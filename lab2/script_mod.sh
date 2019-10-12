#!/bin/bash

file=$1

tail $file -n1

tac $file | head -n1

export STR="trtr"

cat $file | while read oneline
do
	export STR=$oneline	
done;

echo "$STR"

grep "
" $file | sed '$!d'

awk 'END {print}' $file

