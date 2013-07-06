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

* Install RStudio, a powerful IDE for R via [this link](http://www.rstudio.com/ide/download/).
* Install a number of required packages via the RStudio interface or the console 

```R
install.packages(c("knitr", "plyr", "rplos"))
```

Subprojects
-----------

### Improve documentation of PLOS Search API

The current schema for the PLOS Solr search is [here](schema.xml). Make sure all fields are also documented in the [PLOS Search website](http://api.plos.org/solr/search-fields/). Also compare field list to [PLOS Search web interface](http://www.plosone.org/search/advanced), and add more search examples, including some advanced Solr queries.
