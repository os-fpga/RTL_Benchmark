
# Setting the Target Technology Library
set lib_path "$tech_lib_path $memory_lib_path"
if {[info exists pad_lib_path]} {
	set lib_path [concat $lib_path $pad_lib_path]
}
set search_path [concat $search_path $lib_path]

set memory_lib_list [glob -nocomplain -types f -directory $memory_lib_path *_${mem_cond}.db]
set lib_list "${tech_lib}.db $memory_lib_list"
if {[info exists pad_lib]} {
	set lib_list [concat $lib_list ${pad_lib}.db]
}
set target_library "${tech_lib}.db"
set symbol_library "${tech_lib}.sdb "
set synthetic_library "dw_foundation.sldb"
set link_library "* $lib_list $synthetic_library"

if {[info exists dont_use_cells]} {
	set_dont_use $dont_use_cells
}


# Loading the HDL Files
catch {source -verbose $ip_top/syn/flist.tcl}

if {![info exists env(ip_def_search_path)]} {
	set env(ip_def_search_path) ""
}

if {![info exists incdir]} {
	set incdir ""
}

set search_path [concat $search_path $env(ip_def_search_path) $incdir $ip_top/hdl $ip_top/hdl/include]

analyze -define $syn_define -format verilog $hdl_file_list

if {[info exists load_gck_cell]} {
	puts "=== generate gck_autogen.v ==="
	source "$script_path/gck_autogen_dc.tcl"
	if {[gck_autogen "gck_autogen.v"]} {
		puts "=== load gck_autogen.v ==="
		analyze -define $syn_define -format verilog "gck_autogen.v"
	} else {
		puts "read_design.tcl: WARNING: fail to generate gck_autogen.v ."
		puts "=== load gck.v ==="
		analyze -define $syn_define -format verilog "$NDS_HOME/andes_ip/macro/gck.v"
	}
}


# Loading the DDC of sub-modules
if {[info exists sub_module_netlist]} {
	puts "Read sub-module database:"
	foreach sub_design $sub_module_netlist {
		if {[file exists "$ip_database/$sub_design.ddc"]} {
			read_ddc $ip_database/$sub_design.ddc
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
	elaborate $design_name -parameters $param
} else {
	elaborate $design_name
	current_design $design_name
}

uniquify
link


# Applying Constraints
set loading_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $loading_cell match loading_cell loading_pin]
set driving_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $driving_cell match driving_cell driving_pin]

if {![llength [find lib_cell $tech_lib/$loading_cell]]} {
        puts "ERROR! Can't find $loading_cell"
        puts "       Please check the variable loading_cell in syn_setup_dc.tcl"
        exit
}
if {$loading_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
                puts "ERROR! Can't find input pin name '$loading_pin' in $loading_cell"
                puts "       Please check the variable loading_cell in syn_setup_dc.tcl"
                exit
        }
        set loading_cell_pin_path "${tech_lib}/$loading_cell/$loading_pin"
} else {
        set loading_cell_pin_path [get_object_name [filter [find lib_pin $tech_lib/$loading_cell/*] -regexp {@port_direction == in}]]
}

if {![llength [find lib_cell $tech_lib/$driving_cell]]} {
        puts "ERROR! Can't find $driving_cell"
        puts "       Please check the variable driving_cell in file syn_setup_dc.tcl"
        exit
}
if {$driving_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
                puts "ERROR! Can't find output pin name '$driving_pin' in $driving_cell"
                puts "       Please check the variable driving_cell in syn_setup_dc.tcl"
                exit
        }
}

set load_val [load_of $loading_cell_pin_path]

source -verbose "$ip_top/syn/${design_name}.sdc"

if {[info exists sub_module_netlist]} {
	foreach sub_design $sub_module_netlist {
		set sub_design_col [get_designs -quiet $sub_design]

		if {[sizeof_collection  $sub_design_col]} {
			propagate_constraints -design $sub_design_col -multicycle_path
		}
	}
}

if {[info exists wire_load_group]} {
	set_wire_load_selection_group $wire_load_group
}


# Grouping the paths to improve the timing closure
group_path -weight 1 \
	   -name "I2C" \
	   -from [all_inputs]

group_path -weight 1 \
	   -name "C2O" \
	   -to [all_outputs]


# Changing names to avoid naming conflicts
set macro_design [get_designs -quiet {gck* nds* clkmux* sync_l2l* sync_p2p* sync_fifo* async_fifo*}]
if {[llength $macro_design]} {
	rename_design -update_links $macro_design -prefix "${design_name}_"
}

set_fix_multiple_port_nets -all [all_designs]
set_boundary_optimization [all_designs] false


# Preserve the netlist of the sub-modules
if {[info exists sub_module_netlist]} {
	foreach sub_design $sub_module_netlist {
		set sub_design_col [get_designs -quiet $sub_design]

		if {[sizeof_collection $sub_design_col]} {
			set_dont_touch $sub_design_col
		}
	}
}


# Performing Synthesis
if {"$syn_effort" == ""} {
	compile_ultra -no_seq_output_inversion -no_autoungroup
} else {
	compile_ultra -no_seq_output_inversion -no_autoungroup $syn_effort
}


define_name_rules ip_name_rule -restricted "()/\[\]{}" -replacement_char "_" -equal_ports_nets -inout_ports_equal_nets
change_names -rule ip_name_rule -hierarchy -verbose

for {set itr 2} {$itr <= $compile_itr} {incr itr} {
	compile_ultra -incremental -no_seq_output_inversion -no_autoungroup
}


# Report the Synthesis Results
check_design									>  $report_path/check_design.rpt
report_clock -nosplit								>  $report_path/clocks.rpt
report_qor									>  $report_path/qor.rpt
report_constraint -all_violators -nosplit					>  $report_path/timing_summary.rpt
report_timing -slack_lesser_than 0 -max_path 1000 -nworst 10 -nosplit		>  $report_path/timing.rpt
report_area -hierarchy								>  $report_path/area.rpt


# Writing Out Netlist/SDC
write -format verilog -hierarchy -output $output_path/${design_name}.vg
write_sdc				 $output_path/${design_name}.sdc
write -format ddc -hier -o		 $output_path/${design_name}.ddc

