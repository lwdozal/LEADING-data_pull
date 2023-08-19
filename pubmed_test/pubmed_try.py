# -*- coding: utf-8 -*-
"""
Created on Tue Aug 15 19:53:23 2023

@author: Laura D
"""

from Bio import Entrez
import json
import pandas as pd
import csv
import itertools


def search(query, database):
    Entrez.email = 'lwerthmann@arizona.edu'
    handle = Entrez.esearch(db =  database,
                            sort = 'relevance',
                            retmode = 'xml',
                            term = query
                            )
    results = Entrez.read(handle)
    return results

def fetch_details(id_list, database):
    ids = ','.join(id_list)
    Entrez.email = 'lwerthmann@arizona.edu'
    handle = Entrez.efetch(db = database,
                           retmode ='xml',
                           id = ids)
    results = Entrez.read(handle)
    return results

def summary(id_list, database):
    ids = ','.join(id_list)
    Entrez.email = 'lwerthmann@arizona.edu'
    handle = Entrez.esummary(db = database,
                            retmode ='xml',
                            id = ids)
    results = Entrez.read(handle)
    return results    

def main():
    # query = "Dataset AND \"University of Rochester\"" 
    
    databases = ['pubmed', 'protein', 'nuccore', 'nucleotide', 'nucgss',
                  'nucest', 'gene', 'nlmcatalog', 'pmc'] 
    for i in databases:
        print(i)
        results = search("University of Rochester" + 'AND' + "dataset", i)
        # print("results", results)
        id_list = results['IdList']
        chunck_size = 10000
        
        sums = []
        
        for chunk_1 in range(0, len(id_list), chunck_size):
            chunk = id_list[chunk_1:chunk_1 + chunck_size]
            summaries = summary(chunk, i)
            # print("chunk", chunk)
            # print("SUMMARY", type(summaries))
            sums.append(summaries)
            
            papers = fetch_details(chunk, i)
            # print(dict(itertools.islice(papers.items(),1)))
            # sums.append(papers)
            
            print("papers", type(papers))
            if isinstance(papers, dict):
            # if type(papers) is dict: 
                # keys = papers.keys()
                # print(keys)
                with open(f'pubmed_test_{i}.csv', 'w', encoding="utf-8", newline='') as output_file:
                    writer = csv.writer(output_file)
                    for key, value in papers.items():
                        writer.writerows([key, value])

                output_file.close()
                
            elif isinstance(papers, list): # == "Papers <class 'Bio.Entrez.Parser.ListElement'>":
            # elif type(papers) is list: # == "Papers <class 'Bio.Entrez.Parser.ListElement'>":
                pps = pd.DataFrame(papers)
                with open(f'pubmed_test_{i}.csv', 'w', encoding="utf-8", newline='') as output_file:
                    pps.to_csv(output_file)
                output_file.close()

            else:
                # pps = pd.DataFrame(papers)
                with open(f'pubmed_test_{i}.csv', 'w', encoding="utf-8", newline='') as output_file:
                    papers.to_csv(output_file)
                output_file.close()

    
if __name__ == '__main__':
     main()
     
     
     
        # print("SUMMARY", sums)
        # while True:
            # if papers == True:
            # keys = papers[0].keys()
            # with open('pubmed_test_' + i +'.csv', 'w', newline='') as output_file:
            #     dict_writer = csv.DictWriter(output_file, keys)
            #     dict_writer.writeheader()
            #     dict_writer.writerows(papers)   
    
    
    
    
    
    ##########################################
    # sums_df = pd.DataFrame(sums)
    # sums_df.to_csv('pubmed_test.csv')
    
    # papers_df = pd.DataFrame(papers)
    # papers_df.to_csv('pubmed_test.csv')
        
        
        # print_file = open('pubmed_test.csv', 'w')
        # writer = csv.DictWriter(print_file, fieldnames= ['Caption', 'Gi', 'Length', 
        #                                                  'Status', 'CreateDate', 'Extra', 
        #                                                  'Comment', 'Id', 'UpdateDate', 
        #                                                  'TaxId', 'Flags', 'Title', 'Item', 
        #                                                  'ReplacedBy', 'AccessionVersion'])

        # writer.writeheader()
        # writer.writerow(pd.DataFrame(summaries))
        # print_file.close()
        
                
        
        # with open('pubmed_test.csv', 'w') as csvfile:
        #     for key in papers:
        #         writer = csv.DictWriter(csvfile, fieldnames= key)
        #         writer.writeheader()
        #         writer.writerows(papers)
            
        # papers_df = pd.DataFrame(papers)
        # print("papers_df", papers_df)
        # papers_df.to_csv("pubmed_test.csv")

            # for i, paper in enumerate(papers['PubmedArticle']):
                # papers_df.to_csv("pubmed_test.csv")
        # except:
            # pass
            
            
            
    # for i, paper in enumerate(papers['Dataset']):
    #      print("{}) {}".format(i+1, paper['MedlineCitation']['Article']['ArticleTitle']))
        
