
if {[file exists "$NDS_HOME/andes_ip/kv_core"]} {
    set nds_mp_core_dir "kv_core"
    set nds_sp_core_dir "kv_core"
} else {
    set nds_mp_core_dir "vcmp_core"
    set nds_sp_core_dir "vc_core"
}


if {[file exists "$NDS_HOME/andes_ip/$nds_mp_core_dir/syn/ae350_cpu_cluster_subsystem/syn/core_env.tcl"]} {
    source $NDS_HOME/andes_ip/$nds_mp_core_dir/syn/ae350_cpu_cluster_subsystem/syn/core_env.tcl
    set nds_core			$nds_mp_core_dir
} elseif {[file exists "$NDS_HOME/andes_ip/$nds_sp_core_dir/syn/core_env.tcl"]} {
    source $NDS_HOME/andes_ip/$nds_sp_core_dir/syn/core_env.tcl
    set nds_core			$nds_sp_core_dir
}

set NDS_PLATFORM		"$nds_platform"

set env(core_clk_period)	20
set env(hclk_period)		20
set env(pclk_period)		20
set env(osch_clk_period)	20
set env(jdtm_clk_period)	33.0
set env(spi_clk_period)     21.0
if {[file exists "$NDS_HOME/andes_ip/$nds_mp_core_dir"]} {
    set env(ip_def_search_path)	"$NDS_HOME/andes_ip/$NDS_PLATFORM/define $NDS_HOME/andes_ip/$NDS_PLATFORM/top/hdl/include $NDS_HOME/andes_ip/$nds_mp_core_dir/top/hdl"
} else {
    set env(ip_def_search_path)	"$NDS_HOME/andes_ip/$NDS_PLATFORM/define $NDS_HOME/andes_ip/$NDS_PLATFORM/top/hdl/include $NDS_HOME/andes_ip/$nds_sp_core_dir/top/hdl"
}

set syn_define                  "NDS_SYN"

set compile_itr			2

set report_path			"rpt"
set output_path			"netlist"
set ip_database			"../ip_database"


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# DO NOT modify the following codes!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
if {[file exists "$NDS_HOME/andes_ip/$design_name"]} {
        set ip_top "$NDS_HOME/andes_ip/$design_name"
} elseif {[file exists "$NDS_HOME/andes_ip/peripheral_ip/$design_name"]} {
        set ip_top "$NDS_HOME/andes_ip/peripheral_ip/$design_name"
} elseif {[file exists "$NDS_HOME/andes_ip/soc/$design_name"]} {
        set ip_top "$NDS_HOME/andes_ip/soc/$design_name"
} else {
	set platform_name [string map {"_core" "_chip"} $design_name]

	if {[file exists "$NDS_HOME/andes_ip/$platform_name"]} {
		set ip_top "$NDS_HOME/andes_ip/$platform_name"
	} else {
		set platform_name [string map {"_core" "" "_chip" ""} $design_name]

		if {[file exists "$NDS_HOME/andes_ip/$platform_name"]} {
			set ip_top "$NDS_HOME/andes_ip/$platform_name"
		} else {
			puts "ERROR! Can not find IP \"$design_name\"."
			exit 10
		}
	}
}


