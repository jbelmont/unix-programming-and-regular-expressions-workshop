#! /bin/bash

IFS=$'\n'
BRACKET_LIST=$(pbpaste | awk 'BEGIN { FS="[][]" } { print $2 }')

for br in $BRACKET_LIST
do
    printf "#### %s\n\nContent\n\n" $br 
done
