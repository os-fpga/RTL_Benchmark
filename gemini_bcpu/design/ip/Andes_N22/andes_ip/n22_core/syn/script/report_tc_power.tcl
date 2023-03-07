set power_tc "./power_tc"

if {[file exists $power_tc]} {
	file delete -force $power_tc 
}
exec mkdir $power_tc 

for {set itr 1} {$itr <= $last_itr} {incr itr} {

	set outfile [open "$power_tc/${root_design}${itr}_tc.sdc" w]
	set infile  [open "./netlist/${root_design}${itr}.sdc" r]
	
	# Change corner from SS to TT in sdc 
	while {[gets $infile line] >= 0} {
		regsub -all $tech_lib $line $tech_lib_tc line
		regsub -all $operating_cond $line $operating_cond_tc line
	
		# Since command "set_dont_use" is useless for reporting power, remove this commmand to prevent errors
		if {![regexp "set_dont_use" $line]} {
			puts $outfile $line
		}
	}
	
	close $outfile
	close $infile
	
	# Remove all designs and librarys
	remove_design -all

	# Link to TT library only
	source syn_setup_dc.tcl
	if {[info exists memory_lib_path] && [info exists mem_cond_tc] && [file exists $memory_lib_path]} {
       		set memory_list [glob -types f -directory $memory_lib_path *${mem_cond_tc}.db]
       		set search_path " $search_path $memory_lib_path"
	} else {
        	set memory_list ""
	}

	set link_library   " * ${tech_lib_tc}.db $memory_list"
	set target_library " ${tech_lib_tc}.db"
	set symbol_library " ${tech_lib_tc}.sdb"

	if {[string equal $env(NDS_PLATFORM) "ae250"]} {
		set root_design ae250_cpu_subsystem
	} else {
		set root_design ae350_cpu_subsystem
	}

	read_file -format verilog -netlist ./netlist/${root_design}${itr}.vg
	
	current_design $root_design
	
	set_operating_conditions -lib $tech_lib_tc $operating_cond_tc
	
	read_sdc  "$power_tc/${root_design}${itr}_tc.sdc"

	saif_map -start
	read_saif -auto_map_names -input ./netlist/${root_design}${itr}.saif -instance_name $root_design -verbose
	
	report_power -nosplit -hierarchy -levels 3 > ./rpt/power${itr}.rpt
}

file delete -force $power_tc 
