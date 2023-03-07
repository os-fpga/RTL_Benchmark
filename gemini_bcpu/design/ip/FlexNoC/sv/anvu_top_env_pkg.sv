// Copyright (c) 2006-2020 Qualcomm Technologies, Inc. All rights reserved.
// This code contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this code solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this code (including any copies)
// to your licensor.
// This code or portions thereof are protected under U.S. and foreign patent and patent applications.


`include "uvm_macros.svh"
`include "anvu_defines.sv"
`include "anvu_uvm_macros.sv"

package anvu_top_env_pkg;

typedef class anvu_top_env;

import uvm_pkg::*;
import anvu_commons_pkg::*;
import anvu_xactors_pkg::*;
import anvu_noc_definitions_pkg::*;
import anvu_scoreboard_pkg::*;
import anvu_json_pkg::*;
import svt_uvm_pkg::*;
import svt_apb_uvm_pkg::*;
import svt_ahb_uvm_pkg::*;
import svt_axi_uvm_pkg::*;

`include "anvu_defines.sv"
`include "anvu_uvm_macros.sv"
`include "anvu_axi_defines.sv"
`include "anvu_user_bench_env.sv"
`include "anvu_nocAip_env.sv"

//! Virtual sequencer that can be used for some tests, particularly
//! when the test does not want all initiator to work in parallel
class anvu_virtual_sequencer extends uvm_sequencer;
	//! List all the sequencer of the APB master driver.
	//! Index in the list is the same as the index in the nocAPBInitName list
	svt_apb_master_sequencer                                apbSequencer[$];
	//! List all the sequencer of the AHB master driver.
	//! Index in the list is the same as the index in the nocAHBInitName list
	svt_ahb_master_transaction_sequencer                    ahbSequencer[$];
	//! List all the sequencer of the AXI master driver.
	//! Index in the list is the same as the index in the nocAPBInitName list
	svt_axi_master_sequencer                                axiSequencer[$];
	
	`uvm_component_utils(anvu_virtual_sequencer)
	
	//! Top environment, to be able to call wait_flow in the helpers
	anvu_top_env   top;
	
	function new(string name = "anvu_virtual_sequencer" , uvm_component parent);
		super.new(name,parent);
		$cast(top,get_parent());
	endfunction
	
	//! Send the provided register access to the appropriate sequencer based on the flowId in the access
	//! If the access is a RD transaction and the dataValue in the access is not -1, the sequence will wait for the
	//! response of the accesss and check the dataValue
	task sendRegisterMapTransaction(anvu_registerMap_access access, output bit done);
		eHowHandleInterleav howInter = anvu_commons_pkg::ONECONPERTARG;
		anvu_memoryMap_connection connections[$];
		
		anvu_flow initFlow,targFlow,targFlowWithNoRights;
		longint targStartAddr;
		int unsigned securityBase=0;
		int unsigned securityMask=0;
		bit unreacheable=1;
		int unsigned secuBaseReachable = nocReachableSecurityBasesByInitFlowId[access.initFlowId];
		int unsigned secuMaskReachable = nocReachableSecurityMasksByInitFlowId[access.initFlowId];
		initFlow=new(access.initFlowId);
		
		top.bench.memoryMap.getConnections(initFlow,nocMaxAddrByInitFlowId[initFlow.id()],howInter,connections);
		foreach(connections[k]) begin
			if (access.address > connections[k].initStartAddr && access.address < connections[k].initEndAddr) begin
				t_opcode opcode = (access.write==1)?WRITE:READ;
				top.bench.memoryMap.translate(initFlow,access.address,opcode,-1,targFlow,targStartAddr,targFlowWithNoRights);
				if (targFlow.isNowhere()) begin
					unreacheable=1;
					break;
				end
				unreacheable=0;
				connections[k].findValidSecurityBaseMask(opcode,secuBaseReachable,secuMaskReachable,securityBase,securityMask,unreacheable);
				break;
			end
		end
		if (unreacheable) begin
			`uvm_info("anvu_test",$psprintf("Skipping, this register slice is unreacheable. InitFlow %s address 0x%x opcode %s",initFlow.str(),access.address,access.write?"WRITE":"READ"),uvm_pkg::UVM_HIGH)
			done = 0;
			return;
		end
		
		case (nocSocketTypeByFlowId[access.initFlowId])
			anvu_commons_pkg::AXI: begin
				anvu_axi_master_registerAccess_seq seq = anvu_axi_master_registerAccess_seq::type_id::create();
				seq.access       = access;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
				seq.start(axiSequencer[nocAxiInitIdxByFlowId[access.initFlowId]]);
			end
			anvu_commons_pkg::APB: begin
				anvu_apb_master_registerAccess_seq seq = anvu_apb_master_registerAccess_seq::type_id::create();
				seq.access       = access;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
				seq.start(apbSequencer[nocApbInitIdxByFlowId[access.initFlowId]]);
			end
			anvu_commons_pkg::AHB: begin
				anvu_ahb_master_registerAccess_seq seq = anvu_ahb_master_registerAccess_seq::type_id::create();
				seq.access       = access;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
