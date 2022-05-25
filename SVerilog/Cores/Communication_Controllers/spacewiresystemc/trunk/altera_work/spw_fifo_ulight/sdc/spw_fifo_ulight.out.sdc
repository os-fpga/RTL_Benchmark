## Generated SDC file "/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/sdc/spw_fifo_ulight.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.1 Internal Build 593 12/11/2017 SJ Lite Edition"

## DATE    "Sat Feb  3 17:13:42 2018"

##
## DEVICE  "5CSEMA4U23C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {FPGA_CLK1_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {FPGA_CLK1_50}]
create_clock -name {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i} -period 10.000 -waveform { 0.000 5.000 } [get_registers { clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i }]
create_clock -name {din_a} -period 4.000 -waveform { 0.000 2.000 } [get_ports { din_a }]
create_clock -name {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i} -period 2.500 -waveform { 0.000 1.250 } [get_registers { clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i }]
create_clock -name {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e} -period 4.000 -waveform { 0.000 2.000 } [get_registers { spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e }]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} -source [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|refclkin}] -duty_cycle 50/1 -multiply_by 16 -divide_by 2 -master_clock {FPGA_CLK1_50} [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]}] 
create_generated_clock -name {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk} -source [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -master_clock {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_fsm_m:tx_fsm|tx_dout_e}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|aux_pb}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|*}]
set_false_path -from [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|rx_resetn}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|*}]
set_false_path -from [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|enable_tx}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

