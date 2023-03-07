
source $NDS_HOME/andes_ip/n22_core/syn/core_env.tcl

set NDS_PLATFORM		"$nds_platform"
set nds_core			"n22_core"

set env(core_clk_period)	20.0
set env(hclk_period)		20.0
set env(pclk_period)		20.0
set env(osch_clk_period)	20.0
set env(jdtm_clk_period)	33.0
set env(spi_clk_period)         21.0
set env(ip_def_search_path)	"$NDS_HOME/andes_ip/$NDS_PLATFORM/define $NDS_HOME/andes_ip/$NDS_PLATFORM/top/hdl/include $NDS_HOME/andes_ip/n22_core/top/hdl"

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


