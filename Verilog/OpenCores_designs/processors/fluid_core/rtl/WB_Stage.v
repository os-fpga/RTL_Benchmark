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

module WB_Stage(
	input Clk,
	input RST,
	input branch,
	input bubble_free,
	input [0:`MEM_WB_reg_w] MEM_WB_reg,
	output [0:`bc_msb] wb_dst,
	output [0:`dpw] wb_data,
	output write_rf, write_intr, write_uop
    );

	wire [0:`type_msb] Type;
	wire [0:`wb_dst_msb] WB_Dest;
	wire [0:`reg_sel_w] Rd;
	wire write;
	
	assign Type = MEM_WB_reg[0:`type_msb];
	assign WB_Dest = MEM_WB_reg[`type_msb+1:`type_msb+1+`wb_dst_msb];
	assign Rd = MEM_WB_reg[`type_msb+1+`wb_dst_msb+1:`type_msb+1+`wb_dst_msb+1+`reg_sel_w];
	
	assign wb_dst =  ((Clk) && ((Type==`type_other) || (Type==`type_load))) ? Rd : 'bZ;
	assign wb_data = ((Clk) && ((Type==`type_other) || (Type==`type_load))) ? MEM_WB_reg[`type_msb+1+`wb_dst_msb+1+`reg_sel_w+1:`type_msb+1+`wb_dst_msb+1+`reg_sel_w+1+`dpw]:'bZ;
	assign write = ((Type==`type_other) || (Type==`type_load)) && (branch || bubble_free);
	assign write_rf =  (WB_Dest==`wb_rf) && write;
	assign write_intr = (WB_Dest==`wb_int) && write;
	assign write_uop = (WB_Dest==`wb_uop) && write;
	
endmodule
