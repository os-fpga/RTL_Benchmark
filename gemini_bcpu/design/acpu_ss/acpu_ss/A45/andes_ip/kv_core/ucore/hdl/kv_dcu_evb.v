// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_evb (
    dcu_clk,
    dcu_reset_n,
    evb_empty,
    evb_async_ecc_error,
    evb_async_ecc_corr,
    dcu_acctl_ecc_error,
    dcu_acctl_ecc_corr,
    dcu_xcctl_ecc_error,
    dcu_xcctl_ecc_corr,
    evb_async_write_error,
    evb_cmp_addr,
    evb_cmp_hit_ptr,
    evb_cmp_speculative,
    evb_cmp_cft,
    evb_enq_valid,
    evb_enq_source,
    evb_enq_spec,
    evb_enq_addr,
    evb_enq_eccen,
    evb_enq_state,
    evb_enq_way,
    evb_enq_func,
    evb_enq_wbf,
    evb_enq_ready,
    evb_enq_ptr,
    evb_mrg_valid,
    evb_mrg_ptr,
    evb_probe_func,
    evb_cmt_valid,
    evb_cmt_kill,
    evb_cmt_ptr,
    evt_req_valid,
    evt_req_addr,
    evt_req_way,
    evt_req_mesi,
    evt_req_lock,
    evt_req_data,
    evt_req_ready,
    evt_ack_valid,
    evt_ack_rdata,
    evt_ack_error1,
    evt_ack_error2,
    evb_c_valid,
    evb_c_opcode,
    evb_c_param,
    evb_c_addr,
    evb_c_data,
    evb_c_source,
    evb_c_ptr,
    evb_c_user,
    evb_c_ready,
    evb_d_valid,
    evb_d_ptr,
    evb_d_error,
    evb_d_ready,
    wbf_w0_valid,
    wbf_w0_index,
    wbf_w0_addr,
    wbf_w0_data,
    wbf_r0_index,
    wbf_r0_addr,
    wbf_r0_data,
    wbf_d0_valid
);
parameter PALEN = 32;
parameter DCU_DATA_WIDTH = 32;
parameter EVB_DEPTH = 3;
parameter WBF_DEPTH = 3;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter SOURCE_WIDTH = 2;
parameter CM_SUPPORT_INT = 0;
parameter DCACHE_SIZE_KB = 32;
parameter DCACHE_WAY = 4;
parameter WPT_SUPPORT = 0;
localparam S_BIT = 0;
localparam C_UW = 8;
input dcu_clk;
input dcu_reset_n;
output evb_empty;
output evb_async_ecc_error;
output evb_async_ecc_corr;
output dcu_acctl_ecc_error;
output dcu_acctl_ecc_corr;
output dcu_xcctl_ecc_error;
output dcu_xcctl_ecc_corr;
output evb_async_write_error;
input [PALEN - 1:0] evb_cmp_addr;
output [EVB_DEPTH - 1:0] evb_cmp_hit_ptr;
output [EVB_DEPTH - 1:0] evb_cmp_speculative;
output [3:0] evb_cmp_cft;
input evb_enq_valid;
input [SOURCE_WIDTH - 1:0] evb_enq_source;
input evb_enq_spec;
input [PALEN - 1:0] evb_enq_addr;
input [1:0] evb_enq_eccen;
input [3:0] evb_enq_state;
input [3:0] evb_enq_way;
input [5:0] evb_enq_func;
input [WBF_DEPTH - 1:0] evb_enq_wbf;
output evb_enq_ready;
output [EVB_DEPTH - 1:0] evb_enq_ptr;
input evb_mrg_valid;
input [EVB_DEPTH - 1:0] evb_mrg_ptr;
input [3:0] evb_probe_func;
input evb_cmt_valid;
input evb_cmt_kill;
input [EVB_DEPTH - 1:0] evb_cmt_ptr;
output evt_req_valid;
output [PALEN - 1:0] evt_req_addr;
output [3:0] evt_req_way;
output [2:0] evt_req_mesi;
output evt_req_lock;
output evt_req_data;
input evt_req_ready;
input evt_ack_valid;
input [127:0] evt_ack_rdata;
input evt_ack_error1;
input evt_ack_error2;
output evb_c_valid;
output [2:0] evb_c_opcode;
output [2:0] evb_c_param;
output [PALEN - 1:0] evb_c_addr;
output [DCU_DATA_WIDTH - 1:0] evb_c_data;
output [SOURCE_WIDTH - 1:0] evb_c_source;
output [EVB_DEPTH - 1:0] evb_c_ptr;
output [C_UW - 1:0] evb_c_user;
input evb_c_ready;
input evb_d_valid;
input [EVB_DEPTH - 1:0] evb_d_ptr;
input evb_d_error;
output evb_d_ready;
output wbf_w0_valid;
output [WBF_DEPTH - 1:0] wbf_w0_index;
output [5:4] wbf_w0_addr;
output [127:0] wbf_w0_data;
output [WBF_DEPTH - 1:0] wbf_r0_index;
output [5:3] wbf_r0_addr;
input [DCU_DATA_WIDTH - 1:0] wbf_r0_data;
output [WBF_DEPTH - 1:0] wbf_d0_valid;


