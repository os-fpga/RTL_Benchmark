// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_mshr (
    dcu_clk,
    dcu_reset_n,
    dcu_wna_pending,
    mshr_empty,
    mshr_full,
    mshr_ent_speculative,
    mshr_ent_killed,
    mshr_ent_wt,
    mshr_ent_na,
    mshr_ent_na_mrg,
    mshr_ent_wbf,
    mshr_ent_wbf_cft,
    mshr_ent_write,
    mshr_ent_write_mrg,
    mshr_event,
    mshr_cmp_addr,
    mshr_cmp_func,
    mshr_cmp_hit,
    mshr_cmp_sameidx,
    mshr_cmp_way,
    mshr_cmp_tagw,
    mshr_cmp_mesi,
    mshr_cmp_changing,
    mshr_enq_valid,
    mshr_enq_stall,
    mshr_enq_mrg,
    mshr_enq_mrg_ptr,
    mshr_enq_id,
    mshr_enq_addr,
    mshr_enq_spec,
    mshr_enq_state,
    mshr_enq_way,
    mshr_enq_l2_ways,
    mshr_enq_func,
    mshr_free_ptr,
    mshr_cmt_valid,
    mshr_cmt_ptr,
    mshr_cmt_addr,
    mshr_cmt_kill,
    mshr_cmt_attr,
    mshr_cmt_wdata,
    mshr_cmt_wmask,
    mshr_wbf_flush,
    mshr_prb_valid,
    mshr_prb_ptr,
    mshr_prb_mesi,
    wbf_a1_valid,
    wbf_a1_index,
    wbf_a1_ready,
    wbf_w1_valid,
    wbf_w1_index,
    wbf_w1_addr,
    wbf_w1_data,
    wbf_w1_mask,
    wbf_r1_index,
    wbf_r1_addr,
    wbf_r1_data,
    wbf_r1_mask,
    wbf_d1_valid,
    mshr_a_valid,
    mshr_a_ptr,
    mshr_a_ready,
    mshr_a_opcode,
    mshr_a_address,
    mshr_a_size,
    mshr_a_param,
    mshr_a_user,
    mshr_a_data,
    mshr_a_mask,
    mshr_a_corrupt,
    mshr_d_valid,
    mshr_d_opcode,
    mshr_d_ptr,
    mshr_d_sink,
    mshr_d_data,
    mshr_d_param,
    mshr_d_offset,
    mshr_d_payload,
    mshr_d_error,
    mshr_d_last,
    mshr_d_fildata,
    mshr_d_fildata_last,
    mshr_d_l2_way,
    mshr_d_ready,
    mshr_e_valid,
    mshr_e_sink,
    mshr_e_ready,
    fil_valid,
    fil_addr,
    fil_last,
    fil_way,
    fil_mesi,
    fil_fault,
    fil_lock,
    fil_reserve,
    fil_exclusive,
    fil_wdata,
    fil_payload,
    fil_data_way,
    fil_l2_ways,
    fil_ready,
    dcu_cri_valid,
    dcu_cri_id,
    dcu_cri_rdata,
    dcu_cri_nbload_result,
    dcu_cri_status,
    mshr_async_write_error
);
parameter PALEN = 32;
parameter DCU_DATA_WIDTH = 32;
parameter MSHR_DEPTH = 3;
parameter WBF_DEPTH = 2;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_WAY = 2;
parameter A_UW = 12;
parameter SINK_WIDTH = 2;
parameter WPT_SUPPORT = 0;
localparam GRN_LSB = 2;
localparam XW_RATIO = DCU_DATA_WIDTH / 32;
localparam XW_RATIO_LOG2 = $clog2(XW_RATIO);
localparam ID_WIDTH = 1;
localparam DW_RATIO = 128 / DCU_DATA_WIDTH;
localparam DW_RATIO_LOG2 = $clog2(DW_RATIO);
localparam L2_DW_LOG2 = $clog2(DCU_DATA_WIDTH / 8);
input dcu_clk;
input dcu_reset_n;
output dcu_wna_pending;
output mshr_empty;
output mshr_full;
output [MSHR_DEPTH - 1:0] mshr_ent_speculative;
output [MSHR_DEPTH - 1:0] mshr_ent_killed;
output [MSHR_DEPTH - 1:0] mshr_ent_wt;
output [MSHR_DEPTH - 1:0] mshr_ent_na;
output [MSHR_DEPTH - 1:0] mshr_ent_na_mrg;
output [MSHR_DEPTH - 1:0] mshr_ent_wbf;
output [MSHR_DEPTH - 1:0] mshr_ent_wbf_cft;
output [MSHR_DEPTH - 1:0] mshr_ent_write;
output [MSHR_DEPTH - 1:0] mshr_ent_write_mrg;
output [15:0] mshr_event;
input [PALEN - 1:0] mshr_cmp_addr;
input [1:0] mshr_cmp_func;
output [MSHR_DEPTH - 1:0] mshr_cmp_hit;
output [MSHR_DEPTH - 1:0] mshr_cmp_sameidx;
output [3:0] mshr_cmp_way;
output [3:0] mshr_cmp_tagw;
output [2:0] mshr_cmp_mesi;
output mshr_cmp_changing;
input mshr_enq_valid;
input mshr_enq_stall;
input mshr_enq_mrg;
input [MSHR_DEPTH - 1:0] mshr_enq_mrg_ptr;
input [ID_WIDTH - 1:0] mshr_enq_id;
input [PALEN - 1:0] mshr_enq_addr;
input mshr_enq_spec;
input [3:0] mshr_enq_state;
input [3:0] mshr_enq_way;
input [7:0] mshr_enq_l2_ways;
input [18:0] mshr_enq_func;
output [MSHR_DEPTH - 1:0] mshr_free_ptr;
input mshr_cmt_valid;
input [MSHR_DEPTH - 1:0] mshr_cmt_ptr;
input [PALEN - 1:0] mshr_cmt_addr;
input mshr_cmt_kill;
input [5:0] mshr_cmt_attr;
input [31:0] mshr_cmt_wdata;
input [3:0] mshr_cmt_wmask;
input mshr_wbf_flush;
input mshr_prb_valid;
input [MSHR_DEPTH - 1:0] mshr_prb_ptr;
input [2:0] mshr_prb_mesi;
output wbf_a1_valid;
input [WBF_DEPTH - 1:0] wbf_a1_index;
input wbf_a1_ready;
output wbf_w1_valid;
output [WBF_DEPTH - 1:0] wbf_w1_index;
output [5:4] wbf_w1_addr;
output [127:0] wbf_w1_data;
output [15:0] wbf_w1_mask;
output [WBF_DEPTH - 1:0] wbf_r1_index;
output [5:3] wbf_r1_addr;
input [DCU_DATA_WIDTH - 1:0] wbf_r1_data;
input [(DCU_DATA_WIDTH / 8) - 1:0] wbf_r1_mask;
output [WBF_DEPTH - 1:0] wbf_d1_valid;
output mshr_a_valid;
output [MSHR_DEPTH - 1:0] mshr_a_ptr;
input mshr_a_ready;
output [2:0] mshr_a_opcode;
output [PALEN - 1:0] mshr_a_address;
output [2:0] mshr_a_size;
output [2:0] mshr_a_param;
output [A_UW - 1:0] mshr_a_user;
output [DCU_DATA_WIDTH - 1:0] mshr_a_data;
output [(DCU_DATA_WIDTH / 8) - 1:0] mshr_a_mask;
output mshr_a_corrupt;
input mshr_d_valid;
input [2:0] mshr_d_opcode;
input [MSHR_DEPTH - 1:0] mshr_d_ptr;
input [SINK_WIDTH - 1:0] mshr_d_sink;
input [DCU_DATA_WIDTH - 1:0] mshr_d_data;
input [1:0] mshr_d_param;
input [5:3] mshr_d_offset;
input mshr_d_payload;
input mshr_d_error;
input mshr_d_last;
input [127:0] mshr_d_fildata;
input mshr_d_fildata_last;
input [3:0] mshr_d_l2_way;
output mshr_d_ready;
output mshr_e_valid;
output [SINK_WIDTH - 1:0] mshr_e_sink;
input mshr_e_ready;
output fil_valid;
output [PALEN - 1:0] fil_addr;
output fil_last;
output [3:0] fil_way;
output [2:0] fil_mesi;
output fil_fault;
output fil_lock;
output fil_reserve;
output fil_exclusive;
output [127:0] fil_wdata;
output fil_payload;
output [3:0] fil_data_way;
output [7:0] fil_l2_ways;
input fil_ready;
output dcu_cri_valid;
output [ID_WIDTH - 1:0] dcu_cri_id;
output [31:0] dcu_cri_rdata;
output [31:0] dcu_cri_nbload_result;
output [8:0] dcu_cri_status;
output mshr_async_write_error;


