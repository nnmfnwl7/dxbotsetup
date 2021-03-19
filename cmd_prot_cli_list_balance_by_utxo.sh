# list all utxos also 0 times confirmed
cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ listunspent 0 | grep -e address -e label -e amount -e confirmations
