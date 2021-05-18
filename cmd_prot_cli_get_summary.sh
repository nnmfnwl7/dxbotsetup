# get staking status
echo "WALLET:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getwalletinfo | grep balance
echo "STAKING:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getstakinginfo | grep -e ":"
echo "NETWORK:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getnettotals | grep totalbytes
echo "BLOCK COUNT:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getblockcount
echo "CONNECTIONS:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getconnectioncount
echo "BANNED:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval listbanned
echo "PEERS:"; cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getpeerinfo | grep "\"addr\"" | grep "\."

