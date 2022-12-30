// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_test_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Test package for top
//=============================================================================

`ifndef TOP_TEST_PKG_SV
`define TOP_TEST_PKG_SV

package top_test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import data_input_pkg::*;
  import data_output_pkg::*;
  import top_pkg::*;

  `include "top_test.sv"

endpackage : top_test_pkg

`endif // TOP_TEST_PKG_SV

