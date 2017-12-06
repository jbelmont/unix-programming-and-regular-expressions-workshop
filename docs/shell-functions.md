## Unix Programming and Regular Expressions Workshop - Shell Functions

## Sections:

* [Shell Function Description](#shell-function-description)
* [Shell Function Syntax](#shell-function-syntax)
* [Shell Function Examples](#shell-function-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

### Shell Function Description

A shell function is like a function in other programming languages, where you can group
related statements together.

You can avoid code duplication by using functions to increase modularity and improve code
clarity and code reuse.

### Shell Function Syntax

#### Declaration

```bash
# Can be declared using just parenthesis
nameOfMyFunction () {
  body statements to execute
}
```

```bash
# ...or using the "function" keyword (or both)
# This is equivalent to the previous declaration.
function nameOfMyFunction {
  body statements to execute
}
```

You have to define functions before you can use them.

In a script you have to define them before you use them or they must be sourced from
outside of the script before you use them.

```bash
# Okay
. file-containing-myPrint.sh

myPrint "blah blah blah"
```

```bash
# Okay
function myPrint() {
  echo "$@"
}

myPrint "blah blah blah"
```

```bash
# NOT okay
myPrint "blah blah blah"

function myPrint() {
  echo "$@"
}
```

You can invoke shell functions just like shell commands.

Arguments are passed as $1, $2, ..., $n.  Likewise, $#, $\*, and $@ work similarly to a
script's command line arguments.

The main script arguments are shadowed by the functions arguments while the function is
running.  Thi

The return statement is used to return a status to the shell script and don't use exit to
return a status in a shell function because function do not run in a separate process

### Shell Function Examples

```bash
printHello() {
  echo Hello $1
}
```

This will create local function called printHello that takes an argument and echoes `Hello
$arg`

```bash
printHello Marcel
```

```bash
#! /bin/bash

ARGS=$@

help () {
  printf "Usage:\n\tProvide an argument\n"
}

if [[ $# -lt 1 ]] ; then
  help
  exit 1
fi

printArgs () {
  for arg in "$ARGS"
  do
    echo $arg
  done
}

printArgs
```

This simple script prints a help message if the number of arguments is less than 1

Notice I had to define `ARGS` variable at the top because the command line arguments of
the script will be shadowed so I captured value at the top of the script

### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Subshells](./subshells.md) | [Signal Handling](./signal-handling.md) →
