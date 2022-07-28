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
  mnist_mlp_top #(N, DIR)
  (
    axis_if axis_in,
    axis_if axis_out,
    input   aclk,
    input   aresetn
  );

  // --------------------------------------------------------------------
  wire error[7];
  axis_if #(.N(N)) axis_nn[6](.*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{784, 128}, "dense", DIR, "ReLU")
    axis_dense(.axis_out(axis_nn[0]), .error(error[0]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{128, 64}, "dense_1", DIR, "ReLU")
    axis_dense_1(.axis_in(axis_nn[0]), .axis_out(axis_nn[1]), .error(error[1]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{64,  32}, "dense_2", DIR, "ReLU")
    axis_dense_2(.axis_in(axis_nn[1]), .axis_out(axis_nn[2]), .error(error[2]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{32,  16}, "dense_3", DIR, "ReLU")
    axis_dense_3(.axis_in(axis_nn[2]), .axis_out(axis_nn[3]), .error(error[3]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{16,  32}, "dense_4", DIR, "ReLU")
    axis_dense_4(.axis_in(axis_nn[3]), .axis_out(axis_nn[4]), .error(error[4]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{32,  64}, "dense_5", DIR, "ReLU")
    axis_dense_5(.axis_in(axis_nn[4]), .axis_out(axis_nn[5]), .error(error[5]), .*);

  // --------------------------------------------------------------------
  axis_dense #(N, '{64,  10}, "dense_6", DIR, "Linear")
    axis_dense_6(.axis_in(axis_nn[5]), .error(error[6]), .*);

// --------------------------------------------------------------------
endmodule
