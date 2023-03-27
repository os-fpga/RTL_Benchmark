// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps
`include "atcbusdec301_config.vh"
`include "atcbusdec301_const.vh"

module atcbusdec301 (
`ifdef ATCBUSDEC301_SLV1_SUPPORT
	  ds1_awvalid,
	  ds1_awready,
	  ds1_wvalid,
	  ds1_wready,
	  ds1_bresp,
	  ds1_bvalid,
	  ds1_bready,
	  ds1_arvalid,
	  ds1_arready,
	  ds1_rdata,
	  ds1_rresp,
	  ds1_rlast,
	  ds1_rvalid,
	  ds1_rready,
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
	  ds2_awvalid,
	  ds2_awready,
	  ds2_wvalid,
	  ds2_wready,
	  ds2_bresp,
	  ds2_bvalid,
	  ds2_bready,
	  ds2_arvalid,
	  ds2_arready,
	  ds2_rdata,
	  ds2_rresp,
	  ds2_rlast,
	  ds2_rvalid,
	  ds2_rready,
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
	  ds3_awvalid,
	  ds3_awready,
	  ds3_wvalid,
	  ds3_wready,
	  ds3_bresp,
	  ds3_bvalid,
	  ds3_bready,
	  ds3_arvalid,
	  ds3_arready,
	  ds3_rdata,
	  ds3_rresp,
	  ds3_rlast,
	  ds3_rvalid,
	  ds3_rready,
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
	  ds4_awvalid,
	  ds4_awready,
	  ds4_wvalid,
	  ds4_wready,
	  ds4_bresp,
	  ds4_bvalid,
	  ds4_bready,
	  ds4_arvalid,
	  ds4_arready,
	  ds4_rdata,
	  ds4_rresp,
	  ds4_rlast,
	  ds4_rvalid,
	  ds4_rready,
`endif
	  ds_awaddr,
	  ds_awlen,
	  ds_awsize,
	  ds_awburst,
	  ds_awlock,
	  ds_awcache,
	  ds_awprot,
	  ds_wdata,
	  ds_wstrb,
	  ds_wlast,
	  ds_araddr,
	  ds_arlen,
	  ds_arsize,
	  ds_arburst,
	  ds_arlock,
	  ds_arcache,
	  ds_arprot,
	  us_awid,
	  us_awaddr,
	  us_awlen,
	  us_awsize,
	  us_awburst,
	  us_awlock,
	  us_awcache,
	  us_awprot,
	  us_awvalid,
	  us_awready,
	  us_wdata,
	  us_wstrb,
	  us_wlast,
	  us_wvalid,
	  us_wready,
	  us_bid,
	  us_bresp,
	  us_bvalid,
	  us_bready,
	  us_arid,
	  us_araddr,
	  us_arlen,
	  us_arsize,
	  us_arburst,
	  us_arlock,
	  us_arcache,
	  us_arprot,
	  us_arvalid,
	  us_arready,
	  us_rid,
	  us_rdata,
	  us_rresp,
	  us_rlast,
	  us_rvalid,
	  us_rready,
	  aclk,
	  aresetn
);

parameter ADDR_WIDTH = `ATCBUSDEC301_ADDR_WIDTH;

parameter DATA_WIDTH = `ATCBUSDEC301_DATA_WIDTH;

parameter ADDR_DECODE_WIDTH = `ATCBUSDEC301_ADDR_DECODE_WIDTH;

parameter ID_WIDTH = `ATCBUSDEC301_ID_WIDTH;


`ifdef ATCBUSDEC301_SLV1_SUPPORT
parameter SLV1_OFFSET = `ATCBUSDEC301_SLV1_OFFSET;
parameter SLV1_SIZE = `ATCBUSDEC301_SLV1_SIZE;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
parameter SLV2_OFFSET = `ATCBUSDEC301_SLV2_OFFSET;
parameter SLV2_SIZE = `ATCBUSDEC301_SLV2_SIZE;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
parameter SLV3_OFFSET = `ATCBUSDEC301_SLV3_OFFSET;
parameter SLV3_SIZE = `ATCBUSDEC301_SLV3_SIZE;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
parameter SLV4_OFFSET = `ATCBUSDEC301_SLV4_OFFSET;
parameter SLV4_SIZE = `ATCBUSDEC301_SLV4_SIZE;
`endif

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam WSTRB_MSB        = (DATA_WIDTH/8) - 1;
localparam DATA_BITS_MSB    = DATA_WIDTH - 1;
localparam DATA_ADDR_LSB    = (DATA_WIDTH == 256) ? 5 :
                              (DATA_WIDTH == 128) ? 4 :
                              (DATA_WIDTH == 64)  ? 3 : 2;

localparam ID_MSB           = ID_WIDTH - 1;
localparam AXI_DEC_ERR      = 2'b11;
localparam AW_DATA_MSB      = ADDR_MSB + 21;
localparam W_DATA_MSB       = DATA_BITS_MSB + WSTRB_MSB + 2;
localparam AR_DATA_MSB      = ADDR_MSB + 21;
localparam R_DATA_MSB       = DATA_BITS_MSB + 3;
localparam BURST_FIX        = 2'b00;
localparam BURST_INCR       = 2'b01;
localparam BURST_WRAP       = 2'b10;

