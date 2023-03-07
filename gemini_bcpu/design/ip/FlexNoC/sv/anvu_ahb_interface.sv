// Copyright (c) 2006-2020 Qualcomm Technologies, Inc. All rights reserved.
// This RTL contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this RTL solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this RTL (including any copies)
// to your licensor.
// This RTL or portions thereof are protected under U.S. and foreign patent and patent applications.

`ifndef ANVU_AHB_INTERFACE
`define ANVU_AHB_INTERFACE

`include "anvu_defines.sv"
`include "anvu_ahb_defines.sv"

interface anvu_ahb_if ();
	wire Clk    ;
	wire RstN   ;

	wire                             HSel     ;
	wire [                    1:0]   HTrans   ;
	wire                             HWrite   ;
	wire [                    2:0]   HBurst   ;
	wire [                    2:0]   HSize    ;
	wire [`ANVU_AHB_MAX_WPROT-1:0]   HProt    ;
	wire                             HMastLock;
	wire [`ANVU_AHB_MAX_WADDR-1:0]   HAddr    ;
	wire [`ANVU_AHB_MAX_WDATA-1:0]   HWData   ;
	wire [`ANVU_AHB_MAX_WSTRB-1:0]   HWBe     ;
   	wire [`ANVU_AHB_MAX_WSTRB-1:0]   HBStrb   ;
	wire [                    1:0]   HResp    ;
	wire                             HReady   ;
	wire [`ANVU_AHB_MAX_WDATA-1:0]   HRData   ;
	wire                             HReadySel;
	wire [`ANVU_AHB_MAX_WAUSER-1:0]  ReqUser  ;
	wire [`ANVU_AHB_MAX_WAUSER-1:0]  HAUser   ;
	wire [`ANVU_AHB_MAX_WRUSER-1:0]  HRUser   ;
	wire [`ANVU_AHB_MAX_WUSER-1:0]   HWUser   ;
	wire [`ANVU_AHB_MAX_WMASTER-1:0] HMaster  ;
	wire                             HExcl    ;
	wire                             HExOkay  ;
	wire                             HNonSec  ;

endinterface: anvu_ahb_if

`endif // ANVU_AHB_INTERFACE
