// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_tlc_mux (
    us_a_opcode,
    us_a_param,
    us_a_user,
    us_a_size,
    us_a_address,
    us_a_source,
    us_a_data,
    us_a_mask,
    us_a_corrupt,
    us_a_valid,
    us_a_ready,
    us_b_opcode,
    us_b_param,
    us_b_size,
    us_b_source,
    us_b_address,
    us_b_user,
    us_b_data,
    us_b_mask,
    us_b_corrupt,
    us_b_valid,
    us_b_ready,
    us_c_opcode,
    us_c_param,
    us_c_user,
    us_c_size,
    us_c_address,
    us_c_source,
    us_c_data,
    us_c_corrupt,
    us_c_valid,
    us_c_ready,
    us_d_opcode,
    us_d_param,
    us_d_size,
    us_d_user,
    us_d_data,
    us_d_source,
    us_d_sink,
    us_d_denied,
    us_d_corrupt,
    us_d_valid,
    us_d_ready,
    us_e_valid,
    us_e_user,
    us_e_sink,
    us_e_ready,
    ds_a_opcode,
    ds_a_param,
    ds_a_user,
    ds_a_size,
    ds_a_address,
    ds_a_data,
    ds_a_mask,
    ds_a_source,
    ds_a_corrupt,
    ds_a_valid,
    ds_a_ready,
    ds_b_opcode,
    ds_b_param,
    ds_b_size,
    ds_b_source,
    ds_b_address,
    ds_b_user,
    ds_b_data,
    ds_b_mask,
    ds_b_corrupt,
    ds_b_valid,
    ds_b_ready,
    ds_c_opcode,
    ds_c_param,
    ds_c_user,
    ds_c_size,
    ds_c_address,
    ds_c_source,
    ds_c_data,
    ds_c_corrupt,
    ds_c_valid,
    ds_c_ready,
    ds_d_opcode,
    ds_d_param,
    ds_d_user,
    ds_d_size,
    ds_d_data,
    ds_d_source,
    ds_d_sink,
    ds_d_denied,
    ds_d_corrupt,
    ds_d_valid,
    ds_d_ready,
    ds_e_valid,
    ds_e_user,
    ds_e_sink,
    ds_e_ready,
    clk,
    resetn
);
parameter N = 2;
parameter AW = 32;
parameter DW = 32;
parameter TL_SIZE_WIDTH = 3;
parameter TL_SOURCE_WIDTH = 2;
parameter TL_SINK_WIDTH = 2;
parameter TL_A_USER_WIDTH = 2;
parameter TL_B_USER_WIDTH = 2;
parameter TL_C_USER_WIDTH = 2;
parameter TL_D_USER_WIDTH = 2;
parameter TL_E_USER_WIDTH = 2;
localparam MAX_BYTE_LOG2 = {{32 - TL_SIZE_WIDTH{1'b0}},{TL_SIZE_WIDTH{1'b1}}};
localparam DATA_BYTE_WIDTH_LOG2 = $unsigned($clog2(DW / 8));
localparam BEAT_CNT_WIDTH = MAX_BYTE_LOG2 - DATA_BYTE_WIDTH_LOG2;
input [(3 * N) - 1:0] us_a_opcode;
input [(3 * N) - 1:0] us_a_param;
input [(TL_A_USER_WIDTH * N) - 1:0] us_a_user;
input [(TL_SIZE_WIDTH * N) - 1:0] us_a_size;
input [(AW * N) - 1:0] us_a_address;
input [(TL_SOURCE_WIDTH * N) - 1:0] us_a_source;
input [(DW * N) - 1:0] us_a_data;
input [(DW * N / 8) - 1:0] us_a_mask;
input [N - 1:0] us_a_corrupt;
input [N - 1:0] us_a_valid;
output [N - 1:0] us_a_ready;
output [(3 * N) - 1:0] us_b_opcode;
output [(3 * N) - 1:0] us_b_param;
output [(TL_SIZE_WIDTH * N) - 1:0] us_b_size;
output [(TL_SOURCE_WIDTH * N) - 1:0] us_b_source;
output [(AW * N) - 1:0] us_b_address;
output [(TL_B_USER_WIDTH * N) - 1:0] us_b_user;
output [(DW * N) - 1:0] us_b_data;
output [(DW * N / 8) - 1:0] us_b_mask;
output [N - 1:0] us_b_corrupt;
output [N - 1:0] us_b_valid;
input [N - 1:0] us_b_ready;
input [(3 * N) - 1:0] us_c_opcode;
input [(3 * N) - 1:0] us_c_param;
input [(TL_C_USER_WIDTH * N) - 1:0] us_c_user;
input [(TL_SIZE_WIDTH * N) - 1:0] us_c_size;
input [(AW * N) - 1:0] us_c_address;
input [(TL_SOURCE_WIDTH * N) - 1:0] us_c_source;
input [(DW * N) - 1:0] us_c_data;
input [N - 1:0] us_c_corrupt;
input [N - 1:0] us_c_valid;
output [N - 1:0] us_c_ready;
output [(3 * N) - 1:0] us_d_opcode;
output [(2 * N) - 1:0] us_d_param;
output [(3 * N) - 1:0] us_d_size;
output [(TL_D_USER_WIDTH * N) - 1:0] us_d_user;
output [(DW * N) - 1:0] us_d_data;
output [(TL_SOURCE_WIDTH * N) - 1:0] us_d_source;
output [(TL_SINK_WIDTH * N) - 1:0] us_d_sink;
output [N - 1:0] us_d_denied;
output [N - 1:0] us_d_corrupt;
output [N - 1:0] us_d_valid;
input [N - 1:0] us_d_ready;
input [N - 1:0] us_e_valid;
input [(TL_E_USER_WIDTH * N) - 1:0] us_e_user;
input [(TL_SINK_WIDTH * N) - 1:0] us_e_sink;
output [N - 1:0] us_e_ready;
output [2:0] ds_a_opcode;
output [2:0] ds_a_param;
output [TL_A_USER_WIDTH - 1:0] ds_a_user;
output [TL_SIZE_WIDTH - 1:0] ds_a_size;
output [AW - 1:0] ds_a_address;
output [DW - 1:0] ds_a_data;
output [(DW / 8) - 1:0] ds_a_mask;
output [TL_SOURCE_WIDTH - 1:0] ds_a_source;
output ds_a_corrupt;
output ds_a_valid;
input ds_a_ready;
input [2:0] ds_b_opcode;
input [2:0] ds_b_param;
input [TL_SIZE_WIDTH - 1:0] ds_b_size;
input [TL_SOURCE_WIDTH - 1:0] ds_b_source;
input [AW - 1:0] ds_b_address;
input [TL_B_USER_WIDTH - 1:0] ds_b_user;
input [DW - 1:0] ds_b_data;
input [(DW / 8) - 1:0] ds_b_mask;
input ds_b_corrupt;
input ds_b_valid;
output ds_b_ready;
output [2:0] ds_c_opcode;
output [2:0] ds_c_param;
output [TL_C_USER_WIDTH - 1:0] ds_c_user;
output [TL_SIZE_WIDTH - 1:0] ds_c_size;
output [AW - 1:0] ds_c_address;
output [TL_SOURCE_WIDTH - 1:0] ds_c_source;
output [DW - 1:0] ds_c_data;
output ds_c_corrupt;
output ds_c_valid;
input ds_c_ready;
input [2:0] ds_d_opcode;
input [1:0] ds_d_param;
input [TL_D_USER_WIDTH - 1:0] ds_d_user;
input [TL_SIZE_WIDTH - 1:0] ds_d_size;
input [DW - 1:0] ds_d_data;
input [TL_SOURCE_WIDTH - 1:0] ds_d_source;
input [TL_SINK_WIDTH - 1:0] ds_d_sink;
input ds_d_denied;
input ds_d_corrupt;
input ds_d_valid;
output ds_d_ready;
output ds_e_valid;
output [TL_E_USER_WIDTH - 1:0] ds_e_user;
output [TL_SINK_WIDTH - 1:0] ds_e_sink;
input ds_e_ready;
input clk;
input resetn;


