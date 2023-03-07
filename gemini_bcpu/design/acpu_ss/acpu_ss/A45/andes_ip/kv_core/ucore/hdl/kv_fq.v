// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fq (
    core_clk,
    core_reset_n,
    fetch_kill,
    fq_wr,
    fq_rd,
    fq_wr_valid,
    fq_wr_inst,
    fq_wr_bblk_start,
    fq_wr_bblk_end,
    fq_wr_xcpt,
    fq_i0_valid,
    fq_i0_inst,
    fq_i0_bblk_start,
    fq_i0_bblk_end,
    fq_i0_xcpt,
    fq_i0_xcpt_upper,
    fq_i0_ready,
    fq_i0_bogus,
    fq_i1_valid,
    fq_i1_inst,
    fq_i1_bblk_start,
    fq_i1_bblk_end,
    fq_i1_xcpt,
    fq_i1_xcpt_upper,
    fq_i1_ready,
    fq_i1_bogus
);
parameter FQ_DEPTH = 4;
localparam FQ_PTR_MSB = (FQ_DEPTH == 4) ? 2 : 3;
localparam FQ_INST_LSB = 0;
localparam FQ_INST_MSB = 63;
localparam FQ_BBLK_START = 64;
localparam FQ_BBLK_END = 65;
localparam FQ_XCPT_LSB = 66;
localparam FQ_XCPT_MSB = 69;
localparam FQ_VALID_LSB = 70;
localparam FQ_VALID_MSB = 73;
localparam FQ_WIDTH = 74;
input core_clk;
input core_reset_n;
input fetch_kill;
input fq_wr;
output fq_rd;
input [3:0] fq_wr_valid;
input [63:0] fq_wr_inst;
input fq_wr_bblk_start;
input fq_wr_bblk_end;
input [3:0] fq_wr_xcpt;
output fq_i0_valid;
output [31:0] fq_i0_inst;
output fq_i0_bblk_start;
output fq_i0_bblk_end;
output fq_i0_xcpt;
output fq_i0_xcpt_upper;
input fq_i0_ready;
output fq_i0_bogus;
output fq_i1_valid;
output [31:0] fq_i1_inst;
output fq_i1_bblk_start;
output fq_i1_bblk_end;
output fq_i1_xcpt;
output fq_i1_xcpt_upper;
input fq_i1_ready;
output fq_i1_bogus;


