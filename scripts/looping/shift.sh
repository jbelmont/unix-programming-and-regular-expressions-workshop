#! /bin/bash

ARGS=$@

echo "The number of arguments is $#"
for arg in "${ARGS}"
do
  echo $arg
  shift
done

echo ""

echo "The number of arguments is now $#"