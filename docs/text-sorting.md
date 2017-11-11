## Unix Programming and Regular Expressions Workshop - Text Sorting

## Sections:

* [Sort description](#sort-description)
* [Sort by line](#sort-by-line)
* [Sort by field](#sort-by-field)
* [Sort Field Specifications](#sort-field-specifications)
* [Sort options](#sort-options)
* [Sort examples](#sort-examples)
* [Sort best practices](#sort-best-practices)
* [Uniq description](#uniq-description)
* [Uniq options](#uniq-options)
* [Uniq examples](#uniq-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Sort description

sort - sort lines of text files

`sort` writes sorted concatenation of all FILE(s) to standard output.

The process of sorting will gather related data for further processing in a pipeline

Some uses for sorting:

* To count the number of occurrences of some data
* To remove duplicates of data
* To process related items together

**Sorting can be thought of as a key operation for any complicated pipeline**

#### Sort by line

The default behavior for `sort` is to sort by comparing full lines

**Important note: sort order is defined by the current locale**

If you `export LC_ALL=C` then it will compare by byte values

The default behavior is to keep duplicate line in stdout

2 ways to get unique ways with text in sorted values:

1. If you pass `-u` then it will only print unique values

2. If you pipe sorted text to `uniq` unix command

#### Sort by field

`Fields` are separated by whitespace characters but leading and trailing whitespace are ignored.

The `-t` flag is used to specify a field separator

The `-k` is used to define sorting criteria for each field

`sort` will sort by the first field, then by the second, ..., until it is done

#### Sort Field Specifications

* Field numbers start at one
* You specify character position within a field using `.N` and `N` start at field one

`-k` has a start and end in order to start and end positions for each sort criteria

Each field specification can be specified with an optional letter:

* `n` for numeric
* `r` to reverse
* `f` to fold case

#### Sort options

Ordering options:

* `-b`, --ignore-leading-blanks
  * ignore leading blanks
* `-d`, --dictionary-order
  * consider only blanks and alphanumeric characters
* `-f`, --ignore-case
  * fold lower case to upper case characters
* `-g`, --general-numeric-sort
  * compare according to general numerical value
* `-i`, --ignore-nonprinting
  * consider only printable characters
* `-M`, --month-sort
  * compare (unknown) < 'JAN' < ... < 'DEC'
* `-n`, --numeric-sort
  * compare according to string numerical value
* `-r`, --reverse
  * reverse the result of comparisons
* `-c`, --check
  * check whether input is sorted; do not sort
* `-k`, --key=POS1[,POS2]
  * start a key at POS1, end it at POS2 (origin 1)
* `-m`, --merge
  * merge already sorted files; do not sort
* `-o`, --output=FILE
  * write result to FILE instead of standard output
* `-s`, --stable
  * stabilize sort by disabling last-resort comparison
* `-S`, --buffer-size=SIZE
  * use SIZE for main memory buffer
* `-t`, --field-separator=SEP
  * use SEP instead of non-blank to blank * transition
* `-T`, --temporary-directory=DIR
  * use DIR for temporaries, not $TMPDIR or /tmp; multiple options specify multiple directories
* `-u`, --unique
  * with  `-c`, check for strict ordering; without `-c`, output only the first of an equal run
* `-z`, --zero-terminated
  * end lines with 0 byte, not newline
* `--`help display this help and exit
* `--`version
  * output version information and exit

#### Sort examples

```bash
sed '/^ID/d' data/students.csv | sort -t ',' -k2
```

Here we first delete description column then we sort by student name

```bash
sed '/^ID/d' data/students.csv | sort -n
```

Here we again delete the description record/line and then use `-n` to sort numerically

```bash
du -s * | sort -nr
```

In this command I use the disk usage command to print disk usage in current location per file/directory and then sort them numerically and in reverse order.

As no surprise node_modules is the biggest folder followed by `_book` which is a gitbook folder

```bash
grep -v '^ID' data/students.csv | sort -t, -k2,2r -k4gr | sed 's/^[0-9],//' | sed 's/^10,//'
```

Here we use grep and the invert match flag `-v` to which will print everthing that isn't `ID` and then pipe this into sort and sort by second field and then sort by fourth field then I pipe this into sed to delete the number column

#### Sort best practices

Sorting is at times the critical operation in a long and complex pipeline

The `sort` command is both flexible and powerful

If you can think of collecting your data in terms of sorting it will open more possibilities

Make sure to pay attention to locale

End your field specifications in the correct way

The `-n` option will sort integers

`gnu` sort can sort floating point numbers with `-g`

`gnu` sort has a `--debug` option that helps print what sort is doing

```bash
grep -v '^ID' data/students.csv | sort --debug -t, -k2,2r -k4gr | sed 's/^[0-9],//' | sed 's/^10,//'
```

You will get more output with sort using --debug

#### Uniq description

uniq -- report or filter out repeated lines in a file

The uniq utility reads the specified input_file comparing adjacent lines, and writes a copy of each unique input line to the output_file.  

If input_file is a single dash (`-`) or absent, the standard input is read.  If output_file is absent, standard output is used for output.

The second and succeeding copies of identical adjacent input lines are not written.

Repeated lines in the input will not be detected if they are not adjacent, so it may be necessary to sort the files first

The `uniq` command compares adjacent lines and the default behavior is for it to remove duplicates

**Comparison is based on the current locale**

You must sort the data for `uniq` to work properly

#### Uniq options

The following options are available:

* `-c` Precede each output line with the count of the number of times the line occurred in the input,followed by a single space.
* `-d` Only output lines that are repeated in the input.
* `-f` num  Ignore the first num fields in each input line when doing comparisons.  
  * A field is a string of non-blank characters separated from adjacent fields by blanks.  
  * Field numbers are one based, i.e., the first field is field one.
* `-s` chars
  *  Ignore the first chars characters in each input line when doing comparisons.  
  * If specified in conjunction with the -f option,
  the first chars characters after the first num fields will be ignored.
  * Character numbers are one based, i.e., the first character is character one.
* `-u` Only output lines that are not repeated in the input.
* `-i` Case insensitive comparison of lines.

#### Uniq examples

```bash
grep -v '^ID' data/students.repeated.csv | sort -t, -k2,2r -k4gr | sed 's/^[0-9],//' | sed 's/^10,//' | uniq
```

In the final pipeline we remove duplicate entries with uniq

```bash
grep -v '^ID' data/students.repeated.csv | sort -t, -k2,2r -k4gr | sed 's/^[0-9],//' | sed 's/^10,//' | uniq -c
```

Here we run the earlier command and pipe into `uniq` and use the `-c` option to print the number of times each line occurred

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Working with Fields](./working-with-fields.md) | [Arithmetic Operations and variables](./arithmetic-operations-and-variables.md) →