localparam SLV_SIZE_UNIT = (ADDR_WIDTH == 24) ? 10 : 20;
localparam DECODE_OFFSET_MSB = ADDR_DECODE_WIDTH - 1;


`ifdef ATCBUSDEC301_SLV1_SUPPORT
output                               ds1_awvalid;
input                                ds1_awready;
output                               ds1_wvalid;
input                                ds1_wready;
input                          [1:0] ds1_bresp;
input                                ds1_bvalid;
output                               ds1_bready;
output                               ds1_arvalid;
input                                ds1_arready;
input              [DATA_BITS_MSB:0] ds1_rdata;
input                          [1:0] ds1_rresp;
input                                ds1_rlast;
input                                ds1_rvalid;
output                               ds1_rready;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
output                               ds2_awvalid;
input                                ds2_awready;
output                               ds2_wvalid;
input                                ds2_wready;
input                          [1:0] ds2_bresp;
input                                ds2_bvalid;
output                               ds2_bready;
output                               ds2_arvalid;
input                                ds2_arready;
input              [DATA_BITS_MSB:0] ds2_rdata;
input                          [1:0] ds2_rresp;
input                                ds2_rlast;
input                                ds2_rvalid;
output                               ds2_rready;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
output                               ds3_awvalid;
input                                ds3_awready;
output                               ds3_wvalid;
input                                ds3_wready;
input                          [1:0] ds3_bresp;
input                                ds3_bvalid;
output                               ds3_bready;
output                               ds3_arvalid;
input                                ds3_arready;
input              [DATA_BITS_MSB:0] ds3_rdata;
input                          [1:0] ds3_rresp;
input                                ds3_rlast;
input                                ds3_rvalid;
output                               ds3_rready;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
output                               ds4_awvalid;
input                                ds4_awready;
output                               ds4_wvalid;
input                                ds4_wready;
input                          [1:0] ds4_bresp;
input                                ds4_bvalid;
output                               ds4_bready;
output                               ds4_arvalid;
input                                ds4_arready;
input              [DATA_BITS_MSB:0] ds4_rdata;
input                          [1:0] ds4_rresp;
input                                ds4_rlast;
input                                ds4_rvalid;
output                               ds4_rready;
`endif
output                  [ADDR_MSB:0] ds_awaddr;
output                         [7:0] ds_awlen;
output                         [2:0] ds_awsize;
output                         [1:0] ds_awburst;
output                               ds_awlock;
output                         [3:0] ds_awcache;
output                         [2:0] ds_awprot;
output             [DATA_BITS_MSB:0] ds_wdata;
output                 [WSTRB_MSB:0] ds_wstrb;
output                               ds_wlast;
output                  [ADDR_MSB:0] ds_araddr;
output                         [7:0] ds_arlen;
output                         [2:0] ds_arsize;
output                         [1:0] ds_arburst;
output                               ds_arlock;
output                         [3:0] ds_arcache;
output                         [2:0] ds_arprot;

input                     [ID_MSB:0] us_awid;
input                   [ADDR_MSB:0] us_awaddr;
input                          [7:0] us_awlen;
input                          [2:0] us_awsize;
input                          [1:0] us_awburst;
input                                us_awlock;
input                          [3:0] us_awcache;
input                          [2:0] us_awprot;
input                                us_awvalid;
output                               us_awready;
input              [DATA_BITS_MSB:0] us_wdata;
input                  [WSTRB_MSB:0] us_wstrb;
input                                us_wlast;
input                                us_wvalid;
output                               us_wready;
output                    [ID_MSB:0] us_bid;
output                         [1:0] us_bresp;
output                               us_bvalid;
input                                us_bready;
input                     [ID_MSB:0] us_arid;
input                   [ADDR_MSB:0] us_araddr;
input                          [7:0] us_arlen;
input                          [2:0] us_arsize;
input                          [1:0] us_arburst;
input                                us_arlock;
input                          [3:0] us_arcache;
input                          [2:0] us_arprot;
input                                us_arvalid;
output                               us_arready;
output                    [ID_MSB:0] us_rid;
output             [DATA_BITS_MSB:0] us_rdata;
output                         [1:0] us_rresp;
output                               us_rlast;
output                               us_rvalid;
input                                us_rready;

input                                aclk;
input                                aresetn;

