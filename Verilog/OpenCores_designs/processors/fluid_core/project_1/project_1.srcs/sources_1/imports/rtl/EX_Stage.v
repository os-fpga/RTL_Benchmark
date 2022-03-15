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

module EX_Stage(
	input Clk,
	input RST,
	inout [0:3] stkFlag,
	input ret,
	input [0:`ID_EX_reg_w] ID_EX_reg,
	output [0:`EX_MEM_reg_w] EX_MEM_reg,
	input [0:`dpw] b_EX_MEM_reg, b_MEM_WB_reg
	);

	reg [0:`dpw] bb_MEM_WB_reg;
	wire [0:`type_msb] Type;
	wire [0:`wb_dst_msb] WB_Dest;
	wire [0:`bc_msb] Rd_BC;
	wire [0:`operation_msb] Operation;
	wire [0:`mod_sel_msb] Module;
	wire [0:`dpw] OP1, OP2, OP3, E0, E1;
	wire [0:3] Flag, aluFlag;
	reg [0:3] prev_Flag;
	wire [0:1] reg_src_A, reg_src_B, st_src;
	wire [0:2] load_hazard_abs;
	
	assign Type = ID_EX_reg[0:`type_msb];
	assign WB_Dest = ID_EX_reg[`type_msb+1:`type_msb+1+`wb_dst_msb];
	
	assign Module = ID_EX_reg[`type_msb+1+`wb_dst_msb+1:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb];
	assign Operation = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb];
	
	assign Rd_BC = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb];
	
	assign OP1 = (reg_src_A[0] & load_hazard_abs[0]) | (reg_src_A[1] & ~load_hazard_abs[0]) ? b_MEM_WB_reg : (reg_src_A[0] & ~load_hazard_abs[0]) ? b_EX_MEM_reg : (reg_src_A[1] & load_hazard_abs[0]) ? bb_MEM_WB_reg : ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+`dpw+3:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+`dpw+3+`dpw];
	assign OP2 = (reg_src_B[0] & load_hazard_abs[1]) | (reg_src_B[1] & ~load_hazard_abs[1]) ? b_MEM_WB_reg : (reg_src_B[0] & ~load_hazard_abs[1]) ? b_EX_MEM_reg : (reg_src_B[1] & load_hazard_abs[1]) ? bb_MEM_WB_reg : ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+2:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+2+`dpw];

//	assign OP1 = reg_src_A[0] ? b_EX_MEM_reg : reg_src_A[1] ? load_hazard_abs[0] ? bb_MEM_WB_reg : b_MEM_WB_reg : ID_EX_reg[`type_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+`dpw+3:`type_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+`dpw+3+`dpw];
//	assign OP2 = reg_src_B[0] ? b_EX_MEM_reg : reg_src_B[1] ? load_hazard_abs[1] ? bb_MEM_WB_reg : b_MEM_WB_reg : ID_EX_reg[`type_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+2:`type_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+`dpw+2+`dpw];
	
	assign reg_src_A = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+3:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+4];
	assign reg_src_B = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+5:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+6];
	assign st_src = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+7:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+8];
	assign load_hazard_abs = ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+9:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+11];
	
	//----Sub Modules----//
	int_ALU int_ALU_inst(
		.Module(Module),
		.Operation(Operation),
		.OP1(OP1),
		.OP2(OP2),
		.Result(E1),
		.Flag(aluFlag),
		.prev_Flag(prev_Flag)
	);
	
	Shifter barrel_shifter_inst(
		.Module(Module),
		.Operation(Operation),
		.OP1(OP1),
		.OP2(OP2),
		.Result(E1)
	);
	assign Flag = ret ? stkFlag : aluFlag;
	assign stkFlag = ~ret ? Flag : 'bz;
	
	always@(posedge Clk) begin
		prev_Flag <= Flag;
		bb_MEM_WB_reg <= b_MEM_WB_reg; //store previous MEM_WB_reg coz we can't read it back from RF
	end
	
	assign E0 = (Type==`type_store) ? st_src[0] ? b_EX_MEM_reg : st_src[1] ? load_hazard_abs[2] ? bb_MEM_WB_reg : b_MEM_WB_reg : ID_EX_reg[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw] : (Type==`type_other) ? Flag : (Type==`type_branch) ? prev_Flag : 'bZ ;
	
	assign EX_MEM_reg = {Type,WB_Dest,Rd_BC,E0,E1};
endmodule
