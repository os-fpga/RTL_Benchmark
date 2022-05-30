
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name s6bf_2 -dir "H:/projects/s6bf_board/FPGA/ise2/planAhead_run_1" -part xc6slx45tfgg484-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property top s6bf_board_top $srcset
set_param project.paUcfFile  "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_constraints.ucf"
set hdlfile [add_files [list {User_Sources/iodrp_mcb_controller.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/iodrp_controller.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_aurora_pkg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/pcie_bram_s6.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/mcb_soft_calibration.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/gtpa1_dual_wrapper_tile.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_valid_data_counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_storage_switch_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_storage_mux.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_storage_count_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_storage_ce_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_sideband_output.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_rx_ll_deframer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_output_switch_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_output_mux.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_left_align_mux.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_left_align_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/pcie_brams_s6.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/mcb_soft_calibration_top.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/gtpa1_dual_wrapper.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_tx_ll_datapath.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_tx_ll_control.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_transceiver_tile.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_sym_gen.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_sym_dec.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_rx_ll_pdu_datapath.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_rx_ll_nfc.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_lane_init_sm.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_idle_and_ver_gen.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_error_detect.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_chbond_count_dec.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_channel_init_sm.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_channel_error_detect.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/pcie_bram_top_s6.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/mcb_raw_wrapper.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/gtpa1_dual_wrapper_top.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_tx_ll.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_transceiver_wrapper.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_rx_ll.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_global_logic.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_aurora_lane.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/pcie.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/memc3_wrapper.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/memc3_infrastructure.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/fifo_generator_v6_1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/blk_mem_gen_v4_1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_standard_cc_module.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_reset_logic.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_clock_module.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/xilinx_pcie2wb.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/pll_for_adc.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/op2p_host_wb_if.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/memco.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/dsp_instr_buffer.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/dcm_for_ioclk_dsp_s6bf.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/aurora_8b10b_v5_1_example_des_modified.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/adc_interface.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/s6bfip_pcie.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/s6bfip_memory.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/s6bfip_dsp.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/s6bfip_adc.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/op2p.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {User_Sources/s6bf_board_top.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_constraints.ucf" -fileset [get_property constrset [current_run]]
add_files "H:/projects/s6bf_board/FPGA/ise2/User_Constraints/s6bf_board_TIMING-constraints.ucf" -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx45tfgg484-2
