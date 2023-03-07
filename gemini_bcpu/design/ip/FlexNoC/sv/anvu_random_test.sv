// Copyright (c) 2013-2020 Qualcomm Technologies, Inc. All rights reserved.
// This RTL contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this RTL solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this RTL (including any copies)
// to your licensor.
// This RTL or portions thereof are protected under U.S. and foreign patent and patent applications.

`include "uvm_macros.svh"

//! This Random virtual sequence, after a bench reset, populates each (non-filtered) initiator sequencer with one random sequence (itself made of 100 lightly constrained transactions) 
class anvu_virtual_random_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_random_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)

	bit restrictedInitFlowId[int];
	longint timeout = 300000;

	function new(string name = "anvu_virtual_random_seq");
		super.new(name);
	endfunction
	task body();
		anvu_top_env   top;

		$cast(top,p_sequencer.get_parent());
		`uvm_info("anvu_test","Starting Random",uvm_pkg::UVM_LOW)

		// perform a noc reset
		top.bench.performNocReset();

		foreach(nocAxiInitName[i]) begin
			fork 
				automatic int j = i;
				begin
					anvu_axi_master_random_seq seq;
					anvu_flow socketFlow  = Flow_fromName(nocAxiInitName[j]);
					int flowId  = socketFlow.id();
					if (restrictedInitFlowId.size()>0 && !restrictedInitFlowId.exists(flowId)) begin
						`uvm_info("anvu_test",$psprintf("%s : Skipped based on command line option",socketFlow.str()),uvm_pkg::UVM_LOW)
					end else begin
						`uvm_do_on(seq,p_sequencer.axiSequencer[j] )
					end
				end
			join_none
		end
		foreach(nocApbInitName[i]) begin
			fork
				automatic int j = i;
				begin
					anvu_apb_master_random_seq seq;
					anvu_flow socketFlow  = Flow_fromName(nocApbInitName[j]);
					int flowId  = socketFlow.id();
					if (restrictedInitFlowId.size()>0 && !restrictedInitFlowId.exists(flowId)) begin
						`uvm_info("anvu_test",$psprintf("%s : Skipped based on command line option",socketFlow.str()),uvm_pkg::UVM_LOW)
					end else begin
						`uvm_do_on(seq,p_sequencer.apbSequencer[j] )
					end
				end
			join_none
		end
		foreach(nocAhbInitName[i]) begin
			fork
				automatic int j = i;
				begin
					anvu_ahb_master_random_seq seq;
					anvu_flow socketFlow  = Flow_fromName(nocAhbInitName[j]);
					int flowId  = socketFlow.id();
					if (restrictedInitFlowId.size()>0 && !restrictedInitFlowId.exists(flowId)) begin
						`uvm_info("anvu_test",$psprintf("%s : Skipped based on command line option",socketFlow.str()),uvm_pkg::UVM_LOW)
					end else begin
						`uvm_do_on(seq,p_sequencer.ahbSequencer[j] )
					end
				end
			join_none
		end

		wait fork;

		#(nocSlowestClkPeriod);  // so that it won't skip wait_flows straigth away, if no sequencer had the time to get any transaction
		top.wait_flows(,timeout);
		top.wait_scoreboard_empty();

		`uvm_info("anvu_test","End of Random",uvm_pkg::UVM_LOW)
		#(50*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.


	endtask
endclass

//! Test the NoC by generating random transaction sequences.
//! For each initiator socket, a sequence of 100 random transactions is created.
//! All sequences are played simultaneously, and the test ends when all transaction have been sent and received.
//! Slave VIP are currently configured to answer random responses (delays and status).
//! The +anvu_test_options supports the named options 'timeout=d' that sets the timeout in nocSlowestClk cycles for wait_flows.
//! Tested initiators can be filtered by using the +anvu_test_options command option. It can be set to a string listing all initiator socket names to be tested separated by space characters.
//! If no initiator names are given in the list, then all initiators are tested.
//! For example, +anvu_test_options="Init_2 Init_1" means that the only connections which will be tested are those starting from Init_1 or Init_2.
class anvu_random_test extends uvm_test;
	`uvm_component_utils(anvu_random_test)

	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;

	function new(string name = "anvu_random_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	//! Build the top test environment, configure initiator VIP to send a random sequence, and configure slave VIP.
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		top = anvu_top_env::type_id::create("top",this);
		anvu_noc_definitions_fillStrArrays();

		set_type_override_by_type(svt_ahb_master_transaction::get_type(), anvu_ahb_master_trans::get_type()                     );
		for (int i=0;i<nocAhbTargNb;i++) begin
			anvu_ahb_rsp_cfg rspCfg = anvu_ahb_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::STATUSRAND;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAhbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_ahb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_ahb_rsp_cfg  )::set(this, {"top.bench.",nocAhbTargName[i]}, "rspCfg", rspCfg);
		end
		set_type_override_by_type(svt_axi_master_transaction::get_type(), anvu_axi_master_trans::get_type()                     );
		for (int i=0;i<nocAxiTargNb;i++) begin
			anvu_axi_rsp_cfg rspCfg = anvu_axi_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::STATUSRAND;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAxiTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_axi_slave_sequence::type_id::get());
			uvm_config_db#(anvu_axi_rsp_cfg  )::set(this, {"top.bench.",nocAxiTargName[i]}, "rspCfg", rspCfg);
		end
		for (int i=0;i<nocAxiInitNb;i++) begin
			if (nocAxiInitInfo[i].version inside {anvu_xactors_pkg::ACE_LITE_DVM,anvu_xactors_pkg::ACE}) 
				uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAxiInitName[i],".snoop_sequencer.run_phase"}, "default_sequence", svt_axi_ace_master_snoop_response_sequence::type_id::get());
		end
		set_type_override_by_type(svt_ahb_master_transaction::get_type(), anvu_ahb_master_trans::get_type()                     );
		for (int i=0;i<nocAhbTargNb;i++) begin
			anvu_ahb_rsp_cfg rspCfg = anvu_ahb_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::STATUSRAND;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAhbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_ahb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_ahb_rsp_cfg  )::set(this, {"top.bench.",nocAhbTargName[i]}, "rspCfg", rspCfg);
		end
		set_type_override_by_type(svt_apb_master_transaction::get_type(), anvu_apb_master_trans::get_type()                     );
		for (int i=0;i<nocApbTargNb;i++) begin
			anvu_apb_rsp_cfg rspCfg = anvu_apb_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::STATUSRAND;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocApbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_apb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_apb_rsp_cfg  )::set(this, {"top.bench.",nocApbTargName[i]}, "rspCfg", rspCfg);
		end
	endfunction : build_phase
	

	//! Run the test.
	task run_phase(uvm_phase phase);
		longint timeout = 300000;
		bit initFlowId[int],targFlowId[int];
		anvu_virtual_random_seq virtSeq = anvu_virtual_random_seq::type_id::create();
		if (nocTestOptionsKeywords.exists("timeout")) begin
			timeout = stringToLongHex(nocTestOptionsKeywords["timeout"]);
		end
		getFlowIdFromTestOptions(initFlowId,targFlowId);
		virtSeq.restrictedInitFlowId = initFlowId;
		virtSeq.timeout              = timeout;
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
        phase.drop_objection(this);
	endtask : run_phase

endclass

