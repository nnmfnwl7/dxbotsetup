#!/bin/bash

source "dxbot_cfg.sh"

cfgfile=$1
if [ "$cfgfile" = "" ] ; then
    echo "ERROR: first parameter must point to wallet configuration file"
    echo "EXAMPLE: bash bash ./dxbot_node_user_cc.sh dxbot_node_user_block.sh"
    exit 1
fi

if [ ! -f "$cfgfile" ]; then
    echo "ERROR: config file ${cfgfile} does not exist"
    exit 1
fi

echo "using config file <${cfgfile}>"

source "${cfgfile}"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> prepare sandbox environments"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue, <s> to skip step or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "s" ]; then
        echo -e "\nsetup step skip"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    
    if [ "${firejail}" = "firejailyes" ]; then
    
        echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> prepare sandbox environments >> try"
        
        # firejail profile for qt wallet
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_qt=${firejail_dir}"/"${cc_firejail_profile_qt}
            
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && cp ${dxbot_dir_remote_root}"/firejail_qt_proto.profile" ${firejail_cfg_qt}
            (test $? = 0) || (echo "firejail <${firejail_cfg_qt}> copy failed" && exit 1)
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_bitcoin_bin_path+${dxbot_dir_remote_root}/${cc_name}_bin/${cc_name}-qt+g" \
                -e "s/bitcoin/${cc_name}/g" \
                -e "s/Bitcoin/${cc_name_upper}/g" \
                -e "s/^private-bin/#private-bin/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                -e "s/^include whitelist-common.inc/#include whitelist-common.inc/g" \
            ${firejail_cfg_qt}
            (test $? = 0) || (echo "firejail <${firejail_cfg_qt}> update failed" && exit 1)
            
            # check that bitcoin strings has been successfully replaced
            cat ${firejail_cfg_qt} | grep -e "bitcoin" -e "Bitcoin"
            (test $? = 1) || (echo "firejail <${firejail_cfg_qt}> check failed" && exit 1)
        
        # firejail profile for daemon wallet
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_d=${firejail_dir}"/"${cc_firejail_profile_d}
            
            # TODO update firejail daemon profile from another firejail profile than bitcoin qt profile
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && cp ${dxbot_dir_remote_root}"/firejail_d_proto.profile" ${firejail_cfg_d}
            (test $? = 0) || (echo "firejail <${firejail_cfg_d}> copy failed" && exit 1)
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_bitcoin_bin_path+${dxbot_dir_remote_root}/${cc_name}_bin/${cc_name}d+g" \
                -e "s/bitcoin/${cc_name}/g" \
                -e "s/Bitcoin/${cc_name_upper}/g" \
                -e "s/^private-bin/#private-bin/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#include whitelist-common.inc/g" \
            ${firejail_cfg_d}
            (test $? = 0) || (echo "firejail <${firejail_cfg_d}> update failed" && exit 1)
            
            # check that bitcoin strings has been successfully replaced
            cat ${firejail_cfg_d} | grep -e "bitcoin" -e "Bitcoin"
            (test $? = 1) || (echo "firejail <${firejail_cfg_d}> check failed" && exit 1)
            
        # firejail profile for command-line-interface
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_cli=${firejail_dir}"/"${cc_firejail_profile_cli}
            
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && cp ${dxbot_dir_remote_root}"/firejail_cli_proto.profile" ${firejail_cfg_cli}
            (test $? = 0) || (echo "firejail <${firejail_cfg_cli}> copy failed" && exit 1)
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_bitcoin_bin_path+${dxbot_dir_remote_root}/${cc_name}_bin/${cc_name}-cli+g" \
                -e "s/bitcoin/${cc_name}/g" \
                -e "s/Bitcoin/${cc_name_upper}/g" \
                -e "s/^private-bin/#private-bin/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#include whitelist-common.inc/g" \
            ${firejail_cfg_cli}
            (test $? = 0) || (echo "firejail <${firejail_cfg_cli}> update failed" && exit 1)
            
            # check that bitcoin strings has been successfully replaced
            cat ${firejail_cfg_cli} | grep -e "bitcoin" -e "Bitcoin"
            (test $? = 1) || (echo "firejail <${firejail_cfg_cli}> check failed" && exit 1)
            
        # firejail profile for make app from source
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_make=${firejail_dir}"/"${cc_firejail_profile_make}
            
            # firejail hints configs:
            # whitelist* - whitelist read-only
            # allow - noblacklist
            # disable* - blacklist read-only noexec
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && cp ${dxbot_dir_remote_root}"/firejail_make_proto.profile" ${firejail_cfg_make}
            (test $? = 0) || (echo "firejail <${firejail_cfg_make}> copy failed" && exit 1)
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
            -e "s+cc_bitcoin_bin_path+${dxbot_dir_remote_root}/${cc_name}_src/+g" \
            -e "s/bitcoin/${cc_name}/g" \
            -e "s/Bitcoin/${cc_name_upper}/g" \
            -e "s/^private-bin/#private-bin/g" \
            -e "/include globals.local/ a #updated by dxbotsetup start" \
                -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
            -e "s/^include disable-devel.inc/#include disable-devel.inc/g"
            ${firejail_cfg_make}
            (test $? = 0) || (echo "firejail <${firejail_cfg_make}> update failed" && exit 1)
            
            # check that bitcoin strings has been successfully replaced
            cat ${firejail_cfg_make} | grep -e "bitcoin" -e "Bitcoin"
            (test $? = 1) || (echo "firejail <${firejail_cfg_make}> check failed" && exit 1)
            
        echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> prepare sandbox environments >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> $firejail >> checkout and build cc from source code"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue, <s> to skip step or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "s" ]; then
        echo -e "\nsetup step skip"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> $firejail >> checkout and build cc from source code >> try"
    
    if [ "${firejail}" = "firejailyes" ]; then
        firejail --profile=${firejail_cfg_make} bash ./dxbot_node_user_cc_make.sh dxbot_node_user_block.sh
        (test $? = 0) || (echo "blocknet firejailed makeprocess failed" && exit 1)
    else
        bash ./dxbot_node_user_cc_make.sh dxbot_node_user_block.sh
        (test $? = 0) || (echo "blocknet makeprocess failed" && exit 1)
    fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> $firejail >> checkout and build cc from source code >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> generate wallet configuration file >> $cc_cfg"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue, <s> to skip step or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "s" ]; then
        echo -e "\nsetup step skip"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> generate wallet configuration file >> $cc_cfg >> try"
    
    mkdir -p ${cc_blockchain_dir} && chmod 700 ${cc_blockchain_dir} && cd ${cc_blockchain_dir}
    (test $? = 0) || (echo "mkdir -p ${cc_blockchain_dir} failed" && exit 1)
    
    echo "
