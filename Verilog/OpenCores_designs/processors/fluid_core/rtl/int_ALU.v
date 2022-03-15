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

module int_ALU(
	input [0:`mod_sel_msb] Module,
	input [0:`operation_msb] Operation,
	input [0:`dpw] OP1,
	input [0:`dpw] OP2,
	output [0:`dpw] Result,
	output [0:3] Flag,
	input [0:3] prev_Flag
    );

	wire en;
	assign en = (Module==`int_ALU);
	
	wire [0:`dpw] OP1_;
	assign OP1_ = (~OP1 + `dpw'b01);

	reg [0:`dpw] result_buff;
	reg C,Z,S,O;
	 //----[C|Z|S|O]------// 
	
	initial begin
		{C,Z,S,O} = {0,0,0,0};
		result_buff = 0;		
	end
	always@(*) begin
		
		if (en) begin
			case (Operation)
			`ADD: {C,result_buff} <= OP1 + OP2;
			`SUB: {C,result_buff} <= OP2 + OP1_;
			`ADC: {C,result_buff} <= OP1 + OP2 + prev_Flag[0];
			`SBC: {C,result_buff} <= OP2 + OP1_ + prev_Flag[0];
			`AND: result_buff <= OP1 & OP2;
			`OR: 	result_buff <= OP1 | OP2;
			`XOR: result_buff <= OP1 ^ OP2;
			endcase
				
			S <= result_buff[0];
			O <= OP1_[0]^OP2[0]^result_buff[0]^C;
			Z <= result_buff == 0;
			
		end		
	end
	
	assign Result = en ? result_buff : 'bz;
	assign Flag = {C,Z,S,O};
endmodule
