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

module interrupt_unit(
	input Clk,
	input [0:`intr_msb] intr_req,
	input [0:log2(`intr_msb)] intr_inx,
	input [0:`pc_w] new_vector,
	input write, return_back,
	output intr,
	output [0:`pc_w] vector
    );

	reg [0:`pc_w] isr_vectors [0:`intr_msb+1];
	reg [0:`intr_msb] masks;
	reg temp_unblock;
	reg [0:log2(`intr_msb)-1] vctr_inx;
 
	integer i;
	always@(*) begin
	for ( i = `intr_msb; (i >= 0); i = i - 1) begin
		if (intr_req[i] == 1) begin
		vctr_inx <= i;
		end
	end
	end
	initial begin
		temp_unblock <= 1;
	end
	assign intr = |(masks & intr_req ) & temp_unblock; //(~(vctr_inx == 0)&&(masks[vctr_inx]));
	assign vector = intr ? isr_vectors[vctr_inx]:'bz;
	
	always@(posedge Clk) begin							
		if (write) begin//write
			if (intr_inx == 0) masks <= new_vector; //(aligned by MSB)
			else begin
			isr_vectors[intr_inx] <= new_vector;
			end 
		end
		if (intr) temp_unblock <= 0;
		else if (return_back) temp_unblock <= 1;
	end
	

	//--- Constant Function ----//
	function integer log2;
	  input integer value;
	  begin
		 value = value-1;
		 for (log2=0; value>0; log2=log2+1)
			value = value>>1;
	  end
	endfunction
endmodule
