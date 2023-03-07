// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_sfp_predec_stub (
    instr,
    vpu_decode,
    isa_c_dp_fls_en,
    csr_mmisc_ctl_rvcompm,
    csr_mstatus_fs,
    csr_frm,
    instr_csr,
    instr_sfp,
    instr_illegal_sfp,
    instr_sfp_off_xcpt,
    sfp_rs1_ren,
    sfp_rd1_wen,
    sfp_frd1,
    sfp_frd1_wen,
    sfp_frs1,
    sfp_frs1_ren,
    sfp_frs2,
    sfp_frs2_ren,
    sfp_frs3,
    sfp_frs3_ren,
    sfp_ex_rm,
    sfp_ex_sign,
    sfp_ex_sew,
    sfp_ex_fmac,
    sfp_ex_fdiv,
    sfp_ex_fmis,
    sfp_ex_fmv,
    sfp_ex_ctrl,
    instr_sfp_ls,
    instr_sfp_lhw,
    instr_sfp_shw,
    instr_sfp_lw,
    instr_sfp_sw,
    instr_sfp_ld,
    instr_sfp_sd,
    instr_sfp_c_lwsp,
    instr_sfp_c_swsp,
    instr_sfp_c_ldsp,
    instr_sfp_c_sdsp,
    instr_sfp_c_lw,
    instr_sfp_c_sw,
    instr_sfp_c_ld,
    instr_sfp_c_sd
);
parameter FLEN = 32;
parameter RVV_SUPPORT_INT = 0;
localparam STATE_OFF = 2'd0;
localparam CSR12_FFLAGS = 12'h001;
localparam CSR12_FRM = 12'h002;
localparam CSR12_FCSR = 12'h003;
localparam CSR12_VXSAT = 12'h009;
localparam CSR12_VXRM = 12'h00a;
input [31:0] instr;
input [25:0] vpu_decode;
input isa_c_dp_fls_en;
input csr_mmisc_ctl_rvcompm;
input [1:0] csr_mstatus_fs;
input [31:0] csr_frm;
input instr_csr;
output instr_sfp;
output instr_illegal_sfp;
output instr_sfp_off_xcpt;
output sfp_rs1_ren;
output sfp_rd1_wen;
output [4:0] sfp_frd1;
output sfp_frd1_wen;
output [4:0] sfp_frs1;
output sfp_frs1_ren;
output [4:0] sfp_frs2;
output sfp_frs2_ren;
output [4:0] sfp_frs3;
output sfp_frs3_ren;
output [2:0] sfp_ex_rm;
output sfp_ex_sign;
output [2:0] sfp_ex_sew;
output sfp_ex_fmac;
output sfp_ex_fdiv;
output sfp_ex_fmis;
output sfp_ex_fmv;
output [5:0] sfp_ex_ctrl;
output instr_sfp_ls;
output instr_sfp_lhw;
output instr_sfp_shw;
output instr_sfp_lw;
output instr_sfp_sw;
output instr_sfp_ld;
output instr_sfp_sd;
output instr_sfp_c_lwsp;
output instr_sfp_c_swsp;
output instr_sfp_c_ldsp;
output instr_sfp_c_sdsp;
output instr_sfp_c_lw;
output instr_sfp_c_sw;
output instr_sfp_c_ld;
output instr_sfp_c_sd;


assign instr_sfp = 1'b0;
assign sfp_rs1_ren = 1'b0;
assign sfp_rd1_wen = 1'b0;
assign instr_sfp_ls = 1'b0;
assign instr_sfp_lhw = 1'b0;
assign instr_sfp_shw = 1'b0;
assign instr_sfp_lw = 1'b0;
assign instr_sfp_sw = 1'b0;
assign instr_sfp_ld = 1'b0;
assign instr_sfp_sd = 1'b0;
assign instr_sfp_c_lwsp = 1'b0;
assign instr_sfp_c_swsp = 1'b0;
assign instr_sfp_c_ldsp = 1'b0;
assign instr_sfp_c_sdsp = 1'b0;
assign instr_sfp_c_lw = 1'b0;
assign instr_sfp_c_sw = 1'b0;
assign instr_sfp_c_ld = 1'b0;
assign instr_sfp_c_sd = 1'b0;
assign instr_illegal_sfp = 1'b0;
assign instr_sfp_off_xcpt = 1'b0;
assign sfp_frd1 = 5'b0;
assign sfp_frd1_wen = 1'b0;
assign sfp_frs1 = 5'b0;
assign sfp_frs1_ren = 1'b0;
assign sfp_frs2 = 5'b0;
assign sfp_frs2_ren = 1'b0;
assign sfp_frs3 = 5'b0;
assign sfp_frs3_ren = 1'b0;
assign sfp_ex_rm = 3'b0;
assign sfp_ex_sign = 1'b0;
assign sfp_ex_sew = 3'b0;
assign sfp_ex_fmac = 1'b0;
assign sfp_ex_fdiv = 1'b0;
assign sfp_ex_fmis = 1'b0;
assign sfp_ex_fmv = 1'b0;
assign sfp_ex_ctrl = 6'b0;
endmodule

