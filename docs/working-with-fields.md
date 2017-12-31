## Unix Programming and Regular Expressions Workshop - Working with Fields

## Sections:

* [Cut description](#cut-description)
* [Cut options](#cut-options)
* [Cut examples](#cut-examples)
* [Join description](#join-description)
* [Join options](#join-options)
* [Join examples](#join-examples)
* [Usages for Cut and Join](#usages-for-cut-and-join)
* [Awk Description](#awk-description)
* [Awk options](#awk-options)
* [Distributions of awk](#distributions-of-awk)
* [Patterns and Actions in Awk](#patterns-and-actions-in-awk)
* [Awk Program Flow](#awk-program-flow)
* [Awk fields](#awk-fields)
* [Printing lines in Awk](#printing-lines-in-awk)
* [Awk Startup and Cleanup Actions](#awk-startup-and-cleanup-actions)
* [Awk examples](#awk-examples)
* [Tips for awk programs](#tips-for-awk-programs)
* [Exercises](#exercises)
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

```bash
$ join data/population.txt data/cities.txt
Ireland 4,773,000 Dublin
USA 318,900,000 Washington, D.C
Russia 144,300,000 Moscow
UK 64,100,000 London
Canada 35,160,000 Toronto
```

Remember that the first field is used by default which happens to be the key in `population.txt` and `cities.txt`

Notice here that the key `Ireland` joins both text files with population and capital fields consequently

```bash
join -o 1.1,2.2,1.2,1.3 data/cities.txt data/population.txt
```

This example prints out first field of `cities.txt` => 1.1, then prints out second field of `population.txt` => 2.2, then prints out second field of `cities.txt` => 1.2, then lastly prints out third field of `cities.txt` => 1.3 (mainly to get `D.C`) since it get cut off from.

```bash
sed '/^Russia/d' data/cities.txt| join - data/population.txt
```

In this example we first delete Russia from cities.txt and then pipe this as stdin for `join` but it fails with join because we didn't sort the contents of the file `cities.txt` and when it encountered the file population.txt which wasn't sorted either it looked for a key `Russia` but didn't find it.

```bash
sort data/cities.txt > data/cities.sorted.txt
```

Here we sort `cities.txt`

```bash
sort data/population.txt > data/population.sorted.txt
```

and here we sort `population.txt`

```bash
sed '/^Russia/d' data/cities.sorted.txt | join - data/population.sorted.txt
```

This command will pass because both files have been sorted and when join encounters key `Russia` that is not found it simply omits Russia from Output because population and cities didn't have the shared key anymore

#### Usages for Cut and Join

* Cut is a focused tool for a special task
  * Cut is a special command that cuts out either delimiter-separated fields or a range of characters
  * Cut is much simpler than sed and is used to extract individual fields from a file
  * Also there is some locale issues when cutting by a charactere so be cognizant of that
* Join is also a focused tool for a special task
  * Join is a special command that selectively merges related data based on corresponding keys
  * Join must be sorted on the key field
  * Remember from the example above we had to sort it, if you don't sort it may or may not work as was evidenced on the first `sort` example so always sort to avoid unexpected behavior

#### Awk Description

awk - pattern-directed scanning and processing language

Awk scans each input file for lines that match any of a set of patterns specified literally in prog or in one or more files specified as -f progfile.  

With each pattern there can be an associated action that will be performed when a line of a file matches the pattern.

Each  line  is  matched  against  the  pattern  portion of every pattern-action statement; the associated action is performed for each
matched pattern.  

The file name - means the standard input.  Any file of the form var=value is treated as an assignment, not  a  filename, and is executed at the time it would have been opened if it were a filename.  

The option -v followed by var=value is an assign-
ment to be done before prog is executed; any number of -v options may be present.  

The -F fs option defines the input field  separator
to be the regular expression fs

#### Awk options

```bash
$ awk --help
```

*Usage: awk [POSIX or GNU style options] -f progfile [--] file ...*

*Usage: awk [POSIX or GNU style options] [--] 'program' file ...*

POSIX options:

  * `-f` progfile
	* `-F` fs (field separator)
	* `-v` var=val

Short options:

  * `-b`
  * `-c`
  * `-C`
  * `-d` [file]
  * `-D` [file]
  * `-e`  'program-text'
  * `-E`  file
  * `-g`
  * `-h`
  * `-i`  includefile
  * `-l`  library
  * `-L` [fatal|invalid]
  * `-M`
  * `-N`
  * `-n`
  * `-o` [file]
  * `-O`
  * `-p` [file]
  * `-P`
  * `-r`
  * `-S`
  * `-t`
  * `-V`

GNU long options: (standard):

  * `--file=progfile`
  * `--field-separator=fs`
  * `--assign=var=val`

GNU long options: (extensions)

  * `--characters-as-bytes`
  * `--traditional`
  * `--copyright`
  * `--dump-variables[=file]`
  * `--debug[=file]`
  * `--source='program-text'`
  * `--exec=file`
  * `--gen-pot`
  * `--help`
  * `--include=includefile`
  * `--load=library`
  * `--lint[=fatal|invalid]`
  * `--bignum`
  * `--use-lc-numeric`
  * `--non-decimal-data`
  * `--pretty-print[=file]`
  * `--optimize`
  * `--profile[=file]`
  * `--posix`
  * `--re-interval`
  * `--sandbox`
  * `--lint-old`
  * `--version`

#### Distributions of awk

`awk` has several distributions:

* `awk` bsd style
* `nawk` is a version written by one of the original authors [Brian Kernighan](https://en.wikipedia.org/wiki/Brian_Kernighan)
* `gawk` is gnu awk and here is the [Gawk Docs](https://www.gnu.org/software/gawk/manual/gawk.html)
* `mawk` is fast awk implementation
* `libmawk` is a fork of mawk
* `awka`
* `tawk`
* `jawk`
* `xgawk`
* `qseawk`
* Implementation of `awk` written by [BusyBox](https://en.wikipedia.org/wiki/BusyBox)

We will mainly look at bsd version of awk and gawk

#### Patterns and Actions in Awk

Awk programs operate on a series of patterns and actions

`$1 === "marcel" { increment_user++ }`

Here is an example

* Patterns in awk are done:

1. Regular expression matching
2. String Comparision
3. Number Comparison
4. General Test
5. Extended Regular expressions

`awk` actions are enclosed in braces and can do any computation

Variables in awk are automatically initialized to `0` or `""`

Either the pattern or the action may be omitted in `awk`

[Patterns in Awk Docs](https://www.gnu.org/software/gawk/manual/gawk.html#Pattern-Overview)

[Actions in Awk Docs](https://www.gnu.org/software/gawk/manual/gawk.html#Action-Overview)

#### Awk Program Flow

1. `awk` processes command line options and parses program text
2. `awk` will execute any startup actions
3. `awk` will loop until it is done
  1. awk will read a record
  2. awk will split a record into fields
  3. awk will test each pattern (your program code) against a record.
  4. awk will run corresponding action if the action matches
4. `awk` will execute any cleanup actions

#### Awk fields

An input line in `awk` is known as a `record`

Records in awk consist of fields that are separated by whitespace

You can set field separators on the command line  or use `FS` variable

In awk you use the variables `$1`, `$2`, ... , `$n` and so on for each field

`NF` is the number of fields in a current record

You can use `NF` for the last field in a record

You use `$0` for the whole record in awk

###### Set Field Separator in awk

You can set field separator in 2 places:

1. command line wth `-F` option
  1. `awk -F: 'some program text' /etc/passwd | some pipe operation`

2. In an awk program.
  1. You assign a string to `FS`
  2. 3 different "modes" in awk:
    1. `FS = " "` number of whitespace separated fields
    2. `FS = "character"` Number of instances of `character` separated fields
    3. `FS = "re"` Each field separated by text that matches "re"

#### Printing lines in Awk

**print** statements only appear in the actions parts in awk

The `print` statement is mainly used for simple formatting

`print "Order", $2, "Amount:", $1`

The `printf` statement is used for formatted text

`printf("Order: %s\tAmount: %g\n", $2, $1)`

[printf docs](https://en.wikipedia.org/wiki/Printf_format_string)

Many languages have a `printf` function

**As you saw earlier in the workshop you need to put `\n` in printf to print a final newline**

#### Awk Startup and Cleanup Actions

[Startup and Cleanup](https://www.gnu.org/software/gawk/manual/gawk.html#Using-BEGIN_002fEND)

###### Begin and End Rules

You provide code that runs before reading any records like so:

```sh
BEGIN {
  code here ...
}
```

You then can provide code to run after all the records have been processed

```sh
END {
  code here ...
}
```

The keywords `BEGIN` and `END` can begin anywhere in your awk program.

`BEGIN` and `END` can be used multiple times in an awk program.

Furthermore `BEGIN` and `END` are run in the order that they appear in your awk program

#### Awk examples

```bash
awk -F , '{ print $2 }' data/information.txt
```

The field separator is `,` is in this awk program

Here is a breakdown of each field:

1. Name
2. Rank
3. Height
4. Years of Service

It prints out the Rank field here

```bash
awk -F : '{ print $1 }' /etc/passwd
```

This awk command line program sets field separator to `:`, then it prints out the first field for each record of `/etc/passwd`

```bash
sed -n '25p' /etc/passwd
```

Notice with sed we print the 25th line of `/etc/passwd`

which has the following content:

**_serialnumberd:*:58:58:Serial Number Daemon:/var/empty:/usr/bin/false**

Here is a breakdown of each field:

1. _serialnumberd
2. *
3. 58
4. 58
5. Serial Number Daemon
6. /var/empty
7. /usr/bin/false

So in total there is 7 fields in each record that is field separated with `:` character

```bash
sed '/^#/d' /etc/passwd | awk -F : '{ print $6 }'
```

What do you think gets printed in this awk program?

```bash
awk -F : '$NF ~ /\/bin\/sh/ { print $1 }' /etc/passwd
```

This script counts with `$NF` which is a special variable in `awk` the number of records that have users that use `/bin/sh`. Notice here that I had to escape the `/` with a `\` to get the literal `/`. Also remember `$1` is the first field of the record

```bash
awk -F : '$5 ~ /PostgreSQL Server/' /etc/passwd
```

This awk program looks in the 5th field for each record for the pattern `/PostgreSQL Server/` using the `~` operator and then prints out the entire record that matched

```bash
awk -F : '$5 ~ /PostgreSQL Server/ { print $1 }' /etc/passwd
```

This example explicitly prints out first field `_postgres` because we used the curly braces and the print command

```bash
cat data/orders.txt
ID,ORDER DESCRIPTION,PRICE
1,Hamburger,2.50
2,Fries,1.00
3,Hamburger,2.50
4,Shake,2.75
5,Fries,1.00
6,Hamburger,2.75
```

This simple file has a list of orders

```bash
awk -F ',' '$2 ~ /Hamburger/ { total += $3 } END { print "total: ", total }' data/orders.txt
```

This awk program sets `,` as field delimiter and then searches in the second field for the pattern `Hamburger` and then it creates variable `total` that sums up 3rd field which is the price and then prints the total in the end.

```bash
./scripts/working-with-fields/bank_statement.sh data/bank_statement.csv
```

We will look at this script and explain contents line by line but one thing we will discuss is that the first line has a shebang and takes the `-f` option because we will provide a data file to it.

#### Tips for awk programs

Remember when using regular expression matching and string comparison in awk programs that locales come into effect.

When using multiple source files with awk you need to order them correctly in the command line

Remember for portability that certain flavors of `awk` have different features so try not to use to many special functions if your script is to be used across many environments

If portability is not a real issue then try to use `gnu` awk as it is the most feature rich version of awk

The concept of patterns and actions in awk brings a powerful abilithy to describe data that needs to be processed.

Since awk automatically reads records and performs field splitting you can focus on your data and what to do with your data

Also awk is a much more powerful unix tool than sed as it is a turing complete programming language and sed is just a streaming editor at heart

Extended regular expressions give awk more power

#### Exercises

For the exercise we will work with the a sample file that is a copy of the */etc/passwd*

Here is a quick rundown of the */etc/passwd* this information was explained in [cyberciti](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/) :

1. Username: It is used when user logs in. It should be between 1 and 32 characters in length.

2. Password: An x character indicates that encrypted password is stored in /etc/shadow file.
  1. Please note that you need to use the passwd command to computes the hash of a password typed at the CLI or to store/update the hash of the password in /etc/shadow file.

3. User ID (UID): Each user must be assigned a user ID (UID). 
  1. UID 0 (zero) is reserved for root and UIDs 1-99 are reserved for other predefined accounts. 
  2. Further UID 100-999 are reserved by system for administrative and system accounts/groups.

4. Group ID (GID): The primary group ID (stored in /etc/group file)

5. User ID Info: The comment field. It allow you to add extra information about the users such as user’s full name, phone number etc. This field use by finger command.

6. Home directory: The absolute path to the directory the user will be in when they log in. 
  1. If this directory does not exists then users directory becomes /
Command/shell: The absolute path of a command or shell (/bin/bash). 
  2. Typically, this is a shell. Please note that it does not have to be a shell.

For this exercise you need to get the 5th field and grab the 15th record.
You can use either cut or awk to solve this and the *scripts/working-with-fields/passwd*.

**Solution with cut**

<details>
<pre>
cut -d: -f5 scripts/working-with-fields/passwd | sed -n '15p'
</pre>
</details>

**Solution with awk**

<details>
<pre>
awk -F ':' '{ print $5 }' scripts/working-with-fields/passwd | sed -n '15p'
</pre>
</details>

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Filename expansions and globbing](./filename-expansions-and-globbing.md) | [Text Sorting](./text-sorting.md) →
