// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: rca_if.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Tue Mar 19 21:50:30 2019
//=============================================================================
// Description: Signal interface for agent rca
//=============================================================================

`ifndef RCA_IF_SV
`define RCA_IF_SV

interface rca_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import rca_pkg::*;

  logic [15:0] a;
  logic [15:0] b;
  logic ci;
  logic co;
  logic [15:0] s;
  logic clk;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file rca.tpl

endinterface : rca_if

`endif // RCA_IF_SV

