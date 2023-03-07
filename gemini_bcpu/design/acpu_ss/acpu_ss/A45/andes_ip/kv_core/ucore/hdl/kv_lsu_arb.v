// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_arb (
    core_clk,
    core_reset_n,
    arb_standby_ready,
    ls_privilege_u,
    lsu_dtlb_privilege_u,
    lsu_dtlb_va_op0,
    lsu_dtlb_va_op1,
    lsu_dtlb_store,
    dtlb_lsu_ppn,
    lsq_req_valid,
    lsq_req_stall,
    lsq_req_src,
    lsq_req_func,
    lsq_req_pc,
    lsq_req_va,
    lsq_req_va_op0,
    lsq_req_va_op1,
    lsq_req_offset,
    lsq_req_ilm,
    lsq_req_dlm,
    lsq_req_ready,
    lsq_ack_valid,
    lsq_ack_src,
    lsq_ack_result,
    lsq_ack_result2,
    lsq_ack_bresult,
    lsq_ack_fault_va,
    lsq_ack_pa,
    lsq_ack_status,
    lsq_cmt_wdata,
    lsq_commit,
    lsq_kill,
    iptw_req_valid,
    iptw_req_pa,
    iptw_req_func,
    iptw_req_ready,
    iptw_ack_valid,
    iptw_ack_result,
    iptw_ack_status,
    dptw_req_valid,
    dptw_req_pa,
    dptw_req_func,
    dptw_req_ready,
    dptw_ack_valid,
    dptw_ack_result,
    dptw_ack_status,
    prf_req_valid,
    prf_req_va,
    prf_req_func,
    prf_req_pc,
    prf_req_ready,
    prf_ack_valid,
    prf_ack_status,
    lsp_req_valid,
    lsp_req_stall,
    lsp_req_ptw,
    lsp_req_src,
    lsp_req_func,
    lsp_req_pc,
    lsp_req_va,
    lsp_req_va_lm,
    lsp_req_base_va20,
    lsp_req_pa,
    lsp_req_offset,
    lsp_req_ilm,
    lsp_req_dlm,
    lsp_req_ready,
    lsp_ack_valid,
    lsp_ack_kill,
    lsp_ack_src,
    lsp_ack_result,
    lsp_ack_result2,
    lsp_ack_bresult,
    lsp_ack_va,
    lsp_ack_fault_va,
    lsp_ack_pa,
    lsp_ack_status,
    lsp_commit,
    lsp_kill,
    lsp_cmt_wdata,
    lsp_event,
    lsu_event,
    lsu_mmu_req_valid,
    lsu_mmu_va,
    mmu_lsu_resp_valid
);
parameter VALEN = 32;
parameter PALEN = 32;
parameter EXTVALEN = 32;
localparam DPTW = 0;
localparam PRF = 1;
localparam LSQ = 2;
localparam IPTW = 3;
localparam ARB_BITS = 4;
parameter LSQ_DEPTH = 4;
parameter LSP_SRCS = 7;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter SRC_DPTW = LSQ_DEPTH;
parameter SRC_IPTW = LSQ_DEPTH + 1;
parameter SRC_PRF = LSQ_DEPTH + 2;
input core_clk;
input core_reset_n;
output arb_standby_ready;
input ls_privilege_u;
output lsu_dtlb_privilege_u;
output [VALEN - 1:0] lsu_dtlb_va_op0;
output [20:0] lsu_dtlb_va_op1;
output lsu_dtlb_store;
input [PALEN - 1:12] dtlb_lsu_ppn;
input lsq_req_valid;
input lsq_req_stall;
input [LSQ_DEPTH - 1:0] lsq_req_src;
input [36:0] lsq_req_func;
input [11:0] lsq_req_pc;
input [EXTVALEN - 1:0] lsq_req_va;
input [VALEN - 1:0] lsq_req_va_op0;
input [20:0] lsq_req_va_op1;
input [2:0] lsq_req_offset;
input lsq_req_ilm;
input lsq_req_dlm;
output lsq_req_ready;
output lsq_ack_valid;
output [LSQ_DEPTH - 1:0] lsq_ack_src;
output [31:0] lsq_ack_result;
output [63:0] lsq_ack_result2;
output [31:0] lsq_ack_bresult;
output [EXTVALEN - 1:0] lsq_ack_fault_va;
output [PALEN - 1:0] lsq_ack_pa;
output [44:0] lsq_ack_status;
input [63:0] lsq_cmt_wdata;
input [LSQ_DEPTH - 1:0] lsq_commit;
input [LSQ_DEPTH - 1:0] lsq_kill;
input iptw_req_valid;
input [PALEN - 1:0] iptw_req_pa;
input [36:0] iptw_req_func;
output iptw_req_ready;
output iptw_ack_valid;
output [31:0] iptw_ack_result;
output [44:0] iptw_ack_status;
input dptw_req_valid;
input [PALEN - 1:0] dptw_req_pa;
input [36:0] dptw_req_func;
output dptw_req_ready;
output dptw_ack_valid;
output [31:0] dptw_ack_result;
output [44:0] dptw_ack_status;
input prf_req_valid;
input [EXTVALEN - 1:0] prf_req_va;
input [36:0] prf_req_func;
input [11:0] prf_req_pc;
output prf_req_ready;
output prf_ack_valid;
output [44:0] prf_ack_status;
output lsp_req_valid;
output lsp_req_stall;
output lsp_req_ptw;
output [LSP_SRCS - 1:0] lsp_req_src;
output [36:0] lsp_req_func;
output [11:0] lsp_req_pc;
output [EXTVALEN - 1:0] lsp_req_va;
output [EXTVALEN - 1:0] lsp_req_va_lm;
output [2:0] lsp_req_base_va20;
output [PALEN - 1:0] lsp_req_pa;
output [2:0] lsp_req_offset;
output lsp_req_ilm;
output lsp_req_dlm;
input lsp_req_ready;
input lsp_ack_valid;
input lsp_ack_kill;
input [LSP_SRCS - 1:0] lsp_ack_src;
input [31:0] lsp_ack_result;
input [63:0] lsp_ack_result2;
input [31:0] lsp_ack_bresult;
input [EXTVALEN - 1:0] lsp_ack_va;
input [EXTVALEN - 1:0] lsp_ack_fault_va;
input [PALEN - 1:0] lsp_ack_pa;
input [44:0] lsp_ack_status;
output [LSP_SRCS - 1:0] lsp_commit;
output [LSP_SRCS - 1:0] lsp_kill;
output [63:0] lsp_cmt_wdata;
input [3:0] lsp_event;
output [4:0] lsu_event;
output lsu_mmu_req_valid;
output [EXTVALEN - 1:0] lsu_mmu_va;
input mmu_lsu_resp_valid;


