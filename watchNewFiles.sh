#!/bin/bash


if [ "$1" == "" ]; then
	echo $'Please specify path of dir to watch!\nExit...'
elif [ ! -d "$1" ]; then
	echo $'Directory does not exist!\nExit...'
else	
	if [ -e ./execScriptsPipe ]
	then
		echo "Pipe already exists..."
	else
		mkfifo execScriptsPipe
	fi

	if ! [ -e ./lastwatch ]
	then
		touch ./lastwatch
	fi

	while true
	do
        	sleep 10
        	find $1 -type f -cnewer ./lastwatch > execScriptsPipe;	
		touch  ./lastwatch
	done
fi