wire                                 ds0_wready;
wire                                 ds0_rlast;
wire                                 ds0_bvalid;
wire               [DATA_BITS_MSB:0] ds0_rdata;
wire                                 ds0_arready;
wire                                 ds0_awready;
wire                                 ds0_awvalid;
wire                                 ds0_bready;
wire                                 ds0_wvalid;
wire                                 ds0_arvalid;
wire                                 ds0_rready;
reg                                  ds0_rvalid;
wire                           [4:0] us_aw_slv_sel;
wire                           [4:0] us_ar_slv_sel;
wire                           [4:0] ds_aw_slv_sel;
wire                           [4:0] ds_w_slv_sel;
wire                           [4:0] ds_ar_slv_sel;
wire                           [4:0] ds_r_slv_sel;
wire                           [4:0] ds_b_slv_sel;
reg                                  ds_awready;
reg                                  ds_wready;
reg                                  ds_bvalid;
reg                                  ds_rvalid;
reg                                  ds_arready;
wire                                 ds_rlast;
wire                                 f_aw_sel_full;
wire                                 f_w_sel_full;
wire                                 f_ar_sel_full;
wire                                 f_b_sel_full;
wire                                 f_r_sel_full;
wire                                 f_aw_sel_empty;
wire                                 f_w_sel_empty;
wire                                 f_ar_sel_empty;
wire                                 f_b_sel_empty;
wire                                 f_r_sel_empty;
wire                                 f_aw_data_full;
wire                                 f_w_data_full;
wire                                 f_ar_data_full;
wire                                 f_b_data_full;
wire                                 f_r_data_full;
wire                                 f_aw_data_empty;
wire                                 f_w_data_empty;
wire                                 f_ar_data_empty;
wire                                 f_b_data_empty;
wire                                 f_r_data_empty;
wire                                 us_aw_valid_trans;
wire                                 us_w_valid_trans;
wire                                 us_b_valid_trans;
wire                                 us_ar_valid_trans;
wire                                 us_r_valid_trans;
wire                                 us_awready;
wire                                 us_wready;
wire                                 us_arready;
wire                                 us_bvalid;
wire                                 us_rvalid;
wire                                 ds_awvalid;
wire                                 ds_wvalid;
wire                                 ds_arvalid;
wire                                 ds_bready;
wire                                 ds_rready;
wire                                 ds_aw_valid_trans;
wire                                 ds_w_valid_trans;
wire                                 ds_w_last_valid_trans;
wire                                 ds_b_valid_trans;
wire                                 ds_ar_valid_trans;
wire                                 ds_r_valid_trans;
wire                                 ds_r_last_valid_trans;
wire                                 wid_fifo_wr;
wire                                 rid_fifo_wr;
wire                                 wid_fifo_rd;
wire                                 rid_fifo_rd;
wire                                 wid_fifo_full;
wire                                 rid_fifo_full;
wire                 [AW_DATA_MSB:0] us_aw_data;
wire                 [AW_DATA_MSB:0] ds_aw_data;
wire                  [W_DATA_MSB:0] us_w_data;
wire                  [W_DATA_MSB:0] ds_w_data;
wire                 [AR_DATA_MSB:0] us_ar_data;
wire                 [AR_DATA_MSB:0] ds_ar_data;
wire               [DATA_BITS_MSB:0] ds_rdata;
wire                           [1:0] ds_rresp;
reg                            [1:0] ds_bresp;
reg                   [R_DATA_MSB:0] ds_r_data;
wire                  [R_DATA_MSB:0] us_r_data;
reg                                  ds0_bresp_pend;
reg                                  ds0_wlast_received;
reg                            [7:0] ds0_burst_count;
reg                            [7:0] ds0_burst_count_nx;
wire                           [1:0] ds0_bresp;
wire                           [1:0] ds0_rresp;

wire                          [31:0] id_register;


`ifdef ATCBUSDEC301_SLV1_SUPPORT
localparam SLV1_OFFSET_LSB = (SLV_SIZE_UNIT + SLV1_SIZE - 1);
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
localparam SLV2_OFFSET_LSB = (SLV_SIZE_UNIT + SLV2_SIZE - 1);
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
localparam SLV3_OFFSET_LSB = (SLV_SIZE_UNIT + SLV3_SIZE - 1);
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
localparam SLV4_OFFSET_LSB = (SLV_SIZE_UNIT + SLV4_SIZE - 1);
`endif
`ifdef ATCBUSDEC301_SLV1_SUPPORT
localparam SLV1_CFG_REG = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV1_OFFSET}  | {1'b0,SLV1_SIZE};
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
localparam SLV2_CFG_REG = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV2_OFFSET}  | {1'b0,SLV2_SIZE};
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
localparam SLV3_CFG_REG = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV3_OFFSET}  | {1'b0,SLV3_SIZE};
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
localparam SLV4_CFG_REG = {{(33-ADDR_DECODE_WIDTH){1'b0}}, SLV4_OFFSET}  | {1'b0,SLV4_SIZE};
`endif

wire ds_aw_slv0_sel = 1'b1;
wire ds_ar_slv0_sel = 1'b1;

