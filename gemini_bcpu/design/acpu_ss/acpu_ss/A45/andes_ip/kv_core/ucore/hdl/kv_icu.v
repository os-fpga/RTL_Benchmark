// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icu (
    core_clk,
    core_reset_n,
    csr_mcache_ctl_ic_en,
    csr_halt_mode,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    ifu_icu_kill,
    icu_ifu_bus_req_full,
    icu_ifu_bus_req_event,
    ifu_icu_req_valid,
    ifu_icu_req_type,
    ifu_icu_req_addr,
    ifu_icu_req_nonseq,
    ifu_icu_req_rd_word,
    ifu_icu_req_tag,
    ifu_icu_f1_pa,
    ifu_icu_f2_cacheable,
    ifu_icu_f2_cctl_pref,
    ifu_icu_req_wdata,
    ifu_icu_req_wecc,
    icu_ifu_req_ready,
    icu_ifu_resp_valid,
    icu_ifu_resp_tag,
    icu_ifu_resp_rdata,
    icu_ifu_resp_status,
    ifu_icu_line_aq,
    ifu_icu_line_aq_addr,
    ifu_icu_line_aq_index,
    ifu_icu_line_aq_attri,
    icu_ifu_line_aq_error,
    icu_ifu_line_aq_done,
    ifu_icu_line_op_req,
    ifu_icu_line_op,
    icu_ifu_line_op_req_done,
    icu_standby_ready,
    icu_a_opcode,
    icu_a_param,
    icu_a_size,
    icu_a_address,
    icu_a_data,
    icu_a_mask,
    icu_a_corrupt,
    icu_a_user,
    icu_a_source,
    icu_a_valid,
    icu_a_ready,
    icu_d_opcode,
    icu_d_param,
    icu_d_size,
    icu_d_data,
    icu_d_denied,
    icu_d_corrupt,
    icu_d_user,
    icu_d_source,
    icu_d_sink,
    icu_d_valid,
    icu_d_ready,
    icache_tag0_cs,
    icache_tag0_wdata,
    icache_tag0_rdata,
    icache_tag0_we,
    icache_tag0_addr,
    icache_data0_cs,
    icache_data0_wdata,
    icache_data0_we,
    icache_data0_addr,
    icache_data0_rdata,
    icache_tag1_cs,
    icache_tag1_wdata,
    icache_tag1_rdata,
    icache_tag1_we,
    icache_tag1_addr,
    icache_data1_cs,
    icache_data1_wdata,
    icache_data1_we,
    icache_data1_addr,
    icache_data1_rdata,
    icache_tag2_cs,
    icache_tag2_wdata,
    icache_tag2_rdata,
    icache_tag2_we,
    icache_tag2_addr,
    icache_data2_cs,
    icache_data2_wdata,
    icache_data2_we,
    icache_data2_addr,
    icache_data2_rdata,
    icache_tag3_cs,
    icache_tag3_wdata,
    icache_tag3_rdata,
    icache_tag3_we,
    icache_tag3_addr,
    icache_data3_cs,
    icache_data3_wdata,
    icache_data3_we,
    icache_data3_addr,
    icache_data3_rdata,
    icache_data4_cs,
    icache_data4_wdata,
    icache_data4_we,
    icache_data4_addr,
    icache_data4_rdata,
    icache_data5_cs,
    icache_data5_wdata,
    icache_data5_we,
    icache_data5_addr,
    icache_data5_rdata,
    icache_data6_cs,
    icache_data6_wdata,
    icache_data6_we,
    icache_data6_addr,
    icache_data6_rdata,
    icache_data7_cs,
    icache_data7_wdata,
    icache_data7_we,
    icache_data7_addr,
    icache_data7_rdata
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter PALEN = 32;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter TL_SIZE_WIDTH = 3;
parameter TL_SINK_WIDTH = 2;
parameter CACHE_LINE_SIZE = 32;
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_TAG_RAM_AW = 9;
parameter ICACHE_TAG_RAM_DW = 26;
parameter ICACHE_DATA_RAM_DW = 64;
parameter ICACHE_DATA_RAM_AW = 11;
parameter ICACHE_LRU_INT = 0;
parameter ICACHE_WAY = 2;
parameter ICACHE_ECC_TYPE_INT = 0;
parameter ICACHE_TAG_ECC_DW = 7;
parameter ICACHE_DATA_ECC_DW = 7;
parameter ICACHE_INDEX_MSB = 10;
parameter ICACHE_FIRST_WORD_FIRST_INT = 0;
localparam ICU_SOURCE_WIDTH = 1;
localparam TAG_ECC_DW = (ICACHE_TAG_ECC_DW == 0) ? 1 : ICACHE_TAG_ECC_DW;
localparam DATA_ECC_DW = (ICACHE_DATA_ECC_DW == 0) ? 1 : ICACHE_DATA_ECC_DW;
localparam LRU_WIDTH = (ICACHE_WAY == 4) ? 3 : 1;
localparam FILL_DATA_WIDTH = 32;
localparam FILL_ENTRY = (CACHE_LINE_SIZE == 64) ? 8 : 4;
localparam OFFSET_WIDTH = 3;
localparam NO_ECC_TAG_DW = ICACHE_TAG_RAM_DW - ICACHE_TAG_ECC_DW;
localparam NO_ECC_DATA_DW = ICACHE_DATA_RAM_DW - ICACHE_DATA_ECC_DW;
localparam TAG_MSB = (ICACHE_SIZE_KB == 0) ? 0 : (PALEN - 1);
localparam TAG_LSB = (ICACHE_SIZE_KB == 0) ? TAG_MSB : (TAG_MSB - NO_ECC_TAG_DW + 4);
localparam TAG_WIDTH = TAG_MSB - TAG_LSB + 1;
localparam INDEX_MSB = ICACHE_INDEX_MSB;
localparam INDEX_LSB = 6;
localparam INDEX_WIDTH = INDEX_MSB - INDEX_LSB + 1;
localparam OFFSET_MSB = 5;
localparam OFFSET_LSB = OFFSET_MSB - OFFSET_WIDTH + 1;
localparam CACHE_VALID = NO_ECC_TAG_DW - 1;
localparam CACHE_LOCK = NO_ECC_TAG_DW - 2;
localparam CACHE_LOCK_DUP = NO_ECC_TAG_DW - 3;
localparam ICACHE_ECC_SUPPORT = ((ICACHE_ECC_TYPE_INT == 0)) ? 0 : 1;
localparam TAG_RAM_AW = ICACHE_TAG_RAM_AW;
localparam TAG_RAM_DW = ICACHE_TAG_RAM_DW;
localparam DATA_RAM_DW = ICACHE_DATA_RAM_DW;
localparam DATA_RAM_AW = ICACHE_DATA_RAM_AW;
localparam FB_FILL_WIDTH = (ICACHE_WAY == 4) ? 256 : (ICACHE_WAY == 2) ? 128 : 64;
localparam FB_DEPTH = 3'b010;
localparam ST_IDLE = 3'd0;
localparam ST_DONE = 3'd1;
localparam ST_WAIT_OST = 3'd2;
localparam ST_FILL_LINE = 3'd3;
input core_clk;
input core_reset_n;
input csr_mcache_ctl_ic_en;
input csr_halt_mode;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
input ifu_icu_kill;
output icu_ifu_bus_req_full;
output icu_ifu_bus_req_event;
input ifu_icu_req_valid;
input [2:0] ifu_icu_req_type;
input [VALEN - 1:0] ifu_icu_req_addr;
input ifu_icu_req_nonseq;
input [1:0] ifu_icu_req_rd_word;
input ifu_icu_req_tag;
input [PALEN - 1:0] ifu_icu_f1_pa;
input ifu_icu_f2_cacheable;
input ifu_icu_f2_cctl_pref;
input [71:0] ifu_icu_req_wdata;
input ifu_icu_req_wecc;
output icu_ifu_req_ready;
output [3:0] icu_ifu_resp_valid;
output icu_ifu_resp_tag;
output [63:0] icu_ifu_resp_rdata;
output [35:0] icu_ifu_resp_status;
input ifu_icu_line_aq;
input [PALEN - 1:0] ifu_icu_line_aq_addr;
input [ICACHE_INDEX_MSB:6] ifu_icu_line_aq_index;
input [16:0] ifu_icu_line_aq_attri;
output icu_ifu_line_aq_error;
output icu_ifu_line_aq_done;
input ifu_icu_line_op_req;
input [1:0] ifu_icu_line_op;
output icu_ifu_line_op_req_done;
output icu_standby_ready;
output [2:0] icu_a_opcode;
output [2:0] icu_a_param;
output [TL_SIZE_WIDTH - 1:0] icu_a_size;
output [L2_ADDR_WIDTH - 1:0] icu_a_address;
output [L2_DATA_WIDTH - 1:0] icu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] icu_a_mask;
output icu_a_corrupt;
output [7:0] icu_a_user;
output [1:0] icu_a_source;
output icu_a_valid;
input icu_a_ready;
input [2:0] icu_d_opcode;
input [1:0] icu_d_param;
input [TL_SIZE_WIDTH - 1:0] icu_d_size;
input [(L2_DATA_WIDTH - 1):0] icu_d_data;
input icu_d_denied;
input icu_d_corrupt;
input [1:0] icu_d_user;
input [1:0] icu_d_source;
input [TL_SINK_WIDTH - 1:0] icu_d_sink;
input icu_d_valid;
output icu_d_ready;
output icache_tag0_cs;
output [TAG_RAM_DW - 1:0] icache_tag0_wdata;
input [TAG_RAM_DW - 1:0] icache_tag0_rdata;
output icache_tag0_we;
output [TAG_RAM_AW - 1:0] icache_tag0_addr;
output icache_data0_cs;
output [DATA_RAM_DW - 1:0] icache_data0_wdata;
output icache_data0_we;
output [DATA_RAM_AW - 1:0] icache_data0_addr;
input [DATA_RAM_DW - 1:0] icache_data0_rdata;
output icache_tag1_cs;
output [TAG_RAM_DW - 1:0] icache_tag1_wdata;
input [TAG_RAM_DW - 1:0] icache_tag1_rdata;
output icache_tag1_we;
output [TAG_RAM_AW - 1:0] icache_tag1_addr;
output icache_data1_cs;
output [DATA_RAM_DW - 1:0] icache_data1_wdata;
output icache_data1_we;
output [DATA_RAM_AW - 1:0] icache_data1_addr;
input [DATA_RAM_DW - 1:0] icache_data1_rdata;
output icache_tag2_cs;
output [TAG_RAM_DW - 1:0] icache_tag2_wdata;
input [TAG_RAM_DW - 1:0] icache_tag2_rdata;
output icache_tag2_we;
output [TAG_RAM_AW - 1:0] icache_tag2_addr;
output icache_data2_cs;
output [DATA_RAM_DW - 1:0] icache_data2_wdata;
output icache_data2_we;
output [DATA_RAM_AW - 1:0] icache_data2_addr;
input [DATA_RAM_DW - 1:0] icache_data2_rdata;
output icache_tag3_cs;
output [TAG_RAM_DW - 1:0] icache_tag3_wdata;
input [TAG_RAM_DW - 1:0] icache_tag3_rdata;
output icache_tag3_we;
output [TAG_RAM_AW - 1:0] icache_tag3_addr;
output icache_data3_cs;
output [DATA_RAM_DW - 1:0] icache_data3_wdata;
output icache_data3_we;
output [DATA_RAM_AW - 1:0] icache_data3_addr;
input [DATA_RAM_DW - 1:0] icache_data3_rdata;
output icache_data4_cs;
output [DATA_RAM_DW - 1:0] icache_data4_wdata;
output icache_data4_we;
output [DATA_RAM_AW - 1:0] icache_data4_addr;
input [DATA_RAM_DW - 1:0] icache_data4_rdata;
output icache_data5_cs;
output [DATA_RAM_DW - 1:0] icache_data5_wdata;
output icache_data5_we;
output [DATA_RAM_AW - 1:0] icache_data5_addr;
input [DATA_RAM_DW - 1:0] icache_data5_rdata;
output icache_data6_cs;
output [DATA_RAM_DW - 1:0] icache_data6_wdata;
output icache_data6_we;
output [DATA_RAM_AW - 1:0] icache_data6_addr;
input [DATA_RAM_DW - 1:0] icache_data6_rdata;
output icache_data7_cs;
output [DATA_RAM_DW - 1:0] icache_data7_wdata;
output icache_data7_we;
output [DATA_RAM_AW - 1:0] icache_data7_addr;
input [DATA_RAM_DW - 1:0] icache_data7_rdata;


