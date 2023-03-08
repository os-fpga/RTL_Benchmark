//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_reg_int.v
//   Module Name:        gem_reg_int
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
//   Description    : Interrupt model for GEM.
//                    Provides standard functionality for a single interrupt
//                    bit. Contains the following:
//                      Mask bit
//                      Interrupt status bit
//                      Test functionality
//                      Support for write clear and read clear modes.
//
//------------------------------------------------------------------------------


module gem_reg_int (
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input               write_int_ena,        // write to interrupt enable reg
  input               write_int_dis,        // write to interrupt disable reg
  input               write_int_mask,       // write to interrupt mask reg
  input               write_int_status,     // write to interrupt status reg
  input               read_int_status,      // read interrupt status reg
  input               int_trigger,          // Trigger pulse for interrupt
  input               pwdata,               // APB write data for relevant bit
  output  reg         int_mask,             // Mask output for reading
  output  reg         int_status            // Interrupt status

);

  parameter p_edma_irq_read_clear = 1'b0;  // Clear interrupt status on read.

  // Mask register
  always @ (posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      int_mask  <= 1'b1;
    else
      if (write_int_ena & pwdata)
        int_mask  <= 1'b0;
      else
        if (write_int_dis & pwdata)
          int_mask  <= 1'b1;
  end

  // Interrupt status
  always @ (posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      int_status <= 1'b0;
    // Write to mask register for software test trigger of interrupt.
    else if (write_int_mask & pwdata)
      int_status <= 1'b1;
    // Set interrupt based on trigger
    else if (int_trigger & ~int_mask)
      int_status <= 1'b1;
    // Clear interrupt either by reading or writing
    else if ((read_int_status  && (p_edma_irq_read_clear == 1)) ||
              (write_int_status && pwdata && (p_edma_irq_read_clear == 0)))
      int_status <= 1'b0;
  end


endmodule
