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

class s_debug extends s_anf_base #(shortreal);
  `uvm_object_utils(s_debug)

  // --------------------------------------------------------------------
  task body();
    numeric_frame #(T) f_h;

    // anf_api_h.put_test_pattern("constant", 1.0);
    // anf_api_h.put_test_pattern("constant", 2.0);
    // anf_api_h.put_test_pattern("constant", 3.12);
    // // anf_api_h.put_test_pattern("horizontal");
    // // anf_api_h.put_test_pattern("vertical");
    // // anf_api_h.put_test_pattern("random");

    // f_h = anf_api_h.new_frame();
    // f_h.a_h.set_entry('{1,0}, 1.0);
    // f_h.a_h.set_entry('{2,1}, 1.0);
    // f_h.a_h.set_entry('{3,0}, 1.0);
    // f_h.a_h.set_entry('{3,1}, 1.0);
    // anf_api_h.put_array(f_h);

    // f_h = anf_api_h.new_frame();
    // f_h.a_h.a_2d[1][0] = 1.0;
    // f_h.a_h.a_2d[2][1] = 1.0;
    // f_h.a_h.a_2d[3][0] = 1.0;
    // f_h.a_h.a_2d[3][1] = 1.0;

    // f_h = anf_api_h.new_frame();
    // f_h.a_h.a_2d[0][0] = 0.0;
    // f_h.a_h.a_2d[0][1] = 1.0;
    // f_h.a_h.a_2d[1][0] = 2.0;
    // f_h.a_h.a_2d[1][1] = 3.0;
    // f_h.a_h.a_2d[2][0] = 4.0;
    // f_h.a_h.a_2d[2][1] = 5.0;
    // f_h.a_h.a_2d[3][0] = 6.0;
    // f_h.a_h.a_2d[3][1] = 7.0;

    // anf_api_h.put_array(f_h);
    
    anf_api_h.load_from_file("x_test_0.raw");

    anf_api_h.send_frame_buffer(m_sequencer, this);
    #(300ns);
  endtask: body

// --------------------------------------------------------------------
endclass : s_debug
