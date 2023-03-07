# run.tcl for JG CDC

# WARNING (WCDC010): Signal "..." has been defined as a "Fully Asynchronous" reset.
#     Ignoring new definition as "Fully Asynchronous" reset.
set_message -info WCDC010
# WARNING (WCDC025): You have not declared any CDC static values yet; nothing to prove.
#     Run "check_cdc -signal_config -add_static" to declare static values.
set_message -info WCDC025
# WARNING (WCDC073): This is a heuristic detection; thus, review of the detected synchronizers is advised.
set_message -info WCDC073
# WARNING (WNL066): Ignoring entry "+tb_debug_mon" in "-f" file "flist" as it is unsupported or contains errors.
set_message -info WNL066
# WARNING (WRS002): The reset condition "..." is already declared.
set_message -info WRS002

analyze -sv +incdir+. -f flist
elaborate -top nceplmt100
check_cdc -init

set_max_trace_length 400


##########################
### Parameter Settings ###
##########################
config_rtlds -rule -parameter {multi_mode_analysis=true}

config_rtlds -rule -parameter {src_unit_signal=both} -domain CDC
config_rtlds -rule -parameter {src_unit_domain=both} -domain CDC

# Don't let JG rate unrated input ports by the clock of the flop they are driving.
#config_rtlds -rule -parameter {treat_boundaries_as_unclocked=true} -tag PRT_IS_UNCK
config_rtlds -rule -parameter {ignore_non_resettable_flop=true} -tag RDC_RS_DFRS

# # Pair configuration
# config_rtlds -rule {cdc_pair_logic=buf} -tag CDC_PR_LOGC
# config_rtlds -rule {sync_chain_logic=Buf} -tag SYN_DF_SLGC
# config_rtlds -rule {reset_pair_logic=Buf} -tag RST_RS_PLGC
# config_rtlds -rule {reset_sync_chain_logic=Buf} -tag SYN_RS_SLGC


##########################
### Clock Declarations ###
##########################
check_cdc -clock_domain -virtual_clock v_stoptime_clk
check_cdc -clock_domain -virtual_clock v_por_rstn_clk
clock v_stoptime_clk
clock v_por_rstn_clk
clock clk
clock mtime_clk

#########################
### Clock Association ###
#########################
check_cdc -clock_domain -clock_signal  clk -port {araddr arburst arcache arid arlen arlock arprot arready arsize arvalid awaddr awburst awcache awid awlen awlock awprot awready awsize awvalid bid bready bresp bvalid rdata rid rlast rready rresp rvalid wdata wlast wready wstrb wvalid}
check_cdc -clock_domain -clock_signal  clk -port {haddr hburst hrdata hready hreadyout hresp hsel hsize htrans hwdata hwrite}
check_cdc -clock_domain -clock_signal  clk -port {mtip resetn}

# stoptime is an asynchronous input without clocks so we need to make
# sure proper CDC handling is done.
# "check_cdc -clock_domain -port {stoptime} -async" doesn't work before
# JG 2020.06 FCS so use virtual clocks as a work-around.
check_cdc -clock_domain -clock_signal v_stoptime_clk -port {stoptime}

# Also associate a virtual clock with por_rstn so that por_rstn won't be reported unrated.
check_cdc -clock_domain -clock_signal v_por_rstn_clk -port {por_rstn}

##########################
### Reset Declarations ###
##########################
config_rtlds -reset -async por_rstn -polarity low
config_rtlds -reset -synchronized resetn -clock clk -polarity low
reset -expression !por_rstn !resetn

###################
### Reset Order ###
###################
# por_rstn will also trigger resetn (bus reset) at the same time so there's
# no order when por_rstn is asserted. However, when being released, por_rstn
# will be released first while the bus reset is being sync'ed by the bus clock.
# This means resetn will live longer than por_rstn. As a result, registers (A)
# reset by por_rstn can be safely flopped by registers (B) reset by resetn
# since when A is released from reset, B is still being reset.
check_cdc -reset -set_order {por_rstn resetn}

##################################
### Assumptions and Assertions ###
##################################
# Don't let stoptime toggle too frequently so that clk can sample it in time.
# Otherwise, CDC will complain that "Control path 'xxx' is not stable
# long enough to be captured correctly by destination clock 'clk'"
assume {$changed(stoptime) |=> $stable(stoptime)}

# Multiple bits of gray-coded counter (mtime_gray) will change when mtime_program_update changes from 0 to 1.
assume {nceplmt100_rtc.mtime_program_update == 0}

