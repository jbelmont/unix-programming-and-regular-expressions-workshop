## Unix Programming and Regular Expressions Workshop - Subshells

## Sections:

* [Subshells Description](#subshells-description)
* [Code Blocks](#code-blocks)
* [Subshell Examples](#subshell-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Subshells Description

If you enclose a group of commands in parenthesis then this runs the commands in a *subshell* environment

The Shell state will be different than the parent

For example the current directory and variable values will not be the same

But values such as `$$` which is the current Process ID will be the same

Subshells are almost always executed in a separate process

The Parentheses are specially treated

#### Code Blocks

Curly Braces `{ ... }` enclose a code block

The braces are recognized in keyword contexts

Make sure to put a semicolon or newline before the closing brace

Any state will be shared with the main script 

Like the current directory or variables

#### Subshell Examples

```bash
tar -cf - . | (cd ~/tmp/copy ; tar -xpvf -)
```

This will use the current directory contents and run the *tar* command but this will be piped into a subshell process

```bash
echo $$
```

This will print the current process ID for the shell

```bash
(echo $$)
```

This will print the same number because it is shared between parent shell and subshell

```bash
test -d ~/tmp/copy && { cd ~/tmp/copy ; }
```

This will test if the directory *~/tmp/copy* exists and if so will execute within the code block

```bash
test -d ~/tmp/copy && ( cd ~/tmp/copy ; pwd )
```

Notice with this command the subshell does indeed go to *~/tmp/copy* but the parent does not actually do so

```bash
for i in this is a code block here
{
echo $i
}
```

This for loop is run in a code block

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Evaluation Order](./evaluation-order.md) | [Shell Functions](./shell-functions.md) →
