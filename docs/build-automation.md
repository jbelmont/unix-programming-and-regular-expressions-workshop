## Unix Programming and Regular Expressions Workshop - Build Automation

## Sections:

* [Description of Build Automation](#description-of-build-automation)
* [List of Build Automation Utilities](#list-of-build-automation-utilities)
* [Make Overview](#make-overview)
* [Makefile Overview](#makefile-overview)
* [Makefile Rules](#makefile-rules)
* [Makefile Macros](#makefile-macros)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Description of Build Automation

[Build Automation](https://en.wikipedia.org/wiki/Build_automation)

> Build automation is the process of automating the creation of a software build and the associated processes including: compiling computer source code into binary code, packaging binary code, and running automated tests.

Essentially build automation converts a set of files into a consumable software product.

Build automation is a prerequisite to effective use of continuous integration. 

Benefits of Build Automation:

* Eliminates any variables in building software artifacts, thus reducing possible defects
* Reduce the number of steps to get consummable software product thus reducing possible mistakes
* Helps document target environments and/or dependenies on third party software

Historically build automation occurred with makefiles and we will use makefiles for this build automation tutorial

#### List of Build Automation Utilities

* [GNU Make](https://www.gnu.org/software/make/manual/html_node/Overview.html#Overview)
* [Apache Ant for Java](https://ant.apache.org/manual/)
* [Cabal for haskell](https://www.haskell.org/cabal/users-guide/)
* [npm scripts for Node based Projects](https://docs.npmjs.com/misc/scripts)
* [Rake for Ruby](https://en.wikipedia.org/wiki/Rake_(software))
* [MSBuild for Windows Development](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild)

There is many more build automation tooling this is just a short list I compiled

#### Make Overview

Make is typically used to build executable programs and libraries from source code

Make is applicable to any process that involves executing arbitrary commands to transform a source file to a target result

The make utility automatically determines which pieces of a large program need to be recompiled, and issues commands to recompile them

Make will not help you build on multiple platforms however and so tools like [Autoconf](https://www.gnu.org/software/autoconf/autoconf.html) and [cmake](https://cmake.org/cmake/help/v3.10/manual/cmake.1.html) can further help you with this problem

This is because compilers can differ on different platforms like for example [gnu gcc](https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc/) can have different behavior to [apple clang compiler](https://clang.llvm.org/get_started.html)

#### Makefile Overview

The [make utility](https://www.gnu.org/software/make/manual/html_node/Overview.html#Overview) will search in the current directory for a GNUmakefile, makefile, or Makefile files and will run specified or default targets from the [Makefile](https://en.wikipedia.org/wiki/Makefile)

Remember that earlier in the workshop we ran make without a makefile and the reason that worked is that make has some implicit rules that work as defaults unless you override them, therefore you can run make without a makefile

Read this [Stackoverflow Post](https://stackoverflow.com/questions/15745241/using-the-make-command-without-makefiles) on running make without makefile for more details on this

A **makefile** consists of a set of rules

A rule begins with a textual dependency line which defines a target followed by a colon (:) and optionally an enumeration of components (files or other targets) on which the target depends.

```make
some_binary:
	echo "nothing"
```

```bash
cd scripts/build-automation/example1; make
```

Notice here that when you run it you get the following output:

```bash
echo "nothing"
nothing
```

Because we specified the **target** *some_binary* first it is the **default** target

All it does is run the **echo** command. 

Notice that it printed out the execution of the `echo "nothing"` and then it printed out `"nothing"`

The exit status of make can be one of three values:

* 0 
  * The exit status is zero if make is successful.

* 2
  * The exit status is two if make encounters any errors. 
  * It will print messages describing the particular errors.

* 1
  * The exit status is one if you use the ‘-q’ flag and make determines that some target is not already up to date.

```bash
cd scripts/build-automation/example2; make
```

Notice here that when we run `make` here we only get the output **nothing** instead.

We will discuss this further later but an at sign (@) will suppress output to standard output

#### Makefile Rules

A makefile consists of rules.

The first command may appear on the same line after the prerequisites, separated by a semicolon

`targets : prerequisites ; command`

Here we defined a target with prereqs and command all in one line

```make
some_binary: ; @echo "nothing"
```

```bash
cd scripts/build-automation/example3; make
```

Here we get the same output except the target is run all in one line.

Notice that we had to put a semicolon `:` else we will get an error if we try to run `makefile` utility

Usually each rule has a single unique target, rather than multiple targets.

Make itself does not understand, recognize or distinguish different kinds of files

Each dependency line may be followed by a series of TAB indented command lines which define how to transform the components

If any of the prerequisites has a more recent modification time than the target, the command lines are run

Make decides where to start through [Topological Sorting](https://en.wikipedia.org/wiki/Topological_sorting).

A rule may have no command lines defined. 

```make
target ... [target] : prerequisites ... [prerequisites]
```

This generic example illustrates that having multiple targets and prerequisites but no commands

###### Makefile Prefixes

A makefile target can have one of three prefixes:

* a hyphen-minus (`-`), specifying that errors are ignored

* an at sign (`@`), specifying that the command is not printed to standard output before it is executed.

* a plus sign (`+`), the command is executed even if Make is invoked in a "do not execute" mode

###### Makefile Definitions

A **target** is usually the name of a file that is generated by a program.
Examples of targets are executable or object files.
A target can also be the name of an action to carry out, such as 'clean' (see Phony Targets).

A **prerequisite** is a file that is used as input to create the target. 
A target often depends on several files.

A **recipe** is an action that `make` carries out. 
A **recipe** may have more than one command, either on the same line or each on its own line. Please note: you need to put a tab character at the beginning of every recipe line! 
This is an obscurity that catches the unwary. 
If you prefer to prefix your recipes with a character other than tab, you can set the .RECIPEPREFIX variable to an alternate character.

```make
a_failure:
echo "Will not work"
```

This makefile will not work

```bash
cd scripts/build-automation/example4; make
```

If you run this makefile in your terminal you will see the following error:

_makefile:2: *** missing separator.  Stop._

Usually a **recipe** is in a rule with prerequisites and serves to create a target file if any of the prerequisites change. 
However, the rule that specifies a recipe for the target need not have prerequisites. 
For example, the rule containing the delete command associated with the target 'clean' does not have prerequisites.

A **rule**, then, explains how and when to remake certain files which are the targets of the particular rule. 
make carries out the recipe on the prerequisites to create or update the target. 
A rule can also explain how and when to carry out an action.

A makefile may contain other text besides rules, but a simple makefile need only contain rules. 
Rules may look somewhat more complicated than shown in this template, but all fit the pattern more or less.

#### Makefile Macros

A makefile can contain definitions of macros. 

Macros are usually referred to as variables when they hold simple string definitions, like "CC=clang".

Macros in makefiles may be overridden in the command-line arguments passed to the Make utility. 

Environment variables are also available as macros.

Macros allow users to specify the programs invoked and other custom behavior during the build process.

New macros (or simple "variables") are traditionally defined using capital letters

A macro is used by expanding it

Traditionally this is done by enclosing its name inside `$()`

An equivalent form uses curly braces rather than parenthesis, i.e. `${}`

This is more common in BSD Unix flavors like Mac OS X.

```make
MY_NAME = "Jean-Marcel"

print_my_name:
	@echo $(MY_NAME)
```

Notice here that we defined a **macro** named MY_NAME and used command prefix `@` to suppress output of `echo` command execution

```bash
cd scripts/build-automation/example5; make
```

You can see the output of the above makefile by running the snippet above

```make
MY_NAME = "Jean-Marcel"

print_my_name:
	@echo ${MY_NAME}
```


Here we get the same output but used `${}` instead of `$()` to expand the makefile **MACRO**

Macros can be composed of shell commands by using the command substitution operator, denoted by backticks (\`).

Here is another example of shell commands:

```make
SOME_DATE = `date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"`

print_date_in_past:
	@echo ${SOME_DATE}
```

In this example we can't use `$()` but need to use the \` \` instead

MACROS can be overriden in the commandline by doing the following:

`make MACRO="value" [MACRO="value" ...] TARGET [TARGET ...]`

```make
MY_NAME = "Jean-Marcel Belmont"

print my_name:
	@echo $(MY_NAME)
```

Here we defined the *MY_NAME* MACRO


```bash
cd scripts/build-automation/example9; make
```

Here we get the following output:

**Jean-Marcel Belmont**

If we however run make like this:

`make MY_NAME="John Rambo"*

then the MY_NAME macro is overriden and the value `John Rambo` is printed to stdout instead

makefiles also have some predefined **MACROS** 

You can find a complete list of MACROS [HERE](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

You can also use environment variables as MACROS

```make
print_my_environment_variable:
	@echo $$MY_VAR
```

Notice here that we had to access the environment variable with `$$` syntax.

The reason being is that each line of a makefile is parsed first using the makefile syntax, and then the result is passed to the shell so you have to wrap it in 2 `$` signs

```bash
cd scripts/build-automation/example10; export MY_VAR="SOME VALUE"; make
```

When we run the following snippet from above we get the output **SOME VALUE** to stdout

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Remote File Sharing and File Access](./remote-file-sharing-and-file-access.md) | [Building Command line applications](./building-command-line-applications.md) →
