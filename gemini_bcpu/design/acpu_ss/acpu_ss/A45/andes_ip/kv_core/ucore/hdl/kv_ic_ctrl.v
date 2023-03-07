// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ic_ctrl (
    core_clk,
    core_reset_n,
    pf_ecc_wr,
    pf_wecccode,
    pf_tag_index,
    pf_tag_we,
    pf_tag_way,
    pf_tag_wdata,
    pf_data_index,
    pf_ram_offset,
    pf_ram_rd_word,
    pf_data_we,
    pf_data_way,
    pf_data_wdata,
    fill2cache,
    fill_data,
    fill_way,
    fill_index,
    f1_pa,
    f1_same_line_hit_way,
    f2_ecc_error_way,
    f2_ecc_ramid,
    f2_ecc_corr,
    f2_ecc_code,
    f2_hit,
    f2_hit_way,
    f2_lock_way,
    f2_valid_way,
    f2_hit_data,
    f2_hit_tag,
    f2_tag_rdata,
    f2_data_rdata,
    f2_recccode,
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
parameter PALEN = 32;
parameter TAG_RAM_AW = 9;
parameter TAG_RAM_DW = 26;
parameter DATA_RAM_DW = 64;
parameter DATA_RAM_AW = 11;
parameter ICACHE_WAY = 2;
parameter ECC_TYPE_INT = 0;
parameter ICACHE_TAG_ECC_DW = 7;
parameter OFFSET_WIDTH = 3;
parameter INDEX_WIDTH = 8;
localparam TAG_ECC_DW = ICACHE_TAG_ECC_DW;
localparam NO_ECC_TAG_DW = TAG_RAM_DW - TAG_ECC_DW;
localparam TAG_WIDTH = NO_ECC_TAG_DW - 3;
localparam TAG_MSB = PALEN - 1;
localparam TAG_LSB = TAG_MSB - TAG_WIDTH + 1;
localparam CACHE_VALID = NO_ECC_TAG_DW - 1;
localparam CACHE_LOCK = NO_ECC_TAG_DW - 2;
localparam CACHE_LOCK_DUP = NO_ECC_TAG_DW - 3;
localparam DATA_INDEX_WIDTH = OFFSET_WIDTH + INDEX_WIDTH;
input core_clk;
input core_reset_n;
input pf_ecc_wr;
input [7:0] pf_wecccode;
input [INDEX_WIDTH - 1:0] pf_tag_index;
input pf_tag_we;
input [3:0] pf_tag_way;
input [NO_ECC_TAG_DW - 1:0] pf_tag_wdata;
input [DATA_INDEX_WIDTH - 1:0] pf_data_index;
input pf_ram_offset;
input [1:0] pf_ram_rd_word;
input pf_data_we;
input [3:0] pf_data_way;
input [63:0] pf_data_wdata;
input fill2cache;
input [255:0] fill_data;
input [3:0] fill_way;
input [TAG_RAM_AW - 1:0] fill_index;
input [PALEN - 1:0] f1_pa;
input [3:0] f1_same_line_hit_way;
output [3:0] f2_ecc_error_way;
output f2_ecc_ramid;
output f2_ecc_corr;
output [7:0] f2_ecc_code;
output f2_hit;
output [3:0] f2_hit_way;
output [3:0] f2_lock_way;
output [3:0] f2_valid_way;
output [63:0] f2_hit_data;
output [NO_ECC_TAG_DW - 1:0] f2_hit_tag;
output [63:0] f2_tag_rdata;
output [63:0] f2_data_rdata;
output [7:0] f2_recccode;
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


wire s0 = 1'b1;
wire s1 = (ICACHE_WAY != 1);
wire s2 = (ICACHE_WAY == 4);
wire s3 = (ICACHE_WAY == 4);
wire s4 = ((ECC_TYPE_INT != 0));
wire s5 = (ICACHE_WAY == 1);
wire s6 = (ICACHE_WAY == 2);
wire s7 = (ICACHE_WAY == 4);
reg [3:0] s8;
reg s9;
reg [7:0] s10;
reg s11;
wire [3:0] s12;
wire s13;
wire [7:0] s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire [TAG_RAM_DW - 1:0] s19;
wire [TAG_RAM_DW - 1:0] s20;
wire [TAG_RAM_DW - 1:0] s21;
wire [TAG_RAM_DW - 1:0] s22;
wire [DATA_RAM_DW - 1:0] s23;
wire [DATA_RAM_DW - 1:0] s24;
wire [DATA_RAM_DW - 1:0] s25;
wire [DATA_RAM_DW - 1:0] s26;
wire [DATA_RAM_DW - 1:0] s27;
wire [DATA_RAM_DW - 1:0] s28;
wire [DATA_RAM_DW - 1:0] s29;
wire [DATA_RAM_DW - 1:0] s30;
reg [3:0] s31;
reg [7:0] s32;
reg s33;
wire [7:0] s34;
reg s35;
wire s36;
wire s37;
wire s38;
wire s39;
wire s40;
wire s41;
wire s42;
wire s43;
reg [3:0] s44;
wire [3:0] s45;
reg [3:0] f2_hit_way;
wire [3:0] s46;
wire [3:0] f2_lock_way;
wire [3:0] f2_valid_way;
wire s47;
wire s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire s53;
wire s54;
wire s55;
wire s56;
wire s57;
wire s58;
wire s59;
wire s60;
wire s61;
wire s62;
wire s63;
wire s64;
wire s65;
wire s66;
wire s67;
wire s68;
wire s69;
wire s70;
wire s71;
wire s72;
wire s73;
wire s74;
wire s75;
wire s76;
wire s77;
wire s78;
wire s79;
wire s80;
wire s81;
wire s82;
wire [TAG_RAM_DW - 1:0] s83;
wire [63:0] s84;
wire [63:0] s85;
wire [63:0] s86;
wire [63:0] s87;
wire [DATA_RAM_DW - 1:0] s88;
wire [DATA_RAM_DW - 1:0] s89;
wire [DATA_RAM_DW - 1:0] s90;
wire [DATA_RAM_DW - 1:0] s91;
wire [DATA_RAM_DW - 1:0] s92;
wire [DATA_RAM_DW - 1:0] s93;
wire [DATA_RAM_DW - 1:0] s94;
wire [DATA_RAM_DW - 1:0] s95;
wire s96;
wire s97;
wire s98;
wire s99;
wire s100;
wire s101;
wire s102;
wire s103;
wire s104;
wire s105;
wire s106;
wire s107;
wire s108;
wire s109;
wire s110;
wire s111;
wire [7:0] s112;
wire [7:0] s113;
wire [7:0] s114;
wire [7:0] s115;
wire [7:0] s116;
wire [7:0] s117;
wire [7:0] s118;
wire [7:0] s119;
wire [7:0] s120;
wire [7:0] s121;
wire [7:0] s122;
wire [7:0] s123;
wire [1:0] s124;
wire [1:0] s125;
reg [1:0] s126;
reg s127;
wire s128;
wire s129;
wire [DATA_RAM_AW - 1:0] s130;
wire [DATA_RAM_AW - 1:0] s131;
wire [DATA_RAM_AW - 1:0] s132;
wire [DATA_RAM_AW - 1:0] s133;
wire [DATA_RAM_AW - 1:0] s134;
wire [DATA_RAM_AW - 1:0] s135;
wire [DATA_RAM_AW - 1:0] s136;
wire [DATA_RAM_AW - 1:0] s137;
wire [DATA_RAM_AW - 1:0] s138;
wire [DATA_RAM_AW - 1:0] s139;
wire [DATA_RAM_AW - 1:0] s140;
wire [DATA_RAM_AW - 1:0] s141;
wire [63:0] s142;
wire [63:0] s143;
wire [63:0] s144;
wire [63:0] s145;
wire s146;
wire s147;
wire s148;
wire s149;
wire s150;
wire s151;
wire s152;
wire s153;
wire s154;
wire s155;
wire s156;
wire s157;
wire s158;
wire s159;
wire s160;
wire s161;
wire s162;
wire s163;
wire s164;
wire s165;
wire s166;
wire s167;
wire s168;
wire s169;
wire s170;
wire s171;
wire s172;
wire s173;
wire s174;
wire s175;
wire s176;
wire s177;
wire nds_unused_top = pf_ecc_wr | (|pf_wecccode);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s127 <= 1'b0;
    end
    else if (s129) begin
        s127 <= s128;
    end
end

