// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_th.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Tue Mar 19 21:50:30 2019
//=============================================================================
// Description: Test Harness
//=============================================================================

module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // You can remove clock and reset below by setting th_generate_clock_and_reset = no in file common.tpl

  // Example clock and reset declarations
  logic clock = 0;
  logic reset;

  // Example clock generator process
  always #10 clock = ~clock;

  // Example reset generator process
  initial
  begin
    reset = 0;         // Active low reset in this example
    #75 reset = 1;
  end

  assign rca_if_0.clk = clock;

  // You can insert code here by setting th_inc_inside_module in file common.tpl

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  rca_if  rca_if_0 ();

  rca uut (
    .a (rca_if_0.a),
    .b (rca_if_0.b),
    .ci(rca_if_0.ci),
    .co(rca_if_0.co),
    .s (rca_if_0.s)
  );

endmodule

