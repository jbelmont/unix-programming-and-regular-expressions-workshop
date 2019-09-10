#! /bin/bash

COUNT=1

printf "Printing Numbers: "
while [[ $COUNT -lt 11 ]] ; do #loop gets terminated if COUNT exceeds 10
  printf "%i " "$((COUNT++))"  #printing 1-10 numbers with COUNT incremented
done
printf "\n"