#!/bin/bash
port=24344
# nc localhost $port <<< "$file"
while true;
do
	nc -l -p $port -e /home/maslov/labOS/lab5/tmp_file_cat.sh;
done
