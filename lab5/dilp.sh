#!/bin/bash

direct=$([ -n "$1" ] && echo "$1" || echo "$PWD");

function dfs {
	cur=$1
	echo -e "\e[32m$cur\e[0m"
	if [ -d $cur ] 
	then 
		for i in $(ls $cur); 
		do 
			echo -e "\e[33m$i\e[0m"
			arg="$cur/$i"
			dfs $arg
		done
	else	
		echo $cur
	fi
}

dfs $direct

