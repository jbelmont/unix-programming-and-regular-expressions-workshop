#! /bin/bash

NAMES=(John Kate Ashish Lee Tom Omar)

echo "Names: "
for NAME in "${NAMES[@]}"
do
  if [[ $NAME == "John" ]] ; then
    continue
  fi
  printf "\t%s\n" "$NAME"
done