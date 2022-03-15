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
module Staller(
	input Clk,
	input RST,
	input bubble,
	input load_hazard,
	output stall,
	output [0:4] bubble_lines
    );

	reg [0:8] bubble_reg;
	reg stall_reg;
	
		initial begin
			stall_reg <= 0;
		end
		
	wire Clk_RST;
	assign Clk_RST = Clk || RST;
	
	always@(posedge Clk_RST) begin
		if (RST) begin
			bubble_reg <= 9'b111100000;
		end else begin
		  if (bubble) begin
			bubble_reg <= 9'b111100000;
		  end else begin
			bubble_reg <= {1,bubble_reg[0:7]};
		  end
		  
		  if (~stall_reg) begin
			if (load_hazard) begin
				stall_reg <= 1;
			end else begin
				stall_reg <= 0;
			end
		   end else begin
				stall_reg <= 0;
			end
		end
	end
		

	
	assign bubble_lines = bubble_reg[4:8];
	assign stall = stall_reg;
endmodule
