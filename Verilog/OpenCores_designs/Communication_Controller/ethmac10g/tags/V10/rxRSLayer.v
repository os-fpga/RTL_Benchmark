`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    15:11:04 12/22/05
// Design Name:    
// Module Name:    rxRSLayer
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
module rxRSLayer(rxclk_2x, reset, link_fault, rxd64, rxc8, rxd, rxc);
    input rxclk_2x;
    input reset;     
	 input [31:0] rxd;
    input [3:0] rxc;
    output [1:0] link_fault;
    output [63:0] rxd64;
    output [7:0] rxc8;

	 wire  local_fault;
	 wire  remote_fault;
	 wire[1:0]  link_fault;

	 rxRSIO datapath(.rxclk_2x(rxclk_2x), 
	                 .reset(reset), 
						  .rxd(rxd), 
						  .rxc(rxc), 
						  .rxd64(rxd64), 
						  .rxc8(rxc8), 
						  .local_fault(local_fault), 
						  .remote_fault(remote_fault)
						  );
	 
	 rxLinkFaultState statemachine(.rxclk_2x(rxclk_2x),
	                               .reset(reset),
											 .local_fault(local_fault), 
											 .remote_fault(remote_fault), 
											 .link_fault(link_fault)
											 );

endmodule