wire s0 = 1'b0;
wire [1:0] s1;
reg s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire [ARB_BITS - 1:0] s7;
wire [ARB_BITS - 1:0] s8;
wire [ARB_BITS - 1:0] s9;
wire [PALEN - 1:0] s10;
wire s11 = lsq_req_func[25];
wire [EXTVALEN - 1:0] s12 = lsq_req_va[EXTVALEN - 1:0];
wire [PALEN - 1:0] s13;
wire s14 = prf_req_func[25];
kv_arb_fp #(
    .N(ARB_BITS)
) u_arb (
    .valid(s7),
    .ready(s9),
    .grant(s8)
);
assign s7[DPTW] = dptw_req_valid;
assign s7[PRF] = prf_req_valid & ~s2;
assign s7[LSQ] = lsq_req_valid & ~s2;
assign s7[IPTW] = iptw_req_valid;
assign arb_standby_ready = ~s1[0];
kv_mux_onehot #(
    .N(ARB_BITS),
    .W(38)
) u_lsp_req_func_stall (
    .out({lsp_req_func,lsp_req_stall}),
    .in({iptw_req_func,1'b0,lsq_req_func,lsq_req_stall,prf_req_func,1'b0,dptw_req_func,1'b0}),
    .sel(s8)
);
assign lsp_req_valid = |s7;
assign lsq_req_ready = s8[LSQ] & lsp_req_ready;
assign lsp_req_src[LSQ_DEPTH - 1:0] = {LSQ_DEPTH{s8[LSQ]}} & lsq_req_src;
assign lsp_req_src[SRC_DPTW] = s8[DPTW];
assign lsp_req_src[SRC_IPTW] = s8[IPTW];
assign lsp_req_src[SRC_PRF] = s8[PRF];
assign lsp_req_pc = ({12{s8[LSQ]}} & lsq_req_pc) | ({12{s8[PRF]}} & prf_req_pc);
assign lsp_req_va = ({EXTVALEN{s8[LSQ]}} & s12) | ({EXTVALEN{s8[PRF]}} & prf_req_va);
assign lsp_req_va_lm = s12;
assign lsp_req_base_va20 = ({3{s8[LSQ]}} & lsq_req_va[2:0]) | ({3{s8[PRF]}} & prf_req_va[2:0]);
assign lsp_req_ilm = s8[LSQ] & lsq_req_ilm;
assign lsp_req_dlm = s8[LSQ] & lsq_req_dlm;
assign lsp_req_ptw = s8[IPTW] | s8[DPTW];
generate
    if (EXTVALEN >= PALEN) begin:gen_lsq_req_va
        assign s10 = s12[PALEN - 1:0];
        assign s13 = prf_req_va[PALEN - 1:0];
    end
    else begin:gen_lsq_req_va_zext
        kv_zero_ext #(
            .OW(PALEN),
            .IW(EXTVALEN)
        ) u_lsq_req_non_translate_pa (
            .out(s10),
            .in(s12)
        );
        kv_zero_ext #(
            .OW(PALEN),
            .IW(EXTVALEN)
        ) u_prf_req_non_translate_pa (
            .out(s13),
            .in(prf_req_va)
        );
    end
