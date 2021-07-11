#~ cc_ticker="BLOCK"
#~ cc_name_full="blocknet"
#~ cc_name_prefix="blocknet"
#~ cc_instance_suffix="staking"

# difference beetween root path and instance root path is >>
# >> in root path are binaries
# >> in instance root path are specific scripts for instance 
if [ "${cc_root_path_main}" == "" ]; then
    cc_root_path_main=${dxbot_dir_remote_root}"/"${cc_name_prefix}
    echo "gen cc root path >> "${cc_root_path_main}
fi

if [ "${cc_root_path_instance}" == "" ]; then
    cc_root_path_instance=${cc_root_path_main}${cc_instance_suffix}
    echo "gen cc instance root path >> "${cc_root_path_instance}
fi

if [ "${cc_firejail_profile_dir_path_eval}" == "" ]; then
    cc_firejail_profile_dir_path_eval=${cc_root_path_instance}"/firejail"
    echo "gen cc firejail profile dir path >> "${cc_firejail_profile_dir_path_eval}
fi

if [ "${cc_name_prefix_uppper}" == "" ]; then
    cc_name_prefix_uppper=${cc_name_prefix}
    echo "gen upper prefix >> "${cc_name_prefix_uppper}
fi

if [ "$cc_blockchain_dir_path_eval" == "" ]; then
    cc_blockchain_dir_path_eval=${HOME}"/."${cc_name_prefix}${cc_instance_suffix}
    echo "gen blockchain directory path >> "${cc_blockchain_dir_path_eval}
fi

if [ "$cc_cfg" == "" ]; then
    cc_cfg=${cc_name_prefix}".conf"
    echo "gen config file name >> "${cc_cfg}
fi

#~ cc_port=41412
#~ cc_rpcport=41414

if [ "$cc_rpcuser" == "" ]; then
    cc_rpcuser="BlockDX"${cc_name_prefix}
    echo "gen config rpc user >> "${cc_rpcuser}
fi

#~ cc_cfg_add='
#~ '

# to boost up sync with some clear net nodes
#~ cc_nodes_clearnet='
#~ '

# to boost up sync with some onion nodes
#~ cc_nodes_tor='
#~ '

if [ "$cc_blockchain_dir_path_noteval" == "" ]; then
    cc_blockchain_dir_path_noteval='${HOME}'"/."${cc_name_prefix}${cc_instance_suffix}
    echo "gen chain dir path >> "${cc_blockchain_dir_path_noteval}
fi

if [ "$cc_cfg_file_path_noteval" == "" ]; then
    cc_cfg_file_path_noteval=${cc_blockchain_dir_path_noteval}"/"${cc_cfg}
    echo "gen cfg file path >> "${cc_cfg_file_path_noteval}
fi

if [ "$cc_qt_cfg_dir_path_noteval" == "" ]; then
    cc_qt_cfg_dir_path_noteval='${HOME}'"/.config/"${cc_name_prefix_upper}
    echo "gen qt cfg file path >> "${cc_qt_cfg_dir_path_noteval}
fi

if [ "$cc_src_dir_path_eval" == "" ]; then
    cc_src_dir_path_eval=${cc_root_path_main}"/src"
    echo "gen source code path >> "${cc_src_dir_path_eval}
fi

if [ "$cc_bin_dir_path_eval" == "" ]; then
    cc_bin_dir_path_eval=${cc_root_path_main}"/bin"
    echo "gen binary path >> "${cc_bin_dir_path_eval}
fi

if [ "$cc_daemon_file_path_eval" == "" ]; then
    cc_daemon_file_path_eval=${cc_bin_dir_path_eval}"/"${cc_name_prefix}"d"
    echo "gen daemon binary path >> "${cc_daemon_file_path_eval}
fi

if [ "$cc_cli_file_path_eval" == "" ]; then
    cc_cli_file_path_eval=${cc_bin_dir_path_eval}"/"${cc_name_prefix}"-cli"
    echo "gen cli binary path >> "${cc_cli_file_path_eval}
