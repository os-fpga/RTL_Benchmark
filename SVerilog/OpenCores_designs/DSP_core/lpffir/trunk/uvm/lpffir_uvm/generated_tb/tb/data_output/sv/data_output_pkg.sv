// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_output_pkg.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Package for agent data_output
//=============================================================================

package data_output_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;


  `include "data_output_output_tx.sv"
  `include "data_output_config.sv"
  `include "data_output_driver.sv"
  `include "data_output_monitor.sv"
  `include "data_output_sequencer.sv"
  `include "data_output_coverage.sv"
  `include "data_output_agent.sv"
  `include "data_output_seq_lib.sv"

endpackage : data_output_pkg
