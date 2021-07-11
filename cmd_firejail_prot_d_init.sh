# initialize wallet daemon sandboxing by firejail

cd {cc_cli_cmd_list_dir_path_eval}

firejail --name=ccnode_{cc_name_prefix}_{cc_instance_suffix} --profile={cc_daemon_firejail_profile_path_eval} \
bash ./cmd_firejail_{cc_name_prefix}{cc_instance_suffix}_d_init.cfg $@
