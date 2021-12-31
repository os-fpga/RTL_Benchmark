///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_crc16
// File Name:    e_crc16.v
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

module e_crc16(
  rst,
  clk,
  gen_en,
  out_en,
  din,
  dout
);

input rst;
input clk;
input gen_en;
input out_en;
input din;
output dout;

wire   rst ;
wire   clk ;
wire   gen_en ;
wire   out_en ;
wire   din ;
wire   dout ;


reg [15:0] crc_reg;

  assign dout = crc_reg[15];
  always @(posedge rst or posedge clk) begin
    if(rst == 1'b 1) begin
      crc_reg <= {16{1'b0}};
    end
    else
    begin
      if(gen_en == 1'b 1) begin
        crc_reg[15:13]  <= crc_reg[14:12] ;
        crc_reg[12] <= din ^ crc_reg[15] ^ crc_reg[11];
        crc_reg[11:6]  <= crc_reg[10:5] ;
        crc_reg[5] <= din ^ crc_reg[15] ^ crc_reg[4];
        crc_reg[4:1]  <= crc_reg[3:0] ;
        crc_reg[0] <= din ^ crc_reg[15];
      end
      else if(out_en == 1'b 1) begin
        crc_reg[15:1]  <= crc_reg[14:0] ;
        crc_reg[0] <= 1'b 0;
      end
    end
  end


endmodule
