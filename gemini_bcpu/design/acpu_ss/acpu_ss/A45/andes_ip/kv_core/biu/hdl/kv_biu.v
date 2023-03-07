// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_biu (
    dcu_a_address,
    dcu_a_corrupt,
    dcu_a_data,
    dcu_a_mask,
    dcu_a_opcode,
    dcu_a_param,
    dcu_a_ready,
    dcu_a_size,
    dcu_a_source,
    dcu_a_user,
    dcu_a_valid,
    dcu_c_address,
    dcu_c_corrupt,
    dcu_c_data,
    dcu_c_opcode,
    dcu_c_param,
    dcu_c_ready,
    dcu_c_size,
    dcu_c_source,
    dcu_c_user,
    dcu_c_valid,
    dcu_d_corrupt,
    dcu_d_data,
    dcu_d_denied,
    dcu_d_opcode,
    dcu_d_param,
    dcu_d_ready,
    dcu_d_sink,
    dcu_d_size,
    dcu_d_source,
    dcu_d_user,
    dcu_d_valid,
    dcu_e_ready,
    dcu_e_sink,
    dcu_e_valid,
    icu_a_source,
    icu_a_user,
    icu_d_source,
    icu_d_user,
    lsu_a_address,
    lsu_a_corrupt,
    lsu_a_data,
    lsu_a_mask,
    lsu_a_opcode,
    lsu_a_param,
    lsu_a_ready,
    lsu_a_size,
    lsu_a_source,
    lsu_a_user,
    lsu_a_valid,
    lsu_d_corrupt,
    lsu_d_data,
    lsu_d_denied,
    lsu_d_opcode,
    lsu_d_param,
    lsu_d_ready,
    lsu_d_sink,
    lsu_d_size,
    lsu_d_source,
    lsu_d_user,
    lsu_d_valid,
    test_mode,
    bus_clk,
    core_reset_n,
    araddr,
    arburst,
    arcache,
    arid,
    arlen,
    arlock,
    arprot,
    arready,
    arsize,
    arvalid,
    awaddr,
    awburst,
    awcache,
    awid,
    awlen,
    awlock,
    awprot,
    awready,
    awsize,
    awvalid,
    bid,
    bready,
    bresp,
    bvalid,
    rdata,
    rid,
    rlast,
    rready,
    rresp,
    rvalid,
    wdata,
    wlast,
    wready,
    wstrb,
    wvalid,
    bus_clk_en,
    core_clk,
    d_araddr,
    d_arburst,
    d_arcache,
    d_arid,
    d_arlen,
    d_arlock,
    d_arprot,
    d_arready,
    d_arsize,
    d_arvalid,
    d_awaddr,
    d_awburst,
    d_awcache,
    d_awid,
    d_awlen,
    d_awlock,
    d_awprot,
    d_awready,
    d_awsize,
    d_awvalid,
    d_bid,
    d_bready,
    d_bresp,
    d_bvalid,
    d_rdata,
    d_rid,
    d_rlast,
    d_rready,
    d_rresp,
    d_rvalid,
    d_wdata,
    d_wlast,
    d_wready,
    d_wstrb,
    d_wvalid,
    i_araddr,
    i_arburst,
    i_arcache,
    i_arid,
    i_arlen,
    i_arlock,
    i_arprot,
    i_arready,
    i_arsize,
    i_arvalid,
    i_awaddr,
    i_awburst,
    i_awcache,
    i_awid,
    i_awlen,
    i_awlock,
    i_awprot,
    i_awready,
    i_awsize,
    i_awvalid,
    i_bid,
    i_bready,
    i_bresp,
    i_bvalid,
    i_rdata,
    i_rid,
    i_rlast,
    i_rready,
    i_rresp,
    i_rvalid,
    i_wdata,
    i_wlast,
    i_wready,
    i_wstrb,
    i_wvalid,
    icu_a_address,
    icu_a_corrupt,
    icu_a_data,
    icu_a_mask,
    icu_a_opcode,
    icu_a_param,
    icu_a_ready,
    icu_a_size,
    icu_a_valid,
    icu_d_corrupt,
    icu_d_data,
    icu_d_denied,
    icu_d_opcode,
    icu_d_param,
    icu_d_ready,
    icu_d_sink,
    icu_d_size,
    icu_d_valid
);
parameter BIU_ADDR_WIDTH = 32;
parameter BIU_DATA_WIDTH = 64;
parameter BIU_PATH_X2_INT = 0;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter TL_SIZE_WIDTH = 3;
parameter TL_SINK_WIDTH = 2;
parameter BIU_ID_WIDTH = 4;
parameter BIU_ASYNC_SUPPORT = 0;
localparam AXI_USER_WIDTH = 1;
localparam TL_C_USER_WIDTH = 8 + AXI_USER_WIDTH;
localparam TL_A_USER_WIDTH = 8 + AXI_USER_WIDTH;
localparam TL_D_USER_WIDTH = 2 + AXI_USER_WIDTH;
localparam TL_B_USER_WIDTH = 1;
localparam TL_E_USER_WIDTH = 1;
localparam RST_SYNC_STAGE = 2;
input [L2_ADDR_WIDTH - 1:0] dcu_a_address;
input dcu_a_corrupt;
input [L2_DATA_WIDTH - 1:0] dcu_a_data;
input [L2_DATA_WIDTH / 8 - 1:0] dcu_a_mask;
input [2:0] dcu_a_opcode;
input [2:0] dcu_a_param;
output dcu_a_ready;
input [2:0] dcu_a_size;
input [2:0] dcu_a_source;
input [11:0] dcu_a_user;
input dcu_a_valid;
input [L2_ADDR_WIDTH - 1:0] dcu_c_address;
input dcu_c_corrupt;
input [L2_DATA_WIDTH - 1:0] dcu_c_data;
input [2:0] dcu_c_opcode;
input [2:0] dcu_c_param;
output dcu_c_ready;
input [2:0] dcu_c_size;
input [2:0] dcu_c_source;
input [7:0] dcu_c_user;
input dcu_c_valid;
output dcu_d_corrupt;
output [L2_DATA_WIDTH - 1:0] dcu_d_data;
output dcu_d_denied;
output [2:0] dcu_d_opcode;
output [1:0] dcu_d_param;
input dcu_d_ready;
output [TL_SINK_WIDTH - 1:0] dcu_d_sink;
output [2:0] dcu_d_size;
output [2:0] dcu_d_source;
output [5:0] dcu_d_user;
output dcu_d_valid;
output dcu_e_ready;
input [TL_SINK_WIDTH - 1:0] dcu_e_sink;
input dcu_e_valid;
input [1:0] icu_a_source;
input [7:0] icu_a_user;
output [1:0] icu_d_source;
output [1:0] icu_d_user;
input [L2_ADDR_WIDTH - 1:0] lsu_a_address;
input lsu_a_corrupt;
input [L2_DATA_WIDTH - 1:0] lsu_a_data;
input [L2_DATA_WIDTH / 8 - 1:0] lsu_a_mask;
input [2:0] lsu_a_opcode;
input [2:0] lsu_a_param;
output lsu_a_ready;
input [2:0] lsu_a_size;
input lsu_a_source;
input [7:0] lsu_a_user;
input lsu_a_valid;
output lsu_d_corrupt;
output [L2_DATA_WIDTH - 1:0] lsu_d_data;
output lsu_d_denied;
output [2:0] lsu_d_opcode;
output [1:0] lsu_d_param;
input lsu_d_ready;
output [TL_SINK_WIDTH - 1:0] lsu_d_sink;
output [2:0] lsu_d_size;
output lsu_d_source;
output [1:0] lsu_d_user;
output lsu_d_valid;
input test_mode;
input bus_clk;
input core_reset_n;
output [(BIU_ADDR_WIDTH - 1):0] araddr;
output [1:0] arburst;
output [3:0] arcache;
output [(BIU_ID_WIDTH - 1):0] arid;
output [7:0] arlen;
output arlock;
output [2:0] arprot;
input arready;
output [2:0] arsize;
output arvalid;
output [(BIU_ADDR_WIDTH - 1):0] awaddr;
output [1:0] awburst;
output [3:0] awcache;
output [(BIU_ID_WIDTH - 1):0] awid;
output [7:0] awlen;
output awlock;
output [2:0] awprot;
input awready;
output [2:0] awsize;
output awvalid;
input [(BIU_ID_WIDTH - 1):0] bid;
output bready;
input [1:0] bresp;
input bvalid;
input [(BIU_DATA_WIDTH - 1):0] rdata;
input [(BIU_ID_WIDTH - 1):0] rid;
input rlast;
output rready;
input [1:0] rresp;
input rvalid;
output [(BIU_DATA_WIDTH - 1):0] wdata;
output wlast;
input wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] wstrb;
output wvalid;
input bus_clk_en;
input core_clk;
output [(BIU_ADDR_WIDTH - 1):0] d_araddr;
output [1:0] d_arburst;
output [3:0] d_arcache;
output [(BIU_ID_WIDTH - 1):0] d_arid;
output [7:0] d_arlen;
output d_arlock;
output [2:0] d_arprot;
input d_arready;
output [2:0] d_arsize;
output d_arvalid;
output [(BIU_ADDR_WIDTH - 1):0] d_awaddr;
output [1:0] d_awburst;
output [3:0] d_awcache;
output [(BIU_ID_WIDTH - 1):0] d_awid;
output [7:0] d_awlen;
output d_awlock;
output [2:0] d_awprot;
input d_awready;
output [2:0] d_awsize;
output d_awvalid;
input [(BIU_ID_WIDTH - 1):0] d_bid;
output d_bready;
input [1:0] d_bresp;
input d_bvalid;
input [(BIU_DATA_WIDTH - 1):0] d_rdata;
input [(BIU_ID_WIDTH - 1):0] d_rid;
input d_rlast;
output d_rready;
input [1:0] d_rresp;
input d_rvalid;
output [(BIU_DATA_WIDTH - 1):0] d_wdata;
output d_wlast;
input d_wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] d_wstrb;
output d_wvalid;
output [(BIU_ADDR_WIDTH - 1):0] i_araddr;
output [1:0] i_arburst;
output [3:0] i_arcache;
output [(BIU_ID_WIDTH - 1):0] i_arid;
output [7:0] i_arlen;
output i_arlock;
output [2:0] i_arprot;
input i_arready;
output [2:0] i_arsize;
output i_arvalid;
output [(BIU_ADDR_WIDTH - 1):0] i_awaddr;
output [1:0] i_awburst;
output [3:0] i_awcache;
output [(BIU_ID_WIDTH - 1):0] i_awid;
output [7:0] i_awlen;
output i_awlock;
output [2:0] i_awprot;
input i_awready;
output [2:0] i_awsize;
output i_awvalid;
input [(BIU_ID_WIDTH - 1):0] i_bid;
output i_bready;
input [1:0] i_bresp;
input i_bvalid;
input [(BIU_DATA_WIDTH - 1):0] i_rdata;
input [(BIU_ID_WIDTH - 1):0] i_rid;
input i_rlast;
output i_rready;
input [1:0] i_rresp;
input i_rvalid;
output [(BIU_DATA_WIDTH - 1):0] i_wdata;
output i_wlast;
input i_wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] i_wstrb;
output i_wvalid;
input [L2_ADDR_WIDTH - 1:0] icu_a_address;
input icu_a_corrupt;
input [L2_DATA_WIDTH - 1:0] icu_a_data;
input [L2_DATA_WIDTH / 8 - 1:0] icu_a_mask;
input [2:0] icu_a_opcode;
input [2:0] icu_a_param;
output icu_a_ready;
input [2:0] icu_a_size;
input icu_a_valid;
output icu_d_corrupt;
output [L2_DATA_WIDTH - 1:0] icu_d_data;
output icu_d_denied;
output [2:0] icu_d_opcode;
output [1:0] icu_d_param;
input icu_d_ready;
output [TL_SINK_WIDTH - 1:0] icu_d_sink;
output [2:0] icu_d_size;
output icu_d_valid;


