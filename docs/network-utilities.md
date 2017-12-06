## Unix Programming and Regular Expressions Workshop - Network Utilities

## Sections:

* [What are networking utilities](#what-are-networking-utilities)
* [List of Networking Utilities](#list-of-networing-utilities)
* [ping command description](#ping-command-description)
* [ping command options](#ping-command-options)
* [ping command examples](#ping-command-examples)
* [ifconfig command description](#ifconfig-command-description)
* [ifconfig command options](#ifconfig-command-options)
* [ifconfig command examples](#ifconfig-command-examples)
* [netstat command description](#netstat-command-description)
* [netstat command options](#netstat-command-options)
* [netstat command examples](#netstat-command-examples)
* [netcat command description](#netcat-command-description)
* [netcat command options](#netcat-command-options)
* [netcat command examples](#netcat-command-examples)
* [nmap command description](#nmap-command-description)
* [nmap command options](#nmap-command-options)
* [nmap command examples](#nmap-command-examples)
* [traceroute command description](#traceroute-command-description)
* [traceroute command options](#traceroute-command-options)
* [traceroute command examples](#traceroute-command-examples)
* [dig command description](#dig-command-description)
* [dig command options](#dig-command-options)
* [dig command examples](#dig-command-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### What are networking utilities

[Network Utility](https://en.wikipedia.org/wiki/Network_utility)

Network utilities are software utilities designed to analyze and configure various aspects of computer networks. 

The majority of them originated on Unix systems, but several later ports to other operating systems exist.

#### List of Networking Utilities

Common Networking Tools:

* [ping](https://en.wikipedia.org/wiki/Ping_(networking_utility)), ping a host to check connectivity (reports packet loss and latency, uses ICMP).

* [ifconfig](https://en.wikipedia.org/wiki/Network_utility) ifconfig is a system administration utility in Unix-like operating systems for network interface configuration.

* [ipconfig](https://en.wikipedia.org/wiki/Ipconfig) ipconfig (internet protocol configuration) in Microsoft Windows is a console application that displays all current TCP/IP network configuration values and can modify Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS) settings.

* [netcat](https://en.wikipedia.org/wiki/Netcat) Netcat (often abbreviated to nc) is a computer networking utility for reading from and writing to network connections using TCP or UDP.

* [netstat](https://en.wikipedia.org/wiki/Netstat), displays network connections (both incoming and outgoing), routing tables, and a number of network interface and network protocol statistics. 
  * It is used for finding problems in the network and to determine the amount of traffic on the network as a performance measurement

* [nmap](https://en.wikipedia.org/wiki/Nmap) Nmap (Network Mapper) is a security scanner, originally written by Gordon Lyon (also known by his pseudonym Fyodor Vaskovich), used to discover hosts and services on a computer network, thus building a "map" of the network.

* [traceroute](https://en.wikipedia.org/wiki/Traceroute) shows the series of successive systems a packet goes through en route to its destination on a network. 
  * It works by sending packets with sequential TTLs which generate ICMP TTL-exceeded messages from the hosts the packet passes through.

* [dig](https://en.wikipedia.org/wiki/Dig_(command)) dig (domain information groper) is a network administration command-line tool for querying Domain Name System (DNS) servers.

#### ping command description

ping -- send ICMP ECHO_REQUEST packets to network hosts

The ping utility uses the ICMP protocol's mandatory ECHO_REQUEST datagram to elicit an ICMP ECHO_RESPONSE from a host or gateway. 

ECHO_REQUEST datagrams (pings) have an IP and ICMP header, followed by a struct timeval and then an arbitrary number of pad bytes used to fill out the packet.

#### ping command options

List of `ping` options:

* -i wait Wait wait seconds between sending each packet.  
  * The default is to wait for one second between each packet.  
  * The wait time may be fractional, but only the super-user may specify values less than 0.1 second.
  * This option is incompatible with the -f option.

* -c count Stop after sending (and receiving) count ECHO_RESPONSE packets.
  * If this option is not specified, ping will operate until interrupted.  
  * If this option is specified in conjunction with ping sweeps, each sweep will consist of count packets.

* -f Flood ping. Outputs packets as fast as they come back or one hundred times per second, whichever is more.  
  * For every ECHO_REQUEST sent a period '.' is printed, while for every ECHO_REPLY received a backspace is printed.  
  * This provides a rapid display of how many packets are being dropped. 
  * Only the super-user may use this option.  
  * This can be very hard on a network and should be used with caution.

* -a Audible. Include a bell (ASCII 0x07) character in the output when any packet is received.  
  * This option is ignored if other format options are present.

* -s packetsize Specify the number of data bytes to be sent. 
  * The default is 56, which translates into 64 ICMP data bytes when combined with the 8 bytes of ICMP header data.  
  * This option cannot be used with ping sweeps.

* -W waittime Time in milliseconds to wait for a reply for each packet sent.  
  * If a reply arrives later, the packet is not printed as replied, but considered as replied when calculating statistics.

**Read the Fine Manual** for more options

### ping command examples

content

#### ifconfig command description

ifconfig -- configure network interface parameters

The ifconfig utility is used to assign an address to a network interface and/or configure network interface parameters.

#### ifconfig command options

* `-a` Display information for all network interfaces, even if they are down.

* `-s` Display a short list in a format identical to the command "netstat -i".

* `-v` Verbose mode; display additional information for certain error conditions.

* `interface` The name of the interface. This is usually a driver name followed by a unit number, for example "eth0" for the first Ethernet interface. 

* `up` This flag causes the interface to be activated. 
  * It is implicitly specified if an address is assigned to the interface.
down	This flag causes the driver for this interface to be shut down.

* `[-]arp`	Enable (or disable, if the "-" prefix is specified) the use of the ARP protocol on this interface.

* `[-]promisc`	Enable (or disable, if the "-" prefix is specified) the promiscuous mode of the interface. 
  * If promiscuous mode is enabled, all packets on the network will be received by the interface.

* `[-]allmulti`	Enable or disable all-multicast mode. If multicast mode is enabled, all multicast packets on the network will be received by the interface.

* `metric N` This parameter sets the interface metric, which is used by the interface to make routing decisions. N must be an integer between 0 and 4294967295. If you're not sure what a network metric is, or whether you should change it, you can safely leave this setting alone.

* `netmask address`	Set the IP network mask for this interface. 
  * This value defaults to the usual class A, B or C network mask (as derived from the interface IP address), but it can be set to any value.

* `add address/prefixlen`	Add an IPv6 address to an interface.

* `del address/prefixlen`	Remove an IPv6 address from an interface.

* `tunnel aa.bb.cc.dd` Create a new SIT (IPv6-in-IPv4) device, tunnelling to the given destination.

**Read the Fine Manual for more options**

#### ifconfig command examples

content

#### netstat command description

netstat -- show network status

The netstat command symbolically displays the contents of various network-related data structures.  

There are a number of output formats, depending on the options for the information presented.  

The 7 netstat command forms:

* The first form of the command displays a list of active sockets for each protocol.  

* The second form presents the contents of one of the other network data structures according to the option selected. 

* Using the third form, with a wait interval specified, netstat will continuously display the information regarding packet traffic on the configured network interfaces. 

* The fourth form displays statistics for the specified protocol or address family. 

* If a wait interval is specified, the protocol information over the last interval seconds will be displayed.  

* The fifth form displays per-interface statistics for the specified protocol or address family.  

* The sixth form displays mbuf statistics. 

* The seventh form displays routing table for the specified address family.  The eighth form displays routing statistics.

#### netstat command options

Some important `netstat` command options:

* `-l` Print full IPv6 address.

* `-v` Increase verbosity level.

**Read the fine manual for more options**

#### netstat command examples

content

#### netcat command description

netcat (nc) -- arbitrary TCP and UDP connections and listens

The nc (or netcat) utility is used for just about anything under the sun involving TCP or UDP.  

It can open TCP connections, send UDP packets, listen on arbitrary TCP and UDP ports, do port scanning, and deal with both IPv4 and IPv6.

Unlike telnet, nc scripts nicely, and separates error messages onto standard error instead of sending them to standard output, as telnet does with some.

#### netcat command options

`nc` command options:

* `-4` Forces nc to use IPv4 addresses only.

* `-6` Forces nc to use IPv6 addresses only.

* `-b` Allow broadcast.

* `-C` Send CRLF as line-ending.

* `-D` Enable debugging on the socket.

* `-d` Do not attempt to read from stdin.

* `-h` Prints out nc help.

* `-I` length	Specifies the size of the TCP receive buffer.

* `-i` interval	Specifies a delay time interval between lines of text sent and received. 
  * Also, causes a delay time between connections to multiple ports.

* `-k`	Forces nc to stay listening for another connection after its current connection is completed. 
  * It is an error to use this option without the -l option.

* `-l` Used to specify that nc should listen for an incoming connection rather than initiate a connection to a remote host. It is an error to use this option in conjunction with the -p, 

**Read the Fine Manual for more options**

#### netcat command examples

content

#### nmap command description

nmap - Network exploration tool and security / port scanner

Nmap ("Network Mapper") is an open source tool for network exploration and security auditing. 

It was designed to rapidly scan large networks, although it works fine against single hosts. Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. 

While Nmap is commonly used for security audits, many systems and network administrators find it useful for routine tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime

If you are on Mac OS X then you might have to install nmap

If you have homebrew package manager run `brew install nmap`

#### nmap command options

Important `nmap` command options:

* `-sP`  Ping scans the network, listing machines that respond to ping.

* `-p` `-sV` `-sS` `-T4` target Full TCP port scan using with service version detection

* `-v` `-sS` `-A` `-T4` target Prints verbose output, runs stealth syn scan, T4 timing, OS and version detection + traceroute and scripts against target services.

* `-v` `-sS` `-A` `-T5` target  Prints verbose output, runs stealth syn scan, T5 timing, OS and version detection + traceroute and scripts against target services.

*  `-v` `-sV` `-O` `-sS` `-T5` target Prints verbose output, runs stealth syn scan, T5 timing, OS and version detection.

* `-v` `-p` `-sV` `-O` `-sS` `-T4` target Prints verbose output, runs stealth syn scan, T4 timing, OS and version detection + full port range scan.

*  `-v` `-p` `1-65535` `-sV` `-O` `-sS` `-T5` target Prints verbose output, runs stealth syn scan, T5 timing, OS and version detection + full port range scan.

#### nmap command examples

content

#### traceroute command description

traceroute -- print the route packets take to network host

The Internet is a large and complex aggregation of network hardware, connected together by gateways. 

Tracking the route one's packets follow (or finding the miscreant gateway that's discarding your packets) can be difficult.  

traceroute utilizes the IP protocol time to live field and attempts to elicit an ICMP TIME_EXCEEDED response from each gateway along the path to some host.

#### traceroute command options

`traceroute` command options:

* `-a` Turn on AS# lookups for each hop encountered.

* `-A` as_server Turn  on  AS#  lookups  and  use the given server instead of the default.

* `-d` Enable socket level debugging.

* `-D` When an ICMP response to our probe datagram is received, print the differences between the transmitted packet and the packet quoted by the ICMP response.

* `-e` Firewall evasion mode.  
  * Use fixed destination ports for UDP and TCP probes.  
  * The destination port does NOT increment with each packet sent.

* `-f` first_ttl
  * Set the initial time-to-live used in the first outgoing probe packet.

**Read the Fine manual for more options**

#### traceroute command examples

content

#### dig command description

dig - DNS lookup utility

dig (domain information groper) is a flexible tool for interrogating DNS name servers. 

It performs DNS lookups and displays the answers that are returned from the name server(s) that were queried. 

Most DNS administrators use dig to troubleshoot DNS problems because of its flexibility, ease of use and clarity of output. Other lookup tools tend to have less functionality than dig.

#### dig command options

Some `dig` command options:

* `+nocomments` – Turn off the comment lines

* `+noauthority` – Turn off the authority section

* `+noadditional` – Turn off the additional section

* `+nostats` – Turn off the stats section

* `+noanswer` – Turn off the answer section (Of course, you wouldn’t want to turn off the answer section)

#### dig command examples

content

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Shell Login Order](./shell-login-order.md) | [README](../README.md) →
