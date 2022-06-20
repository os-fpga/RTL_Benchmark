//-----------------------------------------------------------------------------
// Title         : Cloks and Reset generation
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_generic_module_lib.v
// Author        : Lior Valency
// Created       : 20/02/2008
// Last modified : 20/02/2008
//-----------------------------------------------------------------------------
// Description : This module is library of all cells writen in behaouvral.
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

// Clock Mux
module sip_clk_mux(/*AUTOARG*/
   // Outputs
   clk_out,
   // Inputs
   clk_in0, clk_in1, selector
   );

   ///////////////
   // INTERFACE //
   ///////////////
   
   input  clk_in0;
   input  clk_in1;
   input  selector;
   output clk_out;

   ///////////
   // LOGIC //
   ///////////

   assign clk_out = (selector == 1'b0) ? clk_in0 : clk_in1; 
   
endmodule

// Clock divider
module sip_clock_divider(/*AUTOARG*/
   // Outputs
   clk_out,
   // Inputs
   clk_in, dn, dp, reset_n
   );

   ///////////////
   // INTERFACE //
   ///////////////

   input    clk_in;
   input    dn;
   input    dp;
   input    reset_n;
   output   clk_out;

   ////////////////////////////////
   // INTERNAL WIRES & REGISTERS //
   ////////////////////////////////

   reg 	    qn;
   reg 	    qp;
  
   
   ///////////
   // LOGIC //
   ///////////

   assign   clk_out = (clk_in == 1'b0) ? qn : qp;
   
   ////////
   // FF //
   ////////

   always @(posedge clk_in or negedge reset_n)
     begin
       if(reset_n == 1'b0)
	 begin
	   qn <= #1 1'b0;
	 end
       else
	 begin
	   qn <= #1 dn;
	 end
     end // always @ (posedge clk_in or negedge reset_n)

   always @(negedge clk_in or negedge reset_n)
     begin
       if(reset_n == 1'b0)
	 begin
	   qp <= #1 1'b0;
	 end
       else
	 begin
	   qp <= #1 dp;
	 end
     end // always @ (negedge clk_in or negedge reset_n)

   
   
endmodule // sip_clock_divider


		     
  
