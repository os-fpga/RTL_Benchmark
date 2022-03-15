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

module FluidCore(
	input [0:`inst_w] exInstruction,
	input Clk,
	input RST,
	input [0:`intr_msb] Interrupt,
	output [0:`pc_w] exInstAddr,
	output [0:`memory_bus_w] exMemoryAddr,
	inout [0:`dpw] exMemoryData,
	output exMemoryClk,
	output exMemoryWrite
	);

	wire Return, linked;
	wire wb_write, write_intr, write_uop, intr, branch;
	wire [0:`pc_w] intr_vector;
	wire [0:`uop_vector_msb] uop_vector;
	wire [0:`uop_msb] uop;
	wire [0:4] bubble_lines;
	wire stall_IF_ID_EX, load_hazard;
	Staller Staller_inst(.Clk(Clk),.RST(RST),.bubble(branch|Return),.bubble_lines(bubble_lines),.load_hazard(load_hazard),.stall(stall_IF_ID_EX));
	
	wire [0:`IF_ID_reg_w] IF_ID_reg_in, IF_ID_reg_out;
	P_Reg #(`IF_ID_reg_w) IF_ID_reg(.Clk(Clk),.RST(RST),.stall(stall_IF_ID_EX),.bubble(bubble_lines[0]),.prev_stage(IF_ID_reg_in),.next_stage(IF_ID_reg_out));
	
	wire [0:`ID_EX_reg_w] ID_EX_reg_in, ID_EX_reg_out;
	P_Reg #(`ID_EX_reg_w) ID_EX_reg(.Clk(Clk),.RST(RST),.stall(stall_IF_ID_EX),.bubble(bubble_lines[1]),.prev_stage(ID_EX_reg_in),.next_stage(ID_EX_reg_out));
	
	wire [0:`EX_MEM_reg_w] EX_MEM_reg_in, EX_MEM_reg_out;
	P_Reg #(`EX_MEM_reg_w) EX_MEM_reg(.Clk(Clk),.RST(RST),.stall(stall_IF_ID_EX),.bubble(bubble_lines[2]),.prev_stage(EX_MEM_reg_in),.next_stage(EX_MEM_reg_out));
	
	wire [0:`MEM_WB_reg_w] MEM_WB_reg_in, MEM_WB_reg_out;
	P_Reg #(`MEM_WB_reg_w) MEM_WB_reg(.Clk(Clk),.RST(RST),.stall(0),.bubble(bubble_lines[3]),.prev_stage(MEM_WB_reg_in),.next_stage(MEM_WB_reg_out));
	
	
	wire [0:`dpw] op_reg_a, op_reg_b, wb_data;
	wire [0:`reg_sel_w] reg_a, reg_b;
	wire [0:`bc_msb] wb_dst;
	wire [0:`pc_w] branch_target;
	wire [0:3] stkFlag;
	
	//------Forwarding Logic-----------//
	wire s_EX_MEM_reg, s_ID_EX_reg, rrr_adm, rri_adm, not_ID_EX_branch, not_EX_MEM_branch, ID_EX_load, not_branch;
	wire [0:`reg_sel_w] d_EX_MEM_reg, d_ID_EX_reg;
	wire [0:`dpw] b_EX_MEM_reg, b_MEM_WB_reg;
	wire [0:1] reg_src_A, reg_src_B, st_src;
	wire [0:2] load_hazard_abs;
	wire [0:3] adm;
	wire [0:`type_msb] t_ID_EX_reg, t_EX_MEM_reg, t_IF_ID_reg;
	/*
		d prefixed wires carry previous stage destination registers, these are compared with current inst's dest reg
		if they match, current inst is associated with some bits to specify fwding from that stage
	*/
	assign s_EX_MEM_reg = bubble_lines[3]; //actual reg is populated a cycle after so sample it after a cycle hence 3 instead of 2
	assign s_ID_EX_reg = bubble_lines[2]; //same as above
	assign t_ID_EX_reg = ID_EX_reg_out[0:`type_msb];
	assign t_EX_MEM_reg = EX_MEM_reg_out[0:`type_msb];
	assign d_ID_EX_reg = ID_EX_reg_out[`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1:`type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb]; 
	assign d_EX_MEM_reg = EX_MEM_reg_out[`type_msb+1+`wb_dst_msb+1:`type_msb+1+`wb_dst_msb+1+`bc_msb];
	assign b_EX_MEM_reg = EX_MEM_reg_out[`type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw+1:`type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw+1+`dpw];
	assign b_MEM_WB_reg = MEM_WB_reg_out[`type_msb+1+`wb_dst_msb+1+`reg_sel_w+1:`type_msb+1+`wb_dst_msb+1+`reg_sel_w+1+`dpw];
	assign not_ID_EX_branch = ~(t_ID_EX_reg == `type_branch);//(|(t_ID_EX_reg ^ `type_branch));
	assign not_EX_MEM_branch = ~(t_EX_MEM_reg == `type_branch);// (|(t_EX_MEM_reg ^ `type_branch));
	assign ID_EX_load = (t_ID_EX_reg == `type_load);//~(|(t_ID_EX_reg ^ `type_load));
	assign fw_c_1 = s_ID_EX_reg & not_branch & not_ID_EX_branch;
	assign fw_c_2 = s_EX_MEM_reg & not_branch & not_EX_MEM_branch;
//--------Clock and Reset Behaviour--------//

