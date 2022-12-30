// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: port_converter.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Analysis port type converter class for use with Syosil scoreboard
//=============================================================================

`ifndef PORT_CONVERTER_SV
`define PORT_CONVERTER_SV


class port_converter #(type T = uvm_sequence_item) extends uvm_subscriber #(T);
  `uvm_component_param_utils(port_converter#(T))

  // For connecting analysis port of monitor to analysis export of Syosil scoreboard

  uvm_analysis_port #(uvm_sequence_item) analysis_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("a_port", this);
  endfunction

  function void write(T t);
    analysis_port.write(t);
  endfunction

endclass


`endif // PORT_CONVERTER_SV

