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

`ifndef ANVU_CONNECTIVITY_TEST
`define ANVU_CONNECTIVITY_TEST

`include "uvm_macros.svh"

//! This Connectivity sequence, after a bench reset, generates the following transactions:
//! - For each initiator thread of the NoC
//! - For each segment of the memory map of this initiator, not going to an internal target, (and not going 'nowhere', depending on attribute canGoNowhere)
//! - Try to do 4 transactions, 2 RD, 2 WR, 2 at the bottom of the range, 2 at the top.
class anvu_virtual_connectivity_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_connectivity_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	bit restrictedInitFlowId[int];
	bit restrictedTargFlowId[int];
	bit canGoNowhere;
	bit slvError;
	bit subSequence;
	bit switchPwrCtlBackOff;
	bit switchPwrDiscBackOff;

	function new(string name = "anvu_virtual_connectivity_seq");
		super.new(name);
	endfunction
	task body();
		anvu_top_env   top;
		anvu_flow flow;
		anvu_memoryMap_connection connections[$];
		longint maxAddr;
		t_opcode opcodes[2] = '{anvu_noc_definitions_pkg::READ,anvu_noc_definitions_pkg::WRITE};
		eHowHandleInterleav howInter = anvu_commons_pkg::CONNECTIVITY;
		string interleavedPfx;

		$cast(top,p_sequencer.get_parent());
		if (!subSequence) begin
			if (slvError==0) begin `uvm_info("anvu_test","Starting Connectivity"               ,uvm_pkg::UVM_LOW) end
			else             begin `uvm_info("anvu_test","Starting Connectivity with slave err",uvm_pkg::UVM_LOW) end

			// Example here of how to drive the regime clocks of the DUT with the testbench instead of the default Verilog Oscillator
			foreach (top.bench.clkRegimeDriverVip[i]) begin
				top.bench.clkRegimeDriverVip[i].setPeriod( nocClkRegimePsPeriod[i] );  // setFrequency() method can also be used to set the frequency
				top.bench.clkRegimeDriverVip[i].startClock();
				top.bench.clkRegimeDriverVip[i].driveFromTestBench();
			end

			// perform a noc reset
			top.bench.performNocReset();
		end

		// Iterates the memoryMap of each datapath initiator in the NoC
		foreach ( nocMaxAddrByInitFlowId[flowId] ) begin
			int modes[$];
			anvu_flow flow = new(flowId);
			anvu_flow socketFlow = flow.socket();
			if (restrictedInitFlowId.size()>0 && !restrictedInitFlowId.exists(socketFlow.id())) begin
				`uvm_info("anvu_test",$psprintf("%s : Skipped based on command line option",flow.str()),uvm_pkg::UVM_LOW)
				continue;
			end
			if ( !top.bench.isPowerActiveForFlow(flow.socket()) ) begin
				`uvm_info("anvu_test",$psprintf("%s : Skipped, power is OFF for the socket.",flow.str()),uvm_pkg::UVM_LOW)
				continue;
			end
			maxAddr = nocMaxAddrByInitFlowId[flowId];
			`uvm_info("anvu_test",flow.str() ,uvm_pkg::UVM_HIGH)
			if (nocMeaningfullModeByInitFlowId.exists(flow.id()))
				modes = nocMeaningfullModeByInitFlowId[flow.id()];
			else
				modes.push_back(nocDfltMode);
			foreach(modes[i]) begin
				string modePfx = "  ";
				if ( modes[i] == 16'hffff) continue;
				if (nocModeFlagNb>0) begin
					top.bench.setMode( modes[i] );
					`uvm_info("anvu_test",$psprintf("  Mode : %s",getModeStr(modes[i])),uvm_pkg::UVM_LOW)
					modePfx = "    ";
				end
				top.bench.memoryMap.getConnections(flow,maxAddr,howInter,connections);
				foreach ( connections[k] ) begin
					anvu_flow targSocketFlow = connections[k].targFlow.socket();
					if (connections[k].targFlow.isInternal()) continue;
					if (connections[k].targFlow.isNowhere() && canGoNowhere == 0) continue;
					if (connections[k].isInterleavedStripe()) interleavedPfx = "       ";
					else                                      interleavedPfx = "";
					if (connections[k].isStartInterleavedRange()) begin
						`uvm_info("anvu_test",$psprintf("%s[%x:%x] -> Interleaved Targets :%s",modePfx,connections[k].initStartAddr,connections[k].initEndAddr,connections[k].interleavedTargetsListStr()),uvm_pkg::UVM_LOW)
						continue;
					end
					if (restrictedTargFlowId.size()>0 && !restrictedTargFlowId.exists(targSocketFlow.id())) begin
						`uvm_info("anvu_test",$psprintf("%s%s[%x:%x] -> %s : Skipped based on command line option"
						,	interleavedPfx
						,	modePfx
						,	connections[k].initStartAddr,connections[k].initEndAddr
						,	connections[k].targFlow.str()
						),uvm_pkg::UVM_LOW);
						continue;
					end
					`uvm_info("anvu_test",$psprintf("%s%s[%x:%x] -> %s"
					,	interleavedPfx
					,	modePfx
					,	connections[k].initStartAddr,connections[k].initEndAddr
					,	connections[k].targFlow.str()
					),uvm_pkg::UVM_LOW);
					for (int securityLevel = 0;securityLevel<nocSecurityLevelNb;securityLevel++) begin
						bit reachable = ( (securityLevel&nocReachableSecurityMasksByInitFlowId[flow.id()]) == (nocReachableSecurityBasesByInitFlowId[flow.id()]&nocReachableSecurityMasksByInitFlowId[flow.id()]) );
						if (!reachable) continue;
						foreach(opcodes[l]) begin
							if (!nocOpcodesByInitFlowId[flow.id()][l]) continue;
							`uvm_info("anvu_test",$psprintf("%s%s    %s %s -> %s"
							,	interleavedPfx
							,	modePfx
							,	(opcodes[l] == anvu_noc_definitions_pkg::READ?"RD":"WR") , getSecurityLevelStr(securityLevel)
							,	connections[k].reachedTargStr(opcodes[l],securityLevel)
							),uvm_pkg::UVM_LOW);
							if (opcodes[l] == anvu_noc_definitions_pkg::WRITE && connections[k].targFlow.areWriteRestricted()) begin
								`uvm_info("anvu_test",$psprintf("%s%s         SKIPPED. Write accesses are restricted on target.",interleavedPfx,modePfx),uvm_pkg::UVM_LOW)
								continue;
							end
							case (nocSocketTypeByFlowId[flow.id()])
								anvu_commons_pkg::AXI: begin
									anvu_axi_master_connectivity_seq seq = anvu_axi_master_connectivity_seq::type_id::create();
									seq.startAddr    = connections[k].initStartAddr;
									seq.endAddr      = connections[k].initEndAddr;
									seq.opcode       = opcodes[l];
									seq.flow         = flow;
									seq.securityBase = securityLevel;
									seq.securityMask = nocSecurityLevelNb-1;
									seq.start(p_sequencer.axiSequencer[nocAxiInitIdxByFlowId[flowId]]);
								end
								anvu_commons_pkg::APB: begin
									anvu_apb_master_connectivity_seq seq = anvu_apb_master_connectivity_seq::type_id::create();
									seq.startAddr    = connections[k].initStartAddr;
									seq.endAddr      = connections[k].initEndAddr;
									seq.opcode       = opcodes[l];
									seq.securityBase = securityLevel;
									seq.securityMask = nocSecurityLevelNb-1;
									seq.start(p_sequencer.apbSequencer[nocApbInitIdxByFlowId[flowId]]);
								end
								anvu_commons_pkg::AHB: begin
									anvu_ahb_master_connectivity_seq seq = anvu_ahb_master_connectivity_seq::type_id::create();
									seq.startAddr    = connections[k].initStartAddr;
									seq.endAddr      = connections[k].initEndAddr;
									seq.opcode       = opcodes[l];
									seq.securityBase = securityLevel;
									seq.securityMask = nocSecurityLevelNb-1;
									seq.start(p_sequencer.ahbSequencer[nocAhbInitIdxByFlowId[flowId]]);
								end
							endcase
							top.wait_flow(flow);
							top.wait_scoreboard_empty();

						end
					end
				end
			end
			if (restrictedInitFlowId.size()==0 || (restrictedInitFlowId.size()>0 && restrictedInitFlowId.exists(socketFlow.id()))) begin
				top.bench.memoryMap.findNotriggedPaths(flow,modes);
			end
		end
		if (!subSequence) begin
			#(5*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.
			// We perform a noc reset just to have 1->0 coverage
			top.bench.performNocReset();
			`uvm_info("anvu_test","End of Connectivity",uvm_pkg::UVM_LOW)
			#(5*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.
		end
	endtask
endclass


//! The goal of this test is to check each individual memory map connections between NoC initiators and masters, one at a time. It generates the following transactions:
//! - For each initiator thread of the NoC
//! - For each segment of the memory map of this initiator, not going to an internal target
//! - Try to do 4 transactions, 2 RD, 2 WR, 2 at the bottom of the range, 2 at the top
//! Slave VIP are configured to answer fast OK responses.
//! Tested initiators and targets can be filtered by using the +anvu_test_options command option. It can be set to a string listing all socket names to be tested separated by space characters.
//! If no initiator names (or target names) are given in the list, then all initiators (or targets) are tested.
//! For example, +anvu_test_options="Init_2 Targ_1 Init_1" means that the only connections which will be tested are those going from Init_1 or Init_2 to Targ_1.   
class anvu_connectivity_test extends uvm_test;
	`uvm_component_utils(anvu_connectivity_test)

	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;

	function new(string name = "anvu_connectivity_test", uvm_component parent);
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
		bit initFlowId[int],targFlowId[int];
		anvu_virtual_connectivity_seq virtSeq = anvu_virtual_connectivity_seq::type_id::create();
		getFlowIdFromTestOptions(initFlowId,targFlowId);
		virtSeq.restrictedInitFlowId = initFlowId;
		virtSeq.restrictedTargFlowId = targFlowId;
		virtSeq.canGoNowhere = 1;
		virtSeq.slvError     = 0;
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
        phase.drop_objection(this);
	endtask : run_phase

endclass

`endif // ANVU_CONNECTIVITY_TEST
