//-----------------------------------------------------------------------------
// Title         : Cloks and Reset generation
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_rxaui_clk_reset.v
// Author        : Lior Valency
// Created       : 20/02/2008
// Last modified : 20/02/2008
//-----------------------------------------------------------------------------
// Description : This block receive clock from serdes and generate clock for
// port (serdes divided by 2). It also generate reset for all clock domains.
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

module sip_rxaui_clk_reset (/*AUTOARG*/
   // Outputs
   serdes_rx_clk_div2, rx_clk0, rx_clk1, serdes_rx_clk_reset_,
   serdes_rx_clk_div2_reset_, txclk_out, serdes_txclk_in0_reset_,
   serdes_txclk_in1_reset_, serdes_tx_clk_reset_,
   // Inputs
   scan_mode_, reset_, media_interface_mode, serdes_mode,
   serdes_rx_clk, serdes_tx_clk, txclk_in0, txclk_in1
   );
   
   ///////////////
   // INTERFACE // 
   ///////////////

   // General
   input      scan_mode_;
   input      reset_;
   input      media_interface_mode;
   input      serdes_mode;
   
   // Rx Clocks
   input      serdes_rx_clk;
   output     serdes_rx_clk_div2;
   output     rx_clk0;
   output     rx_clk1;

   // Rx reset
   output     serdes_rx_clk_reset_;
   output     serdes_rx_clk_div2_reset_;

   // TX Clocks
   input      serdes_tx_clk;
   input      txclk_in0;
   input      txclk_in1;
   output     txclk_out;

   // Tx Reset
   output     serdes_txclk_in0_reset_;
   output     serdes_txclk_in1_reset_;
   output     serdes_tx_clk_reset_;

   /*AUTO-OUTPUT*/
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

   wire       bypass_divider;
   wire       serdes_tx_clk_div2;
   wire       serdes_rx_clk_reset;
   
   ///////////
   // Logic //
   ///////////

   assign bypass_divider = ((scan_mode_ == 1'b0) | 
			    ((media_interface_mode == 1'b0) && (serdes_mode == 1'b0)));

   ////////////
   // CLOCKS //
   ////////////

   /* sip_clock_divider_by_2 AUTO_TEMPLATE(
    .clk_div2		(serdes_rx_clk_div2),
    .reset_		(serdes_rx_clk_reset_),
    .clk		(serdes_rx_clk),
    )*/
   sip_clock_divider_by_2
     rx_clk_div2(/*AUTOINST*/
		 // Outputs
		 .clk_div2		(serdes_rx_clk_div2),	 // Templated
		 // Inputs
		 .reset_		(serdes_rx_clk_reset_),	 // Templated
		 .clk			(serdes_rx_clk));	 // Templated

   sip_clk_mux rx_clk_mux0(.clk_in0(serdes_rx_clk_div2), .clk_in1(serdes_rx_clk), .selector(bypass_divider), .clk_out(rx_clk0));
   sip_clk_mux rx_clk_mux1(.clk_in0(serdes_rx_clk_div2), .clk_in1(serdes_rx_clk), .selector(bypass_divider), .clk_out(rx_clk1));

   /*sip_clock_divider_by_2 AUTO_TEMPLATE(
    .clk_div2		(serdes_tx_clk_div2),
    .reset_		(serdes_tx_clk_reset_),
    .clk		(serdes_tx_clk),
    )*/
   sip_clock_divider_by_2
     tx_clk_div2(/*AUTOINST*/
		 // Outputs
		 .clk_div2		(serdes_tx_clk_div2),	 // Templated
		 // Inputs
		 .reset_		(serdes_tx_clk_reset_),	 // Templated
		 .clk			(serdes_tx_clk));	 // Templated

   // Interface to the xpcs
   sip_clk_mux xpcs_tx_clk_mux0(.clk_in0(serdes_tx_clk_div2), .clk_in1(serdes_tx_clk), .selector(bypass_divider), .clk_out(txclk_out));
   
   ////////////
   // RESETS //
   ////////////

   /*sip_reset_sync AUTO_TEMPLATE(
    .load_config_	(),
    .reset_out_		(serdes_rx_clk_reset_),
    .reset_chg_		(),
    .clk		(serdes_rx_clk),
    .reset_in_		(reset_),
   )*/
   sip_reset_sync
     rx_clk_reset(/*AUTOINST*/
		  // Outputs
		  .load_config_		(),			 // Templated
		  .reset_out_		(serdes_rx_clk_reset_),	 // Templated
		  .reset_chg_		(),			 // Templated
		  // Inputs
		  .clk			(serdes_rx_clk),	 // Templated
		  .reset_in_		(reset_),		 // Templated
		  .scan_mode_		(scan_mode_));

   /*sip_reset_sync AUTO_TEMPLATE(
    .load_config_	(),
    .reset_out_		(serdes_rx_clk_div2_reset_),
    .reset_chg_		(),
    .clk		(serdes_rx_clk_div2),
    .reset_in_		(reset_),
   )*/
   sip_reset_sync
     rx_clk_div2_reset(/*AUTOINST*/
		       // Outputs
		       .load_config_	(),			 // Templated
		       .reset_out_	(serdes_rx_clk_div2_reset_), // Templated
		       .reset_chg_	(),			 // Templated
		       // Inputs
		       .clk		(serdes_rx_clk_div2),	 // Templated
		       .reset_in_	(reset_),		 // Templated
		       .scan_mode_	(scan_mode_));

   /*sip_reset_sync AUTO_TEMPLATE(
    .load_config_	(),
    .reset_out_		(serdes_tx_clk_reset_),
    .reset_chg_		(),
    .clk		(serdes_tx_clk),
    .reset_in_		(reset_),
   )*/
   sip_reset_sync
     tx_clk_reset(/*AUTOINST*/
		  // Outputs
		  .load_config_		(),			 // Templated
		  .reset_out_		(serdes_tx_clk_reset_),	 // Templated
		  .reset_chg_		(),			 // Templated
		  // Inputs
		  .clk			(serdes_tx_clk),	 // Templated
		  .reset_in_		(reset_),		 // Templated
		  .scan_mode_		(scan_mode_));

   /*sip_reset_sync AUTO_TEMPLATE(
    .load_config_	(),
    .reset_out_		(serdes_txclk_in0_reset_),
    .reset_chg_		(),
    .clk		(txclk_in0),
    .reset_in_		(reset_),
   )*/
   sip_reset_sync
     txclk_in0_reset(/*AUTOINST*/
		     // Outputs
		     .load_config_	(),			 // Templated
		     .reset_out_	(serdes_txclk_in0_reset_), // Templated
		     .reset_chg_	(),			 // Templated
		     // Inputs
		     .clk		(txclk_in0),		 // Templated
		     .reset_in_		(reset_),		 // Templated
		     .scan_mode_	(scan_mode_));

   /*sip_reset_sync AUTO_TEMPLATE(
    .load_config_	(),
    .reset_out_		(serdes_txclk_in1_reset_),
    .reset_chg_		(),
    .clk		(txclk_in1),
    .reset_in_		(reset_),
   )*/
   sip_reset_sync
     txclk_in1_reset(/*AUTOINST*/
		     // Outputs
		     .load_config_	(),			 // Templated
		     .reset_out_	(serdes_txclk_in1_reset_), // Templated
		     .reset_chg_	(),			 // Templated
		     // Inputs
		     .clk		(txclk_in1),		 // Templated
		     .reset_in_		(reset_),		 // Templated
		     .scan_mode_	(scan_mode_));
  
endmodule
// Local Variables:
// verilog-library-directories:( "." "../GenericModules/")
// End:


