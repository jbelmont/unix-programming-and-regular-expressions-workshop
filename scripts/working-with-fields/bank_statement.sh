#! /usr/bin/awk -f

# ID,Date,Description,Amount

## A good thing to do is to describe fields in a data file for awk script

BEGIN { FS = "," }

/^#/ { next } ## skip comment line

# It is necessary here to put variable in { } to do an action in awk
{ total += $4 }

# Here we use the special printf command to do some special formatting that print can't really do
END {
  printf("Bank Statement Total:\t%g\n", total)
}