#! /bin/bash

# Run trap for cleanup no matter what
trap 'rm -f $tmpfile' EXIT

tmpfile=$(mktemp -p /tmp someprogram.XXXXXXXXXXX) || exit 1

echo Here is some data again > $tmpfile

ls -l $tmpfile

echo

cat $tmpfile
