#!/usr/bin/env python3

# python script to filter the accession numbers needed to get 
# replicate 1 of SNF2 and WT on page 16 in Dundar et al 2015

# How to run this? First download a file with all the accession numbers
# according to Dundar et al this is available at:
# https://ndownloader.figshare.com/files/2194841 and save it as, say, file_2194841.txt
# then run this file on the command line as
# python3 get_relevant_accessions.py file_2194841.txt

# load libraries
import pandas as pd
import sys, os, os.path 

# get file name from command line arguments
file_name = sys.argv[1]

# read the file into a data.frame
accession_db = pd.read_csv(filepath_or_buffer=file_name
        ,sep="\t")

# now make a selection: we want biol rep 1 of either SNF2 or WT and for each a folder
samples = ["SNF2","WT"]

# we only want the first replicate
biol_rep = 1

# go through the two labels and select samples accordingly
for sample_i in samples:

    # make a sub directory
    dir_name = sample_i + "_rep" + str(biol_rep)

    if not os.path.exists(dir_name):
        os.mkdir(dir_name)

    # get the set of files belong to this sample and biol rep $biol_rep
    subset = accession_db.loc[(accession_db["Sample"] == sample_i) & (accession_db["BiolRep"] == biol_rep)]

    # write the subset to the file in this local dir
    subset.to_csv(path_or_buf=os.path.join(dir_name, "accession_numbers.tsv")
            ,header=False
            ,sep="\t")
