cc_ticker="BLOCK"
cc_name_full="blocknet"
cc_name_prefix="blocknet"
cc_blockchain_dir=${HOME}"/.blocknet.staking"
cc_cfg="blocknet.conf"

cc_port=""
cc_rpcport=""
cc_rpcuser=""

cc_cfg_add='
classic=1
staking=1
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
54.158.97.146:41412
62.171.146.255:41412
'

# to boost up sync with some onion nodes
cc_nodes_tor='
zb5iptmn4zvg2dmf.onion:41412
qt2fojojjgiyo75l.onion:41412
byn4h67ful67ri44.onion:41412
gihg67fqzu6vbzpx.onion:41412
wbbesmd4e5ryvxxb.onion:41412
cmi452uosfx5zrbu.onion:41412
y6ga2ty3vqedgs6f.onion:41412
ukouz7bipuady23p.onion:41412
3sy7at64ykn7jxeb.onion:41412
fnfzzmvzqngjia3p.onion:41412
'

cc_firejail_blockchain_dir_path='${HOME}/.blocknet.staking'
cc_firejail_cfg_file_path=${cc_firejail_blockchain_dir_path}"/"${cc_cfg}

cc_firejail_qt_cfg_dir_path='${HOME}/.config/Blocknet'

cc_firejail_src_path=${dxbot_dir_remote_root}"/"${cc_name_prefix}"_src/"

cc_firejail_daemon_file_path=${dxbot_dir_remote_root}"/"${cc_name_prefix}"_bin/"${cc_name_prefix}"d"
cc_firejail_cli_file_path=${dxbot_dir_remote_root}"/"${cc_name_prefix}"_bin/"${cc_name_prefix}"-cli"
cc_firejail_qt_file_path=${dxbot_dir_remote_root}"/"${cc_name_prefix}"_bin/"${cc_name_prefix}"-qt"

cc_firejail_profile_d=${cc_name_prefix}".staking.d.profile"
cc_firejail_profile_qt=${cc_name_prefix}".staking.qt.profile"
cc_firejail_profile_cli=${cc_name_prefix}".staking.cli.profile"
cc_firejail_profile_make=${cc_name_prefix}".staking.make.profile"

cc_export_CC=""
cc_export_CXX=""

cc_git_src=""
cc_git_branch=""

cc_wallet_type=${BLOCKwalletstaking}

cc_make_cpu_cores=2
cc_make_depends=""

cc_configure_gui_yes=''

cc_configure_gui_no=''

cc_command_pre_make=""
