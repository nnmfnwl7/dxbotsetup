# start wallet daemon process
cd d_dir && ./d_bin -datadir=$HOME/.blockchain_dir/ walletpassphrase "$(read -sp "pwd" undo; echo $undo;undo=)" 9999999999 true

# TODO in cycle check returns and in case try to restore chain
