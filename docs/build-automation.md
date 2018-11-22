## Unix Programming and Regular Expressions Workshop - Build Automation

## Sections:

* [Description of Build Automation](#description-of-build-automation)
* [List of Build Automation Utilities](#list-of-build-automation-utilities)
* [Make Overview](#make-overview)
* [Makefile Overview](#makefile-overview)
* [Makefile Rules](#makefile-rules)
* [Makefile Macros](#makefile-macros)
* [Default command](#default-command)
* [Makefile Tasks](#makefile-tasks)
* [Including Other Makefiles](#including-other-makefiles)
* [Running make with different named file](#running-make-with-different-named-file)
* [Automatic variables and Wildcards](#automatic-variables-and-wildcards)
* [Phony Targets](#phony-targets)
* [Commands](#commands)
* [Make Options](#make-options)
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
* [Rake for Ruby](https://en.wikipedia.org/wiki/Rake_%28software%29)
* [MSBuild for Windows Development](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild)

There is many more build automation tooling this is just a short list I compiled

#### Make Overview

Make is typically used to build executable programs and libraries from source code

Make is applicable to any process that involves executing arbitrary commands to transform a source file to a target result

The make utility automatically determines which pieces of a large program need to be recompiled, and issues commands to recompile them

Make will not help you build on multiple platforms however and so tools like [Autoconf](https://www.gnu.org/software/autoconf/autoconf.html) and [cmake](https://cmake.org/cmake/help/v3.10/manual/cmake.1.html) can further help you with this problem

This is because compilers can differ on different platforms like for example [gnu gcc](https://gcc.gnu.org/onlinedocs/gcc-7.2.0/gcc/) can have different behavior to [apple clang compiler](https://clang.llvm.org/get_started.html)

Parts of a Makefile:

* Comment which start with `#`
* A variable assignment
	* **Lazy Set**
		* `myvar = 'A Name'`
		* Normal setting of a variable - values within it are recursively expanded when the variable is used, not when it's declared
	* **Immediate Set**
		* `myvar := 'Some Name'`
		* Setting of a variable with simple expansion of the values inside - values within it are expanded at declaration time.
	* **Set If Absent**
		* `MyFoo ?= SomeBar`
		* Setting of a variable only if it doesn't have a value
	* **Append**
		* `anotherVar += 'another one bites the dust'`
		* Appending the supplied value to the existing value (or setting to that value if the variable didn't exist)
* A Rule
	* `target: dependencies\n\tsystem command(s)`
	* An explicit rule says when and how to remake one or more files, called the rule's targets.
	* It lists the other files that the targets depend on, called the prerequisites of the target, and may also give a recipe to use to create or update the targets.
	* An implicit rule says when and how to remake a class of files based on their names. 
	* It describes how a target may depend on a file with a name similar to the target and gives a recipe to create or update such a target.

#### Makefile Overview

The [make utility](https://www.gnu.org/software/make/manual/html_node/Overview.html#Overview) will search in the current directory for a GNUmakefile, makefile, or Makefile files and will run specified or default targets from the [Makefile](https://en.wikipedia.org/wiki/Makefile)

Remember that earlier in the workshop we ran make without a makefile and the reason that worked is that make has some implicit rules that work as defaults unless you override them, therefore you can run make without a makefile

Read this [Stackoverflow Post](https://stackoverflow.com/questions/15745241/using-the-make-command-without-makefiles) on running make without makefile for more details on this

A **makefile** consists of a set of rules

A rule begins with a textual dependency line which defines a target followed by a colon (:) and optionally an enumeration of components (files or other targets) on which the target depends.

```makefile
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

```makefile
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

```makefile
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

```makefile
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

```makefile
MY_NAME = "Jean-Marcel"

print_my_name:
	@echo $(MY_NAME)
```

Notice here that we defined a **macro** named MY_NAME and used command prefix `@` to suppress output of `echo` command execution

```bash
cd scripts/build-automation/example5; make
```

You can see the output of the above makefile by running the snippet above

```makefile
MY_NAME = "Jean-Marcel"

print_my_name:
	@echo ${MY_NAME}
```


Here we get the same output but used `${}` instead of `$()` to expand the makefile **MACRO**

Macros can be composed of shell commands by using the command substitution operator, denoted by backticks (\`).

Here is another example of shell commands:

```makefile
SOME_DATE = `date "+DATE: %Y-%m-%d%nTIME: %H:%M:%S"`

print_date_in_past:
	@echo ${SOME_DATE}
```

In this example we can't use `$()` but need to use the \` \` instead

MACROS can be overriden in the commandline by doing the following:

`make MACRO="value" [MACRO="value" ...] TARGET [TARGET ...]`

```makefile
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

```makefile
print_my_environment_variable:
	@echo $$MY_VAR
```

Notice here that we had to access the environment variable with `$$` syntax.

The reason being is that each line of a makefile is parsed first using the makefile syntax, and then the result is passed to the shell so you have to wrap it in 2 `$` signs

```bash
cd scripts/build-automation/example10; export MY_VAR="SOME VALUE"; make
```

When we run the following snippet from above we get the output **SOME VALUE** to stdout

#### Default command

```makefile
SOME_VAR := "Hello there"

# Default target since it comes first
all:
	@echo $(SOME_VAR)


# This target can be run with `make list`
list:
	@cd test; \
	ls
```

Notice here that we created a comment with `#` and that a default argument of `all` is created simply because it came first in the makefile

```bash
cd scripts/build-automation/example11; make
```

This will print out **Hello there**

```bash
make list
```

This will `cd` into test directory and print out contents

#### Makefile Tasks

```makefile
# Makefile with specific designed tasks

all: program1 program2 program3

program1: program1.js
					node program1.js

program2: program2.js
					node program2.js

program3: program3.js
					node program3.js
```

Notice here that we have specified 3 makefile tasks

The `all` task runs program1, program2, and program3 tasks respectively

The `all` task is the default task because it comes first in the **Makefile**

In the program1 task here is the breakdown:

* `program1.js` is given as a dependency
* The command `node program1.js` is run

For each of the tasks given to the default task of `all` this occurs

```bash
cd ./scripts/build-automation/makefile-tasks; make
```

Notice that output of the 3 different program files when you run the command above.

#### Including Other Makefiles

The include directive tells make to suspend reading the current makefile and read one or more other makefiles before continuing. 

The directive is a line in the makefile that looks like this:

`include somefile.mk`

```makefile
# Makefile with include directive

all: program1 program2 program3 program4

program1: program1.js
					node program1.js

program2: program2.js
					node program2.js

program3: program3.js
					node program3.js

include someprogram.mk
```

Notice the `include` directive in this makefile.

We also added program4 target to tasks in `all` target

#### Running make with different named file

The makefile can be given a different name than the 3 files:

1. GNUmakefile
2. makefile
3. Makefile

By using the commandline options: `-f`, `--file=file`, or `--makefile=FILE`

Contents of *Node_Build_Script*

```makefile
# Another named makefile
program2: program2.js
					node program2.js
```

To run this file you can do the following:

1. `make -f Node_Build_Script`
2. `make --file=Node_Build_Script`
3. `make --makefile=Node_Build_Script`

#### Automatic variables and Wildcards

[Automatic Variables](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

| Automatic Variable | Computed Value |
| --- | --- |
| $@ | The file name of the target of the rule. If the target is an archive member, then ‘$@’ is the name of the archive file. In a pattern rule that has multiple targets (see Introduction to Pattern Rules), '$@' is the name of whichever target caused the rule’s recipe to be run. |
| $% | The target member name, when the target is an archive member. See Archives. For example, if the target is foo.a(bar.o) then '$%' is bar.o and '$@' is foo.a. '$%' is empty when the target is not an archive member. |
| $< | The name of the first prerequisite. If the target got its recipe from an implicit rule, this will be the first prerequisite added by the implicit rule (see Implicit Rules). |
| $? | he names of all the prerequisites that are newer than the target, with spaces between them. For prerequisites which are archive members, only the named member is used |
| $^ | The names of all the prerequisites, with spaces between them. For prerequisites which are archive members, only the named member is used (see Archives). A target has only one prerequisite on each other file it depends on, no matter how many times each file is listed as a prerequisite. So if you list a prerequisite more than once for a target, the value of $^ contains just one copy of the name. This list does not contain any of the order-only prerequisites; for those see the ‘$|’ variable, below. |
| $+ | This is like ‘$^’, but prerequisites listed more than once are duplicated in the order they were listed in the makefile. This is primarily useful for use in linking commands where it is meaningful to repeat library file names in a particular order. |
| $\| |  The names of all the order-only prerequisites, with spaces between them. |
| $* | The stem with which an implicit rule matches (see How Patterns Match). If the target is dir/a.foo.b and the target pattern is a.%.b then the stem is dir/foo. The stem is useful for constructing names of related files. In a static pattern rule, the stem is part of the file name that matched the ‘%’ in the target pattern. |

Some people refer to these automatic variables as wildcards in makefile

Let us look at a makefile for a golang project

```makefile
# Variables
BUILD_DIR := build
BUILD_MANIFEST := wildcard
BUILD_OUT := -o ${BUILD_DIR}/wildcard

# Targets
all: package files homedirectory

package: 	compile
					tar -czf ${BUILD_DIR}/wildcard.tar.gz -C ${BUILD_DIR} ${BUILD_MANIFEST}

compile: 	wildcard.go
					mkdir -p ${BUILD_DIR}
					rm -rf ${BUILD_DIR}/*
					go build ${BUILD_OUT}/wildcard

files: 	*.go
				echo $?

homedirectory: ~
				echo $?

test:	
					go test ./...

clean:
					rm -rf ${BUILD_DIR}
```

Notice here that we have several targets and variables for this makefile.

We also used a couple of targets with wildcard operators `*`, and `~`

Notice that `*.go` printed out all the go source files in current directory

Also notice that the `~` printed out current directory

```bash
cd ./scripts/build-automation/wildcards; make
```

This will run the default target of all and its tasks

```bash
cd ./scripts/build-automation/wildcards; make test
```

This will run the go tests using the `test` target

```bash
cd ./scripts/build-automation/wildcards; make clean
```

The `clean` target will run remove the build directory

Here we will look at another makefile that examines some more automatic variables

```makefile
goFiles := $(wildcard *.go)

showAutomaticVariables: automatic

automatic: 	${goFiles}
						echo $@
						echo $<
						echo $?
						echo $^

clean:
	rm ${goFiles}			
```

Here we have a variable and several targets

To get this started run the following:

```bash
cd ./scripts/build-automation/makefile-automatic-variables; touch one.go second.go; touch third.go; make
```

You will see the following output:

```bash
echo automatic
automatic
echo one.go
one.go
echo one.go second.go third.go
one.go second.go third.go
echo one.go second.go third.go
one.go second.go third.go
```

Here is the breakdown:

* `echo $@` => prints out default target of automatic
* `echo $<` => prints out first filed created of `one.go`
* `echo $?` => prints outs all the prerequisites newer than the target which in this case is all the files
* `echo $^` => prints out all the prerequisites

You can read about more [Automatic Variables Here](https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

###### Wildcard functions and other make functions

The make utility has a [WildCard Function](https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html)
 as well as more [functions](https://www.gnu.org/software/make/manual/html_node/Functions.html)

 ```makefile
src := $(wildcard *.c)

all: compile

compile: 	${src}
					gcc ${src} -o printStuff
					./printStuff
 ```

 Here I am using the wildcard function and notice that is wrapped in `$()` and we call the wildcard function which finds all the c source files in the current directory.

 Then the default target of all call compile target which compiles source file into a binary executable called printStuff

 Lastly **printStuff** binary is invoked and some statements are printed to stdout

 ```bash
cd ./scripts/build-automation/makefile-wildcard-function; make
 ```

You can run the makefile by executing the command above in your terminal

#### Phony Targets

Suppose you have the following makefile:

```makefile
all: compile

compile: 	one.o two.o three.o
					gcc one.o two.o three.o

one.o : 	one.c
					gcc -c one.c

two.o : 	two.c
					gcc -c two.c

three.o : three.c
					gcc -c three.c

clean:
					rm *.o
```

Here we have a list of targets that have object files as dependencies and then has a clean target that removes all of the object files

```bash
cd ./scripts/build-automation/phony-target-issue; make; make clean
```

This works fine but suppose you do the following now:

```bash
touch clean
```

Now rerun `make clean` and look at the output:

**make: `clean' is up to date.**

Notice that no matter what it reports clean is up to date 

This is because you created a target file of clean and the make utility believes there is nothing left to do.

This is where the concept of the PHONY target comes into place

Let us look at this makefile now:

```makefile
all: compile

compile: 	one.o two.o three.o
					gcc one.o two.o three.o

one.o : 	one.c
					gcc -c one.c

two.o : 	two.c
					gcc -c two.c

three.o : three.c
					gcc -c three.c

.PHONY: clean

clean:
					rm *.o
```

Notice now that we can run `make clean` and it works, it is because of the .PHONY target we just created which helps fix the issue of an existing file called the same name as the target

Let us now look at the previous makefile that had several targets specified:

```makefile
# Variables
BUILD_DIR := build
BUILD_MANIFEST := wildcard
BUILD_OUT := -o ${BUILD_DIR}/wildcard

# Targets
all: package files homedirectory

package: 	compile
					tar -czf ${BUILD_DIR}/wildcard.tar.gz -C ${BUILD_DIR} ${BUILD_MANIFEST}

compile: 	wildcard.go
					mkdir -p ${BUILD_DIR}
					rm -rf ${BUILD_DIR}/*
					go build ${BUILD_OUT}/wildcard

files: 	*.go
				echo $?

homedirectory: ~
				echo $?

test:	
					go test ./...

.PHONY: clean

clean:
					rm -rf ${BUILD_DIR}
```

Here we created a .PHONY target for the clean task because clean should not be associated with a file

#### Commands

Makefile commands help update targets

Remember that commands begin with a tab and follow the shell syntax

**Target : Prerequisite ; Command**

or in this format

```makefile
target: Prerequisites
TAB Command
TAB Command
....
```

The backslash character (`\`) is used to continue a command

```makefile
all: print

print: 
				@echo What is this \
stuff about
```

This is a trivial example but illustrates what the `\` is used for

```bash
cd ./scripts/build-automation/makefile-backslash-command; make
```

Run the command above to see the output

#### Make Options

Let us look at the following makefile:

```makefile
all: print

print: 
		echo one
		echo two
		echo three
```

If we run make like this `make -n` it will merely print the command but won't execute them

**Read the Fine Manual for more options with the make utility**

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Remote File Sharing and File Access](./remote-file-sharing-and-file-access.md) | [Building Command line applications](./building-command-line-applications.md) →
