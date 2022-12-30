// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_output_agent.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Agent for data_output
//=============================================================================

`ifndef DATA_OUTPUT_AGENT_SV
`define DATA_OUTPUT_AGENT_SV

// You can insert code here by setting agent_inc_before_class in file data_output.tpl

class data_output_agent extends uvm_agent;

  `uvm_component_utils(data_output_agent)

  uvm_analysis_port #(output_tx) analysis_port;

  data_output_config       m_config;
  data_output_sequencer_t  m_sequencer;
  data_output_driver       m_driver;
  data_output_monitor      m_monitor;

  local int m_is_active = -1;

  extern function new(string name, uvm_component parent);

  // You can remove build/connect_phase and get_is_active by setting agent_generate_methods_inside_class = no in file data_output.tpl

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function uvm_active_passive_enum get_is_active();

  // You can insert code here by setting agent_inc_inside_class in file data_output.tpl

endclass : data_output_agent 


function  data_output_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


// You can remove build/connect_phase and get_is_active by setting agent_generate_methods_after_class = no in file data_output.tpl

function void data_output_agent::build_phase(uvm_phase phase);

  // You can insert code here by setting agent_prepend_to_build_phase in file data_output.tpl

  if (!uvm_config_db #(data_output_config)::get(this, "", "config", m_config))
    `uvm_error(get_type_name(), "data_output config not found")

  m_monitor     = data_output_monitor    ::type_id::create("m_monitor", this);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver    = data_output_driver     ::type_id::create("m_driver", this);
    m_sequencer = data_output_sequencer_t::type_id::create("m_sequencer", this);
  end

  // You can insert code here by setting agent_append_to_build_phase in file data_output.tpl

endfunction : build_phase


function void data_output_agent::connect_phase(uvm_phase phase);
  if (m_config.vif == null)
    `uvm_warning(get_type_name(), "data_output virtual interface is not set!")

  m_monitor.vif = m_config.vif;
  m_monitor.analysis_port.connect(analysis_port);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_driver.vif = m_config.vif;
  end

  // You can insert code here by setting agent_append_to_connect_phase in file data_output.tpl

endfunction : connect_phase


function uvm_active_passive_enum data_output_agent::get_is_active();
  if (m_is_active == -1)
  begin
    if (uvm_config_db#(uvm_bitstream_t)::get(this, "", "is_active", m_is_active))
    begin
      if (m_is_active != m_config.is_active)
        `uvm_warning(get_type_name(), "is_active field in config_db conflicts with config object")
    end
    else 
      m_is_active = m_config.is_active;
  end
  return uvm_active_passive_enum'(m_is_active);
endfunction : get_is_active


// You can insert code here by setting agent_inc_after_class in file data_output.tpl

`endif // DATA_OUTPUT_AGENT_SV

