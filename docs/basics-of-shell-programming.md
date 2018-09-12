## Unix Programming and Regular Expressions Workshop - Basics of Shell Programming

## Sections:

* [Variables](#variables)
* [Demonstrate different types of args](#demonstrate-different-types-of-args)
* [Quoting](#quoting)
* [Execution Tracing](#execution-tracing)
* [Redirection](#redirection)
* [Command Types and Searching](#command-types-and-searching)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Variables

Variables store data.

If you want to get the value of a stored variable then you need to use `$SOME_VARIABLE`

```bash
$ MY_JUNK_VARIABLE=JUNKY
$ echo $MY_JUNK_VARIABLE
JUNKY
```

Bash doesn't preserve whitespace in variables unless you use double quotes

```bash
$ echo 'a        b'
a        b
$ echo "a              b"
a              b
$ some="a              b"
$ echo $some
a b
$ echo "$some"
a              b
```

Zsh on the either hand does preserve spaces

```bash
$ one="a         b"
$ echo $one
a         b
$ echo "$one"
a         b
```

If you pass the `-n` flag to `echo` like this `echo -n "Type your name: "` it will not print trailing newline

```bash
$ echo -n "Enter your Name: "
Enter your Name: %
```

Notice the `%` character in the prompt

```bash
$ chmod +x scripts/basics-of-shell-programming/simple-output.sh
$ ./scripts/basics-of-shell-programming/simple-output.sh
```

The `$#` tells you the number of arguments passed in

```bash
echo $#
0
```

Notice that 0 printed but that is not fixed

```bash
$ ./scripts/basics-of-shell-programming/count-arguments.sh the number of args is
The number of arguments passed in this script is: 5
```

**Run the script above at the root of the repository**

#### Demonstrate different types of args

$1 ... $9 will print the position of the argument

Both `$*` and `$@` expand to positional parameters.

But `$*` and `$@` behave differently when you use double quotes:

1. "$@" expands to properly quoted arguments
2. "$*" makes all arguments into a single argument.

```bash
$ ./scripts/basics-of-shell-programming/compare-positional-parameters.sh
Args using $@
one
two three
four
Args using $*
one two three four
```

Notice that the `$@` treated each argument that was quoted as separate while `$*` treated them as one argument

*Always use double quotes when referring to variable values*

Always use "$*" to refer to all command line arguments in these scenarios:

1. Processing arguments in a loop
2. Passing arguments onto another command

#### Quoting

```bash
$ one=one
$ echo $one
one
$ echo \$one
$one
```

Notice above that the backslash made `echo \$one` a literal argument

```bash
$ first_name=marcel
$ last_name=belmont
$ echo '$first_name $last_name'
$first_name $last_name
$ echo "$first_name $last_name"
marcel belmont
$ name="$first_name $last_name"
$ echo "My name is $name"
My name is marcel belmont
```

Notice that the variables in single quotes were treated literally while the double quotes were evaluated

#### Execution Tracing

[Debugging in Bash](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_03.html)

Execution tracing is the main way to conduct debugging in the `shell`

```bash
$ set -x
$ echo $name
+ echo Jean-Marcel
Jean-Marcel
$ set +x
+ set +x
$ echo $name
Jean-Marcel
```

Notice that `set -x` turned on execution tracing while `set +x` turned it off again

Run the script `./scripts/basics-of-shell-programming/script-tracing.sh`

```bash
$ ./scripts/basics-of-shell-programming/script-tracing.sh one two three
+ for arg in '"$@"'
+ printf 'This arg is one\n'
This arg is one
+ for arg in '"$@"'
+ printf 'This arg is two\n'
This arg is two
+ for arg in '"$@"'
+ printf 'This arg is three\n'
This arg is three
```

Notice here that we turned on execution tracing in the `shebang` line with optional argument
Each line traced each step of the script, notice that the script ran 3 times

* Backslash `\` will quote the following single character
* Single Quotes are treated literally
  * No need to escape and single quotes don't do expansion
  * Need to escape embedded single quotes in single quotes
    * `echo 'one '\''two'\'''` => `one 'two'`
* Double quotes do some expansions
  * Use `\` inside "..." to escape the following characters:
    * "
    * $
    * `
* Execution Tracing helps you understand what the shell is doing on each step

###### Best Practice for Quoting

* Quote text that are passed to commands
  * Double quote is almost always what you want to do
* Make sure to understand what double quote do
* Execution Tracing is the most important form of debugging in the shell
  * There is a bash debugger as well
* Bash quotes arguments with metacharacters

#### Redirection

[Redirection](https://en.wikipedia.org/wiki/Redirection_%28computing%29)

```bash
$ cat
one
one
two
two
three
three
```

Here I entered `cat` pressed enter then typed one and hit enter and standard output printed another one to standard output and the last three printed to standard output I pressed `control d`

```bash
$ cat > colors.txt
## Hit enter
blue
green
orange
black
yellow
## Press Control D for end of line
```

```bash
$ cat colors.txt
blue
green
orange
black
yellow
```

Notice that we used cat and redirected the output of standard input into the file called `colors.txt`

```bash
$ cat >> colors.txt
white
bash-4.4$ cat colors.txt
blue
green
orange
black
yellow
white
```

Notice here that the `>>` operator appended elements to a file

```bash
$ echo "one
> two
> three
> " > numbers.txt

$ cat numbers.txt
one
two
three

$ echo "four
> five
> six" > numbers2.txt

$ cat numbers.txt numbers2.txt > allnumbers.txt

$ cat allnumbers.txt
one
two
three
four
five
six
```

1. Notice in this shell execution we created 2 files called `numbers.txt` and `numbers2.txt` using echo command
2. Then we created another file called `allnumbers.txt` using `>` redirection operator

```bash
$ tr a-z A-Z << UPPER
> one
> two
> three
> UPPER
ONE
TWO
THREE
```

Notice the `tr` operator which translate characters and the `<<` operator is known as a here document
When you use the `<<` operator (here document) you need to define a literal value to delimit in this case we used `UPPER`

[Here Document](https://en.wikipedia.org/wiki/Here_document)

```bash
$ tr a-z A-Z <<< "one two three"
```

Notice that here we use `<<<` which is known as `here string`

[Here strings](https://en.wikipedia.org/wiki/Here_document#Here_strings)

```bash
$ od -c allnumbers.txt
0000000    o   n   e  \n   t   w   o  \n   t   h   r   e   e  \n   f   o
0000020    u   r  \n   f   i   v   e  \n   s   i   x  \n
0000034
```

Notice here we used the `od -- octal, decimal, hex, ASCII dump` operator with `-c` flag to output c-style escaped characters

###### Differences with Redirection Operators

1. `<` is used to redirect input
2. `>` is used to redirect output.
3. `>>` is used to append output
4. `<<` is used to read from a stream literal and behaves like a file
5. `<<<` is used to read a stream from a word
6. `|` is used to feed standard output of one command as standard input for another command

###### Other operators used in shell redirection

[TLDP Shell Redirection](http://www.tldp.org/LDP/abs/html/io-redirection.html)

* 1> filename
  * Redirect stdout to file "filename."

* 1>> filename
  * Redirect and append stdout to file "filename."

* 2> filename
  * Redirect stderr to file "filename."

* 2>> filename
  * Redirect and append stderr to file "filename."

* &> filename
  * Redirect both stdout and stderr to file "filename."
  * This operator is now functional, as of Bash 4, final release.

* 2>&1
  * Redirects stderr to stdout.
  * Error messages get sent to same place as standard output.
  * >> filename 2>&1
    * bad_command >>filename 2>&1
    * Appends both stdout and stderr to the file "filename" ...
    * 2>&1 | [command(s)]
    * bad_command 2>&1 | awk '{print $5}'   # found
    * Sends stderr through a pipe.
    * |& was added to Bash 4 as an abbreviation for 2>&1 |.

* i>&j
  * Redirects file descriptor i to j.
  * All output of file pointed to by i gets sent to file pointed to by j.

* >&j
  * Redirects, by default, file descriptor 1 (stdout) to j.
  * All stdout gets sent to file pointed to by j.

Here is a hello world example in the C programming Language with a syntax error

```c
#include <stdio.h>

int main(int argc, char **argv) {
  printf("hello World\n")
  return 0;
}
```

```bash
$ make helloWorld
cc     helloWorld.c   -o helloWorld
helloWorld.c:4:26: error: expected ';' after expression
  printf("hello World\n")
                         ^
                         ;
1 error generated.
make: *** [helloWorld] Error 1
```

Here we use the [Make](https://en.wikipedia.org/wiki/Make_%28software%29) utility which is a build automation tool to build executable programs

When we run `make helloWorld` we get both standard output and standard error all printed in screen

```bash
$ make helloWorld > helloWorld.out 2> helloWorld.err
$ cat helloWorld.err
helloWorld.c:4:26: error: expected ';' after expression
  printf("hello World\n")
                         ^
                         ;
1 error generated.
make: *** [helloWorld] Error 1
$ cat helloWorld.out
cc     helloWorld.c   -o helloWorld
```

Notice here we used `>` to redirect standard output  and `2>` to redirect standard error
One important point is that you must redirect standard output before redirecting standard error

```bash
$ make helloWorld 2>&1 | tee errors
```

Notice here used `2>&1` to redirect stderr to stdout and then used the [TEE command](https://en.wikipedia.org/wiki/Tee_\(command\))

* The tee utility copies standard input to standard output, making a copy in zero or more files.
  * The output is unbuffered.

```bash
$ make helloWorld > helloWorld.out 2>&1
```

This command redirects standard output and standard error to a file called helloWorld.out

###### Pipe Operator

```bash
✗ echo 'one two three' | tr a-z A-Z
ONE TWO THREE
```

The `|` operator used the standard output of echo to feed the `tr` operator and transform characters to uppercase

[Pipelines in Unix](https://en.wikipedia.org/wiki/Pipeline_%28Unix%29)

> In Unix-like computer operating systems, a pipeline is a sequence of processes chained together by their standard streams, so that the output of each process (stdout) feeds directly as input (stdin) to the next one.

###### Good Practices in Shell Redirection

* Read the Fine Manual (RTFM) as necessary using `man` command
* Capture standard error as necessary
* Throw away standard output if you don't need it
* Redirection with `<`, `>`, `<<`, `<<<`, `|` are fundamental operators to use
* Redirecting standard error with `2>...` is both powerful and useful

Redirecting standard error in 3 ways:

1. `make helloWorld > helloWorld.out 2> helloWorld.err`
  1. This format creates 2 separate files with `>` funneling standard output into a file
  2. and `2>` funneling standard error into a file
2. `make helloWorld > helloWorld.out 2>&1`
  1. This command sends stdout and stderr both to helloWorld.out
3. `make helloWorld 2>&1 | tee helloWorld.out`
  1. This command uses tee to both send stdout and stderr to console and create file called `helloWorld.out`

###### Redirect to /dev/null

```bash
$ cat /etc/passwd > /dev/null
$ echo $?
0
```

In this run we threw away standard output into `/dev/null` and then checked exit status with `$?` and it ran successfully

* Read more about devices directory in [The /dev directory](http://www.tldp.org/LDP/sag/html/dev-fs.html)

#### Command Types and Searching

[Type Operator](https://en.wikipedia.org/wiki/Type_%28Unix%28)

###### Shell Builtins

[Shell Builtin](https://en.wikipedia.org/wiki/Shell_builtin)

> In computing, a shell builtin is a command or a function, called from a shell, that is executed directly in the shell itself, instead of an external executable program which the shell would load and execute.

```bash
$ type echo
echo is a shell builtin
```

```bash
$ type type
type is a shell builtin
```

Notice here that `type` is used to tell what type of command we have

###### Shell Functions

```bash
$ type cp
cp is /bin/cp
```

`cp` is a shell function

###### Shell Aliases

[Shell Aliases](https://en.wikipedia.org/wiki/Alias_%28command%29)

> In computing, alias is a command in various command line interpreters (shells) such as Unix shells, 4DOS/4NT and Windows PowerShell, which enables a replacement of a word by another string. It is mainly used for abbreviating a system command, or for adding default arguments to a regularly used command. Aliasing functionality in the MS-DOS and Microsoft Windows operating systems is provided by the DOSKey command-line utility.

```bash
✗ alias
-='cd -'
...=../..
....=../../..
.....=../../../..
......=../../../../..
1='cd -'
2='cd -2'
3='cd -3'
4='cd -4'
5='cd -5'
6='cd -6'
7='cd -7'
8='cd -8'
9='cd -9'
_=sudo
afind='ack -il'
baidu='web_search baidu'
bing='web_search bing'
brews='brew list -1'
bubc='brew upgrade && brew cleanup'
bubo='brew update && brew outdated'
bubu='bubo && bubc'
d='dirs -v | head -10'
dcb='docker-compose build'
dcdn='docker-compose down'
dce='docker-compose exec'
dcl='docker-compose logs'
dclf='docker-compose logs -f'
dco=docker-compose
dcps='docker-compose ps'
dcr='docker-compose run'
dcrestart='docker-compose restart'
dcrm='docker-compose rm'
dcstop='docker-compose stop'
...
```

Notice here that aliases are used to make abbreviated commands

###### Hashed commands

```bash
$ ls
LICENSE				_book				docs				package.json
README.md			book.json			node_modules			scripts
SUMMARY.md			data				npm-debug.log.4075885730
$ man bash
$ hash
hits	command
   1	/usr/bin/man
   1	/bin/ls
```

###### Shell Keywords

> A keyword is a reserved word, token or operator. Keywords have a special meaning to the shell, and indeed are the building blocks of the shell's syntax. As examples, for, while, do, and ! are keywords. Similar to a builtin, a keyword is hard-coded into Bash, but unlike a builtin, a keyword is not in itself a command, but a subunit of a command construct.

```bash
$ type [
[ is a shell builtin
$ type [[
[[ is a shell keyword
```

We will go over these later in the workshop

###### Shell Documentation for Builtins

In bash use `help` to get documentation for shell builtins

```bash
$ help echo
echo: echo [-neE] [arg ...]
    Write arguments to the standard output.

    Display the ARGs, separated by a single space character and followed by a
    newline, on the standard output.

    Options:
      -n	do not append a newline
      -e	enable interpretation of the following backslash escapes
      -E	explicitly suppress interpretation of backslash escapes

    `echo' interprets the following backslash-escaped characters:
      \a	alert (bell)
      \b	backspace
      \c	suppress further output
      \e	escape character
      \E	escape character
      \f	form feed
      \n	new line
      \r	carriage return
      \t	horizontal tab
      \v	vertical tab
      \\	backslash
      \0nnn	the character whose ASCII code is NNN (octal).  NNN can be
    		0 to 3 octal digits
      \xHH	the eight-bit character whose value is HH (hexadecimal).  HH
    		can be one or two hex digits

    Exit Status:
    Returns success unless a write error occurs.
```

while in Zsh you need to use `run-help` to get shell builtin documentation

```zsh
$ run-help echo
## Pager is used in my case it is LESS
echo [ -neE ] [ arg ... ]
       Write  each  arg on the standard output, with a space separating
       each one.  If the -n flag is not present, print a newline at the
       end.  echo recognizes the following escape sequences:

       \a     bell character
       \b     backspace
       \c     suppress final newline
       \e     escape
       \f     form feed
       \n     linefeed (newline)
       \r     carriage return
       \t     horizontal tab
       \v     vertical tab
       \\     backslash
       \0NNN  character code in octal
       \xNN   character code in hexadecimal
       \uNNNN unicode character code in hexadecimal
       \UNNNNNNNN
              unicode character code in hexadecimal

       The  -E  flag,  or  the  BSD_ECHO option, can be used to disable
       these escape sequences.  In the latter case, -e flag can be used
       to enable them.
/Users/marcelbelmont/zsh_help/echo (END)
```

###### Command Builtin

Command is used when you want to enhance a regular builtin command and what to use shell functions

In this script below although we really didn't enhance `echo` command is a sample script using `command` builtin

`different-type-of-echo.sh`:

```bash
#! /bin/bash -

type echo
echo "defining echo command"

function echo () {
  command echo "$@"
  printf "Printing some commands here\n"
}

type echo

echo "one two three"
```

Running the script above:

```bash
echo is a shell builtin
defining echo command
echo is a function
echo ()
{
    command echo "$@";
    printf "Printing some commands here\n"
}
one two three
Printing some commands here
```

Notice that at first `echo` is a shell builtin and then with the `command` builtin we are using our own version of `echo`

###### Special Builtins

[Bash Special Builtins](https://www.gnu.org/software/bash/manual/html_node/Special-Builtins.html#Special-Builtins)

For historical reasons, the POSIX standard has classified several builtin commands as special. When Bash is executing in POSIX mode, the special builtins differ from other builtin commands in three respects:

Special builtins are found before shell functions during command lookup.
If a special builtin returns an error status, a non-interactive shell exits.
Assignment statements preceding the command stay in effect in the shell environment after the command completes.
When Bash is not executing in POSIX mode, these builtins behave no differently than the rest of the Bash builtin commands. The Bash POSIX mode is described in Bash POSIX Mode.

These are the POSIX special builtins:

break : . continue eval exec exit export readonly return set
shift trap unset

I am not sure whether zsh calls `break` and `continue` special builtins

###### Defining your own scripts

The `PATH` variable is used find location of binary executables

> On POSIX and Unix-like operating systems, the $PATH variable is specified as a list of one or more directory names separated by colon (:) characters.

[Path Variable](https://en.wikipedia.org/wiki/PATH_%28variable%29)

```bash
echo $PATH
/Users/marcelbelmont/.gvm/bin:/Users/marcelbelmont/.nvm/versions/node/v6.11.2/bin:/Users/marcelbelmont/.local/bin:/Users/marcelbelmont/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/go/libexec/bin:/usr/local/opt/openvpn/sbin:/Users/marcelbelmont/go/bin:/Users/marcelbelmont/.gvm/bin:/Users/marcelbelmont/.local/bin:/Users/marcelbelmont/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/go/libexec/bin:/usr/local/opt/openvpn/sbin:/Users/marcelbelmont/go/bin:/Users/marcelbelmont/.gvm/bin:/Users/marcelbelmont/.local/bin:/Users/marcelbelmont/bin:/usr/local/bin:/usr/local/sbin:...
```

Notice that when we echo the contents of `PATH` variable the local executables come first

```bash
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$(brew --prefix openvpn)/sbin:$GOPATH/bin:$PATH
```

Here is my local `PATH` variable

```bash
export PATH="$PATH:$HOME/.rvm/bin"
```

Here `rvm` is prepended to existing `PATH` variable

*Good Practices for PATH variable:*

* You should use a convention like `$HOME:/bin` to define any local scripts
* Don't use current directory as this can be used to execute malicious code like a `trojan horse`
* Be careful with `PATH` variable
  * Use full paths only
  * Don't use empty elements or explicit `.` in PATH variable
* Try to put private directories first
* Use command function to skip functions
* Clear `CDPATH` in production environments

###### CDPATH variable

* Use CDPATH to define the base directory for cd command
* Never export CDPATH from your shell to the environment.
* If you use CDPATH then set it in your `.bashrc`, `.zshrc` file and don’t export it
  * so that it’s only set in interactive shells.

```bash
CDPATH=~/genesys:.
```

Now when I try `cd` into directory I can cd into any folders inside of `~/genesys` and it will be found

As I mentioned above don't do this in production because there is assumptions about directory structure here that won't necessarily be the case in a production environment

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [README](../README.md) | [Introduction to Text Processing](./introduction-to-text-processing.md) →
