// =============================================================================
//  Unpublished work. Copyright 2021 Siemens           
//  This material contains trade secrets or otherwise    
//  confidential information owned by Siemens Industry Software Inc.
//  or its affiliates (collectively, "SISW"), or its licensors.
//  Access to and use of this information is strictly limited as
//  set forth in the Customer's applicable agreements with SISW.
//
//  THIS FILE MAY NOT BE MODIFIED, DISCLOSED, COPIED OR DISTRIBUTED WITHOUT THE
//  EXPRESSED WRITTEN CONSENT OF PRO DESIGN.
//
// =============================================================================
//!  @project      proFPGA
// =============================================================================
//!  @file         profpga_sync_ipad.v
//!  @author       Sebastian Fluegel
//!  @brief        proFPGA clock sync receiver and transmitter modules
//!
// =============================================================================

`timescale 1ns/1ps

// === profpga SYNC transmitter ===



// === SYNC Input pad (technology-dependent) ===
module profpga_sync_ipad 
(
 input wire clk_pad,
 input wire clk_core,
 input wire sync_p_i,
 input wire sync_n_i,
 output reg sync_o
 );
   
   parameter CLK_CORE_COMPENSATION = "DELAYED";  // "DELAYED", "ZHOLD", "DELAYED_XVUS"
   
   //  (* IOB = (CLK_CORE_COMPENSATION == "DELAYED" ? "FALSE" : "TRUE") *)
   wire     sync_pad;
   reg 	    sync_r1, sync_r2;
   reg 	    sync_r;
   wire     clk_pad_sel;
   wire     clk_pad_delay;
   
//-------------------------------------------
// FPGA Vendor dependent primitives/modules
//-------------------------------------------
`include "profpga_sync_ipad.vh"

//-------------------------------------------
// Generic part of module
//-------------------------------------------
   // sample in IOB register
   assign #1 clk_pad_delay = clk_pad; // simulate some delay as caused by actual hardware
   
   assign clk_pad_sel = (CLK_CORE_COMPENSATION=="ZHOLD" ? 
			 clk_core :                 // sampling on falling edge of compensated clock
			 ~clk_pad_delay );          // sampling on rising edge of low-delay clock
   
   always @ (negedge(clk_pad_sel)) sync_r1 <= sync_pad;
   always @ (posedge(clk_pad_sel)) sync_r2 <= sync_r1;
   
   // transfer to internal clock 
   always @ (posedge(clk_core)) 
     begin
	// switch clock domains
	sync_r <= CLK_CORE_COMPENSATION=="DELAYED_XVUS" ? sync_r2 : sync_r1;
	sync_o <= sync_r;   // additional pipeline register to ease timing
     end
   
endmodule
