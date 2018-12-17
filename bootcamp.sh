ssh student@ansibleprod
shutdown -h 10:00 "Shutingdown for update" # -h : halt 10:00 schedule "" message to users.
touch /etc/sudoers.d/student < student ALL = (ALL) ALL && chmod 440 /etc/sudoers.d/student #add a sudoer user named student.
sudo du --max-depth=1 -hx # -x : stay on fs do not look at dir that aren't in / (/dev/proc/run/sys) -h : human readable.
whatis firefox # display manual page descriptions.
which firefox # shows the full path of (shell) commands.
whereis firefox # locate the binary, source, and manual page files for a command.
ulimit -a # show all limits.
ulimit -n 1600 # increase the max number of file descriptors.
ulimit -n hard # -n soft - set the limit at soft or hard.
nice -n 5 sleep 10 # set niceness , -19 -> 20 +Nice = -Priority.
renice +3 sleep 10 # reset the niceness / priority.
ldd /usr/bin/vi # print shared object(libs) dependecies.
ldconfig # configure dynamic linker(shared libs) run time bindings, run to update if new lib added (lib, lib64), env var LD_LIBRARY_PATH.
ipcs -p # overall activity summary on SysV -p : info about the processes that created the seg.
kill -l # display a list of signals with their numbers, SIGRTMAX and SIGRTMIN are ream time signals, recent addition no pupose uses FIFO.
man 7 signal # full signal docs.
kill 1988 # kill proc pid 1988 with SIGTERM (terminate/safe kill), use -9 SIGKILL to force kill.
killall java # kill all processes with java name.
pkill -u student java # kill all java process of user student.
