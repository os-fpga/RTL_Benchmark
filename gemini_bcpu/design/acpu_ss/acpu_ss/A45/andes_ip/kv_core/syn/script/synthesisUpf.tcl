set upf_file "$NDS_HOME/andes_ip/kv_core/upf/sample_${root_design}.upf"
set ram_insts [get_object_name [get_cells * -hierarchical -filter "is_macro_cell==true"]]
puts "# ram_insts: $ram_insts"
set subsystem_ram_insts ""
set core_ram_insts ""
foreach ram_inst $ram_insts {
	if {[regexp {.*u_kv_core_top[0-9]/} $ram_inst] != 0} {
		lappend core_ram_insts [regsub {.*u_kv_core_top[0-9]/} $ram_inst ""]
	} else {
		lappend subsystem_ram_insts $ram_inst
	}
}
set core_ram_insts [lsort -unique $core_ram_insts]
set subsystem_ram_insts [lsort -unique $subsystem_ram_insts]
puts "# core_ram_insts: $core_ram_insts"
puts "# subsystem_ram_insts: $subsystem_ram_insts"

load_upf -strict_check true ${upf_file} > ./log/load_upf.log
set_voltage ${main_power_voltage}  -object_list {PD_SUBSYSTEM.primary.power  PD_SUBSYSTEM.SS_CORE0.power  PD_CORE0.primary.power}
set_voltage ${main_ground_voltage} -object_list {PD_SUBSYSTEM.primary.ground PD_SUBSYSTEM.SS_CORE0.ground PD_CORE0.primary.ground}

