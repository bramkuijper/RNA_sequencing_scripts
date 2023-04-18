# page 18, Phred Score translation howto
```sed -e '4~4y/@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghi/!"#$%&'\''()*+,-.\/0123456789:;<=>?@ABCDEFGHIJ/' originalFile.fastq```


Here
`4~4y` would select every 4th line starting from line 4 (the line containing the Phred scores), with the
`y` modifier meaning we are going to use this result to do some replacing

Next, the regex is given by `/match/replace/`, where *match* are, in this case, all the ascii 
characters starting from `@` to `i`. There is no need to include `j` up to `~` 
in the regex as the ascii code of `j` is 106, minus the offset of 64 
(ee table 3 on p19)) 
would result in a Phred score of 42 whereas the max Phred score that is used is 41 (hopefully!)
the replace part is then the correct sequence starting with `!` up to `J` matching Illumina 1.8+




