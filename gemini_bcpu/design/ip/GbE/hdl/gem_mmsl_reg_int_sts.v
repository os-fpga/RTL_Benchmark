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
//   Filename:           gem_mmsl_reg_int_sts.v
//   Module Name:        gem_mmsl_reg_int_sts
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
//   Description   :
//
//------------------------------------------------------------------------------


module gem_mmsl_reg_int_sts (
  input                 pclk,
  input                 n_preset,
  input                 write_registers,
  input                 read_registers,
  input       [5:0]     paddr,
  input       [5:0]     pwdata,
  input                 p_active,
  input       [2:0]     verify_status,
  input                 respond_status,
  input       [5:0]     error_status,
  output      [31:0]    mmsl_status,
  output  reg [5:0]     int_status,
  output  reg [5:0]     int_mask,
  output                mmsl_int
);

  parameter MMSL_STATUS     = 6'h01;
  parameter MMSL_INT_STATUS = 6'h06;
  parameter MMSL_INT_EN     = 6'h07;
  parameter MMSL_INT_DIS    = 6'h08;
  parameter MMSL_INT_MASK   = 6'h09;

  parameter p_edma_irq_read_clear  = 1'b0; // Configure whether interrupts are cleared on read

  // Internals
  reg   [5:0] error_status_hold;
  wire        write_int_status;
  wire        read_int_status;
  wire        write_int_en;
  wire        write_int_dis;
  wire        write_int_mask;

  // some of the bits constituting the mmsl_status
  // register need to be held until they're read.
  // if an error happens while reading, this will
  // not clear the register as it needs to keep
  // track of it.
  always @ (posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      error_status_hold  <= 6'h00;
    else
      if(read_registers && (paddr == MMSL_STATUS))
        error_status_hold  <= 6'h00;
      else
        error_status_hold  <= error_status_hold | error_status;
  end

  assign mmsl_status = {21'd0,              // 31:11
                        error_status  |     // 10:5
                        error_status_hold,
                        verify_status,      // 4:2
                        respond_status,     // 1
                        p_active};          // 0

  // Interrupt managment
  assign write_int_status = write_registers && (paddr == MMSL_INT_STATUS);
  assign read_int_status  = read_registers  && (paddr == MMSL_INT_STATUS);
  assign write_int_en     = write_registers && (paddr == MMSL_INT_EN);
  assign write_int_dis    = write_registers && (paddr == MMSL_INT_DIS);
  assign write_int_mask   = write_registers && (paddr == MMSL_INT_MASK);

  // Writing the enable/disable for the interrupts:
  always @ (posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      int_mask <= 6'h3f;
    else
      if(write_int_dis)
        int_mask <= int_mask | pwdata[5:0];
      else if(write_int_en)
        int_mask <= int_mask & ~pwdata[5:0];
  end

  // setting the appropriate bit of the int_status register
  // when its related event happens, for all the bits of the status_register

  genvar loop_int;
  generate for (loop_int = 0; loop_int < 6; loop_int = loop_int + 1) begin : gen_loop_int
    always @ (posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        int_status[loop_int]  <= 1'b0;
      else
        if(write_int_mask && pwdata[loop_int])
          int_status[loop_int]  <= 1'b1;
        else
          if(error_status[loop_int] && ~int_mask[loop_int])
            int_status[loop_int]  <= 1'b1;
          else if((read_int_status && (p_edma_irq_read_clear == 1'b1)) ||
                  (write_int_status && pwdata[loop_int] && (p_edma_irq_read_clear == 1'b0)))
            int_status[loop_int]  <= 1'b0;
    end
  end
  endgenerate

  assign mmsl_int = |int_status;

endmodule
