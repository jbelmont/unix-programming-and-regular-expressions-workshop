#! /bin/bash

FILE=$1

if [ -L "$FILE" ]
then
	echo $FILE is a symbolic link
elif [ -f "$FILE" ]; then
	if [ -r "$FILE" ]; then
		echo $FILE is readable
	fi

	if [ -w "$FILE" ]; then
		echo $FILE is writable
	fi

	if [ -x "$FILE" ]; then
		echo $FILE is executable
	fi
elif [ -d "$FILE" ]; then
	echo $FILE is a directory
else 
	echo $FILE is neither a file, directory or a symbolic link
fi
