#! /bin/bash

NAMES=(John Kate Ashish Lee Tom Omar)

echo "Names: "
for NAME in "${NAMES[@]}"
do
  printf "\t%s\n" "$NAME"
done