//------------------------------------------------------------------------------
// Copyright (c) 2013-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_gen_timer_v0.v
//   Module Name:        edma_gen_timer_v0
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description   : This module is a general purpose timer for use many
//                   serdes functions.  It has a programmable width and reset
//                   value.  When the load signal is active, the load_val is
//                   loaded into the timer.  When the count signal is active,
//                   the timer is decremented down to 0, and remains at 0 until
//                   a new value is loaded in.
//
//------------------------------------------------------------------------------


module edma_gen_timer_v0
#(
   parameter
      BIT_WIDTH      = 8,                  // Bit width of the timer.
      RESET_VALUE    = {BIT_WIDTH{1'b0}}   // This value gets loaded into the timer
                                           // when the asynchronous reset_n pin is active.
)
(
   input                  clock,      // Clock.
   input                  reset_n,    // Reset

   input                  load,       // Load the timer with load_val.
   input  [BIT_WIDTH-1:0] load_val,
   input                  count,      // Decrement the timer value.
   output reg             zero        // Active when the timer equals 0.
);

   //-----------------------------------------------------------------------------
   // Internal signal definitions.
   //-----------------------------------------------------------------------------

   reg [BIT_WIDTH-1:0] gen_timer_reg;

   //-----------------------------------------------------------------------------
   // Timer implementation.
   //-----------------------------------------------------------------------------

   always @(posedge clock or negedge reset_n)
   begin
      if (!reset_n)
         gen_timer_reg <= RESET_VALUE;
      else
      begin
         if (load)
            gen_timer_reg <= load_val;
         else if (count)
            if (zero)
               gen_timer_reg <= {BIT_WIDTH{1'b0}};
            else
               gen_timer_reg <= gen_timer_reg - {{BIT_WIDTH-1{1'b0}}, 1'b1};
         else
            gen_timer_reg <= gen_timer_reg;
      end
   end

   //-----------------------------------------------------------------------------
   // Zero bit implementation.
   // Note that this was changed to be implemented with a flop, in order to make
   // timing easier to meet on higher speed designs.
   //-----------------------------------------------------------------------------

   always @(posedge clock or negedge reset_n)
   begin
      if (!reset_n)
         zero <= !(|(RESET_VALUE));
      else
      begin
         if (load)
            zero <= !(|(load_val));
         else if (count)
            if (gen_timer_reg == {{BIT_WIDTH-1{1'b0}}, 1'b1})
               zero <= 1'b1;
            else
               zero <= zero;
         else
            zero <= zero;
      end
   end

endmodule


