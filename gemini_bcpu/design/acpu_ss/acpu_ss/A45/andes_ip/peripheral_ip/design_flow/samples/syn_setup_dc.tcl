
set tech_lib "name_of_target_tech_lib"
set mem_lib "prefix_of_sram_cells"
set pad_lib "name_of_pad_lib"
set pad_lib_path "/directory/of/pad_lib"
set operating_cond "op_cond_for_tech_lib"
set mem_cond "op_cond_for_sram"
set tech_lib_path "/directory/of/tech_lib"
set memory_lib_path "/directory/of/sram_cells"
set loading_cell "name_of_buf_cell"
set driving_cell "name_of_buf_cell"

set dont_use_cells [list $tech_lib/SDF* $tech_lib/SEDF* $tech_lib/G* $tech_lib/*D0BWP30P140 $tech_lib/DEL* $tech_lib/CKAN2D* $tech_lib/CKBD* $tech_lib/CKLHQD* $tech_lib/CKMUX2D* $tech_lib/CKND* $tech_lib/CKND2D* $tech_lib/CKXOR2D*]
set wire_load_group "wire_load_model_selection_group"
set syn_effort "high"

set compile_preserve_subdesign_interfaces "true"
set compile_seqmap_propagate_constants "false"
set verilogout_no_tri "true"
set verilogout_show_unconnected_pins "false"

define_design_lib work -path work
