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

// SystemC Test Bench
#include "systemc.h"
#include "verilated_vcd_sc.h"
#include "Vbench.h"

#define TRACE

int sc_main(int argc, char * argv[])
{

#ifdef TRACE
  // Verilator trace file
  Verilated::traceEverOn(true);
  VerilatedVcdSc* tfp = new VerilatedVcdSc;
#endif

  sc_time T(10,SC_NS);
  sc_time Tsim = T * 15 ;
  sc_clock clk("clk",T);
  sc_signal<bool> rstn("rstn");
  Vbench uut("top");
  uut.clk (clk);
  uut.rstn(rstn);

#ifdef TRACE
  // Verilator trace file, depth
  uut.trace(tfp, 10);
  tfp->open("simu.vcd");
#endif

  rstn = 0;
  sc_start(10*T);
  rstn = 1;
  sc_start(Tsim);

#ifdef TRACE
  tfp->close();
#endif
  return 0;
}
