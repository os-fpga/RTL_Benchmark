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

`ifndef ANVU_AXI_DEFINES
`define ANVU_AXI_DEFINES

`define ANVU_AXI_MAX_WADDR    64
`define ANVU_AXI_MAX_WID      16
`define ANVU_AXI_MAX_WUSER    256
`define ANVU_AXI_MAX_WLEN      8
`define ANVU_AXI_MAX_WREGION   4
`define ANVU_AXI_MAX_WQOS      4
`define ANVU_AXI_MAX_WDATA   2048
`define ANVU_AXI_MAX_WSTRB  `ANVU_AXI_MAX_WDATA/8

`endif // ANVU_AXI_DEFINES
