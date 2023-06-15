`timescale 1ns/10ps

/*
 User asked for RAM that fits in 1 m_dpram18k_rw_rw.
 Address bitness of port0 should be 8
 Address bitness of port1 should be 8.
 Structure of logical memory:
 (ram_RW1024x18_RW1024x18)


 Here are the selections made by user :
	1. Macro name - RAMB18_M2000
	2. Physical memory type - ramdp_18k
	3. Verilog file path - /home/users/lpillai/customer-designs/pico-computing/with_mem/mem_model/RAMB18_M2000.v
	4. VHDL file path - /home/users/lpillai/customer-designs/pico-computing/with_mem/mem_model/RAMB18_M2000.vhd
	5. Interface - Dual ported
	6. Output log file path - /home/users/lpillai/customer-designs/pico-computing/with_mem/mem_model/RAMB18_M2000.log

 Port0 specifications:
	1. Type - Read/Write
	2. Port Width - 8
	3. Number of words - 256
	4. Reset - yes
	5. Reset active high - yes
	6. Enable - yes
	7. Enable active high - yes
	8. Output registered - yes
	9. Write mode - readfirst

 Port1 specifications:
	1. Type - Read/Write
	2. Port Width - 8
	3. Number of words - 256
	4. Reset - yes
	5. Reset active high - yes
	6. Enable - yes
	7. Enable active high - yes
	8. Output registered - yes
	9. Write mode - readfirst

 Common parameters:
	1. Common reset - yes
	2. Common enable - yes
	3. Common clock:
		clock 0 - CLKM0, CLKM1, CLKR0, CLKR1  
	4. Inverted clock:
		CLKM0 - false
		CLKM1 - false
		CLKR0 - false
		CLKR1 - false


 Logical memory RAMB18_M2000

	Port    I/O     Bitness 

	addr0    I         8
	addr1    I         8
	din0     I         8
	din1     I         8
	en       I         1
	we0      I         1
	we1      I         1
	rst      I         1
	clk      I         1
	dout0    O         8
	dout1    O         8
 */

 module RAMB18_M2000(
	addr0,
	addr1,
	din0,
	din1,
	en,
	we0,
	we1,
	rst,
	clk,
	dout0,
	dout1);

 // input/output ports
 input [7:0]addr0;
 input [7:0]addr1;
 input [7:0]din0;
 input [7:0]din1;
 input en;
 input we0;
 input we1;
 input rst;
 input clk;
 output [7:0]dout0;
 output [7:0]dout1;

 // wires 
 wire rst_0_0;
 wire rst_0_1;
 wire we_0_0;
 wire we_0_1;
 wire [9:0]fdout_0_0;
 wire [9:0]fdout_0_1;
 wire [7:0]dout_0_0;
 wire [7:0]dout_0_1;

 // instantiation of m_dpram18k_rw_rw
 m_dpram18k_rw_rw ram_0_0(
	.ADDR0({2'b00,addr0[7:0],1'b0}),
	.ADDR1({2'b00,addr1[7:0],1'b0}),
	.DIN0({10'b0000000000,din0[7:0]}),
	.DIN1({10'b0000000000,din1[7:0]}),
	.CLKM0({clk}),
	.CLKM1({clk}),
	.CLKR0({clk}),
	.CLKR1({clk}),
	.WR0({we_0_0}),
	.WR1({we_0_1}),
	.RSTB0({rst_0_0}),
	.RSTB1({rst_0_1}),
	.ENB0({!en}),
	.ENB1({!en}),
	.DOUT0({fdout_0_0[9:0],dout_0_0[7:0]}),
	.DOUT1({fdout_0_1[9:0],dout_0_1[7:0]}));

 // parameters definition of ram_0_0
	defparam ram_0_0.PIPE1 = "ON";
	defparam ram_0_0.FORMAT = "RW1024X18_RW1024X18";
	defparam ram_0_0.MODE0 = "READ_FIRST";
	defparam ram_0_0.PIPE0 = "ON";
	defparam ram_0_0.POLARITY_CLKM0 = "NEGEDGE";
	defparam ram_0_0.MODE1 = "READ_FIRST";
	defparam ram_0_0.POLARITY_CLKM1 = "NEGEDGE";
	defparam ram_0_0.POLARITY_CLKR1 = "NEGEDGE";
	defparam ram_0_0.POLARITY_CLKR0 = "NEGEDGE";

 assign rst_0_0 = !rst;
 assign rst_0_1 = !rst;
 assign we_0_0 = we0;
 assign we_0_1 = we1;
 assign dout0[0] = dout_0_0[0];
 assign dout0[1] = dout_0_0[1];
 assign dout0[2] = dout_0_0[2];
 assign dout0[3] = dout_0_0[3];
 assign dout0[4] = dout_0_0[4];
 assign dout0[5] = dout_0_0[5];
 assign dout0[6] = dout_0_0[6];
 assign dout0[7] = dout_0_0[7];
 assign dout1[0] = dout_0_1[0];
 assign dout1[1] = dout_0_1[1];
 assign dout1[2] = dout_0_1[2];
 assign dout1[3] = dout_0_1[3];
 assign dout1[4] = dout_0_1[4];
 assign dout1[5] = dout_0_1[5];
 assign dout1[6] = dout_0_1[6];
 assign dout1[7] = dout_0_1[7];

endmodule