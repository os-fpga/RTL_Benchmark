// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pardec64 (
    check_en,
    data,
    parin,
    error
);
input check_en;
input [63:0] data;
input [7:0] parin;
output error;


wire [7:0] s0;
assign s0[0] = ^data[7:0] ^ parin[0];
assign s0[1] = ^data[15:8] ^ parin[1];
assign s0[2] = ^data[23:16] ^ parin[2];
assign s0[3] = ^data[31:24] ^ parin[3];
assign s0[4] = ^data[39:32] ^ parin[4];
assign s0[5] = ^data[47:40] ^ parin[5];
assign s0[6] = ^data[55:48] ^ parin[6];
assign s0[7] = ^data[63:56] ^ parin[7];
assign error = |s0 & check_en;
endmodule

