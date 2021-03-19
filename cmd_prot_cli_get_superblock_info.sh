# get superblock info
nextsuperblock=`cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ nextsuperblock`
blockcount=`cd cli_dir && ./cli_bin -datadir=$HOME/.blockchain_dir/ getblockcount`
days=$(expr $( expr $nextsuperblock - $blockcount) / 1440)
echo "actual block count is $blockcount and next superblock is $nextsuperblock so it is about $days days to next superblock"
