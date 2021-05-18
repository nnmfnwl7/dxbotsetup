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
mkdir cc_blockchain_dir_path_noteval
noblacklist cc_blockchain_dir_path_noteval

mkfile cc_cfg_file_path_noteval
whitelist cc_cfg_file_path_noteval
read-only cc_cfg_file_path_noteval
noblacklist cc_cfg_file_path_noteval

whitelist cc_cli_file_path_eval
read-only cc_cli_file_path_eval
noblacklist cc_cli_file_path_eval

### basic blacklisting
include disable-common.inc
include disable-devel.inc
# include disable-exec.inc
include disable-interpreters.inc
include disable-passwdmgr.inc
include disable-programs.inc
include disable-shell.inc
include disable-xdg.inc

private-dev
#~ private-etc drirc,fonts,os-release,xdg,gtk-3.0,selinux,localtime,timezone,resolv.conf,hosts,group,passwd,
#~ private-etc dconf,drirc,fonts,xdg,gtk-3.0,selinux,
#~ private-etc alternatives,ca-certificates,crypto-policies,fonts,pki,ssl,selinux,
private-etc
private-tmp

### security filters
caps.drop all
machine-id
no3d
noautopulse
dbus-system=none
dbus-user=none
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
