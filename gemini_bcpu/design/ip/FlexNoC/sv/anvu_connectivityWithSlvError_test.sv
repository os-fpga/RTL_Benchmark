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
`include "anvu_connectivity_test.sv"

//! The goal of this test is to check each individual memory map connections between NoC initiators and masters, one at a time. It generates the following transactions:
//! - For each initiator thread of the NoC
//! - For each segment of the memory map of this initiator, not going to an internal target, and not going 'noWhere'
//! - Try to do 4 transactions, 2 RD, 2 WR, 2 at the bottom of the range, 2 at the top
//! Slave VIP are configured to answer Error responses.
//! Tested initiators and targets can be filtered by using the +anvu_test_options command option. It can be set to a string listing all socket names to be tested separated by space characters.
//! If no initiator names (or target names) are given in the list, then all initiators (or targets) are tested.
//! For example, +anvu_test_options="Init_2 Targ_1 Init_1" means that the only connections which will be tested are those going from Init_1 or Init_2 to Targ_1.   
class anvu_connectivityWithSlvError_test extends uvm_test;
	`uvm_component_utils(anvu_connectivityWithSlvError_test)

	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;

	function new(string name = "anvu_connectivityWithSlvError_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	//! Build the top test environment, and configure slave VIP.
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		top = anvu_top_env::type_id::create("top",this);
		anvu_noc_definitions_fillStrArrays();

		set_type_override_by_type(svt_axi_master_transaction::get_type(), anvu_axi_master_trans::get_type()                     );
		for (int i=0;i<nocAxiTargNb;i++) begin
			anvu_axi_rsp_cfg rspCfg = anvu_axi_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSERR;
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
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSERR;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAhbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_ahb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_ahb_rsp_cfg  )::set(this, {"top.bench.",nocAhbTargName[i]}, "rspCfg", rspCfg);
		end
		set_type_override_by_type(svt_apb_master_transaction::get_type(), anvu_apb_master_trans::get_type()                     );
		for (int i=0;i<nocApbTargNb;i++) begin
			anvu_apb_rsp_cfg rspCfg = anvu_apb_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSERR;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocApbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_apb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_apb_rsp_cfg  )::set(this, {"top.bench.",nocApbTargName[i]}, "rspCfg", rspCfg);
		end
	endfunction : build_phase
	

	//! Run the test by starting the virtual sequence.
	task run_phase(uvm_phase phase);
		bit initFlowId[int],targFlowId[int];
		anvu_virtual_connectivity_seq virtSeq = anvu_virtual_connectivity_seq::type_id::create();
		getFlowIdFromTestOptions(initFlowId,targFlowId);
		virtSeq.restrictedInitFlowId = initFlowId;
		virtSeq.restrictedTargFlowId = targFlowId;
		virtSeq.canGoNowhere = 0;
		virtSeq.slvError     = 1;
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
        phase.drop_objection(this);
	endtask : run_phase

endclass
