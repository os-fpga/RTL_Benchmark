
set tech_lib "name_of_target_tech_lib"
set mem_lib "prefix_for_sram_cells"
set pad_lib "name_of_pad_lib"
set pad_lib_path "/directory/of/pad_lib"
set operating_cond "op_cond_for_tech_lib"
set mem_cond "op_cond_for_sram_cells"
set tech_lib_path "/directory/of/tech_lib"
set memory_lib_path "/directory/of/sram_cells"
set loading_cell "name_of_buf_cell"
set driving_cell "name_of_buf_cell"
set dont_use_cells [list $tech_lib/SDF* $tech_lib/SEDF* $tech_lib/G* $tech_lib/*D0BWP30P140 $tech_lib/DEL* $tech_lib/CKAN2D* $tech_lib/CKBD* $tech_lib/CKLHQD* $tech_lib/CKMUX2D* $tech_lib/CKND* $tech_lib/CKND2D* $tech_lib/CKXOR2D*]
set wire_load_group "wire_load_model_selection_group"
set syn_effort "high"

set_db common_ui false
set_attribute hdl_array_naming_style "%s_%d_" /
set_attribute delete_unloaded_insts false /
set_attribute delete_flops_on_preserved_net false /
set_attribute delete_hier_insts_on_preserved_net false /
set_attribute optimize_constant_0_flops false /
set_attribute optimize_constant_1_flops false /
set_attribute optimize_constant_latches false /
set_attribute optimize_merge_flops false /
set_attribute boundary_optimize_constant_hier_pins false /
set_attribute boundary_optimize_equal_opposite_hier_pins false /
set_attribute propagate_constant_from_timing_model false /
set_attribute remove_assigns true /

set_attribute lp_insert_clock_gating true /
set_attribute lp_clock_gating_prefix $design_name /
set_attribute gen_module_prefix "${design_name}_" /
set_attribute auto_ungroup none

set_attribute hdl_undriven_signal_value 0

