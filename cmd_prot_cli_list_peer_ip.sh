# get staking status
cons=`cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getconnectioncount`
echo "wallet is connected to $cons peers"
echo "peer list:"
cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getpeerinfo | grep "\"addr\":" | grep "\."
