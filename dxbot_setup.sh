#!/bin/bash

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 000 >> Welcome in Blocknet dxbot ecosystem remote setup for Debian Linux"
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
echo "# STEP 001 >> client >> Configuration verification"
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

# config file name read and include
cfgfile=$1
if [ "$cfgfile" = "" ] || [ "$cfgfile" = "dxbot_cfg.sh" ]; then
    echo "ERROR: first parameter, which is config file parameter can not be empty also can not be <dxbot_cfg.sh> because used as temporary file"
    echo "Please make copy and edit <dxbot_cfg_example1.sh> as your wishes are and run dxbot setup ie like:"
    echo "bash ./dxbot_setup.sh dxbot_cfg_node1.sh"
    exit 1
fi

if [ ! -f "$cfgfile" ]; then
    echo "ERROR: config file ${cfgfile} does not exist"
    exit 1
fi

echo "using config file <${cfgfile}>:"
cat ${cfgfile} | grep -v "^#" | grep "="
echo ""

source "${cfgfile}"
 
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

dxbot_dir_local_setup=`pwd`

(test ${dxbot_dir_local_setup} = ${dxbot_dir_remote_root}) && (echo "dxbot setup installation files and remote node dxbot setup installation directory can not be same, please change <dxbot_dir_remote_root> directory parameter in <${cfgfile}> configuration file and try to run setup..." && exit 1)

dxbot_dir_remote_setup=${dxbot_dir_remote_root}"/dxbotsetup/"

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 002 >> client >> Exporting configuration to file"
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
dxbot_config_file="dxbot_cfg.sh"

cp ${cfgfile} ${dxbot_config_file} && echo "
localuser=$USER
dxbot_dir_local_setup=$dxbot_dir_local_setup
dxbot_dir_remote_root=$dxbot_dir_remote_root
dxbot_dir_remote_setup=$dxbot_dir_remote_setup
" >> $dxbot_config_file
if [ $? -ne 0 ]; then
    echo "configuration export top file failed: $dxbot_config_file"
    exit 1
fi

echo "configuration has been successfully exported to: $dxbot_config_file"

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 003 >> root@node >> check or create $nodeuser2@node"
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
    ssh -t ${nodeuser2}@${nodeip} "echo ${nodeuser2} already exist"
    if [ $? -ne 0 ]; then
        ssh -t ${nodeuser1}@${nodeip} "echo -n 'Enter root ' && su -c 'id $nodeuser2 || (echo creating$nodeuser2 && adduser $nodeuser2)'"
        if [ $? -ne 0 ]; then
            echo "ERROR: dxbot process failed on root@node"
            exit 1
        fi
    fi
    echo "creating/check for $nodeuser2 on node success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 004 >> Generating/Exporting ssh public key from client to $nodeuser2@node to be able to login/installation without password"
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
        if [ ! -f "$sshkey" ]; then
            echo "ssh key <$sshkey> does not exist. generating one"
            ssh-keygen -t ed25519 -a 100 -f $sshkey
            if [ $? -ne 0 ] || [ ! -f "$sshkey" ]; then
                echo "ERROR: failed to generated ssh key for export"
                exit 1
            fi
        fi
        
        echo "trying to export ssh key <$sshkey>"
        
        /usr/bin/ssh-copy-id -i ${sshkey} ${nodeuser2}@${nodeip}
        if [ $? -ne 0 ]; then
            echo "ERROR: failed to export public keyt from client to node"
            exit 1
        fi
        
        echo "ssh key <$sshkey> has been successfully exported"
    fi
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 005 >> Copying installation from client to $nodeuser2@node"
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

    echo "creating installation directories on node"
    ssh ${nodeuser2}@${nodeip} "mkdir -p $dxbot_dir_remote_setup && chmod 700 $dxbot_dir_remote_setup"
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to create installation directories"
        exit 1
    fi
    
    echo "packing up all installation files"
    tar -czf dxbotsetup.tar.gz --exclude=dxbotsetup.tar.gz *
    (test $? = 0) || (echo "installation files pack failed" && exit 1)
    
    echo "copying installation files to node"
    scp "dxbotsetup.tar.gz" ${nodeuser2}@${nodeip}:${dxbot_dir_remote_setup}
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to copy installtion files to node"
        exit 1
    fi
    
    echo "extracting node installation files"
    ssh ${nodeuser2}@${nodeip} "cd $dxbot_dir_remote_setup && tar xvzf dxbotsetup.tar.gz -C ./"
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to create installation directories"
        exit 1
    fi
    
    echo "files has been successfully copied from client to node"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 006 >> root@node >> processing installation"
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
    echo "dxbotsetup on node as root..."
    ssh -t ${nodeuser2}@${nodeip} "echo -n 'Enter root ' && su -c 'cd $dxbot_dir_remote_setup && bash ./dxbot_node_root.sh'"
    if [ $? -ne 0 ]; then
        echo "ERROR: dxbot process failed on root@node"
        exit 1
    fi

    echo "node installation by root success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 007 >> copying generated files from $nodeuser2@node to client"
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
    # copy generated files from node to client
    echo "copying generated files from node to client"
    keyname="${clientalias}2${nodealias}"
    cd ${dxbot_dir_local_setup} && scp $nodeuser2@$nodeip:${dxbot_dir_remote_setup}"/"${keyname}.auth_private ./
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to copy installtion files to node"
        exit 1
    fi

    echo "copy generated files back from server to client success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 008 >> root@client >> processing installation"
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
    # processing installations script on root@client
    echo "dxbotsetup on root@client..."
    cd ${dxbot_dir_local_setup} && echo -n 'Enter root ' && su -c 'bash ./dxbot_client_root.sh'
    if [ $? -ne 0 ]; then
        echo "ERROR: dxbot process failed on root@client"
        exit 1
    fi

    echo "node installation by root success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 009 >> $nodeuser2@node >> processing installation"
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
    echo "trying >> download >> build >> generate configuration for wallets and scripts"

    ssh -t ${nodeuser2}@${nodeip} "cd ${dxbot_dir_remote_setup} && bash ./dxbot_node_user.sh'"
    if [ $? -ne 0 ]; then
        echo "ERROR: dxbot process failed on user@node"
        exit 1
    fi

    echo "trying >> download >> build >> generate configuration for wallets and scripts success"
fi

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 010 >> @client >> generating connect scripts >> finalizing installation"
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
    echo "trying >> generate connect scripts"
    
    #~ TODO generate SSH and RD connect scripts
    #~ ssh -t $nodeuser2@$nodeip "cd ${dxbot_dir_remote_setup} && bash ./dxbot_node_user.sh'"
    #~ if [ $? -ne 0 ]; then
        #~ echo "ERROR: dxbot process failed on user@node"
        #~ exit 1
    #~ fi
    
    echo "trying >> generate connect scripts >> success"
fi

echo 0
