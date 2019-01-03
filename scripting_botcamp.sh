#####~~SHELL SCRIPTING~~#####
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
##############################
####_GENERAL_####
##############################
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
### [] [[ ]] (( )) () ###
#--------------------------#
##-----[ ]-----##
TODO
##-----[[ ]]-----##
##-----(( ))-----##
##-----()-----##
