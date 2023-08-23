#################################
# Attempts to pull many types of data


# potentially contact: https://www.icpsr.umich.edu/web/membership/administration/institutions/20
# https://github.com/fsolt/icpsrdata
# install.packages("icpsrdata")
# install.packages("tidyverse")
# https://docs.ropensci.org/rdatacite/
# install.packages("rdatacite")
install.packages("pak")
pak::pkg_install("ropensci/rdatacite")

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


#845 resutls an attempt to get all of them
# continue by looking in the help(rdatacite) support

# try = dc_dois(query = "University of Rochester", page = 1)
# for (i in 2:34){
#   try1 <- dc_dois(query = "University of Rochester", page = i)
#   # The data downloaded comes in a dc class
#   try1 <- unclass(try1)
#   try[[length(try)+1]] = try1
# }
# The data downloaded comes in a dc class
try <- unclass(try)

# try1 <- dc_dois(query = "Rochester", page = i)
# The data downloaded comes in a dc class
# try1 <- unclass(try1)

# Essentially it's a bunch of nested lists and datasets that needs to be cleaned up
try_meta <- try$meta
try_providers <- try_meta$providers

df_try <- try1$data
df_attributes <- df_try$attributes
#remove null columns and dataframes that were uneccesary
df_attributes <- select(df_attributes, -c("identifiers", "container", "types", "relatedItems", "formats"))
glimpse(df_attributes)


# multiple nested datasests but helpful to find the repository it's stored in
glimpse(df_try)
df_client <- df_try$relationships
glimpse(df_client)
df_client <- df_client$client
df_client <- df_client$data

df <- cbind(df_attributes, df_client$id)

# because some of our variables are lists, we need to convert everything to characters
# is now a character matrix
df <- apply(df, 2, as.character)

#now we can write the .csv file
# write.csv(df, "datacite.csv", row.names = TRUE)
