#!/bin/bash

file="pdf"
end=5000

for ((i=5000; i>=0; i--)); do
	echo $i
	pdfdetach $file$i.pdf -saveall
done

for i in $(seq 1 $end); do
	rm $file$i.pdf
done
