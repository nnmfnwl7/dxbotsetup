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
echo "# ${0} >> root@${nodealias} >> ssh config >> allow access by private-key >> disable access by password >> optional"
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
    if [ "$sshpkonly" = "sshpkonlyyes" ]; then
        
        echo "# ${0} >> root@${nodealias} >> ssh config >> allow access by private-key >> try"
        
        cfgvar='PubkeyAuthentication'
        cfgline='PubkeyAuthentication yes'
        cfgfile='/etc/ssh/sshd_config'
        
        # search and try to update commented by # or PubkeyAuthentication no
        sed -i "s/.*${cfgvar}.*/${cfgline}/" "${cfgfile}"
        (test $? != 0) && echo "ERROR: failed to update node sshd configuration to allow access by private-key" && exit 1
        
        # search if "PubkeyAuthentication yes" is not missing and if try to add it at the end of file
        grep -qxF "$cfgline" "$cfgfile"
        if [ $? -ne 0 ]; then
            echo "$cfgline" >> "$cfgfile"
        fi
        
        # configuration update verification
        grep -qxF "$cfgline" "$cfgfile"
        (test $? != 0) && echo "ERROR: failed to update node sshd configuration to allow access by private-key" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> ssh config >> allow access by private-key >> disable access by password >> try"
        
        cfgvar='PasswordAuthentication'
        cfgline='PasswordAuthentication no'
        cfgfile='/etc/ssh/sshd_config'
        
        # search and try to update commented by # or PasswordAuthentication yes
        sed -i "s/.*${cfgvar}.*/${cfgline}/" "${cfgfile}"
        (test $? != 0) && echo "ERROR: failed to update node sshd configuration to disable access by password" && exit 1
        
        # search if "PasswordAuthentication no" is not missing and if try to add it at the end of file
        grep -qxF "$cfgline" "$cfgfile"
        if [ $? -ne 0 ]; then
            echo "$cfgline" >> "$cfgfile"
        fi
        
        grep -qxF "$cfgline" "$cfgfile"
        (test $? != 0) && echo "ERROR: failed to update node sshd configuration to disable access by password" && exit 1
        
        /usr/sbin/service sshd restart
        (test $? != 0) && echo "ERROR: failed to restart sshd with new configuration" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> ssh config >> allow access by private-key >> disable access by password >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> etc/hosts.allow/deny >> access only from client and tor >> optional"
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
    if [ "$sshiponly" = "sshiponlyyes" ]; then
        
        echo "# ${0} >> root@${nodealias} >> trying to update node hosts.allow to allow ssh access from client and tor only >> try"
        
        cfgvar='sshd:'
        cfgval='127.0.0.1'
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/etc/hosts.allow'
        
        # search if "sshd: 127.0.0.1" is not missing and if try to add it at the end of file
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        cfgvar='sshd:'
        cfgval=`echo $SSH_CONNECTION | cut -d ' ' -f1`
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/etc/hosts.allow'
        
        # search if "sshd: client ip" is not missing and if try to add it at the end of file
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> trying to update node hosts.deny to deny ssh access from any other source >> try"
        
        cfgvar='sshd:'
        cfgval='ALL'
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/etc/hosts.deny'
        
        # search if "sshd: ALL" is not missing and if try to add it at the end of file
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> etc/hosts.allow/deny >> access only from client and tor >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> apt install software dependencies"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    echo "# ${0} >> root@${nodealias} >> apt install software dependencies >> try"
    
    
    if [ "${firejail}" = "firejailyes" ];then
        deb_pkg_firejail="firejail"
    fi
    
    if [ ${sshtoraccess} = "sshtoraccessyes" ] || [ ${torwallet} = "torwalletyes" ] || [ ${torhswallet} = "torhswalletyes" ]; then
        deb_pkg_tor="tor"
    fi
    
    # install system packages/software/utils needed, this can take same time...
    apt update && apt full-upgrade && apt install screen htop joe mc curl git gitg keepassxc make cmake clang clang-tools clang-format libclang1 libboost-all-dev wget qt5-qmake-bin qt5-qmake qttools5-dev-tools qttools5-dev qtbase5-dev-tools qtbase5-dev libqt5charts5-dev basez libprotobuf-dev protobuf-compiler libssl-dev openssl keepassx geany gcc g++ cargo apt-file net-tools xsensors hddtemp ${deb_pkg_firejail} ${deb_pkg_tor}
    (test $? != 0) && echo "ERROR: install software dependencies by root@node error" && exit 1
    
    echo "# ${0} >> root@${nodealias} >> apt install software dependencies >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> tor >> update user ${nodeuser2} groups to allow tor access"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    
    if [ ${sshtoraccess} = "sshtoraccessyes" ] || [ ${torwallet} = "torwalletyes" ] || [ ${torhswallet} = "torhswalletyes" ]; then
        
        echo "# ${0} >> root@${nodealias} >> tor >> update user ${nodeuser2} groups to allow tor access >> try"
        
        groups ${nodeuser2} | grep "debian-tor"
        if [ $? -ne 0 ]; then
            /usr/sbin/usermod -a -G debian-tor ${nodeuser2}
            (test $? != 0) && echo "ERROR: failed to add user <${nodeuser2}> to group <debian-tor>" && exit 1
        fi
        
        echo "# ${0} >> root@${nodealias} >> tor >> update user ${nodeuser2} groups to allow tor access >> try >> success"
        
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> tor config >> create hidden service v3 for ssh clients authorized by key"
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
        
        echo "# ${0} >> root@${nodealias} >> tor config >> create hidden service v3 for ssh clients authorized by key >> try"
        
        cfgvar='ControlPort'
        cfgval='9051'
        cfgline="${cfgvar} ${cfgval}"
        cfgfile='/usr/share/tor/tor-service-defaults-torrc'
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        cfgvar='CookieAuthentication'
        cfgval='1'
        cfgline="${cfgvar} ${cfgval}"
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1

        cfgvar='CookieAuthFileGroupReadable'
        cfgval='1'
        cfgline="${cfgvar} ${cfgval}"
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        cfgvar='CookieAuthFile'
        cfgval='/run/tor/control.authcookie'
        cfgline="${cfgvar} ${cfgval}"
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "${cfgline}" >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        cfgvar='HiddenServiceDir'
        cfgval='/var/lib/tor/hidden-service-ssh/'
        cfgline="${cfgvar} ${cfgval}"
        cfgline2="HiddenServicePort 22 127.0.0.1:22"
        cfgline3="HiddenServiceVersion 3"
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        if [ $? -ne 0 ]; then
            echo "
