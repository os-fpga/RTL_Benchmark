// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_input_driver.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Driver for data_input
//=============================================================================

`ifndef DATA_INPUT_DRIVER_SV
`define DATA_INPUT_DRIVER_SV

// You can insert code here by setting driver_inc_before_class in file data_input.tpl

class data_input_driver extends uvm_driver #(input_tx);

  `uvm_component_utils(data_input_driver)

  virtual data_input_if vif;

  extern function new(string name, uvm_component parent);

  // Start of inlined include file generated_tb/tb/include/data_input_driver_inc_inside_class.sv
  extern task run_phase(uvm_phase phase);
  // End of inlined include file

endclass : data_input_driver 


function data_input_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


// Start of inlined include file generated_tb/tb/include/data_input_driver_inc_after_class.sv
task data_input_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever @(posedge vif.clk)
  begin
    seq_item_port.get_next_item(req);
    phase.raise_objection(this);
    wait (vif.reset == 1);
    vif.data <= req.data;
    vif.valid  <= 1;
    vif.last  <= 0;
    wait (vif.ready == 1);
  
    fork
      begin
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
      end
    join_none
    seq_item_port.item_done();
  end
endtask : run_phase
// End of inlined include file

`endif // DATA_INPUT_DRIVER_SV

