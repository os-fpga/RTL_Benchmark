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

`ifndef ANVU_APB_INTERFACE
`define ANVU_APB_INTERFACE

`include "anvu_defines.sv"
`include "anvu_apb_defines.sv"

interface anvu_apb_if ();
	wire Clk    ;
	wire RstN   ;

	wire                               PSel      ;
	wire                               PEnable   ;
	wire [`ANVU_APB_MAX_WADDR    -1:0] PAddr     ;
	wire                               PWrite    ; 
	wire [`ANVU_APB_MAX_WDATA    -1:0] PWData    ;
	wire [`ANVU_APB_MAX_WDATAINFO-1:0] PWDataInfo;
	wire [`ANVU_APB_MAX_WDATA    -1:0] PRData    ;
	wire [`ANVU_APB_MAX_WDATAINFO-1:0] PRDataInfo;
	wire                               PReady    ;
	wire                               PSlvErr   ;
	wire [`ANVU_APB_MAX_WSTRB    -1:0] PStrb     ;
	wire [`ANVU_APB_MAX_WPROT    -1:0] PProt     ;
	wire [`ANVU_APB_MAX_WUSER    -1:0] ReqUser   ;

endinterface: anvu_apb_if

`endif // ANVU_APB_INTERFACE
