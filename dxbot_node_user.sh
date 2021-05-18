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
echo "# ${0} >> ${nodeuser2}@${nodealias} >> build wallets from source >> generate wallets config >> generate sandbox config"
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
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> build wallets from source >> generate wallets config >> generate sandbox config >> try"
    
    cd ${dxbot_dir_remote_setup}
    (test $? != 0) && echo "ERROR: change directory <$dxbot_dir_remote_setup> failed" && exit 1
    
    cc_list=`ls | grep dxbot_node_user_cc_cfg_ | grep sh$`
    for f in $cc_list; do
        bash ./dxbot_node_user_cc.sh ${dxbot_config_file_arg} $f
        (test $? != 0) && echo "ERROR: <$f> wallet configuration file processing failed" && exit 1
    done
    
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> build wallets from source >> generate wallets config >> generate sandbox config >> try >> success"
fi


########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and configure dxbot"
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
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and configure dxbot >> try"
    
    bash ./dxbot_node_user_dxbot.sh
    (test $? != 0) && echo "ERROR: Blocknet dxbot install and configure failed" && exit 1
    
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and configure dxbot >> try >> success"
fi

#~ TODO update cron user startup by screen or mate-terminal

#~ TODO generate mate/gnome terminal script for QT and D

#~ TODO generate screen script
# screen -t <title> <tab-index> <command>
# screen -t titlescript1 0 bash script1.sh
# screen -t titlescript2 1 bash script2.sh

exit 0
