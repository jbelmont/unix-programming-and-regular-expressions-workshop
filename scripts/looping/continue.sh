#! /bin/bash

NAMES=(John Kate Ashish Lee Tom Omar) #array NAMES

echo "Names: "
for NAME in "${NAMES[@]}" #here for loop iterates over NAME array until it's end
do
  if [[ $NAME == "John" ]] ; then
    continue
  fi
  printf "\t%s\n" "$NAME"
done