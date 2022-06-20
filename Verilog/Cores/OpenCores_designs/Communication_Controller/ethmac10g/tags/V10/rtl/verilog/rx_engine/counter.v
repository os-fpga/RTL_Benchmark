`timescale 100ps / 10ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    15:53:19 11/22/05
// Design Name:    
// Module Name:    counter
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module counter(clk, reset, load, en, value);
    input clk;
    input reset;
    input load;
    input en;

	 parameter WIDTH = 8;
    output[WIDTH-1:0] value;

	 reg [WIDTH-1:0] value;
   
    always @(posedge clk or posedge reset)
       if (reset)	 
          value <= 0;
       else begin
		    if (load) 
             value <= 0;
          else if (en)
             value <= value + 1;
		 end
			 
endmodule
