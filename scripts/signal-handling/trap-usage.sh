#! /bin/bash

trap 'echo Ignoring HUP ...' HUP
trap 'echo Terminating on USR1 ... ; exit 1' USR1

while true
do
  sleep 2
  date > /dev/null
done