# this configuration file has been generated by dxbot autosetup
listen=1
server=1
rpcallowip=127.0.0.1
port=${cc_port}
rpcport=${cc_rpcport}
rpcuser=${cc_rpcuser}
rpcpassword=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`

${cc_cfg_add}

#Automatically create Tor hidden service to be able to accept connections from tor network
listenonion=`(test '${torhswallet}' = 'torhswalletyes') && (echo '1') || (echo '0')`

#~ onlynet=<net>
# Make outgoing connections only through network <net> (ipv4, ipv6 or
# onion). Incoming connections are not affected by this option.
# This option can be specified multiple times to allow multiple networks.
`(test '${clearnetwallet}' = 'clearnetwalletyes') && (echo 'onlynet=ipv6') || (echo '#~ onlynet=ipv6')`
`(test '${clearnetwallet}' = 'clearnetwalletyes') && (echo 'onlynet=ipv4') || (echo '#~ onlynet=ipv4')`
`(test '${torwallet}' = 'torwalletyes') && (echo 'onlynet=onion') || (echo '#~ onlynet=onion')`

maxconnections=12

#~ proxy=127.0.0.1:9050
`(test '${torwallet}' = 'torwalletyes') && (echo 'onion=127.0.0.1:9050') || (echo '#~ onion=127.0.0.1:9050')`
bind=127.0.0.1
bantime=180

    " > ${cc_cfg}
    (test $? = 0) || (echo "generate ${cc_cfg} failed" && exit 1)
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> generate wallet configuration file >> $cc_cfg >> try >> success"
fi

# TODO startup script for firejail needs to know network interface as startup argument for network bandwidth upload/download limits to set
#~ ifconfig | grep UP | grep BROADCAST | grep RUNNING | grep MULTICAST | grep "mtu 1500" | cut -d ':' -f1
