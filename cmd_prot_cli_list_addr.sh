# list all generated addresses, also zero balance
cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ listreceivedbyaddress 0 true | grep -e address -e label