wire [N - 1:0] us_a_grant;
wire [N - 1:0] ds_b_sel;
wire [N - 1:0] us_c_grant;
wire [N - 1:0] ds_d_sel;
wire [N - 1:0] us_e_grant;
wire [N - 1:0] arb_e_ready;
wire [N - 1:0] a_lasts;
wire [N - 1:0] c_lasts;
wire [7:0] a_burst_size;
wire [BEAT_CNT_WIDTH - 1:0] a_len;
reg [BEAT_CNT_WIDTH - 1:0] a_last_cnt;
wire [BEAT_CNT_WIDTH - 1:0] a_last_cnt_nx;
wire [BEAT_CNT_WIDTH - 1:0] a_last_cnt_inc;
wire a_last_cnt_en;
wire a_last;
assign a_burst_size = ~({8{1'b1}} << ds_a_size);
assign a_len = a_burst_size[DATA_BYTE_WIDTH_LOG2 +:BEAT_CNT_WIDTH];
assign a_last_cnt_en = ds_a_valid & ds_a_ready;
assign a_last_cnt_nx = {BEAT_CNT_WIDTH{~a_last}} & a_last_cnt_inc;
assign a_last_cnt_inc = a_last_cnt + {{BEAT_CNT_WIDTH - 1{1'b0}},1'b1};
assign a_last = (a_last_cnt == a_len) | (ds_a_opcode != 3'd1) & (ds_a_opcode != 3'd0);
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        a_last_cnt <= {BEAT_CNT_WIDTH{1'b0}};
    end
    else if (a_last_cnt_en) begin
        a_last_cnt <= a_last_cnt_nx;
    end
end

assign a_lasts = {N{a_last}};
wire [7:0] c_burst_size;
wire [BEAT_CNT_WIDTH - 1:0] c_len;
reg [BEAT_CNT_WIDTH - 1:0] c_last_cnt;
wire [BEAT_CNT_WIDTH - 1:0] c_last_cnt_nx;
wire [BEAT_CNT_WIDTH - 1:0] c_last_cnt_inc;
wire c_last_cnt_en;
wire c_last;
assign c_burst_size = ~({8{1'b1}} << ds_c_size);
assign c_len = c_burst_size[DATA_BYTE_WIDTH_LOG2 +:BEAT_CNT_WIDTH];
assign c_last_cnt_en = ds_c_valid & ds_c_ready;
assign c_last_cnt_nx = {BEAT_CNT_WIDTH{~c_last}} & c_last_cnt_inc;
assign c_last_cnt_inc = c_last_cnt + {{BEAT_CNT_WIDTH - 1{1'b0}},1'b1};
assign c_last = (c_last_cnt == c_len) | (ds_c_opcode != 3'd7);
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        c_last_cnt <= {BEAT_CNT_WIDTH{1'b0}};
    end
    else if (c_last_cnt_en) begin
        c_last_cnt <= c_last_cnt_nx;
    end
end

assign c_lasts = {N{c_last}};
kv_arb_fp_mb #(
    .N(N)
) u_a_arb (
    .clk(clk),
    .resetn(resetn),
    .valids(us_a_valid),
    .readys(us_a_ready),
    .grants(us_a_grant),
    .ready(ds_a_ready),
    .valid(ds_a_valid),
    .lasts(a_lasts)
);
kv_arb_fp_mb #(
    .N(N)
) u_c_arb (
    .clk(clk),
    .resetn(resetn),
    .valids(us_c_valid),
    .readys(us_c_ready),
    .grants(us_c_grant),
    .ready(ds_c_ready),
    .valid(ds_c_valid),
    .lasts(c_lasts)
);
kv_arb_fp #(
    .N(N)
) u_e_arb (
    .valid(us_e_valid),
    .ready(arb_e_ready),
    .grant(us_e_grant)
);
assign us_e_ready = arb_e_ready & {N{ds_e_ready}};
assign ds_e_valid = |us_e_valid;
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_a_opcode (
    .out(ds_a_opcode),
    .in(us_a_opcode),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_a_param (
    .out(ds_a_param),
    .in(us_a_param),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_A_USER_WIDTH)
) u_ds_a_user (
    .out(ds_a_user),
    .in(us_a_user),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_a_size (
    .out(ds_a_size),
    .in(us_a_size),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(AW)
) u_ds_a_address (
    .out(ds_a_address),
    .in(us_a_address),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(DW)
) u_ds_a_data (
    .out(ds_a_data),
    .in(us_a_data),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(DW / 8)
) u_ds_a_mask (
    .out(ds_a_mask),
    .in(us_a_mask),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SOURCE_WIDTH)
) u_ds_a_source (
    .out(ds_a_source),
    .in(us_a_source),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_ds_a_corrupt (
    .out(ds_a_corrupt),
    .in(us_a_corrupt),
    .sel(us_a_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_c_opcode (
    .out(ds_c_opcode),
    .in(us_c_opcode),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_c_param (
    .out(ds_c_param),
    .in(us_c_param),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_C_USER_WIDTH)
) u_ds_c_user (
    .out(ds_c_user),
    .in(us_c_user),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(3)
) u_ds_c_size (
    .out(ds_c_size),
    .in(us_c_size),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(AW)
) u_ds_c_address (
    .out(ds_c_address),
    .in(us_c_address),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(DW)
) u_ds_c_data (
    .out(ds_c_data),
    .in(us_c_data),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SOURCE_WIDTH)
) u_ds_c_source (
    .out(ds_c_source),
    .in(us_c_source),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_ds_c_corrupt (
    .out(ds_c_corrupt),
    .in(us_c_corrupt),
    .sel(us_c_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_SINK_WIDTH)
) u_ds_e_sink (
    .out(ds_e_sink),
    .in(us_e_sink),
    .sel(us_e_grant)
);
kv_mux_onehot #(
    .N(N),
    .W(TL_E_USER_WIDTH)
) u_ds_e_user (
    .out(ds_e_user),
    .in(us_e_user),
    .sel(us_e_grant)
);
kv_tl_id_dec #(
    .N(N)
) u_ds_d_sel (
    .sel(ds_d_sel),
    .source(ds_d_source)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_ds_d_ready (
    .out(ds_d_ready),
    .in(us_d_ready),
    .sel(ds_d_sel)
);
assign us_d_opcode = {N{ds_d_opcode}};
assign us_d_param = {N{ds_d_param}};
assign us_d_user = {N{ds_d_user}};
assign us_d_size = {N{ds_d_size}};
assign us_d_data = {N{ds_d_data}};
assign us_d_source = {N{ds_d_source}};
assign us_d_sink = {N{ds_d_sink}};
assign us_d_denied = {N{ds_d_denied}};
assign us_d_corrupt = {N{ds_d_corrupt}};
assign us_d_valid = {N{ds_d_valid}} & ds_d_sel;
kv_tl_id_dec #(
    .N(N)
) u_ds_b_sel (
    .sel(ds_b_sel),
    .source(ds_b_source)
);
kv_mux_onehot #(
    .N(N),
    .W(1)
) u_ds_b_ready (
    .out(ds_b_ready),
    .in(us_b_ready),
    .sel(ds_b_sel)
);
assign us_b_address = {N{ds_b_address}};
assign us_b_opcode = {N{ds_b_opcode}};
assign us_b_param = {N{ds_b_param}};
assign us_b_user = {N{ds_b_user}};
assign us_b_mask = {N{ds_b_mask}};
assign us_b_size = {N{ds_b_size}};
assign us_b_data = {N{ds_b_data}};
assign us_b_source = {N{ds_b_source}};
assign us_b_corrupt = {N{ds_b_corrupt}};
assign us_b_valid = {N{ds_b_valid}} & ds_b_sel;
endmodule

