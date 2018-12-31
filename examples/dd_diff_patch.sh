####_dd_diff_patch_####
# this is an example of using dd diff and patch alltogheter. #
cp /etc/group /tmp # copy group file in etc to /tmp
cd /tmp # change directory to /tmp
dd if=/tmp/group of=/tmp/GROUP conv=ucase # make a copy of the file while uppercasing all the characteres
diff -Nur group GROUP > patchfile # -N : treat absent file as empty, -u : output 3 (default) line of unified contexte, r : recursive, generate a diff patch file.
patch --dry-run group patchfile # simulating the application of patchfile on group file.
patch group patchfile # apply patch to group file. 
