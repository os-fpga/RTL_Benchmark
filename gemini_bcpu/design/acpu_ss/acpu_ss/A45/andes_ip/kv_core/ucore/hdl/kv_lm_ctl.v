// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_ctl (
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
    ram0_cs,
    ram0_we,
    ram0_addr,
    ram0_byte_we,
    ram0_user,
    ram0_wdata,
    ram0_rdata,
    ram1_cs,
    ram1_we,
    ram1_addr,
    ram1_byte_we,
    ram1_user,
    ram1_wdata,
    ram1_rdata,
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
parameter RAM_DW = 64;
parameter RAM_BWEW = 8;
parameter ECC_TYPE_INT = 0;
parameter UW = 1;
parameter SB_DEPTH = 6;
parameter SOURCE_BITS = 4;
localparam SW = SOURCE_BITS;
localparam ALSB = (DW == 64) ? 3 : 2;
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
output ram0_cs;
output ram0_we;
output [RAM_AW - 1:0] ram0_addr;
output [RAM_BWEW - 1:0] ram0_byte_we;
output [SOURCE_BITS - 1:0] ram0_user;
output [RAM_DW - 1:0] ram0_wdata;
input [RAM_DW - 1:0] ram0_rdata;
output ram1_cs;
output ram1_we;
output [RAM_AW - 1:0] ram1_addr;
output [RAM_BWEW - 1:0] ram1_byte_we;
output [SOURCE_BITS - 1:0] ram1_user;
output [RAM_DW - 1:0] ram1_wdata;
input [RAM_DW - 1:0] ram1_rdata;
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
wire [RAM_AW - 1:0] s3;
wire [(RAM_BWEW * BLOCKS) - 1:0] s4;
wire [DW - 1:0] s5;
wire [SW - 1:0] s6;
reg lm_pfm_event;
wire s7 = a_valid;
wire s8 = a_stall;
wire [RAM_AW - 1:0] s9 = a_addr;
wire [BLOCKS - 1:0] s10 = a_mask;
wire [UW - 1:0] s11 = a_user;
wire [SW - 1:0] s12 = a_source;
wire [2:0] s13 = a_func;
wire s14 = s13[0];
wire s15 = s13[1];
wire s16 = s13[2];
wire s17 = (csr_eccen == 2'd2) | (csr_eccen == 2'd3);
wire s18;
wire s19 = s7 & ~s8 & ~s18;
reg s20;
reg [RAM_AW - 1:0] s21;
reg [BLOCKS - 1:0] s22;
reg [UW - 1:0] s23;
reg [SW - 1:0] s24;
reg s25;
reg s26;
reg s27;
wire [DW - 1:0] s28;
wire [(DW / 8) - 1:0] s29;
wire [SB_DEPTH - 1:0] s30;
wire [DW - 1:0] s31;
wire [(ECCW * BLOCKS) - 1:0] s32;
reg s33;
wire s34;
wire s35;
reg s36;
reg [RAM_AW - 1:0] s37;
reg [BLOCKS - 1:0] s38;
reg [UW - 1:0] s39;
reg [SW - 1:0] s40;
reg s41;
reg s42;
reg s43;
reg [(DW / 8) - 1:0] s44;
reg [SB_DEPTH - 1:0] s45;
wire s46 = |s45;
wire [DW - 1:0] s47;
reg [DW - 1:0] s48;
reg [DW - 1:0] s49;
wire [(ECCW * BLOCKS) - 1:0] s50;
wire [DW - 1:0] s51;
wire [DW - 1:0] s52;
wire [DW - 1:0] s53;
wire s54;
wire [(DW / 8) - 1:0] s55;
wire s56;
reg s57;
wire s58;
wire s59;
wire s60;
wire s61;
wire s62;
wire [DW / 8 - 1:0] s63;
wire [DW - 1:0] s64;
reg s65;
wire [ARB_BITS - 1:0] s66;
wire [ARB_BITS - 1:0] s67;
wire [ARB_BITS - 1:0] s68;
wire s69;
wire s70;
wire [RAM_AW - 1:0] s71;
wire [(DW / 8) - 1:0] s72;
wire [SW - 1:0] s73;
wire s74;
wire s75;
wire [RAM_AW - 1:0] s76;
wire [(DW / 8) - 1:0] s77;
wire [SW - 1:0] s78;
wire s79 = s59;
wire s80;
wire s81;
wire [7:0] s82;
wire [1:0] s83;
wire [BLOCKS - 1:0] s84;
wire [BLOCKS - 1:0] s85;
wire s86;
wire [ECCW - 1:0] s87;
wire s88;
wire s89;
assign lm_standby_ready = sb_empty & ~s20 & ~s36;
assign a_ready = ~s18 & ~s62;
assign s18 = sb_full | (csr_rwecc & s20) | (csr_rwecc & s36) | (csr_rwecc & ~sb_empty);
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s20 <= 1'b0;
    end
    else if (~s62) begin
        s20 <= s19;
    end
