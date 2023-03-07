// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_btb_update_ctrl (
    reso_info,
    pred_info,
    alloc,
    invalid,
    revise,
    way,
    ucond,
    call,
    ret,
    mispred
);
input [12:0] reso_info;
input [11:0] pred_info;
output invalid;
output alloc;
output revise;
output [1:0] way;
output ucond;
output call;
output ret;
output mispred;


wire s0 = reso_info[0];
wire s1 = reso_info[4];
wire s2 = reso_info[3];
wire s3 = reso_info[1];
wire s4 = reso_info[2];
wire s5 = reso_info[10];
wire [1:0] s6 = reso_info[5 +:2];
wire s7 = reso_info[9];
wire s8 = pred_info[11];
wire s9 = pred_info[0];
wire s10 = pred_info[6];
wire s11 = pred_info[1];
wire s12 = pred_info[7];
wire s13 = (s3 | s4) & ~s10;
assign invalid = (~s13 & s9 & s8) | s10;
assign alloc = (s4 & ~s9 & ~s8 & s0) | (s3 & ~s9 & ~s8);
assign revise = (s3 & s9 & s5 & ~(s2 & s12)) | (s3 & s8 & ~s9) | (s4 & s8 & ~s9 & s0);
assign way = s6;
assign call = s1 | s7 | invalid;
assign ret = s2 | invalid;
assign ucond = s3 & ~invalid;
assign mispred = (s4 & ((s9 & s11) ^ s0)) | (s3 & ~(s9 & s11)) | (((s4 & s0) | s3) & s5) | (~s3 & ~s4 & s11);
endmodule

