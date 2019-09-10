#! /bin/bash

ARGS="$@"

help () {
  printf "Usage:\n\tProvide an argument\n"
}

if [[ $# -lt 1 ]] ; then
  help
  exit 1
fi

printArgs () {
  for arg in "$ARGS"
  do
    echo $arg
  done
}

printArgs
