//////////////////////////////////////////////////////////////////////
////                                                              ////
////  SMII                                                        ////
////                                                              ////
////  Description                                                 ////
////  Low pin count serial MII ethernet interface                 ////
////                                                              ////
////  To Do:                                                      ////
////   -                                                          ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////        ORSoC AB          michael.unneback@orsoc.se           ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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
module obufdff
  (
   input d,
   output reg pad,
   input clk,
   input rst
   );
   always @ (posedge clk or posedge rst)
     if (rst)
       pad <= #1 1'b0;
     else
       pad <= #1 d;
endmodule 
module ibufdff
  (
   input pad,
   output reg q,
   input clk,
   input rst
   );
   always @ (posedge clk or posedge rst)
     if (rst)
       q <= #1 1'b0;
     else
       q <= #1 pad;
endmodule 
module iobuftri
  (
   input i,
   input oe,
   output o,
   inout pad
   );
   assign #1 pad = oe ? i : 1'bz;
   assign #1 i = pad;
endmodule 
module obuf
  (
   input i,
   inout pad
   );
   assign #1 pad = i;
endmodule 
module smii_sync
  (
    output            sync,
    output reg [1:10] state,
    input 	      clk,
    input 	      rst
   );
   always @ (posedge clk or posedge rst)
     if (rst)
       state <= 10'b0000000001;
     else
       state <= {state[10],state[1:9]};
   assign sync = state[1];
endmodule 
module smii_txrx
  (
    output     tx,
    input      rx,
    input [3:0] mtxd,
    input 	mtxen,
    input 	mtxerr,
    output 	mtx_clk,
    output reg [3:0] mrxd,
    output reg	 mrxdv,
    output reg	 mrxerr,
    output  	 mrx_clk,
    output 	 mcoll,
    output reg	 mcrs,
    input [1:10] state,
    input 	 clk,
    input 	 rst
   );
   reg [0:7]		 tx_data_reg;
   reg 			 tx_data_reg_valid;
   reg 			 a0;
   reg 			 state_data;
   reg [3:0] 	 rx_tmp;
   reg 		 speed;
   reg 		 duplex;
   reg 		 link;
   reg 		 jabber;
   reg 		 mtx_clk_tmp, mrx_clk_tmp;
   reg [3:0] 	 tx_cnt;
   reg [3:0] 	 rx_cnt;
   always @ (posedge clk or posedge rst)
     if (rst)
       tx_cnt <= 4'd0;
     else
       if (speed)
	 tx_cnt <= 4'd0;
       else if (state[10])
	 if (tx_cnt == 4'd9)
	   tx_cnt <= 4'd0;
	 else
	   tx_cnt <= tx_cnt + 4'd1;
     always @ (posedge clk or posedge rst)
     if (rst)
       mtx_clk_tmp <= 1'b0;
     else
       if ((state[10] | state[5]) & (tx_cnt == 4'd0))
	 mtx_clk_tmp <= 1'b1;
       else if (state[2] | state[7])
	 mtx_clk_tmp <= 1'b0;
   gbuf bufg1
     (
      .CLK(mtx_clk_tmp),
      .GL(mtx_clk)
      );
   always @ (posedge clk or posedge rst)
     if (rst)
       begin
	  tx_data_reg <= 8'd0;
	  tx_data_reg_valid <= 1'b0;
	  a0 <= 1'b0;
       end
     else
       if ((state[4] | state[9]) & (tx_cnt == 4'd0))
	 begin
	    if (!mtxen)
	      a0 <= 1'b0;
	    else
	      a0 <= ~a0;
	    if (!mtxen & !a0)
	      tx_data_reg_valid <= 1'b0;	    
	    else if (a0)
	      tx_data_reg_valid <= 1'b1;
	    if (mtxen & !a0)
	      tx_data_reg[0:3] <= {mtxd[0],mtxd[1],mtxd[2],mtxd[3]};
	    else if (mtxen & a0)
	      tx_data_reg[4:7] <= {mtxd[0],mtxd[1],mtxd[2],mtxd[3]};
	 end 
   always @ (posedge clk or posedge rst)
     if (rst)
       state_data <= 1'b0;
     else
       if (state[1] & (tx_cnt == 4'd0))
	 state_data <= tx_data_reg_valid;
   assign tx = state[1] ? mtxerr :
	       state[2] ? ((tx_data_reg_valid & (tx_cnt == 4'd0)) | state_data) :
	       state_data ? |(state[2:10] & tx_data_reg) :
	       |(state[2:10] & {mtxerr,speed,duplex,link,jabber,3'b111});
   always @ (posedge clk or posedge rst)
     if (rst)
       rx_cnt <= 4'd0;
     else
       if (speed)
	 rx_cnt <= 4'd0;
       else if (!mrxdv & state[8] & rx_tmp[3])
	 rx_cnt <= 4'd9;
       else if (state[10])
	 if (rx_cnt == 4'd9)
	   rx_cnt <= 4'd0;
	 else
	   rx_cnt <= rx_cnt + 4'd1;
   always @ (posedge clk or posedge rst)
     if (rst)
       begin
	  {mcrs, mrxdv, mrxerr, speed, duplex, link, jabber} <= 7'b0001110;
	  rx_tmp <= 4'h0;	  
	  mrxd <= 4'h0;
       end
     else
       begin
	  rx_tmp[2:0] <= {rx,rx_tmp[2:1]};
	  if (state[3])
	    mcrs <= rx;	  
	  if (state[4])
	    rx_tmp[3] <= rx;
	  if (rx_tmp[3]) 
	    begin
	       if (state[8])
		 {mrxdv,mrxd} <= #1 {rx_tmp[3],rx,rx_tmp[2:0]};
	       else if (state[2])
		 mrxd <= #1 {rx,rx_tmp[2:0]};
	    end
	  else
	    begin
	       if (state[5])
		 mrxerr <= #1 rx;
	       if (state[6])
		 speed <= #1 rx;
	       if (state[7])
		 duplex <= #1 rx;
	       if (state[8])
		 begin
		    link <= #1 rx;
		    mrxdv <= #1 1'b0;
		 end
	       if (state[9])
		 jabber <= #1 rx;
	    end
       end 
   always @ (posedge clk or posedge rst)
     if (rst)
       mrx_clk_tmp <= 1'b0;
     else
       if ((state[1] | state[6]) & (rx_cnt == 4'd0))
	 mrx_clk_tmp <= 1'b1;
       else if (state[3] | state[8])
	 mrx_clk_tmp <= 1'b0;
   gbuf bufg2
     (
      .CLK(mrx_clk_tmp),
      .GL(mrx_clk)
      );
   assign mcoll = mcrs & mtxen;
endmodule 
