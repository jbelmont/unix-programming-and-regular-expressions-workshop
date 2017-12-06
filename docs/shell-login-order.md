## Unix Programming and Regular Expressions Workshop - Shell Login Order

## Sections:

* [Shell Configuration Files](#shell-configuration-files)
* [Configuration files in Home Directory](#configuration-files-in-home-directory)
* [Shell Login Order](#shell-login-order)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Shell Configuration Files

Here is a the list of shell configuration files:

* `/etc/profile` Configuration File
* `/etc/profile.d` Directory with Configuration Files
  * `/etc/profile.d/dircolors.sh`
  * `/etc/profile.d/extrapaths.sh`
  * `/etc/profile.d/readline.sh`
  * `/etc/profile.d/umask.sh`
  * `/etc/profile.d/X.sh`
  * `/etc/profile.d/i18n.sh`
* `/etc/bashrc` 
* `/etc/zshrc`
* `/etc/zprofile`
* `~/.bash_profile`
* `~/.bash_login`
* `~/.bash_logout`
* `~/.bashrc`
* `~/.bashenv`
* `~/.zprofile`
* `~/.profile`
* `~/.zshrc`
* `~/.zshenv`
* `~/.zlogin`
* `~/.zlogout`

There are other configuration files for the other shells: 

* `fish`
* `csh`
* `tcsh`
* `ksh`
* `sh`

###### /etc/profile

This file usually set the shell variables `PATH`, `USER`, `MAIL`, `HOSTNAME` and `HISTSIZE`.

This file starts by setting up some helper functions and some basic parameters

Here is the contents of `/etc/profile` in the Ubuntu Linux Distribution

```bash
# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "$PS1" ]; then
  if [ "$BASH" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
```

Here are the contents in Mac OS X

```bash
# System-wide .profile for sh(1)

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi
```

###### /etc/profile.d

All large user and site specific environment customization should be placed in this directory.

Here are the configuration files in this directory:

* `/etc/profile.d/dircolors.sh`
* `/etc/profile.d/extrapaths.sh`
* `/etc/profile.d/readline.sh`
* `/etc/profile.d/umask.sh`
* `/etc/profile.d/X.sh`
* `/etc/profile.d/i18n.sh`

###### /etc/profile.d/dircolors.sh

The `/etc/profile.d/dircolors.sh` script uses the `~/.dircolors` and `/etc/dircolors` files to control the colors of file names in a directory listing. 

They control colorized output of things like `ls --color`. 

The explanation of how to initialize these files is at the end of this section.

###### /etc/profile.d/extrapaths.sh

This script adds several useful paths to the PATH and PKG_CONFIG_PATH environment variables.

This will allow executables in the current working directory to be executed without specifiying a ./, however you are warned that this is generally considered a security hazard

This script adds some useful paths to the PATH and can be used to customize other PATH related environment variables (e.g. LD_LIBRARY_PATH, etc) that may be needed for all users.

Sample Entry for this configuration file

```bash
if [ -d /usr/local/lib/pkgconfig ] ; then
        pathappend /usr/local/lib/pkgconfig PKG_CONFIG_PATH
fi
if [ -d /usr/local/bin ]; then
        pathprepend /usr/local/bin
fi
if [ -d /usr/local/sbin -a $EUID -eq 0 ]; then
        pathprepend /usr/local/sbin
fi

# Set some defaults before other applications add to these paths.
pathappend /usr/share/man  MANPATH
pathappend /usr/share/info INFOPATH
```

###### /etc/profile.d/readline.sh

This script sets up the default inputrc configuration file. 

If the user does not have individual settings, it uses the global file.

Here is a sample entry:

```bash
# Setup the INPUTRC environment variable.
if [ -z "$INPUTRC" -a ! -f "$HOME/.inputrc" ] ; then
        INPUTRC=/etc/inputrc
fi
export INPUTRC
```

###### /etc/profile.d/umask.sh

Setting the umask value is important for security. 

Here the default group write permissions are turned off for system users and when the user name and group name are not the same.

Here is a sample entry:

```bash
# By default we want the umask to get set.
if [ "$(id -gn)" = "$(id -un)" -a $EUID -gt 99 ] ; then
  umask 002
else
  umask 022
fi
```

###### /etc/profile.d/X.sh

If X is installed, the PATH and PKG_CONFIG_PATH variables are also updated.

Here is a sample entry:

```bash
if [ -x /usr/X11R6/bin/X ]; then
        pathappend /usr/X11R6/bin
fi
if [ -d /usr/X11R6/lib/pkgconfig ] ; then
        pathappend /usr/X11R6/lib/pkgconfig PKG_CONFIG_PATH
fi
```

###### /etc/profile.d/i18n.sh

This script sets an environment variable necessary for native language support.

Here is a sample entry:

```bash
# Set up i18n variables
export LANG=<ll>_<CC>.<charmap><@modifiers>
```

#### /etc/bashrc

This `/etc/bashrc` file is meant for setting command aliases and functions used by bash shell users.

Here is a sample bashrc from ubuntu `/etc/bash.bashrc

```bash
# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *|*\ sudo\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.

	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
```

###### /etc/zshrc

This `/etc/zshrc` file is meant for setting command aliases and functions used by zsh shell users.

Here is a sample:

```bash
# Correctly display UTF-8 with combining characters.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
	setopt combiningchars
fi

disable log
```

###### /etc/zprofile

Used for executing user's commands at start, will be sourced when starting as a login shell.

#### Configuration files in Home Directory

Shell Users can define these configuration files in their home directory which will override the system level configuration files `/etc` directory

Linux users home directory path is usually like this: `/home/jbelmont`

Mac OS X Users home directory is like this: `/Users/marcelbelmont`

You can create the configuration files by using the `touch` command and set your own local configuration that you want to override with the system level configuration

#### Shell Login Order

If Bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option


Bash will first read and execute commands from the file `/etc/profile`

Then if that `/etc/profile` exists. 

After reading `/etc/profile`, it looks for `~/.bash_profile`, `~/.bash_login`, and `~/.profile`, in that order, and reads and executes commands from the first one that exists and is readable. 

The --noprofile option may be used when the shell is started to inhibit this behavior.

Here is a zsh chart with login order

| Shell | Interactive Login | Interactive non-login | Script |
| --- | --- | --- | --- |
| <code>/etc/zshenv</code> | A | A | A |
| <code>~/.zshenv</code> | B | B | B |
| <code>/etc/zprofile</code> | C |  |  |
| <code>~/.zprofile</code> | D | | |
| <code>/etc/zshrc</code> | E | C | |
| <code>~/.zshrc</code> | F | D | |
| <code>/etc/zlogin</code> | G | | |
| <code>~/.zlogin</code> | H | | |
| <code>~/.zlogout</code> | I | | |
| <code>/etc/zlogout</code> | J | | |

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Building Command line applications](./building-command-line-applications.md) | [Network Utilities](./network-utilities.md) →
