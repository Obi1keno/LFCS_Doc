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
source script.sh || . script.sh # TODO
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
# comment
\ # indicate new line, example :
scp abc@server:/var/ftp/pub \
xyz@server2:/opt/test
; # separate command "xxx; yyy" != "xxx & yyy"

TODO

$var # what follows $ is a variable.
> # redirect ouput.
>> # append ouput.
< # redict input.
xxx | yyyy # pipe
