#!/bin/bash

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> Welcome in Blocknet dxbot ecosystem remote setup for Debian Linux"
echo ""
echo "first please edit <dxbot_cfg_example1.sh> as your wishes are and run dxbot setup like:"
echo "bash ./dxbot_setup.sh dxbot_cfg_example1.sh"

echo '
MIT License

Copyright (c) 2020 FAZER
Copyright (c) 2021 FAZER

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'
read -n 1 -r -p "To continue installation you must agree above MIT License agreement by pushing uppercase 'Y'" key
if [ "$key" != "Y" ]; then
    echo -e "\nsetup cancelled"
    exit 0
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> Configuration verification"
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

echo "# ${0} >> Configuration verification >> try"

# config file name read and include
dxbot_config_file_arg=$1
if [ "${dxbot_config_file_arg}" = "" ]; then
    echo "ERROR: first parameter, which is config file parameter can not be empty"
    echo "Please make copy and edit <dxbot_cfg_example1.sh> as your wishes are and run dxbot setup, ie like:"
    echo "bash ./dxbot_setup.sh dxbot_cfg_node1.sh"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg}>:"
cat ${dxbot_config_file_arg} | grep -v "^#" | grep "="
echo ""

source "${dxbot_config_file_arg}"
 
# client name read
if [ "$clientalias" = "" ]; then
    echo "ERROR: node clientalias can not be empty"
    exit 1
fi
echo "using clientalias: $clientalias"

# node alias read
if [ "$nodealias" = "" ]; then
    echo "ERROR: node nodealias can not be empty"
    exit 1
fi
echo "using nodealias: $nodealias"

# node ip read
if [ "$nodeip" = "" ]; then
    echo "ERROR: node nodeip can not be empty"
    exit 1
fi
echo "using nodeip: $nodeip"

# node first username
if [ "$nodeuser1" = "" ]; then
    echo "ERROR: node nodeuser1 can not be empty"
    exit 1
fi
echo "using nodeuser1: $nodeuser1"

# node dxbot username
if [ "$nodeuser2" = "" ]; then
    echo "ERROR: node nodeuser2 can not be empty"
    exit 1
fi
echo "using nodeuser2: $nodeuser2"

# sshpkexport
if [ "$sshpkexport" != "sshpkexportyes" ] && [ "$sshpkexport" != "sshpkexportno" ]; then
    echo "ERROR: invalid sshpkexport input: $sshpkexport"
    exit 1
fi
echo "using sshpkexport: $sshpkexport"

# sshpkonly
if [ "$sshpkonly" != "sshpkonlyyes" ] && [ "$sshpkonly" != "sshpkonlyno" ]; then
    echo "ERROR: invalid sshpkonly input: $sshpkonly"
    exit 1
fi
echo "using sshpkonly: $sshpkonly"

# sshiponly
if [ "$sshiponly" != "sshiponlyyes" ] && [ "$sshiponly" != "sshiponlyno" ]; then
    echo "ERROR: invalid sshiponly input: $sshiponly"
    exit 1
fi
echo "using sshiponly: $sshiponly"

# sshtoraccess
if [ "$sshtoraccess" != "sshtoraccessyes" ] && [ "$sshtoraccess" != "sshtoraccessno" ]; then
    echo "ERROR: invalid sshtoraccess input: $sshtoraccess"
    exit 1
fi
echo "using sshtoraccess: $sshtoraccess"

# remote desktop
if [ "$rd" != "rdyes" ] && [ "$rd" != "rdno" ]; then
    echo "ERROR: invalid rd input: $rd"
    exit 1
fi
echo "using rd: $rd"

# enable debug builds
if [ "$debug" != "debugyes" ] && [ "$debug" != "debugno" ]; then
    echo "ERROR: invalid debug input: $debug"
    exit 1
fi
echo "using debug: $debug"

# firejail sandboxing
if [ "$firejail" != "firejailyes" ] && [ "$firejail" != "firejailno" ]; then
    echo "ERROR: invalid firejail input: $firejail"
    exit 1
fi
echo "using rd: $firejail"

# torwallet
if [ "$torwallet" != "torwalletyes" ] && [ "$torwallet" != "torwalletno" ]; then
    echo "ERROR: invalid torwallet input: $torwallet"
    exit 1
fi
echo "using torwallet: $torwallet"

