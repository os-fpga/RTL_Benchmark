//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OMS 8051 cores common output pad Module                     ////
////                                                              ////
////  This file is part of the OMS 8051 cores project             ////
////  http://www.opencores.org/cores/oms8051mini/                 ////
////                                                              ////
////  Description                                                 ////
////  OMS 8051 definitions.                                       ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
////  Revision : Nov 26, 2016                                     //// 
////                                                              ////
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
/*
**---------------------------------------------------------------------
** Title         : wrapper file for Output pad 
** Project       :
**---------------------------------------------------------------------
** File          : OutputPad.v
** Author        : Dinesh A
** Created       : 
** Last modified : 
** Upper Modules/file instantiating this module:  
**---------------------------------------------------------------------
** Modification history :
**
**--------------------------------------------------------------------
*/

module OutputPad (PAD, I);
inout  PAD ;
input I ;

gpio_pads U_OUTPUT_PAD (
                                 .I(I), 
                                 .OEN(1'b0), 
                                 .PAD(PAD), 
                                 .C(), 
                                 .REN(1'b1) 

);

endmodule

