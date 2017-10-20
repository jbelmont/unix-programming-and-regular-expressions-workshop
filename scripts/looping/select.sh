#! /bin/bash

PS3="selection: "

FRUITS=(Apple Oranges Pineapple Strawberry Nectarine)
select fruit in "${FRUITS[@]}"
do
  echo $fruit
  case "$fruit" in
    Apple)
      echo The fruit is $fruit
      ;;
    Oranges)
      echo yummy fruit is $fruit
      ;;
    Pineapple)
      echo Who is not a fan of $fruit?
      ;;
    Strawberry)
      echo Eat some yummy $fruit sundaes
      ;;
    Nectarine)
      echo Well $fruit is not too bad
      ;;
    End) 
      echo Going to exit here
      break
      ;;
    *)
      echo What fruit is this?
      ;;
  esac
done