// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: reference.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Reference model for use with Syosil scoreboard
//=============================================================================

`ifndef REFERENCE_SV
`define REFERENCE_SV

// You can insert code here by setting ref_model_inc_before_class in file common.tpl


`uvm_analysis_imp_decl(_reference_0)

class reference extends uvm_component;
  `uvm_component_utils(reference)

  uvm_analysis_imp_reference_0 #(input_tx, reference) analysis_export_0; // m_data_input_agent

  uvm_analysis_port #(uvm_sequence_item) analysis_port_0; // m_data_output_agent

  extern function new(string name, uvm_component parent);
  extern function void write_reference_0(input input_tx t);

  // Start of inlined include file generated_tb/tb/include/reference_inc_inside_class.sv
  extern function void send(input_tx t);                                    
  
  int save_pnt = 5;
  logic [15:0] tx_save [0:5];
  int init_flag = 1;  // End of inlined include file

endclass


function reference::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_export_0 = new("analysis_export_0", this);
  analysis_port_0   = new("analysis_port_0",   this);
endfunction : new


// Start of inlined include file generated_tb/tb/include/reference_inc_after_class.sv
function void reference::write_reference_0(input_tx t);
  send(t);
endfunction
  
function void reference::send(input_tx t);
  output_tx tx;
  tx = output_tx::type_id::create("tx");
  if (init_flag == 1)
    begin
      init_flag = 0;
      foreach(tx_save[j])
        tx_save[j] = 0;
    end
  if (save_pnt == 5)
    save_pnt = 0;
  else
  save_pnt++;
  tx_save[save_pnt] = t.data;
  tx.data = tx_save[0] + tx_save[1] + tx_save[2] + tx_save[3] + tx_save[4] + tx_save[5];
  analysis_port_0.write(tx);
  `uvm_info(get_type_name(), $sformatf("Reference Model save_pnt = %0d, data = %0d",save_pnt, tx.data), UVM_HIGH)
endfunction
// End of inlined include file

`endif // REFERENCE_SV

