#! /bin/bash

ARGS=$1

FOOD=(bananas pizza bread spaghetti)

help () {
	printf "Usage:\n\tcase_statements takes arguments: print and stop\n"
}

if [[ $# -eq 0 ]] ; then
	help
	exit 1
fi

# while loop will run if the number of arguments is not zero
while :
do
	case "$ARGS" in
		print)
			printf "Some foods: "
			for food in ${FOOD[@]}
			do
				printf "%s " $food
			done
			printf "\n"
			exit 0
			;;
		stop)
			echo "Exiting here"
			exit 0
			;;
		*)
			echo "Something to print"
			exit 0
			;;
	esac
done
