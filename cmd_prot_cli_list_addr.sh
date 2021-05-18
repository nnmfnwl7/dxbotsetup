# list all generated addresses, also zero balance
cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval listreceivedbyaddress 0 true | grep -e address -e label
