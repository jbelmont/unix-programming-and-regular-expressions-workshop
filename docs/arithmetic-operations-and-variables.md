## Unix Programming and Regular Expressions Workshop - Arithmetic Operations and variables

## Sections:

* [Variable Assignment Syntax](#variable-assignment-syntax)
* [Create Global variables](#create-global-variables)
* [Read only variables](#read-only-variables)
* [Environment control with env](#environment-control-with-env)
* [Unset command](#unset-command)
* [Variable Best Practices](#variable-best-practices)
* [Parameter expansions](#parameter-expansions)
* [Command line arguments](#command-line-arguments)
* [Simple Parameter Expansion](#simple-parameter-expansion)
* [Other types of expansions](#other-types-of-expansions)
* [Parameter expansion best practices](#parameter-expansion-best-practices)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Variable Assignment Syntax

To assign variables you do `somevar=somevalue` 

* Don't use spaces around the `=` sign
* You need to quote values if the value contains some whitespace
* You don't need to quote if you assigning a value
  * FOO=foo; bar=$FOO
  * `FOO` variable is assigned so we just assign bar to it with quotes
* You can do multiple assignments in one line

```bash
bar='BAR' foo=FOO baz=BAZ
```

```bash
echo $bar $foo $baz
BAR FOO BAZ
```
Notice here we created three variables in one line with no issues because the assignments worked from left to right

Some shells give you concatenation capability like so:

`somevar+=somevalue` which will concatenate a value to the end of `$somevar` but this is not defined in `POSIX` so be wary for portability's sake

#### Create Global variables

A shell environment has a list of name/value pairs (aka associative array, or dictionary) that are accesible to all programs in the shell

Child programs in the shell will inherit the shell environment from the Parent program

To make globally accessible variables use the `export` command 

`export BAZ=baz`

This will do 2 things:

1. It will give the value 'baz' to `BAZ`
2. It will create a name/value pair that is available to child programs.

The `export -p` command will print all global shell variables

#### Read only variables

The command `readonly somevar=value` will 3 things:

1. Assign value to _somevar_
2. It will disallow changing _somevar_
3. It will not put _somevar_ into shell environment like `export` command

```bash
readonly immutable='Will not change me'
```

Here we create a readonly variable

```bash
immutable='this will not work'
```

Zsh prints this output: `zsh: read-only variable: immutable`

Bash prints this output: `bash: immutable: readonly variable`

If you use `readonly -p` it will print the read-only variables

In zsh here is the output: `typeset -r immutable='Will not change me'`

In bash here is the output:

```bash
bash-4.4$ readonly immutable='Will not change me'
bash-4.4$ immutable='this will not work'
bash: immutable: readonly variable
bash-4.4$ readonly -p
declare -r BASHOPTS="cmdhist:complete_fullquote:expand_aliases:extquote:force_fignore:hostcomplete:interactive_comments:progcomp:promptvars:sourcepath"
declare -ir BASHPID
declare -ar BASH_VERSINFO=([0]="4" [1]="4" [2]="12" [3]="1" [4]="release" [5]="x86_64-apple-darwin16.3.0")
declare -ir EUID="501"
declare -ir PPID="25996"
declare -r SHELLOPTS="braceexpand:emacs:hashall:histexpand:history:interactive-comments:monitor"
declare -ir UID="501"
declare -r immutable="Will not change me"
```

#### Environment control with env

The `env` command provides a way to control the shell environment

```bash
env
TERM_SESSION_ID=w1t0p0:011B05E8-0A67-486A-A821-E15BCBA8AF92
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.1s3qZ3IXF0/Listeners
Apple_PubSub_Socket_Render=/private/tmp/com.apple.launchd.7gtsRkK4VJ/Render
COLORFGBG=12;8
ITERM_PROFILE=Default
XPC_FLAGS=0x0
LANG=en_US.UTF-8
PWD=/Users/marcelbelmont/code-craftsmanship-organization/unix-programming-and-regular-expressions-workshop
SHELL=/usr/local/bin/zsh
SECURITYSESSIONID=186a8
TERM_PROGRAM_VERSION=3.1.3
TERM_PROGRAM=iTerm.app
...
```

Here it prints all the shell variables

If you want to start a shell environment with clean slate use `env -i` and set variables you want, in this way the shell will not inherit anything

#### Unset command

`unset` will remove shell variables and functions

unset options:

* `unset` with no options or with `-v` will just remove variables
* `unset -f` will remove shell functions

* When you use `unset` it will also remove variables from the shell environment

#### Variable Best Practices

* Don't put spaces around the `=` when doing variable assignments
* Make sure to quote values that have whitespace
* exported variables will share the same namespace as regular variables
* I haven't seen much use of read-only variables even though I introduced them

#### Parameter expansions

Parameters consist of regular shell variables(baz=BAZ)

Command line argument like this:

* `$1`, ... `$n`
* `$#`
* `$#`,
* `$@`,
* `$*`
**We have discusses these already earlier**

* `$?` ==> this gives you exit status code

Parameter expansion is the way you get values from different parameters

#### Command line arguments

* `$1`, ..., `${8}` is individual positional parameters
* `$@` and `$*` will get all arguments but their expansion will behave differently in quotes as was discussed earlier in the workshop
* `$#` is the count of command line arguments
* `shift` command will drop an argument from left side and decrement `$#` and is used in shell scripts
* `$0` is the name of the shell program or could a function
* `$-` will give options given to shell at invocation `awk -f`
* `$$` will show process ID of current shell process
* `$?` will show exit status of last background command
* `$!` will show process ID of last background command
* `$HOME` is the current users home directory for example my home is `/Users/marcelbelmont`
* `$IFS` is the set input field separator characters
* `$ENV` is the startup file for interactive shells

#### Simple Parameter Expansion

As you have seen already to get variable value you need to precede `$` to variable name like `$HOME`

If you want to use a variable but it is enclosed in a variable

```bash
echo "my home directory is ${HOME}"
my home directory is /Users/marcelbelmont
```

| `Operator` | `Action` | `Purpose` |
| ${var:-word} | If the variable exists and is not nul return it else return the word | Its purpose is to return if a variable is not defined |
| ${var:=word} | If var exists and is not null return it else assign word | Its purpose is to set a variable to a default value if it is not defined already |
| ${var:?message} | If var exists and is not null return it else print message | Its purpose is to catch errors if a variable is not defined |
| ${var:+word} | If var exists and is not null return the word else return null | Its purpose is to test if a variable exists and has a value |

#### Other types of expansions

| `Operator` | `Action` |
| ${var#pattern} | delete shortest matching text from front of value |
| ${var##pat} | delete longest text from front of value | 
| ${var%pattern} | delete shortest matching text from end of value |
| ${var%%pattern} | delete longest matching text from end of value |

#### Parameter expansion best practices

* Remember that when you use `$@` and `$*` there is quoting quirks
* `$$` will often be used when creating temporary filenames
  * `mktemp` is a better command to use for this purpose
* In general the most useful general expansion is `${value:-someval}` and `${value:=somevalue}`
* The `${var#pattern}` type parameter expansions can be good for manipulating pathnames and filenames

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Text Sorting](./text-sorting.md) | [Decision Making and Exit Status](./decision-making-and-exit-status.md) →
