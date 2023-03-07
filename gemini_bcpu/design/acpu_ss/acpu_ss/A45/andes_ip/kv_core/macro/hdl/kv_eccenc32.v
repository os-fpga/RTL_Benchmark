// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_eccenc32 (
    data,
    dataout
);
input [31:0] data;
output [6:0] dataout;


wire [6:0] s0;
assign s0[0] = data[30] ^ data[28] ^ data[26] ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13] ^ data[11] ^ data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[3] ^ data[1] ^ data[0];
assign s0[1] = data[31] ^ data[28] ^ data[27] ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13] ^ data[12] ^ data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[3] ^ data[2] ^ data[0];
assign s0[2] = data[31] ^ data[30] ^ data[29] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[3] ^ data[2] ^ data[1];
assign s0[3] = data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[6] ^ data[5] ^ data[4];
assign s0[4] = data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[13] ^ data[12] ^ data[11];
assign s0[5] = data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27] ^ data[26];
assign s0[6] = data[29] ^ data[27] ^ data[26] ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12] ^ data[11] ^ data[10] ^ data[7] ^ data[5] ^ data[4] ^ data[2] ^ data[1] ^ data[0];
assign dataout = s0;
endmodule

