//////////////////////////////////////////////////////////////////////
////                                                              ////
////  MEM.v	                                                  ////
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
module MEM (/* ALU_result_MEM,*/ reg_write_MEM, mem_to_reg_EX, clk, reset, ALU_result, reg_write_EX, mem_to_reg_MEM, reg_out_B_EX, reg_out_B_MEM, DM_read_data, RF_data_in, byte, word, mem_sign_ext);

// Input Ports
input 		 clk;			// clk
input		 reset;			// reset pulse
// // synopsys async_set_reset "reset"
input [31:0]	 ALU_result;

// inputs that are control signals
input		 reg_write_EX;
input 		 mem_to_reg_EX;

input [31:0]     reg_out_B_EX;

input [31:0]     DM_read_data;

input byte, word, mem_sign_ext;

// Output ports
//output [31:0]  ALU_result_MEM;

output [31:0]  reg_out_B_MEM;

output [31:0]  RF_data_in;

// outputs that are control signals
output reg_write_MEM;
output mem_to_reg_MEM;


//reg [31:0] ALU_result_MEM;
reg reg_write_MEM;
reg mem_to_reg_MEM;

reg [31:0] reg_out_B_MEM;

reg [31:0] RF_data_in;

// always @(posedge clk or posedge reset)

always @(posedge clk or posedge reset)
begin
	if (reset)
	begin
//		ALU_result_MEM <= 32'd0;
		reg_write_MEM <= 1'd0;
		mem_to_reg_MEM <= 1'd0;
		reg_out_B_MEM <= 32'b0;
		RF_data_in <= 32'b0;
	end
	else
	begin
//		ALU_result_MEM <= ALU_result;
		reg_write_MEM <= reg_write_EX;
		mem_to_reg_MEM <= mem_to_reg_EX;
		reg_out_B_MEM <= reg_out_B_EX;
		if (mem_to_reg_EX == 1'b1) begin
			if (mem_sign_ext) begin
				if (byte)
					RF_data_in <= {{24{DM_read_data[7]}},DM_read_data[7:0]};
				else if (word)
					RF_data_in <= {{16{DM_read_data[15]}},DM_read_data[15:0]};
				else
					RF_data_in <= DM_read_data;
			end
			else
				RF_data_in <= DM_read_data;
		end
		else
			RF_data_in <= ALU_result;
		
	end	
end

endmodule




