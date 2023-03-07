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
//! Virtual sequence which send transactions to NoC Bist Controller (sequentially).
class anvu_virtual_bistAccesses_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_bistAccesses_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	anvu_top_env   top;
	
	function new(string name = "anvu_virtual_bistAccesses_seq");
		super.new(name);
	endfunction
	task  performBistAccesses(input string fileName);
		
		chandle doc;
		longint  mode, resetValue;
		bit done = 1;
		longint initId, dataValue, dataMask;
		string targetCurrent [$];
		string targDone [$];
		longint modeCurrent = 0;
		anvu_registerMap_access accessBist;
		doc = openJson(fileName);

		foreach(nocInitServiceNetwork[i]) begin
			foreach(nocTargServiceNetwork[j]) begin
				targetCurrent = targDone.find_first(p) with (p == nocTargServiceNetwork[j]);
				if(targetCurrent.size() == 0) begin
					if (targetType( doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j]) == "ResilienceFaultController") begin

						anvu_flow   initFlow;
						initId = initiatorId(doc, nocInitServiceNetwork[i]);
						targDone.push_front(nocTargServiceNetwork[j]);
						targetCurrent = {};
						initFlow = Flow_fromNameAndIdx(nocInitServiceNetwork[i],initId);

						`uvm_info("anvu_test_D_",$psprintf("Perform Target '%s'<==>'%s'.",nocInitServiceNetwork[i] ,nocTargServiceNetwork[j]),uvm_pkg::UVM_LOW);
						if (initFlow.isNowhere()) begin
							`uvm_error("anvu_test",$psprintf("Initiator information '%s %d' does not reference a valid initiator.",nocInitServiceNetwork[i],initId))
							break;
						end

						mode = modeAccessTarget (doc,nocInitServiceNetwork[i],nocTargServiceNetwork[j], modeCurrent);

						accessBist.initFlowId 		= initFlow.id();
						accessBist.mode 			= mode;
						accessBist.securityLevel 	= 0;

						//Setting modeAccess
						top.bench.setMode( accessBist.mode );
						
						//Set BistTO1

						resetValue 	= registerResetValue(doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistTO1");
						//Setting resetValue at 0x0000FF, so according to the specifiction for Resilience feature we keep a lower value for TimeOut1
						dataValue 	= resetValue>>8;
						dataMask	= -1;
						accessBist 	= setRegisterAccessWrite(doc,accessBist,nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistTO1", dataValue, dataMask, modeCurrent);

						`uvm_info("anvu_test_D_",$psprintf("Set BistTO1 %p .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);
						
						//Set BistTO2

						resetValue 	= registerResetValue(doc, nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistTO2");
						//Setting resetValue at 0x00000F
						dataValue 	= resetValue>>4;
						accessBist 	= setRegisterAccessWrite(doc,accessBist,nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistTO2", dataValue, -1, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("Set BistTO2 %p .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//Set IntEn register, BistDoneEn field
						dataMask	= setDataMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j],"IntEn","BistDoneEn");
						accessBist 	 = setRegisterAccessWrite(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"IntEn",1'b0,dataMask, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("Set IntEn register, BistDoneEn field: %p .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//enable BIST
						dataMask 	= setDataMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j],"BistCtl","BistStart");
						accessBist 	= setRegisterAccessWrite(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistCtl",2'b01,dataMask, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("enable BIST '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//check BIST done
						#(500*nocSlowestClkPeriod);	
						dataMask 	=  setDataMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j],"BistDone","BistDone");		
						accessBist 	= setRegisterAccessRead(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistDone",1'b1,dataMask, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("check BIST done '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);
			
						dataMask 	= setDataMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j],"BistDone","MissionMode");
						accessBist 	= setRegisterAccessRead(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistDone",2'b10,dataMask, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("check MissionMode  '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//check Faults register in fields LatentFault	
						dataMask 	= 	setDataMask(doc, nocInitServiceNetwork[i], nocTargServiceNetwork[j],"Faults","LatentFault");			
						accessBist 	= setRegisterAccessRead(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"Faults",1'b0,dataMask, modeCurrent);	
						`uvm_info("anvu_test_D_",$psprintf("check LatentFault '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//Set BistDoneClr in BistCtl register
						accessBist 	= setRegisterAccessWrite(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistCtl",2'b10,-1, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("Set BistDoneClr in BistClr register '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);

						//Check after Clr MissionMode and BistDone
						#(15*nocSlowestClkPeriod);
						accessBist = setRegisterAccessRead(doc, accessBist,  nocInitServiceNetwork[i],nocTargServiceNetwork[j],"BistDone",2'b10,-1, modeCurrent);
						`uvm_info("anvu_test_D_",$psprintf("Check after Clr MissionMode and BistDone '%p' .",accessBist),uvm_pkg::UVM_LOW);
						p_sequencer.sendRegisterMapTransaction(accessBist,done);		
					end
					else begin
						`uvm_info("anvu_test_D_",$psprintf("Not Resilliance target or not access from initiator '%s'<==>'%s'.",nocInitServiceNetwork[i] ,nocTargServiceNetwork[j]),uvm_pkg::UVM_LOW);
					end
				end
				else begin
					`uvm_info("anvu_test_D_",$psprintf("Resilliance target already perform  '%s'<==>'%s'.",nocInitServiceNetwork[i] ,nocTargServiceNetwork[j]),uvm_pkg::UVM_LOW);
				end
			end
		end
		/*Print all Resilliance target done.
		`uvm_info("update",$psprintf("count Target <==>'%d' targetDone = '%p'.",targDone.size(),targDone),uvm_pkg::UVM_LOW);
		*/
	endtask

	task body();
		performBistAccesses({top.txtFilesDir,"/RegisterMap.json"});
	endtask
endclass

//! Virtual sequence whose function is to parse Json file to list accesses to NoC registers.
//! It then creates and starts another virual sequence which will send transactions to those registers.
class anvu_virtual_Bist_seq extends uvm_sequence;
	`uvm_object_utils(anvu_virtual_Bist_seq)
	`uvm_declare_p_sequencer(anvu_virtual_sequencer)
	
	anvu_top_env   top;
	function new(string name = "anvu_virtual_Bist_seq");
		super.new(name);
	endfunction

	task body();
				
		anvu_virtual_bistAccesses_seq bistAccess;
		
		$cast(top,p_sequencer.get_parent());
	
		`uvm_info("anvu_test","Starting Bist Test",uvm_pkg::UVM_LOW)
		// perform a noc reset
		top.bench.performNocReset();
		// Perform all accesses
        bistAccess = anvu_virtual_bistAccesses_seq::type_id::create();
        bistAccess.top = top;
        bistAccess.start(top.virtual_sequencer);

        // Wait  for all to be done
        top.wait_scoreboard_empty();
        `uvm_info("anvu_test","End of Bist Test",uvm_pkg::UVM_LOW)
        #(5*nocSlowestClkPeriod);  // Gives time for monitors to handle latest response if they have some internal delays.
    endtask
endclass

//!  The goal of this diagnostic is to check BIST inside the NoC for a Resiliance FaultController target. The following actions are performed. 
//! - First the bench resets the NoC.
//! - RegisterAccesses.json file is parsed to find all correct Register to perform a bist sequence according to the specification in Resilence feature.
//! - Transactions are sent sequencially to these registers from the corresponding initiators.
//! - There are 8 sequences for a succecfull BIST test.
//! Slave VIP are currently configured to answer fast OK responses.
class anvu_bist_test extends uvm_test;
	`uvm_component_utils(anvu_bist_test)
	
	//! top uvm_env which instantiates all sub uvm_env and the instrumented NoC
	anvu_top_env top;
	
	function new(string name = "anvu_bist_test", uvm_component parent);
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
		anvu_virtual_Bist_seq virtSeq = anvu_virtual_Bist_seq::type_id::create();
		phase.raise_objection(this);
		virtSeq.start(top.virtual_sequencer);
		phase.drop_objection(this);
	endtask : run_phase
endclass
