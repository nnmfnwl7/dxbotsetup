#!/bin/bash

# config file name read and include
dxbot_config_file_arg=$1
if [ "${dxbot_config_file_arg}" = "" ]; then
    echo "ERROR: first parameter, which is config file parameter can not be empty"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg}>:"

source "${dxbot_config_file_arg}"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${clientalias} >> tor install >> tor config >> add hidden service v3 auth_private file for ssh client authentication over tor"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue or <s> to skip step or <q> to exit setup process: " key
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
    if [ "$sshtoraccess" = "sshtoraccessyes" ]; then
        
        # install tor package
        echo "# ${0} >> root@${clientalias} >> tor install >> try"
        
        apt install tor
        (test $? != 0) && echo "ERROR: install tor package on root@${clientalias} failed" && exit 1
        
        # update tor config about directory used to store client auth private keys for hs
        echo "# ${0} >> root@${clientalias} >> tor configuration update >> try"
        
        cfgvar='ClientOnionAuthDir'
        cfgval='/var/lib/tor/onion_auth'
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/usr/share/tor/tor-service-defaults-torrc'
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> ${cfgfile}
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        # check tor directory used for storing client auth private keys for hs
        torauthclientsdir="/var/lib/tor/onion_auth/"

        mkdir -p ${torauthclientsdir} && cd ${torauthclientsdir} && chown debian-tor:debian-tor . && chmod 700 .
        (test $? != 0) && echo "ERROR: directory <${torauthclientsdir}> processing failed" && exit 1
        
        echo "# ${0} >> root@${clientalias} >> tor copy auth file >> try"
        
        #generate key name
        keyname="${clientalias}2${nodealias}"

        # preparere directory for storing keys
        torgenkeysdir="/root/private_ssl_keys"
        
        mkdir -p ${torgenkeysdir} && cd ${torgenkeysdir} && chmod 700 .
        (test $? != 0) && echo "ERROR: directory <${torgenkeysdir}> processing failed" && exit 1
        
        # copy formated private key to nodeuser2 installation directory
        cp ${dxbot_dir_local_setup}${keyname}.auth_private ${torauthclientsdir} && \
        chmod 700 ${torauthclientsdir}${keyname}.auth_private && \
        chown $nodeuser2 ${torauthclientsdir}${keyname}.auth_private && \
        mv ${dxbot_dir_local_setup}${keyname}.auth_private ${torgenkeysdir}${keyname}.auth_private && \
        chmod 700 ${torgenkeysdir}${keyname}.auth_private && \
        chown root ${torgenkeysdir}${keyname}.auth_private
        (test $? != 0) && echo "ERROR: <${torauthclientsdir}${keyname}.auth_private> copy failed" && exit 1
        
        # generate shell script to connect by ssh by tor to node
        echo "ssh ${nodeuser2}@`cat ${torgenkeysdir}${keyname}.auth_private | cut -d ':' -f1`.onion" > ${dxbot_dir_local_setup}${keyname}.sh && chown ${nodeuser2} ${dxbot_dir_local_setup}${keyname}.sh
        (test $? != 0) && echo "ERROR: <${dxbot_dir_local_setup}${keyname}.sh> file generate failed" && exit 1
        
        # restart tor service
        /usr/sbin/service tor restart
        
        echo "# ${0} >> root@${clientalias} >> tor update about new user ${localuser}"
        
        # if localuser is not in tor group, is not allowed to use tor, so try to add user to tor group
        groups ${localuser} | grep "debian-tor"
        if [ $? -ne 0 ]; then
            /usr/sbin/usermod -a -G debian-tor ${localuser}
            (test $? != 0) && echo "ERROR: failed to add user <${localuser}> to group <debian-tor>" && exit 1
        fi
        
        echo "# ${0} >> root@${clientalias} >> tor install >> tor config >> add hidden service v3 auth_private file for ssh client authentication over tor >> try >> success"
    fi
fi
