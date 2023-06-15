`timescale 1ns/10ps

/*
 User asked for Regfile that fits in 8 regfile576_func.
 Address bitness of port0 should be 5
 Address bitness of port1 should be 5.
 Structure of logical memory:
 (regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18 | regfile_W32x18_R32x18)


 Here are the selections made by user :
	1. Macro name - sr18_fifo_regfile128_reg_mem
	2. Physical memory type - regfile_576
	3. Verilog file path - /home/users/lpillai/junk/sr18_fifo_regfile128_reg_mem.v
	4. Interface - Dual ported
	5. Output log file path - /home/users/lpillai/junk/sr18_fifo_regfile128.log

 Port0 specifications:
	1. Port Width - 128
	2. Number of words - 32

 Port1 specifications:
	1. Port Width - 128
	2. Number of words - 32

 Common parameters:

	1. Bypass - no
	2. Inverted clock:
		CLKM1 - true


 Logical memory sr18_fifo_regfile128_reg_mem

	Port    I/O     Bitness 

	addr1    I         5
	addr0    I         5
	din      I       128
	en       I         1
	clk      I         1
	dout     O       128
 */

 module sr32_fifo_regfile54_reg_mem(
	addr1,
	addr0,
	din,
	en,
	clk,
	dout);

 // input/output ports
 input [4:0]addr1;
 input [4:0]addr0;
 input [54:0]din;
 input en;
 input clk;
 output [54:0]dout;

 // wires 
 wire en_0;
 wire [54:0]rout_0;
 wire [15:0]fdout_0_1;
 wire [54:0]dout_0_1;

 // instantiation of m_regfile576
 m_regfile576 regfile_0_0(
	.ADDR0({addr1[4:0]}),
	.ADDR1({addr0[4:0]}),
	.DIN0({din[17:0]}),
	.CLK0({clk}),
	.EN0({en_0}),
	.BPEN1({1'b1}),
	.DOUT1({dout_0_1[17:0]}));

 // parameters definition of regfile_0_0
	defparam regfile_0_0.POLARITY = "POSEDGE";


 // instantiation of m_regfile576
 m_regfile576 regfile_0_1(
	.ADDR0({addr1[4:0]}),
	.ADDR1({addr0[4:0]}),
	.DIN0({din[35:18]}),
	.CLK0({clk}),
	.EN0({en_0}),
	.BPEN1({1'b1}),
	.DOUT1({dout_0_1[35:18]}));

 // parameters definition of regfile_0_1
	defparam regfile_0_1.POLARITY = "POSEDGE";


 // instantiation of m_regfile576
 m_regfile576 regfile_0_2(
	.ADDR0({addr1[4:0]}),
	.ADDR1({addr0[4:0]}),
	.DIN0({din[53:36]}),
	.CLK0({clk}),
	.EN0({en_0}),
	.BPEN1({1'b1}),
	.DOUT1({dout_0_1[53:36]}));

 // parameters definition of regfile_0_2
	defparam regfile_0_2.POLARITY = "POSEDGE";




 assign en_0 = en;
 assign rout_0[0] = dout_0_1[0];
 assign rout_0[1] = dout_0_1[1];
 assign rout_0[2] = dout_0_1[2];
 assign rout_0[3] = dout_0_1[3];
 assign rout_0[4] = dout_0_1[4];
 assign rout_0[5] = dout_0_1[5];
 assign rout_0[6] = dout_0_1[6];
 assign rout_0[7] = dout_0_1[7];
 assign rout_0[8] = dout_0_1[8];
 assign rout_0[9] = dout_0_1[9];
 assign rout_0[10] = dout_0_1[10];
 assign rout_0[11] = dout_0_1[11];
 assign rout_0[12] = dout_0_1[12];
 assign rout_0[13] = dout_0_1[13];
 assign rout_0[14] = dout_0_1[14];
 assign rout_0[15] = dout_0_1[15];
 assign rout_0[16] = dout_0_1[16];
 assign rout_0[17] = dout_0_1[17];
 assign rout_0[18] = dout_0_1[18];
 assign rout_0[19] = dout_0_1[19];
 assign rout_0[20] = dout_0_1[20];
 assign rout_0[21] = dout_0_1[21];
 assign rout_0[22] = dout_0_1[22];
 assign rout_0[23] = dout_0_1[23];
 assign rout_0[24] = dout_0_1[24];
 assign rout_0[25] = dout_0_1[25];
 assign rout_0[26] = dout_0_1[26];
 assign rout_0[27] = dout_0_1[27];
 assign rout_0[28] = dout_0_1[28];
 assign rout_0[29] = dout_0_1[29];
 assign rout_0[30] = dout_0_1[30];
 assign rout_0[31] = dout_0_1[31];
 assign rout_0[32] = dout_0_1[32];
 assign rout_0[33] = dout_0_1[33];
 assign rout_0[34] = dout_0_1[34];
 assign rout_0[35] = dout_0_1[35];
 assign rout_0[36] = dout_0_1[36];
 assign rout_0[37] = dout_0_1[37];
 assign rout_0[38] = dout_0_1[38];
 assign rout_0[39] = dout_0_1[39];
 assign rout_0[40] = dout_0_1[40];
 assign rout_0[41] = dout_0_1[41];
 assign rout_0[42] = dout_0_1[42];
 assign rout_0[43] = dout_0_1[43];
 assign rout_0[44] = dout_0_1[44];
 assign rout_0[45] = dout_0_1[45];
 assign rout_0[46] = dout_0_1[46];
 assign rout_0[47] = dout_0_1[47];
 assign rout_0[48] = dout_0_1[48];
 assign rout_0[49] = dout_0_1[49];
 assign rout_0[50] = dout_0_1[50];
 assign rout_0[51] = dout_0_1[51];
 assign rout_0[52] = dout_0_1[52];
 assign rout_0[53] = dout_0_1[53];
 assign rout_0[54] = dout_0_1[54];



 assign dout[0] = rout_0[0];
 assign dout[1] = rout_0[1];
 assign dout[2] = rout_0[2];
 assign dout[3] = rout_0[3];
 assign dout[4] = rout_0[4];
 assign dout[5] = rout_0[5];
 assign dout[6] = rout_0[6];
 assign dout[7] = rout_0[7];
 assign dout[8] = rout_0[8];
 assign dout[9] = rout_0[9];
 assign dout[10] = rout_0[10];
 assign dout[11] = rout_0[11];
 assign dout[12] = rout_0[12];
 assign dout[13] = rout_0[13];
 assign dout[14] = rout_0[14];
 assign dout[15] = rout_0[15];
 assign dout[16] = rout_0[16];
 assign dout[17] = rout_0[17];
 assign dout[18] = rout_0[18];
 assign dout[19] = rout_0[19];
 assign dout[20] = rout_0[20];
 assign dout[21] = rout_0[21];
 assign dout[22] = rout_0[22];
 assign dout[23] = rout_0[23];
 assign dout[24] = rout_0[24];
 assign dout[25] = rout_0[25];
 assign dout[26] = rout_0[26];
 assign dout[27] = rout_0[27];
 assign dout[28] = rout_0[28];
 assign dout[29] = rout_0[29];
 assign dout[30] = rout_0[30];
 assign dout[31] = rout_0[31];
 assign dout[32] = rout_0[32];
 assign dout[33] = rout_0[33];
 assign dout[34] = rout_0[34];
 assign dout[35] = rout_0[35];
 assign dout[36] = rout_0[36];
 assign dout[37] = rout_0[37];
 assign dout[38] = rout_0[38];
 assign dout[39] = rout_0[39];
 assign dout[40] = rout_0[40];
 assign dout[41] = rout_0[41];
 assign dout[42] = rout_0[42];
 assign dout[43] = rout_0[43];
 assign dout[44] = rout_0[44];
 assign dout[45] = rout_0[45];
 assign dout[46] = rout_0[46];
 assign dout[47] = rout_0[47];
 assign dout[48] = rout_0[48];
 assign dout[49] = rout_0[49];
 assign dout[50] = rout_0[50];
 assign dout[51] = rout_0[51];
 assign dout[52] = rout_0[52];
 assign dout[53] = rout_0[53];


endmodule