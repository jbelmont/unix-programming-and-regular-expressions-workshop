#! /bin/bash

echo "Enter your name: "
read NAME
echo "Your name is $NAME"

echo -n "Enter your name: "
read MISSING_NEWLINE
echo "Now your name is: $MISSING_NEWLINE"

## Using gnu echo command
gecho -e "Enter your name: \c"
read GNU_NAME
echo "Your name is $GNU_NAME and used the gnu echo shell builtin"

gecho -e "Enter your name: \c this are ignored"
read IGNORED_ARGS
echo "Your name is $IGNORED_ARGS and the \\c ignores anything after"

