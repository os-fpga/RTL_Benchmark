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
//   Filename:           edma_sync_toggle_detect.v
//   Module Name:        edma_sync_toggle_detect
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
// To make code neater and avoid a little bit of bloat this block combines
// the cdnsdru_datasync_v1 and edma_toggle_detect blocks. The block
// synchronises the input into the destination clock domain and pulses the
// output if the input signal toggled.
//
//------------------------------------------------------------------------------


module edma_sync_toggle_detect # (

   parameter RESET_STATE = 1'b0, // What is the default level of the input. The
                                 // reset state should match the default level.
   parameter NUM_FLOPS = 32'd2,  // Number of serial flops in the synchroniser -
                                 // should probably never vary from 2
   parameter DIN_W = 32'd1 // Width of the input bus

) (

   input clk,
   input reset_n,

   input [DIN_W-1:0] din,

   output [DIN_W-1:0] rise_edge, // Rising Edge
   output [DIN_W-1:0] fall_edge, // Falling Edge
   output [DIN_W-1:0] any_edge   // Any Edge

);

   wire [DIN_W-1:0] din_sync;

   cdnsdru_datasync_v1 #(

      .CDNSDRU_DATASYNC_RESET_STATE(RESET_STATE),
      .CDNSDRU_DATASYNC_NUM_FLOPS(NUM_FLOPS),
      .CDNSDRU_DATASYNC_DIN_W(DIN_W)

   ) i_cdnsdru_datasync_v1 (

      .clk(clk),
      .reset_n(reset_n),
      .din(din),
      .dout(din_sync));


   edma_toggle_detect # (

      .RESET_STATE(RESET_STATE),
      .DIN_W(DIN_W)

   ) i_edma_toggle_detect (

      .clk(clk),
      .reset_n(reset_n),
      .din(din_sync),

      .rise_edge(rise_edge),
      .fall_edge(fall_edge),
      .any_edge(any_edge));


endmodule