wire icache_tag0_cs;
wire [TAG_RAM_DW - 1:0] icache_tag0_rdata;
wire icache_tag0_we;
wire [TAG_RAM_AW - 1:0] icache_tag0_addr;
wire icache_data0_cs;
wire icache_data0_we;
wire [DATA_RAM_AW - 1:0] icache_data0_addr;
wire [DATA_RAM_DW - 1:0] icache_data0_rdata;
wire icache_tag1_cs;
wire [TAG_RAM_DW - 1:0] icache_tag1_rdata;
wire icache_tag1_we;
wire [TAG_RAM_AW - 1:0] icache_tag1_addr;
wire icache_data1_cs;
wire icache_data1_we;
wire [DATA_RAM_AW - 1:0] icache_data1_addr;
wire [DATA_RAM_DW - 1:0] icache_data1_rdata;
wire icache_tag2_cs;
wire [TAG_RAM_DW - 1:0] icache_tag2_rdata;
wire icache_tag2_we;
wire [TAG_RAM_AW - 1:0] icache_tag2_addr;
wire icache_data2_cs;
wire icache_data2_we;
wire [DATA_RAM_AW - 1:0] icache_data2_addr;
wire [DATA_RAM_DW - 1:0] icache_data2_rdata;
wire icache_tag3_cs;
wire [TAG_RAM_DW - 1:0] icache_tag3_rdata;
wire icache_tag3_we;
wire [TAG_RAM_AW - 1:0] icache_tag3_addr;
wire icache_data3_cs;
wire icache_data3_we;
wire [DATA_RAM_AW - 1:0] icache_data3_addr;
wire [DATA_RAM_DW - 1:0] icache_data3_rdata;
wire icache_data4_cs;
wire icache_data4_we;
wire [DATA_RAM_AW - 1:0] icache_data4_addr;
wire [DATA_RAM_DW - 1:0] icache_data4_rdata;
wire icache_data5_cs;
wire icache_data5_we;
wire [DATA_RAM_AW - 1:0] icache_data5_addr;
wire [DATA_RAM_DW - 1:0] icache_data5_rdata;
wire icache_data6_cs;
wire icache_data6_we;
wire [DATA_RAM_AW - 1:0] icache_data6_addr;
wire [DATA_RAM_DW - 1:0] icache_data6_rdata;
wire icache_data7_cs;
wire icache_data7_we;
wire [DATA_RAM_AW - 1:0] icache_data7_addr;
wire [DATA_RAM_DW - 1:0] icache_data7_rdata;
wire [3:0] f2_ecc_error_way;
wire f2_ecc_ramid;
wire f2_ecc_corr;
wire [7:0] f2_ecc_code;
wire s0;
wire f2_hit;
wire [3:0] f2_hit_way;
wire [3:0] f2_valid_way;
wire [3:0] f2_lock_way;
wire [63:0] f2_hit_data;
wire [63:0] s1;
wire [NO_ECC_TAG_DW - 1:0] f2_hit_tag;
wire [63:0] f2_tag_rdata;
wire [63:0] f2_data_rdata;
wire [7:0] f2_recccode;
wire s2;
wire s3;
wire s4;
wire [PALEN - 1:0] s5;
wire s6;
wire [3:0] s7;
wire s8;
wire s9;
wire [PALEN - 1:0] s10;
wire [TAG_WIDTH - 1:0] s11;
wire [INDEX_WIDTH - 1:0] s12;
wire [OFFSET_WIDTH - 1:0] s13;
wire s14;
wire [1:0] s15;
wire [3:0] s16;
wire s17;
wire s18;
wire s19;
wire [1:0] s20;
wire [TAG_WIDTH - 1:0] s21;
wire [INDEX_WIDTH - 1:0] s22;
wire [63:0] s23;
wire [63:0] s24;
wire [63:0] s25;
wire [63:0] s26;
wire s27;
wire s28;
wire [255:0] s29;
wire s30;
wire s31;
wire s32;
wire s33;
wire s34;
wire [TAG_WIDTH - 1:0] s35;
wire [INDEX_WIDTH - 1:0] s36;
wire [OFFSET_WIDTH - 1:0] s37;
wire [PALEN - 1:0] s38;
wire [63:0] s39;
wire s40;
wire s41;
wire s42;
wire s43;
wire [TAG_WIDTH - 1:0] s44;
wire [INDEX_WIDTH - 1:0] s45;
wire [OFFSET_WIDTH - 1:0] s46;
wire [PALEN - 1:0] s47;
wire s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire [PALEN - 1:0] s53;
wire s54;
wire [3:0] s55;
wire s56;
wire s57;
wire [PALEN - 1:0] s58;
wire [TAG_WIDTH - 1:0] s59;
wire [INDEX_WIDTH - 1:0] s60;
wire [OFFSET_WIDTH - 1:0] s61;
wire s62;
wire [3:0] s63;
wire [1:0] s64;
wire s65;
wire s66;
wire s67;
wire [1:0] s68;
wire [TAG_WIDTH - 1:0] s69;
wire [INDEX_WIDTH - 1:0] s70;
wire [63:0] s71;
wire [63:0] s72;
wire [63:0] s73;
wire [63:0] s74;
wire s75;
wire s76;
wire [255:0] s77;
wire s78;
wire s79;
wire s80;
wire s81;
wire s82;
wire [TAG_WIDTH - 1:0] s83;
wire [INDEX_WIDTH - 1:0] s84;
wire [OFFSET_WIDTH - 1:0] s85;
wire [PALEN - 1:0] s86;
wire [63:0] s87;
wire s88;
wire s89;
wire s90;
wire s91;
wire [TAG_WIDTH - 1:0] s92;
wire [INDEX_WIDTH - 1:0] s93;
wire [OFFSET_WIDTH - 1:0] s94;
wire [PALEN - 1:0] s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
wire [PALEN - 1:0] s101;
wire s102;
wire [3:0] s103;
wire s104;
wire s105;
wire [PALEN - 1:0] s106;
wire [TAG_WIDTH - 1:0] s107;
wire [INDEX_WIDTH - 1:0] s108;
wire [OFFSET_WIDTH - 1:0] s109;
wire s110;
wire [3:0] s111;
wire [1:0] s112;
wire s113;
wire s114;
wire s115;
wire [1:0] s116;
wire [TAG_WIDTH - 1:0] s117;
wire [INDEX_WIDTH - 1:0] s118;
wire [63:0] s119;
wire [63:0] s120;
wire [63:0] s121;
wire [63:0] s122;
wire s123;
wire s124;
wire [255:0] s125;
wire s126;
wire s127;
wire s128;
wire s129;
wire s130;
wire [TAG_WIDTH - 1:0] s131;
wire [INDEX_WIDTH - 1:0] s132;
wire [OFFSET_WIDTH - 1:0] s133;
wire [PALEN - 1:0] s134;
wire [63:0] s135;
wire s136;
wire s137;
wire s138;
wire s139;
wire [TAG_WIDTH - 1:0] s140;
wire [INDEX_WIDTH - 1:0] s141;
wire [OFFSET_WIDTH - 1:0] s142;
wire [PALEN - 1:0] s143;
wire s144;
wire s145;
wire s146;
wire s147;
wire s148;
wire [PALEN - 1:0] s149;
wire s150;
wire [3:0] s151;
wire s152;
wire s153;
wire [PALEN - 1:0] s154;
wire [TAG_WIDTH - 1:0] s155;
wire [INDEX_WIDTH - 1:0] s156;
wire [OFFSET_WIDTH - 1:0] s157;
wire s158;
wire [3:0] s159;
wire [1:0] s160;
wire s161;
wire s162;
wire s163;
wire [1:0] s164;
wire [TAG_WIDTH - 1:0] s165;
wire [INDEX_WIDTH - 1:0] s166;
wire [63:0] s167;
wire [63:0] s168;
wire [63:0] s169;
wire [63:0] s170;
wire s171;
wire s172;
wire [255:0] s173;
wire s174;
wire s175;
wire s176;
wire s177;
wire s178;
wire [TAG_WIDTH - 1:0] s179;
wire [INDEX_WIDTH - 1:0] s180;
wire [OFFSET_WIDTH - 1:0] s181;
wire [PALEN - 1:0] s182;
wire [63:0] s183;
wire s184;
wire s185;
wire s186;
wire s187;
wire [TAG_WIDTH - 1:0] s188;
wire [INDEX_WIDTH - 1:0] s189;
wire [OFFSET_WIDTH - 1:0] s190;
wire [PALEN - 1:0] s191;
wire s192;
wire s193;
wire s194;
wire s195;
wire s196;
reg [2:0] s197;
wire [2:0] s198;
wire s199;
wire s200 = ifu_icu_line_op_req & (ifu_icu_line_op == 2'b0);
wire s201 = ifu_icu_line_op_req & (ifu_icu_line_op == 2'b1);
wire fb_aq_hit;
wire s202;
wire [1:0] fb_alloc_way;
wire fill2cache;
wire s203 = csr_mcache_ctl_ic_en;
wire s204 = csr_halt_mode;
wire s205 = ifu_icu_f2_cacheable | ifu_icu_f2_cctl_pref;
reg s206;
wire s207;
reg [2:0] s208;
reg [VALEN - 1:0] s209;
reg s210;
reg s211;
reg [1:0] s212;
reg s213;
wire [3:0] f1_same_line_hit_way;
wire s214;
wire [1:0] s215;
wire [3:0] s216;
wire s217;
wire s218;
wire [63:0] s219;
wire s220;
reg s221;
wire s222;
reg s223;
reg [2:0] s224;
reg [VALEN - 1:0] s225;
wire s226;
reg [3:0] s227;
wire s228;
reg s229;
reg s230;
reg [63:0] s231;
reg s232;
reg [1:0] s233;
wire [1:0] s234;
wire [63:0] s235;
wire [63:0] s236;
wire [63:0] s237;
wire [63:0] s238;
wire [63:0] s239;
wire s240;
reg [1:0] s241;
wire [1:0] s242;
wire [1:0] s243;
wire [1:0] s244;
wire s245;
reg s246;
reg [2:0] s247;
reg [2:0] s248;
wire [2:0] s249;
wire [2:0] s250;
wire s251;
reg s252;
reg s253;
wire s254;
wire s255;
wire s256;
wire s257;
wire [1:0] s258;
wire [1:0] s259;
wire fb_alloc;
wire [3:0] fb_alloc_arcache;
wire [3:0] s260;
wire [2:0] agent_a_opcode;
wire [2:0] agent_a_param;
wire [TL_SIZE_WIDTH - 1:0] s261;
wire [TL_SIZE_WIDTH - 1:0] agent_a_size;
wire [L2_ADDR_WIDTH - 1:0] s262;
wire [L2_ADDR_WIDTH - 1:0] agent_a_address;
wire [255:0] agent_a_data;
wire [31:0] agent_a_mask;
wire agent_a_corrupt;
wire [7:0] agent_a_user;
wire agent_a_valid;
wire agent_a_ready;
wire [ICU_SOURCE_WIDTH - 1:0] agent_a_source;
wire [2:0] agent_d_opcode;
wire [1:0] agent_d_param;
wire [TL_SIZE_WIDTH - 1:0] agent_d_size;
wire [255:0] agent_d_data;
wire agent_d_denied;
wire agent_d_corrupt;
wire [1:0] agent_d_user;
wire agent_d_valid;
wire agent_d_ready;
wire [ICU_SOURCE_WIDTH - 1:0] agent_d_source;
wire [1:0] s263;
wire [TL_SINK_WIDTH - 1:0] agent_d_sink;
wire [2:0] icu_a_opcode;
wire [2:0] icu_a_param;
wire [TL_SIZE_WIDTH - 1:0] icu_a_size;
wire [1:0] icu_a_source;
wire [ICU_SOURCE_WIDTH - 1:0] s264;
wire [L2_ADDR_WIDTH - 1:0] icu_a_address;
wire [L2_DATA_WIDTH - 1:0] icu_a_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] icu_a_mask;
wire icu_a_corrupt;
wire [7:0] icu_a_user;
wire icu_a_valid;
wire icu_a_ready;
wire [2:0] icu_d_opcode;
wire [1:0] icu_d_param;
wire [TL_SIZE_WIDTH - 1:0] icu_d_size;
wire [1:0] icu_d_source;
wire [TL_SINK_WIDTH - 1:0] icu_d_sink;
wire [L2_DATA_WIDTH - 1:0] icu_d_data;
wire icu_d_denied;
wire icu_d_corrupt;
wire [1:0] icu_d_user;
wire icu_d_valid;
wire icu_d_ready;
reg s265;
wire s266;
wire s267;
reg [3:0] s268;
reg [3:0] s269;
wire [3:0] s270;
wire [2:0] s271;
wire [3:0] s272;
wire s273;
wire s274;
wire s275 = agent_d_valid & agent_d_ready;
reg [1:0] s276[0:3];
reg [1:0] s277;
wire [1:0] s278;
wire s279;
reg [1:0] s280;
wire [1:0] s281;
wire s282;
reg s283;
reg s284;
wire s285;
wire s286;
wire s287;
wire s288;
reg s289;
wire s290;
wire s291;
wire s292;
wire s293;
wire [1:0] s294;
wire [1:0] s295;
wire s296;
wire [1:0] s297;
wire fb_force_fill;
wire [2:0] s298;
wire [2:0] s299;
wire nds_unused_top = s27 | (|agent_d_sink) | (|agent_d_param) | (|agent_d_opcode) | (|agent_d_sink) | (|agent_d_size) | (|s260);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s252 <= 1'b0;
        s253 <= 1'b0;
    end
    else begin
        s252 <= ifu_icu_line_aq;
        s253 <= icu_ifu_line_aq_done;
    end
end

assign s240 = ifu_icu_line_aq & (~s252 | s253);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s241 <= 2'b0;
        s246 <= 1'b0;
        s248 <= {OFFSET_WIDTH{1'b0}};
    end
    else if (s240) begin
        s241 <= s243;
        s246 <= ifu_icu_line_aq_attri[0];
        s248 <= ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB];
    end
end

assign s243 = s202 ? s244 : s259;
assign s244 = s49 ? 2'd0 : s97 ? 2'd1 : s145 ? 2'd2 : 2'd3;
assign s251 = s240 | (ifu_icu_line_aq & s275 & (s263[1:0] == s242));
assign s250 = s240 ? 3'b0 : s247 + 3'b100;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s247 <= 3'b0;
    end
    else if (s251) begin
        s247 <= s250;
    end
end

assign s242 = s240 ? s243 : s241;
assign s249 = s240 ? ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB] : s248;
assign s245 = s240 ? ifu_icu_line_aq_attri[0] : s246;
assign s254 = (s263[1:0] == s242);
assign s255 = ~(s249[2] ^ s194);
assign icu_ifu_line_aq_done = (s275 & ~s245 & s254 & ifu_icu_line_aq) | (s275 & s255 & s254 & ifu_icu_line_aq) | (s240 & fb_aq_hit);
assign icu_ifu_line_aq_error = ifu_icu_line_aq & s195 & s254;
assign icu_ifu_resp_valid = s227 & {4{s221}};
assign icu_ifu_resp_tag = s223;
assign icu_ifu_resp_status[0] = s232 & s229;
assign icu_ifu_resp_status[1 +:4] = f2_ecc_error_way & {4{~s229 & ~s230}};
assign icu_ifu_resp_status[5 +:2] = {1'b1,f2_ecc_ramid};
assign icu_ifu_resp_status[7 +:8] = ({8{~s224[2] & ~s229 & ~s230}} & f2_ecc_code) | ({8{s224[2]}} & f2_recccode);
assign icu_ifu_resp_status[16 +:2] = 2'b11;
assign icu_ifu_resp_status[15] = f2_ecc_corr;
assign icu_ifu_resp_status[18 +:4] = f2_hit_way;
assign icu_ifu_resp_status[23 +:4] = f2_valid_way;
assign icu_ifu_resp_status[27 +:4] = f2_lock_way;
assign icu_ifu_resp_status[22] = s205 ? ~f2_hit : ~s229;
assign icu_ifu_resp_status[31 +:3] = s299;
assign icu_ifu_resp_status[34] = 1'b0;
assign icu_ifu_resp_status[35] = 1'b0;
assign icu_ifu_resp_rdata = (s236 & {64{s224[0] & ~s224[2]}}) | (s235 & {64{~s224[0] & ~s224[2]}}) | (f2_data_rdata & {64{~s224[1] & s224[2]}}) | (f2_tag_rdata & {64{s224[1] & s224[2]}});
assign f2_hit = s229 | s0 & ~s229 & ~s230;
kv_zero_ext #(
    .OW(64),
    .IW(NO_ECC_TAG_DW)
) u_hit_tag_zext (
    .out(s236),
    .in(f2_hit_tag)
);
assign f2_hit_data = ({{32{s233[1] & s0 & ~s229}},{32{s233[0] & s0 & ~s229}}} & s1) | ({64{s229}} & s231);
kv_zero_ext #(
    .OW(64),
    .IW(48)
) u_hit_data_shift1_zext (
    .out(s237),
    .in(f2_hit_data[63:16])
);
kv_zero_ext #(
    .OW(64),
    .IW(32)
) u_hit_data_shift2_zext (
    .out(s238),
    .in(f2_hit_data[63:32])
);
kv_zero_ext #(
    .OW(64),
    .IW(16)
) u_hit_data_shift3_zext (
    .out(s239),
    .in(f2_hit_data[63:48])
);
assign s235 = ({64{(s234 == 2'd0)}} & f2_hit_data[63:0]) | ({64{(s234 == 2'd1)}} & s237) | ({64{(s234 == 2'd2)}} & s238) | ({64{(s234 == 2'd3)}} & s239);
reg s300;
wire s301;
wire s302;
wire s303;
wire s304;
reg [3:0] s305;
assign s301 = s221 & (s224 == 3'b0) & ~(s206 & s211);
assign s302 = (ifu_icu_req_valid & (s224 != 3'b0)) | (ifu_icu_req_valid & ifu_icu_req_nonseq) | fill2cache;
assign s303 = (s300 | s301) & ~s302;
assign s304 = s301 | s302;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s300 <= 1'b0;
    end
    else if (s304) begin
        s300 <= s303;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s305 <= 4'b0;
    end
    else if (s301) begin
        s305 <= f2_hit_way;
    end
end

assign s274 = (~ifu_icu_req_nonseq & ~(s206 & s211) & s221) | (~ifu_icu_req_nonseq & ~(s206 & s211) & s300);
assign f1_same_line_hit_way = s300 ? s305 : f2_hit_way & {4{s213}};
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_ic_ctrl_yes
        wire [TAG_RAM_AW - 1:0] pf_tag_index;
        wire pf_tag_we;
        wire [3:0] pf_tag_way;
        wire [NO_ECC_TAG_DW - 1:0] pf_tag_wdata;
        wire [INDEX_MSB:OFFSET_LSB] pf_data_index;
        wire pf_ram_offset;
        wire [1:0] pf_ram_rd_word;
        wire pf_data_we;
        wire [3:0] pf_data_way;
        wire [63:0] pf_data_wdata;
        wire pf_ecc_wr;
        wire [7:0] pf_wecccode;
        wire [255:0] fill_data;
        wire [3:0] fill_way;
        wire [TAG_RAM_AW - 1:0] fill_index;
        wire s306;
        wire s307;
        wire s308;
        wire s309;
        wire [3:0] s310;
        wire [3:0] s311;
        reg s312;
        reg s313;
        reg s314;
        reg s315;
        wire [3:0] s316;
        wire [3:0] s317;
        wire [3:0] s318;
        wire [3:0] s319;
        wire s320;
        wire s321;
        wire s322;
        wire s323;
        assign s320 = s18 & s19;
        assign s321 = s66 & s67;
        assign s322 = s114 & s115;
        assign s323 = s162 & s163;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s312 <= 1'b0;
                s313 <= 1'b0;
                s314 <= 1'b0;
                s315 <= 1'b0;
            end
            else begin
                s312 <= s320;
                s313 <= s321;
                s314 <= s322;
                s315 <= s323;
            end
        end

        assign s306 = s320 & ~s312 & (s20 == 2'd0) | s321 & ~s313 & (s68 == 2'd0) | s322 & ~s314 & (s116 == 2'd0) | s323 & ~s315 & (s164 == 2'd0);
        assign s307 = s320 & ~s312 & (s20 == 2'd1) | s321 & ~s313 & (s68 == 2'd1) | s322 & ~s314 & (s116 == 2'd1) | s323 & ~s315 & (s164 == 2'd1);
        assign s308 = s320 & ~s312 & (s20 == 2'd2) | s321 & ~s313 & (s68 == 2'd2) | s322 & ~s314 & (s116 == 2'd2) | s323 & ~s315 & (s164 == 2'd2);
        assign s309 = s320 & ~s312 & (s20 == 2'd3) | s321 & ~s313 & (s68 == 2'd3) | s322 & ~s314 & (s116 == 2'd3) | s323 & ~s315 & (s164 == 2'd3);
        assign s273 = s306 | s307 | s308 | s309;
        assign s310 = {ifu_icu_req_addr[INDEX_MSB + 4],ifu_icu_req_addr[INDEX_MSB + 3],ifu_icu_req_addr[INDEX_MSB + 2],ifu_icu_req_addr[INDEX_MSB + 1]};
        assign s311 = {s309,s308,s307,s306};
        assign pf_ecc_wr = ifu_icu_req_wecc;
        assign pf_wecccode = ifu_icu_req_wdata[71:64];
        assign pf_tag_we = s273 | (ifu_icu_req_valid & (ifu_icu_req_type == 3'd7));
        assign pf_tag_way = (|s311) ? s311 : (ifu_icu_req_valid & (&ifu_icu_req_type[2:1])) ? s310 : (ifu_icu_req_valid & ~(|ifu_icu_req_type[2:1])) ? {4{~s274}} : 4'b0;
        assign pf_tag_wdata = ({NO_ECC_TAG_DW{s320 & ~s312}} & {3'd4,s21}) | ({NO_ECC_TAG_DW{s321 & ~s313}} & {3'd4,s69}) | ({NO_ECC_TAG_DW{s322 & ~s314}} & {3'd4,s117}) | ({NO_ECC_TAG_DW{s323 & ~s315}} & {3'd4,s165}) | ({NO_ECC_TAG_DW{~s273}} & ifu_icu_req_wdata[NO_ECC_TAG_DW - 1:0]);
        assign pf_tag_index = ({TAG_RAM_AW{s320 & ~s312}} & s22) | ({TAG_RAM_AW{s321 & ~s313}} & s70) | ({TAG_RAM_AW{s322 & ~s314}} & s118) | ({TAG_RAM_AW{s323 & ~s315}} & s166) | ({TAG_RAM_AW{~s273}} & ifu_icu_req_addr[INDEX_MSB:INDEX_LSB]);
        assign pf_data_we = ifu_icu_req_valid & (ifu_icu_req_type == 3'd5);
        assign pf_data_way = (ifu_icu_req_valid & (^ifu_icu_req_type[2:1])) ? s310 : (ifu_icu_req_valid & (ifu_icu_req_type == 3'b0)) ? s274 ? s300 ? s305 : f2_hit_way : 4'hf : 4'b0;
        assign pf_data_wdata = ifu_icu_req_wdata[63:0];
        assign pf_data_index = ifu_icu_req_addr[INDEX_MSB:OFFSET_LSB];
        assign pf_ram_offset = ifu_icu_req_addr[2];
        assign pf_ram_rd_word = ifu_icu_req_rd_word;
        assign s316 = {s20 == 2'b11,s20 == 2'b10,s20 == 2'b01,s20 == 2'b00};
        assign s317 = {s68 == 2'b11,s68 == 2'b10,s68 == 2'b01,s68 == 2'b00};
        assign s318 = {s116 == 2'b11,s116 == 2'b10,s116 == 2'b01,s116 == 2'b00};
        assign s319 = {s164 == 2'b11,s164 == 2'b10,s164 == 2'b01,s164 == 2'b00};
        assign fill2cache = s320 | s321 | s322 | s323;
        assign fill_way = ({4{s320}} & s316) | ({4{s321}} & s317) | ({4{s322}} & s318) | ({4{s323}} & s319);
        assign fill_index = ({TAG_RAM_AW{s320}} & s22) | ({TAG_RAM_AW{s321}} & s70) | ({TAG_RAM_AW{s322}} & s118) | ({TAG_RAM_AW{s323}} & s166);
        assign fill_data = ({256{s320}} & {s26,s25,s24,s23}) | ({256{s321}} & {s74,s73,s72,s71}) | ({256{s322}} & {s122,s121,s120,s119}) | ({256{s323}} & {s170,s169,s168,s167});
        kv_ic_ctrl #(
            .PALEN(PALEN),
            .TAG_RAM_AW(TAG_RAM_AW),
            .TAG_RAM_DW(TAG_RAM_DW),
            .DATA_RAM_DW(DATA_RAM_DW),
            .DATA_RAM_AW(DATA_RAM_AW),
            .INDEX_WIDTH(INDEX_WIDTH),
            .OFFSET_WIDTH(OFFSET_WIDTH),
            .ICACHE_WAY(ICACHE_WAY),
            .ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
            .ICACHE_TAG_ECC_DW(ICACHE_TAG_ECC_DW)
        ) u_kv_ic_ctrl (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .pf_ecc_wr(pf_ecc_wr),
            .pf_wecccode(pf_wecccode),
            .pf_tag_index(pf_tag_index),
            .pf_tag_we(pf_tag_we),
            .pf_tag_way(pf_tag_way),
            .pf_tag_wdata(pf_tag_wdata),
            .pf_data_index(pf_data_index),
            .pf_ram_offset(pf_ram_offset),
            .pf_ram_rd_word(pf_ram_rd_word),
            .pf_data_we(pf_data_we),
            .pf_data_way(pf_data_way),
            .pf_data_wdata(pf_data_wdata),
            .fill2cache(fill2cache),
            .fill_data(fill_data),
            .fill_way(fill_way),
            .fill_index(fill_index),
            .f1_pa(ifu_icu_f1_pa),
            .f1_same_line_hit_way(f1_same_line_hit_way),
            .f2_ecc_error_way(f2_ecc_error_way),
            .f2_ecc_ramid(f2_ecc_ramid),
            .f2_ecc_corr(f2_ecc_corr),
            .f2_ecc_code(f2_ecc_code),
            .f2_hit(s0),
            .f2_hit_way(f2_hit_way),
            .f2_lock_way(f2_lock_way),
            .f2_valid_way(f2_valid_way),
            .f2_hit_data(s1),
            .f2_hit_tag(f2_hit_tag),
            .f2_tag_rdata(f2_tag_rdata),
            .f2_data_rdata(f2_data_rdata),
            .f2_recccode(f2_recccode),
            .icache_tag0_cs(icache_tag0_cs),
            .icache_tag0_wdata(icache_tag0_wdata),
            .icache_tag0_rdata(icache_tag0_rdata),
            .icache_tag0_we(icache_tag0_we),
            .icache_tag0_addr(icache_tag0_addr),
            .icache_data0_cs(icache_data0_cs),
            .icache_data0_wdata(icache_data0_wdata),
            .icache_data0_we(icache_data0_we),
            .icache_data0_addr(icache_data0_addr),
            .icache_data0_rdata(icache_data0_rdata),
            .icache_tag1_cs(icache_tag1_cs),
            .icache_tag1_wdata(icache_tag1_wdata),
            .icache_tag1_rdata(icache_tag1_rdata),
            .icache_tag1_we(icache_tag1_we),
            .icache_tag1_addr(icache_tag1_addr),
            .icache_data1_cs(icache_data1_cs),
            .icache_data1_wdata(icache_data1_wdata),
            .icache_data1_we(icache_data1_we),
            .icache_data1_addr(icache_data1_addr),
            .icache_data1_rdata(icache_data1_rdata),
            .icache_tag2_cs(icache_tag2_cs),
            .icache_tag2_wdata(icache_tag2_wdata),
            .icache_tag2_rdata(icache_tag2_rdata),
            .icache_tag2_we(icache_tag2_we),
            .icache_tag2_addr(icache_tag2_addr),
            .icache_data2_cs(icache_data2_cs),
            .icache_data2_wdata(icache_data2_wdata),
            .icache_data2_we(icache_data2_we),
            .icache_data2_addr(icache_data2_addr),
            .icache_data2_rdata(icache_data2_rdata),
            .icache_tag3_cs(icache_tag3_cs),
            .icache_tag3_wdata(icache_tag3_wdata),
            .icache_tag3_rdata(icache_tag3_rdata),
            .icache_tag3_we(icache_tag3_we),
            .icache_tag3_addr(icache_tag3_addr),
            .icache_data3_cs(icache_data3_cs),
            .icache_data3_wdata(icache_data3_wdata),
            .icache_data3_we(icache_data3_we),
            .icache_data3_addr(icache_data3_addr),
            .icache_data3_rdata(icache_data3_rdata),
            .icache_data4_cs(icache_data4_cs),
            .icache_data4_wdata(icache_data4_wdata),
            .icache_data4_we(icache_data4_we),
            .icache_data4_addr(icache_data4_addr),
            .icache_data4_rdata(icache_data4_rdata),
            .icache_data5_cs(icache_data5_cs),
            .icache_data5_wdata(icache_data5_wdata),
            .icache_data5_we(icache_data5_we),
            .icache_data5_addr(icache_data5_addr),
            .icache_data5_rdata(icache_data5_rdata),
            .icache_data6_cs(icache_data6_cs),
            .icache_data6_wdata(icache_data6_wdata),
            .icache_data6_we(icache_data6_we),
            .icache_data6_addr(icache_data6_addr),
            .icache_data6_rdata(icache_data6_rdata),
            .icache_data7_cs(icache_data7_cs),
            .icache_data7_wdata(icache_data7_wdata),
            .icache_data7_we(icache_data7_we),
            .icache_data7_addr(icache_data7_addr),
            .icache_data7_rdata(icache_data7_rdata)
        );
    end
    else begin:gen_ic_ctrl_no
        wire nds_unused_ic_ctrl_no = (|icache_data0_rdata) | (|icache_data1_rdata) | (|icache_data2_rdata) | (|icache_data3_rdata) | (|icache_data4_rdata) | (|icache_data5_rdata) | (|icache_data6_rdata) | (|icache_data7_rdata) | (|icache_tag0_rdata) | (|icache_tag1_rdata) | (|icache_tag2_rdata) | (|icache_tag3_rdata) | ifu_icu_req_wecc | (|ifu_icu_req_wdata) | (|s167) | (|f1_same_line_hit_way) | (|s23) | (|s24) | (|s25) | (|s26) | (|s71) | (|s72) | (|s73) | (|s74) | (|s119) | (|s120) | (|s121) | (|s122) | (|s167) | (|s168) | (|s169) | (|s170) | s165 | s117 | s69 | s21 | (|s164) | (|s116) | (|s68) | (|s20) | s163 | s115 | s67 | s19 | (|s166) | (|s118) | (|s70) | (|s22);
        assign f2_ecc_error_way = 4'b0;
        assign f2_ecc_ramid = 1'b0;
        assign f2_ecc_corr = 1'b0;
        assign f2_ecc_code = 8'b0;
        assign f2_recccode = 8'b0;
        assign s0 = 1'b0;
        assign f2_hit_way = 4'b0;
        assign f2_lock_way = 4'b0;
        assign f2_valid_way = 4'b0;
        assign s1 = 64'b0;
        assign f2_hit_tag = {NO_ECC_TAG_DW{1'b0}};
        assign f2_tag_rdata = 64'b0;
        assign f2_data_rdata = 64'b0;
        assign icache_tag0_cs = 1'b0;
        assign icache_tag0_we = 1'b0;
        assign icache_tag0_addr = {TAG_RAM_AW{1'b0}};
        assign icache_tag0_wdata = {TAG_RAM_DW{1'b0}};
        assign icache_tag1_cs = 1'b0;
        assign icache_tag1_we = 1'b0;
        assign icache_tag1_addr = {TAG_RAM_AW{1'b0}};
        assign icache_tag1_wdata = {TAG_RAM_DW{1'b0}};
        assign icache_tag2_cs = 1'b0;
        assign icache_tag2_we = 1'b0;
        assign icache_tag2_addr = {TAG_RAM_AW{1'b0}};
        assign icache_tag2_wdata = {TAG_RAM_DW{1'b0}};
        assign icache_tag3_cs = 1'b0;
        assign icache_tag3_we = 1'b0;
        assign icache_tag3_addr = {TAG_RAM_AW{1'b0}};
        assign icache_tag3_wdata = {TAG_RAM_DW{1'b0}};
        assign icache_data0_cs = 1'b0;
        assign icache_data0_we = 1'b0;
        assign icache_data0_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data0_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data1_cs = 1'b0;
        assign icache_data1_we = 1'b0;
        assign icache_data1_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data1_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data2_cs = 1'b0;
        assign icache_data2_we = 1'b0;
        assign icache_data2_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data2_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data3_cs = 1'b0;
        assign icache_data3_we = 1'b0;
        assign icache_data3_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data3_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data4_cs = 1'b0;
        assign icache_data4_we = 1'b0;
        assign icache_data4_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data4_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data5_cs = 1'b0;
        assign icache_data5_we = 1'b0;
        assign icache_data5_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data5_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data6_cs = 1'b0;
        assign icache_data6_we = 1'b0;
        assign icache_data6_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data6_wdata = {DATA_RAM_DW{1'b0}};
        assign icache_data7_cs = 1'b0;
        assign icache_data7_we = 1'b0;
        assign icache_data7_addr = {DATA_RAM_AW{1'b0}};
        assign icache_data7_wdata = {DATA_RAM_DW{1'b0}};
        assign fill2cache = 1'b0;
        assign s273 = 1'b0;
    end
endgenerate
generate
    if (ICACHE_SIZE_KB != 0) begin:gen_lru_yes
        wire [2:0] lru_rdata;
        reg [2:0] s324;
        wire s325;
        wire s326;
        wire [TAG_RAM_AW - 1:0] lru_raddr;
        wire s327;
        wire [TAG_RAM_AW - 1:0] lru_waddr;
        wire [3:0] s328;
        wire [2:0] s329;
        wire [TAG_RAM_AW - 1:0] fb_alloc_index;
        assign fb_alloc_index = ifu_icu_line_aq_index;
        assign s327 = (s221 & ~s224[2] & s205 & (|f2_hit_way)) | (fb_alloc & ifu_icu_line_aq_attri[0]);
        assign lru_waddr = ifu_icu_line_aq ? fb_alloc_index : s225[INDEX_MSB:INDEX_LSB];
        assign s328 = ifu_icu_line_aq ? s272 : f2_hit_way;
        assign s329 = s324;
        assign s326 = (s206 & ~s208[2]) & s211;
        assign lru_raddr = s209[INDEX_MSB:INDEX_LSB];
        assign s325 = s326;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s324 <= 3'b0;
            end
            else if (s325) begin
                s324 <= lru_rdata;
            end
        end

        assign s299 = s324;
        kv_lru #(
            .TAG_AW(TAG_RAM_AW),
            .LRU_INT(ICACHE_LRU_INT),
            .WAY(ICACHE_WAY)
        ) kv_icu_lru (
            .lru_write(s327),
            .lru_waddr(lru_waddr),
            .lru_way_hit(s328),
            .lru_ori_lru(s329),
            .lru_read(s326),
            .lru_raddr(lru_raddr),
            .lru_rdata(lru_rdata),
            .core_clk(core_clk),
            .core_reset_n(core_reset_n)
        );
    end
    else begin:gen_lru_no
        assign s299 = 3'b0;
    end
endgenerate
assign icu_ifu_bus_req_full = ~s3 & ~s51 & ~s99 & ~s147;
assign s198 = s197 + {2'b0,s196} - {2'b0,s194};
assign s199 = s196 | s194;
assign s290 = s202 & s240;
assign s291 = ifu_icu_kill | s201 | icu_ifu_line_aq_done | ~ifu_icu_line_aq;
assign s292 = (s290 | s289) & ~s291;
assign s293 = s290 | s291;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s289 <= 1'b0;
    end
    else if (s293) begin
        s289 <= s292;
    end
end

assign icu_ifu_bus_req_event = agent_a_valid & agent_a_ready & s257 & ~s284 & ~s289;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s197 <= 3'b0;
    end
    else if (s199) begin
        s197 <= s198;
    end
end

assign s196 = agent_a_valid & agent_a_ready;
assign s195 = s275 & (agent_d_corrupt | agent_d_denied | agent_d_user[1]);
assign s194 = s31 | s79 | s127 | s175;
assign agent_d_ready = ~(s32 & (s263[1:0] == 2'b00)) & ~(s80 & (s263[1:0] == 2'b01)) & ~(s128 & (s263[1:0] == 2'b10)) & ~(s176 & (s263[1:0] == 2'b11));
assign s28 = (s263[1:0] == 2'b00) & agent_d_valid;
assign s76 = (s263[1:0] == 2'b01) & agent_d_valid;
assign s124 = (s263[1:0] == 2'b10) & agent_d_valid;
assign s172 = (s263[1:0] == 2'b11) & agent_d_valid;
assign s29 = {256{(s263[1:0] == 2'b00)}} & agent_d_data;
assign s77 = {256{(s263[1:0] == 2'b01)}} & agent_d_data;
assign s125 = {256{(s263[1:0] == 2'b10)}} & agent_d_data;
assign s173 = {256{(s263[1:0] == 2'b11)}} & agent_d_data;
assign s30 = (s263[1:0] == 2'b00) & s195;
assign s78 = (s263[1:0] == 2'b01) & s195;
assign s126 = (s263[1:0] == 2'b10) & s195;
assign s174 = (s263[1:0] == 2'b11) & s195;
assign s256 = (s197 == 3'b0);
assign s267 = s265 & ~fill2cache & s201;
assign icu_ifu_line_op_req_done = s267 | (fb_force_fill & ~s2 & ~s50 & ~s98 & ~s146);
assign icu_standby_ready = s256 & ~s18 & ~s66 & ~s114 & ~s162;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s265 <= 1'b0;
    end
    else begin
        s265 <= s201;
    end
end

assign s266 = s201 & ~s265;
assign s17 = s266;
assign s65 = s266;
assign s113 = s266;
assign s161 = s266;
assign fb_aq_hit = s48 | s96 | s144 | s192;
assign s202 = s49 | s97 | s145 | s193;
kv_pma2axcache u_axcache(
    .c2nc(1'b0),
    .pma_mtype(ifu_icu_line_aq_attri[1 +:4]),
    .arcache(fb_alloc_arcache),
    .awcache(s260)
);
assign s259 = ({2{s9}} & 2'b00) | ({2{s57}} & 2'b01) | ({2{s105}} & 2'b10) | ({2{s153}} & 2'b11);
assign s9 = ifu_icu_line_aq & ~fb_aq_hit & ~s202 & s3;
assign s57 = ifu_icu_line_aq & ~fb_aq_hit & ~s202 & ~s3 & s51;
assign s105 = ifu_icu_line_aq & ~fb_aq_hit & ~s202 & ~s3 & ~s51 & s99;
assign s153 = ifu_icu_line_aq & ~fb_aq_hit & ~s202 & ~s3 & ~s51 & ~s99 & s147;
assign fb_alloc = s9 | s57 | s105 | s153;
assign s10 = ifu_icu_line_aq_addr;
assign s58 = ifu_icu_line_aq_addr;
assign s106 = ifu_icu_line_aq_addr;
assign s154 = ifu_icu_line_aq_addr;
assign s14 = ifu_icu_line_aq_attri[0];
assign s62 = ifu_icu_line_aq_attri[0];
assign s110 = ifu_icu_line_aq_attri[0];
assign s158 = ifu_icu_line_aq_attri[0];
assign s16 = fb_alloc_arcache;
assign s63 = fb_alloc_arcache;
assign s111 = fb_alloc_arcache;
assign s159 = fb_alloc_arcache;
assign s11 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s59 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s107 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s155 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s12 = ifu_icu_line_aq_index;
assign s60 = ifu_icu_line_aq_index;
assign s108 = ifu_icu_line_aq_index;
assign s156 = ifu_icu_line_aq_index;
assign s13 = ifu_icu_line_aq_attri[0] ? ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB] : {OFFSET_WIDTH{1'b0}};
assign s61 = ifu_icu_line_aq_attri[0] ? ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB] : {OFFSET_WIDTH{1'b0}};
assign s109 = ifu_icu_line_aq_attri[0] ? ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB] : {OFFSET_WIDTH{1'b0}};
assign s157 = ifu_icu_line_aq_attri[0] ? ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB] : {OFFSET_WIDTH{1'b0}};
assign s270 = (((&s268) ? 4'b0 : s268) & {4{(ICACHE_WAY == 4)}}) | (((&s268[1:0]) ? 4'b0 : s268) & {4{(ICACHE_WAY == 2)}}) | s269;
assign s298 = ifu_icu_line_aq_attri[14 +:3];
assign s271[2] = (&s270[3:2]) ? 1'b0 : (&s270[1:0]) ? 1'b1 : s298[2];
assign s271[1] = s270[3] ? 1'b0 : s270[2] ? 1'b1 : s298[1];
assign s271[0] = s270[1] ? 1'b0 : s270[0] ? 1'b1 : s298[0];
assign s272[3] = s271[2] & s271[1];
assign s272[2] = s271[2] & ~s271[1];
assign s272[1] = ~s271[2] & s271[0];
assign s272[0] = ~s271[2] & ~s271[0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s268 <= 4'b0;
        s269 <= 4'b0;
    end
    else begin
        s268 <= ifu_icu_line_aq_attri[6 +:4];
        s269 <= ifu_icu_line_aq_attri[10 +:4];
    end
end

assign fb_alloc_way = s272[0] ? 2'b00 : s272[1] ? 2'b01 : s272[2] ? 2'b10 : 2'b11;
assign s15 = fb_alloc_way;
assign s64 = fb_alloc_way;
assign s112 = fb_alloc_way;
assign s160 = fb_alloc_way;
assign s257 = (s297 == 2'b00) ? s6 : (s297 == 2'b01) ? s54 : (s297 == 2'b10) ? s102 : s150;
assign s258 = s297;
assign s262 = (s297 == 2'b00) ? s5 : (s297 == 2'b01) ? s53 : (s297 == 2'b10) ? s101 : s149;
assign agent_a_address = s257 ? {s262[PALEN - 1:6],6'b0} : {s262[PALEN - 1:3],3'b0};
assign agent_a_opcode = 3'd4;
assign s261 = (s257 == 1'b0) ? 3'd3 : 3'd6;
kv_zero_ext #(
    .OW(TL_SIZE_WIDTH),
    .IW(3)
) u_a_size_data_ext (
    .out(agent_a_size),
    .in(s261)
);
assign agent_a_param = {3{1'b0}};
assign agent_a_corrupt = 1'b0;
assign agent_a_valid = (s4 | s52 | s100 | s148) & (s197 != FB_DEPTH) & ~fb_force_fill & ~s283;
assign agent_a_source = s258[ICU_SOURCE_WIDTH - 1:0];
assign agent_a_data = 256'b0;
assign agent_a_mask[7:0] = {8{agent_a_address[4:3] == 2'b0}};
assign agent_a_mask[15:8] = {8{(agent_a_address[4:3] == 2'b01) | s257}};
assign agent_a_mask[23:16] = {8{(agent_a_address[4:3] == 2'b10) | s257}};
assign agent_a_mask[31:24] = {8{(agent_a_address[4:3] == 2'b11) | s257}};
assign agent_a_user[0] = cur_privilege_m | cur_privilege_s;
assign agent_a_user[1] = cur_privilege_s | cur_privilege_u;
assign agent_a_user[2] = 1'b1;
assign agent_a_user[3 +:4] = (s297 == 2'b00) ? s7 : (s297 == 2'b01) ? s55 : (s297 == 2'b10) ? s103 : s151;
assign agent_a_user[7] = 1'd0;
assign s8 = (s197 != FB_DEPTH) & (s297 == 2'b00) & agent_a_ready & ~s283;
assign s56 = (s197 != FB_DEPTH) & (s297 == 2'b01) & agent_a_ready & ~s283;
assign s104 = (s197 != FB_DEPTH) & (s297 == 2'b10) & agent_a_ready & ~s283;
assign s152 = (s197 != FB_DEPTH) & (s297 == 2'b11) & agent_a_ready & ~s283;
assign s33 = (s206 & ~s208[2]);
assign s81 = (s206 & ~s208[2]);
assign s129 = (s206 & ~s208[2]);
assign s177 = (s206 & ~s208[2]);
assign s34 = (s208[2:0] == 3'b1);
assign s82 = (s208[2:0] == 3'b1);
assign s130 = (s208[2:0] == 3'b1);
assign s178 = (s208[2:0] == 3'b1);
assign s43 = (ifu_icu_line_aq);
assign s91 = (ifu_icu_line_aq);
assign s139 = (ifu_icu_line_aq);
assign s187 = (ifu_icu_line_aq);
assign s35 = ifu_icu_f1_pa[TAG_MSB:TAG_LSB];
assign s83 = ifu_icu_f1_pa[TAG_MSB:TAG_LSB];
assign s131 = ifu_icu_f1_pa[TAG_MSB:TAG_LSB];
assign s179 = ifu_icu_f1_pa[TAG_MSB:TAG_LSB];
assign s44 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s92 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s140 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s188 = ifu_icu_line_aq_addr[TAG_MSB:TAG_LSB];
assign s36 = ifu_icu_f1_pa[INDEX_MSB:INDEX_LSB];
assign s84 = ifu_icu_f1_pa[INDEX_MSB:INDEX_LSB];
assign s132 = ifu_icu_f1_pa[INDEX_MSB:INDEX_LSB];
assign s180 = ifu_icu_f1_pa[INDEX_MSB:INDEX_LSB];
assign s45 = ifu_icu_line_aq_addr[INDEX_MSB:INDEX_LSB];
assign s93 = ifu_icu_line_aq_addr[INDEX_MSB:INDEX_LSB];
assign s141 = ifu_icu_line_aq_addr[INDEX_MSB:INDEX_LSB];
assign s189 = ifu_icu_line_aq_addr[INDEX_MSB:INDEX_LSB];
assign s37 = ifu_icu_f1_pa[OFFSET_MSB:OFFSET_LSB];
assign s85 = ifu_icu_f1_pa[OFFSET_MSB:OFFSET_LSB];
assign s133 = ifu_icu_f1_pa[OFFSET_MSB:OFFSET_LSB];
assign s181 = ifu_icu_f1_pa[OFFSET_MSB:OFFSET_LSB];
assign s46 = ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB];
assign s94 = ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB];
assign s142 = ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB];
assign s190 = ifu_icu_line_aq_addr[OFFSET_MSB:OFFSET_LSB];
assign s38 = ifu_icu_f1_pa;
assign s86 = ifu_icu_f1_pa;
assign s134 = ifu_icu_f1_pa;
assign s182 = ifu_icu_f1_pa;
assign s47 = ifu_icu_line_aq_addr;
assign s95 = ifu_icu_line_aq_addr;
assign s143 = ifu_icu_line_aq_addr;
assign s191 = ifu_icu_line_aq_addr;
assign s19 = ~s75 & ~s123 & ~s171;
assign s67 = (~s18 & ~s123 & ~s171) | s75;
assign s115 = (~s18 & ~s66 & ~s171) | s123;
assign s163 = (~s18 & ~s66 & ~s114) | s171;
assign s294 = s277 - 2'b1;
assign s295 = s276[s294];
assign s297 = s276[s277];
assign s296 = ((s295 == 2'b00) & s41 & (ifu_icu_req_type == 3'b0)) | ((s295 == 2'b01) & s89 & (ifu_icu_req_type == 3'b0)) | ((s295 == 2'b10) & s137 & (ifu_icu_req_type == 3'b0)) | ((s295 == 2'b11) & s185 & (ifu_icu_req_type == 3'b0));
assign s285 = ((agent_a_valid & agent_a_ready) | (s240 & ~fb_alloc)) & ~ifu_icu_kill & ~s240;
assign s286 = s296 | ifu_icu_kill | s240;
assign s287 = (s283 & ~s286) | s285;
assign s288 = s285 | s286;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s283 <= 1'b0;
    end
    else if (s288) begin
        s283 <= s287;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s284 <= 1'b0;
    end
    else begin
        s284 <= s283;
    end
end

integer s330;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        for (s330 = 0; s330 < 4; s330 = s330 + 1) begin
            s276[s330] <= 2'b0;
        end
    end
    else if (s240) begin
        s276[0] <= s243;
    end
    else if (fb_alloc) begin
        s276[0] <= s276[0];
        s276[1] <= (s280 == 2'd1) ? s259 : s276[1];
        s276[2] <= (s280 == 2'd2) ? s259 : s276[2];
        s276[3] <= (s280 == 2'd3) ? s259 : s276[3];
    end
end

assign s282 = ifu_icu_kill | s240 | fb_alloc;
assign s281 = ifu_icu_kill ? 2'b0 : s240 ? 2'b1 : s280 + 2'b1;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s280 <= 2'b0;
    end
    else if (s282) begin
        s280 <= s281;
    end
end

assign s279 = ifu_icu_kill | s240 | (agent_a_valid & agent_a_ready);
assign s278 = (ifu_icu_kill | (s240 & fb_alloc)) ? 2'b0 : s240 ? 2'b1 : s277 + 2'b1;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s277 <= 2'b0;
    end
    else if (s279) begin
        s277 <= s278;
    end
end

assign fb_force_fill = s200;
kv_fb #(
    .PALEN(PALEN),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .TAG_WIDTH(TAG_WIDTH),
    .INDEX_WIDTH(INDEX_WIDTH),
    .OFFSET_WIDTH(OFFSET_WIDTH)
) u_kv_fb0 (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .ifu_icu_kill(ifu_icu_kill),
    .icu_miss_flush(s240),
    .fb_force_fill(fb_force_fill),
    .fb_bus_req_valid(s4),
    .fb_bus_req_pa(s5),
    .fb_bus_req_cacheability(s6),
    .fb_bus_req_arcache(s7),
    .fb_bus_req_ready(s8),
    .fb_valid(s2),
    .fb_available(s3),
    .fb_alloc(s9),
    .fb_alloc_pa(s10),
    .fb_alloc_tag(s11),
    .fb_alloc_index(s12),
    .fb_alloc_offset(s13),
    .fb_alloc_fillable(s14),
    .fb_alloc_arcache(s16),
    .fb_alloc_way(s15),
    .fb_invalidate(s17),
    .fb_wr(s28),
    .fb_wr_wait(s32),
    .fb_wr_data(s29),
    .fb_wr_error(s30),
    .fb_wr_last(s31),
    .fb_fill_valid(s18),
    .fb_fill_ready(s19),
    .fb_fill_way(s20),
    .fb_fill_tag(s21),
    .fb_fill_index(s22),
    .fb_fill_data0(s23),
    .fb_fill_data1(s24),
    .fb_fill_data2(s25),
    .fb_fill_data3(s26),
    .fb_fill_last(s27),
    .fb_aq_rd(s43),
    .fb_aq_rd_tag(s44),
    .fb_aq_rd_index(s45),
    .fb_aq_rd_offset(s46),
    .fb_aq_rd_pa(s47),
    .fb_aq_wait_crit_word(s49),
    .fb_aq_hit(s48),
    .fb_f1_rd(s33),
    .fb_f1_rd_prefetch(s34),
    .fb_f1_rd_tag(s35),
    .fb_f1_rd_index(s36),
    .fb_f1_rd_offset(s37),
    .fb_f1_rd_pa(s38),
    .fb_f1_rd_data(s39),
    .fb_f1_rd_error(s40),
    .fb_f1_wait_crit_word(s42),
    .fb_f1_hit(s41)
);
generate
    if (FB_DEPTH != 3'b001) begin:gen_fb1_yes
        kv_fb #(
            .PALEN(PALEN),
            .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
            .TAG_WIDTH(TAG_WIDTH),
            .INDEX_WIDTH(INDEX_WIDTH),
            .OFFSET_WIDTH(OFFSET_WIDTH)
        ) u_kv_fb1 (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ifu_icu_kill(ifu_icu_kill),
            .icu_miss_flush(s240),
            .fb_force_fill(fb_force_fill),
            .fb_bus_req_valid(s52),
            .fb_bus_req_pa(s53),
            .fb_bus_req_cacheability(s54),
            .fb_bus_req_arcache(s55),
            .fb_bus_req_ready(s56),
            .fb_valid(s50),
            .fb_available(s51),
            .fb_alloc(s57),
            .fb_alloc_pa(s58),
            .fb_alloc_tag(s59),
            .fb_alloc_index(s60),
            .fb_alloc_offset(s61),
            .fb_alloc_fillable(s62),
            .fb_alloc_arcache(s63),
            .fb_alloc_way(s64),
            .fb_invalidate(s65),
            .fb_wr(s76),
            .fb_wr_wait(s80),
            .fb_wr_data(s77),
            .fb_wr_error(s78),
            .fb_wr_last(s79),
            .fb_fill_valid(s66),
            .fb_fill_ready(s67),
            .fb_fill_way(s68),
            .fb_fill_tag(s69),
            .fb_fill_index(s70),
            .fb_fill_data0(s71),
            .fb_fill_data1(s72),
            .fb_fill_data2(s73),
            .fb_fill_data3(s74),
            .fb_fill_last(s75),
            .fb_aq_rd(s91),
            .fb_aq_rd_tag(s92),
            .fb_aq_rd_index(s93),
            .fb_aq_rd_offset(s94),
            .fb_aq_rd_pa(s95),
            .fb_aq_wait_crit_word(s97),
            .fb_aq_hit(s96),
            .fb_f1_rd(s81),
            .fb_f1_rd_prefetch(s82),
            .fb_f1_rd_tag(s83),
            .fb_f1_rd_index(s84),
            .fb_f1_rd_offset(s85),
            .fb_f1_rd_pa(s86),
            .fb_f1_rd_data(s87),
            .fb_f1_rd_error(s88),
            .fb_f1_wait_crit_word(s90),
            .fb_f1_hit(s89)
        );
    end
    else begin:gen_fb1_no
        wire nds_unused_fb1_no = (|s59) | (|s58) | (|s60) | (|s61) | (|s63) | s62 | (|s64) | (|s95) | (|s92) | (|s93) | (|s94) | s91 | (|s83) | s82 | (|s86) | (|s84) | (|s85) | s78 | s76 | (|s77) | s56 | s65;
        assign s52 = 1'b0;
        assign s53 = {PALEN{1'b0}};
        assign s54 = 1'b0;
        assign s55 = 4'b0;
        assign s50 = 1'b0;
        assign s51 = 1'b0;
        assign s80 = 1'b0;
        assign s79 = 1'b0;
        assign s66 = 1'b0;
        assign s68 = 2'b0;
        assign s69 = {TAG_WIDTH{1'b0}};
        assign s70 = {INDEX_WIDTH{1'b0}};
        assign s71 = 64'b0;
        assign s72 = 64'b0;
        assign s73 = 64'b0;
        assign s74 = 64'b0;
        assign s75 = 1'b0;
        assign s97 = 1'b0;
        assign s96 = 1'b0;
        assign s87 = 64'b0;
        assign s88 = 1'b0;
        assign s90 = 1'b0;
        assign s89 = 1'b0;
    end
endgenerate
generate
    if ((FB_DEPTH != 3'b001) && (FB_DEPTH != 3'b010)) begin:gen_fb2_yes
        kv_fb #(
            .PALEN(PALEN),
            .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
            .TAG_WIDTH(TAG_WIDTH),
            .INDEX_WIDTH(INDEX_WIDTH),
            .OFFSET_WIDTH(OFFSET_WIDTH)
        ) u_kv_fb2 (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ifu_icu_kill(ifu_icu_kill),
            .icu_miss_flush(s240),
            .fb_force_fill(fb_force_fill),
            .fb_bus_req_valid(s100),
            .fb_bus_req_pa(s101),
            .fb_bus_req_cacheability(s102),
            .fb_bus_req_arcache(s103),
            .fb_bus_req_ready(s104),
            .fb_valid(s98),
            .fb_available(s99),
            .fb_alloc(s105),
            .fb_alloc_pa(s106),
            .fb_alloc_tag(s107),
            .fb_alloc_index(s108),
            .fb_alloc_offset(s109),
            .fb_alloc_fillable(s110),
            .fb_alloc_arcache(s111),
            .fb_alloc_way(s112),
            .fb_invalidate(s113),
            .fb_wr(s124),
            .fb_wr_wait(s128),
            .fb_wr_data(s125),
            .fb_wr_error(s126),
            .fb_wr_last(s127),
            .fb_fill_valid(s114),
            .fb_fill_ready(s115),
            .fb_fill_way(s116),
            .fb_fill_tag(s117),
            .fb_fill_index(s118),
            .fb_fill_data0(s119),
            .fb_fill_data1(s120),
            .fb_fill_data2(s121),
            .fb_fill_data3(s122),
            .fb_fill_last(s123),
            .fb_aq_rd(s139),
            .fb_aq_rd_tag(s140),
            .fb_aq_rd_index(s141),
            .fb_aq_rd_offset(s142),
            .fb_aq_rd_pa(s143),
            .fb_aq_wait_crit_word(s145),
            .fb_aq_hit(s144),
            .fb_f1_rd(s129),
            .fb_f1_rd_prefetch(s130),
            .fb_f1_rd_tag(s131),
            .fb_f1_rd_index(s132),
            .fb_f1_rd_offset(s133),
            .fb_f1_rd_pa(s134),
            .fb_f1_rd_data(s135),
            .fb_f1_rd_error(s136),
            .fb_f1_wait_crit_word(s138),
            .fb_f1_hit(s137)
        );
    end
    else begin:gen_fb2_no
        wire nds_unused_fb2_no = (|s107) | (|s106) | (|s108) | (|s109) | (|s111) | s110 | (|s112) | (|s143) | (|s140) | (|s141) | (|s142) | s139 | (|s131) | s130 | (|s134) | (|s132) | (|s133) | s126 | s124 | (|s125) | s104 | s113;
        assign s100 = 1'b0;
        assign s101 = {PALEN{1'b0}};
        assign s102 = 1'b0;
        assign s103 = 4'b0;
        assign s98 = 1'b0;
        assign s99 = 1'b0;
        assign s128 = 1'b0;
        assign s127 = 1'b0;
        assign s114 = 1'b0;
        assign s116 = 2'b0;
        assign s117 = {TAG_WIDTH{1'b0}};
        assign s118 = {INDEX_WIDTH{1'b0}};
        assign s119 = 64'b0;
        assign s120 = 64'b0;
        assign s121 = 64'b0;
        assign s122 = 64'b0;
        assign s123 = 1'b0;
        assign s145 = 1'b0;
        assign s144 = 1'b0;
        assign s135 = 64'b0;
        assign s136 = 1'b0;
        assign s138 = 1'b0;
        assign s137 = 1'b0;
    end
endgenerate
generate
    if ((FB_DEPTH == 3'b100)) begin:gen_fb3_yes
        kv_fb #(
            .PALEN(PALEN),
            .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
            .TAG_WIDTH(TAG_WIDTH),
            .INDEX_WIDTH(INDEX_WIDTH),
            .OFFSET_WIDTH(OFFSET_WIDTH)
        ) u_kv_fb3 (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ifu_icu_kill(ifu_icu_kill),
            .icu_miss_flush(s240),
            .fb_force_fill(fb_force_fill),
            .fb_bus_req_valid(s148),
            .fb_bus_req_pa(s149),
            .fb_bus_req_cacheability(s150),
            .fb_bus_req_arcache(s151),
            .fb_bus_req_ready(s152),
            .fb_valid(s146),
            .fb_available(s147),
            .fb_alloc(s153),
            .fb_alloc_pa(s154),
            .fb_alloc_tag(s155),
            .fb_alloc_index(s156),
            .fb_alloc_offset(s157),
            .fb_alloc_fillable(s158),
            .fb_alloc_arcache(s159),
            .fb_alloc_way(s160),
            .fb_invalidate(s161),
            .fb_wr(s172),
            .fb_wr_wait(s176),
            .fb_wr_data(s173),
            .fb_wr_error(s174),
            .fb_wr_last(s175),
            .fb_fill_valid(s162),
            .fb_fill_ready(s163),
            .fb_fill_way(s164),
            .fb_fill_tag(s165),
            .fb_fill_index(s166),
            .fb_fill_data0(s167),
            .fb_fill_data1(s168),
            .fb_fill_data2(s169),
            .fb_fill_data3(s170),
            .fb_fill_last(s171),
            .fb_aq_rd(s187),
            .fb_aq_rd_tag(s188),
            .fb_aq_rd_index(s189),
            .fb_aq_rd_offset(s190),
            .fb_aq_rd_pa(s191),
            .fb_aq_wait_crit_word(s193),
            .fb_aq_hit(s192),
            .fb_f1_rd(s177),
            .fb_f1_rd_prefetch(s178),
            .fb_f1_rd_tag(s179),
            .fb_f1_rd_index(s180),
            .fb_f1_rd_offset(s181),
            .fb_f1_rd_pa(s182),
            .fb_f1_rd_data(s183),
            .fb_f1_rd_error(s184),
            .fb_f1_wait_crit_word(s186),
            .fb_f1_hit(s185)
        );
    end
    else begin:gen_fb3_no
        wire nds_unused_fb3_no = (|s155) | (|s154) | (|s156) | (|s157) | (|s159) | s158 | (|s160) | (|s191) | (|s188) | (|s189) | (|s190) | s187 | (|s179) | s178 | (|s182) | (|s180) | (|s181) | s174 | s172 | (|s173) | s152 | s161;
        assign s148 = 1'b0;
        assign s149 = {PALEN{1'b0}};
        assign s150 = 1'b0;
        assign s151 = 4'b0;
        assign s146 = 1'b0;
        assign s147 = 1'b0;
        assign s176 = 1'b0;
        assign s175 = 1'b0;
        assign s162 = 1'b0;
        assign s164 = 2'b0;
        assign s165 = {TAG_WIDTH{1'b0}};
        assign s166 = {INDEX_WIDTH{1'b0}};
        assign s167 = 64'b0;
        assign s168 = 64'b0;
        assign s169 = 64'b0;
        assign s170 = 64'b0;
        assign s171 = 1'b0;
        assign s193 = 1'b0;
        assign s192 = 1'b0;
        assign s183 = 64'b0;
        assign s184 = 1'b0;
        assign s186 = 1'b0;
        assign s185 = 1'b0;
    end
endgenerate
assign s228 = s273;
assign icu_ifu_req_ready = ((ifu_icu_req_type == 3'b0) & ~fill2cache) | ((ifu_icu_req_type == 3'b1) & ~s228) | (ifu_icu_req_type[2] & ~fill2cache);
assign s214 = ifu_icu_req_valid & icu_ifu_req_ready & ~(ifu_icu_req_type[2] & ifu_icu_req_type[0]);
assign s207 = ifu_icu_req_valid & icu_ifu_req_ready & ~(ifu_icu_req_type[2] & ifu_icu_req_type[0]);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s206 <= 1'b0;
    end
    else begin
        s206 <= s207;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s208 <= 3'b0;
        s209 <= {VALEN{1'b0}};
        s210 <= 1'b0;
        s213 <= 1'b0;
        s211 <= 1'b0;
        s212 <= 2'b0;
    end
    else if (s214) begin
        s208 <= ifu_icu_req_type;
        s209 <= ifu_icu_req_addr;
        s210 <= ifu_icu_req_tag;
        s213 <= s274;
        s211 <= ifu_icu_req_nonseq;
        s212 <= ifu_icu_req_rd_word;
    end
end

assign s215 = s209[2:1];
assign s216 = (s215 == 2'b00) ? 4'b1111 : (s215 == 2'b01) ? 4'b0111 : (s215 == 2'b10) ? 4'b0011 : 4'b0001;
assign s217 = s41 | s89 | s137 | s185;
assign s218 = s42 | s90 | s138 | s186;
assign s219 = (s39 & {64{s41 & s33}}) | (s87 & {64{s89 & s81}}) | (s135 & {64{s137 & s129}}) | (s183 & {64{s185 & s177}});
assign s220 = (s40 & s33 & s41) | (s88 & s81 & s89) | (s136 & s129 & s137) | (s184 & s177 & s185);
assign s226 = s206 & ~ifu_icu_kill;
assign s222 = s206 & ~ifu_icu_kill;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s221 <= 1'b0;
    end
    else begin
        s221 <= s222;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s223 <= 1'b0;
        s224 <= 3'b0;
        s225 <= {VALEN{1'b0}};
        s227 <= 4'b0;
        s229 <= 1'b0;
        s230 <= 1'b0;
        s231 <= 64'b0;
        s232 <= 1'b0;
        s233 <= 2'b0;
    end
    else if (s226) begin
        s223 <= s210;
        s224 <= s208;
        s225 <= s209;
        s227 <= s216;
        s229 <= s217;
        s230 <= s218;
        s231 <= s219;
        s232 <= s220;
        s233 <= s212;
    end
end

assign s234 = s225[2:1];
kv_zero_ext #(
    .OW(2),
    .IW(ICU_SOURCE_WIDTH)
) u_agent_d_source_zext (
    .out(s263),
    .in(agent_d_source)
);
kv_zero_ext #(
    .OW(2),
    .IW(ICU_SOURCE_WIDTH)
) u_a_source_data_ext (
    .out(icu_a_source),
    .in(s264)
);
kv_icu_brg #(
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .ICU_DATA_WIDTH(256),
    .PALEN(PALEN),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .ICU_SOURCE_WIDTH(ICU_SOURCE_WIDTH),
    .TL_SIZE_WIDTH(TL_SIZE_WIDTH)
) u_icu_brg (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .agent_a_opcode(agent_a_opcode),
    .agent_a_param(agent_a_param),
    .agent_a_user(agent_a_user),
    .agent_a_size(agent_a_size),
    .agent_a_address(agent_a_address),
    .agent_a_data(agent_a_data),
    .agent_a_mask(agent_a_mask),
    .agent_a_corrupt(agent_a_corrupt),
    .agent_a_valid(agent_a_valid),
    .agent_a_ready(agent_a_ready),
    .agent_a_source(agent_a_source),
    .agent_d_opcode(agent_d_opcode),
    .agent_d_param(agent_d_param),
    .agent_d_user(agent_d_user),
    .agent_d_size(agent_d_size),
    .agent_d_data(agent_d_data),
    .agent_d_denied(agent_d_denied),
    .agent_d_corrupt(agent_d_corrupt),
    .agent_d_valid(agent_d_valid),
    .agent_d_ready(agent_d_ready),
    .agent_d_source(agent_d_source),
    .agent_d_sink(agent_d_sink),
    .icu_a_opcode(icu_a_opcode),
    .icu_a_param(icu_a_param),
    .icu_a_user(icu_a_user),
    .icu_a_size(icu_a_size),
    .icu_a_address(icu_a_address),
    .icu_a_data(icu_a_data),
    .icu_a_mask(icu_a_mask),
    .icu_a_corrupt(icu_a_corrupt),
    .icu_a_valid(icu_a_valid),
    .icu_a_ready(icu_a_ready),
    .icu_a_source(s264),
    .icu_d_opcode(icu_d_opcode),
    .icu_d_param(icu_d_param),
    .icu_d_user(icu_d_user),
    .icu_d_size(icu_d_size),
    .icu_d_data(icu_d_data),
    .icu_d_denied(icu_d_denied),
    .icu_d_corrupt(icu_d_corrupt),
    .icu_d_valid(icu_d_valid),
    .icu_d_ready(icu_d_ready),
    .icu_d_source(icu_d_source[(ICU_SOURCE_WIDTH - 1):0]),
    .icu_d_sink(icu_d_sink)
);
endmodule

