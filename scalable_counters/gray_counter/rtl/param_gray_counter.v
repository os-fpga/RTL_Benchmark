//-------------------------------------------------------
//  Functionality: An n-bit gray counter 
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`define size 10

module gray_counter
 
  (	input 	clk,
	input 	rstn,
	output reg [`size-1:0] out);
  
	reg [`size-1:0] q; 	 	
  
	always @ (posedge clk) begin
		if (rstn) begin
    	q <= 0;
    		out <= 0;
      end else begin
  		q <= q + 1;
        
			out <= {q[`size-1], q[`size-1:1] ^ q[`size-2:0]};
     end
 	end
endmodule
