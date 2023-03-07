// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dsp_stub (
    core_clk,
    core_reset_n,
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
    dsp_stage1_result,
    dsp_stage1_ovf_set,
    dsp_stage2_result,
    dsp_stage2_ovf_set,
    dsp_stage3_result,
    dsp_stage3_ovf_set
);
localparam DSP_OCTRL_WIDTH = 44;
localparam DSP_FCTRL_WIDTH = 151;
localparam DSP_RCTRL_WIDTH = 70;
localparam SHIFT_AMT_MSB = 4;
input core_clk;
input core_reset_n;
input dsp_instr_valid;
input [DSP_OCTRL_WIDTH - 1:0] dsp_operand_ctrl;
input [DSP_FCTRL_WIDTH - 1:0] dsp_function_ctrl;
input [DSP_RCTRL_WIDTH - 1:0] dsp_result_ctrl;
input dsp_overflow_ctrl;
input [31:0] dsp_data_src1;
input [31:0] dsp_data_src2;
input [31:0] dsp_data_src3;
input [31:0] dsp_data_src4;
input dsp_stage2_pipe_en;
input dsp_stage3_pipe_en;
output [63:0] dsp_stage1_result;
output dsp_stage1_ovf_set;
output [63:0] dsp_stage2_result;
output dsp_stage2_ovf_set;
output [63:0] dsp_stage3_result;
output dsp_stage3_ovf_set;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_dsp_instr_valid = dsp_instr_valid;
wire [DSP_OCTRL_WIDTH - 1:0] s0 = dsp_operand_ctrl;
wire [DSP_FCTRL_WIDTH - 1:0] s1 = dsp_function_ctrl;
wire [DSP_RCTRL_WIDTH - 1:0] s2 = dsp_result_ctrl;
wire nds_unused_dsp_overflow_ctrl = dsp_overflow_ctrl;
wire [31:0] nds_unused_dsp_data_src1 = dsp_data_src1;
wire [31:0] nds_unused_dsp_data_src2 = dsp_data_src2;
wire [31:0] nds_unused_dsp_data_src3 = dsp_data_src3;
wire [31:0] nds_unused_dsp_data_src4 = dsp_data_src4;
wire nds_unused_dsp_stage2_pipe_en = dsp_stage2_pipe_en;
wire nds_unused_dsp_stage3_pipe_en = dsp_stage3_pipe_en;
assign dsp_stage1_result = 64'b0;
assign dsp_stage1_ovf_set = 1'b0;
assign dsp_stage2_result = 64'b0;
assign dsp_stage2_ovf_set = 1'b0;
assign dsp_stage3_result = 64'b0;
assign dsp_stage3_ovf_set = 1'b0;
endmodule