`ifdef ATCBUSDEC301_SLV1_SUPPORT
wire us_aw_slv1_sel = us_awvalid & ({us_awaddr[DECODE_OFFSET_MSB:SLV1_OFFSET_LSB], {SLV1_OFFSET_LSB{1'b0}}} == SLV1_OFFSET);
wire us_ar_slv1_sel = us_arvalid & ({us_araddr[DECODE_OFFSET_MSB:SLV1_OFFSET_LSB], {SLV1_OFFSET_LSB{1'b0}}} == SLV1_OFFSET);
wire [32:0] slv1_base_size = SLV1_CFG_REG;
`else
wire us_aw_slv1_sel = 1'b0;
wire us_ar_slv1_sel = 1'b0;
wire [32:0] slv1_base_size = 33'd0;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
wire us_aw_slv2_sel = us_awvalid & ({us_awaddr[DECODE_OFFSET_MSB:SLV2_OFFSET_LSB], {SLV2_OFFSET_LSB{1'b0}}} == SLV2_OFFSET);
wire us_ar_slv2_sel = us_arvalid & ({us_araddr[DECODE_OFFSET_MSB:SLV2_OFFSET_LSB], {SLV2_OFFSET_LSB{1'b0}}} == SLV2_OFFSET);
wire [32:0] slv2_base_size = SLV2_CFG_REG;
`else
wire us_aw_slv2_sel = 1'b0;
wire us_ar_slv2_sel = 1'b0;
wire [32:0] slv2_base_size = 33'd0;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
wire us_aw_slv3_sel = us_awvalid & ({us_awaddr[DECODE_OFFSET_MSB:SLV3_OFFSET_LSB], {SLV3_OFFSET_LSB{1'b0}}} == SLV3_OFFSET);
wire us_ar_slv3_sel = us_arvalid & ({us_araddr[DECODE_OFFSET_MSB:SLV3_OFFSET_LSB], {SLV3_OFFSET_LSB{1'b0}}} == SLV3_OFFSET);
wire [32:0] slv3_base_size = SLV3_CFG_REG;
`else
wire us_aw_slv3_sel = 1'b0;
wire us_ar_slv3_sel = 1'b0;
wire [32:0] slv3_base_size = 33'd0;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
wire us_aw_slv4_sel = us_awvalid & ({us_awaddr[DECODE_OFFSET_MSB:SLV4_OFFSET_LSB], {SLV4_OFFSET_LSB{1'b0}}} == SLV4_OFFSET);
wire us_ar_slv4_sel = us_arvalid & ({us_araddr[DECODE_OFFSET_MSB:SLV4_OFFSET_LSB], {SLV4_OFFSET_LSB{1'b0}}} == SLV4_OFFSET);
wire [32:0] slv4_base_size = SLV4_CFG_REG;
`else
wire us_aw_slv4_sel = 1'b0;
wire us_ar_slv4_sel = 1'b0;
wire [32:0] slv4_base_size = 33'd0;
`endif
wire us_aw_slv5_sel = 1'b0;
wire us_ar_slv5_sel = 1'b0;
wire [32:0] slv5_base_size = 33'd0;

wire us_aw_slv6_sel = 1'b0;
wire us_ar_slv6_sel = 1'b0;
wire [32:0] slv6_base_size = 33'd0;

wire us_aw_slv7_sel = 1'b0;
wire us_ar_slv7_sel = 1'b0;
wire [32:0] slv7_base_size = 33'd0;

wire us_aw_slv8_sel = 1'b0;
wire us_ar_slv8_sel = 1'b0;
wire [32:0] slv8_base_size = 33'd0;

wire us_aw_slv9_sel = 1'b0;
wire us_ar_slv9_sel = 1'b0;
wire [32:0] slv9_base_size = 33'd0;

wire us_aw_slv10_sel = 1'b0;
wire us_ar_slv10_sel = 1'b0;
wire [32:0] slv10_base_size = 33'd0;

wire us_aw_slv11_sel = 1'b0;
wire us_ar_slv11_sel = 1'b0;
wire [32:0] slv11_base_size = 33'd0;

wire us_aw_slv12_sel = 1'b0;
wire us_ar_slv12_sel = 1'b0;
wire [32:0] slv12_base_size = 33'd0;

wire us_aw_slv13_sel = 1'b0;
wire us_ar_slv13_sel = 1'b0;
wire [32:0] slv13_base_size = 33'd0;

wire us_aw_slv14_sel = 1'b0;
wire us_ar_slv14_sel = 1'b0;
wire [32:0] slv14_base_size = 33'd0;

wire us_aw_slv15_sel = 1'b0;
wire us_ar_slv15_sel = 1'b0;
wire [32:0] slv15_base_size = 33'd0;

wire us_aw_slv16_sel = 1'b0;
wire us_ar_slv16_sel = 1'b0;
wire [32:0] slv16_base_size = 33'd0;

wire us_aw_slv17_sel = 1'b0;
wire us_ar_slv17_sel = 1'b0;
wire [32:0] slv17_base_size = 33'd0;

wire us_aw_slv18_sel = 1'b0;
wire us_ar_slv18_sel = 1'b0;
wire [32:0] slv18_base_size = 33'd0;

wire us_aw_slv19_sel = 1'b0;
wire us_ar_slv19_sel = 1'b0;
wire [32:0] slv19_base_size = 33'd0;

wire us_aw_slv20_sel = 1'b0;
wire us_ar_slv20_sel = 1'b0;
wire [32:0] slv20_base_size = 33'd0;

wire us_aw_slv21_sel = 1'b0;
wire us_ar_slv21_sel = 1'b0;
wire [32:0] slv21_base_size = 33'd0;

wire us_aw_slv22_sel = 1'b0;
wire us_ar_slv22_sel = 1'b0;
wire [32:0] slv22_base_size = 33'd0;

wire us_aw_slv23_sel = 1'b0;
wire us_ar_slv23_sel = 1'b0;
wire [32:0] slv23_base_size = 33'd0;

wire us_aw_slv24_sel = 1'b0;
wire us_ar_slv24_sel = 1'b0;
wire [32:0] slv24_base_size = 33'd0;

wire us_aw_slv25_sel = 1'b0;
wire us_ar_slv25_sel = 1'b0;
wire [32:0] slv25_base_size = 33'd0;

wire us_aw_slv26_sel = 1'b0;
wire us_ar_slv26_sel = 1'b0;
wire [32:0] slv26_base_size = 33'd0;

wire us_aw_slv27_sel = 1'b0;
wire us_ar_slv27_sel = 1'b0;
wire [32:0] slv27_base_size = 33'd0;

wire us_aw_slv28_sel = 1'b0;
wire us_ar_slv28_sel = 1'b0;
wire [32:0] slv28_base_size = 33'd0;

wire us_aw_slv29_sel = 1'b0;
wire us_ar_slv29_sel = 1'b0;
wire [32:0] slv29_base_size = 33'd0;

wire us_aw_slv30_sel = 1'b0;
wire us_ar_slv30_sel = 1'b0;
wire [32:0] slv30_base_size = 33'd0;

wire us_aw_slv31_sel = 1'b0;
wire us_ar_slv31_sel = 1'b0;
wire [32:0] slv31_base_size = 33'd0;

assign us_aw_valid_trans     = us_awvalid && us_awready;
assign us_w_valid_trans      = us_wvalid  && us_wready ;
assign us_b_valid_trans      = us_bvalid  && us_bready ;
assign us_ar_valid_trans     = us_arvalid && us_arready;
assign us_r_valid_trans      = us_rvalid  && us_rready ;
assign us_awready            = !f_aw_sel_full &&!f_w_sel_full && !f_b_sel_full && !wid_fifo_full;
assign us_wready             = !f_w_data_full ;
assign us_arready            = !f_ar_sel_full && !f_r_sel_full && !rid_fifo_full;
assign us_bvalid             = !f_b_data_empty;
assign us_rvalid             = !f_r_data_empty;
assign ds_awvalid            = !f_aw_sel_empty;
assign ds_wvalid             = !f_w_sel_empty && !f_w_data_empty;
assign ds_arvalid            = !f_ar_sel_empty;
assign ds_bready             = !f_b_sel_empty && !f_b_data_full;
assign ds_rready             = !f_r_sel_empty && !f_r_data_full;
assign ds_aw_valid_trans     = ds_awvalid && ds_awready;
assign ds_w_valid_trans      = ds_wvalid  && ds_wready ;
assign ds_w_last_valid_trans = ds_wvalid  && ds_wready && ds_wlast;
assign ds_b_valid_trans      = ds_bvalid  && ds_bready ;
assign ds_ar_valid_trans     = ds_arvalid && ds_arready;
assign ds_r_valid_trans      = ds_rvalid  && ds_rready ;
assign ds_r_last_valid_trans = ds_rvalid  && ds_rready && ds_rlast;
assign id_register           = `ATCBUSDEC301_PRODUCT_ID;




assign us_aw_slv_sel = {5{us_aw_slv1_sel}} & 5'd1
                     | {5{us_aw_slv2_sel}} & 5'd2
                     | {5{us_aw_slv3_sel}} & 5'd3
                     | {5{us_aw_slv4_sel}} & 5'd4
                     | {5{us_aw_slv5_sel}} & 5'd5
                     | {5{us_aw_slv6_sel}} & 5'd6
                     | {5{us_aw_slv7_sel}} & 5'd7
                     | {5{us_aw_slv8_sel}} & 5'd8
                     | {5{us_aw_slv9_sel}} & 5'd9
                     | {5{us_aw_slv10_sel}} & 5'd10
                     | {5{us_aw_slv11_sel}} & 5'd11
                     | {5{us_aw_slv12_sel}} & 5'd12
                     | {5{us_aw_slv13_sel}} & 5'd13
                     | {5{us_aw_slv14_sel}} & 5'd14
                     | {5{us_aw_slv15_sel}} & 5'd15
                     | {5{us_aw_slv16_sel}} & 5'd16
                     | {5{us_aw_slv17_sel}} & 5'd17
                     | {5{us_aw_slv18_sel}} & 5'd18
                     | {5{us_aw_slv19_sel}} & 5'd19
                     | {5{us_aw_slv20_sel}} & 5'd20
                     | {5{us_aw_slv21_sel}} & 5'd21
                     | {5{us_aw_slv22_sel}} & 5'd22
                     | {5{us_aw_slv23_sel}} & 5'd23
                     | {5{us_aw_slv24_sel}} & 5'd24
                     | {5{us_aw_slv25_sel}} & 5'd25
                     | {5{us_aw_slv26_sel}} & 5'd26
                     | {5{us_aw_slv27_sel}} & 5'd27
                     | {5{us_aw_slv28_sel}} & 5'd28
                     | {5{us_aw_slv29_sel}} & 5'd29
                     | {5{us_aw_slv30_sel}} & 5'd30
                     | {5{us_aw_slv31_sel}} & 5'd31
                     ;

assign us_ar_slv_sel = {5{us_ar_slv1_sel}} & 5'd1
                     | {5{us_ar_slv2_sel}} & 5'd2
                     | {5{us_ar_slv3_sel}} & 5'd3
                     | {5{us_ar_slv4_sel}} & 5'd4
                     | {5{us_ar_slv5_sel}} & 5'd5
                     | {5{us_ar_slv6_sel}} & 5'd6
                     | {5{us_ar_slv7_sel}} & 5'd7
                     | {5{us_ar_slv8_sel}} & 5'd8
                     | {5{us_ar_slv9_sel}} & 5'd9
                     | {5{us_ar_slv10_sel}} & 5'd10
                     | {5{us_ar_slv11_sel}} & 5'd11
                     | {5{us_ar_slv12_sel}} & 5'd12
                     | {5{us_ar_slv13_sel}} & 5'd13
                     | {5{us_ar_slv14_sel}} & 5'd14
                     | {5{us_ar_slv15_sel}} & 5'd15
                     | {5{us_ar_slv16_sel}} & 5'd16
                     | {5{us_ar_slv17_sel}} & 5'd17
                     | {5{us_ar_slv18_sel}} & 5'd18
                     | {5{us_ar_slv19_sel}} & 5'd19
                     | {5{us_ar_slv20_sel}} & 5'd20
                     | {5{us_ar_slv21_sel}} & 5'd21
                     | {5{us_ar_slv22_sel}} & 5'd22
                     | {5{us_ar_slv23_sel}} & 5'd23
                     | {5{us_ar_slv24_sel}} & 5'd24
                     | {5{us_ar_slv25_sel}} & 5'd25
                     | {5{us_ar_slv26_sel}} & 5'd26
                     | {5{us_ar_slv27_sel}} & 5'd27
                     | {5{us_ar_slv28_sel}} & 5'd28
                     | {5{us_ar_slv29_sel}} & 5'd29
                     | {5{us_ar_slv30_sel}} & 5'd30
                     | {5{us_ar_slv31_sel}} & 5'd31
                     ;


nds_sync_fifo_afe #(.DATA_WIDTH(5),.FIFO_DEPTH(2)) aw_sel_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_aw_valid_trans    ),
	.wr_data   (us_aw_slv_sel        ),
	.rd        (ds_aw_valid_trans    ),
	.rd_data   (ds_aw_slv_sel        ),
	.empty     (f_aw_sel_empty       ),
	.full      (f_aw_sel_full        ),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(5),.FIFO_DEPTH(2)) w_sel_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_aw_valid_trans    ),
	.wr_data   (us_aw_slv_sel        ),
	.rd        (ds_w_last_valid_trans),
	.rd_data   (ds_w_slv_sel         ),
	.empty     (f_w_sel_empty        ),
	.full      (f_w_sel_full         ),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(5),.FIFO_DEPTH(4)) b_sel_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_aw_valid_trans    ),
	.wr_data   (us_aw_slv_sel        ),
	.rd        (ds_b_valid_trans     ),
	.rd_data   (ds_b_slv_sel         ),
	.empty     (f_b_sel_empty        ),
	.full      (f_b_sel_full         ),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(5),.FIFO_DEPTH(2)) ar_sel_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_ar_valid_trans    ),
	.wr_data   (us_ar_slv_sel        ),
	.rd        (ds_ar_valid_trans    ),
	.rd_data   (ds_ar_slv_sel        ),
	.empty     (f_ar_sel_empty       ),
	.full      (f_ar_sel_full        ),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(5),.FIFO_DEPTH(4)) r_sel_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_ar_valid_trans    ),
	.wr_data   (us_ar_slv_sel        ),
	.rd        (ds_r_last_valid_trans),
	.rd_data   (ds_r_slv_sel         ),
	.empty     (f_r_sel_empty        ),
	.full      (f_r_sel_full         ),
	.almost_empty (),
	.almost_full  ()
);


assign us_aw_data = {us_awaddr, us_awlen, us_awsize, us_awburst, us_awlock, us_awcache, us_awprot};
assign {ds_awaddr,ds_awlen, ds_awsize, ds_awburst, ds_awlock, ds_awcache, ds_awprot} = ds_aw_data;

nds_sync_fifo_afe #(.DATA_WIDTH(AW_DATA_MSB+1),.FIFO_DEPTH(2)) aw_data_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_aw_valid_trans    ),
	.wr_data   (us_aw_data           ),
	.rd        (ds_aw_valid_trans    ),
	.rd_data   (ds_aw_data           ),
	.empty     (f_aw_data_empty      ),
	.full      (f_aw_data_full       ),
	.almost_empty (),
	.almost_full  ()
);

assign us_w_data = {us_wdata, us_wstrb, us_wlast};
assign {ds_wdata,ds_wstrb, ds_wlast} = ds_w_data;

nds_sync_fifo_afe #(.DATA_WIDTH(W_DATA_MSB+1),.FIFO_DEPTH(2)) w_data_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (us_w_valid_trans     ),
	.wr_data   (us_w_data            ),
	.rd        (ds_w_valid_trans     ),
	.rd_data   (ds_w_data            ),
	.empty     (f_w_data_empty       ),
	.full      (f_w_data_full        ),
	.almost_empty (),
	.almost_full  ()
);

assign us_ar_data = {us_araddr, us_arlen, us_arsize, us_arburst, us_arlock, us_arcache, us_arprot};
assign {ds_araddr,ds_arlen, ds_arsize, ds_arburst, ds_arlock, ds_arcache, ds_arprot} = ds_ar_data;

nds_sync_fifo_afe #(.DATA_WIDTH(AR_DATA_MSB+1),.FIFO_DEPTH(2)) ar_data_fifo(
	.clk       (aclk                  ),
	.reset_n   (aresetn               ),
	.wr        (us_ar_valid_trans     ),
	.wr_data   (us_ar_data            ),
	.rd        (ds_ar_valid_trans     ),
	.rd_data   (ds_ar_data            ),
	.empty     (f_ar_data_empty       ),
	.full      (f_ar_data_full        ),
	.almost_empty (),
	.almost_full  ()
);

assign {ds_rdata,ds_rresp, ds_rlast} = ds_r_data;
assign {us_rdata, us_rresp, us_rlast} = us_r_data;

nds_sync_fifo_afe #(.DATA_WIDTH(R_DATA_MSB+1),.FIFO_DEPTH(2)) r_data_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (ds_r_valid_trans     ),
	.wr_data   (ds_r_data            ),
	.rd        (us_r_valid_trans     ),
	.rd_data   (us_r_data            ),
	.empty     (f_r_data_empty       ),
	.full      (f_r_data_full        ),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(2),.FIFO_DEPTH(2)) b_data_fifo(
	.clk       (aclk                 ),
	.reset_n   (aresetn              ),
	.wr        (ds_b_valid_trans     ),
	.wr_data   (ds_bresp             ),
	.rd        (us_b_valid_trans     ),
	.rd_data   (us_bresp             ),
	.empty     (f_b_data_empty       ),
	.full      (f_b_data_full        ),
	.almost_empty (),
	.almost_full  ()
);



assign ds0_awvalid       = (ds_aw_slv_sel == 5'd0) & ds_awvalid;
assign ds0_bready        = (ds_b_slv_sel  == 5'd0) & ds_bready;
assign ds0_wvalid        = (ds_w_slv_sel  == 5'd0) & ds_wvalid;
assign ds0_arvalid       = (ds_ar_slv_sel == 5'd0) & ds_arvalid;
assign ds0_rready        = (ds_r_slv_sel  == 5'd0) & ds_rready;
`ifdef ATCBUSDEC301_SLV1_SUPPORT
assign ds1_awvalid       = (ds_aw_slv_sel == 5'd1) & ds_awvalid;
assign ds1_wvalid        = (ds_w_slv_sel  == 5'd1) & ds_wvalid;
assign ds1_arvalid       = (ds_ar_slv_sel == 5'd1) & ds_arvalid;
assign ds1_bready        = (ds_b_slv_sel  == 5'd1) & ds_bready;
assign ds1_rready        = (ds_r_slv_sel  == 5'd1) & ds_rready;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
assign ds2_awvalid       = (ds_aw_slv_sel == 5'd2) & ds_awvalid;
assign ds2_wvalid        = (ds_w_slv_sel  == 5'd2) & ds_wvalid;
assign ds2_arvalid       = (ds_ar_slv_sel == 5'd2) & ds_arvalid;
assign ds2_bready        = (ds_b_slv_sel  == 5'd2) & ds_bready;
assign ds2_rready        = (ds_r_slv_sel  == 5'd2) & ds_rready;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
assign ds3_awvalid       = (ds_aw_slv_sel == 5'd3) & ds_awvalid;
assign ds3_wvalid        = (ds_w_slv_sel  == 5'd3) & ds_wvalid;
assign ds3_arvalid       = (ds_ar_slv_sel == 5'd3) & ds_arvalid;
assign ds3_bready        = (ds_b_slv_sel  == 5'd3) & ds_bready;
assign ds3_rready        = (ds_r_slv_sel  == 5'd3) & ds_rready;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
assign ds4_awvalid       = (ds_aw_slv_sel == 5'd4) & ds_awvalid;
assign ds4_wvalid        = (ds_w_slv_sel  == 5'd4) & ds_wvalid;
assign ds4_arvalid       = (ds_ar_slv_sel == 5'd4) & ds_arvalid;
assign ds4_bready        = (ds_b_slv_sel  == 5'd4) & ds_bready;
assign ds4_rready        = (ds_r_slv_sel  == 5'd4) & ds_rready;
`endif

always @* begin
	case (ds_aw_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_awready = ds1_awready;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_awready = ds2_awready;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_awready = ds3_awready;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_awready = ds4_awready;
`endif
		default: ds_awready = ds0_awready;
	endcase
end

always @* begin
	case (ds_w_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_wready = ds1_wready;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_wready = ds2_wready;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_wready = ds3_wready;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_wready = ds4_wready;
`endif
		default: ds_wready = ds0_wready;
	endcase
end

always @* begin
	case (ds_ar_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_arready = ds1_arready;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_arready = ds2_arready;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_arready = ds3_arready;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_arready = ds4_arready;
`endif
		default: ds_arready = ds0_arready;
	endcase
end

always @* begin
	case (ds_b_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_bvalid = ds1_bvalid;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_bvalid = ds2_bvalid;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_bvalid = ds3_bvalid;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_bvalid = ds4_bvalid;
`endif
		default: ds_bvalid = ds0_bvalid;
	endcase
end

always @* begin
	case (ds_r_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_rvalid = ds1_rvalid;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_rvalid = ds2_rvalid;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_rvalid = ds3_rvalid;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_rvalid = ds4_rvalid;
`endif
		default: ds_rvalid = ds0_rvalid;
	endcase
end




always @* begin
	case (ds_r_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_r_data = {ds1_rdata, ds1_rresp, ds1_rlast};
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_r_data = {ds2_rdata, ds2_rresp, ds2_rlast};
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_r_data = {ds3_rdata, ds3_rresp, ds3_rlast};
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_r_data = {ds4_rdata, ds4_rresp, ds4_rlast};
`endif
		default: ds_r_data = {ds0_rdata, ds0_rresp, ds0_rlast};
	endcase
end

always @* begin
	case (ds_b_slv_sel)
`ifdef ATCBUSDEC301_SLV1_SUPPORT
		5'd1: ds_bresp = ds1_bresp;
`endif
`ifdef ATCBUSDEC301_SLV2_SUPPORT
		5'd2: ds_bresp = ds2_bresp;
`endif
`ifdef ATCBUSDEC301_SLV3_SUPPORT
		5'd3: ds_bresp = ds3_bresp;
`endif
`ifdef ATCBUSDEC301_SLV4_SUPPORT
		5'd4: ds_bresp = ds4_bresp;
`endif
		default: ds_bresp = ds0_bresp;
	endcase
end


assign wid_fifo_wr = us_awvalid & us_awready;
assign rid_fifo_wr = us_arvalid & us_arready;
assign wid_fifo_rd = us_bvalid  & us_bready;
assign rid_fifo_rd = us_rvalid  & us_rready & us_rlast;

nds_sync_fifo_afe #(.DATA_WIDTH(ID_MSB+1),.FIFO_DEPTH(4)) wid_fifo(
	.clk       (aclk        ),
	.reset_n   (aresetn     ),
	.wr        (wid_fifo_wr ),
	.wr_data   (us_awid     ),
	.rd        (wid_fifo_rd ),
	.rd_data   (us_bid      ),
	.full      (wid_fifo_full),
	.empty        (),
	.almost_empty (),
	.almost_full  ()
);

nds_sync_fifo_afe #(.DATA_WIDTH(ID_MSB+1),.FIFO_DEPTH(4)) rid_fifo(
	.clk       (aclk        ),
	.reset_n   (aresetn     ),
	.wr        (rid_fifo_wr ),
	.wr_data   (us_arid     ),
	.rd        (rid_fifo_rd ),
	.rd_data   (us_rid      ),
	.full      (rid_fifo_full),
	.empty        (),
	.almost_empty (),
	.almost_full  ()
);


always @(posedge aclk or negedge aresetn) begin
	if (~aresetn) begin
		ds0_bresp_pend <= 1'b0;
	end
	else if (ds0_awvalid && ds0_awready) begin
		ds0_bresp_pend <= 1'b1;
	end
	else if (ds0_bready && ds0_bvalid) begin
		ds0_bresp_pend <= 1'b0;
	end
end


	`ifdef ATCBUSDEC301_OOR_ERR_EN
		assign ds0_bresp = AXI_DEC_ERR;
	`else
		assign ds0_bresp = 2'd0;
	`endif



always @(posedge aclk or negedge aresetn) begin
	if (~aresetn) begin
		ds0_wlast_received <= 1'b0;
	end
	else if (ds0_wready && ds0_wvalid && ds_wlast) begin
		ds0_wlast_received <= 1'b1;
	end
	else if (ds0_bready && ds0_bvalid) begin
		ds0_wlast_received <= 1'b0;
	end
end

assign ds0_bvalid   = ds0_wlast_received;
assign ds0_awready  = !ds0_bresp_pend || (ds0_bready && ds0_bvalid);
assign ds0_wready   = !ds0_wlast_received || (ds0_bready && ds0_bvalid);

always @(posedge aclk or negedge aresetn) begin
	if (~aresetn)
		ds0_burst_count <= 8'd0;
	else
		ds0_burst_count <= ds0_burst_count_nx;
end

always @* begin
	if (ds0_arvalid && ds0_arready)
		ds0_burst_count_nx = ds_arlen;
	else if (ds0_burst_count == 8'd0)
		ds0_burst_count_nx = 8'd0;
	else if (ds0_rvalid && ds0_rready)
		ds0_burst_count_nx = ds0_burst_count - 8'd1;
	else
		ds0_burst_count_nx = ds0_burst_count;
end

assign ds0_rlast = (ds0_burst_count == 8'd0) && ds0_rvalid;

always @(posedge aclk or negedge aresetn) begin
	if (~aresetn) begin
		ds0_rvalid  <= 1'b0;
	end
	else if (ds0_arvalid && ds0_arready) begin
		ds0_rvalid  <= 1'b1;
	end
	else if (ds0_rlast && ds0_rvalid && ds0_rready) begin
		ds0_rvalid  <= 1'b0;
	end
end

assign ds0_arready = ~ds0_rvalid | (ds0_rready & ds0_rlast);




	`ifdef ATCBUSDEC301_OOR_ERR_EN
		assign ds0_rresp = AXI_DEC_ERR;
	`else
		assign ds0_rresp = 2'd0;
	`endif









assign ds0_rdata  = {(DATA_BITS_MSB+1){1'd0}};



endmodule
