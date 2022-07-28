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

module tb_top;

  // --------------------------------------------------------------------
  wire clk_100mhz;
  wire tb_clk = clk_100mhz;
  wire tb_rst;

  tb_base #(.PERIOD(10_000)) tb(clk_100mhz, tb_rst);

  // --------------------------------------------------------------------
  wire clk = clk_100mhz;
  wire reset = tb_rst;
  wire aclk = clk;
  wire aresetn = ~reset;

  // --------------------------------------------------------------------
  logic        accumulate = 1; // accumulate.accumulate
  wire [1:0]  aclr = {reset, reset};       //       aclr.aclr
  logic [31:0] ay = $shortrealtobits(5.5);         //         ay.ay
  logic [31:0] az = $shortrealtobits(2.0);         //         az.az
  logic        ena = 1;        //        ena.ena

  // --------------------------------------------------------------------
  wire [31:0] mac_result;      //     result.result

  mac mac(.result(mac_result), .*);

  // --------------------------------------------------------------------
  wire [31:0] subt_result;      //     result.result
  wire [31:0] ax = az;         //         ax.ax

  fp_adder subt(.result(subt_result), .*);

  // --------------------------------------------------------------------
  shortreal mac_result_w;

  always @(mac_result)
  begin
    mac_result_w = $bitstoshortreal(mac_result);
    $display("^^^ %16.t | mac_result | %f\n", $time, mac_result_w);
  end

  // --------------------------------------------------------------------
  shortreal subt_result_w;

  always @(subt_result)
  begin
    subt_result_w = $bitstoshortreal(subt_result);
    $display("^^^ %16.t | subt_result | %f\n", $time, subt_result_w);
  end

  // --------------------------------------------------------------------
  initial
  begin
    $display("^^^ %16.t | Testbench begun.\n", $time);
    wait(~reset)

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(-7563.547);
    az = $shortrealtobits(-10.0);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(436.55);
    az = $shortrealtobits(0.0);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(0.0);
    az = $shortrealtobits(0.0);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(-4.1212);
    az = $shortrealtobits(1.111);

    repeat(16) @(posedge clk);
    accumulate = 0;

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(115444.65456);
    az = $shortrealtobits(654.5425);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(436.55);
    az = $shortrealtobits(0.0);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(0.0);
    az = $shortrealtobits(0.0);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(10.0);
    az = $shortrealtobits(33.333);

    repeat(16) @(posedge clk);
    ay = $shortrealtobits(-4.1212);
    az = $shortrealtobits(1.111);

    repeat(16) @(posedge clk);
    $display("^^^ %16.t | Testbench done.\n", $time);
    $stop();
  end

// --------------------------------------------------------------------
endmodule
