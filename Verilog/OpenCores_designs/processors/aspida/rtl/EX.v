//////////////////////////////////////////////////////////////////////
////                                                              ////
////  EX.v	                                                  ////
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

// function fields of R-Type instructions
`define   ADD 	6'b100000
`define   ADDU 	6'b100001
`define   SUB 	6'b100010
`define   SUBU 	6'b100011
`define   AND 	6'b100100
`define    OR 	6'b100101
`define   XOR	6'b100110
`define   SLL	6'b000100
`define   SRL	6'b000110
`define   SRA	6'b000111
`define   SEQ   6'b101000
`define   SNE   6'b101001
`define   SLT   6'b101010
`define   SGT   6'b101011
`define   SLE   6'b101100
`define   SGE   6'b101101
`define   MOVS2I 6'b110001

// opcode fields of I-Type instructions
`define    LW 	6'b100011
`define    SW 	6'b101011

`define    LB   6'b100000
`define    LH   6'b100001
`define   LBU   6'b100100
`define   LHU   6'b100101
`define    SB   6'b101000
`define    SH   6'b101001

`define   LHI   6'b001111

`define  ADDI 	6'b001000
`define  ADDUI 	6'b001001
`define  SUBI 	6'b001010
`define  SUBUI 	6'b001011
`define  ANDI 	6'b001100
`define   ORI 	6'b001101
`define  XORI 	6'b001110
`define  SRLI 	6'b010110
`define  SLLI 	6'b010100
`define  SRAI 	6'b010111
`define  BEQZ 	6'b000100
`define  BNEZ 	6'b000101
`define  SEQI   6'b011000
`define  SNEI   6'b011001
`define  SLTI   6'b011010
`define  SGTI   6'b011011
`define  SLEI   6'b011100
`define  SGEI   6'b011101

// opcode fields of J-Type instructions
`define     J 	6'b000010
`define   JAL 	6'b000011

`define    JR 	6'b010010
`define  JALR 	6'b010011

