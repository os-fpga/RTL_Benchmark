//////////////////////////////////////////////////////////////////////
////                                                              ////
////  eth_spram_256x32.v                                          ////
////                                                              ////
////  This file is part of the Ethernet IP core project           ////
////  http://www.opencores.org/projects/ethmac/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Igor Mohor (igorM@opencores.org)                      ////
////                                                              ////
////  All additional information is available in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2001, 2002 Authors                             ////
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
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.2  2002/09/23 18:24:31  mohor
// ETH_VIRTUAL_SILICON_RAM supported (for ASIC implementation).
//
// Revision 1.1  2002/07/23 16:36:09  mohor
// ethernet spram added. So far a generic ram and xilinx RAMB4 are used.
//
//
//

`include "eth_defines.v"
`include "timescale.v"

module eth_spram_256x32(
	// Generic synchronous single-port RAM interface
	clk, rst, ce, we, oe, addr, di, do

`ifdef ETH_BIST
  ,trst, SO, SI, shift_DR, capture_DR, extest, tck
`endif



);

	//
	// Generic synchronous single-port RAM interface
	//
	input           clk;  // Clock, rising edge
	input           rst;  // Reset, active high
	input           ce;   // Chip enable input, active high
	input           we;   // Write enable input, active high
	input           oe;   // Output enable input, active high
	input  [7:0]    addr; // address bus inputs
	input  [31:0]   di;   // input data bus
	output [31:0]   do;   // output data bus


`ifdef ETH_BIST
  input           trst;
  input           shift_DR, capture_DR, tck, extest;
  input           SI;
  output          SO;
`endif

`ifdef ETH_XILINX_RAMB4

    RAMB4_S16 ram0
    (
        .DO      (do[15:0]),
        .ADDR    (addr),
        .DI      (di[15:0]),
        .EN      (ce),
        .CLK     (clk),
        .WE      (we),
        .RST     (rst)
    );

    RAMB4_S16 ram1
    (
        .DO      (do[31:16]),
        .ADDR    (addr),
        .DI      (di[31:16]),
        .EN      (ce),
        .CLK     (clk),
        .WE      (we),
        .RST     (rst)
    );

`else   // !ETH_XILINX_RAMB4
`ifdef  ETH_VIRTUAL_SILICON_RAM
  `ifdef ETH_BIST
      vs_hdsp_256x32_bist ram0_bist
  `else
      vs_hdsp_256x32 ram0
  `endif
      (
        .CK         (clk),
        .CEN        (!ce),
        .WEN        (!we),
        .OEN        (!oe),
        .ADR        (addr),
        .DI         (di),
        .DOUT       (do)

      `ifdef ETH_BIST
        ,
        // reset
        .trst      (trst),

        // debug chain signals
        .SO        (SO),
        .SI        (SI),
        .shift_DR  (shift_DR),
        .capture_DR(capture_DR),
        .extest    (extest),
        .tck       (tck)
      `endif
      );

`else   // !ETH_VIRTUAL_SILICON_RAM

	//
	// Generic single-port synchronous RAM model
	//

	//
	// Generic RAM's registers and wires
	//
	reg  [31:0] mem [255:0];	// RAM content
	wire [31:0] q;          // RAM output
	reg  [7:0]  raddr;      // RAM read address
	//
	// Data output drivers
	//
	assign do = (oe & ce) ? q : {32{1'bz}};

	//
	// RAM read and write
	//

	// read operation
	always@(posedge clk)
	if (ce) // && !we)
		raddr <= #1 addr;    // read address needs to be registered to read clock

	assign #1 q = rst ? {32{1'b0}} : mem[raddr];

	// write operation
	always@(posedge clk)
		if (ce && we)
			mem[addr] <= #1 di;

	// Task prints range of memory
	// *** Remember that tasks are non reentrant, don't call this task in parallel for multiple instantiations. 
	task print_ram;
	input [7:0] start;
	input [7:0] finish;
	integer rnum;
  	begin
    		for (rnum=start;rnum<=finish;rnum=rnum+1)
      			$display("Addr %h = %h",rnum,mem[rnum]);
  	end
	endtask

`endif  // !ETH_VIRTUAL_SILICON_RAM
`endif  // !ETH_XILINX_RAMB4

endmodule