//				seq.flow         = initFlow;
				seq.start(ahbSequencer[nocAhbInitIdxByFlowId[access.initFlowId]]);
			end
			default:;
		endcase
		done = 1;
	endtask
	
	
	
	
	
	//! Sends a single word transaction from the provided initiator flow, with an
	//! address computed from the memory map so that the transaction reaches the provided target flow.
	//! Generates a security flag baseMask which takes into account
	//!  - security flags reachable from the environment/VIPs
	//!  - security flags which allow valid transaction from the initiator to the target flow
	//!  - the additional constraint passed through the task parameters
	//! Generates a user flag baseMask which takes into account
	//!  - security flags reachable from the environment/VIPs
	//!  - the additional constraint passed through the task parameters
	//! These security/user baseMask are then used to constrain the transaction
	task sendOneWordInitToTargTransaction(anvu_flow initFlow, anvu_flow targFlow , string logMsg="", int unsigned addConstrSecuBase=0 , int unsigned addConstrSecuMask=0 , int unsigned addConstrUserBase=0 , int unsigned addConstrUserMask=0);
		longint addr = -1;
		bit secuNoMatchingReachable,secuNoMatchingAddConstr,userNoMatching;
		int unsigned secuBaseForConnectionOnly=0;
		int unsigned secuMaskForConnectionOnly=0;
		int unsigned secuBaseResult=0;
		int unsigned secuMaskResult=0;
		int unsigned secuBaseReachable = nocReachableSecurityBasesByInitFlowId[initFlow.id()];
		int unsigned secuMaskReachable = nocReachableSecurityMasksByInitFlowId[initFlow.id()];
		int unsigned userBaseResult=0;
		int unsigned userMaskResult=0;
		int unsigned userBaseReachable = nocReachableUserBasesByInitFlowId[initFlow.id()];
		int unsigned userMaskReachable = nocReachableUserMasksByInitFlowId[initFlow.id()];
		int modes[$];
		int mode;
	
		eHowHandleInterleav howInter = anvu_commons_pkg::ONECONPERTARG;
		anvu_memoryMap_connection connections[$],iconnection;
		bit[1:0] wrRd = nocOpcodesByInitFlowId[initFlow.id()];
		bit write,done;
		t_opcode opcode_list[$];
		if (wrRd[0])
			opcode_list.push_back(READ);
		if (wrRd[1])
			opcode_list.push_back(WRITE);

		`uvm_info("anvu_test",$psprintf("%s to %s%s.",initFlow.str(),targFlow.str(),logMsg),uvm_pkg::UVM_LOW)
		// Browse the initiator memoryMap to find an address that must reach the target.
		if (nocMeaningfullModeByInitFlowId.exists(initFlow.id()))
			modes = nocMeaningfullModeByInitFlowId[initFlow.id()];
		else
			modes.push_back(nocDfltMode);
		for (int noWhere=0; noWhere<=1; noWhere++) begin
			addr = -1;
			foreach(modes[i]) begin
				mode = modes[i];
				top.bench.memoryMap.setMode(modes[i]);
				top.bench.memoryMap.getConnections(initFlow,nocMaxAddrByInitFlowId[initFlow.id()],howInter,connections);
				foreach(opcode_list[l]) begin
					write = (opcode_list[l]==WRITE)? 1:0;
					foreach(connections[k]) begin
						anvu_flow destFlow,destFlowWithNoRights;
						bit targetMatch;
						longint targStartAddr;
						anvu_flow connectionTargSocket = connections[k].targFlow.socket();
						addr = connections[k].initStartAddr;
						targetMatch = (!noWhere && (targFlow.id() inside {connectionTargSocket.id(),connections[k].targFlow.id()}) );
						if (!targetMatch && noWhere) begin
							top.bench.memoryMap.translate(initFlow,addr,opcode_list[l],-1,destFlow,targStartAddr,destFlowWithNoRights);
							if(destFlowWithNoRights && !destFlowWithNoRights.isNowhere()) begin
								targetMatch = (targFlow.id() inside {destFlowWithNoRights.id(),destFlowWithNoRights.socket().id()});
								if(targetMatch) begin
									connections[k].targFlow = destFlowWithNoRights;
								end
							end
						end
						if (targetMatch) begin	
							connections[k].findValidSecurityBaseMask(opcode_list[l],secuBaseReachable,secuMaskReachable,secuBaseForConnectionOnly,secuMaskForConnectionOnly,secuNoMatchingReachable);
							if (!secuNoMatchingReachable) begin
								done = 1;
								break;
							end
						end
					end
				if (done) break;
				end //opcode
				if(done) break;
			end
			if(done) break;
		end	

		if (done) begin
			if (addr == -1) begin
				`uvm_error("anvu_test",$psprintf("Cannot find an address for initiator %s that reaches target %s.",initFlow.str(),targFlow.str()))
				return;
			end
			if (secuNoMatchingReachable) begin
				`uvm_error("anvu_test",$psprintf("Cannot reach a security flag set of values which allow a transaction between initiator %s and target %s.",initFlow.str(),targFlow.str()))
				return;
			end
			mergeTwoBaseMask(secuBaseForConnectionOnly,secuMaskForConnectionOnly,addConstrSecuBase,addConstrSecuMask,secuBaseResult,secuMaskResult,secuNoMatchingAddConstr);
			if (secuNoMatchingAddConstr) begin
				`uvm_error("anvu_test",$psprintf("Cannot reach a security flag set of values which allow a valid transaction between initiator %s and target %s and match additionnal constraints",initFlow.str(),targFlow.str()))
				return;
			end
			mergeTwoBaseMask(userBaseReachable,userMaskReachable,addConstrUserBase,addConstrUserMask,userBaseResult,userMaskResult,userNoMatching);
			if (userNoMatching) begin
				`uvm_error("anvu_test",$psprintf("Cannot reach a user flag set of values which match additionnal constraints"))
				return;
			end
			top.bench.setMode(mode);
			sendOneWordTransaction(initFlow,addr,write,secuBaseResult,secuMaskResult,userBaseResult,userMaskResult);
		end else `uvm_error("anvu_test",$psprintf("Cannot reach a targetFlow %s from initiator %s ",targFlow.str(),initFlow.str()))
	endtask
	
	//! Sends a single word transaction from the provided iniatiator flow with the provided address
	task sendOneWordTransaction(anvu_flow initFlow,longint address,bit write,int unsigned securityBase=0,int unsigned securityMask=0,int unsigned userBase=0,int unsigned userMask=0);
		// Generates an access from the initiator to the target
		case (nocSocketTypeByFlowId[initFlow.id()])
			anvu_commons_pkg::AXI: begin
				anvu_axi_master_oneWord_seq seq = anvu_axi_master_oneWord_seq::type_id::create();
				seq.address      = address;
				seq.write        = write;
				seq.flow         = initFlow;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
				seq.userBase     = userBase;
				seq.userMask     = userMask;
				seq.start(axiSequencer[nocAxiInitIdxByFlowId[initFlow.id()]]);
			end
			anvu_commons_pkg::APB: begin
				anvu_apb_master_oneWord_seq seq = anvu_apb_master_oneWord_seq::type_id::create();
				seq.address      = address;
				seq.write        = write;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
				seq.userBase     = userBase;
				seq.userMask     = userMask;
				seq.start(apbSequencer[nocApbInitIdxByFlowId[initFlow.id()]]);
			end
			anvu_commons_pkg::AHB: begin
				anvu_ahb_master_oneWord_seq seq = anvu_ahb_master_oneWord_seq::type_id::create();
				seq.address      = address;
				seq.write        = write;
				seq.securityBase = securityBase;
				seq.securityMask = securityMask;
				seq.userBase     = userBase;
				seq.userMask     = userMask;
				seq.start(ahbSequencer[nocAhbInitIdxByFlowId[initFlow.id()]]);
			end
			default:;
		endcase
	endtask
