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


class anvu_probeConnectivity_test extends uvm_test;
	`uvm_component_utils(anvu_probeConnectivity_test)

	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;

	function new(string name = "anvu_probeConnectivity_test", uvm_component parent);
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
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSOK;
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
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSOK;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocAhbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_ahb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_ahb_rsp_cfg  )::set(this, {"top.bench.",nocAhbTargName[i]}, "rspCfg", rspCfg);
		end
		set_type_override_by_type(svt_apb_master_transaction::get_type(), anvu_apb_master_trans::get_type()                     );
		for (int i=0;i<nocApbTargNb;i++) begin
			anvu_apb_rsp_cfg rspCfg = anvu_apb_rsp_cfg::type_id::create("rspCfg");
			rspCfg.statusBehaviour = anvu_commons_pkg::ALWAYSOK;
			rspCfg.delaysBehaviour = anvu_commons_pkg::DELAYRAND;
			uvm_config_db#(uvm_object_wrapper)::set(this, {"top.bench.",nocApbTargName[i],".sequencer.run_phase"}, "default_sequence", anvu_apb_slave_sequence::type_id::get());
			uvm_config_db#(anvu_apb_rsp_cfg  )::set(this, {"top.bench.",nocApbTargName[i]}, "rspCfg", rspCfg);
		end
	endfunction : build_phase
	

	//! Run the test by starting the virtual sequence.
	task run_phase(uvm_phase phase);
	endtask : run_phase

endclass
