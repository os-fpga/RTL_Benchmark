//-----------------------------------------------------------------------------
// Title         :Clock divider Glue
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_clock_divider_by_2_glue.v
// Author        : Lior Valency
// Created       : 21/02/2008 
// Last modified : 21/02/2008 
//-----------------------------------------------------------------------------
// Description : This clock set the value of <dp> and <dn> since we want
// the clock to be divided by 2, <dp> and <dn> should have the same value for
// every cc.
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
module sip_clock_divider_by_2_glue(/*AUTOARG*/
   // Outputs
   clk_div2,
   // Inputs
   reset_, clk
   );

   ///////////////
   // INTERFACE //  
   ///////////////

   // General
   input          reset_;
   input 	  clk;

   // Divider cell interface 
   output 	  clk_div2;

   /////////////////////
   // Regsiter & Wire //
   /////////////////////

   wire 	  clk_div2_inv;
   reg 		  clk_div2;

   ///////////
   // Logic //
   ///////////

   // Devide clock by 2
   assign clk_div2_inv = ~clk_div2;

   ////////
   // FF //
   ////////
   
   always @ (posedge clk or negedge reset_)
     begin
       if(~reset_)
	 begin
	   clk_div2 <= #1 1'b1;
	 end
       else
	 begin
	   clk_div2 <= #1 clk_div2_inv; 
	 end
     end
   
endmodule // sip_clock_divider_by_2_glue
