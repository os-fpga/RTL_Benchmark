///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_rx_fifo
// File Name:    e_rx_fifo.v
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

module e_rx_fifo(
                        rst,
                        clk,
                        sd_clk,
                  
                        block_size_reg,
                        dat_end,

                        push,
                        push_data,
                        buffer_write_rdy,

                        pop,
                        pop_data,
                        buffer_read_en,
                                
                        fifo_sel_h,
                        fifo_sel_l
                     );


   input                rst;
   input                clk;
   input                sd_clk;

   input    [11:0]      block_size_reg;
   input                dat_end;

   input                push;
   input    [7:0]       push_data;
   output               buffer_write_rdy;

   input                pop;
   output   [15:0]      pop_data;
   output               buffer_read_en;

   input                fifo_sel_h;
   input                fifo_sel_l;

   reg                  buffer_write_rdy;
   reg                  buffer_read_en;
//   wire     [15:0]      pop_data;
   wire     [17:0]      i_pop_data;

//   reg      [9:0]       push_ptr;
   reg      [8:0]       pop_ptr;
//   reg      [7:0]       pop_ptr_h;
//   reg      [7:0]       pop_ptr_l;

//   wire                 last_dword;
   wire                 last_byte;
   reg                  flush;
//   wire                 we_h, we_l;
//   reg      [1:0]       be_cnt;
//   reg      [7:0]       push_data_l;
//   wire     [17:0]      rd_ram_h, rd_ram_l;
   wire                 i_pop;
   reg flush_sync;
   reg flush_d1;

   wire                 i_push;
   reg                  push_pad;
   reg            [1:0] push_ptr;

   wire                 clkn;
   wire           [3:0] pop_flag;

  assign i_pop = (pop & ~buffer_write_rdy);// & |pop_flag; 

  assign pop_data = ({i_pop_data[16:9],i_pop_data[7:0]});
   
  assign last_byte = (pop_ptr[8:1] == block_size_reg[9:2]) ? 1 : 0;
     
  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      flush     <= 1'b1;
    else
      begin
        if (last_byte && ((pop & fifo_sel_h) || block_size_reg[1:0] == 2'b00))
          flush <= 1'b1;
        else
          flush <= 1'b0;
      end
  end
   
  always @ (posedge sd_clk or posedge flush) 
  begin
    if (flush)
      begin
        buffer_write_rdy <= 1'b1;
      end
    else
    begin
      if (push)
        buffer_write_rdy <= 1'b0;
    end
  end
    
  always @ (posedge clk or posedge flush)
  begin
    if (flush)
      pop_ptr <= 0;
    else if (pop && buffer_read_en)
      pop_ptr <= pop_ptr + 1;
  end    

  always @ (posedge clk or posedge dat_end)
  begin
    if (dat_end)
      begin
        buffer_read_en <= 1;
      end
    else if (flush)
      begin
        buffer_read_en <= 0;
      end
  end

  af512x9_256x18 RX_FIFO (
    .Push_Clk        (sd_clk),
    .Pop_Clk         (clk),
    .Fifo_Push_Flush (1'b0),//flush_sync),
    .Fifo_Pop_Flush  (1'b0),
    .PUSH            (i_push),
    .POP             (i_pop),
    .Almost_Full     ( ),
    .Almost_Empty    ( ),
    .PUSH_FLAG       (  ),
    .POP_FLAG        ( pop_flag ),
    .DIN             ({1'b0, push_data}),
    .DOUT            (i_pop_data)
    );

  always@( posedge sd_clk or posedge flush )
  begin
    if (flush)
    begin
      flush_sync <= 1'b1;
	  flush_d1   <= 1'b1;
    end
    else
    begin
	  flush_sync <= flush_d1;
	  flush_d1   <= 1'b0;
    end
  end






  always @ (posedge sd_clk or posedge rst)
  begin
    if (rst)
      push_ptr <= 2'b0;
	else if (i_push)
      push_ptr <= push_ptr + 1;
  end

  always @ (posedge sd_clk or posedge rst)
  begin
    if (rst)
      push_pad <= 1'b0;
	else if(dat_end & (push_ptr != 2'b00))
      push_pad <= 1'b1;
    else if(push_ptr == 2'b11)
      push_pad <= 1'b0;
  end

assign i_push = push | push_pad;



endmodule

















