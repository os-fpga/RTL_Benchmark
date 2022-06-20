`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:54:17 11/21/05
// Design Name:    
// Module Name:    rxDAchecker
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



module rxDAchecker(local_invalid, broad_valid, multi_valid, MAC_Addr, da_addr);

    output local_invalid;
	 output broad_valid;
	 output multi_valid;

    input [47:0] MAC_Addr;
	 input [47:0] da_addr;

	 parameter Multicast = 48'h0180C2000001;
	 parameter Broadcast = 48'hffffffffffff; 

	 // check individual MAC address
	 wire broad_valid_1;

	 assign multi_valid   = (da_addr~^Multicast);
	 assign broad_valid_1 = (da_addr[7:0] ~^ Broadcast[7:0]);
	 assign broad_valid   = broad_valid_1 &(da_addr[47:8] ~^ Broadcast[47:8]);
	 assign local_invalid = da_addr^MAC_Addr;

endmodule