wire s0;
wire [3:0] s1;
wire [3:0] s2;
wire [3:0] s3;
wire s4;
wire [(BIU_ADDR_WIDTH - 1):0] ds_b_address;
wire ds_b_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] ds_b_data;
wire [(BIU_DATA_WIDTH / 8) - 1:0] ds_b_mask;
wire [2:0] ds_b_opcode;
wire [2:0] ds_b_param;
wire [2:0] ds_b_size;
wire [(BIU_ID_WIDTH - 1):0] ds_b_source;
wire [(TL_B_USER_WIDTH - 1):0] ds_b_user;
wire ds_b_valid;
wire [3:0] s5;
wire [TL_A_USER_WIDTH - 1:0] s6;
wire [BIU_ADDR_WIDTH - 1:0] s7;
wire s8;
wire [BIU_DATA_WIDTH - 1:0] s9;
wire [2:0] s10;
wire [2:0] s11;
wire [2:0] s12;
wire [BIU_ID_WIDTH - 1:0] s13;
wire [7:0] s14;
wire [TL_C_USER_WIDTH - 1:0] s15;
wire s16;
wire [TL_SINK_WIDTH - 1:0] s17;
wire s18;
wire s19;
wire [3:0] s20;
wire [BIU_ADDR_WIDTH - 1:0] s21;
wire s22;
wire [BIU_DATA_WIDTH - 1:0] s23;
wire [2:0] s24;
wire [2:0] s25;
wire s26;
wire [2:0] s27;
wire [BIU_ID_WIDTH - 1:0] s28;
wire [7:0] s29;
wire s30;
wire [3:0] s31;
wire s32;
wire [TL_SINK_WIDTH - 1:0] s33;
wire s34;
wire s35;
wire [(BIU_ADDR_WIDTH * 3) - 1:0] s36;
wire [2:0] s37;
wire [(BIU_DATA_WIDTH * 3) - 1:0] s38;
wire [(BIU_DATA_WIDTH * 3 / 8) - 1:0] s39;
wire [8:0] s40;
wire [8:0] s41;
wire [8:0] s42;
wire [(BIU_ID_WIDTH * 3) - 1:0] s43;
wire [(TL_A_USER_WIDTH * 3) - 1:0] s44;
wire [2:0] s45;
wire [(BIU_ADDR_WIDTH * 3) - 1:0] s46;
wire [2:0] s47;
wire [(BIU_DATA_WIDTH * 3) - 1:0] s48;
wire [8:0] s49;
wire [8:0] s50;
wire [8:0] s51;
wire [(BIU_ID_WIDTH * 3) - 1:0] s52;
wire [(TL_C_USER_WIDTH * 3) - 1:0] s53;
wire [2:0] s54;
wire [2:0] s55;
wire [(TL_SINK_WIDTH * 3) - 1:0] s56;
wire [(TL_E_USER_WIDTH * 3) - 1:0] s57;
wire [2:0] s58;
wire [(BIU_ADDR_WIDTH * 2) - 1:0] s59;
wire [1:0] s60;
wire [(BIU_DATA_WIDTH * 2) - 1:0] s61;
wire [(BIU_DATA_WIDTH * 2 / 8) - 1:0] s62;
wire [5:0] s63;
wire [5:0] s64;
wire [5:0] s65;
wire [(BIU_ID_WIDTH * 2) - 1:0] s66;
wire [(TL_A_USER_WIDTH * 2) - 1:0] s67;
wire [1:0] s68;
wire [(BIU_ADDR_WIDTH * 2) - 1:0] s69;
wire [1:0] s70;
wire [(BIU_DATA_WIDTH * 2) - 1:0] s71;
wire [5:0] s72;
wire [5:0] s73;
wire [5:0] s74;
wire [(BIU_ID_WIDTH * 2) - 1:0] s75;
wire [(TL_C_USER_WIDTH * 2) - 1:0] s76;
wire [1:0] s77;
wire [1:0] s78;
wire [(TL_SINK_WIDTH * 2) - 1:0] s79;
wire [(TL_E_USER_WIDTH * 2) - 1:0] s80;
wire [1:0] s81;
wire s82;
wire [0:0] nds_unused_aruser;
wire [0:0] nds_unused_awuser;
wire [0:0] nds_unused_wuser;
wire ds_a_ready;
wire ds_c_ready;
wire ds_d_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] ds_d_data;
wire ds_d_denied;
wire [2:0] ds_d_opcode;
wire [1:0] ds_d_param;
wire [(TL_SINK_WIDTH - 1):0] ds_d_sink;
wire [2:0] ds_d_size;
wire [(BIU_ID_WIDTH - 1):0] ds_d_source;
wire [(TL_D_USER_WIDTH - 1):0] ds_d_user;
wire ds_d_valid;
wire ds_e_ready;
wire [(BIU_ADDR_WIDTH - 1):0] s83;
wire nds_unused_ds_b_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] s84;
wire [BIU_DATA_WIDTH / 8 - 1:0] s85;
wire [2:0] nds_unused_ds_b_opcode;
wire [2:0] nds_unused_ds_b_param;
wire [2:0] nds_unused_ds_b_size;
wire [(BIU_ID_WIDTH - 1):0] s86;
wire nds_unused_ds_b_user;
wire nds_unused_ds_b_valid;
wire [0:0] nds_unused_d_aruser;
wire [0:0] nds_unused_d_awuser;
wire [0:0] nds_unused_d_wuser;
wire s87;
wire [3:0] s88;
wire [TL_D_USER_WIDTH - 1:0] s89;
wire s90;
wire [0:0] nds_unused_i_aruser;
wire [0:0] nds_unused_i_awuser;
wire [0:0] nds_unused_i_wuser;
wire [(BIU_ADDR_WIDTH - 1):0] s91;
wire nds_unused_icu_b_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] s92;
wire [BIU_DATA_WIDTH / 8 - 1:0] s93;
wire [2:0] nds_unused_icu_b_opcode;
wire [2:0] nds_unused_icu_b_param;
wire [2:0] nds_unused_icu_b_size;
wire [(BIU_ID_WIDTH - 1):0] s94;
wire nds_unused_icu_b_user;
wire nds_unused_icu_b_valid;
wire [(BIU_ADDR_WIDTH * 3) - 1:0] s95;
wire [2:0] nds_unused_x1_b_corrupt;
wire [(BIU_DATA_WIDTH * 3) - 1:0] s96;
wire [(BIU_DATA_WIDTH * 3 / 8) - 1:0] s97;
wire [8:0] nds_unused_x1_b_opcode;
wire [8:0] nds_unused_x1_b_param;
wire [8:0] nds_unused_x1_b_size;
wire [(BIU_ID_WIDTH * 3) - 1:0] s98;
wire [(TL_B_USER_WIDTH * 3) - 1:0] s99;
wire [2:0] nds_unused_x1_b_valid;
wire [2:0] s100;
wire [2:0] s101;
wire [2:0] s102;
wire [(BIU_DATA_WIDTH * 3) - 1:0] s103;
wire [2:0] s104;
wire [8:0] s105;
wire [5:0] s106;
wire [(TL_SINK_WIDTH * 3) - 1:0] s107;
wire [8:0] s108;
wire [(BIU_ID_WIDTH * 3) - 1:0] s109;
wire [(TL_D_USER_WIDTH * 3) - 1:0] s110;
wire [2:0] s111;
wire [2:0] s112;
wire [(BIU_ADDR_WIDTH - 1):0] ds_a_address;
wire ds_a_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] ds_a_data;
wire [(BIU_DATA_WIDTH / 8) - 1:0] ds_a_mask;
wire [2:0] ds_a_opcode;
wire [2:0] ds_a_param;
wire [2:0] ds_a_size;
wire [(BIU_ID_WIDTH - 1):0] ds_a_source;
wire [(TL_A_USER_WIDTH - 1):0] ds_a_user;
wire ds_a_valid;
wire [(BIU_ADDR_WIDTH - 1):0] ds_c_address;
wire ds_c_corrupt;
wire [(BIU_DATA_WIDTH - 1):0] ds_c_data;
wire [2:0] ds_c_opcode;
wire [2:0] ds_c_param;
wire [2:0] ds_c_size;
wire [(BIU_ID_WIDTH - 1):0] ds_c_source;
wire [(TL_C_USER_WIDTH - 1):0] ds_c_user;
wire ds_c_valid;
wire ds_d_ready;
wire [(TL_SINK_WIDTH - 1):0] ds_e_sink;
wire [(TL_E_USER_WIDTH - 1):0] ds_e_user;
wire ds_e_valid;
wire nds_unused_ds_b_ready;
wire [(BIU_ADDR_WIDTH * 2) - 1:0] s113;
wire [1:0] nds_unused_x2_b_corrupt;
wire [(BIU_DATA_WIDTH * 2) - 1:0] s114;
wire [(BIU_DATA_WIDTH * 2 / 8) - 1:0] s115;
wire [5:0] nds_unused_x2_b_opcode;
wire [5:0] nds_unused_x2_b_param;
wire [5:0] nds_unused_x2_b_size;
wire [(BIU_ID_WIDTH * 2) - 1:0] s116;
wire [(TL_B_USER_WIDTH * 2) - 1:0] s117;
wire [1:0] nds_unused_x2_b_valid;
wire [1:0] s118;
wire [1:0] s119;
wire [1:0] s120;
wire [(BIU_DATA_WIDTH * 2) - 1:0] s121;
wire [1:0] s122;
wire [5:0] s123;
wire [3:0] s124;
wire [(TL_SINK_WIDTH * 2) - 1:0] s125;
wire [5:0] s126;
wire [(BIU_ID_WIDTH * 2) - 1:0] s127;
wire [(TL_D_USER_WIDTH * 2) - 1:0] s128;
wire [1:0] s129;
wire [1:0] s130;
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_rst_sync_stub
        assign s82 = 1'b0;
    end
