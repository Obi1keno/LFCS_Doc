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
### command substitution () & parameter substitution {} ###
x=2 ; ( x=5 ) ; echo $x : 2 # () create a subshell that do not affect parent shell.
x=2 ; { x=4 } ; echo $x : 4 # parameter substitution, affect the current shell (Variable concatenation, Parameter Expansion and Positional Parameters in man bash).
#~~~~~#
animal=cat # variable declaration.
echo ${animal} : cat
echo ${animal}s : cats # parameter substitution of the variable animal and concatenation with s.
echo ${#animal} : 3 # length of the string.
echo ${animal:1:t} : at # from position 1 to t (cat, start a 0, c => 0).
echo ${animal/at/ow} : cow # replace at with ow.
cat=tabby
echo ${!animal} : tabby # variable indirection, kind like pointer in C (cat=tabby, animal=cat, !animal=tabby).
tabby=test.com # variable declaration.
echo ${tabby#*.} : com # print all characteres after "."
#~~~~~#

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
###################################
####_VARIABLES and PARAMETERES_####
###################################
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
### variables ###
#---------------#
age=30 # local var not shared with child processes.
export age=30 # env var shared with child, if a child process modify it, parent will not see it, ! ENV VAR are only copied and inherited, not shared !.
$ ls -ld "$filename" # always quote shells variables.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
###################
####_FUNCTIONS_####
###################
### Declaration ###
#-----------------#
showmess(){    # declare a function, $1 here is a function param.
  echo my message is : $1
}
### Call ###
#----------#
showmess OMAR # call the function with the param OMAR , the result will be "my message is : OMAR".
### others ###
#------------#
fun_function() {  # calling a function with a composed name base on a variable.
  echo im func 1
}
echo enter 1
read n
fun$n
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
#######################
####_CONDITIONS_IF_####
#######################
### Condition syntaxe : IF ELIF ELSE FI ###
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
### IF [] ###
#-----------#
##-----Syntaxe-----##
if [ "$var" == "omar" ] # same as command : 'test', used to check files types and compare values.
#~~~~~#
if [ -a *.sh ]; then # if their is 1 file => true, if their is 0 files => false, if their is n files => error, because *.sh is expanded to the files in the working directory.
##-----Arithemetic Operations val and let----#
val=`expr 2 + 2`; echo $val # expr evaluate experssions and return result. (+, -, *, /, %, =(assign), ==(equal), !=(not equal)). in modern scripting $(()) is used.
let x=( 2 + 2); echo $x # builin shell command for arithemetic. in modern scripting $(()) is used.
##-----Relational and Arithemetic Operators-----##
if [ $a -eq $b ] # equal.
if [ $a -ne $b ] # not equal.
if [ $a -gt $b ] # great than >.
if [ $a -lt $b ] # less than <.
if [ $a -ge $b ] # great or equal >=.
if [ $a -le $b ] # less or equal <=.
if [ ! false ] # give true, inverts the boolean operator.
if [ 10 -lt 20 -o 30 -gt 40] || if [ 10 -lt 20 ] || [ 30 -gt 40 ] # OR, will return true. (Note that the and operator has precedence over the or operator, meaning that “&&” or “-a” will be evaluated before “||” or “-o”.).
if [ 10 -lt 20 -a 30 -gt 40] || if [ 10 -lt 20 ] && [ 30 -gt 40 ]  # AND, will return false. (Note that the and operator has precedence over the or operator, meaning that “&&” or “-a” will be evaluated before “||” or “-o”.).
##-----String Operators-----##
if [ $a == $b ]  # equal (== works too), are string comparaison in [ ].
if [ $a != $b ] # not equal.,  are string comparaison in [ ].
if [ $a > $b ] # $a sorts after $b.
if [ $a < $b ] # $a sorts before $b.
if [ $a != $b ]
if [ -z $a ] # check if lenght size is zero, return true if it is the case.
if [ -n $a ] # check if size is NOT zero.
if [ $a ] # check if string $a is not empty. (if empty return false).
##-----File Test Operators-----##
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
##-----Miscellaneous-----##
if [ -o shelloption ] # check if shelloption is enabled, Shell options modify the behaviour of bash, except a few unmodifiable ones that indicate the shell status (checkwinzise, login_shell).
### IF [[ ]] ###
#--------------#
# shares sames operator as [ ] with exception and features bellow
##-----Syntaxe-----##
if [[ $var == omar ]] # upgrade of '[ ]',support '[ ]' feartures and have extended ones like testing string value with regular expression, no need to put a variable in "" to evaluate an espace for example, (support && and || and also -a and -o from [ ])
#~~~~~#
if [[ -a *.sh ]]; then # apply pattern matching rules, if their is 1 file => true, if their is 0 files => false, if their is n files => will return true at the first files because their is no filename expansion.
##-----Relational and Arithemetic Operators-----##
if [[ 5 == 5 ]] # equal.
if [[ 5 != 6 ]] # not equal.
if [[ 5 <= 6 ]] # great or equal.
if [[ 6 >= 5 ]] # less or equal.
if [[ 3 -eq 3 && bar == foo ]] # and, will return false. (Note that the and operator has precedence over the or operator, meaning that “&&” or “-a” will be evaluated before “||” or “-o”.).
if [[ 3 -eq 3 || bar == foo ]] # or, will return true. (Note that the and operator has precedence over the or operator, meaning that “&&” or “-a” will be evaluated before “||” or “-o”.).
##-----String Operators-----##
if [[ $var == omar ]] # compare string and apply pattern matching rules (*, ?, etc.), and no need for""(see pattern matching in bash).
##-----regex comparaison-----##
if [[ “$email” =~ “b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}b” ]]; then # example of regex comparaison.
echo “$email contains a valid e-mail address.”
fi
### IF (( )) ###
#--------------#
# only accepte numbers and arithemetic, accept normal operator "==", "<", ">=", "&&", "||", but no -o and -a. (String is converted to number).
##-----Syntaxe-----##
if (( $number <= 5 )) # perfom arithemetic, if the result of calculation != 0 , it return exit code 0 (true), support <=, =>, ==, &&, !!, etc, as for programming.
### IF ( ) ###
#------------#
if ( rm -r dir ) # create a subshell and once the command is executed sets an exit code, IF command execution was successfull return true, else false.(main raison to use is to not affect ENV VAR)
### IF command ###
#------------#
if rm -r dir # if commend execution is successfull return true.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
#########################
####_CONDITIONS_CASE_####
#########################
##-----Syntaxe-----##
case "$response" in
  "Hi")
      echo "hello to you";
      ;;
  "bye")
      echo "bye";
      break;
      ;;
    *)
      echo "Sorry, i don't understand"
      ;;
esac
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
##################
####_LOOP_FOR_####
##################
##-----Syntaxe-----##
for i in {1..5}
do
  sum=$(($sum+$i))
done
#~~~~~#
FILES="$@"
for f in $FILES
do
        # if .bak backup file exists, read next file
	if [ -f ${f}.bak ]
	then
		echo "Skiping $f file..."
		continue  # read next file and skip the cp command
	fi
        # we are here means no backup file exists, just use cp command to copy file
	/bin/cp $f $f.bak
done
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
####################
####_LOOP_WHILE_####
####################
##-----Syntaxe-----##
while [ $j -ne 0 ] # repeats as long as control command return TRUE (tant que j != 0), (The while loop enables you to execute a set of commands repeatedly until some condition occurs.).
do
  j=$(($j-1))
done
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
####################
####_LOOP_UNTIL_####
####################
##-----Syntaxe-----##
until [ $j -eq 0 ] # repeats as long as control command return FALSE (perfect for a situation where you need to execute a set of commands while some condition is true).
do
  j=$(($j-1))
done
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
####################
####_DEBUGGING_####
####################
