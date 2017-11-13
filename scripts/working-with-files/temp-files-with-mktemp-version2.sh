#! /bin/bash

trap 'rm -f $tmpfile' EXIT

tmpfile=$(mktemp -p /dev anotherprogram.XXXX) || exit 1

echo Some data here for a file > $tmpfile

ls -l $tmpfile

echo 

cat $tmpfile
