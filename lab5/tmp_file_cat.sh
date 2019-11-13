#!/bin/bash
read -r file
echo  "$(readlink -m "/tmp/files/$file")"  
if [[ "$(readlink -m "/tmp/files/$file")" == "/tmp/files/"* ]]; 
then	
	cat "/tmp/files/$file"
fi;
