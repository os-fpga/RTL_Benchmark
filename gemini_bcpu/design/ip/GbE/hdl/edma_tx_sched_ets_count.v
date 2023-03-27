//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_tx_sched_ets_count.v
//   Module Name:        edma_tx_sched_ets_count
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
//   Description    : Counter that generates a toggle signal every time a set
//                    value is reached. This is used to signal to the tx
//                    scheduler that it is time to update ETS credits.
//
//------------------------------------------------------------------------------


module edma_tx_sched_ets_count (

    input       tx_clk,
    input       tx_rst_n,
    input       any_ets_en,
    input       tx_enable,
    input       gigabit,
    output  reg ets_upd_tog
);

  // Internals
  reg   [7:0]   ets_counter;

  always@(posedge tx_clk or negedge tx_rst_n)
  begin
    if (~tx_rst_n)
    begin
      ets_counter <= 8'h00;
      ets_upd_tog <= 1'b0;
    end
    else
      if (~tx_enable | ~any_ets_en)
        ets_counter <= 8'h00;
      else
        if (ets_counter == 8'h00)
        begin
          ets_upd_tog <= ~ets_upd_tog;
          if (gigabit)
            ets_counter <= 8'd99;
          else
            ets_counter <= 8'd199;
        end
        else
          ets_counter <= ets_counter - 8'd1;
  end

endmodule
