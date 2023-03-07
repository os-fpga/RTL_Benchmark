#### Template Script for RTL->Gate-Level Flow
set NDS_HOME $env(NDS_HOME)

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

set nds_core n22_core
source -verbose core_env.tcl

set env(NDS_PLATFORM)	"$nds_platform"

if {[string equal $env(NDS_PLATFORM) "ae250"]} {
set root_design ae250_cpu_subsystem
} else {
set root_design ae350_cpu_subsystem
}

set DESIGN $root_design
set SYN_EFF high
set MAP_EFF high
set DATE [exec date +%m%d.%H%M]
#### The following variables are used for diagnostic purposes only.
#### They do not have any effect on the results of synthesis.
#### Setting 'map_fancy_names' to 1 tells the tool to name the combinational
#### cells based on the criteria that was used when selecting them.
set map_fancy_names 1
#### Setting 'iopt_stats' to 1 prints out statistics during incremental
#### optimization.

set SYN_PATH "."
set _OUTPUTS_PATH netlist_${DATE}
set _LOG_PATH logs_${DATE}
set _REPORTS_PATH reports_${DATE}

set tool_name "rc"
if {[catch {get_db / .program_short_name} tool_name]} {
	set tool_name "rc"
}
if {$tool_name == ""} {
	set tool_name "rc"
}

if {$tool_name != "rc"} {
	set_db common_ui false
}

source -verbose syn_setup_${tool_name}.tcl 

set_attribute hdl_language v2001
if {[string equal $env(NDS_PLATFORM) "ae250"]} {
	set_attribute hdl_search_path ". $NDS_HOME/andes_ip/${nds_core}/top/hdl $NDS_HOME/andes_ip/${nds_core}/ucore/hdl $NDS_HOME/andes_ip/ae250/top/hdl/include " /
} else {
	set_attribute hdl_search_path ". $NDS_HOME/andes_ip/${nds_core}/top/hdl $NDS_HOME/andes_ip/${nds_core}/ucore/hdl $NDS_HOME/andes_ip/ae350/top/hdl/include $NDS_HOME/andes_ip/ae350/define $NDS_HOME/andes_ip/peripheral_ip/atcbusdec350/hdl/include " /
}
set_attribute information_level 9 

if {[info exists memory_lib_path]} {
	set_attribute lib_search_path ". $tech_lib_path $memory_lib_path" / 
	set memory_lib [glob -nocomplain -types f -directory $memory_lib_path *${mem_cond}.lib] 
		     
	set_attribute library "${tech_lib}.lib $memory_lib" /
} else {
	set_attribute lib_search_path ". $tech_lib_path" / 
	set_attribute library "${tech_lib}.lib" /
}

if {[info exists dont_use_cells]} {
	foreach cells $dont_use_cells {
		set_attribute avoid true [find / -libcell $cells] 
	}
}

set_attribute operating_conditions $operating_cond
##generates <signal>_reg[<bit_width>] format
#set_attribute hdl_array_naming_style %s\[%d\] /  

#### Turn on TNS, affects global and incr opto
#set_attribute endpoint_slack_opto true /

#### Power root attributes
set_attribute lp_insert_clock_gating true /
set_attribute lp_insert_discrete_clock_gating_logic true

#set_attribute lp_clock_gating_prefix <string> /
#set_attribute lp_insert_operand_isolation true /
#set_attribute lp_operand_isolation_prefix <string> /
#set_attribute lp_power_analysis_effort <high> /
#set_attribute lp_power_unit mW /
#set_attribute lp_toggle_rate_unit /ns /
set_attribute hdl_track_filename_row_col true /
set_attribute lp_multi_vt_optimization_effort low /

set_attribute hdl_undriven_signal_value 0

if {[info exists area_opt]} {
	if {!$area_opt} {
		set_attribute tns_opto true /
	}
} else {
	set_attribute tns_opto true /
}

set_attribute auto_ungroup none

#ns => ps
set core_clk_period [expr 1000 * $core_clk_period]
set bus_clk_period  [expr 1000 * $bus_clk_period]
set tap_clk_period  [expr 1000 * $tap_clk_period]
#set test_clk_period [expr 1000 * $test_clk_period]

if {[info exist clock_uncertainty]} {
	set clock_uncertainty [expr 1000 * $clock_uncertainty]
}
if {[info exist apr_margin]} {
	set apr_margin [expr 1000 * $apr_margin]
}

source -verbose ./script_rc/syn_env.tcl     
source -verbose ./script_rc/read_design.tcl 

if { $ungroup_core } {
	set_attribute ungroup true [find / -hdl_arch n22_*]
	set_attribute ungroup false [find / -hdl_arch n22_core_top]
	set_attribute ungroup false [find / -hdl_arch n22_core]
	if { [llength [find / -hdl_arch n22_*_ram]] } {
	set_attribute ungroup false [find / -hdl_arch n22_*_ram]
	}
}
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
timestat Elaboration

source -verbose ./script_rc/clock.tcl      
source -verbose ./script_rc/io_delay.tcl   
source -verbose ./script_rc/group_path.tcl 
source -verbose ./script_rc/timing_con.tcl 

