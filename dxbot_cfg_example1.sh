# dxbotsetup example configuration file

# comments and examples are starting by #

# please make copies as many configurations as many nodes going to be installed

# command to use this configuration:
# bash ./dxbot_setup.sh dxbot_cfg_example1.sh

# PLEASE DO NOT USE SPACES IN CONFIGURATION PARAMETERS AS LONG IT NOT BEEN TESTED

# client machine alias, is machine to be configured to access node from
# parameter used for config files/private/public keys files naming
clientalias="client1"
#~ clientalias="mynotebook1"

# node machine alias, is machine where Blockent dxbot+wallets to be installed
# parameter used for config files/private/public keys files naming.
nodealias="node1"
#~ nodealias='localhost' # alias for installation on local host
#~ nodealias='localvps' # alias for installation on local virtual private server
#~ nodealias='localminipc' # alias for installing on local network mini pc
#~ nodealias='awsvps' # alias for installtion on AWS service

# node machine IP address or hostname.
nodeip='192.168.10.xx' # in case of local network node be probably IP like this.
#~ nodeip='myminipcnode007' # in case of node is running on local network and hostname is set
#~ nodeip='127.0.0.1' # In case of installing on local machine can be 127.0.0.1/localhost

# Debian Linux installer asks you for first username account to be created
# which is having also special system permissions, so it is not recommended
# to use this for dxbot installation
nodeuser1="user1"

# user to be added if missing. All Blocknet dxbot ecosystem be installed 
# in home directory of this user, ie 'user2'
nodeuser2='user2'

# generate if missing and also export ssh key from client to node,
# to be able to login to all possible nodes without password 
# or with one password which is used just to encrypt client private authorization key
# so you do not need to remember all passwords for your nodes but just one
sshpkexport='sshpkexportyes'
#~ sshpkexport='sshpkexportno'

# update node ssh configuration to disable ssh login by password.
# this can prevent bruteforce password attacks on your NODE.
sshpkonly='sshpkonlyyes'
#~ sshpkonly='sshpkonlyno'

# update node hosts.allow and hosts.deny about sshd to be accessible
# only by localhost and IP address which has been used to install node from
sshiponly='sshiponlyyes'
#~ sshiponly='sshiponlyno'

# configure access to node from any point of internet by tor hidden service version 3
# script will generate private and public key pair for the only and only access by this client.
sshtoraccess='sshtoraccessyes'
#~ sshtoraccess='sshtoraccessno'

# configure access to node by remote desktop protocol
rd='rdyes'
#~ rd='rdno'

# enabled/disable firejail sandbox for secured build and execution process
firejail='firejailyes'
#~ firejail='firejailno'

# configure wallets to try to connect also over anonoym tor service
torwallet='torwalletyes'
#~ torwallet='torwalletno'

# configure tor and wallets to also accepts connections from tor service
torhswallet='torhswalletyes'
#~ torhswallet='torhswalletno'

#configure walets to try to connect also over clearnet
clearnetwallet='clearnetwalletno'
#~ clearnetwallet='clearnetwalletyes'

# compile wallets with QT interface + daemon or only as daemon or do not compile wallet
# choose between:
#   gui - graphical user interface and also daemon wallet
#   daemon - daemon wallet only
#   no - do not compile wallet

# blocknet wallet
BLOCKwallet='gui'
#~ BLOCKwallet='BLOCKd'
#~ BLOCKwalletrestore="${HOME}/.blocknet/wallet.dat"

# separated blocknet instance for staking on ~/.blocknet.staking directory
BLOCKwalletstaking='no'
#~ BLOCKwalletstaking='gui'

# bitcoin walet
BTCwallet='gui' # wallet with qt interface and also as daemon
#~ BTCwallet='daemon' # compile wallet as daemon only
#~ BTCwallet='no' # do not compile wallet
#~ BTCwalletrestore="${HOME}/.bitcoin/wallets/wallet.dat"

# litecoin wallet
LTCwallet='gui'
#~ LTCwallet='daemon'
#~ LTCwallet='no'
#~ LTCwalletrestore="${HOME}/.litecoin/wallet.dat"

# WARNING: before activating LBRY wallet, please consider to edit 
#    dxbot setup config file dxbot_setup_user_cc_cfg_lbc.sh variables 
#    cc_blockchain_dir_path_eval= and cc_blockchain_dir_path_noteval= 
#    to point to SEPARATED SSD storage because LBC chain high IO requirements
#    otherwise chain sync can take 15+ days.
 
# Lbry credits (LBRY) (LBC) (ODYSEE)
#~ LBCwallet='gui'
#~ LBCwallet='daemon'
LBCwallet='no'
#~ LBCwalletrestore="${HOME}/.lbrycrd/wallet.dat"

# dash wallet
DASHwallet='gui'
#~ DASHwallet='daemon'
#~ DASHwallet='no'
#~ DASHwalletrestore="${HOME}/.dashcore/wallet.dat"

# dogecoin wallet
DOGEwallet='gui'
#~ DOGEwallet='daemon'
#~ DOGEwallet='no'
#~ DOGEwalletrestore="${HOME}/.dogecoin/wallet.dat"

# verge wallet
XVGwallet='gui'
#~ XVGwallet='daemon'
#~ XVGwallet='no'
#~ XVGwalletrestore="${HOME}/.VERGE/wallets/wallet.dat

# pivx wallet
PIVXwallet='gui'
#~ PIVXwallet='daemon'
#~ PIVXwallet='no'
#~ PIVXwalletrestore="${HOME}/.pivx/wallet.dat

# monero wallet...coming soon as long atomic swap on monero blockchain are applicable  :)
#~ XMRwallet='gui'
#~ XMRwallet='daemon'
#~ XMRwallet='no'
#~ XMRwalletrestore="${HOME}/Monero/wallets/${USER}/*

# installation node root-directory where source code and binary files are stored
dxbot_dir_remote_root="/home/${nodeuser2}/ccwallets"
