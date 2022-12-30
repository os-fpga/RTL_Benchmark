// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: data_input_seq_item.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2016-04-18-EP on Sat Apr 27 13:59:59 2019
//=============================================================================
// Description: Sequence item for data_input_sequencer
//=============================================================================

`ifndef DATA_INPUT_SEQ_ITEM_SV
`define DATA_INPUT_SEQ_ITEM_SV

// You can insert code here by setting trans_inc_before_class in file data_input.tpl

class input_tx extends uvm_sequence_item; 

  `uvm_object_utils(input_tx)

  // To include variables in copy, compare, print, record, pack, unpack, and compare2string, define them using trans_var in file data_input.tpl
  // To exclude variables from compare, pack, and unpack methods, define them using trans_meta in file data_input.tpl

  // Transaction variables
  rand logic [15:0] data;
  constraint c_data { 0 <= data; data < 128; }


  extern function new(string name = "");

  // You can remove do_copy/compare/print/record and convert2string method by setting trans_generate_methods_inside_class = no in file data_input.tpl
  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();

  // You can insert code here by setting trans_inc_inside_class in file data_input.tpl

endclass : input_tx 


function input_tx::new(string name = "");
  super.new(name);
endfunction : new


// You can remove do_copy/compare/print/record and convert2string method by setting trans_generate_methods_after_class = no in file data_input.tpl

function void input_tx::do_copy(uvm_object rhs);
  input_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  data = rhs_.data;
endfunction : do_copy


function bit input_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  input_tx rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("data", data, rhs_.data, $bits(data));
  return result;
endfunction : do_compare


function void input_tx::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void input_tx::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  // Use the record macros to record the item fields:
  `uvm_record_field("data", data)
endfunction : do_record


function void input_tx::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(data) 
endfunction : do_pack


function void input_tx::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(data) 
endfunction : do_unpack


function string input_tx::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "data = 'h%0h  'd%0d\n"},
    get_full_name(), data, data);
  return s;
endfunction : convert2string


// You can insert code here by setting trans_inc_after_class in file data_input.tpl

`endif // DATA_INPUT_SEQ_ITEM_SV

