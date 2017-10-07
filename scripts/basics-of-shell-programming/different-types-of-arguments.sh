#! /bin/bash -

printf "The number of arguments passed is $#\n"

printf "The first argument passed in $1\n"

printf "The second argument passed in %s\n" "$2"

echo '$* shows all the arguments: ' "$*"

echo '$@ shows all the arguments as well: ' "$@"

echo '$* but the difference between them can be shown as ' "$*"
./scripts/basics-of-shell-programming/count-arguments.sh "$*"

echo '$@ shows all the arguments as well: ' "$@"
./scripts/basics-of-shell-programming/count-arguments.sh $@

echo '$* but the difference between them can be shown as ' "$*"
./scripts/basics-of-shell-programming/count-arguments.sh $*

echo '$? prints the exit status' "$?"
