#!/bin/bash

source "dxbot_cfg.sh"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> checkout Blocknet dxbot source code"
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
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> dxbot >> git clone source code >> try"
    
    cd ${dxbot_dir_remote_root}
    (test $? = 0) || (echo "cd ${dxbot_dir_remote_root} failed" && exit 1)

    mkdir -p dxbot && cd dxbot
    (test $? = 0) || (echo "mkdir -p dxbot failed" && exit 1)
    
    git clone https://github.com/nnmfnwl7/dxmakerbot.git .
    if [ $? != 0 ]; then
        if [ $? == 128 ]; then
            git pull
            (test $? = 0) || (echo "git pull failed" && exit 1)
        else
            echo "git clone dxbot source code failed"
            exit 1
        fi
    fi
    
    git checkout origin/fazer_dxmakerbot_latest_alfa
    (test $? = 0) || (echo "checkout dxbot alfa version failed" && exit 1)
    
    echo "
# dxsetting dxbot setup update:
tradingaddress = {}
rpcport = 41414
rpcuser = '`cat ~/.blocknet/blocknet.conf | grep rpcuser | cut -d "=" -f2`'
rpcpassword = '`cat ~/.blocknet/blocknet.conf | grep rpcpassword | cut -d "=" -f2`'
    " >> utils/dxsettings.py
    (test $? = 0) || (echo "generate ${cfgfile} failed" && exit 1)

    # copy example dxmakerbot v2 configurations
    cp howto/examples/bot_v2_sell_block_buy_ltc.py ./bot_v2_sell_block_buy_ltc.py
    (test $? = 0) || (echo "example config copy failed" && exit 1)
    
    cp howto/examples/bot_v2_sell_ltc_buy_block.py ./bot_v2_sell_ltc_buy_block.py
    (test $? = 0) || (echo "example config copy failed" && exit 1)

    # usefull command to check configuration file
    #~ cat  bot_v2_sell_block_buy_ltc.py | grep -v "#" | grep "\"--"
    #~ cat  bot_v2_sell_ltc_buy_block.py | grep -v "#" | grep "\"--" 
 
    # run bot which sells blocknet for litecoin
    #~ python3 dxmakerbot_v2_run.py --config bot_v2_sell_block_buy_ltc

    # run bot which sells litecoin for blocknet
    #~ python3 dxmakerbot_v2_run.py --config bot_v2_sell_ltc_buy_block
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> dxbot >> git clone source code >> try >> success"
    
fi

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> generate Blocknet xBridge configuration file"
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
    
    cc_xbridge_file="xbridge.conf"
    
    cc_xbridge_wallets=BLOCK
    
    cc_xbridge_configs="
[BLOCK]
Title=Blocknet
Ip=127.0.0.1
Port=`echo 41414`
AddressPrefix=26
ScriptPrefix=28
SecretPrefix=154
COIN=100000000
MinimumAmount=0
TxVersion=1
DustAmount=0
CreateTxMethod=BTC
GetNewKeySupported=true
ImportWithNoScanSupported=true
MinTxFee=10000
BlockTime=60
FeePerByte=20
Confirmations=0
Username=`echo BlockDXBlocknet`
Password=`echo password`
Address=
TxWithTimeField=false
LockCoinsSupported=false
JSONVersion=
ContentType=
CashAddrPrefix=
"
    
    if [ ${LTCwallet} = "gui" ] || [ ${LTCwallet} = "daemon" ]; then
        cc_xbridge_wallets=${cc_xbridge_wallets},LTC
    fi
    
    echo "
[Main]
ExchangeWallets=${cc_xbridge_wallets}
FullLog=true
ShowAllOrders=true
${cc_xbridge_configs}
    " >> ${cc_xbridge_file}
    (test $? = 0) || (echo "generate ${cc_xbridge_file} failed" && exit 1)
    
fi
