// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_wbf (
    dcu_clk,
    dcu_reset_n,
    wbf_a0_valid,
    wbf_a0_kill,
    wbf_a0_index,
    wbf_a0_ready,
    wbf_w0_valid,
    wbf_w0_index,
    wbf_w0_addr,
    wbf_w0_data,
    wbf_r0_index,
    wbf_r0_addr,
    wbf_r0_data,
    wbf_d0_valid,
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
    wbf_d1_valid
);
parameter WBF_DEPTH = 3;
parameter DCU_DATA_WIDTH = 32;
parameter WRITE_AROUND_SUPPORT_INT = 0;
localparam PTR_RST_VALUE = 3'h1;
localparam ARB_BITS = 2;
input dcu_clk;
input dcu_reset_n;
input wbf_a0_valid;
input wbf_a0_kill;
output [WBF_DEPTH - 1:0] wbf_a0_index;
output wbf_a0_ready;
input wbf_w0_valid;
input [WBF_DEPTH - 1:0] wbf_w0_index;
input [5:4] wbf_w0_addr;
input [127:0] wbf_w0_data;
input [WBF_DEPTH - 1:0] wbf_r0_index;
input [5:3] wbf_r0_addr;
output [DCU_DATA_WIDTH - 1:0] wbf_r0_data;
input [WBF_DEPTH - 1:0] wbf_d0_valid;
input wbf_a1_valid;
output [WBF_DEPTH - 1:0] wbf_a1_index;
output wbf_a1_ready;
input wbf_w1_valid;
input [WBF_DEPTH - 1:0] wbf_w1_index;
input [5:4] wbf_w1_addr;
input [127:0] wbf_w1_data;
input [15:0] wbf_w1_mask;
input [WBF_DEPTH - 1:0] wbf_r1_index;
input [5:3] wbf_r1_addr;
output [DCU_DATA_WIDTH - 1:0] wbf_r1_data;
output [(DCU_DATA_WIDTH / 8) - 1:0] wbf_r1_mask;
input [WBF_DEPTH - 1:0] wbf_d1_valid;
localparam DW_RATIO = 512 / DCU_DATA_WIDTH;
localparam DW_RATIO_LOG2 = $clog2(DW_RATIO);


wire [WBF_DEPTH - 1:0] ent_valid;
wire [WBF_DEPTH - 1:0] ent_free = ~ent_valid;
wire [WBF_DEPTH - 1:0] ent_enq_valid;
wire ent_enq_kill;
wire [WBF_DEPTH - 1:0] ent_deq;
wire [WBF_DEPTH * 512 - 1:0] ent_data;
wire [WBF_DEPTH * 64 - 1:0] ent_mask;
wire [WBF_DEPTH - 1:0] enq_ptr;
wire full;
wire [ARB_BITS - 1:0] arb_a_valid;
wire [ARB_BITS - 1:0] arb_a_ready;
wire [ARB_BITS - 1:0] arb_a_grant;
wire a_valid;
wire a_ready;
wire a_grant;
wire a_kill;
wire [15:0] wbf_w0_mask = {16{1'b1}};
wire [511:0] wbf_r0_line_data;
wire [511:0] wbf_r1_line_data;
wire [63:0] wbf_r1_line_mask;
wire a0_valid;
wire a0_ready;
wire a1_valid;
wire a1_ready;
wire tb_a0_stall = 1'b0;
wire tb_a1_stall = 1'b0;
generate
    genvar i;
    for (i = 0; i < WBF_DEPTH; i = i + 1) begin:gen_ent
        wire we;
        wire [1:0] wvalid;
        wire [127:0] wdata;
        wire [5:4] waddr;
        wire [15:0] wmask;
        kv_dcu_wbf_ent #(
            .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
        ) u_ent (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .valid(ent_valid[i]),
            .data(ent_data[i * 512 +:512]),
            .mask(ent_mask[i * 64 +:64]),
            .enq_valid(ent_enq_valid[i]),
            .enq_kill(ent_enq_kill),
            .deq(ent_deq[i]),
            .we(we),
            .waddr(waddr),
            .wmask(wmask),
            .wdata(wdata)
        );
        assign wvalid[0] = wbf_w0_valid & wbf_w0_index[i];
        assign wvalid[1] = wbf_w1_valid & wbf_w1_index[i];
        assign we = wvalid[0] | wvalid[1];
        kv_mux_onehot #(
            .N(2),
            .W(146)
        ) u_write (
            .out({waddr,wdata,wmask}),
            .sel(wvalid[1:0]),
            .in({wbf_w1_addr,wbf_w1_data,wbf_w1_mask,wbf_w0_addr,wbf_w0_data,wbf_w0_mask})
        );
    end
endgenerate
kv_mux_onehot #(
    .N(WBF_DEPTH),
    .W(512)
) u_wbf_r0_line (
    .out(wbf_r0_line_data),
    .sel(wbf_r0_index),
    .in(ent_data)
);
kv_mux_onehot #(
    .N(WBF_DEPTH),
    .W(512)
) u_wbf_r1_line_data (
    .out(wbf_r1_line_data),
    .sel(wbf_r1_index),
    .in(ent_data)
);
kv_mux_onehot #(
    .N(WBF_DEPTH),
    .W(64)
) u_wbf_r1_line_mask (
    .out(wbf_r1_line_mask),
    .sel(wbf_r1_index),
    .in(ent_mask)
);
kv_mux #(
    .N(DW_RATIO),
    .W(DCU_DATA_WIDTH)
) u_wbf_r0_data (
    .out(wbf_r0_data),
    .sel(wbf_r0_addr[5 -:DW_RATIO_LOG2]),
    .in(wbf_r0_line_data)
);
kv_mux #(
    .N(DW_RATIO),
    .W(DCU_DATA_WIDTH)
) u_wbf_r1_data (
    .out(wbf_r1_data),
    .sel(wbf_r1_addr[5 -:DW_RATIO_LOG2]),
    .in(wbf_r1_line_data)
);
kv_mux #(
    .N(DW_RATIO),
    .W(DCU_DATA_WIDTH / 8)
) u_wbf_r1_mask (
    .out(wbf_r1_mask),
    .sel(wbf_r1_addr[5 -:DW_RATIO_LOG2]),
    .in(wbf_r1_line_mask)
);
assign wbf_a0_ready = a0_ready & ~tb_a0_stall;
assign a0_valid = wbf_a0_valid & ~tb_a0_stall;
assign wbf_a1_ready = a1_ready & ~tb_a1_stall;
assign a1_valid = wbf_a1_valid & ~tb_a1_stall;
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb_a (
    .valid(arb_a_valid),
    .ready(arb_a_ready),
    .grant(arb_a_grant)
);
kv_ffs #(
    .WIDTH(WBF_DEPTH)
) u_enq_ptr (
    .out(enq_ptr),
    .in(ent_free)
);
assign full = &ent_valid;
assign arb_a_valid[0] = a0_valid;
assign arb_a_valid[1] = a1_valid;
assign a0_ready = arb_a_ready[0] & a_ready;
assign a1_ready = arb_a_ready[1] & a_ready;
assign wbf_a0_index = enq_ptr;
assign wbf_a1_index = enq_ptr;
assign a_valid = |arb_a_valid;
assign a_kill = (arb_a_grant[0] & wbf_a0_kill);
assign a_ready = ~full;
assign a_grant = a_valid & a_ready;
assign ent_enq_valid = enq_ptr & {WBF_DEPTH{a_grant}};
assign ent_enq_kill = a_kill;
assign ent_deq = wbf_d0_valid | wbf_d1_valid;
endmodule

