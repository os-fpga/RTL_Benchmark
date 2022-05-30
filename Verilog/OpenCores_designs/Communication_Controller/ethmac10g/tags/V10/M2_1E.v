`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    11:54:49 12/27/05
// Design Name:    
// Module Name:    M2_1E
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
module M2_1E(E, S0, D0, D1, O);
    input E;
    input S0;
    input D0;
    input D1;
    output O;

	 wire M0,M1;
	 assign M0 = D0 & ~S0 & E;
	 assign M1 = D1 & S0 & E;
	 assign O = M0 | M1;


endmodule
