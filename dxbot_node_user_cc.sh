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

echo "using config file <"${dxbot_config_file_arg}">:"

source ${dxbot_config_file_arg}
(test $? != 0) && echo "source file <"${dxbot_config_file_arg}"> not found" && exit 1

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

echo "using config file <"${dxbot_config_file_arg_cc}">:"

source ${dxbot_config_file_arg_cc}
(test $? != 0) && echo "source file <"${dxbot_config_file_arg_cc}"> not found" && exit 1

# crypto currency config auto generator include
source dxbot_node_user_cc_gen_cfg.sh
(test $? != 0) && echo "source file <dxbot_node_user_cc_gen_cfg.sh> not found" && exit 1
        
# skip cc instance if disabled
if [ "${cc_wallet_type" = "gui" ] || [ "${cc_wallet_type" = "daemon" ]; then
    echo "<"${cc_name_full}"> on dir <"${cc_blockchain_dir_path_eval}"> is enabled by configuration"
else
    echo "<"${cc_name_full}"> on dir <"${cc_blockchain_dir_path_eval}"> has been skipped by configuration"
    exit 0
fi

mkdir -p ${cc_root_path_main} && cd ${cc_root_path_main} && chmod 700 .
(test $? != 0) && echo "<${cc_name_full}> root directory prepare failed" && exit 1

mkdir -p ${cc_root_path_instance} && cd ${cc_root_path_instance} && chmod 700 .
(test $? != 0) && echo "<${cc_name_full}> instance ${cc_root_path_instance} root directory prepare failed" && exit 1

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
        
        # prepare directory for storing firejail profile files
        mkdir -p ${cc_firejail_profile_dir_path_eval} && cd ${cc_firejail_profile_dir_path_eval} && chmod 700 .
        (test $? != 0) && echo "firejail data path <${cc_firejail_profile_dir_path_eval}> prepare failed" && exit 1
        
        # go to main dxbot directory
        cd ${dxbot_dir_remote_setup}
        (test $? != 0) && echo "cd ${dxbot_dir_remote_setup} failed" && exit 1
        
        # firejail profile for qt wallet ###############################
        
            # make copy of prototype firejail profile
            cp ${dxbot_dir_remote_setup}"/firejail_prot_qt.profile" ${cc_qt_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_qt_firejail_profile_path_eval}> copy failed" && exit 1
            
            # search predefined strings to update firejail prototype file for specific cryptocurrency
            sed -i \
                -e "s+cc_blockchain_dir_path_noteval+${cc_blockchain_dir_path_noteval}+g" \
                -e "s+cc_qt_cfg_dir_path_noteval+${cc_qt_cfg_dir_path_noteval}+g" \
                -e "s+cc_qt_file_path_eval+${cc_qt_file_path_eval}+g" \
                -e "s/bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "s/Bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#private-bin/g" \
            ${cc_qt_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_qt_firejail_profile_path_eval}> update failed" && exit 1
            
        # firejail profile for daemon wallet ###########################
        
            # make copy of prototype firejail profile
            cp ${dxbot_dir_remote_setup}"/firejail_prot_d.profile" ${cc_daemon_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_daemon_firejail_profile_path_eval}> copy failed" && exit 1
            
            # search predefined strings to update firejail prototype file for specific cryptocurrency
            sed -i \
                -e "s+cc_blockchain_dir_path_noteval+${cc_blockchain_dir_path_noteval}+g" \
                -e "s+cc_daemon_file_path_eval+${cc_daemon_file_path_eval}+g" \
                -e "s/bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "s/Bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#~ private-bin/g" \
            ${cc_daemon_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_daemon_firejail_profile_path_eval}> update failed" && exit 1
            
        # firejail profile for command-line-interface ##################
            
            # make copy of prototype firejail profile
            cp ${dxbot_dir_remote_setup}"/firejail_prot_cli.profile" ${cc_cli_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_cli_firejail_profile_path_eval}> copy failed" && exit 1
            
            # search predefined strings to update firejail prototype file for specific cryptocurrency
            sed -i \
                -e "s+cc_blockchain_dir_path_noteval+${cc_blockchain_dir_path_noteval}+g" \
                -e "s+cc_cfg_file_path_noteval+${cc_cfg_file_path_noteval}+g" \
                -e "s+cc_cli_file_path_eval+${cc_cli_file_path_eval}+g" \
                -e "s/bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "s/Bitcoin/${cc_name_prefix}${cc_instance_suffix}/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                    -e "/#updated by dxbotsetup end/ i ignore noexec ${PATH}/bash" \
                    -e "/#updated by dxbotsetup end/ i noblacklist ${PATH}/bash" \
                -e "s/^include whitelist-common.inc/#~ include whitelist-common.inc/g" \
                -e "s/^private-bin/#~ private-bin/g" \
            ${cc_cli_firejail_profile_path_eval}
            (test $? != 0) && echo "firejail <${cc_cli_firejail_profile_path_eval}> update failed" && exit 1
            
        # firejail profile for make apps from source ###################
        
            if [ "${cc_git_src_url}" != "" ]; then
                
                # make copy of prototype firejail profile
                cp ${dxbot_dir_remote_setup}"/firejail_prot_make.profile" ${cc_make_firejail_profile_path_eval}
                (test $? != 0) && echo "firejail <${cc_make_firejail_profile_path_eval}> copy failed" && exit 1
                
                # search predefined strings to update firejail prototype file for specific cryptocurrency
                sed -i \
                -e "s+cc_src_dir_path_eval+${cc_src_dir_path_eval}+g" \
                -e "s/bitcoin/${cc_name_prefix}/g" \
                -e "s/Bitcoin/${cc_name_prefix}/g" \
                -e "s/^private-bin/#private-bin/g" \
                -e "/include globals.local/ a #updated by dxbotsetup start" \
                    -e "/#updated by dxbotsetup start/ a #updated by dxbotsetup end" \
                -e "s/^include disable-devel.inc/#include disable-devel.inc/g"
                ${cc_make_firejail_profile_path_eval}
                (test $? != 0) && echo "firejail <${cc_make_firejail_profile_path_eval}> update failed" && exit 1
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
    if [ "${cc_git_src_url}" != "" ]; then
        cd ${dxbot_dir_remote_setup}
        (test $? != 0) && echo "cd ${dxbot_dir_remote_setup} failed" && exit 1
        
        # check if to build in firejail sandbox or not
        if [ "${firejail}" = "firejailyes" ]; then
            firejail --profile=${cc_make_firejail_profile_path_eval} bash ./dxbot_node_user_cc_make.sh ${dxbot_config_file_arg} ${dxbot_config_file_arg_cc}
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
    
    mkdir -p ${cc_blockchain_dir_path_eval} && chmod 700 ${cc_blockchain_dir_path_eval} && cd ${cc_blockchain_dir_path_eval}
    (test $? != 0) && echo "mkdir -p ${tmp} failed" && exit 1
    
    echo "