# Assume the hreadyin is connected with hreadyout to match the AHB transaction protocal
assume {nceplmt100_busif.hready == nceplmt100_busif.hreadyout}

#############################
### Signal Configurations ###
#############################
# Assign the constant value to input ports.
check_cdc -signal_config -add_constant {{test_mode 0}}

#########################
### Reset Association ###
#########################


##########################
### Find Clock Domains ###
##########################
check_cdc -clock_domain -find

# Report unrated (unclocked) unit
set cdc_units [check_cdc -list units]
set units {}
foreach key [dict keys $cdc_units] {
	if {[lsearch [dict get [dict get $cdc_units $key] Status] Unrated] >= 0} {
		lappend units $key
	}
}
if {[llength $units]} {
	puts "Unrated Units: $units"
}

######################
### Find CDC Pairs ###
######################
check_cdc -pair -find

################################
### Add User-Defined Schemes ###
################################
# Set handshake template
# clk -> mtime_clk
check_cdc -scheme -add Handshake -module nceplmt100 \
        -map {{Sreq update_req}  {Dreq update_req_sync} \
              {Sack update_ack_sync} {Dack update_ack} \
              {Sctrl nceplmt100_busif.mtime_shadow_gray_en}  {Dctrl nceplmt100_rtc.mtime_gray_en} \
              {Data  nceplmt100_busif.mtime_shadow_gray   }  {Dout  nceplmt100_rtc.mtime_gray   }}

# # Set FIFO template
# check_cdc -scheme -add FIFO -module async_fifo_data -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
# check_cdc -scheme -add FIFO -module async_fifo -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
check_cdc -scheme -add NDFF     -module nds_sync_l2l     -map {{Data a_signal} {Dout b_signal}}

####################
### Find Schemes ###
####################
check_cdc -scheme -find -aggressive

########################
### Find Convergence ###
########################
check_cdc -group  -find -aggressive

##########################
### Funcational Checks ###
##########################
check_cdc -protocol_check -generate
check_cdc -protocol_check -prove

######################
### Reset Analysis ###
######################
check_cdc -reset -find

##############################
### Metastability Analysis ###
##############################
check_cdc -metastability -inject -include_reset
check_cdc -metastability -prove

###################################
### Signal Configuration Checks ###
###################################
check_cdc -signal_config -prove

# ###################
# ### Add Waivers ###
# ###################
# ### Pair check ###
# # cdc_pair_logic violation
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check cdc_pair_fanout -violation Pair -source_unit {u_spi_reg\.mem_cmd_r} -destination_unit {u_spi_sync\.arb_trans_end_sync\.a_level_r} -source_clock clk -destination_clock spi_clock -severity Error] -comment {Glitch is okay for stopping SPI}

# ### Scheme Check ###
# # sync_chain_fanout violation
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -scheme_type NDFF -scheme {n13_core\.edm\.edm_tap\.tap_addr_scan\[3\]} -check sync_chain_fanout -violation Scheme -severity Error] -comment {This signal has been qualified by the sru_edm_ack signal}
#
# # sync_chain_logic violation
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -scheme_type NDFF -scheme {n13_core\.edm\.edm_tap\.tap_addr_scan\[3\]} -check sync_chain_logic -violation Scheme -severity Error] -comment check_cdc\ -waiver\ -add\ -filter\ \[check_cdc\ -filter\ -add\ -regexp\ -scheme_type\ NDFF\ -scheme\ \{n13_core\\.edm\\.edm_tap\\.tap_addr_scan\\\[3\\\]\}\ -check\ sync_chain_fanout\ -violation\ Scheme\ -severity\ Error\]\ -comment\ \{This\ signal\ has\ been\ qualified\ by\ the\ sru_edm_ack\ signal\}
#
# ### CDC Reset check ###
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check different_reset] -comment {Synchrozation reset flop design}
#
# ### Convergence check ###
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check reconvergence_check -cdc_group {n13_core\.bus_path_ahb\.backup_selected_ahb_addr\[31:2\]} -violation Convergence -severity Error] -comment {The tap_write has been qualified}
#
#
# ### Metastability Check ###
#
#
#
# ### Functional check waiver ###
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -violation Functional -module .*async_fifo.*] -comment {Unidentified synchronizer}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -violation Functional -module .*nds_sync_l2l*] -comment {Unidentified synchronizer}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -scheme_type NDFF -scheme {n13_core\.edm\.edm_tap\.edm_ahb_req} -scheme_property {CDC_n13_core\.edm\.edm_tap\.edm_ahb_req_data_stable} -check data_stable -violation Functional -severity Error] -comment {This signal has been qualified}

