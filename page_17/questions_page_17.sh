#!/usr/bin/env bash

# How to count the number of reads in a file
fast_q_file="../page_16/SNF2_rep1/ERR458500.fastq.gz"

if [[ ! -e "$fast_q_file" ]]
then
    echo "Nope, nopety, no, cannot find the fastq file "$fast_q_file". Cowardly exiting."
    exit
fi

# 1. count the number of reads stored in a FASTQ file
# hence, we need to find the @accession_number.READ_NUMBER at the start of each read and then the last thereof

# to this end, we need to find the last read, 
# so we first use tail n4 then head n1 to get the 4th line (and only the 4th
# from the end);
# we then use the awk function gensub() which substitutes matches of regular expressions
# with something (most likely nothing so that only the number READ_NUMBER will be left)
# then some complicated regex wizardry where we use ([0-9]+) to match a group of digits
# that is the read number
# and then we recall that group within gensub()'s second argument (replacement) using \\1. 
printf "QUESTION 1:\n"
zcat $fast_q_file | tail -n4 | head -n1 |  awk '{ r = gensub(/@[^.]*\.([0-9]+).*/,"\\1","G"); print r; }'

printf "\n\nQUESTION 2:\n"

# 2. extract quality scores from the first 10 lines. This is actually a real pain using grep, because grep can be made to match multiple lines (by changing line endings to null), but then it will be really difficult to match a given number of lines. Argh. so let's make a small python script which I call here
python3 quality_scores_n_lines.py $fast_q_file 10


printf "\n\nQUESTION 2 alternative:\n"
#2. awh... got it, with sed's line skipping you could easily achieve this
zcat $fast_q_file | head -n40 | sed -n '4~4p'

# 3. concatenate the two fastq files of a PE (paired-end) run
# to see how this works might be good to download an example paired end run
# let's use accession number SRX4669750 which I found by typing the keyword 'blood' in
# on ebi.ac.uk/ena and it turned out to be a paired end read.
if [[ ! -e SRR453566_1.fastq.gz ]]
then 
    wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR453/SRR453566/SRR453566_{1,2}.fastq.gz
fi

# and then it is as simple as 
if [[ ! -e SRR453566_combined.fastq.gz ]]
then
    zcat SRR453566_{1,2}.fastq.gz | gzip > SRR453566_combined.fastq.gz
fi

