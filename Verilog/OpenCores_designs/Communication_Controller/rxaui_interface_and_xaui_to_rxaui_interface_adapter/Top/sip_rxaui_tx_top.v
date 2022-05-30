//-----------------------------------------------------------------------------
// Title         : Rxaui Tx top
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_tx_top.v
// Author        : Lior Valency
// Created       : 17/02/2008 
// Last modified : 17/02/2008 
//-----------------------------------------------------------------------------
// Description : This is the top of rxaui tranismit block the purpose of this block
// is to receive data from 2 lanes (XPCS) and interleave them on the same lane.     
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


module sip_rxaui_tx_top(/*AUTOARG*/
   // Outputs
   rxaui_tx_data,
   // Inputs
   serdes_tx_clk, serdes_txclk_in0_reset_, serdes_txclk_in1_reset_,
   serdes_tx_clk_reset_, media_interface_mode, serdes_mode, txclk_in0,
   txdata_serdes0, txclk_in1, txdata_serdes1
   );

`include "sip_rxaui_params.inc"

   /* AUTO_CONSTANT (1'b0 or 1'b1 or 10'd0)*/

   ///////////////
   // INTERFACE //
   ///////////////

   // General
   input                               serdes_tx_clk;
   input 			       serdes_txclk_in0_reset_;
   input 			       serdes_txclk_in1_reset_;
   input 			       serdes_tx_clk_reset_;	

   // Configuration
   input 			       media_interface_mode;	
   input 			       serdes_mode;
   
   // XPCS interface
   input 			       txclk_in0;
   input [SERDES_DATA_W-1:0] 	       txdata_serdes0;		
   input 			       txclk_in1;
   input [SERDES_DATA_W-1:0] 	       txdata_serdes1;	
   
   // Serdes interface
   output [SERDES_DATA_W-1:0] 	       rxaui_tx_data;
   
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
   wire [SERDES_DATA_W-1:0] 	       fifo_rxaui_tx_data0;
   wire [SERDES_DATA_W-1:0] 	       fifo_rxaui_tx_data1;
   wire 			       fifo_type;		

   /*sip_phase_sync_fifo_slow_2_fast AUTO_TEMPLATE(
    .fifo_data_out	(fifo_rxaui_tx_data0[SERDES_DATA_W-1:0]),
    .wr_clk		(txclk_in0),
    .rd_clk		(serdes_tx_clk),
    .wr_reset_	        (serdes_txclk_in0_reset_),
    .rd_reset_	        (serdes_tx_clk_reset_),
    .fifo_data_in	(txdata_serdes0[SERDES_DATA_W-1:0]),
    );*/
   sip_phase_sync_fifo_slow_2_fast
     sip_phase_sync_fifo_slow_2_fast_0(/*AUTOINST*/
				       // Outputs
				       .fifo_data_out	(fifo_rxaui_tx_data0[SERDES_DATA_W-1:0]), // Templated
				       // Inputs
				       .fifo_type	(fifo_type),
				       .wr_clk		(txclk_in0),	 // Templated
				       .rd_clk		(serdes_tx_clk), // Templated
				       .wr_reset_	(serdes_txclk_in0_reset_), // Templated
				       .rd_reset_	(serdes_tx_clk_reset_), // Templated
				       .fifo_data_in	(txdata_serdes0[SERDES_DATA_W-1:0])); // Templated
   
   /*sip_phase_sync_fifo_slow_2_fast AUTO_TEMPLATE(
    .fifo_data_out	(fifo_rxaui_tx_data1[SERDES_DATA_W-1:0]),
    .wr_clk		(txclk_in1),
    .rd_clk		(serdes_tx_clk),
    .wr_reset_	        (serdes_txclk_in1_reset_),
    .rd_reset_	        (serdes_tx_clk_reset_),
    .fifo_data_in	(txdata_serdes1[SERDES_DATA_W-1:0]),    
    .fifo_type          (media_interface_mode),
    );*/
   sip_phase_sync_fifo_slow_2_fast
     sip_phase_sync_fifo_slow_2_fast_1(/*AUTOINST*/
				       // Outputs
				       .fifo_data_out	(fifo_rxaui_tx_data1[SERDES_DATA_W-1:0]), // Templated
				       // Inputs
				       .fifo_type	(media_interface_mode), // Templated
				       .wr_clk		(txclk_in1),	 // Templated
				       .rd_clk		(serdes_tx_clk), // Templated
				       .wr_reset_	(serdes_txclk_in1_reset_), // Templated
				       .rd_reset_	(serdes_tx_clk_reset_), // Templated
				       .fifo_data_in	(txdata_serdes1[SERDES_DATA_W-1:0])); // Templated

   sip_rxaui_tx_glue
     sip_rxaui_tx_glue(/*AUTOINST*/
		       // Outputs
		       .fifo_type	(fifo_type),
		       .rxaui_tx_data	(rxaui_tx_data[SERDES_DATA_W-1:0]),
		       // Inputs
		       .media_interface_mode(media_interface_mode),
		       .serdes_mode	(serdes_mode),
		       .fifo_rxaui_tx_data0(fifo_rxaui_tx_data0[SERDES_DATA_W-1:0]),
		       .fifo_rxaui_tx_data1(fifo_rxaui_tx_data1[SERDES_DATA_W-1:0]),
		       .txdata_serdes0	(txdata_serdes0[SERDES_DATA_W-1:0]));
       
   
endmodule // sip_rxaui_tx_top

// Local Variables:
// verilog-library-directories:( "." "/proj1/galileo101/tomcat/MODELS/current/Model_link/")
// End:

