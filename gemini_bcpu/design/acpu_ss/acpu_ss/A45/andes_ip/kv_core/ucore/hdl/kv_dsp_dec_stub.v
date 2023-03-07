// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dsp_dec_stub (
    instr,
    src2_sel_imm,
    src3_sel_imm,
    src4_sel_imm,
    src2_imm,
    src3_imm,
    src4_imm,
    operand_ctrl,
    function_ctrl,
    result_ctrl,
    overflow_ctrl
);
localparam OP_DSP = 7'b1111111;
localparam DSP_OCTRL_WIDTH = 44;
localparam DSP_FCTRL_WIDTH = 151;
localparam DSP_RCTRL_WIDTH = 70;
localparam DSP_HCTRL_WIDTH = 3;
input [31:0] instr;
output [DSP_OCTRL_WIDTH - 1:0] operand_ctrl;
output [DSP_FCTRL_WIDTH - 1:0] function_ctrl;
output [DSP_RCTRL_WIDTH - 1:0] result_ctrl;
output overflow_ctrl;
output src2_sel_imm;
output src3_sel_imm;
output src4_sel_imm;
output [31:0] src2_imm;
output [31:0] src3_imm;
output [31:0] src4_imm;


wire [31:0] nds_unused_instr = instr;
assign operand_ctrl = {DSP_OCTRL_WIDTH{1'b0}};
assign function_ctrl = {DSP_FCTRL_WIDTH{1'b0}};
assign result_ctrl = {DSP_RCTRL_WIDTH{1'b0}};
assign overflow_ctrl = 1'b0;
assign src2_sel_imm = 1'b0;
assign src3_sel_imm = 1'b0;
assign src4_sel_imm = 1'b0;
assign src2_imm = {32{1'b0}};
assign src3_imm = {32{1'b0}};
assign src4_imm = {32{1'b0}};
endmodule

