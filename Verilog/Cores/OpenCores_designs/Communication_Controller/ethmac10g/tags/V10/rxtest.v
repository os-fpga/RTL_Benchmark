`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:18 12/26/2005
// Design Name:   rxReceiveEngine
// Module Name:   rxtest.v
// Project Name:  ethmac10g
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rxReceiveEngine
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rxtest_v;

	// Inputs
	reg rxclk_in;
	reg reset_in;
	reg [63:0] rxd64;
	reg [7:0] rxc8;
	reg [52:0] cfgRxRegData;
	reg [1:0] link_fault;

	// Outputs
	wire [12:0] rxStatRegPlus;
	wire [63:0] rx_data;
	wire [7:0] rx_data_valid;
	wire rx_good_frame;
	wire rx_bad_frame;
	wire [2:0] rxCfgofRS;
	wire [1:0] rxTxLinkFaul;
	wire reset_out;

	// Instantiate the Unit Under Test (UUT)
	rxReceiveEngine uut (
		.rxclk_in(rxclk_in), 
		.reset_in(reset_in),
		.reset_out(reset_out), 
		.rxd64(rxd64), 
		.rxc8(rxc8), 
		.rxStatRegPlus(rxStatRegPlus), 
		.cfgRxRegData(cfgRxRegData), 
		.rx_data(rx_data), 
		.rx_data_valid(rx_data_valid), 
		.rx_good_frame(rx_good_frame), 
		.link_fault(link_fault), 
		.rx_bad_frame(rx_bad_frame), 
		.rxCfgofRS(rxCfgofRS), 
		.rxTxLinkFaul(rxTxLinkFaul)
	);

	initial begin
		// Initialize Inputs
		rxclk_in = 0;
		rxd64 = 0;
		rxc8 = 0;
		cfgRxRegData = 0;
		cfgRxRegData[35] = 1'b1;//recv_enable
		cfgRxRegData[36] = 1'b1;//vlan enable
		cfgRxRegData[34] = 1'b0;//inband fcs
		cfgRxRegData[52:37] = 16'h00c0;
		cfgRxRegData[31:0]=32'h9fe22972;
		link_fault = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	wire [63:0]testvector1[15:0];  //normal frame
	wire [7:0] testvector2[15:0];
	
   wire [63:0]smallvector1[10:0]; //small frame
	wire [7:0] smallvector2[10:0];

	wire [63:0]taggedvector1[15:0];
	wire [7:0] taggedvector2[15:0];



	assign testvector1[0] = 64'h0707070707070707;
	assign testvector1[1] = 64'hfbaaaaaaaaaaaaab;
	assign testvector1[2] = 64'h00c09fe229720015;
	assign testvector1[3] = 64'h0024ac34004e9889; 
// assign testvector1[3] = 64'h0024ac3400639889; //length error frame
	assign testvector1[4] = 64'h1234567890123456;
	assign testvector1[5] = 64'h7890123456789012;
	assign testvector1[6] = 64'h3456789012345678;
	assign testvector1[7] = 64'h9012345678901234;
	assign testvector1[8] = 64'h5678901234567890;
	assign testvector1[9] = 64'h1234567890123456;
	assign testvector1[10] = 64'h7890123456789012;
	assign testvector1[11] = 64'h3456789012345678;
	assign testvector1[12] = 64'h9012345678901234;
	assign testvector1[13] = 64'h5678901234555555;
	assign testvector1[14] = 64'h55fd070707070707;
	assign testvector1[15] = 64'h0707070707070707;	 
	assign testvector2[0] = 8'hff;
	assign testvector2[1] = 8'h80;
	assign testvector2[2] = 8'h00;
	assign testvector2[3] = 8'h00;
	assign testvector2[4] = 8'h00;
	assign testvector2[5] = 8'h00;
	assign testvector2[6] = 8'h00;
	assign testvector2[7] = 8'h00;
	assign testvector2[8] = 8'h00;
	assign testvector2[9] = 8'h00;
	assign testvector2[10] = 8'h00;
	assign testvector2[11] = 8'h00;
	assign testvector2[12] = 8'h00;
	assign testvector2[13] = 8'h00;
	assign testvector2[14] = 8'h4f;
	assign testvector2[15] = 8'hff;

	assign smallvector1[0] = 64'h0707070707070707;
	assign smallvector1[1] = 64'hfbaaaaaaaaaaaaab;
	assign smallvector1[2] = 64'h00c09fe229720015;	
	assign smallvector1[3] = 64'h0024ac3400039889;
	assign smallvector1[4] = 64'h1234567890123456;
	assign smallvector1[5] = 64'h7890123456789012;
	assign smallvector1[6] = 64'h3456789012345678;
	assign smallvector1[7] = 64'h9012345678901234;
	assign smallvector1[8] = 64'h5678901234567890;
	assign smallvector1[9] = 64'h1234567855555555;
	assign smallvector1[10] = 64'hfd07070707070707;

   assign smallvector2[0] = 8'hff;
	assign smallvector2[1] = 8'h80;
	assign smallvector2[2] = 8'h00;
	assign smallvector2[3] = 8'h00;
	assign smallvector2[4] = 8'h00;
	assign smallvector2[5] = 8'h00;
	assign smallvector2[6] = 8'h00;
	assign smallvector2[7] = 8'h00;
	assign smallvector2[8] = 8'h00;
	assign smallvector2[9] = 8'h00;
	assign smallvector2[10] = 8'hff;
	
	assign taggedvector1[0] = 64'h0707070707070707;
	assign taggedvector1[1] = 64'hfbaaaaaaaaaaaaab;
	assign taggedvector1[2] = 64'h00c09fe229720015;
	assign taggedvector1[3] = 64'h0024ac348100004f; // assign taggedvector1[3] = 64'h0024ac3400639889; //length error frame
	assign taggedvector1[4] = 64'h004f123456789012;
	assign taggedvector1[5] = 64'h3456789012345678;
	assign taggedvector1[6] = 64'h9012345678901234;
	assign taggedvector1[7] = 64'h5678901234567890;
	assign taggedvector1[8] = 64'h1234567890123456;
	assign taggedvector1[9] = 64'h7890123456789012;
	assign taggedvector1[10] = 64'h7890123456789012;
	assign taggedvector1[11] = 64'h3456789012345678;
	assign taggedvector1[12] = 64'h9012345678901234;
	assign taggedvector1[13] = 64'h5678901234567890;
	assign taggedvector1[14] = 64'h1255555555fd0707;
	assign taggedvector1[15] = 64'h0707070707070707;	 
	assign taggedvector2[0] = 8'hff;
	assign taggedvector2[1] = 8'h80;
	assign taggedvector2[2] = 8'h00;
	assign taggedvector2[3] = 8'h00;
	assign taggedvector2[4] = 8'h00;
	assign taggedvector2[5] = 8'h00;
	assign taggedvector2[6] = 8'h00;
	assign taggedvector2[7] = 8'h00;
	assign taggedvector2[8] = 8'h00;
	assign taggedvector2[9] = 8'h00;
	assign taggedvector2[10] = 8'h00;
	assign taggedvector2[11] = 8'h00;
	assign taggedvector2[12] = 8'h00;
	assign taggedvector2[13] = 8'h00;
	assign taggedvector2[14] = 8'h07;
	assign taggedvector2[15] = 8'hff;

	initial begin
	  reset_in = 1;
	  #100
	  reset_in = 0;
	end

	always rxclk_in =#5 ~rxclk_in;

	reg [3:0]i;
	always@(posedge rxclk_in or posedge reset_out) begin
	      if (reset_out) begin
			   i <= 0;
				rxd64 <=0;
				rxc8 <=0;
   		end
			else begin
			   i <= i+1;
				rxd64 <=taggedvector1[i];
	      	rxc8 <=taggedvector2[i];
//				rxd64 <=testvector1[i];
//	      	rxc8 <=testvector2[i];
//				rxd64 <=smallvector1[i];
//	      	rxc8 <=smallvector2[i];
			end
	end

      
endmodule

