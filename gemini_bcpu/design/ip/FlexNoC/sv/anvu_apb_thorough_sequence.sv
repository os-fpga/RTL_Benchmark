// Copyright (c) 2013-2020 Qualcomm Technologies, Inc. All rights reserved.
// This code contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this code solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this code (including any copies)
// to your licensor.
// This code or portions thereof are protected under U.S. and foreign patent and patent applications.

class anvu_apb_master_thorough_seq extends anvu_apb_sequence #(anvu_apb_master_trans);
	`uvm_object_utils(anvu_apb_master_thorough_seq) 
	rand longint  sAddr    ;
	rand longint  eAddr    ;
	int total = 0;

	function new(string name = "anvu_apb_master_thorough_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		integer direction[2] = '{svt_apb_transaction::READ , svt_apb_transaction::WRITE};
		foreach(direction[k]) begin
			`uvm_create(req)
			if (!( req.randomize() with {
				address                  >= sAddr;
				address+req.nBytePerData <= eAddr;
				xact_type  == direction[k];
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			total += 1;
		end
		`uvm_info("anvu_test",$psprintf("Total transaction sent : %d",total) , uvm_pkg::UVM_MEDIUM)
	endtask
endclass
