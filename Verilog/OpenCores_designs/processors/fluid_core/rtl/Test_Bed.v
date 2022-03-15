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

module Test_Bed(
	input Clk,
	input RST,
	input [0:`intr_msb] Interrupt,
	output [0:`dpw] data,
	output reg [0:`dpw] io_port
    );

	wire [0:`inst_w] exInstruction;
	wire [0:`pc_w] exInstAddr;
	wire MemoryClk, MemoryWrite;
	wire [0:`memory_bus_w] MemoryAddr;
	wire [0:`dpw] MemoryData;
	
assign data = MemoryData;
	
FluidCore FC_inst(
.Clk (Clk),
.RST (RST),
.Interrupt(Interrupt),
.exInstruction(exInstruction),
.exInstAddr(exInstAddr),
.exMemoryData(MemoryData),
.exMemoryClk(MemoryClk),
.exMemoryAddr(MemoryAddr),
.exMemoryWrite(MemoryWrite)
);

Inst_Mem Inst_Mem_inst (
.Clk (Clk),
.inst(exInstruction),
.inst_addr(exInstAddr)
);

data_mem data_mem_inst(
.Clk(MemoryClk),
.mem_addr(MemoryAddr),
.data(MemoryData),
.write_en(MemoryWrite),
.en(~MemoryAddr[0])
);

ioPort ioPort_inst(
.Clk(MemoryClk),
.en(MemoryAddr[0]),
.wr(MemoryAddr[3]),
.rd(~MemoryAddr[3]),
.fc_data(MemoryData)
);
endmodule
