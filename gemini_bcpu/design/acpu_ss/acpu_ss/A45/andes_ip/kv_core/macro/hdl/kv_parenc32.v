// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_parenc32 (
    data,
    dataout
);
input [31:0] data;
output [3:0] dataout;


assign dataout[0] = ^data[7:0];
assign dataout[1] = ^data[15:8];
assign dataout[2] = ^data[23:16];
assign dataout[3] = ^data[31:24];
endmodule

