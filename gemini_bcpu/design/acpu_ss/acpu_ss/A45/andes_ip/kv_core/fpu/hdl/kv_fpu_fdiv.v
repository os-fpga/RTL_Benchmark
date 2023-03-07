// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_fdiv (
    fdiv_standby_ready,
    f4_wdata,
    f4_wdata_en,
    f4_flag_set,
    f4_result_type,
    f4_tag,
    f4_frf_stall,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_round_mode,
    f1_sew,
    f1_ediv,
    f1_ex_ctrl,
    f1_tag,
    kill,
    f3_main_pipe_stall,
    req_ready,
    core_clk,
    core_reset_n
);
parameter FLEN = 32;
localparam DSU_FRA_MSB = (FLEN == 64) ? 161 : (FLEN == 32) ? 132 : 119;
localparam DSU_FRA_LSB = 108;
localparam DSU_FRA_RND = 107;
localparam DSU_SRT_MSB = DSU_FRA_MSB;
localparam DSU_SRT_LSB = 104;
localparam FRACTION_WIDTH = (FLEN == 64) ? 53 : (FLEN == 32) ? 24 : 11;
localparam FRACTION_MSB = (FRACTION_WIDTH - 1);
localparam DS_DIN_WIDTH = (FRACTION_WIDTH + 1);
localparam DS_DIN_MSB = (DS_DIN_WIDTH - 1);
localparam DS_DOUT_WIDTH = (FRACTION_WIDTH + 5);
localparam DS_DOUT_MSB = (DS_DOUT_WIDTH - 1);
localparam ROUND_ZERO = 2'b00;
localparam ROUND_NEG = 2'b01;
localparam ROUND_POS = 2'b10;
localparam ROUND_NEAREST = 2'b11;
localparam ROUND_RNE = 3'b000;
localparam ROUND_RTZ = 3'b001;
localparam ROUND_RDN = 3'b010;
localparam ROUND_RUP = 3'b011;
localparam ROUND_RMM = 3'b100;
localparam HP = 3'b001;
localparam SP = 3'b010;
localparam DP = 3'b011;
output fdiv_standby_ready;
output [63:0] f4_wdata;
output f4_wdata_en;
output [4:0] f4_flag_set;
output [4:0] f4_tag;
output [1:0] f4_result_type;
input f4_frf_stall;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [4:0] f1_tag;
input [2:0] f1_round_mode;
input [2:0] f1_sew;
input [1:0] f1_ediv;
input [5:0] f1_ex_ctrl;
input core_clk;
input core_reset_n;
input kill;
input f3_main_pipe_stall;
output req_ready;


wire s0;
wire s1;
wire s2;
wire [11:0] s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
wire s33;
wire [11:0] s34;
wire [11:0] s35;
wire [FRACTION_MSB:0] s36;
wire [FRACTION_MSB:0] s37;
wire s38;
wire s39;
wire s40;
wire s41;
wire s42;
reg s43;
reg s44;
wire s45;
wire [63:0] s46;
wire [4:0] s47;
wire [1:0] s48;
wire s49;
wire s50;
wire s51;
wire [FRACTION_MSB:0] s52;
wire [FRACTION_MSB:0] s53;
wire [11:0] s54;
wire [11:0] s55;
wire [11:0] s56;
wire [11:0] s57;
wire [12:0] s58;
wire [12:0] s59;
wire [12:0] s60;
wire [12:0] s61;
wire [12:0] s62;
wire [12:0] s63;
wire [52:0] s64;
wire [52:0] s65;
wire [1:0] s66;
wire [53:1] s67;
wire [53:0] s68;
reg [2:0] s69;
reg s70;
reg s71;
reg s72;
reg s73;
reg s74;
reg s75;
reg s76;
reg s77;
reg s78;
reg s79;
reg s80;
reg s81;
reg s82;
reg [4:0] s83;
wire s84;
wire s85;
wire s86 = s79;
wire s87 = s80;
wire s88 = s73;
wire s89 = s74;
wire s90 = s75;
wire s91 = s49;
wire s92 = s50;
wire s93 = s51;
wire s94 = s81;
wire s95 = s76;
wire [2:0] s96 = s69;
wire [DSU_SRT_MSB:DSU_SRT_LSB] s97;
wire [DS_DOUT_MSB:0] s98;
wire [DS_DOUT_MSB:0] s99;
wire [DS_DOUT_MSB:0] s100;
wire [DS_DOUT_MSB:0] s101;
wire [DS_DOUT_MSB:0] s102;
wire s103;
wire [12:0] s104;
wire [12:0] s105;
wire [12:0] s106;
wire s107;
wire s108;
wire s109;
wire s110;
wire [5:0] s111;
wire [DS_DOUT_MSB:0] s112;
wire [DS_DOUT_MSB:0] s113;
wire [DS_DOUT_MSB:0] s114;
wire [DS_DOUT_MSB:0] s115;
wire [DS_DOUT_MSB:0] s116;
wire [DS_DOUT_MSB:0] s117;
wire [DS_DOUT_MSB:0] s118;
wire s119;
wire s120;
wire s121;
wire s122;
wire s123;
wire s124;
wire s125;
wire s126;
wire s127;
wire s128;
wire s129;
wire s130;
wire s131;
wire s132;
wire s133;
wire s134;
wire s135;
wire s136;
wire s137;
wire s138;
wire s139;
wire s140;
wire s141;
wire s142;
wire s143;
wire f3_stall;
reg s144;
reg s145;
reg s146;
reg [4:0] s147;
reg [1:0] s148;
wire s149;
wire s150;
wire [12:0] s151;
wire s152;
wire s153;
wire s154;
wire s155;
wire s156;
wire s157;
wire s158;
wire s159;
wire s160 = s78;
wire [2:0] s161 = s96;
wire s162 = s86;
wire s163 = s87;
wire s164 = s94;
wire s165 = s88;
wire s166 = s89;
wire s167 = s90;
wire s168 = s91;
wire s169 = s92;
wire s170 = s93;
wire s171;
wire s172;
wire s173;
wire s174;
wire s175;
wire s176;
wire s177;
wire s178;
wire s179;
wire s180;
wire s181;
wire s182;
wire s183;
wire s184;
wire s185;
wire s186;
wire s187;
wire s188;
wire s189;
wire s190;
wire [DSU_SRT_MSB:DSU_SRT_LSB] s191;
wire [DSU_FRA_MSB:DSU_FRA_RND] s192;
wire [DSU_FRA_MSB:DSU_FRA_RND] s193;
wire [DSU_FRA_MSB:108] s194;
wire s195;
wire f4_wdata_en;
wire [63:0] f4_wdata;
wire [63:0] s196;
wire [63:0] s197;
wire s198;
wire s199;
wire s200;
wire s201;
wire [1:0] s202;
wire [1:0] s203;
wire [11:0] s204;
wire [11:0] s205;
wire s206;
wire s207;
wire s208;
wire s209;
wire s210;
wire s211;
wire s212;
wire s213;
wire s214;
wire s215;
wire s216;
wire s217;
wire s218;
wire s219;
wire s220;
wire s221;
wire s222;
wire s223;
wire s224;
wire s225;
wire [11:0] s226;
wire s227;
wire s228;
wire s229;
wire s230;
wire s231;
wire s232;
wire s233;
wire s234;
wire s235;
reg s236;
reg [4:0] f4_tag;
reg s237;
wire s238;
wire s239;
wire s240;
wire s241;
reg s242;
wire [DS_DIN_MSB:0] ds_din0;
wire [DS_DIN_MSB:1] ds_din1;
wire [DS_DOUT_MSB:0] ds_result0;
wire [DS_DOUT_MSB:0] ds_result1;
wire ds_busy;
wire ds_gen_sticky;
wire ds_calc_done;
wire s243;
wire s244;
wire s245;
wire s246;
wire s247;
assign fdiv_standby_ready = ~f1_valid & ~s82 & ~s144 & ~s236;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s83 <= 5'b0;
    end
    else if (s245) begin
        s83 <= f1_tag;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s147 <= 5'b0;
    end
    else if (s246) begin
        s147 <= s83;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        f4_tag <= 5'b0;
    end
    else if (s247) begin
        f4_tag <= s147;
    end