end

always @(posedge lm_clk) begin
    if (s35) begin
        s21 <= s9;
        s22 <= s10;
        s23 <= s11;
        s24 <= s12;
        s25 <= s14;
        s26 <= s15;
        s27 <= s16;
        s33 <= s14 & s17;
    end
end

assign s35 = s19 & ~s62;
assign sb_cmp_addr = s21;
assign s28 = sb_hit_data;
assign s29 = sb_hit_mask;
assign s30 = sb_hit;
assign s34 = s36 & s59;
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_m1_ram_recc_32
        assign s32 = ram0_rdata[38:32];
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_m1_ram_recc_64
        assign s32 = ram0_rdata[71:64];
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_m1_ram_recc_32x2
        assign s32 = {ram1_rdata[38:32],ram0_rdata[38:32]};
    end
    else begin:gen_m1_ram_recc_stub
        assign s32 = {(ECCW * BLOCKS){1'b0}};
    end
endgenerate
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s36 <= 1'b0;
    end
    else if (~s62) begin
        s36 <= s20;
    end
end

always @(posedge lm_clk) begin
    if (s60) begin
        s37 <= s21;
        s38 <= s22;
        s39 <= s23;
        s40 <= s24;
        s42 <= s26;
        s43 <= s27;
        s41 <= s25;
        s45 <= s30;
        s65 <= s33;
    end
end

always @(posedge lm_clk) begin
    if (s56) begin
        s57 <= s58;
    end
end

always @(posedge lm_clk) begin
    if (s61) begin
        s49 <= s31;
        s48 <= s28;
        s44 <= s29;
    end
end

kv_dff_gen #(
    .EXPRESSION((ECC_TYPE_INT == 2)),
    .W(ECCW * BLOCKS)
) u_m2_ram_recc (
    .clk(lm_clk),
    .en(s61),
    .d(s32),
    .q(s50)
);
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_m2_sb_rmask_bit (
    .out(s47),
    .in(s44)
);
assign s60 = s20 & ~s62;
assign s61 = s20 & ~s62 & s25;
assign s52 = (~s47 & s49[DW - 1:0]) | (s48[DW - 1:0]);
assign s53 = (~s47 & s51[DW - 1:0]) | (s48[DW - 1:0]);
assign s89 = 1'b0;
assign s62 = (s36 & s42 & ~w_valid) | (~lm_clk_en) | s89;
assign s59 = s57 | (s42 & sb_full);
assign s56 = (s36 & s62) | s60;
assign s58 = s62 ? s59 : s34;
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_eccdec32
        wire [(BLOCKS * ECCW) - 1:0] s90;
        wire [(BLOCKS * ECCW) - 1:0] s91;
        wire s92;
        wire s93;
        wire [6:0] nds_unused_parout;
        wire nds_unused_error;
        wire nds_unused_invalidate;
        wire nds_unused_replay;
        wire nds_unused_xcpt;
        kv_eccdec32 u_eccdec32(
            .data(s49[31:0]),
            .parin(s50[6:0]),
            .check_en(s65),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s51[31:0]),
            .parout(nds_unused_parout),
            .sec(s92),
            .ded(s93),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
        kv_eccenc32 u_sb_ecc_bits(
            .data(s48),
            .dataout(s90)
        );
        assign s91 = s50[6:0];
        assign s84[0] = ~(s46 & s44[0]) & s92;
        assign s85[0] = ~(s46 & s44[0]) & s93;
        assign s82 = s46 & s44[0] ? {1'b0,s90} : {1'b0,s91};
        assign s80 = s84[0];
        assign s81 = s85[0];
        assign s83 = {2{s84[0] | s85[0]}};
        assign s54 = s84[0];
        assign s55 = {4{s41}};
        wire [BLOCKS - 1:0] s94 = s38;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_ecc64
        wire [(BLOCKS * ECCW) - 1:0] s90;
        wire [(BLOCKS * ECCW) - 1:0] s91;
        wire s92;
        wire s93;
        wire [7:0] nds_unused_parout;
        wire nds_unused_error;
        wire nds_unused_invalidate;
        wire nds_unused_replay;
        wire nds_unused_xcpt;
        kv_eccdec64 u_eccdec64(
            .data(s49[63:0]),
            .parin(s50[7:0]),
            .check_en(s65),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s51[63:0]),
            .parout(nds_unused_parout),
            .sec(s92),
            .ded(s93),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
        kv_eccenc64 u_sb_ecc_bits(
            .data(s48),
            .dataout(s90)
        );
        assign s91 = s50[7:0];
        assign s84[0] = ~(s46 & s44[0]) & s92;
        assign s85[0] = ~(s46 & s44[0]) & s93;
        assign s80 = s84[0];
        assign s81 = s85[0];
        assign s83 = {2{s84[0] | s85[0]}};
        assign s82 = s46 & s44[0] ? s90 : s91;
        assign s54 = s84[0];
        assign s55 = {8{s41}};
        wire [BLOCKS - 1:0] s94 = s38;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_ecc32x2
        wire [7:0] s95;
        wire [7:0] s96;
        wire [(ECCW * BLOCKS) - 1:0] s97;
        wire [1:0] s92;
        wire [1:0] s93;
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
            .data(s49[31:0]),
            .parin(s50[6:0]),
            .check_en(s65),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s51[31:0]),
            .parout(nds_unused_b0_parout),
            .sec(s92[0]),
            .ded(s93[0]),
            .error(nds_unused_b0_error),
            .invalidate(nds_unused_b0_invalidate),
            .replay(nds_unused_b0_replay),
            .xcpt(nds_unused_b0_xcpt)
        );
        kv_eccdec32 u_eccdec32_bank1(
            .data(s49[63:32]),
            .parin(s50[13:7]),
            .check_en(s65),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s51[63:32]),
            .parout(nds_unused_b1_parout),
            .sec(s92[1]),
            .ded(s93[1]),
            .error(nds_unused_b1_error),
            .invalidate(nds_unused_b1_invalidate),
            .replay(nds_unused_b1_replay),
            .xcpt(nds_unused_b1_xcpt)
        );
        kv_eccenc32 u_sb_ecc_bank0(
            .data(s48[31:0]),
            .dataout(s97[0 +:ECCW])
        );
        kv_eccenc32 u_sb_ecc_bank1(
            .data(s48[63:32]),
            .dataout(s97[ECCW +:ECCW])
        );
        assign s84[0] = ~(s46 & s44[0]) & s92[0];
        assign s85[0] = ~(s46 & s44[0]) & s93[0];
        assign s84[1] = ~(s46 & s44[4]) & s92[1];
        assign s85[1] = ~(s46 & s44[4]) & s93[1];
        assign s83 = {{s84[1] | s85[1]},{s84[0] | s85[0]}};
        assign s95 = s46 & s44[0] ? {1'b0,s97[6:0]} : {1'b0,s50[6:0]};
        assign s96 = s46 & s44[4] ? {1'b0,s97[13:7]} : {1'b0,s50[13:7]};
        assign s80 = (s38[0] & s84[0]) | (s38[1] & s84[1]);
        assign s81 = (s38[0] & s85[0]) | (s38[1] & s85[1]);
        assign s82 = s38[0] ? s95 : s96;
        assign s54 = (s38[0] & s84[0]) | (s38[1] & s84[1]);
        assign s55[3:0] = {4{s41 & s38[0]}};
        assign s55[7:4] = {4{s41 & s38[1]}};
    end
    else begin:gen_ecc_none
        assign s51 = s49[DW - 1:0];
        assign s84 = {BLOCKS{1'b0}};
        assign s85 = {BLOCKS{1'b0}};
        assign s82 = 8'd0;
        assign s54 = 1'b0;
        assign s55 = {(DW / 8){1'b0}};
        assign s80 = 1'b0;
        assign s81 = 1'b0;
        assign s83 = 2'b0;
        wire [BLOCKS - 1:0] s98 = s84;
        wire [BLOCKS - 1:0] s99 = s85;
        wire nds_unused_m2_read = s41;
        wire [(ECCW * BLOCKS) - 1:0] s100 = s50;
        wire nds_unused_m2_check_en = s65;
        wire [BLOCKS - 1:0] s94 = s38;
        wire nds_unused_m2_sb_hit_any = s46;
    end
endgenerate
assign d_data = s52;
assign d_user = s39;
assign d_status[0] = s79;
assign d_status[1] = s80;
assign d_status[2] = s81;
assign d_status[3 +:8] = s82;
assign d_status[11 +:2] = s83;
assign d_status[13] = 1'b0;
assign lm_async_write_error = 1'b0;
assign s88 = s36 & lm_clk_en;
kv_stall_filter u_d_valid(
    .clk(lm_clk),
    .reset_n(lm_reset_n),
    .valid_pre(s88),
    .stall(s62),
    .valid(d_valid)
);
assign w_ready = s36 & s42 & lm_clk_en;
assign s66[ARB_REQ] = s7 & s14 & ~s18;
assign s66[ARB_DRN] = sb_drn_valid;
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb (
    .valid(s66),
    .ready(s67),
    .grant(s68)
);
kv_mux_onehot #(
    .N(2),
    .W(2 + RAM_AW + (DW / 8) + 2)
) u_ram_out (
    .out({s1,s2,s3,s4,s6}),
    .in({s69,s70,s71,s72,s73,s74,s75,s76,s77,s78}),
    .sel({s68[ARB_DRN],s68[ARB_REQ]})
);
assign s74 = s7 & s14 & ~s8 & ~s62;
assign s76 = s9;
assign s75 = 1'b0;
assign s77 = {(DW / 8){1'b0}};
assign s78 = s12;
assign s69 = sb_drn_valid & ~s62;
assign s71 = sb_drn_addr;
assign s70 = 1'b1;
assign s72 = sb_drn_mask;
assign s73 = sb_drn_data[(DW + 1) -:2];
assign s5[DW - 1:0] = sb_drn_data[DW - 1:0];
always @(posedge lm_clk) begin
    lm_pfm_event <= s1 & lm_clk_en;
end

generate
    if (BLOCKS == 1) begin:gen_one_bank
        assign ram0_cs = s1;
        assign ram0_we = s2;
        assign ram0_addr = s3;
        assign ram0_byte_we = s4;
        assign ram0_wdata[DW - 1:0] = s5;
        assign ram0_user = s6;
        assign ram1_cs = 1'b0;
        assign ram1_we = 1'b0;
        assign ram1_addr = {RAM_AW{1'b0}};
        assign ram1_byte_we = {RAM_BWEW{1'b0}};
        assign ram1_wdata = {RAM_DW{1'b0}};
        assign ram1_user = {SW{1'b0}};
        wire [RAM_DW - 1:0] s101 = ram1_rdata;
        assign s31 = ram0_rdata[DW - 1:0];
    end
    else begin:gen_two_bank
        assign ram0_cs = s1;
        assign ram0_we = s2 & |s4[3:0];
        assign ram0_addr = s3;
        assign ram0_user = s6;
        assign ram1_cs = s1;
        assign ram1_we = s2 & |s4[7:4];
        assign ram1_addr = s3;
        assign ram1_user = s6;
        assign {ram1_byte_we,ram0_byte_we} = s4;
        assign {ram1_wdata[31:0],ram0_wdata[31:0]} = s5;
        assign s31 = {ram1_rdata[31:0],ram0_rdata[31:0]};
    end
endgenerate
generate
    if (((ECC_TYPE_INT == 2)) && (DW == 32)) begin:gen_ram_wdata_ecc32
        wire [ECCW - 1:0] s102;
        kv_eccenc32 u_ecc32(
            .data(sb_drn_data[DW - 1:0]),
            .dataout(s102)
        );
        assign ram0_wdata[38:32] = s86 ? s87 : s102;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 1)) begin:gen_ram_wdata_ecc64
        wire [ECCW - 1:0] s102;
        kv_eccenc64 u_ecc64(
            .data(sb_drn_data[DW - 1:0]),
            .dataout(s102)
        );
        assign ram0_wdata[71:64] = s86 ? s87 : s102;
    end
    else if (((ECC_TYPE_INT == 2)) && (DW == 64) && (BLOCKS == 2)) begin:gen_ram_wdata_ecc32x2
        wire [ECCW - 1:0] s102;
        wire [ECCW - 1:0] s103;
        kv_eccenc32 u_eccenc32_bank0(
            .data(sb_drn_data[31:0]),
            .dataout(s102)
        );
        kv_eccenc32 u_eccenc32_bank1(
            .data(sb_drn_data[63:32]),
            .dataout(s103)
        );
        assign ram0_wdata[38:32] = s86 ? s87 : s102;
        assign ram1_wdata[38:32] = s86 ? s87 : s103;
    end
    else begin:gen_ran_wdata_no_ecc
        wire [ECCW - 1:0] s104 = s87;
    end
endgenerate
generate
    if ((ECC_TYPE_INT == 2)) begin:gen_inject
        reg s105;
        wire s106;
        wire s107;
        wire s108;
        wire s109;
        reg [ECCW - 1:0] s110;
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s105 <= 1'b0;
            end
            else if (s106) begin
                s105 <= s107;
            end
        end

        always @(posedge lm_clk) begin
            if (s108) begin
                s110 <= csr_mecc_code_code[ECCW - 1:0];
            end
        end

        assign s106 = s108 | s109;
        assign s108 = sb_enq_valid & s43;
        assign s109 = s68[ARB_DRN] & s67[ARB_DRN] & ~s62;
        assign s107 = s108 | (s105 & ~s109);
        assign s86 = s105;
        assign s87 = s110;
    end
    else begin:gen_inject_stub
        assign s86 = 1'b0;
        assign s87 = {ECCW{1'b0}};
        wire [7:0] nds_unused_csr_mecc_code_code = csr_mecc_code_code;
        wire nds_unused_m2_rwecc = s43;
    end
endgenerate
assign s63 = {(DW / 8){s42 & ~s80}} & w_mask;
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_m2_wmask_bit (
    .out(s64),
    .in(s63)
);
assign sb_drn_ready = s67[ARB_DRN] & ~s62;
assign sb_enq_valid = (s42 & ~s59 & w_valid & w_ready & ~s81 & ~s62) | (~s42 & ~s59 & s36 & s54 & ~s81 & ~s62);
assign sb_enq_ent = s45;
assign sb_enq_addr = s37;
assign sb_enq_mask = s63 | (~s63 & s55);
assign sb_enq_data = (({(DW + SW){~s0}} | {2'b11,s64}) & {s40,w_data}) | (({(DW + SW){s0}} & {2'b11,~s64}) & {s40,s53});
wire nds_unused_sb_enq_ready = sb_enq_ready;
endmodule

