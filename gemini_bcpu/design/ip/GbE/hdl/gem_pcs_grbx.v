//------------------------------------------------------------------------------
// Copyright (c) 2015-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pcs_grbx.v
//   Module Name:        gem_pcs_grbx
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
//   Description    : A generic n to 2n-bit gearbox where the output clock is
//                    running at exactly 1/2 input clock and both clocks are
//                    phase aligned.
//
//------------------------------------------------------------------------------


module gem_pcs_grbx
  #( parameter n_width  = 10,
     parameter rst_val  = 10'h057)
(
  input       in_clk,     // Input clock
  input       in_rst_n,   // Active low asynchronous reset
  input       out_clk,    // Output clock at 2x in_clk
  input       out_rst_n,  // Active low asynchronous reset
  input       grbx_en,    // Enable, synchronous to in_clk

  input       [n_width-1:0]
              in_data,    // Input data
  output  reg [(2*n_width)-1:0]
              out_data    // Output data
);

  // Internal signals
  reg   [n_width-1:0] in_data_r1;   // Delayed input data
  reg   [(2*n_width)-1:0]
                      dat_xfer;     // Data to transfer across clock domain
  reg                 dat_tog;      // Toggle to build data
  reg                 out_en;       // Output enable


  // Write side logic simply samples input data and builds dat_xfer as long as
  // grbx_en is enabled.
  always@(posedge in_clk or negedge in_rst_n)
  begin
    if (~in_rst_n)
    begin
      in_data_r1  <= rst_val;
      dat_xfer    <= {2{rst_val}};
      dat_tog     <= 1'b0;
    end
    else
      if (grbx_en)
      begin
        dat_tog <= ~dat_tog;
        if (dat_tog)
          dat_xfer    <= {in_data,in_data_r1};
        else
          in_data_r1  <= in_data;
      end
      else
        dat_tog <= 1'b0;
  end

  // The read side logic samples grbx_en and dat_xfer.
  always@(posedge out_clk or negedge out_rst_n)
  begin
    if (~out_rst_n)
    begin
      out_en    <= 1'b0;
      out_data  <= {2{rst_val}};
    end
    else
    begin
      out_en  <= grbx_en;
      if (out_en)
        out_data  <= dat_xfer;
      else
        out_data  <= {2{rst_val}};
    end
  end


endmodule
