## Unix Programming and Regular Expressions Workshop - Remote File Sharing and File Access

## Sections:

* [OSI Model](#osi-model)
* [telnet Command Description](#telnet-command-description)
* [telnet Command Options](#telnet-command-options)
* [telnet Command Examples](#telnet-command-examples)
* [ssh Command Description](#telnet-command-description)
* [ssh Command Options](#telnet-command-options)
* [ssh Command Examples](#telnet-command-examples)
* [ftp Command Description](#telnet-command-description)
* [ftp Command Options](#telnet-command-options)
* [ftp Command Examples](#telnet-command-examples)
* [sftp Command Description](#telnet-command-description)
* [sftp Command Options](#telnet-command-options)
* [sftp Command Examples](#telnet-command-examples)
* [scp Command Description](#telnet-command-description)
* [scp Command Options](#telnet-command-options)
* [scp Command Examples](#telnet-command-examples)
* [rsync Command Description](#telnet-command-description)
* [rsync Command Options](#telnet-command-options)
* [rsync Command Examples](#telnet-command-examples)
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

content

#### ssh Command Description

content

#### ssh Command Options

content

#### ssh Command Examples

content

#### ftp Command Description

content

#### ftp Command Options

content

#### ftp Command Examples

content

#### sftp Command Description

content

#### sftp Command Options

content

#### sftp Command Examples

content

#### scp Command Description

content

#### scp Command Options

content

#### scp Command Examples

content

#### rsync Command Description

content

#### rsync Command Options

content

#### rsync Command Examples

content

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Working with Files](./working-with-files.md) | [Building Command line applications](./building-command-line-applications.md) →
