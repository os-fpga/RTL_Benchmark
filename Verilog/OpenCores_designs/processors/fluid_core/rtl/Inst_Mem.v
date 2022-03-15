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
`include "Programming.v"

module Inst_Mem(
	input [0:`pc_w] inst_addr,
	input Clk,
	output [0:`inst_w] inst
    );
	 
	reg [0:`inst_w] instruction [0:15];
	reg [0:`inst_w] instb;
	
initial begin
instruction[0] = {`iLoad_RI,`dR3,6'd2};
instruction[1] = {`iAdduOP_RRI,5'd0,`R3,3'd0};
instruction[2] = {`iLoad_RI,`dR2,6'd1};
instruction[3] = {`iAddVector_RI,`dR1,6'd11};
instruction[4] = {`iAddVector_RI,`dR0,6'b11111100};
instruction[5] = {`iLoad_RI,`dR1,6'd0};
instruction[6] = {5'd0,`dR0,`R1,`R2};
instruction[7] = {`iStore_sRI,`dR0,6'd3};
instruction[8] = {`iBranch_RI,`ulnk,`bALL,6'd4};
instruction[9] = {16'hFFFF};
instruction[10] = {6'd8,`dR0,`R1,`R2};
instruction[11] = {`iADD_RRR,`dR3,`R2,`R1};
instruction[12] = {`iBranch_RI,`bRET,6'd0};
instruction[13] = {`iAND_RRI,`dR2,`R2,3'd1};
instruction[14] = {`iOR_RRI,`dR2,`R2,3'd1};
instruction[15] = {`iXOR_RRI,`dR2,`R2,3'd1};
end

assign inst = instruction[inst_addr];

endmodule