endgenerate
assign lsp_req_pa = ({PALEN{s8[DPTW]}} & dptw_req_pa) | ({PALEN{s8[IPTW]}} & iptw_req_pa) | ({PALEN{s8[LSQ] & s11}} & {dtlb_lsu_ppn,s12[11:0]}) | ({PALEN{s8[PRF] & s14}} & {dtlb_lsu_ppn,prf_req_va[11:0]}) | ({PALEN{s8[LSQ] & ~s11}} & s10) | ({PALEN{s8[PRF] & ~s14}} & s13);
assign lsp_req_offset = {3{s8[LSQ]}} & lsq_req_offset;
assign lsp_commit[LSQ_DEPTH - 1:0] = lsq_commit;
assign lsp_kill[LSQ_DEPTH - 1:0] = lsq_kill;
assign lsp_commit[SRC_DPTW] = 1'b1;
assign lsp_kill[SRC_DPTW] = 1'b0;
assign lsp_commit[SRC_IPTW] = 1'b1;
assign lsp_kill[SRC_IPTW] = 1'b0;
assign lsp_commit[SRC_PRF] = 1'b1;
assign lsp_kill[SRC_PRF] = 1'b0;
assign lsp_cmt_wdata = lsq_cmt_wdata;
assign lsq_ack_valid = lsp_ack_valid & |lsp_ack_src[LSQ_DEPTH - 1:0];
assign lsq_ack_src = lsp_ack_src[LSQ_DEPTH - 1:0];
assign lsq_ack_result = lsp_ack_result;
assign lsq_ack_result2 = lsp_ack_result2;
assign lsq_ack_bresult = lsp_ack_bresult;
assign lsq_ack_fault_va = lsp_ack_fault_va;
assign lsq_ack_pa = lsp_ack_pa;
assign lsq_ack_status = lsp_ack_status;
assign dptw_req_ready = s8[DPTW] & lsp_req_ready;
assign iptw_req_ready = s8[IPTW] & lsp_req_ready;
assign dptw_ack_valid = lsp_ack_src[SRC_DPTW] & lsp_ack_valid;
assign dptw_ack_result = lsp_ack_result;
assign dptw_ack_status = lsp_ack_status;
assign iptw_ack_valid = lsp_ack_src[SRC_IPTW] & lsp_ack_valid;
assign iptw_ack_result = lsp_ack_result;
assign iptw_ack_status = lsp_ack_status;
assign prf_req_ready = s8[PRF] & lsp_req_ready;
assign prf_ack_valid = lsp_ack_src[SRC_PRF] & lsp_ack_valid;
assign prf_ack_status = lsp_ack_status;
wire s15 = lsq_req_func[3] | lsq_req_func[8] | lsq_req_func[9];
assign lsu_dtlb_privilege_u = ls_privilege_u;
assign lsu_dtlb_va_op0 = ({VALEN{s8[LSQ]}} & lsq_req_va_op0[VALEN - 1:0]) | ({VALEN{s8[PRF]}} & prf_req_va[VALEN - 1:0]);
assign lsu_dtlb_va_op1 = ({21{s8[LSQ]}} & lsq_req_va_op1);
assign lsu_dtlb_store = s8[LSQ] & s15;
kv_cnt_johnson #(
    .N(2)
) u_mmu_inflight (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .up(lsu_mmu_req_valid),
    .dn(mmu_lsu_resp_valid),
    .cnt(s1)
);
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s2 <= 1'b0;
    end
    else if (s6) begin
        s2 <= s3;
    end
end

assign s4 = lsu_mmu_req_valid;
assign s5 = mmu_lsu_resp_valid;
assign s6 = s4 | s5;
assign s3 = ~s5 & (s2 | s4);
assign lsu_mmu_req_valid = lsp_ack_valid & ~lsp_ack_kill & lsp_ack_status[13] & ~s2;
assign lsu_mmu_va = lsp_ack_va;
generate
    if (PERFORMANCE_MONITOR_INT == 1) begin:gen_pfm_events
        reg s16;
        wire s17;
        wire s18;
        wire s19;
        wire s20;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s16 <= 1'b0;
            end
            else if (s18) begin
                s16 <= s17;
            end
        end

        assign s18 = s19 | s20;
        assign s17 = s19 | (s16 & ~s20);
        assign s19 = lsu_mmu_req_valid;
        assign s20 = lsq_ack_valid & ~s2;
        assign lsu_event[0] = lsp_event[0];
        assign lsu_event[1] = lsp_event[1];
        assign lsu_event[3] = s16;
        assign lsu_event[2] = lsp_event[2];
        assign lsu_event[4] = lsp_event[3];
    end
    else begin:gen_pfm_events_stub
        assign lsu_event = {5{1'b0}};
        wire [3:0] nds_unused_lsp_event = lsp_event;
    end
endgenerate
endmodule

