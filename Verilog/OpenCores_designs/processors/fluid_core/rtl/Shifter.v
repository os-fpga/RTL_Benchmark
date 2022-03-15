//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2014-2015 Azmath Moosa                         ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 3 of the License, or (at your option) any     ////
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
`timescale 1ns / 1ps
`include "Configuration.v"
`define sh_left 3'b001
`define sh_right 3'b010

module Shifter(
	input [0:`mod_sel_msb] Module,
	input [0:`operation_msb] Operation,
	input [0:`dpw] OP1, OP2,
	output [0:`dpw] Result
    );

	reg [0:`dpw] Result_buff;
	wire en;
	assign en = (Module==`barrel_Shifter);
	
	always@(*) begin
		case(Operation) 
			`sh_left: Result_buff <= OP1<<OP2;
			`sh_right: Result_buff <= OP1>>OP2;
		endcase
	end
	
	assign Result = en ? Result_buff : 'bz;
	

endmodule