# torhswallet
if [ "$torhswallet" != "torhswalletyes" ] && [ "$torhswallet" != "torhswalletno" ]; then
    echo "ERROR: invalid torhswallet input: $torhswallet"
    exit 1
fi
echo "using torhswallet: $torhswallet"

# clearnetwallet
if [ "$clearnetwallet" != "clearnetwalletyes" ] && [ "$clearnetwallet" != "clearnetwalletno" ]; then
    echo "ERROR: invalid clearnetwallet input: $clearnetwallet"
    exit 1
fi
echo "using clearnetwallet: $clearnetwallet"

# BLOCKwallet
if [ "$BLOCKwallet" != "gui" ] && [ "$BLOCKwallet" != "daemon" ]; then
    echo "ERROR: invalid BLOCKwallet input: $BLOCKwallet"
    exit 1
fi
echo "using BLOCKwallet: $BLOCKwallet"

# BTCwallet
if [ "$BTCwallet" != "gui" ] && [ "$BTCwallet" != "daemon" ] && [ "$BTCwallet" != "no" ]; then
    echo "ERROR: invalid BTCwallet input: $BTCwallet"
    exit 1
fi
echo "using BTCwallet: $BTCwallet"

# LTCwallet
if [ "$LTCwallet" != "gui" ] && [ "$LTCwallet" != "daemon" ] && [ "$LTCwallet" != "no" ]; then
    echo "ERROR: invalid LTCwallet input: $LTCwallet"
    exit 1
fi
echo "using LTCwallet: $LTCwallet"

# DASHwallet
if [ "$DASHwallet" != "gui" ] && [ "$DASHwallet" != "daemon" ] && [ "$DASHwallet" != "no" ]; then
    echo "ERROR: invalid DASHwallet input: $DASHwallet"
    exit 1
fi
echo "using DASHwallet: $DASHwallet"

# DOGEwallet
if [ "$DOGEwallet" != "gui" ] && [ "$DOGEwallet" != "daemon" ] && [ "$DOGEwallet" != "no" ]; then
    echo "ERROR: invalid DOGEwallet input: $DOGEwallet"
    exit 1
fi
echo "using DOGEwallet: $DOGEwallet"

# XVGwallet
if [ "$XVGwallet" != "gui" ] && [ "$XVGwallet" != "daemon" ] && [ "$XVGwallet" != "no" ]; then
    echo "ERROR: invalid XVGwallet input: $XVGwallet"
    exit 1
fi
echo "using XVGwallet: $XVGwallet"

# PIVXwallet
if [ "$PIVXwallet" != "gui" ] && [ "$PIVXwallet" != "daemon" ] && [ "$PIVXwallet" != "no" ]; then
    echo "ERROR: invalid PIVXwallet input: $PIVXwallet"
    exit 1
fi
echo "using PIVXwallet: $PIVXwallet"

# XMRwallet
#~ if [ "$XMRwallet" != "gui" ] && [ "$XMRwallet" != "daemon" ] && [ "$XMRwallet" != "no" ]; then
    #~ echo "ERROR: invalid XMRwallet input: $XMRwallet"
    #~ exit 1
#~ fi
#~ echo "using XMRwallet: $XMRwallet"

localuser=`id -un`
dxbot_dir_local_setup=`pwd`
dxbot_dir_remote_setup=${dxbot_dir_remote_root}"/dxbotsetup/"

(test ${dxbot_dir_local_setup} = ${dxbot_dir_remote_root}) && echo "dxbot setup installation files and remote node dxbot setup installation directory can not be same, please change <dxbot_dir_remote_root> directory parameter in <${dxbot_config_file_arg}> configuration file and try to run setup..." && exit 1

echo "# ${0} >> Configuration verification >> try >> success"

mkdir -p ~/.ssh/active_sessions && chmod 700 ~/.ssh/active_sessions
(test $? != 0) && echo "ERROR: failed to create directory for master ssh channel" && exit 1

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${localuser}@${clientalias} >> Exporting configuration to file"
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

# export config to file
dxbot_config_file_gen=${dxbot_config_file_arg}".gen.sh"

echo "# ${0} >> ${localuser}@${clientalias} >> Exporting configuration to ${dxbot_config_file_gen} >> try"

