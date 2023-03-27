# run.tcl for JG CDC

# WARNING (WCDC025): You have not declared any CDC static values yet; nothing to prove.
#     Run "check_cdc -signal_config -add_static" to declare static values.
set_message -info WCDC025
# WARNING (WCDC073): This is a heuristic detection; thus, review of the detected synchronizers is advised.
set_message -info WCDC073
# WARNING (WNL066): Ignoring entry "+tb_debug_mon" in "-f" file "flist" as it is unsupported or contains errors.
set_message -info WNL066

analyze -sv +incdir+. -f flist
elaborate -top ncepldm200
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
check_cdc -clock_domain -virtual_clock v_core_clk
clock clk
clock v_core_clk

#########################
### Clock Association ###
#########################
check_cdc -clock_domain -clock_signal clk -port {dmactive ndmreset resethaltreq debugint bus_resetn dmi_resetn}
check_cdc -clock_domain -clock_signal clk -port {rv_haddr rv_htrans rv_hwrite rv_hsize rv_hburst rv_hprot rv_hwdata rv_hsel rv_hready rv_hrdata rv_hreadyout rv_hresp}
check_cdc -clock_domain -clock_signal clk -port {rv_awid rv_awaddr rv_awlen rv_awsize rv_awburst rv_awlock rv_awcache rv_awprot rv_awvalid rv_awready rv_wdata rv_wstrb rv_wlast rv_wvalid rv_wready rv_bid rv_bresp rv_bvalid rv_bready rv_arid rv_araddr rv_arlen rv_arsize rv_arburst rv_arlock rv_arcache rv_arprot rv_arvalid rv_arready rv_rid rv_rdata rv_rresp rv_rlast rv_rvalid rv_rready}
check_cdc -clock_domain -clock_signal clk -port {sys_awid sys_awaddr sys_awlen sys_awsize sys_awburst sys_awlock sys_awcache sys_awprot sys_awvalid sys_awready sys_wdata sys_wstrb sys_wlast sys_wvalid sys_wready sys_bid sys_bresp sys_bvalid sys_bready sys_arid sys_araddr sys_arlen sys_arsize sys_arburst sys_arlock sys_arcache sys_arprot sys_arvalid sys_arready sys_rid sys_rdata sys_rresp sys_rlast sys_rvalid sys_rready sys_haddr sys_htrans sys_hwrite sys_hsize sys_hburst sys_hprot sys_hwdata sys_hbusreq sys_hrdata sys_hready sys_hresp sys_hgrant}
check_cdc -clock_domain -clock_signal clk -port {dmi_haddr dmi_htrans dmi_hwrite dmi_hsize dmi_hburst dmi_hprot dmi_hwdata dmi_hsel dmi_hready dmi_hrdata dmi_hreadyout dmi_hresp}

check_cdc -clock_domain -clock_signal v_core_clk -port {hart_unavail hart_under_reset}

##########################
### Reset Declarations ###
##########################
reset -expression !dmi_resetn !bus_resetn

###################
### Reset Order ###
###################
check_cdc -reset -set_order {bus_resetn dmi_resetn}

##################################
### Assumptions and Assertions ###
##################################
# Don't let hart_* toggle too frequently so that clk can sample it in time.
# Otherwise, CDC will complain that "Control path 'hart_unavail' is not stable
# long enough to be captured correctly by destination clock 'clk'"
assume {$changed(hart_unavail) |=> $stable(hart_unavail)}
assume {$changed(hart_under_reset) |=> $stable(hart_under_reset)}

#############################
### Signal Configurations ###
#############################
# Assign the constant value to input ports.
# check_cdc -signal_config -add_constant {{test_mode 0}}

# Each bit of hart_* is independent of others. Using the exclusive mode
# prevents CDC from complaining about the gray code although there may
# be multiple ones at the same time.
# check_cdc -signal_config -add_exclusive {hart_unavail}
# check_cdc -signal_config -add_exclusive {hart_halted}
# check_cdc -signal_config -add_exclusive {hart_under_reset}
check_cdc -signal_config -add_exclusive {hart_unavail hart_under_reset}

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
# # Set handshake template
# check_cdc -scheme -add Handshake -module edm_tap -map {{Dack ahb_edm_ack} {Data edm_biu_cmd} {Dctrl edm_ahb_req} {Dreq edm_ahb_req} {Sack core_ctr_comp_tck} {Sctrl g_tap_update_dr_tck_en} {Sreq edm_pcu_tap_issue_tck}}

# # Set FIFO template
# check_cdc -scheme -add FIFO -module async_fifo_data -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
# check_cdc -scheme -add FIFO -module async_fifo -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
# check_cdc -scheme -add NDFF -module nds_sync_l2l -map {{Data a_signal} {Dout b_signal}}

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
#check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check cdc_pair_fanout -violation Pair -source_unit {u_spi_reg\.mem_cmd_r} -destination_unit {u_spi_sync\.arb_trans_end_sync\.a_level_r} -source_clock dmi_hclk -destination_clock spi_clock -severity Error] -comment {Glitch is okay for stopping SPI}

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

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {hart_resumereq-gen_rv_interface_ahb\.reg_rv_hrdata\[30:0\]}]    -comment {external debugger won't cause race condition in resets}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {abs_cs-gen_rv_interface_ahb\.reg_rv_hrdata\[30:0\]}]            -comment {external debugger won't cause race condition in resets}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {resumereq_hartsel-gen_rv_interface_ahb\.reg_rv_hrdata\[30:0\]}] -comment {external debugger won't cause race condition in resets}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {hart_resumeack-gen_rv_interface_ahb\.reg_rv_hrdata\[30:0\]}]    -comment {external debugger won't cause race condition in resets}

# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {dmi_hrdata[17:16]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {dmi_hrdata[17:16]}] -comment {dmi_hrdata simply reflects the synchronized data}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {dmi_hrdata[0]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {dmi_hrdata[0]}] -comment {dmi_hrdata simply reflects the synchronized data}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {dmi_hrdata[11]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {dmi_hrdata[11]}] -comment {dmi_hrdata simply reflects the synchronized data}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {hart_cs[3]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {hart_cs[3]}] -comment {hart_cs simply gathers the status of each hart}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {hart_cs[2]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {hart_cs[2]}] -comment {hart_cs simply gathers the status of each hart}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {hart_cs[1]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {hart_cs[1]}] -comment {hart_cs simply gathers the status of each hart}
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -cdc_group {hart_cs[0]} -tag CNV_ST_CONV -severity Error -module ncepldm200 -occurrence {hart_cs[0]}] -comment {hart_cs simply gathers the status of each hart}
