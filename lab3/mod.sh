#!/bin/bash
direct="/home/maslov/labOS/lab3/pid_links"
rm -r $direct
mkdir $direct
for i in $(ps -axo pid | tail -n +2)
do
	echo $i $(readlink /proc/$i/exe) $(readlink /proc/$i/cwd)
	link $(readlink /proc/$i/exe) $direct"/"$i 2>/dev/null;
done
