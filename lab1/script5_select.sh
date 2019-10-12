#!/bin/bash

echo "Select action:
	v - starts vim
	n - starts nano
	l - starts links
	q - exit"
read a_case
select yn in "Yes" "No"; do
case $yn in
	Yes ) 	case $a_case in
		'v' ) vi ;;
		'n' ) nano ;;
		'l' ) links ;;
		'q' ) exit ;;
		esac;;
	No ) exit;;
esac
done
