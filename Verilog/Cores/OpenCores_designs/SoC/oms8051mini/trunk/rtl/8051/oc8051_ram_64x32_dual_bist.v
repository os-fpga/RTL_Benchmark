//////////////////////////////////////////////////////////////////////
////                                                              ////
////  8051 cache ram                                              ////
////                                                              ////
////  This file is part of the 8051 cores project                 ////
////  http://www.opencores.org/cores/oms8051mini/                 ////
////                                                              ////
////  Description                                                 ////
////   64x31 dual port ram                                        ////
////                                                              ////
////  To Do:                                                      ////
////   nothing                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Simon Teran, simont@opencores.org                     ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////   v0.0 - Dinesh A, 5th Jan 2017
////        1. Active edge of reset changed from High to Low
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
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
//
//


`include "top_defines.v"

//
// duble port ram
//
module oc8051_ram_64x32_dual_bist (
                     clk,
                     resetn,
                     
		     adr0,
		     dat0_o,
		     en0,
		     
		     adr1,
		     dat1_i,
		     dat1_o,
		     en1,
		     wr1
`ifdef OC8051_BIST
	 ,
         scanb_rst,
         scanb_clk,
         scanb_si,
         scanb_so,
         scanb_en
`endif
		     );

parameter ADR_WIDTH = 6;

input         clk, 
              wr1, 
	      resetn,
	      en0,
	      en1;
input  [7:0]  dat1_i;
input  [ADR_WIDTH-1:0]  adr0;
input  [ADR_WIDTH-1:0]  adr1;

output [31:0]  dat0_o;
output [31:0]  dat1_o;

reg    [7:0]  rd_data;


`ifdef OC8051_BIST
input   scanb_rst;
input   scanb_clk;
input   scanb_si;
output  scanb_so;
input   scanb_en;
`endif


`ifdef OC8051_RAM_XILINX
  xilinx_ram_dp u_ram_dp(
  	// read port
  	.CLKA(clk),
  	.RSTA(resetn),
  	.ENA(en0),
  	.ADDRA(adr0),
  	.DIA(32'h00),
  	.WEA(1'b0),
  	.DOA(dat0_o),
  
  	// write port
  	.CLKB(clk),
  	.RSTB(resetn),
  	.ENB(en1),
  	.ADDRB(adr1),
  	.DIB(dat1_i),
  	.WEB(wr1),
  	.DOB(dat1_o)
  );
  
  defparam
  	xilinx_ram.dwidth = 32,
  	xilinx_ram.awidth = ADR_WIDTH;

`else

  `ifdef OC8051_RAM_VIRTUALSILICON

  `else

    `ifdef OC8051_RAM_GENERIC
    
      generic_dpram #(ADR_WIDTH, 32) u_ram_dp(
      	.rclk  ( clk            ),
      	.resetn  ( resetn            ),
      	.rce   ( en0            ),
      	.oe    ( 1'b1           ),
      	.raddr ( adr0           ),
      	.do    ( dat0_o         ),
      
      	.wclk  ( clk            ),
      	.wresetn  ( resetn      ),
      	.wce   ( en1            ),
      	.we    ( wr1            ),
      	.waddr ( adr1           ),
      	.di    ( dat1_i         )
      );
    
    `else

      reg [31:0] dat1_o; 
      reg [31:0] dat0_o; 
      //
      // buffer
      reg    [31:0]  buff [0:(1<<ADR_WIDTH) -1];

      always @(posedge clk or negedge resetn)
      begin
        if (resetn == 1'b0)
          dat1_o     <= 32'h0;
        else if (wr1) begin
          buff[adr1] <= dat1_i;
          dat1_o    <= dat1_i;
        end else
          dat1_o <= buff[adr1];
      end
      
      always @(posedge clk or negedge resetn)
      begin
        if (resetn == 1'b0)
          dat0_o <= 32'h0;
        else if ((adr0==adr1) & wr1)
          dat0_o <= dat1_i;
        else
          dat0_o <= buff[adr0];
      end
            
    `endif  //OC8051_RAM_GENERIC
  `endif    //OC8051_RAM_VIRTUALSILICON  
`endif      //OC8051_RAM_XILINX

endmodule
