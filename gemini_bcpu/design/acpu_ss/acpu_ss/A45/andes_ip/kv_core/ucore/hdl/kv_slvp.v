// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp (
    slv_clk,
    slv_reset_n,
    slv_clk_en,
    slv1_clk,
    slv1_reset_n,
    slv1_clk_en,
    lm_clk,
    lm_reset_n,
    lm_reset_done,
    csr_mdlmb_eccen,
    csr_milmb_eccen,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    slvp_ipipe_local_int,
    slv0_awid,
    slv0_awaddr,
    slv0_awlen,
    slv0_awsize,
    slv0_awburst,
    slv0_awlock,
    slv0_awcache,
    slv0_awprot,
    slv0_awuser,
    slv0_awready,
    slv0_awvalid,
    slv0_wdata,
    slv0_wstrb,
    slv0_wlast,
    slv0_wvalid,
    slv0_wready,
    slv0_bid,
    slv0_bresp,
    slv0_bvalid,
    slv0_bready,
    slv0_arid,
    slv0_araddr,
    slv0_arlen,
    slv0_arsize,
    slv0_arburst,
    slv0_arlock,
    slv0_arcache,
    slv0_arprot,
    slv0_aruser,
    slv0_arvalid,
    slv0_arready,
    slv0_rid,
    slv0_rdata,
    slv0_rresp,
    slv0_rlast,
    slv0_rvalid,
    slv0_rready,
    slv1_awid,
    slv1_awaddr,
    slv1_awlen,
    slv1_awsize,
    slv1_awburst,
    slv1_awlock,
    slv1_awcache,
    slv1_awprot,
    slv1_awuser,
    slv1_awready,
    slv1_awvalid,
    slv1_wdata,
    slv1_wstrb,
    slv1_wlast,
    slv1_wvalid,
    slv1_wready,
    slv1_bid,
    slv1_bresp,
    slv1_bvalid,
    slv1_bready,
    slv1_arid,
    slv1_araddr,
    slv1_arlen,
    slv1_arsize,
    slv1_arburst,
    slv1_arlock,
    slv1_arcache,
    slv1_arprot,
    slv1_aruser,
    slv1_arvalid,
    slv1_arready,
    slv1_rid,
    slv1_rdata,
    slv1_rresp,
    slv1_rlast,
    slv1_rvalid,
    slv1_rready,
    slv_ilm_a_addr,
    slv_ilm_a_mask,
    slv_ilm_a_func,
    slv_ilm_a_stall,
    slv_ilm_a_user,
    slv_ilm_a_valid,
    slv_ilm_a_ready,
    slv_ilm_d_data,
    slv_ilm_d_status,
    slv_ilm_d_user,
    slv_ilm_d_valid,
    slv_ilm_w_data,
    slv_ilm_w_mask,
    slv_ilm_w_valid,
    slv_ilm_w_ready,
    slv_dlm0_a_addr,
    slv_dlm0_a_func,
    slv_dlm0_a_stall,
    slv_dlm0_a_user,
    slv_dlm0_a_valid,
    slv_dlm0_a_ready,
    slv_dlm0_d_data,
    slv_dlm0_d_status,
    slv_dlm0_d_user,
    slv_dlm0_d_valid,
    slv_dlm0_w_data,
    slv_dlm0_w_mask,
    slv_dlm0_w_valid,
    slv_dlm0_w_ready,
    slv_dlm1_a_addr,
    slv_dlm1_a_func,
    slv_dlm1_a_stall,
    slv_dlm1_a_user,
    slv_dlm1_a_valid,
    slv_dlm1_a_ready,
    slv_dlm1_d_data,
    slv_dlm1_d_status,
    slv_dlm1_d_user,
    slv_dlm1_d_valid,
    slv_dlm1_w_data,
    slv_dlm1_w_mask,
    slv_dlm1_w_valid,
    slv_dlm1_w_ready,
    slv_dlm2_a_addr,
    slv_dlm2_a_func,
    slv_dlm2_a_stall,
    slv_dlm2_a_user,
    slv_dlm2_a_valid,
    slv_dlm2_a_ready,
    slv_dlm2_d_data,
    slv_dlm2_d_status,
    slv_dlm2_d_user,
    slv_dlm2_d_valid,
    slv_dlm2_w_data,
    slv_dlm2_w_mask,
    slv_dlm2_w_valid,
    slv_dlm2_w_ready,
    slv_dlm3_a_addr,
    slv_dlm3_a_func,
    slv_dlm3_a_stall,
    slv_dlm3_a_user,
    slv_dlm3_a_valid,
    slv_dlm3_a_ready,
    slv_dlm3_d_data,
    slv_dlm3_d_status,
    slv_dlm3_d_user,
    slv_dlm3_d_valid,
    slv_dlm3_w_data,
    slv_dlm3_w_mask,
    slv_dlm3_w_valid,
    slv_dlm3_w_ready
);
parameter SLAVE_PORT_ASYNC = 0;
parameter SLAVE_PORT_ADDR_WIDTH = 32;
parameter SLAVE_PORT_DATA_WIDTH = 32;
parameter SLAVE_PORT_ID_WIDTH = 4;
parameter ILM_UW = 1;
parameter DLM_UW = 1;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter ILM_AMSB = 19;
parameter DLM_AMSB = 19;
parameter DLM_BANK = 1;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
input slv_clk;
input slv_reset_n;
input slv_clk_en;
input slv1_clk;
input slv1_reset_n;
input slv1_clk_en;
input lm_clk;
input lm_reset_n;
input lm_reset_done;
input [1:0] csr_mdlmb_eccen;
input [1:0] csr_milmb_eccen;
output slvp_ipipe_ecc_corr;
output [3:0] slvp_ipipe_ecc_ramid;
output slvp_ipipe_local_int;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv0_awid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv0_awaddr;
input [7:0] slv0_awlen;
input [2:0] slv0_awsize;
input [1:0] slv0_awburst;
input slv0_awlock;
input [3:0] slv0_awcache;
input [2:0] slv0_awprot;
input slv0_awuser;
output slv0_awready;
input slv0_awvalid;
input [(SLAVE_PORT_DATA_WIDTH - 1):0] slv0_wdata;
input [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] slv0_wstrb;
input slv0_wlast;
input slv0_wvalid;
output slv0_wready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv0_bid;
output [1:0] slv0_bresp;
output slv0_bvalid;
input slv0_bready;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv0_arid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv0_araddr;
input [7:0] slv0_arlen;
input [2:0] slv0_arsize;
input [1:0] slv0_arburst;
input slv0_arlock;
input [3:0] slv0_arcache;
input [2:0] slv0_arprot;
input slv0_aruser;
input slv0_arvalid;
output slv0_arready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv0_rid;
output [(SLAVE_PORT_DATA_WIDTH - 1):0] slv0_rdata;
output [1:0] slv0_rresp;
output slv0_rlast;
output slv0_rvalid;
input slv0_rready;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_awid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv1_awaddr;
input [7:0] slv1_awlen;
input [2:0] slv1_awsize;
input [1:0] slv1_awburst;
input slv1_awlock;
input [3:0] slv1_awcache;
input [2:0] slv1_awprot;
input slv1_awuser;
output slv1_awready;
input slv1_awvalid;
input [(SLAVE_PORT_DATA_WIDTH - 1):0] slv1_wdata;
input [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] slv1_wstrb;
input slv1_wlast;
input slv1_wvalid;
output slv1_wready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_bid;
output [1:0] slv1_bresp;
output slv1_bvalid;
input slv1_bready;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_arid;
input [(SLAVE_PORT_ADDR_WIDTH - 1):0] slv1_araddr;
input [7:0] slv1_arlen;
input [2:0] slv1_arsize;
input [1:0] slv1_arburst;
input slv1_arlock;
input [3:0] slv1_arcache;
input [2:0] slv1_arprot;
input slv1_aruser;
input slv1_arvalid;
output slv1_arready;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_rid;
output [(SLAVE_PORT_DATA_WIDTH - 1):0] slv1_rdata;
output [1:0] slv1_rresp;
output slv1_rlast;
output slv1_rvalid;
input slv1_rready;
output [((ILM_AMSB + 1) - 1):0] slv_ilm_a_addr;
output [1:0] slv_ilm_a_mask;
output [2:0] slv_ilm_a_func;
output slv_ilm_a_stall;
output [(ILM_UW - 1):0] slv_ilm_a_user;
output slv_ilm_a_valid;
input slv_ilm_a_ready;
input [63:0] slv_ilm_d_data;
input [13:0] slv_ilm_d_status;
input [(ILM_UW - 1):0] slv_ilm_d_user;
input slv_ilm_d_valid;
output [63:0] slv_ilm_w_data;
output [7:0] slv_ilm_w_mask;
output slv_ilm_w_valid;
input slv_ilm_w_ready;
output [((DLM_AMSB + 1) - 1):0] slv_dlm0_a_addr;
output [2:0] slv_dlm0_a_func;
output slv_dlm0_a_stall;
output [(DLM_UW - 1):0] slv_dlm0_a_user;
output slv_dlm0_a_valid;
input slv_dlm0_a_ready;
input [31:0] slv_dlm0_d_data;
input [13:0] slv_dlm0_d_status;
input [(DLM_UW - 1):0] slv_dlm0_d_user;
input slv_dlm0_d_valid;
output [31:0] slv_dlm0_w_data;
output [3:0] slv_dlm0_w_mask;
output slv_dlm0_w_valid;
input slv_dlm0_w_ready;
output [((DLM_AMSB + 1) - 1):0] slv_dlm1_a_addr;
output [2:0] slv_dlm1_a_func;
output slv_dlm1_a_stall;
output [(DLM_UW - 1):0] slv_dlm1_a_user;
output slv_dlm1_a_valid;
input slv_dlm1_a_ready;
input [31:0] slv_dlm1_d_data;
input [13:0] slv_dlm1_d_status;
input [(DLM_UW - 1):0] slv_dlm1_d_user;
input slv_dlm1_d_valid;
output [31:0] slv_dlm1_w_data;
output [3:0] slv_dlm1_w_mask;
output slv_dlm1_w_valid;
input slv_dlm1_w_ready;
output [((DLM_AMSB + 1) - 1):0] slv_dlm2_a_addr;
output [2:0] slv_dlm2_a_func;
output slv_dlm2_a_stall;
output [(DLM_UW - 1):0] slv_dlm2_a_user;
output slv_dlm2_a_valid;
input slv_dlm2_a_ready;
input [31:0] slv_dlm2_d_data;
input [13:0] slv_dlm2_d_status;
input [(DLM_UW - 1):0] slv_dlm2_d_user;
input slv_dlm2_d_valid;
output [31:0] slv_dlm2_w_data;
output [3:0] slv_dlm2_w_mask;
output slv_dlm2_w_valid;
input slv_dlm2_w_ready;
output [((DLM_AMSB + 1) - 1):0] slv_dlm3_a_addr;
output [2:0] slv_dlm3_a_func;
output slv_dlm3_a_stall;
output [(DLM_UW - 1):0] slv_dlm3_a_user;
output slv_dlm3_a_valid;
input slv_dlm3_a_ready;
input [31:0] slv_dlm3_d_data;
input [13:0] slv_dlm3_d_status;
input [(DLM_UW - 1):0] slv_dlm3_d_user;
input slv_dlm3_d_valid;
output [31:0] slv_dlm3_w_data;
output [3:0] slv_dlm3_w_mask;
output slv_dlm3_w_valid;
input slv_dlm3_w_ready;


