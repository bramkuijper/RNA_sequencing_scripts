# page 18, Phred Score translation howto
```sed -e '4~4y/@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghi/!"#$%&'\''()*+,-.\/0123456789:;<=>?@ABCDEFGHIJ/' originalFile.fastq```
Here
`4~4y` would select every 4th line starting from line 4 (the line containing the Phred scores), with the
`y` command meaning we are going to use this result to do some replacing

Next, the regex is given by /match/replace/, where match is all the ascii 
characters starting from @ to i. There is no need to include j up to ~ 
in the regex as ascii code of j is 106, minus 64 
(here 64 is offset see table 3 on p19)) 
results in a Phred score of 42 whereas max Phred score is 41 (hopefully!)
the replace part is then the correct sequence starting with ! up to J.




