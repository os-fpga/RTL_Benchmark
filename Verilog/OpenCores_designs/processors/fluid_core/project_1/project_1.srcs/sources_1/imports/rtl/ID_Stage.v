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


module ID_Stage(
	input [0:`IF_ID_reg_w] IF_ID_reg,
	input Clk,
	input RST,
	output [0:`reg_sel_w] RF_a,
	output [0:`reg_sel_w] RF_b,
	input [0:`dpw] RF_op_a,
	input [0:`dpw] RF_op_b,
	output [0:`ID_EX_reg_w] ID_EX_reg,
	//---op forwarding pins---//
	//output [0:`type_msb] curr_type,
	input [0:1] reg_src_A, reg_src_B, st_src,
	input [0:2] load_hazard_abs,
	output rrr_adm, rri_adm, not_branch,
	output [0:`uop_vector_msb] uop_vector,
	input [0:`uop_msb] uop
    );
//-----------------------MicroOperation--------------------------//
//	wire [0:`uop_vector_msb] uop_vector;
//	wire [0:`uop_msb] uop;
	assign uop_vector = IF_ID_reg[0:`uop_vector_msb];
	
	

	wire [0:3] adm;
	wire [0:`type_msb] Type;
	wire [0:`wb_dst_msb] WB_Dest;
	wire [0:`mod_sel_msb] Mod_Sel;
	wire [0:`operation_msb] Operation;
	wire bS0, bS1, bS2, bImm;
	
		
	assign Type = uop[0:`type_msb]; 
	assign WB_Dest = uop[`type_msb+1:`type_msb+1+`wb_dst_msb];
	assign adm = uop[`type_msb+1+`wb_dst_msb+1:`type_msb+1+`wb_dst_msb+4];
	assign bS0 = uop[`type_msb+1+`wb_dst_msb+1];
	assign bS1 = uop[`type_msb+1+`wb_dst_msb+2];
	assign bS2 = uop[`type_msb+1+`wb_dst_msb+3];
	assign bImm = uop[`type_msb+1+`wb_dst_msb+4];
	assign Mod_Sel = uop[`type_msb+1+`wb_dst_msb+5:`type_msb+1+`wb_dst_msb+5+`mod_sel_msb];
	assign Operation = uop[`type_msb+1+`wb_dst_msb+5+`mod_sel_msb+1:`type_msb+1+`wb_dst_msb+5+`mod_sel_msb+1+`operation_msb];

//------------fetch operands------------------//
	wire [0:`inst_w-`uop_vector_msb-1] raw_operands;
	assign raw_operands = IF_ID_reg[`uop_vector_msb+1:`inst_w];
	
	wire [0:`dpw] S0, S1, S2, Imm;
	reg [0:`dpw] buff_op_a, buff_op_b;
	wire [0:`bc_msb] Rd_BC;
	
	assign Rd_BC = raw_operands[0:`bc_msb];
	
	
	//update RF_a in negative half of cycle -- no need for that wrong comment!
	assign RF_a = bS0 ? Rd_BC[1:`bc_msb] : bS2 ? raw_operands[`bc_msb+1+`reg_sel_w+1:`bc_msb+1+`reg_sel_w+1+`reg_sel_w]:0 ;
	assign S0 = bS0 ? buff_op_a : 0;
	
	assign RF_b = bS1 ? raw_operands[`bc_msb+1:`bc_msb+1+`reg_sel_w]:0;
	assign S1 = bS1 ? buff_op_b : 0;
	
	
	assign Imm = bImm ? raw_operands[`bc_msb+1:`inst_w-`uop_vector_msb-1]:raw_operands[`bc_msb+1+`reg_sel_w+1:`inst_w-`uop_vector_msb-1];
	assign S2 = bS2 ? buff_op_a : Imm;
	
	//latch on to reg file in the negative half
	always@(*) begin
		if (~Clk) begin
			buff_op_a <= RF_op_a;
			buff_op_b <= RF_op_b;
		end
	end
	
//----Operand Forwarding----//
	assign not_branch = (|(Type ^ `type_branch));
	assign rrr_adm = (adm == `RRR);//(~(|(adm ^ `RRR)));
	assign rri_adm = (adm == `RRI);
	
//-----next stage----//
	assign ID_EX_reg = {Type,WB_Dest,Mod_Sel,Operation,Rd_BC,S0,S1,S2,reg_src_A,reg_src_B,st_src,load_hazard_abs};//
endmodule
