cc_ticker="PKOIN"
cc_name_full="pocketcoin"
cc_name_prefix="pocketcoin"
cc_name_prefix_upper="Pocketcoin"
cc_instance_suffix=""

cc_port=41412
cc_rpcport=41414
cc_rpcuser="BlockDXPocketcoin"

cc_cfg_add='
staking=1
blocksonly=1
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
95.217.78.168:37070
216.108.231.40:37070
188.187.45.218:37070
162.246.52.153:37070
64.235.41.74:37070
172.83.108.34:37070
98.173.46.156:37070
71.19.157.54:37070
'

# to boost up sync with some onion nodes
cc_nodes_tor='
'

cc_export_CC=""
cc_export_CXX=""

cc_git_src_url="https://github.com/pocketnetteam/pocketnet.core.git"
cc_git_branch="master"

cc_wallet_type=${PKOINwallet}

cc_make_cpu_cores=2
cc_make_depends="bdb"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/x86_64-pc-linux-gnu/lib/" CPPFLAGS="-I`pwd`/depends/x86_64-pc-linux-gnu/include/" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static CXXFLAGS="-O3 -march=native" --without-miniupnpc --without-zmq --with-gui=qt5'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/x86_64-pc-linux-gnu/lib/" CPPFLAGS="-I`pwd`/depends/x86_64-pc-linux-gnu/include/" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static CXXFLAGS="-O3 -march=native" --without-miniupnpc --without-zmq --with-gui=no'

cc_command_pre_make=""