reg [FQ_WIDTH - 1:0] s0[0:FQ_DEPTH - 1];
wire [FQ_WIDTH - 1:0] s1;
wire [FQ_WIDTH - 1:0] s2;
reg [FQ_PTR_MSB:0] s3;
wire s4;
wire [FQ_PTR_MSB:0] s5;
wire [FQ_PTR_MSB:0] s6;
wire fq_rd;
reg [FQ_PTR_MSB:0] s7;
wire s8;
wire [FQ_PTR_MSB:0] s9;
wire [FQ_PTR_MSB:0] s10;
wire s11 = fq_i0_valid & fq_i0_ready;
wire s12 = fq_i1_valid & fq_i1_ready;
wire s13 = (s7 == s3);
reg s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire [63:0] s19;
wire [3:0] s20;
wire s21;
wire s22;
wire [3:0] s23;
wire s24 = 1'b1;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire s30;
wire s31;
wire s32;
reg s33;
wire s34;
wire s35;
wire s36;
wire s37;
reg [2:0] s38;
wire [2:0] s39;
reg [47:0] s40;
wire [47:0] s41;
reg s42;
wire s43;
reg s44;
wire s45;
reg [2:0] s46;
wire [2:0] s47;
wire s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire s53;
wire s54;
assign s1 = {fq_wr_valid,fq_wr_xcpt,fq_wr_bblk_end,fq_wr_bblk_start,fq_wr_inst};
integer s55;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        for (s55 = 0; s55 < FQ_DEPTH; s55 = s55 + 1)
        s0[s55] <= {FQ_WIDTH{1'b0}};
    end
    else if (fq_wr) begin
        s0[s7[FQ_PTR_MSB - 1:0]] <= s1;
    end
end

assign s8 = fetch_kill | fq_wr;
kv_zero_ext #(
    .OW(FQ_PTR_MSB + 1),
    .IW(1)
) u_wincr_zext (
    .out(s10),
    .in(1'b1)
);
assign s9 = fetch_kill ? {FQ_PTR_MSB + 1{1'b0}} : s10 + s7;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s7 <= {FQ_PTR_MSB + 1{1'b0}};
    end
    else if (s8) begin
        s7 <= s9;
    end
end

assign s4 = fetch_kill | fq_rd;
kv_zero_ext #(
    .OW(FQ_PTR_MSB + 1),
    .IW(1)
) u_rincr1_zext (
    .out(s6),
    .in(1'b1)
);
assign s5 = fetch_kill ? {FQ_PTR_MSB + 1{1'b0}} : s6 + s3;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s3 <= {FQ_PTR_MSB + 1{1'b0}};
    end
    else if (s4) begin
        s3 <= s5;
    end
end

assign s2 = s0[s3[FQ_PTR_MSB - 1:0]];
assign s19 = s2[FQ_INST_MSB:FQ_INST_LSB];
assign s20 = s2[FQ_VALID_MSB:FQ_VALID_LSB];
assign s21 = s2[FQ_BBLK_START];
assign s22 = s2[FQ_BBLK_END];
assign s23 = s2[FQ_XCPT_MSB:FQ_XCPT_LSB];
assign s15 = (s11 & fq_i0_xcpt) | (s11 & fq_i0_bogus) | (s12 & fq_i1_xcpt) | (s12 & fq_i1_bogus);
assign s16 = fetch_kill;
assign s17 = (s14 | s15) & ~s16;
assign s18 = s15 | s16;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s14 <= 1'b0;
    end
    else if (s18) begin
        s14 <= s17;
    end
end

assign fq_rd = s25 | (s50 & ~(^s20[1:0])) | (s51 & ~(^s20[2:1])) | (s52 & ~(^s20[3:2])) | (~s33 & ~s11 & ~(&s20) & ~s13);
assign s34 = (s49 & ~fetch_kill) | (s50 & ~(^s20[1:0]) & ~fetch_kill) | (s51 & ~(^s20[2:1]) & ~fetch_kill) | (s52 & ~(^s20[3:2]) & ~fetch_kill) | (~s33 & ~s13 & ~s11 & ~(&s20) & ~fetch_kill);
assign s35 = s26 | fetch_kill;
assign s36 = (s33 & ~s35) | s34;
assign s37 = s34 | s35;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s33 <= 1'b0;
    end
    else if (s37) begin
        s33 <= s36;
    end
end

assign s39 = s49 ? (s48 ? (s38 >> 1) : (s38 >> 2)) : s50 ? {s20[3:1]} : s51 ? {1'b0,s20[3:2]} : s52 ? {2'b0,s20[3]} : s20[2:0];
assign s41 = s49 ? (s48 ? (s40 >> 16) : (s40 >> 32)) : s50 ? s19[63:16] : s51 ? {16'b0,s19[63:32]} : s52 ? {32'b0,s19[63:48]} : s19[47:0];
assign s43 = s49 ? s42 : s22;
assign s47 = s49 ? (s48 ? (s46 >> 1) : (s46 >> 2)) : s50 ? {s23[3:1]} : s51 ? {1'b0,s23[3:2]} : s52 ? {2'b0,s23[3]} : s23[2:0];
assign s45 = ~s49 & ~s50 & ~s51 & ~s52 & s21;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s38 <= 3'b0;
        s40 <= 48'b0;
        s42 <= 1'b0;
        s46 <= 3'b0;
        s44 <= 1'b0;
    end
    else if (s34) begin
        s38 <= s39;
        s40 <= s41;
        s42 <= s43;
        s46 <= s47;
        s44 <= s45;
    end
end

assign s49 = s33 & ~s26 & s11;
assign s48 = (s33 & ~s30 & s11 & ~s12);
assign s50 = (s33 & (&s38) & s30 & s32 & ~s13 & s12) | (s33 & (^s38[2:1]) & ~s30 & s31 & ~s13 & s12) | (s33 & (^s38[2:1]) & s30 & ~s27 & ~s13 & s12) | (s33 & (^s38[1:0]) & s30 & ~s13 & s11 & ~s12) | (s33 & (^s38[1:0]) & ~s30 & ~s13 & ~s27 & s12) | (~s33 & ~s13 & ~s27 & s11 & ~s12);
assign s51 = (s33 & (^s38[2:1]) & s30 & s27 & ~s13 & s12) | (s33 & (^s38[1:0]) & s30 & ~s28 & ~s13 & s12) | (s33 & (^s38[1:0]) & ~s30 & s27 & ~s13 & s12) | (~s33 & ~s13 & s27 & s11 & ~s12) | (~s33 & ~s13 & ~s27 & ~s28 & s12);
assign s52 = (s33 & (^s38[1:0]) & s30 & s28 & ~s13 & s12) | (~s33 & ~s13 & s27 & ~s29 & s12) | (~s33 & ~s13 & ~s27 & s28 & s12);
assign s26 = (s33 & (&s38) & s30 & ~s32 & s12) | (s33 & (&s38) & ~s30 & s31 & s12) | (s33 & (&s38) & s30 & s32 & ~s13 & s12) | (s33 & (^s38[2:1]) & s30 & s11) | (s33 & (^s38[2:1]) & ~s30 & ~s31 & s12) | (s33 & (^s38[2:1]) & ~s30 & s31 & s12) | (s33 & (^s38[1:0]) & ~s30 & s11) | (s33 & (^s38[1:0]) & s30 & ~s13 & s11);
assign s53 = (s33 & (&s38) & s30 & s32 & ~s13 & (^s20[1:0]) & s12) | (s33 & (^s38[2:1]) & s30 & ~s27 & ~s13 & (^s20[1:0]) & s12) | (s33 & (^s38[2:1]) & ~s30 & s31 & ~s13 & (^s20[1:0]) & s12) | (s33 & (^s38[2:1]) & s30 & s27 & ~s13 & (^s20[2:1]) & s12) | (s33 & (^s38[1:0]) & ~s30 & ~s27 & ~s13 & (^s20[1:0]) & s12) | (s33 & (^s38[1:0]) & ~s30 & s27 & ~s13 & (^s20[2:1]) & s12) | (s33 & (^s38[1:0]) & s30 & ~s28 & ~s13 & (^s20[2:1]) & s12) | (s33 & (^s38[1:0]) & s30 & s28 & ~s13 & (^s20[3:2]) & s12) | (s33 & (^s38[1:0]) & s30 & ~s13 & (^s20[1:0]) & s11 & ~s12);
assign s54 = (~s33 & ~s13 & (^s20[1:0]) & ~s27 & s11) | (~s33 & ~s13 & (^s20[2:1]) & s27 & s11) | (~s33 & ~s13 & (^s20[2:1]) & ~s27 & ~s28 & s12) | (~s33 & ~s13 & (^s20[3:2]) & ~s27 & s28 & s12) | (~s33 & ~s13 & (^s20[3:2]) & s27 & ~s29 & s12) | (~s33 & ~s13 & (&s20) & s27 & s29 & s12);
assign s25 = s53 | s54;
assign s27 = (s19[1:0] == 2'b11) | ~s24;
assign s28 = (s19[17:16] == 2'b11);
assign s29 = (s19[33:32] == 2'b11) | ~s24;
assign s30 = (s40[1:0] == 2'b11) | ~s24;
assign s31 = (s40[17:16] == 2'b11) | ~s24;
assign s32 = (s40[33:32] == 2'b11) | ~s24;
assign fq_i0_valid = ~s14 & ((s33 & (&s38)) | (s33 & (&s38[1:0])) | (s33 & s38[0] & ~s38[1] & ~s30) | (s33 & s38[0] & ~s38[1] & s30 & ~s13) | (~s33 & ~s13 & (&s20)) | (~s33 & ~s13 & (&s20[2:0])) | (~s33 & ~s13 & (&s20[1:0])) | (~s33 & ~s13 & s20[0] & ~s20[1] & ~s27) | fq_i0_xcpt | fq_i0_bogus);
assign fq_i0_inst[15:0] = s33 ? s40[15:0] : s19[15:0];
assign fq_i0_inst[31:16] = s33 ? (&s38[1]) ? s40[31:16] : s19[15:0] : s19[31:16];
assign fq_i0_xcpt = (s33 & s46[0]) | (~s33 & ~s13 & s23[0]) | (fq_i0_xcpt_upper & ~fq_i0_bogus);
assign fq_i0_xcpt_upper = (s33 & (^s38[1:0]) & ~s46[0] & s30 & ~s13 & s23[0]) | (s33 & (^s38[2:1]) & ~s46[0] & s46[1] & s30) | (s33 & (&s38) & ~s46[0] & s46[1] & s30) | (~s33 & ~s13 & s27 & s20[1] & ~s23[0] & s23[1]);
assign fq_i0_bblk_start = (s33 & s44) | (~s33 & s21);
assign fq_i0_bblk_end = (s33 & (^s38[1:0]) & ~s30 & s42) | (s33 & (^s38[2:1]) & s30 & s42) | (s33 & (^s38[1:0]) & s30 & ~s13 & (^s20[1:0]) & s22) | (~s33 & ~s13 & (^s20[1:0]) & ~s27 & s22) | (~s33 & ~s13 & (^s20[2:1]) & s27 & s22);
assign fq_i0_bogus = (s33 & (^s38[1:0]) & s30 & s42) | (~s33 & ~s13 & (^s20[1:0]) & s27 & s22);
assign fq_i1_valid = ~s14 & ~fq_i0_xcpt & ((s33 & (&s38) & ~s30) | (s33 & (&s38) & s30 & ~s32) | (s33 & (&s38) & s30 & ~s13) | (s33 & (^s38[2:1]) & ~s30 & ~s31) | (s33 & (^s38[2:1]) & ~s30 & ~s13) | (s33 & (^s38[2:1]) & s30 & ~s27 & ~s13) | (s33 & (^s38[2:1]) & s30 & s27 & ~s13 & s20[1]) | (s33 & (^s38[1:0]) & ~s30 & ~s27 & ~s13) | (s33 & (^s38[1:0]) & s30 & ~s28 & ~s13 & s20[1]) | (s33 & (^s38[1:0]) & ~s30 & s27 & ~s13 & s20[1]) | (s33 & (^s38[1:0]) & s30 & s28 & ~s13 & s20[2]) | (~s33 & ~s27 & ~s28 & ~s13 & s20[1]) | (~s33 & s27 & ~s29 & ~s13 & s20[2]) | (~s33 & ~s27 & s28 & ~s13 & s20[2]) | (~s33 & s27 & s29 & ~s13 & s20[3]) | fq_i1_xcpt | fq_i1_bogus);
assign fq_i1_inst[15:0] = (s33 & s30 & s38[2]) ? s40[47:32] : (s33 & s30 & s38[1]) ? s19[15:0] : (s33 & s30 & ~s38[1]) ? s19[31:16] : (s33 & ~s30 & s38[1]) ? s40[31:16] : (s33 & ~s30 & ~s38[1]) ? s19[15:0] : (~s33 & ~s27) ? s19[31:16] : s19[47:32];
assign fq_i1_inst[31:16] = (s33 & s30 & s38[2]) ? s19[15:0] : (s33 & s30 & s38[1]) ? s19[31:16] : (s33 & s30 & ~s38[1]) ? s19[47:32] : (s33 & ~s30 & s38[1]) ? s38[2] ? s40[47:32] : s19[15:0] : (s33 & ~s30 & ~s38[1]) ? s19[31:16] : (~s33 & ~s27) ? s19[47:32] : s19[63:48];
assign fq_i1_xcpt = (s33 & (&s38) & ~s30 & s46[1]) | (s33 & (&s38) & s30 & s46[2]) | (s33 & (^s38[2:1]) & ~s30 & s46[1]) | (s33 & (^s38[2:1]) & s30 & ~s13 & s23[0]) | (s33 & (^s38[1:0]) & ~s30 & ~s13 & s23[0]) | (s33 & (^s38[1:0]) & s30 & ~s13 & s20[1] & s23[1]) | (~s33 & s20[1] & ~s27 & ~s13 & s23[1]) | (~s33 & s20[2] & s27 & ~s13 & s23[2]) | (fq_i1_xcpt_upper & ~fq_i1_bogus);
assign fq_i1_xcpt_upper = (s33 & (&s38) & s30 & s32 & ~s46[2] & ~s13 & s23[0]) | (s33 & (&s38) & ~s30 & s31 & ~s46[1] & s46[2]) | (s33 & (^s38[2:1]) & ~s30 & s31 & ~s46[1] & ~s13 & s23[0]) | (s33 & (^s38[2:1]) & s30 & s27 & s20[1] & ~s13 & ~s23[0] & s23[1]) | (s33 & (^s38[1:0]) & ~s30 & s27 & s20[1] & ~s13 & ~s23[0] & s23[1]) | (s33 & (^s38[1:0]) & s30 & s28 & s20[2] & ~s13 & ~s23[1] & s23[2]) | (~s33 & s27 & s29 & s20[3] & ~s13 & ~s23[2] & s23[3]) | (~s33 & ~s27 & s28 & s20[2] & ~s13 & ~s23[1] & s23[2]);
assign fq_i1_bblk_start = fq_i0_bblk_end;
assign fq_i1_bblk_end = (s33 & s38[2] & ~s30 & s31 & s42) | (s33 & s38[2] & s30 & ~s32 & s42) | (s33 & s38[2] & s30 & s32 & (^s20[1:0]) & s22) | (s33 & (^s38[2:1]) & ~s30 & ~s31 & s42) | (s33 & (^s38[2:1]) & ~s30 & s31 & (^s20[1:0]) & s22) | (s33 & (^s38[2:1]) & s30 & ~s27 & (^s20[1:0]) & s22) | (s33 & (^s38[2:1]) & s30 & s27 & (^s20[2:1]) & s22) | (s33 & (^s38[1:0]) & ~s30 & ~s27 & (^s20[1:0]) & s22) | (s33 & (^s38[1:0]) & ~s30 & s27 & (^s20[2:1]) & s22) | (s33 & (^s38[1:0]) & s30 & ~s28 & (^s20[2:1]) & s22) | (s33 & (^s38[1:0]) & s30 & s28 & (^s20[3:2]) & s22) | (~s33 & s20[3] & s27 & s29 & s22) | (~s33 & (^s20[3:2]) & s27 & ~s29 & s22) | (~s33 & (^s20[3:2]) & ~s27 & s28 & s22) | (~s33 & (^s20[2:1]) & ~s27 & ~s28 & s22);
assign fq_i1_bogus = (s33 & s38[2] & s30 & s32 & s42) | (s33 & (^s38[2:1]) & ~s30 & s31 & s42) | (s33 & (^s38[2:1]) & s30 & ~s13 & (^s20[1:0]) & s27 & s22) | (s33 & (^s38[1:0]) & ~s30 & ~s13 & (^s20[1:0]) & s27 & s22) | (s33 & (^s38[1:0]) & s30 & ~s13 & (^s20[2:1]) & s28 & s22) | (~s33 & ~s13 & (^s20[3:2]) & s27 & s29 & s22) | (~s33 & ~s13 & (^s20[2:1]) & ~s27 & s28 & s22);
endmodule

