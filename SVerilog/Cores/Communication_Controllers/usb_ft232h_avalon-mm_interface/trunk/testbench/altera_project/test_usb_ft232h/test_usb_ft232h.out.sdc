## Generated SDC file "test_usb_ft232h.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.1.2 Build 203 01/18/2017 SJ Lite Edition"

## DATE    "Thu Apr  6 13:43:18 2017"

##
## DEVICE  "EP4CE22E22C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLOCK_IN} -period 61.035 -waveform { 0.000 30.517 } [get_ports {CLOCK_IN}]
create_clock -name {USB_CLK} -period 16.666 -waveform { 0.000 8.333 } [get_ports {USB_CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {inst1|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 25 -divide_by 4 -master_clock {inst|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst1|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {inst1|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {inst1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 25 -divide_by 4 -phase -90.000 -master_clock {inst|altpll_component|auto_generated|pll1|clk[0]} [get_pins {inst1|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 125 -divide_by 128 -master_clock {CLOCK_IN} [get_pins {inst|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {USB_CLK}] -rise_to [get_clocks {USB_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {USB_CLK}] -fall_to [get_clocks {USB_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {USB_CLK}] -rise_to [get_clocks {USB_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {USB_CLK}] -fall_to [get_clocks {USB_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -physically_exclusive -group [get_clocks {USB_CLK}] 
set_clock_groups -logically_exclusive -group [get_clocks {CLOCK_IN}] 
set_clock_groups -logically_exclusive -group [get_clocks {inst|altpll_component|auto_generated|pll1|clk[0]}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_3f9:dffpipe22|dffe23a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_0f9:dffpipe13|dffe14a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_2f9:dffpipe14|dffe15a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_1f9:dffpipe5|dffe6a*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_oci_break:the_sopc_cpu_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_oci_debug:the_sopc_cpu_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr[33]}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_oci_debug:the_sopc_cpu_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr[0]}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_oci_debug:the_sopc_cpu_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr[34]}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_ocimem:the_sopc_cpu_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_tck:the_sopc_cpu_cpu_debug_slave_tck|*sr*}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_sysclk:the_sopc_cpu_cpu_debug_slave_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_debug_slave_wrapper:the_sopc_cpu_cpu_debug_slave_wrapper|sopc_cpu_cpu_debug_slave_sysclk:the_sopc_cpu_cpu_debug_slave_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*sopc_cpu_cpu:*|sopc_cpu_cpu_nios2_oci:the_sopc_cpu_cpu_nios2_oci|sopc_cpu_cpu_nios2_oci_debug:the_sopc_cpu_cpu_nios2_oci_debug|monitor_go}]


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

