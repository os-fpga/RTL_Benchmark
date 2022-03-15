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

module MEM_Stage(
	input Clk,
	input RST,
	input [0:`EX_MEM_reg_w] EX_MEM_reg,
	output [0:`MEM_WB_reg_w] MEM_WB_reg,
	output [0:`memory_bus_w] ex_mem_addr,
	inout [0:`dpw] ex_mem_data,
	output mem_Clk,
	output mem_wr,
	output branch, linked,
	output return_back,
	output [0:`pc_w] branch_target
    );

	wire [0:`type_msb] Type;
	wire [0:`wb_dst_msb] WB_Dest;
	wire [0:`bc_msb] Rd_BC;
	wire [0:`dpw] E1, E0, M0;
	wire C,Z,S,O;
	
	assign Type = EX_MEM_reg[0:`type_msb];
	assign WB_Dest = EX_MEM_reg[`type_msb+1:`type_msb+1+`wb_dst_msb];
	assign Rd_BC = EX_MEM_reg[`type_msb+1+`wb_dst_msb+1:`type_msb+1+`wb_dst_msb+1+`bc_msb];
	assign E0 = EX_MEM_reg[`type_msb+1+`wb_dst_msb+1+`bc_msb+1:`type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw];
	assign E1 = EX_MEM_reg[`type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw+1:`type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw+1+`dpw];
	assign {C,Z,S,O} = E0[`dpw+1-4:`dpw];
	
	assign ex_mem_addr = E1;
	
	assign mem_wr = (Type==`type_store) ? 1: 0;	
	assign ex_mem_data = (Type==`type_store) ? E0 : 'bZ;
	assign M0 = (Type==`type_load) ? ex_mem_data : E1;
	
	assign mem_Clk = ((Type==`type_load) || (Type==`type_store)) ? ~Clk : 'bZ;
	
	
	//--branch logic--//
	reg bc, ret;
	always@(*) begin
	if (Type==`type_branch) begin
		case (Rd_BC[1:`bc_msb])
			`bLT: bc <= S^O;
			`bLE: bc <= Z + (S^O);
			`bNEG: bc <= S;
			`bPOS: bc <= ~S;
			`bEQ: bc <= Z;
			`bNEQ: bc <= ~Z;
			`bGE: bc <= ~(S^O);
			`bGT: bc <= ~(Z+(S^O));
			`bLTU: bc <= C;
			`bLEU: bc <= C + Z;
			`bGTU: bc <= ~(C+Z);
			`bGEU: bc <= ~C;
			`bOVF: bc <= O;
			`bNOVF: bc <= ~O;	
			`bALL: bc <= 1;
			`bRET: begin
					bc <= 1;
					ret <= 1;
					end
		endcase
	end else begin
		bc <= 0;
		ret <= 0;
	end
	end
	assign branch = (Type==`type_branch) & bc & ~ret;
	assign linked = Rd_BC[0];
	assign return_back = ret;
	assign branch_target = (Type==`type_branch) ? E1:'bZ;
	
	assign MEM_WB_reg = {Type,WB_Dest, Rd_BC[2:`bc_msb], M0};
	
endmodule
