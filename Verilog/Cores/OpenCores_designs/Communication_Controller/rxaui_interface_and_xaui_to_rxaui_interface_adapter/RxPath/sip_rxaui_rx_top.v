//-----------------------------------------------------------------------------
// Title         : Rxaui Rx top
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_rx_top.v
// Author        : Lior Valency
// Created       : 17/02/2008 
// Last modified : 17/02/2008 
//-----------------------------------------------------------------------------
// Description : This is the top of rxaui receive block the purpose of this block
// is to receive data from serdes and to separate it to 2 different lanes.     
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


module sip_rxaui_rx_top(/*AUTOARG*/
   // Outputs
   lock, rxdata_serdes0, rxdata_serdes1, rxaui_status,
   // Inputs
   serdes_rx_clk, serdes_rx_clk_div2, serdes_rx_clk_reset_,
   serdes_rx_clk_reset, serdes_rx_clk_div2_reset_, rx_clk0, rx_clk1,
   media_interface_mode, serdes_mode, lane0_sync_ok, lane1_sync_ok,
   s_sigdet, serdes_rx_data
   );

`include "sip_rxaui_params.inc"

   /* AUTO_CONSTANT (1'b0 or 1'b1 or 10'd0)*/

   ///////////////
   // INTERFACE //
   ///////////////

   // General
   input                               serdes_rx_clk;
   input 			       serdes_rx_clk_div2;
   input 			       serdes_rx_clk_reset_;
   input 			       serdes_rx_clk_reset;
   input 			       serdes_rx_clk_div2_reset_;
   input 			       rx_clk0;	
   input 			       rx_clk1;	
   
   // Configuration
   input 			       media_interface_mode;	
   input 			       serdes_mode;
   
   // XPCS interface
   input 			       lane0_sync_ok;	
   input 			       lane1_sync_ok;	
   output 			       lock;
   output [SERDES_DATA_W-1:0] 	       rxdata_serdes0;		
   output [SERDES_DATA_W-1:0] 	       rxdata_serdes1;	
   
   // Serdes interface
   input 			       s_sigdet;
   input [SERDES_DATA_W-1:0] 	       serdes_rx_data;

   // Status
   output [STATUS_REG_W-1:0] 	       rxaui_status;


   // 
   
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
   wire			               comma_aligned_en;		
   wire [SERDES_DATA_W-1:0] 	       rxdata_rxaui_lane0;	
   wire [SERDES_DATA_W-1:0] 	       rxdata_rxaui_lane1;	
   wire [STD_DATA_W-1:0] 	       lane0_rx;		
   wire [STD_DATA_W-1:0] 	       lane1_rx;		
   wire [19:0] 			       rx_aligned_data;	

   /* sip_xpcs_comma_detect AUTO_TEMPLATE(
    .rout		 (rx_aligned_data[SERDES_DATA_W-1:0]),
    .bypass		 ({1'b0}),
    .clk		 (serdes_rx_clk),
    .comma_valid0	 ({1'b0}), // Only if use internal sync-sm
    .comma_valid1	 ({1'b0}), // Only if use internal sync-sm
    .commaa		 ({10'd0}), // Not in use 
    .commab		 ({10'd0}), // Not in use
    .data_special_valid0 ({1'b0}), // Only if use internal sync-sm
    .data_special_valid1 ({1'b0}), // Only if use internal sync-sm
    .reset		 (serdes_rx_clk_reset),
    .rin                 (serdes_rx_data[SERDES_DATA_W-1:0]),
    .sel_comma		 ({1'b1}), // use standard 7 bits comma
    .en_comma_align_glob (comma_aligned_en),
    .rf_en_2sync	 ({1'b0}), // Use external sync-sm   
    .sigdet		 (s_sigdet),
    );*/
   
   sip_xpcs_comma_detect
     xpcs_comma_detect(/*AUTOINST*/
			  // Outputs
			  .lock			(lock),
			  .rout			(rx_aligned_data[SERDES_DATA_W-1:0]), // Templated
			  // Inputs
			  .bypass		({1'b0}),	 // Templated
			  .clk			(serdes_rx_clk), // Templated
			  .comma_valid0		({1'b0}),	 // Templated
			  .comma_valid1		({1'b0}),	 // Templated
			  .commaa		({10'd0}),	 // Templated
			  .commab		({10'd0}),	 // Templated
			  .data_special_valid0	({1'b0}),	 // Templated
			  .data_special_valid1	({1'b0}),	 // Templated
			  .reset		(serdes_rx_clk_reset), // Templated
			  .rin			(serdes_rx_data[SERDES_DATA_W-1:0]), // Templated
			  .sel_comma		({1'b1}),	 // Templated
			  .sigdet		(s_sigdet),	 // Templated
			  .en_comma_align_glob	(comma_aligned_en), // Templated
			  .rf_en_2sync		({1'b0}));	 // Templated

   /* sip_rxaui_aa_detection AUTO_TEMPLATE(
    .reset_		(serdes_rx_clk_reset_),
    .clk		(serdes_rx_clk),
    );*/
   
   sip_rxaui_aa_detection
     sip_rxaui_aa_detection(/*AUTOINST*/
			    // Outputs
			    .lane0_rx		(lane0_rx[STD_DATA_W-1:0]),
			    .lane1_rx		(lane1_rx[STD_DATA_W-1:0]),
			    .rxaui_status	(rxaui_status[STATUS_REG_W-1:0]),
			    // Inputs
			    .clk		(serdes_rx_clk), // Templated
			    .reset_		(serdes_rx_clk_reset_), // Templated
			    .serdes_mode	(serdes_mode),
			    .rx_aligned_data	(rx_aligned_data[SERDES_DATA_W-1:0]),
			    .serdes_rx_data	(serdes_rx_data[SERDES_DATA_W-1:0]));

   /* sip_phase_sync_fifo_fast_2_slow AUTO_TEMPLATE(
    .fifo_data_out	({rxdata_rxaui_lane1[SERDES_DATA_W-1:STD_DATA_W],rxdata_rxaui_lane0[SERDES_DATA_W-1:STD_DATA_W],rxdata_rxaui_lane1[STD_DATA_W-1:0],rxdata_rxaui_lane0[STD_DATA_W-1:0]}),
    .fifo_data_in	({lane1_rx[STD_DATA_W-1:0],lane0_rx[STD_DATA_W-1:0]}),
    .wr_clk		(serdes_rx_clk),
    .rd_clk		(serdes_rx_clk_div2),
    .wr_reset_		(serdes_rx_clk_reset_),
    .rd_reset_		(serdes_rx_clk_div2_reset_),
    );*/
   
   sip_phase_sync_fifo_fast_2_slow
     sip_phase_sync_fifo_fast_2_slow(/*AUTOINST*/
				     // Outputs
				     .fifo_data_out	({rxdata_rxaui_lane1[SERDES_DATA_W-1:STD_DATA_W],rxdata_rxaui_lane0[SERDES_DATA_W-1:STD_DATA_W],rxdata_rxaui_lane1[STD_DATA_W-1:0],rxdata_rxaui_lane0[STD_DATA_W-1:0]}), // Templated
				     // Inputs
				     .wr_clk		(serdes_rx_clk), // Templated
				     .rd_clk		(serdes_rx_clk_div2), // Templated
				     .wr_reset_		(serdes_rx_clk_reset_), // Templated
				     .rd_reset_		(serdes_rx_clk_div2_reset_), // Templated
				     .fifo_data_in	({lane1_rx[STD_DATA_W-1:0],lane0_rx[STD_DATA_W-1:0]})); // Templated

   /*sip_rxaui_rx_glue  AUTO_TEMPLATE(
   );*/   
   sip_rxaui_rx_glue
     sip_rxaui_rx_glue(/*AUTOINST*/
		       // Outputs
		       .comma_aligned_en(comma_aligned_en),
		       .rxdata_serdes0	(rxdata_serdes0[SERDES_DATA_W-1:0]),
		       .rxdata_serdes1	(rxdata_serdes1[SERDES_DATA_W-1:0]),
		       // Inputs
		       .rx_clk0		(rx_clk0),
		       .rx_clk1		(rx_clk1),
		       .media_interface_mode(media_interface_mode),
		       .serdes_mode	(serdes_mode),
		       .rxdata_rxaui_lane0(rxdata_rxaui_lane0[SERDES_DATA_W-1:0]),
		       .rxdata_rxaui_lane1(rxdata_rxaui_lane1[SERDES_DATA_W-1:0]),
		       .serdes_rx_data	(serdes_rx_data[SERDES_DATA_W-1:0]),
		       .lane0_sync_ok	(lane0_sync_ok),
		       .lane1_sync_ok	(lane1_sync_ok));
   
endmodule // sip_rxaui_rx_top

// Local Variables:
// verilog-library-directories:( "." "/proj1/galileo101/tomcat/MODELS/current/Model_link/")
// End:

