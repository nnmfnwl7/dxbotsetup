# clear bandwidth limits for firejailed sandboxes

# predefined default values
sandbox_name_prefix="ccnode"

# processing arguments
if [ "${1}" = "" ]; then
    echo ""
    echo "custom usage >> ./cmd_firejail_bandwidth_clear.sh [<crypto currency nodes firejail sandbox name prefix>]"
else
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
echo "clearing bandwidth limit for firejail sandbox list <"${sandbox_list}">"

# get bandwidth download/upload limits
for sandbox_name in ${sandbox_list}; \
    do ( \
    firejail --bandwidth=${sandbox_name} clear ${net_interface} \
    ) ; done
(test $? != 0) && echo "" && echo "cleating bandwidth limits for running sandboxes failed" && exit 1

# success log
echo ""
echo "success"