${cfgline}
${cfgline2}
${cfgline3}
            " >> "${cfgfile}"
        fi
        
        cat "${cfgfile}" | grep "^${cfgvar}" | grep "${cfgval}"
        (test $? != 0) && echo "ERROR: failed to update <${cfgfile}> to contain <${cfgline}>" && exit 1
        
        # need to restart tor service to let hidden service generate onion addresses
        /usr/sbin/service tor restart
        echo "waiting for tor service restart"
        sleep 7
        
        # check tor directory used for storing auth private keys for clients
        torauthclientsdir="/var/lib/tor/hidden-service-ssh/authorized_clients/"
        
        mkdir -p ${torauthclientsdir} && cd "${torauthclientsdir}" && chown debian-tor:debian-tor . && chmod 700 .
        (test $? != 0) && echo "ERROR: directory <${torauthclientsdir}> processing failed" && exit 1
        
        #generate key name
        keyname="${clientalias}2${nodealias}"

        # preparere directory for storing keys
        torgenkeysdir="/root/private_ssl_keys"
        
        mkdir -p ${torgenkeysdir} && cd ${torgenkeysdir} && chmod 700 .
        (test $? != 0) && echo "ERROR: directory <${torgenkeysdir}> processing failed" && exit 1
        
        # generate private key for hidden service ssh client X
        openssl genpkey -algorithm x25519 -out ./${keyname}.prv.pem
        (test $? != 0) && echo "ERROR: <${keyname}>.prv.pem failed to generate" && exit 1
        
        # export private key as base 32 key
        cat ./${keyname}.prv.pem | grep -v " PRIVATE KEY" | base64pem -d | tail --bytes=32 | base32 | sed 's/=//g' > ./${keyname}.prv.key
        (test $? != 0) && echo "ERROR: <${keyname}>.prv.key failed to export" && exit 1
        
        # export public key as base 32 key
        openssl pkey -in ./${keyname}.prv.pem -pubout | grep -v " PUBLIC KEY" | base64pem -d | tail --bytes=32 | base32 | sed 's/=//g' > ./${keyname}.pub.key
        (test $? != 0) && echo "ERROR: <${keyname}>.pub.key failed to export" && exit 1
        
        # export private key formated as: <56-char-onion-addr-without-.onion-part>:descriptor:x25519:<x25519 private key in base32>
        echo "`cat /var/lib/tor/hidden-service-ssh/hostname | cut -d '.' -f1`:descriptor:x25519:`cat ./${keyname}.prv.key`" > ./${keyname}.auth_private
        (test $? != 0) && echo "ERROR: <${keyname}>.auth_private failed to export" && exit 1
        
        # export public key formated as: <auth-type>:<key-type>:<base32-encoded-public-key>
        echo "descriptor:x25519:`cat ./${keyname}.pub.key`" > ./${keyname}.auth
        (test $? != 0) && echo "ERROR: <${keyname}>.auth failed to export" && exit 1
        
        # copy formated private key to nodeuser2 installtion directory
        cp ./${keyname}.auth_private ${dxbot_dir_remote_setup} && chmod 700 ${dxbot_dir_remote_setup}"/"${keyname}.auth_private && chown $nodeuser2 ${dxbot_dir_remote_setup}"/"${keyname}.auth_private
        (test $? != 0) && echo "ERROR: <${dxbot_dir_remote_setup}/${keyname}.auth_private> copy failed" && exit 1
        
        # copy formated public key to tor auth directory
        cp ./${keyname}.auth ${torauthclientsdir} && chmod 700 ${torauthclientsdir}${keyname}.auth && chown debian-tor:debian-tor ${torauthclientsdir}${keyname}.auth
        (test $? != 0) && echo "ERROR: <${torauthclientsdir}${keyname}.auth> copy failed" && exit 1

        # restart tor service
        /usr/sbin/service tor restart
        
        echo "# ${0} >> root@${nodealias} >> tor config >> create hidden service v3 for ssh clients authorized by key >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> remote desktop access configuration"
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
    if [ "$rd" = "rdyes" ]; then
        echo "# ${0} >> root@${nodealias} >> remote desktop access configuration >> try"
        
        #~ TODO add remote desktop configuration process
        (test $? != 0) && echo "ERROR: remote desktop node configuration failed" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> remote desktop access configuration >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> firejail main config update"
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
    if [ "${firejail}" = "firejailyes" ];then
        echo "# ${0} >> root@${nodealias} >> firejail main config update >> try"
        
        echo "# ${0} >> root@${nodealias} >> firejail main config update >> allow network restrictions"
        firejail_main_cfg="/etc/firejail/firejail.config"
        sed -i \
            -e "s/.*restricted-network.*/restricted-network no/g" \
            ${firejail_main_cfg}
        (test $? != 0) && echo "firejail config file <${firejail_main_cfg}> update failed" && exit 1
        
        cat ${firejail_main_cfg} | grep -e "restricted-network no"
        (test $? != 0) && echo "firejail config file <${firejail_main_cfg}> check failed" && exit 1
        
        echo "# ${0} >> root@${nodealias} >> firejail main config update >> try >> success"
    fi
fi

exit 0
