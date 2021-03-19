# unlock wallet for staking only
cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ walletpassphrase "$(read -sp "pwd" undo; echo $undo;undo=)" 9999999999 true
