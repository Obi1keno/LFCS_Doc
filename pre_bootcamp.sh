####_HARD_&_SOFT_LINKS_####
ln file1 file2 # create a hard link.
ln -s file1 softlink1 # -s : soft, create a soft link.
####_VIEW_FILES_####
cat file1 # view file1 on stdout (screen).
tac file1 # view file1 backwords.
less file1 # view larger files with paging.
tail -n 10 file1 # -n : number of lines, show the last 10 lines of file1, -f : follow , appended as the files grows.
head -n 10 files # opposite of tail , show the fist 10 lines of file1.
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
find /usr -name "*.gcc" -type F -exec rm{}';' # -name : name of file, -type : type of the file , -exec : execute, rm{} : remove place holder which will contains all files found, ';' or "\;" end of command.
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
updatedb & # run command in background, CTRL+Z : suspend forground job(Pause), CTRL+C terminate forground job(Stop)/
bg # display background jobs, command or processes.
fg # set background job to forground.
jobs -l # list all background processes and their PIDs.
