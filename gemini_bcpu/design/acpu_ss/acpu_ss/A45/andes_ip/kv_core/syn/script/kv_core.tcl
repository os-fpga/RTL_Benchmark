#### Template Script for the Synthesis Flow
set suppress_errors [list ABS-351 TIM-179 TIM-250]

# Get environment settings.
source -verbose ./core_env.tcl

set NDS_HOME	$env(NDS_HOME)
set PLATFORM		$nds_platform
set nds_core		kv_core

set RTL_PATH		$NDS_HOME/andes_ip/$nds_core
set ACE_RTL_PATH        $RTL_PATH/ace/hdl
set ACE_MEM_PATH        $RTL_PATH/ace/memory/syn

set env(NDS_PLATFORM)	$PLATFORM

#set compile_delete_unloaded_sequential_cells false
#set compile_seqmap_propagate_constants false


### Check out license
set license_flag [get_license HDL-Compiler]
while {!$license_flag}  {
    exec sleep 10
    set license_flag [get_license HDL-Compiler]
}

set license_flag [get_license DC-Ultra-Opt]
while {!$license_flag}  {
    exec sleep 10
    set license_flag [get_license DC-Ultra-Opt]
}

if {[regexp {2005} $sh_product_version] == 1} {
    set_ultra_optimization true
}

set license_flag [get_license DesignWare]
while {!$license_flag}  {
    exec sleep 10
    set license_flag [get_license DesignWare]
}

#MultiCore Flow
#set_app_var disable_multicore_resource_checks true

set cpu_info [exec cpuinfo | head -n 1]
set core_num [lindex $cpu_info 2]

echo "Number of Cores: $core_num"

if {$core_num > 4} {
    set_host_options -max_cores 4
} else {
    set_host_options -max_cores [expr $core_num - 1]
}

report_host_options

#make dir
foreach dir { work ddc db rpt log netlist } {
        if {![file exists $dir]} {
                file mkdir $dir
        }
}

exec date +Start\ Time:\ %H:%M\ \(%D\)
# When following script has error, use -echo to debug
### Synthesis Environment Setting ###
source -verbose ./syn_setup_dc.tcl > ./log/syn_setup_dc.log

source -verbose ./script/syn_env.tcl > ./log/syn_env.log

source ./script/parseConfig.tcl
parseConfig config.inc

if {![info exists root_design] || ![string equal $root_design "kv_core_top"]} {
        set chip_design ae350_chip
	set root_design ae350_cpu_subsystem
}


set search_path " $search_path $tech_lib_path"

if {[info exists memory_lib_path] && [info exists mem_cond] && [file exists $memory_lib_path]} {
        set memory_list [glob -types f -directory $memory_lib_path *${mem_cond}.db]
        set search_path " $search_path $memory_lib_path"
} else {
        set memory_list ""
}

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
        set EXTRA_SEARCH_PATH "$EXTRA_SEARCH_PATH $RTL_PATH/vpu/hdl"
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

# Include path for AE350 should be placed before include paths for
# individual IPs. This ordering rule guarantees that the config file
# specialized for the platform is used instead of the one for individual IP.
set search_path "$search_path ."
set search_path "$search_path $NDS_HOME/andes_ip/${nds_core}/top/hdl"
set search_path "$search_path $NDS_HOME/andes_ip/$PLATFORM/top/hdl/include"
set search_path "$search_path $NDS_HOME/andes_ip/$PLATFORM/define"
set search_path "$search_path $PLATFORM_BUSDEC"
set search_path "$search_path $EXTRA_SEARCH_PATH"

set link_library " * ${tech_lib}.db $memory_list"
set target_library " ${tech_lib}.db"
set symbol_library " ${tech_lib}.sdb"

if {$synthesis_upf} {
	set_app_var enable_golden_upf true
	set_app_var upf_create_implicit_supply_sets true
	if {[file exists ./syn_setup_dc_upf.tcl]} {
		source -verbose ./syn_setup_dc_upf.tcl >> ./log/syn_setup_dc.log
	} else {
		set switch_lib_path ""
		set switch_lib ""
		set iso_lvl_lib ""
	}
	
	if {${switch_lib_path} ne ""} {
		append search_path " ${switch_lib_path}"
	}	
	if {${switch_lib} ne ""} {
		append link_library " ${switch_lib}.db"
		append target_library " ${switch_lib}.db"
	}	
	if {${iso_lvl_lib} ne ""} {
		append link_library " ${iso_lvl_lib}.db"
		append target_library " ${iso_lvl_lib}.db"
	}	
}

