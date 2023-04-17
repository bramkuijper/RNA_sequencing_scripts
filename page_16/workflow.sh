#!/usr/bin/env bash

# workflow file that accompanies 


file_accessions=2194841.txt
file_extended_accessions=samples_at_ENA.txt
accessions_per_dir=accession_numbers.tsv

# first get accession numbers and split them in dirs
./get_relevant_accessions.py $file_accessions

# the directories for each accession
dirs=("SNF2_rep1" "WT_rep1")

# store the current directory
olddir=`pwd`

# go through each of the subdirs and download the accessions
for dir_i in ${dirs[@]}; do

    # if dir does not exist make it
    if [[ ! -d $dir_i ]] 
    then
        mkdir $dir_i
    fi

    # go to subdir to download the files within that subdir
    cd $dir_i;

    # get the column with the accession numbers as a space separated list
    accession_numbers=`cut -f2 $accessions_per_dir`

#    echo "$accession_numbers"

    # now search for those accession numbers in the big file and get corresponding list of fastq files
    list_downloads=`echo "$accession_numbers" | grep -f - "$olddir/$file_extended_accessions"`

    echo `echo "$list_downloads" | cut -f7 | xargs printf -- 'ftp://%s ' | xargs wget`

    cd $olddir;
done


