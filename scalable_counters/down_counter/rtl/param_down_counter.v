//-------------------------------------------------------
//  Functionality: An n-bit down counter 
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`ifndef TESTBENCH
`define size 5
`endif

module param_down_counter (clk_counter, q_counter, rst_counter);

    input clk_counter;
    input rst_counter;
    output [`size-1:0] q_counter;
    reg [`size-1:0] q_counter ='b0;

    always @ (posedge clk_counter or posedge rst_counter)


    begin
        if(rst_counter)
		    q_counter <= ((2<<(`size-1))-1);
        else if (q_counter == 0)
            q_counter <= ((2<<(`size-1))-1);
	    else
		    q_counter <= q_counter - 1;
    end

endmodule
