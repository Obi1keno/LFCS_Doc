#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
################
####_GENERAL_###
################
### SSH ###
#---------#
ssh student@ansibleprod
### SHUTDOWN & REBOOT ###
#-----------------------#
shutdown -h 10:00 "Shutingdown for update" # -h : halt 10:00 schedule "" message to users.
### HISTORY ###
#-------------#
history # print history of commands executed based on ~/.bash_history. (env variable for history : HISTFILE > location, HISTFILESIZE > max line numbers, etc.)
### SHORTCUTS ###
#---------------#
!! # runs last command executed.
!vim # runs last "vim" command executed.
CTRL-R # search for previous commands.
CTRL-L # clear screen (same as clear command).
CTRL-D # exit current shell (same as exit command).
CTRL-Z # put current process runing into suspended backgroup.
CTRL-C # kill current process.
CTRL-A # beginning of the line.
CTRL-U # delete all line.
### MAN PAGES ###
#---------------#
man -f sysctl # same as "whatis" command, gives description.
man -k sysctl # prints specific subject list of man pages discussing the subject.
man -a printf # displays all man pages (1 to 9) for printf.
man --help # short description.
### BIN or APPs INFO ###
#----------------------#
whatis firefox # display manual page descriptions.
which firefox # shows the full path of (shell) commands.
whereis firefox # locate the binary, source, and manual page files for a command.
type cd # give the type of the command (example cd is a shell builtin)
help # displays information about builtin commands.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
###################
####_FILESYSTEM_###
###################
### SPACE FILESYSTEM INFO ###
#---------------------------#
df -Th # -T : print filesystem type, -h : human readable, df or diskfree displays filesystem disk usage.
du --max-depth=1 -hx # -x : stay on fs do not look at dir that aren't in / (/dev/proc/run/sys) -h : human readable.
### MOUNT UNMOUNT FILESYSTEMS ###
#-------------------------------#
mount /dev/sda5 /home # mount the device node (/dev/sda5) into the mount point directory (/home).
mount || cat /proc/mounts # show all presently mounted FS according to /etc/mtab -> /proc/self/mounts
umount /home # un mount /home from /dev/sda5.
cat /etc/fstab # explicitly requested filesystem table, to edit in order to mount at startup.
cat /proc/filesystems # filesystem types the current kernel supports.
man mount # to display list of filesystem independent options.
cat /proc/sys/kernel/random/uuid || uuidgen # to generate a random UUID.
ls -l /dev/disk/by-uuid/ # UUID names and their link to the block device.
blkid # locate/print block device attributes.
### NFS ###
#---------#
systemctl start nfs # start nfs daemon.
systemctl enable nfs # nfs started at boot.
cat /etc/exports # contains directories and permissions to share with other hosts.
exportfs -av # -a : export or unexport directories, v : verbose : notify system about new NFS directories, you can also restart nfs but it is heavier.
mount ansible_server:/home/student/project /mnt/nfs/project # mount manually the NFS if he wasnt mounted automatically in /etc/fstab.
### DD & RSYNC ###
#----------------#
dd if=/dev/sda of=/dev/sdv # make byte for byte image of /dev/sda into /dev/sdv (can be used whit strage drive, partition, file system, etc.)
dd if=/dev/sda of=/home/student/backup.img bs=4096 && dd if=backup.img of=/dev/sdb # bs = the number of bytes to copy at a single time, create an backup image and import it later.
ssh username@54.98.132.10 "dd if=/dev/sda | gzip -1 -" | dd of=backup.gz # backup a remote /dev/sda into a local backup.gz image.
dd if=/dev/urandom of=/dev/sda1 # (data definition) make it harder to restore data from sda1 by adding random characteres everywhere.
dd if=/dev/sda of=sda.mbr bs=512 count=1 # backup the Master Boot loader (MBL), the first 512bytes sector on the disk.
rsync -r --dry-run project_X archive-machine:/archive_dir/project_X # -r : recursive, --dry-run : simulate, rsync copies only the part that change in a file (fast) locally or to a remote machine.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
##############################
####_FILES_AND_DIRECTORIES_###
##############################
#### VIEW FILES DIRECTORIES ###
#----------------------------#
cat file1 # view file1 on stdout (screen).
tac file1 # view file1 backwords.
less file1 # view larger files with paging.
tail -n 10 file1 # -n : number of lines, show the last 10 lines of file1, -f : follow , appended as the files grows.
head -n 10 files # opposite of tail , show the fist 10 lines of file1.
cd $HOME || cd ~ # change directory to home directory.
pwd # current directory.
### FILES MANIPULATIONS ###
#-------------------------#
##-----test file-----##
file file1 # test the file and displays his type.
##-----DIFF and CMP-----##
diff -ciwq file1 file2 # -c : print file content and add "!" to lines that differ, -i : ingore the case, -w : ignore tab and space, -q : quiet mode (the files differs "yes" or "no").
diff -r /root /usr # compare two directories and print what differs.
diff3 ref_file file1 file2 # compare two files to a reference file.
cmp file1 file2 # used to compare two files byte by byte.
##-----patchs-----##
patch originalfile patchfile # used to patch files modifying only deltas.(see diff and patch example)
##-----SED-----##
sed -e s/xxx/yyy file > file_output # -e : expression, replace first occurence of xxx with zzz in file and output to file_output.
sed -e s/01/JAN/g -e s/02/FEB/g -i file # -e : expression, -i : replace in the same file, replace all occurence of 01 with JAN and 02 with FEB in file.
sed -e s:/sbin/nologin:/bin/bash/g # better use ":" than : sed -e s/\/bin\/nologin/\/bin/\bash/g...
sed -f sed_script file_to_change # -f : file, use sed_script, to change file_to_change.
##-----AWK-----##
awk -F : '{print "name: "$1" shell : "$7}' /etc/passwd # -F : field separator ":" here(:,space,',',;,etc.), print the $1 first column and $7 seventh column of /etc/passwd ($0 will print all file).
##-----SORT-----##
sort file # sort lines according to the first characteres (-r : reverse).
sort -k 3 -u file # -k : key of sorting, -u : unique, sort lines according to the 3 first chars, then sort will check for uniq values after sorting.
##-----UNIQ-----##
sort file1 file2 | uniq > file3 # sort file1 and file 2 and then remove duplicate lines and output the result to file3.
sort -c file1 # -c : count , print the count of duplicate value in file1.
##-----PASTE-----#
paste -d , file1 file2 > file3 # -d : delimeter =',' , file1 = "omar,bistami", file2 = "30", file3 will be : "omar,bistami,30".
##-----JOIN-----#
join file1 file2 > file3 # file1="0001 omar", file2="0001 bistami" , file3 will be ="0001 omar bistami".
#-----SPLIT-----#
split -l 1000 american-english output_name # -l : number of lines per file, split the american english dictionnary in to multiple files output_nameaa, output_nameab, etc. each with 1000 lines.
#-----GREP-----#
grep -v 'pattern' file # -v : invert match line that do not contain 'pattern'.
grep [0-9] file # print file containing 0,1,2,..,8,9.
grep -rnw '/path/to/somewhere/' -e 'pattern' # r : recursive, n : print line number, -w : whole word 'pattern', -e : pattern to search(1..n), find all files inside '/path/to/somewhere containing' 'pattern'
#-----String-----#
string book.xls | grep my_string # extract all printable chars in a non human file.
#-----tr-----#
tr [:space:] '\t' file1 file2.yml # replace all space to tab.
#-----tee-----#
ls -lrta | tee ls_output # print output and save a copy to ls_output.
#-----wc-----#
wc file # print -l : number of line, -c : number of bytes, -w : number of words (if empty the 3 are diplays by default).
#-----cut-----#
ls -l | cut -d " " -f3 # -d : delimiter, -f3 : 3rd column, used to manipulate column based files to extract specific columns.
### CREATION ####
#---------------#
touch file1 # create an empty file1, -t : set the date and timestamp of a file.
mkdir dir1 # create directory dir1.
rmdir dir1 # if dir1 is empty, will remove it.
### STANDARD FILE STREAMS & I/O REDIRECTIONS ####
#-----------------------------------------------#
cat < file0 # set stdin input as file0.
ls -l /var > file1 # set stdout output to file1.
ls -l /do_not_exist 2> file2 # set error output to file2.
ls -l /var > file1and2 2>&1 || ls -l /var >& file1and2 # redirect stdout and stderr to file1and2.
#TODO
### REMOVE DELETE ###
#-------------------#
rm -if file1 # -i : interfactive, -f : force, delete file1.
rm -rf dir1 # -r : recursive, -f : force, delete a directory and his content.
### HARD & SOFT LINKS ###
#-----------------------#
ln file1 file2 # create a hard link.
ln -s file1 softlink1 # -s : soft, create a soft link.
### SEARCH ###
#------------#
locate zip | grep bin # search for file1, locate uses a file and directory database.
update db # update file & dir database.
find /usr -iname "*.gcc" -type F -exec rm{}';' # -iname : name of file non case sensitive(i), -type : type of the file , -exec : execute, rm{} : remove place holder which will contains all files found, ';' or "\;" end of command.
find /var -ctime 3 -atime +3 -mtime -2 -size +10M # -ctime : last changed 3 days ago(=3days), -atime : last accessed in more than 3 days(>3days) , -mtime : last modified in the last 2 days(<2days), -size : size of the file in Megabits.
### GZIP BZIP2 XZ ZIP TAR ###
#---------------------------#
##-----GZIP-----##
gzip -r project_Y # r : recursivly, compress directory and sub-directories
gunzip project_Y.gz || gzip -d project_Y.gz # -d : uncompress (both works).
zcat file.txt.gz || zless file.txt.gz || zmore file.txt.gz # view the gzip compressed file file.txt.gz.
zgrep -i less file.txt.gz # i : ignore case, search inside file.txt.gz
##-----BZIP2-----##
bzip -r project_Y # # r : recursivly, compress directory and sub-directories
bunzip project_Y.bz2 || bzip2 -d project_Y.bz2 # -d : uncompress (both works).
bzcat file.txt.bz2 || bzless file.txt.bz2 || bzmore file.txt.bz2 # view the gzip compressed file file.txt.bz2.
bzgrep -i less file.txt.bz2 # i : ignore case, search inside file.txt.bz2
###-----XZ-----##
xz -r project_Y # r : recursivly, compress directory and sub-directories
xz -dk project_Y.xz# -d : uncompress, k : keep the compressed file do not delete it after uncompress.
xzcat file.txt.xz || xzless file.txt.xz || xzmore file.txt.xz # view the gzip compressed file file.txt.xz.
xzgrep -i less file.txt.xz # i : ignore case, search inside file.txt.xz
##-----ZIP-----##
zip backup_home /home/student/* # compress all file inside /home/student/* inside backup_home.
unzip backup_home.zip # uncompress in current directory.
##-----TAR-----##
tar zcvf mytardir.tar.gz mytardir # z or --gzip : compress using gz(-j or --bzip2, -J or --xz), c : create archive tar, v : verbose, f : archive file.
tar xvf myTarfile.tar # x : extract, v : verbose, f : specify file, into myTarfile directory.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
##############################
####_USERS_GROUPS_ENV_Vars_###
##############################
### USERS GROUPS INFORMATIONS ###
#-------------------------------#
groups obistami # display the groups were "obistami" belongs.
su obistami # switch to obistami , if empty switch to root.
who # list current login users.
whoami # identify current user.
id obistami # information about user (uid, gid, groups, etc.)
### USERS GROUPS CREATION, MODIFICATION and SUPPRESSION ###
#---------------------------------------------------------#
useradd obistami # create a new use by adding a line to : /etc/passwd(obistami:x:1000:1000::/home/obistami:/bin/bash) , creating a home directory : /home/obistami and copying basic files from : /etc/skel/* .
userdel -r obistami # -r : delete user and home directory.
groupadd devs # add the group "devs".
groupdel devs # delete the group "devs".
usermod -a -G devs obistami # -a : append, -G : list of group affected by -a (if !-a user will be removed from group not listed) add obistami to the group devs.
### SUDO ###
#----------#
touch /etc/sudoers.d/student < student ALL = (ALL) ALL && chmod 440 /etc/sudoers.d/student # add a sudoer user named student.
sudo -E bash - # -E : indicate to the security policy that user wishes to preserve their existing env variables (can return error).
### PERMISSIONS AND OWNERSHIP ###
#-------------------------------#
chmod 755 file || chmod u+rwx,g+a,g+rwx # +a : all, set file permissions to 755 (1 = execute , 2 = write, 4 = read).
chown apache:apache /etc/httpd/httpd.conf # change ownership of the file to the user and group apache.
umask || umask -S # -S : symbolic representation (rwx) view the current umask.
umask 022 # set new created files permissions , new file in linux by default have 644 - 022 (applying umask) = 622, new directories by default have 755 - 022 (umask) = 733.
-rw-r--r--. 1 root root # file with no link =1.
-rw-r--r--. 2 root root # file that has 2 reference pointing to it (link) = 2.
drwxr-xr-x 10 root root # directory containing 8 files, "." and ".." = 10 files.
### ENV-VAR ###
#-------------#
alias ls='ls -al' # set a new alias for ls, if no option show all set alias, to make it persistent, place them in ~/.bashrc.
set || env || export || printenv # print environnement variables (set print more info).
export JAVA_HOME=/usr/java/jre1.6.0_04 # export a new env variable (here the java home), to make it permanant on each user shell, add it to ~/.bashrc and run : source ~/.bashrc || . ~/.bashrc.
export PATH=/usr/java/jdk1.8.0_04/bin:$PATH # add jdk to path variable, be sure to add $PATH at the end, to not override previous paths.
export SHELL=/bin/bash # set the default shell.
export PS1=\u@\h\$ # u : user, h : host, omar@server$, export PS1 variable.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
###########################
####_PACKAGE_MANAGEMENT_###
###########################
### RPM ###
#---------#
##-----RPM informations-----##
rpm -q bash # -q : query, get bash version installed.
rpm -qf /bin/bash # -f : file, from which package this file come from.
rpm -ql bash # -l : list, list file installed by the package.
rpm -qi bash # -i : info, show bash informations, -qip foo-1.0.0-1.noarch.rpm (-p : package) show info from package file.
rpm -qa # -a : all, list all installed packages.
rpm -qp --requiere foo-1.0.0-1.noarch.rpm # list prerequisite for a packages.
rpm -q --whatprovides libc-so.6 # What installed package provides a particular requisite package. TODO.
##-----RPM verification-----##
rpm -Va # -V : Verify -a : all, Allows to verify if package is consistent with the system RPM DB
##-----RPM install, uninstall and updates-----##
rpm -ivh foo-1.0.0-1.noarch.rpm # -i : install, -v : verbose, -h : print hash marks.
rpm -e system-config-lvm # -e : erase, will fail if package do not exist or if dependecies.
rpm -Uvh bash-4.2.45-5.el7_0.4.x86-64.rpm # -U : Upgrade, old package removed, old config file kept, --oldpackage to downgrade.
rpm -Fvh *.rpm # F : freshen all packages in . , if older version installed -> Upgrade, if same version -> nothing, if no version installed -> package ingored. (usefull for applying patchs.).
rpm -qilp foobar.rpm # query list files package in a rpm.
rpm --rebuilddb # rebuild rpm database , but first backup /var/lib/rpm and run -qa (query all) to test.
rpm2cpio xxx.rpm > xxx.cpio # copy file from rpm to cpio.
rpm2cpio bash-4.2.45-5.el7_0.4x86_64.rpm | cpio -ivd bin/bash # extract into the system.
### YUM ###
##-----YUM informations-----##
yum clean all # [packages|metadata|expire-cache|rpmdb|plugins|all] clean cached data.
time yum makecache # generate cache from repos, option : "fast" can be used to cache only a part of the repos.
yum search rundeck # show available packages named "rundeck".
yum list rundeck # [installed|updates|available] show packages by name or type (installed, updates, etc.).
yum info rundeck # show detailled info about installed package named "rundeck" and detailled info about available updates.
yum list  # list installed , updates or available packages.
yum provides /etc/logrotate.conf # which packages contains the file "logrotate.conf"
yum provides yum # which packages provides the command yum
yum repolist # list all repos.
##-----YUM history, plugins and verification-----##
yum history # show history with possiblity of undo & redo.
yum install yum-plugin-verify # install yum plugin to verify packages.
yum list yum-plugin* # list yum plugins installed.
yum verify rundeck # verify the package rundeck.
yum verify-all # verify all installed packages.
man yum-verify # manuel page of yum-verify.
##-----YUM install, uninstall and updates-----##
yum install rundeck # install package rundeck.
yum local install foo-1.0.0-1.noarch.rpm # install from a local rpm.
yum install --downloadonly rundeck # will download package without installing and store it in /var/cache/yum (or use "d" instead of "y" or "no" during normal install).
yum -i foo-1.0.0-1.noarch.rpm # install from a rpm file and resolve dependecies using repos.
yum remove rundeck # uninstall rundeck and all package that depend on it, thats why you should never use -y (yes to all).
yum update rundeck # update package rundeck, if no package name given , all packages are updated.
##-----YUM Shell and group installation-----##
yum shell [text-file] # interactive Yum shell, can use a file with commandes as input (text-file).
yum grouplist infra* || yum groupinfo basic* # show informations about groups.
yum groupinstall group_name || yum install @group_name # install a group of software.
yum group summary # list all available group packages.
##-----Packages conf files-----##
find /etc -name "*.rpm*" # list all packages rpm conf files stored inside /etc.
### DNF ###
##-----DNF informations, install, uninstall and update-----##
dnf search php # searche packages on the repos.
dnf install httpd # install package httpd.
dnf remove httpd # uninstall package httpd.
dnf check-update # check for available updates.
dnf update httpd -y # -y : assumes yes, update httpd.
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
###############################
####_MONITORING AND TUNNING_###
###############################
### GENERAL ###
#-------------#
w # shows users, their processes, how many are logged and the system load average.
top # display load average, memory, cpu utilization and linux processes.
### ULIMITE ###
#-------------#
ulimit -a # show all limits.
ulimit -n 1600 # increase the max number of file descriptors.
ulimit -n hard || ulimit -n soft # set the limit at soft or hard.
### NICE & RENICE ###
#-------------------#
nice -n 5 sleep 10 # set niceness , -19 -> 20 +Nice = -Priority.
renice +3 sleep 10 # reset the niceness / priority.
### DYNAMIC/SHARED LIBRARIES ###
#------------------------------#
ldd /usr/bin/vi # print shared object(libs) dependecies.
ldconfig # configure dynamic linker(shared libs) run time bindings, run to update if new lib added (lib, lib64), env var LD_LIBRARY_PATH.
ipcs -p # overall activity summary on SysV -p : info about the processes that created the seg.
### SYSTEM & Monitoring ###
#-------------------------#
uptime # how long the system has been running and load average.
### CPU & Monitoring ###
#----------------------#
grep processor /proc/cpuinfo | wc -l # display load average.
### MEMORY & Monitoring ###
#-------------------------#
### PROCESSES & Monitoring ###
#---------------------------#
##-----Background jobs-----##
updatedb & # run command in background, CTRL+Z : suspend forground job(Pause), CTRL+C terminate forground job(Stop).
bg # display background jobs, command or processes.
fg # set background job to forground.
jobs -l # list all background processes and their PIDs.
##-----SCHEDULING AT and CRONTAB-----##
atd # runs at daemons.
at -f script.sh now + 2 minutes # run script.sh in 2 minutes from now.
atq # Displays at queue.
crontab -l -u root # -l : list, -u : user, list crontabs for user root.
crontab -e # -e : edit, edit crontabs for current user.
##-----PS & TOP-----## {PS : BSD no '-', UNIX '-', GNU '--'}
ps -elF # [SYSTEMV Style] -e : select all processes, -l : long format, -F : extrat full format(info for each thread), you can use -H for tree(how a process is connected to his ancestor).
ps aux # [BSD Style] a : lift BSD "only yourself" to see all, u : user oriented format, x : Register formart, you can use f for tree(how a process is connected to his ancestor).
ps top # Display linux process.
##-----SIGNALS KILL-----##
kill -l # display a list of signals with their numbers, SIGRTMAX and SIGRTMIN are ream time signals, recent addition no purpose uses FIFO.
man 7 signal # full signal docs.
kill 1988 # kill proc pid 1988 with SIGTERM (terminate/safe kill), use -9 SIGKILL to force kill.
killall java # kill all processes with java name.
pkill -u student java # kill all java process of user student.
### I/O ###
#---------#
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________#
#################
####_NETWORK_####
#################
### WGET CURL AND FTP ###
#-------------------------#
wget "URL" # non interactive network downloader.
curl -o file.html www.google.com # -o : output to file, transfert a URL (source code or return json from a webservice for example) .
sftp ftp.gnu.org && get welcome.msg # connect to the sftp server and get the welcome.msg file.
scp file obistami@ansiblemaster:/home/obistami # copy file from local to remote server.
### Network misc ###
#-------------------------#
hostname # display, configure the system hostname.
host google.com # (package : bind-utils) dnslookup (ip, mx, v4, v6, etc.).
ping -c 5 google.com # -c : count of pings, pings the host google.com and display answers.
vim /etc/sysconfig/network # network config files (Fedora, CentOS).
vim /etc/network # network config files (debian).
ifconfig || ip addr # (package : net-tools) display info about network interfaces and networks (IP, Mask, etc).
dhclient eth0 # get a fresh IP from dhcp.
vim /etc/hosts # contains server hosts file for local host resolution before /etc/resolv.conf.
vim /etc/resolv.conf # file containing dns used to resolve name and ip adresses.
ip rout show # show routing info.
route -n # -n : show numerical addresses, display current routing table.
route add -net xx.xxx.xx.xx # add static route. (del to delete) //TODO
traceroute google.com # (package : traceroute) inspect the route which the data takes to reach destination.
ethtool ens33 # (package : ethtool) query network interfaces and set params such as speed.
netstat # display active connections and routing tables (usefull for monitoring and troubleshooting).
nmap -vv htts://google.com/ # (package nmap) -vv : super verbosity, scans open ports on a network, useful for security.
tcpdump -i ens33 # -i : interface, dumps network traffic for analysis.
iptraf-ng -i ens33 # (package iptraf-ng) -i : interface, monitor network traffic in text mode.
mtr -rw google.com # (package mtr) -r : generate report, -w : hostname long version, combine ping and traceroute, give continous displays.
dig www.google.com # test dns like host or nslookup.
