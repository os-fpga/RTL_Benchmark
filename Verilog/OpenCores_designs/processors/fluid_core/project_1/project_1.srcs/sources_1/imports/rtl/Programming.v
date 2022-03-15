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

`define dR0 5'b0000
`define dR1 5'b0001
`define dR2 5'b0010
`define dR3 5'b0011
`define dR4 5'b0100
`define dR5 5'b0101
`define dR6 5'b0110
`define dR7 5'b0111

`define R0 3'b000
`define R1 3'b001
`define R2 3'b010
`define R3 3'b011
`define R4 3'b100
`define R5 3'b101
`define R6 3'b110
`define R7 3'b111

`define iNone_RRR 'd0
`define iADD_RRR 'd1
`define iADD_RRI 'd2
`define iSUB_RRR 'd3
`define iSUB_RRI 'd4
`define iADC_RRR 'd5
`define iADC_RRI 'd6
`define iSBC_RRR 'd7
`define iSBC_RRI 'd8
`define iAND_RRR 'd9
`define iAND_RRI 'd10
`define iOR_RRR 'd11
`define iOR_RRI 'd12
`define iXOR_RRR 'd13
`define iXOR_RRI 'd14
`define iBranch_RRR 'd15
`define iBranch_RRI 'd16
`define iBranch_RI 'd17
`define iLoad_RRR 'd18
`define iLoad_RRI 'd19
`define iLoad_RI 'd20
`define iStore_sRR 'd21
`define iStore_sRI 'd22
`define iAddVector_RI 'd23
`define iAdduOP_RI 'd24
`define iAdduOP_RRI 'd25
