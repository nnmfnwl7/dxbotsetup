# initialize wallet console interface sandboxing by firejail

cd cc_cli_cmd_list_dir_path_eval

firejail --profile=cc_cli_firejail_profile_path_eval bash ./cmd_firejail_{cc_name_prefix}{cc_instance_suffix}_cli_init.cfg $@
