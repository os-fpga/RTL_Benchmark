///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  bipadoff_pp
// File Name:    bipadoff_pp.v
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
module bipadoff_pp( 
               A2,
					EN, 
					FFCLK, 
					FFCLR, 
					O_EN,
               P_FB,					
					Q, 
					P,
					sd_clock_en
					);
					
input A2;
input EN;

input FFCLK; 
input FFCLR;
input O_EN;    //FF enable signal

inout P;
input sd_clock_en;

output P_FB;
output Q;

wire EN_n;
wire test1;
wire test2;

wire clk_inv;
wire clk_inv1;
wire clk_inv2;
wire clk_inv3;
wire resetn;

reg A2_flopped;

assign EN_n = ~EN;
assign resetn = ~FFCLR;

always @(posedge FFCLK or posedge FFCLR)
  begin
    if (FFCLR)
	   A2_flopped <= 1'b0;
	 else
	   if(O_EN)
        A2_flopped <= A2;
  end

assign Q = clk_inv2;
assign P_FB = test1;


/*    mux2x0 CLK_MUX_DELAY ( //pragma attribute CLK_MUX_DELAY dont_touch true 
                 .A( 1'b0 ), 
                 .B( test1 ), 
                 .S( sd_clock_en ), 
                 .Q( clk_inv1 )  
                 ) ; */

assign clk_inv1=(sd_clock_en)?1'b0:test1;
assign clk_inv2 = clk_inv1;
assign test1 = A2_flopped;			    

/*    bipad IOBUF_inst( //pragma attribute IOBUF_inst dont_touch true
                    .Q( test2 ),     //Buffer output (signal coming out of the tristate buffer)
                    .P(  P  ),   //inout (connect directly to io pad)
                    .A(   test1   ),     //Buffer input (signal going into tristate buffer)
                    .EN(   EN   )      // 1 means output enabled
                  ); */

assign P = EN ? test1 : 8'b0 ;
assign test2  = test1;

endmodule 