# this configuration file has been generated by dxbot autosetup
"`(test "${cc_rpcuser}" = "") && (echo "#~ ")`"listen=1
"`(test "${cc_rpcuser}" = "") && (echo "#~ ")`"server=1
"`(test "${cc_rpcuser}" = "") && (echo "#~ ")`"rpcallowip=127.0.0.1
"`(test "${cc_port}" = "") && (echo "#~ ")`"port="${cc_port}"
"`(test "${cc_rpcport}" = "") && (echo "#~ ")`"rpcport="${cc_rpcport}"
"`(test "${cc_rpcuser}" = "") && (echo "#~ ")`"rpcuser="${cc_rpcuser}"
"`(test "${cc_rpcuser}" = "") && (echo "#~ ")`"rpcpassword="`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`"

"${cc_cfg_add}"

#Automatically create Tor hidden service to be able to accept connections from tor network
listenonion="`(test '${torhswallet}' = 'torhswalletyes') && (echo '1') || (echo '0')`"

#~ onlynet=<net>
# Make outgoing connections only through network <net> (ipv4, ipv6 or
# onion). Incoming connections are not affected by this option.
# This option can be specified multiple times to allow multiple networks.
"`(test "${clearnetwallet}" != "clearnetwalletyes") && (echo "#~ ")`"onlynet=ipv6
"`(test "${clearnetwallet}" != 'clearnetwalletyes') && (echo '#~ ')`"onlynet=ipv4
"`(test "${torwallet}" != 'torwalletyes') && (echo '#~ ')`"onlynet=onion

maxconnections=12