wire [EVB_DEPTH - 1:0] ent_valid;
wire [EVB_DEPTH - 1:0] ent_cmp_hit;
wire [EVB_DEPTH - 1:0] ent_cmp_speculative;
wire [(4 * EVB_DEPTH) - 1:0] ent_cmp_cft;
wire [EVB_DEPTH - 1:0] enq_ptr;
wire [EVB_DEPTH - 1:0] ent_enq_select;
wire [EVB_DEPTH - 1:0] ent_cmt_valid;
wire [EVB_DEPTH - 1:0] ent_ecc_fault_async;
wire [EVB_DEPTH - 1:0] ent_ecc_fault_xcctl;
wire [EVB_DEPTH - 1:0] ent_ecc_fault_acctl;
wire [EVB_DEPTH - 1:0] ent_ecc_uncorr;
wire [EVB_DEPTH - 1:0] ent_bus_fault;
wire evt_req_grant;
wire [EVB_DEPTH - 1:0] ent_req_valid;
wire [EVB_DEPTH - 1:0] ent_req_last;
wire [(PALEN * EVB_DEPTH) - 1:0] ent_req_addr;
wire [(4 * EVB_DEPTH) - 1:0] ent_req_way;
wire [(3 * EVB_DEPTH) - 1:0] ent_req_mesi;
wire [EVB_DEPTH - 1:0] ent_req_lock;
wire [EVB_DEPTH - 1:0] ent_req_data;
wire [EVB_DEPTH - 1:0] ent_req_ready;
wire [EVB_DEPTH - 1:0] ent_ack_valid;
wire [EVB_DEPTH - 1:0] ack_ptr;
wire [EVB_DEPTH - 1:0] arb_req_valid;
wire [EVB_DEPTH - 1:0] arb_req_ready;
wire [EVB_DEPTH - 1:0] arb_req_last;
wire [EVB_DEPTH - 1:0] arb_req_grant;
wire arb_req_en;
wire [EVB_DEPTH - 1:0] arb_c_valid;
wire [EVB_DEPTH - 1:0] arb_c_ready;
wire [EVB_DEPTH - 1:0] arb_c_grant;
wire [EVB_DEPTH - 1:0] arb_c_last;
wire arb_c_en;
wire evb_c_grant;
wire [EVB_DEPTH - 1:0] ent_c_valid;
wire [(3 * EVB_DEPTH) - 1:0] ent_c_opcode;
wire [(3 * EVB_DEPTH) - 1:0] ent_c_param;
wire [(PALEN * EVB_DEPTH) - 1:0] ent_c_addr;
wire [(SOURCE_WIDTH * EVB_DEPTH) - 1:0] ent_c_source;
wire [(DCU_DATA_WIDTH * EVB_DEPTH) - 1:0] ent_c_data;
wire [EVB_DEPTH - 1:0] ent_c_last;
wire [EVB_DEPTH - 1:0] ent_c_ready;
wire [EVB_DEPTH - 1:0] ent_d_valid;
wire [EVB_DEPTH - 1:0] ent_d_ready;
wire [EVB_DEPTH - 1:0] ent_wbf_w_vaid;
wire [(EVB_DEPTH * 2) - 1:0] ent_wbf_w_addr;
wire [(EVB_DEPTH * 32 * 4) - 1:0] ent_wbf_w_data;
wire [(EVB_DEPTH * 3) - 1:0] ent_wbf_r_addr;
wire [(EVB_DEPTH * WBF_DEPTH) - 1:0] ent_wbf_d_valid;
wire [(EVB_DEPTH * WBF_DEPTH) - 1:0] ent_wbf_index;
wire [EVB_DEPTH - 1:0] arb_wbf_w_grant;
wire nds_unused_wready;
wire nds_unused_rvalid;
wire enq_valid;
wire enq_ready;
wire tb_stall;
wire delay_t2b;
generate
    genvar i;
    for (i = 0; i < EVB_DEPTH; i = i + 1) begin:gen_ent
        kv_dcu_evb_ent #(
            .PALEN(PALEN),
            .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
            .WBF_DEPTH(WBF_DEPTH),
            .SOURCE_WIDTH(SOURCE_WIDTH),
            .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
            .DCACHE_WAY(DCACHE_WAY),
            .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
            .CM_SUPPORT_INT(CM_SUPPORT_INT)
        ) u_ent (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .valid(ent_valid[i]),
            .wbf_index(ent_wbf_index[i * WBF_DEPTH +:WBF_DEPTH]),
            .ecc_fault_async(ent_ecc_fault_async[i]),
            .ecc_fault_xcctl(ent_ecc_fault_xcctl[i]),
            .ecc_fault_acctl(ent_ecc_fault_acctl[i]),
            .ecc_uncorr(ent_ecc_uncorr[i]),
            .bus_fault(ent_bus_fault[i]),
            .cmp_addr(evb_cmp_addr),
            .cmp_hit(ent_cmp_hit[i]),
            .cmp_speculative(ent_cmp_speculative[i]),
            .cmp_cft(ent_cmp_cft[i * 4 +:4]),
            .enq_valid(enq_valid),
            .enq_select(ent_enq_select[i]),
            .enq_spec(evb_enq_spec),
            .enq_eccen(evb_enq_eccen),
            .enq_addr(evb_enq_addr),
            .enq_source(evb_enq_source),
            .enq_way(evb_enq_way),
            .enq_state(evb_enq_state),
            .enq_func(evb_enq_func),
            .enq_wbf(evb_enq_wbf),
            .mrg_valid(evb_mrg_valid),
            .mrg_select(evb_mrg_ptr[i]),
            .probe_func(evb_probe_func),
            .cmt_valid(ent_cmt_valid[i]),
            .cmt_kill(evb_cmt_kill),
            .req_valid(ent_req_valid[i]),
            .req_addr(ent_req_addr[i * PALEN +:PALEN]),
            .req_way(ent_req_way[i * 4 +:4]),
            .req_mesi(ent_req_mesi[i * 3 +:3]),
            .req_lock(ent_req_lock[i]),
            .req_data(ent_req_data[i]),
            .req_last(ent_req_last[i]),
            .req_ready(ent_req_ready[i]),
            .ack_valid(ent_ack_valid[i]),
            .ack_rdata(evt_ack_rdata),
            .ack_error1(evt_ack_error1),
            .ack_error2(evt_ack_error2),
            .wbf_w_vaid(ent_wbf_w_vaid[i]),
            .wbf_w_addr(ent_wbf_w_addr[i * 2 +:2]),
            .wbf_w_data(ent_wbf_w_data[i * 32 * 4 +:128]),
            .wbf_r_addr(ent_wbf_r_addr[i * 3 +:3]),
            .wbf_r_data(wbf_r0_data),
            .wbf_d_valid(ent_wbf_d_valid[i * WBF_DEPTH +:WBF_DEPTH]),
            .c_valid(ent_c_valid[i]),
            .c_opcode(ent_c_opcode[i * 3 +:3]),
            .c_param(ent_c_param[i * 3 +:3]),
            .c_addr(ent_c_addr[i * PALEN +:PALEN]),
            .c_data(ent_c_data[i * DCU_DATA_WIDTH +:DCU_DATA_WIDTH]),
            .c_source(ent_c_source[i * SOURCE_WIDTH +:SOURCE_WIDTH]),
            .c_last(ent_c_last[i]),
            .c_ready(ent_c_ready[i]),
            .d_valid(ent_d_valid[i]),
            .d_error(evb_d_error),
            .d_ready(ent_d_ready[i]),
            .delay_t2b(delay_t2b)
        );
    end
