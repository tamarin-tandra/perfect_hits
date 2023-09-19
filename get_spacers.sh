#!/bin/bash

query=$1
subject=$2
outfile=$3

blast_out=$(mktemp)
bed_file=$(mktemp)

blastn -query $1 \
    -subject $2 \
    -outfmt '6 std qlen' \
    -task blastn-short \
    | awk '$3==100 && $4==$13' \
    | cut -f2,9,10 > $blast_out
paste \
<(cut -f1 $blast_out | head -n -1) \
<(cut -f3 $blast_out | head -n -1) \
<(cut -f2 $blast_out | tail -n +2 \
    | awk '{print $1 -1}') \
> $bed_file

seqtk subseq $subject $bed_file > $outfile

rm $blast_out
rm $bed_file