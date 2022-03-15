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

module IF_Stage(
	input Clk,
	input RST,
	input stall,
	input intr,
	input return_back,
	input [0:`pc_w] intr_vector,
	input [0:`inst_w] exInstruction,
	input [0:`pc_w] branch_target,
	input branch, linked,
	inout [0:3] stkFlag,
	output [0:`pc_w] exInstAddr,
	output exInstClk,
	output [0:`IF_ID_reg_w] IF_ID_reg
    );


	reg [0:`pc_w] PC;
	reg [0:`inst_w] IR;
	reg [0:`pc_w+4] PCStack [0:3];
	reg [0:1] PCStackPtr;
	reg HLT;
	
initial begin
PC <= 0;
IR <=0;
PCStackPtr <= 0;
end

always@ (posedge Clk) begin
	if (RST) begin
		PC <=0;
		IR <= 0;
		PCStackPtr <= 0;
		HLT <= 0;
	end else if (~HLT) begin
	
		if (intr) begin
		PCStack[PCStackPtr] <= {PC,stkFlag};
		PCStackPtr <= PCStackPtr + 1;
		PC <= intr_vector;
		end else if (branch) begin
			if (linked) begin
			PCStack[PCStackPtr] <= {PC+1,stkFlag};
			PCStackPtr <= PCStackPtr + 1;
			end
		PC <= branch_target;
		end else if (return_back) begin
		PCStackPtr <= PCStackPtr - 1;
		PC <= PCStack[PCStackPtr-1][0:`pc_w];
		end else if (~stall) begin
		PC <= PC + 1;
		IR <= exInstruction;
		HLT <= &exInstruction[0:`uop_vector_msb];
		end
		
	end
end

assign stkFlag = return_back ? PCStack[PCStackPtr][`pc_w+1:`pc_w+4]:'bz;

assign exInstAddr = PC;
assign exInstClk = Clk;

assign IF_ID_reg = IR;

endmodule
