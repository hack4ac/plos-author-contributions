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
    role.squeeze!(" ")
    role.strip!

    if ROLES.include?(role) && initials
      initials.split.each do |initial|
        map[initial] ||= []
        map[initial] << role
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

  start = params.fetch("start", 0)
  limit = params.fetch("limit", 100)

  response = Net::HTTP.get(URI("http://api.plos.org/search?api_key=#{API_KEY}&fl=id,author_notes,author,author_affiliate&q=*:*&start=#{start}&rows=#{limit}&fq=article_type:%22research%20article%22%20AND%20doc_type:full"))

  document = Nokogiri::XML(response)

  CSV.generate do |csv|
    csv << ["DOI", "Author Position", "Author Name", "Initials"] + ROLES

    document.xpath("//doc").each do |doc|
      doi = doc.at("str[@name='id']").text
      author_notes = doc.at("str[@name='author_notes']").text.strip
      affiliations = doc.at("arr[@name='author_affiliate']").xpath("str").map { |a| a.text }

      contribution_map(author_notes).each do |initials, roles|
        author_name, position = find_author(initials, doc)
        role_bitmap = ROLES.map { |r| roles.include?(r) ? 1 : 0 }
        csv << [doi, position, author_name, initials] + role_bitmap
      end
    end
  end
end
