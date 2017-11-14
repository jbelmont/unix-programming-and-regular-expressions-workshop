## Unix Programming and Regular Expressions Workshop - Working with Files

## Sections:

* [ls Command Description](#ls-command-description)
* [ls Command Options](#ls-command-options)
* [ls Command Examples](#ls-command-examples)
* [touch Command Description](#touch-command-description)
* [touch Command Options](#touch-command-options)
* [touch Command Examples](#touch-command-examples)
* [df Command Description](#df-command-description)
* [df Command Options](#df-command-options)
* [df Command Examples](#df-command-examples)
* [du Command Description](#du-command-description)
* [du Command Options](#du-command-options)
* [du Command Examples](#du-command-examples)
* [mkdir Command Description](#mkdir-command-description)
* [mkdir Command Options](#mkdir-command-options)
* [rmdir Command Description](#rmdir-command-description)
* [rmdir Command Options](#rmdir-command-options)
* [rm, rmdir, mkdir Command Examples](#rm\,-rmdir\,-mkdir-command-examples)
* [cmp Command Description](#cmp-command-description)
* [Temporary Files Tips](#temporary-files-tips)
* [mktemp Command Description](#mktemp-command-description)
* [File Permissions](#file-permissions)
* [chmod Command Description](#chmod-command-description)
* [chmod Command Options](#chmod-command-options)
* [chmod Command Examples](#chmod-command-examples)
* [umask Command Options](#umask-command-options)
* [umask Command Examples](#umask-command-examples)
* [umask Command Examples](#umask-command-examples)
* [chown Command Options](#chown-command-options)
* [chown Command Examples](#chown-command-examples)
* [chown Command Examples](#chown-command-examples)
* [Bread Crumb Navigation](#bread-crumb-navigation)

#### ls Command Description

For each operand that names a file of a type other than directory, ls displays its name as well as any requested, associated information.

For each operand that names a file of type directory, ls displays the names of files contained within that directory, as well as any requested, associated information.

ls -- list directory contents

ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]

If no operands are given, the contents of the current directory are displayed.  If more than one operand is given, non-directory operands are displayed first; directory and non-directory operands are sorted separately and in lexicographical order.

#### ls Command Options

Mandatory arguments to long options are mandatory for short options too.

Common ls options:

* `-1` Force output to be one entry per line.  This is the default when output is not to a terminal.

* `-a` Include directory entries whose names begin with a dot (.).

* `-d` Directories are listed as plain files (not searched recursively).

* `-l` Provide a more detailed listing

* `-r` Reverse the order of the sort to get reverse lexicographical order or the oldest    
  * entries first (or largest files last, if combined with sort by size

* `-t` Sort by time modified (most recently modified first) before sorting the operands by lexicographical order.

* `-R` Recursively list subdirectories encountered.

Please Read the Fine Manual for more options by running `man ls`

#### ls Command Examples

```bash
ls -ltr
total 44
-rw-r--r--   1 marcelbelmont  1076 Oct  1 22:12 LICENSE
-rw-r--r--   1 marcelbelmont  1290 Oct  5 19:49 package.json
drwxr-xr-x 363 marcelbelmont 12342 Oct  5 19:50 node_modules
-rw-r--r--   1 marcelbelmont   110 Oct 14 19:02 book.json
drwxr-xr-x   5 marcelbelmont   170 Oct 14 19:48 object-files
drwxr-xr-x  36 marcelbelmont  1224 Oct 18 14:08 data
-rw-r--r--   1 marcelbelmont  1254 Oct 29 12:40 SUMMARY.md
drwxr-xr-x  13 marcelbelmont   442 Oct 29 18:06 images
-rw-r--r--   1 marcelbelmont 11271 Oct 29 18:07 CONTRIBUTING.md
drwxr-xr-x  22 marcelbelmont   748 Nov 11 15:18 docs
-rw-r--r--   1 marcelbelmont    93 Nov 11 15:18 TEST.md
drwxr-xr-x  21 marcelbelmont   714 Nov 11 16:42 scripts
-rw-r--r--   1 marcelbelmont  9228 Nov 12 10:38 README.md
drwxr-xr-x  18 marcelbelmont   612 Nov 12 10:39 _book
```

Notice here that the `ls` command printed a detailed listing of the directory by the time modified and printed in reverse order all the files in the current directory

```bash
ls -R scripts/shell-functions
```

Here we use the `-R` flag which recursively prints out any subdirectories in a directory

```bash
ls -a
.   .git     .gitignore       LICENSE	 SUMMARY.md  _book	data  images	    object-files  scripts
..  .github  CONTRIBUTING.md  README.md  TEST.md     book.json	docs  node_modules  package.json
```

The `-a` flag will print out any hidden files/directories that starts with `.`

```bash
ls working-with-fields
bank_statement.sh
```

```bash
ls -d working-with-fields
working-with-fields
```

Notice the difference between ls and ls -d, `ls -d` prints out directory as a plain file instead of the contents of the working-with-fields directory

The touch command is useful with the `make` utility and specifically for bootstrapping programs in linux distributions

```bash
ls -ld /tmp
lrwxr-xr-x 1 root 11 May 24 14:27 /tmp -> private/tmp
```

Notice in this example we have the `->` which indicates that /tmp is a symbolic link to `private/tmp`

#### touch Command Description

The touch utility sets the modification and access times of files.  
If any file does not exist, it is created with default permissions.

By default, touch changes both modification and access times.  

The -a and -m flags may be used to select the access time or the modification time individually.

Selecting both is equivalent to the default.  By default, the timestamps are set to the current time.  

The -t flag explicitly specifies a different time, and the -r flag specifies to set the times those of the specified file.  

The -A flag adjusts the values by a specified amount.

#### touch Command Options

`touch` command options:

* `-a` change only the access time

* `-c`, `--no-create`
  * do not create any files

* `-d`, `--date=STRING`
  * parse STRING and use it instead of current time

* `-f` (ignored)

* `-h`, `--no-dereference`
  * affect each symbolic link instead of any referenced file (useful only on systems that can change the timestamps of a symlink)

* `-m`     change only the modification time

* `-r`, `--reference=FILE`
  * use this file's times instead of current time

* `-t` STAMP
  * use [[CC]YY]MMDDhhmm[.ss] instead of current time

#### touch Command Examples

```bash
cd scripts/working-with-files
```

Here we **cd** into working-with-files directory to begin work

```bash
touch file1
```

Here we create a file called file1

```bash
touch file2 file3 file4
```

Here we create multiple files using the `touch` command

```bash
vi file1
```

make some edits to file1

```bash
touch -a file1
```

update access time to file1

```bash
ls -l file1
```

You should see a new updated modification time

```bash
ls
```

Look at the contents of the directory

```bash
touch -c file5
```

Notice here that file5 will not be created because it is a new file

```bash
touch -m file2
```

Here we update the modification time of file2

```bash
ls -l file2
```

Now we confirm that the modification time has been updated

Remember the -t option:

CC      The first two digits of the year (the century).
YY      The second two digits of the year.  If `YY` is specified, but `CC` is not, 
      a value for `YY` between 69 and 99 results in a `CC` value of 19.  
      Otherwise, a `CC` value of 20 is used.
MM      The month of the year, from 01 to 12.
DD      the day of the month, from 01 to 31.
hh      The hour of the day, from 00 to 23.
mm      The minute of the hour, from 00 to 59.
SS      The second of the minute, from 00 to 61.

```bash
touch file5
```

Here we create file5 because it must exist before we modify the time it was created

```bash
touch -c -t 2010030915 file5
```

Here we set the new date to be as follows:

Year: 2020
Month: 10 (October)
Day: 03
Hour: 09
Minute: 15

```bash
ls -l
```

Here we confirm that it has been updated

```bash
touch -r file1 file5
```

Here we use file1's access and modification time instead of what file5 already has as the time

#### df Command Description

The df utility displays statistics about the amount of free disk space on the specified filesystem or on the filesystem of which file is a part.  

Values are displayed in 512-byte per block counts.  

If neither a file or a filesystem operand is specified, statistics for all mounted filesystems are displayed (subject to the -t option below).

df -- display free disk space

Historically The df command has used different size blocks for example 512 vs 1024

Also the header format of the printed table has historically been different like for example multiple lines

#### df Command Options

`df` command options:

* `-a`, `--all`
  * include pseudo, duplicate, inaccessible file systems

* `-B`, `--block-size=SIZE`
  * scale sizes by SIZE before printing them; e.g., '-BM' prints sizes in units of 1,048,576 bytes; see SIZE format below

* `-h`, `--human-readable`
  * print sizes in powers of 1024 (e.g., 1023M)

* `-H`, `--si`
  * print sizes in powers of 1000 (e.g., 1.1G)

* `-i`, `--inodes`
  * list inode information instead of block usage

* `-k` like --block-size=1K

* `-l`, `--local`
  * limit listing to local file systems

* `--no-sync`
  * do not invoke sync before getting usage info (default)

* `--output[=FIELD_LIST]`
  * use the output format defined by FIELD_LIST, or print all fields if FIELD_LIST is omitted.

* `-P`, `--portability`
  * use the POSIX output format

* `--sync` invoke sync before getting usage info

* `--total`
  * elide all entries insignificant to available space, and produce a grand total

* `-t`, `--type=TYPE`

* `-T`, `--print-type`
  * print file system type

* `-x`, `--exclude-type=TYPE`
  * limit listing to file systems not of type TYPE

* `-v` (ignored)

* `--help` display this help and exit

* `--version`
  * output version information and exit

#### df Command Examples

```bash
df
```

This will print out a table of disk free statistics like this

Filesystem     1K-blocks      Used Available Use% Mounted on
/dev/disk1     484696704 224577476 259863228  47% /
kbfs@kbfuse0   262144000         0 262144000   0% /keybase

```bash
df -P
```

Will print out a table in POSIX format

Filesystem     1024-blocks      Used Available Capacity Mounted on
/dev/disk1       484696704 224578156 259862548      47% /
kbfs@kbfuse0     262144000         0 262144000       0% /keybase

Notice here that it printed out A capacity column and has 1024-blocks column instead of 1K-blocks

```bash
df -i
```

This command prints out free i nodes in the system

Filesystem         Inodes   IUsed      IFree IUse% Mounted on
/dev/disk1     4294967279 6197229 4288770050    1% /

#### du Command Description

Summarize disk usage of the set of FILEs, recursively for directories.

du - estimate file space usage

The `du` command shows disk usage of files and directory trees

The `du` command recursively shows file and directory information

The `du` command only shows hard-linked files once

The `du` command does not follow symbolic links but instead counts the space of the symbolic link

The POSIX default for the `du` command is to use 512-byte blocks

That being said many systems default to 1024-byte blocks instead of following the POSIX because it is much easier to use and understand 1024 byte blocks

#### du Command Options

`du` command options:

* `-0`, `--null`
  * end each output line with NUL, not newline

* `-a`, `--all`
  * write counts for all files, not just directories

* `--apparent-size`
  * print  apparent  sizes,  rather than disk usage; although the apparent size is usually smaller, it may be larger due to holes in ('sparse') files, internal fragmentation, indirect blocks, and the like

* `-B`, `--block-size=SIZE`
  * scale sizes by SIZE before printing them; e.g., '-BM' prints sizes in units of 1,048,576 bytes; see SIZE format below

* `-b`, `--bytes`
  * equivalent to '--apparent-size --block-size=1'

* `-c`, `--total`
  * produce a grand total

* `-D`, `--dereference-args`
  * dereference only symlinks that are listed on the command line

* `-d`, `--max-depth=N`
  * print the total for a directory (or file, with --all) only if it  is  N  or  fewer  levels  below  the  command  line  argument; --max-depth=0 is the same as --summarize

* `--files0-from=F`
  * summarize disk usage of the NUL-terminated file names specified in file F; if F is -, then read names from standard input

* `-H` equivalent to --dereference-args (-D)

* `-h`, `--human-readable`
  * print sizes in human readable format (e.g., 1K 234M 2G)

* `--inodes`
  * list inode usage information instead of block usage

* `-k` like --block-size=1K

* `-L`, `--dereference`
  * dereference all symbolic links

* `-l`, `--count-links`
  * count sizes many times if hard linked

* `-m` like --block-size=1M

* `-P`, `--no-dereference`
  * don't follow any symbolic links (this is the default)

* `-S`, `--separate-dirs`
  * for directories do not include size of subdirectories

* `--si` like `-h`, but use powers of 1000 not 1024

* `-s`, `--summarize`
  * display only a total for each argument

* `-t`, `--threshold=SIZE`

Read the Fine Manual for more options

#### du Command Examples

```bash
mkdir dir1 dir2
```

Here we create 2 directories *dir1* *dir2*

```bash
for i in dir1/file1 dir1/file2 dir2/file1 dir2/file2
do echo this is $i > $i
done
```

Here we create files file1 and file2 in both dir1 and dir2 directories and put `this is dir1/file1` etc into each file

```bash
du -s *
```

The `-s` option displays an entry for each specified file.  (Equivalent to -d 0)

8	dir1
8	dir2
4	file1
0	file2
0	file3
0	file4
0	file5
0	program.sh

Using `-s` is most useful in shell scripts

```bash
du -a *
```

Here we get the following difference using the `-a` option which is to *display an entry for each file in a file hierarchy.*

4	dir1/file1
4	dir1/file2
8	dir1
4	dir2/file1
4	dir2/file2
8	dir2
4	file1
0	file2
0	file3
0	file4
0	file5
0	program.sh

#### mkdir Command Description

The mkdir utility creates the directories named as operands, in the order specified, using mode rwxrwxrwx (0777) as modified by the current umask.

mkdir - make directories

#### mkdir Command Options

* `-m`, `--mode=MODE`
  * set file mode (as in chmod), not a=rwx - umask

* `-p`, `--parents`
  * no error if existing, make parent directories as needed

* `-v`, `--verbose`
  * print a message for each created directory

* `-Z` set SELinux security context of each created directory to the default type

* `--context[=CTX]`
  * like -Z, or if CTX is specified then set the SELinux or SMACK security context to CTX

* `--help` display this help and exit

* `--version`
  * output version information and exit

#### rmdir Command Description

The rmdir utility removes the directory entry specified by each directory argument, provided it is empty.

Arguments are processed in the order given.  

In order to remove both a parent directory and a subdirectory of that parent, the subdirectory must be specified first so the parent directory is empty when rmdir tries to remove it.

#### rmdir Command Options

`rmdir` command options:

* `--ignore-fail-on-non-empty`
  * ignore each failure that is solely because a directory is non-empty

* `-p`, `--parents`
  * remove DIRECTORY and its ancestors; e.g., 'rmdir -p a/b/c' is similar to 'rmdir a/b/c a/b a'

* `-v`, `--verbose`
  * output a diagnostic for every directory processed

* `--help` display this help and exit

* `--version`
  * output version information and exit

#### rm Command Description

The rm utility attempts to remove the non-directory type files specified on the command line.  If the permissions of the file do not permit writing, and the standard input device is a terminal, the user is prompted (on the standard error output) for confirmation.

rm, unlink -- remove directory entries

#### rm Command Options

`rm` command options:

* `-f`, `--force`
  * ignore nonexistent files and arguments, never prompt

* `-i` prompt before every removal

* `-I`  prompt once before removing more than three files, or when removing recursively; less intrusive than -i, while still giving protection against most mistakes

* `--interactive[=WHEN]`
  * prompt according to WHEN: never, once (-I), or always (-i); without WHEN, prompt always

* `--one-file-system`
  * when removing a hierarchy recursively, skip any directory that is on a file system different from that of the corresponding command line argument

* `--no-preserve-root`
  * do not treat '/' specially

* `--preserve-root`
  * do not remove '/' (default)

* `-r`, `-R`, `--recursive`
  * remove directories and their contents recursively

* `-d`, `--dir`
  * remove empty directories

* `-v`, `--verbose`
  * explain what is being done

* `--help` display this help and exit

* `--version`
  * output version information and exit

#### rm, rmdir, mkdir Command Examples

```bash
mkdir -vp dir3/subdir1/subsubdir2
```

Here we create the following directory tree structure:

dir3:
  subdir1:
    subsubdir2

The `-p` flag will create the intermediate directories and the `-v` will print out the directories created

```bash
rmdir dir3/subdir1/subsubdir2
```

Here we remove the empty folder **subsubdir2** directory

```bash
rm -rf dir3/subdir1
```

This command forcibly removes subdir1 and recursively any files inside of subdir1

#### cmp Command Description

cmp - compare two files byte by byte

cmp [OPTION]... FILE1 [FILE2 [SKIP1 [SKIP2]]]

The optional SKIP1 and SKIP2 specify the number of bytes to skip at the beginning of each file (zero by default).

The `cmp` command compares two files and has exit status of zero if the 2 files are identical

if the files are identical
  then there is no output 
else 
  cmp will print out the line and character of the first byte that differs and then it exits

#### cmp Command Options

`cmp` command options:

* `-b`, `--print-bytes`
  * print differing bytes

* `-i`, `--ignore-initial=SKIP`
  * skip first SKIP bytes of both inputs

* `-i`, `--ignore-initial=SKIP1:SKIP2`
  * skip first SKIP1 bytes of FILE1 and first SKIP2 bytes of FILE2

* `-l`, `--verbose`
  * output byte numbers and differing byte values

* `-n`, `--bytes=LIMIT`
  * compare at most LIMIT bytes

* `-s`, `--quiet`, `--silent`
  * suppress all normal output

* `--help` display this help and exit

* `-v`, `--version`
  * output version information and exit

#### Temporary Files Tips

As a convention use the shell variable `$TMPDIR` to override the default location for temp files in `/tmp`

Make sure to use trap on EXIT pseudo code to clean up your temporary files as

Also try to use `umask 077` so that only the current running user can read files that are created by your shell script

A common technique for creating temporary files that are unique is the following pattern

**/tmp/someprogram.$$**

Remember that `$$` is the current process id number

However there is security problems with using this technique

Here are the following security issues with that technique:

* The filenames created are easily guessable by an attacker who can use this pattern to have system use malicious script created by him/her

* The temporary files created in this manner can cause a program failure

* The temporary files can feed your program false data or other unwanted content

The temporary filenames you create need to be both random and long

To solve all of these issues just use the `mktemp` command

#### mktemp Command Description

mktemp -- make temporary file name (unique)

The mktemp utility takes each of the given file name templates and overwrites a portion of it to create a file name.  This file name is unique and suitable for use by the application.  

The template may be any file name with some number of `Xs` appended to it, for example /tmp/temp.XXXX.  
The trailing `Xs' are replaced with the current process number and/or a unique letter combination.  

The number of unique file names mktemp can return depends on the number of `Xs` provided; six `Xs` will result in mktemp selecting 1 of 56800235584 (62 ** 6) possible file names.  

On case-insensitive file systems, the effective number of unique names is significantly less; given six `Xs`, mktemp will instead select 1 of 2176782336 (36 ** 6) possible unique file names.

If mktemp can successfully generate a unique file name, the file is created with mode 0600 (unless the -u flag is given) and the filename is printed to standard output.

The mktemp utility is provided to allow shell scripts to safely use temporary files.  

Traditionally, many shell scripts take the name of the program with the pid as a suffix and use that as a temporary file name.  

This kind of naming scheme is predictable and the race condition it creates is easy for an attacker to win.  

A safer, though still inferior, approach is to make a temporary directory using the same naming scheme. 

While this does allow one to guarantee that a temporary file will not be subverted, it still  allows a simple denial of service attack.  

For these reasons it is suggested that mktemp be used instead.

If no template is provided then `mktemp` provides a default template

#### mktemp Command Options

`mktemp` command options:

* `-d` Make a directory instead of a file.

* `-q` Fail silently if an error occurs.  This is useful if a script does not want error output to go to standard error.

* `-t` prefix
  * Generate a template (using the supplied prefix and TMPDIR if set) to create a filename template.

* `-u` Operate in `unsafe` mode.  
  * The temp file will be unlinked before mktemp exits.  
  * This is slightly better than mktemp but still introduces a race condition.  
  * Use of this option is not encouraged.

#### mktemp Command Examples

```bash
cmp line1 line2
```

Here we compare line1 and line2 which are identical

```bash
echo $?
```

Here we check the exit status of the `cmp` command which returns 0 meaning the 2 files are identical

```bash
cmp line1 line3
```

Here the 2 files are different so we get this output

line1 line3 differ: char 1, line 1

```bash
cmp /etc/passwd /etc/group
```

Here the files /etc/passwd and /etc/group differ as well like this:

**/etc/passwd /etc/group differ: char 6, line 2**

```bash
echo $?
```

The exit status here is 1 meaning the files differ

```bash
cmp -l line1 line3
```

Here we compare line1 and line3 using `-l` for long listing output showing the differences on each byte

```bash
cmp -s line1 line3
```

Here we use the `-s` option to suppress the output

When this is done in a shell script normally you check the exit status

```bash
echo $?
```

This will output 1

```bash
#! /bin/sh

## Here we trap the command when pseudo EXIT signal is given so that we cleanup temp files that were created
trap 'rm -f $tmpfile $tmpfile2' EXIT

tmpfile=${TMPDIR:-/tmp}/someprogram.$$

echo Here is a simple line > $tmpfile

ls -l $tmpfile
echo
cat $tmpfile

echo

umask 077
tmpfile2=${TMPDIR:-/tmp}/someprogram.$$.2

echo Another line to write here > $tmpfile2

ls -l $tmpfile2

echo 

cat $tmpfile2
```

Remember this parameter expansion assignment `${var:-word}` Its purpose is to return if a variable is not defined

Here we are creating a temporary file using the common but vulnerable naming scheme we mentioned previously

```bash
./temp-files.sh

-rw-r--r-- 1 marcelbelmont staff 22 Nov 12 20:55 /var/folders/s4/szxqn65j3tz89r6c5z786x2m0000gn/T//someprogram.57340

Here is a simple line

-rw------- 1 marcelbelmont staff 27 Nov 12 20:55 /var/folders/s4/szxqn65j3tz89r6c5z786x2m0000gn/T//someprogram.57340.2
```	

Here we are using umask instead of chmod because we are setting the permission bits in creation time for tmpfile2

```bash
#! /bin/bash

# Run trap for cleanup no matter what
trap 'rm -f $tmpfile' EXIT

tmpfile=$(mktemp -p /tmp someprogram.XXXXXXXXXXX) || exit 1

echo Here is some data again > $tmpfile

ls -l $tmpfile

echo

cat $tmpfile
```

The difference in this script is that we are using the mktemp utility

Here is the output of this shell script:

```bash
-rw------- 1 marcelbelmont wheel 24 Nov 12 21:27 /tmp/someprogram.OaZPcfjZ6oc

Here is some data again
```

Notice that mktemp entered random symbols for the `XXXXX` placeholder

Also notice that we didn't have to use `umask` because `mktemp` set the proper security permissions for us

```bash
#! /bin/bash

trap 'rm -f $tmpfile' EXIT

tmpfile=$(mktemp -p /dev anotherprogram.XXXX) || exit 1

echo Some data here for a file > $tmpfile

ls -l $tmpfile

echo 

cat $tmpfile
```

Here we try to run `mktemp` on the `/dev` directory but it is not a writable directory so this will fail with this error 

**mktemp: failed to create file via template ‘/dev/anotherprogram.XXXX’: Permission denied**

#### File Permissions

```bash
ls -l
total 24
-rwxrwxrwx 1 marcelbelmont   0 Nov 14 17:15 bad-practice.txt
-rw-r--r-- 1 marcelbelmont  15 Nov 12 20:08 line1
-rw-r--r-- 1 marcelbelmont  15 Nov 12 20:08 line2
-rw-r--r-- 1 marcelbelmont  31 Nov 12 20:11 line3
-rw-r--r-- 1 marcelbelmont   0 Oct  5 09:17 program.sh
drwxrwxrwx 3 marcelbelmont 102 Nov 14 17:20 really-bad-directory
-rw-r-Sr-- 1 marcelbelmont   0 Nov 14 17:07 stick-bit.txt
-rwSr--r-- 1 marcelbelmont   0 Nov 14 17:09 stick-bit.txt2
-rwsr-sr-x 1 marcelbelmont   0 Nov 14 17:09 stick-bit.txt3
-rwxr-xr-x 1 marcelbelmont 178 Nov 12 21:24 temp-files-with-mktemp-version2.sh
-rwxr-xr-x 1 marcelbelmont 217 Nov 12 21:22 temp-files-with-mktemp.sh
-rwxr-xr-x 1 marcelbelmont 305 Nov 12 20:53 temp-files.sh
```

You can see file Permission Bits in the following `ls` command above in the root of the repository

There are 3 specific types of file permissions:

1. **read** 
  1. The read permission grants the ability to read a file. When set for a directory, this permission grants the ability to read the names of files in the directory, but not to find out any further information about them such as contents, file type, size, ownership, permissions.

2. **write**
  1. The write permission grants the ability to modify a file. When set for a directory, this permission grants the ability to modify entries in the directory. This includes creating files, deleting files, and renaming files.

3. **execute**
  1. The execute permission grants the ability to execute a file. This permission must be set for executable programs, including shell scripts, in order to allow the operating system to run them. When set for a directory, the execute permission is interpreted as the search permission: it grants the ability to access file contents and meta-information if its name is known, but not list files inside the directory, unless read is set also.

Notice that there are 10 entries

| Directory | User | Group | Other
| --- | --- | --- | --- |
| X | XXX | XXX | XXX |
| This First Character Indicates the File Type (i.e File or Directory) | what the user/owner can do | what the group members can do | what other users can do |

```bash
cd scripts/working-with-files
```

```bash
ls -l bad-practice.txt
-rwxrwxrwx 1 marcelbelmont 0 Nov 14 17:15 bad-practice.txt
```

Notice here the order for XXX => r (read) w (write) x (execute)

```bash
drwxrwxrwx 3 marcelbelmont 102 Nov 14 17:20 really-bad-directory
```

Here is a directory that has read, write, execute for owner/user, group, and others

| Mode | Name | Octal Value | Description |
| --- | --- | --- | --- |
| r | read | 4 | read a file or list a directory's contents |
| w | write | 2 | write to a file or directory |
| x | execute | 1 | execute a file or recurse a directory tree |
| X | special execute | -- | It applies execute permissions to directories regardless of their current permissions and applies execute permissions to a file which already has at least one execute permission bit already set |
| s | setuid/gid | -- | The symbolic modes use s to represent the setuid and setgid modes |
| t | sticky | -- | When a directory's sticky bit is set, the filesystem treats the files in such directories in a special way so only the file's owner, the directory's owner, or root user can rename or delete the file |

```bash
chmod +t stick-bit.txt
```

Here we set the sticky bit for the user

```bash
ls -l stick-bit.txt
-rw-r-Sr-T 1 marcelbelmont 0 Nov 14 17:07 stick-bit.txt
```

Notice here that we have a T at the end of the triad which is the sticky bit

A trick to remembering how to add octal values

_  _  _
4  2  1

The first `_` has 4 which stands for read permission

The second `_` has 2 which stands for write permission

The third `_` has 1 which stands for execute permission

If you add up 4 + 2 you get read and write Permission = 6

If you add up 4 + 1 you get read and execute Permission = 5

If you add up 2 + 1 you get write and execute permission = 3

If you add up 4 + 2 + 1 you get read, write, and execute permission = 7


#### chmod Command Description

chmod -- change file modes or Access Control Lists

The chmod utility modifies the file mode bits of the listed files as specified by the mode operand. It may also be used to modify the Access Control Lists (ACLs) associated with the listed files.

chmod [-fv] [-R [-H | -L | -P]] mode file ...
chmod [-fv] [-R [-H | -L | -P]] [-a | +a | =a] ACE file ...
chmod [-fhv] [-R [-H | -L | -P]] [-E] file ...
chmod [-fhv] [-R [-H | -L | -P]] [-C] file ...
chmod [-fhv] [-R [-H | -L | -P]] [-N] file ...

#### chmod Command Options

`chmod` command options:

* `-f` Do not display a diagnostic message if chmod could not modify the mode for file.

* `-H` If the `-R` option is specified, symbolic links on the command line are followed.  (Symbolic links encountered in the tree traversal are not followed by default.)

* `-h` If the file is a symbolic link, change the mode of the link itself rather than the file that the link points to.

* `-L` If the `-R` option is specified, all symbolic links are followed.

* `-P` If the `-R` option is specified, no symbolic links are followed.  This is the default.

* `-R` Change the modes of the file hierarchies rooted in the files instead of just the files themselves.

* `-v` Cause chmod to be verbose, showing filenames as the mode is modified.  If the -v flag is specified more than once, the old and new modes of the file will also be printed, in both octal and symbolic notation.

#### chmod Command Examples

```bash
chmod a+r permissions.txt
```

Here we give read permission for users, groups, and others using the `a`

```bash
ls -l permissions.txt
-rw-r--r-- 1 marcelbelmont 0 Nov 14 17:37 permissions.txt
```

We confirm with this with the following `ls -l permissions.txt` command

```bash
chmod ugo-r permissions.txt
```

Here we remove read permission for users, groups, and others using `-` instead of `+`

```bash
chmod 444 permissions.txt
```

Here we give read permission using octal value 4 to users, groups, and others

```bash
chmod a-r permissions.txt
```

Here we remove read permission for users, groups, and others

```bash
chmod +r permissions.txt
```

Here we give users read permission but no one else

```bash
chmod -r permissions.txt
```

Here we remove read permission for everyone

```bash
chmod u=rwx,g=rx,o= permissions.txt
```

Here we give user => read, write, execute, group => read, execute, other: none

```bash
chmod -R u+w,go-w really-bad-directory
```

Here we use `-R` flag and recursively go done directory structure and add the following permissions:

User => write
Group and Other => remove write permission

```bash
chmod 0722 permissions.txt
```

Here we explicitly set no special modes denoted by `0` and give user=rwx, go=w

```bash
chmod 1755 permissions.txt
```

Here we set the sticky bit denoted by `1` and give user=rwx,go=rx

```bash
chmod -R u+rwX,g-rwx,o-rx really-bad-directory
```

Here we Recursively adds read, write, and special execution permissions for owner, remove read, write, and execution permissions for group, and remove read and execution permissions for others

Also notice we used a capital `X` here instead of lowercase `x`

#### umask Command Description

Display or set file mode mask.

Sets the user file-creation mask to MODE.  

If MODE is omitted, prints the current value of the mask.

If MODE begins with a digit, it is interpreted as an octal number, otherwise it is a symbolic mode string like that accepted by chmod

umask entails only new files. 

umask sets the default permissions that a file/directory will have on creation time.

umask has no effect on existing files/directories

#### umask Command Options

`umask` command options:

* `-p`	if MODE is omitted, output in a form that may be reused as input
* `-S`	makes the output symbolic; otherwise an octal number is output

#### umask Command Examples

```bash
umask
022
```

Here it prints out the default file permissions that will get added in creation time

```bash
umask -S
u=rwx,g=rx,o=rx
```

Notice that in octal values that is 755 meaning users => read (r), write (w), execute (x), groups => read (r), execute (x), others => read (r), execute (x)


```bash
umask 000
```

Here we allow read, write, and execute permission for all (potential security risk)

```bash
umask 777
```

Here we disallow read, write, and execute permission for all

```bash
umask u=rw,go=
```

Here we allow read and write permission to be enabled for the user, while prohibiting execute permission from being enabled for the owner; prohibit enabling any permissions for the group and others

#### chown Command Description

chown - change file owner and group

This  manual  page  documents the GNU version of chown.  chown changes the user and/or group ownership of each given file.  

If only an owner (a user name or numeric user ID) is given, that user is made the owner of each given file, and the files' group is not  changed.

If  the  owner  is followed by a colon and a group name (or numeric group ID), with no spaces between them, the group ownership of the files is changed as well.  

If a colon but no group name follows the user name, that user is made the owner of the files and the group of the files is changed to that user's login group.  

If the colon and group are given, but the owner is omitted, only the group of the files is changed; in this case, chown performs the same function as chgrp.  

If only a colon is given, or if the entire operand is empty, neither the owner nor the group is changed.

#### chown Command Options

`chown` command options:

* `-c`, `--changes`
  * like verbose but report only when a change is made

* `-f`, `--silent`, `--quiet`
  * suppress most error messages

* `-v`, `--verbose`
  * output a diagnostic for every file processed

* `--dereference`
  * affect the referent of each symbolic link (this is the default), rather than the symbolic link itself

* `-h`, `--no-dereference`
  * affect symbolic links instead of any referenced file (useful only on systems that can change the ownership of a symlink)

* `--from=CURRENT_OWNER:CURRENT_GROUP`
  * change the owner and/or group of each file only if its current owner and/or group match those specified here.   
  * Either may be omitted, in which case a match is not required for the omitted attribute

* `--no-preserve-root`
  * do not treat '/' specially (the default)

* `--preserve-root`
  * fail to operate recursively on '/'

* `--reference=RFILE`
  * use RFILE's owner and group rather than specifying OWNER:GROUP values

* `-R`, `--recursive`
  * operate on files and directories recursively

The  following  options modify how a hierarchy is traversed when the -R option is also specified.  

If more than one is specified, only  dthe final one takes effect.

* `-H` if a command line argument is a symbolic link to a directory, traverse it

* `-L` traverse every symbolic link to a directory encountered

* `-P` do not traverse any symbolic links (default)

* `--help` display this help and exit

* `--version` output version information and exit

#### chown Command Examples

```bash
sudo chown root chown-practice.txt
```

Here we set ownership to *chown-practice.txt* to root using sudo privileges

```bash
sudo chown marcelbelmont:wheel chown-practice.txt
```

Here we explicitly set chown-practice.txt to user marcelbelmont and to group wheel

```bash
ls -l chown-practice.txt
-rw-r--r-- 1 marcelbelmont wheel 0 Nov 14 18:22 chown-practice.txt
```

I had to get into bash subshell to see because my oh my zsh shell wasn't showing it

#### Bread Crumb Navigation
_________________________

Previous | Next
:------- | ---:
← [Signal Handling](./signal-handling.md) | [Building Command line applications](./building-command-line-applications.md) →
