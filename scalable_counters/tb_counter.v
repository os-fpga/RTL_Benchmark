`timescale 1ns / 1ps
`define size 25
`include "param_counter.v"

module counter_tb;

	reg clk_counter, rst_counter;
	wire [`size-1:0] q_counter;

	param_counter C_1(
		clk_counter, 
		q_counter, 
		rst_counter);
always begin
		#10 clk_counter = ~clk_counter;
	end	


	initial begin
		#0 rst_counter = 1'b1; clk_counter = 1'b0;
		#100 rst_counter = 1'b0;
                #30000 $stop;
	end

	
	

endmodule