end

assign s238 = s236 & f4_frf_stall;
assign s239 = s236 & ~f4_frf_stall;
assign s240 = (s237 & ~s239) | s238;
assign s241 = s238 | s239;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s237 <= 1'b0;
    end
    else if (s241) begin
        s237 <= s240;
    end
end

wire s248 = (FLEN == 64);
wire s249 = (FLEN == 32) | s248;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s242 <= 1'b0;
    end
    else if (f1_valid | s82 | s144 | s236) begin
        s242 <= ds_busy;
    end
end

assign req_ready = (~f1_valid & ~s82 & ~s144 & ~s236) | (s236 & ~f1_valid & ~s82 & ~s144 & ~f4_frf_stall);
wire s250 = (f1_valid & ~kill & ~f3_stall & ~(f4_frf_stall & s236) & ~f3_main_pipe_stall) | (s82 & ~kill & f3_main_pipe_stall);
wire s251 = (f3_stall & ~kill) | (s82 & ~s45 & ~kill & ~f3_main_pipe_stall);
wire s252 = (~f3_stall & s144 & ~kill) | (f4_frf_stall & s236 & (~kill | s237));
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s82 <= 1'b0;
        s144 <= 1'b0;
        s236 <= 1'b0;
    end
    else begin
        s82 <= s250;
        s144 <= s251;
        s236 <= s252;
    end
end

