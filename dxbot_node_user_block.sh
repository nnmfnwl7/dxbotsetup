cc_ticker="BLOCK"
cc_name="blocknet"
cc_name_upper="Blocknet"
cc_blockchain_dir=${HOME}"/.blocknet"
cc_cfg="blocknet.conf"

cc_port=41412
cc_rpcport=41414
cc_rpcuser="BlockDXBlocknet"

cc_cfg_add='
dxnowallets=1
classic=1
staking=1
rpcworkqueue=256
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
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
ukouz7bipuady23p.onion:41412
3sy7at64ykn7jxeb.onion:41412
fnfzzmvzqngjia3p.onion:41412
'

cc_firejail_profile_d=${cc_name}"d.profile"
cc_firejail_profile_qt=${cc_name}"-qt.profile"
cc_firejail_profile_cli=${cc_name}"-cli.profile"
cc_firejail_profile_make=${cc_name}"make.profile"

cc_export_CC="clang"
cc_export_CXX="clang++"

cc_git_src="https://github.com/blocknetdx/blocknet.git"
cc_git_branch="origin/4.3.2"

cc_wallet_type=${BLOCKwallet}

cc_make_cpu_cores=2
cc_make_depends="bdb boost"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=auto'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=no'
