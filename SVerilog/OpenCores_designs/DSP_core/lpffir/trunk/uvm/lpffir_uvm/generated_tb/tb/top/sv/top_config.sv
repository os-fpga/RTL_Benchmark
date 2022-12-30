// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_config.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Configuration for top
//=============================================================================

`ifndef TOP_CONFIG_SV
`define TOP_CONFIG_SV

// You can insert code here by setting top_env_config_inc_before_class in file common.tpl

class top_config extends uvm_object;

  // Do not register config class with the factory

  rand data_input_config   m_data_input_config; 
  rand data_output_config  m_data_output_config;

  // You can insert variables here by setting config_var in file common.tpl

  // You can remove new by setting top_env_config_generate_methods_inside_class = no in file common.tpl

  extern function new(string name = "");

  // You can insert code here by setting top_env_config_inc_inside_class in file common.tpl

endclass : top_config 


// You can remove new by setting top_env_config_generate_methods_after_class = no in file common.tpl

function top_config::new(string name = "");
  super.new(name);

  m_data_input_config                  = new("m_data_input_config"); 
  m_data_input_config.is_active        = UVM_ACTIVE;                 
  m_data_input_config.checks_enable    = 1;                          
  m_data_input_config.coverage_enable  = 1;                          

  m_data_output_config                 = new("m_data_output_config");
  m_data_output_config.is_active       = UVM_ACTIVE;                 
  m_data_output_config.checks_enable   = 1;                          
  m_data_output_config.coverage_enable = 0;                          

  // You can insert code here by setting top_env_config_append_to_new in file common.tpl

endfunction : new


// You can insert code here by setting top_env_config_inc_after_class in file common.tpl

`endif // TOP_CONFIG_SV

