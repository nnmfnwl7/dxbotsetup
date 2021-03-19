# list balance by address
cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ listaddressgroupings | grep -v -e "\[" -e "\]"
