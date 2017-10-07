#!/bin/bash

function args_at {
    printf "%s\n" "$@"
}

function args_star {
    printf "%s\n" "$*"
}

echo 'Args using $@'
args_at "one" "two three" "four"
echo 'Args using $*'
args_star "one" "two three" "four"
