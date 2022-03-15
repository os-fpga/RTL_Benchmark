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

module P_Reg(
		Clk,
		RST,
		bubble,
		stall,
		prev_stage,
		next_stage
    );

	parameter p_reg_w = 7;
	
	input Clk, RST, bubble, stall;
	input [0:p_reg_w] prev_stage;
	output [0:p_reg_w] next_stage;
	
	wire zero, Clk_RST;
	assign Clk_RST = Clk || RST;
	assign zero = RST || ~bubble;
	
	reg [0:p_reg_w] pipeline_register;

	
	always@(posedge Clk_RST) begin
	if (zero) begin
		pipeline_register <=0;
	end else begin
		if (~stall) pipeline_register <= prev_stage;
	end 
	end
	
	assign next_stage = pipeline_register;
endmodule