// R-Type instructions
`define  R_TYPE 6'b000000

`define  TRAP   6'b010001
`define  RFE    6'b010000

module EX (ALU_result, reg_out_B_EX, mem_write_EX, mem_read_EX, mem_to_reg_EX, reg_write_EX, clk, reset, IR_opcode_field, IR_function_field, reg_out_A, reg_out_B, Imm, reg_dst, reg_write, mem_to_reg, mem_read, mem_write, byte, word, counter, mem_sign_ext);

// Input Ports
input [1:0] counter;
input 	        clk;							// clock pulse
input	      reset;							// reset pulse
// // synopsys async_set_reset "reset"
input [31:0] reg_out_A;
input [31:0] reg_out_B;
input [31:0] Imm;
// inputs that are control signals

input reg_dst;
input [5:0] IR_opcode_field;
input [5:0] IR_function_field;

// inputs that are control signals (not used at this stage)

input 	reg_write;
input	mem_to_reg;
input	mem_read;
input	mem_write;

// Output Ports

output [31:0] ALU_result;
output [31:0] reg_out_B_EX;

// outputs that are control signals (not used at this stage)

output 	 reg_write_EX;
output	 mem_to_reg_EX;
output	 mem_read_EX;
output	 mem_write_EX;

// output signals for stalling

//output [5:0] opcode_of_EX_reg;

//reg [5:0] opcode_of_EX_reg;

reg [31:0] ALU_result;
reg [31:0] reg_out_B_EX;

reg reg_write_EX;
reg mem_to_reg_EX;
reg mem_read_EX;
reg mem_write_EX;

output byte;
output word;
output mem_sign_ext;

reg byte;
reg word;
reg mem_sign_ext;

always @(posedge clk or posedge reset)

//always @(posedge clk)
begin
	if (reset)
	begin
		ALU_result  <= 32'd0;
		reg_out_B_EX   <= 32'd0;

		reg_write_EX   <=  1'd0;
		mem_to_reg_EX	<=  1'd0;
		mem_sign_ext <= 1'd0;
		mem_read_EX	<=  1'd0;
		mem_write_EX	<=  1'd0;
		byte <= 0;
		word <= 0;
//		opcode_of_EX_reg <= 6'b0;
	end		
	else 
	begin	

	if (counter!=0)
	begin
		ALU_result  <= 32'd0;
		reg_out_B_EX   <= 32'd0;

		reg_write_EX   <=  1'd0;
		mem_to_reg_EX <=  1'd0;
		mem_sign_ext <= 1'd0;
		mem_read_EX <=  1'd0;
		mem_write_EX <=  1'd0;

	end
	else
	begin
		byte <= 0;
		word <= 0;
	
		if(IR_opcode_field == 0)					// R-Type format instructions or NOP
		
		begin

		case(IR_function_field)
		
			`ADD  :  ALU_result <= reg_out_A + reg_out_B;	

			`ADDU  :  ALU_result <= reg_out_A + reg_out_B;

			`SUB  :  ALU_result <= reg_out_A - reg_out_B;
	
			`SUBU  :  ALU_result <= reg_out_A - reg_out_B;
	
			`AND  :	 ALU_result <= reg_out_A & reg_out_B;

			`OR   :  ALU_result <= reg_out_A | reg_out_B;

			`XOR  :  ALU_result <= reg_out_A ^ reg_out_B;

			`SLL  :  ALU_result <= reg_out_A << reg_out_B;

			`SRL  :  ALU_result <= reg_out_A >> reg_out_B;

			`SRA  :  ALU_result <= { {32{reg_out_A[31]}}, reg_out_A } >> reg_out_B;

			`MOVS2I  :  ALU_result <= reg_out_A;

			`SEQ : ALU_result <= (reg_out_A == reg_out_B) ? 32'b1 : 32'b0;
			
			`SNE : ALU_result <= (reg_out_A != reg_out_B) ? 32'b1 : 32'b0;

			/*
			`SLT : ALU_result <= (reg_out_A < reg_out_B) ? 32'b1 : 32'b0;
	
			`SGT : ALU_result <= (reg_out_A > reg_out_B) ? 32'b1 : 32'b0;

			`SLE : ALU_result <= (reg_out_A <= reg_out_B) ? 32'b1 : 32'b0;
		
			`SGE : ALU_result <= (reg_out_A >= reg_out_B) ? 32'b1 : 32'b0;
			*/
			`SLT : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} < {~reg_out_B[31],reg_out_B[30:0]} ) ? 32'b1 : 32'b0;
	
			`SGT : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} > {~reg_out_B[31],reg_out_B[30:0]} ) ? 32'b1 : 32'b0;

			`SLE : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} <= {~reg_out_B[31],reg_out_B[30:0]} ) ? 32'b1 : 32'b0;
		
			`SGE : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} >= {~reg_out_B[31],reg_out_B[30:0]} ) ? 32'b1 : 32'b0;
		
		endcase
		
		end
			
		else if (IR_opcode_field != 0)				// I-Type and J-Type format instructions

		begin

		case(IR_opcode_field)
	
			`LW   : begin
					ALU_result <= reg_out_A + Imm;
					byte <= 0;
					word <= 0;
				end

			`LH   : begin
					ALU_result <= reg_out_A + Imm;
					byte <= 0;
					word <= 1;
				end
		
			`LB   : begin
					ALU_result <= reg_out_A + Imm;
					byte <= 1;
					word <= 0;
				end
			
			`LBU   : begin
					ALU_result <= reg_out_A + Imm;
					byte <= 1;
					word <= 0;
				end
			
			`LHU   : begin
					ALU_result <= reg_out_A + Imm;
					byte <= 0;
					word <= 1;
				end

			`SW   :	 begin 
					ALU_result <= reg_out_A + Imm;
					byte <= 0;
					word <= 0;
				 end

			`SH   :  begin 
					ALU_result <= reg_out_A + Imm;
					byte <= 0;
					word <= 1;
				 end 

			`SB   :  begin
					ALU_result <= reg_out_A + Imm;
					byte <= 1;
					word <= 0;
				 end

			`LHI  :  ALU_result <= Imm << 16;

			`ADDI :  ALU_result <= reg_out_A + Imm;

			`ADDUI : ALU_result <= reg_out_A + {16'b0,Imm[15:0]};

			`SUBI :	 ALU_result <= reg_out_A - Imm;

			`SUBUI : ALU_result <= reg_out_A - {16'b0,Imm[15:0]};

			`ANDI :	 ALU_result <= reg_out_A & Imm;

			`ORI  :  ALU_result <= reg_out_A | Imm;

			`XORI :	 ALU_result <= reg_out_A ^ Imm;

			`SLLI :  ALU_result <= reg_out_A << Imm;

			`SRLI :  ALU_result <= reg_out_A >> Imm;

			`SRAI :  ALU_result <= { {32{reg_out_A[31]}}, reg_out_A } >> Imm;
//(reg_out_A[31]) ? ((reg_out_A >> Imm) | 32'h80000000) : (reg_out_A >> Imm);
			
			`SEQI : ALU_result <= (reg_out_A == Imm) ? 32'b1 : 32'b0;
			
			`SNEI : ALU_result <= (reg_out_A != Imm) ? 32'b1 : 32'b0;

			/*
			`SLTI : ALU_result <= (reg_out_A < Imm) ? 32'b1 : 32'b0;
	
			`SGTI : ALU_result <= (reg_out_A > Imm) ? 32'b1 : 32'b0;

			`SLEI : ALU_result <= (reg_out_A <= Imm) ? 32'b1 : 32'b0;
		
			`SGEI : ALU_result <= (reg_out_A >= Imm) ? 32'b1 : 32'b0;
			*/
			`SLTI : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} < {~Imm[31],Imm[30:0]}) ? 32'b1 : 32'b0;
	
			`SGTI : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} > {~Imm[31],Imm[30:0]}) ? 32'b1 : 32'b0;

			`SLEI : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} <= {~Imm[31],Imm[30:0]}) ? 32'b1 : 32'b0;
		
			`SGEI : ALU_result <= ({~reg_out_A[31],reg_out_A[30:0]} >= {~Imm[31],Imm[30:0]}) ? 32'b1 : 32'b0;
		
			 default: ALU_result <= 32'b0;


		endcase

		end

		else ALU_result <= 32'b0; // Undefined Instruction ? //


		if(reg_dst == 1)                                        // R-Type format instruction
			reg_out_B_EX <= reg_out_B;
		else begin                                 		       // I-Type and J-Type format instruction
			if (IR_opcode_field == `SB)		       // clear high bits for stores //
					reg_out_B_EX <= reg_out_B & (32'h000000FF);
			else if (IR_opcode_field == `SH)
					reg_out_B_EX <= reg_out_B & (32'h0000FFFF);
			else
				reg_out_B_EX <= reg_out_B;
		end

	    reg_write_EX  <=  reg_write;
	    mem_to_reg_EX <=  mem_to_reg;
	    mem_read_EX   <=  mem_read;
	    mem_write_EX  <=  mem_write;
		mem_sign_ext <= (IR_opcode_field == `LB || IR_opcode_field == `LH) ? 1'b1: 1'b0;
	 end

end
end

endmodule
	


 