endgenerate
assign tb_stall = 1'b0;
assign enq_valid = evb_enq_valid & ~tb_stall;
assign evb_enq_ready = enq_ready & ~tb_stall;
assign evb_empty = ~|ent_valid;
assign enq_ready = ~(|(ent_valid & enq_ptr));
assign evb_enq_ptr = enq_ptr;
assign evb_async_write_error = |ent_bus_fault;
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_ecc_fault
        assign evb_async_ecc_error = |ent_ecc_fault_async;
        assign evb_async_ecc_corr = ~|ent_ecc_uncorr;
        assign dcu_acctl_ecc_error = |ent_ecc_fault_acctl;
        assign dcu_acctl_ecc_corr = ~|ent_ecc_uncorr;
        assign dcu_xcctl_ecc_error = |ent_ecc_fault_xcctl;
        assign dcu_xcctl_ecc_corr = ~|ent_ecc_uncorr;
    end
    else begin:gen_ecc_fault_stub
        assign evb_async_ecc_error = 1'b0;
        assign evb_async_ecc_corr = 1'b0;
        assign dcu_acctl_ecc_error = 1'b0;
        assign dcu_acctl_ecc_corr = 1'b0;
        assign dcu_xcctl_ecc_error = 1'b0;
        assign dcu_xcctl_ecc_corr = 1'b0;
    end
