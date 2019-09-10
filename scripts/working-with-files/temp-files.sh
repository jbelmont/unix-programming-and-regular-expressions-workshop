#! /bin/sh

trap 'rm -f $tmpfile $tmpfile2' EXIT

tmpfile=${TMPDIR:-/tmp}/someprogram.$$

echo Here is a simple line > $tmpfile

ls -l $tmpfile
echo
cat $tmpfile

echo

umask 077
tmpfile2=${TMPDIR:-/tmp}/someprogram.$$.2

echo Another line to write here > $tmpfile2

ls -l $tmpfile2

echo 

cat $tmpfile2
