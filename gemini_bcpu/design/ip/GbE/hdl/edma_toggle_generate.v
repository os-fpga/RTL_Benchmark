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
//   Filename:           edma_toggle_generate.v
//   Module Name:        edma_toggle_generate
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
// Incredbly simple block to effetively keep code tidy and to stop reproducing
// the same code. The block simply toggles the output when the input is high.
//
//------------------------------------------------------------------------------


module edma_toggle_generate # (

   parameter RESET_STATE = 1'b0, // Define the default state of the output.
   parameter MODE_EARLY = 1'b0,  // By defaul the output is registered. However,
                                     // it's possible to use an early mode, where the
                                     // output will be generated combinatorially. The
                                     // toggle output will therefore change on the
                                     // same cycle as the input.
   parameter DIN_W = 32'd1           // Width of the input bus

) (

   input clk,
   input reset_n,

   input [DIN_W-1:0] din,
   output reg [DIN_W-1:0] dout

);

   reg [DIN_W-1:0] toggle;

   genvar i;
   generate for (i=0; i<DIN_W[31:0]; i = i+1) begin : gen_toggle

      always @(posedge clk or negedge reset_n)
         if (~reset_n)
            toggle[i] <= RESET_STATE;
         else if (din[i])
            toggle[i] <= ~toggle[i];

      always @(*)
         if (!MODE_EARLY)
            dout[i] = toggle[i];
         else
            dout[i] = (din[i]) ? ~toggle[i] : toggle[i];

   end
   endgenerate


endmodule


