#### Template Script for RTL->Gate-Level Flow

if {[file exists /proc/cpuinfo]} {
	sh grep "model name" /proc/cpuinfo
	sh grep "cpu MHz"    /proc/cpuinfo
}

if {![info exists compile_itr]} {
	set compile_itr 5
}

#### Include TCL utility script_rcs..
include load_etc.tcl
#### Set up

if {![file exists log]} {
	file mkdir log
}

set nds_core		kv_core

source -verbose core_env.tcl

set PLATFORM		$nds_platform

source -verbose ./script_rc/syn_env.tcl     

set root_design		ae350_cpu_subsystem

set DESIGN		$root_design
set SYN_EFF		high
set MAP_EFF		high
set DATE		[exec date +%m%d.%H%M]
#### The following variables are used for diagnostic purposes only.
#### They do not have any effect on the results of synthesis.
#### Setting 'map_fancy_names' to 1 tells the tool to name the combinational
#### cells based on the criteria that was used when selecting them.
set map_fancy_names	1
#### Setting 'iopt_stats' to 1 prints out statistics during incremental
#### optimization.

set output_path		netlist_${DATE}
set log_path		logs_${DATE}
set report_path		reports_${DATE}
set NDS_HOME	$env(NDS_HOME)

set RTL_PATH            $NDS_HOME/andes_ip/$nds_core
set ACE_RTL_PATH        $RTL_PATH/ace/hdl
set ACE_MEM_PATH        $RTL_PATH/ace/memory/syn

set env(NDS_PLATFORM)	$PLATFORM

set tool_name		"rc"
if {[catch {get_db / .program_short_name} tool_name]} {
	set tool_name		"rc"
}
if {$tool_name == ""} {
	set tool_name		"rc"
}

if {$tool_name != "rc"} {
	set_db common_ui	false
}

source -verbose syn_setup_${tool_name}.tcl 

set PLATFORM_BUSDEC     "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/include $NDS_HOME/andes_ip/peripheral_ip/atcbusdec301/hdl/include"
set EXTRA_SEARCH_PATH   ""

if {[info exists NDS_RVV_SUPPORT]} {
    if {[string equal $NDS_RVV_SUPPORT "yes"]} {
        set rvv_support 1
    } else {
        set rvv_support 0
    }
} else {
        set rvv_support 0
}

if {[info exists NDS_FP16_SUPPORT]} {
    if {[string equal $NDS_FP16_SUPPORT "yes"]} {
        set fp16_support 1
    } else {
        set fp16_support 0
    }
} else {
        set fp16_support 0
}

if {[info exists NDS_BFLOAT16_SUPPORT]} {
    if {[string equal $NDS_BFLOAT16_SUPPORT "yes"]} {
        set bfloat16_support 1
    } else {
        set bfloat16_support 0
    }
} else {
        set bfloat16_support 0
}

if {$rvv_support} {
        set has_vpu 1
        set EXTRA_SEARCH_PATH "$EXTRA_SEARCH_PATH $NDS_HOME/andes_ip/kv_core/vpu/hdl"
} else {
        set has_vpu 0
}

if {[info exists NDS_IO_ILM_TL_UL]} {
    set has_ilm_tl_ul 1
} else {
    set has_ilm_tl_ul 0
}

if {[info exists NDS_BIU_ASYNC]} {
    set bus_async 1
} else {
    set bus_async 0
}

set_attribute hdl_language v2001
if {$tool_name == "rc"} {
	set_attribute hdl_search_path ". $NDS_HOME/andes_ip/${nds_core}/top/hdl $NDS_HOME/andes_ip/$PLATFORM/top/hdl/include $NDS_HOME/andes_ip/$PLATFORM/define $PLATFORM_BUSDEC $EXTRA_SEARCH_PATH" / 
} else {
	set_attribute init_hdl_search_path ". $NDS_HOME/andes_ip/${nds_core}/top/hdl $NDS_HOME/andes_ip/$PLATFORM/top/hdl/include $NDS_HOME/andes_ip/$PLATFORM/define $PLATFORM_BUSDEC $EXTRA_SEARCH_PATH" / 
}
set_attribute information_level 9 

if {$synthesis_upf} {
	# Enable low-power support
	set enable_ieee_18f01_support 1
	# Set Library Domain
	set library_domain_name $operating_cond
	puts "Create Library Domain ${library_domain_name} Start ..."
	create_library_domain ${library_domain_name}
	puts "Create Library Domain ${library_domain_name} Done !"
} else {
	set library_domain_name ""
}

