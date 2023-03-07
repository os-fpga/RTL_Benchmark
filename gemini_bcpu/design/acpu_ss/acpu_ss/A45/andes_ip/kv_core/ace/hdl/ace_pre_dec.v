// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ace_pre_dec (
    ace_dec_inst,
    cur_privilege_m,
    cur_privilege_s,
    cur_privilege_u,
    ace_dec_xrf_rs1_ren,
    ace_dec_xrf_rs2_ren,
    ace_dec_xrf_rs3_ren,
    ace_dec_xrf_rs4_ren,
    ace_dec_xrf_rd1_wen,
    ace_dec_xrf_rd2_wen,
    ace_dec_frf_rs1_ren,
    ace_dec_frf_rs2_ren,
    ace_dec_frf_rd1_wen,
    ace_dec_vrf_rs1_ren,
    ace_dec_vrf_rs2_ren,
    ace_dec_vrf_rd1_wen,
    ace_dec_rs1_index,
    ace_dec_rs2_index,
    ace_dec_rs3_index,
    ace_dec_rs4_index,
    ace_dec_rd1_index,
    ace_dec_rd2_index,
    ace_dec_illegal_insn,
    ace_dec_xcpt,
    ace_dec_xcpt_cause,
    ace_dec_sync_en
);
input [31:0] ace_dec_inst;
input cur_privilege_m;
input cur_privilege_s;
input cur_privilege_u;
output ace_dec_xrf_rs1_ren;
output ace_dec_xrf_rs2_ren;
output ace_dec_xrf_rs3_ren;
output ace_dec_xrf_rs4_ren;
output ace_dec_xrf_rd1_wen;
output ace_dec_xrf_rd2_wen;
output ace_dec_frf_rs1_ren;
output ace_dec_frf_rs2_ren;
output ace_dec_frf_rd1_wen;
output ace_dec_vrf_rs1_ren;
output ace_dec_vrf_rs2_ren;
output ace_dec_vrf_rd1_wen;
output [4:0] ace_dec_rs1_index;
output [4:0] ace_dec_rs2_index;
output [4:0] ace_dec_rs3_index;
output [4:0] ace_dec_rs4_index;
output [4:0] ace_dec_rd1_index;
output [4:0] ace_dec_rd2_index;
output ace_dec_illegal_insn;
output ace_dec_xcpt;
output [5:0] ace_dec_xcpt_cause;
output ace_dec_sync_en;


assign ace_dec_xrf_rs1_ren = 1'b0;
assign ace_dec_xrf_rs2_ren = 1'b0;
assign ace_dec_xrf_rs3_ren = 1'b0;
assign ace_dec_xrf_rs4_ren = 1'b0;
assign ace_dec_xrf_rd1_wen = 1'b0;
assign ace_dec_xrf_rd2_wen = 1'b0;
assign ace_dec_frf_rs1_ren = 1'b0;
assign ace_dec_frf_rs2_ren = 1'b0;
assign ace_dec_frf_rd1_wen = 1'b0;
assign ace_dec_vrf_rs1_ren = 1'b0;
assign ace_dec_vrf_rs2_ren = 1'b0;
assign ace_dec_vrf_rd1_wen = 1'b0;
assign ace_dec_rs1_index = 5'b0;
assign ace_dec_rs2_index = 5'b0;
assign ace_dec_rs3_index = 5'b0;
assign ace_dec_rs4_index = 5'b0;
assign ace_dec_rd1_index = 5'b0;
assign ace_dec_rd2_index = 5'b0;
assign ace_dec_illegal_insn = 1'b0;
assign ace_dec_xcpt = 1'b0;
assign ace_dec_xcpt_cause = 6'b0;
assign ace_dec_sync_en = 1'b0;
wire [31:0] nds_unused_ace_dec_inst = ace_dec_inst;
wire nds_unused_cur_privilege_m = cur_privilege_m;
wire nds_unused_cur_privilege_s = cur_privilege_s;
wire nds_unused_cur_privilege_u = cur_privilege_u;
endmodule

