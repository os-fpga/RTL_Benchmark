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

`include "anvu_axi_scoreboard_abstract.sv"
`include "anvu_apb_scoreboard_abstract.sv"
`include "anvu_ahb_scoreboard_abstract.sv"

//! Mode port monitor scoreboard abstractor that will feed the scoreboard with the appropriate change of power state.
class anvu_modePort_scoreboard_abstractor extends uvm_component;
	`uvm_component_utils(anvu_modePort_scoreboard_abstractor)	
	//! Interface used to receive transactions from the monitor
	uvm_analysis_imp #(anvu_signal_transaction,anvu_modePort_scoreboard_abstractor) transaction_port;
	//! The reference to the scoreboard object.
	anvu_nocAip_scoreboard scoreboard;
	
	int modePortValues[];
	
	function new(string name = "anvu_modePort_scoreboard_abstractor" , uvm_component parent);
		super.new(name,parent);
		modePortValues   = new[nocModePortDriverNb];
		transaction_port = new("transaction_port",this);
	endfunction
	
	//! Function executed after receiving a transaction
	virtual function void write( anvu_signal_transaction tr );
		anvu_flow  socketFlow = tr.socketFlow;
		modePortValues[nocModePortDriverIdxByFlowId[socketFlow.id()]] = tr.Signal;
		scoreboard.setMode(getModeFromModePortValues(modePortValues));
	endfunction
endclass

