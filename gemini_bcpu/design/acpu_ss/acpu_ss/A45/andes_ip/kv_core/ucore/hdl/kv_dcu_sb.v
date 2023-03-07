// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_sb (
    dcu_clk,
    dcu_reset_n,
    sb_empty,
    sb_full,
    sb_afull,
    sb_pending,
    sb_cmp_addr,
    sb_cmp_hit,
    sb_cmp_hit_ptr,
    sb_cmp_hit_line_ptr,
    sb_cmp_hit_beat_ptr,
    sb_cmp_rdata,
    sb_cmp_rmask,
    sb_cmp_beat_data,
    sb_cmp_beat_mask,
    sb_fil_beat_data,
    sb_req_hit_line,
    sb_req_hit_beat,
    sb_fil_valid,
    sb_fil_last,
    sb_fil_mesi,
    sb_fil_fault,
    sb_fil_payload,
    sb_probe_valid,
    sb_probe_2n,
    sb_probe_2b,
    sb_evt_valid,
    sb_evt_exclusive,
    sb_cmt_valid,
    sb_cmt_kill0,
    sb_cmt_kill1,
    sb_cmt_kill1_en,
    sb_cmt_wdata,
    sb_cmt_wmask,
    sb_cmt_miss,
    sb_cmt_ptr,
    sb_enq_valid,
    sb_enq_spec,
    sb_enq_mrg,
    sb_enq_mrg_ptr,
    sb_enq_addr,
    sb_enq_mesi,
    sb_enq_way,
    sb_enq_rmw,
    sb_enq_rmwdata,
    sb_enq_free_ptr,
    sb_drain_valid,
    sb_drain_way,
    sb_drain_addr,
    sb_drain_data,
    sb_drain_mask,
    sb_drain_ready
);
parameter PALEN = 32;
parameter SB_DEPTH = 4;
parameter DCACHE_ECC_TYPE_INT = 0;
input dcu_clk;
input dcu_reset_n;
output sb_empty;
output sb_full;
output sb_afull;
output [SB_DEPTH - 1:0] sb_pending;
input [PALEN - 1:0] sb_cmp_addr;
output sb_cmp_hit;
output [SB_DEPTH - 1:0] sb_cmp_hit_ptr;
output [SB_DEPTH - 1:0] sb_cmp_hit_line_ptr;
output [SB_DEPTH - 1:0] sb_cmp_hit_beat_ptr;
output [31:0] sb_cmp_rdata;
output [3:0] sb_cmp_rmask;
output [127:0] sb_cmp_beat_data;
output [15:0] sb_cmp_beat_mask;
input [127:0] sb_fil_beat_data;
input [SB_DEPTH - 1:0] sb_req_hit_line;
input [SB_DEPTH - 1:0] sb_req_hit_beat;
input sb_fil_valid;
input sb_fil_last;
input [2:0] sb_fil_mesi;
input sb_fil_fault;
input sb_fil_payload;
input sb_probe_valid;
input sb_probe_2n;
input sb_probe_2b;
input sb_evt_valid;
input sb_evt_exclusive;
input sb_cmt_valid;
input sb_cmt_kill0;
input sb_cmt_kill1;
input sb_cmt_kill1_en;
input [31:0] sb_cmt_wdata;
input [3:0] sb_cmt_wmask;
input sb_cmt_miss;
input [SB_DEPTH - 1:0] sb_cmt_ptr;
input sb_enq_valid;
input sb_enq_spec;
input sb_enq_mrg;
input [SB_DEPTH - 1:0] sb_enq_mrg_ptr;
input [PALEN - 1:0] sb_enq_addr;
input [2:0] sb_enq_mesi;
input [3:0] sb_enq_way;
input sb_enq_rmw;
input [31:0] sb_enq_rmwdata;
output [SB_DEPTH - 1:0] sb_enq_free_ptr;
output sb_drain_valid;
output [3:0] sb_drain_way;
output [PALEN - 1:0] sb_drain_addr;
output [31:0] sb_drain_data;
output [3:0] sb_drain_mask;
input sb_drain_ready;


