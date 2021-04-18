#!/bin/bash

# main config file name read and include
dxbot_config_file_arg=$1
if [ "${dxbot_config_file_arg}" = "" ]; then
    echo "ERROR: first parameter, which is main config file parameter can not be empty"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg}>:"

source "${dxbot_config_file_arg}"

# crypto config file name read and include
dxbot_config_file_arg_cc=$2
if [ "${dxbot_config_file_arg_cc}" = "" ]; then
    echo "ERROR: second parameter, which is cryptocurrency config file parameter can not be empty"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg_cc}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg_cc} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg_cc}>:"

source "${dxbot_config_file_arg_cc}"

if [ "${cc_wallet_type" = "no" ]; then
    echo "<"${cc_name_full}"> on dir <"${cc_blockchain_dir}"> has been skipped by configuration"
    exit 0
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare sandbox environments"
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
    
        echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare sandbox environments >> try"
        
        # firejail profile for qt wallet ###############################
            cd ${dxbot_dir_remote_root}
            (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1
            
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_qt=${firejail_dir}"/"${cc_firejail_profile_qt}
            
            # TODO update firejail QT wallet profile from another firejail profile than bitcoin qt profile
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && \
            cp ${dxbot_dir_remote_root}"/firejail_prot_qt.profile" ${firejail_cfg_qt}
            (test $? != 0) && echo "firejail <${firejail_cfg_qt}> copy failed" && exit 1
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_firejail_blockchain_dir_path+${cc_firejail_blockchain_dir_path}+g" \
                -e "s+cc_firejail_qt_cfg_dir_path+${cc_firejail_qt_cfg_dir_path}+g" \
                -e "s+cc_firejail_qt_file_path+${cc_firejail_qt_file_path}+g" \
                -e "s/bitcoin/${cc_name_full}/g" \
                -e "s/Bitcoin/${cc_name_full}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#private-bin/g" \
            ${firejail_cfg_qt}
            (test $? != 0) && echo "firejail <${firejail_cfg_qt}> update failed" && exit 1
            
        # firejail profile for daemon wallet ###########################
            cd ${dxbot_dir_remote_root}
            (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1
            
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_d=${firejail_dir}"/"${cc_firejail_profile_d}
            
            # TODO update firejail daemon profile from another firejail profile than bitcoin qt profile
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . && \
            cp ${dxbot_dir_remote_root}"/firejail_prot_d.profile" ${firejail_cfg_d}
            (test $? != 0) && echo "firejail <${firejail_cfg_d}> copy failed" && exit 1
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_firejail_blockchain_dir_path+${cc_firejail_blockchain_dir_path}+g" \
                -e "s+cc_firejail_daemon_file_path+${cc_firejail_daemon_file_path}+g" \
                -e "s/bitcoin/${cc_name_full}/g" \
                -e "s/Bitcoin/${cc_name_full}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#~ private-bin/g" \
            ${firejail_cfg_d}
            (test $? != 0) && echo "firejail <${firejail_cfg_d}> update failed" && exit 1
            
        # firejail profile for command-line-interface ##################
            cd ${dxbot_dir_remote_root}
            (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1
            
            firejail_dir=${dxbot_dir_remote_root}"/firejail"
            firejail_cfg_cli=${firejail_dir}"/"${cc_firejail_profile_cli}
            
            # TODO update firejail cli profile from another firejail profile than bitcoin qt profile
            mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . \
            && cp ${dxbot_dir_remote_root}"/firejail_prot_cli.profile" ${firejail_cfg_cli}
            (test $? != 0) && echo "firejail <${firejail_cfg_cli}> copy failed" && exit 1
            
            # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
            sed -i \
                -e "s+cc_firejail_cfg_file_path+${cc_firejail_cfg_file_path}+g" \
                -e "s+cc_firejail_cli_file_path+${cc_firejail_cli_file_path}+g" \
                -e "s/bitcoin/${cc_name_full}/g" \
                -e "s/Bitcoin/${cc_name_full}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#~ private-bin/g" \
            ${firejail_cfg_cli}
            (test $? != 0) && echo "firejail <${firejail_cfg_cli}> update failed" && exit 1
            
        # firejail profile for make apps from source ###################
        
            if [ "${cc_git_src}" != "" ]; then
                cd ${dxbot_dir_remote_root}
                (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1
                
                firejail_dir=${dxbot_dir_remote_root}"/firejail"
                firejail_cfg_make=${firejail_dir}"/"${cc_firejail_profile_make}
                
                # firejail hints configs:
                # whitelist* - whitelist read-only
                # allow - noblacklist
                # disable* - blacklist read-only noexec
                
                # TODO update firejail make profile from another firejail profile than bitcoin qt profile
                mkdir -p ${firejail_dir} && cd ${firejail_dir} && chmod 700 . \
                && cp ${dxbot_dir_remote_root}"/firejail_prot_make.profile" ${firejail_cfg_make}
                (test $? != 0) && echo "firejail <${firejail_cfg_make}> copy failed" && exit 1
                
                # search for bitcoin and Bitcoin and try to replace it with another cryptocurrency
                sed -i \
                -e "s+cc_firejail_src_path+${cc_firejail_src_path}+g" \
                -e "s/bitcoin/${cc_name_full}/g" \
                -e "s/Bitcoin/${cc_name_full_upper}/g" \
                -e "s/^private-bin/#private-bin/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                -e "s/^include disable-devel.inc/#include disable-devel.inc/g"
                ${firejail_cfg_make}
                (test $? != 0) && echo "firejail <${firejail_cfg_make}> update failed" && exit 1
            fi
            
        echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare sandbox environments >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> $firejail >> checkout and build cc from source code"
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
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> $firejail >> checkout and build cc from source code >> try"
    
    # check if git source is specified or do not build
    if [ "${cc_git_src}" != "" ]; then
        cd ${dxbot_dir_remote_root}
        (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1
        
        # check if to build in firejail sandbox or not
        if [ "${firejail}" = "firejailyes" ]; then
            firejail --profile=${firejail_cfg_make} bash ./dxbot_node_user_cc_make.sh ${dxbot_config_file_arg} ${dxbot_config_file_arg_cc}
            (test $? != 0) && echo "cc <${dxbot_config_file_arg_cc}> firejailed makeprocess failed" && exit 1
        else
            bash ./dxbot_node_user_cc_make.sh ${dxbot_config_file_arg} ${dxbot_config_file_arg_cc}
            (test $? != 0) && echo "cc <${dxbot_config_file_arg_cc}> makeprocess failed" && exit 1
        fi
    fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> $firejail >> checkout and build cc from source code >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> generate wallet configuration file >> $cc_cfg"
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
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> generate wallet configuration file >> $cc_cfg >> try"
    
    mkdir -p ${cc_blockchain_dir} && chmod 700 ${cc_blockchain_dir} && cd ${cc_blockchain_dir}
    (test $? != 0) && echo "mkdir -p ${tmp} failed" && exit 1
    
    echo "
# this configuration file has been generated by dxbot autosetup
listen=1
server=1
rpcallowip=127.0.0.1
port="${cc_port}"
rpcport="${cc_rpcport}"
rpcuser="${cc_rpcuser}"
rpcpassword="`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`"

"${cc_cfg_add}"

#Automatically create Tor hidden service to be able to accept connections from tor network
listenonion="`(test '${torhswallet}' = 'torhswalletyes') && (echo '1') || (echo '0')`"

#~ onlynet=<net>
# Make outgoing connections only through network <net> (ipv4, ipv6 or
# onion). Incoming connections are not affected by this option.
# This option can be specified multiple times to allow multiple networks.
"`(test '${clearnetwallet}' = 'clearnetwalletyes') && (echo 'onlynet=ipv6') || (echo '#~ onlynet=ipv6')`"
"`(test '${clearnetwallet}' = 'clearnetwalletyes') && (echo 'onlynet=ipv4') || (echo '#~ onlynet=ipv4')`"
"`(test '${torwallet}' = 'torwalletyes') && (echo 'onlynet=onion') || (echo '#~ onlynet=onion')`"

maxconnections=12

#~ proxy=127.0.0.1:9050
"`(test '${torwallet}' = 'torwalletyes') && (echo 'onion=127.0.0.1:9050') || (echo '#~ onion=127.0.0.1:9050')`"
bind=127.0.0.1
bantime=180

    " > ${cc_cfg}
    (test $? != 0) && echo "generate ${cc_cfg} failed" && exit 1
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> generate wallet configuration file >> $cc_cfg >> try >> success"
fi

# TODO bash history needs to be overwritten in firejail custom for each screen/mate-terminal window

