// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_input_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Package for agent data_input
//=============================================================================

package data_input_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "data_input_input_tx.sv"
  `include "data_input_config.sv"
  `include "data_input_driver.sv"
  `include "data_input_monitor.sv"
  `include "data_input_sequencer.sv"
  `include "data_input_coverage.sv"
  `include "data_input_agent.sv"
  `include "data_input_seq_lib.sv"

endpackage : data_input_pkg
