//-----------------------------------------------------------------------------
// Title         : Rxaui top
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_top.v
// Author        : Lior Valency
// Created       : 17/02/2008 
// Last modified : 17/02/2008 
//-----------------------------------------------------------------------------
// Description : This block implement rxaui.
// The purpose of this block is interleave 2 lanes to one serdes,
// this block work in 2 clock dominas.    
//-----------------------------------------------------------------------------
// Copyright (c) 2007  Marvell International Ltd.
//
// THIS CODE CONTAINS CONFIDENTIAL INFORMATION OF MARVELL SEMICONDUCTOR, INC.
// NO RIGHTS ARE GRANTED HEREIN UNDER ANY PATENT, MASK WORK RIGHT OR COPYRIGHT
// OF MARVELL OR ANY THIRD PARTY. MARVELL RESERVES THE RIGHT AT ITS SOLE
// DISCRETION TO REQUEST THAT THIS CODE BE IMMEDIATELY RETURNED TO MARVELL.
// THIS CODE IS PROVIDED "AS IS". MARVELL MAKES NO WARRANTIES, EXPRESS,
// IMPLIED OR OTHERWISE, REGARDING ITS ACCURACY, COMPLETENESS OR PERFORMANCE.
//
//------------------------------------------------------------------------------
// Modification history :
// 12/12/2007  : created
//-----------------------------------------------------------------------------
`timescale 10ps / 10ps


module sip_rxaui_top(/*AUTOARG*/
   // Outputs
   txclk_out, rxaui_tx_data, lock, rxdata_serdes0, rxdata_serdes1,
   rx_clk0, rx_clk1, rxaui_status,
   // Inputs
   reset_in_, media_interface_mode, scan_mode_, serdes_mode,
   txclk_in0, txclk_in1, txdata_serdes0, txdata_serdes1, s_tx_clk,
   lane0_sync_ok, lane1_sync_ok, rxaui_rx_data, s_sigdet, s_rx_clk
   );

`include "sip_rxaui_params.inc"

   /* AUTO_CONSTANT (1'b0 or 1'b1 or 10'd0)*/

   ///////////////
   // INTERFACE //
   ///////////////

   // General
   input                              reset_in_;
   input 			      media_interface_mode;
   input 			      scan_mode_;
   input 			      serdes_mode;
   
   // Tx Interface
   // XPCS
   input 			      txclk_in0;		
   input 			      txclk_in1;
   input [19:0] 		      txdata_serdes0;	
   input [19:0] 		      txdata_serdes1;	
   output 			      txclk_out; 		

   // Serdes
   input 			      s_tx_clk;	
   output [19:0] 		      rxaui_tx_data;

   // Rx Interface
   // XPCS
   input 			      lane0_sync_ok;		
   input 			      lane1_sync_ok;		
   output 			      lock;
   output [19:0] 		      rxdata_serdes0;	
   output [19:0] 		      rxdata_serdes1;
   output 			      rx_clk0;
   output 			      rx_clk1;
   
   // Serdes
   input [19:0] 		      rxaui_rx_data;
   input 			      s_sigdet;
   input 			      s_rx_clk;	

   // Status
   output [8:0] 		      rxaui_status;

   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   // End of automatics
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   // End of automatics



   ////////////////////
   // INTERNAL WIRES //
   ////////////////////
   wire			serdes_rx_clk_div2;	
   wire			serdes_rx_clk_div2_reset_;
   wire			serdes_rx_clk_reset_;	
   wire			serdes_tx_clk_reset_;	
   wire			serdes_txclk_in0_reset_;
   wire			serdes_txclk_in1_reset_;

   /*sip_rxaui_rx_top AUTO_TEMPLATE(
    .serdes_rx_clk_reset({~serdes_rx_clk_reset_}),
    .serdes_rx_data	(rxaui_rx_data[SERDES_DATA_W-1:0]),
    .serdes_rx_clk	(s_rx_clk),
    )*/
   sip_rxaui_rx_top
     sip_rxaui_rx_top(/*AUTOINST*/
		      // Outputs
		      .lock		(lock),
		      .rxdata_serdes0	(rxdata_serdes0[SERDES_DATA_W-1:0]),
		      .rxdata_serdes1	(rxdata_serdes1[SERDES_DATA_W-1:0]),
		      .rxaui_status	(rxaui_status[STATUS_REG_W-1:0]),
		      // Inputs
		      .serdes_rx_clk	(s_rx_clk),		 // Templated
		      .serdes_rx_clk_div2(serdes_rx_clk_div2),
		      .serdes_rx_clk_reset_(serdes_rx_clk_reset_),
		      .serdes_rx_clk_reset({~serdes_rx_clk_reset_}), // Templated
		      .serdes_rx_clk_div2_reset_(serdes_rx_clk_div2_reset_),
		      .rx_clk0		(rx_clk0),
		      .rx_clk1		(rx_clk1),
		      .media_interface_mode(media_interface_mode),
		      .serdes_mode	(serdes_mode),
		      .lane0_sync_ok	(lane0_sync_ok),
		      .lane1_sync_ok	(lane1_sync_ok),
		      .s_sigdet		(s_sigdet),
		      .serdes_rx_data	(rxaui_rx_data[SERDES_DATA_W-1:0])); // Templated
   
   /*sip_rxaui_tx_top AUTO_TEMPLATE(
    .serdes_tx_clk	(s_tx_clk),
    )*/
   sip_rxaui_tx_top
     sip_rxaui_tx_top(/*AUTOINST*/
		      // Outputs
		      .rxaui_tx_data	(rxaui_tx_data[SERDES_DATA_W-1:0]),
		      // Inputs
		      .serdes_tx_clk	(s_tx_clk),		 // Templated
		      .serdes_txclk_in0_reset_(serdes_txclk_in0_reset_),
		      .serdes_txclk_in1_reset_(serdes_txclk_in1_reset_),
		      .serdes_tx_clk_reset_(serdes_tx_clk_reset_),
		      .media_interface_mode(media_interface_mode),
		      .serdes_mode	(serdes_mode),
		      .txclk_in0	(txclk_in0),
		      .txdata_serdes0	(txdata_serdes0[SERDES_DATA_W-1:0]),
		      .txclk_in1	(txclk_in1),
		      .txdata_serdes1	(txdata_serdes1[SERDES_DATA_W-1:0]));

   /*sip_rxaui_clk_reset AUTO_TEMPLATE(
    .reset_		(reset_in_),
    .serdes_tx_clk	(s_tx_clk),
    .serdes_rx_clk	(s_rx_clk),
    )*/
   sip_rxaui_clk_reset
     sip_rxaui_clk_reset(/*AUTOINST*/
			 // Outputs
			 .serdes_rx_clk_div2	(serdes_rx_clk_div2),
			 .rx_clk0		(rx_clk0),
			 .rx_clk1		(rx_clk1),
			 .serdes_rx_clk_reset_	(serdes_rx_clk_reset_),
			 .serdes_rx_clk_div2_reset_(serdes_rx_clk_div2_reset_),
			 .txclk_out		(txclk_out),
			 .serdes_txclk_in0_reset_(serdes_txclk_in0_reset_),
			 .serdes_txclk_in1_reset_(serdes_txclk_in1_reset_),
			 .serdes_tx_clk_reset_	(serdes_tx_clk_reset_),
			 // Inputs
			 .scan_mode_		(scan_mode_),
			 .reset_		(reset_in_),	 // Templated
			 .media_interface_mode	(media_interface_mode),
			 .serdes_mode		(serdes_mode),
			 .serdes_rx_clk		(s_rx_clk),	 // Templated
			 .serdes_tx_clk		(s_tx_clk),	 // Templated
			 .txclk_in0		(txclk_in0),
			 .txclk_in1		(txclk_in1));
   
endmodule // sip_rxaui_top

// Local Variables:
// verilog-library-directories:( "." "../RxPath/" "../TxPath/" "../ClockReset/" "/proj1/galileo101/tomcat/MODELS/current/Model_link/")
// End:

