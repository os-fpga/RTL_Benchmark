set NDS_HOME $env(NDS_HOME)

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
set nds_core n22_core
source -verbose ./core_env.tcl
source -verbose ./script/syn_env.tcl > ./log/syn_env.log

set env(NDS_PLATFORM)	"$nds_platform"

if {[string equal $env(NDS_PLATFORM) "ae250"]} {
set root_design ae250_cpu_subsystem
} else {
set root_design ae350_cpu_subsystem
}

set search_path " $search_path $tech_lib_path"

if {[info exists memory_lib_path] && [info exists mem_cond] && [file exists $memory_lib_path]} {
        set memory_list [glob -types f -directory $memory_lib_path *${mem_cond}.db]
        set search_path " $search_path $memory_lib_path"
} else {
        set memory_list ""
}

set link_library " * ${tech_lib}.db $memory_list"
set target_library " ${tech_lib}.db"
set symbol_library " ${tech_lib}.sdb"

if {[info exists dont_use_cells]} {
    set_dont_use $dont_use_cells
}

source ./script/naming_rule.tcl

### Read RTL ###

source -verbose ./script/read_design.tcl > ./log/read_design.log

### Apply budget
source -verbose ./script/clock.tcl      > ./log/clock.log
source -verbose ./script/io_delay.tcl   > ./log/io_delay.log
source -verbose ./script/group_path.tcl > ./log/group_path.log
source -verbose ./script/timing_con.tcl > ./log/timing_con.log

uniquify > ./log/uniquify.log

set_max_transition $max_trans $root_design
set_operating_conditions -lib $tech_lib $operating_cond

set_boundary_optimization [all_designs] true
set_boundary_optimization [get_designs $root_design] false

set_max_area 0
set_wire_load_mode  enclosed

set_fix_multiple_port_net -all -buffer_constants [all_designs]

#set_structure -boolean true
#set compile_new_boolean_structure true

if {![info exists compile_itr]} {
	set compile_itr 10
}

puts "tech_lib = $tech_lib"

if {[string compare "gtech" $tech_lib] == 0} {
	puts "set compile_itr 1"
	set compile_itr 1 
}

if {![info exists report_power]} {
	set report_power 0
}
puts "report_power = $report_power"
if {[file exists pf_info.tcl] && $report_power} {
        source pf_info.tcl -verbose
        if {[file exists $pf_file]} {
		if {[string compare $pf_type "saif"] == 0} {
			saif_map -start
			read_saif -auto_map_names -input $pf_file -instance_name system/ae250_chip/$root_design -verbose
			report_saif -hier -rtl_saif -missing > ./rpt/report_saif.rpt
			if {$debug_module_support && [llength [get_ports -quiet dbg_tck]]} {
				set_switching_activity [get_nets *dbg_tck] -static_probability 0.5 -toggle_rate [expr 2/$tap_clk_period] -period [expr $tap_clk_period*1000]
			}
		}
        }
}

if { $ungroup_core } {
	ungroup -flatten {n22_core_top/n22_core/u_n22_*}
	compile_ultra -gate_clock -no_seq_output_inversion -area_high_effort_script > ./log/compile.log
} else {
	compile_ultra -gate_clock -timing_high_effort_script -no_seq_output_inversion -no_autoungroup > ./log/compile.log
}

check_design > ./rpt/check_design.rpt
check_timing > ./rpt/check_timing.rpt

set itr 1
source ./script/report_timing.tcl
source ./script/report_area.tcl
source ./script/output_netlist.tcl

if {![shell_is_in_xg_mode]} {
    write -format db  -hier -o ./db/${root_design}1.db
} else {
    write -format ddc -hier -o ./ddc/${root_design}1.ddc
}

source ./script/report_worst_slack.tcl

set worst_slack [report_worst_slack]
set last_itr 1
for {set itr 2} {$itr <= $compile_itr} {incr itr} {
    puts "Current itr = $itr"
    set last_itr $itr
    
	if { $ungroup_core } {
		compile_ultra -incremental -no_seq_output_inversion  >> ./log/compile.log
		if {$itr == $compile_itr} {
			optimize_netlist -area
		}
	} else {
		compile_ultra -incremental -no_seq_output_inversion -no_autoungroup >> ./log/compile.log
	}

    set current_slack [report_worst_slack]
    puts "itr = $itr, current_slack: $current_slack worst_slack: $worst_slack" 


    source ./script/report_timing.tcl
    source ./script/report_area.tcl
    source ./script/output_netlist.tcl
    
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
}

exec date +End\ Time:\ %H:%M\ \(%D\)
exit
