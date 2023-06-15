

`define R1BIAS 128'h64ac285ac9b337c50a10b7a3bab19746
`define R2BIAS 128'h3d05dc666ef69af80d589567c6aaabec
`define R3BIAS 128'ha0689b96d4ebbf434936e96a89d8c38a
`define R4BIAS 128'h946399bc7bbec122bb5c71d51f92575d
`define R5BIAS 128'h8f44411d51e64017fbfd193234b8612a
`define R6BIAS 128'hca236fda39f7a2017fd631e7de8004dd
`define R7BIAS 128'h2c5982afa8e00fcda1123e30d11cd03a
`define R8BIAS 128'h33722e4f9002130675ce87c2efb2ad7d
`define R9BIAS 128'h3815e1529f7a6c2f27c4e281a9cf8dc0
`define RABIAS 128'hd7dfff6076148c5e5509e408c74220fc
`define RBBIAS 128'hd25091d94c629ee8b9a6f91a00210bfa
`define RCBIAS 128'h359c4e4b6948cb0ec8a45bea8407b418
`define RDBIAS 128'hf4ae6bdba7cc3f8b4a0c3c25e5544d45
`define REBIAS 128'h83ed11f0b05393f27426b59d6d7cf32d
`define RFBIAS 128'hf156247e471b86bd708e1e3b731603b6
`define RGBIAS 128'hac285ac9b337c50a10b7a3bab1974688

module safer_rot3(
   input  [135:0] in,
   output [135:0] out
);

assign out = {
   in[132:128], in[135:133],
   in[124:120], in[127:125],
   in[116:112], in[119:117],
   in[108:104], in[111:109],
   in[100:96], in[103:101],
   in[92:88], in[95:93],
   in[84:80], in[87:85],
   in[76:72], in[79:77],
   in[68:64], in[71:69],
   in[60:56], in[63:61],
   in[52:48], in[55:53],
   in[44:40], in[47:45],
   in[36:32], in[39:37],
   in[28:24], in[31:29],
   in[20:16], in[23:21],
   in[12:8],  in[15:13],
   in[4:0],   in[7:5]
};

endmodule

module safer_ksa_round(
   input  clk,
   input  [135:0] lk0,
   output [135:0] lk1,
   output reg [135:0] lk2 = 136'h0
);
//synthesis attribute init lk2 0;

wire [135:0] lk1_, lk1_0, lk2_;

safer_rot3 rot3_1(lk0, lk1_);
assign lk1 = {lk1_[7:0], lk1_[135:8]};

safer_rot3 rot3_2(lk1, lk2_);
always @(posedge clk) begin
   lk2 <= {lk2_[7:0], lk2_[135:8]};
end

endmodule

module safer_ksa_bias(
   input  [135:0] in,
   input  [127:0] bias,
   output [127:0] out
);

assign out[7:0]     = in[7:0]     + bias[7:0];
assign out[15:8]    = in[15:8]    + bias[15:8];
assign out[23:16]   = in[23:16]   + bias[23:16];
assign out[31:24]   = in[31:24]   + bias[31:24];
assign out[39:32]   = in[39:32]   + bias[39:32];
assign out[47:40]   = in[47:40]   + bias[47:40];
assign out[55:48]   = in[55:48]   + bias[55:48];
assign out[63:56]   = in[63:56]   + bias[63:56];
assign out[71:64]   = in[71:64]   + bias[71:64];
assign out[79:72]   = in[79:72]   + bias[79:72];
assign out[87:80]   = in[87:80]   + bias[87:80];
assign out[95:88]   = in[95:88]   + bias[95:88];
assign out[103:96]  = in[103:96]  + bias[103:96];
assign out[111:104] = in[111:104] + bias[111:104];
assign out[119:112] = in[119:112] + bias[119:112];
assign out[127:120] = in[127:120] + bias[127:120];

endmodule

/*
 * this is an 8 stage pipeline implementation of the safer+ ksa
 */
module safer_ksa(
   input  clk,
   input  [127:0] lk,
   output [127:0] lkey0, lkey1, lkey2, lkey3, lkey4, lkey5, lkey6, lkey7,
   output [127:0] lkey8, lkey9, lkeya, lkeyb, lkeyc, lkeyd, lkeye, lkeyf, lkeyg
);

wire [135:0] lk0, lk2, lk3, lk4, lk5, lk6, lk7, lk8, lk9, lka, lkb, lkc, lkd, lke, lkf, lkg;

assign lk0 = {
   lk[127:120] ^ lk[119:112] ^ lk[111:104] ^ lk[103:96] ^
   lk[95:88]   ^ lk[87:80]   ^ lk[79:72]   ^ lk[71:64]  ^
   lk[63:56]   ^ lk[55:48]   ^ lk[47:40]   ^ lk[39:32]  ^
   lk[31:24]   ^ lk[23:16]   ^ lk[15:8]    ^ lk[7:0],
   lk
};
wire [135:0] lk1_;
safer_rot3 rot3_1(lk0, lk1_);

reg  [135:0] lk1 = 136'h0,   lk3_1 = 136'h0;
reg  [135:0] lk1_0 = 136'h0, lk3_0 = 136'h0, lk5_0 = 136'h0, lk7_0 = 136'h0;
reg  [135:0] lk9_0 = 136'h0, lkb_0 = 136'h0, lkd_0 = 136'h0, lkf_0 = 136'h0;
always @(posedge clk) begin
   lk1   <= {lk1_[7:0], lk1_[135:8]};
   lk1_0 <= lk1;
end

safer_ksa_round r23(clk, lk1_0, lk2, lk3);
safer_ksa_round r45(clk, lk3_1, lk4, lk5);
safer_ksa_round r67(clk, lk5_0, lk6, lk7);
safer_ksa_round r89(clk, lk7_0, lk8, lk9);
safer_ksa_round rab(clk, lk9_0, lka, lkb);
safer_ksa_round rcd(clk, lkb_0, lkc, lkd);
safer_ksa_round ref(clk, lkd_0, lke, lkf);
always @(posedge clk) begin
   lk3_0 <= lk3;
   lk3_1 <= lk3_0;
   lk5_0 <= lk5;
   lk7_0 <= lk7;
   lk9_0 <= lk9;
   lkb_0 <= lkb;
   lkd_0 <= lkd;
   lkf_0 <= lkf;
end

wire [135:0] lkg_;
safer_rot3 rot3_g(lkf_0, lkg_);
assign lkg = {lkg_[7:0], lkg_[135:8]};

assign lkey0 = lk;
safer_ksa_bias bias1(lk1, `R1BIAS, lkey1);
safer_ksa_bias bias2(lk2, `R2BIAS, lkey2);
safer_ksa_bias bias3(lk3, `R3BIAS, lkey3);
safer_ksa_bias bias4(lk4, `R4BIAS, lkey4);
safer_ksa_bias bias5(lk5, `R5BIAS, lkey5);
safer_ksa_bias bias6(lk6, `R6BIAS, lkey6);
safer_ksa_bias bias7(lk7, `R7BIAS, lkey7);
safer_ksa_bias bias8(lk8, `R8BIAS, lkey8);
safer_ksa_bias bias9(lk9, `R9BIAS, lkey9);
safer_ksa_bias biasa(lka, `RABIAS, lkeya);
safer_ksa_bias biasb(lkb, `RBBIAS, lkeyb);
safer_ksa_bias biasc(lkc, `RCBIAS, lkeyc);
safer_ksa_bias biasd(lkd, `RDBIAS, lkeyd);
safer_ksa_bias biase(lke, `REBIAS, lkeye);
safer_ksa_bias biasf(lkf, `RFBIAS, lkeyf);
safer_ksa_bias biasg(lkg, `RGBIAS, lkeyg);