cp ${dxbot_config_file_arg} ${dxbot_config_file_gen} && echo "
localuser=${localuser}
dxbot_dir_local_setup=$dxbot_dir_local_setup
dxbot_dir_remote_setup=$dxbot_dir_remote_setup
" >> ${dxbot_config_file_gen}
(test $? != 0) && echo "ERROR: Exporting configuration to ${dxbot_config_file_gen} failed" && exit 1

echo "# ${0} >> ${localuser}@${clientalias} >> Exporting configuration to ${dxbot_config_file_gen} >> try >> success"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> check or create user ${nodeuser2}@${nodealias)"
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
    echo "# ${0} >> root@${nodealias} >> check or create user ${nodeuser2}@${nodealias) >> try"
    
    ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser1}@${nodeip} \
    "(id ${nodeuser2}) || (echo -ne 'User ${nodeuser2} does not exist. To create user please enter root ' && su -c 'adduser ${nodeuser2})'"
    # in case of rerunning dxbot setup and user already exists and ssh by private key to user2 is allowed only...
    if [ $? -ne 0 ]; then
        ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
        "id"
    fi
    (test $? != 0) && echo "ERROR: check or create user ${nodeuser2}@${nodealias) failed" && exit 1
    
    echo "# ${0} >> root@${nodealias} >> check or create user ${nodeuser2}@${nodealias) >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${localuser}@${clientalias} >> Check/Generate+Export SSH public key to ${nodeuser1}@${nodealias}"
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

# generate and export ssh keys
sshkey="$HOME/.ssh/id_ed25519.pub"
#~ sshkey="$HOME/.ssh/id_ed25519test"

