cc_ticker="LTC"
cc_name_full="litecoin"
cc_name_prefix="litecoin"
cc_name_prefix_upper="Litecoin"
cc_instance_suffix=""

cc_port=9333
cc_rpcport=9332
cc_rpcuser="BlockDXLitecoin"

cc_cfg_add='
txindex=1
addresstype=legacy
changetype=legacy
deprecatedrpc=signrawtransaction
'

# to boost up sync with some clear net nodes
cc_nodes_clearnet='
'

# to boost up sync with some onion nodes
cc_nodes_tor='
rfbmjiezbc3xhenn.onion:7107
y4xisg75xh5rdgcr.onion:9333
kqjkde4rcms4wluw.onion:9333
oovh7ookaudj23h7.onion:9333
whcovvve6kgrfe7t.onion:9333
shxoj35dk4krxwth.onion:9333
cwqtc5unvlo7eg6h.onion:9333
ajnrrpyx4cfkbjhg.onion:9333
ltcfxb7x362h54x6.onion:9333
'

cc_export_CC=""
cc_export_CXX=""

cc_git_src_url="https://github.com/litecoin-project/litecoin.git"
cc_git_branch="origin/0.18"

cc_wallet_type=${LTCwallet}
cc_wallet_restore=${LTCwalletrestore}

cc_make_cpu_cores=2
cc_make_depends="bdb"

cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=auto'

cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=no'

cc_command_pre_make=""