//always@(posedge Clk or posedge RST) begin
//	if (RST) begin
//		
//		ID_EX_reg <= 0;
//		EX_MEM_reg <= 0;
//		MEM_WB_reg <= 0;
//	end
//	else begin
//		
//		ID_EX_reg <= ID_EX_reg_wire;
//		EX_MEM_reg <= EX_MEM_reg_wire;
//		MEM_WB_reg <= MEM_WB_reg_wire;
//	end
//end

//--------Sub Modules-------------------//	

//Instruction Fetch Stage
IF_Stage IF_Stage_inst (
.Clk(Clk),
.RST(RST),
.intr(intr),
.stkFlag(stkFlag),
.return_back(Return),
.linked(linked),
.intr_vector(intr_vector),
.exInstruction(exInstruction),
.exInstAddr(exInstAddr),
.IF_ID_reg(IF_ID_reg_in),
.branch_target(branch_target),
.branch(branch),
.stall(stall_IF_ID_EX)
);

//Register File
Reg_File Reg_File_inst (
.Clk(Clk),
.RST(RST),
.reg_a(reg_a),
.reg_b(reg_b),
.wb_reg(wb_dst),
.op_a(op_reg_a),
.op_b(op_reg_b),
.word(wb_data),
.write(wb_write)
);

//----Operand Forwarding----//
Reg_Hist Reg_Hist_inst (
//.Clk(Clk),
//.RST(RST),
//.s_ID_EX_reg(s_ID_EX_reg),
//.s_EX_MEM_reg(s_EX_MEM_reg),
.ID_EX_reg(d_ID_EX_reg),
.EX_MEM_reg(d_EX_MEM_reg),
//.ID_EX_type(t_ID_EX_reg),
.nxt_reg_A(IF_ID_reg_out[`uop_vector_msb+1+`bc_msb+1+`reg_sel_w+1:`uop_vector_msb+1+`bc_msb+1+`reg_sel_w+1+`reg_sel_w]),
.nxt_reg_B(IF_ID_reg_out[`uop_vector_msb+1+`bc_msb+1:`uop_vector_msb+1+`bc_msb+1+`reg_sel_w]),
.st_reg(IF_ID_reg_out[`uop_vector_msb+1+`bc_msb-`reg_sel_w:`uop_vector_msb+1+`bc_msb]),
//.type(t_IF_ID_reg),
.reg_src_A(reg_src_A),
.reg_src_B(reg_src_B),
.load_hazard(load_hazard),
.load_hazard_abs(load_hazard_abs),
.st_src(st_src),
.rrr_adm(rrr_adm),
.rri_adm(rri_adm),
//.not_ID_EX_branch(not_ID_EX_branch),
//.not_EX_MEM_branch(not_EX_MEM_branch),
.ID_EX_load(ID_EX_load),
//.not_branch(not_branch),
.fw_c_1(fw_c_1),
.fw_c_2(fw_c_2)
//.stall(stall_IF_ID_EX)
);	
//Instruction Decode Stage
ID_Stage ID_Stage_inst (
.Clk(Clk),
.RST(RST),
.IF_ID_reg(IF_ID_reg_out),
.RF_a(reg_a),
.RF_b(reg_b),
.RF_op_a(op_reg_a),
.RF_op_b(op_reg_b),
.ID_EX_reg(ID_EX_reg_in),
.reg_src_A(reg_src_A),
.reg_src_B(reg_src_B),
//.curr_type(t_IF_ID_reg),
.load_hazard_abs(load_hazard_abs),
.st_src(st_src),
.rrr_adm(rrr_adm),
.rri_adm(rri_adm),
.not_branch(not_branch),
.uop_vector(uop_vector),
.uop(uop)
);

//uOP Store
uOP_Store uOP_Store_inst(
		.Clk(Clk),
		.uop_vector(uop_vector),
		.uop(uop),
		.write(write_uop),
		.write_vector(wb_dst),
		.write_uop(wb_data)
	);

//Execute Stage
EX_Stage EX_Stage_inst (
.Clk(Clk),
.RST(RST),
.ret(Return),
.stkFlag(stkFlag),
.ID_EX_reg(ID_EX_reg_out),
.EX_MEM_reg(EX_MEM_reg_in),
.b_EX_MEM_reg(b_EX_MEM_reg),
.b_MEM_WB_reg(b_MEM_WB_reg)
);

//Memory Stage
MEM_Stage MEM_Stage_inst (
.Clk(Clk),
.RST(RST),
.linked(linked),
.EX_MEM_reg(EX_MEM_reg_out),
.MEM_WB_reg(MEM_WB_reg_in),
.ex_mem_addr(exMemoryAddr),
.ex_mem_data(exMemoryData),
.mem_Clk(exMemoryClk),
.mem_wr(exMemoryWrite),
.branch_target(branch_target),
.branch(branch),
.return_back(Return)
);

//Write Back Stage
WB_Stage WB_Stage_inst (
.Clk(Clk),
.RST(RST),
.MEM_WB_reg(MEM_WB_reg_out),
.wb_dst(wb_dst),
.wb_data(wb_data),
.write_rf(wb_write),
.write_intr(write_intr),
.write_uop(write_uop),
.branch(branch),
.bubble_free(bubble_lines[4])
);

//Interrupt Unit
interrupt_unit interrupt_unit_inst(
.Clk(Clk),
.return_back(Return),
.intr_req(Interrupt),
.intr_inx(wb_dst),
.intr(intr),
.vector(intr_vector),
.new_vector(wb_data),
.write(write_intr)
);

endmodule
