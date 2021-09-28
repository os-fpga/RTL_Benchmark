//-------------------------------------------------------
//  Functionality: An n-bit johnson counter 
//  Author:        Laraib Khan
//-------------------------------------------------------
`timescale 1ns / 1ps
`define size 298

module johnson_counter
  (  
	input clk,                
	input rstn,
  	output reg [`size-1:0] out
  );    
  integer i;
  always @ (posedge clk) begin
      if (!rstn)
         out <= 1;
      else begin
        out[`size-1] <= ~out[0];
        for ( i = 0; i < `size-1; i=i+1) begin
          out[i] <= out[i+1];
        end
      end
  end
endmodule
