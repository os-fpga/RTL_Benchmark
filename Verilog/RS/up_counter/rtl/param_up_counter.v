//-------------------------------------------------------
//  Functionality: An n-bit up counter 
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`ifndef TESTBENCH
`define size 5
`endif

module param_up_counter (clk_counter, q_counter, rst_counter);

    input clk_counter;
    input rst_counter;
    output [`size-1:0] q_counter;
    reg [`size-1:0] q_counter;

    always @ (posedge clk_counter)
    begin
        if(rst_counter)
		q_counter <= 'b00000000;
	else
		q_counter <= q_counter + 1;
    end

endmodule
