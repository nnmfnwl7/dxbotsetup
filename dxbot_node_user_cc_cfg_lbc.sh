cc_ticker="LBC"
cc_name_full="lbry"
cc_name_prefix="lbrycrd"
cc_name_prefix_upper="LBRY"
cc_instance_suffix=""

cc_port=9246
cc_rpcport=9245
cc_rpcuser="BlockDXLbrycredits"

cc_cfg_add='
txindex=1
addresstype=legacy
changetype=legacy
deprecatedrpc=signrawtransaction
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
212.102.60.88:9246
217.182.194.134:9246
47.75.9.191:9246
51.81.47.19:9246
47.91.158.151:9246
109.236.88.24:9246
'

# to boost up sync with some onion nodes
cc_nodes_tor='
'

#~ cc_export_CC="clang"
#~ cc_export_CXX="clang++"

cc_git_src_url="https://github.com/lbryio/lbrycrd.git"
cc_git_branch="origin/v17_master"

cc_wallet_type=${LBCwallet}

cc_make_cpu_cores=2
cc_make_depends="bdb boost"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ CXXFLAGS="-O3 -march=native" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --with-gui=auto'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ CXXFLAGS="-O3 -march=native" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --without-miniupnpc --with-gui=no'

cc_command_pre_make='
(cat "src/httpserver.cpp" | grep "#include <deque>") || sed -i -e "/#include <future>/ a #include <deque>" src/httpserver.cpp;
(cat "src/qt/trafficgraphwidget.cpp" | grep "#include <QPainterPath>") || sed -i -e "/#include <QPainter>/ a #include <QPainterPath>" src/qt/trafficgraphwidget.cpp
'
