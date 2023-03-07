// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pc_gpr_prob (
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


reg [VALEN - 1:0] s0;
wire s1 = wb_i0_retire | wb_i1_retire;
wire [VALEN - 1:0] s2 = wb_i1_retire ? wb_i1_pc[VALEN - 1:0] : wb_i0_pc[VALEN - 1:0];
assign rf_raddr5 = core_gpr_index[4:0];
assign csr_prob_raddr = core_gpr_index[11:0];
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {VALEN{1'b0}};
    end
    else if (s1) begin
        s0 <= s2;
    end
end

assign core_current_pc = s0;
assign core_selected_gpr_value = core_gpr_index[12] ? rf_rdata5 : csr_prob_rdata;
endmodule

