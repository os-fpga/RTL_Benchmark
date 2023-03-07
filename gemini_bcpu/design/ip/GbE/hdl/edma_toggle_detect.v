//------------------------------------------------------------------------------
// Copyright (c) 2012-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_toggle_detect.v
//   Module Name:        edma_toggle_detect
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
//   Description    :
//
// The purpose of this module is to provide a simple block that will detect
// a toggle on the input, wether this is rising, falling or any edge. The
// rising, falling and edge outputs are provided by default, and if these are
// not necessary then not connecting to them will cause synthesis to remove
// them.
//
// The reset level of the sample flops can also be changed to match the
// default state of the inputs.
//
//------------------------------------------------------------------------------


module edma_toggle_detect # (

   parameter RESET_STATE = 1'b0, // What is the default level of the input. The
                                     // reset state should match the default level.
   parameter DIN_W = 32'd1 // Width of the input bus

) (

   input clk,
   input reset_n,

   input [DIN_W-1:0] din,

   output reg [DIN_W-1:0] rise_edge, // Rising Edge
   output reg [DIN_W-1:0] fall_edge, // Falling Edge
   output reg [DIN_W-1:0] any_edge   // Any Edge

);


   //-----------------------------------------------------------------------
   // Internal registers

   reg [DIN_W-1:0] din_reg;


   //-----------------------------------------------------------------------
   // Sample the input signals and generate the OVERWEIGHT edge detect
   // signals. The OVERWEIGHT signals may not be used, but they still need
   // generated.

   always @(posedge clk or negedge reset_n)
      if (~reset_n)
         din_reg <= {DIN_W{RESET_STATE}};
      else
         din_reg <= din;


   //-----------------------------------------------------------------------
   // Generate the outputs.
   // Synthesis will strip out the unused options

   always @(*) begin
      rise_edge = ~din_reg &  din;
      fall_edge =  din_reg & ~din;
      any_edge  =  din_reg ^  din;
   end


endmodule

