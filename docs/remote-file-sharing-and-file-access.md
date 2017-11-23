## Unix Programming and Regular Expressions Workshop - Remote File Sharing and File Access

## Sections:

* [OSI Model](#osi-model)
* [Openssh replacement tools](#openssh-replacement-tools)
* [telnet Command Description](#telnet-command-description)
* [telnet Command Options](#telnet-command-options)
* [telnet Command Examples](#telnet-command-examples)
* [ftp Command Description](#ftp-command-description)
* [ftp Command Options](#ftp-command-options)
* [ftp Command Examples](#ftp-command-examples)
* [ssh Command Description](#telnet-command-description)
* [ssh Command Options](#telnet-command-options)
* [ssh config options](#ssh-config-options)
* [Requirements to Run Secure shell](#requirements-to-run-secure-shell)
* [ssh Command Examples](#telnet-command-examples)
* [sftp Command Description](#sftp-command-description)
* [sftp Command Options](#sftp-command-options)
* [sftp Command Examples](#sftp-command-examples)
* [scp Command Description](#scp-command-description)
* [scp Command Options](#scp-command-options)
* [scp Command Examples](#scp-command-examples)
* [rsync Command Description](#rsync-command-description)
* [rsync Command Options](#rsync-command-options)
* [rsync Command Examples](#rsync-command-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

### OSI Model

[OSI Model](https://en.wikipedia.org/wiki/OSI_model)

The Open Systems Interconnection model (OSI model) is a conceptual model that characterizes and standardizes the communication functions of a telecommunication or computing system without regard to their underlying internal structure and technology. 

Its goal is the interoperability of diverse communication systems with standard protocols. The model partitions a communication system into abstraction layers. 

The original version of the model defined seven layers.

| Type Layer | OSI Layer | Protocol Data Unit (PDU) | Function |
| --- | --- | --- | --- |
| Host Layer| 7. Application | Data | High-level APIs, including resource sharing, remote file access |
| Host Layer| 6. Presentation | Data | Translation of data between a networking service and an application; including character encoding, data compression and encryption/decryption |
| Host Layer| 5. Session | Data | Managing communication sessions, i.e. continuous exchange of information in the form of multiple back-and-forth transmissions between two nodes |
| Host Layer| 4. Transport | Segment (TCP) / Datagram (UDP) | Reliable transmission of data segments between points on a network, including segmentation, acknowledgement and multiplexing |
| Media Layer| 3. Network | Packet | Structuring and managing a multi-node network, including addressing, routing and traffic control |
| Media Layer| 2. Data Link | Frame | Reliable transmission of data frames between two nodes connected by a physical layer |
| Media Layer| 1. Physical | Bit | Transmission and reception of raw bit streams over a physical medium |

Layer 5: Session Layer:

* The session layer controls the dialogues (connections) between computers. 

* It establishes, manages and terminates the connections between the local and remote application. 

* It provides for full-duplex, half-duplex, or simplex operation, and establishes checkpointing, adjournment, termination, and restart procedures. 

* The OSI model made this layer responsible for graceful close of sessions, which is a property of the Transmission Control Protocol, and also for session checkpointing and recovery, which is not usually used in the Internet Protocol Suite. 

* The session layer is commonly implemented explicitly in application environments that use remote procedure calls.

#### Openssh replacement tools

OpenSSH is a suite of secure network connectivity tools that replaces:

* `telnet` / `telnetd` 
* `rcp`
* `rsh` / `rshd`
* `rlogin` / `rlogind`
* `ftp` / `ftpd`

None of these older tools encrypt traffic, everything comes over clear text and they can be sniffed with tools like [Wireshark](https://www.wireshark.org/docs/wsug_html_chunked/ChapterIntroduction.html#ChIntroWhatIs)

Unlike the tools they replace, OpenSSH tools encrypt all traffic, including passwords. 

Openssh tools can thwart attackers who attempt to eavesdrop, hijack connections, and steal passwords.

#### telnet Command Description

telnet -- user interface to the TELNET protocol

The telnet command is used to communicate with another host using the TELNET protocol.  

If telnet is invoked without the host argument, it enters command mode, indicated by its prompt (`telnet`).  

In this mode, it accepts and executes the commands listed below.  

If it is invoked with arguments, it performs an open command with those arguments.

#### telnet Command Option

`telnet` command options:

* `-4` Forces telnet to use IPv4 addresses only.

* `-6` Forces telnet to use IPv6 addresses only.

* `-8` Specifies an 8-bit data path.  
  * This causes an attempt to negotiate the TELNET BINARY option on both input and output.

* `-E` Stops any character from being recognized as an escape character.

* `-F` If Kerberos V5 authentication is being used, the -F option allows the local credentials to be forwarded to the remote system, including any credentials that have already been forwarded into the local environment.

* `-K` Specifies no automatic login to the remote system.

* `-L` Specifies an 8-bit data path on output.  This causes the BINARY option to be negotiated on output.

* `-N` Prevents IP address to name lookup when destination host is given as an IP address.

* `-S` tos  Sets the IP type-of-service (TOS) option for the telnet connection to the value tos, which can be a numeric TOS value or, on systems that support it, a symbolic TOS name found in the /etc/iptos file.

* `-X` atype
  * Disables the atype type of authentication.

* `-a` Attempt automatic login.  
  * This is now the default, so this option is ignored.  Currently, this sends the user name via the USER variable of the ENVIRON option if supported by the remote system.  The name used is that of the current user as returned by getlogin if it agrees with the current user ID, otherwise it is the name associated with the user ID.

* `-c` Disables the reading of the user's .telnetrc file.

* `-d` Sets the initial value of the debug toggle to TRUE.

**Read the Fine Manual** for more options

#### telnet Command Examples

```bash
telnet www.google.com 80
```

If you enter this command you should see 

```bash
Trying 173.194.206.99...
Connected to www.google.com.
Escape character is '^]'.
```

If you press **Control ]** then you will get into telnet prompt

You can also get into prompt by simply typing in **telnet**

```bash
telnet
```

This will start an interactive telnet session with **telnet** prompt

Type *?* to see the available options

```bash
telnet towel.blinkenlights.nl
```

This will start in an interactive telnet session to watch star wars

In order to quit press **Control ]** and then type *quit* command to exit telnet session

```bash
telnet
```

this gets you into interactive telnet prompt

```bash
o telehack.com
```

This will get telnet session started for telehack.com

type in **eliza** to get session with a computerized Psychotherapist

Press **Control ]** to get back into telnet prompt

Type **quit** command to exit telnet


```bash
telnet freechess.org 5000
```

This will take you into telnet session with freechess.org

Type **guest** if you aren't a registered user

Type **quit** to get out or type **?** to see all the options

#### ftp Command Description

ftp -- Internet file transfer program

ftp is the user interface to the Internet standard File Transfer Protocol.  

The program allows a user to transfer files to and from remote network site.

The last five arguments will fetch a file using the FTP or HTTP protocols, or by direct copying, into the current directory.  

This is ideal for scripts.

#### ftp Command Options

`ftp` command options:

* `-4` Forces ftp to only use IPv4 addresses.

* `-6` Forces ftp to only use IPv6 addresses.

* `-A` Force active mode ftp.  
    * By default, ftp will try to use passive mode ftp and fall back to active mode if passive is not supported by the server.  
    * This option causes ftp to always use an active connection.  It is only useful for connecting to very old servers that do not implement passive mode properly.

* `-a` Causes ftp to bypass normal login procedure, and use an anonymous login instead.

* `-d` Enables debugging.

* `-e` Disables command line editing.  This is useful for Emacs ange-ftp mode.

* `-f` Forces a cache reload for transfers that go through the FTP or HTTP proxies.

* `-g` Disables file name globbing.

* `-i` Turns off interactive prompting during multiple file transfers.

**Read the Fine Manual** for more options

#### ftp Command Examples

```bash
ftp domain.com
```

This won't work but is an example of accessing a site

```bash
ftp > ls
```

This will list files in the remote directory

```bash
ftp
```

This will get you into an interactive ftp session

```bash
ftp > ?
```

This will out all the available ftp command in an interactive session

```bash
ftp > ? lcd
lcd        	change local working directory
```

This prints out a description of the *ftp* command **lcd**

#### ssh Command Description

[SSH Description](https://en.wikipedia.org/wiki/Secure_Shell)

ssh -- OpenSSH SSH client (remote login program)

ssh (SSH client) is a program for logging into a remote machine and for executing commands on a remote machine.  

It is intended to provide secure encrypted communications between two untrusted hosts over an insecure network.  

X11 connections, arbitrary TCP ports and UNIX-domain sockets can also be forwarded over the secure channel.

ssh connects and logs into the specified hostname (with optional user name).  

The user must prove his/her identity to the remote machine using one of several methods.

#### ssh Command Options

`ssh` command options:

* `-1` Use protocol version 1 only.

* `-2` Use protocol version 2 only.

* `-4` Use IPv4 addresses only.

* `-6` Use IPv6 addresses only.

* `-A` Enable forwarding of the authentication agent connection.

* `-a` Disable forwarding of the authentication agent connection.

* `-C` Use data compression

* `-c` cipher_spec Selects the cipher specification for encrypting the session.

* `-D` [bind_address:]port Dynamic application-level port forwarding. This allocates a socket to listen to port on the local side. When a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine.

* `-E` log_file Append debug logs to log_file instead of standard error.

* `-F` config file Specifies a per-user configuration file. The default for the per-user configuration file is ~/.ssh/config.

* `-g` Allows remote hosts to connect to local forwarded ports.

* `-i` identity_file A file from which the identity key (private key) for public key authentication is read.

* `-J` [user@]host[:port] Connect to the target host by first making a ssh connection to the pjump host[(/iam/jump-host) and then establishing a TCP forwarding to the ultimate destination from there.

* `-l` login_name Specifies the user to log in as on the remote machine.

* `-p` port Port to connect to on the remote host.

* `-q` Quiet mode.

* `-V` Display the version number.

* `-v` Verbose mode.

* `-X` Enables X11 forwarding.

#### ssh config options

```yml
Host firsthost
    SSH_OPTION_1 custom_value
    SSH_OPTION_2 custom_value
    SSH_OPTION_3 custom_value

Host secondhost
    ANOTHER_OPTION custom_value

Host *host
    ANOTHER_OPTION custom_value

Host *
    CHANGE_DEFAULT custom_value
```

All the available options can be found by *Reading the Fine Manual*.

You can do `man ssh_config` for all the available options for the client in `/etc/ssh/ssh_config` or you can create your own options in `~/.ssh/config` for user options

#### Requirements to Run Secure shell

To run a secure shell on or securely copy a file to or from a remote system you must meet the following requirements:

* The remote system must be running the OpenSSH daemon (sshd)
* There needs to be an account on the remote system
* The SSH server must positively identify itself to the client

```bash
ls -al ~/.ssh
```

I have the following in the `~/.ssh` directory:

```bash
total 16
drwx------    5 marcelbelmont  170 Oct  3  2016 .
drwxr-xr-x+ 163 marcelbelmont 5542 Nov 22 14:31 ..
-rw-------    1 marcelbelmont 1675 Sep 19  2016 id_rsa
-rw-r--r--    1 marcelbelmont  421 Sep 19  2016 id_rsa.pub
-rw-r--r--    1 marcelbelmont 4752 Oct 21 08:09 known_hosts
```

If you don't have any `ssh` keys or want a new key then create another key by doing the following command:

```bash
ssh-keygen -t ecdsa -b 521 -C "johnrambo@hero.net"
```

Here we are generating a new key using `ecdsa` type key with key length of *521* bits and with a comment of email type of "johnrambo@hero.net"

Here is the sample output for the command given above:

```bash
Generating public/private ecdsa key pair.
Enter file in which to save the key (/Users/marcelbelmont/.ssh/id_ecdsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/marcelbelmont/.ssh/id_ecdsa.
Your public key has been saved in /Users/marcelbelmont/.ssh/id_ecdsa.pub.
The key fingerprint is:
SHA256:LF3IksGBcXTYv9mDj4KD33oMOb0kfX+MP5Heo/FVshU johnrambo@hero.net
The key's randomart image is:
+---[ECDSA 521]---+
|    .==+.        |
|    ..o=..       |
|      o o..    E |
|       + ..     .|
|      .+S  =  ..o|
|      =.+ = o o+.|
|     . B o + *.o.|
|    . o.= . + B.o|
|     .o+..   +oo.|
+----[SHA256]-----+
```

```bash
eval "$(ssh-agent -s)"
```

```bash
ssh-add ~/.ssh/id_rsa
```

Here we add private key to ssh agent

You can copy keys to be used with ssh using `ssh-copy-id` command

###### ssh-copy-id command description

ssh-copy-id -- use locally available keys to authorise logins on a remote machine

ssh-copy-id is a script that uses ssh(1) to log into a remote machine (presumably using a login password, so password authentication should be enabled, unless you've done some clever use of multiple identities).  

It assembles a list of one or more fingerprints (as described below) and tries to log in with each key, to see if any of them are already installed (of course, if you are not using ssh-agent(1) this may result in you being repeatedly prompted for pass-phrases).  

It then assembles a list of those that failed to login, and using ssh, enables logins with those keys on the remote server.  

By default it adds the keys by appending them to the remote user's ~/.ssh/authorized_keys (creating the file, and directory, if necessary).  It is also capable of detecting if the remote system is a NetScreen, and using its `set ssh pka-dsa key ...' command instead

###### ssh-copy-id command options

`ssh-copy-id` command options:

* `-i` identity_file
    * Use only the key(s) contained in identity_file (rather than looking for identities via ssh-add(1) or in the default_ID_file).
    * If the filename does not end in .pub this is added.  If the filename is omitted, the default_ID_file is used.

* `-f` Forced mode: doesn't check if the keys are present on the remote server.  This means that it does not need the private key.

* `-n` do a dry-run.  Instead of installing keys on the remote system simply prints the key(s) that would have been installed.

* `-h`, `-?`  Print Usage summary

* `-p` port, `-o` ssh_option
    * These two options are simply passed through untouched, along with their argument, to allow one to set the port or other ssh(1) options, respectively.

Here is a sample **ssh-copy-id** command that automates copying keys

```bash
ssh-copy-id jbelmont@104.131.117.137
```

This will fail for my system because I have already uploaded my keys to the system

#### ssh Command Examples

```bash
ssh jbelmont@104.131.117.137
```

Here I am `ssh`ing into a linux box that I have. Notice here that I have specified a username before the **IP Address**

```bash
ssh -l jbelmont 104.131.117.137
```

Here is the same command but using the `-l` (login name) option

```bash
ssh -i "workshop.pem" ubuntu@ec2-54-165-173-39.compute-1.amazonaws.com touch temp1.txt
```

Here I login into my ec2 instance and create a file and then logout

```bash
ssh -i "workshop.pem" ubuntu@ec2-54-165-173-39.compute-1.amazonaws.com echo "something" > temp2.txt
``` 

Here I am `echo`ing something to stdout and then creating a file in my local file

```bash
ssh -i "workshop.pem" ubuntu@ec2-54-165-173-39.compute-1.amazonaws.com 'echo "something" > temp2.txt'
```

Here because we quoted `ssh` command part the file is created in the remote shell instead of the local shell

```bash
cat scripts/remote-file-sharing-and-file-access/temp1.txt | ssh -i "~/marcel-aws/workshop.pem" ubuntu@ec2-54-165-173-39.compute-1.amazonaws.com diff - temp2.txt
```

Here we pipe the output of temp1.txt into ssh command stdin to the **diff** utility and compare against temp2.txt

#### sftp Command Description

sftp -- secure file transfer program

sftp is an interactive file transfer program, similar to ftp, which performs all operations over an encrypted ssh(1) transport.  

It may also use many features of ssh, such as public key authentication and compression.  sftp connects and logs into the specified host, then enters an interactive command mode.

The second usage format will retrieve files automatically if a non-interactive authentication method is used; otherwise it will do so after successful interactive authentication.

The third usage format allows sftp to start in a remote directory.

The final usage format allows for automated sessions using the -b option.  

In such cases, it is necessary to configure non-interactive authentication to obviate the need to enter a password at connection time.

Since some usage formats use colon characters to delimit host names from path names, IPv6 addresses must be enclosed in square brackets to avoid ambiguity.

#### sftp Command Options

`sftp` command options:

* `-4` Forces sftp to use IPv4 addresses only.

* `-6` Forces sftp to use IPv6 addresses only.

* `-a` Attempt to continue interrupted transfers rather than overwriting existing partial or complete copies of files.  
    * If the partial contents differ from those being transferred, then the resultant file is likely to be corrupt.

* `-B` buffer_size
    * Specify the size of the buffer that sftp uses when transferring files.  Larger buffers require fewer round trips at the cost of higher memory consumption.  The default is 32768 bytes.

* `-b` batchfile
    * Batch mode reads a series of commands from an input batchfile instead of stdin.  Since it lacks user interaction it should be used in conjunction with non-interactive authentication.

* `-C` Enables compression (via ssh's -C flag).

* `-c` cipher
    * Selects the cipher to use for encrypting the data transfers.  This option is directly passed to ssh.

* `-D` sftp_server_path
    * Connect directly to a local sftp server (rather than via ssh.  This option may be useful in debugging the client and server.

* `-F` ssh_config
    * Specifies an alternative per-user configuration file for ssh(1).  This option is directly passed to ssh.

* `-f` Requests that files be flushed to disk immediately after transfer.  When uploading files, this feature is only enabled if the server implements the "fsync@openssh.com" extension.

* `-i` identity_file
    * Selects the file from which the identity (private key) for public key authentication is read.  This option is directly passed to ssh

#### sftp Command Examples

```bash
sftp -i "~/marcel-aws/workshop.pem" ubuntu@ec2-54-165-173-39.compute-1.amazonaws.com
```

Here I am connecting to my ec2 instance using `sftp` command.

```bash
sftp> ?
```

Here I entered a `?` to get all the available commands

```bash
sftp> lls
```

Here I am printing out the files in my local directory and here is the output

```bash
CONTRIBUTING.md  LICENSE  README.md  SUMMARY.md  TEST.md  _book  book.json  data  docs	images	node_modules  object-files  package.json  scripts
```

```bash
put TEST.md
```

I am uploading **TEST.md** into the remote server here

**Read the Fine Manual** for more options with sftp

#### scp Command Description

scp -- secure copy (remote file copy program)

scp copies files between hosts on a network.  

It uses ssh for data transfer, and uses the same authentication and provides the same security as ssh.  

scp will ask for passwords or passphrases if they are needed for authentication

File names may contain a user and host specification to indicate that the file is to be copied to/from that host.  

Local file names can be made explicit using absolute or relative pathnames to avoid scp treating file names containing `:` as host specifiers.  

Copies between two remote hosts are also permitted

#### scp Command Options

`scp` command options:

* `-3` Copies between two remote hosts are transferred through the local host.  Without this option the data is copied directly between the two remote hosts.  Note that this option disables the progress meter.

* `-4` Forces scp to use IPv4 addresses only.

* `-6` Forces scp to use IPv6 addresses only.

* `-B` Selects batch mode (prevents asking for passwords or passphrases).

* `-C` Compression enable.  Passes the -C flag to ssh(1) to enable compression.

* `-c` cipher
    * Selects the cipher to use for encrypting the data transfer.  This option is directly passed to ssh(1).

* `-F` ssh_config
    * Specifies an alternative per-user configuration file for ssh.  This option is directly passed to ssh(1).

* `-i` identity_file
    * Selects the file from which the identity (private key) for public key authentication is read.  This option is directly passed to ssh(1).

* `-l` limit
    * Limits the used bandwidth, specified in Kbit/s.

#### scp Command Examples

```bash
scp -vvv SUMMARY.md  jbelmont@104.131.117.137:/home/jbelmont
```

Here I logged out a very verbose output for `scp` 

This will upload SUMMARY.md into my remote ubuntu server

```bash
scp -v jbelmont@104.131.117.137:/home/jbelmont/random.txt .
```

Here I am passing verbose output and copying a file from my remote server into my local directory

You can also pass the `-r` to recursively copy directories with `scp` command

#### rsync Command Description

rsync - a fast, versatile, remote (and local) file-copying tool

Rsync  is a fast and extraordinarily versatile file copying tool.  

It can copy locally, to/from another host over any remote shell, or to/from a remote rsync daemon.  

It offers a large number of options that control every aspect of its behavior and permit very flexible specification  of the set of files to be copied.  

It is famous for its delta-transfer algorithm, which reduces the amount of data sent over the network by sending only the differences between the source files and the existing files in the destination.  

Rsync is  widely used for backups and mirroring and as an improved copy command for everyday use.

Rsync  finds  files that need to be transferred using a "quick check" algorithm (by default) that looks for files that have changed in size or in last-modified time.  

Any changes in the other preserved attributes (as requested by options) are made  on  the  destination file directly when the quick check indicates that the file's data does not need to be updated.

#### rsync Command Options

`rsync` command options: 

* `-v`, `--verbose` increase verbosity
* `--info=FLAGS` fine-grained informational verbosity
* `--debug=FLAGS` fine-grained debug verbosity
* `--msgs2stderr` special output handling for debugging
* `-q`, `--quiet` suppress non-error messages
* `--no-motd` suppress daemon-mode MOTD (see caveat)
* `-c`, `--checksum` skip based on checksum, not mod-time & size
* `-a`, `--archive` archive mode; equals -rlptgoD (no -H,-A,-X)
* `--no-OPTION` turn off an implied OPTION (e.g. --no-D)
* `-r`, `--recursive` recurse into directories

**Read the Fine Manual** for more optionscontent

#### rsync Command Examples

```bash
rsync -zvh SUMMARY.md /tmp/
```

Here we sync a local file **SUMMARY.md** into our local `/tmp` directory

```bash
rsync -zvh SUMMARY.MD jbelmont@104.131.117.137
```

Here we are uploading a local file to remote server.

The `-z` option will compress output as it goes over the wire, the `-v` options will print extra verbose output and `-h` will show output in human readable format.

There are many more options to do with `rsync` command

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Working with Files](./working-with-files.md) | [Building Command line applications](./building-command-line-applications.md) →
