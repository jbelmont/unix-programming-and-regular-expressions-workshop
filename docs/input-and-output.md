## Unix Programming and Regular Expressions Workshop - Input and Output

## Sections:

* [Redirections](#redirections)
* [Read Command Description](#read-command-description)
* [Moving Descriptors](#moving-descriptors)
* [Read Command Options](#read-command-options)
* [Read Command Usage](#read-command-usage)
* [Read Command Examples](#read-command-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Redirections

**Quick Review of Redirection Operators we have seen so far in the workshop.**

Opening files in Unix is manipulated using integer file descriptors:

* 0 corresponds to standard input (stdin)
* 1 corresponds to standard output (stdout)
* 2 corresponds to standard error (stderr)

| File Handle | Name | Description |
| --- | --- | --- |
| 0 | stdin | Standard Input |
| 1 | stdout | Standard Output |
| 2 | stderr | Standard Error |

Here are the following redirection operators:

* `<` redirect input
* `>` redirect output
* `>>` append instead of truncate
* `|` will pipe stdout of an action as stdin for the corresponding pipeline
* `<<`, `<<-` corresponds to Here Documents
* `>&2` will redirect output to standard error (stderr)
* `do an action 2>&1 | tee myoutput`

New Redirection Operators:

* `set -o | grep noclobber`
* `set -o noclobber` this works in bash and zsh
  * `>` will not truncate a file instead will throw an error
* `>|` this redirection will override noclobber option
* `<>` will open a file for reading and writing
  * `somecommand <> somefile`

### Moving Descriptors

You can use *exec* with shell redirections and no arguments to manage your shell's file descriptors

Any open files are inherited by child programs

```bash
exec myaction >& anotherAction
```

This copies output of myAction into anotherAction

```bash
exec someAction >& -
```

This closes the file descriptor

You need to move file descriptors by copying them and then closing them

Using *exec* with arguments has different behavior:

* Exec will retain the same process ID number
* The arguments will be passed into a new program
* Any open file descriptors will remain open

Run the script *capture.sh*

```bash
./scripts/input-and-output/capture.sh > something
```

This will redirect stdout to a file and the `exec` command will redirect error to myerr files

```bash
echo some file > text
```

Create a file called text

```bash
set -C
```

enable noclobber option

```bash
echo another thing > text
```

The shell will now throw error and not perform truncation

```bash
echo another thing >| text
```

Now this command will work because of `>|` operator which will forcibly truncate

#### Read Command Description

`read: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]`

* Read a line from the standard input and split it into fields.

* Reads a single line from the standard input, or from file descriptor FD if the -u option is supplied.

* The line is split into fields as with word splitting, and the first word is assigned to the first NAME, the second word to the second NAME, and so on, with any leftover words assigned to the last NAME.

* Only the characters found in $IFS are recognized as word delimiters.

The Read Command does the following:

* Changes the field separator
* Reads a loop
* Reads exactly one line
* The *read* command has bash extensions

The *read* command can read one line of text and split into words, assign to variables

* *IFS* can control word splitting
* Exit status of 1 upon end of file

If there are any remaining words they are assigned to the last variable and you can use one variable to get a whole line

The **Read** command is often run in a subshell if you use a pipeline or a loop

Also the variables defined in a loop won't be available outside the loop body

#### Read Command Options

*Read* Command Options (Bash):

* `-a` array	assign the words read to sequential indices of the array variable ARRAY, starting at zero

* `-d` delim	continue until the first character of DELIM is read, rather than newline

* `-e`use Readline to obtain the line in an interactive shell

* `-i` text	use TEXT as the initial text for Readline

* `-n` nchars	return after reading NCHARS characters rather than waiting for a newline, but honor a delimiter if fewer than NCHARS characters are read before the delimiter

* `-N` nchars	return only after reading exactly NCHARS characters, unless EOF is encountered or read times out, ignoring any delimiter

* `-p` prompt	output the string PROMPT without a trailing newline before attempting to read

* `-r`	do not allow backslashes to escape any characters

* `-s`	do not echo input coming from a terminal
-t timeout	time out and return failure if a complete line of input is not read within TIMEOUT seconds.  
  * The value of the TMOUT variable is the default timeout.  
  * TIMEOUT may be avfractional number. 
  * If TIMEOUT is 0, read returns immediately, without trying to read any data, returning
  success only if input is available on the specified file descriptor.  
  * The exit status is greater than 128 if the timeout is exceeded

* `-u` fd	read from file descriptor FD instead of the standard input

#### Read Command Usage

[IFS Docs](https://en.wikipedia.org/wiki/Internal_field_separator)

You can set `IFS=' ... '` to read var1, var2, ... to change field separators while the read command is executing

The **read** command can be piped into a loop

```bash
some_processing |
  while read somevar1 somevar2 
  do
    some loop body
  done
```

The **read** command can also be used with input redirection 

```bash
while read somevar1 somevar2
do
  some loop body
done < someFile
```

It is necessary to put the redirection after done

The **read** command will continue reading input if you use the `\` 

If you use the `-r` option though the **read** command will only read one line

#### Read Command Examples

```bash
printf "Enter your name: " ; read name
```

Here the `;` is necessary to get read input

```bash
echo "Your name is $name"
```

```bash
printf "Enter your first_name and last_name: " ; read firstName lastName
```

```bash
echo $firstName $lastName
```

```bash
read sentence
```

Use the `\` to make multiple lines else when you hit enter after your first line the input is complete

```bash
echo $sentence
```

```bash
FOODS="pizz cookies bread shrimp"
echo $FOODS | sed 's;pizz;pizza;' | while read foods
do
echo $foods
done
```

This is a contrived example showing how you can use pipe with while loop and use that to pipe into read

```bash
echo $?
```

The exit status of 0 means success

```bash
bash
```

Enter a bash subshell if in zsh

```bash
read -p "Enter your name: " -t 4 name
```

This will prompt for you to enter your name and timeout after 4 seconds if you haven't entered anything

If you check the exit status it is greater than *128* upon a timeout

```bash
echo $?
```

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Looping](./looping.md) | [Command Process Substitution](./command-process-substitution.md) →
