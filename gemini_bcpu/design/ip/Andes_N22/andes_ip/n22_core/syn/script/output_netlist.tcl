change_names -rules nds_core_rule -hierarchy
change_names -rules nds_core_rule_2 -hierarchy

write -format verilog -hierarchy -output ./netlist/${root_design}${itr}.vg
write_sdc ./netlist/${root_design}${itr}.sdc

if {[file exists pf_info.tcl] && $report_power} {
        if {[file exists $pf_file]} {
		if {[string compare $pf_type "saif"] == 0} {
			write_saif -output ./netlist/${root_design}${itr}.saif
		}
        }
}

if {![shell_is_in_xg_mode]} {
    write -format db  -hier -o ./db/${root_design}${itr}.db
} else {
    write -format ddc -hier -o ./ddc/${root_design}${itr}.ddc
}
