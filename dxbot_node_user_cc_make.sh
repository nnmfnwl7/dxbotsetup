#!/bin/bash

source "dxbot_cfg.sh"

cfgfile=$1
if [ "$cfgfile" = "" ] ; then
    echo "ERROR: first parameter must point to wallet configuration file"
    echo "EXAMPLE: bash bash ./dxbot_node_user_cc_make.sh dxbot_node_user_block.sh"
    exit 1
fi

if [ ! -f "$cfgfile" ]; then
    echo "ERROR: config file ${cfgfile} does not exist"
    exit 1
fi

echo "using config file <${cfgfile}>"

source "${cfgfile}"

########################################################################
echo ""
echo "##################################################################"
echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> clone source code from git >> build binary files from source code"
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
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> source code >> clone >> configure >> build >> try"
    
    export CC=${cc_export_CC}
    export CXX=${cc_export_CXX}

    cd ${dxbot_dir_remote_root}
    (test $? = 0) || (echo "cd ${dxbot_dir_remote_root} failed" && exit 1)

    mkdir -p ${cc_name}"_src" && cd ${cc_name}"_src"
    (test $? = 0) || (echo "mkdir -p ${cc_name}_src failed" && exit 1)

    git clone ${cc_git_src} ./ && git checkout ${cc_git_branch}
    if [ $? != 0 ]; then
        if [ $? == 128 ]; then
            make clean && git pull && git checkout ${cc_git_branch}
            (test $? = 0) || (echo "make clean && git pull && checkout origin failed" && exit 1)
        else
            echo "clone and checkout ${cc_git_src} ${cc_git_branch} source code to ${cc_name}_src failed"
            exit 1
        fi
    fi
    
    sh autogen.sh
    (test $? = 0) || (echo "${cc_name} autogen script failed" && exit 1)
    
    make -j${cc_make_cpu_cores} -C depends ${cc_make_depends}
    (test $? = 0) || (echo "${cc_name} make dependencies failed" && exit 1)
    
    cd "depends/built/" && cc_archdir=`ls` && cd ../../
    (test "${cc_archdir}" == "") && (echo "get machine architecture failed"; exit 1)
    
    for f in $cc_make_depends; do (tar xvzf "depends/built/"${cc_archdir}"/"${f}"/*.tar.gz" -C "./depends/"${cc_archdir}"/"); done
    (test $? = 0) || (echo "blocknet extract dependencies failed" && exit 1)
    
    if [ "${cc_wallet_type}" = "gui" ]; then
        eval ${cc_configure_gui_yes}
        (test $? = 0) || (echo "${cc_name} configure script failed" && exit 1)
    else
        eval ${cc_configure_gui_no}
        (test $? = 0) || (echo "${cc_name} configure script failed" && exit 1)
    fi

    make -j${cc_make_cpu_cores}
    (test $? = 0) || (echo "${cc_name} build binary files failed" && exit 1)
    
    export CC=""
    export CXX=""
    
    mkdir -p "./../"${cc_name}"_bin"
    (test $? = 0) || (echo "${cc_name} create binary files dir failed" && exit 1)
    
    cp "./src/"${cc_name}"-cli" "./../"${cc_name}"_bin" && cp "./src/"${cc_name}"-clid" "./../"${cc_name}"_bin"
    (test $? = 0) || (echo "${cc_name} copy daemon and cli binary files to target dir failed" && exit 1)
    
    if [ "${cc_wallet_type}" = "gui" ]; then
        cp "./src/qt/"${cc_name}"-qt" "./../"${cc_name}"_bin"
        (test $? = 0) || (echo "${cc_name} copy QT binary file to target dir failed" && exit 1)
    fi
    
    echo "# ${0} >> ${nodeuser1}@${nodealias} >> ${cc_name} >> source code >> clone >> configure >> build >> try >> success"
fi
