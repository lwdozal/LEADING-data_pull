#############################
#' Created on Sat Aug 19 11:11:29 2023
#' 
#' @author: Laura
#' 
#' For pulling Harvard Dataverse data
#' 1. use api to get ids with the Rochester keyword
#' 2. for each id, get the metadata
#' 3. save the metadata to a csv
##############################


# install.packages("dataverse")
# install.packages("janitor")

library(janitor)
library(dplyr)
library(dataverse)
Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")

# help(dataverse_search)
#use api to pull university of rochester datasets
search1 <- dataverse_search("Rochester", type = "dataset", per_page = 1000)
search2 <- dataverse_search("\"Laboratory for Laser Energetics\"", type = "dataset", per_page = 1000)
search3 <- dataverse_search("\"University of Rochester\"", type = "dataset", per_page = 1000)


### set up to combine all dataframes
#compare dataframes
janitor::compare_df_cols(search1, search3, search2)
# remove columns that don't match all three
search1 <- select(search1, -c("dataSources", "geographicCoverage", "producers", "publications", "relatedMaterial"))
search3 <- select(search3, -c("dataSources", "geographicCoverage", "producers", "publications", "relatedMaterial"))

#check all dataframes have the same columns again
janitor::compare_df_cols(search1, search3, search2)

# sort columns and set up for merge
search1 <- search1[, order(names(search1))]
search2 <- search2[, order(names(search2))]
search3 <- search3[, order(names(search3))]

# help("bind_rows")
hdataverse <- bind_rows(search1, search2) %>% bind_rows(search3)

# because some of our variables are lists, we need to convert everything to characters
# is now a character matrix
hdataverse <- apply(hdataverse, 2, as.character)

#now we can write the .csv file
write.csv(hdataverse, "hdataverse.csv", row.names = TRUE)

