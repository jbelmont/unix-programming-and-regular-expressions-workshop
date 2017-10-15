## Unix Programming and Regular Expressions Workshop - Working with Fields

## Sections:

* [Cut description](#cut-description)
* [Cut options](#cut-options)
* [Cut examples](#cut-examples)
* [Join description](#join-description)
* [Join options](#join-options)
* [Join examples](#join-examples)
* [Basics of Awk Programming](#basics-of-awk-programming)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Cut description

Cut is used to "cut out" fields from data files

The cut utility cuts out selected portions of each line (as specified by list) from each file and writes them to the standard output.  

* If no file arguments are specified, or a file argument is a single dash (`-'), cut reads from the standard input.  

* The items specified by list can be in terms of column position or in terms of fields delimited by a special character.  

* Column numbering starts from 1.

The default for `cut` is field based with `TAB` as a field separator using the `-f` option.

#### Cut options

`cut` takes the following options:

* `-b` list
  * The list specifies byte positions.

* `-c` list
  * The list specifies character positions.

* `-d` delim
  * Use delim as the field delimiter character instead of the tab character.

* `-f` list
  * The list specifies fields, separated in the input by the field delimiter character (see the -d option.)  
  * Output fields are separated by a single occurrence of the field delimiter character.

* `-n` Do not split multi-byte characters.          
  * Characters will only be output if at least one byte is selected, and, after a prefix of zero or more unselected bytes, the rest of the bytes that form the character are selected.

* `-s` Suppress lines with no field delimiter characters.  
  * Unless specified, lines with no delimiters are passed through unmodified.

#### Cut examples

```bash
$ echo 'one,two,three,four,five' | cut -d ',' -f 1,5
```

This cut example cuts field `1` and field `5` so it prints out `one,five`

```bash
$ cut -d : -f 1,7 /etc/passwd | sed '/\#.*/d' | sort -u
```

This cut example first cuts field `1` and field `7` then this is piped into sed to delete the initial comment lines and then sort the values and only print unique values

#### Join description

> join -- relational database operator

* The join utility performs an `equality join` on the specified files and writes the result to the standard output.  

* The `join field` is the field in each file by which the files are compared.  

* The first field in each line is used by default.  

* There is one line in the output for each pair of lines in file1 and file2 which have identical join fields.  

* Each output line consists of the join field, the remaining fields from file1 and then the remaining fields from file2

`join` is used for these reasons:

* You have 2 files that associate data with corresponding keys.

* You have 2 files that have different data in each file.

* You have 2 files that need to combine the related data in an output record.
  * Both of these files need to be sorted on the key `(field)` of interest

Remember that `joins` occur on a line-by-line basis

A missing key in one file will skip the corresponding line in the other file.

#### Join options

The following options are available for `join`:

* `-a` file_number
  * In addition to the default output, produce a line for each unpairable line in file file_number.

* `-e` string
  * Replace empty output fields with string.

* `-o` list
  * The -o option specifies the fields that will be output from each file for each line with matching join fields.  
  * Each element of list has the either the form `file_number.field`, where file_number is a file number and field is a field number, or the form `0' (zero), representing the join field. 
  * The elements of list must be either comma (`,') or whitespace separated.

* `-t` char
  * Use character char as a field delimiter for both input and output.  
  * Every occurrence of char in a line is significant.

* `-v` file_number
  * Do not display the default output, but display a line for each unpairable line in file file_number.  
  * The options -v 1 and -v 2 may be specified at the same time.

* `-1` field
  * Join on the field'th field of file 1.

* `-2` field
  * Join on the field'th field of file 2.

#### Join examples

content

#### Basics of Awk Programming

content

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Filename expansions and globbing](./filename-expansions-and-globbing.md) | [Text Sorting](./text-sorting.md) →


