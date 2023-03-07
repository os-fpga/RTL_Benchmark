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

`ifndef ANVU_AXI_INTERFACE
`define ANVU_AXI_INTERFACE

`include "anvu_defines.sv"
`include "anvu_axi_defines.sv"

interface anvu_axi_if ();
	wire Clk    ;
	wire RstN   ;

	wire                             ArValid  ;
	wire                             ArReady  ;
	wire [`ANVU_AXI_MAX_WADDR  -1:0] ArAddr   ;
	wire [`ANVU_AXI_MAX_WID    -1:0] ArId     ;
	wire [`ANVU_AXI_MAX_WLEN   -1:0] ArLen    ;
	wire [                      2:0] ArSize   ;
	wire [                      1:0] ArBurst  ;
	wire [                      1:0] ArLock   ;
	wire [                      3:0] ArCache  ;
	wire [                      2:0] ArProt   ;
	wire [`ANVU_AXI_MAX_WUSER  -1:0] ArUser   ;
	wire [`ANVU_AXI_MAX_WREGION-1:0] ArRegion ;
	wire [`ANVU_AXI_MAX_WQOS   -1:0] ArQos    ;
	wire [                      3:0] ArSnoop  ;
	wire [                      1:0] ArDomain ;
	wire [                      1:0] ArBar    ;

	wire                             AwValid  ;
	wire                             AwReady  ;
	wire [`ANVU_AXI_MAX_WADDR  -1:0] AwAddr   ;
	wire [`ANVU_AXI_MAX_WID    -1:0] AwId     ;
	wire [`ANVU_AXI_MAX_WLEN   -1:0] AwLen    ;
	wire [                      2:0] AwSize   ;
	wire [                      1:0] AwBurst  ;
	wire [                      1:0] AwLock   ;
	wire [                      3:0] AwCache  ;
	wire [                      2:0] AwProt   ;
	wire [`ANVU_AXI_MAX_WUSER  -1:0] AwUser   ;
	wire [`ANVU_AXI_MAX_WREGION-1:0] AwRegion ;
	wire [`ANVU_AXI_MAX_WQOS   -1:0] AwQos    ;
	wire [5                      :0] AwAtop   ;
	wire [                      2:0] AwSnoop  ;
	wire [                      1:0] AwDomain ;
	wire [                      1:0] AwBar    ;

	wire                             WValid   ;
	wire                             WReady   ;
	wire                             WLast    ;
	wire [`ANVU_AXI_MAX_WID    -1:0] WId      ;
	wire [`ANVU_AXI_MAX_WDATA  -1:0] WData    ;
	wire [`ANVU_AXI_MAX_WSTRB  -1:0] WStrb    ;

	wire                             BValid   ;
	wire                             BReady   ;
	wire [`ANVU_AXI_MAX_WID    -1:0] BId      ;
	wire [                      1:0] BResp    ;
	wire [`ANVU_AXI_MAX_WUSER  -1:0] BUser    ;

	wire                             RValid   ;
	wire                             RReady   ;
	wire                             RLast    ;
	wire [`ANVU_AXI_MAX_WID    -1:0] RId      ;
	wire [                      1:0] RResp    ;
	wire [`ANVU_AXI_MAX_WDATA  -1:0] RData    ;
	wire [`ANVU_AXI_MAX_WUSER  -1:0] RUser    ;

endinterface: anvu_axi_if


`endif // ANVU_AXI_INTERFACE
