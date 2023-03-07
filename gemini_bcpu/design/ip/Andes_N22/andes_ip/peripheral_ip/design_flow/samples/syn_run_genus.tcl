
# Setting the Target Technology Library
set lib_path "$tech_lib_path $memory_lib_path"
if {[info exists pad_lib_path]} {
	set lib_path [concat $lib_path $pad_lib_path]
}
set_attribute lib_search_path ". $lib_path" /

set memory_lib_list [glob -nocomplain -types f -directory $memory_lib_path *_${mem_cond}.lib]
set lib_list "${tech_lib}.lib $memory_lib_list"
if {[info exists pad_lib]} {
	set lib_list [concat $lib_list ${pad_lib}.lib]
}
set_attribute library "$lib_list" /

if {[info exists dont_use_cells]} {
	foreach cell_name $dont_use_cells {
		set_attribute avoid true [find / -libcell $cell_name]
	}
}

set_attribute auto_ungroup none

# Loading the HDL Files
catch {source -verbose $ip_top/syn/flist.tcl}

if {![info exists env(ip_def_search_path)]} {
	set env(ip_def_search_path) ""
}

if {![info exists incdir]} {
	set incdir ""
}

set_attribute hdl_search_path "[get_attribute hdl_search_path /] $env(ip_def_search_path) $incdir $ip_top/hdl $ip_top/hdl/include" /

read_hdl -define $syn_define $hdl_file_list -v2001

if {[info exists load_gck_cell]} {
	puts "=== generate gck_autogen.v ==="
	source "$script_path/gck_autogen_genus.tcl"
	if {[gck_autogen "gck_autogen.v"]} {
		puts "=== load gck_autogen.v ==="
		read_hdl -define $syn_define "gck_autogen.v" -v2001
	} else {
		puts "read_design.tcl: WARNING: fail to generate gck_autogen.v ."
		puts "=== load gck.v ==="
		read_hdl -define $syn_define "$NDS_HOME/andes_ip/macro/gck.v" -v2001
	}
}


# Loading the netlist of sub-modules
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


# Performing Elaboration
if {[info exists param]} {
	set params [split $param ","]
	set param_str "{"

	foreach p $params {
		set expr [split $p "="]
		set param_str [concat $param_str "{" $expr "}"]
	} 
	set param_str [concat $param_str "}"]

	puts "elaborate parameters: $param_str"
	eval "elaborate -parameters $param_str $design_name"
} else {
	elaborate $design_name
	cd /designs/$design_name
}

if {[info exists sub_module_netlist]} {
	edit_netlist uniquify designs/$design_name
} else {
	uniquify designs/$design_name
}

# Applying Constraints
set loading_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $loading_cell match loading_cell loading_pin]
set driving_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $driving_cell match driving_cell driving_pin]

