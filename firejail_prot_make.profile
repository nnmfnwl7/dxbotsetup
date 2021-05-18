# Firejail profile for bitcoin-qt
# This file is overwritten after every install/update
# Persistent local customizations

### need to add this line to add in screen sessions >> is in disable-shell.inc
ignore noexec ${PATH}/bash
noblacklist ${PATH}/bash

### home directory whitelisting to prevent whole home directory tree reveal
mkdir ${HOME}/.donotuse
whitelist ${HOME}/.donotuse

whitelist cc_src_dir_path_eval
noblacklist cc_src_dir_path_eval

### basic blacklisting
#~ include disable-common.inc
#~ include disable-devel.inc
#~ include disable-exec.inc
#~ include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
#~ include disable-shell.inc
#~ include disable-xdg.inc

### basic whitelising
#~ include whitelist-common.inc
include whitelist-usr-share-common.inc
#~ whitelist /var/lib/dbus/machine-id
#~ include whitelist-var-common.inc

private-dev
#~ private-etc drirc,fonts,os-release,xdg,gtk-3.0,selinux,localtime,timezone,resolv.conf,hosts,group,passwd,
#~ private-etc dconf,drirc,fonts,xdg,gtk-3.0,selinux,
#~ private-etc alternatives,ca-certificates,crypto-policies,fonts,pki,ssl,selinux,
private-tmp

### security filters
caps.drop all
machine-id
no3d
nodvd
nogroups
### MUST HAVE nonewprivs >> This ensures that child processes cannot acquire new privileges using execve(2)
nonewprivs
noroot
nosound
notv
nou2f
novideo
#x11
seccomp

### network
protocol unix,inet,inet6,
# net eth0
netfilter


### environment
#~ shell none

#memory-deny-write-execute
