PLOS Author Contributions
=========================

All PLOS papers (currently about 80,000) include author contributions in a format similar to this:

    Conceived and designed the experiments: HQ JKC AR NH. 
    Performed the experiments: HQ JKC AR MP. 
    Analyzed the data: HQ JKC AR MP NH. 
    Contributed reagents/materials/analysis tools: CH. 
    Wrote the paper: HQ JKC AR NH.

I want to use the [PLOS Search API](http://api.plos.org/solr/faq/) to do a systematic analysis of these author contributions, e.g. how many times the first author was involved in writing the paper, or how often we have co-authors who appear only in the "contributed reagents/materials/analysis tools" section.

This idea is also an exercise in searching the PLOS CC-BY content for machine-readable information, and in using R for data analysis and visualization. I would be happy to introduce people to R and the [rplos](http://ropensci.github.io/rplos/) package created by rOpenSci that makes working with the PLOS Search API much easier. We will do some nice visualizations with the results, and will write a report in markdown (using the R knitr package) that can be posted to the hack4ac website.

2. [Martin Fenner](https://twitter.com/mfenner), technical lead of the PLOS article-level metrics project
3. Experience in R, Ruby, Javascript, PHP
4. People who can help with asking good questions, data analysis and writing. People with skills in R or interested in learning R, or experience in Solr query syntax a bonus. 

Background
----------

This project is part of the [hack4ac](http://hack4ac.com) event taking place in London July 6, 2013. The goals of the event are twofold:

* Demonstrate the value of the CC-BY licence within academia. We are interested in supporting innovations around and on top of the literature.
* Reach out to academics who are keen to learn or improve their programming skills to better their research. We’re especially interested in academics who have never coded before.

Requirements
------------

* Register for an API key for the PLOS Search API [here](http://api.plos.org/registration/).
* Create a (free) [Github account](https://github.com) in case you haven't done so already.
* Install RStudio, a powerful IDE for R via [this link](http://www.rstudio.com/ide/download/).
* Install a number of required packages via the RStudio interface or the console: `install.packages(c("knitr", "plyr", "rplos"))`
* Import this git repository. Use any git tool or the git support in R. 
* Open the R project file `plos-author-contributions.Rproj` in this repository.
* Open the file `index.Rmd`. This file is where we will do the bulk of our work.

Subprojects
-----------

### Improve documentation of PLOS Search API

The current schema for the PLOS Solr search is [here](schema.xml). Make sure all fields are also documented in the [PLOS Search website](http://api.plos.org/solr/search-fields/). Also compare field list to [PLOS Search web interface](http://www.plosone.org/search/advanced), and add more search examples, including some advanced Solr queries. This can also include a wish list of features you would like to see supported in the PLOS Search API. Write down docuentation in file `documentation.md` in this repo.

### Extract author contributions out of PLOS papers

We will do this using R and the `rplos` package. We use `knitr` to document our code in markdown, and do this in the `index.Rmd` file in this repo. RStudio understands `R Markdown` files: R code embedded into markdown, using the file extension `.Rmd`. 

### Analyze author contributions

Some ideas include the following:

* Add [ScoRo](http://www.essepuntato.it/lode/http://purl.org/spar/scoro) Scholarly Contributions and Roles, e.g. `provides tools, equipment or facilities` or `authorship contribution`.
* Find particular authorship patterns, e.g. number of papers where at least one author only `contributed reagents/materials/analysis tools`.
* Correlate authorship for `performed the experiments` with `analyzed the data`.
* Analyse Flesch readability score of abstracts and correlate with number of people who `wrote the paper` and geolocation.
* Visualize authorship patterns.
* Correlate authorship patterns with subject areas and/or geolocation information.
