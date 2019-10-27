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
	echo -e "\e[31m$help_message\e[0m";
}

function _start_line {
	echo "$(cat /proc/$1/cmdline)"
}

function _short_start_line {
	echo "$(head -c50 <<< "$(_start_line $1)")"
}

function _list {
	for i in $(ls /proc | grep '^[0-9]*$' | sort -n)
       	do
		echo -e "\e[32mPID = $i : CMDLINE = $(_short_start_line $i)\e[0m"
	done
}

function _info {
	pid=$1
	echo -e "\e[34mPID: $pid"
	ppid=$(cat /proc/$pid/status | grep "PPid" | tr -s "\t" | awk '{print $2}')
	echo -e "PPID: $ppid"
	echo -e "PPID_CMDLINE : $(_short_start_line $ppid)"
	echo -e "PATH_TO_EXE : $(readlink /proc/$pid/exe)"
	echo -e "PATH_TO_CWD : $(readlink /proc/$pid/cwd)"
	echo -e "USED_MEMORY : $(grep -o '[0-9]\+' /proc/$pid/statm | head -n1)\e[0m"
}

function _find {
	query=$1
	for i in $(ls /proc | grep '^[0-9]*$' | sort -n)
	do
		if [[ "$(_start_line $i)" =~ "$query" ]]
		then
			echo -e "\e[36mPID : $i\e[0m"
		fi;
	done
}

function _send {
	kill $1 $2
}

function _stream {
	trap 'return' SIGINT;
	pid_list="$(ls /proc | grep '^[0-9]*$' | sort -n | cat)"
	while true; do
		new_pid_list="$(ls /proc | grep '^[0-9]*$' | sort -n | cat)"
		for i in $new_pid_list
		do
			if [[ $pid_list != *"$i"* ]]
			then
				echo -e "\e[32mprocess $i ($(_short_start_line $i)) started\e[0m"
			fi;
		done
		for i in $pid_list
		do
			if [[ $new_pid_list != *"$i"* ]]
			then
				echo -e "\e[31mprocess $i finished\e[0m"
			fi;
		done
		pid_list="$new_pid_list"
		sleep 2;
	done
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
