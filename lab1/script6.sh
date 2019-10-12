#!/bin/bash
if [[ "$HOME" == "$PWD" ]];
then
	pwd
	exit 0;
else
	echo "ERROR"
	exit 1;
fi;
