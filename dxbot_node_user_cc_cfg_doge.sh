cc_ticker="DOGE"
cc_name_full="dogecoin"
cc_name_prefix="dogecoin"
cc_name_prefix_upper="Dogecoin"
cc_instance_suffix=""

cc_port=22556
cc_rpcport=22555
cc_rpcuser="BlockDXDogecoin"

cc_cfg_add='
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
208.113.131.229:22556
35.138.92.19:22556
82.24.76.153:22556
76.106.229.107:22556
[2001:44b8:512d:6d00:e810:462a:7c0:c81c]:22556
'

# to boost up sync with some onion nodes
cc_nodes_tor='
'

cc_export_CC="clang"
cc_export_CXX="clang++"

cc_git_src_url="https://github.com/dogecoin/dogecoin.git"
cc_git_branch="origin/1.14-maint"

cc_wallet_type=${DOGEwallet}

cc_make_cpu_cores=2
cc_make_depends="bdb"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" CXXFLAGS="-O3 -march=native" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --without-zmq --with-gui=auto'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" CXXFLAGS="-O3 -march=native" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --without-zmq --with-gui=no'

cc_command_pre_make=""
