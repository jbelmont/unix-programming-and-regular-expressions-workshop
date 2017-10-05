## Unix Programming and Regular Expressions Workshop - Basics of Shell Programming

## Sections:

* [Variables](#variables)
* [Demonstrate different types of args](#demonstrate-different-types-of-args)
* [Redirection](#redirection)
* [Command Types and Searching](#command-types-and-searching)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Variables

Variables store data.

If you want to get the value of a stored variable then you need to use `$SOME_VARIABLE`

```bash
➜  unix-programming-and-regular-expressions-workshop git:(master) MY_JUNK_VARIABLE=JUNKY
➜  unix-programming-and-regular-expressions-workshop git:(master) echo $MY_JUNK_VARIABLE
JUNKY
```

Bash doesn't preserve whitespace in variables unless you use double quotes

```bash
bash-3.2$ echo 'a        b'
a        b
bash-3.2$ echo "a              b"
a              b
bash-3.2$ some="a              b"
bash-3.2$ echo $some
a b
bash-3.2$ echo "$some"
a              b
```

Zsh on the either hand does preserve spaces

```bash
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ one="a         b"
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ echo $one
a         b
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ echo "$one"
a         b
```

If you pass the `-n` flag to `echo` like this `echo -n "Type your name: "` it will not print trailing newline

```bash
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ echo -n "Enter your Name: "
Enter your Name: %
```

Notice the `%` character in the prompt

```bash
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ chmod +x scripts/basics-of-shell-programming/simple-output.sh
➜  unix-programming-and-regular-expressions-workshop git:(master) ✗ ./scripts/basics-of-shell-programming/simple-output.sh
```

The `$#` tells you the number of arguments passed in

```bash
echo $#
0
```

Notice that 0 printed but that is not fixed

```bash
unix-programming-and-regular-expressions-workshop git:(master) ✗ ./scripts/basics-of-shell-programming/count-arguments.sh the number of args is
The number of arguments passed in this script is: 5
```

**Run the script above at the root of the repository**

#### Demonstrate different types of args

$1 ... $9 will print the position of the argument

#### Redirection

content

#### Command Types and Searching

content

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [README](../README.md) | [Introduction to Text Processing](./introduction-to-text-processing.md) →
