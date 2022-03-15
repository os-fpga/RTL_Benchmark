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
/*
-----General Format---------
,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
|Type|S0|S1|S2|Imm|Mod_Sel|Operation|
`````````````````````````````````````

*/


module uOP_Store(
	input Clk,
	input write,
	input [0:`uop_vector_msb] write_vector,
	input [0:`uop_msb] write_uop,
	input [0:`uop_vector_msb] uop_vector,
	output [0:`uop_msb] uop
    );

	reg [0:`uop_msb] uOP_rom [0:`uop_n];
	
	assign uop = uOP_rom[uop_vector];
	
	//---initialize-----//
	initial begin
		uOP_rom[0] <= {`type_other,`wb_none,`RRR,`none,`op_none};// iNone_RRR
		uOP_rom[1] <= {`type_other,`wb_rf,`RRR,`int_ALU,`ADD};// iADD_RRR
		uOP_rom[2] <= {`type_other,`wb_rf,`RRI,`int_ALU,`ADD};// iADD_RRI
		uOP_rom[3] <= {`type_other,`wb_rf,`RRR,`int_ALU,`SUB};// iSUB_RRR
		uOP_rom[4] <= {`type_other,`wb_rf,`RRI,`int_ALU,`SUB};// iSUB_RRI
		uOP_rom[5] <= {`type_other,`wb_rf,`RRR,`int_ALU,`ADC};// iADC_RRR
		uOP_rom[6] <= {`type_other,`wb_rf,`RRI,`int_ALU,`ADC};// iADC_RRI
		uOP_rom[7] <= {`type_other,`wb_rf,`RRR,`int_ALU,`SBC};// iSBC_RRR
		uOP_rom[8] <= {`type_other,`wb_rf,`RRI,`int_ALU,`SBC};// iSBC_RRI
		uOP_rom[9] <= {`type_other,`wb_rf,`RRR,`int_ALU,`AND};// iAND_RRR
		uOP_rom[10] <= {`type_other,`wb_rf,`RRI,`int_ALU,`AND};// iAND_RRI
		uOP_rom[11] <= {`type_other,`wb_rf,`RRR,`int_ALU,`OR};// iOR_RRR
		uOP_rom[12] <= {`type_other,`wb_rf,`RRI,`int_ALU,`OR};// iOR_RRI
		uOP_rom[13] <= {`type_other,`wb_rf,`RRR,`int_ALU,`XOR};// iXOR_RRR
		uOP_rom[14] <= {`type_other,`wb_rf,`RRI,`int_ALU,`XOR};// iXOR_RRI
		uOP_rom[15] <= {`type_branch,`wb_rf,`RRR,`int_ALU,`ADD};// iBranch_RRR
		uOP_rom[16] <= {`type_branch,`wb_rf,`RRI,`int_ALU,`ADD};// iBranch_RRI
		uOP_rom[17] <= {`type_branch,`wb_rf,`RI,`int_ALU,`ADD};// iBranch_RI
		uOP_rom[18] <= {`type_load,`wb_rf,`RRR,`int_ALU,`ADD};// iLoad_RRR
		uOP_rom[19] <= {`type_load,`wb_rf,`RRI,`int_ALU,`ADD};// iLoad_RRI
		uOP_rom[20] <= {`type_load,`wb_rf,`RI,`int_ALU,`ADD};// iLoad_RI
		uOP_rom[21] <= {`type_store,`wb_rf,`sRR,`int_ALU,`ADD};// iStore_sRR
		uOP_rom[22] <= {`type_store,`wb_rf,`sRI,`int_ALU,`ADD};// iStore_sRI
		uOP_rom[23] <= {`type_other,`wb_int,`RI,`int_ALU,`ADD};// iAddVector_RI
		uOP_rom[24] <= {`type_other,`wb_uop,`RI,`int_ALU,`ADD};// iAdduOP_RI
		uOP_rom[25] <= {`type_other,`wb_uop,`RRI,`int_ALU,`ADD};// iAdduOP_RRI
	end
	
	always@(posedge Clk) begin							
		if (write) begin//write
			uOP_rom[write_vector] <= write_uop;
		end
	end
endmodule
