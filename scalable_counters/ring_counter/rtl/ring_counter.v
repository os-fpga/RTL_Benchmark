//-------------------------------------------------------
//  Functionality: An n-bit ring counter 
//  Author:        Laraib Khan
//-------------------------------------------------------

`timescale 1ns / 1ps
`define size 5
module ring_counter    
      (    
        input clk,                  
        input rst,  
        output reg [`size-1:0] out  
      );      
       
      integer i;
      always @ (posedge clk) begin  
          if (rst)  
             out <= 1;  
          else begin  
            out[`size-1] <= out[0];  
            for (i = 0; i < `size-1; i=i+1) begin  
              out[i] <= out[i+1];  
            end  
          end  
      end  
endmodule  
