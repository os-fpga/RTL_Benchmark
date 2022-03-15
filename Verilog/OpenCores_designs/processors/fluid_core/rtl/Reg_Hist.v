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
module Reg_Hist(
//	input Clk, RST,
	input [0:`reg_sel_w] ID_EX_reg, EX_MEM_reg,
	input [0:`reg_sel_w] nxt_reg_A, nxt_reg_B, st_reg, 
	output [0:1] reg_src_A, reg_src_B, st_src, 
	output [0:2] load_hazard_abs,
	output load_hazard, 
	input rrr_adm, rri_adm, ID_EX_load, fw_c_1, fw_c_2
	);

		
//	//pure combinational
	wire reg_src_a_1, reg_src_a_2, reg_src_b_1, reg_src_b_2;
	//store hazards
	wire st_src_1, st_src_2;
	
	//assign rrr_adm = (~(|(adm ^ `RRR)));
//	assign not_branch = (|(type ^ `type_branch));
//	assign not_ID_EX_branch = (|(ID_EX_type ^ `type_branch));
//	assign not_EX_MEM_branch = (|(EX_MEM_type ^ `type_branch));
	assign load_hazard = (reg_src_a_1 | reg_src_b_1 | st_src_1) & ID_EX_load;//~(|(ID_EX_type ^ `type_load));
	//WORK HERE  WORK HERE --- below --- below
	assign reg_src_a_1 =  (rrr_adm & fw_c_1 & (~(|(nxt_reg_A ^ ID_EX_reg))));//
	assign reg_src_a_2 =  (rrr_adm & fw_c_2 &  (~(|(nxt_reg_A ^ EX_MEM_reg))));//
	assign reg_src_b_1 = ((rrr_adm | rri_adm) & fw_c_1 & (~(|(nxt_reg_B ^ ID_EX_reg))));
	assign reg_src_b_2 = ((rrr_adm | rri_adm) & fw_c_2 & (~(|(nxt_reg_B ^ EX_MEM_reg))));
	assign st_src_1 = (fw_c_1 & (~(|(st_reg ^ ID_EX_reg))));
	assign st_src_2 = (fw_c_2 & (~(|(st_reg ^ EX_MEM_reg))));
	
	assign reg_src_A = {reg_src_a_1,reg_src_a_2};//load_hazard_abs[0] ? 2'b01 : 
	assign reg_src_B = {reg_src_b_1,reg_src_b_2};//load_hazard_abs[1] ? 2'b01 : 
	assign st_src = load_hazard_abs[2] ? 2'b01 : {st_src_1,st_src_2};
	assign load_hazard_abs = {load_hazard & reg_src_a_1,load_hazard & reg_src_b_1,load_hazard & st_src_1};
	
//	always@(Clk) begin
//	if (|(type ^ `type_branch)) begin
//		if ((|(ID_EX_type ^ `type_branch))&(~(|(nxt_reg_A ^ ID_EX_reg)))) reg_src_A <= 2'b01;
//		else if ((|(ID_EX_type ^ `type_branch))&(~(|(nxt_reg_A ^ EX_MEM_reg)))) reg_src_A <= 2'b10;
//		else reg_src_A <= 2'b00;
//		
//		if ((|(EX_MEM_type ^ `type_branch))&(~(|(nxt_reg_B ^ ID_EX_reg)))) reg_src_B <= 2'b01;
//		else if ((|(EX_MEM_type ^ `type_branch))&(~(|(nxt_reg_B ^ EX_MEM_reg)))) reg_src_B <= 2'b10;
//		else reg_src_B <= 2'b00;
//	end else begin
//		reg_src_A <= 2'b00;
//		reg_src_B <= 2'b00;
//	end
//	end


//	wire Clk_RST;
//	assign Clk_RST = Clk || RST;
//	reg stall_reg;
//	
//		initial begin
//			stall_reg <= 0;
//		end
//	always@(posedge Clk_RST) begin
//		if (RST) begin
//			bubble_reg <= 9'b111100000;
//		end else begin
//		  if (bubble) begin
//			bubble_reg <= 9'b111100000;
//		  end else begin
//			bubble_reg <= {1,bubble_reg[0:7]};
//		  end
//		  
//		  if (~stall_reg) begin
//			if (load_hazard) begin
//				stall_reg <= 1;
//			end else begin
//				stall_reg <= 0;
//			end
//		   end else begin
//				stall_reg <= 0;
//			end
//		end
//	
//	assign stall = stall_reg;
endmodule
