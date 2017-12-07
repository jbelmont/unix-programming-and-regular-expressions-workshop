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

```bash
ping 8.8.8.8
```

Here we use the `ping` command to see if google.com is up

```bash
ping -i 1 127.0.0.1
```

Here we see if localhost is up and running and wait 1 second before sending the next packet

```bash
ping -c 3 www.google.com
```

Here we send 3 packets to www.google.com and then `ping` quits

```bash
sudo ping -f localhost
```

Here using sudo privileges we flood localhost with packets

```bash
--- localhost ping statistics ---
1645 packets transmitted, 1000 packets received, 39.2% packet loss
round-trip min/avg/max/stddev = 0.007/0.019/0.060/0.005 ms
```

Here is sample output session

The `-f` option provides a rapid display of how many packets are being dropped

```bash
ping -a 8.8.8.8
```

The `-a` command option does an audible bell on each successful packet sent

```bash
ping -c 1 www.google.com
```

He we send 1 count to www.google.com

Notice that we get the output:

```bash
PING www.google.com (216.58.218.228): 56 data bytes
64 bytes from 216.58.218.228: icmp_seq=0 ttl=52 time=38.605 ms

--- www.google.com ping statistics ---
1 packets transmitted, 1 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 38.605/38.605/38.605/0.000 ms
```

Here we can also see the IP_ADDRESS: 216.58.218.228 that maps to www.google.com host name

```bash
ping -c 3 -q 127.0.0.1
```

Here we send 3 packets and only show the summary information by using `-q` command option which quiets output

```bash
ping -s 50 localhost
```

This specifies a packet size of 50 to localhost

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

```bash
ifconfig
```

Here we get the following output:

```bash
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
	nd6 options=201<PERFORMNUD,DAD>
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	ether a4:5e:60:f3:b3:37
	inet6 fe80::8fc:5c30:b69b:16f0%en0 prefixlen 64 secured scopeid 0x4
	inet 192.168.0.7 netmask 0xffffff00 broadcast 192.168.0.255
	inet6 2606:a000:50d0:c600:1cb9:f213:74eb:9108 prefixlen 64 autoconf secured
	inet6 2606:a000:50d0:c600:70a1:966f:7d89:3653 prefixlen 64 autoconf temporary
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
en1: flags=963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX> mtu 1500
	options=60<TSO4,TSO6>
	ether 6a:00:00:81:e6:40
	media: autoselect <full-duplex>
	status: inactive
en2: flags=963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX> mtu 1500
	options=60<TSO4,TSO6>
	ether 6a:00:00:81:e6:41
	media: autoselect <full-duplex>
	status: inactive
bridge0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=63<RXCSUM,TXCSUM,TSO4,TSO6>
	ether 6a:00:00:81:e6:40
	Configuration:
		id 0:0:0:0:0:0 priority 0 hellotime 0 fwddelay 0
		maxage 0 holdcnt 0 proto stp maxaddr 100 timeout 1200
		root id 0:0:0:0:0:0 priority 0 ifcost 0 port 0
		ipfilter disabled flags 0x2
	member: en1 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 5 priority 0 path cost 0
	member: en2 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 6 priority 0 path cost 0
	nd6 options=201<PERFORMNUD,DAD>
	media: <unknown type>
	status: inactive
p2p0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 2304
	ether 06:5e:60:f3:b3:37
	media: autoselect
	status: inactive
awdl0: flags=8943<UP,BROADCAST,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1484
	ether 2e:35:d7:b0:d9:b5
	inet6 fe80::2c35:d7ff:feb0:d9b5%awdl0 prefixlen 64 scopeid 0x9
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
utun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 2000
	inet6 fe80::fe8b:356a:44f2:9f6e%utun0 prefixlen 64 scopeid 0xa
	nd6 options=201<PERFORMNUD,DAD>
```

Notice here we get multiple entries for network entries

```bash
ifconfig -a
```

Here we list all the network interfaces no matter if they are up or not.

```bash
ifconfig en0
```

Here we list the configuration of a specific interface by providing its name

```bash
sudo ifconfig utun0 down
```

Here we disable an active network interface using the `down` keyword

```bash
ifconfig utun0
```

Here we look at the network interface and notice that it no longer shows the network interface as *UP* 

```bash
sudo ifconfig utun0 up
```

Here we enable an active network interface using the `up` keyword

```bash
ifconfig utun0
```

Notice we get the following output:

```bash
utun0: flags=8051<UP,POINTOPOINT,RUNNING,MULTICAST> mtu 2000
	inet6 fe80::fe8b:356a:44f2:9f6e%utun0 prefixlen 64 scopeid 0xa
	nd6 options=201<PERFORMNUD,DAD>
```

Notice that UP is displayed because the network interface is up and running again

```bash
sudo ifconfig utun0 162.72.169.1
```

Here we assign the static IP_ADDRESS: *162.72.169.1* to the utun0 network interface

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

```bash
netstat -sp tcp
```

Here we get statistics on tcp

Here is some output of the command above:

```bash
tcp:
	465304 packets sent
		88311 data packets (71920719 bytes)
		2276 data packets (1952856 bytes) retransmitted
		0 resend initiated by MTU discovery
		279607 ack-only packets (122 delayed)
		0 URG only packet
		0 window probe packet
		75672 window update packets
		19500 control packets
		0 data packet sent after flow control
		473999 checksummed in software
			430025 segments (87051438 bytes) over IPv4
			43974 segments (2741629 bytes) over IPv6
``` 

Now we will look at stats for udp

```bash
netstat -sp udp
```

Here is the output for the command above:

```bash
udp:
	16185 datagrams received
		0 with incomplete header
		0 with bad data length field
		0 with bad checksum
		0 with no checksum
		5627 checksummed in software
			5584 datagrams (712357 bytes) over IPv4
			43 datagrams (4424 bytes) over IPv6
		162 dropped due to no socket
		2 broadcast/multicast datagrams undelivered
		0 time multicast source filter matched
		0 dropped due to full socket buffers
		0 not for hashed pcb
		16021 delivered
	25081 datagrams output
		16302 checksummed in software
			15573 datagrams (2842945 bytes) over IPv4
			729 datagrams (219939 bytes) over IPv6
```

Notice that udp stats are printed to stdout

```bash
netstat -a
```

This command shows all sockets , both listening and non-listening on all protocols like tcp, udp, etc

This command shows the following output:

```bash
Active Internet connections (including servers)
Proto Recv-Q Send-Q  Local Address          Foreign Address        (state)
tcp4       0      0  192.168.0.7.59978      ec2-54-186-179-1.https ESTABLISHED
tcp4       0      0  192.168.0.7.59963      a184-86-71-214.d.https ESTABLISHED
tcp4       0      0  192.168.0.7.59961      ec2-34-195-182-8.https ESTABLISHED
..............................................................................
```

Here you will get a lot of output because there is usually a lot of open sockets

```bash
netstat -at
```

This command shows only tcp connections

```bash
netstat -ant
```

This command shows all TCP connections with no dns resolution (show ip numbers instead).

```bash
netstat -al
```

This command shows only listening sockets

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
