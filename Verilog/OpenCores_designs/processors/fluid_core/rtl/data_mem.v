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
module data_mem(
	input [0:`memory_bus_w] mem_addr,
	input Clk,
	input write_en, en,
	inout [0:`dpw] data
    );

	reg [0:`dpw] data_bank [0:9];
	reg [0:`dpw] data_buff;
	
initial begin
data_bank[0] <= `dpw'd1;
data_bank[1] <= `dpw'd5;
data_bank[2] <= {19'd0,`type_other,`wb_rf,`RRR,`barrel_Shifter,3'b001};
data_bank[3] <= `dpw'd15;
data_bank[4] <= `dpw'd25;
data_bank[5] <= `dpw'd35;
data_bank[6] <= `dpw'd45;
data_bank[7] <= `dpw'd55;
data_bank[8] <= `dpw'd85;
data_bank[9] <= `dpw'd95;
end

always@(posedge Clk) begin
	if (en) begin
		if (write_en) begin
			data_bank[mem_addr] <= data;
		end else begin
			data_buff <= data_bank[mem_addr];
		end
	end
end

assign data = en ? write_en ? 'bZ: data_buff:'bZ;
endmodule
