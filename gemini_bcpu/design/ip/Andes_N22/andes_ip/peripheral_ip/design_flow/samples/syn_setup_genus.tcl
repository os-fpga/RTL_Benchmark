
set tech_lib tcbn28hpcbwp12t35p140ssg0p81v0c
set mem_lib hsspt28c
set pad_lib tphn28hpcgv18essg0p81v1p62v0c
set pad_lib_path /pseudopath/tphn28hpcgv18e_120a
set operating_cond ssg0p81v0c
set mem_cond N40CSSG0P81
set tech_lib_path /pseudopath/tcbn28hpcbwp12t35p140_100a
set memory_lib_path /pseudopath/hsspt28c/lib
set loading_cell BUFFD4BWP12T35P140
set driving_cell BUFFD4BWP12T35P140
set dont_use_cells [list tcbn28hpcbwp12t35p140ssg0p81v0c/SDF* tcbn28hpcbwp12t35p140ssg0p81v0c/SDF* tcbn28hpcbwp12t35p140ssg0p81v0c/SEDF* tcbn28hpcbwp12t35p140ssg0p81v0c/G* tcbn28hpcbwp12t35p140ssg0p81v0c/*D0BWP12T35P140 tcbn28hpcbwp12t35p140ssg0p81v0c/DEL* tcbn28hpcbwp12t35p140ssg0p81v0c/CKAN2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKBD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKLHQD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKLNQD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKMUX2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKND* tcbn28hpcbwp12t35p140ssg0p81v0c/CKND2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKXOR2D* ]
set wire_load_group WireAreaForZero
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

