## Unix Programming and Regular Expressions Workshop - Filename expansions and globbing

## Sections:

* [Tilde Expansion](#tilde-expansion)
* [Wildcards](#wildcards)
* [Hidden Files](#hidden-files)
* [Tilde Examples](#tilde-examples)
* [Wildcard Examples](#wildcard-examples)
* [Hidden File Examples](#hidden-file-examples)
* [Best Practices](#best-practices)
* [Extended Pattern Matching](#extended-pattern-matching)
* [Extended Pattern Notations](#extended-pattern-notations)
* [Enable Pattern matching](#enable-pattern-matching)
* [Extended Pattern Matching Examples](#extended-pattern-matching-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Tilde Expansion

The `~` is shorthand for a users home directory

* `~/somefile` is shorthand for a file in current users home directory
  * In my mac book ~ is short for `/Users/marcelbelmont` so `~/somefile` would expand to `/Users/marcelbelmont/somefile`
  * In linux machines usually `~` would be `/home/someuser`
* ~someuser/somefile would be for a file in a specific users home directory
  * `cd ~marcelbelmont/code-craftsmanship-organization/`
    * this command would expand to ` cd /Users/marcelbelmont/code-craftsmanship-organization`
* Common extensions:
  * `~+` will use the current directory
  * `~-` will use the previous directory
* The tilde `~` will expand after variable expansion so you could do `cd ~$USER` which would work

#### Wildcards

Wildcards are like regular expressions but are simpler

Wildcards are used for file names while regular expressions are typically used for file contents

* `*` asterisk matches any sequence of characters much like use in regular expressions
  * `ls .*` will print out all hidden files in current directory

* `?` will match any single character like the `.` dot in regular expressions

* Bracket expressions are like the regular expressions bracket expressions
  * Ranges and `[[:class:]]`
  * Big difference is the complement though
    * Use `[!...]` instead of `[^...]` to complement

* Anchoring is done implicitly
  * `*.c` => `^.*\.c$`
    * remember the `^ and $` will anchor the name to this
    * like `word.c` or something

#### Hidden Files

By convention files and directories whose names start with a dot are not shown by either `ls` and are not matched by `wildcards`

If you want to see hidden files pass `-a` flag which means "all"

* `ls -a` will print out all the files

```bash
$ ls -a
.  ..  .git  .gitignore  LICENSE  README.md  SUMMARY.md  _book	book.json  data  docs  node_modules  package.json  scripts
```

Notice that this printed out all the files/directories in the repo

```bash
ls -l ~/.profile
-rw-r--r-- 1 marcelbelmont 186 Jan 23  2017 /Users/marcelbelmont/.profile
```

Notice here I am printing out `.profile` in my home directory with `-l` flag option which gives full description

#### Tilde Examples

Example using extensions:

```bash
$ pwd
/Users/marcelbelmont/code-craftsmanship-organization/data-visualization-workshop
```

```bash
$ cd ~/code-craftsmanship-organization/unix-programming-and-regular-expressions-workshop
```

```bash
$ echo We were just in ~-
We were just in /Users/marcelbelmont/code-craftsmanship-organization/data-visualization-workshop
$ echo Now we are in ~+
Now we are in /Users/marcelbelmont/code-craftsmanship-organization/unix-programming-and-regular-expressions-workshop
```

Notice here that `~-` prints out the previous path we were in while `~+` prints out the current path

#### Wildcard Examples

Let use go to object file directory

```bash
$ cd ~/code-craftsmanship-organization/unix-programming-and-regular-expressions-workshop/object-files
```

Run the gcc utility to generate object files

```bash
$ gcc -c helloWorld.c
```

This will generate an object file

```bash
$ gcc helloWorld.o -o hello
```

This will generate an executable file called `hello`

```bash
$ ls *.[!c]
```

This command works in bash but not the zsh

#### Hidden File Examples

```bash
ls ~/.bash*
/Users/marcelbelmont/.bash_history
/Users/marcelbelmont/.bash_profile
/Users/marcelbelmont/.bashrc

/Users/marcelbelmont/.bash_sessions:
029688FD-3537-49D5-B14B-572B91E5DC3F.history
029688FD-3537-49D5-B14B-572B91E5DC3F.historynew
029688FD-3537-49D5-B14B-572B91E5DC3F.session
80529834-95E5-41D0-81D4-D94A60984AE1.history
80529834-95E5-41D0-81D4-D94A60984AE1.historynew
80529834-95E5-41D0-81D4-D94A60984AE1.session
8C1748D6-939A-4FBD-925F-0FBDBCFE729B.history
8C1748D6-939A-4FBD-925F-0FBDBCFE729B.historynew
8C1748D6-939A-4FBD-925F-0FBDBCFE729B.session
```

Notice this command prints out all the hidden files/directories that start with `.bash`

#### Best Practices

* You need to be very carefule with spaces and `*`
  * `rm *  .o
  * this will remove all files and then try to delete `.o` but that is already deleted

* Make sure to quote wildcard characters if you want to use them literally

* Older shells don't support tilde expansion even though tilde expansion is part of the POSIX standard.

* If you run scripts in a older shell then they may fail

#### Extended Pattern Matching

Extended Pattern Matching is availabe in Bash, ksh, zsh and probably other shells

Extended Pattern is not part of the POSIX standard

Don't rely on extended pattern matching though for portability though as some shells may not have it

Extended patterns provide similar power that extended regular expressions provide

Extended Pattern matching is a more powerful filename matching mechanism

#### Extended Pattern Notations

| `Pattern` | `ERE equivalent` | Explanation |
| --- | --- | --- |
| `*(exp)` | exp* | means zero or more of an exp |
| `+(exp)` | exp+ | means one or more of an exp |
| `?(exp)` | exp? | means zero or one of exp |
| <code>@(exp1&#124;exp2&#124;...&#124;expn)</code> | exp1 pipe exp2 | This is alternation |
| `!(exp)` | No equivalent notation | means complement of exp |

#### Enable Pattern matching

Use command `shopt` in bash

```bash
$ shopt --help
shopt: shopt [-pqsu] [-o] [optname ...]
    Set and unset shell options.

    Change the setting of each shell option OPTNAME.  Without any option
    arguments, list all shell options with an indication of whether or not each
    is set.

    Options:
      -o	restrict OPTNAMEs to those defined for use with `set -o'
      -p	print each shell option with an indication of its status
      -q	suppress output
      -s	enable (set) each OPTNAME
      -u	disable (unset) each OPTNAME

    Exit Status:
    Returns success if OPTNAME is enabled; fails if an invalid option is
    given or OPTNAME is disabled.
```

To enable extended pattern matching you do `shopt -s extglob`

You can see what shell options are enabled by simply typing `shopt` into shell or if it is enabled by the command you just entered

Use command `setopt` in zsh to enable shell options

Use command `unsetopt` to disable shell options

So to enable pattern matching in zsh do `setopt extendedglob`

[Zsh options](https://linux.die.net/man/1/zshoptions)

#### Extended Pattern Matching Examples

```bash
$ cd data
```

Go into data directory

```bash
$ echo @(vincent|john|jenny)
```

This command prints out `jenny john vincent` in bash but doesn't work as intended in zsh

```bash
$ echo *@(vincent|john|jingle)*
jingleheimer john vincent
```

In order to get `jingleheimer` we need to put `*` in front and after

If you see this message in bash `extglob` is not enabled `bash: !: event not found`

```bash
$ ls !(*.o)
hello  helloWorld.c
```

* This prints out anything not an object file so in this case the executable and c file get printed to stdout

The equivalent zsh command is `ls ^*.o`

* Use the extended patterns if they are available
* `!(...)` in bash for complement and `^..` in zsh
* `@(...)` in bash for alternation is useful
* You can use wildcards in the pattern like `!(*.o) in bash
* Use extended patterns where it makes sense
* Sometimes using something like `egrep` will be faster than a shell function that is read line-by-line

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Text Substitution](./text-substitution.md) | [Working with Fields](./working-with-fields.md) →