endgenerate
assign evb_cmp_hit_ptr = ent_cmp_hit;
assign evb_cmp_speculative = ent_cmp_speculative;
kv_vor #(
    .N(EVB_DEPTH),
    .W(4)
) u_cmp_cft (
    .out(evb_cmp_cft),
    .in(ent_cmp_cft)
);
kv_cnt_onehot #(
    .N(EVB_DEPTH)
) u_enq_ptr (
    .clk(dcu_clk),
    .rst_n(dcu_reset_n),
    .en(enq_valid),
    .up_dn(1'b1),
    .load(1'b0),
    .data({EVB_DEPTH{1'b0}}),
    .cnt(enq_ptr)
);
assign ent_enq_select = enq_ptr;
assign ent_cmt_valid = {EVB_DEPTH{evb_cmt_valid}} & evb_cmt_ptr;
kv_arb_rr_mb #(
    .N(EVB_DEPTH)
) u_arb_req (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(arb_req_en),
    .valid(arb_req_valid),
    .last(arb_req_last),
    .ready(arb_req_ready),
    .grant(arb_req_grant),
    .valid_out(evt_req_valid)
);
assign arb_req_en = evt_req_grant;
assign arb_req_valid = ent_req_valid;
assign arb_req_last = ent_req_last;
assign ent_req_ready = arb_req_ready & {EVB_DEPTH{evt_req_ready}};
assign evt_req_grant = evt_req_valid & evt_req_ready;
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(PALEN)
) u_evt_req_addr (
    .out(evt_req_addr),
    .sel(arb_req_grant),
    .in(ent_req_addr)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(4)
) u_evt_req_way (
    .out(evt_req_way),
    .sel(arb_req_grant),
    .in(ent_req_way)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(3)
) u_evt_req_mesi (
    .out(evt_req_mesi),
    .sel(arb_req_grant),
    .in(ent_req_mesi)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(1)
) u_evt_req_lock (
    .out(evt_req_lock),
    .sel(arb_req_grant),
    .in(ent_req_lock)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(1)
) u_evt_req_data (
    .out(evt_req_data),
    .sel(arb_req_grant),
    .in(ent_req_data)
);
kv_fifo #(
    .DEPTH(3),
    .WIDTH(EVB_DEPTH)
) u_evt_ack_ptr (
    .clk(dcu_clk),
    .reset_n(dcu_reset_n),
    .flush(1'b0),
    .wdata(arb_req_grant),
    .wvalid(evt_req_grant),
    .wready(nds_unused_wready),
    .rdata(ack_ptr),
    .rvalid(nds_unused_rvalid),
    .rready(evt_ack_valid)
);
assign ent_ack_valid = ack_ptr & {EVB_DEPTH{evt_ack_valid}};
assign arb_wbf_w_grant = ent_wbf_w_vaid;
assign wbf_w0_valid = |ent_wbf_w_vaid;
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(2)
) u_wbf_w0_addr (
    .out(wbf_w0_addr),
    .sel(arb_wbf_w_grant),
    .in(ent_wbf_w_addr)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(128)
) u_wbf_w0_data (
    .out(wbf_w0_data),
    .sel(arb_wbf_w_grant),
    .in(ent_wbf_w_data)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_w0_index (
    .out(wbf_w0_index),
    .sel(arb_wbf_w_grant),
    .in(ent_wbf_index)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_r0_index (
    .out(wbf_r0_index),
    .sel(arb_c_grant),
    .in(ent_wbf_index)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(3)
) u_wbf_r0_addr (
    .out(wbf_r0_addr),
    .sel(arb_c_grant),
    .in(ent_wbf_r_addr)
);
kv_vor #(
    .N(EVB_DEPTH),
    .W(WBF_DEPTH)
) u_wbf_d0_valid (
    .out(wbf_d0_valid),
    .in(ent_wbf_d_valid)
);
generate
    if (CM_SUPPORT_INT == 1) begin:gen_delay_t2b
        reg [6:0] fair_cnt;
        wire [6:0] fair_cnt_nx;
        wire [6:0] fair_cnt_sub_one = fair_cnt - 7'd1;
        wire fair_cnt_nz = |fair_cnt;
        wire fair_cnt_set;
        wire fair_cnt_en;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                fair_cnt <= 7'd0;
            end
            else if (fair_cnt_en) begin
                fair_cnt <= fair_cnt_nx;
            end
        end

        assign fair_cnt_nx = fair_cnt_set ? 7'd100 : fair_cnt_sub_one;
        assign fair_cnt_en = fair_cnt_set | fair_cnt_nz;
        assign fair_cnt_set = evb_c_grant & (evb_c_opcode == 3'd5) & (evb_c_param == 3'd0);
        assign delay_t2b = fair_cnt_nz;
    end
    else begin:gen_gen_delay_t2b_stub
        assign delay_t2b = 1'b0;
    end
endgenerate
kv_arb_rr_mb #(
    .N(EVB_DEPTH)
) u_arb_c (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(arb_c_en),
    .valid(arb_c_valid),
    .last(arb_c_last),
    .ready(arb_c_ready),
    .grant(arb_c_grant),
    .valid_out(evb_c_valid)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(3)
) u_c_param (
    .out(evb_c_param),
    .sel(arb_c_grant),
    .in(ent_c_param)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(3)
) u_c_opcode (
    .out(evb_c_opcode),
    .sel(arb_c_grant),
    .in(ent_c_opcode)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(PALEN)
) u_c_addr (
    .out(evb_c_addr),
    .sel(arb_c_grant),
    .in(ent_c_addr)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(DCU_DATA_WIDTH)
) u_c_data (
    .out(evb_c_data),
    .sel(arb_c_grant),
    .in(ent_c_data)
);
kv_mux_onehot #(
    .N(EVB_DEPTH),
    .W(SOURCE_WIDTH)
) u_c_source (
    .out(evb_c_source),
    .sel(arb_c_grant),
    .in(ent_c_source)
);
assign evb_c_ptr = arb_c_grant;
assign evb_c_user[0] = 1'b1;
assign evb_c_user[1] = 1'b0;
assign evb_c_user[2] = 1'b0;
assign evb_c_user[3 +:4] = 4'b1111;
assign evb_c_user[7] = 1'b0;
assign arb_c_en = evb_c_grant;
assign arb_c_valid = ent_c_valid;
assign arb_c_last = ent_c_last;
assign ent_c_ready = arb_c_ready & {EVB_DEPTH{evb_c_ready}};
assign evb_c_grant = evb_c_valid & evb_c_ready;
assign ent_d_valid = {EVB_DEPTH{evb_d_valid}} & evb_d_ptr;
assign evb_d_ready = |(evb_d_ptr & ent_d_ready);
endmodule

