#! /bin/bash

COUNT=10

printf "Printing Numbers: "
until [[ $COUNT -lt 1 ]] #loops until count becomes less than one
do
  printf "%i " "$((COUNT--))" #print 10-1 numbers with COUNT decrementing
done

printf "\n"