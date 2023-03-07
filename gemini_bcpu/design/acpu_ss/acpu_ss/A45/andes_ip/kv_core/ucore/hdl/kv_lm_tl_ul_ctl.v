// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_tl_ul_ctl (
    lm_clk,
    lm_clk_en,
    lm_reset_n,
    lm_standby_ready,
    lm_pfm_event,
    lm_async_write_error,
    csr_eccen,
    csr_rwecc,
    csr_mecc_code_code,
    a_valid,
    a_stall,
    a_addr,
    a_mask,
    a_func,
    a_user,
    a_source,
    a_ready,
    w_valid,
    w_data,
    w_mask,
    w_ready,
    d_valid,
    d_data,
    d_status,
    d_user,
    lm_a_valid,
    lm_a_ready,
    lm_a_addr,
    lm_a_data,
    lm_a_opcode,
    lm_a_mask,
    lm_a_size,
    lm_a_user,
    lm_a_parity0,
    lm_a_parity1,
    lm_d_valid,
    lm_d_ready,
    lm_d_data,
    lm_d_parity0,
    lm_d_parity1,
    lm_d_denied,
    sb_empty,
    sb_full,
    sb_cmp_addr,
    sb_hit_data,
    sb_hit_mask,
    sb_hit,
    sb_enq_valid,
    sb_enq_ent,
    sb_enq_addr,
    sb_enq_data,
    sb_enq_mask,
    sb_enq_ready,
    sb_drn_valid,
    sb_drn_ready,
    sb_drn_addr,
    sb_drn_mask,
    sb_drn_data
);
parameter DW = 64;
parameter BLOCKS = 1;
parameter RAM_AW = 8;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter SB_DEPTH = 6;
parameter SOURCE_BITS = 4;
localparam SW = SOURCE_BITS;
localparam ECCW = ((DW == 64) && (BLOCKS == 1)) ? 8 : 7;
localparam ARB_REQ = 0;
localparam ARB_DRN = 1;
localparam ARB_BITS = 2;
input lm_clk;
input lm_clk_en;
input lm_reset_n;
output lm_standby_ready;
output lm_pfm_event;
output lm_async_write_error;
input [1:0] csr_eccen;
input csr_rwecc;
input [7:0] csr_mecc_code_code;
input a_valid;
input a_stall;
input [RAM_AW - 1:0] a_addr;
input [BLOCKS - 1:0] a_mask;
input [2:0] a_func;
input [UW - 1:0] a_user;
input [SOURCE_BITS - 1:0] a_source;
output a_ready;
input w_valid;
input [DW - 1:0] w_data;
input [DW / 8 - 1:0] w_mask;
output w_ready;
output d_valid;
output [DW - 1:0] d_data;
output [13:0] d_status;
output [UW - 1:0] d_user;
output lm_a_valid;
input lm_a_ready;
output [RAM_AW + 2:3] lm_a_addr;
output [DW - 1:0] lm_a_data;
output [2:0] lm_a_opcode;
output [DW / 8 - 1:0] lm_a_mask;
output [2:0] lm_a_size;
output [1:0] lm_a_user;
output [7:0] lm_a_parity0;
output [7:0] lm_a_parity1;
input lm_d_valid;
output lm_d_ready;
input [DW - 1:0] lm_d_data;
input [7:0] lm_d_parity0;
input [7:0] lm_d_parity1;
input lm_d_denied;
input sb_empty;
input sb_full;
output [RAM_AW - 1:0] sb_cmp_addr;
input [DW - 1:0] sb_hit_data;
input [(DW / 8) - 1:0] sb_hit_mask;
input [SB_DEPTH - 1:0] sb_hit;
output sb_enq_valid;
output [SB_DEPTH - 1:0] sb_enq_ent;
output [RAM_AW - 1:0] sb_enq_addr;
output [DW + 1:0] sb_enq_data;
output [(DW / 8) - 1:0] sb_enq_mask;
input sb_enq_ready;
input sb_drn_valid;
output sb_drn_ready;
input [RAM_AW - 1:0] sb_drn_addr;
input [(DW / 8) - 1:0] sb_drn_mask;
input [DW + 1:0] sb_drn_data;