wire [PALEN - 1:0] a_addr;
wire [2:0] a_opcode;
wire [A_UW - 1:0] a_user;
wire [2:0] a_size;
wire [2:0] a_param;
wire [(DCU_DATA_WIDTH - 1):0] a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] a_mask;
wire d_grant;
wire d_fault;
wire [2:0] d_fmt;
wire d_nbload;
wire d_prefetch;
wire [4:0] d_rd;
wire [PALEN - 1:0] d_cri_addr;
wire [7:0] d_cri_addr_onehot;
wire [4:0] d_bresult_sel;
wire [5:0] d_result_sel;
wire [ID_WIDTH - 1:0] d_id;
wire d_crit;
wire [31:0] d_crit_data;
wire arb_a_en;
wire [MSHR_DEPTH - 1:0] arb_a_grant;
wire [MSHR_DEPTH - 1:0] arb_a_ready;
wire [MSHR_DEPTH - 1:0] arb_e_grant;
wire [MSHR_DEPTH - 1:0] arb_e_ready;
wire xlen64 = 1'b0;
wire [MSHR_DEPTH - 1:0] ent_valid;
wire [MSHR_DEPTH - 1:0] ent_invalid = ~ent_valid;
wire [(MSHR_DEPTH * 4) - 1:0] ent_way;
wire [(MSHR_DEPTH * ID_WIDTH) - 1:0] ent_id;
wire [MSHR_DEPTH - 1:0] ent_write_error;
wire [MSHR_DEPTH - 1:0] ent_wna_pending;
wire [MSHR_DEPTH - 1:0] ent_event_miss_cnt;
wire [MSHR_DEPTH - 1:0] ent_event_miss_latency;
wire [WBF_DEPTH * MSHR_DEPTH - 1:0] ent_wbf_index;
wire [MSHR_DEPTH - 1:0] ent_wbf_a_valid;
wire [MSHR_DEPTH - 1:0] ent_wbf_a_ready;
wire [MSHR_DEPTH - 1:0] ent_wbf_w_valid;
wire [MSHR_DEPTH - 1:0] ent_wbf_w_ready;
wire [2 * MSHR_DEPTH - 1:0] ent_wbf_w_addr;
wire [(128 * MSHR_DEPTH) - 1:0] ent_wbf_w_data;
wire [16 * MSHR_DEPTH - 1:0] ent_wbf_w_mask;
wire [MSHR_DEPTH - 1:0] ent_wbf_r_valid;
wire [MSHR_DEPTH - 1:0] ent_wbf_r_ready;
wire [3 * MSHR_DEPTH - 1:0] ent_wbf_r_addr;
wire [(WBF_DEPTH * MSHR_DEPTH) - 1:0] ent_wbf_d_valid;
wire [MSHR_DEPTH - 1:0] ent_a_valid;
wire [MSHR_DEPTH - 1:0] ent_a_last;
wire [MSHR_DEPTH - 1:0] ent_a_ready;
wire [(MSHR_DEPTH * 3) - 1:0] ent_a_param;
wire [(MSHR_DEPTH * PALEN) - 1:0] ent_a_addr;
wire [(MSHR_DEPTH * 3) - 1:0] ent_a_opcode;
wire [(MSHR_DEPTH * A_UW) - 1:0] ent_a_user;
wire [(MSHR_DEPTH * 3) - 1:0] ent_a_size;
wire [(MSHR_DEPTH * DCU_DATA_WIDTH) - 1:0] ent_a_data;
wire [MSHR_DEPTH * (DCU_DATA_WIDTH / 8) - 1:0] ent_a_mask;
wire [MSHR_DEPTH - 1:0] ent_d_grant;
wire [MSHR_DEPTH - 1:0] ent_d_fault;
wire [MSHR_DEPTH - 1:0] ent_d_crit;
wire [(MSHR_DEPTH * 3) - 1:0] ent_d_fmt;
wire [MSHR_DEPTH - 1:0] ent_e_valid;
wire [(MSHR_DEPTH * SINK_WIDTH) - 1:0] ent_e_sink;
wire [MSHR_DEPTH - 1:0] ent_e_ready;
wire [MSHR_DEPTH - 1:0] ent_fil_int_valid;
wire [MSHR_DEPTH - 1:0] ent_fil_int_ready;
wire tb_fil_not_ready = 1'b0;
wire [(MSHR_DEPTH * PALEN) - 1:0] ent_fil_addr;
wire [(MSHR_DEPTH * 3) - 1:0] ent_fil_mesi;
wire [MSHR_DEPTH - 1:0] ent_fil_fault;
wire [MSHR_DEPTH - 1:0] ent_fil_lock;
wire [MSHR_DEPTH - 1:0] ent_fil_reserve;
wire [MSHR_DEPTH - 1:0] ent_fil_exclusive;
wire [(MSHR_DEPTH * 8) - 1:0] ent_fil_l2_ways;
wire [MSHR_DEPTH - 1:0] ent_fil_last;
wire [(MSHR_DEPTH * PALEN) - 1:0] ent_cri_addr;
wire [MSHR_DEPTH - 1:0] ent_cri_nbload;
wire [MSHR_DEPTH - 1:0] ent_cri_prefetch;
wire [(MSHR_DEPTH * 5) - 1:0] ent_cri_rd;
wire [MSHR_DEPTH - 1:0] free_ptr;
wire [MSHR_DEPTH - 1:0] ent_cmp_hit;
wire [MSHR_DEPTH - 1:0] ent_cmp_sameidx;
wire [(3 * MSHR_DEPTH) - 1:0] ent_cmp_mesi;
wire [(MSHR_DEPTH * 4) - 1:0] ent_cmp_tagw;
wire [MSHR_DEPTH - 1:0] ent_cmp_changing;
wire [3:0] ent_hit_way;
wire ent_hit_changing;
wire [2:0] ent_hit_mesi;
wire enq_valid = mshr_enq_valid & ~mshr_enq_stall;
wire [MSHR_DEPTH - 1:0] mshr_enq_ptr = mshr_enq_mrg ? mshr_enq_mrg_ptr : free_ptr;
wire [MSHR_DEPTH - 1:0] ent_enq_valid = {MSHR_DEPTH{enq_valid}} & mshr_enq_ptr;
wire [PALEN - 1:0] ent_enq_addr;
wire [MSHR_DEPTH - 1:0] ent_prb_valid = {MSHR_DEPTH{mshr_prb_valid}} & mshr_prb_ptr;
wire [MSHR_DEPTH - 1:0] arb_wbf_a_valid;
wire [MSHR_DEPTH - 1:0] arb_wbf_a_ready;
wire [MSHR_DEPTH - 1:0] nds_unused_arb_wbf_a_grant;
wire arb_wbf_r_grant_en;
reg [MSHR_DEPTH - 1:0] arb_wbf_r_grant;
wire [MSHR_DEPTH - 1:0] arb_wbf_r_grant_nx;
wire wbf_a1_grant;
wire [MSHR_DEPTH - 1:0] arb_fil_int_valid;
wire [MSHR_DEPTH - 1:0] arb_fil_int_ready;
wire [MSHR_DEPTH - 1:0] arb_fil_int_grant;
wire [MSHR_DEPTH - 1:0] arb_fil_grant;
wire mshr_d_opcode_grant = (mshr_d_opcode == 3'd4);
wire mshr_d_opcode_grantdata = (mshr_d_opcode == 3'd5);
wire mshr_d_opcode_grants = mshr_d_opcode_grant | mshr_d_opcode_grantdata;
wire fil_int_valid;
wire fil_ext_valid;
wire tb_full = 1'b0;
generate
    genvar i;
    for (i = 0; i < MSHR_DEPTH; i = i + 1) begin:gen_ent
        kv_dcu_mshr_ent #(
            .PALEN(PALEN),
            .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
            .WBF_DEPTH(WBF_DEPTH),
            .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
            .DCACHE_WAY(DCACHE_WAY),
            .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT),
            .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
            .SINK_WIDTH(SINK_WIDTH),
            .A_UW(A_UW)
        ) u_mshr_ent (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .cmp_addr(mshr_cmp_addr),
            .cmp_func(mshr_cmp_func),
            .cmp_hit(ent_cmp_hit[i]),
            .cmp_sameidx(ent_cmp_sameidx[i]),
            .cmp_mesi(ent_cmp_mesi[3 * i +:3]),
            .cmp_tagw(ent_cmp_tagw[i * 4 +:4]),
            .cmp_changing(ent_cmp_changing[i]),
            .enq_valid(ent_enq_valid[i]),
            .enq_mrg(mshr_enq_mrg),
            .enq_spec(mshr_enq_spec),
            .enq_addr(ent_enq_addr),
            .enq_id(mshr_enq_id),
            .enq_state(mshr_enq_state),
            .enq_way(mshr_enq_way),
            .enq_l2_ways(mshr_enq_l2_ways),
            .enq_func(mshr_enq_func),
            .event_miss_cnt(ent_event_miss_cnt[i]),
            .event_miss_latency(ent_event_miss_latency[i]),
            .prb_valid(ent_prb_valid[i]),
            .prb_mesi(mshr_prb_mesi),
            .wbf_flush(mshr_wbf_flush),
            .wbf_a1_valid(wbf_a1_valid),
            .wbf_index(ent_wbf_index[i * WBF_DEPTH +:WBF_DEPTH]),
            .wbf_a_valid(ent_wbf_a_valid[i]),
            .wbf_a_index(wbf_a1_index),
            .wbf_a_ready(ent_wbf_a_ready[i]),
            .wbf_w_valid(ent_wbf_w_valid[i]),
            .wbf_w_ready(ent_wbf_w_ready[i]),
            .wbf_w_addr(ent_wbf_w_addr[i * 2 +:2]),
            .wbf_w_data(ent_wbf_w_data[i * 128 +:128]),
            .wbf_w_mask(ent_wbf_w_mask[i * 16 +:16]),
            .wbf_r_valid(ent_wbf_r_valid[i]),
            .wbf_r_ready(ent_wbf_r_ready[i]),
            .wbf_r_addr(ent_wbf_r_addr[i * 3 +:3]),
            .wbf_r_data(wbf_r1_data),
            .wbf_r_mask(wbf_r1_mask),
            .wbf_d_valid(ent_wbf_d_valid[i * WBF_DEPTH +:WBF_DEPTH]),
            .cmt_select(mshr_cmt_ptr[i]),
            .cmt_valid(mshr_cmt_valid),
            .cmt_addr(mshr_cmt_addr),
            .cmt_kill(mshr_cmt_kill),
            .cmt_attr(mshr_cmt_attr),
            .cmt_wdata(mshr_cmt_wdata),
            .cmt_wmask(mshr_cmt_wmask),
            .valid(ent_valid[i]),
            .id(ent_id[i * ID_WIDTH +:ID_WIDTH]),
            .way(ent_way[i * 4 +:4]),
            .write_error(ent_write_error[i]),
            .ent_speculative(mshr_ent_speculative[i]),
            .ent_killed(mshr_ent_killed[i]),
            .ent_wt(mshr_ent_wt[i]),
            .ent_na(mshr_ent_na[i]),
            .ent_na_mrg(mshr_ent_na_mrg[i]),
            .ent_wbf(mshr_ent_wbf[i]),
            .ent_wbf_cft(mshr_ent_wbf_cft[i]),
            .ent_write(mshr_ent_write[i]),
            .ent_write_mrg(mshr_ent_write_mrg[i]),
            .ent_wna_pending(ent_wna_pending[i]),
            .a_valid(ent_a_valid[i]),
            .a_last(ent_a_last[i]),
            .a_param(ent_a_param[i * 3 +:3]),
            .a_ready(ent_a_ready[i]),
            .a_opcode(ent_a_opcode[i * 3 +:3]),
            .a_user(ent_a_user[i * A_UW +:A_UW]),
            .a_addr(ent_a_addr[i * PALEN +:PALEN]),
            .a_size(ent_a_size[i * 3 +:3]),
            .a_data(ent_a_data[i * DCU_DATA_WIDTH +:DCU_DATA_WIDTH]),
            .a_mask(ent_a_mask[i * (DCU_DATA_WIDTH / 8) +:(DCU_DATA_WIDTH / 8)]),
            .d_grant(ent_d_grant[i]),
            .d_opcode(mshr_d_opcode),
            .d_error(mshr_d_error),
            .d_sink(mshr_d_sink),
            .d_param(mshr_d_param),
            .d_last(mshr_d_last),
            .d_offset(mshr_d_offset),
            .d_data(mshr_d_data),
            .d_payload(mshr_d_payload),
            .d_l2_way(mshr_d_l2_way),
            .d_fault(ent_d_fault[i]),
            .d_crit(ent_d_crit[i]),
            .d_fmt(ent_d_fmt[i * 3 +:3]),
            .e_valid(ent_e_valid[i]),
            .e_sink(ent_e_sink[i * SINK_WIDTH +:SINK_WIDTH]),
            .e_ready(ent_e_ready[i]),
            .fil_int_valid(ent_fil_int_valid[i]),
            .fil_int_ready(ent_fil_int_ready[i]),
            .fil_addr(ent_fil_addr[i * PALEN +:PALEN]),
            .fil_mesi(ent_fil_mesi[i * 3 +:3]),
            .fil_fault(ent_fil_fault[i]),
            .fil_lock(ent_fil_lock[i]),
            .fil_reserve(ent_fil_reserve[i]),
            .fil_exclusive(ent_fil_exclusive[i]),
            .fil_l2_ways(ent_fil_l2_ways[i * 8 +:8]),
            .fil_last(ent_fil_last[i]),
            .cri_addr(ent_cri_addr[i * PALEN +:PALEN]),
            .cri_nbload(ent_cri_nbload[i]),
            .cri_prefetch(ent_cri_prefetch[i]),
            .cri_rd(ent_cri_rd[i * 5 +:5])
        );
    end
