///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  pp_dcntx8
// File Name:    pp_dcntx8.v
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
`timescale 1ns/1ps

module pp_dcntx8 ( 
                 CLK, 
                 CLR, 
                 D, 
                 EN, 
                 LOAD, 
                 Q
                 );
	 
input CLK;
input CLR;
input [7:0] D;
input EN;
input LOAD;

output [7:0] Q;
reg    [7:0] Q;	 
	 
always@( posedge CLR or posedge CLK )
	begin
      if(CLR)
        begin
          Q <= 8'b00000000;
        end
      else
        begin
		    if(LOAD)
            begin
 			     Q <= D;
 			   end
  			 else if(EN)
			   begin
              Q <= Q - 1;				 
            end				
        end
	end	 
	 
endmodule	 