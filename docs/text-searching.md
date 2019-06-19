## Unix Programming and Regular Expressions Workshop - Text Searching

## Sections:

* [Regular Expressions](#regular-expressions)
* [History and Types of Regular Expressions](#history-and-types-of-regular-expressions)
* [Unix Tools that use Regular Expressions](#unix-tools-that-use-regular-expressions)
* [Basic Regular Expressions](#basic-regular-expressions)
* [Extended Regular Expressions](#extended-regular-expressions)
* [Family of Regular Expression Tools](#family-of-regular-expression-tools)
* [Important Grep Options](#important-grep-options)
* [Good Practices for Regular Expressions](#good-practices-for-regular-expressions)
* [Bracket Expressions](#bracket-expressions)
* [Basic Grep Examples](#basic-grep-examples)
* [Interval Expressions](#interval-expressions)
* [Parenthesized Subexpressions](#parenthesized-subexpressions)
* [Basic Regular Expression Operator Precedence](#basic-regular-expression-operator-precedence)
* [Regular Expression Matching](#regular-expression-matching)
* [Intermediate Grep Examples](#intermediate-grep-examples)
* [Extended Regular Expressions](#extended-regular-expressions)
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

#### Unix Tools that use Regular Expressions

Unix Tools that use Regexes:

* grep

* sed

* awk

* vim

* emacs

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
| --- | --- |
| `?` |	Matches the preceding element zero or one time. For example, ab?c matches only "ac" or "abc". |
| `+`	| Matches the preceding element one or more times. For example, ab+c matches "abc", "abbc", "abbbc", and so on, but not "ac". |
| <code>&#124;</code>	| The choice (also known as alternation or set union) operator matches either the expression before or the expression after the operator. For example, abc&#124;def matches "abc" or "def". |

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

#### Basic Grep Examples

```bash
$ echo 'Hey Marcel how are you doing?' | grep --color 'Marcel'
```

Notice when you output this that `Marcel` is in color because it is a match

```bash
$ echo 'Hey Marcel how are you doing?' | grep --color 'marcel'
```

This will not match though because case matters

```bash
$ echo 'You are hungry right?' | grep --color h.ngry
```

Notice that `hungry` matches because the dot `.` matches any character

```bash
$ echo this is www.marcelbelmont.com domain | grep --color 'www\.marcelbelmont\.com'
```

When you want to match a literal character such as a dot it needs to be escaped

```bash
$ echo abc 555 | grep --color '[aeiouc]'
```

What do you think will match here?

```bash
$ echo what will match here 987 | grep --color '[^whe9]'
```

What matches here?

```bash
$ echo what is happening 587-987-1000 | grep --color '[[:digit:]]'
```

This matches numbers 0-9

```bash
$ echo what should match here? 897-888-3333 | grep --color '[^[:digit:]]'
```

What matches here?

```bash
echo do alphas match? 5899 | grep --color '[[:alpha:]]'
```

The alpha character class matches any characters in alphabet

```bash
echo do alphas match? 5899 | grep --color '[^[:alpha:]]'
```

What should match here?

```bash
$ echo what matches here 888 | grep --color '[[:alpha:]]*'
```

```bash
$ echo 0899 matches here 888 | grep --color '[[:alpha:]]*'
```

```bash
$ echo 159 out for this 999 | ggrep -E --color '[^[:alpha:]]*'
```

```bash
$ echo what the 189 stuff 877 | grep --color -E '[[:digit:]]*'
```

```bash
$ echo what the 189 stuff 877 | grep --color -E '[^[:digit:]]*'
```

When using `bsd` grep there is what seems like subtle bugs

I have gnu grep installed and all occurrences of  characters not in alphabet matched as they should

* Be aware of subtle differences between `BSD` Unix Tools and `GNU` they creep up on you.

* Using `--color` and some sample data helps test your `BREs` as you write them

#### Interval Expressions

* `d\{A\}` - A occurrences of d
* `d\{A,\}` - At least A occurrences of d
* `d\{A, B\}` - A to B occurrences of d

* The `d` means a single character

* `[[:digit:]]\{3\}-[[:digit:]]\{4\}` this RegEx matches on a US local phone number
  * such as 531-2000

* A and B are integers up to RE_DUP_MAX

If you are on a Mac run the following command:

```bash
$ sysctl user.re_dup_max
user.re_dup_max: 255
```

`sysctl` can print kernel state variables

#### Anchor regex matches

* Caret `^` means match must start at beginning of line or string

* Dollar Sign `$` means match must occur at end of line or string

* if you use `^` and `$` in the middle of a basic regular expression than they stand for their literal value

#### Parenthesized Subexpressions

* \(o[pq]\)\(567\)yy\2\1 is the same as `o[pq]567yyY2Y1

  * The Y2 and Yq are the actual text that match expressions in parentheses
  * The contents of the parenthesis can be any regular expression
* You can use up to 9 parenthesized subexpressions
* This is often called "backreferences"
* This only works for Basic Regular Expressions (BREs)

#### Basic Regular Expression Operator Precedence

I am ordering from Highest to Lowest Precedence:

* Bracket Symbols: [:class:], [=a=], [.ab.]
* \metacharacter
* Bracket Expresssions `[ ]`
* \(.....\) and \digit
* * and \{......\}
* concatenation (cde is c followed by d then by e)
* ^ and $ anchors

#### Regular Expression Matching

* Regular Expression match the longest possible, leftmost occurrence of text that can be matched
  * It is said that regular expressions are greedy by default in this way
* The regex match stops at the first character that cannot be matched
* If a text is matched then it is used even if a longer match exists further down the text

#### Intermediate Grep Examples

```bash
$ echo 891 you 588 | grep --color '[[:alpha:]]\{2\}'
```

It matches 2 characters here the `yo`

but

```bash
$ echo 891 some 5888 | grep --color '[[:alpha:]]\{2\}'
```

Here it matches the `some` the whole character set

```bash
$ echo 589 him 999 | grep --color '[^[:alpha:]]\{2\}'
```

Here it matches on 4 pairs:

The `58`, `9 and space`, `a space and 9`, and `99`

```bash
$ echo 589 him 999 | grep --color '[^[:alpha:][:space:]]\{2\}'
```

Here it matched on 2 pairs:

The `58` and the `99`

```bash
$ echo 589 her 897 | grep --color '^[[:digit:]]*'
```

Here it matches the digits at the beginning which happens to be `589`

```bash
$ echo her 888 | grep --color '^[^[:digit:]]*'
```

This matches anything that is not a digit at the beginning of the set so it matches `her`

```bash
$ echo 567 vim 321 | grep --color '[^[:alpha:]]*$'
```

This matches any character that is not in alphabet and in the end of the set so it matches `321`

```bash
$ echo 567 abcd 789 himhim | grep --color '[aeiouhm]*'
```

```bash
$ echo 567 abcd 789 himhim | grep --color '[aeiouhm]*'
```

Here it didn't match with `BSD` grep but with gnu grep

```bash
$ echo 567 abcd 789 himhim | ggrep --color '[aeiouhm]*'
```

it matches with `a`,`him`, `him` like it should to match longest string

This seems to be a bug between `bsd` grep and `gnu` grep

Here is an example using `sed` which will go into soon

```bash
$ echo 567 aeod 888 houhou  | sed 's/[aeioud]*/D/'
```

Notice a quirk here it matched on the null string which is at the beginning of the set

```bash
$ echo 567 aeod 888 houhou  | sed 's/[aeioud][aeioud]*/D/'

567 D 888 houhou
```

Here it matched on the string `aeod` and replaced with `D` but it didn't match all occurrence because we need the `g` flag which does a global replace

```bash
echo 567 aeod 888 houhou  | sed 's/[aeioud][aeioud]*/D/g'

567 D 888 hDhD
```

Notice this time `ou` was replaced with `D` twice

*Always quote your regular expressions on the command line or you will get unexpected behavior*

Things to be watch out for regular expressions:

* Substitutions can match the null string in unexpected ways as you saw

* Matches will go with *longest leftmost match*

* Regular expressions can become cryptic very quickly so do take your time to read, write and to test them.

#### Extended Regular Expressions

Similiarites to Basic Regular Expressions:

* Matching single characters
  * Regular characters, `.`, escaped metacharacters
  * Bracket expressions: ranges and classes

* Conduct repetition with `*` and inverval expressions `({.....})`

* Anchor sets with `^` and `$`
  * Although in `EREs` the `^` and `$` are still special even in the middle of a Regular Expression

* Matches go with longest, leftmost match

###### Additional Repition Operators for EREs

* `re?` is zero or one of `re`
  * so for example `mother?` would match one mother or none, meaning optional
* A note that `re` can be more than one character
  * This applies to `*` and `{...}` as well

###### Grouping with Parenthesis

* Parenthesis group smaller Regular Expressions into larger regexes
  * `([[:digit:]]{3}-[[:digit:]]{4})+` this matches one or more US phone numbers
  * We can even include repetition operators
* You can't use backreferences with EREs

###### Alternation

* `Alternation` means this or that
  * `(mayo|ketchup)` will match either mayo or ketchup but not both
  * `Alternation` is often used with parenthesis
* `Alternation` has the lowest precedence of all the operators
  * ^sorry|world$ will expand like this
    * (^sorry)|(world$) and not like this ^(sorry|world)$ as you would think due to operator precedence

###### Extended Regular Expressions Operator Precedence

Operator Precedence:

1. Bracket symbols: `[:class:]`, `[=c=]`, `[.bs.]`, and `[012345]`
  1. Meaning the brackets themselves `[  ]`
2. `\metacharacter`
3. Bracket expressions `[:alnum:]`
4. `(.....)` grouping
5. `*`, `+`, `?`, and `{.....}`
6. Concatenation => who means `w` followed by `h` then followed by `o`
7. Alternation

###### EREs Examples

```bash
$ echo ac abc abbc abbbc | egrep --color 'ab?c'
```

This matches `ac` and `abc` since `ac` does not have a `b` and it matched `abc` since it was one `b`

```bash
$ echo ac abc abbc abbbc | grep -E --color 'ab?c'
```

this also works because `-E` puts grep in ERE mode

```bash
echo abc 531-2000 531-7777 cba | egrep --color '([[:digit:]]{3}-[[:digit:]]{4} )+
```

This uses grouping operator `()` and matches 3 digits, a `-` and 4 digits respectively

```bash
echo 'yo man
how are you' | egrep --color 'how|yo'
```

This matches `yo` twice once in `yo` and second in `yo`u and it matches `how`

```bash
$ echo word and up | egrep --color '^word|up$'
```

This matches both `word` and `up` because of operator precedence

```bash
$ echo word and up | egrep --color '^(word|up)$'
```

This doesn't match because we have more in the line than just `word` or `up`

```bash
echo abc 888-7777 999-1111 cba |
grep --color '\([[:digit:]]\{3\}-[[:digit:]]\{4\} \)\+'
```

This matches using regular `grep with backslashes and interval expressions and grouping expressions and the plus operator

```bash
echo 'yo
man
hey' | grep --color '^\(yo\|man\)$'
```

Notice here that we need to escape with `\` but we match with `yo`, `man`

Notice an example with `sed` and `gsed`

```bash
$ echo yo and hey | sed 's/^yo\|hey$/zzz/g'
```

this should have worked and replaced both `yo` and `hey` with `zzz`

but this example with `gnu` sed works

```bash
echo yo and hey | gsed 's/^yo\|hey$/zzz/g'
zzz and zzz
```

###### Main programs that use EREs

* egrep
* grep with `-E`
* awk
* GNU grep and sed let you use `\?`, `\+` and `\|` to get the same `ERE` power but is not readable

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Basics of Shell Programming](./basics-of-shell-programming.md) | [Text Substitution](./text-substitution.md) →
