//---------------------------------------------------------------------------
// Clock divider core
//
//
// Description: See description below (which suffices for IP core
//                                     specification document.)
//
// Copyright (C) 2002 John Clayton and OPENCORES.ORG (this Verilog version)
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation;  either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source.
// If not, download it from http://www.opencores.org/lgpl.shtml
//
//---------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : Sep. 13, 2002
//
//
// Description
//---------------------------------------------------------------------------
// This module implements a counter to divide down a clock signal.
// I put it in a separate module because I did not know of another way
// to put a timing constraint on it for synthesis.  (Apparently the naming
// convention is different for named blocks and instantiated modules?)
//
//---------------------------------------------------------------------------


module clock_divider (
                  clk_i,
                  clk_o
                  );

parameter SIZE_PP = 3;

input clk_i;

output clk_o;

// This is the counter that does the dividing
reg [SIZE_PP-1:0] clk_count;

always @(posedge clk_i)
begin
  clk_count <= clk_count + 1;
end
assign clk_o = clk_count[SIZE_PP-1];

endmodule


