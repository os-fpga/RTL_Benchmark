
set power_tc "./power_tc"

if {[file exists $power_tc]} {
	file delete -force $power_tc 
}
exec mkdir $power_tc 


for {set itr 1} {$itr <= $compile_itr} {incr itr} {

	#modify $tech_lib in power_wc.sdc to $tech_lib_tc
	set outfile [open "$power_tc/${DESIGN}${itr}_tc.sdc" w]
	set infile  [open "$output_path/${DESIGN}${itr}.sdc" r]
	
	while {[gets $infile line] >= 0} {
		regsub -all $tech_lib $line $tech_lib_tc line
		regsub -all $operating_cond $line $operating_cond_tc line
	
		#since command "set_dont_use" is useless for reporting power, remove this commmand to prevent errors
		if {![regexp "set_dont_use" $line]} {
			puts $outfile $line
		}
	}
	
	
	close $outfile
	close $infile
	
	reset_design
	
	rm /designs/*

	set var_tc_lib_search_path ". $tech_lib_path"
	set var_tc_library "${tech_lib_tc}.lib"
	
	if {[info exists memory_lib_path]} {
		append var_tc_lib_search_path " $memory_lib_path"
		set tc_memory_lib [glob -nocomplain -types f -directory $memory_lib_path *${mem_cond_tc}.lib]
		append var_tc_library " ${tc_memory_lib}"
	}

	if {$synthesis_upf} {
		if {[file exists ./syn_setup_genus_upf.tcl]} {
			source -verbose ./syn_setup_genus_upf.tcl
		} else {
			set switch_lib_path ""
			set switch_lib_tc ""
			set iso_lvl_lib_tc ""
		}
		
		if {${switch_lib_path} ne ""} {
			append var_tc_lib_search_path " ${switch_lib_path}"
		}	
		if {${switch_lib_tc} ne ""} {
			append var_tc_library " ${switch_lib_tc}.lib"
		}	
		if {${iso_lvl_lib_tc} ne ""} {
			append var_tc_library " ${iso_lvl_lib_tc}.lib"
		}	
	}


	set_attribute lib_search_path ${var_tc_lib_search_path} / 
	if {$synthesis_upf} {
		set_attribute library "${var_tc_library}"  ${library_domain_name} /
	} else {
		set_attribute library "${var_tc_library}" /
		set_attribute operating_conditions [find /libraries/${tech_lib_tc} -operating_condition ${operating_cond_tc}]
	}
	
	set_attr power_engine legacy
	read_netlist ${output_path}/${DESIGN}${itr}.vg
	if {[file exists pf_info.tcl]} {
		read_tcf     ${output_path}/${DESIGN}${itr}.tcf
	}
	read_sdc     ${power_tc}/${DESIGN}${itr}_tc.sdc
	set_attr power_engine joules
	
	report power -by_hierarchy -levels 3 > $report_path/power${itr}.rpt
	# file delete -force ${output_path}/${DESIGN}${itr}.tcf
}

file delete -force $power_tc 
