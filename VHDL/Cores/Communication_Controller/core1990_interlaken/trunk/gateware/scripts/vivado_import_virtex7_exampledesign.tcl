#
#	File import script for the core1990 interlaken hdl project
#	

source vivado_import_virtex7.tcl

# ----------------------------------------------------------
# Example design files
# ----------------------------------------------------------
read_vhdl -library work $proj_dir/sources/example/core1990_test.vhd
read_vhdl -library work $proj_dir/sources/example/data_generator.vhd
read_vhdl -library work $proj_dir/sources/example/pipeline.vhd

# ----------------------------------------------------------
# Example design IP cores
# ----------------------------------------------------------
import_ip $proj_dir/sources/ip_cores/ILA_Data.xci
import_ip $proj_dir/sources/ip_cores/vio_0.xci

# ----------------------------------------------------------
# finish project initilization
# ----------------------------------------------------------
upgrade_ip [get_ips]

read_xdc -verbose $proj_dir/constraints/Core1990_Constraints.xdc
read_xdc -verbose $proj_dir/constraints/debug_probes.xdc
set_property target_constrs_file $proj_dir/constraints/debug_probes.xdc [current_fileset -constrset]

set_property top Interface_Test [current_fileset]

# ----------------------------------------------------------
# Example design testbench
# ----------------------------------------------------------
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $proj_dir/simulation/testbench_interlaken_interface_behav.wcfg
add_files -fileset sim_1 -norecurse $proj_dir/simulation/Core1990_Test_tb.vhd

puts "INFO: Done!"

