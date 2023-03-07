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
import anvu_json_pkg::*;

//! Virtual sequence which send transactions to NoC registers (sequentially), according to the accesses[$] list.
class anvu_virtual_registerAccesses_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_registerAccesses_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	anvu_top_env   top;
	anvu_registerMap_access accesses[$];
	function new(string name = "anvu_virtual_registerAccesses_seq");
		super.new(name);
	endfunction
	task body();
		int currentMode = 0;
		bit done=1;
		longint prevAddr;
		bit prevIsWrite;
		foreach(accesses[i]) begin
			automatic int initFlowId = accesses[i].initFlowId;
			anvu_flow expFlow = new(accesses[i].initFlowId);
			
			if (accesses[i].mode != currentMode) begin
				top.bench.setMode( accesses[i].mode );
				currentMode = accesses[i].mode;
			end
			if (!done && prevIsWrite && accesses[i].address==prevAddr) begin
				`uvm_warning("anvu_test",$psprintf("Skipping, previous write access from %s to 0x%x not performed, not sending the next READ to same address.",expFlow.str(),accesses[i].address))
				continue;
			end
			prevIsWrite=accesses[i].write;
			prevAddr=accesses[i].address;	
			if (accesses[i].write) begin
				`uvm_info("anvu_test",$psprintf("%s 0x%0x WR value %8x with mask %8x",expFlow.str(),accesses[i].address,accesses[i].dataValue,accesses[i].dataMask),uvm_pkg::UVM_LOW)
			end else begin
				`uvm_info("anvu_test",$psprintf("%s 0x%0x , expect %8x with mask %8x",expFlow.str(),accesses[i].address,accesses[i].dataValue,accesses[i].dataMask),uvm_pkg::UVM_LOW)
			end
			p_sequencer.sendRegisterMapTransaction(accesses[i],done);
		end
	endtask
endclass

//! Virtual sequence whose function is to parse RegisterAccesses.json file to list accesses to NoC registers.
//! It then creates and starts another virual sequence which will send transactions to those registers.
class anvu_virtual_registerMap_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_registerMap_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	anvu_top_env   top;
	function new(string name = "anvu_virtual_registerMap_seq");
		super.new(name);
	endfunction

	function bit isAccessLegal(int initFlowId);

		case (nocSocketTypeByFlowId[initFlowId])
			anvu_commons_pkg::AXI: begin
				anvu_axi_init_info axiInfo = nocAxiInitInfoByFlowId[initFlowId];
				if(axiInfo.wData < 'h20 || (axiInfo.wData > 'h20 && axiInfo.version ==  anvu_xactors_pkg::AXI_LITE)) begin
					return 0;
				end
				else return 1;
			end
			anvu_commons_pkg::APB: begin
				anvu_apb_init_info apbInfo = nocApbInitInfoByFlowId[initFlowId];			
				if(apbInfo.wData <'h20) begin
					return 0;
				end
				else return 1;
			end
			anvu_commons_pkg::AHB: begin
				anvu_ahb_init_info ahbInfo = nocAhbInitInfoByFlowId[initFlowId];				
				if(ahbInfo.wData <'h20) begin
					return 0;
				end
				else return 1;
			end
			default: return 1;
		endcase

	endfunction
	//! Creates a list of registerMap accesses from the content of the fileName.
	//! Expected format of the file is Json
	function void readRegisterMapAccesses(string fileName, output anvu_registerMap_access registerMapAccesses[$]);
		chandle doc;
		anvu_flow initFlow;
		longint mode, dataMask, dataValue;
		bit done=1;
		longint initId;
		int sizeMode, indexMode;
		int sizeBaseAddress, indexBaseAddress;
		int sizeDict,indexRegister;
		string currentRegister;
		int count_queue = 1;
		anvu_registerMap_access access;
		doc = openJson(fileName);

		//Generate Queue Accesses for RD Only
		foreach(nocInitServiceNetwork[i]) begin
			initId 		= initiatorId(doc, nocInitServiceNetwork[i]);
			initFlow 	= Flow_fromNameAndIdx(nocInitServiceNetwork[i],initId);
			if (initFlow.isNowhere()) begin
				`uvm_error("anvu_test",$psprintf("Initiator information '%s %d' does not reference a valid initiator.",nocInitServiceNetwork[i],initId))
				break;
			end
			if(isAccessLegal(initFlow.id()) == 0) begin
				`uvm_warning("anvu_test",$psprintf("Initiator Width Data is smaller than 32bit, ignoring this initiator"));
				continue;
			end
			// For each access with a specific mode, the base address will be in the same index accordinly for the mode
			foreach(nocTargServiceNetwork[j]) begin
				if(validTarget(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j])) begin
					sizeMode = numberOfMode(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j]);
					sizeBaseAddress = numberOfMode(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j]);
					for(indexMode = 0; indexMode<sizeMode; indexMode++) begin
						sizeDict 	= sizeTarget(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j]);
						for(indexRegister = 0; indexRegister < sizeDict; indexRegister++ ) begin
							currentRegister = registerName(doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j],indexRegister);
							mode = modeAccessTarget (doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j], indexMode);

							access.mode 				= mode;
							access.initFlowId 			= initFlow.id();
							access.securityLevel        = 0;
							
							dataValue 	= registerResetValue(doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
							dataMask 	= registerResetMask (doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
							access 		= setRegisterAccessRead(doc, access, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister, dataValue, dataMask, indexMode);
							`uvm_info("anvu_test",$psprintf("Queue %d %p .",count_queue,access),uvm_pkg::UVM_LOW);
							registerMapAccesses.push_back(access);
							count_queue = count_queue + 1;
						end
					end
				end
			end
		end

		//Generate Queue Accesses for WR/RD
		foreach(nocInitServiceNetwork[i]) begin
			initId 		= initiatorId(doc, nocInitServiceNetwork[i]);
			initFlow 	= Flow_fromNameAndIdx(nocInitServiceNetwork[i],initId);
			if (initFlow.isNowhere()) begin
				`uvm_error("anvu_test",$psprintf("Initiator information '%s %d' does not reference a valid initiator.",nocInitServiceNetwork[i],initId))
				break;
			end
			if(isAccessLegal(initFlow.id()) == 0) begin
				`uvm_warning("anvu_test",$psprintf("Initiator  Width Data is smaller than 32bit, ignoring this initiator"));
				continue;
			end
			foreach(nocTargServiceNetwork[j]) begin
				if(validTarget(doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j])) begin
					sizeDict 	= sizeTarget(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j]);
					sizeMode 	= numberOfMode(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j]);
					for( indexMode = 0; indexMode < sizeMode; indexMode++) begin
						for(indexRegister = 0; indexRegister < sizeDict; indexRegister++) begin
							currentRegister = registerName(doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j],indexRegister);
							if(registerWR(doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister) == 1) begin

								mode = modeAccessTarget (doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j], indexMode);
								
								access.mode 				= mode;
								access.initFlowId 			= initFlow.id();
								access.securityLevel 		= 0;
								
								//first WR
								dataValue 	= setWrValue(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister);
								dataMask	= setWrMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister);
								access 		= setRegisterAccessWrite(doc, access, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister, dataValue, dataMask, indexMode);
								`uvm_info("anvu_test",$psprintf("Queue %d:  %p ",count_queue,access),uvm_pkg::UVM_LOW);
								registerMapAccesses.push_back(access);
								count_queue = count_queue + 1;

								//first RD
								dataValue 	= setWrValue(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister);
								dataMask	= setWrMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister);
								access 		= setRegisterAccessRead(doc, access, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister, dataValue, dataMask, indexMode);
								`uvm_info("anvu_test",$psprintf("Queue %d:  %p ",count_queue,access),uvm_pkg::UVM_LOW);
								registerMapAccesses.push_back(access);
								count_queue = count_queue + 1;

								//second WR
								dataValue 	= registerResetValue(doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
								dataMask 	= registerResetMask (doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
								access 		= setRegisterAccessWrite(doc, access, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister, dataValue, dataMask, indexMode);
								`uvm_info("anvu_test",$psprintf("Queue %d:  %p ",count_queue,access),uvm_pkg::UVM_LOW);
								registerMapAccesses.push_back(access);
								count_queue = count_queue + 1;

								//second RD 
								dataValue 	= registerResetValue(doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
								dataMask 	= registerResetMask (doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],currentRegister);
								access      = setRegisterAccessRead(doc, access, nocInitServiceNetwork[i], nocTargServiceNetwork[j], currentRegister, dataValue, dataMask, indexMode);
								`uvm_info("anvu_test",$psprintf("Queue %d:  %p ",count_queue,access),uvm_pkg::UVM_LOW);
								registerMapAccesses.push_back(access);
								count_queue = count_queue + 1;
							end
						end
					end
				end
			end
		end

	endfunction
	
	//! Generates accesses list from RegisterAccesses.json, creates and starts a virtual sequence to those acceses.
	//! Ends when all transactions have been sent and received.
	task body();
		anvu_registerMap_access accesses[$];
		anvu_virtual_registerAccesses_seq regAccessesSeq;
		
		$cast(top,p_sequencer.get_parent());
		
		`uvm_info("anvu_test","Starting RegisterMap",uvm_pkg::UVM_LOW)
		
		readRegisterMapAccesses({top.txtFilesDir,"/RegisterMap.json"},accesses);
		// perform a noc reset
		top.bench.performNocReset();
		// Perform all accesses
		regAccessesSeq = anvu_virtual_registerAccesses_seq::type_id::create();
		regAccessesSeq.top = top;
		regAccessesSeq.accesses = accesses;
		regAccessesSeq.start(top.virtual_sequencer);
		// Wait  for all to be done
		top.wait_scoreboard_empty();
		`uvm_info("anvu_test","End of RegisterMap",uvm_pkg::UVM_LOW)
		#(5*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.
	endtask
endclass

//! The goal of this diagnostic is to check configuration registers inside the NoC. The following actions are performed. 
//! - First the bench resets the NoC.
//! - RegisterAccesses.json file is parsed to find all accesses to NoC registers
//! - Transactions are sent sequencially to these registers from the corresponding initiators.
//! - A read register is tested by checking that the response data value is equal to the register reset value including masked bits.
//! - As specified in the RegisterAccesses.json file, a write register is tested by sending three transactions:
//!		1- a write with a different data (specified in RegisterAccesses.json file)
//!		2- a read, checking the read data value coresponds to data value set previously 
//!		3- a write, to set the register back to its reset value
//! Slave VIP are currently configured to answer fast OK responses.
class anvu_registerMap_test extends uvm_test;
	`uvm_component_utils(anvu_registerMap_test)
	
	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;
	
	function new(string name = "anvu_registerMap_test", uvm_component parent);
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
	
	//! Run the test by starting the virtual sequence.
	task run_phase(uvm_phase phase);
		anvu_virtual_registerMap_seq virtSeq = anvu_virtual_registerMap_seq::type_id::create();
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
		phase.drop_objection(this);
	endtask : run_phase
endclass
