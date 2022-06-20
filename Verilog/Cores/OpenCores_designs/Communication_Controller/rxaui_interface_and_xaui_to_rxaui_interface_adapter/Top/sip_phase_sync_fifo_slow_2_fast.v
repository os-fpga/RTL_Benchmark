//-----------------------------------------------------------------------------
// Title         : Phase sync fifo
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_phase_sync_fifo_slow_2_fast.v
// Author        : Lior Valency
// Created       : 19/02/2008 
// Last modified : 19/02/2008 
//-----------------------------------------------------------------------------
// Description : This module is a free-running fifo which syncs the data between 
// 2 clocks domain, the read is double frequency and half-width from the read.
// in case <fifo_type> is '0' this is regular fifo in which rd and wr clock 
// are the same.  
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

`timescale 1ns / 10ps
module sip_phase_sync_fifo_slow_2_fast (/*AUTOARG*/
   // Outputs
   fifo_data_out,
   // Inputs
   fifo_type, wr_clk, rd_clk, wr_reset_, rd_reset_, fifo_data_in
   );

   parameter FAST_DATA_WIDTH = 10;
   parameter SYNC_FIFO_WIDTH = 2*FAST_DATA_WIDTH; 
   parameter SYNC_FIFO_DEPTH = 8; 
   parameter SYNC_FIFO_ADDR_WIDTH = 3; 
   parameter SYNC_FIFO_LAST_ENTRY = 3'd7; 
   parameter FIFO_RD_PTR_INIT = 3'd4;
   parameter FIFO_ONE = 3'd1;
   parameter REGULAR = 1'b0;

   input                                fifo_type;
   input                                wr_clk;
   input 				rd_clk;
   input 				wr_reset_;
   input 				rd_reset_;
   input [SYNC_FIFO_WIDTH-1:0] 		fifo_data_in;
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
   wire 				inc_rd_ptr_d_;
   reg 					inc_rd_ptr_;
   wire [SYNC_FIFO_WIDTH-1:0] 		full_fifo_data_out;
   
   integer 				wr_addr,i;
   
   //Internal signals
   assign fifo_wr_addr_d = (fifo_wr_addr == SYNC_FIFO_LAST_ENTRY) ? {SYNC_FIFO_ADDR_WIDTH{1'b0}} : 
			   (fifo_wr_addr + FIFO_ONE);
   assign fifo_rd_addr_d = ((inc_rd_ptr_ == 1'b0) || (fifo_type == REGULAR)) ? 
			   ((fifo_rd_addr == SYNC_FIFO_LAST_ENTRY) ? {SYNC_FIFO_ADDR_WIDTH{1'b0}}  : 
			    (fifo_rd_addr + FIFO_ONE)) :
			   fifo_rd_addr;
   // increment read pointer every 2cc
   assign inc_rd_ptr_d_ = ~inc_rd_ptr_;
   //read from fifo
   assign full_fifo_data_out =  fifo_entry[fifo_rd_addr];
   assign fifo_data_out_d = (fifo_type == REGULAR) ? full_fifo_data_out :
			    (inc_rd_ptr_ == 1'b1) ? 
			    {{FAST_DATA_WIDTH{1'b0}},full_fifo_data_out[FAST_DATA_WIDTH-1:0]} :
			    {{FAST_DATA_WIDTH{1'b0}},full_fifo_data_out[SYNC_FIFO_WIDTH-1:FAST_DATA_WIDTH]};

   //write to fifo
   always @ (fifo_entry[0] or fifo_entry[1] or fifo_entry[2] or fifo_entry[3] or
	     fifo_entry[4] or fifo_entry[5] or fifo_entry[6] or fifo_entry[7] or
	     /*AUTOSENSE*/fifo_data_in or fifo_wr_addr)
     begin
       for (wr_addr = 0; wr_addr < SYNC_FIFO_DEPTH; wr_addr = wr_addr + 1) 
         begin
           fifo_entry_d[wr_addr] = (fifo_wr_addr == wr_addr) ? fifo_data_in : fifo_entry[wr_addr];
         end
     end // always @ (...
   //write clock domain FF
     always @ (negedge wr_clk or negedge wr_reset_)
     begin
       if (!wr_reset_)
         begin
           for (i = 0; i < SYNC_FIFO_DEPTH; i = i + 1) 
             begin
               fifo_entry[i] <= #1 {SYNC_FIFO_WIDTH{1'b0}};
             end
           fifo_wr_addr      <= #1 {SYNC_FIFO_ADDR_WIDTH{1'b0}};
         end
       else
         begin
           for (i = 0; i < SYNC_FIFO_DEPTH; i = i + 1) 
             begin
               fifo_entry[i] <= #1 fifo_entry_d[i];
             end
           fifo_wr_addr      <= #1 fifo_wr_addr_d;
         end
     end // always @ (negedge wr_clk or negedge wr_reset_)
   
   //read clock domain FF
   always @(posedge rd_clk or negedge rd_reset_)
     begin
       if(!rd_reset_)
	 begin
	   inc_rd_ptr_   <= #1 1'b1;
	   fifo_rd_addr  <= #1 FIFO_RD_PTR_INIT;
	   fifo_data_out <= #1 {SYNC_FIFO_WIDTH{1'b0}};
	 end
       else
	 begin
	   inc_rd_ptr_   <= #1 inc_rd_ptr_d_;
	   fifo_rd_addr  <= #1 fifo_rd_addr_d;
	   fifo_data_out <= #1 fifo_data_out_d;
	 end
     end // always @ (posedge rd_clk or negedge rd_reset_)
   

endmodule // tc_qsgmii_phase_sync_fifo_slow_2_fast





