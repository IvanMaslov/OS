#!/bin/bash

# ps aux | awk '{print $11" "$2}' | grep -E "/sbin/"
# ps aux | awk '{if ($11~'/sbin/') print $2}'
# ps aux | awk '{if ("readlink /proc/$11/exe"~'/sbin/') print $2}'
# ps aux | awk '{print $2}' | awk '{if ("readlink /proc/$1/exe"~'/sbin/') print $1}'
for i in /proc/*/exe;
do
	path=$(readlink $i);
	if [[ $path =~ "/sbin/"  ]];
	then
		echo $(cut -d/ -f3 <<< $i);
	fi;
done
