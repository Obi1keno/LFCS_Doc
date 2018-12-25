### YUM ###
## This is a special chapter for yum with more informations that original doc ##
## Plugins ##
vi /etc/yum.conf # here you need to change "plugins=0" to "plugins=1" (Or add it if not found).
cd /etc/yum/pluginconf.d/ # here each packages has its own conf file.
vi /etc/yum/pluginconf.d/<plugin-name>.conf # here to disable package set "enabled=0".
