#!/bin/bash

result=0

while true;
do
	read number
	if [[ $(( number % 2 )) -eq 0 ]];
	then 
		echo $result
		exit;
	fi;
	result=$(( result + 1 ))
done
