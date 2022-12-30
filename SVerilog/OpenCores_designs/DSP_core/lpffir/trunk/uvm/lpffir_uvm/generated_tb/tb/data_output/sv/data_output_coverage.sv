// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_output_coverage.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Coverage for agent data_output
//=============================================================================

`ifndef DATA_OUTPUT_COVERAGE_SV
`define DATA_OUTPUT_COVERAGE_SV

// You can insert code here by setting agent_cover_inc_before_class in file data_output.tpl

class data_output_coverage extends uvm_subscriber #(output_tx);

  `uvm_component_utils(data_output_coverage)

  data_output_config m_config;    
  bit                m_is_covered;
  output_tx          m_item;
     
  // You can replace covergroup m_cov by setting agent_cover_inc in file data_output.tpl
  // or remove covergroup m_cov by setting agent_cover_generate_methods_inside_class = no in file data_output.tpl

  covergroup m_cov;
    option.per_instance = 1;
    // You may insert additional coverpoints here ...

    cp_data: coverpoint m_item.data;
    //  Add bins here if required

  endgroup

  // You can remove new, write, and report_phase by setting agent_cover_generate_methods_inside_class = no in file data_output.tpl

  extern function new(string name, uvm_component parent);
  extern function void write(input output_tx t);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  // You can insert code here by setting agent_cover_inc_inside_class in file data_output.tpl

endclass : data_output_coverage 


// You can remove new, write, and report_phase by setting agent_cover_generate_methods_after_class = no in file data_output.tpl

function data_output_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  m_is_covered = 0;
  m_cov = new();
endfunction : new


function void data_output_coverage::write(input output_tx t);
  m_item = t;
  if (m_config.coverage_enable)
  begin
    m_cov.sample();
    // Check coverage - could use m_cov.option.goal instead of 100 if your simulator supports it
    if (m_cov.get_inst_coverage() >= 100) m_is_covered = 1;
  end
endfunction : write


function void data_output_coverage::build_phase(uvm_phase phase);
  if (!uvm_config_db #(data_output_config)::get(this, "", "config", m_config))
    `uvm_error(get_type_name(), "data_output config not found")
endfunction : build_phase


function void data_output_coverage::report_phase(uvm_phase phase);
  if (m_config.coverage_enable)
    `uvm_info(get_type_name(), $sformatf("Coverage score = %3.1f%%", m_cov.get_inst_coverage()), UVM_MEDIUM)
  else
    `uvm_info(get_type_name(), "Coverage disabled for this agent", UVM_MEDIUM)
endfunction : report_phase


// You can insert code here by setting agent_cover_inc_after_class in file data_output.tpl

`endif // DATA_OUTPUT_COVERAGE_SV

