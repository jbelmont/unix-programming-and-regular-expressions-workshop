#! /bin/bash

COUNT=1

printf "Printing Numbers: "
while [[ $COUNT -lt 11 ]] ; do
  printf "%i " "$((COUNT++))"
done
printf "\n"