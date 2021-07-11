cc_ticker="BTC"
cc_name_full="bitcoin"
cc_name_prefix="bitcoin"
cc_name_prefix_upper="Bitcoin"
cc_instance_suffix=""
#~ cc_cfg="bitcoin.conf"

cc_port=8333
cc_rpcport=8332
cc_rpcuser="BlockDXBitcoin"

cc_cfg_add='
txindex=1
addresstype=legacy
changetype=legacy
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
'

# to boost up sync with some onion nodes
cc_nodes_tor='
'

cc_export_CC="clang"
cc_export_CXX="clang++"

cc_git_src_url="https://github.com/bitcoin/bitcoin.git"
cc_git_branch="v0.21.1"

cc_wallet_type=${BLOCKwallet}
cc_wallet_restore=${BLOCKwalletrestore}

cc_make_cpu_cores=2
cc_make_depends="bdb"

cc_configure_gui_yes='
./configure \
LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" \
CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" \
CXXFLAGS="-O3 -march=native" \
--disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --without-zmq --with-gui=qt5
'

cc_configure_gui_no='
./configure \
LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" \
CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" \
CXXFLAGS="-O3 -march=native" \
--disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --without-zmq --with-gui=no
'

cc_command_pre_make=""
