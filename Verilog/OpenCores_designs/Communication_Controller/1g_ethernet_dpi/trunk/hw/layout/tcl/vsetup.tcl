
create_project project_n1 ./ -part xc7k325tffg900-2

set obj [get_projects project_n1]

set_property "board_part" "xilinx.com:kc705:part0:1.2" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "sim.ip.auto_export_scripts" "1" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "Verilog" $obj
set_property "target_simulator" "ModelSim" $obj

add_files -norecurse ../xdc/project_n1_b.sdc 
add_files -norecurse ../xdc/project_n1_p.sdc 
add_files -norecurse ../xdc/project_n1_t.sdc 
add_files -norecurse ../xdc/project_n1_user_phytiming.xdc 

add_files -norecurse ../../src/rtl/microb_top.v 
add_files -norecurse ../../src/rtl/tri_mode_emac_support/tri_mode_ethernet_mac_0_clk_wiz.v 
add_files -norecurse ../../src/rtl/tri_mode_emac_support/tri_mode_ethernet_mac_0_example_design_clocks.v 
add_files -norecurse ../../src/rtl/tri_mode_emac_support/tri_mode_ethernet_mac_0_example_design_resets.v 
add_files -norecurse ../../src/rtl/tri_mode_emac_support/common/tri_mode_ethernet_mac_0_reset_sync.v 
add_files -norecurse ../../src/rtl/tri_mode_emac_support/common/tri_mode_ethernet_mac_0_sync_block.v 

set_property "ip_repo_paths"  "../../src/rtl" $obj
update_ip_catalog

import_files -norecurse ../bd/base_microblaze_design.bd
export_ip_user_files -of_objects  [get_files  ./project_n1.srcs/sources_1/bd/bd/base_microblaze_design.bd] -force -quiet

set obj [get_filesets sources_1]
set_property "top" "microb_top" $obj

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# derive BD-files
generate_target all [get_files  ./project_n1.srcs/sources_1/bd/bd/base_microblaze_design.bd]
# derive xci-src
export_ip_user_files -of_objects [get_files ./project_n1.srcs/sources_1/bd/bd/base_microblaze_design.bd] -no_script -force -quiet
# derive sim-scripts
export_simulation -of_objects [get_files ./project_n1.srcs/sources_1/bd/bd/base_microblaze_design.bd] -directory ./project_n1.ip_user_files/sim_scripts -force -quiet

close_project
