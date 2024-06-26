
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name s6bf_2 -dir "H:/projects/s6bf_board/FPGA/ise2/planAhead_run_1" -part xc6slx45tfgg484-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "H:/projects/s6bf_board/FPGA/ise2/s6bf_board_top_cs.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {H:/projects/s6bf_board/FPGA/ise2} {User_coregen_NGC_copied} }
set_param project.pinAheadLayout  yes
set_param project.paUcfFile  "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_constraints.ucf"
add_files "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_constraints.ucf" -fileset [get_property constrset [current_run]]
add_files "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_TIMING-constraints.ucf" -fileset [get_property constrset [current_run]]
open_netlist_design
