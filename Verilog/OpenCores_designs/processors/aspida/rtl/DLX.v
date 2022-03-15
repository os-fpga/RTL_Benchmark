//////////////////////////////////////////////////////////////////////
////                                                              ////
////  DLX.v							  ////
////                                                              ////
////  This file is part of the ASPIDA IP core project             ////
////  http://www.opencores.org/projects/aspida/                   ////
////		  and						  ////
///   http://www.ics.forth.gr/carv/aspida			  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Christos Sotiriou (sotiriou@ics.forth.gr)		  ////
////      - ASPIDA Consortium					  ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002-2003 Authors				  ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
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

//module DLX_sync (clk, DM_write_data, DM_addr, DM_write, DM_read, NPC, reset, IR, DM_read_data, byte, word, INT, CLI, PIPEEMPTY, FREEZE);
module DLX_sync (clk, DM_read_data, DM_write_data, DM_addr, DM_write, DM_read, NPC, reset, IR, byte, word, INT, CLI, PIPEEMPTY, FREEZE);


input reset;                                                    // system reset
// // synopsys async_set_reset "reset"

input clk;
wire [31:0] PC;
input [31:0] IR;

output [31:0] DM_addr;
output DM_write;
output DM_read;

//inout [31:0] DM_data;
input  [31:0] DM_read_data;
output [31:0] DM_write_data;
wire [31:0] DM_read_data;
//assign DM_read_data = DM_data;
wire [31:0] DM_write_data;
//assign DM_data = (DM_write)? DM_write_data:32'bz;

output [31:0] NPC;
//wire [31:0] NPC;

output byte;
output word;
//wire byte, word;

input INT;
output CLI;
output PIPEEMPTY;
//wire CLI,PIPEEMPTY;

input FREEZE;

wire [31:0] IR_latched;
wire branch_sig;
wire [31:0] branch_address;
wire stall;
wire [1:0] counter;

wire [31:0] Imm;
wire [4:0] rt_addr;
wire [4:0] rd_addr;
wire reg_dst;
wire reg_write;
wire mem_to_reg;
wire mem_write;
wire mem_read;
wire [5:0] IR_opcode_field;
wire [5:0] IR_function_field;
wire [31:0] reg_out_A;
wire [31:0] reg_out_B;
wire [31:0] ALU_result;
wire [4:0] reg_dst_EX;
wire mem_to_reg_EX;
wire mem_sign_ext;
wire reg_write_EX;


wire [31:0] RF_data_old;
//wire [31:0] ALU_result_MEM;
wire reg_write_MEM;
wire mem_to_reg_MEM;

wire [31:0] RF_data_in;

 IF IFinst (NPC, PC, IR_latched, clk, reset, branch_sig, branch_address, IR, stall, counter);
 
 ID IDinst (INT, CLI, PIPEEMPTY, FREEZE, branch_address, branch_sig, Imm, rt_addr, rd_addr, reg_dst, reg_write, mem_to_reg, mem_write, mem_read, IR_opcode_field, IR_function_field, stall, counter, clk, reset, NPC,/* PC,*/ IR_latched, reg_out_A, reg_out_B, reg_write_MEM, RF_data_in, RF_data_old);

 EX EXinst (DM_addr, DM_write_data, DM_write, DM_read, mem_to_reg_EX, reg_write_EX, clk, reset, IR_opcode_field, IR_function_field, reg_out_A, reg_out_B, Imm, reg_dst, reg_write, mem_to_reg, mem_read, mem_write, byte, word, counter, mem_sign_ext);

 MEM MEMinst (/*ALU_result_MEM,*/ reg_write_MEM, mem_to_reg_EX, clk, reset, DM_addr, reg_write_EX, mem_to_reg_MEM, DM_write_data, RF_data_old, DM_read_data, RF_data_in, byte, word, mem_sign_ext );

endmodule
