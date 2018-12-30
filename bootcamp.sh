####_GENERAL_HISTORY_SHORTCUTS_####
ssh student@ansibleprod
shutdown -h 10:00 "Shutingdown for update" # -h : halt 10:00 schedule "" message to users.
history # print history of commands executed based on ~/.bash_history. (env variable for history : HISTFILE > location, HISTFILESIZE > max line numbers, etc.)
!! # runs last command executed.
!vim # runs last "vim" command executed.
CTRL-R # search for previous commands.
CTRL-L # clear screen (same as clear command).
CTRL-D # exit current shell (same as exit command).
CTRL-Z # put current process runing into suspended backgroup.
CTRL-C # kill current process.
CTRL-A # beginning of the line.
CTRL-U # delete all line.
####_SUDO_####
touch /etc/sudoers.d/student < student ALL = (ALL) ALL && chmod 440 /etc/sudoers.d/student # add a sudoer user named student.
sudo -E bash - # -E : indicate to the security policy that user wishes to preserve their existing env variables (can return error).
####_SPACE_FILESYSTEM_INFO_####
df -Th # -T : print filesystem type, -h : human readable, df or diskfree displays filesystem disk usage.
du --max-depth=1 -hx # -x : stay on fs do not look at dir that aren't in / (/dev/proc/run/sys) -h : human readable.
####_NFS_####
systemctl start nfs # start nfs daemon.
systemctl enable nfs # nfs started at boot.
cat /etc/exports # contains directories and permissions to share with other hosts.
exportfs -av # -a : export or unexport directories, v : verbose : notify system about new NFS directories, you can also restart nfs but it is heavier.
mount ansible_server:/home/student/project /mnt/nfs/project # mount manually the NFS if he wasnt mounted automatically in /etc/fstab.
####_USER_GROUP_OWNERSHIP_PERMISSIONS_ENV-VAR_####
who # list current login users.
whoami # identify current user.
id obistami # information about user (uid, gid, groups, etc.)
useradd obistami # create a new use by adding a line to : /etc/passwd(obistami:x:1000:1000::/home/obistami:/bin/bash) , creating a home directory : /home/obistami and copying basic files from : /etc/skel/* .
userdel -r obistami # -r : delete user and home directory.
groupadd devs # add the group "devs".
groupdel devs # delete the group "devs".
usermod -a -G devs obistami # -a : append, -G : list of group affected by -a (if !-a user will be removed from group not listed) add obistami to the group devs.
groups obistami # display the groups were "obistami" belongs.
su obistami # switch to obistami , if empty switch to root.
alias ls='ls -al' # set a new alias for ls, if no option show all set alias, to make it persistent, place them in ~/.bashrc.
set || env || export || printenv # print environnement variables (set print more info).
export JAVA_HOME=/usr/java/jre1.6.0_04 # export a new env variable (here the java home), to make it permanant on each user shell, add it to ~/.bashrc and run : source ~/.bashrc || . ~/.bashrc.
export PATH=/usr/java/jdk1.8.0_04/bin:$PATH # add jdk to path variable, be sure to add $PATH at the end, to not override previous paths.
export SHELL=/bin/bash # set the default shell.

