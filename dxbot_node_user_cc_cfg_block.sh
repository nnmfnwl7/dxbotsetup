cc_ticker="BLOCK"
cc_name_full="blocknet"
cc_name_prefix="blocknet"
cc_name_prefix_upper="Blocknet"
cc_instance_suffix=""
#~ cc_cfg="blocknet.conf"

cc_port=41412
cc_rpcport=41414
cc_rpcuser="BlockDXBlocknet"

cc_cfg_add='
dxnowallets=1
classic=1
staking=1
rpcworkqueue=256

#rpcxbridgetimeout - Timeout for internal XBridge RPC calls (default: 120 seconds)
# 210 seconds = 3 minutes and 30 seconds
rpcxbridgetimeout=210
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

cc_export_CC="clang"
cc_export_CXX="clang++"

cc_git_src_url="https://github.com/blocknetdx/blocknet.git"
cc_git_branch="origin/4.3.1"

cc_wallet_type=${BLOCKwallet}
cc_wallet_restore=${BLOCKwalletrestore}

cc_make_cpu_cores=2
cc_make_depends="bdb boost"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=auto'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=no'

#~ cc_configure_debug_option="--enable-debug"

cc_command_pre_make=""
