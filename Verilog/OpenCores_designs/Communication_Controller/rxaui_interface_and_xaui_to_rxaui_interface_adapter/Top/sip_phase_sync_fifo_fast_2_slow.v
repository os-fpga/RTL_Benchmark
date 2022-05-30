//-----------------------------------------------------------------------------
// Title         : Phase sync fifo
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_phase_sync_fifo_fast_2_slow.v
// Author        : Lior Valency
// Created       : 13/02/2008 
// Last modified : 13/02/2008 
//-----------------------------------------------------------------------------
// Description : This module is a free-running fifo which syncs the data between 
// 2 clocks domain, the write is double frequency and half-width from the read. 
//-----------------------------------------------------------------------------
// Copyright (c) 2007  Marvell International Ltd.
//
// THIS CODE CONTAINS CONFIDENTIAL INFORMATION OF MARVELL SEMICONDUCTOR, INC.
// NO RIGHTS ARE GRANTED HEREIN UNDER ANY PATENT, MASK WORK RIGHT OR COPYRIGHT
// OF MARVELL OR ANY THIRD PARTY. MARVELL RESERVES THE RIGHT AT ITS SOLE
// DISCRETION TO REQUEST THAT THIS CODE BE IMMEDIATELY RETURNED TO MARVELL.
// THIS CODE IS PROVIDED "AS IS". MARVELL MAKES NO WARRANTIES, EXPRESS,
// IMPLIED OR OTHERWISE, REGARDING ITS ACCURACY, COMPLETENESS OR PERFORMANCE.
//
//------------------------------------------------------------------------------
// Modification history :
// 12/12/2007  : created
//-----------------------------------------------------------------------------

//`timescale 1ns / 10ps
`timescale 10ps / 10ps

module sip_phase_sync_fifo_fast_2_slow (/*AUTOARG*/
   // Outputs
   fifo_data_out,
   // Inputs
   wr_clk, rd_clk, wr_reset_, rd_reset_, fifo_data_in
   );
   
   parameter FAST_DATA_WIDTH = 20;
   parameter SYNC_FIFO_WIDTH = 2*FAST_DATA_WIDTH; 
   parameter SYNC_FIFO_DEPTH = 8; 
   parameter SYNC_FIFO_ADDR_WIDTH = 3; 
   parameter SYNC_FIFO_LAST_ENTRY = 3'd7;
   parameter FIFO_RD_PTR_INIT = 3'd4;
   parameter FIFO_ONE = 3'd1;
   
   input                                wr_clk;
   input 				rd_clk;
   input 				wr_reset_;
   input 				rd_reset_;
   input [FAST_DATA_WIDTH-1:0] 		fifo_data_in;
   output [SYNC_FIFO_WIDTH-1:0] 	fifo_data_out;
   //
   reg [SYNC_FIFO_WIDTH-1:0] 		fifo_entry [SYNC_FIFO_DEPTH-1:0];
   reg [SYNC_FIFO_WIDTH-1:0] 		fifo_entry_d [SYNC_FIFO_DEPTH-1:0];
   reg [SYNC_FIFO_WIDTH-1:0] 		fifo_data_out;
   wire [SYNC_FIFO_WIDTH-1:0] 		fifo_data_out_d;
   reg [SYNC_FIFO_ADDR_WIDTH-1:0] 	fifo_wr_addr;
   wire [SYNC_FIFO_ADDR_WIDTH-1:0] 	fifo_wr_addr_d;
   reg [SYNC_FIFO_ADDR_WIDTH-1:0] 	fifo_rd_addr;
   wire [SYNC_FIFO_ADDR_WIDTH-1:0] 	fifo_rd_addr_d;
   wire 				inc_wr_addr_d_;
   reg 					inc_wr_addr_;
   
   integer 				wr_addr,i;
   
   //Internal signals
   // increment write address every 2cc
   assign inc_wr_addr_d_ = ~inc_wr_addr_;
   assign fifo_wr_addr_d = (inc_wr_addr_ == 1'b0) ? 
			   ((fifo_wr_addr == SYNC_FIFO_LAST_ENTRY) ? {SYNC_FIFO_ADDR_WIDTH{1'b0}} : 
			    (fifo_wr_addr + FIFO_ONE)) :
			   fifo_wr_addr;
   assign fifo_rd_addr_d = (fifo_rd_addr == SYNC_FIFO_LAST_ENTRY) ? {SYNC_FIFO_ADDR_WIDTH{1'b0}} : 
			   (fifo_rd_addr + FIFO_ONE);
   //read from fifo
   assign fifo_data_out_d = fifo_entry[fifo_rd_addr];	 
   
   //write to fifo
   always @ (fifo_entry[0] or fifo_entry[1] or fifo_entry[2] or fifo_entry[3] or
	     fifo_entry[4] or fifo_entry[5] or fifo_entry[6] or fifo_entry[7] or
	     /*AUTOSENSE*/ /*memory or*/ fifo_data_in or fifo_wr_addr
	     or inc_wr_addr_)
     begin
       for (wr_addr = 0; wr_addr < SYNC_FIFO_DEPTH; wr_addr = wr_addr + 1) 
         begin
           fifo_entry_d[wr_addr] = (fifo_wr_addr == wr_addr) ? 
				   ((inc_wr_addr_ == 1'b1) ? ({fifo_entry[wr_addr][SYNC_FIFO_WIDTH-1:FAST_DATA_WIDTH],fifo_data_in}) 
				    : ({fifo_data_in,fifo_entry[wr_addr][FAST_DATA_WIDTH-1:0]})) : fifo_entry[wr_addr];
         end
     end // always @ (...
   //write clock domain FF
     always @ (posedge wr_clk or negedge wr_reset_)
     begin
       if (!wr_reset_)
         begin
           for (i = 0; i < SYNC_FIFO_DEPTH; i = i + 1) 
             begin
               fifo_entry[i] <= #1 {SYNC_FIFO_WIDTH{1'b0}};
             end
           fifo_wr_addr      <= #1 {SYNC_FIFO_ADDR_WIDTH{1'b0}};
	   inc_wr_addr_      <= #1 1'b1;
         end
       else
         begin
           for (i = 0; i < SYNC_FIFO_DEPTH; i = i + 1) 
             begin
               fifo_entry[i] <= #1 fifo_entry_d[i];
             end
           fifo_wr_addr      <= #1 fifo_wr_addr_d;
	   inc_wr_addr_      <= #1 inc_wr_addr_d_;
         end
     end // always @ (negedge wr_clk or negedge wr_reset_)
   
   //read clock domain FF
   always @(posedge rd_clk or negedge rd_reset_)
     begin
       if(!rd_reset_)
	 begin
	   fifo_rd_addr  <= #1 FIFO_RD_PTR_INIT;
	   fifo_data_out <= #1 {SYNC_FIFO_WIDTH{1'b0}};
	 end
       else
	 begin
	   fifo_rd_addr  <= #1 fifo_rd_addr_d;
	   fifo_data_out <= #1 fifo_data_out_d;
	 end
     end // always @ (posedge rd_clk or negedge rd_reset_)
   

endmodule // tc_qsgmii_phase_sync_fifo_fast_2_slow





