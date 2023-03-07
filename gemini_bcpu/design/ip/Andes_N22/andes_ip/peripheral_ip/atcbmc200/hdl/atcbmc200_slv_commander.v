// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"


module atcbmc200_slv_commander (
`ifdef ATCBMC200_AHB_MST0
	  hm0_hwdata,
	  mst0_ack,
	  mst0_haddr,
	  mst0_hburst,
	  mst0_hprot,
	  mst0_hsize,
	  mst0_htrans,
	  mst0_hwrite,
	  mst0_req,
`endif
`ifdef ATCBMC200_AHB_MST1
	  hm1_hwdata,
	  mst1_ack,
	  mst1_haddr,
	  mst1_hburst,
	  mst1_hprot,
	  mst1_hsize,
	  mst1_htrans,
	  mst1_hwrite,
	  mst1_req,
`endif
`ifdef ATCBMC200_AHB_MST2
	  hm2_hwdata,
	  mst2_ack,
	  mst2_haddr,
	  mst2_hburst,
	  mst2_hprot,
	  mst2_hsize,
	  mst2_htrans,
	  mst2_hwrite,
	  mst2_req,
`endif
`ifdef ATCBMC200_AHB_MST3
	  hm3_hwdata,
	  mst3_ack,
	  mst3_haddr,
	  mst3_hburst,
	  mst3_hprot,
	  mst3_hsize,
	  mst3_htrans,
	  mst3_hwrite,
	  mst3_req,
`endif
`ifdef ATCBMC200_AHB_MST4
	  hm4_hwdata,
	  mst4_ack,
	  mst4_haddr,
	  mst4_hburst,
	  mst4_hprot,
	  mst4_hsize,
	  mst4_htrans,
	  mst4_hwrite,
	  mst4_req,
`endif
`ifdef ATCBMC200_AHB_MST5
	  hm5_hwdata,
	  mst5_ack,
	  mst5_haddr,
	  mst5_hburst,
	  mst5_hprot,
	  mst5_hsize,
	  mst5_htrans,
	  mst5_hwrite,
	  mst5_req,
`endif
`ifdef ATCBMC200_AHB_MST6
	  hm6_hwdata,
	  mst6_ack,
	  mst6_haddr,
	  mst6_hburst,
	  mst6_hprot,
	  mst6_hsize,
	  mst6_htrans,
	  mst6_hwrite,
	  mst6_req,
`endif
`ifdef ATCBMC200_AHB_MST7
	  hm7_hwdata,
	  mst7_ack,
	  mst7_haddr,
	  mst7_hburst,
	  mst7_hprot,
	  mst7_hsize,
	  mst7_htrans,
	  mst7_hwrite,
	  mst7_req,
`endif
`ifdef ATCBMC200_AHB_MST8
	  hm8_hwdata,
	  mst8_ack,
	  mst8_haddr,
	  mst8_hburst,
	  mst8_hprot,
	  mst8_hsize,
	  mst8_htrans,
	  mst8_hwrite,
	  mst8_req,
`endif
`ifdef ATCBMC200_AHB_MST9
	  hm9_hwdata,
	  mst9_ack,
	  mst9_haddr,
	  mst9_hburst,
	  mst9_hprot,
	  mst9_hsize,
	  mst9_htrans,
	  mst9_hwrite,
	  mst9_req,
`endif
`ifdef ATCBMC200_AHB_MST10
	  hm10_hwdata,
	  mst10_ack,
	  mst10_haddr,
	  mst10_hburst,
	  mst10_hprot,
	  mst10_hsize,
	  mst10_htrans,
	  mst10_hwrite,
	  mst10_req,
`endif
`ifdef ATCBMC200_AHB_MST11
	  hm11_hwdata,
	  mst11_ack,
	  mst11_haddr,
	  mst11_hburst,
	  mst11_hprot,
	  mst11_hsize,
	  mst11_htrans,
	  mst11_hwrite,
	  mst11_req,
`endif
`ifdef ATCBMC200_AHB_MST12
	  hm12_hwdata,
	  mst12_ack,
	  mst12_haddr,
	  mst12_hburst,
	  mst12_hprot,
	  mst12_hsize,
	  mst12_htrans,
	  mst12_hwrite,
	  mst12_req,
`endif
`ifdef ATCBMC200_AHB_MST13
	  hm13_hwdata,
	  mst13_ack,
	  mst13_haddr,
	  mst13_hburst,
	  mst13_hprot,
	  mst13_hsize,
	  mst13_htrans,
	  mst13_hwrite,
	  mst13_req,
`endif
`ifdef ATCBMC200_AHB_MST14
	  hm14_hwdata,
	  mst14_ack,
	  mst14_haddr,
	  mst14_hburst,
	  mst14_hprot,
	  mst14_hsize,
	  mst14_htrans,
	  mst14_hwrite,
	  mst14_req,
`endif
`ifdef ATCBMC200_AHB_MST15
	  hm15_hwdata,
	  mst15_ack,
	  mst15_haddr,
	  mst15_hburst,
	  mst15_hprot,
	  mst15_hsize,
	  mst15_htrans,
	  mst15_hwrite,
	  mst15_req,
`endif
	  bmc_hs_hready,
	  hclk,
	  hresetn,
	  hs_bmc_hready,
	  hs_haddr,
	  hs_hburst,
	  hs_hprot,
	  hs_hresp,
	  hs_hsel,
	  hs_hsize,
	  hs_htrans,
	  hs_hwdata,
	  hs_hwrite,
	  init_priority,
	  mst0_highest_en
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam HTRANS_IDLE   = 2'b00;
localparam HTRANS_BUSY   = 2'b01;
localparam HTRANS_NONSEQ = 2'b10;
localparam HTRANS_SEQ    = 2'b11;
localparam HRESP_OK      = 2'b00;

`ifdef ATCBMC200_AHB_MST0
input       [DATA_MSB:0] hm0_hwdata;
output                   mst0_ack;
input       [ADDR_MSB:0] mst0_haddr;
input              [2:0] mst0_hburst;
input              [3:0] mst0_hprot;
input              [2:0] mst0_hsize;
input              [1:0] mst0_htrans;
input                    mst0_hwrite;
input                    mst0_req;
`endif
`ifdef ATCBMC200_AHB_MST1
input       [DATA_MSB:0] hm1_hwdata;
output                   mst1_ack;
input       [ADDR_MSB:0] mst1_haddr;
input              [2:0] mst1_hburst;
input              [3:0] mst1_hprot;
input              [2:0] mst1_hsize;
input              [1:0] mst1_htrans;
input                    mst1_hwrite;
input                    mst1_req;
`endif
`ifdef ATCBMC200_AHB_MST2
input       [DATA_MSB:0] hm2_hwdata;
output                   mst2_ack;
input       [ADDR_MSB:0] mst2_haddr;
input              [2:0] mst2_hburst;
input              [3:0] mst2_hprot;
input              [2:0] mst2_hsize;
input              [1:0] mst2_htrans;
input                    mst2_hwrite;
input                    mst2_req;
`endif
`ifdef ATCBMC200_AHB_MST3
input       [DATA_MSB:0] hm3_hwdata;
output                   mst3_ack;
input       [ADDR_MSB:0] mst3_haddr;
input              [2:0] mst3_hburst;
input              [3:0] mst3_hprot;
input              [2:0] mst3_hsize;
input              [1:0] mst3_htrans;
input                    mst3_hwrite;
input                    mst3_req;
`endif
`ifdef ATCBMC200_AHB_MST4
input       [DATA_MSB:0] hm4_hwdata;
output                   mst4_ack;
input       [ADDR_MSB:0] mst4_haddr;
input              [2:0] mst4_hburst;
input              [3:0] mst4_hprot;
input              [2:0] mst4_hsize;
input              [1:0] mst4_htrans;
input                    mst4_hwrite;
input                    mst4_req;
`endif
`ifdef ATCBMC200_AHB_MST5
input       [DATA_MSB:0] hm5_hwdata;
output                   mst5_ack;
input       [ADDR_MSB:0] mst5_haddr;
input              [2:0] mst5_hburst;
input              [3:0] mst5_hprot;
input              [2:0] mst5_hsize;
input              [1:0] mst5_htrans;
input                    mst5_hwrite;
input                    mst5_req;
`endif
`ifdef ATCBMC200_AHB_MST6
input       [DATA_MSB:0] hm6_hwdata;
output                   mst6_ack;
input       [ADDR_MSB:0] mst6_haddr;
input              [2:0] mst6_hburst;
input              [3:0] mst6_hprot;
input              [2:0] mst6_hsize;
input              [1:0] mst6_htrans;
input                    mst6_hwrite;
input                    mst6_req;
`endif
`ifdef ATCBMC200_AHB_MST7
input       [DATA_MSB:0] hm7_hwdata;
output                   mst7_ack;
input       [ADDR_MSB:0] mst7_haddr;
input              [2:0] mst7_hburst;
input              [3:0] mst7_hprot;
input              [2:0] mst7_hsize;
input              [1:0] mst7_htrans;
input                    mst7_hwrite;
input                    mst7_req;
`endif
`ifdef ATCBMC200_AHB_MST8
input       [DATA_MSB:0] hm8_hwdata;
output                   mst8_ack;
input       [ADDR_MSB:0] mst8_haddr;
input              [2:0] mst8_hburst;
input              [3:0] mst8_hprot;
input              [2:0] mst8_hsize;
input              [1:0] mst8_htrans;
input                    mst8_hwrite;
input                    mst8_req;
`endif
`ifdef ATCBMC200_AHB_MST9
input       [DATA_MSB:0] hm9_hwdata;
output                   mst9_ack;
input       [ADDR_MSB:0] mst9_haddr;
input              [2:0] mst9_hburst;
input              [3:0] mst9_hprot;
input              [2:0] mst9_hsize;
input              [1:0] mst9_htrans;
input                    mst9_hwrite;
input                    mst9_req;
`endif
`ifdef ATCBMC200_AHB_MST10
input       [DATA_MSB:0] hm10_hwdata;
output                   mst10_ack;
input       [ADDR_MSB:0] mst10_haddr;
input              [2:0] mst10_hburst;
input              [3:0] mst10_hprot;
input              [2:0] mst10_hsize;
input              [1:0] mst10_htrans;
input                    mst10_hwrite;
input                    mst10_req;
`endif
`ifdef ATCBMC200_AHB_MST11
input       [DATA_MSB:0] hm11_hwdata;
output                   mst11_ack;
input       [ADDR_MSB:0] mst11_haddr;
input              [2:0] mst11_hburst;
input              [3:0] mst11_hprot;
input              [2:0] mst11_hsize;
input              [1:0] mst11_htrans;
input                    mst11_hwrite;
input                    mst11_req;
`endif
`ifdef ATCBMC200_AHB_MST12
input       [DATA_MSB:0] hm12_hwdata;
output                   mst12_ack;
input       [ADDR_MSB:0] mst12_haddr;
input              [2:0] mst12_hburst;
input              [3:0] mst12_hprot;
input              [2:0] mst12_hsize;
input              [1:0] mst12_htrans;
input                    mst12_hwrite;
input                    mst12_req;
`endif
`ifdef ATCBMC200_AHB_MST13
input       [DATA_MSB:0] hm13_hwdata;
output                   mst13_ack;
input       [ADDR_MSB:0] mst13_haddr;
input              [2:0] mst13_hburst;
input              [3:0] mst13_hprot;
input              [2:0] mst13_hsize;
input              [1:0] mst13_htrans;
input                    mst13_hwrite;
input                    mst13_req;
`endif
`ifdef ATCBMC200_AHB_MST14
input       [DATA_MSB:0] hm14_hwdata;
output                   mst14_ack;
input       [ADDR_MSB:0] mst14_haddr;
input              [2:0] mst14_hburst;
input              [3:0] mst14_hprot;
input              [2:0] mst14_hsize;
input              [1:0] mst14_htrans;
input                    mst14_hwrite;
input                    mst14_req;
`endif
`ifdef ATCBMC200_AHB_MST15
input       [DATA_MSB:0] hm15_hwdata;
output                   mst15_ack;
input       [ADDR_MSB:0] mst15_haddr;
input              [2:0] mst15_hburst;
input              [3:0] mst15_hprot;
input              [2:0] mst15_hsize;
input              [1:0] mst15_htrans;
input                    mst15_hwrite;
input                    mst15_req;
`endif
output                   bmc_hs_hready;
input                    hclk;
input                    hresetn;
input                    hs_bmc_hready;
output      [ADDR_MSB:0] hs_haddr;
output             [2:0] hs_hburst;
output             [3:0] hs_hprot;
input              [1:0] hs_hresp;
output                   hs_hsel;
output             [2:0] hs_hsize;
output             [1:0] hs_htrans;
output      [DATA_MSB:0] hs_hwdata;
output                   hs_hwrite;
input             [15:0] init_priority;
input                    mst0_highest_en;

wire               [3:0] hs_hmaster;
wire                     slv_sel;

reg                 [ADDR_MSB:0] hs_haddr;
reg                        [2:0] hs_hburst;
reg                        [3:0] hs_hprot;
reg                        [2:0] hs_hsize;
reg                        [1:0] hs_htrans;
reg                 [DATA_MSB:0] hs_hwdata;
reg                              hs_hwrite;

reg                              mst_valid;
wire                             mst_req;

`ifdef ATCBMC200_AHB_MST0
reg               priority0;
reg               next_priority0;
wire              mask0_req;
wire              lv_mask0_req;
reg               mst0_ack;
`endif
`ifdef ATCBMC200_AHB_MST1
reg               priority1;
reg               next_priority1;
wire              mask1_req;
wire              lv_mask1_req;
reg               mst1_ack;
`endif
`ifdef ATCBMC200_AHB_MST2
reg               priority2;
reg               next_priority2;
wire              mask2_req;
wire              lv_mask2_req;
reg               mst2_ack;
`endif
`ifdef ATCBMC200_AHB_MST3
reg               priority3;
reg               next_priority3;
wire              mask3_req;
wire              lv_mask3_req;
reg               mst3_ack;
`endif
`ifdef ATCBMC200_AHB_MST4
reg               priority4;
reg               next_priority4;
wire              mask4_req;
wire              lv_mask4_req;
reg               mst4_ack;
`endif
`ifdef ATCBMC200_AHB_MST5
reg               priority5;
reg               next_priority5;
wire              mask5_req;
wire              lv_mask5_req;
reg               mst5_ack;
`endif
`ifdef ATCBMC200_AHB_MST6
reg               priority6;
reg               next_priority6;
wire              mask6_req;
wire              lv_mask6_req;
reg               mst6_ack;
`endif
`ifdef ATCBMC200_AHB_MST7
reg               priority7;
reg               next_priority7;
wire              mask7_req;
wire              lv_mask7_req;
reg               mst7_ack;
`endif
`ifdef ATCBMC200_AHB_MST8
reg               priority8;
reg               next_priority8;
wire              mask8_req;
wire              lv_mask8_req;
reg               mst8_ack;
`endif
`ifdef ATCBMC200_AHB_MST9
reg               priority9;
reg               next_priority9;
wire              mask9_req;
wire              lv_mask9_req;
reg               mst9_ack;
`endif
`ifdef ATCBMC200_AHB_MST10
reg               priority10;
reg               next_priority10;
wire              mask10_req;
wire              lv_mask10_req;
reg               mst10_ack;
`endif
`ifdef ATCBMC200_AHB_MST11
reg               priority11;
reg               next_priority11;
wire              mask11_req;
wire              lv_mask11_req;
reg               mst11_ack;
`endif
`ifdef ATCBMC200_AHB_MST12
reg               priority12;
reg               next_priority12;
wire              mask12_req;
wire              lv_mask12_req;
reg               mst12_ack;
`endif
`ifdef ATCBMC200_AHB_MST13
reg               priority13;
reg               next_priority13;
wire              mask13_req;
wire              lv_mask13_req;
reg               mst13_ack;
`endif
`ifdef ATCBMC200_AHB_MST14
reg               priority14;
reg               next_priority14;
wire              mask14_req;
wire              lv_mask14_req;
reg               mst14_ack;
`endif
`ifdef ATCBMC200_AHB_MST15
reg               priority15;
reg               next_priority15;
wire              mask15_req;
wire              lv_mask15_req;
reg               mst15_ack;
`endif
wire              priority_reload;
wire              priority_fixed;

reg         [3:0] mst_id;
reg               hs_hsel_dp;
wire        [3:0] next_mst_id;
wire              arb_valid;
wire              pri_sel;

assign priority_fixed = ~(
`ifdef ATCBMC200_AHB_MST0
                          init_priority[0] |
`endif
`ifdef ATCBMC200_AHB_MST1
                          init_priority[1] |
`endif
`ifdef ATCBMC200_AHB_MST2
                          init_priority[2] |
`endif
`ifdef ATCBMC200_AHB_MST3
                          init_priority[3] |
`endif
`ifdef ATCBMC200_AHB_MST4
                          init_priority[4] |
`endif
`ifdef ATCBMC200_AHB_MST5
                          init_priority[5] |
`endif
`ifdef ATCBMC200_AHB_MST6
                          init_priority[6] |
`endif
`ifdef ATCBMC200_AHB_MST7
                          init_priority[7] |
`endif
`ifdef ATCBMC200_AHB_MST8
                          init_priority[8] |
`endif
`ifdef ATCBMC200_AHB_MST9
                          init_priority[9] |
`endif
`ifdef ATCBMC200_AHB_MST10
                          init_priority[10] |
`endif
`ifdef ATCBMC200_AHB_MST11
                          init_priority[11] |
`endif
`ifdef ATCBMC200_AHB_MST12
                          init_priority[12] |
`endif
`ifdef ATCBMC200_AHB_MST13
                          init_priority[13] |
`endif
`ifdef ATCBMC200_AHB_MST14
                          init_priority[14] |
`endif
`ifdef ATCBMC200_AHB_MST15
                          init_priority[15] |
`endif
                          1'b0);

assign priority_reload = ~(
`ifdef ATCBMC200_AHB_MST0
                          (init_priority[0] & next_priority0) |
`endif
`ifdef ATCBMC200_AHB_MST1
                          (init_priority[1] & next_priority1) |
`endif
`ifdef ATCBMC200_AHB_MST2
                          (init_priority[2] & next_priority2) |
`endif
`ifdef ATCBMC200_AHB_MST3
                          (init_priority[3] & next_priority3) |
`endif
`ifdef ATCBMC200_AHB_MST4
                          (init_priority[4] & next_priority4) |
`endif
`ifdef ATCBMC200_AHB_MST5
                          (init_priority[5] & next_priority5) |
`endif
`ifdef ATCBMC200_AHB_MST6
                          (init_priority[6] & next_priority6) |
`endif
`ifdef ATCBMC200_AHB_MST7
                          (init_priority[7] & next_priority7) |
`endif
`ifdef ATCBMC200_AHB_MST8
                          (init_priority[8] & next_priority8) |
`endif
`ifdef ATCBMC200_AHB_MST9
                          (init_priority[9] & next_priority9) |
`endif
`ifdef ATCBMC200_AHB_MST10
                          (init_priority[10] & next_priority10) |
`endif
`ifdef ATCBMC200_AHB_MST11
                          (init_priority[11] & next_priority11) |
`endif
`ifdef ATCBMC200_AHB_MST12
                          (init_priority[12] & next_priority12) |
`endif
`ifdef ATCBMC200_AHB_MST13
                          (init_priority[13] & next_priority13) |
`endif
`ifdef ATCBMC200_AHB_MST14
                          (init_priority[14] & next_priority14) |
`endif
`ifdef ATCBMC200_AHB_MST15
                          (init_priority[15] & next_priority15) |
`endif
                          1'b0 );

assign arb_valid = bmc_hs_hready & (hs_hresp == HRESP_OK) & (~mst_valid |
`ifdef ATCBMC200_AHB_MST0
                          ((mst_id == 4'd0) & (mst0_htrans == HTRANS_NONSEQ | mst0_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST1
                          ((mst_id == 4'd1) & (mst1_htrans == HTRANS_NONSEQ | mst1_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST2
                          ((mst_id == 4'd2) & (mst2_htrans == HTRANS_NONSEQ | mst2_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST3
                          ((mst_id == 4'd3) & (mst3_htrans == HTRANS_NONSEQ | mst3_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST4
                          ((mst_id == 4'd4) & (mst4_htrans == HTRANS_NONSEQ | mst4_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST5
                          ((mst_id == 4'd5) & (mst5_htrans == HTRANS_NONSEQ | mst5_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST6
                          ((mst_id == 4'd6) & (mst6_htrans == HTRANS_NONSEQ | mst6_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST7
                          ((mst_id == 4'd7) & (mst7_htrans == HTRANS_NONSEQ | mst7_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST8
                          ((mst_id == 4'd8) & (mst8_htrans == HTRANS_NONSEQ | mst8_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST9
                          ((mst_id == 4'd9) & (mst9_htrans == HTRANS_NONSEQ | mst9_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST10
                          ((mst_id == 4'd10) & (mst10_htrans == HTRANS_NONSEQ | mst10_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST11
                          ((mst_id == 4'd11) & (mst11_htrans == HTRANS_NONSEQ | mst11_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST12
                          ((mst_id == 4'd12) & (mst12_htrans == HTRANS_NONSEQ | mst12_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST13
                          ((mst_id == 4'd13) & (mst13_htrans == HTRANS_NONSEQ | mst13_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST14
                          ((mst_id == 4'd14) & (mst14_htrans == HTRANS_NONSEQ | mst14_htrans == HTRANS_IDLE) ) |
`endif
`ifdef ATCBMC200_AHB_MST15
                          ((mst_id == 4'd15) & (mst15_htrans == HTRANS_NONSEQ | mst15_htrans == HTRANS_IDLE) ) |
`endif
                          1'b0 );

assign mst_req = (
`ifdef ATCBMC200_AHB_MST0
                          mst0_req |
`endif
`ifdef ATCBMC200_AHB_MST1
                          mst1_req |
`endif
`ifdef ATCBMC200_AHB_MST2
                          mst2_req |
`endif
`ifdef ATCBMC200_AHB_MST3
                          mst3_req |
`endif
`ifdef ATCBMC200_AHB_MST4
                          mst4_req |
`endif
`ifdef ATCBMC200_AHB_MST5
                          mst5_req |
`endif
`ifdef ATCBMC200_AHB_MST6
                          mst6_req |
`endif
`ifdef ATCBMC200_AHB_MST7
                          mst7_req |
`endif
`ifdef ATCBMC200_AHB_MST8
                          mst8_req |
`endif
`ifdef ATCBMC200_AHB_MST9
                          mst9_req |
`endif
`ifdef ATCBMC200_AHB_MST10
                          mst10_req |
`endif
`ifdef ATCBMC200_AHB_MST11
                          mst11_req |
`endif
`ifdef ATCBMC200_AHB_MST12
                          mst12_req |
`endif
`ifdef ATCBMC200_AHB_MST13
                          mst13_req |
`endif
`ifdef ATCBMC200_AHB_MST14
                          mst14_req |
`endif
`ifdef ATCBMC200_AHB_MST15
                          mst15_req |
`endif
                          1'b0 );

assign hs_hmaster   = (arb_valid & mst_req) ? next_mst_id : mst_id;
assign hs_hsel      = slv_sel;
assign slv_sel      = (arb_valid) ? mst_req : (
`ifdef ATCBMC200_AHB_MST0
                          ((mst_id == 4'd0) & mst_valid & ((mst0_htrans == HTRANS_SEQ) | (mst0_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST1
                          ((mst_id == 4'd1) & mst_valid & ((mst1_htrans == HTRANS_SEQ) | (mst1_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST2
                          ((mst_id == 4'd2) & mst_valid & ((mst2_htrans == HTRANS_SEQ) | (mst2_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST3
                          ((mst_id == 4'd3) & mst_valid & ((mst3_htrans == HTRANS_SEQ) | (mst3_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST4
                          ((mst_id == 4'd4) & mst_valid & ((mst4_htrans == HTRANS_SEQ) | (mst4_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST5
                          ((mst_id == 4'd5) & mst_valid & ((mst5_htrans == HTRANS_SEQ) | (mst5_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST6
                          ((mst_id == 4'd6) & mst_valid & ((mst6_htrans == HTRANS_SEQ) | (mst6_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST7
                          ((mst_id == 4'd7) & mst_valid & ((mst7_htrans == HTRANS_SEQ) | (mst7_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST8
                          ((mst_id == 4'd8) & mst_valid & ((mst8_htrans == HTRANS_SEQ) | (mst8_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST9
                          ((mst_id == 4'd9) & mst_valid & ((mst9_htrans == HTRANS_SEQ) | (mst9_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST10
                          ((mst_id == 4'd10) & mst_valid & ((mst10_htrans == HTRANS_SEQ) | (mst10_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST11
                          ((mst_id == 4'd11) & mst_valid & ((mst11_htrans == HTRANS_SEQ) | (mst11_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST12
                          ((mst_id == 4'd12) & mst_valid & ((mst12_htrans == HTRANS_SEQ) | (mst12_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST13
                          ((mst_id == 4'd13) & mst_valid & ((mst13_htrans == HTRANS_SEQ) | (mst13_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST14
                          ((mst_id == 4'd14) & mst_valid & ((mst14_htrans == HTRANS_SEQ) | (mst14_htrans == HTRANS_BUSY))) |
`endif
`ifdef ATCBMC200_AHB_MST15
                          ((mst_id == 4'd15) & mst_valid & ((mst15_htrans == HTRANS_SEQ) | (mst15_htrans == HTRANS_BUSY))) |
`endif
                          1'b0 );
assign bmc_hs_hready    = hs_hsel_dp ? hs_bmc_hready : 1'b1;
always @(posedge hclk or negedge hresetn) begin
	if (!hresetn)
		hs_hsel_dp	<= 1'b0;
	else if (bmc_hs_hready)
		hs_hsel_dp	<= hs_hsel;
end


always @* begin
    case({slv_sel, hs_hmaster})
    `ifdef ATCBMC200_AHB_MST0
       {1'b1, 4'd0}: begin
       hs_htrans = mst0_htrans;
       hs_haddr  = mst0_haddr;
       hs_hwrite = mst0_hwrite;
       hs_hsize  = mst0_hsize;
       hs_hburst = mst0_hburst;
       hs_hprot  = mst0_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST1
       {1'b1, 4'd1}: begin
       hs_htrans = mst1_htrans;
       hs_haddr  = mst1_haddr;
       hs_hwrite = mst1_hwrite;
       hs_hsize  = mst1_hsize;
       hs_hburst = mst1_hburst;
       hs_hprot  = mst1_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST2
       {1'b1, 4'd2}: begin
       hs_htrans = mst2_htrans;
       hs_haddr  = mst2_haddr;
       hs_hwrite = mst2_hwrite;
       hs_hsize  = mst2_hsize;
       hs_hburst = mst2_hburst;
       hs_hprot  = mst2_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST3
       {1'b1, 4'd3}: begin
       hs_htrans = mst3_htrans;
       hs_haddr  = mst3_haddr;
       hs_hwrite = mst3_hwrite;
       hs_hsize  = mst3_hsize;
       hs_hburst = mst3_hburst;
       hs_hprot  = mst3_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST4
       {1'b1, 4'd4}: begin
       hs_htrans = mst4_htrans;
       hs_haddr  = mst4_haddr;
       hs_hwrite = mst4_hwrite;
       hs_hsize  = mst4_hsize;
       hs_hburst = mst4_hburst;
       hs_hprot  = mst4_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST5
       {1'b1, 4'd5}: begin
       hs_htrans = mst5_htrans;
       hs_haddr  = mst5_haddr;
       hs_hwrite = mst5_hwrite;
       hs_hsize  = mst5_hsize;
       hs_hburst = mst5_hburst;
       hs_hprot  = mst5_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST6
       {1'b1, 4'd6}: begin
       hs_htrans = mst6_htrans;
       hs_haddr  = mst6_haddr;
       hs_hwrite = mst6_hwrite;
       hs_hsize  = mst6_hsize;
       hs_hburst = mst6_hburst;
       hs_hprot  = mst6_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST7
       {1'b1, 4'd7}: begin
       hs_htrans = mst7_htrans;
       hs_haddr  = mst7_haddr;
       hs_hwrite = mst7_hwrite;
       hs_hsize  = mst7_hsize;
       hs_hburst = mst7_hburst;
       hs_hprot  = mst7_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST8
       {1'b1, 4'd8}: begin
       hs_htrans = mst8_htrans;
       hs_haddr  = mst8_haddr;
       hs_hwrite = mst8_hwrite;
       hs_hsize  = mst8_hsize;
       hs_hburst = mst8_hburst;
       hs_hprot  = mst8_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST9
       {1'b1, 4'd9}: begin
       hs_htrans = mst9_htrans;
       hs_haddr  = mst9_haddr;
       hs_hwrite = mst9_hwrite;
       hs_hsize  = mst9_hsize;
       hs_hburst = mst9_hburst;
       hs_hprot  = mst9_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST10
       {1'b1, 4'd10}: begin
       hs_htrans = mst10_htrans;
       hs_haddr  = mst10_haddr;
       hs_hwrite = mst10_hwrite;
       hs_hsize  = mst10_hsize;
       hs_hburst = mst10_hburst;
       hs_hprot  = mst10_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST11
       {1'b1, 4'd11}: begin
       hs_htrans = mst11_htrans;
       hs_haddr  = mst11_haddr;
       hs_hwrite = mst11_hwrite;
       hs_hsize  = mst11_hsize;
       hs_hburst = mst11_hburst;
       hs_hprot  = mst11_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST12
       {1'b1, 4'd12}: begin
       hs_htrans = mst12_htrans;
       hs_haddr  = mst12_haddr;
       hs_hwrite = mst12_hwrite;
       hs_hsize  = mst12_hsize;
       hs_hburst = mst12_hburst;
       hs_hprot  = mst12_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST13
       {1'b1, 4'd13}: begin
       hs_htrans = mst13_htrans;
       hs_haddr  = mst13_haddr;
       hs_hwrite = mst13_hwrite;
       hs_hsize  = mst13_hsize;
       hs_hburst = mst13_hburst;
       hs_hprot  = mst13_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST14
       {1'b1, 4'd14}: begin
       hs_htrans = mst14_htrans;
       hs_haddr  = mst14_haddr;
       hs_hwrite = mst14_hwrite;
       hs_hsize  = mst14_hsize;
       hs_hburst = mst14_hburst;
       hs_hprot  = mst14_hprot;
    end
    `endif
    `ifdef ATCBMC200_AHB_MST15
       {1'b1, 4'd15}: begin
       hs_htrans = mst15_htrans;
       hs_haddr  = mst15_haddr;
       hs_hwrite = mst15_hwrite;
       hs_hsize  = mst15_hsize;
       hs_hburst = mst15_hburst;
       hs_hprot  = mst15_hprot;
    end
    `endif
    default: begin
       hs_htrans = 2'h0;
       hs_haddr  = {ADDR_WIDTH{1'b0}};
       hs_hwrite = 1'b0;
       hs_hsize  = 3'h0;
       hs_hburst = 3'h0;
       hs_hprot  = 4'h0;
    end
    endcase
end

always @* begin
   case(mst_id)
   `ifdef ATCBMC200_AHB_MST0
       4'd0: hs_hwdata = hm0_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST1
       4'd1: hs_hwdata = hm1_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST2
       4'd2: hs_hwdata = hm2_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST3
       4'd3: hs_hwdata = hm3_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST4
       4'd4: hs_hwdata = hm4_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST5
       4'd5: hs_hwdata = hm5_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST6
       4'd6: hs_hwdata = hm6_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST7
       4'd7: hs_hwdata = hm7_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST8
       4'd8: hs_hwdata = hm8_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST9
       4'd9: hs_hwdata = hm9_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST10
       4'd10: hs_hwdata = hm10_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST11
       4'd11: hs_hwdata = hm11_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST12
       4'd12: hs_hwdata = hm12_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST13
       4'd13: hs_hwdata = hm13_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST14
       4'd14: hs_hwdata = hm14_hwdata;
   `endif
   `ifdef ATCBMC200_AHB_MST15
       4'd15: hs_hwdata = hm15_hwdata;
   `endif
   default: hs_hwdata = {DATA_WIDTH{1'b0}};
   endcase
end

assign next_mst_id =
`ifdef ATCBMC200_AHB_MST0
                     (mst0_ack) ? 4'd0 :
`endif
`ifdef ATCBMC200_AHB_MST1
                     (mst1_ack) ? 4'd1 :
`endif
`ifdef ATCBMC200_AHB_MST2
                     (mst2_ack) ? 4'd2 :
`endif
`ifdef ATCBMC200_AHB_MST3
                     (mst3_ack) ? 4'd3 :
`endif
`ifdef ATCBMC200_AHB_MST4
                     (mst4_ack) ? 4'd4 :
`endif
`ifdef ATCBMC200_AHB_MST5
                     (mst5_ack) ? 4'd5 :
`endif
`ifdef ATCBMC200_AHB_MST6
                     (mst6_ack) ? 4'd6 :
`endif
`ifdef ATCBMC200_AHB_MST7
                     (mst7_ack) ? 4'd7 :
`endif
`ifdef ATCBMC200_AHB_MST8
                     (mst8_ack) ? 4'd8 :
`endif
`ifdef ATCBMC200_AHB_MST9
                     (mst9_ack) ? 4'd9 :
`endif
`ifdef ATCBMC200_AHB_MST10
                     (mst10_ack) ? 4'd10 :
`endif
`ifdef ATCBMC200_AHB_MST11
                     (mst11_ack) ? 4'd11 :
`endif
`ifdef ATCBMC200_AHB_MST12
                     (mst12_ack) ? 4'd12 :
`endif
`ifdef ATCBMC200_AHB_MST13
                     (mst13_ack) ? 4'd13 :
`endif
`ifdef ATCBMC200_AHB_MST14
                     (mst14_ack) ? 4'd14 :
`endif
`ifdef ATCBMC200_AHB_MST15
                     (mst15_ack) ? 4'd15 :
`endif
   4'd0;

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn)
        mst_valid <= 1'b0;
	else if (bmc_hs_hready && (hs_hresp != HRESP_OK) && (hs_htrans == HTRANS_IDLE))
        mst_valid <= 1'b0;
    else if (arb_valid)
        mst_valid <= mst_req;
end

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn)
`ifdef ATCBMC200_AHB_MST0
        mst_id <= 4'd0 ;
`else
`ifdef ATCBMC200_AHB_MST1
        mst_id <= 4'd1 ;
`else
`ifdef ATCBMC200_AHB_MST2
        mst_id <= 4'd2 ;
`else
`ifdef ATCBMC200_AHB_MST3
        mst_id <= 4'd3 ;
`else
`ifdef ATCBMC200_AHB_MST4
        mst_id <= 4'd4 ;
`else
`ifdef ATCBMC200_AHB_MST5
        mst_id <= 4'd5 ;
`else
`ifdef ATCBMC200_AHB_MST6
        mst_id <= 4'd6 ;
`else
`ifdef ATCBMC200_AHB_MST7
        mst_id <= 4'd7 ;
`else
`ifdef ATCBMC200_AHB_MST8
        mst_id <= 4'd8 ;
`else
`ifdef ATCBMC200_AHB_MST9
        mst_id <= 4'd9 ;
`else
`ifdef ATCBMC200_AHB_MST10
        mst_id <= 4'd10 ;
`else
`ifdef ATCBMC200_AHB_MST11
        mst_id <= 4'd11 ;
`else
`ifdef ATCBMC200_AHB_MST12
        mst_id <= 4'd12 ;
`else
`ifdef ATCBMC200_AHB_MST13
        mst_id <= 4'd13 ;
`else
`ifdef ATCBMC200_AHB_MST14
        mst_id <= 4'd14 ;
`else
`ifdef ATCBMC200_AHB_MST15
        mst_id <= 4'd15 ;
`else
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
`endif
    else if (arb_valid && mst_req)
        mst_id <= next_mst_id;
end

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
`ifdef ATCBMC200_AHB_MST0
         priority0 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST1
         priority1 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST2
         priority2 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST3
         priority3 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST4
         priority4 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST5
         priority5 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST6
         priority6 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST7
         priority7 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST8
         priority8 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST9
         priority9 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST10
         priority10 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST11
         priority11 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST12
         priority12 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST13
         priority13 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST14
         priority14 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST15
         priority15 <= 1'b0;
`endif
    end
    else if (arb_valid && mst_req && !priority_fixed) begin
`ifdef ATCBMC200_AHB_MST0
        priority0 <= next_priority0 | (priority_reload & init_priority[0]);
`endif
`ifdef ATCBMC200_AHB_MST1
        priority1 <= next_priority1 | (priority_reload & init_priority[1]);
`endif
`ifdef ATCBMC200_AHB_MST2
        priority2 <= next_priority2 | (priority_reload & init_priority[2]);
`endif
`ifdef ATCBMC200_AHB_MST3
        priority3 <= next_priority3 | (priority_reload & init_priority[3]);
`endif
`ifdef ATCBMC200_AHB_MST4
        priority4 <= next_priority4 | (priority_reload & init_priority[4]);
`endif
`ifdef ATCBMC200_AHB_MST5
        priority5 <= next_priority5 | (priority_reload & init_priority[5]);
`endif
`ifdef ATCBMC200_AHB_MST6
        priority6 <= next_priority6 | (priority_reload & init_priority[6]);
`endif
`ifdef ATCBMC200_AHB_MST7
        priority7 <= next_priority7 | (priority_reload & init_priority[7]);
`endif
`ifdef ATCBMC200_AHB_MST8
        priority8 <= next_priority8 | (priority_reload & init_priority[8]);
`endif
`ifdef ATCBMC200_AHB_MST9
        priority9 <= next_priority9 | (priority_reload & init_priority[9]);
`endif
`ifdef ATCBMC200_AHB_MST10
        priority10 <= next_priority10 | (priority_reload & init_priority[10]);
`endif
`ifdef ATCBMC200_AHB_MST11
        priority11 <= next_priority11 | (priority_reload & init_priority[11]);
`endif
`ifdef ATCBMC200_AHB_MST12
        priority12 <= next_priority12 | (priority_reload & init_priority[12]);
`endif
`ifdef ATCBMC200_AHB_MST13
        priority13 <= next_priority13 | (priority_reload & init_priority[13]);
`endif
`ifdef ATCBMC200_AHB_MST14
        priority14 <= next_priority14 | (priority_reload & init_priority[14]);
`endif
`ifdef ATCBMC200_AHB_MST15
        priority15 <= next_priority15 | (priority_reload & init_priority[15]);
`endif
    end
end

`ifdef ATCBMC200_AHB_MST0
assign mask0_req = (mst0_highest_en | priority0) & mst0_req;
`endif
`ifdef ATCBMC200_AHB_MST1
    assign mask1_req = priority1 & mst1_req;
`endif
`ifdef ATCBMC200_AHB_MST2
    assign mask2_req = priority2 & mst2_req;
`endif
`ifdef ATCBMC200_AHB_MST3
    assign mask3_req = priority3 & mst3_req;
`endif
`ifdef ATCBMC200_AHB_MST4
    assign mask4_req = priority4 & mst4_req;
`endif
`ifdef ATCBMC200_AHB_MST5
    assign mask5_req = priority5 & mst5_req;
`endif
`ifdef ATCBMC200_AHB_MST6
    assign mask6_req = priority6 & mst6_req;
`endif
`ifdef ATCBMC200_AHB_MST7
    assign mask7_req = priority7 & mst7_req;
`endif
`ifdef ATCBMC200_AHB_MST8
    assign mask8_req = priority8 & mst8_req;
`endif
`ifdef ATCBMC200_AHB_MST9
    assign mask9_req = priority9 & mst9_req;
`endif
`ifdef ATCBMC200_AHB_MST10
    assign mask10_req = priority10 & mst10_req;
`endif
`ifdef ATCBMC200_AHB_MST11
    assign mask11_req = priority11 & mst11_req;
`endif
`ifdef ATCBMC200_AHB_MST12
    assign mask12_req = priority12 & mst12_req;
`endif
`ifdef ATCBMC200_AHB_MST13
    assign mask13_req = priority13 & mst13_req;
`endif
`ifdef ATCBMC200_AHB_MST14
    assign mask14_req = priority14 & mst14_req;
`endif
`ifdef ATCBMC200_AHB_MST15
    assign mask15_req = priority15 & mst15_req;
`endif

`ifdef ATCBMC200_AHB_MST0
    assign lv_mask0_req = init_priority[0] & mask0_req;
`endif
`ifdef ATCBMC200_AHB_MST1
    assign lv_mask1_req = init_priority[1] & mask1_req;
`endif
`ifdef ATCBMC200_AHB_MST2
    assign lv_mask2_req = init_priority[2] & mask2_req;
`endif
`ifdef ATCBMC200_AHB_MST3
    assign lv_mask3_req = init_priority[3] & mask3_req;
`endif
`ifdef ATCBMC200_AHB_MST4
    assign lv_mask4_req = init_priority[4] & mask4_req;
`endif
`ifdef ATCBMC200_AHB_MST5
    assign lv_mask5_req = init_priority[5] & mask5_req;
`endif
`ifdef ATCBMC200_AHB_MST6
    assign lv_mask6_req = init_priority[6] & mask6_req;
`endif
`ifdef ATCBMC200_AHB_MST7
    assign lv_mask7_req = init_priority[7] & mask7_req;
`endif
`ifdef ATCBMC200_AHB_MST8
    assign lv_mask8_req = init_priority[8] & mask8_req;
`endif
`ifdef ATCBMC200_AHB_MST9
    assign lv_mask9_req = init_priority[9] & mask9_req;
`endif
`ifdef ATCBMC200_AHB_MST10
    assign lv_mask10_req = init_priority[10] & mask10_req;
`endif
`ifdef ATCBMC200_AHB_MST11
    assign lv_mask11_req = init_priority[11] & mask11_req;
`endif
`ifdef ATCBMC200_AHB_MST12
    assign lv_mask12_req = init_priority[12] & mask12_req;
`endif
`ifdef ATCBMC200_AHB_MST13
    assign lv_mask13_req = init_priority[13] & mask13_req;
`endif
`ifdef ATCBMC200_AHB_MST14
    assign lv_mask14_req = init_priority[14] & mask14_req;
`endif
`ifdef ATCBMC200_AHB_MST15
    assign lv_mask15_req = init_priority[15] & mask15_req;
`endif

assign pri_sel =
`ifdef ATCBMC200_AHB_MST0
                 mask0_req |
`endif
`ifdef ATCBMC200_AHB_MST1
                 mask1_req |
`endif
`ifdef ATCBMC200_AHB_MST2
                 mask2_req |
`endif
`ifdef ATCBMC200_AHB_MST3
                 mask3_req |
`endif
`ifdef ATCBMC200_AHB_MST4
                 mask4_req |
`endif
`ifdef ATCBMC200_AHB_MST5
                 mask5_req |
`endif
`ifdef ATCBMC200_AHB_MST6
                 mask6_req |
`endif
`ifdef ATCBMC200_AHB_MST7
                 mask7_req |
`endif
`ifdef ATCBMC200_AHB_MST8
                 mask8_req |
`endif
`ifdef ATCBMC200_AHB_MST9
                 mask9_req |
`endif
`ifdef ATCBMC200_AHB_MST10
                 mask10_req |
`endif
`ifdef ATCBMC200_AHB_MST11
                 mask11_req |
`endif
`ifdef ATCBMC200_AHB_MST12
                 mask12_req |
`endif
`ifdef ATCBMC200_AHB_MST13
                 mask13_req |
`endif
`ifdef ATCBMC200_AHB_MST14
                 mask14_req |
`endif
`ifdef ATCBMC200_AHB_MST15
                 mask15_req |
`endif
                 1'b0;

always @* begin
`ifdef ATCBMC200_AHB_MST0
    mst0_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST1
    mst1_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST2
    mst2_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST3
    mst3_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST4
    mst4_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST5
    mst5_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST6
    mst6_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST7
    mst7_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST8
    mst8_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST9
    mst9_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST10
    mst10_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST11
    mst11_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST12
    mst12_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST13
    mst13_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST14
    mst14_ack = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST15
    mst15_ack = 1'b0;
`endif

   if (pri_sel && arb_valid) begin
       `ifdef ATCBMC200_AHB_MST0
           if (lv_mask0_req) mst0_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (lv_mask1_req) mst1_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (lv_mask2_req) mst2_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (lv_mask3_req) mst3_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (lv_mask4_req) mst4_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (lv_mask5_req) mst5_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (lv_mask6_req) mst6_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (lv_mask7_req) mst7_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (lv_mask8_req) mst8_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (lv_mask9_req) mst9_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (lv_mask10_req) mst10_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (lv_mask11_req) mst11_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (lv_mask12_req) mst12_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (lv_mask13_req) mst13_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (lv_mask14_req) mst14_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (lv_mask15_req) mst15_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST0
           if (mask0_req) mst0_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (mask1_req) mst1_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (mask2_req) mst2_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (mask3_req) mst3_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (mask4_req) mst4_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (mask5_req) mst5_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (mask6_req) mst6_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (mask7_req) mst7_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (mask8_req) mst8_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (mask9_req) mst9_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (mask10_req) mst10_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (mask11_req) mst11_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (mask12_req) mst12_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (mask13_req) mst13_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (mask14_req) mst14_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (mask15_req) mst15_ack = 1'b1; else
       `endif
       begin
           `ifdef ATCBMC200_AHB_MST0
               mst0_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST1
               mst1_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST2
               mst2_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST3
               mst3_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST4
               mst4_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST5
               mst5_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST6
               mst6_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST7
               mst7_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST8
               mst8_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST9
               mst9_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST10
               mst10_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST11
               mst11_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST12
               mst12_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST13
               mst13_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST14
               mst14_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST15
               mst15_ack = 1'b0;
           `endif
       end
   end
   else if (arb_valid) begin
       `ifdef ATCBMC200_AHB_MST0
           if (mst0_req) mst0_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (mst1_req) mst1_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (mst2_req) mst2_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (mst3_req) mst3_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (mst4_req) mst4_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (mst5_req) mst5_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (mst6_req) mst6_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (mst7_req) mst7_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (mst8_req) mst8_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (mst9_req) mst9_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (mst10_req) mst10_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (mst11_req) mst11_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (mst12_req) mst12_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (mst13_req) mst13_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (mst14_req) mst14_ack = 1'b1; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (mst15_req) mst15_ack = 1'b1; else
       `endif
       begin
           `ifdef ATCBMC200_AHB_MST0
               mst0_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST1
               mst1_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST2
               mst2_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST3
               mst3_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST4
               mst4_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST5
               mst5_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST6
               mst6_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST7
               mst7_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST8
               mst8_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST9
               mst9_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST10
               mst10_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST11
               mst11_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST12
               mst12_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST13
               mst13_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST14
               mst14_ack = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST15
               mst15_ack = 1'b0;
           `endif
       end
   end
end
always @* begin
   if (pri_sel) begin
       `ifdef ATCBMC200_AHB_MST0
           next_priority0 = mask0_req;
       `endif
       `ifdef ATCBMC200_AHB_MST1
           next_priority1 = mask1_req;
       `endif
       `ifdef ATCBMC200_AHB_MST2
           next_priority2 = mask2_req;
       `endif
       `ifdef ATCBMC200_AHB_MST3
           next_priority3 = mask3_req;
       `endif
       `ifdef ATCBMC200_AHB_MST4
           next_priority4 = mask4_req;
       `endif
       `ifdef ATCBMC200_AHB_MST5
           next_priority5 = mask5_req;
       `endif
       `ifdef ATCBMC200_AHB_MST6
           next_priority6 = mask6_req;
       `endif
       `ifdef ATCBMC200_AHB_MST7
           next_priority7 = mask7_req;
       `endif
       `ifdef ATCBMC200_AHB_MST8
           next_priority8 = mask8_req;
       `endif
       `ifdef ATCBMC200_AHB_MST9
           next_priority9 = mask9_req;
       `endif
       `ifdef ATCBMC200_AHB_MST10
           next_priority10 = mask10_req;
       `endif
       `ifdef ATCBMC200_AHB_MST11
           next_priority11 = mask11_req;
       `endif
       `ifdef ATCBMC200_AHB_MST12
           next_priority12 = mask12_req;
       `endif
       `ifdef ATCBMC200_AHB_MST13
           next_priority13 = mask13_req;
       `endif
       `ifdef ATCBMC200_AHB_MST14
           next_priority14 = mask14_req;
       `endif
       `ifdef ATCBMC200_AHB_MST15
           next_priority15 = mask15_req;
       `endif

       `ifdef ATCBMC200_AHB_MST0
           if (lv_mask0_req) next_priority0 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (lv_mask1_req) next_priority1 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (lv_mask2_req) next_priority2 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (lv_mask3_req) next_priority3 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (lv_mask4_req) next_priority4 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (lv_mask5_req) next_priority5 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (lv_mask6_req) next_priority6 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (lv_mask7_req) next_priority7 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (lv_mask8_req) next_priority8 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (lv_mask9_req) next_priority9 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (lv_mask10_req) next_priority10 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (lv_mask11_req) next_priority11 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (lv_mask12_req) next_priority12 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (lv_mask13_req) next_priority13 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (lv_mask14_req) next_priority14 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (lv_mask15_req) next_priority15 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST0
           if (mask0_req) next_priority0 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (mask1_req) next_priority1 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (mask2_req) next_priority2 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (mask3_req) next_priority3 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (mask4_req) next_priority4 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (mask5_req) next_priority5 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (mask6_req) next_priority6 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (mask7_req) next_priority7 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (mask8_req) next_priority8 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (mask9_req) next_priority9 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (mask10_req) next_priority10 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (mask11_req) next_priority11 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (mask12_req) next_priority12 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (mask13_req) next_priority13 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (mask14_req) next_priority14 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (mask15_req) next_priority15 = 1'b0; else
       `endif
       begin
           `ifdef ATCBMC200_AHB_MST0
               next_priority0 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST1
               next_priority1 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST2
               next_priority2 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST3
               next_priority3 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST4
               next_priority4 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST5
               next_priority5 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST6
               next_priority6 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST7
               next_priority7 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST8
               next_priority8 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST9
               next_priority9 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST10
               next_priority10 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST11
               next_priority11 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST12
               next_priority12 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST13
               next_priority13 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST14
               next_priority14 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST15
               next_priority15 = 1'b0;
           `endif
       end
   end
   else begin
       `ifdef ATCBMC200_AHB_MST0
           next_priority0 = mst0_req;
       `endif
       `ifdef ATCBMC200_AHB_MST1
           next_priority1 = mst1_req;
       `endif
       `ifdef ATCBMC200_AHB_MST2
           next_priority2 = mst2_req;
       `endif
       `ifdef ATCBMC200_AHB_MST3
           next_priority3 = mst3_req;
       `endif
       `ifdef ATCBMC200_AHB_MST4
           next_priority4 = mst4_req;
       `endif
       `ifdef ATCBMC200_AHB_MST5
           next_priority5 = mst5_req;
       `endif
       `ifdef ATCBMC200_AHB_MST6
           next_priority6 = mst6_req;
       `endif
       `ifdef ATCBMC200_AHB_MST7
           next_priority7 = mst7_req;
       `endif
       `ifdef ATCBMC200_AHB_MST8
           next_priority8 = mst8_req;
       `endif
       `ifdef ATCBMC200_AHB_MST9
           next_priority9 = mst9_req;
       `endif
       `ifdef ATCBMC200_AHB_MST10
           next_priority10 = mst10_req;
       `endif
       `ifdef ATCBMC200_AHB_MST11
           next_priority11 = mst11_req;
       `endif
       `ifdef ATCBMC200_AHB_MST12
           next_priority12 = mst12_req;
       `endif
       `ifdef ATCBMC200_AHB_MST13
           next_priority13 = mst13_req;
       `endif
       `ifdef ATCBMC200_AHB_MST14
           next_priority14 = mst14_req;
       `endif
       `ifdef ATCBMC200_AHB_MST15
           next_priority15 = mst15_req;
       `endif

       `ifdef ATCBMC200_AHB_MST0
           if (mst0_req) next_priority0 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST1
           if (mst1_req) next_priority1 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST2
           if (mst2_req) next_priority2 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST3
           if (mst3_req) next_priority3 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST4
           if (mst4_req) next_priority4 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST5
           if (mst5_req) next_priority5 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST6
           if (mst6_req) next_priority6 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST7
           if (mst7_req) next_priority7 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST8
           if (mst8_req) next_priority8 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST9
           if (mst9_req) next_priority9 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST10
           if (mst10_req) next_priority10 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST11
           if (mst11_req) next_priority11 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST12
           if (mst12_req) next_priority12 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST13
           if (mst13_req) next_priority13 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST14
           if (mst14_req) next_priority14 = 1'b0; else
       `endif
       `ifdef ATCBMC200_AHB_MST15
           if (mst15_req) next_priority15 = 1'b0; else
       `endif
       begin
           `ifdef ATCBMC200_AHB_MST0
               next_priority0 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST1
               next_priority1 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST2
               next_priority2 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST3
               next_priority3 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST4
               next_priority4 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST5
               next_priority5 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST6
               next_priority6 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST7
               next_priority7 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST8
               next_priority8 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST9
               next_priority9 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST10
               next_priority10 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST11
               next_priority11 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST12
               next_priority12 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST13
               next_priority13 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST14
               next_priority14 = 1'b0;
           `endif
           `ifdef ATCBMC200_AHB_MST15
               next_priority15 = 1'b0;
           `endif
       end
   end
end

endmodule
