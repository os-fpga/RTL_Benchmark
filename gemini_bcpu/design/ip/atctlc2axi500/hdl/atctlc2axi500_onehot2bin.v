// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_onehot2bin (
        	  out,
        	  in
);
parameter N = 8;


localparam W = $unsigned($clog2(N));


output   [W-1:0] out;
input    [N-1:0] in;



generate
if (W == 1) begin : gen_w1
	wire [2:0] inx = {{(2+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[2];
	assign out[0] =   inx[1];
end
endgenerate

generate
if (W == 2) begin : gen_w2
	wire [4:0] inx = {{(4+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[4];
	assign out[0] =   inx[1] | inx[3];
	assign out[1] =   inx[2] | inx[3];
end
endgenerate

generate
if (W == 3) begin : gen_w3
	wire [8:0] inx = {{(8+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[8];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7];
end
endgenerate

generate
if (W == 4) begin : gen_w4
	wire [16:0] inx = {{(16+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[16];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7] | inx[9] | inx[11] | inx[13] | inx[15];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7] | inx[10] | inx[11] | inx[14] | inx[15];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7] | inx[12] | inx[13] | inx[14] | inx[15];
	assign out[3] =   inx[8] | inx[9] | inx[10] | inx[11] | inx[12] | inx[13] | inx[14] | inx[15];
end
endgenerate

generate
if (W == 5) begin : gen_w5
	wire [32:0] inx = {{(32+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[32];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7] | inx[9] | inx[11] | inx[13] | inx[15] | inx[17] | inx[19] | inx[21] | inx[23] | inx[25] | inx[27] | inx[29] | inx[31];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7] | inx[10] | inx[11] | inx[14] | inx[15] | inx[18] | inx[19] | inx[22] | inx[23] | inx[26] | inx[27] | inx[30] | inx[31];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7] | inx[12] | inx[13] | inx[14] | inx[15] | inx[20] | inx[21] | inx[22] | inx[23] | inx[28] | inx[29] | inx[30] | inx[31];
	assign out[3] =   inx[8] | inx[9] | inx[10] | inx[11] | inx[12] | inx[13] | inx[14] | inx[15] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31];
	assign out[4] =   inx[16] | inx[17] | inx[18] | inx[19] | inx[20] | inx[21] | inx[22] | inx[23] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31];
end
endgenerate

generate
if (W == 6) begin : gen_w6
	wire [64:0] inx = {{(64+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[64];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7] | inx[9] | inx[11] | inx[13] | inx[15] | inx[17] | inx[19] | inx[21] | inx[23] | inx[25] | inx[27] | inx[29] | inx[31] | inx[33] | inx[35] | inx[37] | inx[39] | inx[41] | inx[43] | inx[45] | inx[47] | inx[49] | inx[51] | inx[53] | inx[55] | inx[57] | inx[59] | inx[61] | inx[63];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7] | inx[10] | inx[11] | inx[14] | inx[15] | inx[18] | inx[19] | inx[22] | inx[23] | inx[26] | inx[27] | inx[30] | inx[31] | inx[34] | inx[35] | inx[38] | inx[39] | inx[42] | inx[43] | inx[46] | inx[47] | inx[50] | inx[51] | inx[54] | inx[55] | inx[58] | inx[59] | inx[62] | inx[63];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7] | inx[12] | inx[13] | inx[14] | inx[15] | inx[20] | inx[21] | inx[22] | inx[23] | inx[28] | inx[29] | inx[30] | inx[31] | inx[36] | inx[37] | inx[38] | inx[39] | inx[44] | inx[45] | inx[46] | inx[47] | inx[52] | inx[53] | inx[54] | inx[55] | inx[60] | inx[61] | inx[62] | inx[63];
	assign out[3] =   inx[8] | inx[9] | inx[10] | inx[11] | inx[12] | inx[13] | inx[14] | inx[15] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63];
	assign out[4] =   inx[16] | inx[17] | inx[18] | inx[19] | inx[20] | inx[21] | inx[22] | inx[23] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63];
	assign out[5] =   inx[32] | inx[33] | inx[34] | inx[35] | inx[36] | inx[37] | inx[38] | inx[39] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63];
end
endgenerate

generate
if (W == 7) begin : gen_w7
	wire [128:0] inx = {{(128+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[128];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7] | inx[9] | inx[11] | inx[13] | inx[15] | inx[17] | inx[19] | inx[21] | inx[23] | inx[25] | inx[27] | inx[29] | inx[31] | inx[33] | inx[35] | inx[37] | inx[39] | inx[41] | inx[43] | inx[45] | inx[47] | inx[49] | inx[51] | inx[53] | inx[55] | inx[57] | inx[59] | inx[61] | inx[63] | inx[65] | inx[67] | inx[69] | inx[71] | inx[73] | inx[75] | inx[77] | inx[79] | inx[81] | inx[83] | inx[85] | inx[87] | inx[89] | inx[91] | inx[93] | inx[95] | inx[97] | inx[99] | inx[101] | inx[103] | inx[105] | inx[107] | inx[109] | inx[111] | inx[113] | inx[115] | inx[117] | inx[119] | inx[121] | inx[123] | inx[125] | inx[127];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7] | inx[10] | inx[11] | inx[14] | inx[15] | inx[18] | inx[19] | inx[22] | inx[23] | inx[26] | inx[27] | inx[30] | inx[31] | inx[34] | inx[35] | inx[38] | inx[39] | inx[42] | inx[43] | inx[46] | inx[47] | inx[50] | inx[51] | inx[54] | inx[55] | inx[58] | inx[59] | inx[62] | inx[63] | inx[66] | inx[67] | inx[70] | inx[71] | inx[74] | inx[75] | inx[78] | inx[79] | inx[82] | inx[83] | inx[86] | inx[87] | inx[90] | inx[91] | inx[94] | inx[95] | inx[98] | inx[99] | inx[102] | inx[103] | inx[106] | inx[107] | inx[110] | inx[111] | inx[114] | inx[115] | inx[118] | inx[119] | inx[122] | inx[123] | inx[126] | inx[127];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7] | inx[12] | inx[13] | inx[14] | inx[15] | inx[20] | inx[21] | inx[22] | inx[23] | inx[28] | inx[29] | inx[30] | inx[31] | inx[36] | inx[37] | inx[38] | inx[39] | inx[44] | inx[45] | inx[46] | inx[47] | inx[52] | inx[53] | inx[54] | inx[55] | inx[60] | inx[61] | inx[62] | inx[63] | inx[68] | inx[69] | inx[70] | inx[71] | inx[76] | inx[77] | inx[78] | inx[79] | inx[84] | inx[85] | inx[86] | inx[87] | inx[92] | inx[93] | inx[94] | inx[95] | inx[100] | inx[101] | inx[102] | inx[103] | inx[108] | inx[109] | inx[110] | inx[111] | inx[116] | inx[117] | inx[118] | inx[119] | inx[124] | inx[125] | inx[126] | inx[127];
	assign out[3] =   inx[8] | inx[9] | inx[10] | inx[11] | inx[12] | inx[13] | inx[14] | inx[15] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[72] | inx[73] | inx[74] | inx[75] | inx[76] | inx[77] | inx[78] | inx[79] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127];
	assign out[4] =   inx[16] | inx[17] | inx[18] | inx[19] | inx[20] | inx[21] | inx[22] | inx[23] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[80] | inx[81] | inx[82] | inx[83] | inx[84] | inx[85] | inx[86] | inx[87] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127];
	assign out[5] =   inx[32] | inx[33] | inx[34] | inx[35] | inx[36] | inx[37] | inx[38] | inx[39] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[96] | inx[97] | inx[98] | inx[99] | inx[100] | inx[101] | inx[102] | inx[103] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127];
	assign out[6] =   inx[64] | inx[65] | inx[66] | inx[67] | inx[68] | inx[69] | inx[70] | inx[71] | inx[72] | inx[73] | inx[74] | inx[75] | inx[76] | inx[77] | inx[78] | inx[79] | inx[80] | inx[81] | inx[82] | inx[83] | inx[84] | inx[85] | inx[86] | inx[87] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[96] | inx[97] | inx[98] | inx[99] | inx[100] | inx[101] | inx[102] | inx[103] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127];
