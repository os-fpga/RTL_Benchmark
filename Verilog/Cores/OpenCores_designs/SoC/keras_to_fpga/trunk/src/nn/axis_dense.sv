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
  axis_dense
  #(
    int N,
    int SHAPE[],
    string LAYER,
    string DIR,
    string ACTIVATION
  )
  (
    axis_if axis_in,
    axis_if axis_out,
    wire    error,
    input   aclk,
    input   aresetn
  );

  // --------------------------------------------------------------------
  initial
    $display("### layer: %s SHAPE = (%0.d, %0.d) | (inputs, neurons) | %s", LAYER, SHAPE[0], SHAPE[1], ACTIVATION);

  // --------------------------------------------------------------------
  localparam A = $clog2(SHAPE[0]+1);
  localparam ROM_SIZE = 2**A;
  localparam START = 0;
  localparam STOP = SHAPE[0]+1;
  localparam MA = $clog2(SHAPE[1]); // fixme

  // --------------------------------------------------------------------
  axis_if #(N) axis_neuron[(2**MA)-1:0](.*);
  wire [SHAPE[1]-1:0] neuron_error;

  generate
    for(genvar j = 0; j < 2**MA; j++)
      if(j < SHAPE[1])
      begin: neuron_gen
        localparam FILE_NAME = $sformatf("%s/%s_%0.d.txt", DIR, LAYER, j);
        axis_dense_neuron #(N, A, FILE_NAME, START, STOP, ACTIVATION)
          neuron_i(.axis_out(axis_neuron[j]), .error(neuron_error[j]),  .*);
      end
      else
      begin: dummy_gen
        assign axis_neuron[j].tvalid = 1;
        assign axis_neuron[j].tdata = 0;
        assign axis_neuron[j].tlast = 1;
      end
  endgenerate

  // --------------------------------------------------------------------
  generate
  begin: catenate_gen
    if(SHAPE[1] > 1)
        recursive_axis_catenate #(.N(N), .MA(MA))
          recursive_axis_catenate_i(.axis_in(axis_neuron), .*);
    else
      axis_alias axis_alias_in(axis_neuron[0], axis_out);
  end
  endgenerate

  // --------------------------------------------------------------------
  assign error = |neuron_error;

// --------------------------------------------------------------------
endmodule