if [ "$key" = "c" ]; then
    
    if [ "$sshpkexport" = "sshpkexportyes" ]; then
        
        echo "# ${0} >> ${localuser}@${clientalias} >> Check/Generate+Export SSH public key to ${nodeuser1}@${nodealias} >> try"
        
        if [ ! -f "$sshkey" ]; then
            echo "ssh key <${sshkey}> does not exist >> generating one"
            ssh-keygen -t ed25519 -a 100 -f $sshkey
            if [ $? -ne 0 ] || [ ! -f "$sshkey" ]; then
                echo "ERROR: failed to generated ssh key for export"
                exit 1
            fi
        else
            echo "ssh key <${sshkey}> already exist >> using existing"
        fi
        
        echo "trying to export ssh key <$sshkey> with ssh-copy-id"
        
        /usr/bin/ssh-copy-id -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
        -i ${sshkey} ${nodeuser2}@${nodeip}
        (test $? != 0) && echo "ERROR: failed to export public keyt from client to node" && exit 1
        
        echo "# ${0} >> ${localuser}@${clientalias} >> Check/Generate+Export SSH public key to ${nodeuser1}@${nodealias} >> try >> success"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${localuser}@${clientalias} >> copying setup files to ${nodeuser1}@${nodealias}"
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
    
    echo "# ${0} >> ${localuser}@${clientalias} >> copying setup files to ${nodeuser1}@${nodealias} >> try"
    
    # create remote destination directory where dxbot setup installation files copied
    echo "creating installation directories"
    ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
    "mkdir -p $dxbot_dir_remote_setup && chmod 700 $dxbot_dir_remote_setup"
    (test $? != 0) && echo "ERROR: failed to create installation directories" && exit 1
    
    # copy wallet dat files if set to restore
    cc_list=`ls | grep dxbot_node_user_cc_cfg_ | grep sh$`
    for f in $cc_list; do
        
        # null previously auto gen cc config variables
        source dxbot_node_user_cc_null_cfg.sh
        (test $? != 0) && echo "source file <dxbot_node_user_cc_null_cfg.sh> not found" && exit 1
        
        # load cc config variables
        source ${f}
        (test $? != 0) && echo "source file <"${f}"> not found" && exit 1

        # auto gen cc config variables
        source dxbot_node_user_cc_gen_cfg.sh
        (test $? != 0) && echo "source file <dxbot_node_user_cc_gen_cfg.sh> not found" && exit 1

        # check if cc wallet restore is enabled
        if [ "${cc_wallet_restore}" != "" ]; then
            
            # check cc process running
            ps ux | grep -v grep | grep -i -e ${cc_name_prefix}
            (test $? = 0) && echo "ERROR: ${cc_name_prefix} wallet.dat file has been set to restore but seems like process is running" && exit 1
            
            # copy wallet dat file
            cp ${cc_wallet_restore} "./"${cc_name_prefix}${cc_instance_suffix}".wallet.dat"
            (test $? = 0) && echo "ERROR: copy ${cc_wallet_restore} to ${cc_name_prefix}${cc_instance_suffix}.wallet.dat failed" && exit 1
        fi
        
        # null previously auto gen cc config variables
        source dxbot_node_user_cc_null_cfg.sh
    done
    
    echo "packing up all installation files"
    tar -czf ${clientalias}2${nodealias}.tar.gz dxbot_node_root* dxbot_node_user* firejail* cmd* *.wallet.dat ${dxbot_config_file_gen}
    (test $? != 0) && echo "ERROR: installation files pack failed" && exit 1
    
    echo "copying installation files to node"
    scp -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" \
    ${clientalias}2${nodealias}.tar.gz ${nodeuser2}@${nodeip}:${dxbot_dir_remote_setup}
    (test $? != 0) && echo "ERROR: failed to copy installation files to node" && exit 1
    
    echo "extracting node installation files"
    ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
    "cd ${dxbot_dir_remote_setup} && tar xvzf ${clientalias}2${nodealias}.tar.gz -C ./"
    (test $? != 0) && echo "ERROR: failed to extract installation files" && exit 1
    
    echo "# ${0} >> ${localuser}@${clientalias} >> copying setup files to ${nodeuser1}@${nodealias} >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${nodealias} >> processing installation as root on node"
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
    echo "# ${0} >> root@${nodealias} >> processing installation as root on node >> try"
    
    ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
    "echo -n 'Enter root ' && su -c 'cd $dxbot_dir_remote_setup && bash ./dxbot_node_root.sh ${dxbot_config_file_gen}'"
    (test $? != 0) && echo "ERROR: processing dxbot setup installer on root@node failed" && exit 1

    echo "# ${0} >> root@${nodealias} >> processing installation as root on node >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> copying generated files to ${localuser}@${clientalias}"
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
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> copying generated files to ${localuser}@${clientalias} >> try"
    
    keyname="${clientalias}2${nodealias}"
    cd ${dxbot_dir_local_setup} && scp -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" \
    $nodeuser2@$nodeip:${dxbot_dir_remote_setup}"/"${keyname}.auth_private ./
    (test $? != 0) && echo "ERROR: copy generated files from node to client failed" && exit 1

    echo "# ${0} >> ${nodeuser1}@${nodealias} >> copying generated files to ${localuser}@${clientalias} >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> root@${clientalias} >> processing installation"
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
    echo "# ${0} >> root@${clientalias} >> processing installation >> try"
    
    cd ${dxbot_dir_local_setup} && echo -n 'Enter root ' && su -c 'bash ./dxbot_client_root.sh ${dxbot_config_file_gen}'
    (test $? != 0) && echo "ERROR: dxbot process failed on root@${clientalias}" && exit 1

    echo "# ${0} >> root@${clientalias} >> processing installation >> try >> success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> build and configure wallets, configure dxbot and generate scripts"
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
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> build and configure wallets, configure dxbot and generate scripts >> try"
    
    ssh -o "ControlMaster=auto" -o "ControlPath=~/.ssh/active_sessions/%C" -o "ControlPersist=600" -t ${nodeuser2}@${nodeip} \
    "cd ${dxbot_dir_remote_setup} && bash ./dxbot_node_user.sh ${dxbot_config_file_gen}'"
    (test $? != 0) && echo "ERROR: dxbot process failed on ${nodeuser1}@${nodealias}" && exit 1

    echo "# ${0} >> ${nodeuser1}@${nodealias} >> build and configure wallets, configure dxbot and generate scripts >> try  success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> generating connect scripts >> finalizing installation"
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
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> generating connect scripts >> finalizing installation >> try"
    
    #~ TODO generate SSH and RD connect scripts
    #~ ssh -t $nodeuser2@$nodeip "cd ${dxbot_dir_remote_setup} && bash ./dxbot_node_user.sh'"
    #~ if [ $? -ne 0 ]; then
        #~ echo "ERROR: dxbot process failed on user@node"
        #~ exit 1
    #~ fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> generating connect scripts >> finalizing installation >> try >> success"
fi

echo 0
