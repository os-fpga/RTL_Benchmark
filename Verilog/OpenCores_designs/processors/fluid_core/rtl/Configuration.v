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
/*----------NOTES---------------/
	1. All numerical values are counted from 0
	
*/
	
`ifndef dpw
//----Processor Interface------//
`define dpw 31				// -- Datapath Width -- //
`define inst_w 15			// -- Instruction Width -- //
`define pc_w 5				// -- Program Counter Width i.e. Instruction Memory Space -- //
`define memory_bus_w 3	// -- Memory Bus Width i.e. Data Memory Space -- //
`define intr_msb 3		// -- Interrupt Bus i.e. No. of Ext Interrupts to support -- //


`define reg_n 7			// -- Number of Registers -- //
`define reg_sel_w 2		// -- Register Address Width -- //

//------ISA Specifics----------//
`define uop_vector_msb 4
`define uop_msb 12			// -- Type|WB_Destination|ADM|Module_Sel|Operation -- [2|2|4|2|3] -- //
`define uop_n 25
`define type_msb 1
`define wb_dst_msb 1
`define mod_sel_msb 1
`define operation_msb 2
`define bc_msb 4




	//-----Pipeline Registers-----//
`define IF_ID_reg_w `inst_w
`define ID_EX_reg_w `type_msb+1+`wb_dst_msb+1+`mod_sel_msb+1+`operation_msb+1+`bc_msb+1+`dpw+`dpw+`dpw+2+6+3 //55 //Type + Mod_Sel + Operation + reg_sel_w + (dpw x 3) + (2 bit reg_src x 3) + (3 bit load_hazard_a/b/s)
`define EX_MEM_reg_w `type_msb+1+`wb_dst_msb+1+`bc_msb+1+`dpw+`dpw+1
`define MEM_WB_reg_w `type_msb+1+`wb_dst_msb+1+`reg_sel_w+1+`dpw

/********************************************************************************
//---------------------------------MicroOp Store-------------------------------//
********************************************************************************/

	//------Module Identifiers-------//
	`define int_ALU 2'b01
	`define barrel_Shifter 2'b10
	
	//------Empty Instructions----//
	`define none 2'b00
	`define op_none 3'b000

	//---ALU Operations---//
	`define ADD 	3'b001
	`define SUB 	3'b010
	`define ADC 	3'b011
	`define SBC 	3'b100
	`define AND 	3'b101
	`define OR 		3'b110
	`define XOR 	3'b111
	
	//---Branch Conditions---//
	`define bLT 4'd1
	`define bLE 4'd2
	
	`define bEQ 4'd3
	`define bZ 4'd3
	`define bNEQ 4'd4
	`define bNZ 4'd4
	
	`define bGE 4'd5
	`define bGT 4'd6
	
	`define bLTU 4'd7 
	`define bCRY 4'd7
	
	`define bLEU 4'd8
	
	`define bGEU 4'd9
	`define bNCRY 4'd9
	
	`define bGTU 4'd10
	`define bNEG 4'd11
	`define bPOS 4'd12
	
	`define bOVF 4'd13
	`define bNOVF 4'd14
	
	`define bALL 4'd0
	
	`define bRET 5'd15
	
	`define lnk 1'b1
	`define ulnk 1'b0
	
	//----Declarations for easing readability of Micro_Ops------//
	`define type_other 2'b00
	`define type_load 2'b01
	`define type_store 2'b10
	`define type_branch 2'b11 //never make this 00, conflict in reg_history

	//----S0,S1,S2,Imm---//
	`define RRR 4'b0111
	`define RRI 4'b0100
	`define RI  4'b0001
	`define sRR 4'b1100
	`define sRI 4'b1001

	//---- Write Back Destination ----//
	`define wb_rf 2'b00
	`define wb_uop 2'b01
	`define wb_int	2'b10
	`define wb_none 2'b11

	// ---- Constant Functions ---- //
	
`endif
