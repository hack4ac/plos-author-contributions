require "nokogiri"
require "sinatra"
require "net/http"
require "csv"

API_KEY = ENV.fetch("PLOS_API_KEY")
ROLES = [
  "Conceived and designed the experiments",
  "Performed the experiments",
  "Analyzed the data",
  "Contributed reagents/materials/analysis tools",
  "Wrote the paper"
]

def initials_for(name)
  name.scan(/[A-Z-]/).join
end

def contribution_map(author_notes)
  map = {}
  author_notes.split(/\.\s*/).map { |c| c.split(/:\s*/) }.each do |(role, initials)|
    if role
      role.squeeze!(" ")
      role.strip!

      if ROLES.include?(role) && initials
        initials.split.each do |initial|
          map[initial] ||= []
          map[initial] << role
        end
      end
    end
  end

  map
end

def find_author(initials, doc)
  authors = doc.at("arr[@name='author']").xpath("str").map { |e| e.text }
  name = authors.find { |author| initials == initials_for(author) }

  [name, authors.index(name).succ] if name
end

get "/" do
  content_type "text/csv"

  page_size = 100
  limit = params.fetch("limit", page_size).to_i

  stream do |out|
    out << CSV.generate do |csv|
      csv << ["DOI", "Author Position", "Author Name", "Initials"] + ROLES
    end

    (limit / page_size.to_f).ceil.times do |page|
      out << Thread.new do
        start = page * page_size

        CSV.generate do |csv|
          tries = 3
          begin
            response = Net::HTTP.get(URI("http://api.plos.org/search?api_key=#{API_KEY}&fl=id,author_notes,author,publication_date&q=*:*&start=#{start}&rows=#{page_size}&fq=article_type:%22research%20article%22%20AND%20doc_type:full"))
          rescue
            tries -= 1
            retry unless tries.zero?
          end

          document = Nokogiri::XML(response)

          document.xpath("//doc[str/@name='author_notes'][str/@name='author_notes'][date]").each do |doc|
            doi = doc.at("str[@name='id']").text
            author_notes = doc.at("str[@name='author_notes']").text.strip
            publication_date = doc.at("date").text

            contribution_map(author_notes).each do |initials, roles|
              author_name, position = find_author(initials, doc)
              role_bitmap = ROLES.map { |r| roles.include?(r) ? 1 : 0 }

              csv << [doi, publication_date, position, author_name, initials] + role_bitmap
            end
          end
        end
      end.value
    end
  end
end