wire [SB_DEPTH - 1:0] s0;
wire [SB_DEPTH - 1:0] s1 = ~s0;
wire [(SB_DEPTH * PALEN) - 1:0] s2;
wire [(SB_DEPTH * 32) - 1:0] s3;
wire [(SB_DEPTH * 4) - 1:0] s4;
wire [(SB_DEPTH * 4) - 1:0] s5;
wire [SB_DEPTH - 1:0] s6;
wire [(SB_DEPTH * 32 * 4) - 1:0] s7;
wire [(SB_DEPTH * 16) - 1:0] s8;
wire [SB_DEPTH - 1:0] s9;
wire [3:0] s10;
wire [SB_DEPTH - 1:0] s11;
wire [SB_DEPTH - 1:0] s12;
wire [SB_DEPTH - 1:0] s13;
wire [PALEN - 1:0] cmp_addr;
wire [SB_DEPTH - 1:0] cmt_valid;
wire [SB_DEPTH - 1:0] s14;
wire [SB_DEPTH - 1:0] s15;
wire [SB_DEPTH - 1:0] s16;
wire [3:0] cmt_wmask;
wire cmt_kill0;
wire cmt_kill1;
wire cmt_kill1_en;
wire [SB_DEPTH - 1:0] s17;
wire [31:0] s18;
wire [3:0] s19;
wire [127:0] s20;
wire [15:0] s21;
wire [SB_DEPTH - 1:0] s22;
wire [SB_DEPTH - 1:0] s23;
wire sb_empty;
wire s24;
wire [SB_DEPTH - 1:0] s25;
wire [SB_DEPTH - 1:0] s26;
wire [SB_DEPTH - 1:0] s27;
wire s28 = 1'b0;
generate
    genvar i;
    for (i = 0; i < SB_DEPTH; i = i + 1) begin:gen_ent
        kv_dcu_sb_ent #(
            .PALEN(PALEN),
            .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT)
        ) u_ent (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .enq_valid(s9[i]),
            .enq_spec(sb_enq_spec),
            .enq_addr(sb_enq_addr),
            .enq_state(s10),
            .enq_way(sb_enq_way),
            .enq_rmw(sb_enq_rmw),
            .enq_rmwdata(sb_enq_rmwdata),
            .cmp_addr(cmp_addr),
            .cmp_hit(s11[i]),
            .cmp_hit_line(s12[i]),
            .cmp_hit_beat(s13[i]),
            .cmt_valid(cmt_valid[i]),
            .cmt_kill0(cmt_kill0),
            .cmt_kill1(cmt_kill1),
            .cmt_kill1_en(cmt_kill1_en),
            .cmt_wdata(sb_cmt_wdata),
            .cmt_wmask(cmt_wmask),
            .cmt_miss(sb_cmt_miss),
            .req_hit_beat(sb_req_hit_beat[i]),
            .req_hit_line(sb_req_hit_line[i]),
            .probe_valid(sb_probe_valid),
            .probe_2n(sb_probe_2n),
            .probe_2b(sb_probe_2b),
            .evt_valid(sb_evt_valid),
            .evt_exclusive(sb_evt_exclusive),
            .fil_valid(sb_fil_valid),
            .fil_last(sb_fil_last),
            .fil_mesi(sb_fil_mesi),
            .fil_fault(sb_fil_fault),
            .fil_payload(sb_fil_payload),
            .fil_beat_data(sb_fil_beat_data),
            .drain_valid(s14[i]),
            .drain_ready(s15[i]),
            .valid(s0[i]),
            .addr(s2[i * PALEN +:PALEN]),
            .rdata(s3[i * 32 +:32]),
            .mask(s4[i * 4 +:4]),
            .way(s5[i * 4 +:4]),
            .edata(s7[i * 128 +:128]),
            .emask(s8[i * 16 +:16]),
            .pending(s6[i])
        );
    end
endgenerate
kv_ffs #(
    .WIDTH(SB_DEPTH)
) u_free_ptr (
    .out(s16),
    .in(s1)
);
assign cmp_addr = sb_cmp_addr;
assign cmt_valid = {SB_DEPTH{sb_cmt_valid}} & sb_cmt_ptr;
assign cmt_wmask = sb_cmt_wmask;
assign cmt_kill0 = sb_cmt_kill0;
assign cmt_kill1 = sb_cmt_kill1;
assign cmt_kill1_en = sb_cmt_kill1_en;
assign s9 = {SB_DEPTH{sb_enq_valid}} & s17;
assign s10 = {1'b0,sb_enq_mesi};
assign sb_enq_free_ptr = s16;
assign s17 = sb_enq_mrg ? sb_enq_mrg_ptr : s16;
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(32)
) u_m1_rdata (
    .out(s18),
    .sel(s11),
    .in(s3)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(4)
) u_m1_rmask (
    .out(s19),
    .sel(s11),
    .in(s4)
);
kv_vor #(
    .N(SB_DEPTH),
    .W(128)
) u_m1_edata (
    .out(s20),
    .in(s7)
);
kv_vor #(
    .N(SB_DEPTH),
    .W(16)
) u_m1_emask (
    .out(s21),
    .in(s8)
);
assign sb_cmp_rdata = s18;
assign sb_cmp_rmask = s19;
assign s22 = s12;
assign s23 = s13;
assign sb_full = (&s0) | s28;
assign sb_afull = (s16 == ~s0);
assign sb_empty = ~|s0;
assign sb_pending = s6;
assign sb_cmp_hit = |s11;
assign sb_cmp_hit_ptr = s11;
assign sb_cmp_hit_line_ptr = s22;
assign sb_cmp_hit_beat_ptr = s23;
assign sb_cmp_beat_data = s20;
assign sb_cmp_beat_mask = s21;
kv_arb_rr #(
    .N(SB_DEPTH)
) u_arb_drain (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(s24),
    .valid(s25),
    .ready(s26),
    .grant(s27)
);
assign s25 = s14;
assign s24 = sb_drain_valid & sb_drain_ready;
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(PALEN)
) u_sb_drain_addr (
    .out(sb_drain_addr),
    .sel(s27),
    .in(s2)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(32)
) u_sb_drain_data (
    .out(sb_drain_data),
    .sel(s27),
    .in(s3)
);
kv_mux_onehot #(
    .N(SB_DEPTH),
    .W(4)
) u_sb_drain_way (
    .out(sb_drain_way),
    .sel(s27),
    .in(s5)
);
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_drain_mask_ecc
        assign sb_drain_mask = {4{1'b1}};
    end
    else begin:gen_drain_mask_noecc
        kv_mux_onehot #(
            .N(SB_DEPTH),
            .W(4)
        ) u_sb_drain_mask (
            .out(sb_drain_mask),
            .sel(s27),
            .in(s4)
        );
    end
endgenerate
assign sb_drain_valid = |s14;
assign s15 = {SB_DEPTH{sb_drain_ready}} & s26;
endmodule

