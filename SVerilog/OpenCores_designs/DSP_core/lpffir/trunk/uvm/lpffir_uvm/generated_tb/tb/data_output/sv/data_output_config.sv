// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_output_config.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Configuration for agent data_output
//=============================================================================

`ifndef DATA_OUTPUT_CONFIG_SV
`define DATA_OUTPUT_CONFIG_SV

// You can insert code here by setting agent_config_inc_before_class in file data_output.tpl

class data_output_config extends uvm_object;

  // Do not register config class with the factory

  virtual data_output_if   vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  // You can insert variables here by setting config_var in file data_output.tpl

  // You can remove new by setting agent_config_generate_methods_inside_class = no in file data_output.tpl

  extern function new(string name = "");

  // You can insert code here by setting agent_config_inc_inside_class in file data_output.tpl

endclass : data_output_config 


// You can remove new by setting agent_config_generate_methods_after_class = no in file data_output.tpl

function data_output_config::new(string name = "");
  super.new(name);
endfunction : new


// You can insert code here by setting agent_config_inc_after_class in file data_output.tpl

`endif // DATA_OUTPUT_CONFIG_SV