wire s0 = ((ECC_TYPE_INT == 2));
wire s1;
wire s2;
wire s3;
wire [RAM_AW - 1:0] s4;
wire [(DW / 8 - 1):0] s5;
wire [DW - 1:0] s6;
wire [SW - 1:0] s7;
reg lm_pfm_event;
wire s8 = a_valid;
wire s9 = a_stall;
wire [RAM_AW - 1:0] s10 = a_addr;
wire [BLOCKS - 1:0] s11 = a_mask;
wire [UW - 1:0] s12 = a_user;
wire [SW - 1:0] s13 = a_source;
wire [2:0] s14 = a_func;
wire s15 = s14[0];
wire s16 = s14[1];
wire s17 = s14[2];
wire s18 = (csr_eccen == 2'd2) | (csr_eccen == 2'd3);
wire s19;
wire s20;
reg s21;
reg [RAM_AW - 1:0] s22;
reg [BLOCKS - 1:0] s23;
reg [UW - 1:0] s24;
reg [SW - 1:0] s25;
reg s26;
reg s27;
reg s28;
wire [DW - 1:0] s29;
wire [(DW / 8) - 1:0] s30;
wire [SB_DEPTH - 1:0] s31;
reg s32;
wire s33;
wire s34;
reg s35;
reg [RAM_AW - 1:0] s36;
reg [BLOCKS - 1:0] s37;
reg [UW - 1:0] s38;
reg [SW - 1:0] s39;
reg s40;
reg s41;
reg s42;
reg [(DW / 8) - 1:0] s43;
reg [SB_DEPTH - 1:0] s44;
wire s45 = |s44;
wire [DW - 1:0] s46;
reg [DW - 1:0] s47;
wire [DW - 1:0] s48;
wire [DW - 1:0] s49;
wire [DW - 1:0] s50;
wire s51;
wire [(DW / 8) - 1:0] s52;
wire s53;
reg s54;
wire s55;
wire s56;
wire s57;
wire s58;
wire s59;
wire [DW / 8 - 1:0] s60;
wire [DW - 1:0] s61;
reg s62;
wire [ARB_BITS - 1:0] s63;
wire [ARB_BITS - 1:0] s64;
wire [ARB_BITS - 1:0] s65;
wire s66;
wire s67;
wire s68;
wire [RAM_AW - 1:0] s69;
wire [(DW / 8) - 1:0] s70;
wire [SW - 1:0] s71;
wire s72;
wire s73;
wire s74;
wire [RAM_AW - 1:0] s75;
wire [(DW / 8) - 1:0] s76;
wire [SW - 1:0] s77;
wire s78 = s56;
wire s79;
wire s80;
wire [7:0] s81;
wire [1:0] s82;
wire s83;
wire [BLOCKS - 1:0] s84;
wire [BLOCKS - 1:0] s85;
wire s86;
wire [ECCW - 1:0] s87;
wire s88;
wire s89;
wire [DW - 1:0] s90;
wire s91;
wire s92;
wire [ECCW - 1:0] s93;
wire [ECCW - 1:0] s94;
wire s95;
wire [(ECCW * BLOCKS) - 1:0] s96;
wire [DW - 1:0] s97;
wire [(ECCW * BLOCKS) - 1:0] s98;
reg s99;
wire s100;
wire s101;
wire s102;
wire s103;
reg [RAM_AW - 1:0] s104;
reg [DW - 1:0] s105;
reg s106;
reg [DW / 8 - 1:0] s107;
reg [1:0] s108;
wire s109;
wire s110;
wire s111;
wire s112;
reg [1:0] s113;
wire [1:0] s114;
wire s115;
wire s116;
wire s117;
wire nds_unused_lm_wr_q_wready;
wire s118;
wire s119;
reg s120;
wire s121;
wire s122;
assign lm_standby_ready = sb_empty & ~s21 & ~s35 & ~s99 & (s113 == 2'b00);
assign a_ready = ~s19 & ~s59 & ~s99 & (s113 != 2'b11);
assign s19 = sb_full | (csr_rwecc & s21) | (csr_rwecc & s35) | (csr_rwecc & ~sb_empty);
assign s20 = s8 & ~s9 & ~s19 & ~s99 & (s113 != 2'b11);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s21 <= 1'b0;
    end
    else if (~s59) begin
        s21 <= s20;
    end
end

always @(posedge lm_clk) begin
    if (s34) begin
        s22 <= s10;
        s23 <= s11;
        s24 <= s12;
        s25 <= s13;
        s26 <= s15;
        s27 <= s16;
        s28 <= s17;
        s32 <= s15 & s18;
    end
end

assign s34 = s20 & ~s59;
assign sb_cmp_addr = s22;
assign s29 = sb_hit_data;
assign s30 = sb_hit_mask;
assign s31 = sb_hit;
assign s33 = s35 & s56;
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_m2_lm_recc_32
        assign s98 = s93;
        wire nds_unused_parity = |s94;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_m2_lm_recc_64
        assign s98 = s93;
        wire nds_unused_parity = |s94;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_m2_lm_recc_32x2
        assign s98 = {s94,s93};
    end
    else begin:gen_m2_lm_recc_stub
        wire nds_unused_parity = (|s94) | (|s93);
        assign s98 = {ECCW * BLOCKS{1'b0}};
    end
endgenerate
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s35 <= 1'b0;
    end
    else if (~s59) begin
        s35 <= s21;
    end
end

always @(posedge lm_clk) begin
    if (s57) begin
        s36 <= s22;
        s37 <= s23;
        s38 <= s24;
        s39 <= s25;
        s41 <= s27;
        s42 <= s28;
        s40 <= s26;
        s44 <= s31;
        s62 <= s32;
    end
end

always @(posedge lm_clk) begin
    if (s53) begin
        s54 <= s55;
    end
end

always @(posedge lm_clk) begin
    if (s58) begin
        s47 <= s29;
        s43 <= s30;
    end
end

assign s96 = s98;
assign s97 = s90;
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_m2_sb_rmask_bit (
    .out(s46),
    .in(s43)
);
assign s57 = s21 & ~s59;
assign s58 = s21 & ~s59 & s26;
assign s49 = (~s46 & s97[DW - 1:0]) | (s47[DW - 1:0]);
assign s50 = (~s46 & s48[DW - 1:0]) | (s47[DW - 1:0]);
assign s89 = 1'b0;
assign s59 = (s40 & s35 & ~s91) | (s35 & s41 & ~w_valid) | (~lm_clk_en) | s89;
assign s56 = s54 | (s41 & sb_full);
assign s53 = (s35 & s59) | s57;
assign s55 = s59 ? s56 : s33;
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_eccdec32
        wire [(BLOCKS * ECCW) - 1:0] s123;
        wire [(BLOCKS * ECCW) - 1:0] s124;
        wire s125;
        wire s126;
        wire [6:0] nds_unused_parout;
        wire nds_unused_error;
        wire nds_unused_invalidate;
        wire nds_unused_replay;
        wire nds_unused_xcpt;
        kv_eccdec32 u_eccdec32(
            .data(s97[31:0]),
            .parin(s96[6:0]),
            .check_en(s62),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s48[31:0]),
            .parout(nds_unused_parout),
            .sec(s125),
            .ded(s126),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
        kv_eccenc32 u_sb_ecc_bits(
            .data(s47),
            .dataout(s123)
        );
        assign s124 = s96[6:0];
        assign s84[0] = ~(s45 & s43[0]) & s125;
        assign s85[0] = ~(s45 & s43[0]) & s126;
        assign s81 = s45 & s43[0] ? {1'b0,s123} : {1'b0,s124};
        assign s79 = s84[0];
        assign s80 = s85[0];
        assign s82 = {2{s84[0] | s85[0]}};
        assign s51 = s84[0];
        assign s52 = {4{s40}};
        wire [BLOCKS - 1:0] s127 = s37;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_ecc64
        wire [(BLOCKS * ECCW) - 1:0] s123;
        wire [(BLOCKS * ECCW) - 1:0] s124;
        wire s125;
        wire s126;
        wire [7:0] nds_unused_parout;
        wire nds_unused_error;
        wire nds_unused_invalidate;
        wire nds_unused_replay;
        wire nds_unused_xcpt;
        kv_eccdec64 u_eccdec64(
            .data(s97[63:0]),
            .parin(s96[7:0]),
            .check_en(s62),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s48[63:0]),
            .parout(nds_unused_parout),
            .sec(s125),
            .ded(s126),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
        kv_eccenc64 u_sb_ecc_bits(
            .data(s47),
            .dataout(s123)
        );
        assign s124 = s96[7:0];
        assign s84[0] = ~(s45 & s43[0]) & s125;
        assign s85[0] = ~(s45 & s43[0]) & s126;
        assign s79 = s84[0];
        assign s80 = s85[0];
        assign s82 = {2{s84[0] | s85[0]}};
        assign s81 = s45 & s43[0] ? s123 : s124;
        assign s51 = s84[0];
        assign s52 = {8{s40}};
        wire [BLOCKS - 1:0] s127 = s37;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_ecc32x2
        wire [7:0] s128;
        wire [7:0] s129;
        wire [(ECCW * BLOCKS) - 1:0] s130;
        wire [1:0] s125;
        wire [1:0] s126;
        wire [6:0] nds_unused_b0_parout;
        wire nds_unused_b0_error;
        wire nds_unused_b0_invalidate;
        wire nds_unused_b0_replay;
        wire nds_unused_b0_xcpt;
        wire [6:0] nds_unused_b1_parout;
        wire nds_unused_b1_error;
        wire nds_unused_b1_invalidate;
        wire nds_unused_b1_replay;
        wire nds_unused_b1_xcpt;
        kv_eccdec32 u_eccdec32_bank0(
            .data(s97[31:0]),
            .parin(s96[6:0]),
            .check_en(s62),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s48[31:0]),
            .parout(nds_unused_b0_parout),
            .sec(s125[0]),
            .ded(s126[0]),
            .error(nds_unused_b0_error),
            .invalidate(nds_unused_b0_invalidate),
            .replay(nds_unused_b0_replay),
            .xcpt(nds_unused_b0_xcpt)
        );
        kv_eccdec32 u_eccdec32_bank1(
            .data(s97[63:32]),
            .parin(s96[13:7]),
            .check_en(s62),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s48[63:32]),
            .parout(nds_unused_b1_parout),
            .sec(s125[1]),
            .ded(s126[1]),
            .error(nds_unused_b1_error),
            .invalidate(nds_unused_b1_invalidate),
            .replay(nds_unused_b1_replay),
            .xcpt(nds_unused_b1_xcpt)
        );
        kv_eccenc32 u_sb_ecc_bank0(
            .data(s47[31:0]),
            .dataout(s130[0 +:ECCW])
        );
        kv_eccenc32 u_sb_ecc_bank1(
            .data(s47[63:32]),
            .dataout(s130[ECCW +:ECCW])
        );
        assign s84[0] = ~(s45 & s43[0]) & s125[0];
        assign s85[0] = ~(s45 & s43[0]) & s126[0];
        assign s84[1] = ~(s45 & s43[4]) & s125[1];
        assign s85[1] = ~(s45 & s43[4]) & s126[1];
        assign s82 = {{s84[1] | s85[1]},{s84[0] | s85[0]}};
        assign s128 = s45 & s43[0] ? {1'b0,s130[6:0]} : {1'b0,s96[6:0]};
        assign s129 = s45 & s43[4] ? {1'b0,s130[13:7]} : {1'b0,s96[13:7]};
        assign s79 = (s37[0] & s84[0]) | (s37[1] & s84[1]);
        assign s80 = (s37[0] & s85[0]) | (s37[1] & s85[1]);
        assign s81 = s37[0] ? s128 : s129;
        assign s51 = (s37[0] & s84[0]) | (s37[1] & s84[1]);
        assign s52[3:0] = {4{s40 & s37[0]}};
        assign s52[7:4] = {4{s40 & s37[1]}};
    end
    else begin:gen_ecc_none
        assign s48 = s97[DW - 1:0];
        assign s84 = {BLOCKS{1'b0}};
        assign s85 = {BLOCKS{1'b0}};
        assign s81 = 8'd0;
        assign s51 = 1'b0;
        assign s52 = {(DW / 8){1'b0}};
        assign s79 = 1'b0;
        assign s80 = 1'b0;
        assign s82 = 2'b0;
        wire [BLOCKS - 1:0] s131 = s84;
        wire [BLOCKS - 1:0] s132 = s85;
        wire nds_unused_m2_read = s40;
        wire nds_unused_m2_check_en = s62;
        wire [BLOCKS - 1:0] s127 = s37;
        wire nds_unused_m2_sb_hit_any = s45;
    end
endgenerate
assign d_data = s49;
assign d_user = s38;
assign d_status[0] = s78;
assign d_status[1] = s79 & ~s83;
assign d_status[2] = s80 & ~s83;
assign d_status[3 +:8] = s81;
assign d_status[11 +:2] = s82 & {2{~s83}};
assign d_status[13] = s83;
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s120 <= 1'b0;
    end
    else if (s122) begin
        s120 <= s121;
    end
end

assign s122 = lm_d_valid & lm_d_ready | s120;
assign s121 = s112 & lm_d_denied & ~s110;
assign lm_async_write_error = s120;
assign s88 = (s35 & s40 & s91) | (s35 & s41 & ~s40);
kv_stall_filter u_d_valid(
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .valid_pre(s88),
    .stall(s59),
    .valid(d_valid)
);
assign w_ready = s35 & s41 & lm_clk_en & ~(s40 & ~s91);
assign s63[ARB_REQ] = s8 & s15 & ~s19 & (s113 != 2'b11);
assign s63[ARB_DRN] = sb_drn_valid;
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb (
    .valid(s63),
    .ready(s64),
    .grant(s65)
);
kv_mux_onehot #(
    .N(2),
    .W(3 + RAM_AW + (DW / 8) + 2)
) u_ram_out (
    .out({s1,s2,s3,s4,s5,s7}),
    .in({s66,s67,s68,s69,s70,s71,s72,s73,s74,s75,s76,s77}),
    .sel({s65[ARB_DRN],s65[ARB_REQ]})
);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s113 <= 2'b0;
    end
    else if (s115) begin
        s113 <= s114;
    end
end

assign s115 = lm_a_valid & lm_a_ready | lm_d_ready & lm_d_valid;
assign s114 = s113 + {1'b0,lm_a_valid & lm_a_ready} - {1'b0,lm_d_ready & lm_d_valid};
assign s72 = s8 & s15 & ~s59 & ~s99 & (s113 != 2'b11);
assign s73 = s9;
assign s75 = s10;
assign s74 = 1'b0;
assign s76 = {(DW / 8){1'b0}};
assign s77 = s13;
assign s66 = sb_drn_valid & ~s59 & ~s99 & (s113 != 2'b11);
assign s67 = 1'b0;
assign s69 = sb_drn_addr;
assign s68 = 1'b1;
assign s70 = sb_drn_mask;
assign s71 = sb_drn_data[(DW + 1) -:2];
assign s6 = sb_drn_data[DW - 1:0];
always @(posedge lm_clk) begin
    lm_pfm_event <= lm_a_valid & lm_a_ready;
end

assign s100 = (s1 & ~s2 & ~s99 & ~lm_a_ready);
assign s101 = lm_a_ready;
assign s102 = (s99 & ~s101) | s100;
assign s103 = s100 | s101;
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s99 <= 1'b0;
    end
    else if (s103) begin
        s99 <= s102;
    end
end

always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s104 <= {RAM_AW{1'b0}};
        s105 <= {DW{1'b0}};
        s106 <= 1'b0;
        s107 <= {DW / 8{1'b0}};
        s108 <= 2'b0;
    end
    else if (s100) begin
        s104 <= s4;
        s105 <= s6;
        s106 <= s3;
        s107 <= s5;
        s108 <= s7;
    end
end

assign lm_a_valid = (s1 & ~s2 | s99);
assign lm_a_addr[RAM_AW + 2:3] = s99 ? s104 : s4;
assign lm_a_data = s99 ? s105 : s6;
assign lm_a_opcode = s99 ? s106 ? 3'd1 : 3'd4 : s3 ? 3'd1 : 3'd4;
assign lm_a_mask = s99 ? (s107 | {DW / 8{~s106}}) : (s5 | {DW / 8{~s3}});
assign lm_a_size = (DW == 64) ? 3'b11 : 3'b10;
assign lm_a_user = s99 ? s108 : s7;
assign s92 = s35 & s40 & ~(s41 & ~w_valid);
kv_fifo #(
    .DEPTH(2),
    .WIDTH(DW + 1 + ECCW * 2)
) u_lm_d_q (
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .flush(1'b0),
    .wdata({lm_d_denied,lm_d_parity0[ECCW - 1:0],lm_d_parity1[ECCW - 1:0],lm_d_data}),
    .wvalid(lm_d_valid & ~s112),
    .wready(lm_d_ready),
    .rdata({s95,s93,s94,s90}),
    .rvalid(s91),
    .rready(s92)
);
assign s116 = (lm_a_opcode == 3'd4);
assign s117 = ~(|lm_a_mask);
assign s118 = lm_a_valid & lm_a_ready;
assign s119 = lm_d_ready & lm_d_valid;
kv_fifo #(
    .DEPTH(3),
    .WIDTH(2)
) u_lm_wr_q (
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .flush(1'b0),
    .wdata({s116,s117}),
    .wvalid(s118),
    .wready(nds_unused_lm_wr_q_wready),
    .rdata({s109,s110}),
    .rvalid(s111),
    .rready(s119)
);
assign s112 = ~s109 & s111;
assign s83 = s35 & s40 & s91 & s95;
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_ram_wdata_ecc32
        wire [ECCW - 1:0] s133;
        wire [ECCW - 1:0] s134;
        reg [ECCW - 1:0] s135;
        kv_eccenc32 u_ecc32(
            .data(sb_drn_data[DW - 1:0]),
            .dataout(s133)
        );
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s135 <= {ECCW{1'b0}};
            end
            else if (s100) begin
                s135 <= s134;
            end
        end

        assign s134 = s86 ? s87 : s133;
        assign lm_a_parity0 = s99 ? {1'b0,s135} : {1'b0,s134};
        assign lm_a_parity1 = 8'b0;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_ram_wdata_ecc64
        wire [ECCW - 1:0] s133;
        wire [ECCW - 1:0] s134;
        reg [ECCW - 1:0] s135;
        kv_eccenc64 u_ecc64(
            .data(sb_drn_data[DW - 1:0]),
            .dataout(s133)
        );
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s135 <= 8'b0;
            end
            else if (s100) begin
                s135 <= s134[7:0];
            end
        end

        assign s134 = s86 ? s87 : s133;
        assign lm_a_parity0 = s99 ? s135 : s134;
        assign lm_a_parity1 = 8'b0;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_ram_wdata_ecc32x2
        wire [ECCW - 1:0] s133;
        wire [ECCW - 1:0] s136;
        wire [ECCW - 1:0] s137;
        wire [ECCW - 1:0] s138;
        reg [ECCW - 1:0] s139;
        reg [ECCW - 1:0] s140;
        kv_eccenc32 u_eccenc32_bank0(
            .data(sb_drn_data[31:0]),
            .dataout(s133)
        );
        kv_eccenc32 u_eccenc32_bank1(
            .data(sb_drn_data[63:32]),
            .dataout(s136)
        );
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s139 <= {ECCW{1'b0}};
                s140 <= {ECCW{1'b0}};
            end
            else if (s100) begin
                s139 <= s137;
                s140 <= s138;
            end
        end

        assign s137 = s86 ? s87 : s133;
        assign s138 = s86 ? s87 : s136;
        assign lm_a_parity0 = s99 ? {1'b0,s139} : {1'b0,s137};
        assign lm_a_parity1 = s99 ? {1'b0,s140} : {1'b0,s138};
    end
    else begin:gen_ran_wdata_no_ecc
        wire nds_unused_inject_ecc = |s87;
        assign lm_a_parity0 = 8'b0;
        assign lm_a_parity1 = 8'b0;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_inject
        reg s141;
        wire s142;
        wire s143;
        wire s144;
        wire s145;
        reg [ECCW - 1:0] s146;
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s141 <= 1'b0;
            end
            else if (s142) begin
                s141 <= s143;
            end
        end

        always @(posedge lm_clk) begin
            if (s144) begin
                s146 <= csr_mecc_code_code[ECCW - 1:0];
            end
        end

        assign s142 = s144 | s145;
        assign s144 = sb_enq_valid & s42;
        assign s145 = s65[ARB_DRN] & s64[ARB_DRN] & ~s59;
        assign s143 = s144 | (s141 & ~s145);
        assign s86 = s141;
        assign s87 = s146;
    end
    else begin:gen_inject_stub
        assign s86 = 1'b0;
        assign s87 = {ECCW{1'b0}};
        wire nds_unused_csr_mecc_code_code = |csr_mecc_code_code;
        wire nds_unused_m2_rwecc = s42;
    end
endgenerate
assign s60 = {(DW / 8){s41 & ~s79}} & w_mask;
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_m2_wmask_bit (
    .out(s61),
    .in(s60)
);
assign sb_drn_ready = s64[ARB_DRN] & ~s59 & ~s99 & (s113 != 2'b11);
assign sb_enq_valid = (s41 & ~s56 & w_valid & w_ready & ~s80 & ~s59 & ~s83) | (~s41 & ~s56 & s35 & s51 & ~s80 & ~s59 & ~s83);
assign sb_enq_ent = s44;
assign sb_enq_addr = s36;
assign sb_enq_mask = s60 | (~s60 & s52);
assign sb_enq_data = (({(DW + SW){~s0}} | {2'b11,s61}) & {s39,w_data}) | (({(DW + SW){s0}} & {2'b11,~s61}) & {s39,s50});
wire nds_unused_sb_enq_ready = sb_enq_ready;
endmodule

