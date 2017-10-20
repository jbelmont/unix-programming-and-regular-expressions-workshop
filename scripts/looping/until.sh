#! /bin/bash

COUNT=10

printf "Printing Numbers: "
until [[ $COUNT -lt 1 ]]
do
  printf "%i " "$((COUNT--))"
done

printf "\n"