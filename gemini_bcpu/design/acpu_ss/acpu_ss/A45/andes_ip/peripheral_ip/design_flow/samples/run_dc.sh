#! /bin/sh

if [ -d $NDS_HOME/andes_ip/kv_core ]; then
	NDS_MP_CORE_DIR="kv_core";
	NDS_SP_CORE_DIR="kv_core";
else
	NDS_MP_CORE_DIR="vcmp_core";
	NDS_SP_CORE_DIR="vc_core";
fi

#if [ `grep nds_platform $NDS_HOME/andes_ip/$NDS_SP_CORE_DIR/syn/core_env.tcl | grep -c "ae350"` != 0 ]; then
#	export NDS_PLATFORM="ae350";
#elif [ `grep nds_platform $NDS_HOME/andes_ip/$NDS_MP_CORE_DIR/syn/ae350_cpu_cluster_subsystem/syn/core_env.tcl | grep -c "ae350"` != 0 ]; then
#	export NDS_PLATFORM="ae350";
#fi

export NDS_PLATFORM="ae350"

if [ `grep NDS_BIU_BUS $NDS_HOME/andes_ip/$NDS_SP_CORE_DIR/top/hdl/config.inc | grep -c "ahb"` != 0 ]; then
	export NDS_PLATFORM_BUS="ahb";
else
	export NDS_PLATFORM_BUS="axi";
fi

if [[ $NDS_PLATFORM = "" ]]; then
	echo "ERROR! Environment variable \"NDS_PLATFORM\" must be defined before synthesis."
	exit 1
fi

ip_list="nceplmt100   nceplic100 ncejdtm200 ncepldm200 \
	 atcapbbrg100 atciic100  atcrtc100  atcgpio100   atcpit100  atcspi200 atcuart100 atcwdt200 "

	if [[ $NDS_PLATFORM_BUS = "ahb" ]] ; then
		ip_list+="atcdmac110"
	else
		ip_list+="atcdmac300"
	fi
	ip_list+=" ${NDS_PLATFORM}_chip"

# Choice the best result of AndesCore synthesis iteration
itr=`echo $NDS_PKG_IRT`
if [[ $itr = "" ]]; then
        itr=2
fi

if [ -d $NDS_HOME/andes_ip/$NDS_MP_CORE_DIR ]; then
    export CORE_SYN_PATH="$NDS_HOME/andes_ip/$NDS_MP_CORE_DIR/syn"
else
    export CORE_SYN_PATH="$NDS_HOME/andes_ip/$NDS_SP_CORE_DIR/syn"
fi
export SCRIPT_PATH="$NDS_HOME/andes_ip/peripheral_ip/design_flow/samples"

cd $SCRIPT_PATH

if [ ! -d "ip_database" ]; then
	mkdir ip_database
fi

if [ -d $NDS_HOME/andes_ip/$NDS_MP_CORE_DIR/syn/ae350_cpu_cluster_subsystem ]; then
    if [ ! -e "ip_database/${NDS_PLATFORM}_cpu_cluster_subsystem.ddc" ]; then
       cd $CORE_SYN_PATH

       if [  -d ./netlist ]; then
           rm -rf netlist
       fi
       if [  -d ./log ]; then
           rm -rf log
       fi
       if [  -d ./rpt ]; then
           rm -rf rpt
       fi
       if [  -d ./ddc ]; then
           rm -rf ddc
       fi
       if [  -d ./db ]; then
           rm -rf db
       fi
       $CORE_SYN_PATH/run_syn
       cp     $CORE_SYN_PATH/ip_database/ip_ddc/${NDS_PLATFORM}_cpu_cluster_subsystem.ddc $SCRIPT_PATH/ip_database/${NDS_PLATFORM}_cpu_cluster_subsystem.ddc
       cd $SCRIPT_PATH
    fi
else
	if [ ! -e "ip_database/ae350_cpu_subsystem.ddc" ]; then
		cd $CORE_SYN_PATH

		if [  -d ./netlist ]; then
			rm -rf netlist
		fi
		if [  -d ./log ]; then
			rm -rf log
		fi
		if [  -d ./rpt ]; then
			rm -rf rpt
		fi
		if [  -d ./ddc ]; then
			rm -rf ddc
		fi
		if [  -d ./db ]; then
			rm -rf db
		fi
		$CORE_SYN_PATH/run_syn
		cp     $CORE_SYN_PATH/ddc/ae350_cpu_subsystem$itr.ddc $SCRIPT_PATH/ip_database/ae350_cpu_subsystem.ddc
		cd $SCRIPT_PATH
	fi
fi

for ip in $ip_list; do
	# Do synthesis only when the netlist not exists
	if [ ! -e "ip_database/$ip.ddc" ]; then
		rm -rf $ip

		mkdir $ip
		cd $ip

		export DESIGN_NAME=$ip

		# Synthesis by DC
		dc_shell-t -f $SCRIPT_PATH/syn_dc.tcl | tee dc.log

		# Equivalence checking by Conformal
		lec -LP -nogui -dofile $SCRIPT_PATH/formal_lec.do

		cd ..
	fi
done

