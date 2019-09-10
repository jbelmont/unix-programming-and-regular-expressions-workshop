## Unix Programming and Regular Expressions Workshop - Shell Security

## Sections:

* [Shell Permissions](#shell-permissions)
* [Root Permissions](#root-permissions)
* [System Administrator Techniques](#system-administrator-techniques)
* [Keep Software Up to Date](#keep-software-up-to-date)
* [Understand the Services Running in the Unix Environment](#understand-the-services-running-in-the-unix-environment)
* [File System Security](#file-system-security)
* [SELinux](#selinux)
* [Viruses in Unix Systems](#viruses-in-unix-systems)
* [Network Firewalls](#network-firewalls)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### Shell Permissions

In the [Working with Files Section](./working-with-files.md) we discussed the different types of permissions and the level of access they give.

Users under Unix style operating systems often belong to managed groups with specific access permissions. 

This enables users to be grouped by the level of access they have to this system. 

Many Unix implementations add an additional layer of security by requiring that a user be a member of the wheel user privileges group in order to access the su command.

Mac OS X uses the wheel user group as well.

#### Root Permissions

A lot of the following content was extracted from [Unix Security Wikipedia Page](https://en.wikipedia.org/wiki/Unix_security)

A lot of Unix systems have either an account or group that permits complete control of the system, this is usually called having root access.

If access is granted to an unwanted user then they can have complete access to the system which is a complete breach of security.

> A root account however is necessary for administrative purposes, and for the above security reasons the root account is seldom used for day to day purposes (the sudo program is more commonly used), so usage of the root account can be more closely monitored.

#### System Administrator Techniques

> Selecting a strong password and guarding it properly are probably the most important things a user can do to improve Unix security. 

> In Unix systems, the essential information about users is stored under the file /etc/passwd. 

> This file keeps track of the users registered in the system and their main definitions. Passwords, or more correctly, the hash of the password, can also be stored in the same place. 

> The entries in /etc/passwd occupy exactly one line each

> The entries in /etc/passwd occupy exactly one line each, and have the following form:

`nickname:password_hash:UserID:GroupID:Complete_Name:home_dir:shell_bin`

> Since all users must have read access to the /etc/passwd file to do many common tasks (ls -l /home will use /etc/passwd to map UIDs to login names for example), anyone could also read the password hashes of other users. 

> To solve this problem, the file /etc/shadow was created to store the password hashes, with only root having read access. 

> Under password shadowing, the 2nd field (password hash) is replaced by an 'x' which tells the system to retrieve the corresponding user's password via the /etc/shadow file.

> The /etc/shadow file often only contains values for the first two fields:

`xfze:$$1zuW2nX3sslp3qJm9MYDdglEApAc36r/:::::`

The remaining fields in the /etc/shadow file include:

1. The minimum number of days between password changes

2. The maximum number of days until the password must be changed

3. The number of days of warning given before the password must be changed

4. The number of days after the password must be changed when the account becomes unusable

5. The date (expressed as the number of days since January 1st, 1970) when the account is expired

A system administrator can use these fields in the `/etc/shadow` to enforce a password security policy.

Any old users or groups should be promptly removed from the Unix System.

**su, sudo, ssh only, no remote root logins**

#### Keep Software Up to Date

[Software Patching Wikipedia Section](https://en.wikipedia.org/wiki/Unix_security#Patching)

###### Patching

> Operating systems, like all software, may contain bugs in need of fixing or may be enhanced with the addition of new features. Patching the operating system in a secure manner requires that the software come from a trustworthy source and not have been altered since it was packaged. Common methods for verifying that operating system patches have not been altered include the use of cryptographic hash, such as an MD5 based checksum, or the use of read-only media.

###### Source distributions

> Source distributions include the ability to examine the code for suspicious content. The drawback, absent an accompanying cryptographic hash value, is that the user must be able to perform a security analysis of the code themselves.

> Regardless of the vendor or distribution, all software distributions should provide a mechanism for verifying that the software is legitimate and has not been modified since it was originally packaged.

Often an md5 checksum of the downloaded content is used to verify that you downloaded an untampered resource.

#### Understand the Services Running in the Unix Environment

Do not install unnecessary services in the system.

Any software that is no longer needed should be removed from the system.

**Identify what services are running** :

1. netstat -na

2. lsof

3. nmap

4. sockstat -4

**The commands inetd and xinetd act as super-servers for a variety of network protocols such as rlogin, telnet and ftp.**

Here is a sample run of netstat in a ubuntu system:

```bash
$ netstat -na

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 127.0.0.1:9333          0.0.0.0:*               LISTEN     
tcp        0      0 127.0.1.1:53            0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN     
tcp        0      0 192.168.0.14:35384      64.233.177.188:443      ESTABLISHED
tcp        0      0 192.168.0.14:56538      192.241.178.140:443     ESTABLISHED
tcp6       0      0 ::1:631                 :::*                    LISTEN     
tcp6       0      0 2606:a000:50d0:c6:54216 2607:f8b0:4002:810::443 ESTABLISHED
tcp6       0      0 2606:a000:50d0:c6:48316 2607:f8b0:4002:804::443 ESTABLISHED
tcp6       0      0 2606:a000:50d0:c6:48314 2607:f8b0:4002:804::443 ESTABLISHED
tcp6       0      0 2606:a000:50d0:c6:53842 2607:f8b0:4002:808::443 ESTABLISHED
udp        0      0 0.0.0.0:43326           0.0.0.0:*                          
udp        0      0 127.0.1.1:53            0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp        0      0 0.0.0.0:631             0.0.0.0:*                          
udp        0      0 0.0.0.0:51891           0.0.0.0:*                          
udp        0      0 0.0.0.0:5353            0.0.0.0:*                          
udp        0      0 0.0.0.0:5353            0.0.0.0:*                          
udp6       0      0 :::57792                :::*                               
udp6       0      0 :::5353                 :::*                               
udp6       0      0 :::5353                 :::*                               
raw6       0      0 :::58                   :::*                    7          
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  2      [ ACC ]     STREAM     LISTENING     28568    /tmp/.org.chromium.Chromium.1VIs5h/SingletonSocket
unix  2      [ ]         DGRAM                    24170    /run/user/1000/systemd/notify
unix  2      [ ACC ]     STREAM     LISTENING     netstat -na | less24171    /run/user/1000/systemd/private
unix  2      [ ACC ]     SEQPACKET  LISTENING     10230    /run/udev/control
unix  3      [ ]         DGRAM                    9874     /run/systemd/notify
unix  2      [ ACC ]     STREAM     LISTENING     27702    @christine-com.canonical.Unity.Scope.scopes.T1268472427719
unix  2      [ ACC ]     STREAM     LISTENING     24202    /run/user/1000/keyring/control
unix  2      [ ACC ]     STREAM     LISTENING     24508    /run/user/1000/keyring/pkcs11
unix  2      [ ACC ]     STREAM     LISTENING     24512    /run/user/1000/keyring/ssh
unix  2      [ ACC ]     STREAM     LISTENING     27704    @christine-com.canonical.Unity.Scope.applications.T1268524384910
unix  2      [ ACC ]     STREAM     LISTENING     16458    /sys/fs/cgroup/cgmanager/sock
unix  2      [ ACC ]     STREAM     LISTENING     25260    /run/user/1000/pulse/native
unix  2      [ ACC ]     STREAM     LISTENING     531649   /run/user/1000/vscode-git-askpass-ace0622bfd4151186f67e7466a8ebc0a7aaf5aaf.sock
unix  2      [ ACC ]     STREAM     LISTENING     25334    @/tmp/.ICE-unix/1660
unix  2      [ ACC ]     STREAM     LISTENING     55198    /run/user/1000/Code-1.19.1-main.sock
unix  2      [ ACC ]     STREAM     LISTENING     55613    /run/user/1000/Code-1.19.1-shared.sock
......................................................................
```

#### File System Security

This information was extracted from [File System Security Wikipedia Section](https://en.wikipedia.org/wiki/Unix_security#file-systems)

> File system security within UNIX and Unix-like systems is based on 9 permission bits, set user and group ID bits, and the sticky bit, for a total of 12 bits. 

> These permissions apply almost equally to all filesystem objects such as files, directories and devices.

> The 9 permission bits are divided into three groups of three bits each. The first group describes the permissions of the file owner, the second group describes the permissions of a group associated with the file owner or the directory containing the file, and the third group describes the permissions associated with any process which does not have the same user ID as the file. Each group of three bits contains a bit indicating the read, write or execute access is granted. In the case of directories, execute access is interpreted as the permission to perform a filename lookup within the directory.

> The set user ID and set group ID bits, commonly abbreviated set-UID and set-GID respectively, are used to change the identity of the process which executes a file having either or both of those bits set. A file having the set-UID permission bit set will cause a process which executes that file to temporarily switch the effective user ID to that of the file owner. A file having the set-GID permission bit set will cause a process which executes that file to temporarily switch the effective group ID to that of the file group. A process may then alternate between the effective user or group ID which it inherited from the file and the real user or group ID which it inherited when the user logged on to the system. This provides a mechanism by which a process may limit the access rights it possesses to those code regions which require those access rights. This is a form of a security technique known as privilege separation and improves program security by limiting the unintended or undesirable actions of a processes.

> A directory having the set-GID permission bit set will cause a newly created file to have an initial file group value equal to the file group of the directory. This provides a mechanism whereby a subsystem, such as the system's mail subsystem, can create files which have a common file group value so that set-GID processes within that subsystem are then able to read or write the file.

> The sticky bit, formally known as the save text on swap bit, derives its name from its original purpose. Originally the sticky bit caused a process's initial memory image to be stored as a contiguous image on the disk drive which was used to store real memory pages when they were not in use. This improved the performance of commonly executed commands by making the initial memory image readily available. Modern UNIX systems no longer perform that function when the bit is set, but the name has been preserved nonetheless. In the case of files, the sticky-bit may be used by the system to indicate the style of file locking to be performed. In the case of directories, the sticky bit prevents any process, other than one which has super-user privileges or one having an effective user ID of the file owner, from deleting a file within that directory. The sticky bit is most commonly used on publicly writable directories, such as the various temporary working space directories on the system.

We discussed in great detail the permission bits on the [Working with Files Section](./working-with-files.md)

#### SELinux

[SELinux Wikipedia](https://en.wikipedia.org/wiki/Security-Enhanced_Linux)

> Security-Enhanced Linux (SELinux) is a Linux kernel security module that provides a mechanism for supporting access control security policies, including United States Department of Defense–style mandatory access controls (MAC).

SELinux features include:

* clean separation of policy from enforcement
* well-defined policy interfaces
support for applications querying the policy and enforcing access control (for example, crond running jobs in the correct context)
* independence of specific policies and policy languages
* independence of specific security-label formats and contents
* individual labels and controls for kernel objects and services
support for policy changes
* separate measures for protecting system integrity (domain-type) and data confidentiality (multilevel security)
* flexible policy
* controls over process initialization and inheritance and program execution
* controls over file systems, directories, files, and open file descriptors
* controls over sockets, messages, and network interfaces
* controls over the use of "capabilities"
* cached information on access-decisions via the Access Vector Cache (AVC)

#### Viruses in Unix Systems

Unix-like operating systems are immune to most Microsoft Windows viruses because binaries created to run on Windows generally won't run on other platforms. 

However, many Unix like installations provide file storage services to Microsoft Windows clients, such as through the use of Samba software, and may unintentionally become a repository for viruses stored by users. 

It is common for Unix servers to act as mail transfer agents; consequently; email virus scanning is often installed. The ClamAV virus scanner is available in source code form and may be used to scan Unix file systems for viruses which infect other operating systems.

There are viruses and worms that target Unix-like operating systems. In fact, the first computer worm—the Morris worm—targeted Unix systems.

#### Network Firewalls

> In computing, a firewall is a network security system that monitors and controls incoming and outgoing network traffic based on predetermined security rules. A firewall typically establishes a barrier between a trusted internal network and untrusted outside network, such as the Internet.

###### iptables

iptables is the current user interface for interacting with Linux kernel netfilter functionality. 

It replaced ipchains. Other Unix like operating systems may provide their own native functionality and other open source firewall products exist.

> iptables requires elevated privileges to operate and must be executed by user root, otherwise it fails to function. On most Linux systems, iptables is installed as /usr/sbin/iptables and documented in its man pages, which can be opened using man iptables when installed. It may also be found in /sbin/iptables, but since iptables is more like a service rather than an "essential binary", the preferred location remains /usr/sbin.

Read the [iptables Wikipedia Page](https://en.wikipedia.org/wiki/Iptables) for more details on iptables

#### Shellshock Bash Bug

Please read the [Shellshock Wikipedia Page](https://en.wikipedia.org/wiki/Shellshock_%28software_bug%29)

> Shellshock, also known as Bashdoor, is a family of security bugs in the widely used Unix Bash shell, the first of which was disclosed on 24 September 2014. Many Internet-facing services, such as some web server deployments, use Bash to process certain requests, allowing an attacker to cause vulnerable versions of Bash to execute arbitrary commands. This can allow an attacker to gain unauthorized access to a computer system

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Network Utilities](./network-utilities.md) | [Find and Replace Patterns](./find-and-replace-patterns) →
