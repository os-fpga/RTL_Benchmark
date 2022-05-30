//-----------------------------------------------------------------------------
// Title         :Clock divider by 2
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_clock_divider_by_2.v
// Author        : Lior Valency
// Created       : 21/02/2008 
// Last modified : 21/02/2008 
//-----------------------------------------------------------------------------
// Description :The purpose of this block is to divide the input clock by 2, it
// use <MSIL_0065G_PDCKDIV> cell so the clock will be balanced. // <dp> and <dn>
// are generate from reguler divider (by 2).
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
module sip_clock_divider_by_2(/*AUTOARG*/
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
   output 	  clk_div2;

   //////////////////////////////
   // Internal Regsiter & Wire //
   //////////////////////////////

   wire 	  dp_dn;

   ///////////
   // Logic //
   ///////////

   /* sip_clock_divider_by_2_glue AUTO_TEMPLATE (
    .clk_div2 (dp_dn),
    );*/
   sip_clock_divider_by_2_glue
     sip_clock_divider_by_2_glue(/*AUTOINST*/
				 // Outputs
				 .clk_div2		(dp_dn),	 // Templated
				 // Inputs
				 .reset_		(reset_),
				 .clk			(clk));
       
   // Use this cell clock will be balaned.
   sip_clock_divider clock_divider
     (
      // Outputs
      .clk_out  (clk_div2),
      // Inputs
      .clk_in   (clk),
      .dn       (dp_dn),
      .dp       (dp_dn),
      .reset_n  (reset_));
  
endmodule // sip_clock_divider_by_2

 
