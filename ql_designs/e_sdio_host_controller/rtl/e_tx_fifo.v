///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_tx_fifo
// File Name:    e_tx_fifo.v
// 
// Version 1.0   April  1, 2006  -Original
// Version 1.1   Feb.   7, 2007  -Added 16 bit support
// Version 1.2   May.   14,2007  -Fixed cmd to cmd delay
//                               -SDIO power on switch clock line level
//                               -Used latched signal for datline0
//                               -Optimized to use fifo controllers
//                               -Modified to use one RAMBLOCK instead of two
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module e_tx_fifo(
                        rst,
                        clk,
                        sd_clk,
                  
                        block_size_reg,
                        dat_end,
                        
                        push,
                        push_data,                       
                        buffer_write_en,
                                                            
                        pop,
                        pop_data,
                        buffer_read_rdy,
                                
                        fifo_sel_h,
                        fifo_sel_l                      
                     );

   parameter   MAX_PTR_WIDTH     = 10;

   input                rst;
   input                clk;
   input                sd_clk;
                  
   input    [11:0]      block_size_reg;
   input                dat_end;
   
   input                push;
   input    [15:0]      push_data;                       
   output               buffer_write_en;
                                       
   input                pop;
   output   [7:0]       pop_data;
   output               buffer_read_rdy;
    
   input                fifo_sel_h;
   input                fifo_sel_l;

   reg                  buffer_write_en;

   reg                  buffer_read_rdy;
   reg                  buffer_read_rdy_pre;

   reg                  push_ptr_en;
   reg      [7:0]       push_ptr;
   reg                  pop_dly;

   wire                 rst_i;
   wire                 last_dword;
   wire     [8:0]       i_pop_data;      

   wire                 i_push;
   reg                  rst_i_sync;
   reg                  rst_i_d1;

   wire                 i_pop;
   reg                  pop_pad;
   reg            [1:0] pop_ptr;

   assign pop_data = i_pop_data[7:0];   
   assign rst_i = rst | dat_end | !(|block_size_reg);
   assign last_dword = ( push_ptr == block_size_reg[9:2] )? 1 : 0;
     
   
  always@( posedge clk or posedge rst_i )
  begin
  if( rst_i )
    begin
    push_ptr_en       <= 0;
    push_ptr          <= 0;
    buffer_write_en   <= 1'b1;
    end
  else
    begin
    if (push)
      begin
      push_ptr_en <= ~push_ptr_en;
      if (push_ptr_en)
        push_ptr <= push_ptr + 1;
      end
    if (last_dword && (block_size_reg[1:0] == 2'b00 || (push & fifo_sel_h) ))
      buffer_write_en  <= 1'b0;
    end
  end

   always@( posedge sd_clk or posedge rst_i)
   begin
      if (rst_i)
      begin
         buffer_read_rdy           <= 1'b0;
         buffer_read_rdy_pre       <= 1'b0;
         pop_dly                   <= 1'b0;
      end
      else
      begin
         pop_dly                   <= pop;
         buffer_read_rdy           <= buffer_read_rdy_pre;
         buffer_read_rdy_pre       <= ~buffer_write_en;
      end
   end                          


  af256x18_512x9 TX_FIFO (
    .Push_Clk        (clk),
    .Pop_Clk         (sd_clk),
    .Fifo_Push_Flush (1'b0),//rst_i_sync),
    .Fifo_Pop_Flush  (1'b0),
    .PUSH            (i_push),
    .POP             (i_pop),
    .Almost_Full     ( ),
    .Almost_Empty    ( ),
    .PUSH_FLAG       ( ),
    .POP_FLAG        ( ),
    .DIN             ({1'b0, push_data[15:8], 1'b0, push_data[7:0]}),
    .DOUT            (i_pop_data)
    );

assign i_push = push & buffer_write_en;

  always@( posedge clk or posedge rst_i )
  begin
    if (rst_i)
    begin
      rst_i_sync <= 1'b1;
	  rst_i_d1   <= 1'b1;
    end
    else
    begin
	  rst_i_sync <= rst_i_d1;
	  rst_i_d1   <= 1'b0;
    end
  end







  always @ (posedge sd_clk or posedge rst)
  begin
    if (rst)
      pop_ptr <= 2'b0;
	else if (i_pop)
      pop_ptr <= pop_ptr + 1;
  end

  always @ (posedge sd_clk or posedge rst)
  begin
    if (rst)
      pop_pad <= 1'b0;
	else if(rst_i & (pop_ptr != 2'b00))
      pop_pad <= 1'b1;
    else if(pop_ptr == 2'b11)
      pop_pad <= 1'b0;
  end

assign i_pop = pop | pop_pad;






endmodule


