assign s129 = fill2cache;
assign s128 = ~s127;
assign s146 = s5 | (~s126[1] & s6) | ((s126 == 2'd0) & s7);
assign s147 = ((s126[1]) & s6) | ((s126 == 2'd3) & s7);
assign s148 = (s126 == 2'd2) & s7;
assign s149 = (s126 == 2'd1) & s7;
assign s150 = s146;
assign s151 = s147;
assign s152 = s148;
assign s153 = s149;
assign s154 = s5 | ((~s126[1]) & s6) | ((s126 == 2'd1) & s7);
assign s155 = ((s126[1]) & s6) | ((s126 == 2'd0) & s7);
assign s156 = (s126 == 2'd3) & s7;
assign s157 = (s126 == 2'd2) & s7;
assign s158 = s154;
assign s159 = s155;
assign s160 = s156;
assign s161 = s157;
assign s162 = s5 | ((s126[1]) & s6) | ((s126 == 2'd2) & s7);
assign s163 = ((~s126[1]) & s6) | ((s126 == 2'd1) & s7);
assign s164 = (s126 == 2'd0) & s7;
assign s165 = (s126 == 2'd3) & s7;
assign s166 = s162;
assign s167 = s163;
assign s168 = s164;
assign s169 = s165;
assign s170 = s5 | ((s126[1]) & s6) | ((s126 == 2'd3) & s7);
assign s171 = ((~s126[1]) & s6) | ((s126 == 2'd2) & s7);
assign s172 = (s126 == 2'd1) & s7;
assign s173 = (s126 == 2'd0) & s7;
assign s174 = s170;
assign s175 = s171;
assign s176 = s172;
assign s177 = s173;
assign s125 = f1_pa[4:3];
assign f2_ecc_error_way[0] = s104 | (s96 & s146) | (s97 & s150) | (s98 & s154) | (s99 & s158) | (s100 & s162) | (s101 & s166) | (s102 & s170) | (s103 & s174);
assign f2_ecc_error_way[1] = (s105 | (s96 & s147) | (s97 & s151) | (s98 & s155) | (s99 & s159) | (s100 & s163) | (s101 & s167) | (s102 & s171) | (s103 & s175)) & (~s104 | s109);
assign f2_ecc_error_way[2] = (s106 | (s96 & s148) | (s97 & s152) | (s98 & s156) | (s99 & s160) | (s100 & s164) | (s101 & s168) | (s102 & s172) | (s103 & s176)) & (~s104 & ~s105 | s110);
assign f2_ecc_error_way[3] = (s107 | (s96 & s149) | (s97 & s153) | (s98 & s157) | (s99 & s161) | (s100 & s165) | (s101 & s169) | (s102 & s173) | (s103 & s177)) & (~s104 & ~s105 & ~s106 | s111);
assign f2_ecc_ramid = ~s104 & ~s105 & ~s106 & ~s107;
assign f2_ecc_corr = s104 ? s108 : s105 ? s109 : s106 ? s110 : s107 ? s111 : s96 ? s146 ? s108 : s147 ? s109 : s148 ? s110 : s111 : s97 ? s150 ? s108 : s151 ? s109 : s152 ? s110 : s111 : s98 ? s154 ? s108 : s155 ? s109 : s156 ? s110 : s111 : s99 ? s158 ? s108 : s159 ? s109 : s160 ? s110 : s111 : s100 ? s162 ? s108 : s163 ? s109 : s164 ? s110 : s111 : s101 ? s166 ? s108 : s167 ? s109 : s168 ? s110 : s111 : s102 ? s170 ? s108 : s171 ? s109 : s172 ? s110 : s111 : s174 ? s108 : s175 ? s109 : s176 ? s110 : s111;
assign f2_ecc_code = ~f2_ecc_ramid ? s104 ? s112 : s105 ? s113 : s106 ? s114 : s115 : s96 ? s116 : s97 ? s117 : s98 ? s118 : s99 ? s119 : s100 ? s120 : s101 ? s121 : s102 ? s122 : s123;
assign s40 = (icache_tag0_rdata[TAG_WIDTH - 1:0] == f1_pa[TAG_MSB:TAG_LSB]);
assign s41 = (icache_tag1_rdata[TAG_WIDTH - 1:0] == f1_pa[TAG_MSB:TAG_LSB]);
assign s42 = (icache_tag2_rdata[TAG_WIDTH - 1:0] == f1_pa[TAG_MSB:TAG_LSB]);
assign s43 = (icache_tag3_rdata[TAG_WIDTH - 1:0] == f1_pa[TAG_MSB:TAG_LSB]);
assign s36 = (icache_tag0_rdata[CACHE_VALID] & s40 & s15) | (f1_same_line_hit_way[0]);
assign s37 = (icache_tag1_rdata[CACHE_VALID] & s41 & s16) | (f1_same_line_hit_way[1]);
assign s38 = (icache_tag2_rdata[CACHE_VALID] & s42 & s17) | (f1_same_line_hit_way[2]);
assign s39 = (icache_tag3_rdata[CACHE_VALID] & s43 & s18) | (f1_same_line_hit_way[3]);
assign s45 = ({3'b0,s36} & {4{(s125[1:0] == 2'd0) & s5}}) | ({2'b0,s36,1'b0} & {4{(s125[1:0] == 2'd1) & s5}}) | ({1'b0,s36,2'b0} & {4{(s125[1:0] == 2'd2) & s5}}) | ({s36,3'b0} & {4{(s125[1:0] == 2'd3) & s5}}) | ({3'b0,s36} & {4{(s125[1:0] == 2'd0) & s6}}) | ({2'b0,s36,1'b0} & {4{(s125[1:0] == 2'd1) & s6}}) | ({1'b0,s36,2'b0} & {4{(s125[1:0] == 2'd2) & s6}}) | ({s36,3'b0} & {4{(s125[1:0] == 2'd3) & s6}}) | ({1'b0,s37,2'b0} & {4{(s125[1:0] == 2'd0) & s6}}) | ({s37,3'b0} & {4{(s125[1:0] == 2'd1) & s6}}) | ({3'b0,s37} & {4{(s125[1:0] == 2'd2) & s6}}) | ({2'b0,s37,1'b0} & {4{(s125[1:0] == 2'd3) & s6}}) | ({s39,s38,s37,s36} & {4{(s125 == 2'd0) & s7}}) | ({s38,s37,s36,s39} & {4{(s125 == 2'd1) & s7}}) | ({s37,s36,s39,s38} & {4{(s125 == 2'd2) & s7}}) | ({s36,s39,s38,s37} & {4{(s125 == 2'd3) & s7}});
assign s46 = {s39,s38,s37,s36};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s44 <= 4'b0;
        f2_hit_way <= 4'b0;
    end
    else begin
        s44 <= s45;
        f2_hit_way <= s46;
    end
end

assign f2_lock_way = {s22[CACHE_LOCK],s21[CACHE_LOCK],s20[CACHE_LOCK],s19[CACHE_LOCK]};
assign f2_valid_way = {s22[CACHE_VALID],s21[CACHE_VALID],s20[CACHE_VALID],s19[CACHE_VALID]};
assign f2_hit = (|f2_hit_way);
wire [31:0] s178;
wire [31:0] s179;
assign s178 = ({32{s32[0]}} & s23[31:0]) | ({32{s32[2]}} & s25[31:0]) | ({32{s32[4]}} & s27[31:0]) | ({32{s32[6]}} & s29[31:0]);
assign s179 = ({32{s32[1]}} & s24[31:0]) | ({32{s32[3]}} & s26[31:0]) | ({32{s32[5]}} & s28[31:0]) | ({32{s32[7]}} & s30[31:0]);
assign f2_data_rdata = {s179,s178};
assign f2_recccode = ({8{s32[0] & ~s33}} & s116) | ({8{s32[1] & s33}} & s117) | ({8{s32[2] & ~s33}} & s118) | ({8{s32[3] & s33}} & s119) | ({8{s32[4] & ~s33}} & s120) | ({8{s32[5] & s33}} & s121) | ({8{s32[6] & ~s33}} & s122) | ({8{s32[7] & s33}} & s123) | ({8{s31[0]}} & s112) | ({8{s31[1]}} & s113) | ({8{s31[2]}} & s114) | ({8{s31[3]}} & s115);
kv_zero_ext #(
    .OW(64),
    .IW(TAG_WIDTH)
) u_tag0_rdata_zext (
    .out(s142),
    .in(s19[TAG_WIDTH - 1:0])
);
kv_zero_ext #(
    .OW(64),
    .IW(TAG_WIDTH)
) u_tag1_rdata_zext (
    .out(s143),
    .in(s20[TAG_WIDTH - 1:0])
);
kv_zero_ext #(
    .OW(64),
    .IW(TAG_WIDTH)
) u_tag2_rdata_zext (
    .out(s144),
    .in(s21[TAG_WIDTH - 1:0])
);
kv_zero_ext #(
    .OW(64),
    .IW(TAG_WIDTH)
) u_tag3_rdata_zext (
    .out(s145),
    .in(s22[TAG_WIDTH - 1:0])
);
assign f2_tag_rdata = ({64{s31[0]}} & {s19[NO_ECC_TAG_DW - 1:NO_ECC_TAG_DW - 3],s142[60:0]}) | ({64{s31[1]}} & {s20[NO_ECC_TAG_DW - 1:NO_ECC_TAG_DW - 3],s143[60:0]}) | ({64{s31[2]}} & {s21[NO_ECC_TAG_DW - 1:NO_ECC_TAG_DW - 3],s144[60:0]}) | ({64{s31[3]}} & {s22[NO_ECC_TAG_DW - 1:NO_ECC_TAG_DW - 3],s145[60:0]});
assign f2_hit_tag = ({NO_ECC_TAG_DW{f2_hit_way[0]}} & s19[NO_ECC_TAG_DW - 1:0]) | ({NO_ECC_TAG_DW{f2_hit_way[1]}} & s20[NO_ECC_TAG_DW - 1:0]) | ({NO_ECC_TAG_DW{f2_hit_way[2]}} & s21[NO_ECC_TAG_DW - 1:0]) | ({NO_ECC_TAG_DW{f2_hit_way[3]}} & s22[NO_ECC_TAG_DW - 1:0]);
assign f2_hit_data = ({64{s44[0]}} & {s24[31:0],s23[31:0]}) | ({64{s44[1]}} & {s26[31:0],s25[31:0]}) | ({64{s44[2]}} & {s28[31:0],s27[31:0]}) | ({64{s44[3]}} & {s30[31:0],s29[31:0]});
assign s124 = pf_data_index[1:0];
assign s12 = pf_tag_way;
assign s13 = pf_tag_we;
assign s14 = {(s50 & pf_ram_rd_word[1]),(s50 & pf_ram_rd_word[0]),(s49 & pf_ram_rd_word[1]),(s49 & pf_ram_rd_word[0]),(s48 & pf_ram_rd_word[1]),(s48 & pf_ram_rd_word[0]),(s47 & pf_ram_rd_word[1]),(s47 & pf_ram_rd_word[0])};
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s8 <= 4'b0;
        s9 <= 1'b0;
        s10 <= 8'b0;
        s11 <= 1'b0;
    end
    else begin
        s8 <= s12;
        s9 <= s13;
        s10 <= s14;
        s11 <= pf_ram_offset;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s31 <= 4'b0;
        s32 <= 8'b0;
        s33 <= 1'b0;
        s126 <= 2'b0;
        s35 <= 1'b0;
    end
    else begin
        s31 <= {s18,s17,s16,s15};
        s32 <= s34;
        s33 <= s11;
        s126 <= s125;
        s35 <= s9;
    end
end

assign s34 = s10;
assign s15 = s0 & s8[0] & ~s9;
assign s16 = s1 & s8[1] & ~s9;
assign s17 = s2 & s8[2] & ~s9;
assign s18 = s3 & s8[3] & ~s9;
reg [DATA_RAM_DW - 1:0] s180;
wire s181;
assign s181 = s10[0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s180 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s181) begin
        s180 <= icache_data0_rdata;
    end
end

assign s23 = s180;
reg [DATA_RAM_DW - 1:0] s182;
wire s183;
assign s183 = s10[1];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s182 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s183) begin
        s182 <= icache_data1_rdata;
    end
end

assign s24 = s182;
reg [DATA_RAM_DW - 1:0] s184;
wire s185;
assign s185 = s10[2];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s184 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s185) begin
        s184 <= icache_data2_rdata;
    end
end

assign s25 = s184;
reg [DATA_RAM_DW - 1:0] s186;
wire s187;
assign s187 = s10[3];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s186 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s187) begin
        s186 <= icache_data3_rdata;
    end
end

assign s26 = s186;
reg [DATA_RAM_DW - 1:0] s188;
wire s189;
assign s189 = s10[4];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s188 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s189) begin
        s188 <= icache_data4_rdata;
    end
end

assign s27 = s188;
reg [DATA_RAM_DW - 1:0] s190;
wire s191;
assign s191 = s10[5];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s190 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s191) begin
        s190 <= icache_data5_rdata;
    end
end

assign s28 = s190;
reg [DATA_RAM_DW - 1:0] s192;
wire s193;
assign s193 = s10[6];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s192 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s193) begin
        s192 <= icache_data6_rdata;
    end
end

assign s29 = s192;
reg [DATA_RAM_DW - 1:0] s194;
wire s195;
assign s195 = s10[7];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s194 <= {DATA_RAM_DW{1'b0}};
    end
    else if (s195) begin
        s194 <= icache_data7_rdata;
    end
end

assign s30 = s194;
generate
    if (ICACHE_WAY > 0) begin:gen_way0_tag_on
        reg [TAG_RAM_DW - 1:0] s196;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s196 <= {TAG_RAM_DW{1'b0}};
            end
            else if (s15) begin
                s196 <= icache_tag0_rdata;
            end
        end

        assign s19 = s196;
    end
    else begin:gen_way0_tag_off
        assign s19 = {TAG_RAM_DW{1'b0}};
    end
endgenerate
generate
    if (ICACHE_WAY > 1) begin:gen_way1_tag_on
        reg [TAG_RAM_DW - 1:0] s197;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s197 <= {TAG_RAM_DW{1'b0}};
            end
            else if (s16) begin
                s197 <= icache_tag1_rdata;
            end
        end

        assign s20 = s197;
    end
    else begin:gen_way1_tag_off
        assign s20 = {TAG_RAM_DW{1'b0}};
    end
endgenerate
generate
    if (ICACHE_WAY > 2) begin:gen_way2_tag_on
        reg [TAG_RAM_DW - 1:0] s198;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s198 <= {TAG_RAM_DW{1'b0}};
            end
            else if (s17) begin
                s198 <= icache_tag2_rdata;
            end
        end

        assign s21 = s198;
    end
    else begin:gen_way2_tag_off
        assign s21 = {TAG_RAM_DW{1'b0}};
    end
endgenerate
generate
    if (ICACHE_WAY > 3) begin:gen_way3_tag_on
        reg [TAG_RAM_DW - 1:0] s199;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s199 <= {TAG_RAM_DW{1'b0}};
            end
            else if (s18) begin
                s199 <= icache_tag3_rdata;
            end
        end

        assign s22 = s199;
    end
    else begin:gen_way3_tag_off
        assign s22 = {TAG_RAM_DW{1'b0}};
    end
endgenerate
assign icache_tag0_cs = s0 & pf_tag_way[0];
assign icache_tag1_cs = s1 & pf_tag_way[1];
assign icache_tag2_cs = s2 & pf_tag_way[2];
assign icache_tag3_cs = s3 & pf_tag_way[3];
assign icache_tag0_wdata = s83;
assign icache_tag1_wdata = s83;
assign icache_tag2_wdata = s83;
assign icache_tag3_wdata = s83;
assign icache_tag0_we = pf_tag_we;
assign icache_tag1_we = pf_tag_we;
assign icache_tag2_we = pf_tag_we;
assign icache_tag3_we = pf_tag_we;
assign icache_tag0_addr = pf_tag_index;
assign icache_tag1_addr = pf_tag_index;
assign icache_tag2_addr = pf_tag_index;
assign icache_tag3_addr = pf_tag_index;
assign s47 = (s51 & s5) | (s59 & s6) | (s55 & s7);
assign s48 = (s52 & s5) | (s60 & s6) | (s56 & s7);
assign s49 = (s53 & s5) | (s61 & s6) | (s57 & s7);
assign s50 = (s54 & s5) | (s62 & s6) | (s58 & s7);
assign s51 = pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b00);
assign s52 = pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b01);
assign s53 = pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b10);
assign s54 = pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b11);
assign s59 = (pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b00) & s6) | (pf_data_way[1] & ~pf_data_we & (pf_data_index[1:0] == 2'b10) & s6);
assign s60 = (pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b01) & s6) | (pf_data_way[1] & ~pf_data_we & (pf_data_index[1:0] == 2'b11) & s6);
assign s61 = (pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b10) & s6) | (pf_data_way[1] & ~pf_data_we & (pf_data_index[1:0] == 2'b00) & s6);
assign s62 = (pf_data_way[0] & ~pf_data_we & (pf_data_index[1:0] == 2'b11) & s6) | (pf_data_way[1] & ~pf_data_we & (pf_data_index[1:0] == 2'b01) & s6);
assign s55 = (pf_data_way[0] & ~pf_data_we & (s124 == 2'd0) & s7) | (pf_data_way[1] & ~pf_data_we & (s124 == 2'd3) & s7) | (pf_data_way[2] & ~pf_data_we & (s124 == 2'd2) & s7) | (pf_data_way[3] & ~pf_data_we & (s124 == 2'd1) & s7);
assign s56 = (pf_data_way[1] & ~pf_data_we & (s124 == 2'd0) & s7) | (pf_data_way[2] & ~pf_data_we & (s124 == 2'd3) & s7) | (pf_data_way[3] & ~pf_data_we & (s124 == 2'd2) & s7) | (pf_data_way[0] & ~pf_data_we & (s124 == 2'd1) & s7);
assign s57 = (pf_data_way[2] & ~pf_data_we & (s124 == 2'd0) & s7) | (pf_data_way[3] & ~pf_data_we & (s124 == 2'd3) & s7) | (pf_data_way[0] & ~pf_data_we & (s124 == 2'd2) & s7) | (pf_data_way[1] & ~pf_data_we & (s124 == 2'd1) & s7);
assign s58 = (pf_data_way[3] & ~pf_data_we & (s124 == 2'd0) & s7) | (pf_data_way[0] & ~pf_data_we & (s124 == 2'd3) & s7) | (pf_data_way[1] & ~pf_data_we & (s124 == 2'd2) & s7) | (pf_data_way[2] & ~pf_data_we & (s124 == 2'd1) & s7);
assign s63 = fill2cache | (s71 & s5 & ~pf_ram_offset) | (s75 & s6 & ~pf_ram_offset) | (s79 & s7 & ~pf_ram_offset);
assign s64 = fill2cache | (s71 & s5 & pf_ram_offset) | (s75 & s6 & pf_ram_offset) | (s79 & s7 & pf_ram_offset);
assign s65 = fill2cache | (s72 & s5 & ~pf_ram_offset) | (s76 & s6 & ~pf_ram_offset) | (s80 & s7 & ~pf_ram_offset);
assign s66 = fill2cache | (s72 & s5 & pf_ram_offset) | (s76 & s6 & pf_ram_offset) | (s80 & s7 & pf_ram_offset);
assign s67 = fill2cache | (s73 & s5 & ~pf_ram_offset) | (s77 & s6 & ~pf_ram_offset) | (s81 & s7 & ~pf_ram_offset);
assign s68 = fill2cache | (s73 & s5 & pf_ram_offset) | (s77 & s6 & pf_ram_offset) | (s81 & s7 & pf_ram_offset);
assign s69 = fill2cache | (s74 & s5 & ~pf_ram_offset) | (s78 & s6 & ~pf_ram_offset) | (s82 & s7 & ~pf_ram_offset);
assign s70 = fill2cache | (s74 & s5 & pf_ram_offset) | (s78 & s6 & pf_ram_offset) | (s82 & s7 & pf_ram_offset);
assign s71 = (pf_data_we & (pf_data_index[1:0] == 2'b00));
assign s72 = (pf_data_we & (pf_data_index[1:0] == 2'b01));
assign s73 = (pf_data_we & (pf_data_index[1:0] == 2'b10));
assign s74 = (pf_data_we & (pf_data_index[1:0] == 2'b11));
assign s75 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b00)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b10));
assign s76 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b01)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b11));
assign s77 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b10)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b00));
assign s78 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b11)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b01));
assign s79 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b00)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b11)) | (pf_data_way[2] & pf_data_we & (pf_data_index[1:0] == 2'b10)) | (pf_data_way[3] & pf_data_we & (pf_data_index[1:0] == 2'b01));
assign s80 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b01)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b00)) | (pf_data_way[2] & pf_data_we & (pf_data_index[1:0] == 2'b11)) | (pf_data_way[3] & pf_data_we & (pf_data_index[1:0] == 2'b10));
assign s81 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b10)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b01)) | (pf_data_way[2] & pf_data_we & (pf_data_index[1:0] == 2'b00)) | (pf_data_way[3] & pf_data_we & (pf_data_index[1:0] == 2'b11));
assign s82 = (pf_data_way[0] & pf_data_we & (pf_data_index[1:0] == 2'b11)) | (pf_data_way[1] & pf_data_we & (pf_data_index[1:0] == 2'b10)) | (pf_data_way[2] & pf_data_we & (pf_data_index[1:0] == 2'b01)) | (pf_data_way[3] & pf_data_we & (pf_data_index[1:0] == 2'b00));
assign icache_data0_cs = (s47 & pf_ram_rd_word[0] | s63);
assign icache_data1_cs = (s47 & pf_ram_rd_word[1] | s64);
assign icache_data2_cs = (s48 & pf_ram_rd_word[0] | s65);
assign icache_data3_cs = (s48 & pf_ram_rd_word[1] | s66);
assign icache_data4_cs = (s49 & pf_ram_rd_word[0] | s67);
assign icache_data5_cs = (s49 & pf_ram_rd_word[1] | s68);
assign icache_data6_cs = (s50 & pf_ram_rd_word[0] | s69);
assign icache_data7_cs = (s50 & pf_ram_rd_word[1] | s70);
assign s84 = ({64{(fill2cache & s5)}} & fill_data[63:0]) | ({64{(fill2cache & fill_way[0] & s6)}} & fill_data[63:0]) | ({64{(fill2cache & fill_way[1] & s6)}} & fill_data[191:128]) | ({64{fill_way[0] & fill2cache & s7}} & fill_data[63:0]) | ({64{fill_way[1] & fill2cache & s7}} & fill_data[255:192]) | ({64{fill_way[2] & fill2cache & s7}} & fill_data[191:128]) | ({64{fill_way[3] & fill2cache & s7}} & fill_data[127:64]) | ({64{~fill2cache}} & pf_data_wdata);
assign s85 = ({64{(fill2cache & s5)}} & fill_data[127:64]) | ({64{(fill2cache & fill_way[0] & s6)}} & fill_data[127:64]) | ({64{(fill2cache & fill_way[1] & s6)}} & fill_data[255:192]) | ({64{fill_way[0] & fill2cache & s7}} & fill_data[127:64]) | ({64{fill_way[1] & fill2cache & s7}} & fill_data[63:0]) | ({64{fill_way[2] & fill2cache & s7}} & fill_data[255:192]) | ({64{fill_way[3] & fill2cache & s7}} & fill_data[191:128]) | ({64{~fill2cache}} & pf_data_wdata);
assign s86 = ({64{(fill2cache & s5)}} & fill_data[191:128]) | ({64{(fill2cache & fill_way[0] & s6)}} & fill_data[191:128]) | ({64{(fill2cache & fill_way[1] & s6)}} & fill_data[63:0]) | ({64{fill_way[0] & fill2cache & s7}} & fill_data[191:128]) | ({64{fill_way[1] & fill2cache & s7}} & fill_data[127:64]) | ({64{fill_way[2] & fill2cache & s7}} & fill_data[63:0]) | ({64{fill_way[3] & fill2cache & s7}} & fill_data[255:192]) | ({64{~fill2cache}} & pf_data_wdata);
assign s87 = ({64{(fill2cache & s5)}} & fill_data[255:192]) | ({64{(fill2cache & fill_way[0] & s6)}} & fill_data[255:192]) | ({64{(fill2cache & fill_way[1] & s6)}} & fill_data[127:64]) | ({64{fill_way[0] & fill2cache & s7}} & fill_data[255:192]) | ({64{fill_way[1] & fill2cache & s7}} & fill_data[191:128]) | ({64{fill_way[2] & fill2cache & s7}} & fill_data[127:64]) | ({64{fill_way[3] & fill2cache & s7}} & fill_data[63:0]) | ({64{~fill2cache}} & pf_data_wdata);
assign icache_data0_wdata = s88;
assign icache_data1_wdata = s89;
assign icache_data2_wdata = s90;
assign icache_data3_wdata = s91;
assign icache_data4_wdata = s92;
assign icache_data5_wdata = s93;
assign icache_data6_wdata = s94;
assign icache_data7_wdata = s95;
assign icache_data0_we = s63;
assign icache_data1_we = s64;
assign icache_data2_we = s65;
assign icache_data3_we = s66;
assign icache_data4_we = s67;
assign icache_data5_we = s68;
assign icache_data6_we = s69;
assign icache_data7_we = s70;
assign icache_data0_addr = (s130 & {DATA_RAM_AW{s7}}) | (s134 & {DATA_RAM_AW{s6}}) | (s138 & {DATA_RAM_AW{s5}});
assign icache_data1_addr = icache_data0_addr;
assign icache_data2_addr = (s131 & {DATA_RAM_AW{s7}}) | (s135 & {DATA_RAM_AW{s6}}) | (s139 & {DATA_RAM_AW{s5}});
assign icache_data3_addr = icache_data2_addr;
assign icache_data4_addr = (s132 & {DATA_RAM_AW{s7}}) | (s136 & {DATA_RAM_AW{s6}}) | (s140 & {DATA_RAM_AW{s5}});
assign icache_data5_addr = icache_data4_addr;
assign icache_data6_addr = (s133 & {DATA_RAM_AW{s7}}) | (s137 & {DATA_RAM_AW{s6}}) | (s141 & {DATA_RAM_AW{s5}});
assign icache_data7_addr = icache_data6_addr;
generate
    if (ICACHE_WAY == 4) begin:gen_iaddr_4w_yes
        wire [1:0] s200;
        wire [1:0] s201;
        wire [1:0] s202;
        wire [1:0] s203;
        assign s200 = ({2{fill_way[0]}} & 2'b00) | ({2{fill_way[3]}} & 2'b01) | ({2{fill_way[2]}} & 2'b10) | ({2{fill_way[1]}} & 2'b11);
        assign s201 = ({2{fill_way[1]}} & 2'b00) | ({2{fill_way[0]}} & 2'b01) | ({2{fill_way[3]}} & 2'b10) | ({2{fill_way[2]}} & 2'b11);
        assign s202 = ({2{fill_way[2]}} & 2'b00) | ({2{fill_way[1]}} & 2'b01) | ({2{fill_way[0]}} & 2'b10) | ({2{fill_way[3]}} & 2'b11);
        assign s203 = ({2{fill_way[3]}} & 2'b00) | ({2{fill_way[2]}} & 2'b01) | ({2{fill_way[1]}} & 2'b10) | ({2{fill_way[0]}} & 2'b11);
        assign s130 = ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,s200}) | ({DATA_RAM_AW{~fill2cache}} & pf_data_index);
        assign s131 = ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,s201}) | ({DATA_RAM_AW{~fill2cache}} & pf_data_index);
        assign s132 = ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,s202}) | ({DATA_RAM_AW{~fill2cache}} & pf_data_index);
        assign s133 = ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,s203}) | ({DATA_RAM_AW{~fill2cache}} & pf_data_index);
    end
    else begin:gen_iaddr_4w_no
        assign s130 = {DATA_RAM_AW{1'b0}};
        assign s131 = {DATA_RAM_AW{1'b0}};
        assign s132 = {DATA_RAM_AW{1'b0}};
        assign s133 = {DATA_RAM_AW{1'b0}};
    end
endgenerate
generate
    if (ICACHE_WAY == 2) begin:gen_iaddr_2w_yes
        assign s134 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:1]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,fill_way[1]});
        assign s135 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:1]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,fill_way[1]});
        assign s136 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:1]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,fill_way[0]});
        assign s137 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:1]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127,fill_way[0]});
    end
    else begin:gen_iaddr_2w_no
        assign s134 = {DATA_RAM_AW{1'b0}};
        assign s135 = {DATA_RAM_AW{1'b0}};
        assign s136 = {DATA_RAM_AW{1'b0}};
        assign s137 = {DATA_RAM_AW{1'b0}};
    end
endgenerate
generate
    if (ICACHE_WAY == 1) begin:gen_iaddr_1w_yes
        assign s138 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:2]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127});
        assign s139 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:2]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127});
        assign s140 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:2]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127});
        assign s141 = ({DATA_RAM_AW{~fill2cache}} & {pf_data_index[DATA_INDEX_WIDTH - 1:2]}) | ({DATA_RAM_AW{fill2cache}} & {fill_index[INDEX_WIDTH - 1:0],s127});
    end
    else begin:gen_iaddr_1w_no
        assign s138 = {DATA_RAM_AW{1'b0}};
        assign s139 = {DATA_RAM_AW{1'b0}};
        assign s140 = {DATA_RAM_AW{1'b0}};
        assign s141 = {DATA_RAM_AW{1'b0}};
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW <= 32)) begin:gen_leq_32b_tag_eccenc
        wire [31:0] s204;
        wire [6:0] s205;
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag_wdata_zext (
            .out(s204),
            .in(pf_tag_wdata)
        );
        kv_eccenc32 tag_eccenc(
            .data(s204[31:0]),
            .dataout(s205)
        );
        assign s83 = (pf_ecc_wr & pf_tag_we & ~fill2cache) ? {pf_wecccode[6:0],pf_tag_wdata} : {s205,pf_tag_wdata};
    end
    else if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW < 64)) begin:gen_lss_64b_tag_eccenc
        wire [63:0] s204;
        wire [7:0] s205;
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag_wdata_zext (
            .out(s204),
            .in(pf_tag_wdata)
        );
        kv_eccenc64 tag_eccenc(
            .data(s204[63:0]),
            .dataout(s205)
        );
        assign s83 = (pf_ecc_wr & pf_tag_we & ~fill2cache) ? {pf_wecccode[7:0],pf_tag_wdata} : {s205,pf_tag_wdata};
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW <= 32)) begin:gen_leq_32b_tag_parenc
        wire [31:0] s204;
        wire [3:0] s205;
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag_wdata_zext (
            .out(s204),
            .in(pf_tag_wdata)
        );
        kv_parenc32 tag_parenc(
            .data(s204[31:0]),
            .dataout(s205)
        );
        assign s83 = (pf_ecc_wr & pf_tag_we & ~fill2cache) ? {pf_wecccode[3:0],pf_tag_wdata} : {s205,pf_tag_wdata};
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW < 64)) begin:gen_lss_64b_tag_parenc
        wire [63:0] s204;
        wire [7:0] s205;
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag_wdata_zext (
            .out(s204),
            .in(pf_tag_wdata)
        );
        kv_parenc64 tag_parenc(
            .data(s204[63:0]),
            .dataout(s205)
        );
        assign s83 = (pf_ecc_wr & pf_tag_we & ~fill2cache) ? {pf_wecccode[7:0],pf_tag_wdata} : {s205,pf_tag_wdata};
    end
    else begin:gen_no_ecc_tag_eccenc
        assign s83 = pf_tag_wdata;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_data_eccenc
        wire [6:0] s206;
        wire [6:0] s207;
        wire [6:0] s208;
        wire [6:0] s209;
        wire [6:0] s210;
        wire [6:0] s211;
        wire [6:0] s212;
        wire [6:0] s213;
        kv_eccenc32 data_eccenc_word0(
            .data(s84[31:0]),
            .dataout(s206)
        );
        kv_eccenc32 data_eccenc_word1(
            .data(s84[63:32]),
            .dataout(s207)
        );
        kv_eccenc32 data_eccenc_word2(
            .data(s85[31:0]),
            .dataout(s208)
        );
        kv_eccenc32 data_eccenc_word3(
            .data(s85[63:32]),
            .dataout(s209)
        );
        kv_eccenc32 data_eccenc_word4(
            .data(s86[31:0]),
            .dataout(s210)
        );
        kv_eccenc32 data_eccenc_word5(
            .data(s86[63:32]),
            .dataout(s211)
        );
        kv_eccenc32 data_eccenc_word6(
            .data(s87[31:0]),
            .dataout(s212)
        );
        kv_eccenc32 data_eccenc_word7(
            .data(s87[63:32]),
            .dataout(s213)
        );
        assign s88 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s84[31:0]} : {s206,s84[31:0]};
        assign s89 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s84[63:32]} : {s207,s84[63:32]};
        assign s90 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s85[31:0]} : {s208,s85[31:0]};
        assign s91 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s85[63:32]} : {s209,s85[63:32]};
        assign s92 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s86[31:0]} : {s210,s86[31:0]};
        assign s93 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s86[63:32]} : {s211,s86[63:32]};
        assign s94 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s87[31:0]} : {s212,s87[31:0]};
        assign s95 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[6:0],s87[63:32]} : {s213,s87[63:32]};
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_data_parenc
        wire [3:0] s206;
        wire [3:0] s207;
        wire [3:0] s208;
        wire [3:0] s209;
        wire [3:0] s210;
        wire [3:0] s211;
        wire [3:0] s212;
        wire [3:0] s213;
        kv_parenc32 data_parenc_word0(
            .data(s84[31:0]),
            .dataout(s206)
        );
        kv_parenc32 data_parenc_word1(
            .data(s84[63:32]),
            .dataout(s207)
        );
        kv_parenc32 data_parenc_word2(
            .data(s85[31:0]),
            .dataout(s208)
        );
        kv_parenc32 data_parenc_word3(
            .data(s85[63:32]),
            .dataout(s209)
        );
        kv_parenc32 data_parenc_word4(
            .data(s86[31:0]),
            .dataout(s210)
        );
        kv_parenc32 data_parenc_word5(
            .data(s86[63:32]),
            .dataout(s211)
        );
        kv_parenc32 data_parenc_word6(
            .data(s87[31:0]),
            .dataout(s212)
        );
        kv_parenc32 data_parenc_word7(
            .data(s87[63:32]),
            .dataout(s213)
        );
        assign s88 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s84[31:0]} : {s206,s84[31:0]};
        assign s89 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s84[63:32]} : {s207,s84[63:32]};
        assign s90 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s85[31:0]} : {s208,s85[31:0]};
        assign s91 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s85[63:32]} : {s209,s85[63:32]};
        assign s92 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s86[31:0]} : {s210,s86[31:0]};
        assign s93 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s86[63:32]} : {s211,s86[63:32]};
        assign s94 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s87[31:0]} : {s212,s87[31:0]};
        assign s95 = (pf_ecc_wr & pf_data_we) ? {pf_wecccode[3:0],s87[63:32]} : {s213,s87[63:32]};
    end
    else begin:gen_data_eccenc_no
        assign s88 = s84[31:0];
        assign s89 = s84[63:32];
        assign s90 = s85[31:0];
        assign s91 = s85[63:32];
        assign s92 = s86[31:0];
        assign s93 = s86[63:32];
        assign s94 = s87[31:0];
        assign s95 = s87[63:32];
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way0_ecc_data_decode
        wire [31:0] s214;
        wire s215;
        wire s216;
        wire [6:0] s217;
        wire s218;
        wire s219;
        wire s220;
        wire s221;
        assign s221 = (s4 & s32[0] & s146 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[0] & s147 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[0] & s148 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[0] & s149 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s116 = {1'b0,s23[38:32]};
        kv_eccdec32 cache_data0_eccdec32(
            .dataout(s214),
            .ded(s215),
            .invalidate(s216),
            .parout(s217),
            .replay(s218),
            .sec(s219),
            .xcpt(s220),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s23[31:0]),
            .parin(s116[6:0]),
            .check_en(s221),
            .error(s96)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way0_par_data_decode
        wire s221;
        assign s221 = (s4 & s32[0] & s146 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[0] & s147 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[0] & s148 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[0] & s149 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s116 = {4'b0,s23[35:32]};
        kv_pardec32 cache_data0_pardec32(
            .data(s23[31:0]),
            .parin(s116[3:0]),
            .check_en(s221),
            .error(s96)
        );
    end
    else begin:gen_way0_no_ecc_data_decode
        assign s96 = 1'b0;
        assign s116 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way1_ecc_data_decode
        wire [31:0] s222;
        wire s223;
        wire s224;
        wire [6:0] s225;
        wire s226;
        wire s227;
        wire s228;
        wire s229;
        assign s229 = (s4 & s32[1] & s150 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[1] & s151 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[1] & s152 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[1] & s153 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s117 = {1'b0,s24[38:32]};
        kv_eccdec32 cache_data1_eccdec32(
            .dataout(s222),
            .ded(s223),
            .invalidate(s224),
            .parout(s225),
            .replay(s226),
            .sec(s227),
            .xcpt(s228),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s24[31:0]),
            .parin(s117[6:0]),
            .check_en(s229),
            .error(s97)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way1_par_data_decode
        wire s229;
        assign s229 = (s4 & s32[1] & s150 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[1] & s151 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[1] & s152 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[1] & s153 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s117 = {4'b0,s24[35:32]};
        kv_pardec32 cache_data1_pardec32(
            .data(s24[31:0]),
            .parin(s117[3:0]),
            .check_en(s229),
            .error(s97)
        );
    end
    else begin:gen_way1_no_ecc_data_decode
        assign s97 = 1'b0;
        assign s117 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way2_ecc_data_decode
        wire [31:0] s230;
        wire s231;
        wire s232;
        wire [6:0] s233;
        wire s234;
        wire s235;
        wire s236;
        wire s237;
        assign s237 = (s4 & s32[2] & s154 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[2] & s155 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[2] & s156 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[2] & s157 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s118 = {1'b0,s25[38:32]};
        kv_eccdec32 cache_data2_eccdec32(
            .dataout(s230),
            .ded(s231),
            .invalidate(s232),
            .parout(s233),
            .replay(s234),
            .sec(s235),
            .xcpt(s236),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s25[31:0]),
            .parin(s118[6:0]),
            .check_en(s237),
            .error(s98)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way2_par_data_decode
        wire s237;
        assign s237 = (s4 & s32[2] & s154 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[2] & s155 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[2] & s156 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[2] & s157 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s118 = {4'b0,s25[35:32]};
        kv_pardec32 cache_data2_pardec32(
            .data(s25[31:0]),
            .parin(s118[3:0]),
            .check_en(s237),
            .error(s98)
        );
    end
    else begin:gen_way2_no_ecc_data_decode
        assign s98 = 1'b0;
        assign s118 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way3_ecc_data_decode
        wire [31:0] s238;
        wire s239;
        wire s240;
        wire [6:0] s241;
        wire s242;
        wire s243;
        wire s244;
        wire s245;
        assign s245 = (s4 & s32[3] & s158 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[3] & s159 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[3] & s160 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[3] & s161 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s119 = {1'b0,s26[38:32]};
        kv_eccdec32 cache_data3_eccdec32(
            .dataout(s238),
            .ded(s239),
            .invalidate(s240),
            .parout(s241),
            .replay(s242),
            .sec(s243),
            .xcpt(s244),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s26[31:0]),
            .parin(s119[6:0]),
            .check_en(s245),
            .error(s99)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way3_par_data_decode
        wire s245;
        assign s245 = (s4 & s32[3] & s158 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[3] & s159 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[3] & s160 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[3] & s161 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s119 = {4'b0,s26[35:32]};
        kv_pardec32 cache_data3_pardec32(
            .data(s26[31:0]),
            .parin(s119[3:0]),
            .check_en(s245),
            .error(s99)
        );
    end
    else begin:gen_way3_no_ecc_data_decode
        assign s99 = 1'b0;
        assign s119 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way4_ecc_data_decode
        wire [31:0] s246;
        wire s247;
        wire s248;
        wire [6:0] s249;
        wire s250;
        wire s251;
        wire s252;
        wire s253;
        assign s253 = (s4 & s32[4] & s162 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[4] & s163 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[4] & s164 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[4] & s165 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s120 = {1'b0,s27[38:32]};
        kv_eccdec32 cache_data4_eccdec32(
            .dataout(s246),
            .ded(s247),
            .invalidate(s248),
            .parout(s249),
            .replay(s250),
            .sec(s251),
            .xcpt(s252),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s27[31:0]),
            .parin(s120[6:0]),
            .check_en(s253),
            .error(s100)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way4_par_data_decode
        wire s253;
        assign s253 = (s4 & s32[4] & s162 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[4] & s163 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[4] & s164 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[4] & s165 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s120 = {4'b0,s27[35:32]};
        kv_pardec32 cache_data4_pardec32(
            .data(s27[31:0]),
            .parin(s120[3:0]),
            .check_en(s253),
            .error(s100)
        );
    end
    else begin:gen_way4_no_ecc_data_decode
        assign s100 = 1'b0;
        assign s120 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way5_ecc_data_decode
        wire [31:0] s254;
        wire s255;
        wire s256;
        wire [6:0] s257;
        wire s258;
        wire s259;
        wire s260;
        wire s261;
        assign s261 = (s4 & s32[5] & s166 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[5] & s167 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[5] & s168 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[5] & s169 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s121 = {1'b0,s28[38:32]};
        kv_eccdec32 cache_data5_eccdec32(
            .dataout(s254),
            .ded(s255),
            .invalidate(s256),
            .parout(s257),
            .replay(s258),
            .sec(s259),
            .xcpt(s260),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s28[31:0]),
            .parin(s121[6:0]),
            .check_en(s261),
            .error(s101)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way5_par_data_decode
        wire s261;
        assign s261 = (s4 & s32[5] & s166 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[5] & s167 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[5] & s168 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[5] & s169 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s121 = {4'b0,s28[35:32]};
        kv_pardec32 cache_data5_pardec32(
            .data(s28[31:0]),
            .parin(s121[3:0]),
            .check_en(s261),
            .error(s101)
        );
    end
    else begin:gen_way5_no_ecc_data_decode
        assign s101 = 1'b0;
        assign s121 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way6_ecc_data_decode
        wire [31:0] s262;
        wire s263;
        wire s264;
        wire [6:0] s265;
        wire s266;
        wire s267;
        wire s268;
        wire s269;
        assign s269 = (s4 & s32[6] & s170 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[6] & s171 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[6] & s172 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[6] & s173 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s122 = {1'b0,s29[38:32]};
        kv_eccdec32 cache_data6_eccdec32(
            .dataout(s262),
            .ded(s263),
            .invalidate(s264),
            .parout(s265),
            .replay(s266),
            .sec(s267),
            .xcpt(s268),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s29[31:0]),
            .parin(s122[6:0]),
            .check_en(s269),
            .error(s102)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way6_par_data_decode
        wire s269;
        assign s269 = (s4 & s32[6] & s170 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[6] & s171 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[6] & s172 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[6] & s173 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s122 = {4'b0,s29[35:32]};
        kv_pardec32 cache_data6_pardec32(
            .data(s29[31:0]),
            .parin(s122[3:0]),
            .check_en(s269),
            .error(s102)
        );
    end
    else begin:gen_way6_no_ecc_data_decode
        assign s102 = 1'b0;
        assign s122 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_way7_ecc_data_decode
        wire [31:0] s270;
        wire s271;
        wire s272;
        wire [6:0] s273;
        wire s274;
        wire s275;
        wire s276;
        wire s277;
        assign s277 = (s4 & s32[7] & s174 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[7] & s175 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[7] & s176 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[7] & s177 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s123 = {1'b0,s30[38:32]};
        kv_eccdec32 cache_data7_eccdec32(
            .dataout(s270),
            .ded(s271),
            .invalidate(s272),
            .parout(s273),
            .replay(s274),
            .sec(s275),
            .xcpt(s276),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s30[31:0]),
            .parin(s123[6:0]),
            .check_en(s277),
            .error(s103)
        );
    end
    else if ((ECC_TYPE_INT == 1)) begin:gen_way7_par_data_decode
        wire s277;
        assign s277 = (s4 & s32[7] & s174 & (s31[0] & s19[CACHE_VALID] | f2_hit_way[0])) | (s4 & s32[7] & s175 & (s31[1] & s20[CACHE_VALID] | f2_hit_way[1])) | (s4 & s32[7] & s176 & (s31[2] & s21[CACHE_VALID] | f2_hit_way[2])) | (s4 & s32[7] & s177 & (s31[3] & s22[CACHE_VALID] | f2_hit_way[3]));
        assign s123 = {4'b0,s30[35:32]};
        kv_pardec32 cache_data7_pardec32(
            .data(s30[31:0]),
            .parin(s123[3:0]),
            .check_en(s277),
            .error(s103)
        );
    end
    else begin:gen_way7_no_ecc_data_decode
        assign s103 = 1'b0;
        assign s123 = 8'b0;
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 0)) begin:gen_way0_ecc_leq_32b_tag_decode
        wire [31:0] s278;
        wire [31:0] s279;
        wire s280;
        wire s281;
        wire [6:0] s282;
        wire s283;
        wire s284;
        wire s285;
        wire s286;
        wire s287;
        wire s288;
        wire [6:0] s289;
        wire s290;
        wire s291;
        assign s291 = s4 & ~s35;
        assign s289 = s19[TAG_RAM_DW - 1:TAG_RAM_DW - 7];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag0_rdata_zext (
            .out(s278),
            .in(s19[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(7)
        ) u_tag0_ecccode_zext (
            .out(s112),
            .in(s289)
        );
        assign s286 = s19[CACHE_LOCK];
        assign s287 = s19[CACHE_LOCK_DUP];
        assign s288 = (s286 != s287) & s291;
        assign s104 = s290 | s288;
        assign s108 = ~s286 & ~s287;
        kv_eccdec32 cache_tag0_eccdec32(
            .dataout(s279),
            .ded(s280),
            .invalidate(s281),
            .parout(s282),
            .replay(s283),
            .sec(s284),
            .xcpt(s285),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s278),
            .parin(s19[TAG_RAM_DW - 1:TAG_RAM_DW - 7]),
            .check_en(s291),
            .error(s290)
        );
    end
    else if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 0)) begin:gen_way0_ecc_lss_64b_tag_decode
        wire [63:0] s278;
        wire [63:0] s279;
        wire s280;
        wire s281;
        wire [7:0] s282;
        wire s283;
        wire s284;
        wire s285;
        wire s286;
        wire s287;
        wire s288;
        wire [7:0] s289;
        wire s290;
        wire s291;
        assign s291 = s4 & ~s35;
        assign s289 = s19[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag0_rdata_zext (
            .out(s278),
            .in(s19[NO_ECC_TAG_DW - 1:0])
        );
        assign s112 = s289;
        assign s286 = s19[CACHE_LOCK];
        assign s287 = s19[CACHE_LOCK_DUP];
        assign s288 = (s286 != s287) & s291;
        assign s104 = s290 | s288;
        assign s108 = ~s286 & ~s287;
        kv_eccdec64 cache_tag0_eccdec64(
            .dataout(s279),
            .ded(s280),
            .invalidate(s281),
            .parout(s282),
            .replay(s283),
            .sec(s284),
            .xcpt(s285),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s278),
            .parin(s19[TAG_RAM_DW - 1:TAG_RAM_DW - 8]),
            .check_en(s291),
            .error(s290)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 0)) begin:gen_way0_par_leq_32b_tag_decode
        wire [31:0] s278;
        wire s288;
        wire s290;
        wire s286;
        wire s287;
        wire s291;
        wire [3:0] s289;
        assign s291 = s4 & ~s35;
        assign s289 = s19[TAG_RAM_DW - 1:TAG_RAM_DW - 4];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag0_rdata_zext (
            .out(s278),
            .in(s19[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(4)
        ) u_tag0_ecccode_zext (
            .out(s112),
            .in(s289)
        );
        assign s286 = s19[CACHE_LOCK];
        assign s287 = s19[CACHE_LOCK_DUP];
        assign s288 = (s286 != s287) & s291;
        assign s104 = s290 | s288;
        assign s108 = ~s286 & ~s287;
        kv_pardec32 cache_tag0_pardec32(
            .data(s278),
            .parin(s289),
            .check_en(s291),
            .error(s290)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 0)) begin:gen_way0_par_lss_64b_tag_decode
        wire [63:0] s278;
        wire s288;
        wire s290;
        wire s286;
        wire s287;
        wire s291;
        wire [7:0] s289;
        assign s291 = s4 & ~s35;
        assign s289 = s19[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag0_rdata_zext (
            .out(s278),
            .in(s19[NO_ECC_TAG_DW - 1:0])
        );
        assign s286 = s19[CACHE_LOCK];
        assign s287 = s19[CACHE_LOCK_DUP];
        assign s288 = (s286 != s287) & s291;
        assign s112 = s289;
        assign s104 = s290 | s288;
        assign s108 = ~s286 & ~s287;
        kv_pardec64 cache_tag0_pardec64(
            .data(s278),
            .parin(s289),
            .check_en(s291),
            .error(s290)
        );
    end
    else begin:gen_way0_no_ecc_tag_decode
        wire nds_unused_way0_no_ecc_tag_decode = s35 | s4;
        assign s104 = 1'b0;
        assign s112 = 8'b0;
        assign s108 = 1'b0;
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 1)) begin:gen_way1_ecc_leq_32b_tag_decode
        wire [31:0] s292;
        wire [31:0] s293;
        wire s294;
        wire s295;
        wire [6:0] s296;
        wire s297;
        wire s298;
        wire s299;
        wire s300;
        wire s301;
        wire s302;
        wire [6:0] s303;
        wire s304;
        wire s305;
        assign s305 = s4 & ~s35;
        assign s303 = s20[TAG_RAM_DW - 1:TAG_RAM_DW - 7];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag1_rdata_zext (
            .out(s292),
            .in(s20[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(7)
        ) u_tag1_ecccode_zext (
            .out(s113),
            .in(s303)
        );
        assign s300 = s20[CACHE_LOCK];
        assign s301 = s20[CACHE_LOCK_DUP];
        assign s302 = (s300 != s301) & s305;
        assign s105 = s304 | s302;
        assign s109 = ~s300 & ~s301;
        kv_eccdec32 cache_tag1_eccdec32(
            .dataout(s293),
            .ded(s294),
            .invalidate(s295),
            .parout(s296),
            .replay(s297),
            .sec(s298),
            .xcpt(s299),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s292),
            .parin(s20[TAG_RAM_DW - 1:TAG_RAM_DW - 7]),
            .check_en(s305),
            .error(s304)
        );
    end
    else if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 1)) begin:gen_way1_ecc_lss_64b_tag_decode
        wire [63:0] s292;
        wire [63:0] s293;
        wire s294;
        wire s295;
        wire [7:0] s296;
        wire s297;
        wire s298;
        wire s299;
        wire s300;
        wire s301;
        wire s302;
        wire [7:0] s303;
        wire s304;
        wire s305;
        assign s305 = s4 & ~s35;
        assign s303 = s20[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag1_rdata_zext (
            .out(s292),
            .in(s20[NO_ECC_TAG_DW - 1:0])
        );
        assign s113 = s303;
        assign s300 = s20[CACHE_LOCK];
        assign s301 = s20[CACHE_LOCK_DUP];
        assign s302 = (s300 != s301) & s305;
        assign s105 = s304 | s302;
        assign s109 = ~s300 & ~s301;
        kv_eccdec64 cache_tag1_eccdec64(
            .dataout(s293),
            .ded(s294),
            .invalidate(s295),
            .parout(s296),
            .replay(s297),
            .sec(s298),
            .xcpt(s299),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s292),
            .parin(s20[TAG_RAM_DW - 1:TAG_RAM_DW - 8]),
            .check_en(s305),
            .error(s304)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 1)) begin:gen_way1_par_leq_32b_tag_decode
        wire [31:0] s292;
        wire s302;
        wire s304;
        wire s300;
        wire s301;
        wire s305;
        wire [3:0] s303;
        assign s305 = s4 & ~s35;
        assign s303 = s20[TAG_RAM_DW - 1:TAG_RAM_DW - 4];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag1_rdata_zext (
            .out(s292),
            .in(s20[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(4)
        ) u_tag1_ecccode_zext (
            .out(s113),
            .in(s303)
        );
        assign s300 = s20[CACHE_LOCK];
        assign s301 = s20[CACHE_LOCK_DUP];
        assign s302 = (s300 != s301) & s305;
        assign s105 = s304 | s302;
        assign s109 = ~s300 & ~s301;
        kv_pardec32 cache_tag1_pardec32(
            .data(s292),
            .parin(s303),
            .check_en(s305),
            .error(s304)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 1)) begin:gen_way1_par_lss_64b_tag_decode
        wire [63:0] s292;
        wire s302;
        wire s304;
        wire s300;
        wire s301;
        wire s305;
        wire [7:0] s303;
        assign s305 = s4 & ~s35;
        assign s303 = s20[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag1_rdata_zext (
            .out(s292),
            .in(s20[NO_ECC_TAG_DW - 1:0])
        );
        assign s300 = s20[CACHE_LOCK];
        assign s301 = s20[CACHE_LOCK_DUP];
        assign s302 = (s300 != s301) & s305;
        assign s113 = s303;
        assign s105 = s304 | s302;
        assign s109 = ~s300 & ~s301;
        kv_pardec64 cache_tag1_pardec64(
            .data(s292),
            .parin(s303),
            .check_en(s305),
            .error(s304)
        );
    end
    else begin:gen_way1_no_ecc_tag_decode
        wire nds_unused_way1_no_ecc_tag_decode = s35 | s4;
        assign s105 = 1'b0;
        assign s113 = 8'b0;
        assign s109 = 1'b0;
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 2)) begin:gen_way2_ecc_leq_32b_tag_decode
        wire [31:0] s306;
        wire [31:0] s307;
        wire s308;
        wire s309;
        wire [6:0] s310;
        wire s311;
        wire s312;
        wire s313;
        wire s314;
        wire s315;
        wire s316;
        wire [6:0] s317;
        wire s318;
        wire s319;
        assign s319 = s4 & ~s35;
        assign s317 = s21[TAG_RAM_DW - 1:TAG_RAM_DW - 7];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag2_rdata_zext (
            .out(s306),
            .in(s21[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(7)
        ) u_tag2_ecccode_zext (
            .out(s114),
            .in(s317)
        );
        assign s314 = s21[CACHE_LOCK];
        assign s315 = s21[CACHE_LOCK_DUP];
        assign s316 = (s314 != s315) & s319;
        assign s106 = s318 | s316;
        assign s110 = ~s314 & ~s315;
        kv_eccdec32 cache_tag2_eccdec32(
            .dataout(s307),
            .ded(s308),
            .invalidate(s309),
            .parout(s310),
            .replay(s311),
            .sec(s312),
            .xcpt(s313),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s306),
            .parin(s21[TAG_RAM_DW - 1:TAG_RAM_DW - 7]),
            .check_en(s319),
            .error(s318)
        );
    end
    else if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 2)) begin:gen_way2_ecc_lss_64b_tag_decode
        wire [63:0] s306;
        wire [63:0] s307;
        wire s308;
        wire s309;
        wire [7:0] s310;
        wire s311;
        wire s312;
        wire s313;
        wire s314;
        wire s315;
        wire s316;
        wire [7:0] s317;
        wire s318;
        wire s319;
        assign s319 = s4 & ~s35;
        assign s317 = s21[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag2_rdata_zext (
            .out(s306),
            .in(s21[NO_ECC_TAG_DW - 1:0])
        );
        assign s114 = s317;
        assign s314 = s21[CACHE_LOCK];
        assign s315 = s21[CACHE_LOCK_DUP];
        assign s316 = (s314 != s315) & s319;
        assign s106 = s318 | s316;
        assign s110 = ~s314 & ~s315;
        kv_eccdec64 cache_tag2_eccdec64(
            .dataout(s307),
            .ded(s308),
            .invalidate(s309),
            .parout(s310),
            .replay(s311),
            .sec(s312),
            .xcpt(s313),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s306),
            .parin(s21[TAG_RAM_DW - 1:TAG_RAM_DW - 8]),
            .check_en(s319),
            .error(s318)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 2)) begin:gen_way2_par_leq_32b_tag_decode
        wire [31:0] s306;
        wire s316;
        wire s318;
        wire s314;
        wire s315;
        wire s319;
        wire [3:0] s317;
        assign s319 = s4 & ~s35;
        assign s317 = s21[TAG_RAM_DW - 1:TAG_RAM_DW - 4];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag2_rdata_zext (
            .out(s306),
            .in(s21[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(4)
        ) u_tag2_ecccode_zext (
            .out(s114),
            .in(s317)
        );
        assign s314 = s21[CACHE_LOCK];
        assign s315 = s21[CACHE_LOCK_DUP];
        assign s316 = (s314 != s315) & s319;
        assign s106 = s318 | s316;
        assign s110 = ~s314 & ~s315;
        kv_pardec32 cache_tag2_pardec32(
            .data(s306),
            .parin(s317),
            .check_en(s319),
            .error(s318)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 2)) begin:gen_way2_par_lss_64b_tag_decode
        wire [63:0] s306;
        wire s316;
        wire s318;
        wire s314;
        wire s315;
        wire s319;
        wire [7:0] s317;
        assign s319 = s4 & ~s35;
        assign s317 = s21[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag2_rdata_zext (
            .out(s306),
            .in(s21[NO_ECC_TAG_DW - 1:0])
        );
        assign s314 = s21[CACHE_LOCK];
        assign s315 = s21[CACHE_LOCK_DUP];
        assign s316 = (s314 != s315) & s319;
        assign s114 = s317;
        assign s106 = s318 | s316;
        assign s110 = ~s314 & ~s315;
        kv_pardec64 cache_tag2_pardec64(
            .data(s306),
            .parin(s317),
            .check_en(s319),
            .error(s318)
        );
    end
    else begin:gen_way2_no_ecc_tag_decode
        wire nds_unused_way2_no_ecc_tag_decode = s35 | s4;
        assign s106 = 1'b0;
        assign s114 = 8'b0;
        assign s110 = 1'b0;
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 3)) begin:gen_way3_ecc_leq_32b_tag_decode
        wire [31:0] s320;
        wire [31:0] s321;
        wire s322;
        wire s323;
        wire [6:0] s324;
        wire s325;
        wire s326;
        wire s327;
        wire s328;
        wire s329;
        wire s330;
        wire [6:0] s331;
        wire s332;
        wire s333;
        assign s333 = s4 & ~s35;
        assign s331 = s22[TAG_RAM_DW - 1:TAG_RAM_DW - 7];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag3_rdata_zext (
            .out(s320),
            .in(s22[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(7)
        ) u_tag3_ecccode_zext (
            .out(s115),
            .in(s331)
        );
        assign s328 = s22[CACHE_LOCK];
        assign s329 = s22[CACHE_LOCK_DUP];
        assign s330 = (s328 != s329) & s333;
        assign s107 = s332 | s330;
        assign s111 = ~s328 & ~s329;
        kv_eccdec32 cache_tag3_eccdec32(
            .dataout(s321),
            .ded(s322),
            .invalidate(s323),
            .parout(s324),
            .replay(s325),
            .sec(s326),
            .xcpt(s327),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s320),
            .parin(s22[TAG_RAM_DW - 1:TAG_RAM_DW - 7]),
            .check_en(s333),
            .error(s332)
        );
    end
    else if (((ECC_TYPE_INT == 2)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 3)) begin:gen_way3_ecc_lss_64b_tag_decode
        wire [63:0] s320;
        wire [63:0] s321;
        wire s322;
        wire s323;
        wire [7:0] s324;
        wire s325;
        wire s326;
        wire s327;
        wire s328;
        wire s329;
        wire s330;
        wire [7:0] s331;
        wire s332;
        wire s333;
        assign s333 = s4 & ~s35;
        assign s331 = s22[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag3_rdata_zext (
            .out(s320),
            .in(s22[NO_ECC_TAG_DW - 1:0])
        );
        assign s115 = s331;
        assign s328 = s22[CACHE_LOCK];
        assign s329 = s22[CACHE_LOCK_DUP];
        assign s330 = (s328 != s329) & s333;
        assign s107 = s332 | s330;
        assign s111 = ~s328 & ~s329;
        kv_eccdec64 cache_tag3_eccdec64(
            .dataout(s321),
            .ded(s322),
            .invalidate(s323),
            .parout(s324),
            .replay(s325),
            .sec(s326),
            .xcpt(s327),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b0),
            .data(s320),
            .parin(s22[TAG_RAM_DW - 1:TAG_RAM_DW - 8]),
            .check_en(s333),
            .error(s332)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW <= 32) && (ICACHE_WAY > 3)) begin:gen_way3_par_leq_32b_tag_decode
        wire [31:0] s320;
        wire s330;
        wire s332;
        wire s328;
        wire s329;
        wire s333;
        wire [3:0] s331;
        assign s333 = s4 & ~s35;
        assign s331 = s22[TAG_RAM_DW - 1:TAG_RAM_DW - 4];
        kv_zero_ext #(
            .OW(32),
            .IW(NO_ECC_TAG_DW)
        ) u_tag3_rdata_zext (
            .out(s320),
            .in(s22[NO_ECC_TAG_DW - 1:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(4)
        ) u_tag3_ecccode_zext (
            .out(s115),
            .in(s331)
        );
        assign s328 = s22[CACHE_LOCK];
        assign s329 = s22[CACHE_LOCK_DUP];
        assign s330 = (s328 != s329) & s333;
        assign s107 = s332 | s330;
        assign s111 = ~s328 & ~s329;
        kv_pardec32 cache_tag3_pardec32(
            .data(s320),
            .parin(s331),
            .check_en(s333),
            .error(s332)
        );
    end
    else if (((ECC_TYPE_INT == 1)) && (NO_ECC_TAG_DW < 64) && (ICACHE_WAY > 3)) begin:gen_way3_par_lss_64b_tag_decode
        wire [63:0] s320;
        wire s330;
        wire s332;
        wire s328;
        wire s329;
        wire s333;
        wire [7:0] s331;
        assign s333 = s4 & ~s35;
        assign s331 = s22[TAG_RAM_DW - 1:TAG_RAM_DW - 8];
        kv_zero_ext #(
            .OW(64),
            .IW(NO_ECC_TAG_DW)
        ) u_tag3_rdata_zext (
            .out(s320),
            .in(s22[NO_ECC_TAG_DW - 1:0])
        );
        assign s328 = s22[CACHE_LOCK];
        assign s329 = s22[CACHE_LOCK_DUP];
        assign s330 = (s328 != s329) & s333;
        assign s115 = s331;
        assign s107 = s332 | s330;
        assign s111 = ~s328 & ~s329;
        kv_pardec64 cache_tag3_pardec64(
            .data(s320),
            .parin(s331),
            .check_en(s333),
            .error(s332)
        );
    end
    else begin:gen_way3_no_ecc_tag_decode
        wire nds_unused_way3_no_ecc_tag_decode = s35 | s4;
        assign s107 = 1'b0;
        assign s115 = 8'b0;
        assign s111 = 1'b0;
    end
endgenerate
endmodule

