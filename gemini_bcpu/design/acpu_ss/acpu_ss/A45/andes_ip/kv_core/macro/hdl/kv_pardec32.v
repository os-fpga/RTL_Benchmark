// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pardec32 (
    check_en,
    data,
    parin,
    error
);
input check_en;
input [31:0] data;
input [3:0] parin;
output error;


wire [3:0] s0;
assign s0[0] = ^data[7:0] ^ parin[0];
assign s0[1] = ^data[15:8] ^ parin[1];
assign s0[2] = ^data[23:16] ^ parin[2];
assign s0[3] = ^data[31:24] ^ parin[3];
assign error = |s0 & check_en;
endmodule

