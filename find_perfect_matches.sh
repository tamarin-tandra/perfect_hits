#!/bin/bash

#Input and output file names
query_file="$1"
subject_file="$2"
output_file="$3"

#Perform BLAST search and filter for perfect matches
blastn -query "$query_file" -subject "$subject_file" -perc_identity 100 -ungapped -outfmt "6 sseq" -out "$output_file"

#Print the number of perfect matches to stdout
perfect_match_count=$(wc -l < "$output_file")
echo "Number of perfect matches: $perfect_match_count"
