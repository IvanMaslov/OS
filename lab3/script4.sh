#!/bin/bash

#top -n1 | tail -n +8 | awk '{print $1" "$2" "$3" "$4" "$5" "$6" "$7}'
#top -bcn1 | tail -n +8 | tr -s " " "," | awk -F "," '{print $2" "($6-$7)}' | sort -k2nr
top -bcn1 | tail -n +8 | awk '{print $1":"($6-$7)}' | sort -sk2nr -t:
