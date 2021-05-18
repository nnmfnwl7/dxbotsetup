# start wallet daemon process

# TODO
#ulimit -m cc_limit_mem_res
#ulimit -m cc_limit_mem_virtual

# TODO in cycle check returns and in case try to restore chain

cc_daemon_file_path -datadir=cc_blockchain_dir_path_eval -printtoconsole -nodebuglogfile