if {[info exists dont_use_cells]} {
    set_dont_use $dont_use_cells
}

source ./script/naming_rule.tcl

### Read RTL ###

source -verbose ./script/read_design.tcl > ./log/read_design.log

### Apply budget
source -verbose -echo ./script/clock.tcl      > ./log/clock.log
source -verbose -echo ./script/io_delay.tcl   > ./log/io_delay.log
source -verbose -echo ./script/group_path.tcl > ./log/group_path.log
source -verbose -echo ./script/timing_con.tcl > ./log/timing_con.log

set_timing_derate -cell_delay $synthesis_derate

#uniquify > ./log/uniquify.log

# ----------------------------------------
# Changing names to avoid naming conflicts
# ----------------------------------------
set macro_design [get_designs -quiet {gck* nds* clkmux* sync_l2l* sync_p2p* sync_fifo* async_fifo*}]
if {[llength $macro_design]} {
	rename_design -update_links $macro_design -prefix "${root_design}_"
}

set_max_transition $max_trans $root_design
set_operating_conditions -lib $tech_lib $operating_cond

set_boundary_optimization [all_designs] true
#set_boundary_optimization [get_designs $root_design] false

set_max_area 0
set_wire_load_mode  enclosed

set_fix_multiple_port_net -all -buffer_constants [all_designs]

#set_structure -boolean true
#set compile_new_boolean_structure true

if {![info exists compile_itr]} {
	set compile_itr 10
}

puts "tech_lib = $tech_lib"

if {$synthesis_upf} {
	source -verbose ./script/synthesisUpf.tcl > ./log/synthesisUpf.log
}

if {[string compare "gtech" $tech_lib] == 0} {
	puts "set compile_itr 1"
	set compile_itr 1 
}

if {![info exists report_power]} {
	set report_power 0
}
puts "report_power = $report_power"
if {[file exists pf_info.tcl]} {
        source pf_info.tcl -verbose
        if {[file exists $pf_file]} {
		if {[string compare $pf_type "saif"] == 0} {
			saif_map -start
			read_saif -auto_map_names -input $pf_file -instance_name system/$chip_design/$root_design -verbose
			report_saif -hier -rtl_saif -missing > ./rpt/report_saif.rpt
		}
        }
}

if {[info exists elaborate_only]} {
    check_timing > ./rpt/check_timing.rpt
	check_design > ./rpt/check_design.rpt
	exit
}


#   check_timing > ./rpt/check_timing_pre.rpt
#	check_design > ./rpt/check_design_pre.rpt

set_ideal_network [get_ports *core_reset*]
## Bottom-up optimization for VPU
if {[info exists vpu_bottom_up]} {
    set instance_list [list [get_cells $VPU_MODULE/gen_vp_frontend.frontend] \
                            [get_cells $VPU_MODULE/gen_lane.lane_top0]]

    characterize -constraints $instance_list > ./log/characterize.log

    set design_list [list [get_designs kv_vp_frontend*] \
                          [get_designs kv_lane_top]]

    foreach_in_collection design_unit $design_list {
#       To get Design Name (String) with get_attribute
        set subdesign [get_attribute [get_designs $design_unit] full_name]
        current_design $subdesign
        set_port_fanout 5 [all_outputs]
        puts "Compiling $subdesign"
        puts "Start Compiling (itr 1) $subdesign"
        exec date +Start\ Time:\ %H:%M\ \(%D\) > ./log/compile_${subdesign}.log
        compile_ultra -gate_clock -no_seq_output_inversion -no_autoungroup >> ./log/compile_${subdesign}.log
        report_constraint -all_violators -nosplit > ./rpt/timing_summary_${subdesign}_0.rpt
        report_timing -max_path 50 -net -cap -nworst 3 > ./rpt/timing_${subdesign}_0.rpt

#        puts "Start Compiling (itr 2) $subdesign"
#        compile_ultra -incremental -no_seq_output_inversion -no_autoungroup >> ./log/compile_${subdesign}.log
#        report_constraint -all_violators -nosplit > ./rpt/timing_summary_${subdesign}_1.rpt
#        report_timing -max_path 50 -net -cap -nworst 3 > ./rpt/timing_${subdesign}_1.rpt

        write_sdc  ./netlist/${subdesign}.sdc
        set_dont_touch $subdesign true  >> ./log/compile_${subdesign}.log
        exec date +End\ Time:\ %H:%M\ \(%D\) >> ./log/compile_${subdesign}.log
        puts "Compiling $subdesign done"
    }
}

