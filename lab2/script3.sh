#!/bin/bash
mail="[a-zA-Z0-9\-\_\.]+@[a-z]+\.[a-z]+" 
echo $(grep -aEohrs $mail /etc | sort | uniq -u) | sed -E "s/ /,  /g" > emails.lst