endgenerate
kv_zero_ext #(
    .OW(8),
    .IW(MSHR_DEPTH)
) u_mshr_event_miss_cnt (
    .out(mshr_event[7:0]),
    .in(ent_event_miss_cnt)
);
kv_zero_ext #(
    .OW(8),
    .IW(MSHR_DEPTH)
) u_mshr_event_miss_latency (
    .out(mshr_event[15:8]),
    .in(ent_event_miss_latency)
);
assign dcu_wna_pending = |ent_wna_pending;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(4)
) u_ent_hit_way (
    .out(ent_hit_way),
    .sel(ent_cmp_hit),
    .in(ent_way)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_ent_hit_changing (
    .out(ent_hit_changing),
    .sel(ent_cmp_hit),
    .in(ent_cmp_changing)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_ent_hit_mesi (
    .out(ent_hit_mesi),
    .sel(ent_cmp_hit),
    .in(ent_cmp_mesi)
);
assign mshr_cmp_hit = ent_cmp_hit;
assign mshr_cmp_sameidx = ent_cmp_sameidx;
assign mshr_cmp_way = ent_hit_way;
assign mshr_cmp_mesi = ent_hit_mesi;
assign mshr_cmp_changing = ent_hit_changing;
kv_vor #(
    .N(MSHR_DEPTH),
    .W(4)
) u_mshr_cmp_tagw (
    .out(mshr_cmp_tagw),
    .in(ent_cmp_tagw)
);
kv_ffs #(
    .WIDTH(MSHR_DEPTH)
) u_free_ptr (
    .out(free_ptr),
    .in(ent_invalid)
);
assign mshr_empty = ~|ent_valid;
assign mshr_full = (&ent_valid) | tb_full;
assign mshr_free_ptr = free_ptr;
assign ent_enq_addr = mshr_enq_addr;
kv_arb_rr #(
    .N(MSHR_DEPTH)
) u_arb_wbf_a (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(wbf_a1_grant),
    .valid(arb_wbf_a_valid),
    .ready(arb_wbf_a_ready),
    .grant(nds_unused_arb_wbf_a_grant)
);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        arb_wbf_r_grant <= {MSHR_DEPTH{1'b0}};
    end
    else if (arb_wbf_r_grant_en) begin
        arb_wbf_r_grant <= arb_wbf_r_grant_nx;
    end
end

assign arb_wbf_a_valid = ent_wbf_a_valid;
assign ent_wbf_a_ready = arb_wbf_a_ready & {MSHR_DEPTH{wbf_a1_ready}};
assign wbf_a1_valid = |arb_wbf_a_valid;
assign wbf_a1_grant = wbf_a1_valid & wbf_a1_ready;
assign ent_wbf_w_ready = {MSHR_DEPTH{1'b1}};
assign wbf_w1_valid = |ent_wbf_w_valid;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_w1_index (
    .out(wbf_w1_index),
    .sel(ent_wbf_w_valid),
    .in(ent_wbf_index)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(2)
) u_wbf_w1_addr (
    .out(wbf_w1_addr),
    .sel(ent_wbf_w_valid),
    .in(ent_wbf_w_addr)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(128)
) u_wbf_w1_data (
    .out(wbf_w1_data),
    .sel(ent_wbf_w_valid),
    .in(ent_wbf_w_data)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(16)
) u_wbf_w1_mask (
    .out(wbf_w1_mask),
    .sel(ent_wbf_w_valid),
    .in(ent_wbf_w_mask)
);
kv_ffs #(
    .WIDTH(MSHR_DEPTH)
) u_arb_wbf_r_grant_nx (
    .out(arb_wbf_r_grant_nx),
    .in(ent_wbf_r_valid)
);
assign arb_wbf_r_grant_en = (~|(arb_wbf_r_grant & ent_wbf_r_valid)) & |ent_wbf_r_valid;
assign ent_wbf_r_ready = arb_wbf_r_grant;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_r1_index (
    .out(wbf_r1_index),
    .sel(arb_wbf_r_grant),
    .in(ent_wbf_index)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_wbf_r1_addr (
    .out(wbf_r1_addr),
    .sel(arb_wbf_r_grant),
    .in(ent_wbf_r_addr)
);
kv_vor #(
    .N(MSHR_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_d1_valid (
    .out(wbf_d1_valid),
    .in(ent_wbf_d_valid)
);
kv_arb_rr_mb #(
    .N(MSHR_DEPTH)
) u_arb_a (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(arb_a_en),
    .valid(ent_a_valid),
    .last(ent_a_last),
    .ready(arb_a_ready),
    .grant(arb_a_grant),
    .valid_out(mshr_a_valid)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(PALEN)
) u_a_addr (
    .out(a_addr),
    .sel(arb_a_grant),
    .in(ent_a_addr)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_a_func (
    .out(a_param),
    .sel(arb_a_grant),
    .in(ent_a_param)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_a_opcode (
    .out(a_opcode),
    .sel(arb_a_grant),
    .in(ent_a_opcode)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(A_UW)
) u_a_user (
    .out(a_user),
    .sel(arb_a_grant),
    .in(ent_a_user)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_a_size (
    .out(a_size),
    .sel(arb_a_grant),
    .in(ent_a_size)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(DCU_DATA_WIDTH)
) u_a_wdata (
    .out(a_data),
    .sel(arb_a_grant),
    .in(ent_a_data)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(DCU_DATA_WIDTH / 8)
) u_a_wmask (
    .out(a_mask),
    .sel(arb_a_grant),
    .in(ent_a_mask)
);
assign arb_a_en = mshr_a_valid & mshr_a_ready;
assign mshr_a_opcode = a_opcode;
assign mshr_a_address = a_addr;
assign mshr_a_size = a_size;
assign mshr_a_param = a_param;
assign mshr_a_user = a_user;
assign mshr_a_data = a_data;
assign mshr_a_mask = a_mask;
assign mshr_a_corrupt = 1'b0;
assign mshr_a_ptr = arb_a_grant;
assign ent_a_ready = arb_a_ready & {MSHR_DEPTH{mshr_a_ready}};
kv_arb_rr #(
    .N(MSHR_DEPTH)
) u_arb_e (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(mshr_e_ready),
    .valid(ent_e_valid),
    .ready(arb_e_ready),
    .grant(arb_e_grant)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(SINK_WIDTH)
) u_mshr_e_sink (
    .out(mshr_e_sink),
    .sel(arb_e_grant),
    .in(ent_e_sink)
);
assign mshr_e_valid = |ent_e_valid;
assign ent_e_ready = arb_e_grant & {MSHR_DEPTH{mshr_e_ready}};
assign d_grant = mshr_d_valid & mshr_d_ready;
assign mshr_d_ready = fil_ready;
assign ent_d_grant = {MSHR_DEPTH{d_grant}} & mshr_d_ptr;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(4)
) u_fil_data_way (
    .out(fil_data_way),
    .sel(mshr_d_ptr),
    .in(ent_way)
);
assign fil_ext_valid = d_grant & mshr_d_opcode_grant | d_grant & mshr_d_opcode_grantdata & mshr_d_fildata_last;
assign fil_wdata = mshr_d_fildata;
kv_arb_fp #(
    .N(MSHR_DEPTH)
) u_arb_fil_int (
    .valid(arb_fil_int_valid),
    .ready(arb_fil_int_ready),
    .grant(arb_fil_int_grant)
);
assign arb_fil_int_valid = ent_fil_int_valid & {MSHR_DEPTH{~tb_fil_not_ready}};
assign ent_fil_int_ready = {MSHR_DEPTH{fil_ready & ~mshr_d_valid}} & arb_fil_int_ready & {MSHR_DEPTH{~tb_fil_not_ready}};
assign fil_int_valid = |ent_fil_int_valid & ~tb_fil_not_ready;
assign arb_fil_grant = mshr_d_valid ? mshr_d_ptr : arb_fil_int_grant;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(4)
) u_fil_way (
    .out(fil_way),
    .sel(arb_fil_grant),
    .in(ent_way)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(PALEN)
) u_fil_addr (
    .out(fil_addr),
    .sel(arb_fil_grant),
    .in(ent_fil_addr)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_fil_mesi (
    .out(fil_mesi),
    .sel(arb_fil_grant),
    .in(ent_fil_mesi)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_fil_fault (
    .out(fil_fault),
    .sel(arb_fil_grant),
    .in(ent_fil_fault)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_fil_lock (
    .out(fil_lock),
    .sel(arb_fil_grant),
    .in(ent_fil_lock)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_fil_reserve (
    .out(fil_reserve),
    .sel(arb_fil_grant),
    .in(ent_fil_reserve)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_fil_exclusive (
    .out(fil_exclusive),
    .sel(arb_fil_grant),
    .in(ent_fil_exclusive)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_fil_last (
    .out(fil_last),
    .sel(arb_fil_grant),
    .in(ent_fil_last)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(8)
) u_fil_l2_ways (
    .out(fil_l2_ways),
    .sel(arb_fil_grant),
    .in(ent_fil_l2_ways)
);
assign fil_valid = fil_ext_valid | (fil_int_valid & ~mshr_d_valid);
assign fil_payload = mshr_d_valid ? mshr_d_payload : 1'b0;
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(ID_WIDTH)
) u_d_id (
    .out(d_id),
    .sel(mshr_d_ptr),
    .in(ent_id)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_d_crit (
    .out(d_crit),
    .sel(mshr_d_ptr),
    .in(ent_d_crit)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_d_fault (
    .out(d_fault),
    .sel(mshr_d_ptr),
    .in(ent_d_fault)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(3)
) u_d_func3 (
    .out(d_fmt),
    .sel(mshr_d_ptr),
    .in(ent_d_fmt)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(PALEN)
) u_d_cri_addr (
    .out(d_cri_addr),
    .sel(mshr_d_ptr),
    .in(ent_cri_addr)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_d_nbload (
    .out(d_nbload),
    .sel(mshr_d_ptr),
    .in(ent_cri_nbload)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(1)
) u_d_prefetch (
    .out(d_prefetch),
    .sel(mshr_d_ptr),
    .in(ent_cri_prefetch)
);
kv_mux_onehot #(
    .N(MSHR_DEPTH),
    .W(5)
) u_d_cri_rd (
    .out(d_rd),
    .sel(mshr_d_ptr),
    .in(ent_cri_rd)
);
generate
    if (XW_RATIO_LOG2 != 0) begin:gen_cri_data_mux
        kv_mux #(
            .N(XW_RATIO),
            .W(32)
        ) u_d_crit_data (
            .out(d_crit_data),
            .sel(d_cri_addr[GRN_LSB +:XW_RATIO_LOG2]),
            .in(mshr_d_data)
        );
    end
    else begin:gen_cri_data_mux_stub
        assign d_crit_data = mshr_d_data;
    end
endgenerate
assign dcu_cri_valid = d_grant & d_crit;
assign dcu_cri_id = d_id;
assign dcu_cri_rdata = d_crit_data;
assign dcu_cri_status[0] = d_fault;
assign dcu_cri_status[1] = d_nbload;
assign dcu_cri_status[2 +:5] = d_rd;
assign dcu_cri_status[7] = d_prefetch;
assign dcu_cri_status[8] = 1'b1;
assign d_cri_addr_onehot[0] = (d_cri_addr[1:0] == 2'd0) & ~(xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[1] = (d_cri_addr[1:0] == 2'd1) & ~(xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[2] = (d_cri_addr[1:0] == 2'd2) & ~(xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[3] = (d_cri_addr[1:0] == 2'd3) & ~(xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[4] = (d_cri_addr[1:0] == 2'd0) & (xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[5] = (d_cri_addr[1:0] == 2'd1) & (xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[6] = (d_cri_addr[1:0] == 2'd2) & (xlen64 & d_cri_addr[2]);
assign d_cri_addr_onehot[7] = (d_cri_addr[1:0] == 2'd3) & (xlen64 & d_cri_addr[2]);
assign d_result_sel[0] = (d_fmt[1:0] == 2'd3) | (d_fmt[1:0] == 2'd2) | (d_fmt[1:0] == 2'd1);
assign d_result_sel[1] = (d_fmt[1:0] == 2'd3) | (d_fmt[1:0] == 2'd2);
assign d_result_sel[2] = (d_fmt[1:0] == 2'd3);
assign d_result_sel[3] = (d_fmt[2:0] == 3'd0);
assign d_result_sel[4] = (d_fmt[2:0] == 3'd1);
assign d_result_sel[5] = (d_fmt[2:0] == 3'd2);
assign d_bresult_sel[0] = (d_fmt[1:0] == 2'd3) | ((d_fmt[1:0] == 2'd2) & ~d_cri_addr[2]);
assign d_bresult_sel[1] = ((d_fmt[1:0] == 2'd2) & d_cri_addr[2]);
assign d_bresult_sel[2] = (d_fmt[1:0] == 2'd3);
assign d_bresult_sel[3] = (d_fmt[2:0] == 3'd2) & (d_cri_addr[2:0] == 3'd2);
assign d_bresult_sel[4] = (d_fmt[2:0] == 3'd2) & (d_cri_addr[2:0] == 3'd6);
wire [31:0] nds_unused_dcu_cri_nbload_bresult;
wire [63:0] nds_unused_dcu_cri_nbload_result2;
kv_fmt_load u_nbload_result(
    .addr_onehot(d_cri_addr_onehot),
    .offset_onehot(7'd0),
    .mem_rdata(d_crit_data),
    .result_sel(d_result_sel),
    .bresult_sel(d_bresult_sel),
    .result(dcu_cri_nbload_result),
    .bresult(nds_unused_dcu_cri_nbload_bresult),
    .result2(nds_unused_dcu_cri_nbload_result2)
);
assign mshr_async_write_error = |ent_write_error;
endmodule

