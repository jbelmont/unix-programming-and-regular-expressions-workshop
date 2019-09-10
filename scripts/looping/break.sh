#! /bin/bash

SUM=0
ANOTHER_SUM=0
YEP_ANOTHER_SUM=0

for (( COUNT=0 ; $COUNT<=10 ; $((COUNT++)) ))
do
  if [[ $COUNT == 5 ]] ; then
    break
  fi
  ((SUM+=COUNT))
  ANOTHER_SUM=`expr $COUNT + $ANOTHER_SUM`
  YEP_ANOTHER_SUM=$(( $COUNT + $YEP_ANOTHER_SUM ))
done

echo ""
echo "The Sum of the numbers 1 ... 10 is ${SUM}"
echo "Another Sum of the numbers 1 ... 10 is ${ANOTHER_SUM}"
printf "Yep another sum of the numbers 1 ... 10 is %s\n" "${YEP_ANOTHER_SUM}"