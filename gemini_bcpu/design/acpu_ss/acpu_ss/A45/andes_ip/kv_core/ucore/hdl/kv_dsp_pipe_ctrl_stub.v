// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dsp_pipe_ctrl_stub (
    core_clk,
    core_reset_n,
    ii_i0_ctrl,
    ex_i0_ctrl,
    mm_i0_ctrl,
    lx_i0_ctrl,
    ii_i1_ctrl,
    ex_i1_ctrl,
    mm_i1_ctrl,
    lx_i1_ctrl,
    ii_valid,
    ex_valid,
    mm_alive,
    lx_i0_valid,
    lx_i1_valid,
    lx_stall,
    wb_i0_doable,
    wb_i1_doable,
    rs1_rf_rdata,
    rs2_rf_rdata,
    rs3_rf_rdata,
    rs4_rf_rdata,
    ii_rs1_zero,
    ii_rs2_zero,
    ii_rs3_zero,
    ii_rs4_zero,
    ii_dsp_src2_sel_imm,
    ii_dsp_src3_sel_imm,
    ii_dsp_src4_sel_imm,
    ii_dsp_src2_imm,
    ii_dsp_src3_imm,
    ii_dsp_src4_imm,
    ii_dsp_operand_ctrl,
    ii_dsp_function_ctrl,
    ii_dsp_result_ctrl,
    ii_dsp_overflow_ctrl,
    dsp_stage1_ovf_set,
    dsp_stage2_ovf_set,
    dsp_stage3_ovf_set,
    dsp_instr_valid,
    dsp_operand_ctrl,
    dsp_function_ctrl,
    dsp_result_ctrl,
    dsp_overflow_ctrl,
    dsp_data_src1,
    dsp_data_src2,
    dsp_data_src3,
    dsp_data_src4,
    dsp_stage2_pipe_en,
    dsp_stage3_pipe_en,
    ipipe_csr_ucode_ov_set
);
parameter DSP_SUPPORT_INT = 0;
localparam DSP_OCTRL_WIDTH = 44;
localparam DSP_FCTRL_WIDTH = 151;
localparam DSP_RCTRL_WIDTH = 70;
input core_clk;
input core_reset_n;
input [322:0] ii_i0_ctrl;
input [322:0] ii_i1_ctrl;
input [213:0] ex_i0_ctrl;
input [213:0] ex_i1_ctrl;
input [204:0] mm_i0_ctrl;
input [204:0] mm_i1_ctrl;
input [192:0] lx_i0_ctrl;
input [192:0] lx_i1_ctrl;
input [1:0] ii_valid;
input [1:0] ex_valid;
input [1:0] mm_alive;
input lx_i0_valid;
input lx_i1_valid;
input lx_stall;
input wb_i0_doable;
input wb_i1_doable;
input [31:0] rs1_rf_rdata;
input [31:0] rs2_rf_rdata;
input [31:0] rs3_rf_rdata;
input [31:0] rs4_rf_rdata;
input ii_rs1_zero;
input ii_rs2_zero;
input ii_rs3_zero;
input ii_rs4_zero;
input ii_dsp_src2_sel_imm;
input ii_dsp_src3_sel_imm;
input ii_dsp_src4_sel_imm;
input [31:0] ii_dsp_src2_imm;
input [31:0] ii_dsp_src3_imm;
input [31:0] ii_dsp_src4_imm;
input [DSP_OCTRL_WIDTH - 1:0] ii_dsp_operand_ctrl;
input [DSP_FCTRL_WIDTH - 1:0] ii_dsp_function_ctrl;
input [DSP_RCTRL_WIDTH - 1:0] ii_dsp_result_ctrl;
input ii_dsp_overflow_ctrl;
input dsp_stage1_ovf_set;
input dsp_stage2_ovf_set;
input dsp_stage3_ovf_set;
output dsp_instr_valid;
output [DSP_OCTRL_WIDTH - 1:0] dsp_operand_ctrl;
output [DSP_FCTRL_WIDTH - 1:0] dsp_function_ctrl;
output [DSP_RCTRL_WIDTH - 1:0] dsp_result_ctrl;
output dsp_overflow_ctrl;
output [31:0] dsp_data_src1;
output [31:0] dsp_data_src2;
output [31:0] dsp_data_src3;
output [31:0] dsp_data_src4;
output dsp_stage2_pipe_en;
output dsp_stage3_pipe_en;
output ipipe_csr_ucode_ov_set;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire [322:0] nds_unused_ii_i0_ctrl = ii_i0_ctrl;
wire [322:0] nds_unused_ii_i1_ctrl = ii_i1_ctrl;
wire [213:0] nds_unused_ex_i0_ctrl = ex_i0_ctrl;
wire [213:0] nds_unused_ex_i1_ctrl = ex_i1_ctrl;
wire [204:0] nds_unused_mm_i0_ctrl = mm_i0_ctrl;
wire [204:0] nds_unused_mm_i1_ctrl = mm_i1_ctrl;
wire [192:0] nds_unused_lx_i0_ctrl = lx_i0_ctrl;
wire [192:0] nds_unused_lx_i1_ctrl = lx_i1_ctrl;
wire [1:0] nds_unused_ii_valid = ii_valid;
wire [1:0] nds_unused_ex_valid = ex_valid;
wire [1:0] nds_unused_mm_alive = mm_alive;
wire nds_unused_lx_i0_valid = lx_i0_valid;
wire nds_unused_lx_i1_valid = lx_i1_valid;
wire nds_unused_lx_stall = lx_stall;
wire nds_unused_wb_i0_doable = wb_i0_doable;
wire nds_unused_wb_i1_doable = wb_i1_doable;
wire [31:0] nds_unused_rs1_rf_rdata = rs1_rf_rdata;
wire [31:0] nds_unused_rs2_rf_rdata = rs2_rf_rdata;
wire [31:0] nds_unused_rs3_rf_rdata = rs3_rf_rdata;
wire [31:0] nds_unused_rs4_rf_rdata = rs4_rf_rdata;
wire nds_unused_ii_rs1_zero = ii_rs1_zero;
wire nds_unused_ii_rs2_zero = ii_rs2_zero;
wire nds_unused_ii_rs3_zero = ii_rs3_zero;
wire nds_unused_ii_rs4_zero = ii_rs4_zero;
wire nds_unused_ii_dsp_src2_sel_imm = ii_dsp_src2_sel_imm;
wire nds_unused_ii_dsp_src3_sel_imm = ii_dsp_src3_sel_imm;
wire nds_unused_ii_dsp_src4_sel_imm = ii_dsp_src4_sel_imm;
wire [31:0] nds_unused_ii_dsp_src2_imm = ii_dsp_src2_imm;
wire [31:0] nds_unused_ii_dsp_src3_imm = ii_dsp_src3_imm;
wire [31:0] nds_unused_ii_dsp_src4_imm = ii_dsp_src4_imm;
wire [DSP_OCTRL_WIDTH - 1:0] s0 = ii_dsp_operand_ctrl;
wire [DSP_FCTRL_WIDTH - 1:0] s1 = ii_dsp_function_ctrl;
wire [DSP_RCTRL_WIDTH - 1:0] s2 = ii_dsp_result_ctrl;
wire nds_unused_ii_dsp_overflow_ctrl = ii_dsp_overflow_ctrl;
wire nds_unused_dsp_stage1_ovf_set = dsp_stage1_ovf_set;
wire nds_unused_dsp_stage2_ovf_set = dsp_stage2_ovf_set;
wire nds_unused_dsp_stage3_ovf_set = dsp_stage3_ovf_set;
assign dsp_instr_valid = 1'b0;
assign dsp_operand_ctrl = {DSP_OCTRL_WIDTH{1'b0}};
assign dsp_function_ctrl = {DSP_FCTRL_WIDTH{1'b0}};
assign dsp_result_ctrl = {DSP_RCTRL_WIDTH{1'b0}};
assign dsp_overflow_ctrl = 1'b0;
assign dsp_data_src1 = {32{1'b0}};
assign dsp_data_src2 = {32{1'b0}};
assign dsp_data_src3 = {32{1'b0}};
assign dsp_data_src4 = {32{1'b0}};
assign dsp_stage2_pipe_en = 1'b0;
assign dsp_stage3_pipe_en = 1'b0;
assign ipipe_csr_ucode_ov_set = 1'b0;
endmodule

