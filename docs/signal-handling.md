## Unix Programming and Regular Expressions Workshop - Signal Handling

## Sections:

* [Signals](#signals)
* [Jobs Command Description](#jobs-command-description)
* [Jobs Command Options](#jobs-command-options)
* [bg command](#bg-command)
* [fg command](#fg-command)
* [Jobs, fg, bg command examples](#jobs\,-fg\,-bg-command-examples)
* [Kill Command Description](#kill-command-description)
* [Kill Command Options](#kill-command-options)
* [Trap Command](#trap-command)
* [Trap Command Usage](#trap-command-usage)
* [Special Shell Signals](#special-shell-signals)
* [Trap and Kill Command Examples](#trap-and-kill-command-examples)
* [Tips for Trap and Kill Usage](#tips-for-trap-and-kill-usage)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Signals

A signal is a signal sent by the operating system to a shell process that something occurred

Signal Examples Scenarios:

* Hardware Error (floating point error, bad memory access, etc)
  * Division by zero

* Software Event (communication disconnect or hangup) 

* User Action occurred (user pressed control c, control d, etc)

Signals can be caught, ignored or left alone to behave under default behavior

The default behavior for signals can vary

Some signals are ignored but most will terminate your program unless the signal is caught

#### Jobs Command Description

jobs: jobs [-lnprs] [jobspec ...] or jobs -x command [args]

Display status of jobs.

Lists the active jobs.  JOBSPEC restricts output to that job.
Without options, the status of all active jobs is displayed.

#### Job Command Options

Job Options:

* `-l`	lists process IDs in addition to the normal information
* `-n`	lists only processes that have changed status since the last notification
* `-p`	lists process IDs only
* `-r`	restrict output to running jobs
* `-s`	restrict output to stopped jobs

If -x is supplied, COMMAND is run after all job specifications that
appear in ARGS have been replaced with the process ID of that job's
process group leader.

Exit Status:
Returns success unless an invalid option is given or an error occurs.
If -x is used, returns the exit status of COMMAND.

#### bg command

bg: bg [job_spec ...]
Move jobs to the background.

Place the jobs identified by each JOB_SPEC in the background, as if they
had been started with `&'.  If JOB_SPEC is not present, the shell's notion
of the current job is used.

Exit Status:
Returns success unless job control is not enabled or an error occurs.

#### fg command

fg: fg [job_spec]

Move job to the foreground.

Place the job identified by JOB_SPEC in the foreground, making it the
current job.  If JOB_SPEC is not present, the shell's notion of the
current job is used.

Exit Status:
Status of command placed in foreground, or failure if an error occurs.

#### Jobs, fg, bg command examples

```bash
sleep 60 &
```

Issue the sleep command for 60 seconds and send to background process

This returns the following to stdout:

*[2] 36312*

```bash
fg 2
```

Now the job has been moved to the foreground

But let us now press *Control-Z* to suspend the job and it prints out the following to stdout:

**[2]+  Stopped  sleep 60**

```bash
bg
```

Here we move the current job to the background and it prints out:

**[2]+ sleep 60 &**

#### Kill Command Description

kill -- terminate or signal a process

```bash
kill [-s signal_name] pid ...
kill -l [exit_status]
kill -signal_name pid ...
kill -signal_number pid ...
```

The kill utility sends a signal to the processes specified by the pid operands.

You send signals to a shell process using the *kill* command

Usage of *kill* command is: `kill -SIGNAL *process id* aka pid`

#### Kill Command Options

The options are as follows:

* `-s` signal_name*
  * A symbolic signal name specifying the signal to be sent instead of the default TERM.

* `-l` [exit_status]
  * If no operand is given, list the signal names; otherwise, write the signal name corresponding to exit_status.

* `-signal_name`
  * A symbolic signal name specifying the signal to be sent instead of the default TERM.

* `-signal_number`
  * A non-negative decimal integer, specifying the signal to be sent instead of the default TERM.

The following PIDs have special meanings:

-1 If superuser, broadcast the signal to all processes; otherwise broadcast to all processes belonging to the user.

Some of the more commonly used signals:

1       HUP (hang up)
2       INT (interrupt)
3       QUIT (quit)
6       ABRT (abort)
9       KILL (non-catchable, non-ignorable kill)
14      ALRM (alarm clock)
15      TERM (software termination signal)

Some shells may provide a builtin kill command which is similar or identical to this utility.  Consult the builtin manual page.

If you use `kill -l` it will list all the available signals

```bash
kill -l
```

HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ VTALRM PROF WINCH INFO USR1 USR2

Some of the signals that are sent are sent by the keyboard:

* INT is sent with keyboard press *Control-C*
* JOB Control stop with keyboard press *Control-Z*

#### Trap Command

trap: trap [-lp] [[arg] signal_spec ...]

Trap signals and other events.

Defines and activates handlers to be run when the shell receives signals or other conditions.

You can manage signals sent to a shell script using the *trap* command

Trap Options:

* `-l`	print a list of signal names and their corresponding numbers

1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
6) SIGABRT	 7) SIGEMT	 8) SIGFPE	 9) SIGKILL	10) SIGBUS
11) SIGSEGV	12) SIGSYS	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGURG	17) SIGSTOP	18) SIGTSTP	19) SIGCONT	20) SIGCHLD
21) SIGTTIN	22) SIGTTOU	23) SIGIO	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGINFO	30) SIGUSR1

* `-p`	display the trap commands associated with each SIGNAL_SPEC

Trap is used as follows:

* `trap 'command' SIGNAL_NAME`
  * Runs a command for signal

* `trap - SIGNAL_NAME`
  * Reset signals to default

* `trap '' SIGNAL_NAME`
  * Ignore signals

Signals are all names in upper case but they can be numeric for backwards compatibility

If you just use `trap` with no arguments it will print out current trap settings

#### Trap Command Usage

The first argument to trap is called the *signal handler*

The text is evaluated twice:

The first time the text is evaluated when trap itself executes to set the trap

The second time is when one of the given signals arrives

Try to use single quotes for the signal handler when you can because it will delay signal evaluation until the signal arrives which is what you usually want

#### Special Shell Signals

All shells support an *EXIT* pseudo signal which is the numeric 0 signal

The *EXIT* pseudo signal considerations:

* *EXIT* pseudeo signal occurs when a shell script exits (after any other traps)
* *EXIT* pseudeo signal will preserve the final `$?` value
  * Remember `$?` means the exit status
  * Value will change though if signal handler runs *exit*
* *EXIT* pseudeo signal is intended for clean up actions such as removing any temporary files

Bash and other bash like clone shells have **ERR** and **DEBUG** trap signals

**ERR* trap runs when a command exits with non-zero exit code

**DEBUG** trap runs before a command executes

The bash debugger is based on the **DEBUG** trap mechanism

#### Trap and Kill Command Examples

```bash
sleep 10
```

Press *Control-C* and the SIGINT signal is sent

```bash
bash
```

Here we enter a bash subshell

```bash
kill -CHILD $$
```

Here nothing will occur because the shell will ignore this signal but it is stop child subshell

```bash
PS1="> "
```

Changing the PS1 prompt to be `> `

```bash
kill -HUP $$
```

This will send a hangup signal to current shell process which happens to be the bash subshell we are in

```bash
#! /bin/bash

name="Zach"

trap "echo name is $name" EXIT

name="Marcel"

sleep 2
```

You can run the following shell script with:

```bash
./scripts/signal-handling/trap-with-quote.sh
```

Notice that this script will sleep for 2 seconds but it will print Zach and not Marcel as we would expect

The reason being is that the double quotes are evaluated when the trap command executes and what is stored in the string

```bash
#! /bin/bash

name="Zach"

trap 'echo name is $name' EXIT

name="Marcel"

sleep 2
```

The only difference in this shell script is that the trap command argument is wrapped in single quotes but because the single quotes will delay action until the trap actually runs

This key difference is the main reason single quotes are preferred for the trap command

```bash
#! /bin/bash

trap 'echo Ignoring HUP ...' HUP
trap 'echo Terminating on USR1 ... ; exit 1' USR1

while true
do
  sleep 2
  date > /dev/null
done
```

Here we have a shell script that runs 2 different trap commands but there is a while true statement continually running

```bash
./scripts/signal-handling/trap-usage.sh &
```

Here we run trap-usage in a background process

I get the following job pid

```bash
[1] 32428
```

```bash
kill -HUP 32428
```

This will print a hangup signal and continue running the script

```bash
jobs
```

This prints the following:

*[1]  + running    ./scripts/signal-handling/trap-usage.sh*

```bash
kill -USR1 32428
```

Here we send the final trap and it prints the message **Terminating on USR1 ...** and finally exits with this:

**[1]  + 32428 exit 1     ./scripts/signal-handling/trap-usage.sh**

We can also confirm it has been killed with *jobs* command

```bash
jobs
```

#### Tips for Trap and Kill Usage

* Use `trap` command to manage signals in your shell scripts and for cleanup actions
* The most important signals are:
  * EXIT
  * INT
  * HUP
  * TERM
  * QUIT
* Make sure to remember that the signal handler is evaluated twice
  * Remember that is the reason we used single quotes instead of double quotes
* Signal Numbers are still used but using the signal name is generally more readable for others to read
* Also consider writing a function for cleanup actions
* Remember that the signals primarily convey that something happened
* Signals are sent by the keyboard and by the `kill` command
* Signals can be caught, ignored or be left for default action
* Use *trap* command to manage signals in your shell scripts
* The **EXIT** pseudo signal is used for cleanup actions

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Shell Functions](./shell-functions.md) | [Working with Files](./working-with-files.md) →
