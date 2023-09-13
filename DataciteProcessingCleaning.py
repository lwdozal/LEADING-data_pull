import pandas as pd
import re

dataciteR = pd.read_csv('data/datacite_Rochester.csv')
# dataciteUofR = pd.read_csv('data/datacite_UofR.csv')
# dataone = pd.read_csv('data/dataone.csv')
# h_dataverse = pd.read_csv('data/hdataverse.csv')
# pubmed = pd.read_csv('data/pubmed.csv')


datacite = dataciteR.copy()


def clean_column(column, to_remove):
    new_col =[]

    for i in column:
        #only get things between double quotatoins
        new_elemt = re.findall('"([^"]*)"', i)
        #create a new list with the clean data
        for rm in to_remove:
            if rm in new_elemt:
                new_elemt.remove(rm)
        #append the cleaned up row
        new_col.append(new_elemt)

    return new_col

## Creators column
creators_col = datacite['creators']
creators_remove = ['Personal', 'Personal, Personal', 'https://orcid.org', 'ORCID', 'Personal']
new_creators_test = clean_column(creators_col, creators_remove)
#replace the old column with the new column
datacite['creators'] = new_creators_test
#check the data is somewhat clean
# [print(i) for i in datacite['creators']]

## Descriptions Column
descrp_col = datacite['descriptions']
descrp_remove = ["{\\', ':[\\', ', \\', ', \\', ', \\', ', \\', ']}"]
new_description = clean_column(descrp_col, descrp_remove)
# #replace the old column with the new column
datacite['descriptions'] = new_description
# #check the data is somewhat clean
# [print(i) for i in datacite['descriptions']]

## Funding References Column
fr_col = datacite['fundingReferences']
fr_remove = ['<empty>', 'False']
new_fr = clean_column(fr_col, fr_remove)
#replace the old column with the new column
datacite['fundingReferences'] = new_fr
#check the data is somewhat clean
# [print(i) for i in new_fr]

## geoLocations Column
gl_col = datacite['geoLocations']
gl_remove = ['<empty>']
new_gl = clean_column(gl_col, gl_remove)
#replace the old column with the new column
datacite['geoLocations'] = new_gl
#check the data is somewhat clean
# [print(i) for i in datacite]

## relatedIdentifiers Column
rIds_col = datacite['relatedIdentifiers']
rIDs_remove = ['IsPartOf', 'Cites', ' ', 'HasVersion', 'Cites', 'IsVersionOf', 'Cites', 'DOI', 'URL']
new_rIDs = clean_column(rIds_col, rIDs_remove)
#replace the old column with the new column
datacite['relatedIdentifiers'] = new_rIDs
#check the data is somewhat clean
# [print(i) for i in new_rIDs]

## rightsList Column
rights_col = datacite['rightsList']
rights_remove = ['IsPartOf', 'Cites', ' ', 'HasVersion', 'Cites', 'IsVersionOf', 'Cites', 'DOI', 'URL']
new_rights = clean_column(rights_col, rights_remove)
#replace the old column with the new column
datacite['rightsList'] = new_rights
#check the data is somewhat clean
# [print(i) for i in new_rights]

## sizes subjects
subjects_col = datacite['subjects']
subjects_remove = []
new_subjects = clean_column(subjects_col, subjects_remove)
#replace the old column with the new column
datacite['subjects'] = new_subjects
#check the data is somewhat clean
# [print(i) for i in new_subjects]

## sizes titles
titles_col = datacite['titles']
titles_remove = []
new_titles = clean_column(titles_col, titles_remove)
#replace the old column with the new column
datacite['titles'] = new_titles
#check the data is somewhat clean
# [print(i) for i in new_titles]

datacite.to_csv("data/datacite_new.csv", index=False)

#created is the date created; string type
#creators is the creators of the data; string type
#dates is a more records of creations and updates listy type (ignore for now)
#df_client$id is the repository; string type
#doi is the doi; string type
#language Column; mix of str/float
#publishers of the data ... repositories; str type
#Date registered; str type
#schemaVersion schema can ignore
#updated date updated; str type
#data url; str type
#version of the data; can ignore
#versionCount can ignore
#versionOfCount can ignore
#viewCount; int type