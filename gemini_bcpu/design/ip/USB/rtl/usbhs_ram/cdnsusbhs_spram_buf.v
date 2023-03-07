//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
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
//   Filename:           cdnsusbhs_spram.stub.v
//   Module Name:        cdnsusbhs_spram
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   On-Chip RAM - ADMA
//   D.K.
//------------------------------------------------------------------------------
`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"

module cdnsusbhs_spram (
  clk,
  addr,
  din,
  we,
  en,
  dout
);

  parameter ADDR_WIDTH   = 32'd`CDNSUSBHS_ADMAMEMORY_WIDTH;
  parameter DATA_WIDTH   = 32'd32;
  parameter MEMORY_DEPTH = 32'd`CDNSUSBHS_ADMAMEMORY_SIZE;

  input                            clk;
  input  [ADDR_WIDTH-1:0]          addr;
  input  [DATA_WIDTH-1:0]          din;
  input                            we;
  input                            en;
  output [DATA_WIDTH-1:0]          dout;

  // wires
  wire [55:0] rd_data;
  wire [55:0] wr_data;
  wire        ce_n;

  // ADMA data buffer
  assign wr_data = { {(56-DATA_WIDTH){1'b0}}, din};
  assign ce_n    = !en;

  assign dout = rd_data[31:0];

  dti_1pr_tm16fcll_128x56_4ww2x_m_shd adma_dbuf_u (
    .VDD   ( 1'b1    ), 
    .VSS   ( 1'b0    ), 
    .DO    ( rd_data ), 
    .A     ( addr    ), 
    .DI    ( wr_data ), 
    .CE_N  ( ce_n    ), 
    .GWE_N ( we      ), 
    .T_RWM ( 3'b011  ), 
    .T_DLY ( 3'b000  ), 
    .CLK   ( clk     )
  );

endmodule
