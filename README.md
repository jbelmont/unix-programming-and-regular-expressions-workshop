# Unix Programming and regular expressions workshop

A workshop on Unix Programming Principles using tools such as grep, sed, awk, shell programming and regular expressions

## Sections:

* [Unix History](#unix-history)
* [Unix Software Philosophy](#unix-software-philosophy)
* [Self Contained Shell Scripts](#self-contained-shell-scripts)
* [Basics of Shell Programming](docs/basics-of-shell-programming.md)
* [Introduction to Text Processing](docs/introduction-to-text-processing.md)
* [Text Searching](docs/text-searching.md)
* [Text Substitution](docs/text-substitution.md)
* [Filename expansions and globbing](docs/filename-expansions-and-globbing.md)
* [Working with Fields](docs/working-with-fields.md)
* [Text Sorting](docs/text-sorting.md)
* [Arithmetic Operations and variables](docs/arithmetic-operations-and-variables.md)
* [Decision Making and Exit Status](docs/decision-making-and-exit-status.md)
* [Looping](docs/looping.md)
* [Input and Output](docs/input-and-output.md)
* [Command Process Substitution](docs/command-process-substitution.md)
* [History Substitution](docs/history-substitution.md)
* [Evaluation Order](docs/evaluation-order.md)
* [Subshells](docs/subshells.md)
* [Shell Functions](docs/shell-functions.md)
* [Signal Handling](docs/signal-handling.md)
* [Working with Files](docs/working-with-files.md)
* [Remote File Sharing and File Access](docs/remote-file-sharing-and-file-access.md)
* [Building Command line applications](docs/building-command-line-applications.md)
* [Tasks](#tasks)

## Unix History

* Shell Scripting was developed in the context of the UNIX Operating System from Bell Labs

* Early UNIX systems packed incredible power into very small machines
  * 64 Kb "virtual" address space for the code and for data
  * This was often less than that of physical memory on the early [PDP-11S](https://en.wikipedia.org/wiki/PDP-11)
* Source Code made it easy to experiment and change the system
* AT&T Bell Labs heavily influenced Unix by the likes of [Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson), [Dennis Ritchie](https://en.wikipedia.org/wiki/Dennis_Ritchie), and others

Quote from Dennis Ritchie for Vision of Unix:

> What we wanted to preserve was not just a good environment in which to do programming, but a system around which a fellowship could form. We knew from experience that the essence of communal computing, as supplied by remote-access, time-shared machines, is not just to type programs into a terminal instead of a keypunch, but to encourage close communication.

* Unix Developers were the users of the system and they developed tools to solve their own problems
* Unix Developers were given freedom to experiment and rewrite Unix as needed
* Unix was designed in a quest for elegance

## Unix Software Philosophy

[Software Tools Book](https://www.amazon.com/Software-Tools-Brian-W-Kernighan/dp/020103669X) and [Software Tools in Pascal](https://www.amazon.com/Software-Tools-Pascal-Brian-Kernighan/dp/0201103427/ref=pd_lpo_sbs_14_img_0?_encoding=UTF8&psc=1&refRID=2HVC5MB1PKHC4YCETHP9&dpID=41eyH0p9aiL&preST=_SY291_BO1,204,203,200_QL40_&dpSrc=detail)

* Programs should be like specialized tools in a carpenter's toolbox
  * Avoid `create programs to rule them all`
  * Don't create programs that are like a Swiss Army Knife... meaning they do too much
    * One simple example would be sorting... either you can do one of the two following things:
      * Write a bunch of programs to do various tasks, each of which has an option to sort its output
      * Choose a common representation for your system (e.g. streams of ASCII text), create a mechanism for composing pieces of the system (Unix pipes), and only write the sorting functionality once
    * A less simple example would be the [LLVM compiler](http://www.aosabook.org/en/llvm.html) (and compilers in general), which uses an intermediate representation (IR) that is understood and operated on by all pieces of the system as the compiler does all the passes required to generate its target (e.g. lexing, parsing, optimization, code generation, etc.)
    * In general, choosing a common representation for a system will turn the problem of interfacing the various pieces from an m*n problem into an m+n problem (where m is the number of different outputs in the first stage, n is number of inputs that are received in the second stage)
  * Tools can be combined using pipelines and the shell to get your work done
    * One famous example is Doug McIlroy's word count program, compared to Donald Knuth's, as described [here](http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/) and elsewhere
  * This philosophy became popular in [Kernighan & Plauger Books](https://www.amazon.com/Software-Tools-Brian-W-Kernighan/dp/020103669X)
    * Some example presentations that discuss the Unix philosophy include:
      * [Unix Pipeline (Brian Kernighan) - Computerphile](https://www.youtube.com/watch?v=bKzonnwoR2I), which discusses the concept of the Unix pipe
      * [Bringing the Unix Philosophy to Big Data by Bryan Cantrill](https://www.youtube.com/watch?v=S0mviKhVmBI), which discusses the Unix philosophy in relation to big data
      * [Pycon UK 2016: Python and the Glories of the UNIX Tradition by Brandon Rhodes](https://www.youtube.com/watch?v=zFMdhXYlFfY), which discusses the Unix philosophy in relation to Python

  #### Do One thing Well

  Programs are easier to:

  1. Write and to correct

  2. Document

  3. Understand and use

  The `cat` command originally only concatenated files

  The `cp` command copies files

  The `mv` command moves and renames files

#### Process Lines of Text

Using Text as the main data format has advantages:

* Text is easy to process with existing and new tools

* Text can be edited with any text editor

* Text is portable across networks and machine architectures

For example to list some popular baby names and sort them:

```bash
cat data/top-10-baby-names-2016.txt | awk '{print $2 }' | sort
```

#### Use Regular Expressions

* Regular Expressions provide powerful text matching and substitution

2 Flavors of regular expressions standardized by [POSIX](https://en.wikipedia.org/wiki/POSIX)

1. Basic Regular Expressions (BREs)
  1. grep, sed, ...
2. Extended Regular Expressions (EREs)
  1. egrep, awk, ...

#### Default to Standard Input/Output

Use Standard Input/Output (I/O) when there is no files on the command line:

* Helps simplify writing programs
* Helps you hook programs together with pipelines
* Helps encourage programs to do one thing well

#### Don't Be Chatty

* Status messages that are mixed with standard output confuse programs downstream
* If you ask then you get it. Don't prompt with 'Are you sure'
* Do know what you are doing:
  * `rm -rf /` Before running a command like this
  * This will delete everything starting from the root directory
* We have version control systems such as `Git` use them

#### Make sure to use the input format for output

* If your text is structured then after processing
  * Write the same format for standard output in the same format of standard input
  * Doing this affords you to build specialized tools that work together

#### Write specialized tools if they do not exist

* At times a tool does not exist, that is when you need to write the tool
  * Can the tool be useful to other people?
  * Can the tool be generalized?

If any of the answers to these questions are yes:
  * then write a general purpose tool

* Scripting languages can often be used to write a software tool:
  * Awk
  * Perl
  * Python
  * Ruby
  * Shell

* You can also use other languages like for example `Golang` as we will see

#### Software Tools Summary

* Using the `software tools` approach helps provide a framework and a mindset for programming and scripting
* You can combine software tools to solve software programs
  * This strategy in turn gives you flexibility and helps promote innovation
* Know your tools and thinking in the `Software Tools` Philosophy will improve your scripting

## Self Contained Shell Scripts

[Executable Definition](https://en.wikipedia.org/wiki/Executable)

> In computing, executable code or an executable file or executable program, sometimes simply referred to as an executable or binary, causes a computer "to perform indicated tasks according to encoded instructions,"[1] as opposed to a data file that must be parsed by a program to be meaningful.

Typically a high level language is used that compiles to executable machine code files

* Executable scripts typicall start with a `Shebang` => `#! /bin/bash` or the like
  * An optional argument can be provided
  * Some Unix systems have small limits on the path name length

Shell Scripts can be simple executable text files that contain shell commands.

* Keep in mind that this only works if the shell script is in the same language as the interactive shell
  * For example to expect a zsh shell script to run in a bash environment

## Tasks

Sections to Finish:

- [ ] Evaluation Order
- [ ] Signal Handling
- [ ] Working with Files
- [ ] Remote File Sharing and and File Access
- [ ] Building Command Line Applications

Sections to Add:

- [ ] Using Makefile
- [ ] Shell Login order
