#!/bin/bash

# main config file name read and include
dxbot_config_file_arg=$1
if [ "${dxbot_config_file_arg}" = "" ]; then
    echo "ERROR: first parameter, which is main config file parameter can not be empty"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg}>:"

source "${dxbot_config_file_arg}"

# crypto config file name read and include
dxbot_config_file_arg_cc=$2
if [ "${dxbot_config_file_arg_cc}" = "" ]; then
    echo "ERROR: second parameter, which is cryptocurrency config file parameter can not be empty"
    exit 1
fi

if [ ! -f "${dxbot_config_file_arg_cc}" ]; then
    echo "ERROR: config file ${dxbot_config_file_arg_cc} does not exist"
    exit 1
fi

echo "using config file <${dxbot_config_file_arg_cc}>:"

source "${dxbot_config_file_arg_cc}"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> source code >> clone >> configure >> build"
while true; do
    echo ""
    read -n 1 -r -p "Press <c> to continue, <s> to skip step or <q> to exit setup process: " key
    if [ "$key" = "c" ]; then
        echo -e "\nsetup continue"
        break
    elif [ "$key" = "s" ]; then
        echo -e "\nsetup step skip"
        break
    elif [ "$key" = "q" ]; then
        echo -e "\nsetup cancelled"
        exit 1
    fi
done
echo ""

if [ "$key" = "c" ]; then
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> source code >> clone >> configure >> build >> try"
    
    export CC=${cc_export_CC}
    export CXX=${cc_export_CXX}

    # prepare directory strucure
    cd ${dxbot_dir_remote_root}
    (test $? != 0) && echo "cd ${dxbot_dir_remote_root} failed" && exit 1

    mkdir -p ${cc_name_prefix}"_src" && cd ${cc_name_prefix}"_src"
    (test $? != 0) && echo "mkdir -p ${cc_name_prefix}_src failed" && exit 1

    # clone source code and checkout branch
    git clone ${cc_git_src} ./ && git checkout ${cc_git_branch}
    if [ $? != 0 ]; then
        if [ $? == 128 ]; then
            make clean && git pull && git checkout ${cc_git_branch}
            (test $? != 0) && echo "make clean && git pull && checkout origin failed" && exit 1
        else
            echo "clone and checkout ${cc_git_src} ${cc_git_branch} source code to ${cc_name_prefix}_src failed"
            exit 1
        fi
    fi
    
    # autogen
    sh autogen.sh
    (test $? != 0) && echo "${cc_name_full} autogen script failed" && exit 1
    
    # custom pre-compile commands, ie, to fix some libraries incompatibility...
    if [ "${cc_command_pre_make}" != "" ]; then
        eval ${cc_command_pre_make}
        (test $? != 0) && echo "ERROR: custom pre make command <${cc_command_pre_make}> failed" && exit 1
    fi
    
    # build dependencies
    make -j${cc_make_cpu_cores} -C depends ${cc_make_depends}
    (test $? != 0) && echo "${cc_name_full} make dependencies failed" && exit 1
    
    cd "depends/built/" && cc_archdir=`ls` && cd ../../
    (test "${cc_archdir}" == "") && echo "get machine architecture failed" && exit 1
    
    for f in $cc_make_depends; do (tar xvzf "depends/built/"${cc_archdir}"/"${f}"/*.tar.gz" -C "./depends/"${cc_archdir}"/"); done
    (test $? != 0) && echo "blocknet extract dependencies failed" && exit 1
    
    # choose to configure build process with or without graphical user interface 
    if [ "${cc_wallet_type}" = "gui" ]; then
        eval ${cc_configure_gui_yes}
        (test $? != 0) && echo "${cc_name_full} configure script failed" && exit 1
    else
        eval ${cc_configure_gui_no}
        (test $? != 0) && echo "${cc_name_full} configure script failed" && exit 1
    fi

    # start compilation process
    make -j${cc_make_cpu_cores}
    (test $? != 0) && echo "${cc_name_full} build binary files failed" && exit 1
    
    export CC=""
    export CXX=""
    
    # mk directory for storing build binary files
    mkdir -p "./../"${cc_name_prefix}"_bin"
    (test $? != 0) && echo "${cc_name_full} create binary files dir failed" && exit 1
    
    # copy compiled command line interface and daemon wallet binaries
    cp "./src/"${cc_name_prefix}"-cli" "./../"${cc_name_prefix}"_bin" && cp "./src/"${cc_name_prefix}"d" "./../"${cc_name_prefix}"_bin"
    (test $? != 0) && echo "${cc_name_full} copy daemon and cli binary files to target dir failed" && exit 1
    
    # copy compiled graphical user interface wallet
    if [ "${cc_wallet_type}" = "gui" ]; then
        cp "./src/qt/"${cc_name_prefix}"-qt" "./../"${cc_name_prefix}"_bin" || cp "./src/"${cc_name_prefix}"-qt" "./../"${cc_name_prefix}"_bin"
        (test $? != 0) && echo "${cc_name_full} copy QT binary file to target dir failed" && exit 1
    fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name_full} >> source code >> clone >> configure >> build >> try >> success"
fi
