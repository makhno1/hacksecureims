#!/bin/bash
i=1
output="output.log"
dir="images"
declare -a list

for f in ${dir}/*.png; do
	parse=$(zbarimg -q $f | grep -e QR | sed -e 's/QR-Code://g')
	list[i]=$(echo ${parse::1}) 
	(( i = i+1 ))
done

pass=$(echo ${list[@]} | tr -d ' ' )
echo $pass