set_attribute max_transition  [expr $max_trans * 1000] [find / -design *]

set_attribute wireload_mode  "enclosed"

if {[info exists wire_load_group]} {
	set_attribute wireload_selection [find / -wireload_selection $tech_lib/wireload_selections/$wire_load_group] /
}
check_design -unresolved

puts "The number of exceptions is [llength [find /designs/$DESIGN -exception *]]"

#### PLE
##set_attribute lef_library <lef file(s)> /
##set_attribute cap_table_file <file> /
##set_attribute interconnect_mode ple / 
#set_attribute force_wireload <wireload name> "/designs/$DESIGN"

if {![file exists ${_LOG_PATH}]} {
	exec mkdir ${_LOG_PATH}
	puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_OUTPUTS_PATH}]} {
	exec mkdir ${_OUTPUTS_PATH}
	if {[file exists netlist]} {
		file delete netlist
	}
	exec ln -s ${_OUTPUTS_PATH} netlist
	puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
	exec mkdir ${_REPORTS_PATH}
	if {[file exists rpt]} {
		file delete rpt
	}
	exec ln -s ${_REPORTS_PATH} rpt
	puts "Creating directory ${_REPORTS_PATH}"
}

report timing -lint -verbose > $_REPORTS_PATH/timing_lint.rpt

#### Leakage/Dynamic power/Clock Gating setup.
#set_attribute lp_clock_gating_cell [find /lib* -libcell <cg_libcell_name>] "/designs/$DESIGN"
#set_attribute max_leakage_power 0.0 "/designs/$DESIGN"
#set_attribute lp_power_optimization_weight <value from 0 to 1> "/designs/$DESIGN"
set_attribute max_dynamic_power 0.0 "/designs/$DESIGN"
#set_attr lp_optimize_dynamic_power_first true "/designs/$DESIGN"

#set_attribute lp_map_to_srpg_cells true "/designs/$DESIGN"
#set_attribute lp_srpg_pg_driver <driver> "/designs/$DESIGN"

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

#### Synthesizing to generic 
if {$tool_name == "rc"} {
	synthesize -to_generic -eff $SYN_EFF
} else {
	set_attr syn_generic_effort $SYN_EFF /
	syn_generic
}
puts "Runtime & Memory after 'synthesize -to_generic'"
timestat GENERIC

#### Synthesizing to gates
if {$tool_name == "rc"} {
	synthesize -to_mapped -eff $MAP_EFF -no_incr
} else {
	set_attr syn_map_effort $SYN_EFF /
	syn_map
}
puts "Runtime & Memory after 'synthesize -to_map -no_incr'"
timestat MAPPED

set itr 1
source ./script_rc/report_timing.tcl -verbose
source ./script_rc/report_area.tcl -verbose

if {[info exists tech_lib_tc]} {
	write_tcf > ${_OUTPUTS_PATH}/${DESIGN}${itr}.tcf
} else {
	report power -depth 2 > $_REPORTS_PATH/power${itr}.rpt
}
write -m  > ${_OUTPUTS_PATH}/${DESIGN}${itr}.vg
set_clk_margin $clock_uncertainty $clock_uncertainty $debug_module_support 
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}${itr}.sdc
set_clk_margin $synthesis_margin $gck_synthesis_margin $debug_module_support 

source -verbose ./script_rc/clock_latency.tcl

#### Incremental Synthesis
for {set itr 2} {$itr <= $compile_itr} {incr itr} {
	if {$tool_name == "rc"} {
#		if { $ungroup_core } {
#			set_attribute retime true [find / -hdl_arch n22_core]
#		}
	synthesize -to_mapped -eff $MAP_EFF -incr   
	} else {
		set_attr syn_map_effort $SYN_EFF /
		syn_opt
	}
	puts "Runtime & Memory after incremental synthesis"

	timestat INCREMENTAL

	source ./script_rc/report_timing.tcl -verbose
	source ./script_rc/report_area.tcl -verbose

	if {[info exists tech_lib_tc]} {
		write_tcf > ${_OUTPUTS_PATH}/${DESIGN}${itr}.tcf
	} else {
		report power -depth 2 > ${_REPORTS_PATH}/power${itr}.rpt
	}  
	
	write -m  > ${_OUTPUTS_PATH}/${DESIGN}${itr}.vg
	set_clk_margin $clock_uncertainty $clock_uncertainty $debug_module_support
	write_sdc > ${_OUTPUTS_PATH}/${DESIGN}${itr}.sdc
	set_clk_margin $synthesis_margin $gck_synthesis_margin $debug_module_support
}

foreach cg [find / -cost_group -null_ok *] {
	report timing -cost_group $cg > $_REPORTS_PATH/[basename $cg]_post_incr.rpt
}


report clocks > $_REPORTS_PATH/report_clocks.rpt
report port [all des inps] [all des outs] > $_REPORTS_PATH/report_port.rpt

report clock_gating > $_REPORTS_PATH/clockgating.rpt
report gates -power > $_REPORTS_PATH/gates_power.rpt

#start to report tc power
if {[info exists tech_lib_tc]} {
	source ./script_rc/report_tc_power.tcl
}

puts "Final Runtime & Memory."
timestat FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

quit
