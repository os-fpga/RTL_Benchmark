// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dsp_predec_stub (
    instr,
    csr_mmisc_ctl_rvcompm,
    instr_dsp,
    instr_legal_dsp,
    rs1_ren,
    rs2_ren,
    rs3_ren,
    rs4_ren,
    rs1_addr,
    rs2_addr,
    rs3_addr,
    rs4_addr,
    rd1_wen,
    rd2_wen,
    rd1_addr,
    rd2_addr,
    ready_stage
);
parameter OP_DSP = 7'b1111111;
input [31:0] instr;
input csr_mmisc_ctl_rvcompm;
output instr_dsp;
output instr_legal_dsp;
output rs1_ren;
output rs2_ren;
output rs3_ren;
output rs4_ren;
output [4:0] rs1_addr;
output [4:0] rs2_addr;
output [4:0] rs3_addr;
output [4:0] rs4_addr;
output rd1_wen;
output rd2_wen;
output [4:0] rd1_addr;
output [4:0] rd2_addr;
output [2:0] ready_stage;


wire [31:0] nds_unused_instr = instr;
wire nds_unused_csr_mmisc_ctl_rvcompm = csr_mmisc_ctl_rvcompm;
assign instr_dsp = 1'b0;
assign instr_legal_dsp = 1'b0;
assign rs1_ren = 1'b0;
assign rs2_ren = 1'b0;
assign rs3_ren = 1'b0;
assign rs4_ren = 1'b0;
assign rs1_addr = 5'b0;
assign rs2_addr = 5'b0;
assign rs3_addr = 5'b0;
assign rs4_addr = 5'b0;
assign rd1_wen = 1'b0;
assign rd2_wen = 1'b0;
assign rd1_addr = 5'b0;
assign rd2_addr = 5'b0;
assign ready_stage = 3'b0;
endmodule