if {![llength [find / -libcell $loading_cell]]} {
        puts "Error! Can't find $loading_cell"
        puts "       Please check variable loading_cell in syn_setup_genus.tcl"
        exit
}
if ($loading_pin_exist) {
        if {![llength [filter [find / -libpin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
                puts "Error! Can't find input pin name '$loading_pin' in $loading_cell"
                puts "       Please check variable loading_cell in syn_setup_genus.tcl"
                exit
        }
        set loading_cell_pin_path [find / -libcell $loading_cell]/$loading_pin
} else {
        foreach libpin [find [find / -libcell $loading_cell] -libpin *] {
                if {[get_attribute input $libpin] == "true"} {
                        set loading_cell_pin_path $libpin;
                }
        }
}

if {![llength [find / -libcell $driving_cell]]} {
        puts "Error! Can't find $driving_cell"
        puts "       Please check variable driving_cell in syn_setup_genus.tcl"
        exit
}
if ($driving_pin_exist) {
        if {![llength [filter [find / -libpin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
                puts "Error! Can't find output pin name '$driving_pin' in $driving_cell"
                puts "       Please check variable driving_pin in syn_setup_genus.tcl"
                exit
        }
}

set load_val [expr [lindex [get_attribute capacitance $loading_cell_pin_path] 0] / 1000]

read_sdc "$ip_top/syn/${design_name}.sdc"

if {[info exists wire_load_group]} {
	set_attribute wireload_selection [find /libraries/$tech_lib -wireload_selection $wire_load_group] /
}


# Grouping the paths to improve the timing closure
if {[llength [all::all_seqs]] > 0} { 
	define_cost_group -name I2C
	define_cost_group -name C2O
	path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O
	path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C
}


# Changing names to avoid naming conflicts
if {[llength [find / -subdesign gck*]]} {
#	eval "change_names -map {{\"^gck\" \"${design_name}_gck\"}} -subdesign"
	foreach x [find / -subdesign gck*] {
		mv $x ${design_name}_[basename $x]
        }
}
if {[llength [find / -subdesign nds*]]} {
#	eval "change_names -map {{\"^nds\" \"${design_name}_nds\"}} -subdesign"
	foreach x [find / -subdesign  nds*] {
		mv $x ${design_name}_[basename $x]
	}
}
if {[llength [find / -subdesign clkmux*]]} {
#	eval "change_names -map {{\"^clkmux\" \"${design_name}_clkmux\"}} -subdesign"
	foreach x [find / -subdesign  clkmux*] {
		mv $x ${design_name}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_l2l*]]} {
#	eval "change_names -map {{\"^sync_l2l\" \"${design_name}_sync_l2l\"}} -subdesign"
	foreach x [find / -subdesign  sync_l2l*] {
		mv $x ${design_name}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_p2p*]]} {
#	eval "change_names -map {{\"^sync_p2p\" \"${design_name}_sync_p2p\"}} -subdesign"
	foreach x [find / -subdesign  sync_p2p*] {
		mv $x ${design_name}_[basename $x]
	}
}
if {[llength [find / -subdesign async_fifo*]]} {
#	eval "change_names -map {{\"^async_fifo\" \"${design_name}_async_fifo\"}} -subdesign"
	foreach x [find / -subdesign  async_fifo*] {
		mv $x ${design_name}_[basename $x]
	}
}
if {[llength [find / -subdesign sync_fifo*]]} {
#	eval "change_names -map {{\"^sync_fifo\" \"${design_name}_sync_fifo\"}} -subdesign"
	foreach x [find / -subdesign  sync_fifo*] {
		mv $x ${design_name}_[basename $x]
	}
}

report timing -lint -verbose > $report_path/timing_lint.rpt


# Preserve the netlist of the sub-modules
if {[info exists sub_module_netlist]} {
	foreach sub_design $sub_module_netlist {
		if {[llength [find / -subdesign $sub_design]] > 0} {
			set_attribute preserve true [find / -subdesign $sub_design]
			set_attribute boundary_opto false [find / -subdesign $sub_design]
		}
	}
}




# Performing Synthesis
if {"$syn_effort" == ""} {
	set SYN_EFF ""
} else {
	set SYN_EFF "-effort $syn_effort"
}

eval "synthesize -to_mapped $SYN_EFF -no_incremental"

remove_assigns_without_optimization -ignore_preserve_setting
 
for {set itr 2} {$itr <= $compile_itr} {incr itr} {
	eval "synthesize -to_mapped $SYN_EFF -incremental"
}


# Report the Synthesis Results
report clocks							>  $report_path/clocks.rpt
report clocks -generated					>> $report_path/clocks.rpt
report clock_gating						>  $report_path/clock_gating.rpt
report timing -summary -slack_limit 0 -num_paths 100		>  $report_path/timing_summary.rpt
report timing -slack_limit 0 -num_paths 1000 -full_pin_names	>  $report_path/timing.rpt
report area -depth 3						>  $report_path/area.rpt
report gates							>  $report_path/gates.rpt
report power -depth 1                                           >  $report_path/power.rpt

# Writing Out Netlist/SDC
write_hdl	>  $output_path/${design_name}.vg
write_sdc	>  $output_path/${design_name}.sdc

