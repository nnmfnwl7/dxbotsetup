# get actual bandwidth limits status for firejailed sandboxes

# predefined default values
sandbox_name_prefix="ccnode"

# processing arguments
if [ "${1}" = "" ]; then
    echo ""
    echo "custom usage >> ./cmd_firejail_bandwidth_status.sh [<crypto currency nodes firejail sandbox name prefix>]"
else
    sandbox_name_prefix=${3}
fi

# find out running firejail sandboxed crypto currency nodes process names
sandbox_list=`firejail --list | grep ${sandbox_name_prefix} | cut -d ":" -f3`
echo ""
echo "getting bandwidth limit status for firejail sandbox list <"${sandbox_list}">"

# get bandwidth download/upload limits
for sandbox_name in ${sandbox_list}; \
    do ( \
    firejail --bandwidth=${sandbox_name} status \
    ) ; done
(test $? != 0) && echo "" && echo "get bandwidth limits for running sandboxes failed" && exit 1

# success log
echo ""
echo "success"
