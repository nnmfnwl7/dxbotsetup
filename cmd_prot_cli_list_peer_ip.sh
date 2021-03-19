# get staking status
cons=`cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ getconnectioncount`
echo "wallet is connected to $cons peers"
echo "peer list:"
cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ getpeerinfo | grep "\"addr\":" | grep "\."
