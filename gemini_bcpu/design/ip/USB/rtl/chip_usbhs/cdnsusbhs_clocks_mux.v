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
//   Filename:           cdnsusbhs_clocks_mux.v
//   Module Name:        cdnsusbhs_clocks_mux
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
//   Clock mux module
//   M.S.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_clocks_mux
  (
  clk_a,
  clk_b,
  sel,
  clk_o
  );

  input                            clk_a;
  input                            clk_b;
  input                            sel;
  output                           clk_o;
  wire                             clk_o;

`ifdef FPGA_DEMO


  wire                             sel_a;
  wire                             sel_b;



  assign sel_a = ~sel;
  assign sel_b =  sel;



  BUFGCTRL
  fpga_clk_mux
    (
    .I0                                 (clk_a),
    .I1                                 (clk_b),
    .S0                                 (sel_a),
    .S1                                 (sel_b),
    .IGNORE0                            (1'b0),
    .IGNORE1                            (1'b0),
    .CE0                                (1'b1),
    .CE1                                (1'b1),
    .O                                  (clk_o)
    );
`else

`ifdef FL_GENERIC_TECH


  wire                             sel_a;
  wire                             sel_b;
  wire                             clk_a_ok;
  wire                             clk_b_ok;



  assign sel_a = ~sel;
  assign sel_b =  sel;



  assign clk_a_ok = (sel_a) & clk_a;
  assign clk_b_ok = (sel_b) & clk_b;



  assign clk_o    = clk_a_ok | clk_b_ok;
`else

  $fatal("Please instance your actual library component here or define FL_GENERIC_TECH for behavioral model");
`endif
`endif

endmodule
