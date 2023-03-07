// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_eccenc64 (
    data,
    dataout
);
input [63:0] data;
output [7:0] dataout;


wire [7:0] s0;
assign s0[0] = data[63] ^ data[61] ^ data[59] ^ data[57] ^ data[56] ^ data[54] ^ data[52] ^ data[50] ^ data[48] ^ data[46] ^ data[44] ^ data[42] ^ data[40] ^ data[38] ^ data[36] ^ data[34] ^ data[32] ^ data[30] ^ data[28] ^ data[26] ^ data[25] ^ data[23] ^ data[21] ^ data[19] ^ data[17] ^ data[15] ^ data[13] ^ data[11] ^ data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[3] ^ data[1] ^ data[0];
assign s0[1] = data[63] ^ data[62] ^ data[59] ^ data[58] ^ data[56] ^ data[55] ^ data[52] ^ data[51] ^ data[48] ^ data[47] ^ data[44] ^ data[43] ^ data[40] ^ data[39] ^ data[36] ^ data[35] ^ data[32] ^ data[31] ^ data[28] ^ data[27] ^ data[25] ^ data[24] ^ data[21] ^ data[20] ^ data[17] ^ data[16] ^ data[13] ^ data[12] ^ data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[3] ^ data[2] ^ data[0];
assign s0[2] = data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[32] ^ data[31] ^ data[30] ^ data[29] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[3] ^ data[2] ^ data[1];
assign s0[3] = data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[10] ^ data[9] ^ data[8] ^ data[7] ^ data[6] ^ data[5] ^ data[4];
assign s0[4] = data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[25] ^ data[24] ^ data[23] ^ data[22] ^ data[21] ^ data[20] ^ data[19] ^ data[18] ^ data[17] ^ data[16] ^ data[15] ^ data[14] ^ data[13] ^ data[12] ^ data[11];
assign s0[5] = data[56] ^ data[55] ^ data[54] ^ data[53] ^ data[52] ^ data[51] ^ data[50] ^ data[49] ^ data[48] ^ data[47] ^ data[46] ^ data[45] ^ data[44] ^ data[43] ^ data[42] ^ data[41] ^ data[40] ^ data[39] ^ data[38] ^ data[37] ^ data[36] ^ data[35] ^ data[34] ^ data[33] ^ data[32] ^ data[31] ^ data[30] ^ data[29] ^ data[28] ^ data[27] ^ data[26];
assign s0[6] = data[63] ^ data[62] ^ data[61] ^ data[60] ^ data[59] ^ data[58] ^ data[57];
assign s0[7] = data[63] ^ data[60] ^ data[58] ^ data[57] ^ data[56] ^ data[53] ^ data[51] ^ data[50] ^ data[47] ^ data[46] ^ data[44] ^ data[41] ^ data[39] ^ data[38] ^ data[36] ^ data[33] ^ data[32] ^ data[29] ^ data[27] ^ data[26] ^ data[24] ^ data[23] ^ data[21] ^ data[18] ^ data[17] ^ data[14] ^ data[12] ^ data[11] ^ data[10] ^ data[7] ^ data[5] ^ data[4] ^ data[2] ^ data[1] ^ data[0];
assign dataout = s0;
endmodule

