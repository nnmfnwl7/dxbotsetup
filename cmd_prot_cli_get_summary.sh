# get staking status
cd cli_dir || exit 1
echo "WALLET:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getwalletinfo | grep balance
echo "STAKING:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getstakinginfo | grep -e ":"
echo "NETWORK:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getnettotals | grep totalbytes
echo "BLOCK COUNT:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getblockcount
echo "CONNECTIONS:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getconnectioncount
echo "BANNED:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ listbanned
echo "PEERS:"; ./cli_bin-cli -datadir=$HOME/.blockchain_dir/ getpeerinfo | grep "\"addr\"" | grep "\."

