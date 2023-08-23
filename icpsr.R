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

try1 <- dc_dois(query = "University of \"Rochester\"")

# The data downloaded comes in a dc class
try1 <- unclass(try1)

# Essentially it's a bunch of nested lists and datasets that needs to be cleaned up
try_meta <- try1$meta
df_try <- try1$data
df_attributes <- df_try$attributes
glimpse(df_attributes)
df_attributes <- select(df_attributes, -c("identifiers", "container", "relatedItems", "formats"))

