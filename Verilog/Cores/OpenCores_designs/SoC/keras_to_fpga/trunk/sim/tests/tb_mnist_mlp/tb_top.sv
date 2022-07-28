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

module tb_top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import tb_top_pkg::*;

  // --------------------------------------------------------------------
  wire clk_100mhz;
  wire tb_clk = clk_100mhz;
  wire tb_rst;

  tb_base #(.PERIOD(10_000)) tb(clk_100mhz, tb_rst);

  // --------------------------------------------------------------------
  wire aclk = clk_100mhz;
  wire tb_rst_s;
  wire aresetn = ~tb_rst_s;

  sync_reset sync_reset(aclk, tb_rst, tb_rst_s);

  // --------------------------------------------------------------------
  axis_if #(.N(N), .U(U)) axis_in(.*);
  axis_if #(.N(N), .U(U)) axis_out(.*);
  axis_if #(.N(N), .U(U)) axis_stub(.*);

  // --------------------------------------------------------------------
  mnist_mlp_top #(.N(N), .DIR(DIR)) dut(.*);

  // // --------------------------------------------------------------------
  // bind dut axis_checker #(.N(N), .U(U)) dut_b(.*);

  // --------------------------------------------------------------------
  // tb_dut_config #(N, U) cfg_h = new(axis_in, axis_out);
  tb_dut_config #(N, U) cfg_h = new(axis_in, axis_stub);
  assign axis_out.tready = 1;

  initial
  begin
    cfg_h.init( .pixels_per_line(AW)
              , .lines_per_frame(AH)
              , .bits_per_pixel(B * 8)
              );
    uvm_config_db #(tb_dut_config #(N, U))::set(null, "*", "tb_dut_config", cfg_h);
    run_test("t_debug");

    // repeat(16) @(posedge aclk);
    // $stop;
  end
  
  // // --------------------------------------------------------------------
  // int in_index = 0;
  // real in_data;
  
  // initial
    // fork
      // forever @(negedge aclk)
        // if(axis_in.tvalid & axis_in.tready)
        // begin
          // in_data = $bitstoshortreal(axis_in.tdata);
          // $display("%s", {20{"-"}});
          // $display("%d | binary   |input = %h", in_index, axis_in.tdata);
          // $display("%d | IEEE 754 |input = %9.7F", in_index, in_data);
          // if(axis_in.tlast)
          // begin
            // $display("%s", {20{"+"}});
            // in_index++;
          // end
        // end
    // join_none

  // --------------------------------------------------------------------
  int out_index = 0;
  real out_data;
  
  initial
    fork
      forever @(negedge aclk)
        if(axis_out.tvalid & axis_out.tready)
        begin
          out_data = $bitstoshortreal(axis_out.tdata);
          $display("%s", {20{"-"}});
          $display("%d | binary   |result = %h", out_index, axis_out.tdata);
          $display("%d | IEEE 754 |result = %9.7F", out_index, out_data);
          out_index++;
        end
    join_none

// --------------------------------------------------------------------
endmodule
