//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Low Pass Filter FIR IP Core                                 ////
////                                                              ////
////  This file is part of the LPFFIR project                     ////
////  https://opencores.org/projects/lpffir                       ////
////                                                              ////
////  Description                                                 ////
////  Implementation of LPFFIR IP core according to               ////
////  LPFFIR IP core specification document.                      ////
////                                                              ////
////  To Do:                                                      ////
////  -                                                           ////
////                                                              ////
////  Author:                                                     ////
////  - Vladimir Armstrong, vladimirarmstrong@opencores.org       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2019 Authors and OPENCORES.ORG                 ////
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

// Full Adder: adds three 1-bit numbers
module fa(
            input        a,
            input        b,
            input        ci, // Carry Input

            output logic co, // Carry Output
            output logic s // Sum
            );

   logic                 d,e,f;

   xor(s,a,b,ci);
   and(d,a,b);
   and(e,b,ci);
   and(f,a,ci);
   or(co,d,e,f);
endmodule
