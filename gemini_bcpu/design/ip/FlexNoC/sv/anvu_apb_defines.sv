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

`ifndef ANVU_APB_DEFINES
`define ANVU_APB_DEFINES


`define ANVU_APB_MAX_WADDR     64
`define ANVU_APB_MAX_WDATA     32
`define ANVU_APB_MAX_WDATAINFO 32
`define ANVU_APB_MAX_WSTRB      4
`define ANVU_APB_MAX_WUSER     32
`define ANVU_APB_MAX_WPROT      3

`define CDN_APB_DATA_WIDTH `ANVU_APB_MAX_WDATA
`define CDN_APB_ADDR_WIDTH `ANVU_APB_MAX_WADDR

`endif // ANVU_APB_DEFINES
