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
echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and build wallets from source code"
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
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and build wallets from source code >> try"
    
    if [ ${BLOCKwallet} = "gui" ] || [ ${BLOCKwallet} = "daemon" ]; then
        bash ./dxbot_node_user_cc.sh ${dxbot_config_file_arg} dxbot_node_user_block.sh
        (test $? != 0) && echo "ERROR: Blocknet wallet checkout and build failed" && exit 1
    fi

    #~ TODO also apply left wallets configuration files and uncomment code
    
    #~ if [ ${BTCwallet} = "gui" ] || [ ${BTCwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_btc.sh || (echo "ERROR: Bitcoin wallet checkout and install failed" && exit 1)
    #~ fi

    if [ ${LTCwallet} = "gui" ] || [ ${LTCwallet} = "daemon" ]; then
        bash ./dxbot_node_user_cc.sh ${dxbot_config_file_arg} dxbot_node_user_ltc.sh
        (test $? != 0) && echo "ERROR: Litecoin wallet checkout and build failed" && exit 1
    fi

    #~ if [ ${DASHwallet} = "gui" ] || [ ${DASHwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_dash.sh || (echo "ERROR: Dashpay wallet checkout and install failed" && exit 1)
    #~ fi

    #~ if [ ${DOGEwallet} = "gui" ] || [ ${DOGEwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_doge.sh || (echo "ERROR: Dogecoin wallet checkout and install failed" && exit 1)
    #~ fi

    #~ if [ ${XVGwallet} = "gui" ] || [ ${XVGwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_xvg.sh || (echo "ERROR: Verge wallet checkout and install failed" && exit 1)
    #~ fi

    #~ if [ ${PIVXwallet} = "gui" ] || [ ${PIVXwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_pivx.sh || (echo "ERROR: Pivx wallet checkout and install failed" && exit 1)
    #~ fi

    #~ if [ ${XMRwallet} = "gui" ] || [ ${XMRwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_xmr.sh || (echo "ERROR: Monero wallet checkout and install failed" && exit 1)
    #~ fi
    
    echo "# ${0} >> ${nodeuser2}@${nodealias} >> checkout and build wallets from source code >> try >> success"
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

#~ TODO cron user startup by screen or mate-terminal

exit 0
