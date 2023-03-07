# run.tcl for JG CDC

# # WARNING (WCDC010): Signal "..." has been defined as a "Fully Asynchronous" reset.
# #     Ignoring new definition as "Fully Asynchronous" reset.
# set_message -info WCDC010
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
elaborate -top ncejdtm200
check_cdc -init

set_max_trace_length 400


##########################
### Parameter Settings ###
##########################
config_rtlds -rule -parameter {multi_mode_analysis=true}
config_rtlds -rule -parameter {handshake_detection=true}

# # Don't let JG rate unrated input ports by the clock of the flop they are driving.
# config_rtlds -rule -parameter {treat_boundaries_as_unclocked=true} -tag PRT_IS_UNCK
# config_rtlds -rule -parameter {ignore_non_resettable_flop=true} -tag RDC_RS_DFRS

# # Pair configuration
# config_rtlds -rule {cdc_pair_logic=buf} -tag CDC_PR_LOGC
# config_rtlds -rule {sync_chain_logic=Buf} -tag SYN_DF_SLGC
# config_rtlds -rule {reset_pair_logic=Buf} -tag RST_RS_PLGC
# config_rtlds -rule {reset_sync_chain_logic=Buf} -tag SYN_RS_SLGC


##########################
### Clock Declarations ###
##########################
clock tck
clock dmi_hclk

#########################
### Clock Association ###
#########################
check_cdc -clock_domain -port {dmi_hsel dmi_htrans dmi_haddr dmi_hsize dmi_hburst dmi_hprot dmi_hwdata dmi_hwrite dmi_hrdata dmi_hready dmi_hresp} -clock_signal dmi_hclk
check_cdc -clock_domain -port {tms_out_en tms tdi tdo} -clock_signal tck
# check_cdc -clock_domain -port {hresetn} -clock_signal dmi_hclk

##########################
### Reset Declarations ###
##########################
config_rtlds -reset -async {pwr_rst_n} -polarity low
config_rtlds -reset -sync {dtm_dmi_resetn} -clock dmi_hclk -polarity low
config_rtlds -reset -sync {nds_sync_dtm_dmi_rst.resetn_sync_array[1]} -clock dmi_hclk -polarity low
# reset -expression !pwr_rst_n !dmi_hresetn
reset -expression !pwr_rst_n
# check_cdc -reset -set_order {pwr_rst_n dmi_hresetn}

##################################
### Assumptions and Assertions ###
##################################
# Constrain reset generation from JTAG scan chain
assume {tap_dmi_tck_req |-> !ncejdtm200_tap.rst_tap}
assume {ncejdtm200_tap.dtmcs_dmihardreset == 1'b0}

#############################
### Signal Configurations ###
#############################
### Assign the constant value to input ports.
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
check_cdc -scheme -add Handshake -module ncejdtm200 \
        -map {{Sreq tap_dmi_tck_req}               {Dreq tap_dmi_hclk_req} \
              {Sack dmi_tap_hclk_ack}              {Dack dmi_tap_tck_ack} \
              {Sctrl ncejdtm200_tap.dmi_update_en} {Dctrl ncejdtm200_dmi.dmi_data_wen} \
              {Data ncejdtm200_tap.dmi}            {Dout ncejdtm200_dmi.dmi_data}}

# Set FIFO template
# check_cdc -scheme -add FIFO -module async_fifo_data -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
# check_cdc -scheme -add FIFO -module async_fifo -map {{Rdata rd_data} {Rempty empty} {Rinc rd} {Rptr rd_index} {Wdata wr_data} {Wfull full} {Winc wr} {Wptr wr_index}}
check_cdc -scheme -add NDFF -module nds_sync_l2l -map {{Data a_signal} {Dout b_signal}}

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

################################
### Set the waiver condition ###
################################
# ### Pair check ###
# # cdc_pair_logic violation
# check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -check cdc_pair_fanout -violation Pair -source_unit {u_spi_reg\.mem_cmd_r} -destination_unit {u_spi_sync\.arb_trans_end_sync\.a_level_r} -source_clock dmi_hclk -destination_clock spi_clock -severity Error] -comment {Glitch is okay for stopping SPI}

# ### Shceme Check ###
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

check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {nds_sync_tap_dmi.a_signal_sync\[1\]-ncejdtm200_dmi.dmi_data}]     -comment {Some FF will be reset by pwr_rst_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {nds_sync_tap_dmi.a_signal_sync\[1\]-ncejdtm200_dmi.dmi_htrans}]   -comment {Some FF will be reset by pwr_rst_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {nds_sync_tap_dmi.a_signal_sync\[1\]-ncejdtm200_dmi.hrdata_phase}] -comment {Some FF will be reset by pwr_rst_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RDC_RS_DFRS -occurrence {nds_sync_tap_dmi.a_signal_sync\[1\]-ncejdtm200_dmi.dmi_tap_ack}]  -comment {Some FF will be reset by pwr_rst_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FOUT -occurrence pwr_rst_n-tck]                                           -comment {Affected domains are expected to be idle for sometime after pwr_rst_n}
check_cdc -waiver -add -filter [check_cdc -filter -add -regexp -tag RST_RS_FOUT -occurrence pwr_rst_n-dmi_hclk]                                      -comment {Affected domains are expected to be idle for sometime after pwr_rst_n}

