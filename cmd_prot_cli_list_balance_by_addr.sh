# list balance by address
cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval listaddressgroupings | grep -v -e "\[" -e "\]"
