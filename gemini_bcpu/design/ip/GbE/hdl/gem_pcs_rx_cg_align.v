//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pcs_rx_cg_align.v
//   Module Name:        gem_pcs_rx_cg_align
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
//   Description    : Code group alignment module.
//                    Ensures that comma code is aligned to the lower byte
//                    position. This is done by either deleting or repeating
//                    a byte.
//
//------------------------------------------------------------------------------


module gem_pcs_rx_cg_align (
  input               rx_clk,     // Receive clock
  input               n_rxreset,  // Asynchronous active low reset
  input               bypass,     // Bypass alignment function
  input       [19:0]  rx_code,    // Code group comma bit aligned
  output  reg [19:0]  rx_aligned  // Code group aligned
);

  // Comma code definitions.
  parameter   p_com_neg = 10'h17c;
  parameter   p_com_pos = 10'h283;

  // Internals
  wire  [9:0]     code_0;     // First code from rx_code
  wire  [9:0]     code_1;     // Second code from rx_code
  reg   [9:0]     code_1_r1;  // code_1 delayed by 1 cycle
  wire            com_det_0;  // Comma is on code_0
  wire            com_det_1;  // Comma is on code_1
  reg             align_sel;  // Selected alignment


  // Break up input data
  assign code_0 = rx_code[9:0];
  assign code_1 = rx_code[19:10];

  // Comma detection, can be either positive or negative disparity
  assign com_det_0  = (code_0 == p_com_neg) || (code_0 == p_com_pos);
  assign com_det_1  = (code_1 == p_com_neg) || (code_1 == p_com_pos);

  // Delay code_1 by 1 cycle, this allows repeating of the previous code_1 to
  // align comma to lower byte.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      code_1_r1     <= 10'h000;
    else
      if (~bypass)
        code_1_r1     <= code_1;
  end

  // Determine alignment to use on the NEXT clock cycle.
  // This means that we will end up either repeating a comma or deleting a
  // comma depending on current value of align_sel.
  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      align_sel   <= 1'b0;
    else
      if (bypass)
        align_sel <= 1'b0;
      else
        if ((align_sel && com_det_0) || (~align_sel && com_det_1))
          align_sel <= ~align_sel;
  end

  // MUX selection based on align_sel
  always@(*)
  begin
    if (align_sel)
      rx_aligned  = {code_0,code_1_r1};
    else
      rx_aligned  = {code_1,code_0};
  end


endmodule