set var_lib_search_path ". $tech_lib_path"
set var_library "${tech_lib}.lib"

if {[info exists memory_lib_path]} {
	append var_lib_search_path " $memory_lib_path"
	set memory_lib [glob -nocomplain -types f -directory $memory_lib_path *${mem_cond}.lib]
	append var_library " ${memory_lib}"
}

if {$synthesis_upf} {
	if {[file exists ./syn_setup_genus_upf.tcl]} {
		source -verbose ./syn_setup_genus_upf.tcl
	} else {
		set switch_lib_path ""
		set switch_lib ""
		set iso_lvl_lib ""
	}
	
	if {${switch_lib_path} ne ""} {
		append var_lib_search_path " ${switch_lib_path}"
	}	
	if {${switch_lib} ne ""} {
		append var_library " ${switch_lib}.lib"
	}	
	if {${iso_lvl_lib} ne ""} {
		append var_library " ${iso_lvl_lib}.lib"
	}	
}

set_attribute lib_search_path ${var_lib_search_path} / 

if {$synthesis_upf} {
	set_attribute library "${var_library}"  ${library_domain_name} /
} else {
	set_attribute library "${var_library}" /
}

if {[info exists dont_use_cells]} {
	foreach cells $dont_use_cells {
		set_attribute avoid true [find / -libcell $cells] 
	}
}

if {!$synthesis_upf} {
	set_attribute operating_conditions $operating_cond
}

##generates <signal>_reg[<bit_width>] format
#set_attribute hdl_array_naming_style %s\[%d\] /  

#### Turn on TNS, affects global and incr opto
#set_attribute endpoint_slack_opto true /

#### Power root attributes
set_attribute lp_insert_clock_gating true /

#set_attribute lp_clock_gating_prefix <string> /
#set_attribute lp_insert_operand_isolation true /
#set_attribute lp_operand_isolation_prefix <string> /
#set_attribute lp_power_analysis_effort <high> /
#set_attribute lp_power_unit mW /
#set_attribute lp_toggle_rate_unit /ns /
set_attribute hdl_track_filename_row_col true /
if {$tool_name == "genus"} {
        set_attribute leakage_power_effort low /
} else {
	set_attribute lp_multi_vt_optimization_effort low /
}

if {[info exists area_opt]} {
	if {!$area_opt} {
		set_attribute tns_opto true /
	}
} else {
	set_attribute tns_opto true /
}

set_attribute auto_ungroup none

# ns => ps
set core_clk_period [expr 1000 * $core_clk_period]
set bus_clk_period  [expr 1000 * $bus_clk_period]
# set test_clk_period [expr 1000 * $test_clk_period]

if {[info exists clock_uncertainty]} {
	set clock_uncertainty [expr 1000 * $clock_uncertainty]
}
if {[info exists apr_margin]} {
	set apr_margin [expr 1000 * $apr_margin]
}

source -verbose ./script_rc/read_design.tcl 

# ----------------------------------
# Loading the netlist of sub-modules
# ----------------------------------
if {[info exists sub_module_netlist]} {
	puts "Read sub-module netlist:"
	foreach sub_design $sub_module_netlist {
		if {[file exists "$ip_database/$sub_design.vg"]} {
			read_hdl -netlist $ip_database/$sub_design.vg
			lappend tmp_list $sub_design
		}
	}

	if {[info exists tmp_list]} {
		set sub_module_netlist $tmp_list
	} else {
		unset sub_module_netlist
	}
}

if {$synthesis_upf} {
	set upf_file "$NDS_HOME/andes_ip/kv_core/upf/sample_${root_design}.upf"
	read_power_intent -1801 ${upf_file} -module ${root_design}
}

# ----------------------
# Performing Elaboration
# ----------------------
if {[info exists param]} {
	set params [split $param ","]
	set param_str "{"

	foreach p $params {
		set expr [split $p "="]
		set param_str [concat $param_str "{" $expr "}"]
	} 
	set param_str [concat $param_str "}"]

	puts "elaborate parameters: $param_str"
	eval "elaborate -parameters $param_str $root_design"
} else {
	elaborate $root_design
	# cd /designs/$root_design
}

if {$synthesis_upf} {
	apply_power_intent
	commit_power_intent
	#report low_power_cells
	report_power_intent_instances
}

puts "Runtime & Memory after 'read_hdl'"
timestat Elaboration

if {[info exists sub_module_netlist]} {
        edit_netlist uniquify designs/$root_design
} else {
        uniquify designs/$root_design
}

