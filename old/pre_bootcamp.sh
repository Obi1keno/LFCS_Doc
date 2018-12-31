####_HARD_&_SOFT_LINKS_####
ln file1 file2 # create a hard link.
ln -s file1 softlink1 # -s : soft, create a soft link.
####_VIEW_FILES_DIRECTORIES_####
cat file1 # view file1 on stdout (screen).
tac file1 # view file1 backwords.
less file1 # view larger files with paging.
tail -n 10 file1 # -n : number of lines, show the last 10 lines of file1, -f : follow , appended as the files grows.
head -n 10 files # opposite of tail , show the fist 10 lines of file1.
cd $HOME || cd ~ # change directory to home directory.
pwd # current directory.
####_FILES_MANIPULATIONS_####
diff -ciwq file1 file2 # -c : print file content and add "!" to lines that differ, -i : ingore the case, -w : ignore tab and space, -q : quiet mode (the files differs "yes" or "no").
diff -r /root /usr # compare two directories and print what differs.
diff3 ref_file file1 file2 # compare two files to a reference file.
cmp file1 file2 # used to compare two files byte by byte.
patch originalfile patchfile # used to patch files modifying only deltas.
file file1 # test the file and displays his type.
####_dd_rsync_####
dd if=/dev/sda of=/dev/sdv # make byte for byte image of /dev/sda into /dev/sdv (can be used whit strage drive, partition, file system, etc.)
dd if=/dev/sda of=/home/student/backup.img bs=4096 && dd if=backup.img of=/dev/sdb # bs = the number of bytes to copy at a single time, create an backup image and import it later.
ssh username@54.98.132.10 "dd if=/dev/sda | gzip -1 -" | dd of=backup.gz # backup a remote /dev/sda into a local backup.gz image.
dd if=/dev/urandom of=/dev/sda1 # (data definition) make it harder to restore data from sda1 by adding random characteres everywhere.
dd if=/dev/sda of=sda.mbr bs=512 count=1 # backup the Master Boot loader (MBL), the first 512bytes sector on the disk.
rsync -r --dry-run project_X archive-machine:/archive_dir/project_X # -r : recursive, --dry-run : simulate, rsync copies only the part that change in a file (fast) locally or to a remote machine.
####_GZIP_BZIP2_XZ_ZIP_TAR_####
### GZIP ###
gzip -r project_Y # r : recursivly, compress directory and sub-directories
gunzip project_Y.gz || gzip -d project_Y.gz # -d : uncompress (both works).
### BZIP2 ###
bzip -r project_Y # # r : recursivly, compress directory and sub-directories
bunzip project_Y.bz2 || bzip2 -d project_Y.bz2 # -d : uncompress (both works).
### XZ ###
xz -r project_Y # r : recursivly, compress directory and sub-directories
xz -dk project_Y.xz# -d : uncompress, k : keep the compressed file do not delete it after uncompress.
### ZIP ###
zip backup_home /home/student/* # compress all file inside /home/student/* inside backup_home.
unzip backup_home.zip # uncompress in current directory.
### TAR ###
tar zcvf mytardir.tar.gz mytardir # z or --gzip : compress using gz(-j or --bzip2, -J or --xz), c : create archive tar, v : verbose, f : archive file.
tar xvf myTarfile.tar # x : extract, v : verbose, f : specify file, into myTarfile directory.
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
