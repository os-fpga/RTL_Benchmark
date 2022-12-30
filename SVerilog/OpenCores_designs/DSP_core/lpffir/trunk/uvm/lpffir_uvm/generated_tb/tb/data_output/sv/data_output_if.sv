// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_output_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Signal interface for agent data_output
//=============================================================================

`ifndef DATA_OUTPUT_IF_SV
`define DATA_OUTPUT_IF_SV

interface data_output_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import data_output_pkg::*;

  logic last;
  logic valid;
  logic ready;
  logic [15:0] data;
  logic clk;
  logic reset;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file data_output.tpl

endinterface : data_output_if

`endif // DATA_OUTPUT_IF_SV

