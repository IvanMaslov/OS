#!/bin/bash

#ps axo pid | awk '{print "/proc/"$1"/status"}'
result=""
for i in $(ps axo pid | tail -n +2); 
do 
	curr="PID= "$i
	curr=$curr" : PPID= "$(cat /proc/$i/status 2>/dev/null  | grep "PPid" | cut -f2)
	curr=$curr" : SleepAVG="$(cat /proc/$i/sched 2>/dev/null | grep "se.avg.runnable_load_avg" | cut -d ":" -f2)
	curr=$(tr -s " " <<< $curr)
	curr=$(tr -s "\t" <<< $curr)
	result+=$curr"
"
	#echo $curr;	
done

sort -k5n <<< $result > sleepAVG.log
