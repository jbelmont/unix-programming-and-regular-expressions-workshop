#! /usr/bin/awk -f

# ID,Date,Description,Amount

## A good thing to do is to describe fields in a data file for awk script

BEGIN { FS = "," } #making input field seperator as ","(comma)

/^#/ { next } ## skips the line that begin with # i.e., comment lines will be ignored

# It is necessary here to put variable in { } to do an action in awk
#Here , content between {} is called action and before {} is called pattern
#action gets executed only if pattern is evaluated to true
#if no action is specified, it takes default as true and that action will get executed!

{ total += $4 } #adding 4th field to total variable

# Here we use the special printf command to do some special formatting that print can't really do
END {
  printf("Bank Statement Total:\t%g\n", total)
}