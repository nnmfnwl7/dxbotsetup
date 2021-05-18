# unlock wallet for staking only
cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval walletpassphrase "$(read -sp "pwd" undo; echo $undo;undo=)" 9999999999
