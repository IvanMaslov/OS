#!/bin/bash

help_message="Select action:
	list			= list of process in format \"PID : COMMAND\"
	info <PID>		= information of process
	find <QUERY>		= PID_list which started with <QUERY> command
	send <SIGNAL> <PID> 	= send to process <PID> signal <SIGNAL>
	stream			= start STREAM mode. to cancel it use Ctrl+C
	help 			= help
	exit	 		= exit";

function _help {
	echo "$help_message";
}

function _start_line {
	echo "$(head -c50 /proc/$1/cmdline)"
}

function _list {
	for i in $(ls /proc | grep '^[0-9]*$' | sort -n)
       	do
		echo "PID = $i : CMDLINE = $(_start_line $i)"
	done
}

function _info {
	pid=$1
	echo "PID: $pid"
	ppid=$(cat /proc/$pid/status | grep "PPid" | tr -s "\t" | awk '{print $2}')
	echo "PPID: $ppid"
	echo "PPID_CMDLINE : $(_start_line $ppid)"
	echo "PATH_TO_EXE : $(readlink /proc/$pid/exe)"
	echo "PATH_TO_CWD : $(readlink /proc/$pid/cwd)"
	echo "USED_MEMORY : $(grep -o '[0-9]\+' /proc/$pid/statm | head -n1)"
}

function _find {
	query=$1
	echo "$(grep "$query" <<< "$(_list)" | cut -d: -f1)"
}

function _manage {
	_help
	while true; do
		read in_str
	        a_case=$(cut -d" " -f1 <<< $in_str)	
		arg1=$(cut -d" " -f2 <<< $in_str)
		arg2=$(cut -d" " -f3 <<< $in_str)
		# echo "$a_case : $arg1 : $arg2;"
		case $a_case in
			'd' ) _develop ;;
			'list' ) _list ;;
			'info' ) _info $arg1;;
			'find' ) _find $arg1;;
			'send' ) _send $arg1 $arg2;;
			'stream' ) _stream ;;
			'help' ) _help ;;
			'exit' ) exit ;;
		esac
	done
}

_manage
