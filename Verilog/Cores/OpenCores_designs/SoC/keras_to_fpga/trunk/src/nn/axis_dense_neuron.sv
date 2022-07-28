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
  axis_dense_neuron
  #(
    int N,
    int A,
    string FILE_NAME,
    int START,
    int STOP,
    string ACTIVATION
  )
  (
    axis_if axis_in,
    axis_if axis_out,
    output error,
    input   aclk,
    input   aresetn
  );

  // --------------------------------------------------------------------
  axis_if #(4) axis_bias(.*);
  assign axis_bias.tdata = $shortrealtobits(1.0);
  assign axis_bias.tvalid = 1;
  assign axis_bias.tlast = 1;

  // --------------------------------------------------------------------
  axis_if #(4) axis_az(.*);
  axis_if #(4) axis_cat[2](.*);
  axis_alias axis_alias_bias(axis_bias, axis_cat[0]);
  axis_alias axis_alias_in(axis_in, axis_cat[1]);

  axis_catenate #(N)
    axis_catenate_i(.axis_in(axis_cat), .axis_out(axis_az), .*);

  // --------------------------------------------------------------------
  axis_if #(.N(N)) axis_rom(.*);

  axis_rom #(N, A, FILE_NAME, START, STOP)
    axis_rom_i(.axis_out(axis_rom), .*);

  // --------------------------------------------------------------------
  wire [31:0] result;
  wire valid;

  axis_mac axis_mac_i(.axis_ay(axis_rom), .*);

  // --------------------------------------------------------------------
  // ReLU activation function
  // wire [31:0] activation = result[31] ? 0 : result;
  wire [31:0] activation;

  generate
  begin: activation_gen
    if(ACTIVATION == "ReLU")
      relu relu_i(.*);
    else if(ACTIVATION == "Linear")
      linear linear_i(.*);
    else
      initial $stop;
  end
  endgenerate

  // --------------------------------------------------------------------
  wire wr_full;
  wire [(N*8)-1:0] wr_data = activation;
  wire wr_en = valid;
  wire rd_empty;
  wire [(N*8)-1:0] rd_data;
  wire rd_en = axis_out.tvalid & axis_out.tready;

  // tiny_sync_fifo #(N*8) fifo_i(.clk(aclk), .reset(~aresetn), .*);
  wire  [$clog2(64):0] count; // fixme
  sync_fifo #(N*8, 64) fifo_i(.clk(aclk), .reset(~aresetn), .*);  // fix me

  // --------------------------------------------------------------------
  assign axis_out.tvalid = ~rd_empty;
  assign axis_out.tdata = rd_data;
  assign axis_out.tlast = 1;
  assign error = wr_full & valid;

// --------------------------------------------------------------------
endmodule