endclass


//! Top level environment
//! It is responsible for creating the bench environment and the nocAip environment
//! and connect these two environment with all the necessary interfaces of the verilog
//! modules.
//! The top level environment also create and connect the virtual sequencer
class anvu_top_env extends uvm_env;
	`uvm_component_utils(anvu_top_env)
	
	//! Path where all the text files loaded in the environment are stored
	string txtFilesDir;
	//! The bench environment
	anvu_user_bench_env bench;
	//! The nocAip environment
	anvu_nocAip_env nocAip;
	//! The virtual sequencer
	anvu_virtual_sequencer virtual_sequencer;
	
	//! Value of the default timeout for wait_flow and wait_flows method.
	//! It can be overriden in +anvu_test_options string with
	//! keyword attribute timeout=
	longint defaultTimeout=200000;
	
	//! Value of the default timeout for wait_scoreboard_empty method
	//! It can be overriden in +anvu_test_options string with
	//! keyword attribute scTimeout=
	longint defaultScTimeout=20000;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	//! Create the bench, nocAip environment and the virtual sequencer
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (! $value$plusargs("anvu_txt_file_dir=%s",txtFilesDir )) begin
			`uvm_fatal("anvu_bench","Cannot find command line option '+anvu_txt_file_dir=' that defines the directory path where are store all text file required by the environment")
		end
		bench  = anvu_user_bench_env::type_id::create("bench",this);
		bench.txtFilesDir = txtFilesDir;
		nocAip = anvu_nocAip_env::type_id::create("nocAip",this);
		nocAip.txtFilesDir = txtFilesDir;
		virtual_sequencer = anvu_virtual_sequencer::type_id::create("virtual_sequencer",this);
		for(int i=0;i<nocAxiInitNb ;i++) begin
			virtual svt_axi_master_if ifce;
			uvm_config_db#(virtual svt_axi_master_if)::get( uvm_top , "" , {nocAxiInitName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_axi_master_if)::set( this , {"bench.",nocAxiInitName[i]} , "vif" , ifce );
		end
		for(int i=0;i<nocAxiTargNb ;i++) begin
			virtual svt_axi_slave_if ifce;
			uvm_config_db#(virtual svt_axi_slave_if)::get( uvm_top , "" , {nocAxiTargName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_axi_slave_if)::set( this , {"bench.",nocAxiTargName[i]} , "vif" , ifce );
		end
		for(int i=0;i<nocApbInitNb ;i++) begin
			virtual svt_apb_if ifce;
			uvm_config_db#(virtual svt_apb_if)::get( uvm_top , "" , {nocApbInitName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_apb_if)::set( this , {"bench.",nocApbInitName[i]} , "vif" , ifce );
		end
		for(int i=0;i<nocApbTargNb ;i++) begin
			virtual svt_apb_slave_if ifce;
			uvm_config_db#(virtual svt_apb_slave_if)::get( uvm_top , "" , {nocApbTargName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_apb_slave_if)::set( this , {"bench.",nocApbTargName[i]} , "vif" , ifce );
		end
		for(int i=0;i<nocAhbInitNb ;i++) begin
			virtual svt_ahb_if ifce;
			uvm_config_db#(virtual svt_ahb_if)::get( uvm_top , "" , {nocAhbInitName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_ahb_master_if)::set( this , {"bench.",nocAhbInitName[i]} , "vif" , ifce.master_if[0] );
		end
		for(int i=0;i<nocAhbTargNb ;i++) begin
			virtual svt_ahb_if ifce;
			uvm_config_db#(virtual svt_ahb_if)::get( uvm_top , "" , {nocAhbTargName[i],"_benchIf"} , ifce );
			uvm_config_db#(virtual svt_ahb_slave_if)::set( this , {"bench.",nocAhbTargName[i]} , "vif" , ifce.slave_if[0] );
		end


	endfunction
	//! Connect the bench, nocAip environment to the appropriate interfaces of the anvu_uvmTestEnv_Top
	//! and instrumentedNoC verilog modules.
	//! Also connects the virtual sequencer
	function void connect_phase(uvm_phase phase) ;
		super.connect_phase(phase);
		for(int i=0;i<nocAxiInitNb             ;i++) nocAip.axiInitMon              [i].assign_vif( { nocAxiInitName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocAxiTargNb             ;i++) nocAip.axiTargMon              [i].assign_vif( { nocAxiTargName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocApbInitNb             ;i++) nocAip.apbInitMon              [i].assign_vif( { nocApbInitName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocApbTargNb             ;i++) nocAip.apbTargMon              [i].assign_vif( { nocApbTargName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocAhbInitNb             ;i++) nocAip.ahbInitMon              [i].assign_vif( { nocAhbInitName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocAhbTargNb             ;i++) nocAip.ahbTargMon              [i].assign_vif( { nocAhbTargName[i]            , "_nocAipIf" } );
		for(int i=0;i<nocModePortDriverNb      ;i++) nocAip.modePortDriverMon       [i].assign_vif( { nocModePortDriverName[i]     , "_nocAipIf" } );
		for(int i=0;i<nocClkRegimeDriverNb     ;i++) bench.clkRegimeDriverVip       [i].assign_vif( { nocClkRegimeDriverName[i]    , "_benchIf"  } );
		for(int i=0;i<nocRstnDriverNb          ;i++) bench.rstnDriverVip            [i].assign_vif( { nocRstnDriverName[i]         , "_benchIf"  } );
		for(int i=0;i<nocSignalDriverNb        ;i++) bench.signalDriverVip          [i].assign_vif( { nocSignalDriverName[i]       , "_benchIf"  } );
		for(int i=0;i<nocSignalReaderNb        ;i++) bench.signalReaderVip          [i].assign_vif( { nocSignalReaderName[i]       , "_benchIf"  } );
		for(int i=0;i<nocModePortDriverNb      ;i++) bench.modePortDriverVip        [i].assign_vif( { nocModePortDriverName[i]     , "_benchIf"  } );
		for (int i=0;i<nocApbInitNb;i++) begin
			virtual_sequencer.apbSequencer.push_back(bench.apbInitVip[i].sequencer);
		end
		for (int i=0;i<nocAhbInitNb;i++) begin
			virtual_sequencer.ahbSequencer.push_back(bench.ahbInitVip[i].sequencer);
		end
		for (int i=0;i<nocAxiInitNb;i++) begin
			virtual_sequencer.axiSequencer.push_back(bench.axiInitVip[i].sequencer);
		end
	endfunction
	function void end_of_elaboration_phase(uvm_phase phase);
		// Logging
		string       str_id [$] = {"anvu_test", "anvu_nocAip", "anvu_bench"};
		uvm_severity svrt   [$] = {UVM_FATAL, UVM_ERROR, UVM_WARNING, UVM_INFO};
		uvm_action act;
		bit logScoreboard = 0;
		string logFileName;
		UVM_FILE f;
		super.end_of_elaboration_phase(phase);
		if ( $value$plusargs("anvu_log_file=%s",logFileName) ) begin
			f = $fopen(logFileName);
			// Logs nocAip, test and bench outputs to the anvu.log
			foreach(str_id[i]) begin
				foreach(svrt[j]) begin
					act = uvm_top.get_report_action(svrt[j], str_id[i]);
					uvm_top.set_report_severity_id_action_hier(svrt[j], str_id[i], act | uvm_pkg::UVM_DISPLAY | uvm_pkg::UVM_LOG);
					uvm_top.set_report_id_file_hier(str_id[i],f);
				end
			end
		end
		begin
			//Look for timeout and scTimeout keyword in +anvu_test_options string
			if (nocTestOptionsKeywords.exists("timeout")) begin
				defaultTimeout = stringToLongHex(nocTestOptionsKeywords["timeout"]);
			end
			if (nocTestOptionsKeywords.exists("scTimeout")) begin
				defaultScTimeout = stringToLongHex(nocTestOptionsKeywords["scTimeout"]);
			end
		end
	endfunction
	
	//! This task blocks until the NoC scoreboard is empty or the timeout is reached.
	//! When the timeout is reached, the NoC scoreboard is purged to force possible resolution of some byte transfers
	task wait_scoreboard_empty(longint timeout=0);
		if (timeout==0) timeout=defaultScTimeout;
		fork
			begin
				#(timeout*nocSlowestClkPeriod);
				`uvm_info("anvu_test","Timeout waiting for the scoreboard to be empty has been reached. Trying to purge to see if pending transfers can be resolved. Note that in case of scenario with Bufferable/Posted writes, the timeout value may not be sufficient for all transactions to be observed on targets.",uvm_pkg::UVM_HIGH)
				nocAip.scoreboard.purge(getTimeInPs(),0,0);
			end
			begin
				while( !(nocAip.scoreboard.m_isEmpty || nocAip.scoreboard.errorDetected) ) begin
					#(20*nocSlowestClkPeriod);
				end
			end
		join_any
		disable fork;
	endtask
	
	//! This task calls wait_flows to introduce wait until the flow has finished processing its sequence.
	task wait_flow(anvu_flow flow, longint timeout=0);
		
		anvu_flow flows[$];
		flows.push_back(flow);
		
		if (timeout==0) timeout=defaultTimeout;
		wait_flows(flows,timeout);	
	endtask
	//! This task blocks until the listed initiator flows have finished processing their sequences
	//! If no flows are provided, wait for everybody
	task wait_flows(anvu_flow flows[$]={}, longint timeout=0);
		bit allFlows = (flows.size() == 0);
		bit okSig = 1;
		bit axiInitIdx[int];
		int trPrevDoneAxi[string];

		bit apbInitIdx[int];
		int trPrevDoneApb[string];
		bit ahbInitIdx[int];
		int trPrevDoneAhb[string];
		foreach(flows[i]) begin
			case (nocSocketTypeByFlowId[flows[i].id()])
				anvu_commons_pkg::AXI            : axiInitIdx[nocAxiInitIdxByFlowId[flows[i].id()]]               = 1;
				anvu_commons_pkg::APB            : apbInitIdx[nocApbInitIdxByFlowId[flows[i].id()]]               = 1;
				anvu_commons_pkg::AHB            : ahbInitIdx[nocAhbInitIdxByFlowId[flows[i].id()]]               = 1;
				default : begin
					`uvm_error("uvm_test",$psprintf("Unexpected flow received : %s",flows[i].str()))
				end
			endcase
		end
		
		if (timeout==0) timeout=defaultTimeout;
		timeout = timeout/2;
		
		fork
			begin
				string msg;
				do begin
					for(int loop = 0;loop<2; loop++) begin
						#(timeout*nocSlowestClkPeriod);
						// Build the error message, containing initiator and number of transaction missing

						for(int i=0;i<nocAxiInitNb;i++) begin
							if (!allFlows && !axiInitIdx.exists(i)) continue;
							if (loop == 0) begin 
								trPrevDoneAxi[nocAxiInitName[i]] = bench.nbTransactionDoneBySocket[nocAxiInitName[i]];
							end
							else if ( 	bench.nbTransactionDoneBySocket[nocAxiInitName[i]] != bench.axiInitVip[i].sequencer.get_num_reqs_sent()
									&& 	trPrevDoneAxi[nocAxiInitName[i]] == bench.nbTransactionDoneBySocket[nocAxiInitName[i]]
								) begin
								okSig = 0;
								msg = { msg , "\n\t" ,  $psprintf("%s : %d",nocAxiInitName[i] ,  bench.axiInitVip[i].sequencer.get_num_reqs_sent()-bench.nbTransactionDoneBySocket[nocAxiInitName[i]]) };
							end
						end


						for(int i=0;i<nocApbInitNb;i++) begin

							if (loop == 0) begin 
								trPrevDoneApb[nocApbInitName[i]] = bench.nbTransactionDoneBySocket[nocApbInitName[i]];
							end
							else if (	bench.nbTransactionDoneBySocket[nocApbInitName[i]] != bench.nbTransactionSentBySocket[nocApbInitName[i]] 
									&&	trPrevDoneApb[nocApbInitName[i]] == bench.nbTransactionDoneBySocket[nocApbInitName[i]]
								) begin
								okSig = 0;
								msg = { msg , "\n\t" ,  $psprintf("%s : %d",nocApbInitName[i] ,  bench.nbTransactionSentBySocket[nocApbInitName[i]]-bench.nbTransactionDoneBySocket[nocApbInitName[i]]) };
							end
						end
						for(int i=0;i<nocAhbInitNb;i++) begin
							if (loop == 0) begin 
								trPrevDoneAhb[nocAhbInitName[i]] = bench.nbTransactionDoneBySocket[nocAhbInitName[i]];
							end
							else if ( 	bench.nbTransactionDoneBySocket[nocAhbInitName[i]] != bench.ahbInitVip[i].sequencer.get_num_reqs_sent()  
									&& 	trPrevDoneAhb[nocAhbInitName[i]] == bench.nbTransactionDoneBySocket[nocAhbInitName[i]]
								) begin
								okSig = 0;
								msg = { msg , "\n\t" ,  $psprintf("%s : %d",nocAhbInitName[i] ,  bench.ahbInitVip[i].sequencer.get_num_reqs_sent()) };
							end
						end
					end
				end
				while(okSig);
				`uvm_fatal("anvu_bench",$psprintf("Timeout reached. The following initiators have not finished all the transactions send by their sequencers :{}",msg))
			end
			begin
				for(int i=0;i<nocApbInitNb;i++) begin
					if (!allFlows && !apbInitIdx.exists(i)) continue;
					fork
						automatic int j=i;
						begin
							while (bench.nbTransactionDoneBySocket[nocApbInitName[j]]!=bench.nbTransactionSentBySocket[nocApbInitName[j]]) begin
								@(bench.updateTransactionDone);
							end
							`uvm_info("anvu_test",$psprintf("Initiator %s has completed its sequences",nocApbInitName[j]),uvm_pkg::UVM_FULL)
						end
					join_none
				end
				for(int i=0;i<nocAhbInitNb;i++) begin
					if (!allFlows && !ahbInitIdx.exists(i)) continue;
					fork
						automatic int j=i;
						begin
							while (bench.nbTransactionDoneBySocket[nocAhbInitName[j]]!=bench.ahbInitVip[j].sequencer.get_num_reqs_sent()) begin
								@(bench.updateTransactionDone);
							end
							`uvm_info("anvu_test",$psprintf("Initiator %s has completed its sequences",nocAhbInitName[j]),uvm_pkg::UVM_FULL)
						end
					join_none
				end
				for(int i=0;i<nocAxiInitNb;i++) begin
					if (!allFlows && !axiInitIdx.exists(i)) continue;
					fork
						automatic int j=i;
						begin
							while (bench.nbTransactionDoneBySocket[nocAxiInitName[j]]!=bench.axiInitVip[j].sequencer.get_num_reqs_sent()) begin
								@(bench.updateTransactionDone);
							end
							`uvm_info("anvu_test",$psprintf("Initiator %s has completed its sequences",nocAxiInitName[j]),uvm_pkg::UVM_FULL)
						end
					join_none
				end
				
				wait fork;
			end
		join_any
		disable fork;
	endtask
endclass

endpackage
