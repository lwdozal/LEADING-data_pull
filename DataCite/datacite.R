#################################
# Attempts to pull many types of data


# potentially contact: https://www.icpsr.umich.edu/web/membership/administration/institutions/20
# https://github.com/fsolt/icpsrdata
# install.packages("icpsrdata")
# install.packages("tidyverse")
# https://docs.ropensci.org/rdatacite/
# install.packages("rdatacite")
# install.packages("pak")
# pak::pkg_install("ropensci/rdatacite")

## to do, try to install dryad
#dryad https://datadryad.org/api/v2/docs/



library(icpsrdata)
library(tidyverse)
library(rdatacite)

#####
# The data downloaded comes in a dc class
# Essentially it's a bunch of nested lists and datasets that needs to be cleaned up
######

test <- dc_dois(query = "Rochester", page = 1)
test <- unclass(test)



final_df = data.frame() #"Rochester" Search term
final_df_UR <- data.frame() #"University of Rochester" search term

for (i in 1:35) {
  
  try <- dc_dois(query ="University of Rochester", page = i)
  try <- unclass(try)
  # Essentially it's a bunch of nested lists and datasets that needs to be cleaned up
    df_try <- try$data
  df_attributes <- df_try$attributes
  # glimpse(df_attributes)
  #remove null columns and dataframes that were uneccesary
  #make sure this collumn exists
  if (is.list(df_attributes)){
    df_attributes <- select(df_attributes, -c("identifiers", "container", "types", "relatedItems", "formats", "contentUrl", "reason", "published"))
  }
  else{
    break
  }

  # multiple nested datasests but helpful to find the repository it's stored in
  # get the publisher from more nested DFs
  df_client <- df_try$relationships
  df_client <- df_client$client
  df_client <- df_client$data
  # combine metadata
  df <- cbind(df_attributes, df_client$id)
  df <- df %>% select(order(colnames(df)))
  # because some of our variables have lists, we need to convert everything to characters
  # df is now a character matrix
  df <- apply(df, c(1,2), as.character)
  #bind this dataset to the main dataset
  final_df_UR <- final_df_UR %>% rbind(df) 
}

#now we can write the .csv file
#search term - Rochester
write.csv(final_df, "datacite_Rochester.csv", row.names = TRUE)
#search term - University of Rochester
write.csv(final_df_UR, "datacite_UofR.csv", row.names = TRUE)


