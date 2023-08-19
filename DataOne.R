# https://cran.r-project.org/web/packages/dataone/vignettes/v03-searching-dataone.html

# install.packages("dataone")
library(dataone)
library(tidyverse)


cn <- CNode("PROD")

# id = doi
# size = dataset size
# date uploaded
# datasource
# abstract
# title

# example:
# queryParamList <- list(q="id:doi*", rows="5", fq="abstract:carbon", fl="id,title,dateUploaded,abstract,
# datasource,size, contactOrganization,contactOrganizationText, relatedOrganizations,
# rightsHolder,sourceText, author, identifier, source, toipc, keywords, keywordsText, funding,authoritativeMN,
# attributeUnit, attributeLabel, attributeName")


#available metadata
# getQueryEngineDescription(cn, "solr")

queryParamList <- list(q="rochester", fl="id,title,dateUploaded, abstract, identifier,
datasource,size, contactOrganization, relatedOrganizations, rightsHolder,sourceText, author, source, 
                       toipc, keywords, keywordsText, funding,authoritativeMN")



result <- query(cn, solrQuery=queryParamList, as="data.frame", parse = FALSE)
result[,'contactOrganization']
head(result)

queryParams <- list(q="Rochester", fl="id,title,abstract,contactOrganization") 

r = query(cn, queryParams, as = 'data.frame')
r[,'contactOrganization']

result <- result %>% distinct(title, .keep_all = TRUE)
r <- r %>% distinct(title,  .keep_all = TRUE)


'
datasource              
dataUrl          
dateModified        
datePublished               
dateUploaded
author                
contactOrganization 
contactOrganizationText
funding                
id
identifier          
keywords
pubDate
source                
topic                
attributeUnit, attributeLabel, attributeName
'
