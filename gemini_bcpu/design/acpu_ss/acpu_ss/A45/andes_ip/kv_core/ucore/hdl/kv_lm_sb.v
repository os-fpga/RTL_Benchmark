// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_sb (
    lm_clk,
    lm_reset_n,
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
parameter DW = 32;
parameter ALEN = 8;
parameter SB_DEPTH = 6;
localparam FUNC_READ = 0;
localparam FUNC_WRITE = 1;
localparam UW = 2;
input lm_clk;
input lm_reset_n;
output sb_empty;
output sb_full;
input [ALEN - 1:0] sb_cmp_addr;
output [DW - 1:0] sb_hit_data;
output [(DW / 8) - 1:0] sb_hit_mask;
output [SB_DEPTH - 1:0] sb_hit;
input sb_enq_valid;
input [SB_DEPTH - 1:0] sb_enq_ent;
input [ALEN - 1:0] sb_enq_addr;
input [DW + 1:0] sb_enq_data;
input [(DW / 8) - 1:0] sb_enq_mask;
output sb_enq_ready;
output sb_drn_valid;
input sb_drn_ready;
output [ALEN - 1:0] sb_drn_addr;
output [(DW / 8) - 1:0] sb_drn_mask;
output [DW + 1:0] sb_drn_data;


wire [SB_DEPTH - 1:0] s0;
wire [(DW * SB_DEPTH) - 1:0] s1;
wire [(DW / 8 * SB_DEPTH) - 1:0] s2;
wire [(ALEN * SB_DEPTH) - 1:0] s3;
wire [(UW * SB_DEPTH) - 1:0] s4;
wire [SB_DEPTH - 1:0] s5 = ~s0;
wire [SB_DEPTH - 1:0] s6;
wire [SB_DEPTH - 1:0] s7;
wire [SB_DEPTH - 1:0] s8;
wire [SB_DEPTH - 1:0] s9;
wire [SB_DEPTH - 1:0] s10;
wire [SB_DEPTH - 1:0] s11;
wire [SB_DEPTH - 1:0] s12;
wire [SB_DEPTH - 1:0] s13;
wire [SB_DEPTH - 1:0] s14;
wire s15;
wire [DW - 1:0] s16;
wire [(DW / 8) - 1:0] s17;
wire [DW - 1:0] s18;
wire [(DW / 8) - 1:0] s19;
wire [DW - 1:0] s20;
assign sb_full = &s0;
assign sb_empty = ~|s0;
generate
    genvar i;
    for (i = 0; i < SB_DEPTH; i = i + 1) begin:gen_ent
        kv_lm_sb_ent #(
            .DW(DW),
            .UW(UW),
            .ALEN(ALEN)
        ) u_ent (
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .cmp_addr(sb_cmp_addr),
            .cmp_hit(s13[i]),
            .valid(s0[i]),
            .mask(s2[i * (DW / 8) +:(DW / 8)]),
            .data(s1[i * DW +:DW]),
            .addr(s3[i * ALEN +:ALEN]),
            .user(s4[i * UW +:UW]),
            .enq_valid(s14[i]),
            .enq_addr(sb_enq_addr),
            .enq_data(sb_enq_data[DW - 1:0]),
            .enq_mask(sb_enq_mask),
            .enq_user(sb_enq_data[(DW + 1) -:2]),
            .drn_valid(s8[i]),
            .drn_ready(s9[i])
        );
    end
endgenerate
wire [SB_DEPTH - 1:0] s21;
kv_arb_fp #(
    .N(SB_DEPTH)
) u_free_ptr (
    .valid(s5),
    .ready(s21),
    .grant(s6)
);
assign s7 = (|sb_enq_ent) ? sb_enq_ent : s6;
assign s14 = s7 & {SB_DEPTH{sb_enq_valid}};
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_bypass_mask_bit (
    .out(s20),
    .in(s19)
);
assign s15 = sb_enq_valid & (sb_cmp_addr == sb_enq_addr);
assign s19 = {(DW / 8){s15}} & sb_enq_mask;
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(DW)
) u_cmp_data (
    .out(s16),
    .sel(s13),
    .in(s1)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(DW / 8)
) u_cmp_mask (
    .out(s17),
    .sel(s13),
    .in(s2)
);
kv_bit_expand #(
    .N(DW / 8),
    .M(8)
) u_ent_hit_mask_bit (
    .out(s18),
    .in(s17)
);
assign sb_hit_mask = ({(DW / 8){s15}} & sb_enq_mask) | s17;
assign sb_hit_data = (s20 & sb_enq_data[DW - 1:0]) | (~s20 & s16 & s18);
assign sb_hit = s15 ? s7 : s13;
kv_arb_rr #(
    .N(SB_DEPTH)
) u_arb_drn (
    .clk(lm_clk),
    .resetn(lm_reset_n),
    .en(sb_drn_ready),
    .valid(s10),
    .ready(s11),
    .grant(s12)
);
assign sb_drn_valid = |s10;
assign s10 = s8;
assign s9 = s11 & {SB_DEPTH{sb_drn_ready}};
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(ALEN)
) u_sb_drn_addr (
    .out(sb_drn_addr),
    .sel(s12),
    .in(s3)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(DW)
) u_sb_drn_data (
    .out(sb_drn_data[DW - 1:0]),
    .sel(s12),
    .in(s1)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(DW / 8)
) u_sb_drn_mask (
    .out(sb_drn_mask),
    .sel(s12),
    .in(s2)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(UW)
) u_sb_drn_user (
    .out(sb_drn_data[(DW + 1) -:2]),
    .sel(s12),
    .in(s4)
);
assign sb_enq_ready = 1'b1;
endmodule

