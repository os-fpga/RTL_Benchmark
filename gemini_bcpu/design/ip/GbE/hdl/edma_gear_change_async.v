//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_gear_change_async.v
//   Module Name:        edma_gear_change_async
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
//   Description :
//
// The purpose of this block is to provide a safe mechanism for exchanging a
// single shot pulse between 2 asynchronous clock domains, where the clocks
// can be asynchronous. The design is based on an
// async FIFO, and to be honest an async FIFO could have been instantiated
// directly, but this block has been stripped down to the bare minimum,
// to facilitate passing a single shot pulse from one clock domain to another.
//
//  From fast to slow
//  -----------------
//
//                    _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
//  clk_src         _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
//                    ___                                     ___
//  src             _|   |___________________________________|   |_______________
//                        ___________________________________
//  wptr            _____|                                   |___________________
//                      ____      ____      ____      ____      ____      ____
//  clk_dest        ___|    |____|    |____|    |____|    |____|    |____|    |__
//                                         ______________________________________
//  wptr_sync       ______________________|
//                                                   ____________________________
//  rptr            ________________________________|
//                                         _________
//  dest            ______________________|         |____________________________
//
//  From slow to fast
//  -----------------
//                     ___     ___     ___     ___     ___     ___     ___     ___
//  clk_src         __|   |___|   |___|   |___|   |___|   |___|   |___|   |___|   |_
//                             _______
//  src             __________|       |_____________________________________________
//                                     _____________________________________________
//  wptr            __________________|
//                    _   _   _   _   _   _   _   _   _   _   _   _   _   _   _   _
//  clk_dest        _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |
//                                            _____________________________________
//  wptr_sync       _________________________|
//                                                _________________________________
//  rptr            _____________________________|
//                                            ___
//  dest            _________________________|   |_________________________________
//
//
//
//------------------------------------------------------------------------------
// Limitations    :
//
// The block has been kept pretty simple to minimise the size, so by default there
// is no overflow, etc protection. It's assumed that the data rate will never
// be faster than the clock rate. If overflow protection is however needed
// then a parameter can be set to add overflow protection.
//
//------------------------------------------------------------------------------


module edma_gear_change_async # (
  parameter OVERFLOW_PROTECTION = 1'b0 // Set this if the input rate is
                                       // expected to be faster than the
                                       // output rate at any point.
) (

  // Source signals
  input clk_src,
  input rst_src_n,
  input src,

  // Destination signals
  input clk_dest,
  input rst_dest_n,
  output dest

);

  reg wptr, rptr;

  generate if (OVERFLOW_PROTECTION == 1'b1) begin : gen_wptr_overflow_protection

    wire rptr_sync;

    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rptr  (
      .clk(clk_src),
      .reset_n(rst_src_n),
      .din(rptr),
      .dout(rptr_sync));

    always @(posedge clk_src or negedge rst_src_n)
      if (!rst_src_n)
        wptr <= 1'b0;
      else if (src && (wptr == rptr_sync))
        wptr <= ~wptr;

  end
  endgenerate

  generate if (OVERFLOW_PROTECTION == 1'b0) begin : gen_wptr

    always @(posedge clk_src or negedge rst_src_n)
      if (!rst_src_n)
        wptr <= 1'b0;
      else if (src)
        wptr <= ~wptr;

  end
  endgenerate

  wire wptr_sync;
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_wptr  (
    .clk(clk_dest),
    .reset_n(rst_dest_n),
    .din(wptr),
    .dout(wptr_sync));

  always @(posedge clk_dest or negedge rst_dest_n)
    if (!rst_dest_n)
      rptr <= 1'b0;
    else
      rptr <= wptr_sync;

  assign dest = rptr ^ wptr_sync;

endmodule
