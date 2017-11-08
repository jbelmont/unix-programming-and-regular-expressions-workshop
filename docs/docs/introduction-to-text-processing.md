## Unix Programming and Regular Expressions Workshop - Introduction to Text Processing

## Sections:

* [Counting lines, words, and characters](#counting-lines\,-words\,-and-characters)
* [Transforming Text](#transforming-text)
* [Tabs vs Spaces](#tabs-vs-spaces)
* [Text extraction](#text-extraction)
* [Comparing Sorted Files](#comparing-sorted-files)
* [Script using tr, sort, and comm](#script-using-tr\,-sort\,-and-comm)
* [Best Practices](#best-practices)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Counting lines, words, and characters

* `wc` command, short for `word count`
* The wc utility displays the number of lines, words, and bytes contained in each input file
  * or standard input (if no file is specified) to the standard output.
  * A line is defined as a string of characters delimited by a <newline> character.
  * Characters beyond the final <newline> character will not be included in the line count.
* Output order: count of lines, words, characters, or bytes
  * Default count is lines, words, bytes
  * Characters can be multibyte encoded

`wc` takes the following output:

* -c The number of bytes in each input file is written to the standard output.  This will cancel out any prior usage of the -m option.
* -l The number of lines in each input file is written to the standard output.
* -m The number of characters in each input file is written to the standard output.
  * If the current locale does not support multibyte characters, this is equivalent to the -c option.
  * This will cancel out any prior usage of the -c option.
* -w The number of words in each input file is written to the standard output.

#### Transforming Text

* `tr` command, short for `translate characters`
* The tr utility copies the standard input to the standard output with substitution or deletion of selected characters
* The `tr` command transforms text
* The following options are available for `tr`:
  * -C Complement the set of characters in string1, that is ``-C ab'' includes every character except for `a' and `b'.
  * -c Same as -C but complement the set of values in string1.
  * -d Delete characters in string1 from the input.
  * -s Squeeze multiple occurrences of the characters listed in the last operand (either string1 or string2) in the input into a single instance of the character.
    * This occurs after all deletion and translation is completed.
  * -u Guarantee that any output is unbuffered.

Typical usage for `tr` is to map one set of values into another:

* tr a-z A-Z is old style
* tr [:lower:] [:upper:] is POSIX style

[:class:] Represents all characters belonging to the defined character class.

Class names are:

* alnum        <alphanumeric characters>
* alpha        <alphabetic characters>
* blank        <whitespace characters>
* cntrl        <control characters>
* digit        <numeric characters>
* graph        <graphic characters>
* ideogram     <ideographic characters>
* lower        <lower-case alphabetic characters>
* phonogram    <phonographic characters>
* print        <printable characters>
* punct        <punctuation characters>
* rune         <valid characters>
* space        <space characters>
* special      <special characters>
* upper        <upper-case characters>
* xdigit       <hexadecimal characters>

#### Tabs vs Spaces

* expand command converts tabs to spaces
* The expand utility processes the named files or the standard input writing the standard output with tabs changed into blanks.
* Backspace characters are preserved into the output and decrement the column count for tab calculations.
* The expand utility is useful for pre-processing character files (before sorting, looking at specific columns, etc.) that contain tabs.
* unexpand command converts spaces to tabs
* The unexpand utility puts tabs back into the data from the standard input or the named files and writes the result on the standard output.

The following options are available for both `expand` and `unexpand`:
  * -a (unexpand only.)
    * By default, only leading blanks and tabs are reconverted to maximal strings of tabs.
    * If the -a option is given, then tabs are inserted whenever they would compress the resultant file by replacing two or more characters.
    * -t tab1,tab2,...,tabn
      * Set tab stops at column positions tab1, tab2, ..., tabn.
      * If only a single number is given, tab stops are set that number of column positions apart instead of the default number of 8.

```bash
od -c
one two three   4 five  six
0000000    o   n   e       t   w   o       t   h   r   e   e  \t   4
0000020    f   i   v   e  \t   s   i   x  \n
0000031
```

* The od utility is a filter which displays the specified files, or standard input if no files are specified, in a user specified format.
* od -- octal, decimal, hex, ASCII dump

Here we see the white space characters given, namely `space`, `\t`, and `\n`

```bash
printf "a\tb\tc\n" | expand -8 | unexpand -a | od -c
0000000    a  \t   b  \t   c  \n
0000006
```

Here we expand and unexpand meaning we expand tabs to spaces and then back to tabs again

```bash
$ printf '     a     b     c\n' | gexpand -4 | gunexpand -a -4 | od -c
0000000   \t       a  \t               b  \t       c  \n
0000014
$ printf '     a     b     c\n' | gexpand -4 | gunexpand -4 | od -c
0000000   \t       a                       b                       c  \n
0000020
$ printf '     a     b     c\n' | expand -4 | unexpand -a -4 | od -c
unexpand: illegal option -- 4
usage: unexpand [-a | -t tablist] [file ...]
```

Notice here the difference between `gnu` expand/unexpand and `bsd` expand/unexpand (Mac)

```bash
printf '     a     b     c\n' | expand -t 4 | unexpand -a -t 4 | od -c
0000000   \t       a  \t               b  \t       c  \n
0000014
```

Here when I use `BSD` expand/unexpand I had to explicitly set `-t` flag


#### Text extraction

* `tail` command prints `N` lines (10 by default)
* The tail utility displays the contents of file or, by default, its standard input, to the standard output.

The options for `tail` are as follows:
  * -b number The location is number 512-byte blocks.
  * -c number The location is number bytes.
  * -f The -f option causes tail to not stop when end of file is reached, but rather to wait for additional data to be appended to the input.
    * The -f option is ignored if the standard input is a pipe, but not if it is a FIFO.
  * -F The -F option implies the -f option, but tail will also check to see if the file being followed has been renamed or rotated.
    * The file is closed and reopened when tail detects that the filename being read from has a new inode number.
    * The -F option is ignored if reading from standard input rather than a file.
    * -n number The location is number lines.
    * -q Suppresses printing of headers when multiple files are being examined.
    * -r The -r option causes the input to be displayed in reverse order, by line.

`Read the Fine Manual` for more options

#### Comparing Sorted Files

* `comm` command compares two sorted files
* The comm utility reads file1 and file2, which should be sorted lexically, and produces three text columns as output: lines only in file1; lines only in file2; and lines in both files
* The filename `-` means the standard input (stdin)

The following options for `comm` are available:
  * -1    Suppress printing of column 1.
  * -2    Suppress printing of column 2.
  * -3    Suppress printing of column 3.
  * -i    Case insensitive comparison of lines.

#### Script using tr, sort, and comm

```bash
./scripts/introduction-to-text-processing/spell_checking.sh

cont
dat
spele
sumetimes
```

Notice this script printed out the misspelled words from the text file into the screen

```bash
./scripts/introduction-to-text-processing/spell_checking_success.sh

```

Notice no words were printed out

Step by step execution of the script:

1. `tr '[:space:][:punct:]' '\n' < ./data/spelling_success.txt`
  1. tr transforms spaces and punctuation characters to a new line
2. `tr '[:upper:]' '[:lower:]'` via pipeline tr transforms any Uppercase characters to lowercase
3. `sort -u` via another pipeline we sort the text and show only unique entries
4. `comm -23 - /usr/share/dict/words` via the last pipeline we pass into the `comm` command the standard input and compare it to entries in `/usr/share/dict/words`
  1. Remember that the comm file needs to have input sorted and column 1 is content only in 1
  2. The second column is content only in file 2
  3. The third column is content only in both
  4. We only want the content from standard input or column 1

#### Best Practices

* Use POSIX options instead for portability
* Utilities that work with character sets (tr) and with sorted files (comm) are sensitive to current locale
  * Character sets can vary wildly in different locales
  * Similarly files sort differently in different locales

* If you use `export LC_ALL=C` you will get a traditional Unix environment
* To be safe re-sort files in the current locale if the files were sorted in a different locale
* Try to utilize the power of sorting and regular expressions
* Use `tr` for letter case transformations and to break lines into one word per line

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Basics of Shell Programming](./basics-of-shell-programming.md) | [Text Searching](./text-searching.md) →
