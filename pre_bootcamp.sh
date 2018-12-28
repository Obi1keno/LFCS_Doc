####_HARD_&_SOFT_LINKS_####
ln file1 file2 # create a hard link.
ln -s file1 softlink1 # -s : soft, create a soft link.
####_VIEW_FILES_####
cat file1 # view file1 on stdout (screen).
tac file1 # view file1 backwords.
less file1 # view larger files with paging.
tail -n 10 file1 # -n : number of lines, show the last 10 lines of file1, -f : follow , appended as the files grows.
head -n 10 files # opposite of tail , show the fist 10 lines of file1.
####_FILES_MANIPULATIONS_####
diff -ciwq file1 file2 # -c : print file content and add "!" to lines that differ, -i : ingore the case, -w : ignore tab and space, -q : quiet mode (the files differs "yes" or "no").
diff -r /root /usr # compare two directories and print what differs.
cmp file1 file2 # used to compare two files byte by byte.
####_CREATION_####
touch file1 # create an empty file1, -t : set the date and timestamp of a file.
mkdir dir1 # create directory dir1.
rmdir dir1 # if dir1 is empty, will remove it.
####_RM_DELETE_####
rm -if file1 # -i : interfactive, -f : force, delete file1.
rm -rf dir1 # -r : recursive, -f : force, delete a directory and his content.
####_SEARCH_####
locate zip | grep bin # search for file1, locate uses a file and directory database.
update db # update file & dir database.
find /usr -iname "*.gcc" -type F -exec rm{}';' # -iname : name of file non case sensitive(i), -type : type of the file , -exec : execute, rm{} : remove place holder which will contains all files found, ';' or "\;" end of command.
find /var -ctime 3 -atime +3 -mtime -2 -size +10M # -ctime : last changed 3 days ago(=3days), -atime : last accessed in more than 3 days(>3days) , -mtime : last modified in the last 2 days(<2days), -size : size of the file in Megabits.
####_PS_ENV_VARIABLE_####
export PS1=\u@\h\$ # u : user, h : host, omar@server$.
####_STANDARD_FILE_STREAMS_&_I/O_REDIRECTIONS_####
cat < file0 # set stdin input as file0.
ls -l /var > file1 # set stdout output to file1.
ls -l /do_not_exist 2> file2 # set error output to file2.
ls -l /var > file1and2 2>&1 || ls -l /var >& file1and2 # redirect stdout and stderr to file1and2.
####_MAN_PAGES_####
man -f sysctl # same as "whatis" command, gives description.
man -k sysctl # prints specific subject list of man pages discussing the subject.
man -a printf # displays all man pages (1 to 9) for printf.
man --help # short description.
####_PROCESSES_&_LOAD_AVERAGE_####
w # shows users, their processes, how many are logged and the system load average.
top # display linux processes.
uptime # how long the system has been running.
updatedb & # run command in background, CTRL+Z : suspend forground job(Pause), CTRL+C terminate forground job(Stop).
bg # display background jobs, command or processes.
fg # set background job to forground.
jobs -l # list all background processes and their PIDs.
####_SCHEDULING_AT_CRONTAB_####
atd # runs at daemons.
at -f script.sh now + 2 minutes # run script.sh in 2 minutes from now.
atq # Displays at queue.
crontab -l -u root # -l : list, -u : user, list crontabs for user root.
crontab -e # -e : edit, edit crontabs for current user.
####_MOUNT_UNMOUNT_FILESYSTEMS_####
mount /dev/sda5 /home # mount the device node (/dev/sda5) into the mount point directory (/home).
mount || cat /proc/mounts # show all presently mounted FS according to /etc/mtab -> /proc/self/mounts
umount /home # un mount /home from /dev/sda5.
cat /etc/fstab # explicitly requested filesystem table, to edit in order to mount at startup.
cat /proc/filesystems # filesystem types the current kernel supports.
man mount # to display list of filesystem independent options.
cat /proc/sys/kernel/random/uuid || uuidgen # to generate a random UUID.
ls -l /dev/disk/by-uuid/ # UUID names and their link to the block device.
blkid # locate/print block device attributes.
