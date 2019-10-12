#!/bin/bash

echo "Select action:
	v - starts vim
	n - starts nano
	l - starts links
	q - exit"
read a_case
read -p "Do you want execute action $a_case [y/n]: ?" yn
case $yn in
	[Yy]* ) case $a_case in
		'v' ) vi ;;
		'n' ) nano ;;
		'l' ) links ;;
		'q' ) exit ;;
	esac
esac