# --------------------
# Applying Constraints
# --------------------
source -verbose ./script_rc/clock.tcl      
source -verbose ./script_rc/io_delay.tcl   
source -verbose ./script_rc/group_path.tcl 
source -verbose ./script_rc/timing_con.tcl 

set_timing_derate -cell_delay $synthesis_derate

set_attribute max_transition  [expr $max_trans * 1000] [find / -design *]

set_attribute wireload_mode  "enclosed"

if {$synthesis_upf} {
} else {
	if {[info exists wire_load_group]} {
		set_attribute wireload_selection [find / -wireload_selection $tech_lib/wireload_selections/$wire_load_group] /
	}
}
check_design -unresolved

puts "The number of exceptions is [llength [find /designs/$DESIGN -exception *]]"

#### PLE
##set_attribute lef_library <lef file(s)> /
##set_attribute cap_table_file <file> /
##set_attribute interconnect_mode ple / 
#set_attribute force_wireload <wireload name> "/designs/$DESIGN"

if {![file exists ${log_path}]} {
	exec mkdir ${log_path}
	puts "Creating directory ${log_path}"
}

if {![file exists ${output_path}]} {
	exec mkdir ${output_path}
	if {[file exists netlist]} {
		file delete netlist
	}
	exec ln -s ${output_path} netlist
	puts "Creating directory ${output_path}"
}

if {![file exists ${report_path}]} {
	exec mkdir ${report_path}
	if {[file exists rpt]} {
		file delete rpt
	}
	exec ln -s ${report_path} rpt
	puts "Creating directory ${report_path}"
}

# ----------------------------------------
# Changing names to avoid naming conflicts
# ----------------------------------------
if {[llength [find / -subdesign gck*]]} {
#	eval "change_names -map {{\"^gck\" \"${root_design}_gck\"}} -subdesign"
	foreach x [find / -subdesign gck*] {
		mv $x ${root_design}_[basename $x]
        }
}
if {[llength [find / -subdesign nds*]]} {
#	eval "change_names -map {{\"^nds\" \"${root_design}_nds\"}} -subdesign"
	foreach x [find / -subdesign  nds*] {
		mv $x ${root_design}_[basename $x]
	}
}
if {[llength [find / -subdesign clkmux*]]} {
#	eval "change_names -map {{\"^clkmux\" \"${root_design}_clkmux\"}} -subdesign"
	foreach x [find / -subdesign  clkmux*] {
		mv $x ${root_design}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_l2l*]]} {
#	eval "change_names -map {{\"^sync_l2l\" \"${root_design}_sync_l2l\"}} -subdesign"
	foreach x [find / -subdesign  sync_l2l*] {
		mv $x ${root_design}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_p2p*]]} {
#	eval "change_names -map {{\"^sync_p2p\" \"${root_design}_sync_p2p\"}} -subdesign"
	foreach x [find / -subdesign  sync_p2p*] {
		mv $x ${root_design}_[basename $x]
	}
}
if {[llength [find / -subdesign async_fifo*]]} {
#	eval "change_names -map {{\"^async_fifo\" \"${root_design}_async_fifo\"}} -subdesign"
	foreach x [find / -subdesign  async_fifo*] {
		mv $x ${root_design}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_fifo*]]} {
#	eval "change_names -map {{\"^sync_fifo\" \"${root_design}_sync_fifo\"}} -subdesign"
	foreach x [find / -subdesign  sync_fifo*] {
		mv $x ${root_design}_[basename $x]
	}
}

report timing -lint -verbose > $report_path/timing_lint.rpt

if {[info exists sub_module_netlist]} {
	foreach sub_design $sub_module_netlist {
		if {[llength [find / -subdesign $sub_design]] > 0} {
			set_attribute preserve true [find / -subdesign $sub_design]
			set_attribute boundary_opto false [find / -subdesign $sub_design]
		}
	}
}

#### Leakage/Dynamic power/Clock Gating setup.
#set_attribute lp_clock_gating_cell [find /lib* -libcell <cg_libcell_name>] "/designs/$DESIGN"
#set_attribute max_leakage_power 0.0 "/designs/$DESIGN"
#set_attribute lp_power_optimization_weight <value from 0 to 1> "/designs/$DESIGN"
#set_attribute max_dynamic_power 0.0 "/designs/$DESIGN"
#set_attr lp_optimize_dynamic_power_first true "/designs/$DESIGN"

