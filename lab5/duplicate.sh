#!/bin/bash

direct=$([ -n "$1" ] && echo "$1" || echo "$PWD");
rm /tmp/dupl
for i in $(tree -fi $direct | head -n-2); do
	if [ -d $i ];
	then
		echo -e "DIRECTORY:\e[33m$i\e[0m";
	else
		[ ! -L $i ] && [ ! -f $i ] && continue;
		echo -e "FILE:\e[36m$i\e[0m";
		if [ -L $i ]; then
			echo -e "\e[35mLINK: $i\e[0m"
			continue
		fi;
		sha=$(sha256sum $i)
		shaOnly=$(cut -d" " -f1 <<< "$sha")
		file=$(cut -d" " -f3 <<< "$(grep $shaOnly /tmp/dupl)")
		[ "$file" == "$i" ] && continue;
		[ -z "$file" ] && echo -e "\e[32mNEW: $i\e[0m" || echo -e "\e[34mCOPY: $file\e[0m"
		if [ -n "$file" ]; then
			rm $i
			ln -s $file $i
		fi;
		echo "$sha" >> /tmp/dupl
	fi;
done

