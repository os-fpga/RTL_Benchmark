//-------------------------------------------------------
//  Functionality: An n-bit ripple counter 
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`define size 7

// Ripple Counter
module ripple_counter (q, clk, reset);

  output [`size-1:0] q;
  input clk, reset;

tff tff0(q[0], ~clk, reset);

genvar i;	
	// Generate for loop to instantiate N times
	generate 
		for (i = 1; i < `size; i = i + 1) begin
          tff tn (.q(q[i]),.clk(~q[i-1]),.reset(reset));
		end
	endgenerate

endmodule

// Toggle Flip-Flop
module tff (q, clk, reset);

  output q;
  input clk, reset;
  
  reg q;
  
  always @(posedge reset or posedge clk) begin
    if (reset) begin
      q <= 1'b0;
    end else begin
      q <= ~q;
    end
  end
endmodule