endgenerate
assign s0 = test_mode ? core_reset_n : s82;
assign s10 = 3'b0;
assign s11 = 3'b0;
assign s14 = 8'b0;
assign s12 = 3'b0;
assign s7 = {BIU_ADDR_WIDTH{1'b0}};
assign s13 = {BIU_ID_WIDTH{1'b0}};
assign s9 = {BIU_DATA_WIDTH{1'b0}};
assign s8 = 1'b0;
assign s16 = 1'b0;
assign s19 = 1'b0;
assign s18 = 1'b0;
assign s17 = {TL_SINK_WIDTH{1'b0}};
assign s24 = 3'b0;
assign s25 = 3'b0;
assign s29 = 8'b0;
assign s27 = 3'b0;
assign s21 = {BIU_ADDR_WIDTH{1'b0}};
assign s28 = {BIU_ID_WIDTH{1'b0}};
assign s23 = {BIU_DATA_WIDTH{1'b0}};
assign s22 = 1'b0;
assign s30 = 1'b0;
assign s35 = 1'b0;
assign s34 = 1'b0;
assign s33 = {TL_SINK_WIDTH{1'b0}};
assign s4 = 1'b0;
assign ds_b_address = {BIU_ADDR_WIDTH{1'b0}};
assign ds_b_corrupt = 1'b0;
assign ds_b_data = {BIU_DATA_WIDTH{1'b0}};
assign ds_b_mask = {BIU_DATA_WIDTH / 8{1'b0}};
assign ds_b_opcode = 3'b0;
assign ds_b_param = 3'b0;
assign ds_b_size = 3'b0;
assign ds_b_source = {BIU_ID_WIDTH{1'b0}};
assign ds_b_user = 1'b0;
assign ds_b_valid = 1'b0;
generate
    if ((BIU_PATH_X2_INT == 0)) begin:gen_x1_tls
        assign s40 = {icu_a_opcode,dcu_a_opcode,lsu_a_opcode};
        assign s41 = {icu_a_param,dcu_a_param,lsu_a_param};
        assign s44 = {{1'b0,icu_a_user[7:0]},{1'b0,dcu_a_user[7:0]},{1'b0,lsu_a_user}};
        assign s42 = {icu_a_size,dcu_a_size,lsu_a_size};
        assign s36 = {icu_a_address,dcu_a_address,lsu_a_address};
        assign s43 = {s5,s1,s20};
        assign s38 = {icu_a_data,dcu_a_data,lsu_a_data};
        assign s39 = {icu_a_mask,dcu_a_mask,lsu_a_mask};
        assign s37 = {icu_a_corrupt,dcu_a_corrupt,lsu_a_corrupt};
        assign s45 = {icu_a_valid,dcu_a_valid,lsu_a_valid};
        assign {icu_a_ready,dcu_a_ready,lsu_a_ready} = s100;
        assign s49 = {s10,dcu_c_opcode,s24};
        assign s50 = {s11,dcu_c_param,s25};
        assign s53 = {{1'b0,s14[7:0]},{1'b0,dcu_c_user[7:0]},{1'b0,s29}};
        assign s51 = {s12,dcu_c_size,s27};
        assign s46 = {s7,dcu_c_address,s21};
        assign s52 = {s13,s2,s28};
        assign s48 = {s9,dcu_c_data,s23};
        assign s47 = {s8,dcu_c_corrupt,s22};
        assign s54 = {s16,dcu_c_valid,s30};
        assign {s87,dcu_c_ready,s26} = s101;
        assign {icu_d_opcode,dcu_d_opcode,lsu_d_opcode} = s105;
        assign {icu_d_param,dcu_d_param,lsu_d_param} = s106;
        assign {icu_d_size,dcu_d_size,lsu_d_size} = s108;
        assign s89 = s110[6 +:3];
        assign dcu_d_user = {4'b0,s110[3 +:2]};
        assign lsu_d_user = s110[0 +:2];
        assign {icu_d_data,dcu_d_data,lsu_d_data} = s103;
        assign {s88,s3,s31} = s109;
        assign {icu_d_sink,dcu_d_sink,lsu_d_sink} = s107;
        assign {icu_d_denied,dcu_d_denied,lsu_d_denied} = s104;
        assign {icu_d_corrupt,dcu_d_corrupt,lsu_d_corrupt} = s102;
        assign {icu_d_valid,dcu_d_valid,lsu_d_valid} = s111;
        assign s55 = {icu_d_ready,dcu_d_ready,lsu_d_ready};
        assign s58 = {s19,dcu_e_valid,s35};
        assign {s90,dcu_e_ready,s32} = s112;
        assign s56 = {s17,dcu_e_sink,s33};
        assign s57 = {s18,s4,s34};
        assign s63 = {2{3'b0}};
        assign s64 = {2{3'b0}};
        assign s67 = {2 * TL_A_USER_WIDTH{1'b0}};
        assign s65 = {2{3'b0}};
        assign s59 = {2 * BIU_ADDR_WIDTH{1'b0}};
        assign s66 = {2{4'b0}};
        assign s61 = {2 * BIU_DATA_WIDTH{1'b0}};
        assign s62 = {2 * BIU_DATA_WIDTH / 8{1'b0}};
        assign s60 = {2{1'b0}};
        assign s68 = {2{1'b0}};
        assign s118 = {2{1'b0}};
        assign s72 = {2{3'b0}};
        assign s73 = {2{3'b0}};
        assign s76 = {2 * TL_C_USER_WIDTH{1'b0}};
        assign s74 = {2{3'b0}};
        assign s69 = {2 * BIU_ADDR_WIDTH{1'b0}};
        assign s75 = {2{4'b0}};
        assign s71 = {2 * BIU_DATA_WIDTH{1'b0}};
        assign s70 = {2{1'b0}};
        assign s77 = {2{1'b0}};
        assign s119 = {2{1'b0}};
        assign s123 = {2{3'b0}};
        assign s127 = {2{4'b0}};
        assign s124 = {2{2'b0}};
        assign s126 = {2{3'b0}};
        assign s121 = {2 * BIU_DATA_WIDTH{1'b0}};
        assign s120 = {2{1'b0}};
        assign s122 = {2{1'b0}};
        assign s125 = {2 * TL_SINK_WIDTH{1'b0}};
        assign s128 = {2 * TL_D_USER_WIDTH{1'b0}};
        assign s129 = {2{1'b0}};
        assign s78 = {2{1'b0}};
        assign s81 = {2{1'b0}};
        assign s130 = {2{1'b0}};
        assign s79 = {2 * TL_SINK_WIDTH{1'b0}};
        assign s80 = {2 * TL_E_USER_WIDTH{1'd0}};
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 1)) begin:gen_x2_tls
        assign s63 = {dcu_a_opcode,lsu_a_opcode};
        assign s64 = {dcu_a_param,lsu_a_param};
        assign s67 = {{1'b0,dcu_a_user[7:0]},{1'b0,lsu_a_user}};
        assign s65 = {dcu_a_size,lsu_a_size};
        assign s59 = {dcu_a_address,lsu_a_address};
        assign s66 = {s1,s20};
        assign s61 = {dcu_a_data,lsu_a_data};
        assign s62 = {dcu_a_mask,lsu_a_mask};
        assign s60 = {dcu_a_corrupt,lsu_a_corrupt};
        assign s68 = {dcu_a_valid,lsu_a_valid};
        assign {dcu_a_ready,lsu_a_ready} = s118;
        assign s72 = {dcu_c_opcode,s24};
        assign s73 = {dcu_c_param,s25};
        assign s76 = {{1'b0,dcu_c_user[7:0]},{1'b0,s29}};
        assign s74 = {dcu_c_size,s27};
        assign s69 = {dcu_c_address,s21};
        assign s75 = {s2,s28};
        assign s71 = {dcu_c_data,s23};
        assign s70 = {dcu_c_corrupt,s22};
        assign s77 = {dcu_c_valid,s30};
        assign {dcu_c_ready,s26} = s119;
        assign {dcu_d_opcode,lsu_d_opcode} = s123;
        assign {dcu_d_param,lsu_d_param} = s124;
        assign {dcu_d_size,lsu_d_size} = s126;
        assign dcu_d_user = {4'd0,s128[3 +:2]};
        assign lsu_d_user = s128[0 +:2];
        assign {dcu_d_data,lsu_d_data} = s121;
        assign {s3,s31} = s127;
        assign {dcu_d_sink,lsu_d_sink} = s125;
        assign {dcu_d_denied,lsu_d_denied} = s122;
        assign {dcu_d_corrupt,lsu_d_corrupt} = s120;
        assign {dcu_d_valid,lsu_d_valid} = s129;
        assign s78 = {dcu_d_ready,lsu_d_ready};
        assign s81 = {dcu_e_valid,s35};
        assign {dcu_e_ready,s32} = s130;
        assign s79 = {dcu_e_sink,s33};
        assign s80 = {s4,s34};
        assign s40 = {3{3'b0}};
        assign s41 = {3{3'b0}};
        assign s44 = {3 * TL_A_USER_WIDTH{1'b0}};
        assign s42 = {3{3'b0}};
        assign s36 = {3 * BIU_ADDR_WIDTH{1'b0}};
        assign s43 = {3{4'b0}};
        assign s38 = {3 * BIU_DATA_WIDTH{1'b0}};
        assign s39 = {3 * BIU_DATA_WIDTH / 8{1'b0}};
        assign s37 = {3{1'b0}};
        assign s45 = {3{1'b0}};
        assign s100 = {3{1'b0}};
        assign s49 = {3{3'b0}};
        assign s50 = {3{3'b0}};
        assign s53 = {3 * TL_C_USER_WIDTH{1'b0}};
        assign s51 = {3{3'b0}};
        assign s46 = {3 * BIU_ADDR_WIDTH{1'b0}};
        assign s52 = {3{4'b0}};
        assign s48 = {3 * BIU_DATA_WIDTH{1'b0}};
        assign s47 = {3{1'b0}};
        assign s54 = {3{1'b0}};
        assign s101 = {3{1'b0}};
        assign s105 = {3{3'b0}};
        assign s106 = {3{2'b0}};
        assign s108 = {3{3'b0}};
        assign s110 = {3 * TL_D_USER_WIDTH{1'b0}};
        assign s103 = {3 * BIU_DATA_WIDTH{1'b0}};
        assign s109 = {3{4'b0}};
        assign s107 = {3 * TL_SINK_WIDTH{1'b0}};
        assign s104 = {3{1'b0}};
        assign s102 = {3{1'b0}};
        assign s111 = {3{1'b0}};
        assign s55 = {3{1'b0}};
        assign s58 = {3{1'b0}};
        assign s112 = {3{1'b0}};
        assign s56 = {3 * TL_SINK_WIDTH{1'b0}};
        assign s57 = {3 * TL_E_USER_WIDTH{1'd0}};
    end
endgenerate
assign s5 = {2'b01,icu_a_source};
assign icu_d_source = s88[1:0];
assign s1 = {1'b1,dcu_a_source};
assign s2 = {1'b1,dcu_c_source};
assign dcu_d_source = s3[2:0];
assign s20 = {3'b0,lsu_a_source};
assign lsu_d_source = s31[0];
assign s6 = {1'b0,icu_a_user};
assign s15 = {1'b0,s14[7:0]};
assign icu_d_user = s89[1:0];
generate
    if ((BIU_PATH_X2_INT == 1)) begin:gen_axi_dummy_output
        assign awid = {BIU_ID_WIDTH{1'b0}};
        assign awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign awlen = 8'd0;
        assign awsize = 3'd0;
        assign awburst = 2'd0;
        assign awlock = 1'd0;
        assign awcache = 4'd0;
        assign awprot = 3'd0;
        assign awvalid = 1'd0;
        assign wdata = {BIU_DATA_WIDTH{1'b0}};
        assign wstrb = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign wlast = 1'b0;
        assign wvalid = 1'b0;
        assign bready = 1'b0;
        assign arid = {BIU_ID_WIDTH{1'b0}};
        assign araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign arlen = 8'd0;
        assign arsize = 3'd0;
        assign arburst = 2'd0;
        assign arlock = 1'd0;
        assign arcache = 4'd0;
        assign arprot = 3'd0;
        assign arvalid = 1'b0;
        assign rready = 1'b0;
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT != 1)) begin:gen_path_x2_axi_dummy_output
        assign i_awid = {BIU_ID_WIDTH{1'b0}};
        assign i_awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign i_awlen = 8'd0;
        assign i_awsize = 3'd0;
        assign i_awburst = 2'd0;
        assign i_awlock = 1'd0;
        assign i_awcache = 4'd0;
        assign i_awprot = 3'd0;
        assign i_awvalid = 1'd0;
        assign i_wdata = {BIU_DATA_WIDTH{1'b0}};
        assign i_wstrb = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign i_wlast = 1'b0;
        assign i_wvalid = 1'b0;
        assign i_bready = 1'b0;
        assign i_arid = {BIU_ID_WIDTH{1'b0}};
        assign i_araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign i_arlen = 8'd0;
        assign i_arsize = 3'd0;
        assign i_arburst = 2'd0;
        assign i_arlock = 1'd0;
        assign i_arcache = 4'd0;
        assign i_arprot = 3'd0;
        assign i_arvalid = 1'b0;
        assign i_rready = 1'b0;
        assign d_awid = {BIU_ID_WIDTH{1'b0}};
        assign d_awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign d_awlen = 8'd0;
        assign d_awsize = 3'd0;
        assign d_awburst = 2'd0;
        assign d_awlock = 1'd0;
        assign d_awcache = 4'd0;
        assign d_awprot = 3'd0;
        assign d_awvalid = 1'd0;
        assign d_wdata = {BIU_DATA_WIDTH{1'b0}};
        assign d_wstrb = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign d_wlast = 1'b0;
        assign d_wvalid = 1'b0;
        assign d_bready = 1'b0;
        assign d_arid = {BIU_ID_WIDTH{1'b0}};
        assign d_araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign d_arlen = 8'd0;
        assign d_arsize = 3'd0;
        assign d_arburst = 2'd0;
        assign d_arlock = 1'd0;
        assign d_arcache = 4'd0;
        assign d_arprot = 3'd0;
        assign d_arvalid = 1'b0;
        assign d_rready = 1'b0;
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 0)) begin:gen_biu_x1_unused
        wire nds_unused_i_arready = i_arready;
        wire nds_unused_i_awready = i_awready;
        wire [(BIU_ID_WIDTH - 1):0] s131 = i_bid;
        wire [1:0] nds_unused_i_bresp = i_bresp;
        wire nds_unused_i_bvalid = i_bvalid;
        wire [(BIU_DATA_WIDTH - 1):0] s132 = i_rdata;
        wire [(BIU_ID_WIDTH - 1):0] s133 = i_rid;
        wire nds_unused_i_rlast = i_rlast;
        wire [1:0] nds_unused_i_rresp = i_rresp;
        wire nds_unused_i_rvalid = i_rvalid;
        wire nds_unused_i_wready = i_wready;
        wire nds_unused_d_arready = d_arready;
        wire nds_unused_d_awready = d_awready;
        wire [(BIU_ID_WIDTH - 1):0] s134 = d_bid;
        wire [1:0] nds_unused_d_bresp = d_bresp;
        wire nds_unused_d_bvalid = d_bvalid;
        wire [(BIU_DATA_WIDTH - 1):0] s135 = d_rdata;
        wire [(BIU_ID_WIDTH - 1):0] s136 = d_rid;
        wire nds_unused_d_rlast = d_rlast;
        wire [1:0] nds_unused_d_rresp = d_rresp;
        wire nds_unused_d_rvalid = d_rvalid;
        wire nds_unused_d_wready = d_wready;
        wire [(BIU_ADDR_WIDTH * 2) - 1:0] s137 = s59;
        wire [1:0] nds_unused_x2_a_corrupts = s60;
        wire [(BIU_DATA_WIDTH * 2) - 1:0] s138 = s61;
        wire [(BIU_DATA_WIDTH * 2 / 8) - 1:0] s139 = s62;
        wire [5:0] nds_unused_x2_a_opcodes = s63;
        wire [5:0] nds_unused_x2_a_params = s64;
        wire [5:0] nds_unused_x2_a_sizes = s65;
        wire [(BIU_ID_WIDTH * 2) - 1:0] s140 = s66;
        wire [(TL_A_USER_WIDTH * 2) - 1:0] s141 = s67;
        wire [1:0] nds_unused_x2_a_valids = s68;
        wire [(BIU_ADDR_WIDTH * 2) - 1:0] s142 = s69;
        wire [1:0] nds_unused_x2_c_corrupts = s70;
        wire [(BIU_DATA_WIDTH * 2) - 1:0] s143 = s71;
        wire [5:0] nds_unused_x2_c_opcodes = s72;
        wire [5:0] nds_unused_x2_c_params = s73;
        wire [5:0] nds_unused_x2_c_sizes = s74;
        wire [(BIU_ID_WIDTH * 2) - 1:0] s144 = s75;
        wire [(TL_C_USER_WIDTH * 2) - 1:0] s145 = s76;
        wire [1:0] nds_unused_x2_c_valids = s77;
        wire [1:0] nds_unused_x2_d_readys = s78;
        wire [(TL_SINK_WIDTH * 2) - 1:0] s146 = s79;
        wire [(TL_E_USER_WIDTH * 2) - 1:0] s147 = s80;
        wire [1:0] nds_unused_x2_e_valids = s81;
        wire [1:0] nds_unused_x2_a_readys = s118;
        wire [1:0] nds_unused_x2_c_readys = s119;
        wire [1:0] nds_unused_x2_d_corrupts = s120;
        wire [(BIU_DATA_WIDTH * 2) - 1:0] s148 = s121;
        wire [1:0] nds_unused_x2_d_denieds = s122;
        wire [5:0] nds_unused_x2_d_opcodes = s123;
        wire [3:0] nds_unused_x2_d_params = s124;
        wire [(TL_SINK_WIDTH * 2) - 1:0] s149 = s125;
        wire [5:0] nds_unused_x2_d_sizes = s126;
        wire [(BIU_ID_WIDTH * 2) - 1:0] s150 = s127;
        wire [(TL_D_USER_WIDTH * 2) - 1:0] s151 = s128;
        wire [1:0] nds_unused_x2_d_valids = s129;
        wire [1:0] nds_unused_x2_e_readys = s130;
        wire [TL_A_USER_WIDTH - 1:0] s152 = s6;
        wire [TL_C_USER_WIDTH - 1:0] s153 = s15;
        wire nds_unused_icu_c_ready = s87;
        wire nds_unused_icu_e_ready = s90;
        wire nds_unused_lsu_c_ready = s26;
        wire nds_unused_lsu_e_ready = s32;
        assign nds_unused_d_aruser = 1'b0;
        assign nds_unused_d_awuser = 1'b0;
        assign nds_unused_d_wuser = 1'b0;
        assign nds_unused_i_aruser = 1'b0;
        assign nds_unused_i_awuser = 1'b0;
        assign nds_unused_i_wuser = 1'b0;
        assign s91 = {(BIU_ADDR_WIDTH){1'b0}};
        assign nds_unused_icu_b_corrupt = 1'b0;
        assign s92 = {(BIU_DATA_WIDTH){1'b0}};
        assign s93 = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign nds_unused_icu_b_opcode = {3{1'b0}};
        assign nds_unused_icu_b_param = {3{1'b0}};
        assign nds_unused_icu_b_size = {3{1'b0}};
        assign s94 = {(BIU_ID_WIDTH){1'b0}};
        assign nds_unused_icu_b_user = 1'b0;
        assign nds_unused_icu_b_valid = 1'b0;
        assign s113 = {(BIU_ADDR_WIDTH * 2){1'b0}};
        assign nds_unused_x2_b_corrupt = {2{1'b0}};
        assign s114 = {(BIU_DATA_WIDTH * 2){1'b0}};
        assign s115 = {(BIU_DATA_WIDTH * 2 / 8){1'b0}};
        assign nds_unused_x2_b_opcode = {6{1'b0}};
        assign nds_unused_x2_b_param = {6{1'b0}};
        assign nds_unused_x2_b_size = {6{1'b0}};
        assign s116 = {(BIU_ID_WIDTH * 2){1'b0}};
        assign s117 = {(TL_B_USER_WIDTH * 2){1'b0}};
        assign nds_unused_x2_b_valid = {2{1'b0}};
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 1)) begin:gen_biu_x2_unused
        wire nds_unused_arready = arready;
        wire nds_unused_awready = awready;
        wire [(BIU_ID_WIDTH - 1):0] s154 = bid;
        wire [1:0] nds_unused_bresp = bresp;
        wire nds_unused_bvalid = bvalid;
        wire [(BIU_DATA_WIDTH - 1):0] s155 = rdata;
        wire [(BIU_ID_WIDTH - 1):0] s156 = rid;
        wire nds_unused_rlast = rlast;
        wire [1:0] nds_unused_rresp = rresp;
        wire nds_unused_rvalid = rvalid;
        wire nds_unused_wready = wready;
        wire [(BIU_ADDR_WIDTH * 3) - 1:0] s157 = s36;
        wire [2:0] nds_unused_x1_a_corrupts = s37;
        wire [(BIU_DATA_WIDTH * 3) - 1:0] s158 = s38;
        wire [(BIU_DATA_WIDTH * 3 / 8) - 1:0] s159 = s39;
        wire [8:0] nds_unused_x1_a_opcodes = s40;
        wire [8:0] nds_unused_x1_a_params = s41;
        wire [8:0] nds_unused_x1_a_sizes = s42;
        wire [(BIU_ID_WIDTH * 3) - 1:0] s160 = s43;
        wire [(TL_A_USER_WIDTH * 3) - 1:0] s161 = s44;
        wire [2:0] nds_unused_x1_a_valids = s45;
        wire [(BIU_ADDR_WIDTH * 3) - 1:0] s162 = s46;
        wire [2:0] nds_unused_x1_c_corrupts = s47;
        wire [(BIU_DATA_WIDTH * 3) - 1:0] s163 = s48;
        wire [8:0] nds_unused_x1_c_opcodes = s49;
        wire [8:0] nds_unused_x1_c_params = s50;
        wire [8:0] nds_unused_x1_c_sizes = s51;
        wire [(BIU_ID_WIDTH * 3) - 1:0] s164 = s52;
        wire [(TL_C_USER_WIDTH * 3) - 1:0] s165 = s53;
        wire [2:0] nds_unused_x1_c_valids = s54;
        wire [2:0] nds_unused_x1_d_readys = s55;
        wire [(TL_SINK_WIDTH * 3) - 1:0] s166 = s56;
        wire [(TL_E_USER_WIDTH * 3) - 1:0] s167 = s57;
        wire [2:0] nds_unused_x1_e_valids = s58;
        wire [2:0] nds_unused_x1_a_readys = s100;
        wire [2:0] nds_unused_x1_c_readys = s101;
        wire [2:0] nds_unused_x1_d_corrupts = s102;
        wire [(BIU_DATA_WIDTH * 3) - 1:0] s168 = s103;
        wire [2:0] nds_unused_x1_d_denieds = s104;
        wire [8:0] nds_unused_x1_d_opcodes = s105;
        wire [5:0] nds_unused_x1_d_params = s106;
        wire [(TL_SINK_WIDTH * 3) - 1:0] s169 = s107;
        wire [8:0] nds_unused_x1_d_sizes = s108;
        wire [(BIU_ID_WIDTH * 3) - 1:0] s170 = s109;
        wire [(TL_D_USER_WIDTH * 3) - 1:0] s171 = s110;
        wire [2:0] nds_unused_x1_d_valids = s111;
        wire [2:0] nds_unused_x1_e_readys = s112;
        wire nds_unused_icu_c_ready = s87;
        wire nds_unused_icu_e_ready = s90;
        wire nds_unused_lsu_c_ready = s26;
        wire nds_unused_lsu_e_ready = s32;
        assign nds_unused_aruser = 1'b0;
        assign nds_unused_awuser = 1'b0;
        assign nds_unused_wuser = 1'b0;
        assign s95 = {(BIU_ADDR_WIDTH * 3){1'b0}};
        assign nds_unused_x1_b_corrupt = {3{1'b0}};
        assign s96 = {(BIU_DATA_WIDTH * 3){1'b0}};
        assign s97 = {(BIU_DATA_WIDTH * 3 / 8){1'b0}};
        assign nds_unused_x1_b_opcode = {9{1'b0}};
        assign nds_unused_x1_b_param = {9{1'b0}};
        assign nds_unused_x1_b_size = {9{1'b0}};
        assign s98 = {(BIU_ID_WIDTH * 3){1'b0}};
        assign s99 = {(TL_B_USER_WIDTH * 3){1'b0}};
        assign nds_unused_x1_b_valid = {3{1'b0}};
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT) begin:gen_rst_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(RST_SYNC_STAGE)
        ) u_rst_sync (
            .resetn(core_reset_n),
            .clk(bus_clk),
            .d(1'b1),
            .q(s82)
        );
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 0)) begin:gen_path_x1_tlc_mux
        kv_tlc_mux #(
            .AW(BIU_ADDR_WIDTH),
            .DW(BIU_DATA_WIDTH),
            .N(3),
            .TL_A_USER_WIDTH(TL_A_USER_WIDTH),
            .TL_B_USER_WIDTH(TL_B_USER_WIDTH),
            .TL_C_USER_WIDTH(TL_C_USER_WIDTH),
            .TL_D_USER_WIDTH(TL_D_USER_WIDTH),
            .TL_E_USER_WIDTH(TL_E_USER_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SIZE_WIDTH(3),
            .TL_SOURCE_WIDTH(BIU_ID_WIDTH)
        ) u_tlc_mux_x1 (
            .us_a_opcode(s40),
            .us_a_param(s41),
            .us_a_user(s44),
            .us_a_size(s42),
            .us_a_address(s36),
            .us_a_source(s43),
            .us_a_data(s38),
            .us_a_mask(s39),
            .us_a_corrupt(s37),
            .us_a_valid(s45),
            .us_a_ready(s100),
            .us_b_opcode(nds_unused_x1_b_opcode),
            .us_b_param(nds_unused_x1_b_param),
            .us_b_size(nds_unused_x1_b_size),
            .us_b_source(s98),
            .us_b_address(s95),
            .us_b_user(s99),
            .us_b_data(s96),
            .us_b_mask(s97),
            .us_b_corrupt(nds_unused_x1_b_corrupt),
            .us_b_valid(nds_unused_x1_b_valid),
            .us_b_ready(3'b0),
            .us_c_opcode(s49),
            .us_c_param(s50),
            .us_c_user(s53),
            .us_c_size(s51),
            .us_c_address(s46),
            .us_c_source(s52),
            .us_c_data(s48),
            .us_c_corrupt(s47),
            .us_c_valid(s54),
            .us_c_ready(s101),
            .us_d_opcode(s105),
            .us_d_param(s106),
            .us_d_size(s108),
            .us_d_user(s110),
            .us_d_data(s103),
            .us_d_source(s109),
            .us_d_sink(s107),
            .us_d_denied(s104),
            .us_d_corrupt(s102),
            .us_d_valid(s111),
            .us_d_ready(s55),
            .us_e_valid(s58),
            .us_e_user(s57),
            .us_e_sink(s56),
            .us_e_ready(s112),
            .ds_a_opcode(ds_a_opcode),
            .ds_a_param(ds_a_param),
            .ds_a_user(ds_a_user),
            .ds_a_size(ds_a_size),
            .ds_a_address(ds_a_address),
            .ds_a_data(ds_a_data),
            .ds_a_mask(ds_a_mask),
            .ds_a_source(ds_a_source),
            .ds_a_corrupt(ds_a_corrupt),
            .ds_a_valid(ds_a_valid),
            .ds_a_ready(ds_a_ready),
            .ds_b_opcode(ds_b_opcode),
            .ds_b_param(ds_b_param),
            .ds_b_size(ds_b_size),
            .ds_b_source(ds_b_source),
            .ds_b_address(ds_b_address),
            .ds_b_user(ds_b_user),
            .ds_b_data(ds_b_data),
            .ds_b_mask(ds_b_mask),
            .ds_b_corrupt(ds_b_corrupt),
            .ds_b_valid(ds_b_valid),
            .ds_b_ready(nds_unused_ds_b_ready),
            .ds_c_opcode(ds_c_opcode),
            .ds_c_param(ds_c_param),
            .ds_c_user(ds_c_user),
            .ds_c_size(ds_c_size),
            .ds_c_address(ds_c_address),
            .ds_c_source(ds_c_source),
            .ds_c_data(ds_c_data),
            .ds_c_corrupt(ds_c_corrupt),
            .ds_c_valid(ds_c_valid),
            .ds_c_ready(ds_c_ready),
            .ds_d_opcode(ds_d_opcode),
            .ds_d_param(ds_d_param),
            .ds_d_user(ds_d_user),
            .ds_d_size(ds_d_size),
            .ds_d_data(ds_d_data),
            .ds_d_source(ds_d_source),
            .ds_d_sink(ds_d_sink),
            .ds_d_denied(ds_d_denied),
            .ds_d_corrupt(ds_d_corrupt),
            .ds_d_valid(ds_d_valid),
            .ds_d_ready(ds_d_ready),
            .ds_e_valid(ds_e_valid),
            .ds_e_user(ds_e_user),
            .ds_e_sink(ds_e_sink),
            .ds_e_ready(ds_e_ready),
            .clk(core_clk),
            .resetn(core_reset_n)
        );
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 1)) begin:gen_path_x2_tlc_mux
        kv_tlc_mux #(
            .AW(BIU_ADDR_WIDTH),
            .DW(BIU_DATA_WIDTH),
            .N(2),
            .TL_A_USER_WIDTH(TL_A_USER_WIDTH),
            .TL_B_USER_WIDTH(TL_B_USER_WIDTH),
            .TL_C_USER_WIDTH(TL_C_USER_WIDTH),
            .TL_D_USER_WIDTH(TL_D_USER_WIDTH),
            .TL_E_USER_WIDTH(TL_E_USER_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SIZE_WIDTH(3),
            .TL_SOURCE_WIDTH(BIU_ID_WIDTH)
        ) u_tlc_mux_x2 (
            .us_a_opcode(s63),
            .us_a_param(s64),
            .us_a_user(s67),
            .us_a_size(s65),
            .us_a_address(s59),
            .us_a_source(s66),
            .us_a_data(s61),
            .us_a_mask(s62),
            .us_a_corrupt(s60),
            .us_a_valid(s68),
            .us_a_ready(s118),
            .us_b_opcode(nds_unused_x2_b_opcode),
            .us_b_param(nds_unused_x2_b_param),
            .us_b_size(nds_unused_x2_b_size),
            .us_b_source(s116),
            .us_b_address(s113),
            .us_b_user(s117),
            .us_b_data(s114),
            .us_b_mask(s115),
            .us_b_corrupt(nds_unused_x2_b_corrupt),
            .us_b_valid(nds_unused_x2_b_valid),
            .us_b_ready(2'b0),
            .us_c_opcode(s72),
            .us_c_param(s73),
            .us_c_user(s76),
            .us_c_size(s74),
            .us_c_address(s69),
            .us_c_source(s75),
            .us_c_data(s71),
            .us_c_corrupt(s70),
            .us_c_valid(s77),
            .us_c_ready(s119),
            .us_d_opcode(s123),
            .us_d_param(s124),
            .us_d_size(s126),
            .us_d_user(s128),
            .us_d_data(s121),
            .us_d_source(s127),
            .us_d_sink(s125),
            .us_d_denied(s122),
            .us_d_corrupt(s120),
            .us_d_valid(s129),
            .us_d_ready(s78),
            .us_e_valid(s81),
            .us_e_user(s80),
            .us_e_sink(s79),
            .us_e_ready(s130),
            .ds_a_opcode(ds_a_opcode),
            .ds_a_param(ds_a_param),
            .ds_a_user(ds_a_user),
            .ds_a_size(ds_a_size),
            .ds_a_address(ds_a_address),
            .ds_a_data(ds_a_data),
            .ds_a_mask(ds_a_mask),
            .ds_a_source(ds_a_source),
            .ds_a_corrupt(ds_a_corrupt),
            .ds_a_valid(ds_a_valid),
            .ds_a_ready(ds_a_ready),
            .ds_b_opcode(ds_b_opcode),
            .ds_b_param(ds_b_param),
            .ds_b_size(ds_b_size),
            .ds_b_source(ds_b_source),
            .ds_b_address(ds_b_address),
            .ds_b_user(ds_b_user),
            .ds_b_data(ds_b_data),
            .ds_b_mask(ds_b_mask),
            .ds_b_corrupt(ds_b_corrupt),
            .ds_b_valid(ds_b_valid),
            .ds_b_ready(nds_unused_ds_b_ready),
            .ds_c_opcode(ds_c_opcode),
            .ds_c_param(ds_c_param),
            .ds_c_user(ds_c_user),
            .ds_c_size(ds_c_size),
            .ds_c_address(ds_c_address),
            .ds_c_source(ds_c_source),
            .ds_c_data(ds_c_data),
            .ds_c_corrupt(ds_c_corrupt),
            .ds_c_valid(ds_c_valid),
            .ds_c_ready(ds_c_ready),
            .ds_d_opcode(ds_d_opcode),
            .ds_d_param(ds_d_param),
            .ds_d_user(ds_d_user),
            .ds_d_size(ds_d_size),
            .ds_d_data(ds_d_data),
            .ds_d_source(ds_d_source),
            .ds_d_sink(ds_d_sink),
            .ds_d_denied(ds_d_denied),
            .ds_d_corrupt(ds_d_corrupt),
            .ds_d_valid(ds_d_valid),
            .ds_d_ready(ds_d_ready),
            .ds_e_valid(ds_e_valid),
            .ds_e_user(ds_e_user),
            .ds_e_sink(ds_e_sink),
            .ds_e_ready(ds_e_ready),
            .clk(core_clk),
            .resetn(core_reset_n)
        );
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 0)) begin:gen_axi_tlc2axi
        atctlc2axi500 #(
            .ADDR_WIDTH(BIU_ADDR_WIDTH),
            .AXI_ASYNC(BIU_ASYNC_SUPPORT),
            .AXI_ID_WIDTH(BIU_ID_WIDTH),
            .AXI_USER_WIDTH(1),
            .DATA_WIDTH(BIU_DATA_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SOURCE_WIDTH(BIU_ID_WIDTH)
        ) u_tlc2axi (
            .clk(core_clk),
            .resetn(core_reset_n),
            .aclk_en(bus_clk_en),
            .aclk(bus_clk),
            .aresetn(s0),
            .awid(awid),
            .awaddr(awaddr),
            .awlen(awlen),
            .awsize(awsize),
            .awburst(awburst),
            .awlock(awlock),
            .awcache(awcache),
            .awprot(awprot),
            .awuser(nds_unused_awuser),
            .awvalid(awvalid),
            .awready(awready),
            .wdata(wdata),
            .wstrb(wstrb),
            .wlast(wlast),
            .wuser(nds_unused_wuser),
            .wvalid(wvalid),
            .wready(wready),
            .bid(bid),
            .bresp(bresp),
            .buser(1'b0),
            .bvalid(bvalid),
            .bready(bready),
            .arid(arid),
            .araddr(araddr),
            .arlen(arlen),
            .arsize(arsize),
            .arburst(arburst),
            .arlock(arlock),
            .arcache(arcache),
            .arprot(arprot),
            .aruser(nds_unused_aruser),
            .arvalid(arvalid),
            .arready(arready),
            .rid(rid),
            .rdata(rdata),
            .rresp(rresp),
            .rlast(rlast),
            .ruser(1'b0),
            .rvalid(rvalid),
            .rready(rready),
            .a_opcode(ds_a_opcode),
            .a_param(ds_a_param),
            .a_size(ds_a_size),
            .a_source(ds_a_source),
            .a_address(ds_a_address),
            .a_mask(ds_a_mask),
            .a_corrupt(ds_a_corrupt),
            .a_data(ds_a_data),
            .a_user(ds_a_user),
            .a_valid(ds_a_valid),
            .a_ready(ds_a_ready),
            .b_opcode(nds_unused_ds_b_opcode),
            .b_param(nds_unused_ds_b_param),
            .b_size(nds_unused_ds_b_size),
            .b_source(s86),
            .b_address(s83),
            .b_mask(s85),
            .b_corrupt(nds_unused_ds_b_corrupt),
            .b_data(s84),
            .b_user(nds_unused_ds_b_user),
            .b_valid(nds_unused_ds_b_valid),
            .b_ready(1'b0),
            .c_opcode(ds_c_opcode),
            .c_param(ds_c_param),
            .c_size(ds_c_size),
            .c_source(ds_c_source),
            .c_address(ds_c_address),
            .c_corrupt(ds_c_corrupt),
            .c_data(ds_c_data),
            .c_user(ds_c_user),
            .c_valid(ds_c_valid),
            .c_ready(ds_c_ready),
            .d_opcode(ds_d_opcode),
            .d_param(ds_d_param),
            .d_size(ds_d_size),
            .d_source(ds_d_source),
            .d_sink(ds_d_sink),
            .d_denied(ds_d_denied),
            .d_corrupt(ds_d_corrupt),
            .d_data(ds_d_data),
            .d_user(ds_d_user),
            .d_valid(ds_d_valid),
            .d_ready(ds_d_ready),
            .e_sink(ds_e_sink),
            .e_valid(ds_e_valid),
            .e_ready(ds_e_ready),
            .e_user(ds_e_user)
        );
    end
endgenerate
generate
    if ((BIU_PATH_X2_INT == 1)) begin:gen_path_x2_tlc2axi
        atctlc2axi500 #(
            .ADDR_WIDTH(BIU_ADDR_WIDTH),
            .AXI_ASYNC(BIU_ASYNC_SUPPORT),
            .AXI_ID_WIDTH(BIU_ID_WIDTH),
            .AXI_USER_WIDTH(1),
            .DATA_WIDTH(BIU_DATA_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SOURCE_WIDTH(BIU_ID_WIDTH)
        ) u_tlc2axi_i (
            .clk(core_clk),
            .resetn(core_reset_n),
            .aclk_en(bus_clk_en),
            .aclk(bus_clk),
            .aresetn(s0),
            .awid(i_awid),
            .awaddr(i_awaddr),
            .awlen(i_awlen),
            .awsize(i_awsize),
            .awburst(i_awburst),
            .awlock(i_awlock),
            .awcache(i_awcache),
            .awprot(i_awprot),
            .awuser(nds_unused_i_awuser),
            .awvalid(i_awvalid),
            .awready(i_awready),
            .wdata(i_wdata),
            .wstrb(i_wstrb),
            .wlast(i_wlast),
            .wuser(nds_unused_i_wuser),
            .wvalid(i_wvalid),
            .wready(i_wready),
            .bid(i_bid),
            .bresp(i_bresp),
            .buser(1'b0),
            .bvalid(i_bvalid),
            .bready(i_bready),
            .arid(i_arid),
            .araddr(i_araddr),
            .arlen(i_arlen),
            .arsize(i_arsize),
            .arburst(i_arburst),
            .arlock(i_arlock),
            .arcache(i_arcache),
            .arprot(i_arprot),
            .aruser(nds_unused_i_aruser),
            .arvalid(i_arvalid),
            .arready(i_arready),
            .rid(i_rid),
            .rdata(i_rdata),
            .rresp(i_rresp),
            .rlast(i_rlast),
            .ruser(1'b0),
            .rvalid(i_rvalid),
            .rready(i_rready),
            .a_opcode(icu_a_opcode),
            .a_param(icu_a_param),
            .a_size(icu_a_size),
            .a_source(s5),
            .a_address(icu_a_address),
            .a_mask(icu_a_mask),
            .a_corrupt(icu_a_corrupt),
            .a_data(icu_a_data),
            .a_user(s6),
            .a_valid(icu_a_valid),
            .a_ready(icu_a_ready),
            .b_opcode(nds_unused_icu_b_opcode),
            .b_param(nds_unused_icu_b_param),
            .b_size(nds_unused_icu_b_size),
            .b_source(s94),
            .b_address(s91),
            .b_mask(s93),
            .b_corrupt(nds_unused_icu_b_corrupt),
            .b_data(s92),
            .b_user(nds_unused_icu_b_user),
            .b_valid(nds_unused_icu_b_valid),
            .b_ready(1'b0),
            .c_opcode(s10),
            .c_param(s11),
            .c_size(s12),
            .c_source(s13),
            .c_address(s7),
            .c_corrupt(s8),
            .c_data(s9),
            .c_user(s15),
            .c_valid(s16),
            .c_ready(s87),
            .d_opcode(icu_d_opcode),
            .d_param(icu_d_param),
            .d_size(icu_d_size),
            .d_source(s88),
            .d_sink(icu_d_sink),
            .d_denied(icu_d_denied),
            .d_corrupt(icu_d_corrupt),
            .d_data(icu_d_data),
            .d_user(s89),
            .d_valid(icu_d_valid),
            .d_ready(icu_d_ready),
            .e_sink(s17),
            .e_valid(s19),
            .e_ready(s90),
            .e_user(s18)
        );
        atctlc2axi500 #(
            .ADDR_WIDTH(BIU_ADDR_WIDTH),
            .AXI_ASYNC(BIU_ASYNC_SUPPORT),
            .AXI_ID_WIDTH(BIU_ID_WIDTH),
            .AXI_USER_WIDTH(1),
            .DATA_WIDTH(BIU_DATA_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SOURCE_WIDTH(BIU_ID_WIDTH)
        ) u_tlc2axi_d (
            .clk(core_clk),
            .resetn(core_reset_n),
            .aclk_en(bus_clk_en),
            .aclk(bus_clk),
            .aresetn(s0),
            .awid(d_awid),
            .awaddr(d_awaddr),
            .awlen(d_awlen),
            .awsize(d_awsize),
            .awburst(d_awburst),
            .awlock(d_awlock),
            .awcache(d_awcache),
            .awprot(d_awprot),
            .awuser(nds_unused_d_awuser),
            .awvalid(d_awvalid),
            .awready(d_awready),
            .wdata(d_wdata),
            .wstrb(d_wstrb),
            .wlast(d_wlast),
            .wuser(nds_unused_d_wuser),
            .wvalid(d_wvalid),
            .wready(d_wready),
            .bid(d_bid),
            .bresp(d_bresp),
            .buser(1'b0),
            .bvalid(d_bvalid),
            .bready(d_bready),
            .arid(d_arid),
            .araddr(d_araddr),
            .arlen(d_arlen),
            .arsize(d_arsize),
            .arburst(d_arburst),
            .arlock(d_arlock),
            .arcache(d_arcache),
            .arprot(d_arprot),
            .aruser(nds_unused_d_aruser),
            .arvalid(d_arvalid),
            .arready(d_arready),
            .rid(d_rid),
            .rdata(d_rdata),
            .rresp(d_rresp),
            .rlast(d_rlast),
            .ruser(1'b0),
            .rvalid(d_rvalid),
            .rready(d_rready),
            .a_opcode(ds_a_opcode),
            .a_param(ds_a_param),
            .a_size(ds_a_size),
            .a_source(ds_a_source),
            .a_address(ds_a_address),
            .a_mask(ds_a_mask),
            .a_corrupt(ds_a_corrupt),
            .a_data(ds_a_data),
            .a_user(ds_a_user),
            .a_valid(ds_a_valid),
            .a_ready(ds_a_ready),
            .b_opcode(nds_unused_ds_b_opcode),
            .b_param(nds_unused_ds_b_param),
            .b_size(nds_unused_ds_b_size),
            .b_source(s86),
            .b_address(s83),
            .b_mask(s85),
            .b_corrupt(nds_unused_ds_b_corrupt),
            .b_data(s84),
            .b_user(nds_unused_ds_b_user),
            .b_valid(nds_unused_ds_b_valid),
            .b_ready(1'b0),
            .c_opcode(ds_c_opcode),
            .c_param(ds_c_param),
            .c_size(ds_c_size),
            .c_source(ds_c_source),
            .c_address(ds_c_address),
            .c_corrupt(ds_c_corrupt),
            .c_data(ds_c_data),
            .c_user(ds_c_user),
            .c_valid(ds_c_valid),
            .c_ready(ds_c_ready),
            .d_opcode(ds_d_opcode),
            .d_param(ds_d_param),
            .d_size(ds_d_size),
            .d_source(ds_d_source),
            .d_sink(ds_d_sink),
            .d_denied(ds_d_denied),
            .d_corrupt(ds_d_corrupt),
            .d_data(ds_d_data),
            .d_user(ds_d_user),
            .d_valid(ds_d_valid),
            .d_ready(ds_d_ready),
            .e_sink(ds_e_sink),
            .e_valid(ds_e_valid),
            .e_ready(ds_e_ready),
            .e_user(ds_e_user)
        );
    end
endgenerate
endmodule

