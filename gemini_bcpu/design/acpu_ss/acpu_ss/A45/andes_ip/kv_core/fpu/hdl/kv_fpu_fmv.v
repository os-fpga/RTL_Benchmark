// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fpu_fmv (
    fmv_standby_ready,
    f1_wdata,
    f1_op1_data,
    f1_op2_data,
    f1_valid,
    f1_sew,
    f1_ex_ctrl
);
parameter FLEN = 64;
output fmv_standby_ready;
output [63:0] f1_wdata;
input [63:0] f1_op1_data;
input [63:0] f1_op2_data;
input f1_valid;
input [2:0] f1_sew;
input [5:0] f1_ex_ctrl;


wire s0 = f1_sew[2];
wire s1 = f1_sew[1];
wire s2 = f1_sew[0];
wire s3 = 1'b0;
wire s4 = (FLEN == 64);
wire s5 = (FLEN == 32) | s4;
wire s6 = (f1_ex_ctrl[4:0] == 5'b01110);
wire s7 = (f1_ex_ctrl[4:0] == 5'b01100);
wire s8 = (f1_ex_ctrl[4:0] == 5'b00000);
wire s9 = (f1_ex_ctrl[4:0] == 5'b00001);
wire s10 = (f1_ex_ctrl[4:0] == 5'b00010);
wire s11 = s8 & s2;
wire s12 = s9 & s2;
wire s13 = s10 & s2;
wire s14 = s8 & s1 & s5;
wire s15 = s9 & s1 & s5;
wire s16 = s10 & s1 & s5;
wire s17 = s8 & s0 & s4;
wire s18 = s9 & s0 & s4;
wire s19 = s10 & s0 & s4;
wire s20 = (s1 & (FLEN == 64) & (&f1_op1_data[63:32])) | (FLEN != 64);
wire s21 = (s1 & (FLEN == 64) & (&f1_op2_data[63:32])) | (FLEN != 64);
wire s22 = (s2 & (FLEN == 64) & (&f1_op1_data[63:16])) | (s2 & (FLEN == 32) & (&f1_op1_data[31:16]));
wire s23 = (s2 & (FLEN == 64) & (&f1_op2_data[63:16])) | (s2 & (FLEN == 32) & (&f1_op2_data[31:16]));
wire s24 = f1_op2_data[31] & s21;
wire s25 = f1_op2_data[15] & s23;
assign f1_wdata = {64{s0 & (s6 | s7)}} & {f1_op1_data[63:0]} | {64{s1 & (s6 | s7)}} & {{32{s6 | f1_op1_data[31]}},f1_op1_data[31:0]} | {64{s2 & (s6 | s7)}} & {{48{s6 | f1_op1_data[15]}},f1_op1_data[15:0]} | {64{s17}} & {f1_op2_data[63],f1_op1_data[62:0]} | {64{s18}} & {~f1_op2_data[63],f1_op1_data[62:0]} | {64{s19}} & {f1_op1_data[63] ^ f1_op2_data[63],f1_op1_data[62:0]} | {64{s14 & s20}} & {32'hffffffff,s24,f1_op1_data[30:0]} | {64{s15 & s20}} & {32'hffffffff,~s24,f1_op1_data[30:0]} | {64{s16 & s20}} & {32'hffffffff,f1_op1_data[31] ^ s24,f1_op1_data[30:0]} | {64{s14 & ~s20}} & {32'hffffffff,s24,31'h7fc00000} | {64{s15 & ~s20}} & {32'hffffffff,~s24,31'h7fc00000} | {64{s16 & ~s20}} & {32'hffffffff,s24,31'h7fc00000} | {64{s11 & s22}} & {48'hffffffffffff,s25,f1_op1_data[14:0]} | {64{s12 & s22}} & {48'hffffffffffff,~s25,f1_op1_data[14:0]} | {64{s13 & s22}} & {48'hffffffffffff,f1_op1_data[15] ^ s25,f1_op1_data[14:0]} | {64{s11 & ~s22}} & {48'hffffffffffff,s25,15'h7e00} | {64{s12 & ~s22}} & {48'hffffffffffff,~s25,15'h7e00} | {64{s13 & ~s22}} & {48'hffffffffffff,s25,15'h7e00};
assign fmv_standby_ready = ~f1_valid;
endmodule