endmodule



module safer_ef_bram(
   input clk,
   input [7:0] in0, in1,
   output [7:0] out0, out1
);


RAMB18_M2000 /*#(
   .INIT_00(256'hf772bfbb1b3418bd6ba826eb940967083fcf38b8a4870378ae1545be93e22d01),
   .INIT_01(256'h83649192baf4fb11a6d77786dc3ea7ffb18df3d3d89fc0e3553b2f519c483540),
   .INIT_02(256'ha0e81c5c52c4823c578ba35fca719781141d848ccb99d1882bb2b52cdaef33f1),
   .INIT_03(256'hd9c7faea6cd060f2ab9e98a94e249b20fc39e0de8e1a0cdfb65413f64a85b404),
   .INIT_04(256'h0a8f4246e6cde9449659db166df89af9c232c9495d7afe8953ecbc436e1fd400),
   .INIT_05(256'h7e9d706f470d06f05b2a8a7b25c35a0250740e2e2962411eacc6d2b065b9ccc1),
   .INIT_06(256'h6119e5a5af3d7fc5aa765ea237906a80ede47d7536683079d64f4cd52712ce10),
   .INIT_07(256'h283a07179531a10f56636958b3dd66e105c8212373e7f5224badee0bb77c4dfd),
   .DOA_REG(0),
   .DOB_REG(0),
   .INIT_A(18'h000000000),
   .INIT_B(18'h000000000),
   .READ_WIDTH_A(9),
   .READ_WIDTH_B(9),
   .SIM_COLLISION_CHECK("ALL"),
   .SRVAL_A(18'h000000000),
   .SRVAL_B(18'h000000000),
   .WRITE_MODE_A("READ_FIRST"),
   .WRITE_MODE_B("READ_FIRST"),
   .WRITE_WIDTH_A(9),
   .WRITE_WIDTH_B(9)
) */RAMB16_inst (
   .dout0(out0),             // 32-bit A port data output
   .dout1(out1),             // 32-bit B port data output
   //.DOPA(),                // 4-bit A port parity data output
   //.DOPB(),                // 4-bit B port parity data output
   .addr0(in0),  // 15-bit A port address input
   .addr1(in1),  // 15-bit B port address input
   .clk(clk),             // 1-bit A port clock input
   //.CLKB(clk),             // 1-bit B port clock input
   .din0(8'h0),             // 32-bit A port data input
   .din1(8'h0),             // 32-bit B port data input
   //.DIPA(4'h0),            // 4-bit A port parity data input
   //.DIPB(4'h0),            // 4-bit B port parity data input
   .en(1'b1),             // 1-bit A port enable input
   //.ENB(1'b1),             // 1-bit B port enable input
   //.REGCEA(1'b0),          // 1-bit A port register enable input
   //.REGCEB(1'b0),          // 1-bit B port register enable input
   .rst(1'b0),            // 1-bit A port set/reset input
   //.SSRB(1'b0),            // 1-bit B port set/reset input
   .we0(1'h0),             // 1-bit A port write enable input
   .we1(1'h0)              // 1-bit B port write enable input
);


endmodule



module safer_lf_bram(
   input clk,
   input [7:0] in0, in1,
   output [7:0] out0, out1
);


RAMB18_M2000 /*#(
   .INIT_00(256'h82a84e5d1b6ade19fc94064f65c238c0f8adba69e49f1210fdb9ef6009b00080),
   .INIT_01(256'h0f32da5826fe6e0dd3cb211a418efac925ac014447b6abffc315b372ece8ed70),
   .INIT_02(256'h54d58b5cb7b196f457f72766875b24afc673e1c5e7638c22bb9c0598849da920),
   .INIT_03(256'hd9bfcde2b48ac80835d6ccaeeb1e52bdbc83937b17d1f5ca11f1a33ef6aadf79),
   .INIT_04(256'h2a76be2371914a755197fb13033c3dd29e6b2e4c56b588480a34624d3f5950d0),
   .INIT_05(256'h1d0418851c3ba20ce3674561f3462fa4db07e6a777d774163137dc0b55d4f95f),
   .INIT_06(256'h686cf23395437f2b36c7c4812ca5497a0ec19aa14b538dee7ea6d85ab28fa029),
   .INIT_07(256'h3089e06f397d90921f64e93a2d7840b842e5cf86147c995eea9bddce2802f06d),
   .DOA_REG(0),
   .DOB_REG(0),
   .INIT_A(18'h000000000),
   .INIT_B(18'h000000000),
   .READ_WIDTH_A(9),
   .READ_WIDTH_B(9),
   .SIM_COLLISION_CHECK("ALL"),
   .SRVAL_A(18'h000000000),
   .SRVAL_B(18'h000000000),
   .WRITE_MODE_A("READ_FIRST"),
   .WRITE_MODE_B("READ_FIRST"),
   .WRITE_WIDTH_A(9),
   .WRITE_WIDTH_B(9)
)*/ RAMB16_inst (
   .dout0(out0),             // 32-bit A port data output
   .dout1(out1),             // 32-bit B port data output
   //.DOPA(),                // 4-bit A port parity data output
   //.DOPB(),                // 4-bit B port parity data output
   .addr0(in0),  // 15-bit A port address input
   .addr1(in1),  // 15-bit B port address input
   .clk(clk),             // 1-bit A port clock input
   //.CLKB(clk),             // 1-bit B port clock input
   .din0(8'h0),             // 32-bit A port data input
   .din1(8'h0),             // 32-bit B port data input
   //.DIPA(4'h0),            // 4-bit A port parity data input
   //.DIPB(4'h0),            // 4-bit B port parity data input
   .en(1'b1),             // 1-bit A port enable input
   //.ENB(1'b1),             // 1-bit B port enable input
   //.REGCEA(1'b0),          // 1-bit A port register enable input
   //.REGCEB(1'b0),          // 1-bit B port register enable input
   .rst(1'b0),            // 1-bit A port set/reset input
   //.SSRB(1'b0),            // 1-bit B port set/reset input
   .we0(1'h0),             // 1-bit A port write enable input
   .we1(1'h0)              // 1-bit B port write enable input
);


endmodule

module safer_round(
   input  clk,
   input  [127:0] x,
   input  [127:0] k0, k1,
   output [127:0] y
);
//synthesis attribute init out 0;

wire [7:0] ef0_, ef1_, ef2_, ef3_, ef4_, ef5_, ef6_, ef7_;
wire [7:0] lf0_, lf1_, lf2_, lf3_, lf4_, lf5_, lf6_, lf7_;
wire [127:0] x_;

safer_ef_bram ef0(clk, x[7:0]     ^ k0[7:0],     x[31:24]   ^ k0[31:24],   ef0_, ef1_);
safer_ef_bram ef1(clk, x[39:32]   ^ k0[39:32],   x[63:56]   ^ k0[63:56],   ef2_, ef3_);
safer_ef_bram ef2(clk, x[71:64]   ^ k0[71:64],   x[95:88]   ^ k0[95:88],   ef4_, ef5_);
safer_ef_bram ef3(clk, x[103:96]  ^ k0[103:96],  x[127:120] ^ k0[127:120], ef6_, ef7_);
safer_lf_bram lf0(clk, x[15:8]    + k0[15:8],    x[23:16]   + k0[23:16],   lf0_, lf1_);
safer_lf_bram lf1(clk, x[47:40]   + k0[47:40],   x[55:48]   + k0[55:48],   lf2_, lf3_);
safer_lf_bram lf2(clk, x[79:72]   + k0[79:72],   x[87:80]   + k0[87:80],   lf4_, lf5_);
safer_lf_bram lf3(clk, x[111:104] + k0[111:104], x[119:112] + k0[119:112], lf6_, lf7_);

                                          // |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |_
assign x_[7:0]     = ef0_ + k1[7:0];      //  [2  2][1  1] 16 8  2  1  4  2  4  2 [1  1][4  4]a 
assign x_[15:8]    = lf0_ ^ k1[15:8];     //  [1  1][1  1] 8  4  2  1  2  1  4  2 [1  1][2  2]_
assign x_[23:16]   = lf1_ ^ k1[23:16];    //  [1  1][4  4] 2  1  4  2  4  2  16 8 [2  2][1  1]b
assign x_[31:24]   = ef1_ + k1[31:24];    //  [1  1][2  2] 2  1  2  1  4  2  8  4 [1  1][1  1]_

assign x_[39:32]   = ef2_ + k1[39:32];    //  [4  4] 2  1  4  2  4  2  16 8 [1  1][1  1][2  2]c
assign x_[47:40]   = lf2_ ^ k1[47:40];    //  [2  2] 2  1  2  1  4  2  8  4 [1  1][1  1][1  1]_
assign x_[55:48]   = lf3_ ^ k1[55:48];    //  [1  1] 4  2  4  2  16 8  2  1 [2  2][4  4][1  1]d
assign x_[63:56]   = ef3_ + k1[63:56];    //  [1  1] 2  1  4  2  8  4  2  1 [1  1][2  2][1  1]_

assign x_[71:64]   = ef4_ + k1[71:64];    //   2  1  16 8 [1  1][2  2][1  1][4  4] 4  2  4  2 e
assign x_[79:72]   = lf4_ ^ k1[79:72];    //   2  1  8  4 [1  1][1  1][1  1][2  2] 4  2  2  1 _
assign x_[87:80]   = lf5_ ^ k1[87:80];    //   4  2  4  2 [4  4][1  1][2  2][1  1] 16 8  2  1 f
assign x_[95:88]   = ef5_ + k1[95:88];    //   2  1  4  2 [2  2][1  1][1  1][1  1] 8  4  2  1 _

assign x_[103:96]  = ef6_ + k1[103:96];   //   4  2 [2  2][1  1][4  4][1  1] 4  2  2  1  16 8 g
assign x_[111:104] = lf6_ ^ k1[111:104];  //   4  2 [1  1][1  1][2  2][1  1] 2  1  2  1  8  4 _
assign x_[119:112] = lf7_ ^ k1[119:112];  //   16 8 [1  1][2  2][1  1][4  4] 2  1  4  2  4  2 h
assign x_[127:120] = ef7_ + k1[127:120];  //   8  4 [1  1][1  1][1  1][2  2] 2  1  2  1  4  2 _

wire [7:0] a_11_   =  x_[7:0]            +  x_[15:8];    // 1, 3, 6
wire [7:0] a_22_   = {a_11_[6:0], 1'b0};                 // 5
wire [7:0] a_21_   = {x_[6:0], 1'b0}     +  x_[15:8];    // 0, 4
wire [7:0] a_42_   = {a_21_[6:0], 1'b0};                 // 7
wire [7:0] a_84_   = {a_21_[5:0], 2'b0};                 // 2

wire [7:0] b_11_   =  x_[23:16]          +  x_[31:24];   // 0, 2, 7
wire [7:0] b_22_   = {b_11_[6:0], 1'b0};                 // 3
wire [7:0] b_21_   = {x_[22:16], 1'b0}   +  x_[31:24];   // 3, 6
wire [7:0] b_42_   = {b_21_[6:0], 1'b0};                 // 1
wire [7:0] b_84_   = {b_21_[5:0], 2'b0};                 // 5

wire [7:0] c_11_   =  x_[39:32]          +  x_[47:40];   // 1, 5, 6
wire [7:0] c_22_   = {c_11_[6:0], 1'b0};                 // 3
wire [7:0] c_21_   = {x_[38:32], 1'b0}   +  x_[47:40];   // 2, 7
wire [7:0] c_42_   = {c_21_[6:0], 1'b0};                 // 0
wire [7:0] c_84_   = {c_21_[5:0], 2'b0};                 // 4

wire [7:0] d_11_   =  x_[55:48]          +  x_[63:56];   // 0, 4, 7
wire [7:0] d_22_   = {d_11_[6:0], 1'b0};                 // 2
wire [7:0] d_21_   = {x_[54:48], 1'b0}   +  x_[63:56];   // 1, 5
wire [7:0] d_42_   = {d_21_[6:0], 1'b0};                 // 6
wire [7:0] d_84_   = {d_21_[5:0], 2'b0};                 // 3

wire [7:0] e_11_   =  x_[71:64]          +  x_[79:72];   // 0, 2, 4
wire [7:0] e_22_   = {e_11_[6:0], 1'b0};                 // 6
wire [7:0] e_21_   = {x_[70:64], 1'b0}   +  x_[79:72];   // 3, 7
wire [7:0] e_42_   = {e_21_[6:0], 1'b0};                 // 5
wire [7:0] e_84_   = {e_21_[5:0], 2'b0};                 // 1

wire [7:0] f_11_   =  x_[87:80]          +  x_[95:88];   // 3, 5, 7
wire [7:0] f_22_   = {f_11_[6:0], 1'b0};                 // 1
wire [7:0] f_21_   = {x_[86:80], 1'b0}   +  x_[95:88];   // 0, 4
wire [7:0] f_42_   = {f_21_[6:0], 1'b0};                 // 2
wire [7:0] f_84_   = {f_21_[5:0], 2'b0};                 // 6

wire [7:0] g_11_   =  x_[103:96]         +  x_[111:104]; // 2, 4, 6
wire [7:0] g_22_   = {g_11_[6:0], 1'b0};                 // 0
wire [7:0] g_21_   = {x_[102:96], 1'b0}  +  x_[111:104]; // 1, 5
wire [7:0] g_42_   = {g_21_[6:0], 1'b0};                 // 3
wire [7:0] g_84_   = {g_21_[5:0], 2'b0};                 // 7

wire [7:0] h_11_   =  x_[119:112]        +  x_[127:120]; // 1, 3, 5
wire [7:0] h_22_   = {h_11_[6:0], 1'b0};                 // 7
wire [7:0] h_21_   = {x_[118:112], 1'b0} +  x_[127:120]; // 2, 6
wire [7:0] h_42_   = {h_21_[6:0], 1'b0};                 // 4
wire [7:0] h_84_   = {h_21_[5:0], 2'b0};                 // 0

reg [7:0] a_11 = 8'h0, a_22 = 8'h0, a_21 = 8'h0, a_42 = 8'h0, a_84 = 8'h0;
reg [7:0] b_11 = 8'h0, b_22 = 8'h0, b_21 = 8'h0, b_42 = 8'h0, b_84 = 8'h0;
reg [7:0] c_11 = 8'h0, c_22 = 8'h0, c_21 = 8'h0, c_42 = 8'h0, c_84 = 8'h0;
reg [7:0] d_11 = 8'h0, d_22 = 8'h0, d_21 = 8'h0, d_42 = 8'h0, d_84 = 8'h0;
reg [7:0] e_11 = 8'h0, e_22 = 8'h0, e_21 = 8'h0, e_42 = 8'h0, e_84 = 8'h0;
reg [7:0] f_11 = 8'h0, f_22 = 8'h0, f_21 = 8'h0, f_42 = 8'h0, f_84 = 8'h0;
reg [7:0] g_11 = 8'h0, g_22 = 8'h0, g_21 = 8'h0, g_42 = 8'h0, g_84 = 8'h0;
reg [7:0] h_11 = 8'h0, h_22 = 8'h0, h_21 = 8'h0, h_42 = 8'h0, h_84 = 8'h0;
always @(posedge clk) begin
   a_11 <= a_11_; a_22 <= a_22_; a_21 <= a_21_; a_42 <= a_42_; a_84 <= a_84_;
   b_11 <= b_11_; b_22 <= b_22_; b_21 <= b_21_; b_42 <= b_42_; b_84 <= b_84_;
   c_11 <= c_11_; c_22 <= c_22_; c_21 <= c_21_; c_42 <= c_42_; c_84 <= c_84_;
   d_11 <= d_11_; d_22 <= d_22_; d_21 <= d_21_; d_42 <= d_42_; d_84 <= d_84_;
   e_11 <= e_11_; e_22 <= e_22_; e_21 <= e_21_; e_42 <= e_42_; e_84 <= e_84_;
   f_11 <= f_11_; f_22 <= f_22_; f_21 <= f_21_; f_42 <= f_42_; f_84 <= f_84_;
   g_11 <= g_11_; g_22 <= g_22_; g_21 <= g_21_; g_42 <= g_42_; g_84 <= g_84_;
   h_11 <= h_11_; h_22 <= h_22_; h_21 <= h_21_; h_42 <= h_42_; h_84 <= h_84_;
end

wire [127:0] y_;
assign y_[7:0]     = a_21 + b_11 + c_42 + d_11;
assign y_[15:8]    = e_11 + f_21 + g_22 + h_84;
assign y_[23:16]   = a_11 + b_42 + g_21 + h_11;
assign y_[31:24]   = c_11 + d_21 + e_84 + f_22;
assign y_[39:32]   = e_11 + f_42 + g_11 + h_21;
assign y_[47:40]   = a_84 + b_11 + c_21 + d_22;
assign y_[55:48]   = e_21 + f_11 + g_42 + h_11;
assign y_[63:56]   = a_11 + b_21 + c_22 + d_84;
assign y_[71:64]   = e_11 + f_21 + g_11 + h_42;
assign y_[79:72]   = a_21 + b_22 + c_84 + d_11;
assign y_[87:80]   = c_11 + d_21 + e_42 + f_11;
assign y_[95:88]   = a_22 + b_84 + g_21 + h_11;
assign y_[103:96]  = a_11 + b_21 + c_11 + d_42;
assign y_[111:104] = e_22 + f_84 + g_11 + h_21;
assign y_[119:112] = a_42 + b_11 + c_21 + d_11;
assign y_[127:120] = e_21 + f_11 + g_84 + h_22;

assign y[7:0]      =  y_[7:0]            + {y_[14:8], 1'b0};
assign y[15:8]     =  y_[7:0]            +  y_[15:8];
assign y[23:16]    =  y_[23:16]          + {y_[30:24], 1'b0};
assign y[31:24]    =  y_[23:16]          +  y_[31:24];
assign y[39:32]    =  y_[39:32]          + {y_[46:40], 1'b0};
assign y[47:40]    =  y_[39:32]          +  y_[47:40];
assign y[55:48]    =  y_[55:48]          + {y_[62:56], 1'b0};
assign y[63:56]    =  y_[55:48]          +  y_[63:56];
assign y[71:64]    =  y_[71:64]          + {y_[78:72], 1'b0};
assign y[79:72]    =  y_[71:64]          +  y_[79:72];
assign y[87:80]    =  y_[87:80]          + {y_[94:88], 1'b0};
assign y[95:88]    =  y_[87:80]          +  y_[95:88];
assign y[103:96]   =  y_[103:96]         + {y_[110:104], 1'b0};
assign y[111:104]  =  y_[103:96]         +  y_[111:104];
assign y[119:112]  =  y_[119:112]        + {y_[126:120], 1'b0};
assign y[127:120]  =  y_[119:112]        +  y_[127:120];

endmodule

module safer(
   input clk,
   input [127:0] key,
   input [127:0] in,
   input modified,
   output reg [127:0] out = 128'h0
);

wire [127:0] lkey0, lkey1, lkey2, lkey3, lkey4, lkey5, lkey6, lkey7;
wire [127:0] lkey8, lkey9, lkeya, lkeyb, lkeyc, lkeyd, lkeye, lkeyf, lkeyg;

safer_ksa ksa(
   .clk(clk),
   .lk(key),
   .lkey0(lkey0),
   .lkey1(lkey1),
   .lkey2(lkey2),
   .lkey3(lkey3),
   .lkey4(lkey4),
   .lkey5(lkey5),
   .lkey6(lkey6),
   .lkey7(lkey7),
   .lkey8(lkey8),
   .lkey9(lkey9),
   .lkeya(lkeya),
   .lkeyb(lkeyb),
   .lkeyc(lkeyc),
   .lkeyd(lkeyd),
   .lkeye(lkeye),
   .lkeyf(lkeyf),
   .lkeyg(lkeyg)
);

wire [127:0] r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, out_;
safer_round r1(clk, in,  lkey0, lkey1, r1_out);
safer_round r2(clk, r1_out, lkey2, lkey3, r2_out);

//reg [127:0] in0_saved = 128'h0, in1_saved = 128'h0, in2_saved = 128'h0, in3_saved = 128'h0, in4_saved = 128'h0;
wire[127:0] in4_saved;

/*
always @(posedge clk) begin
   in0_saved <= in;
   in1_saved <= in0_saved;
   in2_saved <= in1_saved;
   in3_saved <= in2_saved;
   in4_saved <= in3_saved;
end   */



reg [4:0] wr_pntr = 5'h00, rd_pntr = 5'h00;


assign wr_pntr_wire = wr_pntr;
assign rd_pntr_wire =  rd_pntr;
 
always @(posedge clk ) 
begin
      rd_pntr <= wr_pntr + 4'hb;  //16-5=11    
end

always @(posedge clk) 
begin
      wr_pntr <= wr_pntr + 1'b1;      
end  


sr5_fifo_regfile128_reg_mem sr5_1(
       .addr1(wr_ptr),
       .addr0(rd_ptr),
       .din(in),
       .clk(clk),
       .en(1'b1),
       .dout(in4_saved)
     );


reg [4:0] modified_ = 5'h0;
reg [127:0] r2_out_ = 128'h0;
always @(posedge clk) begin
   r2_out_ <= r2_out;
   modified_ <= {modified_[3:0], modified};
end

wire [127:0] r2_out_mod;
assign r2_out_mod[7:0]     = in4_saved[7:0]     ^ r2_out_[7:0];
assign r2_out_mod[15:8]    = in4_saved[15:8]    + r2_out_[15:8];
assign r2_out_mod[23:16]   = in4_saved[23:16]   + r2_out_[23:16];
assign r2_out_mod[31:24]   = in4_saved[31:24]   ^ r2_out_[31:24];
assign r2_out_mod[39:32]   = in4_saved[39:32]   ^ r2_out_[39:32];
assign r2_out_mod[47:40]   = in4_saved[47:40]   + r2_out_[47:40];
assign r2_out_mod[55:48]   = in4_saved[55:48]   + r2_out_[55:48];
assign r2_out_mod[63:56]   = in4_saved[63:56]   ^ r2_out_[63:56];
assign r2_out_mod[71:64]   = in4_saved[71:64]   ^ r2_out_[71:64];
assign r2_out_mod[79:72]   = in4_saved[79:72]   + r2_out_[79:72];
assign r2_out_mod[87:80]   = in4_saved[87:80]   + r2_out_[87:80];
assign r2_out_mod[95:88]   = in4_saved[95:88]   ^ r2_out_[95:88];
assign r2_out_mod[103:96]  = in4_saved[103:96]  ^ r2_out_[103:96];
assign r2_out_mod[111:104] = in4_saved[111:104] + r2_out_[111:104];
assign r2_out_mod[119:112] = in4_saved[119:112] + r2_out_[119:112];
assign r2_out_mod[127:120] = in4_saved[127:120] ^ r2_out_[127:120];

safer_round r3(clk, modified_[4] ? r2_out_mod : r2_out_, lkey4, lkey5, r3_out);
safer_round r4(clk, r3_out,  lkey6, lkey7, r4_out);
safer_round r5(clk, r4_out,  lkey8, lkey9, r5_out);
safer_round r6(clk, r5_out,  lkeya, lkeyb, r6_out);
safer_round r7(clk, r6_out,  lkeyc, lkeyd, r7_out);
safer_round r8(clk, r7_out,  lkeye, lkeyf, r8_out);

assign out_[7:0]     = r8_out[7:0]     ^ lkeyg[7:0];
assign out_[15:8]    = r8_out[15:8]    + lkeyg[15:8];
assign out_[23:16]   = r8_out[23:16]   + lkeyg[23:16];
assign out_[31:24]   = r8_out[31:24]   ^ lkeyg[31:24];
assign out_[39:32]   = r8_out[39:32]   ^ lkeyg[39:32];
assign out_[47:40]   = r8_out[47:40]   + lkeyg[47:40];
assign out_[55:48]   = r8_out[55:48]   + lkeyg[55:48];
assign out_[63:56]   = r8_out[63:56]   ^ lkeyg[63:56];
assign out_[71:64]   = r8_out[71:64]   ^ lkeyg[71:64];
assign out_[79:72]   = r8_out[79:72]   + lkeyg[79:72];
assign out_[87:80]   = r8_out[87:80]   + lkeyg[87:80];
assign out_[95:88]   = r8_out[95:88]   ^ lkeyg[95:88];
assign out_[103:96]  = r8_out[103:96]  ^ lkeyg[103:96];
assign out_[111:104] = r8_out[111:104] + lkeyg[111:104];
assign out_[119:112] = r8_out[119:112] + lkeyg[119:112];
assign out_[127:120] = r8_out[127:120] ^ lkeyg[127:120];

always @(posedge clk)
   out <= out_;

endmodule

module bt_pin_gen(
   input clk,
   input rst,
   input en,
   input [63:0] start,
   input [63:0] stop,
   output reg [63:0] cur = 64'h0,
   output reg [3:0] pin_l = 4'h0,
   output reg done = 1'b0
);

reg [63:0] out = 64'h0;

always @(posedge clk) begin
   if(rst) begin
      out <= start;
      done <= 0;
   end else if(stop == out)
      done <= 1;
   else if(~done & en) begin
      if(out[3:0] == 10) begin
         out[3:0] <= 1;
         if(out[7:4] == 10) begin
            out[7:4] <= 1;
            if(out[11:8] == 10) begin
               out[11:8] <= 1;
               if(out[15:12] == 10) begin
                  out[15:12] <= 1;
                  if(out[19:16] == 10) begin
                     out[19:16] <= 1;
                     if(out[23:20] == 10) begin
                        out[23:20] <= 1;
                        if(out[27:24] == 10) begin
                           out[27:24] <= 1;
                           if(out[31:28] == 10) begin
                              out[31:28] <= 1;
                              if(out[35:32] == 10) begin
                                 out[35:32] <= 1;
                                 if(out[39:36] == 10) begin
                                    out[39:36] <= 1;
                                    if(out[43:40] == 10) begin
                                       out[43:40] <= 1;
                                       if(out[47:44] == 10) begin
                                          out[47:44] <= 1;
                                          if(out[51:48] == 10) begin
                                             out[51:48] <= 1;
                                             if(out[55:52] == 10) begin
                                                out[55:52] <= 1;
                                                if(out[59:56] == 10) begin
                                                   out[59:56] <= 1;
                                                   if(out[63:60] == 10) begin
                                                      out[63:60] <= 1;
                                                      done <= 1;
                                                   end else
                                                      out[63:60] <= out[63:60] + 4'h1;
                                                end else
                                                   out[59:56] <= out[59:56] + 4'h1;
                                             end else
                                                out[55:52] <= out[55:52] + 4'h1;
                                          end else
                                             out[51:48] <= out[51:48] + 4'h1;
                                       end else
                                          out[47:44] <= out[47:44] + 4'h1;
                                    end else
                                       out[43:40] <= out[43:40] + 4'h1;
                                 end else
                                    out[39:36] <= out[39:36] + 4'h1;
                              end else
                                 out[35:32] <= out[35:32] + 4'h1;
                           end else
                              out[31:28] <= out[31:28] + 4'h1;
                        end else
                           out[27:24] <= out[27:24] + 4'h1;
                     end else
                        out[23:20] <= out[23:20] + 4'h1;
                  end else
                     out[19:16] <= out[19:16] + 4'h1;
               end else
                  out[15:12] <= out[15:12] + 4'h1;
            end else
               out[11:8] <= out[11:8] + 4'h1;
         end else
            out[7:4] <= out[7:4] + 4'h1;
      end else
         out[3:0] <= out[3:0] + 4'h1;
   end
   
   cur   <= out;
   pin_l <= (|out[63:60]) ? 15 :
            (|out[59:56]) ? 14 :
            (|out[55:52]) ? 13 :
            (|out[51:48]) ? 12 :
            (|out[47:44]) ? 11 :
            (|out[43:40]) ? 10 :
            (|out[39:36]) ? 9  :
            (|out[35:32]) ? 8  :
            (|out[31:28]) ? 7  :
            (|out[27:24]) ? 6  :
            (|out[23:20]) ? 5  :
            (|out[19:16]) ? 4  :
            (|out[15:12]) ? 3  :
            (|out[11:8])  ? 2  :
            (|out[7:4])   ? 1  : 0;
end

endmodule

module bt_pin_expand(
   input [3:0] in,
   output [7:0] out
);

assign out = |in ? {4'h3, in + 4'hF} : 8'h0;

endmodule

module e22_comb_pin(
   input [127:0] pin,
   input [3:0] pin_l,
   input [47:0] bd_addr,
   output reg [127:0] expansion = 128'h0,
   output [4:0] pin_l_
);

assign pin_l_ = (pin_l > 8) ? 5'h10 : {1'b0, pin_l} + 5'h7;

always @(pin or pin_l or bd_addr) begin
   case(pin_l)
   0:  expansion <= {bd_addr[7:0], pin[7:0], bd_addr[47:0], pin[7:0],  bd_addr[47:0], pin[7:0]};
   1:  expansion <=                         {bd_addr[47:0], pin[15:0], bd_addr[47:0], pin[15:0]};
   2:  expansion <=                         {bd_addr[31:0], pin[23:0], bd_addr[47:0], pin[23:0]};
   3:  expansion <=                         {bd_addr[15:0], pin[31:0], bd_addr[47:0], pin[31:0]};
   4:  expansion <=                                        {pin[39:0], bd_addr[47:0], pin[39:0]};
   5:  expansion <=                                        {pin[31:0], bd_addr[47:0], pin[47:0]};
   6:  expansion <=                                        {pin[23:0], bd_addr[47:0], pin[55:0]};
   7:  expansion <=                                        {pin[15:0], bd_addr[47:0], pin[63:0]};
   8:  expansion <=                                         {pin[7:0], bd_addr[47:0], pin[71:0]};
   9:  expansion <=                                                   {bd_addr[47:0], pin[79:0]};
   10: expansion <=                                                   {bd_addr[39:0], pin[87:0]};
   11: expansion <=                                                   {bd_addr[31:0], pin[95:0]};
   12: expansion <=                                                   {bd_addr[23:0], pin[103:0]};
   13: expansion <=                                                   {bd_addr[15:0], pin[111:0]};
   14: expansion <=                                                    {bd_addr[7:0], pin[119:0]};
   15: expansion <=                                                                   pin[127:0];
   endcase
end

endmodule

module e21(
   input  [127:0] in,
   input  [127:0] comb_key,
   input  [47:0]  bd_addr,
   output [127:0] key,
   output [127:0] blk,
   output modified
);

wire [127:0] lk_rand = comb_key ^ in;
assign key = {lk_rand[127:120] ^ 8'h6, lk_rand[119:0]};
assign blk = {bd_addr[31:0], bd_addr[47:0], bd_addr[47:0]};
assign modified = 1'b1;

endmodule

module e1_offset_k(
   input  [127:0] in,
   output [127:0] out
);

assign out[7:0]     = in[7:0]     + 8'd233;
assign out[15:8]    = in[15:8]    ^ 8'd229;
assign out[23:16]   = in[23:16]   + 8'd223;
assign out[31:24]   = in[31:24]   ^ 8'd193;
assign out[39:32]   = in[39:32]   + 8'd179;
assign out[47:40]   = in[47:40]   ^ 8'd167;
assign out[55:48]   = in[55:48]   + 8'd149;
assign out[63:56]   = in[63:56]   ^ 8'd131;
assign out[71:64]   = in[71:64]   ^ 8'd233;
assign out[79:72]   = in[79:72]   + 8'd229;
assign out[87:80]   = in[87:80]   ^ 8'd223;
assign out[95:88]   = in[95:88]   + 8'd193;
assign out[103:96]  = in[103:96]  ^ 8'd179;
assign out[111:104] = in[111:104] + 8'd167;
assign out[119:112] = in[119:112] ^ 8'd149;
assign out[127:120] = in[127:120] + 8'd131;

endmodule

module e1_0(
   input [127:0] k,
   input [127:0] in,
   input [127:0] au_rand,
   input [47:0] bd_addr,
   output [127:0] key,
   output [127:0] blk,
   output modified
);

e1_offset_k e1_offset_k(
   .in(k),
   .out(key)
);
safer_ksa_bias safer_ksa_bias0(
   .in({8'h0, au_rand ^ in}),
   .bias({bd_addr[31:0], bd_addr[47:0], bd_addr[47:0]}),
   .out(blk)
);
assign modified = 1'b1;

endmodule

module bt_pin_crack(
   input  clk,
   input  rst,
   input  [63:0] start,
   input  [63:0] stop,
   input  [47:0] m_bd_addr,
   input  [47:0] s_bd_addr,
   input  [127:0] in_rand,
   input  [127:0] m_comb_key,
   input  [127:0] s_comb_key,
   input  [127:0] m_au_rand,
   input  [127:0] s_au_rand,
   input  [31:0] m_sres,
   input  [31:0] s_sres,
   output [63:0] cur,
   output reg found = 1'b0,
   output done
);

reg  [2:0] stage = 3'h0, stage_0 = 3'h0;

wire [127:0] safer_key, safer_in, safer_out;
wire modified;
safer safer(
   .clk(clk),
   .key(safer_key),
   .in(safer_in),
   .modified(modified),
   .out(safer_out)
);

reg [127:0] sout_0 = 128'h0;/*, sout_1 = 128'h0, sout_2 = 128'h0, sout_3 = 128'h0;
reg [127:0] sout_4 = 128'h0, sout_5 = 128'h0, sout_6 = 128'h0, sout_7 = 128'h0;
reg [127:0] sout_8 = 128'h0, sout_9 = 128'h0, sout_a = 128'h0, sout_b = 128'h0;
reg [127:0] sout_c = 128'h0, sout_d = 128'h0, sout_e = 128'h0, sout_f = 128'h0;
reg [127:0] sout_g = 128'h0, sout_h = 128'h0; */
wire [127:0] sout_h;

reg [4:0] wr_pntr = 5'h00, rd_pntr = 5'h00;

wire [4:0] wr_pntr_wire, rd_pntr_wire;


assign wr_pntr_wire = wr_pntr;
assign rd_pntr_wire =  rd_pntr;
 
always @(posedge clk ) 
begin
      rd_pntr <= wr_pntr + 4'he; //32-14=18    
end

always @(posedge clk) 
begin
      wr_pntr <= wr_pntr + 1'b1;      
end  


always @(posedge clk) begin
   if(stage != 4) begin
      if(stage < 3)
         sout_0 <= safer_out;
      else
         sout_0 <= safer_out ^ sout_h;
      /*sout_1 <= sout_0;
      sout_2 <= sout_1;
      sout_3 <= sout_2;
      sout_4 <= sout_3;
      sout_5 <= sout_4;
      sout_6 <= sout_5;
      sout_7 <= sout_6;
      sout_8 <= sout_7;
      sout_9 <= sout_8;
      sout_a <= sout_9;
      sout_b <= sout_a;
      sout_c <= sout_b;
      sout_d <= sout_c;
      sout_e <= sout_d;
      sout_f <= sout_e;
      sout_g <= sout_f;
      sout_h <= sout_g; */
   end
end 

wire sr_enable = (stage > 3);

sr18_fifo_regfile128_reg_mem sr18_1(
 .addr1(wr_pntr_wire),
 .addr0(rd_pntr_wire),
 .din(sout_0),
 .en(sr_enable),
 .clk(clk),
 .dout(sout_h));
 
 
wire [127:0] sout_last = sout_h;

/*reg [127:0] skey_0 = 128'h0, skey_1 = 128'h0, skey_2 = 128'h0, skey_3 = 128'h0;
reg [127:0] skey_4 = 128'h0, skey_5 = 128'h0, skey_6 = 128'h0, skey_7 = 128'h0;
reg [127:0] skey_8 = 128'h0, skey_9 = 128'h0, skey_a = 128'h0, skey_b = 128'h0;
reg [127:0] skey_c = 128'h0, skey_d = 128'h0, skey_e = 128'h0, skey_f = 128'h0;
reg [127:0] skey_g = 128'h0, skey_h = 128'h0;*/
wire[127:0] skey_h;


/*always @(posedge clk) begin
   skey_0 <= safer_key;
   skey_1 <= skey_0;
   skey_2 <= skey_1;
   skey_3 <= skey_2;
   skey_4 <= skey_3;
   skey_5 <= skey_4;
   skey_6 <= skey_5;
   skey_7 <= skey_6;
   skey_8 <= skey_7;
   skey_9 <= skey_8;
   skey_a <= skey_9;
   skey_b <= skey_a;
   skey_c <= skey_b;
   skey_d <= skey_c;
   skey_e <= skey_d;
   skey_f <= skey_e;
   skey_g <= skey_f;
   skey_h <= skey_g;
end */

/*
//instantiate 128 bit wide 18-bit shift register
sr18_regfile sr18_2(
	.din (safer_key),
	.en(1'b1),
	.clk(clk),
	//.rst(rst),
	.dout(skey_h));    
*/


sr18_fifo_regfile128_reg_mem sr18_2(
 .addr1(wr_pntr_wire),
 .addr0(rd_pntr_wire),
 .din(safer_key),
 .en(1'b1),
 .clk(clk),
 .dout(skey_h));

wire [127:0] skey_last = skey_h;


/*
 * stage 0, generate pins and feed them into e22
 */
wire [3:0] pin_l;
bt_pin_gen bt_pin_gen(
   .clk(clk),
   .rst(rst),
   .en(stage_0 == 0 & ~found),
   .start(start),
   .stop(stop),
   .cur(cur),
   .pin_l(pin_l),
   .done(done)
);

wire [127:0] try;
bt_pin_expand pinexp0(cur[3:0],   try[7:0]);
bt_pin_expand pinexp1(cur[7:4],   try[15:8]);
bt_pin_expand pinexp2(cur[11:8],  try[23:16]);
bt_pin_expand pinexp3(cur[15:12], try[31:24]);
bt_pin_expand pinexp4(cur[19:16], try[39:32]);
bt_pin_expand pinexp5(cur[23:20], try[47:40]);
bt_pin_expand pinexp6(cur[27:24], try[55:48]);
bt_pin_expand pinexp7(cur[31:28], try[63:56]);
bt_pin_expand pinexp8(cur[35:32], try[71:64]);
bt_pin_expand pinexp9(cur[39:36], try[79:72]);
bt_pin_expand pinexpa(cur[43:40], try[87:80]);
bt_pin_expand pinexpb(cur[47:44], try[95:88]);
bt_pin_expand pinexpc(cur[51:48], try[103:96]);
bt_pin_expand pinexpd(cur[55:52], try[111:104]);
bt_pin_expand pinexpe(cur[59:56], try[119:112]);
bt_pin_expand pinexpf(cur[63:60], try[127:120]);

wire [4:0] pin_l_;
wire [127:0] key_0, blk_0;
wire modified_0 = 1'b1;
e22_comb_pin e22_comb_pin(
   .pin(try),
   .pin_l(pin_l),
   .bd_addr(s_bd_addr),
   .expansion(key_0),
   .pin_l_(pin_l_)
);
assign blk_0 = {in_rand[127:125], in_rand[124:120] ^ pin_l_, in_rand[119:0]};


/*
 * stage 1, feedback output of pipeline back into safer to compute e21 for master
 */
wire [127:0] key_1, blk_1;
wire modified_1;
e21 e21(
   .in      (~stage[1] ? safer_out  : sout_last),
   .comb_key(~stage[1] ? m_comb_key : s_comb_key),
   .bd_addr (~stage[1] ? m_bd_addr  : s_bd_addr),
   .key(key_1),
   .blk(blk_1),
   .modified(modified_1)
);


/*
 * stage 2, we need to keep a pipeline of the previous 16 output values from kinit
 * to make sure we can reuse kinit on this stage
 */
wire [127:0] key_2, blk_2;
wire modified_2;

assign key_2 = key_1;
assign blk_2 = blk_1;
assign modified_2 = modified_1;


/*
 * stage 3, now we have to xor the output of stage 2 with stage 1
 * and feed the result into the Ar part of e1 to compute m_sres
 */
wire [127:0] key_3, blk_3;
wire modified_3 = 1'b0;

assign key_3 = safer_out ^ sout_last;
assign blk_3 = s_au_rand;


/*
 * stage 4, now we have to xor the output of safer with its input
 * and feed it back in for the second go with e1
 */
wire [127:0] key_4, blk_4;
wire modified_4;
e1_0 e1_0(
   .k(skey_last),
   .in(safer_out),
   .au_rand(~stage[1] ? s_au_rand : m_au_rand),
   .bd_addr(~stage[1] ? m_bd_addr : s_bd_addr),
   .key(key_4),
   .blk(blk_4),
   .modified(modified_4)
);


/*
 * stage 5, now compute e1 for slave
 */
wire [127:0] key_5, blk_5;
wire modified_5 = 1'b0;

assign key_5 = sout_last;
assign blk_5 = m_au_rand;


/*
 * stage 6, now compute finish computing e1 for slave
 */
wire [127:0] key_6 = key_4, blk_6 = blk_4;
wire modified_6 = modified_4;


/*
 * minimal state machine
 */
reg [4:0] count = 5'h0;
reg [15:0] found_0 = 16'h0;
always @(posedge clk) begin
   if(rst) begin
      stage_0 <= 3'h0;
      stage <= 3'h0;
      count <= 5'h0;
      found <= 1'b0;
      found_0 <= 16'h0;
   end else begin
      if(count[4] & count[0]) begin
         if(stage_0 == 6)
            stage_0 <= 0;
         else
            stage_0 <= stage_0 + 3'h1;
         count <= 5'h0;
      end else
         count <= count + 5'h1;

      case(stage)
      1: begin
            found_0 <= 16'h0;
      end
      5: begin
         if(safer_out[31:0] == m_sres)
            found_0[count[3:0]] <= 1;
      end
      0: if(safer_out[31:0] == s_sres & found_0[count[3:0]])
            found <= 1'b1;
      endcase
   end
   stage <= stage_0;
end


assign safer_key = (stage == 0) ? key_0 :
                   (stage == 1) ? key_1 :
                   (stage == 2) ? key_2 :
                   (stage == 3) ? key_3 :
                   (stage == 4) ? key_4 :
                   (stage == 5) ? key_5 :
                   (stage == 6) ? key_6 : 0;
assign safer_in  = (stage == 0) ? blk_0 :
                   (stage == 1) ? blk_1 :
                   (stage == 2) ? blk_2 :
                   (stage == 3) ? blk_3 :
                   (stage == 4) ? blk_4 :
                   (stage == 5) ? blk_5 :
                   (stage == 6) ? blk_6 : 0;
assign modified  = (stage == 0) ? modified_0 :
                   (stage == 1) ? modified_1 :
                   (stage == 2) ? modified_2 :
                   (stage == 3) ? modified_3 :
                   (stage == 4) ? modified_4 :
                   (stage == 5) ? modified_5 :
                   (stage == 6) ? modified_6 : 0;

endmodule

/*
 * 0-7   (0-3)   - start
 * 8-f   (4-7)   - stop
 * 10-17 (8-b)   - m_bd_addr
 * 18-1f (c-f)   - s_bd_addr
 * 20-2f (10-17) - in_rand
 * 30-3f (18-1f) - m_comb_key
 * 40-4f (20-27) - s_comb_key
 * 50-5f (28-2f) - m_au_rand
 * 60-6f (30-37) - s_au_rand
 * 70-73 (38-39) - m_sres
 * 74-77 (3a-3b) - s_sres
 * 78-7f (3c-3f) - cur
 * 80-83 (40-41) - found:done:rst
 */

module bt_pin_bridge #(
   parameter PIN_TOP24BITS = 24'h123400
) (
   input clk,
   input picoclk,
   input [31:0] addr,
   input [31:0] din,
   output [31:0] dout,
   input read,
   input write
);

reg rst = 1'b0;
reg [63:0] start = 64'h0;
reg [63:0] stop = 64'h0;
reg [47:0] m_bd_addr = 48'h0;
reg [47:0] s_bd_addr = 48'h0;
reg [127:0] in_rand = 128'h0;
reg [127:0] m_comb_key = 128'h0;
reg [127:0] s_comb_key = 128'h0;
reg [127:0] m_au_rand = 128'h0;
reg [127:0] s_au_rand = 128'h0;
reg [31:0] m_sres = 32'h0;
reg [31:0] s_sres = 32'h0;
wire [63:0] cur;
wire found;
wire done;

wire master_en    = addr[31:8] == PIN_TOP24BITS;
wire master_read  = master_en & read;
wire master_write = master_en & write;

always @(posedge picoclk) begin
   if(master_write) begin
      case(addr[7:2])
      6'h00: start[31:0]         <= din;
      6'h01: start[63:32]        <= din;
      6'h02: stop[31:0]          <= din;
      6'h03: stop[63:32]         <= din;
      6'h04: m_bd_addr[31:0]     <= din;
      6'h05: m_bd_addr[47:32]    <= din[15:0];
      6'h06: s_bd_addr[31:0]     <= din;
      6'h07: s_bd_addr[47:32]    <= din[15:0];
      6'h08: in_rand[31:0]       <= din;
      6'h09: in_rand[63:32]      <= din;
      6'h0A: in_rand[95:64]      <= din;
      6'h0B: in_rand[127:96]     <= din;
      6'h0C: m_comb_key[31:0]    <= din;
      6'h0D: m_comb_key[63:32]   <= din;
      6'h0E: m_comb_key[95:64]   <= din;
      6'h0F: m_comb_key[127:96]  <= din;
      6'h10: s_comb_key[31:0]    <= din;
      6'h11: s_comb_key[63:32]   <= din;
      6'h12: s_comb_key[95:64]   <= din;
      6'h13: s_comb_key[127:96]  <= din;
      6'h14: m_au_rand[31:0]     <= din;
      6'h15: m_au_rand[63:32]    <= din;
      6'h16: m_au_rand[95:64]    <= din;
      6'h17: m_au_rand[127:96]   <= din;
      6'h18: s_au_rand[31:0]     <= din;
      6'h19: s_au_rand[63:32]    <= din;
      6'h1A: s_au_rand[95:64]    <= din;
      6'h1B: s_au_rand[127:96]   <= din;
      6'h1C: m_sres              <= din;
      6'h1D: s_sres              <= din;
      6'h20: rst                 <= din[0];
      endcase
   end
end

bt_pin_crack bt_pin_crack(
   .clk(clk),
   .rst(rst),
   .start(start),
   .stop(stop),
   .m_bd_addr(m_bd_addr),
   .s_bd_addr(s_bd_addr),
   .in_rand(in_rand),
   .m_comb_key(m_comb_key),
   .s_comb_key(s_comb_key),
   .m_au_rand(m_au_rand),
   .s_au_rand(s_au_rand),
   .m_sres(m_sres),
   .s_sres(s_sres),
   .cur(cur),
   .found(found),
   .done(done)
);

assign dout = master_read ?
   (addr[7:2] == 6'h00) ? start[31:0] :
   (addr[7:2] == 6'h01) ? start[63:32] :
   (addr[7:2] == 6'h02) ? stop[31:0] :
   (addr[7:2] == 6'h03) ? stop[63:32] :
   (addr[7:2] == 6'h04) ? m_bd_addr[31:0] :
   (addr[7:2] == 6'h05) ? {16'h0, m_bd_addr[47:32]} :
   (addr[7:2] == 6'h06) ? s_bd_addr[31:0] :
   (addr[7:2] == 6'h07) ? {16'h0, s_bd_addr[47:32]} :
   (addr[7:2] == 6'h08) ? in_rand[31:0] :
   (addr[7:2] == 6'h09) ? in_rand[63:32] :
   (addr[7:2] == 6'h0a) ? in_rand[95:64] :
   (addr[7:2] == 6'h0b) ? in_rand[127:96] :
   (addr[7:2] == 6'h0c) ? m_comb_key[31:0] :
   (addr[7:2] == 6'h0d) ? m_comb_key[63:32] :
   (addr[7:2] == 6'h0e) ? m_comb_key[95:64] :
   (addr[7:2] == 6'h0f) ? m_comb_key[127:96] :
   (addr[7:2] == 6'h10) ? s_comb_key[31:0] :
   (addr[7:2] == 6'h11) ? s_comb_key[63:32] :
   (addr[7:2] == 6'h12) ? s_comb_key[95:64] :
   (addr[7:2] == 6'h13) ? s_comb_key[127:96] :
   (addr[7:2] == 6'h14) ? m_au_rand[31:0] :
   (addr[7:2] == 6'h15) ? m_au_rand[63:32] :
   (addr[7:2] == 6'h16) ? m_au_rand[95:64] :
   (addr[7:2] == 6'h17) ? m_au_rand[127:96] :
   (addr[7:2] == 6'h18) ? s_au_rand[31:0] :
   (addr[7:2] == 6'h19) ? s_au_rand[63:32] :
   (addr[7:2] == 6'h1a) ? s_au_rand[95:64] :
   (addr[7:2] == 6'h1b) ? s_au_rand[127:96] :
   (addr[7:2] == 6'h1c) ? m_sres[31:0] :
   (addr[7:2] == 6'h1d) ? s_sres[31:0] :
   (addr[7:2] == 6'h1e) ? cur[31:0] :
   (addr[7:2] == 6'h1f) ? cur[63:32] :
   (addr[7:2] == 6'h20) ? {29'h0, found, done, rst} :
   32'h0 : 32'h0;

endmodule

 