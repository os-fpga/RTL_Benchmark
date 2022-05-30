#####################################################################################
# Copyright (C) 1991-2007 Altera Corporation
# Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
# support information,  device programming or simulation file,  and any other
# associated  documentation or information  provided by  Altera  or a partner
# under  Altera's   Megafunction   Partnership   Program  may  be  used  only
# to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
# other  use  of such  megafunction  design,  netlist,  support  information,
# device programming or simulation file,  or any other  related documentation
# or information  is prohibited  for  any  other purpose,  including, but not
# limited to  modification,  reverse engineering,  de-compiling, or use  with
# any other  silicon devices,  unless such use is  explicitly  licensed under
# a separate agreement with  Altera  or a megafunction partner.  Title to the
# intellectual property,  including patents,  copyrights,  trademarks,  trade
# secrets,  or maskworks,  embodied in any such megafunction design, netlist,
# support  information,  device programming or simulation file,  or any other
# related documentation or information provided by  Altera  or a megafunction
# partner, remains with Altera, the megafunction partner, or their respective
# licensors. No other licenses, including any licenses needed under any third
# party's intellectual property, are provided herein.
#####################################################################################

#####################################################################################
# Altera Triple-Speed Ethernet Megacore SDC file for use with the Quartus II 
# TimeQuest Timing Analyzer
#
# To add this SDC file to your Quartus II project execute the following TCL 
# command in the Quartus II TCL console:
# set_global_assignment -name SDC_FILE esoc_port_mac_constraints.sdc
#
# Generated on Mon Nov 18 12:35:31 CET 2013
#
#####################################################################################


#Create clocks for each PLL output clocks

#Constrain MAC control interface clock
create_clock -period "66 MHz" -name clk_to_the_esoc_port_mac [ get_keepers  clk]

#Constrain MAC FIFO data interface clocks
create_clock -period "100 MHz" -name ff_tx_clk_to_the_esoc_port_mac [ get_keepers ff_tx_clk]
create_clock -period "100 MHz" -name ff_rx_clk_to_the_esoc_port_mac [ get_keepers ff_rx_clk]


#Constrain MAC network-side interface clocks
create_clock -period "125 MHz" -name tx_clk_to_the_esoc_port_mac [ get_keepers tx_clk]
create_clock -period "125 MHz" -name rx_clk_to_the_esoc_port_mac [ get_keepers rx_clk]


derive_pll_clocks


#Cut the timing path betweeen unrelated clock domains
set_clock_groups -exclusive -group {clk_to_the_esoc_port_mac } -group {ff_tx_clk_to_the_esoc_port_mac ff_rx_clk_to_the_esoc_port_mac rx_clk_to_the_esoc_port_mac tx_clk_to_the_esoc_port_mac}
set_clock_groups -exclusive -group {ff_rx_clk_to_the_esoc_port_mac} -group {clk_to_the_esoc_port_mac ff_tx_clk_to_the_esoc_port_mac rx_clk_to_the_esoc_port_mac tx_clk_to_the_esoc_port_mac}
set_clock_groups -exclusive -group {ff_tx_clk_to_the_esoc_port_mac} -group {clk_to_the_esoc_port_mac ff_rx_clk_to_the_esoc_port_mac rx_clk_to_the_esoc_port_mac tx_clk_to_the_esoc_port_mac}
set_clock_groups -exclusive -group {rx_clk_to_the_esoc_port_mac} -group {clk_to_the_esoc_port_mac ff_tx_clk_to_the_esoc_port_mac ff_rx_clk_to_the_esoc_port_mac tx_clk_to_the_esoc_port_mac}
set_clock_groups -exclusive -group {tx_clk_to_the_esoc_port_mac} -group {clk_to_the_esoc_port_mac ff_tx_clk_to_the_esoc_port_mac ff_rx_clk_to_the_esoc_port_mac rx_clk_to_the_esoc_port_mac}


#Constrain timing for half duplex logic
set_multicycle_path -setup 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*] -to [ get_keepers *]
set_multicycle_path -setup 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*] -to [ get_keepers *]
set_multicycle_path -setup 5 -from [ get_keepers *] -to [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*]
set_multicycle_path -setup 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|half_duplex_ena_reg2] -to [ get_keepers *]
set_multicycle_path -hold 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*] -to [ get_keepers *]
set_multicycle_path -hold 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*] -to [ get_keepers *]
set_multicycle_path -hold 5 -from [ get_keepers *] -to [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*]
set_multicycle_path -hold 5 -from [ get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|half_duplex_ena_reg2] -to [ get_keepers *]
set_max_delay 7 -from [get_registers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|dout_reg_sft*] -to [get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*]
set_max_delay 7 -from [get_registers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|eop_sft*] -to [get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*]
set_max_delay 7 -from [get_registers *|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|sop_reg*] -to [get_keepers *|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*]

