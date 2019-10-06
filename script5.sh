#!/bin/bash
cat /etc/passwd | awk -F ":" ' {print $3"\t"$1} ' | sort -n
