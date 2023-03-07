//------------------------------------------------------------------------------
// Copyright (c) 2018 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r.stub.v
//   Module Name:        cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r
//
//   Release Revision:   1p3
//   Release SVN Tag:    
//
//   IP Name:            cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r
//   IP Part Number:     
//
//   Product Type:       Off-the-shelf
//   IP Type:            Hard IP
//   IP Family:          USB2
//   Technology:         16FFC
//   Protocol:           USB2
//   Architecture:       
//   Licensable IP:      
//
//------------------------------------------------------------------------------
//   Description: This is Verilog stub for USB2 hard IP
//------------------------------------------------------------------------------

module cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r (

inout		DP,
inout		DM,
inout		ID,
inout		VBUS,
inout		RTRIM,
inout		AVDD_CORE,
inout		AVDD_IO,
inout		gnd,
inout		AVDD_IO_HV,
inout		DVDD_CORE,
input 		refclock,
input 		apb_pclk,
input 		tap_tck,
input 		psm_clock,
input 		scan_hsclock,
input 		scan_hssiclock,
input 		scan_sieclock,
input 		scan_clock,
input 		hssi_tx_clockin ,
output		sieclock,
output		pll_clockout,
output		hssi_tx_clockout,
output		hssi_rx_clockout,
output 		scan_ats_hsclock,
output 		scan_ats_hssiclock,
output 		scan_ats_sieclock,
input 		reset,
input		databus_reset,
input		apb_presetn,
input		tap_trst_n,
input           psm_rstn,
input		scan_mode,
input		scan_en,
input           scan_en_cg,
input		scan_ats_mode,
input	[34:0]	scan_in,
output	[34:0]	scan_out,
input		suspendm,
input		sleepm,
input		termselect,
input		databus16_8,
input		dppulldown,
input		dmpulldown,
input		txbitstuffenable,
input		txbitstuffenableh,
input 	[1:0] 	powerdown,
input 	[1:0] 	opmode,
input 	[1:0] 	xcvrselect,
output		hostdisconnect,
output 	[1:0] 	linestate,
input 		txvalid,
input 		txvalidh,
input 	[15:0]  datain,
output		txready,
output		rxactive,
output		rxerror,
output		rxvalid,
output		rxvalidh,
output 	[15:0]  dataout,
input 		fslsserialmode,
input 		tx_dat,
input 		tx_enable_n,
input 		tx_se0,
input		idle_rpu_enable,
output		rx_dm,
output		rx_dp,
output		rx_rcv,
input		hssi_mode,
input	[1:0]	hssi_datain,
input	[1:0]	hssi_txvalid,
input		hssi_tx_enable,
input		hssi_ted_en,
output	[3:0]	hssi_dataout,
output		hssi_rxvalid,
output		hssi_squelch,
output		hssi_rxerror,
output		hssi_ded_ana,
output		hssi_chirp_data,
input           option_n,
input           option_cv,
input		pso_disable,
input 	[1:0] 	pso_disable_sel,
input 	[1:0] 	usb2_phy_arch,
input 	[1:0] 	pll_clk_sel,
input		pll_clkon,
input		pll_standalone,
input 		lane_reverse,
input 	[3:0]  	pllrefsel,
input 	[1:0]	vbus_sel,
input 		idpullup,
output		iddig,
output		vbusvalid,
output		sessvld,
input		adp_probe_en,
input		adp_en,
input		adp_sense_en,
input		adp_sink_current_en,
input		adp_source_current_en,
output		adp_probe_ana,
output		adp_sense_ana,
input		bc_en,
input 		dm_vdat_ref_comp_en,
input 		dm_vlgc_comp_en,
input 		dp_vdat_ref_comp_en,
input 		idm_sink_en,
input 		idp_sink_en,
input 		idp_src_en,
input 		rid_float_comp_en,
input 		rid_nonfloat_comp_en,
input 		vdm_src_en,
input 		vdp_src_en,
output		dcd_comp_sts,
output		dm_vdat_ref_comp_sts,
output		dm_vlgc_comp_sts,
output		dp_vdat_ref_comp_sts,
output		rid_a_comp_sts,
output		rid_b_comp_sts,
output		rid_c_comp_sts,
output		rid_float_comp_sts,
output		rid_gnd_comp_sts,
input 		pll_bypass_mode,
input 		iddq_mode,
input	[3:0]	bist_mode_sel,
input		bist_on,
input           bist_mode_en,
input 	[1:0]  	loopback,
input 	[7:0]  	usb2_phy_spare_in,
output		bist_complete,
output		bist_error,
output	[7:0]	bist_error_count,
output 	[7:0]  	usb2_phy_spare_out,
input 		apb_pwrite,
input 		apb_penable,
input 		apb_pselx,
input 	[7:0]  	apb_paddr,
input 	[7:0]  	apb_pwdata,
output		apb_pready,
output		apb_pslverr,
output 	[7:0]  	apb_prdata,
input		tap_tdi,
input		tap_tms,
output		tap_tdo,
output		tap_tdoen,
output          usb2_phy_irq
);

endmodule
