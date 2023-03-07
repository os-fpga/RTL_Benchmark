// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_parenc64 (
    data,
    dataout
);
input [63:0] data;
output [7:0] dataout;


assign dataout[0] = ^data[7:0];
assign dataout[1] = ^data[15:8];
assign dataout[2] = ^data[23:16];
assign dataout[3] = ^data[31:24];
assign dataout[4] = ^data[39:32];
assign dataout[5] = ^data[47:40];
assign dataout[6] = ^data[55:48];
assign dataout[7] = ^data[63:56];
endmodule

