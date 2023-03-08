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
//   Filename:           cdnsusbhs_clock_ctrl.v
//   Module Name:        cdnsusbhs_clock_ctrl
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
//   Clock controller
//   K.W.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_clock_ctrl
  (
  scan_en,


  aclk,
  aclk_en,

  aclk_gated
  );

  input                            scan_en;


  input                            aclk;
  input                            aclk_en;

  output                           aclk_gated;
  wire                             aclk_gated;

  reg                              aclk_en_latch;

  `ifdef FL_GENERIC_TECH


  // always @(aclk or aclk_en or scan_en)
  //   begin : ACLK_EN_LATCH_PROC
  //   if (aclk == 1'b0)
  //     begin
  //     aclk_en_latch <= aclk_en | scan_en;
  //     end
  //   end



  // assign aclk_gated = aclk_en_latch & aclk;
  clkgate inst_clkgate (.clk(aclk), .clk_en(aclk_en | scan_en), .clk_out(aclk_gated));


  `else
  $fatal("Please instance your actual library component here or define FL_GENERIC_TECH for behavioral model");
  `endif

endmodule

