//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2018 Authors and OPENCORES.ORG                 ////
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

class tb_dut_config #(N, U);

  avf_config #(N, U) m_cfg_h; // master
  avf_config #(N, U) s_cfg_h; // slave

  // --------------------------------------------------------------------
  //
  function void init
  ( int pixels_per_line
  , int lines_per_frame
  , int bits_per_pixel
  );
    m_cfg_h.init( pixels_per_line
                , lines_per_frame
                , bits_per_pixel
                );
    s_cfg_h.init( pixels_per_line
                , lines_per_frame
                , bits_per_pixel
                );
  endfunction: init


  // --------------------------------------------------------------------
  function new(virtual axis_if #(.N(N), .U(U)) m_vif, virtual axis_if #(.N(N), .U(U)) s_vif);
    m_cfg_h = new(m_vif, UVM_ACTIVE);
    s_cfg_h = new(s_vif, UVM_ACTIVE);
  endfunction : new

// --------------------------------------------------------------------
endclass : tb_dut_config
