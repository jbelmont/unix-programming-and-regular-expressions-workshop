## Unix Programming and Regular Expressions Workshop - Looping

## Sections:

* [Loops](#loops)
* [While Loop](#while-loop)
* [Until Loop](#until-loop)
* [For Loop](#for-loop)
* [For Loop Arithmetic Style](#for-loop-arithmetic-style)
* [Break Command](#break-command)
* [Continue Command](#continue-command)
* [Special Builtins](#special-builtins)
* [Select Loop](#select-loops)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Loops

[Loops](https://en.wikipedia.org/wiki/Control_flow#Loops)

> A loop is a sequence of statements which is specified once but which may be carried out several times in succession. The code "inside" the loop (the body of the loop, shown below as xxx) is obeyed a specified number of times, or once for each of a collection of items, or until some condition is met, or indefinitely.

#### While Loop

`while COMMANDS; do COMMANDS; done`

Execute commands as long as a test succeeds.

Expand and execute COMMANDS as long as the final command in the
*while* COMMANDS has an exit status of zero.

Exit Status:
Returns the status of the last command executed.

```bash
while condition to check
do
  statements
done
```

**A while loop will continue to run as long as a statement is true**

#### Until Loop

`until: until COMMANDS; do COMMANDS; done`

Execute commands as long as a test does not succeed.

Expand and execute COMMANDS as long as the final command in the
*until* COMMANDS has an exit status which is not zero.

Exit Status:
Returns the status of the last command executed.

*Until loops run until a condition becomes true**

It is the inverse of the *while* loop

You can supply multiple commands between *while* and *until* and the *do* keyword

```bash
until something not true
do
  statements
done
```

```bash
while pipeline1 | pipeline2 ... | pipeline
do
  statements here
done
```

The exit status of the last command is taken into account before the do block determines success or failure

#### For Loop

`for: for NAME [in WORDS ... ] ; do COMMANDS; done`

Execute commands for each member in a list.

The *for* loop executes a sequence of commands for each member in a list of items.  

If 'in WORDS ...;' is not present, then `in "$@"` is
assumed.  

For each element in *WORDS*, *NAME* is set to that element, and the *COMMANDS* are executed.

Exit Status:
Returns the status of the last command executed.

So you see a **for** is used to traverse a list:

```bash
for var [ in list]
do
  something to be done
done
```

The default behavior of a *for* loop is there is no list is to use *"$@"* aka all the arguments provided

You can generate a list any way you want:

* Wildcard
* *$var*
* *$( ... )*

#### For Loop Arithmetic Style

There is an arithmetic for loop that you can do in both bash, ksh, and zsh

```bash
for (( init ; condition ; increment ))
do
  statements to execute
done
```

It has a similar form to C-based languages

The order of execution is as follows:

1. Init
2. Condition to test
3. Execute Loop Body
4. Increment Statement
5. Condition to Test
6. Execute Loop Body
7. This will occur until the Condition is not true anymore

If you forgot to put a condition then it is taken as *true*

#### Break Command

`break: break [n]`

Exit for, while, or until loops.

Exit a FOR, WHILE or UNTIL loop.  If N is specified, break N enclosing
loops.

Exit Status:
The exit status is 0 unless N is not greater than or equal to 1.

The Break Command is usually used to break out of a loop in the middle of the body

The *break* command "breaks out of a loop"

```bash
while something is true
do
  some stuff here
  if condition is true; then
    break
  fi
  some more stuff
done
```

Notice here the keyword **break**

You can provide a break level for example if you have 2 for loops and the break is inside of the second for loop `break 2` will break out of the outer loop as well

#### Continue Command

`continue: continue [n]`

Resume for, while, or until loops.

Resumes the next iteration of the enclosing FOR, WHILE or UNTIL loop.
If N is specified, resumes the Nth enclosing loop.

Exit Status:
The exit status is 0 unless N is not greater than or equal to 1.

The **continue** statement is used to skip the rest of the loop body and go back to the condition of the loop

```bash
while something is true
do
  some stuff here
  if condition is true; then
    continue
  fi
  some more stuff
done
```

You can pass an integer with the `continue` command like this *continue 2* and it will break out of the second level of the loop just as I described in the *break* statement section

#### Shift Command

`shift: shift [n]`

Shift positional parameters.

Rename the positional parameters $N+1, $N+2 ... to $1, $2 ...  If N is
not given, it is assumed to be 1.

Exit Status:
Returns success unless N is negative or greater than $#.

The *shift* command shifts the command-line parameters down

You can give a number if you want to shift by more than 1

The *shift* command is designed for argument processing in a loop

Behavior works like this:

`$3` becomes `$2` with first shift command and then `$2` becomes `$1` with another shift command and so on

The original *$1* will be lost with the *shift* command

Also the *$#* is adjusted on each *shift* command iteration

### Special Builtins

The commands *break*, *continue*, and *shift* are considered **special** builtin commands

Special Builtins are found by the shell before other functions

Some more special builtins:

* eval
* exec
* exit
* export
* readonly
* return
* set
* times
* trap
* unset

[A more complete list of special builtins](http://pubs.opengroup.org/onlinepubs/9699919799//utilities/V3_chap02.html#tag_18_14)

#### Select Loops

`select: select NAME [in WORDS ... ;] do COMMANDS; done`

* Select words from a list and execute commands.

* The WORDS are expanded, generating a list of words.  
* The set of expanded words is printed on the standard error, each preceded by a number.  

* If `in WORDS` is not present then "$@"' is assumed.

* The PS3 prompt is then displayed and a line read
from the standard input.

* If the line consists of the number corresponding to one of the displayed words, then NAME is set
to that word.

* If the line is empty, WORDS and the prompt are
redisplayed.  

* If EOF is read, the command completes.  

* Any other value read causes NAME to be set to null.  

* The line read is saved in the variable REPLY.  

* COMMANDS are executed after each selection until a break command is executed.

* Exit Status:
  * Returns the status of the last command executed.

The **select** loop is designed for running an interactive menu from a shell script

It is most useful in terminal-based environments

Environments like:

* Remote Logiin
* Embedded Systems

```bash
select var [ in list ]
do
  body statements
  if done ; then
    break
  fi
done
```

The *select* loop is similar to the *for* loop

The default list is "$@" aka the command line arguments

The *select* loop does the following:

* Creates and prints a numbered menu from the *list* values
* Prompt with `$PS3`. The default value for this prompt is `$#?`
* The select loop places user's response into *REPLY*
* The select loop places the selected value into the loop variable
* The select loop runs the loop body
  * You use `$REPLY` as a case selector to decide what to do
* `Control-D` or the EOF is used to exit the loop
* The `break` command can also break out of *select* loop

Even though `$PS3` has a default prompt, it is a good idea to set a more descriptive prompt

* `$REPLY` containes the users response
  * You can set `$REPLY` to empty `""` to force the menu to repeat
  * Also user hitting `Enter` will repeat the menu

* `$TMOUT` is the timeout in seconds for when the shell will exit the *select* loop and continue

#### Loop Examples

All The scripts can be found in **scripts/looping** directory

*Example While Loop*

```bash
#! /bin/bash

COUNT=1

printf "Printing Numbers: "
while [[ $COUNT -lt 11 ]] ; do
  printf "%i " "$((COUNT++))"
done
printf "\n"
```

*Example Until Loop*

```bash
#! /bin/bash

COUNT=10

printf "Printing Numbers: "
until [[ $COUNT -lt 1 ]]
do
  printf "%i " "$((COUNT--))"
done

printf "\n"
```

*Example For Loop*

```bash
#! /bin/bash

NAMES=(John Kate Ashish Lee Tom Omar)

echo "Names: "
for NAME in "${NAMES[@]}"
do
  printf "\t%s\n" "$NAME"
done
```

*Example Arithmetic For Loop*

```bash
#! /bin/bash

SUM=0
ANOTHER_SUM=0
YEP_ANOTHER_SUM=0

for (( COUNT=0 ; $COUNT<=10 ; $((COUNT++)) ))
do
  ((SUM+=COUNT))
  ANOTHER_SUM=`expr $COUNT + $ANOTHER_SUM`
  YEP_ANOTHER_SUM=$(( $COUNT + $YEP_ANOTHER_SUM ))
done

echo ""
echo "The Sum of the numbers 1 ... 10 is ${SUM}"
echo "Another Sum of the numbers 1 ... 10 is ${ANOTHER_SUM}"
printf "Yep another sum of the numbers 1 ... 10 is %s\n" "${YEP_ANOTHER_SUM}"
```

*Example Break Statement*

```bash
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
```

*Example continue statement*

```bash
#! /bin/bash

NAMES=(John Kate Ashish Lee Tom Omar)

echo "Names: "
for NAME in "${NAMES[@]}"
do
  if [[ $NAME == "John" ]] ; then
    continue
  fi
  printf "\t%s\n" "$NAME"
done
```

*Example shift command*

```bash
#! /bin/bash

ARGS=$@

echo "The number of arguments is $#"
for arg in "${ARGS}"
do
  echo $arg
  shift
done

echo ""

echo "The number of arguments is now $#"
```

*Example select loop*

```bash
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
```

We will run each of these script and talk about them.

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Decision Making and Exit Status](./decision-making-and-exit-status.md) | [Input and Output](./input-and-output.md) →
