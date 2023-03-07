// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dsp_pipe_ctrl (
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


reg [31:0] s0;
reg [31:0] s1;
reg [31:0] s2;
reg [31:0] s3;
wire [31:0] s4;
wire [31:0] s5;
wire [31:0] s6;
wire [31:0] s7;
reg [DSP_OCTRL_WIDTH - 1:0] s8;
reg [DSP_FCTRL_WIDTH - 1:0] s9;
reg [DSP_RCTRL_WIDTH - 1:0] s10;
reg s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16 = ii_i0_ctrl[169] | ii_i0_ctrl[171] | ii_i0_ctrl[170];
wire s17 = ex_i0_ctrl[135] | ex_i0_ctrl[137] | ex_i0_ctrl[136];
wire s18 = mm_i0_ctrl[151] | mm_i0_ctrl[153] | mm_i0_ctrl[152];
wire s19 = lx_i0_ctrl[133] | lx_i0_ctrl[135] | lx_i0_ctrl[134];
wire s20 = ii_i1_ctrl[169] | ii_i1_ctrl[171] | ii_i1_ctrl[170];
wire s21 = ex_i1_ctrl[135] | ex_i1_ctrl[137] | ex_i1_ctrl[136];
wire s22 = mm_i1_ctrl[151] | mm_i1_ctrl[153] | mm_i1_ctrl[152];
wire s23 = lx_i1_ctrl[133] | lx_i1_ctrl[135] | lx_i1_ctrl[134];
reg s24;
reg s25;
wire s26;
wire s27;
assign s12 = (s16 & ii_valid[0] & ~lx_stall) | (s20 & ii_valid[1] & ~lx_stall);
assign s4 = ({32{s16 & ~ii_rs1_zero}} & rs1_rf_rdata) | ({32{s20 & ~s16 & ~ii_rs3_zero}} & rs3_rf_rdata) | ({32{ii_rs1_zero}} & {32{1'b0}});
assign s5 = ({32{ii_dsp_src2_sel_imm}} & ii_dsp_src2_imm) | ({32{~ii_dsp_src2_sel_imm & s16 & ~ii_rs2_zero}} & rs2_rf_rdata) | ({32{~ii_dsp_src2_sel_imm & s20 & ~s16 & ~ii_rs4_zero}} & rs4_rf_rdata) | ({32{ii_rs2_zero}} & {32{1'b0}});
assign s6 = ({32{ii_dsp_src3_sel_imm}} & ii_dsp_src3_imm) | ({32{~ii_dsp_src3_sel_imm & ~ii_rs3_zero}} & rs3_rf_rdata) | ({32{ii_rs3_zero}} & {32{1'b0}});
assign s7 = ({32{ii_dsp_src4_sel_imm}} & ii_dsp_src4_imm) | ({32{~ii_dsp_src4_sel_imm & ~ii_rs4_zero}} & rs4_rf_rdata) | ({32{ii_rs4_zero}} & {32{1'b0}});
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {32{1'b0}};
        s1 <= {32{1'b0}};
        s2 <= {32{1'b0}};
        s3 <= {32{1'b0}};
        s8 <= {DSP_OCTRL_WIDTH{1'b0}};
        s9 <= {DSP_FCTRL_WIDTH{1'b0}};
        s10 <= {DSP_RCTRL_WIDTH{1'b0}};
        s11 <= 1'b0;
    end
    else if (s12) begin
        s0 <= s4;
        s1 <= s5;
        s2 <= s6;
        s3 <= s7;
        s8 <= ii_dsp_operand_ctrl;
        s9 <= ii_dsp_function_ctrl;
        s10 <= ii_dsp_result_ctrl;
        s11 <= ii_dsp_overflow_ctrl;
    end
end

reg s28;
reg s29;
reg s30;
wire s31;
wire s32;
wire s33;
assign s13 = (ex_valid[0] & s17 & ~lx_stall) | (ex_valid[1] & s21 & ~lx_stall);
assign s31 = dsp_stage1_ovf_set;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s28 <= 1'b0;
    end
    else if (s13) begin
        s28 <= s31;
    end
end

assign s14 = (mm_alive[0] & s18 & ~lx_stall) | (mm_alive[1] & s22 & ~lx_stall);
assign s32 = dsp_stage2_ovf_set ? 1'b1 : s28;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s29 <= 1'b0;
    end
    else if (s14) begin
        s29 <= s32;
    end
end

assign s15 = (lx_i0_valid & ~lx_stall) | (lx_i1_valid & ~lx_stall);
assign s33 = dsp_stage3_ovf_set ? 1'b1 : s29;
assign s26 = s19;
assign s27 = s23;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s24 <= 1'b0;
        s25 <= 1'b0;
        s30 <= 1'b0;
    end
    else if (s15) begin
        s24 <= s26;
        s25 <= s27;
        s30 <= s33;
    end
end

assign ipipe_csr_ucode_ov_set = (s30 & s24 & wb_i0_doable) | (s30 & s25 & wb_i1_doable);
assign dsp_instr_valid = s13;
assign dsp_operand_ctrl = s8;
assign dsp_function_ctrl = s9;
assign dsp_result_ctrl = s10;
assign dsp_overflow_ctrl = s11;
assign dsp_data_src1 = s0;
assign dsp_data_src2 = s1;
assign dsp_data_src3 = s2;
assign dsp_data_src4 = s3;
assign dsp_stage2_pipe_en = s13;
assign dsp_stage3_pipe_en = s14;
endmodule

