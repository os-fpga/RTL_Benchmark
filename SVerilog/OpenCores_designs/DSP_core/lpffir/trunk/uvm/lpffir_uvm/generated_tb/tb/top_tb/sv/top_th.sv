// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_th.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
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

  assign data_input_if_0.reset  = reset;
  assign data_output_if_0.reset = reset;

  assign data_input_if_0.clk    = clock;
  assign data_output_if_0.clk   = clock;

  // You can insert code here by setting th_inc_inside_module in file common.tpl

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  data_input_if   data_input_if_0 (); 
  data_output_if  data_output_if_0 ();

  lpffir_axis uut (
    .rx_tlast_i (data_input_if_0.last),
    .rx_tvalid_i(data_input_if_0.valid),
    .rx_tready_o(data_input_if_0.ready),
    .rx_tdata_i (data_input_if_0.data),
    .tx_tlast_o (data_output_if_0.last),
    .tx_tvalid_o(data_output_if_0.valid),
    .tx_tready_i(data_output_if_0.ready),
    .tx_tdata_o (data_output_if_0.data),
    .aclk_i     (clock),
    .aresetn_i  (reset)
  );

endmodule

