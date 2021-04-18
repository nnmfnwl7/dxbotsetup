########################################################################
    Welcome In Blocknet Dxbot Autosetup Installtion Instructions
                  For DEBIAN/TESTING VERSION
        (debian/stable or ubuntu has not been tested)

########################################################################
# STEP 1
# Find out what machine or virtual machine is DXBOT going to be installed:

Ie: Real PC, mini NUC pc, Raspberry Pi 4 8G, local Virtual Private System.
Thirty party services like AWS are not recommended, because they can access your private keys

########################################################################
# STEP 2
# Choose by type of machine what architecture DXBOT is going to be installed:

# installation Debian testing(version) instruction can be found:
https://www.debian.org/CD/http-ftp/

# for example choosing debian + testing + netinstall version for 64bit_x86/Intel+AMD CPUs with included proprietary wireless/eth firmwares
https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/weekly-builds/amd64/iso-cd/firmware-testing-amd64-netinst.iso

# for example choosing debian + testing + netinstall version for Raspberry Pi4
https://cdimage.debian.org/cdimage/weekly-builds/arm64/iso-cd/debian-testing-arm64-netinst.iso

# image can be written to and installed from USB/SDcard stick, please follow Linux/Windows instructions:
https://www.debian.org/CD/faq/#write-usb 

########################################################################
# step 3
# If ssh daemon has not been installed

# enter root and install ssh server on node by command:
su
apt install openssh-server
exit

########################################################################
# step 4

# download or git clone dxbot setup files
git checkout github $HOME/dxbotsetup

# make copy and EDIT configuration file by inside very EASY instructions
cp dxbot_cfg_example1.sh dxbot_cfg_node1.sh
joe dxbot_cfg_node1.sh

# run dxbot autosetup by command and follow instructions:
bash ./dxbot_setup.sh dxbot_cfg_node1.sh

########################################################################
# step 5

# dxbot setup will or optionally will

# connect from client to node. Client and node can possibly be also localhost
# install software dependencies, tor, firejail
# configure ssh, tor, firejail
# clone packages source code with git
# generate firejail sanbox profile files
# make wallet daemon cli and QT binaries from source code optionally in firejail sandbox
# generate wallet configuration files
# restore wallet.dat files
# generate scripts to run wallets/qt/daemon in screen/terminal with/without firejail
# clone dxbot with git
# auto-configure dxbot with restored wallets

########################################################################
# step 6

# find out generated helper scripts used to connect to node or run blockdx ecosystem
# this scripts are named <client alias><node alias>.*
