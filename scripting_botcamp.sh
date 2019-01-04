#####~~SHELL SCRIPTING~~#####
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
#################
####_GENERAL_####
#################
### Command interpreters ###
#--------------------------#
#!/bin/sh -> Bourne Shell.
#!/bin/bash -> Evolution of sh.
#!/bin/tcsh -> tenex.
#!/bin/csh -> c shell (ressemble c programming language syntaxe).
#!/bin/ksh -> Korn shell.
#!/bin/perl -> Perl.
#!/bin/python -> Python.
### Calling a shell script ###
#----------------------------#
./script.sh # direct call
bash script.sh # direct call using interpreter
source script.sh || . script.sh # execute the script in the current context (shell) and returns script return code (Source is less portable than ".").
### INPUT (interactive) ###
#-------------------------#
echo "enter a name"
read name
echo $name
### Return codes ###
#------------------#
0 # success if return code 0.
!0 "(1,-1,etc)" # fail if return code different from 0.
### Basic syntaxe and special characteres ###
#------------------#
$var # what follows $ is a variable.
> # redirect ouput.
>> # append ouput.
< # redict input.
xxx | yyyy # pipe
# comment
scp abc@server:/var/ftp/pub \ # \ indicate a
xyz@server2:/opt/test         # new line.
### multiple commands in a single line : ";" "&&" "||" ###
#--------------------------------------------------------#
make ; make install ; make clean # execute next command even if previous fails.
make && make install && make clean # execute next command if the previous one successed.
make || cat file1 || cate file2 # execute next command if previous fails (if previous successed will stop).
### predefined parameters ###
#---------------------------#
$0 # script name (basename).
$1 to $9 # parameters entered by user (from 1 to 9).
$* # all parameters. but do not wrap each individual argument in quotes : script.sh a b c d => "a b c d".
$@ # all parameters. wrap each individual argument in quotes : script.sh a b c d => "a" "b" "c" "d".
$# # number of arguments passed in (count)
### command substitution ###
#--------------------------#
ls /lib/modules/$(uname -R) || ls /lib/modules/`uname -R` # $() : modern way to use, and ``, create a new shell in where the command inside is executed and the strandard output stdout will be inserted instead.
### VARIABLES ###
#---------------#
age=30 # local var not shared with child processes.
export age=30 # env var shared with child, if a child process modify it, parent will not see it, ! ENV VAR are only copied and inherited, not shared !.
### FUNCTIONS ###
#---------------#
showmess(){    # declare a function, $1 here is a function param.
  echo my message is : $1
}
showmess OMAR # call the function with the param OMAR , the result will be "my message is : OMAR".
#~~~~~#
fun_function() {  # calling a function with a composed name base on a variable.
  echo im func 1
}
echo enter 1
read n
fun$n
### CONDITION : IF ELIF ELSE FI ###
#---------------------------------#
if [ xxx -eq xxx ]; then # if = 0 (true) go to -> then (here using ";")
  echo "yes i agree"
fi
#~~~~~#
if [ xxx -eq yyy ]  # if = 0 (true) go to -> then (here without ";")
then
  echo "yes i agree"
elif [ xxx -eq xxy ]
then
  echo "well ok, i agree"
else
  echo "i do not agree"
