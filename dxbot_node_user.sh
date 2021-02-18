#!/bin/bash

source "dxbot_cfg.sh"

########################################################################
echo ""
echo "##################################################################"
echo "# STEP 007.001 >> user2@node >> checkout and build wallets from source code"
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
    if [ ${BLOCKwallet} = "gui" ] || [ ${BLOCKwallet} = "daemon" ]; then
        bash ./dxbot_node_user_cc.sh dxbot_node_user_block.sh || (echo "ERROR: Blocknet wallet checkout and install failed" && exit 1)
    fi

    #~ TODO also apply left wallets configuration files and uncomment code
    
    #~ if [ ${BTCwallet} = "gui" ] || [ ${BTCwallet} = "daemon" ]; then
        #~ bash ./dxbot_node_user_btc.sh || (echo "ERROR: Bitcoin wallet checkout and install failed" && exit 1)
    #~ fi

    if [ ${LTCwallet} = "gui" ] || [ ${LTCwallet} = "daemon" ]; then
        bash ./dxbot_node_user_cc.sh dxbot_node_user_ltc.sh || (echo "ERROR: Litecoin wallet checkout and install failed" && exit 1)
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
fi


########################################################################
echo ""
echo "##################################################################"
echo "# STEP 007.002 >> user2@node >> checkout and configure dxbot"
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
    bash ./dxbot_node_user_dxbot.sh || (echo "ERROR: Blocknet dxbot install and configure failed" && exit 1)
fi

#~ TODO cron user startup by screen or mate-terminal

exit 0