current_design $root_design
compile_ultra -gate_clock -timing_high_effort_script -no_seq_output_inversion -no_autoungroup > ./log/compile.log

check_design > ./rpt/check_design.rpt
check_timing > ./rpt/check_timing.rpt

set itr 1
source ./script/report_timing.tcl
source ./script/report_area.tcl

reset_timing_derate
source ./script/output_netlist.tcl
set_timing_derate -cell_delay $synthesis_derate

#write -format db  -hier -o ./db/${root_design}1.db
write -format ddc -hier -o ./ddc/${root_design}1.ddc

if {$synthesis_upf} {
	save_upf -include_supply_exceptions -supplemental ./netlist/${root_design}1.upf
}

source ./script/report_worst_slack.tcl

set worst_slack [report_worst_slack]

set last_itr 1
for {set itr 2} {$itr <= $compile_itr} {incr itr} {
    puts "Current itr = $itr"
    set last_itr $itr
    
    if {$itr == $compile_itr} {
        if {[info exists vpu_bottom_up]} {
            echo "Start final run for bottom up optimization." >> ./log/compile.log
            set_dont_touch kv_vp_frontend false
            set_dont_touch kv_lane_top false
            puts "Compiling with -top option"
            exec date +Start\ Time:\ %H:%M\ \(%D\) > ./log/compile_top.log
            compile_ultra -top                    >> ./log/compile_top.log
#            compile        -top                    >> ./log/compile_top.log
            exec date +End\ Time:\ %H:%M\ \(%D\)  >> ./log/compile_top.log
#            compile_ultra -incremental -no_seq_output_inversion -no_autoungroup >> ./log/compile.log
        } else {
            compile_ultra -incremental -gate_clock -no_seq_output_inversion -no_autoungroup >> ./log/compile.log
        }
    } else {
        compile_ultra -incremental -gate_clock -no_seq_output_inversion -no_autoungroup >> ./log/compile.log
    }

    set current_slack [report_worst_slack]
    puts "itr = $itr, current_slack: $current_slack worst_slack: $worst_slack" 

    source ./script/report_timing.tcl
    source ./script/report_area.tcl
    reset_timing_derate
    source ./script/output_netlist.tcl
    set_timing_derate -cell_delay $synthesis_derate
    
    report_resource -hierarchy > rpt/resource${itr}.rpt

    if {$current_slack > $worst_slack} {
	puts "worst_slack is updated from $worst_slack to $current_slack"
        set worst_slack $current_slack
    } else {
	puts "DC synthesis is end at itr = $itr."
        break
    }
}

report_clock -nosplit > ./rpt/report_clocks.rpt
report_port -verbose -nosplit > ./rpt/report_port.rpt

report_transitive_fanout -clock_tree > ./rpt/clock_fanout${compile_itr}.rpt
report_clock_gating -structure > ./rpt/clockgating.rpt

if {[string compare "gtech" $tech_lib] == 0 } {
    file mkdir gtech
    change_names -rules verilog
    write -out ./gtech/${root_design}.gtech -hier -format verilog
    write_sdc  ./gtech/${root_design}.sdc
}

if {[info exists tech_lib_tc] && $report_power} {
	set link_library " * ${tech_lib_tc}.db $memory_list"
	set target_library " ${tech_lib_tc}.db"
	set symbol_library " ${tech_lib_tc}.sdb"
	source ./script/report_tc_power.tcl
}

for {incr itr} {$itr <= $compile_itr} {incr itr} {
	file delete ./rpt/area${itr}.rpt
	file delete ./netlist/${root_design}${itr}.vg
	file delete ./netlist/${root_design}${itr}.sdc
	file delete ./netlist/${root_design}${itr}.saif
	file delete ./db/${root_design}${itr}.db
	file delete ./ddc/${root_design}${itr}.ddc
	if {[file exists $upf_file]} {
		file delete ./netlist/${root_design}${itr}.upf
	}
}

if {[file exists ./script/gck_autogen.v]} {
    source ./script/report_gated_ffs.tcl
}

exec date +End\ Time:\ %H:%M\ \(%D\)
exit