####_BIN_or_APPs_INFO_####
whatis firefox # display manual page descriptions.
which firefox # shows the full path of (shell) commands.
whereis firefox # locate the binary, source, and manual page files for a command.
type cd # give the type of the command (example cd is a shell builtin)
help # displays information about builtin commands.
####_ULIMITE_####
ulimit -a # show all limits.
ulimit -n 1600 # increase the max number of file descriptors.
ulimit -n hard || ulimit -n soft # set the limit at soft or hard.
####_NICE_&_RENICE_####
nice -n 5 sleep 10 # set niceness , -19 -> 20 +Nice = -Priority.
renice +3 sleep 10 # reset the niceness / priority.
####_DYNAMIC/SHARED_LIBRARIES_####
ldd /usr/bin/vi # print shared object(libs) dependecies.
ldconfig # configure dynamic linker(shared libs) run time bindings, run to update if new lib added (lib, lib64), env var LD_LIBRARY_PATH.
ipcs -p # overall activity summary on SysV -p : info about the processes that created the seg.
####_SIGNALS_KILL_####
kill -l # display a list of signals with their numbers, SIGRTMAX and SIGRTMIN are ream time signals, recent addition no purpose uses FIFO.
man 7 signal # full signal docs.
kill 1988 # kill proc pid 1988 with SIGTERM (terminate/safe kill), use -9 SIGKILL to force kill.
killall java # kill all processes with java name.
pkill -u student java # kill all java process of user student.
####_RPM_####
### RPM informations ###
rpm -q bash # -q : query, get bash version installed.
rpm -qf /bin/bash # -f : file, from which package this file come from.
rpm -ql bash # -l : list, list file installed by the package.
rpm -qi bash # -i : info, show bash informations, -qip foo-1.0.0-1.noarch.rpm (-p : package) show info from package file.
rpm -qa # -a : all, list all installed packages.
rpm -qp --requiere foo-1.0.0-1.noarch.rpm # list prerequisite for a packages.
rpm -q --whatprovides libc-so.6 # What installed package provides a particular requisite package. TODO.
### RPM verification ###
rpm -Va # -V : Verify -a : all, Allows to verify if package is consistent with the system RPM DB
### RPM install, uninstall and updates ###
rpm -ivh foo-1.0.0-1.noarch.rpm # -i : install, -v : verbose, -h : print hash marks.
rpm -e system-config-lvm # -e : erase, will fail if package do not exist or if dependecies.
rpm -Uvh bash-4.2.45-5.el7_0.4.x86-64.rpm # -U : Upgrade, old package removed, old config file kept, --oldpackage to downgrade.
rpm -Fvh *.rpm # F : freshen all packages in . , if older version installed -> Upgrade, if same version -> nothing, if no version installed -> package ingored. (usefull for applying patchs.).
rpm -qilp foobar.rpm # query list files package in a rpm.
rpm --rebuilddb # rebuild rpm database , but first backup /var/lib/rpm and run -qa (query all) to test.
rpm2cpio xxx.rpm > xxx.cpio # copy file from rpm to cpio.
rpm2cpio bash-4.2.45-5.el7_0.4x86_64.rpm | cpio -ivd bin/bash # extract into the system.
####_YUM_####
### YUM informations ###
yum clean all # [packages|metadata|expire-cache|rpmdb|plugins|all] clean cached data.
time yum makecache # generate cache from repos, option : "fast" can be used to cache only a part of the repos.
yum search rundeck # show available packages named "rundeck".
yum list rundeck # [installed|updates|available] show packages by name or type (installed, updates, etc.).
yum info rundeck # show detailled info about installed package named "rundeck" and detailled info about available updates.
yum list  # list installed , updates or available packages.
yum provides /etc/logrotate.conf # which packages contains the file "logrotate.conf"
yum provides yum # which packages provides the command yum
yum repolist # list all repos.
### YUM history, plugins and verification ###
yum history # show history with possiblity of undo & redo.
yum install yum-plugin-verify # install yum plugin to verify packages.
yum list yum-plugin* # list yum plugins installed.
yum verify rundeck # verify the package rundeck.
yum verify-all # verify all installed packages.
man yum-verify # manuel page of yum-verify.
### YUM install, uninstall and updates ###
yum install rundeck # install package rundeck.
yum local install foo-1.0.0-1.noarch.rpm # install from a local rpm.
yum install --downloadonly rundeck # will download package without installing and store it in /var/cache/yum (or use "d" instead of "y" or "no" during normal install).
yum -i foo-1.0.0-1.noarch.rpm # install from a rpm file and resolve dependecies using repos.
yum remove rundeck # uninstall rundeck and all package that depend on it, thats why you should never use -y (yes to all).
yum update rundeck # update package rundeck, if no package name given , all packages are updated.
### YUM Shell and group installation ###
yum shell [text-file] # interactive Yum shell, can use a file with commandes as input (text-file).
yum grouplist infra* || yum groupinfo basic* # show informations about groups.
yum groupinstall group_name || yum install @group_name # install a group of software.
yum group summary # list all available group packages.
### Packages conf files ###
find /etc -name "*.rpm*" # list all packages rpm conf files stored inside /etc.
####_DNF_####
### DNF informations, install, uninstall and update ###
dnf search php # searche packages on the repos.
dnf install httpd # install package httpd.
dnf remove httpd # uninstall package httpd.
dnf check-update # check for available updates.
dnf update httpd -y # -y : assumes yes, update httpd.
####_PS_&_TOP_#### {PS : BSD no '-', UNIX '-', GNU '--'}
ps -elF # [SYSTEMV Style] -e : select all processes, -l : long format, -F : extrat full format(info for each thread), you can use -H for tree(how a process is connected to his ancestor).
ps aux # [BSD Style] a : lift BSD "only yourself" to see all, u : user oriented format, x : Register formart, you can use f for tree(how a process is connected to his ancestor).
ps top # Display linux process.
