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

module
  xor_top #(N, DIR)
  (
    axis_if axis_in,
    axis_if axis_out,
    input   aclk,
    input   aresetn
  );

  // --------------------------------------------------------------------
  axis_if #(.N(N)) axis_nn_0(.*);
  wire error_0;

  axis_dense #(N, '{2, 8}, "dense", DIR, "ReLU")
    axis_dense_0(.axis_out(axis_nn_0), .error(error_0), .*);

  // --------------------------------------------------------------------
  wire error_1;

  axis_dense #(N, '{8, 1}, "dense_1", DIR, "Linear")
    axis_dense_1(.axis_in(axis_nn_0), .error(error_1), .*);

// --------------------------------------------------------------------
endmodule
