## Unix Programming and Regular Expressions Workshop - Introduction to Text Processing

## Sections:

* [Counting lines, words, and characters](#counting-lines\,-words\,-and-characters)
* [Transforming Text](#transforming-text)
* [Tabs vs Spaces](#tabs-vs-spaces)
* [Text extraction](#text-extraction)
* [Comparing Sorted Files](#comparing-sorted-files)
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

content

#### Tabs vs Spaces

content

#### Text extraction

content

#### Comparing Sorted Files

content

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Basics of Shell Programming](./basics-of-shell-programming.md) | [Text Searching](./text-searching.md) →
