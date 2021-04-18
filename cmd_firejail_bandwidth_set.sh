# set bandwidth limits for firejailed sandboxes

# predefined default values
download_speed=1000
upload_speed=500
sandbox_name_prefix="ccnode"

# processing arguments
if [ "${1}" = "" ] || [ "${2}" = "" ]; then
    echo ""
    echo "using default bandwidth limits >> download "${download_speed}" KBps upload "${upload_speed}" KBps"
    echo "custom usage >> ./cmd_firejail_bandwidth_set.sh [<download in KB per second> <upload in KB per second>] [<crypto currency nodes firejail sandbox name prefix>]"
    echo "example >> command to set 5 MB/s download and 1 MB/s upload >> ./cmd_firejail_bandwidth_set.sh 5000 1000"
else
    download_speed=${1}
    upload_speed=${2}
fi

if [ "${3}" != "" ]; then
    sandbox_name_prefix=${3}
fi

# find out active network interface name
net_interface=`ifconfig | grep UP | grep BROADCAST | grep RUNNING | grep MULTICAST | grep "mtu 1500" | cut -d ':' -f1`
(test $? != 0 || test "${net_interface}" = "") && echo "" && echo "get active network interface failed" && exit 1
echo ""
echo "using interface <"${net_interface}">"

# find out running firejail sandboxed crypto currency nodes process names
sandbox_list=`firejail --list | grep ${sandbox_name_prefix} | cut -d ":" -f3`
echo ""
echo "setting bandwidth limits for firejail sandbox list <"${sandbox_list}">"

# set bandwidth download/upload limits
for sandbox_name in ${sandbox_list}; \
    do ( \
    firejail --bandwidth=${sandbox_name} set ${net_interface} ${download_speed} ${upload_speed} \
    ) ; done
(test $? != 0) && echo "" && echo "set bandwidth limits for running sandboxes failed" && exit 1

# success log
echo ""
echo "success"