fi

if [ "$cc_qt_file_path_eval" == "" ]; then
    cc_qt_file_path_eval=${cc_bin_dir_path_eval}"/"${cc_name_prefix}"-qt"
    echo "gen daemon binary path >> "${cc_qt_file_path_eval}
fi

if [ "$cc_cli_cmd_list_dir_path_eval" == "" ]; then
    cc_cli_cmd_list_dir_path_eval=${cc_root_path_instance}"/cmd"
    echo "gen cmd list path >> "${cc_cli_cmd_list_dir_path_eval}
fi

if [ "$cc_daemon_firejail_profile_path_eval" == "" ]; then
    cc_daemon_firejail_profile_path_eval=${cc_firejail_profile_dir_path_eval}"/"${cc_name_prefix}${cc_instance_suffix}".d.profile"
    echo "gen firejail daemon profile file name >> "${cc_daemon_firejail_profile_path_eval}
fi

if [ "$cc_qt_firejail_profile_path_eval" == "" ]; then
    cc_qt_firejail_profile_path_eval=${cc_firejail_profile_dir_path_eval}"/"${cc_name_prefix}${cc_instance_suffix}".qt.profile"
    echo "gen firejail qt profile file name >> "${cc_qt_firejail_profile_path_eval}
fi

if [ "$cc_cli_firejail_profile_path_eval" == "" ]; then
    cc_cli_firejail_profile_path_eval=${cc_firejail_profile_dir_path_eval}"/"${cc_name_prefix}${cc_instance_suffix}".cli.profile"
    echo "gen firejail cli profile file name >> "${cc_cli_firejail_profile_path_eval}
fi

if [ "$cc_make_firejail_profile_path_eval" == "" ]; then
    cc_make_firejail_profile_path_eval=${cc_firejail_profile_dir_path_eval}"/"${cc_name_prefix}${cc_instance_suffix}".make.profile"
    echo "gen firejail cli profile file name >> "${cc_make_firejail_profile_path_eval}
fi

if [ "$cc_limit_mem_res" == "" ]; then
    cc_limit_mem_res="unlimited"
    echo "gen memory limit >> "${cc_limit_mem_res}
fi

if [ "$cc_limit_mem_virtual" == "" ]; then
    cc_limit_mem_virtual="unlimited"
    echo "gen virtual memory limit >> "${cc_limit_mem_virtual}
fi

if [ ${sshtoraccess} = "sshtoraccessyes" ] || [ ${torwallet} = "torwalletyes" ] || [ ${torhswallet} = "torhswalletyes" ]; then
    if [ "$cc_proxychains_bin" == "" ]; then
        cc_proxychains_bin="proxychains4"
        echo "gen proxychains binary >> "${cc_proxychains_bin}
    fi
else
    cc_proxychains_bin=
fi

#~ cc_export_CC="clang"
#~ cc_export_CXX="clang++"

#~ cc_git_src_url="https://github.com/blocknetdx/blocknet.git"
#~ cc_git_branch="origin/4.3.1"

#~ cc_wallet_type=${BLOCKwallet}

#~ cc_make_cpu_cores=2
#~ cc_make_depends="bdb boost"

if [ "${cc_configure_debug_option}" == "" ]; then
    cc_configure_debug_option="--enable-debug"
    echo "gen debug option >> "${cc_configure_debug_option}
fi

#~ cc_configure_gui_yes='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=auto'

#~ cc_configure_gui_no='./configure LDFLAGS="-L`pwd`/depends/${cc_archdir}/lib/" CPPFLAGS="-I`pwd`/depends/${cc_archdir}/include/" --with-boost-libdir=`pwd`/depends/${cc_archdir}/lib/ --disable-bench --disable-gui-tests --disable-tests --enable-reduce-exports --enable-static --with-gui=no'

#~ cc_command_pre_make=""
