`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    11:53:07 12/27/05
// Design Name:    
// Module Name:    M8_1E
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
module M8_1E(E, S, D, O);
    input E;
    input [2:0] S;
    input [7:0] D;
    output O;

	 wire M01, M23, M45, M67; 
	 
	 M2_1E  m01(.E(E), .S0(S[0]), .D0(D[0]), .D1(D[1]), .O(M01));
	 M2_1E  m23(.E(E), .S0(S[0]), .D0(D[2]), .D1(D[3]), .O(M23));
	 M2_1E  m45(.E(E), .S0(S[0]), .D0(D[4]), .D1(D[5]), .O(M45));
	 M2_1E  m67(.E(E), .S0(S[0]), .D0(D[6]), .D1(D[7]), .O(M67));
	 
	 MUXF5_L m03(.LO(M03), .I0(M01), .I1(M23), .S(S[1]));
	 MUXF5_L m47(.LO(M47), .I0(M45), .I1(M67), .S(S[1]));
  	 MUXF6   m07(.O(O), .I0(M03), .I1(M47), .S(S[2]));


endmodule
