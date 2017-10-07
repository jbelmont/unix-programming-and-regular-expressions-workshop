#! /bin/bash -

type echo
echo "defining echo command"

function echo () {
  command echo "$@"
  printf "Printing some commands here\n"
}

type echo

echo "one two three"
