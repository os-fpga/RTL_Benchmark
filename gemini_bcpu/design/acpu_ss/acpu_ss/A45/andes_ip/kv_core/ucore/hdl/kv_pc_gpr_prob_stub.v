// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pc_gpr_prob_stub (
    core_clk,
    core_reset_n,
    rf_raddr5,
    rf_rdata5,
    csr_prob_raddr,
    csr_prob_rdata,
    wb_i0_retire,
    wb_i1_retire,
    wb_i0_pc,
    wb_i1_pc,
    core_current_pc,
    core_gpr_index,
    core_selected_gpr_value
);
parameter VALEN = 32;
parameter EXTVALEN = 32;
input core_clk;
input core_reset_n;
output [4:0] rf_raddr5;
input [31:0] rf_rdata5;
output [11:0] csr_prob_raddr;
input [31:0] csr_prob_rdata;
input wb_i0_retire;
input wb_i1_retire;
input [EXTVALEN - 1:0] wb_i0_pc;
input [EXTVALEN - 1:0] wb_i1_pc;
output [VALEN - 1:0] core_current_pc;
input [12:0] core_gpr_index;
output [31:0] core_selected_gpr_value;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
assign rf_raddr5 = 5'b0;
wire [31:0] nds_unused_rf_rdata5 = rf_rdata5;
assign csr_prob_raddr = 12'b0;
wire [31:0] nds_unused_csr_prob_rdata = csr_prob_rdata;
wire nds_unused_wb_i0_retire = wb_i0_retire;
wire nds_unused_wb_i1_retire = wb_i1_retire;
wire [EXTVALEN - 1:0] s0 = wb_i0_pc;
wire [EXTVALEN - 1:0] s1 = wb_i1_pc;
assign core_current_pc = {VALEN{1'b0}};
wire [12:0] nds_unused_core_gpr_index = core_gpr_index;
assign core_selected_gpr_value = {32{1'b0}};
endmodule

