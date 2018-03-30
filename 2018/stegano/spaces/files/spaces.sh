#!/bin/bash

INPUT="file.txt"
OUTPUT="counter"
PLAINTEXT="plaintext"

sed 's/[a]//g' "$INPUT" | awk '{ print length }' > "$OUTPUT"

while read line
do
    ascii=$(printf \\$(printf "%o" $line))
    echo -n ${ascii}
done < "$OUTPUT" > "$PLAINTEXT"
