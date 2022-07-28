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

package tb_top_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import video_frame_pkg::*;
  import avf_pkg::*;
  import anf_pkg::*;

  // --------------------------------------------------------------------
  localparam DIR = "../../../src/xor/weights";
  localparam B = 4; // BYTES_PER_PIXEL
  localparam T = 1; // pixels per clock
  localparam AW = 2; // active width
  localparam AH = 4; // active height
  localparam N = B * T;
  localparam U = 3;

  // --------------------------------------------------------------------
  `include "../../src/tb_base/tb_dut_config.svh"
  `include "../../src/tb_base/tb_env.svh"
  `include "s_debug.svh"
  `include "../../src/tb_base/t_top_base.svh"
  `include "../../src/tb_base/t_debug.svh"

// --------------------------------------------------------------------
endpackage
