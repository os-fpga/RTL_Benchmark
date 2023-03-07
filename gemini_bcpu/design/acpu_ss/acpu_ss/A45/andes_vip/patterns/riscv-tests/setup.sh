#!/bin/sh

CORE_LIST=(\
	'vcmp_core' \
	'vc_core'\
	'kv_core'\
	)

for i in ${!CORE_LIST[@]}; do
	if [[ -f $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc ]]; then
		length=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc   | grep 'define\s.*ISA_BASE\s'            | sed 's|[^0-9]||g')
		rvc=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc      | grep 'define\s.*RVC_SUPPORT\s'         | grep "yes")
		rva=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc      | grep 'define\s.*RVA_SUPPORT\s'         | grep "yes")
		rvf=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc      | grep 'define\s.*FPU_TYPE\s'            | grep -e "[sd]p")
		rvd=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc      | grep 'define\s.*FPU_TYPE\s'            | grep "dp")
		s_mode=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc   | grep 'define\s.*NUM_PRIVILEGE_LEVEL\s' | sed 's|[^0-9]||g')
		ilm_size=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc | grep 'define\s.*ILM_SIZE_KB\s'         | sed 's|[^0-9]||g')
		mmu=$(cat $NDS_HOME/andes_ip/${CORE_LIST[$i]}/top/hdl/config.inc      | grep 'define\s.*MMU_SCHEME\s'          | grep "sv")
		break;
	fi
done

cmd="./configure";

if [[ $length == "32" ]]; then
	cmd="${cmd} --with-xlen=32"
fi

if [[ $ilm_size -ne 1024 ]]; then
	cmd="${cmd} --with-ilm-size=$ilm_size"
fi

if [[ -n $rvc ]]; then
	cmd="${cmd} --enable-rvc=yes"
fi

if [[ -n $rva ]]; then
	cmd="${cmd} --enable-rva=yes"
fi

if [[ -n $rvf ]]; then
	cmd="${cmd} --enable-rvf=yes"
fi

if [[ -n $rvd ]]; then
	cmd="${cmd} --enable-rvd=yes"
fi

if [[ $s_mode == "3" ]]; then
	cmd="${cmd} --enable-s-mode=yes"
fi

if [[ -n $mmu ]]; then
	cmd="${cmd} --enable-mmu=yes"
fi

echo $cmd
$cmd
make setup
