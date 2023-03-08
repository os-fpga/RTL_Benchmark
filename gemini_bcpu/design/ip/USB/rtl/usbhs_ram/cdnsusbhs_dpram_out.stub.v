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
//   Filename:           cdnsusbhs_dpram_out.stub.v
//   Module Name:        cdnsusbhs_dpram_out
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
//   On-Chip RAM - USBHS endpoint buffer
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_dpram_out
  (
  clka,
  addra,
  dina,
  wea,
  clkb,
  addrb,
  enb,
  dob
  );

  parameter ADDR_WIDTH   = 32'd`CDNSUSBHS_OUTADD;
  parameter DATA_WIDTH   = 32'd32;
  parameter MEMORY_DEPTH = (32'd`CDNSUSBHS_EPOUT_ENDADDR + 32'd1) / 32'd4;

  input                            clka;
  input  [ADDR_WIDTH-1:0]          addra;
  input  [DATA_WIDTH-1:0]          dina;
  input  [DATA_WIDTH/8-1:0]        wea;
  input                            clkb;
  input  [ADDR_WIDTH-1:0]          addrb;
  input                            enb;
  output [DATA_WIDTH-1:0]          dob;

endmodule