#set_attribute lp_map_to_srpg_cells true "/designs/$DESIGN"
#set_attribute lp_srpg_pg_driver <driver> "/designs/$DESIGN"

# #### boundary 
# if {$tool_name == "genus"} {
# 	set_attribute boundary_opto false [find / -subdes *]
# }

if {[file exists pf_info.tcl]} {
        source pf_info.tcl -verbose
        if {[file exists $pf_file]} {
                if {[string compare $pf_type tcf] == 0} {
                        read_tcf $pf_file
                } else {
                        read_vcd -start_time $vcd_start_time -static -module [find / -design $DESIGN] -vcd_module $DESIGN $pf_file
                }
        }
}

foreach top_design [find / -subdesign *_core_top*] {
	set_attribute boundary_opto false $top_design
}

#### Synthesizing to generic 
if {$tool_name == "rc"} {
	synthesize -to_generic -eff $SYN_EFF
} else {
	set_attr syn_generic_effort $SYN_EFF /
	syn_generic
	update_clock_gate -keep_name
	set_attr lp_clock_gating_auto_path_adjust variable "/designs/$DESIGN"
}
puts "Runtime & Memory after 'synthesize -to_generic'"
timestat GENERIC

#### Synthesizing to gates
if {$tool_name == "rc"} {
	synthesize -to_mapped -eff $MAP_EFF -no_incr
} else {
	set_attr syn_map_effort $MAP_EFF /
	syn_map
}
puts "Runtime & Memory after 'synthesize -to_map -no_incr'"
timestat MAPPED

# Don't generate UNCONNECTED wires.
set_attribute write_vlog_unconnected_port_style partial /

set itr 1
source ./script_rc/report_timing.tcl -verbose
source ./script_rc/report_area.tcl -verbose

set report_power_depth 2
if {$has_vpu} {
	set report_power_depth 4
}
if {[info exists tech_lib_tc]} {
	write_tcf > ${output_path}/${DESIGN}${itr}.tcf
} else {
	report power -depth $report_power_depth > $report_path/power${itr}.rpt
}
write -m  > ${output_path}/${DESIGN}${itr}.vg
set_clk_margin $clock_uncertainty $clock_uncertainty $has_vpu $has_ilm_tl_ul $ilm_clk_ratio
set_timing_derate -cell_delay 1
write_sdc > ${output_path}/${DESIGN}${itr}.sdc
set_timing_derate -cell_delay $synthesis_derate
set_clk_margin $synthesis_margin $gck_synthesis_margin $has_vpu $has_ilm_tl_ul $ilm_clk_ratio

source -verbose ./script_rc/clock_latency.tcl

set_attr power_engine legacy /	
#### Incremental Synthesis
for {set itr 2} {$itr <= $compile_itr} {incr itr} {
	if {$tool_name == "rc"} {
		synthesize -to_mapped -eff $MAP_EFF -incr   
	} else {
		set_attr syn_opt_effort $MAP_EFF /
		syn_opt
	}
	puts "Runtime & Memory after incremental synthesis"

	timestat INCREMENTAL

	source ./script_rc/report_timing.tcl -verbose
	source ./script_rc/report_area.tcl -verbose

	if {[info exists tech_lib_tc]} {
		write_tcf > ${output_path}/${DESIGN}${itr}.tcf
	} else {
		report power -depth $report_power_depth > ${report_path}/power${itr}.rpt
	}  
	
	write -m  > ${output_path}/${DESIGN}${itr}.vg
	set_clk_margin $clock_uncertainty $clock_uncertainty $has_vpu $has_ilm_tl_ul $ilm_clk_ratio
	set_timing_derate -cell_delay 1
	write_sdc > ${output_path}/${DESIGN}${itr}.sdc
	set_timing_derate -cell_delay $synthesis_derate
	set_clk_margin $synthesis_margin $gck_synthesis_margin $has_vpu $has_ilm_tl_ul $ilm_clk_ratio
}

foreach cg [find /designs/$DESIGN -cost_group -null_ok *] {
	report timing -cost_group $cg > $report_path/[basename $cg]_post_incr.rpt
}


report clocks > $report_path/report_clocks.rpt
report clocks -generated >> $report_path/report_clocks.rpt
report port [all des inps] [all des outs] > $report_path/report_port.rpt

report clock_gating > $report_path/clockgating.rpt
report gates -power > $report_path/gates_power.rpt

#start to report tc power
if {[info exists tech_lib_tc] && $report_power} {
	source ./script_rc/report_tc_power.tcl
}

puts "Final Runtime & Memory."
timestat FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

quit
