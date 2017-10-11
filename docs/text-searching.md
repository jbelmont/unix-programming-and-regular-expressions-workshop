## Unix Programming and Regular Expressions Workshop - Text Searching

## Sections:

* [Regular Expressions](#regular-expressions)
* [History and Types of Regular Expressions](#history-and-types-of-regular-expressions)
* [Basic Regular Expressions](#basic-regular-expressions)
* [Extended Regular Expressions](#extended-regular-expressions)
* [Family of Regular Expression Tools](#family-of-regular-expression-tools)
* [Important Grep Options](#important-grep-options)
* [Good Practices for Regular Expressions](#good-practices-for-regular-expressions)
* [Bracket Expressions](#bracket-expressions)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Regular Expressions

[Regular Expressions](https://en.wikipedia.org/wiki/Regular_expression)

Regular expressions (regex) can be thought of as a language to describe matching text.

> A regular expression, regex or regexp (sometimes called a rational expression) is, in theoretical computer science and formal language theory, a sequence of characters that define a search pattern.

Regular Expressions are comprised of:

* Some regular characters that can stand for themselves like 'a'
* Metacharacters that can stand for a regular expression operation

Here is a chart on metacharacters:

| `Metacharacter` | `Description` |
| --- | --- |
| `^` | Matches the starting position within the string. In line-based tools, it matches the starting position of any line. |
| `.` | Matches any single character (many applications exclude newlines, and exactly which characters are considered newlines is flavor-, character-encoding-, and platform-specific, but it is safe to assume that the line feed character is included). Within POSIX bracket expressions, the dot character matches a literal dot. For example, a.c matches "abc", etc., but [a.c] matches only "a", ".", or "c". |
| `[]` | A bracket expression. Matches a single character that is contained within the brackets. For example, [abc] matches "a", "b", or "c". [a-z] specifies a range which matches any lowercase letter from "a" to "z". These forms can be mixed: [abcx-z] matches "a", "b", "c", "x", "y", or "z", as does [a-cx-z]. The - character is treated as a literal character if it is the last or the first (after the ^, if present) character within the brackets: [abc-], [-abc]. Note that backslash escapes are not allowed. The ] character can be included in a bracket expression if it is the first (after the ^) character: []abc]. |
| `[^]` | Matches a single character that is not contained within the brackets. For example, [^abc] matches any character other than "a", "b", or "c". [^a-z] matches any single character that is not a lowercase letter from "a" to "z". Likewise, literal characters and ranges can be mixed. |
| `$` | Matches the ending position of the string or the position just before a string-ending newline. In line-based tools, it matches the ending position of any line. |
| `()` | Defines a marked subexpression. The string matched within the parentheses can be recalled later (see the next entry, \n). A marked subexpression is also called a block or capturing group. BRE mode requires \( \). |
| `\n` | Matches what the nth marked subexpression matched, where n is a digit from 1 to 9. This construct is vaguely defined in the POSIX.2 standard. Some tools allow referencing more than nine capturing groups. |
| `*` | Matches the preceding element zero or more times. For example, ab*c matches "ac", "abc", "abbbc", etc. [xyz]* matches "", "x", "y", "z", "zx", "zyx", "xyzzy", and so on. (ab)* matches "", "ab", "abab", "ababab", and so on. |
| `{m, n}` | Matches the preceding element at least m and not more than n times. For example, a{3,5} matches only "aaa", "aaaa", and "aaaaa". This is not found in a few older instances of regexes. BRE mode requires \{m,n\}. |

* Expressions that denote categories of a regular expression

#### History and Types of Regular Expressions

> Regular expressions originated in 1956, when mathematician Stephen Cole Kleene described regular languages using his mathematical notation called regular sets. These arose in theoretical computer science, in the subfields of automata theory (models of computation) and the description and classification of formal languages. Other early implementations of pattern matching include the [SNOBOL language](https://en.wikipedia.org/wiki/SNOBOL), which did not use regular expressions, but instead its own pattern matching constructs.

* Different Unix tools have used different Regular Expression types
* This reflects the influence and interests in AT&T Research Labs (Kernighan, Ritchie, etc)

#### Basic Regular Expressions

BRE (Basic Regular Expressions)

BRE . Although POSIX.2 leaves some implementation specifics undefined, BRE and ERE provide a "standard" which has since been adopted as the default syntax of many tools, where the choice of BRE or ERE modes is usually a supported option. For example, GNU grep has the following options: "grep -E" for ERE, and "grep -G" for BRE (the default), and "grep -P" for Perl regexes.

###### Examples of Regular Expressions

Here are some examples from the [Regular Expressions Wikipedia Page](https://en.wikipedia.org/wiki/Regular_expression):

* `.at` matches any three-character string ending with "at", including "hat", "cat", and "bat".

* `[hc]at` matches "hat" and "cat".

* `[^b]at` matches all strings matched by .at except "bat".

* `[^hc]at` matches all strings matched by .at other than "hat" and "cat".

* `^[hc]at` matches "hat" and "cat", but only at the beginning of the string or line.

* `[hc]at$` matches "hat" and "cat", but only at the end of the string or line.

* `\[.\]` matches any single character surrounded by "[" and "]" since the brackets are escaped, for example: "[a]" and "[b]".

* `s.*` matches s followed by zero or more characters, for example: "s" and "saw" and "seed".

#### Extended Regular Expressions

* ERE (Extended Regular Expressions) adds `?`, `+`, and `|`, and EREs removes the need to escape the metacharacters `( )` and `{ }`, which are required in BREs.

* Furthermore, as long as the POSIX standard syntax for regexes is adhered to, there can be, and often is, additional syntax to serve specific (yet POSIX compliant) applications

* The meaning of metacharacters escaped with a backslash is reversed for some characters in the POSIX Extended Regular Expression (ERE) syntax.

* With this syntax, a backslash causes the metacharacter to be treated as a literal character.

* So, for example, `\( \)` is now `( )` and `\{ \}` is now `{ }`.

* Additionally, support is removed for \n backreferences and the following metacharacters are added:

| `Metacharacter`	| `Description` |
| `?` |	Matches the preceding element zero or one time. For example, ab?c matches only "ac" or "abc". |
| `+`	| Matches the preceding element one or more times. For example, ab+c matches "abc", "abbc", "abbbc", and so on, but not "ac". |
| `|`	| The choice (also known as alternation or set union) operator matches either the expression before or the expression after the operator. For example, abc|def matches "abc" or "def". |

###### Examples of EREs

* [hc]?at matches "hat", "cat", and "at".

* [hc]*at matches "hat", "cat", "hhat", "chat", "hcat", "cchchat", "at", and so on.

* [hc]+at matches "hat", "cat", "hhat", "chat", "hcat", "cchchat", and so on, but not "at".

* cat|dog matches "cat" or "dog".

#### Family of Regular Expression Tools

###### Grep

Different `Grep` programs:

1. The `grep` utility searches any given input files, selecting lines that match one or more patterns.
2. The `egrep` interprets pattern as an extended regular expression
  1. Force regular `grep` to behave like `egrep` with `-E` flag.
3. The `fgrep` interprets pattern as a set of fixed strings.
  1. Force regular `grep` to behave as `fgrep` with `-F`.
4. The `zgrep` invokes grep on compressed or gzipped files
  1. Force regular `grep` to behave as `zgrep` with `-Z`.
5. The `zegrep` accept input files compressed with the compress utility
6. The `zfgrep` compression utilities with gzip

###### Sed

* Sed is good for text matching and substitution

* The sed utility reads the specified files, or the standard input if no files are specified, modifying the input as specified by a list of commands.

* The input is then written to the standard output

###### Awk

* Pattern matching with an actual programming language

* Awk scans each input file for lines that match any of a set of patterns specified literally in prog or in one or more files specified as -f progfile.

* With each pattern there can be an associated action that will be performed when a line of a file matches the  pattern.

* Each line is matched against the pattern portion of every pattern-action statement; the associated action is performed for each matched pattern.

* The file name - means the standard input.

* Any file of the form var=value is treated as an assignment, not a filename, and is executed  at the time it would have been opened if it were a filename.

* The option -v followed by var=value is an assignment to be done before prog is executed; any number of -v options may be present.

* The -F fs option defines the input field separator to be the regular expression fs.

###### Scripting Languages with Regular Expression Flavors of their own

* Perl
* Python
* Ruby
* JavaScript

#### Important Grep Options

List of Imporant `grep` options:

* `-e` specify a pattern used during the search of the input: an input line is selected if it matches any of the specified patterns.
  * This option is most useful when multiple -e options are used to specify multiple patterns, or when a pattern begins with a dash (`-').

* `-f` Read one or more newline separated patterns from file.
  * Empty pattern lines match every input line.
  * Newlines are not considered part of a pattern.
  * If file is empty, nothing is matched.

* `-l` Only the names of files containing selected lines are written to standard output.  grep will only search a file until a match has been found, making searches potentially less expensive.
  * Pathnames are listed once per file searched.
  * If the standard input is searched, the string ``(standard input)'' is written.

* `-v` Selected lines are those not matching any of the specified patterns (invert matches)

* `-q` suppress output or quiet mode
  * Often in a shell script doing `> /dev/null` is more obvious to readers

* `-s` don't print errors

#### Good Practices for Regular Expressions

* Try to use `EREs` as much as you can as their more powerful and modern machines have the capability to run them with too much performance impact.

* Always quote your Regular Expressions

##### Single Character Expressions

* Regular characters like "Z" or "&" match themselves

* Character case matters: "d" and "D" are different

* Period (".") matches any single character
  * Possibly matches newlines

Escaped metacharacter:

* `\.` matches a real period
* `\\` matches a real backslash

#### Bracket Expressions

* The brackets `[ ]` match any one character
* So [abcde] matches one of the characters `a`, `b`, `c`, `d`, `e` respectively
* Using a dash like this `[0-9]` or `[A-Z]` matches all characters in alphabet or numbers 0 through 9 respectively
* Using a caret `^` in the beginning of bracket will invert matches `[^cd]` will match anything not `c` or `d`

Character classes are used for digits, punctuations, letters, etc..

* `[[:classname:]]` notice the inner bracket `[:classname:]`

Character Classes:

* `'[:alnum:]'`
  * Alphanumeric characters: '[:alpha:]' and '[:digit:]'; in the 'C' locale and ASCII character encoding, this is the same as ‘[0-9A-Za-z]’.

* `'[:alpha:]'`
  * Alphabetic characters: '[:lower:]' and '[:upper:]'; in the 'C' locale and ASCII character encoding, this is the same as '[A-Za-z]'.

* `'[:blank:]'`
  * Blank characters: space and tab.

* `'[:cntrl:]'`
  * Control characters. In ASCII, these characters have octal codes 000 through 037, and 177 (DEL).
  * In other character sets, these are the equivalent characters, if any.

* `'[:digit:]'`
  * Digits: 0 1 2 3 4 5 6 7 8 9.

* `'[:graph:]'`
  * Graphical characters: '[:alnum:]' and '[:punct:]'.

* `'[:lower:]'`
  * Lower-case letters; in the ‘C’ locale and ASCII character encoding, this is a b c d e f g h i j k l m n o p q r s t u v w x y z.

* `'[:print:]'`
  * Printable characters: '[:alnum:]', '[:punct:]', and space.

* `'[:punct:]'`
  * Punctuation characters; in the ‘C’ locale and ASCII character encoding, this is ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.

* `'[:space:]'`
  * Space characters: in the ‘C’ locale, this is tab, newline, vertical tab, form feed, carriage return, and space.

* `'[:upper:]'`
  * Upper-case letters: in the ‘C’ locale and ASCII character encoding, this is A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.

* `'[:xdigit:]'`
  * Hexadecimal digits: 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f.

#### Repetition in Grep

* `Asterisk` (`*`) indicates zero or more of the preceding character
  * bc*d matches bd, bcd, bccd, bcccd, ...
* Notice the `*` matches zero or more the `c` characters
* it does not match `bAd` though it only matches with `c` characters
* `.*` matches any character though so it is most powerful match
* `*` matches the null string as well which can affect substitutions

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Basics of Shell Programming](./basics-of-shell-programming.md) | [Text Searching](./text-searching.md) →