wire [((DLM_AMSB + 1) - 1):0] s0;
wire [2:0] s1;
wire s2;
wire [(DLM_UW - 1):0] s3;
wire s4;
wire [31:0] s5;
wire [3:0] s6;
wire s7;
wire [((DLM_AMSB + 1) - 1):0] s8;
wire [2:0] s9;
wire s10;
wire [(DLM_UW - 1):0] s11;
wire s12;
wire [31:0] s13;
wire [3:0] s14;
wire s15;
wire [((DLM_AMSB + 1) - 1):0] s16;
wire [2:0] s17;
wire s18;
wire [(DLM_UW - 1):0] s19;
wire s20;
wire [31:0] s21;
wire [3:0] s22;
wire s23;
wire [((DLM_AMSB + 1) - 1):0] s24;
wire [2:0] s25;
wire s26;
wire [(DLM_UW - 1):0] s27;
wire s28;
wire [31:0] s29;
wire [3:0] s30;
wire s31;
wire [((ILM_AMSB + 1) - 1):0] s32;
wire [2:0] s33;
wire [1:0] s34;
wire s35;
wire [(ILM_UW - 1):0] s36;
wire s37;
wire [63:0] s38;
wire [7:0] s39;
wire s40;
wire s41;
wire [3:0] s42;
wire s43;
wire [((DLM_AMSB + 1) - 1):0] s44;
wire [2:0] s45;
wire s46;
wire [(DLM_UW - 1):0] s47;
wire s48;
wire [31:0] s49;
wire [3:0] s50;
wire s51;
wire [((DLM_AMSB + 1) - 1):0] s52;
wire [2:0] s53;
wire s54;
wire [(DLM_UW - 1):0] s55;
wire s56;
wire [31:0] s57;
wire [3:0] s58;
wire s59;
wire [((DLM_AMSB + 1) - 1):0] s60;
wire [2:0] s61;
wire s62;
wire [(DLM_UW - 1):0] s63;
wire s64;
wire [31:0] s65;
wire [3:0] s66;
wire s67;
wire [((DLM_AMSB + 1) - 1):0] s68;
wire [2:0] s69;
wire s70;
wire [(DLM_UW - 1):0] s71;
wire s72;
wire [31:0] s73;
wire [3:0] s74;
wire s75;
wire [((ILM_AMSB + 1) - 1):0] s76;
wire [2:0] s77;
wire [1:0] s78;
wire s79;
wire [(ILM_UW - 1):0] s80;
wire s81;
wire [63:0] s82;
wire [7:0] s83;
wire s84;
wire s85;
wire [3:0] s86;
wire s87;
wire [0:0] nds_unused_slv_dlm0_a_mask;
wire s88;
wire [31:0] s89;
wire [13:0] s90;
wire [(DLM_UW - 1):0] s91;
wire s92;
wire s93;
wire s94;
wire [31:0] s95;
wire [13:0] s96;
wire [(DLM_UW - 1):0] s97;
wire s98;
wire s99;
wire [0:0] nds_unused_slv_dlm1_a_mask;
wire s100;
wire [31:0] s101;
wire [13:0] s102;
wire [(DLM_UW - 1):0] s103;
wire s104;
wire s105;
wire s106;
wire [31:0] s107;
wire [13:0] s108;
wire [(DLM_UW - 1):0] s109;
wire s110;
wire s111;
wire [0:0] nds_unused_slv_dlm2_a_mask;
wire s112;
wire [31:0] s113;
wire [13:0] s114;
wire [(DLM_UW - 1):0] s115;
wire s116;
wire s117;
wire s118;
wire [31:0] s119;
wire [13:0] s120;
wire [(DLM_UW - 1):0] s121;
wire s122;
wire s123;
wire [0:0] nds_unused_slv_dlm3_a_mask;
wire s124;
wire [31:0] s125;
wire [13:0] s126;
wire [(DLM_UW - 1):0] s127;
wire s128;
wire s129;
wire s130;
wire [31:0] s131;
wire [13:0] s132;
wire [(DLM_UW - 1):0] s133;
wire s134;
wire s135;
wire s136;
wire [63:0] s137;
wire [13:0] s138;
wire [(ILM_UW - 1):0] s139;
wire s140;
wire s141;
wire s142;
wire [63:0] s143;
wire [13:0] s144;
wire [(ILM_UW - 1):0] s145;
wire s146;
wire s147;
assign s0 = {(DLM_AMSB + 1){1'b0}};
assign s1 = {3{1'b0}};
assign s2 = 1'b0;
assign s3 = {(DLM_UW){1'b0}};
assign s4 = 1'b0;
assign s5 = {32{1'b0}};
assign s6 = {4{1'b0}};
assign s7 = 1'b0;
assign s8 = {(DLM_AMSB + 1){1'b0}};
assign s9 = {3{1'b0}};
assign s10 = 1'b0;
assign s11 = {(DLM_UW){1'b0}};
assign s12 = 1'b0;
assign s13 = {32{1'b0}};
assign s14 = {4{1'b0}};
assign s15 = 1'b0;
assign s16 = {(DLM_AMSB + 1){1'b0}};
assign s17 = {3{1'b0}};
assign s18 = 1'b0;
assign s19 = {(DLM_UW){1'b0}};
assign s20 = 1'b0;
assign s21 = {32{1'b0}};
assign s22 = {4{1'b0}};
assign s23 = 1'b0;
assign s24 = {(DLM_AMSB + 1){1'b0}};
assign s25 = {3{1'b0}};
assign s26 = 1'b0;
assign s27 = {(DLM_UW){1'b0}};
assign s28 = 1'b0;
assign s29 = {32{1'b0}};
assign s30 = {4{1'b0}};
assign s31 = 1'b0;
assign s32 = {(ILM_AMSB + 1){1'b0}};
assign s33 = {3{1'b0}};
assign s34 = {2{1'b0}};
assign s35 = 1'b0;
assign s36 = {(ILM_UW){1'b0}};
assign s37 = 1'b0;
assign s38 = {64{1'b0}};
assign s39 = {8{1'b0}};
assign s40 = 1'b0;
assign s41 = 1'b0;
assign s42 = {4{1'b0}};
assign s43 = 1'b0;
assign s44 = {(DLM_AMSB + 1){1'b0}};
assign s45 = {3{1'b0}};
assign s46 = 1'b0;
assign s47 = {(DLM_UW){1'b0}};
assign s48 = 1'b0;
assign s49 = {32{1'b0}};
assign s50 = {4{1'b0}};
assign s51 = 1'b0;
assign s52 = {(DLM_AMSB + 1){1'b0}};
assign s53 = {3{1'b0}};
assign s54 = 1'b0;
assign s55 = {(DLM_UW){1'b0}};
assign s56 = 1'b0;
assign s57 = {32{1'b0}};
assign s58 = {4{1'b0}};
assign s59 = 1'b0;
assign s60 = {(DLM_AMSB + 1){1'b0}};
assign s61 = {3{1'b0}};
assign s62 = 1'b0;
assign s63 = {(DLM_UW){1'b0}};
assign s64 = 1'b0;
assign s65 = {32{1'b0}};
assign s66 = {4{1'b0}};
assign s67 = 1'b0;
assign s68 = {(DLM_AMSB + 1){1'b0}};
assign s69 = {3{1'b0}};
assign s70 = 1'b0;
assign s71 = {(DLM_UW){1'b0}};
assign s72 = 1'b0;
assign s73 = {32{1'b0}};
assign s74 = {4{1'b0}};
assign s75 = 1'b0;
assign s76 = {(ILM_AMSB + 1){1'b0}};
assign s77 = {3{1'b0}};
assign s78 = {2{1'b0}};
assign s79 = 1'b0;
assign s80 = {(ILM_UW){1'b0}};
assign s81 = 1'b0;
assign s82 = {64{1'b0}};
assign s83 = {8{1'b0}};
assign s84 = 1'b0;
assign s85 = 1'b0;
assign s86 = {4{1'b0}};
assign s87 = 1'b0;
assign s88 = 1'b0;
assign s89 = {32{1'b0}};
assign s90 = {14{1'b0}};
assign s91 = {(DLM_UW){1'b0}};
assign s92 = 1'b0;
assign s93 = 1'b0;
assign s94 = 1'b0;
assign s95 = {32{1'b0}};
assign s96 = {14{1'b0}};
assign s97 = {(DLM_UW){1'b0}};
assign s98 = 1'b0;
assign s99 = 1'b0;
assign s100 = 1'b0;
assign s101 = {32{1'b0}};
assign s102 = {14{1'b0}};
assign s103 = {(DLM_UW){1'b0}};
assign s104 = 1'b0;
assign s105 = 1'b0;
assign s106 = 1'b0;
assign s107 = {32{1'b0}};
assign s108 = {14{1'b0}};
assign s109 = {(DLM_UW){1'b0}};
assign s110 = 1'b0;
assign s111 = 1'b0;
assign s112 = 1'b0;
assign s113 = {32{1'b0}};
assign s114 = {14{1'b0}};
assign s115 = {(DLM_UW){1'b0}};
assign s116 = 1'b0;
assign s117 = 1'b0;
assign s118 = 1'b0;
assign s119 = {32{1'b0}};
assign s120 = {14{1'b0}};
assign s121 = {(DLM_UW){1'b0}};
assign s122 = 1'b0;
assign s123 = 1'b0;
assign s124 = 1'b0;
assign s125 = {32{1'b0}};
assign s126 = {14{1'b0}};
assign s127 = {(DLM_UW){1'b0}};
assign s128 = 1'b0;
assign s129 = 1'b0;
assign s130 = 1'b0;
assign s131 = {32{1'b0}};
assign s132 = {14{1'b0}};
assign s133 = {(DLM_UW){1'b0}};
assign s134 = 1'b0;
assign s135 = 1'b0;
assign s136 = 1'b0;
assign s137 = {64{1'b0}};
assign s138 = {14{1'b0}};
assign s139 = {(ILM_UW){1'b0}};
assign s140 = 1'b0;
assign s141 = 1'b0;
assign s142 = 1'b0;
assign s143 = {64{1'b0}};
assign s144 = {14{1'b0}};
assign s145 = {(ILM_UW){1'b0}};
assign s146 = 1'b0;
assign s147 = 1'b0;
assign slv1_awready = 1'b0;
assign slv1_wready = 1'b0;
assign slv1_bid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
assign slv1_bresp = {2{1'b0}};
assign slv1_bvalid = 1'b0;
assign slv1_arready = 1'b0;
assign slv1_rid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
assign slv1_rdata = {(SLAVE_PORT_DATA_WIDTH){1'b0}};
assign slv1_rresp = {2{1'b0}};
assign slv1_rlast = 1'b0;
assign slv1_rvalid = 1'b0;
assign nds_unused_slv_dlm0_a_mask = 1'b0;
assign nds_unused_slv_dlm1_a_mask = 1'b0;
assign nds_unused_slv_dlm2_a_mask = 1'b0;
assign nds_unused_slv_dlm3_a_mask = 1'b0;
wire nds_unused_slv1_clk = slv1_clk;
wire nds_unused_slv1_reset_n = slv1_reset_n;
wire nds_unused_slv1_clk_en = slv1_clk_en;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] s148 = slv1_awid;
wire [(SLAVE_PORT_ADDR_WIDTH - 1):0] s149 = slv1_awaddr;
wire [7:0] nds_unused_slv1_awlen = slv1_awlen;
wire [2:0] nds_unused_slv1_awsize = slv1_awsize;
wire [1:0] nds_unused_slv1_awburst = slv1_awburst;
wire nds_unused_slv1_awlock = slv1_awlock;
wire [3:0] nds_unused_slv1_awcache = slv1_awcache;
wire [2:0] nds_unused_slv1_awprot = slv1_awprot;
wire nds_unused_slv1_awuser = slv1_awuser;
wire nds_unused_slv1_awvalid = slv1_awvalid;
wire [(SLAVE_PORT_DATA_WIDTH - 1):0] s150 = slv1_wdata;
wire [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] s151 = slv1_wstrb;
wire nds_unused_slv1_wlast = slv1_wlast;
wire nds_unused_slv1_wvalid = slv1_wvalid;
wire nds_unused_slv1_bready = slv1_bready;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] s152 = slv1_arid;
wire [(SLAVE_PORT_ADDR_WIDTH - 1):0] s153 = slv1_araddr;
wire [7:0] nds_unused_slv1_arlen = slv1_arlen;
wire [2:0] nds_unused_slv1_arsize = slv1_arsize;
wire [1:0] nds_unused_slv1_arburst = slv1_arburst;
wire nds_unused_slv1_arlock = slv1_arlock;
wire [3:0] nds_unused_slv1_arcache = slv1_arcache;
wire [2:0] nds_unused_slv1_arprot = slv1_arprot;
wire nds_unused_slv1_aruser = slv1_aruser;
wire nds_unused_slv1_arvalid = slv1_arvalid;
wire nds_unused_slv1_rready = slv1_rready;
wire [((DLM_AMSB + 1) - 1):0] s154 = s0;
wire [2:0] nds_unused_slv0_dlm0_a_func = s1;
wire nds_unused_slv0_dlm0_a_stall = s2;
wire [(DLM_UW - 1):0] s155 = s3;
wire nds_unused_slv0_dlm0_a_valid = s4;
wire [31:0] nds_unused_slv0_dlm0_w_data = s5;
wire [3:0] nds_unused_slv0_dlm0_w_mask = s6;
wire nds_unused_slv0_dlm0_w_valid = s7;
wire [((DLM_AMSB + 1) - 1):0] s156 = s8;
wire [2:0] nds_unused_slv0_dlm1_a_func = s9;
wire nds_unused_slv0_dlm1_a_stall = s10;
wire [(DLM_UW - 1):0] s157 = s11;
wire nds_unused_slv0_dlm1_a_valid = s12;
wire [31:0] nds_unused_slv0_dlm1_w_data = s13;
wire [3:0] nds_unused_slv0_dlm1_w_mask = s14;
wire nds_unused_slv0_dlm1_w_valid = s15;
wire [((DLM_AMSB + 1) - 1):0] s158 = s16;
wire [2:0] nds_unused_slv0_dlm2_a_func = s17;
wire nds_unused_slv0_dlm2_a_stall = s18;
wire [(DLM_UW - 1):0] s159 = s19;
wire nds_unused_slv0_dlm2_a_valid = s20;
wire [31:0] nds_unused_slv0_dlm2_w_data = s21;
wire [3:0] nds_unused_slv0_dlm2_w_mask = s22;
wire nds_unused_slv0_dlm2_w_valid = s23;
wire [((DLM_AMSB + 1) - 1):0] s160 = s24;
wire [2:0] nds_unused_slv0_dlm3_a_func = s25;
wire nds_unused_slv0_dlm3_a_stall = s26;
wire [(DLM_UW - 1):0] s161 = s27;
wire nds_unused_slv0_dlm3_a_valid = s28;
wire [31:0] nds_unused_slv0_dlm3_w_data = s29;
wire [3:0] nds_unused_slv0_dlm3_w_mask = s30;
wire nds_unused_slv0_dlm3_w_valid = s31;
wire [((ILM_AMSB + 1) - 1):0] s162 = s32;
wire [2:0] nds_unused_slv0_ilm_a_func = s33;
wire [1:0] nds_unused_slv0_ilm_a_mask = s34;
wire nds_unused_slv0_ilm_a_stall = s35;
wire [(ILM_UW - 1):0] s163 = s36;
wire nds_unused_slv0_ilm_a_valid = s37;
wire [63:0] nds_unused_slv0_ilm_w_data = s38;
wire [7:0] nds_unused_slv0_ilm_w_mask = s39;
wire nds_unused_slv0_ilm_w_valid = s40;
wire nds_unused_slvp0_ipipe_ecc_corr = s41;
wire [3:0] nds_unused_slvp0_ipipe_ecc_ramid = s42;
wire nds_unused_slvp0_ipipe_local_int = s43;
wire [((DLM_AMSB + 1) - 1):0] s164 = s44;
wire [2:0] nds_unused_slv1_dlm0_a_func = s45;
wire nds_unused_slv1_dlm0_a_stall = s46;
wire [(DLM_UW - 1):0] s165 = s47;
wire nds_unused_slv1_dlm0_a_valid = s48;
wire [31:0] nds_unused_slv1_dlm0_w_data = s49;
wire [3:0] nds_unused_slv1_dlm0_w_mask = s50;
wire nds_unused_slv1_dlm0_w_valid = s51;
wire [((DLM_AMSB + 1) - 1):0] s166 = s52;
wire [2:0] nds_unused_slv1_dlm1_a_func = s53;
wire nds_unused_slv1_dlm1_a_stall = s54;
wire [(DLM_UW - 1):0] s167 = s55;
wire nds_unused_slv1_dlm1_a_valid = s56;
wire [31:0] nds_unused_slv1_dlm1_w_data = s57;
wire [3:0] nds_unused_slv1_dlm1_w_mask = s58;
wire nds_unused_slv1_dlm1_w_valid = s59;
wire [((DLM_AMSB + 1) - 1):0] s168 = s60;
wire [2:0] nds_unused_slv1_dlm2_a_func = s61;
wire nds_unused_slv1_dlm2_a_stall = s62;
wire [(DLM_UW - 1):0] s169 = s63;
wire nds_unused_slv1_dlm2_a_valid = s64;
wire [31:0] nds_unused_slv1_dlm2_w_data = s65;
wire [3:0] nds_unused_slv1_dlm2_w_mask = s66;
wire nds_unused_slv1_dlm2_w_valid = s67;
wire [((DLM_AMSB + 1) - 1):0] s170 = s68;
wire [2:0] nds_unused_slv1_dlm3_a_func = s69;
wire nds_unused_slv1_dlm3_a_stall = s70;
wire [(DLM_UW - 1):0] s171 = s71;
wire nds_unused_slv1_dlm3_a_valid = s72;
wire [31:0] nds_unused_slv1_dlm3_w_data = s73;
wire [3:0] nds_unused_slv1_dlm3_w_mask = s74;
wire nds_unused_slv1_dlm3_w_valid = s75;
wire [((ILM_AMSB + 1) - 1):0] s172 = s76;
wire [2:0] nds_unused_slv1_ilm_a_func = s77;
wire [1:0] nds_unused_slv1_ilm_a_mask = s78;
wire nds_unused_slv1_ilm_a_stall = s79;
wire [(ILM_UW - 1):0] s173 = s80;
wire nds_unused_slv1_ilm_a_valid = s81;
wire [63:0] nds_unused_slv1_ilm_w_data = s82;
wire [7:0] nds_unused_slv1_ilm_w_mask = s83;
wire nds_unused_slv1_ilm_w_valid = s84;
wire nds_unused_slvp1_ipipe_ecc_corr = s85;
wire [3:0] nds_unused_slvp1_ipipe_ecc_ramid = s86;
wire nds_unused_slvp1_ipipe_local_int = s87;
wire nds_unused_slv0_dlm0_a_ready = s88;
wire [31:0] nds_unused_slv0_dlm0_d_data = s89;
wire [13:0] nds_unused_slv0_dlm0_d_status = s90;
wire [(DLM_UW - 1):0] s174 = s91;
wire nds_unused_slv0_dlm0_d_valid = s92;
wire nds_unused_slv0_dlm0_w_ready = s93;
wire nds_unused_slv1_dlm0_a_ready = s94;
wire [31:0] nds_unused_slv1_dlm0_d_data = s95;
wire [13:0] nds_unused_slv1_dlm0_d_status = s96;
wire [(DLM_UW - 1):0] s175 = s97;
wire nds_unused_slv1_dlm0_d_valid = s98;
wire nds_unused_slv1_dlm0_w_ready = s99;
wire nds_unused_slv0_dlm1_a_ready = s100;
wire [31:0] nds_unused_slv0_dlm1_d_data = s101;
wire [13:0] nds_unused_slv0_dlm1_d_status = s102;
wire [(DLM_UW - 1):0] s176 = s103;
wire nds_unused_slv0_dlm1_d_valid = s104;
wire nds_unused_slv0_dlm1_w_ready = s105;
wire nds_unused_slv1_dlm1_a_ready = s106;
wire [31:0] nds_unused_slv1_dlm1_d_data = s107;
wire [13:0] nds_unused_slv1_dlm1_d_status = s108;
wire [(DLM_UW - 1):0] s177 = s109;
wire nds_unused_slv1_dlm1_d_valid = s110;
wire nds_unused_slv1_dlm1_w_ready = s111;
wire nds_unused_slv0_dlm2_a_ready = s112;
wire [31:0] nds_unused_slv0_dlm2_d_data = s113;
wire [13:0] nds_unused_slv0_dlm2_d_status = s114;
wire [(DLM_UW - 1):0] s178 = s115;
wire nds_unused_slv0_dlm2_d_valid = s116;
wire nds_unused_slv0_dlm2_w_ready = s117;
wire nds_unused_slv1_dlm2_a_ready = s118;
wire [31:0] nds_unused_slv1_dlm2_d_data = s119;
wire [13:0] nds_unused_slv1_dlm2_d_status = s120;
wire [(DLM_UW - 1):0] s179 = s121;
wire nds_unused_slv1_dlm2_d_valid = s122;
wire nds_unused_slv1_dlm2_w_ready = s123;
wire nds_unused_slv0_dlm3_a_ready = s124;
wire [31:0] nds_unused_slv0_dlm3_d_data = s125;
wire [13:0] nds_unused_slv0_dlm3_d_status = s126;
wire [(DLM_UW - 1):0] s180 = s127;
wire nds_unused_slv0_dlm3_d_valid = s128;
wire nds_unused_slv0_dlm3_w_ready = s129;
wire nds_unused_slv1_dlm3_a_ready = s130;
wire [31:0] nds_unused_slv1_dlm3_d_data = s131;
wire [13:0] nds_unused_slv1_dlm3_d_status = s132;
wire [(DLM_UW - 1):0] s181 = s133;
wire nds_unused_slv1_dlm3_d_valid = s134;
wire nds_unused_slv1_dlm3_w_ready = s135;
wire nds_unused_slv0_ilm_a_ready = s136;
wire [63:0] nds_unused_slv0_ilm_d_data = s137;
wire [13:0] nds_unused_slv0_ilm_d_status = s138;
wire [(ILM_UW - 1):0] s182 = s139;
wire nds_unused_slv0_ilm_d_valid = s140;
wire nds_unused_slv0_ilm_w_ready = s141;
wire nds_unused_slv1_ilm_a_ready = s142;
wire [63:0] nds_unused_slv1_ilm_d_data = s143;
wire [13:0] nds_unused_slv1_ilm_d_status = s144;
wire [(ILM_UW - 1):0] s183 = s145;
wire nds_unused_slv1_ilm_d_valid = s146;
wire nds_unused_slv1_ilm_w_ready = s147;
kv_slvp_single #(
    .DLM_AMSB(DLM_AMSB),
    .DLM_BANK(DLM_BANK),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_UW(DLM_UW),
    .ILM_AMSB(ILM_AMSB),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_UW(ILM_UW),
    .SLAVE_PORT_ADDR_WIDTH(SLAVE_PORT_ADDR_WIDTH),
    .SLAVE_PORT_ASYNC(SLAVE_PORT_ASYNC),
    .SLAVE_PORT_DATA_WIDTH(SLAVE_PORT_DATA_WIDTH),
    .SLAVE_PORT_ID_WIDTH(SLAVE_PORT_ID_WIDTH),
    .SLAVE_PORT_SOURCE_ID(1'b0)
) u_slvp_single (
    .lm_reset_done(lm_reset_done),
    .slv_clk(slv_clk),
    .slv_reset_n(slv_reset_n),
    .slv_clk_en(slv_clk_en),
    .lm_clk(lm_clk),
    .lm_reset_n(lm_reset_n),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .csr_milmb_eccen(csr_milmb_eccen),
    .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
    .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
    .slvp_ipipe_local_int(slvp_ipipe_local_int),
    .slv_awid(slv0_awid),
    .slv_awaddr(slv0_awaddr),
    .slv_awlen(slv0_awlen),
    .slv_awsize(slv0_awsize),
    .slv_awburst(slv0_awburst),
    .slv_awlock(slv0_awlock),
    .slv_awcache(slv0_awcache),
    .slv_awprot(slv0_awprot),
    .slv_awuser(slv0_awuser),
    .slv_awready(slv0_awready),
    .slv_awvalid(slv0_awvalid),
    .slv_wdata(slv0_wdata),
    .slv_wstrb(slv0_wstrb),
    .slv_wlast(slv0_wlast),
    .slv_wvalid(slv0_wvalid),
    .slv_wready(slv0_wready),
    .slv_bid(slv0_bid),
    .slv_bresp(slv0_bresp),
    .slv_bvalid(slv0_bvalid),
    .slv_bready(slv0_bready),
    .slv_arid(slv0_arid),
    .slv_araddr(slv0_araddr),
    .slv_arlen(slv0_arlen),
    .slv_arsize(slv0_arsize),
    .slv_arburst(slv0_arburst),
    .slv_arlock(slv0_arlock),
    .slv_arcache(slv0_arcache),
    .slv_arprot(slv0_arprot),
    .slv_aruser(slv0_aruser),
    .slv_arvalid(slv0_arvalid),
    .slv_arready(slv0_arready),
    .slv_rid(slv0_rid),
    .slv_rdata(slv0_rdata),
    .slv_rresp(slv0_rresp),
    .slv_rlast(slv0_rlast),
    .slv_rvalid(slv0_rvalid),
    .slv_rready(slv0_rready),
    .slv_dlm0_a_addr(slv_dlm0_a_addr),
    .slv_dlm0_a_func(slv_dlm0_a_func),
    .slv_dlm0_a_stall(slv_dlm0_a_stall),
    .slv_dlm0_a_user(slv_dlm0_a_user),
    .slv_dlm0_a_valid(slv_dlm0_a_valid),
    .slv_dlm0_a_ready(slv_dlm0_a_ready),
    .slv_dlm0_d_data(slv_dlm0_d_data),
    .slv_dlm0_d_status(slv_dlm0_d_status),
    .slv_dlm0_d_user(slv_dlm0_d_user),
    .slv_dlm0_d_valid(slv_dlm0_d_valid),
    .slv_dlm0_w_data(slv_dlm0_w_data),
    .slv_dlm0_w_mask(slv_dlm0_w_mask),
    .slv_dlm0_w_valid(slv_dlm0_w_valid),
    .slv_dlm0_w_ready(slv_dlm0_w_ready),
    .slv_dlm1_a_addr(slv_dlm1_a_addr),
    .slv_dlm1_a_func(slv_dlm1_a_func),
    .slv_dlm1_a_stall(slv_dlm1_a_stall),
    .slv_dlm1_a_user(slv_dlm1_a_user),
    .slv_dlm1_a_valid(slv_dlm1_a_valid),
    .slv_dlm1_a_ready(slv_dlm1_a_ready),
    .slv_dlm1_d_data(slv_dlm1_d_data),
    .slv_dlm1_d_status(slv_dlm1_d_status),
    .slv_dlm1_d_user(slv_dlm1_d_user),
    .slv_dlm1_d_valid(slv_dlm1_d_valid),
    .slv_dlm1_w_data(slv_dlm1_w_data),
    .slv_dlm1_w_mask(slv_dlm1_w_mask),
    .slv_dlm1_w_valid(slv_dlm1_w_valid),
    .slv_dlm1_w_ready(slv_dlm1_w_ready),
    .slv_dlm2_a_addr(slv_dlm2_a_addr),
    .slv_dlm2_a_func(slv_dlm2_a_func),
    .slv_dlm2_a_stall(slv_dlm2_a_stall),
    .slv_dlm2_a_user(slv_dlm2_a_user),
    .slv_dlm2_a_valid(slv_dlm2_a_valid),
    .slv_dlm2_a_ready(slv_dlm2_a_ready),
    .slv_dlm2_d_data(slv_dlm2_d_data),
    .slv_dlm2_d_status(slv_dlm2_d_status),
    .slv_dlm2_d_user(slv_dlm2_d_user),
    .slv_dlm2_d_valid(slv_dlm2_d_valid),
    .slv_dlm2_w_data(slv_dlm2_w_data),
    .slv_dlm2_w_mask(slv_dlm2_w_mask),
    .slv_dlm2_w_valid(slv_dlm2_w_valid),
    .slv_dlm2_w_ready(slv_dlm2_w_ready),
    .slv_dlm3_a_addr(slv_dlm3_a_addr),
    .slv_dlm3_a_func(slv_dlm3_a_func),
    .slv_dlm3_a_stall(slv_dlm3_a_stall),
    .slv_dlm3_a_user(slv_dlm3_a_user),
    .slv_dlm3_a_valid(slv_dlm3_a_valid),
    .slv_dlm3_a_ready(slv_dlm3_a_ready),
    .slv_dlm3_d_data(slv_dlm3_d_data),
    .slv_dlm3_d_status(slv_dlm3_d_status),
    .slv_dlm3_d_user(slv_dlm3_d_user),
    .slv_dlm3_d_valid(slv_dlm3_d_valid),
    .slv_dlm3_w_data(slv_dlm3_w_data),
    .slv_dlm3_w_mask(slv_dlm3_w_mask),
    .slv_dlm3_w_valid(slv_dlm3_w_valid),
    .slv_dlm3_w_ready(slv_dlm3_w_ready),
    .slv_ilm_a_addr(slv_ilm_a_addr),
    .slv_ilm_a_mask(slv_ilm_a_mask),
    .slv_ilm_a_func(slv_ilm_a_func),
    .slv_ilm_a_stall(slv_ilm_a_stall),
    .slv_ilm_a_user(slv_ilm_a_user),
    .slv_ilm_a_valid(slv_ilm_a_valid),
    .slv_ilm_a_ready(slv_ilm_a_ready),
    .slv_ilm_d_data(slv_ilm_d_data),
    .slv_ilm_d_status(slv_ilm_d_status),
    .slv_ilm_d_user(slv_ilm_d_user),
    .slv_ilm_d_valid(slv_ilm_d_valid),
    .slv_ilm_w_data(slv_ilm_w_data),
    .slv_ilm_w_mask(slv_ilm_w_mask),
    .slv_ilm_w_valid(slv_ilm_w_valid),
    .slv_ilm_w_ready(slv_ilm_w_ready)
);
endmodule

