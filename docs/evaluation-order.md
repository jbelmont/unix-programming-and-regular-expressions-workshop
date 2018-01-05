## Unix Programming and Regular Expressions Workshop - Evaluation Order

## Sections:

* [Shell Evaluation Order](#shell-evaluation-order)
* [Short Circuit Shell Evaluation Order](#short-circuit-shell-evalution-order)
* [Eval Command Description](#eval-command-description)
* [Eval Command Short Circuit](#eval-command-short-circuit)
* [Eval Command Examples](#eval-command-examples)
* [Importance of Shell Evaluation Order](#importance-of-shell-evaluation-order)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Shell Evaluation Order

1. Token Recognition 
    1. Words in the command line are split into **tokens** separated by metacharacters
    2. White Space ` `, `;` (Semicolon), `|`, `<`, `>`, `\`, 
    3. Substitution can occur here like `$HOME/myfile`

2. Shell then looks if there is an opening *keyword*
  if **keyword**
    then the shell knows it is a compound command and that it needs to collect all of the  actual command before executing
  else
    if **middle or final keyword** // `elif` or `fi`
      then keep going and collect all of the command or finish everything and go to **step 3**
    else
      a syntax error has occurred and shell exits or in a interactive session just go back to shell prompt

3. Is the word an *alias* ?
    if token an `alias` 
      then expand alias and go to step 1
        `alias ll='ls -lh'` the shell would expand *ll* in this case to `ls -lh`
    else
      continue on to step 4

4. Tilde Substitution occurs in following situations:
    1. On the start of a word
    2. After `:`, `:-` in variable assignment as we mentioned previously
    3. In expressions like `${somevar operation aword}`

5. Parameter or aka variable expansion
    1. `NAME=james ; echo $NAME`
    2. Here the `NAME` variable is expanded to james

6. Command substitution
    1. Old style with backticks \`\`
    2. New style with `$()`

7. Arithmetic expansion
    1. `$(())`

8. Split results of Step 5, 6, 7 onto characters in the [Internal Field Separator aka $IFS variable](https://en.wikipedia.org/wiki/Internal_field_separator)

    1. For many command line interpreters ("shell") of Unix operating systems, the internal field separator (abbreviated IFS) refers to a variable which defines the character or characters used to separate a pattern into tokens for some operations.
  
    2. IFS typically includes the space, tab, and the newline.

    3. This step is distinguished by steps you can control as shell programmer
  
    4. if there is whitespace then each *run* of whitespace will separate fields
  
    5. else each non whitespace will delimit a field

9. Filename generation / Wilcard Expansion

10. In a series of tokens then look at first word
  
  1. Keywords will be found but really any keywords have already been found
  2. Look at special builtins: `break, continue`
  3. Functions
  4. Regular builtins `cd, echo`

11. Setup Input and Output I/0 redirections that were saved from step 1 and finally to run the shell program

#### Short Circuit Shell Evaluation Order

* Anything in single quotes ' ' is taken literally and shell program execution goes straight to step 11

* Anything in double quotes " " goes from token recognition Step 1 ==> Step 5 (Variable Expansion)

* If you use the *eval* command
  then shell program execution will go from Step 11 ==> Step 1

#### Eval Command Description

`eval: eval [arg ...]`

* Execute arguments as a shell command.

* Combine ARGs into a single string, use the result as input to the shell, and execute the resulting commands.

* Exit Status:
  * Returns exit status of command or success if command is null.

#### Eval Command Short Circuit

Eval will rerun each of the steps given previously

The main purpose of eval is to build up a command in a string and then to run it

```bash
mycommand="echo $?"
if [ "$SOMEVAR" -eq "$ANOTHERVAR" ]; then
  mycommand="$mycommand | less" 
fi
eval "$mycommand"
```

When we run `eval` then command will be run albeit this is a senseless case of eval

#### Eval Command Examples

```bash
testcommand="man test"
command="$testcommand | more"
```

```bash
echo $command
```

This will just echo the command and treat values literally but not execute it

```bash
eval $command
```

This will actually execute the $command and run the man page through the more utility

```bash
cd scripts/eval-order
```

```bash
mkdir tmp
```

```bash
cd tmp
```

```bash
cat > tempFile
Some temporary file
Just a test here
```

Press Control D to redirect stdin into tempFile

```bash
read -p 'Enter something here: ' something
```

Here we are getting user supplied input

I put in `rm *` as my input

```bash
set -x
```

Set execution tracing so you see what is happening

```bash
eval $something
```

Notice here that tempFile has been deleted

```bash
ls
```

#### Importance of Shell Evaluation Order

You need to understand shell evalution order in order to write correctly working shell scripts

Shell Interactions can be tricky to see when they occur:

* Substitutions can occur during token parsing
* Nested shell constructs happen during command substitution
* Substitutions can occur in double quoted contexts

Using *eval** can provide a mechanism to short circuit shell evalution order

**An important caveat is that using eval can be a possible security vulnerability as you see in the example shown above*

**Don't ever run eval with user supplied input because a malicious user could be attempting a malicious attack**

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [History Substitution](./history-substitution.md) | [Subshells](./subshells.md) →
