#!/usr/bin/env python3

import sys
import gzip
import re

# function to get quality scores from gzipped file
def get_quality_scores(gzip_file_name, n):

    # allocate a vector to store the n quality scores
    quality_scores = []

    # flag to see whether current line is a quality score line
    # see loop below
    quality_score_line = False

    # use gzip capabilities to open the gzip file
    with gzip.open(filename=gzip_file_name) as gzip_f:

        # read in a line from the gzip file
        for line in gzip_f:

            # turns out, for some weird reason gzipped lines
            # are read in as a byte string by python, rather than a real string
            # hence we need to decode. We also use strip() to remove any newline
            # characters or other whitespaces from either end of the line
            line_decoded = line.decode('UTF-8').strip()

            # if this is a quality score line add the line  to the list of 
            # quality scores
            if quality_score_line:
                quality_scores += [ line_decoded ]
                quality_score_line = False

            # check if line contains a +, in which case we set the quality_score_line flag
            # so that the next line will be stored
            if re.match(pattern=r"^\+$",string=line_decoded) is not None:
                # line following the + should be quality score
                # hence set the quality_score_flag to true
                # and continue
                quality_score_line = True

            # if number of quality scores has been reached, stop
            if len(quality_scores) == n:
                break

    print("\n".join(quality_scores))

the_fasta_gzip = sys.argv[1]
n_matches = int(sys.argv[2])

get_quality_scores(gzip_file_name=the_fasta_gzip, n=10)
