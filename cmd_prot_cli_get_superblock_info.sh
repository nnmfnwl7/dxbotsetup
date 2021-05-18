# get superblock info
nextsuperblock=`cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval nextsuperblock`
blockcount=`cc_cli_file_path_eval -datadir=cc_blockchain_dir_path_eval getblockcount`
days=$(expr $( expr $nextsuperblock - $blockcount) / 1440)
echo "actual block count is $blockcount and next superblock is $nextsuperblock so it is about $days days to next superblock"
