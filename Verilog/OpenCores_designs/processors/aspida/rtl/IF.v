//////////////////////////////////////////////////////////////////////
////                                                              ////
////  IF.v  	                                                  ////
////                                                              ////
////  This file is part of the ASPIDA IP core project             ////
////  http://www.opencores.org/projects/aspida/                   ////
////		  and						  ////
////   http://www.ics.forth.gr/carv/aspida			  ////		
////                                                              ////
////  Author(s):                                                  ////
////      - Christos Sotiriou (sotiriou@ics.forth.gr)		  ////
////      - ASPIDA Consortium					  ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002-2003 Authors				  ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
module IF (NPC, PC, IR_latched, clk, reset, branch_sig, branch_address, IR, stall, counter);

// Input Ports

input 	     clk;							// clock
input 	     reset;							// reset pulse
// // synopsys async_set_reset "reset"
input 	     branch_sig;						// control signal: branch signal
input [31:0] branch_address;						// branch address
input [31:0] IR;							// instruction memory content			

input stall;
input [1:0] counter;

// Output Ports

output [31:0] NPC;							// program counter
output [31:0] PC;							// memory block to access
output [31:0] IR_latched;		

reg [31:0] NPC;
reg [31:0] PC; 
reg [31:0] IR_latched;							// i - 1
reg [31:0] IR_curr;							// i 

reg [31:0] IR_previous;

reg stalled;								// first cycle after stall //

always @(posedge clk or posedge reset)

//always @(posedge clk)
begin
	if (reset)
	begin
		NPC 		   <= 32'd0;
		PC		   <= 32'd0;
		IR_latched	   <= 32'd0;
		stalled		   <= 0;
	end
	else
 
	begin
		if(branch_sig == 1)
		begin		
			NPC <= branch_address;						// branch is taken
			IR_latched <= IR;
		end
		else if ((counter != 2'b00) || (stall == 1))
		begin
			NPC <= PC; //NPC - 4;							// revert 
			IR_latched  <= IR_previous;
			stalled <= 1;
		end
		else
		begin
			PC <= NPC;
			NPC <= NPC + 4;							// increment program counter
		
			if (stalled == 1)
				IR_latched <= IR_curr;
			else
				IR_latched <= IR;

			stalled <= 0;
	end
	end
end

always @(posedge clk or posedge reset)

//always @(posedge clk)
begin
	if (reset)
	begin
		IR_previous <= 32'd0;
		IR_curr <= 32'd0;
	end
	else
	begin
		if ((counter != 2'b00) || (stall == 1)) 
			begin
				IR_previous <= IR_previous;
				IR_curr <= IR_curr;
			end
		else 
			begin
				IR_previous <= IR_latched;
				IR_curr <= IR;
			end
	end
end

endmodule

