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

//! This Throrough sequence, after a bench reset, generates the following transactions:
//! - For each initiator to be tested
//! - For each segment of the memory map of this initiator, not going to 'nowhere' or to an internal target, or an already tested target
//! - Create the transaction sequences that crosses all commands all sizes and burst lengths.
class anvu_virtual_thorough_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_thorough_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	bit restrictedInitFlowId[int];
	bit restrictedTargFlowId[int];

	function new(string name = "anvu_virtual_thorough_seq");
		super.new(name);
	endfunction
	task body();
		anvu_top_env   top;
		anvu_flow flow;
		anvu_memoryMap_connection connections[$];
		longint maxAddr;
		bit seenTargFlow[int];
		eHowHandleInterleav howInter = anvu_commons_pkg::ONECONPERTARG;
		string interleavedPfx;

		$cast(top,p_sequencer.get_parent());
		`uvm_info("anvu_test","Starting Thorough",uvm_pkg::UVM_LOW)

		// perform a noc reset
		top.bench.performNocReset();
		top.bench.setMode(nocDfltMode);
		if (nocModeFlagNb>0) begin
			`uvm_info("anvu_test",$psprintf("Mode : %s",getModeStr(0)),uvm_pkg::UVM_LOW)
		end


		foreach ( nocMaxAddrByInitFlowId[flowId] ) begin
			anvu_flow flow = new(flowId);
			anvu_flow socketFlow = flow.socket();
			if (restrictedInitFlowId.size()>0 && !restrictedInitFlowId.exists(socketFlow.id())) begin
				`uvm_info("anvu_test",$psprintf("%s : Skipped based on command line option",flow.str()),uvm_pkg::UVM_LOW)
				continue;
			end
			case (nocSocketTypeByFlowId[flow.id()])
				default:;
			endcase
			maxAddr = nocMaxAddrByInitFlowId[flowId];
			seenTargFlow.delete();
			`uvm_info("anvu_test",flow.str() ,uvm_pkg::UVM_LOW)
			top.bench.memoryMap.getConnections(flow,maxAddr,howInter,connections);
			foreach ( connections[k] ) begin
				anvu_flow targSocketFlow = connections[k].targFlow.socket();
				if (
					connections[k].targFlow.isNowhere()
				||  (connections[k].wrSecurityNoLevel && connections[k].rdSecurityNoLevel)  // 'ERR' connection
				||	(connections[k].targFlow.isInternal() && restrictedTargFlowId.size() == 0 && restrictedInitFlowId.size() == 0)   // We skip internal targets in the Thorough only when this is a full thorough test without any command line options
				) continue;
				if (connections[k].isInterleavedStripe()) interleavedPfx = "       ";
				else                                      interleavedPfx = "";
				if (connections[k].isStartInterleavedRange()) begin
					`uvm_info("anvu_test",$psprintf("  [%x:%x] -> Interleaved Targets :%s"
					,	connections[k].initStartAddr
					,	connections[k].initEndAddr
					,	connections[k].interleavedTargetsListStr()),uvm_pkg::UVM_LOW);
					continue;
				end
				if (restrictedTargFlowId.size()>0 && !restrictedTargFlowId.exists(targSocketFlow.id())) begin
					`uvm_info("anvu_test",$psprintf("  %s[%x:%x] -> %s : Skipped based on command line option"
					,	interleavedPfx
					,	connections[k].initStartAddr,connections[k].initEndAddr
					,	connections[k].targFlow.str()
					),uvm_pkg::UVM_LOW);
					continue;
				end
				if (seenTargFlow.exists(connections[k].targFlow.id())) begin
					`uvm_info("anvu_test",$psprintf("  %s[%x:%x] -> %s : Target already tested for this initiator. It is skipped."
					,	interleavedPfx
					,	connections[k].initStartAddr,connections[k].initEndAddr
					,	connections[k].targFlow.str()
					),uvm_pkg::UVM_LOW);
					continue; 
				end
				else seenTargFlow[connections[k].targFlow.id()] = 1;
				`uvm_info("anvu_test",$psprintf("  %s[%x:%x] -> %s"
				,	interleavedPfx
				,	connections[k].initStartAddr,connections[k].initEndAddr
				,	connections[k].targFlow.str()
				),uvm_pkg::UVM_LOW);
				case (nocSocketTypeByFlowId[flow.id()])
					anvu_commons_pkg::AXI: begin
						anvu_axi_master_thorough_seq seq = anvu_axi_master_thorough_seq::type_id::create();
						seq.sAddr = connections[k].initStartAddr;
						seq.eAddr = connections[k].initEndAddr;
						seq.flow  = flow;
						seq.start(p_sequencer.axiSequencer[nocAxiInitIdxByFlowId[flowId]]);
					end
					anvu_commons_pkg::APB: begin
						anvu_apb_master_thorough_seq seq = anvu_apb_master_thorough_seq::type_id::create();
						seq.sAddr = connections[k].initStartAddr;
						seq.eAddr = connections[k].initEndAddr;
						seq.start(p_sequencer.apbSequencer[nocApbInitIdxByFlowId[flowId]]);
					end
					anvu_commons_pkg::AHB: begin
						anvu_ahb_master_thorough_seq seq;
						`uvm_do_on_with(seq,p_sequencer.ahbSequencer[nocAhbInitIdxByFlowId[flowId]], {
							sAddr == connections[k].initStartAddr;
							eAddr == connections[k].initEndAddr;
						});
					end
					default:;
				endcase
				top.wait_flow(flow);
				top.wait_scoreboard_empty();
			end
		end
		`uvm_info("anvu_test","End of Thorough",uvm_pkg::UVM_LOW)
		#(5*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.
	endtask
endclass


//! The goal of this test is to do a crossing of command type, command length and command size.
//! - For each initiator to be tested
//! - For each segment of the memory map of this initiator, not going to 'nowhere' or to an internal target, or an already tested target
//! Slave VIP are currently configured to answer fast OK responses.
//! Tested initiators and targets can be filtered by using the +anvu_test_options command option. It can be set to a string listing all socket names to be tested separated by space characters.
//! If no initiator names (or target names) are given in the list, then all initiators (or targets) are tested.
//! For example, +anvu_test_options="Init_2 Targ_1 Init_1" means that the only connections which will be tested are those going from Init_1 or Init_2 to Targ_1.   
//! The +anvu_test_options supports the named options 'withSlaveErrors=1', when 1 the slaves are configured to answer errors, when undefined or 0, slaves are configured to answer ok
class anvu_thorough_test extends uvm_test;
	`uvm_component_utils(anvu_thorough_test)

	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;

	function new(string name = "anvu_thorough_test", uvm_component parent);
		super.new(name,parent);
	endfunction

	//! Build the top test environment, and configure slave VIP.
	function void build_phase(uvm_phase phase);
		bit withSlvErr;
		super.build_phase(phase);
		top = anvu_top_env::type_id::create("top",this);
		anvu_noc_definitions_fillStrArrays();

		withSlvErr = nocTestOptionsKeywords["withSlaveErrors"].atoi();

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
		bit initFlowId[int],targFlowId[int];
		anvu_virtual_thorough_seq virtSeq = anvu_virtual_thorough_seq::type_id::create();
		getFlowIdFromTestOptions(initFlowId,targFlowId);
		virtSeq.restrictedInitFlowId = initFlowId;
		virtSeq.restrictedTargFlowId = targFlowId;
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
        phase.drop_objection(this);
	endtask : run_phase

endclass
