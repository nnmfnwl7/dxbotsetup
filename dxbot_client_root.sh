#!/bin/bash

source "dxbot_cfg.sh"

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 008.001 >> client >> root >> tor install >> tor config >> add hidden service v3 auth_private file for ssh client authentication over tor"
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
        
        apt install tor
        if [ $? -ne 0 ]; then
            echo "ERROR: install software dependencies by @client error"
            exit 1
        fi
        
        echo "trying to update client tor configuration about directory for as client to node authorisation"
        
        cfgvar='ClientOnionAuthDir'
        cfgval='/var/lib/tor/onion_auth'
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/usr/share/tor/tor-service-defaults-torrc'
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> ${cfgfile}
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>"
            exit 1
        fi
        
        # check tor directory used for storing client auth private keys for hs
        torauthclientsdir="/var/lib/tor/onion_auth/"

        mkdir -p ${torauthclientsdir} && cd ${torauthclientsdir} && chown debian-tor:debian-tor . && chmod 700 .
        if [ $? -ne 0 ]; then
            echo "ERROR: directory <${torauthclientsdir}> processing failed"
            exit 1
        fi
        
        #generate key name
        keyname="${clientalias}2${nodealias}"

        # preparere directory for storing keys
        torgenkeysdir="/root/private_ssl_keys"
        
        mkdir -p ${torgenkeysdir} && cd ${torgenkeysdir} && chmod 700 .
        if [ $? -ne 0 ]; then
            echo "ERROR: directory <${torgenkeysdir}> processing failed"
            exit 1
        fi
        
        # copy formated private key to nodeuser2 installtion directory
        cp ${dxbot_dir_local_setup}${keyname}.auth_private ${torauthclientsdir} && chmod 700 ${torauthclientsdir}${keyname}.auth_private && chown $nodeuser2 ${torauthclientsdir}${keyname}.auth_private && mv ${dxbot_dir_local_setup}${keyname}.auth_private ${torgenkeysdir}${keyname}.auth_private && chmod 700 ${torgenkeysdir}${keyname}.auth_private && chown root ${torgenkeysdir}${keyname}.auth_private
        if [ $? -ne 0 ]; then
            echo "ERROR: <${torauthclientsdir}${keyname}.auth_private> copy failed"
            exit 1
        fi
        
        echo "ssh ${nodeuser2}@`cat ${torgenkeysdir}${keyname}.auth_private | cut -d ':' -f1`.onion" > ${dxbot_dir_local_setup}${keyname}.sh && chown ${nodeuser2} ${dxbot_dir_local_setup}${keyname}.sh
        if [ $? -ne 0 ]; then
            echo "ERROR: <${dxbot_dir_local_setup}${keyname}.sh> file generate failed"
            exit 1
        fi
        
        # restart tor service
        /usr/sbin/service tor restart
        
        echo "trying to update client ${localuser} for tor usage ability"
        
        groups ${localuser} | grep "debian-tor"
        if [ $? -ne 0 ]; then
            /usr/sbin/usermod -a -G debian-tor ${localuser}
            if [ $? -ne 0 ]; then
                echo "ERROR: failed to add user <${localuser}> to group <debian-tor>"
                exit 1
            fi
        fi
        
        echo "update ${localuser} for tor usage ability success"
        
        echo "client >> root >> tor config >> create hidden service v3 auth directory for client and copy auth file success"
    fi
fi