#~ proxy=127.0.0.1:9050
"`(test "${torwallet}" != "torwalletyes") && (echo "#~ ")`"onion=127.0.0.1:9050
"`(test "${torwallet}" != "torwalletyes") && (echo "#~ ")`"bind=127.0.0.1
bantime=180

    " > ${cc_cfg}
    (test $? != 0) && echo "generate ${cc_cfg} failed" && exit 1
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> generate wallet configuration file >> $cc_cfg >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare predefined commands"
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
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare predefined commands >> try"
    
    # prepare directory to store predefined command for crypto currency prefix.instance
    mkdir -p ${cc_cli_cmd_list_dir_path_eval} \
    && cd ${cc_cli_cmd_list_dir_path_eval} \
    && chmod 700 .
    (test $? != 0) && echo "ERROR: make ${cc_cli_cmd_list_dir_path_eval} failed" && exit 1
    
    # go back to main dxbot directory
    cd ${dxbot_dir_remote_setup}
    (test $? != 0) && echo "cd ${dxbot_dir_remote_setup} failed" && exit 1
    
    cmd_list=`ls | grep cmd_prot_ | grep -e "_cli_" -e "_d_" -e "_qt_" | grep sh$`
    for f in $cmd_list; do
        
        # prepare specific command name for specific instance
        new_file_path=${cc_cli_cmd_list_dir_path_eval}"/"`echo ${f} | sed -e "s+_prot_+_${cc_name_prefix}${cc_instance_suffix}_+g"`
        
        # copy prototype as new name
        cp $f ${new_file_path}
        (test $? != 0) && echo "ERROR: copy <${f}> to <${new_file_path}> failed" && exit 1
        
        # search and replace values of command prototypes
        sed -i \
            -e "s+cc_name_prefix+${cc_name_prefix}+g" \
            -e "s+cc_blockchain_dir_path_eval+${cc_blockchain_dir_path_eval}+g" \
            -e "s+cc_daemon_file_path_eval+${cc_daemon_file_path_eval}+g" \
            -e "s+cc_qt_file_path_eval+${cc_qt_file_path_eval}+g" \
            -e "s+cc_cli_file_path_eval+${cc_cli_file_path_eval}+g" \
        ${new_file_path}
        (test $? != 0) && echo "update cmd prototype <${new_file_path}> failed" && exit 1
        
    done
    
    # if firejail feature is activated also generate firejail script commands
    if [ "${firejail}" = "firejailyes" ]; then
    
        # go back to main dxbot directory
        cd ${dxbot_dir_remote_setup}
        (test $? != 0) && echo "cd ${dxbot_dir_remote_setup} failed" && exit 1
        
        # read file list
        cmd_list=`ls | grep cmd_firejail_prot_ | grep -e "_cli_" -e "_d_" -e "_qt_"`
        
        for f in $cmd_list; do
            
            # prepare specific command name for specific instance
            new_file_path=${cc_root_path_instance}"/"`echo ${f} | sed -e "s+_prot_+_${cc_name_prefix}${cc_instance_suffix}_+g"`
            
            # copy prototype as new name
            cp $f ${new_file_path}
            (test $? != 0) && echo "ERROR: copy <${f}> to <${new_file_path}> failed" && exit 1
            
            # search and replace values of command prototypes
            sed -i \
                -e "s+{cc_name_prefix}+${cc_name_prefix}+g" \
                -e "s+{cc_instance_suffix}+${cc_instance_suffix}+g" \
                -e "s+cc_name_prefix+${cc_name_prefix}+g" \
                -e "s+cc_instance_suffix+${cc_instance_suffix}+g" \
                \
                -e "s+cc_cli_cmd_list_dir_path_eval+${cc_cli_cmd_list_dir_path_eval}+g" \
                \
                -e "s+cc_daemon_firejail_profile_path_eval+${cc_daemon_firejail_profile_path_eval}+g" \
                -e "s+cc_cli_firejail_profile_path_eval+${cc_cli_firejail_profile_path_eval}+g" \
                -e "s+cc_qt_firejail_profile_path_eval+${cc_qt_firejail_profile_path_eval}+g" \
                \
                -e "s+cc_blockchain_dir_path_eval+${cc_blockchain_dir_path_eval}+g" \
                -e "s+cc_daemon_file_path_eval+${cc_daemon_file_path_eval}+g" \
                -e "s+cc_qt_file_path_eval+${cc_qt_file_path_eval}+g" \
                -e "s+cc_cli_file_path_eval+${cc_cli_file_path_eval}+g" \
            ${new_file_path}
            (test $? != 0) && echo "update cmd prototype <${new_file_path}> failed" && exit 1
        done
    fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> prepare predefined commands >> try >> success"
fi

# TODO bash history needs to be overwritten in firejail custom for each screen/mate-terminal window

