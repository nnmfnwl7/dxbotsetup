# list all utxos also 0 times confirmed
cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval listunspent 0 | grep -e address -e label -e amount -e confirmations