end
endgenerate

generate
if (W == 8) begin : gen_w8
	wire [256:0] inx = {{(256+1-N){1'b0}}, in};
	wire nds_unused_ix = inx[256];
	assign out[0] =   inx[1] | inx[3] | inx[5] | inx[7] | inx[9] | inx[11] | inx[13] | inx[15] | inx[17] | inx[19] | inx[21] | inx[23] | inx[25] | inx[27] | inx[29] | inx[31] | inx[33] | inx[35] | inx[37] | inx[39] | inx[41] | inx[43] | inx[45] | inx[47] | inx[49] | inx[51] | inx[53] | inx[55] | inx[57] | inx[59] | inx[61] | inx[63] | inx[65] | inx[67] | inx[69] | inx[71] | inx[73] | inx[75] | inx[77] | inx[79] | inx[81] | inx[83] | inx[85] | inx[87] | inx[89] | inx[91] | inx[93] | inx[95] | inx[97] | inx[99] | inx[101] | inx[103] | inx[105] | inx[107] | inx[109] | inx[111] | inx[113] | inx[115] | inx[117] | inx[119] | inx[121] | inx[123] | inx[125] | inx[127] | inx[129] | inx[131] | inx[133] | inx[135] | inx[137] | inx[139] | inx[141] | inx[143] | inx[145] | inx[147] | inx[149] | inx[151] | inx[153] | inx[155] | inx[157] | inx[159] | inx[161] | inx[163] | inx[165] | inx[167] | inx[169] | inx[171] | inx[173] | inx[175] | inx[177] | inx[179] | inx[181] | inx[183] | inx[185] | inx[187] | inx[189] | inx[191] | inx[193] | inx[195] | inx[197] | inx[199] | inx[201] | inx[203] | inx[205] | inx[207] | inx[209] | inx[211] | inx[213] | inx[215] | inx[217] | inx[219] | inx[221] | inx[223] | inx[225] | inx[227] | inx[229] | inx[231] | inx[233] | inx[235] | inx[237] | inx[239] | inx[241] | inx[243] | inx[245] | inx[247] | inx[249] | inx[251] | inx[253] | inx[255];
	assign out[1] =   inx[2] | inx[3] | inx[6] | inx[7] | inx[10] | inx[11] | inx[14] | inx[15] | inx[18] | inx[19] | inx[22] | inx[23] | inx[26] | inx[27] | inx[30] | inx[31] | inx[34] | inx[35] | inx[38] | inx[39] | inx[42] | inx[43] | inx[46] | inx[47] | inx[50] | inx[51] | inx[54] | inx[55] | inx[58] | inx[59] | inx[62] | inx[63] | inx[66] | inx[67] | inx[70] | inx[71] | inx[74] | inx[75] | inx[78] | inx[79] | inx[82] | inx[83] | inx[86] | inx[87] | inx[90] | inx[91] | inx[94] | inx[95] | inx[98] | inx[99] | inx[102] | inx[103] | inx[106] | inx[107] | inx[110] | inx[111] | inx[114] | inx[115] | inx[118] | inx[119] | inx[122] | inx[123] | inx[126] | inx[127] | inx[130] | inx[131] | inx[134] | inx[135] | inx[138] | inx[139] | inx[142] | inx[143] | inx[146] | inx[147] | inx[150] | inx[151] | inx[154] | inx[155] | inx[158] | inx[159] | inx[162] | inx[163] | inx[166] | inx[167] | inx[170] | inx[171] | inx[174] | inx[175] | inx[178] | inx[179] | inx[182] | inx[183] | inx[186] | inx[187] | inx[190] | inx[191] | inx[194] | inx[195] | inx[198] | inx[199] | inx[202] | inx[203] | inx[206] | inx[207] | inx[210] | inx[211] | inx[214] | inx[215] | inx[218] | inx[219] | inx[222] | inx[223] | inx[226] | inx[227] | inx[230] | inx[231] | inx[234] | inx[235] | inx[238] | inx[239] | inx[242] | inx[243] | inx[246] | inx[247] | inx[250] | inx[251] | inx[254] | inx[255];
	assign out[2] =   inx[4] | inx[5] | inx[6] | inx[7] | inx[12] | inx[13] | inx[14] | inx[15] | inx[20] | inx[21] | inx[22] | inx[23] | inx[28] | inx[29] | inx[30] | inx[31] | inx[36] | inx[37] | inx[38] | inx[39] | inx[44] | inx[45] | inx[46] | inx[47] | inx[52] | inx[53] | inx[54] | inx[55] | inx[60] | inx[61] | inx[62] | inx[63] | inx[68] | inx[69] | inx[70] | inx[71] | inx[76] | inx[77] | inx[78] | inx[79] | inx[84] | inx[85] | inx[86] | inx[87] | inx[92] | inx[93] | inx[94] | inx[95] | inx[100] | inx[101] | inx[102] | inx[103] | inx[108] | inx[109] | inx[110] | inx[111] | inx[116] | inx[117] | inx[118] | inx[119] | inx[124] | inx[125] | inx[126] | inx[127] | inx[132] | inx[133] | inx[134] | inx[135] | inx[140] | inx[141] | inx[142] | inx[143] | inx[148] | inx[149] | inx[150] | inx[151] | inx[156] | inx[157] | inx[158] | inx[159] | inx[164] | inx[165] | inx[166] | inx[167] | inx[172] | inx[173] | inx[174] | inx[175] | inx[180] | inx[181] | inx[182] | inx[183] | inx[188] | inx[189] | inx[190] | inx[191] | inx[196] | inx[197] | inx[198] | inx[199] | inx[204] | inx[205] | inx[206] | inx[207] | inx[212] | inx[213] | inx[214] | inx[215] | inx[220] | inx[221] | inx[222] | inx[223] | inx[228] | inx[229] | inx[230] | inx[231] | inx[236] | inx[237] | inx[238] | inx[239] | inx[244] | inx[245] | inx[246] | inx[247] | inx[252] | inx[253] | inx[254] | inx[255];
	assign out[3] =   inx[8] | inx[9] | inx[10] | inx[11] | inx[12] | inx[13] | inx[14] | inx[15] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[72] | inx[73] | inx[74] | inx[75] | inx[76] | inx[77] | inx[78] | inx[79] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127] | inx[136] | inx[137] | inx[138] | inx[139] | inx[140] | inx[141] | inx[142] | inx[143] | inx[152] | inx[153] | inx[154] | inx[155] | inx[156] | inx[157] | inx[158] | inx[159] | inx[168] | inx[169] | inx[170] | inx[171] | inx[172] | inx[173] | inx[174] | inx[175] | inx[184] | inx[185] | inx[186] | inx[187] | inx[188] | inx[189] | inx[190] | inx[191] | inx[200] | inx[201] | inx[202] | inx[203] | inx[204] | inx[205] | inx[206] | inx[207] | inx[216] | inx[217] | inx[218] | inx[219] | inx[220] | inx[221] | inx[222] | inx[223] | inx[232] | inx[233] | inx[234] | inx[235] | inx[236] | inx[237] | inx[238] | inx[239] | inx[248] | inx[249] | inx[250] | inx[251] | inx[252] | inx[253] | inx[254] | inx[255];
	assign out[4] =   inx[16] | inx[17] | inx[18] | inx[19] | inx[20] | inx[21] | inx[22] | inx[23] | inx[24] | inx[25] | inx[26] | inx[27] | inx[28] | inx[29] | inx[30] | inx[31] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[80] | inx[81] | inx[82] | inx[83] | inx[84] | inx[85] | inx[86] | inx[87] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127] | inx[144] | inx[145] | inx[146] | inx[147] | inx[148] | inx[149] | inx[150] | inx[151] | inx[152] | inx[153] | inx[154] | inx[155] | inx[156] | inx[157] | inx[158] | inx[159] | inx[176] | inx[177] | inx[178] | inx[179] | inx[180] | inx[181] | inx[182] | inx[183] | inx[184] | inx[185] | inx[186] | inx[187] | inx[188] | inx[189] | inx[190] | inx[191] | inx[208] | inx[209] | inx[210] | inx[211] | inx[212] | inx[213] | inx[214] | inx[215] | inx[216] | inx[217] | inx[218] | inx[219] | inx[220] | inx[221] | inx[222] | inx[223] | inx[240] | inx[241] | inx[242] | inx[243] | inx[244] | inx[245] | inx[246] | inx[247] | inx[248] | inx[249] | inx[250] | inx[251] | inx[252] | inx[253] | inx[254] | inx[255];
	assign out[5] =   inx[32] | inx[33] | inx[34] | inx[35] | inx[36] | inx[37] | inx[38] | inx[39] | inx[40] | inx[41] | inx[42] | inx[43] | inx[44] | inx[45] | inx[46] | inx[47] | inx[48] | inx[49] | inx[50] | inx[51] | inx[52] | inx[53] | inx[54] | inx[55] | inx[56] | inx[57] | inx[58] | inx[59] | inx[60] | inx[61] | inx[62] | inx[63] | inx[96] | inx[97] | inx[98] | inx[99] | inx[100] | inx[101] | inx[102] | inx[103] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127] | inx[160] | inx[161] | inx[162] | inx[163] | inx[164] | inx[165] | inx[166] | inx[167] | inx[168] | inx[169] | inx[170] | inx[171] | inx[172] | inx[173] | inx[174] | inx[175] | inx[176] | inx[177] | inx[178] | inx[179] | inx[180] | inx[181] | inx[182] | inx[183] | inx[184] | inx[185] | inx[186] | inx[187] | inx[188] | inx[189] | inx[190] | inx[191] | inx[224] | inx[225] | inx[226] | inx[227] | inx[228] | inx[229] | inx[230] | inx[231] | inx[232] | inx[233] | inx[234] | inx[235] | inx[236] | inx[237] | inx[238] | inx[239] | inx[240] | inx[241] | inx[242] | inx[243] | inx[244] | inx[245] | inx[246] | inx[247] | inx[248] | inx[249] | inx[250] | inx[251] | inx[252] | inx[253] | inx[254] | inx[255];
	assign out[6] =   inx[64] | inx[65] | inx[66] | inx[67] | inx[68] | inx[69] | inx[70] | inx[71] | inx[72] | inx[73] | inx[74] | inx[75] | inx[76] | inx[77] | inx[78] | inx[79] | inx[80] | inx[81] | inx[82] | inx[83] | inx[84] | inx[85] | inx[86] | inx[87] | inx[88] | inx[89] | inx[90] | inx[91] | inx[92] | inx[93] | inx[94] | inx[95] | inx[96] | inx[97] | inx[98] | inx[99] | inx[100] | inx[101] | inx[102] | inx[103] | inx[104] | inx[105] | inx[106] | inx[107] | inx[108] | inx[109] | inx[110] | inx[111] | inx[112] | inx[113] | inx[114] | inx[115] | inx[116] | inx[117] | inx[118] | inx[119] | inx[120] | inx[121] | inx[122] | inx[123] | inx[124] | inx[125] | inx[126] | inx[127] | inx[192] | inx[193] | inx[194] | inx[195] | inx[196] | inx[197] | inx[198] | inx[199] | inx[200] | inx[201] | inx[202] | inx[203] | inx[204] | inx[205] | inx[206] | inx[207] | inx[208] | inx[209] | inx[210] | inx[211] | inx[212] | inx[213] | inx[214] | inx[215] | inx[216] | inx[217] | inx[218] | inx[219] | inx[220] | inx[221] | inx[222] | inx[223] | inx[224] | inx[225] | inx[226] | inx[227] | inx[228] | inx[229] | inx[230] | inx[231] | inx[232] | inx[233] | inx[234] | inx[235] | inx[236] | inx[237] | inx[238] | inx[239] | inx[240] | inx[241] | inx[242] | inx[243] | inx[244] | inx[245] | inx[246] | inx[247] | inx[248] | inx[249] | inx[250] | inx[251] | inx[252] | inx[253] | inx[254] | inx[255];
	assign out[7] =   inx[128] | inx[129] | inx[130] | inx[131] | inx[132] | inx[133] | inx[134] | inx[135] | inx[136] | inx[137] | inx[138] | inx[139] | inx[140] | inx[141] | inx[142] | inx[143] | inx[144] | inx[145] | inx[146] | inx[147] | inx[148] | inx[149] | inx[150] | inx[151] | inx[152] | inx[153] | inx[154] | inx[155] | inx[156] | inx[157] | inx[158] | inx[159] | inx[160] | inx[161] | inx[162] | inx[163] | inx[164] | inx[165] | inx[166] | inx[167] | inx[168] | inx[169] | inx[170] | inx[171] | inx[172] | inx[173] | inx[174] | inx[175] | inx[176] | inx[177] | inx[178] | inx[179] | inx[180] | inx[181] | inx[182] | inx[183] | inx[184] | inx[185] | inx[186] | inx[187] | inx[188] | inx[189] | inx[190] | inx[191] | inx[192] | inx[193] | inx[194] | inx[195] | inx[196] | inx[197] | inx[198] | inx[199] | inx[200] | inx[201] | inx[202] | inx[203] | inx[204] | inx[205] | inx[206] | inx[207] | inx[208] | inx[209] | inx[210] | inx[211] | inx[212] | inx[213] | inx[214] | inx[215] | inx[216] | inx[217] | inx[218] | inx[219] | inx[220] | inx[221] | inx[222] | inx[223] | inx[224] | inx[225] | inx[226] | inx[227] | inx[228] | inx[229] | inx[230] | inx[231] | inx[232] | inx[233] | inx[234] | inx[235] | inx[236] | inx[237] | inx[238] | inx[239] | inx[240] | inx[241] | inx[242] | inx[243] | inx[244] | inx[245] | inx[246] | inx[247] | inx[248] | inx[249] | inx[250] | inx[251] | inx[252] | inx[253] | inx[254] | inx[255];
end
endgenerate



endmodule

