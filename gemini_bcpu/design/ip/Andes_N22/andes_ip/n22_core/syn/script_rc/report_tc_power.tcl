
set power_tc "./power_tc"

if {[file exists $power_tc]} {
	file delete -force $power_tc 
}
exec mkdir $power_tc 


for {set itr 1} {$itr <= $compile_itr} {incr itr} {

	#modify $tech_lib in power_wc.sdc to $tech_lib_tc
	set outfile [open "$power_tc/${DESIGN}${itr}_tc.sdc" w]
	set infile  [open "$_OUTPUTS_PATH/${DESIGN}${itr}.sdc" r]
	
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
	
	set_attribute lib_search_path ". $tech_lib_path $memory_lib_path" /
	set memory_lib [glob -nocomplain -types f -directory $memory_lib_path *${mem_cond_tc}.lib]
	set_attribute library "${tech_lib_tc}.lib $memory_lib" /
	
	set_attribute operating_conditions [find /libraries/${tech_lib_tc} -operating_condition ${operating_cond_tc}]
	
	read_netlist ${_OUTPUTS_PATH}/${DESIGN}${itr}.vg
	read_tcf     ${_OUTPUTS_PATH}/${DESIGN}${itr}.tcf
	read_sdc     ${power_tc}/${DESIGN}${itr}_tc.sdc
	
	report power -depth 3 > $_REPORTS_PATH/power${itr}.rpt
	# file delete -force ${_OUTPUTS_PATH}/${DESIGN}${itr}.tcf
}

file delete -force $power_tc 