fi
### IF [] [[ ]] (( )) () ###
#--------------------------#
##-----IF [ ]-----##
if [ "$var" == "omar" ] # same as command : 'test', used to check files types and compare values.
#~~~~~#
if [ -a *.sh ]; then # if their is 1 file => true, if their is 0 files => false, if their is n files => error, because *.sh is expanded to the files in the working directory.
##-----IF [ ] operators-----##
# Relational and arithemetic operators #
if [ $a -eq $b ] # equal ==
if [ $a == $b ]  # equal ==
TODO diff between == -eq.
if [ $a -ne $b ] # not equal !=
if [ $a != $b ] # not equal !=
if [ $a -gt $b ] # great than >
if [ $a -lt $b ] # less than <
if [ $a -ge $b ] # great or equal >=
if [ $a -le $b ] # less or equal <=
TODO
# File test operators #
if [ -a file.txt ] || if [ -e existingfile ] # check if a file exists.
if [ -b /dev/fd0 ] # check if a block special file like kernel and device files in /dev (ATA devices, disk, CD ROM).
if [ -c /dev/dsp ] # check if special characteres file like kernel ones in /dev (audio hardware, tty’s, /dev/null for example).
if [ -f ~/.bashrc ] # check if a regular file exist and if it is a regular file (not special nor character files).
if [ -d ~/.ssh  ] # check if directory exist and is a directory.
if [ -h /bin ] # check if /bin is a symbolic link.
if [ -L /sbin ] # check if /sbin exist and is a symbolic link.
if [ -r readablefile.txt ] # check if readablfile.txt exist and is readable by the script.
if [ -w writeablefile.py ] # check if writeablefile.py exist and is writeable by the script.
if [ -x executablefile ] # check if executablefile exist and is executable by the script.
if [ newerfile -nt olderfile ] # check if newerfile was changed more recently than olderfile or if newerfile exist and olderfile doesn't.
if [ olderfile -ot newerfile ] # check if olderfile was changed longer than newerfile or if newerfile exist and olderfile doesn't.
if [ /dev/cdrom -ef /dev/dvd ] # checks if /dev/cdrom and /dev/dvd refers to the same device/inode number (here our primary cd drive, reads dvd too).
if [ -s nonemptyfile ] # check if a the nonemptyfile exist and has a size greater that 0 bytes.
if [ -g . ] # check if "." is set with SGID-bit (all file created inside will inherit the SGID bit).
if [ -u /etc/passwd ] # check if suidfile.jar exist and is set SUID-bit
if [ -G file ] # check if file exists and is owned by the effective group ID whish is the primary group id of the executing user.
if [ -O file ] # check if file exists and is owned by the effective user ID (user that runs the script).
if [ -k /tmp ] # check if /tmp exists and has its sticky bit set whish is used to prevent world writeable directories from having their content deletable by anyone.
if [ -S /var/lib/mysql/mysql.sock ] # check if socket exist and is a socket.
if [ -t /dev/pts/3 ] # check if /dev/pts/3 exist and refer to an open terminal.
#~~~~~#
if [ -N /etc/crontab ]; then # check if /etc/crontab was modified since last read.
killall -HUP crond # SIGHUP makes crond reread all crontabs
fi
#~~~~~#
if [ -p $file ]; then # check if $file exist and is a named pip file which are files inside /dev/fd that we can read just once.
cp $file tmp.tmp # Make sure we’ll be able to read
file="tmp.tmp"    # the file as many times as we like
fi
##-----[[  ]]-----##
if [[ $var == omar ]] # upgrade of '[ ]',support '[ ]' feartures and have extended ones like testing string value with regular expression, no need to put a variable in "" to evaluate an espace for example, (support && and || and also -a and -o from [ ])
#~~~~~#
if [[ -a *.sh ]]; then # if their is 1 file => true, if their is 0 files => false, if their is n files => will return true at the first files because their is no filename expansion.
#~~~~~#
if [[ “$email” =~ “b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}b” ]]; then # example of regex comparaison.
echo “$email contains a valid e-mail address.”
fi
#~~~~~#
##----- IF (( ))-----##
if (( $number <= 5 )) # perfom arithemetic, if the result of calculation != 0 , it return exit code 0 (true), support <=, =>, ==, &&, !!, etc, as for programming.
##-----IF ()-----##
if ( rm -r dir ) # create a subshell and once the command is executed sets an exit code, IF command execution was successfull return true, else false.(main raison to use is to not affect ENV VAR)
##-----IF COMMAND-----##
if rm -r dir # if commend execution is successfull return true.
