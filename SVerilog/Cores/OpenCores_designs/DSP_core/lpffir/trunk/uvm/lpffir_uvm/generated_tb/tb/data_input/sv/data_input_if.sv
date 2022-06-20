// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_input_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Signal interface for agent data_input
//=============================================================================

`ifndef DATA_INPUT_IF_SV
`define DATA_INPUT_IF_SV

interface data_input_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import data_input_pkg::*;

  logic last;
  logic valid;
  logic ready;
  logic [15:0] data;
  logic clk;
  logic reset;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file data_input.tpl

endinterface : data_input_if

`endif // DATA_INPUT_IF_SV

