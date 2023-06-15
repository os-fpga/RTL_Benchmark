`timescale 1ns/10ps

/*
 User asked for RAM that fits in 2 m_dpram18k_r_rwe.
 Address bitness of port0 should be 10
 Structure of logical memory:
 (ram_R1024x18_RWE1024x18 | ram_R1024x18_RWE1024x18)


 Here are the selections made by user :
	1. Macro name - m2000_spram_1024x32_va
	2. Physical memory type - ramdp_18k
	3. Verilog file path - /home/users/byanik/m2k_open_cores/or1200/m2k_or1200_mem/sources/m2000_spram_1024x32_va.v
	4. VHDL file path - /home/users/byanik/m2k_open_cores/or1200/m2k_or1200_mem/sources/m2000_spram_1024x32_va.vhd
	5. Interface - Single ported
	6. Output log file path - /home/users/byanik/m2k_open_cores/or1200/m2k_or1200_mem/settings/m2000_spram_1024x32_va.log

 Port0 specifications:
	1. Type - Read/Write
	2. Port Width - 32
	3. Number of words - 1024
	4. Reset - no
	5. Enable - no
	6. Output registered - yes
	7. Write mode - writefirst

 Common parameters:
	1. Common clock:
		clock 0 - CLKM0, CLKR0  
	2. Inverted clock:
		CLKM0 - false
		CLKR0 - false


 Logical memory m2000_spram_1024x32_va

	Port    I/O     Bitness 

	addr     I        10
	din      I        32
	we       I         1
	clk      I         1
	dout     O        32
 */

 module m2000_spram_1024x32_va(
	addr,
	din,
	we,
	clk,
	dout);

 // input/output ports
 input [9:0]addr;
 input [31:0]din;
 input we;
 input clk;
 output [31:0]dout;

 // wires 
 wire rst_0_0;
 wire we_0;
 wire [17:0]fout_0_0;
 wire [17:0]fout_0_1;
 wire [3:0]fdout_0_0;
 wire [31:0]dout_0_0;

 // instantiation of m_dpram18k_r_rwe
 m_dpram18k_r_rwe ram_0_0(
	.ADDR0({11'b11111111111}),
	.ADDR1({addr[9:0],1'b0}),
	.DIN1({din[17:0]}),
	.CLKM0({1'b0}),
	.CLKM1({clk}),
	.CLKR0({1'b0}),
	.CLKR1({clk}),
	.WR1({we_0}),
	.RSTB0({1'b1}),
	.RSTB1({rst_0_0}),
	.BE1({18'b111111111111111111}),
	.ENB0({1'b1}),
	.ENB1({1'b0}),
	.DOUT0({fout_0_0[17:0]}),
	.DOUT1({dout_0_0[17:0]}));

 // parameters definition of ram_0_0
	defparam ram_0_0.PIPE1 = "ON";
	defparam ram_0_0.FORMAT = "R1024X18_RWE1024X18";
	defparam ram_0_0.MODE1 = "WRITE_FIRST";
	defparam ram_0_0.POLARITY_CLKM1 = "NEGEDGE";
	defparam ram_0_0.POLARITY_CLKR1 = "NEGEDGE";


 // instantiation of m_dpram18k_r_rwe
 m_dpram18k_r_rwe ram_0_1(
	.ADDR0({11'b11111111111}),
	.ADDR1({addr[9:0],1'b0}),
	.DIN1({4'b0000,din[31:18]}),
	.CLKM0({1'b0}),
	.CLKM1({clk}),
	.CLKR0({1'b0}),
	.CLKR1({clk}),
	.WR1({we_0}),
	.RSTB0({1'b1}),
	.RSTB1({rst_0_0}),
	.BE1({18'b111111111111111111}),
	.ENB0({1'b1}),
	.ENB1({1'b0}),
	.DOUT0({fout_0_1[17:0]}),
	.DOUT1({fdout_0_0[3:0],dout_0_0[31:18]}));

 // parameters definition of ram_0_1
	defparam ram_0_1.PIPE1 = "ON";
	defparam ram_0_1.FORMAT = "R1024X18_RWE1024X18";
	defparam ram_0_1.MODE1 = "WRITE_FIRST";
	defparam ram_0_1.POLARITY_CLKM1 = "NEGEDGE";
	defparam ram_0_1.POLARITY_CLKR1 = "NEGEDGE";

 assign rst_0_0 = 1'b1;
 assign we_0 = we;
 assign dout[0] = dout_0_0[0];
 assign dout[1] = dout_0_0[1];
 assign dout[2] = dout_0_0[2];
 assign dout[3] = dout_0_0[3];
 assign dout[4] = dout_0_0[4];
 assign dout[5] = dout_0_0[5];
 assign dout[6] = dout_0_0[6];
 assign dout[7] = dout_0_0[7];
 assign dout[8] = dout_0_0[8];
 assign dout[9] = dout_0_0[9];
 assign dout[10] = dout_0_0[10];
 assign dout[11] = dout_0_0[11];
 assign dout[12] = dout_0_0[12];
 assign dout[13] = dout_0_0[13];
 assign dout[14] = dout_0_0[14];
 assign dout[15] = dout_0_0[15];
 assign dout[16] = dout_0_0[16];
 assign dout[17] = dout_0_0[17];
 assign dout[18] = dout_0_0[18];
 assign dout[19] = dout_0_0[19];
 assign dout[20] = dout_0_0[20];
 assign dout[21] = dout_0_0[21];
 assign dout[22] = dout_0_0[22];
 assign dout[23] = dout_0_0[23];
 assign dout[24] = dout_0_0[24];
 assign dout[25] = dout_0_0[25];
 assign dout[26] = dout_0_0[26];
 assign dout[27] = dout_0_0[27];
 assign dout[28] = dout_0_0[28];
 assign dout[29] = dout_0_0[29];
 assign dout[30] = dout_0_0[30];
 assign dout[31] = dout_0_0[31];

endmodule