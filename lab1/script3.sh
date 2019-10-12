#!/bin/bash

result=""
curr=""
while true;
do 
	read curr;
	if [[ "$curr" = "q" ]];
	then 
		echo $result
		exit;
	else
		result=$result$curr;
	fi;
done
