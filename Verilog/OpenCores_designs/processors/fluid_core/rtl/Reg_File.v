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
module Reg_File(
	input Clk,
	input RST,
	input [0:`reg_sel_w] reg_a,
	input [0:`reg_sel_w] reg_b,
	input [0:`reg_sel_w] wb_reg,
	input [0: `dpw] word,
	output [0:`dpw] op_a,
	output [0:`dpw] op_b,
	input write
    );

//------------Register Array---------------//
	reg [0:`dpw] registers[0:`reg_n];
	
	//Init for Testing
	initial begin
	registers[0] <= 0;
	registers[1] <= 0;
	registers[2] <= 0;
	registers[3] <= 0;
	registers[4] <= 0;
	registers[5] <= 0;
	registers[6] <= 0;
	registers[7] <= 0;
	end
	
	
	//Write Back Stage
	
	
	always@(posedge Clk) begin							//---The reg_a and word lines are ready before the edge, the rising edge of next cycle completes the write back---//
		if (write) begin//write
			registers[wb_reg] <= word;
		end
	end
	
	//ID stage - Read
	assign op_a = registers[reg_a];
	assign op_b = registers[reg_b];
	
endmodule
