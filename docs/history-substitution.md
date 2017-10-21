## Unix Programming and Regular Expressions Workshop - History Substitution

## Sections:

* [History Description](#history-description)
* [History Options](#history-options)
* [History Event Designators](#history-event-designators)
* [History Examples](#history-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### History Description

[History Command](https://en.wikipedia.org/wiki/History_\(Unix\))

* The history command manipulates this history list. 

* In its simplest form, it prints the history list.

* Options allow for the recall and editing of particular commands and for setting parameters such as the number of past commands to retain in the list.

#### History Options

`history: history [-c] [-d offset] [n] or history -anrw [filename] or history -ps arg [arg...]`

Display or manipulate the history list.

Display the history list with line numbers, prefixing each modified
entry with a `*'.  An argument of N lists only the last N entries.

History Options:

* `-c`	clear the history list by deleting all of the entries

* `-d` offset	delete the history entry at position OFFSET.

* `-a`	append history lines from this session to the history file

* `-n`read all history lines not already read from the history file and append them to the history list

* `-r`	read the history file and append the contents to the history list

* `-w`	write the current history to the history file

* `-p`	perform history expansion on each ARG and display the result
  without storing it in the history list

* `-s`	append the ARGs to the history list as a single entry

If **FILENAME** is given, it is used as the history file.  

Otherwise, if **HISTFILE** has a value, that is used, else ~/.bash_history.

#### History Event Designators

| Designator | Meaning |
| --- | --- |
| ! | Start a history event unless followed immediately by SPACE, NEWLINE or = |
| !! | Previous Command |
| !n | Command number *n* in the history list |
| !-n | The nth preceding command |
| !string | The most recent command that started with string | 
| !?string[?] | The most recent command that contained string. The last *?* is optional |
| !# | The current command that you have typed |
| !{event} | The **event** is an event designator. The braces isolate event from the surrounding text |

#### History Examples

```bash
history 10
```

this will output the last 10 entries in the history file

In zsh history is aliased to fc

```bash
!!
```

Will reexecute last command done in history

```bash
!3
```

This will execute the 3rd command in history

```bash
!-3
```

This will execute the 3rd to last command in history

```bash
!echo
```

This will execute the most recent command that started with *echo*

```bash
!?printf
```

This will execute the most recent command that contained *printf*

```bash
echo !#
```

This will print the curent command that you have typed hence `echo echo`

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Command Process Substitution](./command-process-substitution.md) | [Subshells](./subshells.md) →
