#!/bin/bash
res=""
n="None"
AVGsum=0
AVGcnt=1
delimetr="
"
fl=$(cat sleepAVG.log | tail -n +5)
while read -r line
do
	ppid=$(awk '{print $5}' <<< $line)
	time=$(awk '{print $8}' <<< $line)
	echo $ppid" "$time
	if [[ $ppid == $n ]];
	then
		AVGsum=$(( $AVGsum+$time ))
		AVGcnt=$(( $AVGcnt+1 ));
	else
		# result="$result $delimetr AVERAGE_SLEEPING_CHILDREN_OF_PARENT_ID=$n IS $(( $AVGsum/$AVGcnt ))"	
		result="$result $delimetr AVERAGE_SLEEPING_CHILDREN_OF_PARENT_ID=$n IS $(bc <<< 'scale=2;'$AVGsum/$AVGcnt )"	
		n=$ppid
		AVGsum=$time
		AVGcnt=1;
	fi;

	result="$result $delimetr $line"	
done <<< $fl

echo "$result"