assign s244 = ds_gen_sticky | ds_calc_done;
assign s245 = f1_valid & ~f3_stall & ~(f4_frf_stall & s236);
assign s246 = s82 & ~s45 & ~f3_main_pipe_stall;
assign s247 = s144 & ~f3_stall;
reg [DS_DOUT_MSB:0] s253;
reg [DS_DOUT_MSB:0] s254;
wire [DS_DOUT_MSB:0] s255;
wire [DS_DOUT_MSB:0] s256;
wire [DS_DOUT_MSB:0] s257;
assign s257 = {{(DS_DOUT_WIDTH - 9){1'b0}},s152,s150,s149,s154,s155,s156,s157,s158,s159};
assign {s227,s200,s199,s210,s211,s212,s213,s214,s215} = s254[8:0];
assign s255 = {(DS_DOUT_WIDTH){s245}} & {5'b0,s36} | {(DS_DOUT_WIDTH){s244}} & ds_result0 | {(DS_DOUT_WIDTH){s247}} & s97;
assign s256 = {(DS_DOUT_WIDTH){s245}} & {5'b0,s37} | {(DS_DOUT_WIDTH){s244}} & ds_result1 | {(DS_DOUT_WIDTH){s247}} & s257;
assign s52 = s253[FRACTION_MSB:0];
assign s53 = s254[FRACTION_MSB:0];
assign s100 = s253;
assign s101 = s254;
assign s191 = s253;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s253 <= {(DS_DOUT_MSB + 1){1'b0}};
        s254 <= {(DS_DOUT_MSB + 1){1'b0}};
    end
    else if (s245 | s244 | s247) begin
        s253 <= s255;
        s254 <= s256;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s146 <= 1'b0;
        s145 <= 1'b0;
    end
    else if (ds_gen_sticky) begin
        s146 <= s84;
        s145 <= s85;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s78 <= 1'b0;
        s73 <= 1'b0;
        s74 <= 1'b0;
        s75 <= 1'b0;
        s70 <= 1'b0;
        s71 <= 1'b0;
        s72 <= 1'b0;
        s69 <= 3'b0;
        s76 <= 1'b0;
        s77 <= 1'b0;
        s80 <= 1'b0;
        s79 <= 1'b0;
        s81 <= 1'b0;
        s43 <= 1'b0;
        s44 <= 1'b0;
    end
    else if (s245) begin
        s78 <= s9;
        s73 <= s13;
        s74 <= s14;
        s75 <= s15;
        s70 <= s10;
        s71 <= s11;
        s72 <= s12;
        s69 <= f1_round_mode;
        s76 <= s41;
        s77 <= s42;
        s80 <= s39;
        s79 <= s38;
        s81 <= s40;
        s43 <= s0;
        s44 <= s1;
    end
end

reg [12:0] s258;
reg [12:0] s259;
wire [12:0] s260;
wire [12:0] s261;
assign s260 = {13{s245}} & {1'b0,s34} | {13{s246}} & s62 | {13{s247}} & s151;
assign s261 = {13{s245 & s2}} & {s4,s3} | {13{s245 & ~s2}} & {1'b0,s35} | {13{s246}} & s63;
assign s54 = s258[11:0];
assign s55 = s259[11:0];
assign s104 = s258;
assign s105 = s259;
assign s204 = s258[11:0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s258 <= 13'b0;
        s259 <= 13'b0;
    end
    else if (s245 | s246 | s247) begin
        s258 <= s260;
        s259 <= s261;
    end
end

assign s10 = f1_sew[0];
assign s11 = f1_sew[1] & s249;
assign s12 = f1_sew[2] & s248;
wire s262 = s9;
wire s263 = s262 ? ((s10 & (FLEN == 64)) ? &f1_op1_data[63:16] : (s10 & (FLEN == 32)) ? &f1_op1_data[31:16] : 1'b0) : 1'b1;
wire s264 = s262 ? ((s10 & (FLEN == 64)) ? &f1_op2_data[63:16] : (s10 & (FLEN == 32)) ? &f1_op2_data[31:16] : 1'b0) : 1'b1;
wire s265 = s262 ? ((s11 & (FLEN == 64)) ? &f1_op1_data[63:32] : (s11 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire s266 = s262 ? ((s11 & (FLEN == 64)) ? &f1_op2_data[63:32] : (s11 & (FLEN == 32)) ? 1'b1 : 1'b0) : 1'b1;
wire s267 = s10 ? s263 : s11 ? s265 : 1'b1;
wire s268 = s10 ? s264 : s11 ? s266 : 1'b1;
wire s269 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9:0] == 10'b0) & (s263);
wire s270 = (f1_op1_data[14:10] == 5'b0) & (f1_op1_data[9:0] != 10'b0) & (s263);
wire s271 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[9]) | ~(s263);
wire s272 = (f1_op1_data[14:10] == 5'h1f) & (f1_op1_data[8:0] != 9'b0) & (s263) & ~f1_op1_data[9];
wire s273 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9:0] == 10'b0) & (s264);
wire s274 = (f1_op2_data[14:10] == 5'b0) & (f1_op2_data[9:0] != 10'b0) & (s264);
wire s275 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[9]) | ~(s264);
wire s276 = (f1_op2_data[14:10] == 5'h1f) & (f1_op2_data[8:0] != 9'b0) & (s264) & ~f1_op2_data[9];
wire s277 = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22:0] == 23'b0) & (s265);
wire s278 = (f1_op1_data[30:23] == 8'b0) & (f1_op1_data[22:0] != 23'b0) & (s265);
wire s279 = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[22]) | ~(s265);
wire s280 = (f1_op1_data[30:23] == 8'hff) & (f1_op1_data[21:0] != 22'b0) & (s265) & ~f1_op1_data[22];
wire s281 = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22:0] == 23'b0) & (s266);
wire s282 = (f1_op2_data[30:23] == 8'b0) & (f1_op2_data[22:0] != 23'b0) & (s266);
wire s283 = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[22]) | ~(s266);
wire s284 = (f1_op2_data[30:23] == 8'hff) & (f1_op2_data[21:0] != 22'b0) & (s266) & ~f1_op2_data[22];
wire s285 = s10 & s269 | s11 & s277 | s12 & s26;
wire s286 = s10 & s272 | s11 & s280 | s12 & s29;
wire s287 = s10 & s271 | s11 & s279 | s12 & s28;
wire s288 = s10 & s273 | s11 & s281 | s12 & s30;
wire s289 = s10 & s276 | s11 & s284 | s12 & s33;
wire s290 = s10 & s275 | s11 & s283 | s12 & s32;
wire s291 = s287 | s286;
wire s292 = s290 | s289;
wire s293 = s24 ^ s25;
assign s14 = (s7 | s5) & ~s19 & ~s292 & s18 & s267 & s268 | (s7 | s5) & ~s291 & s288 & s267 & s268 | (s8 | s6) & s18 & s267 | (s0) & s285 & s267 | (s1) & s285 & ~s24 & s267 & s268;
assign s13 = (s7 | s5) & ~(s18 | s291) & s19 & s267 & s268 | (s7 | s5) & ~(s288 | s292) & s285 & s267 & s268 | (s8 | s6) & s285 & s267 | (s0 | s1) & s18 & s267;
assign s15 = (s7 | s5) & (s291 | s292) | (s7 | s5) & (s285 & s288) | (s7 | s5) & (s18 & s19) | (s8 | s6 | s1) & (s291 | (s24 & ~s18)) | (s0) & (s291);
assign s38 = (s7 | s5) & s19 & ~(s18 | s291 | s285) & s268 | (s0 | s1) & s18 & s267;
assign s39 = (s7 | s5) & (s285 & s288) & s267 & s268 | (s7 | s5) & (s18 & s19) & s267 & s268 | (s7 | s5) & ((s286 & s267) | (s289 & s268)) | (s8 | s6 | s1) & (s24 & ~s18 & ~s291) & s267 | (s8 | s6 | s1) & s286 & s267 | (s0) & s286 & s267;
assign s16 = (s7 | s5) & s293 | (s8 | s6) & s24;
assign s17 = (s7 | s5) & (s285 | s288) & s293 | (s7 | s5) & (s19) & s293;
assign s5 = 1'b0;
assign s6 = 1'b0;
assign s7 = (f1_ex_ctrl[4:0] == 5'b00000);
assign s8 = (f1_ex_ctrl[4:0] == 5'b00001);
assign s9 = s7 | s8;
assign s2 = s0 | s1;
assign s45 = s43 | s44;
assign s41 = s7 | s5;
assign s42 = s8 | s6;
assign s18 = s10 & (~(|f1_op1_data[14:0])) | s11 & (~(|f1_op1_data[30:0])) | s12 & (~(|f1_op1_data[62:0]));
assign s19 = s10 & (~(|f1_op2_data[14:0])) | s11 & (~(|f1_op2_data[30:0])) | s12 & (~(|f1_op2_data[62:0]));
assign s20 = s10 & (~(|f1_op1_data[14:10])) | s11 & (~(|f1_op1_data[30:23])) | s12 & (~(|f1_op1_data[62:52]));
assign s21 = s10 & (~(|f1_op2_data[14:10])) | s11 & (~(|f1_op2_data[30:23])) | s12 & (~(|f1_op2_data[62:52]));
assign s22 = ~s20;
assign s23 = ~s21;
assign s24 = s10 & f1_op1_data[15] | s11 & f1_op1_data[31] | s12 & f1_op1_data[63];
assign s25 = s10 & f1_op2_data[15] | s11 & f1_op2_data[31] | s12 & f1_op2_data[63];
assign s40 = s2 ? s24 : s14 ? s16 : s13 ? s17 : (s6 | s8) ? 1'b0 : s24 ^ s25;
assign s68 = {54{s10 & (~s7) & s34[0]}} & {2'd1,s64[51:42],42'd0} | {54{s11 & (~s7) & s34[0]}} & {2'd1,s64[51:29],29'd0} | {54{s12 & (~s7) & s34[0]}} & {2'd1,s64[51:0]} | {54{s10 & (s7 | ~s34[0])}} & {1'd1,s64[51:42],43'd0} | {54{s11 & (s7 | ~s34[0])}} & {1'd1,s64[51:29],30'd0} | {54{s12 & (s7 | ~s34[0])}} & {1'd1,s64[51:0],1'd0};
assign s67 = {53{s10}} & {1'd1,s65[51:42],42'd0} | {53{s11}} & {1'b1,s65[51:29],29'd0} | {53{s12}} & {1'b1,s65[51:0]};
wire s294 = s7 & f1_valid & ~f3_main_pipe_stall;
wire s295 = s8 & f1_valid & ~f3_main_pipe_stall;
assign s243 = 1'b0;
assign s66 = s10 ? 2'b10 : s11 ? 2'b01 : s12 ? 2'b00 : 2'b00;
wire s296 = kill;
kv_fpu_dsu #(
    .FLEN(FLEN)
) kv_fpu_dsu (
    .ds_busy(ds_busy),
    .ds_gen_sticky(ds_gen_sticky),
    .ds_calc_done(ds_calc_done),
    .ds_result0(ds_result0),
    .ds_result1(ds_result1),
    .ds_din0(ds_din0),
    .ds_din1(ds_din1[DS_DIN_MSB:1]),
    .div_enable(s294),
    .sqrt_enable(s295),
    .ds_invalidate(s296),
    .ds_type(s66),
    .f3_stall(s243),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n)
);
assign s58 = {s56[11],s56} - (({13{s70}} & 13'd15) | ({13{s71}} & 13'd127) | ({13{s72}} & 13'd1023));
assign s59 = {s56[11],s56};
assign s60 = {s57[11],s57};
assign s61 = s59 - s60;
assign s62 = s76 ? s61 : {s58[12],s58[12:1]};
assign s63 = s62 - 13'd1;
assign s49 = s70;
assign s50 = s71;
assign s51 = s72;
assign s102 = s253 + s254;
assign s84 = s102[(DS_DOUT_MSB - 1)];
assign s85 = |s102[(DS_DOUT_MSB - 1):0];
assign s99 = s146 ? s101 : s100;
assign s98 = s103 ? {s99[(DS_DOUT_MSB - 1):0],1'b0} : s99;
assign s97 = s118[DS_DOUT_MSB:0];
assign f3_stall = s144 & (ds_busy | s242 | f3_main_pipe_stall | (f4_frf_stall & s236));
assign s151 = (s95 & s103) ? s105 : s104;
assign s153 = s94;
assign s152 = s145 | s125;
assign s132 = ~s151[12] & (s151[11:0] > 12'd15);
assign s133 = ~s151[12] | (~s151[11:0] < 12'd14);
assign s134 = ~s151[12] | (~s151[11:0] < 12'd25);
assign s141 = ~s151[12] & (s151[11:0] > 12'd14);
assign s142 = ~s151[12] | (~s151[11:0] < 12'd15);
assign s143 = ~s151[12] | (~s151[11:0] < 12'd26);
assign s154 = (s91 & s132) | (s92 & s129) | (s93 & s126);
assign s155 = (s91 & s133) | (s92 & s130) | (s93 & s127);
assign s156 = (s91 & s134) | (s92 & s131) | (s93 & s128);
assign s157 = (s91 & s141) | (s92 & s138) | (s93 & s135);
assign s158 = (s91 & s142) | (s92 & s139) | (s93 & s136);
assign s159 = (s91 & s143) | (s92 & s140) | (s93 & s137);
assign s110 = ~s127 & s137;
assign s109 = ~s130 & s140;
assign s108 = ~s133 & s143;
assign s107 = (s91 & s108 | s92 & s109 | s93 & s110) & s144 & ~s242 & ~(s88 | s89 | s90);
assign s106 = ~s151 - (s91 ? 13'd13 : s92 ? 13'd125 : 13'd1021);
assign s111 = {6{s107}} & s106[5:0];
assign s112 = {s98[(DS_DOUT_MSB - 1):0],1'b0};
generate
    if (FLEN > 32) begin:gen_f3_sbs_l0_for_dp
        assign s113 = s111[5] ? {{32'b0},s112[DS_DOUT_MSB:32]} : s112;
        assign s119 = (s111[5] & (|s112[31:0]));
    end
    else begin:gen_f3_sbs_l0_for_hp_sp
        assign s113 = s112;
        assign s119 = 1'b0;
    end
endgenerate
generate
    if (FLEN > 16) begin:gen_f3_sbs_l1_for_dp_sp
        assign s114 = s111[4] ? {{16'b0},s113[DS_DOUT_MSB:16]} : s113;
        assign s120 = (s111[4] & (|s113[15:0]));
    end
    else begin:gen_f3_sbs_l1_for_hp
        assign s114 = s113;
        assign s120 = 1'b0;
    end
endgenerate
assign s115 = s111[3] ? {{8'b0},s114[DS_DOUT_MSB:8]} : s114;
assign s116 = s111[2] ? {{4'b0},s115[DS_DOUT_MSB:4]} : s115;
assign s117 = s111[1] ? {{2'b0},s116[DS_DOUT_MSB:2]} : s116;
assign s118 = s111[0] ? {{1'b0},s117[DS_DOUT_MSB:1]} : s117;
assign s121 = (s111[3] & (|s114[7:0]));
assign s122 = (s111[2] & (|s115[3:0]));
assign s123 = (s111[1] & (|s116[1:0]));
assign s124 = (s111[0] & (|s117[0]));
assign s125 = s124 | s123 | s122 | s121 | s120 | s119;
always @* begin
    case (s96)
        ROUND_RMM: s148 = ROUND_NEAREST;
        ROUND_RUP: s148 = ROUND_POS;
        ROUND_RDN: s148 = ROUND_NEG;
        ROUND_RTZ: s148 = ROUND_ZERO;
        default: s148 = ROUND_NEAREST;
    endcase
end

assign s149 = s148[0] & s148[1];
assign s150 = (~s153 & ~s148[0] & s148[1]) | (s153 & s148[0] & ~s148[1]);
assign s229 = |s191[(DSU_FRA_RND - 1):DSU_SRT_LSB];
assign s228 = s229 | s227;
assign s193 = s191[DSU_FRA_MSB:DSU_FRA_RND];
assign s192 = s193 + {{(DSU_FRA_MSB - DSU_FRA_RND){1'b0}},s202[1]} + {{(DSU_FRA_MSB - DSU_FRA_RND){1'b0}},s202[0]};
assign s201 = s191[DSU_FRA_RND];
assign s235 = s201 & ~s228;
assign s234 = s235 & (s161 == ROUND_RNE);
assign s233 = s234 ? 1'b0 : s192[DSU_FRA_LSB];
assign s194 = {s192[DSU_FRA_MSB:(DSU_FRA_LSB + 1)],s233};
assign s202 = {(s228 & s200),(s199 | s200)};
assign s203 = {(s202[1] & s202[0]),(s202[1] ^ s202[0])};
assign s231 = ~(|s191[DSU_SRT_MSB:DSU_SRT_LSB]);
assign s232 = ~(|s194[DSU_FRA_MSB:DSU_FRA_LSB]);
assign s171 = ~s167 & ~s165 & (s166 | s232 | (s218 & ~s219 & ((s161 == ROUND_RNE) | (s161 == ROUND_RMM) | (s161 == ROUND_RTZ) | ((s161 == ROUND_RUP) & s164) | ((s161 == ROUND_RDN) & ~s164))));
assign s174 = s218 & ~s219 & (((s161 == ROUND_RUP) & ~s164) | ((s161 == ROUND_RDN) & s164));
assign s172 = ~s167 & (s165 | (s217 & ((s161 == ROUND_RNE) | (s161 == ROUND_RMM) | ((s161 == ROUND_RDN) & s164) | ((s161 == ROUND_RUP) & ~s164))));
assign s173 = s217 & ((s161 == ROUND_RTZ) | ((s161 == ROUND_RUP) & s164) | ((s161 == ROUND_RDN) & ~s164));
assign s207 = s206 ? s213 : s210;
assign s208 = s206 ? s214 : s211;
assign s209 = s206 ? s215 : s212;
assign s175 = s165 | s167 | s166;
assign s217 = s207 & ~(s162 | s175);
assign s219 = ~s208 & s209;
assign s230 = s191[106];
assign s222 = s224 & ~(s203[1] | (s203[0] & s230));
assign s223 = s225 & (s228 | s201) & (s200 & !s199);
assign s226 = ~s204 - (s168 ? 12'd13 : s169 ? 12'd125 : s170 ? 12'd1021 : 12'd0);
assign s221 = (s226 == 12'b1) & (s222 | s223);
assign s218 = s219 & (s201 | s228) & (~s220 | s221) | (~s209 & ~(s162 | s163 | s175 | (s231 & ~s201 & ~s228)));
assign s216 = ~(s167 | s166) & ((s201 | s228) & ~(s163 | s165) | s217 | s218);
assign s195 = (s232 & ~s201 & ~s228 & ~s166) ? (s161 == ROUND_RDN) : s164;
assign s176 = s168 & s167;
assign s177 = s169 & s167;
assign s178 = s170 & s167;
assign s179 = s168 & s172;
assign s180 = s169 & s172;
assign s181 = s170 & s172;
assign s182 = s168 & s171;
assign s183 = s169 & s171;
assign s184 = s170 & s171;
assign s185 = s168 & s173;
assign s186 = s169 & s173;
assign s187 = s170 & s173;
assign s188 = s168 & s174;
assign s189 = s169 & s174;
assign s190 = s170 & s174;
assign s197 = ({64{s176}} & {48'hffffffffffff,1'b0,5'h1f,10'h200}) | ({64{s177}} & {32'hffffffff,1'b0,8'hff,23'h400000}) | ({64{s178}} & {1'b0,11'h7ff,52'h8000000000000}) | ({64{s179}} & {48'hffffffffffff,s164,5'h1f,10'h0}) | ({64{s180}} & {32'hffffffff,s164,8'hff,23'h0}) | ({64{s181}} & {s164,11'h7ff,52'h0}) | ({64{s182}} & {48'hffffffffffff,s195,5'h00,10'h0}) | ({64{s183}} & {32'hffffffff,s195,8'h00,23'h0}) | ({64{s184}} & {s195,11'h000,52'h0}) | ({64{s185}} & {48'hffffffffffff,s164,5'h1e,10'h3ff}) | ({64{s186}} & {32'hffffffff,s164,8'hfe,23'h7fffff}) | ({64{s187}} & {s164,11'h7fe,52'hfffffffffffff}) | ({64{s188}} & {48'hffffffffffff,s164,5'h00,10'h1}) | ({64{s189}} & {32'hffffffff,s164,8'h00,23'h1}) | ({64{s190}} & {s164,11'h000,52'h1});
assign s198 = s172 | s171 | s167 | s173 | s174;
assign f4_wdata = s45 ? s46 : s198 ? s197 : s196;
assign f4_wdata_en = s236 & (~kill | s237) | (s45 & s82);
assign f4_flag_set = s45 ? s47 : {(5){s236}} & {s163,s162,s217,s218,s216};
assign f4_result_type = s45 ? s48 : s160 ? 2'b11 : s170 ? 2'b10 : s169 ? 2'b01 : 2'b00;
generate
    if (FLEN == 64) begin:gen_fpu_dp
        assign s26 = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51:0] == 52'b0);
        assign s27 = (f1_op1_data[62:52] == 11'b0) & (f1_op1_data[51:0] != 52'b0);
        assign s28 = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[51]);
        assign s29 = (f1_op1_data[62:52] == 11'h7ff) & (f1_op1_data[50:0] != 51'b0) & ~f1_op1_data[51];
        assign s30 = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51:0] == 52'b0);
        assign s31 = (f1_op2_data[62:52] == 11'b0) & (f1_op2_data[51:0] != 52'b0);
        assign s32 = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[51]);
        assign s33 = (f1_op2_data[62:52] == 11'h7ff) & (f1_op2_data[50:0] != 51'b0) & ~f1_op2_data[51];
        assign ds_din0 = s68;
        assign ds_din1 = s67;
        assign s103 = s91 ? (s146 ? ~s101[13] : ~s100[13]) : s92 ? (s146 ? ~s101[26] : ~s100[26]) : (s146 ? ~s101[55] : ~s100[55]);
        assign s135 = ~s151[12] & (s151[11:0] > 12'd1022);
        assign s136 = ~s151[12] | (~s151[11:0] < 12'd1023);
        assign s137 = ~s151[12] | (~s151[11:0] < 12'd1076);
        assign s126 = ~s151[12] & (s151[11:0] > 12'd1023);
        assign s127 = ~s151[12] | (~s151[11:0] < 12'd1022);
        assign s128 = ~s151[12] | (~s151[11:0] < 12'd1075);
        assign s129 = ~s151[12] & (s151[11:0] > 12'd127);
        assign s130 = ~s151[12] | (~s151[11:0] < 12'd126);
        assign s131 = ~s151[12] | (~s151[11:0] < 12'd150);
        assign s138 = ~s151[12] & (s151[11:0] > 12'd126);
        assign s139 = ~s151[12] | (~s151[11:0] < 12'd127);
        assign s140 = ~s151[12] | (~s151[11:0] < 12'd151);
        assign s224 = s168 & (s191[117:107] == 11'h7ff) | s169 & (s191[130:107] == 24'hffffff) | s170 & (s191[159:107] == 53'h1fffffffffffff);
        assign s225 = s168 & (s191[117:107] == 11'h7fe) | s169 & (s191[130:107] == 24'hfffffe) | s170 & (s191[159:107] == 53'h1ffffffffffffe);
        assign s220 = s168 ? s194[118] : s169 ? s194[131] : s194[160];
        assign s206 = s170 & s192[161] | s169 & s192[132] | s168 & s192[119];
        assign s205 = s219 ? ({11'b0,s168 ? s194[118] : s169 ? s194[131] : s194[160]}) : (s204 + (s168 ? 12'd15 : s169 ? 12'd127 : 12'd1023) + {11'b0,s206});
        assign s196 = s168 ? {48'hffffffffffff,s164,s205[4:0],s194[117:108]} : s169 ? {32'hffffffff,s164,s205[7:0],s194[130:108]} : {s164,s205[10:0],s194[159:108]};
    end
    else if (FLEN == 32) begin:gen_fpu_sp
        assign s26 = 1'b0;
        assign s27 = 1'b0;
        assign s28 = 1'b0;
        assign s29 = 1'b0;
        assign s30 = 1'b0;
        assign s31 = 1'b0;
        assign s32 = 1'b0;
        assign s33 = 1'b0;
        assign ds_din0 = s68[53:29];
        assign ds_din1 = s67[53:30];
        assign s103 = s91 ? s146 ? ~s101[13] : ~s100[13] : s146 ? ~s101[26] : ~s100[26];
        assign s135 = 1'b0;
        assign s136 = 1'b0;
        assign s137 = 1'b0;
        assign s126 = 1'b0;
        assign s127 = 1'b0;
        assign s128 = 1'b0;
        assign s129 = ~s151[12] & (s151[11:0] > 12'd127);
        assign s130 = ~s151[12] | (~s151[11:0] < 12'd126);
        assign s131 = ~s151[12] | (~s151[11:0] < 12'd150);
        assign s138 = ~s151[12] & (s151[11:0] > 12'd126);
        assign s139 = ~s151[12] | (~s151[11:0] < 12'd127);
        assign s140 = ~s151[12] | (~s151[11:0] < 12'd151);
        assign s224 = s168 & (s191[117:107] == 11'h7ff) | s169 & (s191[130:107] == 24'hffffff);
        assign s225 = s168 & (s191[117:107] == 11'h7fe) | s169 & (s191[130:107] == 24'hfffffe);
        assign s206 = s169 & s192[132] | s168 & s192[119];
        assign s220 = s168 ? s194[118] : s194[131];
        assign s205 = s219 ? {11'b0,(s168 ? s194[118] : s194[131])} : (s204 + (s168 ? 12'd15 : 12'd127) + {11'b0,s206});
        assign s196 = s168 ? {48'hffffffffffff,s164,s205[4:0],s194[117:108]} : {32'hffffffff,s164,s205[7:0],s194[130:108]};
    end
    else begin:gen_fpu_hp
        assign s26 = 1'b0;
        assign s27 = 1'b0;
        assign s28 = 1'b0;
        assign s29 = 1'b0;
        assign s30 = 1'b0;
        assign s31 = 1'b0;
        assign s32 = 1'b0;
        assign s33 = 1'b0;
        assign ds_din0 = s68[53:42];
        assign ds_din1 = s67[53:43];
        assign s103 = s146 ? ~s101[13] : ~s100[13];
        assign s135 = 1'b0;
        assign s136 = 1'b0;
        assign s137 = 1'b0;
        assign s126 = 1'b0;
        assign s127 = 1'b0;
        assign s128 = 1'b0;
        assign s138 = 1'b0;
        assign s139 = 1'b0;
        assign s140 = 1'b0;
        assign s129 = 1'b0;
        assign s130 = 1'b0;
        assign s131 = 1'b0;
        assign s224 = (s191[117:107] == 11'h7ff);
        assign s225 = (s191[117:107] == 11'h7fe);
        assign s206 = s192[119];
        assign s220 = s194[118];
        assign s205 = s219 ? {11'b0,s194[118]} : (s204 + 12'd15 + {11'b0,s206});
        assign s196 = {48'hffffffffffff,s164,s205[4:0],s194[117:108]};
    end
endgenerate
generate
    if (FLEN == 16) begin:gen_fpu_hp_subnormal_input
        reg [5:0] s297;
        reg [5:0] s298;
        wire [3:0] s299 = {4{s20}} & s297[3:0];
        wire [3:0] s300 = {4{s21}} & s298[3:0];
        wire [9:0] s301 = f1_op1_data[9:0];
        wire [9:0] s302 = s299[0] ? {s301[9 - 1:0],1'd0} : s301;
        wire [9:0] s303 = s299[1] ? {s302[9 - 2:0],2'd0} : s302;
        wire [9:0] s304 = s299[2] ? {s303[9 - 4:0],4'd0} : s303;
        wire [9:0] s305 = s299[3] ? {s304[9 - 8:0],8'd0} : s304;
        wire [5:0] s306 = 6'd1 - s297;
        wire [9:0] s307 = f1_op2_data[9:0];
        wire [9:0] s308 = s300[0] ? {s307[9 - 1:0],1'd0} : s307;
        wire [9:0] s309 = s300[1] ? {s308[9 - 2:0],2'd0} : s308;
        wire [9:0] s310 = s300[2] ? {s309[9 - 4:0],4'd0} : s309;
        wire [9:0] s311 = s300[3] ? {s310[9 - 8:0],8'd0} : s310;
        wire [5:0] s312 = 6'd1 - s298;
        assign s36 = {s22,s305};
        assign s37 = {s23,s311};
        assign s64 = {s36[10:0],42'b0};
        assign s65 = {s37[10:0],42'b0};
        wire [5:0] s313 = {1'b0,f1_op1_data[14:10]};
        wire [5:0] s314 = {1'b0,f1_op2_data[14:10]};
        assign s34 = s18 ? 12'b0 : s20 ? {{6{s306[5]}},s306[5:0]} : {6'b0,s313};
        assign s35 = s19 ? 12'b0 : s21 ? {{6{s312[5]}},s312[5:0]} : {6'b0,s314};
        assign s56 = {{(7){s54[5]}},s54[4:0]};
        assign s57 = {{(7){s55[5]}},s55[4:0]};
        always @* begin
            casez (s301[9:0])
                {1'd1,{9{1'b?}}}: s297 = 6'd1;
                {2'd1,{8{1'b?}}}: s297 = 6'd2;
                {3'd1,{7{1'b?}}}: s297 = 6'd3;
                {4'd1,{6{1'b?}}}: s297 = 6'd4;
                {5'd1,{5{1'b?}}}: s297 = 6'd5;
                {6'd1,{4{1'b?}}}: s297 = 6'd6;
                {7'd1,{3{1'b?}}}: s297 = 6'd7;
                {8'd1,{2{1'b?}}}: s297 = 6'd8;
                {9'd1,{1{1'b?}}}: s297 = 6'd9;
                default: s297 = 6'd10;
            endcase
        end

        always @* begin
            casez (s307[9:0])
                {1'd1,{9{1'b?}}}: s298 = 6'd1;
                {2'd1,{8{1'b?}}}: s298 = 6'd2;
                {3'd1,{7{1'b?}}}: s298 = 6'd3;
                {4'd1,{6{1'b?}}}: s298 = 6'd4;
                {5'd1,{5{1'b?}}}: s298 = 6'd5;
                {6'd1,{4{1'b?}}}: s298 = 6'd6;
                {7'd1,{3{1'b?}}}: s298 = 6'd7;
                {8'd1,{2{1'b?}}}: s298 = 6'd8;
                {9'd1,{1{1'b?}}}: s298 = 6'd9;
                default: s298 = 6'd10;
            endcase
        end

    end
    else if (FLEN == 32) begin:gen_fpu_sp_subnormal_input
        wire [8:0] s315;
        wire [8:0] s316;
        wire [4:0] s299 = {5{s20}} & s315[4:0];
        wire [4:0] s300 = {5{s21}} & s316[4:0];
        wire [22:0] s317 = {23{s11}} & f1_op1_data[22:0] | {23{s10}} & {f1_op1_data[9:0],13'b0};
        wire [22:0] s318 = s299[0] ? {s317[22 - 1:0],1'd0} : s317;
        wire [22:0] s319 = s299[1] ? {s318[22 - 2:0],2'd0} : s318;
        wire [22:0] s320 = s299[2] ? {s319[22 - 4:0],4'd0} : s319;
        wire [22:0] s321 = s299[3] ? {s320[22 - 8:0],8'd0} : s320;
        wire [22:0] s322 = s299[4] ? {s321[22 - 16:0],16'd0} : s321;
        wire [8:0] s323 = 9'd1 - s315;
        wire [22:0] s324 = {23{s11}} & f1_op2_data[22:0] | {23{s10}} & {f1_op2_data[9:0],13'b0};
        wire [22:0] s325 = s300[0] ? {s324[22 - 1:0],1'd0} : s324;
        wire [22:0] s326 = s300[1] ? {s325[22 - 2:0],2'd0} : s325;
        wire [22:0] s327 = s300[2] ? {s326[22 - 4:0],4'd0} : s326;
        wire [22:0] s328 = s300[3] ? {s327[22 - 8:0],8'd0} : s327;
        wire [22:0] s329 = s300[4] ? {s328[22 - 16:0],16'd0} : s328;
        wire [8:0] s330 = 9'd1 - s316;
        assign s36 = {s22,s322};
        assign s37 = {s23,s329};
        assign s64 = {s36[23:0],29'b0};
        assign s65 = {s37[23:0],29'b0};
        wire [8:0] s313 = s11 ? {1'b0,f1_op1_data[30:23]} : {4'b0,f1_op1_data[14:10]};
        wire [8:0] s314 = s11 ? {1'b0,f1_op2_data[30:23]} : {4'b0,f1_op2_data[14:10]};
        assign s34 = s18 ? 12'b0 : s20 ? {{3{s323[8]}},s323[8:0]} : {3'b0,s313};
        assign s35 = s19 ? 12'b0 : s21 ? {{3{s330[8]}},s330[8:0]} : {3'b0,s314};
        assign s56 = {{(4){s54[8]}},s54[7:0]};
        assign s57 = {{(4){s55[8]}},s55[7:0]};
        wire [31:0] s331;
        wire [15:0] s332;
        wire [7:0] s333;
        wire [3:0] s334;
        wire [1:0] s335;
        wire [4:0] s336;
        assign s336[4] = ~|s331[31:16];
        assign s336[3] = ~|s332[15:8];
        assign s336[2] = ~|s333[7:4];
        assign s336[1] = ~|s334[3:2];
        assign s336[0] = ~s335[1];
        assign s331 = {1'b0,s317[22:0],8'b0};
        assign s332 = s336[4] ? s331[15:0] : s331[31:16];
        assign s333 = s336[3] ? s332[7:0] : s332[15:8];
        assign s334 = s336[2] ? s333[3:0] : s333[7:4];
        assign s335 = s336[1] ? s334[1:0] : s334[3:2];
        assign s315 = {4'b0,s336[4:0]};
        wire [31:0] s337;
        wire [15:0] s338;
        wire [7:0] s339;
        wire [3:0] s340;
        wire [1:0] s341;
        wire [4:0] s342;
        assign s342[4] = ~|s337[31:16];
        assign s342[3] = ~|s338[15:8];
        assign s342[2] = ~|s339[7:4];
        assign s342[1] = ~|s340[3:2];
        assign s342[0] = ~s341[1];
        assign s337 = {1'b0,s324[22:0],8'b0};
        assign s338 = s342[4] ? s337[15:0] : s337[31:16];
        assign s339 = s342[3] ? s338[7:0] : s338[15:8];
        assign s340 = s342[2] ? s339[3:0] : s339[7:4];
        assign s341 = s342[1] ? s340[1:0] : s340[3:2];
        assign s316 = {4'b0,s342[4:0]};
    end
    else begin:gen_fpu_dp_subnormal_input
        wire [11:0] s343;
        wire [11:0] s344;
        wire [5:0] s299 = {6{s20}} & s343[5:0];
        wire [5:0] s300 = {6{s21}} & s344[5:0];
        wire [51:0] s345 = {52{s12}} & f1_op1_data[51:0] | {52{s11}} & {f1_op1_data[22:0],29'b0} | {52{s10}} & {f1_op1_data[9:0],42'b0};
        wire [51:0] s346 = s299[0] ? {s345[51 - 1:0],1'd0} : s345;
        wire [51:0] s347 = s299[1] ? {s346[51 - 2:0],2'd0} : s346;
        wire [51:0] s348 = s299[2] ? {s347[51 - 4:0],4'd0} : s347;
        wire [51:0] s349 = s299[3] ? {s348[51 - 8:0],8'd0} : s348;
        wire [51:0] s350 = s299[4] ? {s349[51 - 16:0],16'd0} : s349;
        wire [51:0] s351 = s299[5] ? {s350[51 - 32:0],32'd0} : s350;
        wire [11:0] s352 = 12'd1 - s343;
        wire [51:0] s353 = {52{s12}} & f1_op2_data[51:0] | {52{s11}} & {f1_op2_data[22:0],29'b0} | {52{s10}} & {f1_op2_data[9:0],42'b0};
        wire [51:0] s354 = s300[0] ? {s353[51 - 1:0],1'd0} : s353;
        wire [51:0] s355 = s300[1] ? {s354[51 - 2:0],2'd0} : s354;
        wire [51:0] s356 = s300[2] ? {s355[51 - 4:0],4'd0} : s355;
        wire [51:0] s357 = s300[3] ? {s356[51 - 8:0],8'd0} : s356;
        wire [51:0] s358 = s300[4] ? {s357[51 - 16:0],16'd0} : s357;
        wire [51:0] s359 = s300[5] ? {s358[51 - 32:0],32'd0} : s358;
        wire [11:0] s360 = 12'd1 - s344;
        assign s36 = {s22,s351};
        assign s37 = {s23,s359};
        assign s64 = s36[52:0];
        assign s65 = s37[52:0];
        wire [11:0] s313 = {12{s12}} & {1'b0,f1_op1_data[62:52]} | {12{s11}} & {4'b0,f1_op1_data[30:23]} | {12{s10}} & {7'b0,f1_op1_data[14:10]};
        wire [11:0] s314 = {12{s12}} & {1'b0,f1_op2_data[62:52]} | {12{s11}} & {4'b0,f1_op2_data[30:23]} | {12{s10}} & {7'b0,f1_op2_data[14:10]};
        assign s34 = s18 ? 12'b0 : s20 ? s352[11:0] : s313;
        assign s35 = s19 ? 12'b0 : s21 ? s360[11:0] : s314;
        assign s56 = s54[11:0];
        assign s57 = s55[11:0];
        wire [63:0] s361;
        wire [31:0] s331;
        wire [15:0] s332;
        wire [7:0] s333;
        wire [3:0] s334;
        wire [1:0] s335;
        wire s362;
        wire [1:0] s363;
        wire [1:0] s364;
        wire [1:0] s365;
        wire [1:0] s366;
        wire [5:0] s336;
        assign s361 = {1'b0,s345[51:0],11'b0};
        assign s362 = ~|s361[63:32];
        assign s363[1] = ~|s361[31:16];
        assign s363[0] = ~|s361[63:48];
        assign s364[1] = s336[5] ? ~|s361[15:8] : ~|s361[47:40];
        assign s364[0] = s336[5] ? ~|s361[31:24] : ~|s361[63:56];
        assign s365[1] = ((s336[5:4] == 2'b11) & (~|s361[7:4])) | ((s336[5:4] == 2'b10) & (~|s361[23:20])) | ((s336[5:4] == 2'b01) & (~|s361[39:36])) | ((s336[5:4] == 2'b00) & (~|s361[55:52]));
        assign s365[0] = ((s336[5:4] == 2'b11) & (~|s361[15:12])) | ((s336[5:4] == 2'b10) & (~|s361[31:28])) | ((s336[5:4] == 2'b01) & (~|s361[47:44])) | ((s336[5:4] == 2'b00) & (~|s361[63:60]));
        assign s366[1] = ((s336[5:3] == 3'b111) & (~|s361[3:2])) | ((s336[5:3] == 3'b110) & (~|s361[11:10])) | ((s336[5:3] == 3'b101) & (~|s361[19:18])) | ((s336[5:3] == 3'b100) & (~|s361[27:26])) | ((s336[5:3] == 3'b011) & (~|s361[35:34])) | ((s336[5:3] == 3'b010) & (~|s361[43:42])) | ((s336[5:3] == 3'b001) & (~|s361[51:50])) | ((s336[5:3] == 3'b000) & (~|s361[59:58]));
        assign s366[0] = ((s336[5:3] == 3'b111) & (~|s361[7:6])) | ((s336[5:3] == 3'b110) & (~|s361[15:14])) | ((s336[5:3] == 3'b101) & (~|s361[23:22])) | ((s336[5:3] == 3'b100) & (~|s361[31:30])) | ((s336[5:3] == 3'b011) & (~|s361[39:38])) | ((s336[5:3] == 3'b010) & (~|s361[47:46])) | ((s336[5:3] == 3'b001) & (~|s361[55:54])) | ((s336[5:3] == 3'b000) & (~|s361[63:62]));
        assign s336[5] = s362;
        assign s336[4] = s336[5] ? s363[1] : s363[0];
        assign s336[3] = s336[4] ? s364[1] : s364[0];
        assign s336[2] = s336[3] ? s365[1] : s365[0];
        assign s336[1] = s336[2] ? s366[1] : s366[0];
        assign s336[0] = ~s335[1];
        assign s331 = s336[5] ? s361[31:0] : s361[63:32];
        assign s332 = s336[4] ? s331[15:0] : s331[31:16];
        assign s333 = s336[3] ? s332[7:0] : s332[15:8];
        assign s334 = s336[2] ? s333[3:0] : s333[7:4];
        assign s335 = s336[1] ? s334[1:0] : s334[3:2];
        assign s343 = {6'b0,s336[5:0]};
        wire [63:0] s367;
        wire [31:0] s337;
        wire [15:0] s338;
        wire [7:0] s339;
        wire [3:0] s340;
        wire [1:0] s341;
        wire s368;
        wire [1:0] s369;
        wire [1:0] s370;
        wire [1:0] s371;
        wire [1:0] s372;
        wire [5:0] s342;
        assign s367 = {1'b0,s353[51:0],11'b0};
        assign s368 = ~|s367[63:32];
        assign s369[1] = ~|s367[31:16];
        assign s369[0] = ~|s367[63:48];
        assign s370[1] = s342[5] ? ~|s367[15:8] : ~|s367[47:40];
        assign s370[0] = s342[5] ? ~|s367[31:24] : ~|s367[63:56];
        assign s371[1] = ((s342[5:4] == 2'b11) & (~|s367[7:4])) | ((s342[5:4] == 2'b10) & (~|s367[23:20])) | ((s342[5:4] == 2'b01) & (~|s367[39:36])) | ((s342[5:4] == 2'b00) & (~|s367[55:52]));
        assign s371[0] = ((s342[5:4] == 2'b11) & (~|s367[15:12])) | ((s342[5:4] == 2'b10) & (~|s367[31:28])) | ((s342[5:4] == 2'b01) & (~|s367[47:44])) | ((s342[5:4] == 2'b00) & (~|s367[63:60]));
        assign s372[1] = ((s342[5:3] == 3'b111) & (~|s367[3:2])) | ((s342[5:3] == 3'b110) & (~|s367[11:10])) | ((s342[5:3] == 3'b101) & (~|s367[19:18])) | ((s342[5:3] == 3'b100) & (~|s367[27:26])) | ((s342[5:3] == 3'b011) & (~|s367[35:34])) | ((s342[5:3] == 3'b010) & (~|s367[43:42])) | ((s342[5:3] == 3'b001) & (~|s367[51:50])) | ((s342[5:3] == 3'b000) & (~|s367[59:58]));
        assign s372[0] = ((s342[5:3] == 3'b111) & (~|s367[7:6])) | ((s342[5:3] == 3'b110) & (~|s367[15:14])) | ((s342[5:3] == 3'b101) & (~|s367[23:22])) | ((s342[5:3] == 3'b100) & (~|s367[31:30])) | ((s342[5:3] == 3'b011) & (~|s367[39:38])) | ((s342[5:3] == 3'b010) & (~|s367[47:46])) | ((s342[5:3] == 3'b001) & (~|s367[55:54])) | ((s342[5:3] == 3'b000) & (~|s367[63:62]));
        assign s342[5] = s368;
        assign s342[4] = s342[5] ? s369[1] : s369[0];
        assign s342[3] = s342[4] ? s370[1] : s370[0];
        assign s342[2] = s342[3] ? s371[1] : s371[0];
        assign s342[1] = s342[2] ? s372[1] : s372[0];
        assign s342[0] = ~s341[1];
        assign s337 = s342[5] ? s367[31:0] : s367[63:32];
        assign s338 = s342[4] ? s337[15:0] : s337[31:16];
        assign s339 = s342[3] ? s338[7:0] : s338[15:8];
        assign s340 = s342[2] ? s339[3:0] : s339[7:4];
        assign s341 = s342[1] ? s340[1:0] : s340[3:2];
        assign s344 = {6'b0,s342[5:0]};
    end
endgenerate
assign s0 = 1'b0;
assign s1 = 1'b0;
assign s3 = 12'b0;
assign s4 = 1'b0;
assign s46 = 64'h0;
assign s47 = 5'h0;
assign s48 = 2'b0;
endmodule

