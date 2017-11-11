## Unix Programming and Regular Expressions Workshop - Command Process Substitution

## Sections:

* [Command Substitution the old way](#command-substitution-the-old-way)
* [Command Substitution the new way](#command-substitution-the-new-way)
* [Command Substitution Examples](#command-substitution-examples)
* [Expr Command Description](#expr-command-description)
* [Expr Command Examples](#expr-command-examples)
* [Process Substitution Description](#process-substitution-description)
* [Process Substitution Syntax](#process-substitution-syntax)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Command Substitution the old way

Command substitution will take the text between \`...\` and run it as a command and then place the results back into the surrounding command

You will need to escape double quotes \\"

Nesting commands is difficult with the old style command substitution

You don't need to quote if you are assigning a variable

#### Command Substitution the new way

You can use `$( ... )` to do command substitution

This has been standardized by POSIX

It is available in both bash and zsh

Advantages of Newer Command Substitution:

* Any matching delimiters will demarcate nested instances
* There is no need to escape nested quotes or delimiters
* It is much easier to read and to maintain then the old styles

#### Command Substitution Examples

```bash
bash ; set -x
```

Turn on execution tracing

```bash
printf "%s marcel\n" `echo hello`
```

Notice that first `echo hello` was executed and was provided as an argument to printf

```bash
myname=`echo Jean-Marcel Belmont`
echo $myname
```

Here we use backticks to do command substitution and then print the variable

```bash
echo first `echo second \`echo third\` fourth` fifth
```

Notice here that we had to escape backticks when there are nested in other backticks

```bash
printf "%s\n" "[`echo PATH is $PATH`]"
```

Here we don't have to escape within double quotes

```bash
echo "hey +`echo man -\`echo \"a quote" here\`- annotate`+ what?"
```

Here we show a very unwield example to illustrate issues with backticks

**Using the New Way**

```bash
printf "%s Marcel\n" $(echo Hello)
```

Here is a simple example

```bash
echo first $(echo second $(echo third) fourth) fifth
```

```bash
echo "hey +$(echo man -$(echo "a quote" here)- annotate)+ what?"
```

Here is the unwieldy example using new style, cleaner right!

#### Expr Command Description

The expr utility evaluates expression and writes the result on standard output.

The **expr** command is mostly used for simple integer arithmetic but can be used for comparisons and Basic Regular Expression matching


The **expr** command was designed to be used inside command substutition

Replace `expr` command with the following:

* You should prefer arithmetic substitution with `$(( ...))`

* `test` `[[]]` command
* sed
* grep
* shell pattern matching

#### Expr Command Examples

```bash
i=0 sum=0
while [ $i -lt 15 ]
do
        echo i is $i
        i=`expr $i + 5`
        anotherSum=$(expr $i + 5)
done
```

Here we assign 2 variables and use while loop and increment i anotherSum

#### Process Substitution Description

[Process Substitution](https://en.wikipedia.org/wiki/Process_substitution)

> In computing, process substitution is a form of inter-process communication that allows the input or output of a command to appear as a file. The command is substituted in-line, where a file name would normally occur, by the command shell. This allows programs that normally only accept files to directly read from or write to another program.

By using **process substitution** you can create *nonlinear* pipelines:

* There can be multiple process streams that can provide input to one command
* One comand can send output to multiple process streams
  * The **tee** command is good for process substitution

#### Process Substitution Syntax

* A `command <(a | b | ...) to be read from a pipeline
  * `diff <(sort file1) <(sort file2)`

* A `command >(d | e | ...)` to write to a pipeline

```bash
tee >(sort | uniq > sorted.dat) \
>(do_something)
> myFile
```

```bash
diff -u <(sort scripts/command-process-substitution/file1) <(sort scripts/command-process-substitution/file2)
```

Here we sort 2 files and pass it to diff command as process substitution

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Input and Output](./input-and-output.md) | [History Substitution](./history-substitution.md) →
