# Firejail profile for bitcoin-qt
# Description: Bitcoin is a peer-to-peer network based digital currency
# This file is overwritten after every install/update
# Persistent local customizations
include bitcoin-qt.local
# Persistent global definitions
include globals.local

### need to add this line to add in screen sessions >> is in disable-shell.inc
ignore noexec ${PATH}/bash
noblacklist ${PATH}/bash

### home directory mkdir/ mkfile / whitelisting / noblacklisting / read-only
mkdir cc_firejail_blockchain_dir_path
whitelist cc_firejail_blockchain_dir_path
noblacklist cc_firejail_blockchain_dir_path

mkdir cc_firejail_qt_cfg_dir_path
whitelist cc_firejail_qt_cfg_dir_path
noblacklist cc_firejail_qt_cfg_dir_path

whitelist cc_firejail_qt_file_path
read-only cc_firejail_qt_file_path
noblacklist cc_firejail_qt_file_path

### basic blacklisting
include disable-common.inc
include disable-devel.inc
# include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
#~ include disable-shell.inc
include disable-xdg.inc

### whitelisting
include whitelist-common.inc

### filesystem
# /usr/share:
#~ whitelist /usr/share/dconf
#~ whitelist /usr/share/glib-2.0
#~ whitelist /usr/share//mime
#~ whitelist /usr/share/mime
#~ whitelist /usr/share/pixmaps
#~ whitelist /usr/share/icons
#~ whitelist /usr/share/drirc.d
#~ whitelist /usr/share/fonts
#~ whitelist /usr/share/fontconfig
#~ whitelist /usr/share/locale
#~ whitelist /usr/share/themes
#~ whitelist /usr/share/mate
#~ whitelist /usr/share/gtk-3.0
#~ whitelist /usr/share/X11
#~ whitelist /usr/share/hwdata
#~ whitelist /usr/share/qt5

include whitelist-usr-share-common.inc
#~ whitelist /var/lib/dbus/machine-id
#~ include whitelist-var-common.inc

private-dev
#~ private-etc drirc,fonts,os-release,xdg,gtk-3.0,selinux,localtime,timezone,resolv.conf,hosts,group,passwd,
#~ private-etc dconf,drirc,fonts,xdg,gtk-3.0,selinux,
private-etc alternatives,ca-certificates,crypto-policies,fonts,pki,ssl,selinux,
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
# seccomp.keep futex,poll,epoll_wait,write,fdatasync,openat,unlink,munmap,stat,mmap,recvmsg,read,recvfrom,close,getdents64,mprotect,writev,statx,access,sendto,readlink,connect,sendmsg,pwrite64,fstat,madvise,brk,getpid,lstat,prctl,getsockname,clone,pread64,socket,fcntl,lseek,eventfd2,rename,sendmmsg,ioctl,set_robust_list,getegid,linkat,getrandom,statfs,execve,setsockopt,geteuid,gettid,setpriority,bind,fstatfs,getsockopt,uname,mkdir,listen,epoll_ctl,fadvise64,fchmod,shmat,shmget,shmdt,prlimit64,sched_setattr,inotify_rm_watch,inotify_add_watch,rt_sigaction,sched_setscheduler,rt_sigprocmask,getuid,sched_setaffinity,shmctl,flock,getrusage,rmdir,getgid,getpeername,getpgid,getsid,getppid,shutdown,getcwd,set_tid_address,sched_getattr,arch_prctl,inotify_init1,getresuid,getresgid,mremap,umask,sysinfo,mlock,munlock,clock_nanosleep,fallocate,epoll_create1,pipe2
# 97 syscalls total
# Probably you will need to add more syscalls to seccomp.keep. Look for
# seccomp errors in /var/log/syslog or /var/log/audit/audit.log while
# running your sandbox.

### network
protocol unix,inet,inet6,
# net eth0
netfilter

### environment
shell none

#~ memory-deny-write-execute
