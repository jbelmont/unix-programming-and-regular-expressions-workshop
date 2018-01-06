## Unix Programming and Regular Expressions Workshop - Text Substitution

## Sections:

* [What is Sed](#what-is-sed)
* [Commandline Options to Sed](#commandline-options-to-sed)
* [Basic Sed Usage](#basic-sed-usage)
* [Sed command structure](#sed-command-structure)
* [Substitute command structure](#substitute-command-structure)
* [Substitute and Replacement text](#substitute-and-replacement-text)
* [Substitute Flags](#substitute-flags)
* [Sed Examples](#sed-examples)
* [Best Practices for Sed](#best-practices-for-sed)
* [Exercises](#exercises)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### What is Sed

[Sed](https://en.wikipedia.org/wiki/Sed) (stream editor) is a Unix utility that parses and transforms text, using a simple, compact programming language.

Sed was developed by [Lee McMahon](https://en.wikipedia.org/wiki/Lee_E._McMahon) in 1974.

Sed was the one of the first tools that supported regular expressions

The sed utility reads the specified files, or the standard input if no files are specified, modifying the input as specified by a list of commands.  

The input is then written to the standard output.

* Sed can get input from command line files and/or standard input

* Sed can use editing command from the command line and/or script

* Sed outputs to standard output but original input files are changed

* You can edit a file in place if you use `-i` option which will create a backup file and then edit file in place

#### Commandline Options to Sed

The following options are available:

* `-E` Interpret regular expressions as extended (modern) regular expressions rather than basic regular expressions (BRE's).
  * `-r` can be used in gnu sed

* `-a` The files listed as parameters for the `w` functions are created (or truncated) before any processing begins, by default.  
  * The * -a option causes sed to delay opening each file until a command containing the related ``w'' function is applied to a line of input.

* -e command
  * Append the editing commands specified by the command argument to the list of commands.

* -f command_file
  * Append the editing commands found in the file command_file to the list of commands.  
  * The editing commands should each be listed on a separate line.

* -i extension
  * Edit files in* -place, saving backups with the specified extension.  
  * If a zero* -length extension is given, no backup will be saved.
  * It is not recommended to give a zero* -length extension when in* -place editing files,  as you risk corruption or partial content in situations where disk space is exhausted, etc.

* -l Make output line buffered.

* -n By default, each line of input is echoed to the standard output after all of the commands have been applied to it.  The * -n option suppresses this behavior.

You can mix `-e` and `-f` options together

If you don't provide options then first command line argument is the script

#### Basic Sed Usage

[Sed Manual](https://www.gnu.org/software/sed/manual/sed.html#Overview)

*sed [-Ealn] [-e command] [-f command_file] [-i extension] [file ...]*

Although `sed` has a large command set be wary of writing unwieldy scripts as they will be hard to read for others

The primary command is `"s"` (substitute) that does text replacements

#### Sed command structure

* <address> <command> [ <operands> [ <flags> ] ]

* `<address>`
  * one or two line numbers and use `$` to mean last line
  * Pattern to match aka basic regular expression

* `<command>`
  * A single letter: `s` and `p` are most useful

* `<operands>`
  * In particular for `s` is the pattern to match and replacement text
  * Other commands can take other operands

* `<flags>`
  * Flags serve as modifiers for `s` command

#### Substitute command structure

**s  /  pattern  / replacement  / [flags]**

The delimiter can be any punctuation character but the `/` is the most common delimiter

* Use `\/` in pattern or replacement for real `/` (forward slash) or another delimiter

* `pattern` is a basic regular expression

* `replacement` is the text to replace the matched input text

* Flags are optional modifiers

#### Substitute and Replacement text

Replacement text can be:

* `Empty` which means the matched text is deleted

* `Plain Text` which means matched text is replaced by contents of plain text

* `&` which means the text matching the pattern
  * `echo you are the man | sed 's/you are the/& goat/g'`
    * Notice in this example the `&` was used as replacement text for the pattern text used

* `\&` means a real `&`

* `\1` through `\9` is for text matched in `\(....\)` in the BRE (basic regular expression)

* `\\` means a real `\` backslash

#### Substitute Flags

* An optional flags will modify the behavior of the `s` command

* The default behavior of substitution is to only replace the first occurrence

Portable flags to use across various flavors of `sed`:

* `g` flag will replace every match on the input line

* `1, 2, 3, 4, 5` or `nth` digit replace the nth occurrence

* `i` will ignore case but only works in `gnu` sed

#### Sed Examples

###### Examples with `s`

```bash
$ grep '2017-08-22' data/aapl.csv | sed 's/,.*//'
```

Notice in this example we use grep to find the date `2017-08-22` and then pipe output to sed and remove everything after the comma

```bash
$ sed 's/Liam/Frank/g' data/top-10-baby-names-2016.txt | sed 's/Charlotte/Katy/g'
```

In this example we use sed to replace the baby name `Liam` with `Frank` and then pipe that as stdin to replace `Charlotte` into `Katy`

```bash
$ sed 's/Liam/Frank/g' data/top-10-baby-names-2016.txt | sed '/Charlotte/d'
```

This example changed Liam to Frank and then deleted the line for Charlotte

```bash
$ sed 's/^/      /g' data/numbers.txt
```

This example prepends 8 spaces to beginning of line in numbers.txt

###### Examples for filtering text

```bash
$ sed -n '/Jacob/p' data/top-10-baby-names-2016.txt > data/jacob.txt
```

This example suppresses all output except matched text and prints it to stdout and then creates file called `jacob.txt`

There is a many more examples of sed usage this is just a sample.

#### Best practices for Sed:

* The longest, left-most matching basic regular expressions is critical for proper sed usage

* Use basic regular expressions over extended regular expressions and only use simple sed commands for portability and readability

* Make sure to use edit commands on the sed command line to make sustainable scripts

* sed is mainly used for text substitutions

* sed is used a lot in scripts with pattern matching and text replacement or deletion of text via substitution

* sed is often used in the middle of shell pipelines to transform data

#### Exercises

Using sed find all the occurrences of *fries* in the 'data/orders.txt' file and replace with French Fries

One Possible Solution:

<details>
  <pre>
    sed 's/Fries/French Fries/g' data/orders.txt
  </pre>
</details>

Using sed delete the first row in the file `data/orders.txt`

One Possible Solution:

<details>
  <pre>
    sed '/^ID/d' data/orders.txt
  </pre>
</details>

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Text Searching](./text-searching.md) | [Filename expansions and globbing](./filename-expansions-and-globbing.md) →
