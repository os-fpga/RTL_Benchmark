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

class anvu_ahb_master_trans extends svt_ahb_master_transaction;
	anvu_ahb_init_info   ahbInfo         ;
	int                  master_id       ;
	int                  nBytePerData    ;
	int                  log2NBytePerData;
	anvu_flow            socketFlow      ;
	
	`uvm_object_utils_begin(anvu_ahb_master_trans)
		`uvm_field_int(master_id,uvm_pkg::UVM_ALL_ON)
	`uvm_object_utils_end
	
	constraint protocol_constraints {
		addr  >= 0;
		addr  <= (64'h1<<ahbInfo.wAddr)-1;
		burst_size >= 0;
		burst_size <= log2NBytePerData;
		addr%(1<<burst_size) == 0;
	}
	
	constraint niu_constraints_wrapMax {
		ahbInfo.wrapMax < 4  -> burst_type != svt_ahb_transaction::WRAP4;
		ahbInfo.wrapMax < 8  -> burst_type != svt_ahb_transaction::WRAP8;
		ahbInfo.wrapMax < 16 -> burst_type != svt_ahb_transaction::WRAP16;
	}
	constraint niu_constraints_minWrapAlign {
		if (burst_type inside { svt_ahb_transaction::WRAP4 , svt_ahb_transaction::WRAP8 , svt_ahb_transaction::WRAP16 } && ahbInfo.minWrapAlign>=2 ) {
			addr&(ahbInfo.minWrapAlign-1) == 0;
		}
	}
	constraint niu_constraints_narrowBurst {
		burst_type != svt_ahb_transaction::SINGLE -> burst_size >= ahbInfo.minXferSize;
	}
	
	constraint reasonable_constraints {
		num_incr_beats<=32;
		foreach(num_busy_cycles[i]) {
			num_busy_cycles[i]<=10;
		}
	}
	
	function new(string name = "anvu_ahb_master_trans");
		super.new(name);
		master_id = -1;
	endfunction : new
	
	function void build();
		if (master_id == -1 ) begin
			bit            initFlowId[int];
			anvu_bench_env bench;
			string         masterName;
			svt_ahb_master_agent agent;
			$cast(agent,m_sequencer.get_parent());
			$cast(bench,agent      .get_parent());
			masterName       = agent.get_name();
			ahbInfo          = nocAhbInitInfo[nocAhbInitIdxByName[masterName]];
			nBytePerData     = ahbInfo.wData/8;
			log2NBytePerData = log2(nBytePerData);
			socketFlow       = Flow_fromName(masterName);
			master_id        = socketFlow.id();
		end
	endfunction
endclass

class anvu_ahb_master_trans_forcedFlags extends anvu_ahb_master_trans;
	int unsigned securityBase      = 0;
	int unsigned securityMask      = 0;
	int unsigned userBase          = 0;
	int unsigned userMask          = 0;
	int unsigned protBaseForSecu   = 0;
	int unsigned protMaskForSecu   = 0;
	int unsigned userBaseForSecu   = 0;
	int unsigned userMaskForSecu   = 0;
	int unsigned nonsecBaseForSecu = 0;
	int unsigned nonsecMaskForSecu = 0;
	int unsigned protBaseForUser   = 0;
	int unsigned protMaskForUser   = 0;
	int unsigned userBaseForUser   = 0;
	int unsigned userMaskForUser   = 0;
	int unsigned nonsecBaseForUser = 0;
	int unsigned nonsecMaskForUser = 0;
	int unsigned masterBaseForUser = 0;
	int unsigned masterMaskForUser = 0;
	int          ahbInitIdx;
	
	`uvm_object_utils_begin(anvu_ahb_master_trans_forcedFlags)
	`uvm_object_utils_end
	
	function new(string name = "anvu_ahb_master_trans_forcedFlags");
		super.new(name);
	endfunction : new
	
	function void pre_randomize();
		int unsigned securityInv;
		int unsigned userInv;
		super.pre_randomize();
		securityInv = nocSecurityBitInversionByFlowId[master_id];
		userInv     = nocUserBitInversionByFlowId    [master_id];
		ahbInitIdx  = nocAhbInitIdxByFlowId          [master_id];
		for (int i=0;i<nocSecurityFlagNb;i++) begin
			anvu_flag_info flagDriver = nocAhbInitSecurityFlagMapping[ahbInitIdx][i];
			bit            flagValue = ((securityBase^securityInv)>>i)%2;
			if ((securityMask>>i)%2==0)
				continue;
			case (flagDriver.flagSrc)
				PROT : begin
					protBaseForSecu |= flagValue << flagDriver.index;
					protMaskForSecu |= 1 << flagDriver.index;
				end
				REQUSER : begin
					userBaseForSecu |= flagValue << flagDriver.index;
					userMaskForSecu |= 1 << flagDriver.index;
				end
				SEC : begin
					nonsecBaseForSecu |= flagValue << flagDriver.index;
					nonsecMaskForSecu |= 1 << flagDriver.index;
				end
				CONST : begin
					//security flag is const, not driven by socket
				end
				NONE : begin
					//security flag is NONE, not driven by socket
				end
				default : begin
					`uvm_error("anvu_test","Unexpected security flag source type")
				end
			endcase
		end
		
		for (int i=0;i<nocUserFlagNb;i++) begin
			anvu_flag_info flagDriver = nocAhbInitUserFlagMapping[ahbInitIdx][i];
			bit flagValue = ((userBase^userInv)>>i)%2;
			if ((userMask>>i)%2==0) continue;
			case (flagDriver.flagSrc)
				PROT : begin
					protBaseForUser |= flagValue << flagDriver.index;
					protMaskForUser |= 1 << flagDriver.index;
				end
				REQUSER : begin
					userBaseForUser |= flagValue << flagDriver.index;
					userMaskForUser |= 1 << flagDriver.index;
				end
				CONNID : begin
					masterBaseForUser |= flagValue << flagDriver.index;
					masterMaskForUser |= 1 << flagDriver.index;
				end
				MASTER : begin
					masterBaseForUser |= flagValue << flagDriver.index;
					masterMaskForUser |= 1 << flagDriver.index;
				end
				SEC : begin
					nonsecBaseForUser |= flagValue << flagDriver.index;
					nonsecMaskForUser |= 1 << flagDriver.index;
				end
				CONST : begin
					//security flag is const, not driven by socket
				end
				UNSUPPORTED : begin
					//assumes this flag is set to 0
				end
				NONE : begin
					//security flag is NONE, not driven by socket
				end
				default : begin
					`uvm_error("anvu_test","Unexpected security flag source type")
				end
			endcase
		end
		nonsec_trans.rand_mode(1); // for forceFlags constraints, cf FN-577
	endfunction
	
	//! Constrain the interface signals which drive the noc internal security and/or user flags, so that these flags match the securityBase/securityMask and/or userBase/securityMask.
	constraint forceFlags {
		(protMaskForUser[0]==1) -> soft prot0_type == (protBaseForUser[0] == 0 ? svt_ahb_transaction::DATA_ACCESS    : svt_ahb_transaction::OPCODE_FETCH      );
		(protMaskForUser[1]==1) -> soft prot1_type == (protBaseForUser[1] == 0 ? svt_ahb_transaction::USER_ACCESS    : svt_ahb_transaction::PRIVILEDGED_ACCESS);
		(protMaskForUser[2]==1) -> soft prot2_type == (protBaseForUser[2] == 0 ? svt_ahb_transaction::NON_BUFFERABLE : svt_ahb_transaction::BUFFERABLE        );
		(protMaskForUser[3]==1) -> soft prot3_type == (protBaseForUser[3] == 0 ? svt_ahb_transaction::NON_CACHEABLE  : svt_ahb_transaction::CACHEABLE         );
		
		(protMaskForSecu[0]==1) ->      prot0_type == (protBaseForSecu[0] == 0 ? svt_ahb_transaction::DATA_ACCESS    : svt_ahb_transaction::OPCODE_FETCH      );
		(protMaskForSecu[1]==1) ->      prot1_type == (protBaseForSecu[1] == 0 ? svt_ahb_transaction::USER_ACCESS    : svt_ahb_transaction::PRIVILEDGED_ACCESS);
		(protMaskForSecu[2]==1) ->      prot2_type == (protBaseForSecu[2] == 0 ? svt_ahb_transaction::NON_BUFFERABLE : svt_ahb_transaction::BUFFERABLE        );
		(protMaskForSecu[3]==1) ->      prot3_type == (protBaseForSecu[3] == 0 ? svt_ahb_transaction::NON_CACHEABLE  : svt_ahb_transaction::CACHEABLE         );
		
		(control_huser & userMaskForSecu) == userBaseForSecu;
		(control_huser & userMaskForUser) == userBaseForUser;
		
		(nonsec_trans & nonsecMaskForSecu) == nonsecBaseForSecu;
		(nonsec_trans & nonsecMaskForUser) == nonsecBaseForUser;
		
		//AHB5 not yet available (control_hmaster & masterMaskForUser)  == masterBaseForUser;
	}
endclass

class anvu_ahb_master_random_seq extends uvm_sequence #(anvu_ahb_master_trans);
	`uvm_object_utils(anvu_ahb_master_random_seq)
	int nTransaction;
	function new(string name = "anvu_ahb_master_random_seq");
		super.new(name);
		nTransaction = 100;
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		for (int l=0; l<nTransaction ; l++ ) begin
			`uvm_create(req)
			req.build();
			if  (!( req.randomize() with {
				xact_type != svt_ahb_transaction::IDLE_XACT ;
				if (ahbInfo.busyIgnoreWaits) {
					foreach(num_busy_cycles[i]) {
						num_busy_cycles[i]==0;
					}
				}
				req.lock == 0;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			if(l<10)
				continue;
			`uvm_send(req)
		end
	endtask
endclass

class anvu_ahb_master_registerAccess_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_registerAccess_seq)
	anvu_registerMap_access access;
//	anvu_flow               flow;
//	anvu_ahb_init_info      ahbInfo;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;
	
	function new(string name = "anvu_ahb_master_registerAccess_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
//		anvu_ahb_init_info ahbInfo = nocAhbInitInfoByFlowId[flow.id()];
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.build();
		if (!( req.randomize() with {
			addr       == access.address;
			xact_type  == ( access.write ? svt_ahb_transaction::WRITE : svt_ahb_transaction::READ );
			burst_size == svt_ahb_transaction::BURST_SIZE_32BIT;
			burst_type == svt_ahb_transaction::SINGLE;
			if (ahbInfo.busyIgnoreWaits) {
				foreach(num_busy_cycles[i]) {
					num_busy_cycles[i]==0;
				}
			}
			req.lock == 0;
			(access.write) -> prot2_type == svt_ahb_transaction::NON_BUFFERABLE; // So that the NIU doesn't allow posted write, which can be a problem if the simulation continue straigth away without the register not being finally configured
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		if (access.write) req.data[0] = access.dataValue;
		`uvm_send(req)
		get_response(rsp);
		
		if ( !access.write && access.dataValue != -1) begin
			int data;
			data = rsp.data[0];
//			$display("#DBG rsp.data[0]=%0x ahbInfo.littleEndian=%0d data=%0x offset=%0d",rsp.data[0],ahbInfo.littleEndian,data,access.address%req.nBytePerData);
			if ((data &access.dataMask) != (access.dataValue&access.dataMask)) begin
				anvu_flow initFlow = new(req.master_id);
				`uvm_error("anvu_test",$psprintf("Initiator %s completed an access at address %x, it received data %x while it expected %x with a mask of %x.",initFlow.str(),access.address,data,access.dataValue,access.dataMask))
			end
		end
	endtask
endclass

class anvu_ahb_master_connectivity_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_connectivity_seq)
	rand longint  startAddr       ;
	rand longint  endAddr         ;
	longint       margin          ;
	rand t_opcode opcode          ;
	int unsigned  securityBase = 0;
	int unsigned  securityMask = 0;
	
	function new(string name = "anvu_ahb_master_connectivity_seq");
		super.new(name);
		margin = 64'h1000;
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		// Do two simple access at the bottom of the range and at the top of the range, with the defined opcode
		longint curAddr[2];
		margin  = margin<(endAddr-startAddr)?margin:(endAddr-startAddr);
		curAddr = '{ startAddr, endAddr-margin };
		foreach (curAddr[l] ) begin
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			if (!( req.randomize() with {
				addr                  >= curAddr[l];
				addr+req.nBytePerData <= curAddr[l]+margin;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_ahb_transaction::READ : svt_ahb_transaction::WRITE );
				burst_size == req.log2NBytePerData;
				burst_type == svt_ahb_transaction::SINGLE;
				if (ahbInfo.busyIgnoreWaits) {
					foreach(num_busy_cycles[i]) {
						num_busy_cycles[i]==0;
					}
				}
				req.lock == 0;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
		end
	endtask
endclass

class anvu_ahb_master_latency_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_latency_seq)
	rand longint  startAddr       ;
	rand longint  endAddr         ;
	rand t_opcode opcode          ;
	int unsigned  securityBase = 0;
	int unsigned  securityMask = 0;
	
	function new(string name = "anvu_ahb_master_latency_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.build();
		if (!( req.randomize() with {
			addr                  >= startAddr;
			addr+req.nBytePerData <= endAddr;
			xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_ahb_transaction::READ : svt_ahb_transaction::WRITE );
			burst_size == req.log2NBytePerData;
			burst_type == svt_ahb_transaction::SINGLE;
			foreach(num_busy_cycles[i]) {
				num_busy_cycles[i]==0;
			}
			prot2_type == svt_ahb_transaction::NON_BUFFERABLE;
			prot3_type == svt_ahb_transaction::NON_CACHEABLE ;
			req.lock == 0;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass

class anvu_ahb_master_throughput_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_throughput_seq)
	rand longint  startAddr         ;
	rand longint  endAddr           ;
	rand t_opcode opcode            ;
	anvu_flow     flow              ;
	int unsigned  securityBase = 0  ;
	int unsigned  securityMask = 0  ;
	int           nbWordsSent  = 0  ;
	int           nbWordsToSend= 128;
	
	function new(string name = "anvu_ahb_master_throughput_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		longint curAddress,firstAddress;
		int wordLength,byteLength;
		anvu_ahb_init_info ahbInfo = nocAhbInitInfoByFlowId[flow.id()];
		
		wordLength   = 16;
		byteLength   = wordLength*ahbInfo.wData/8;
		firstAddress = (startAddr%byteLength)==0 ? startAddr:startAddr-(startAddr%byteLength)+byteLength;
		curAddress   = firstAddress;
		
		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			if (!( req.randomize() with {
				addr       == curAddress;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_ahb_transaction::READ : svt_ahb_transaction::WRITE );
				burst_size == req.log2NBytePerData;
				burst_type == svt_ahb_transaction::INCR16;
				foreach(num_busy_cycles[i]) {
					num_busy_cycles[i]==0;
				}
				prot2_type == svt_ahb_transaction::NON_BUFFERABLE;
				prot3_type == svt_ahb_transaction::NON_CACHEABLE ;
				req.lock == 0;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			curAddress = (curAddress+2*byteLength)<=endAddr ? curAddress+byteLength:firstAddress;
			nbWordsSent+=16;
		end
	endtask
endclass

class anvu_ahb_master_userBit_seq extends uvm_sequence #(anvu_ahb_master_trans);
	`uvm_object_utils(anvu_ahb_master_userBit_seq)
	
	int          totalTransactionSent;
	rand longint startAddr           ;
	rand longint endAddr             ;
	anvu_flow    flow                ;
	
	function new(string name = "anvu_ahb_master_userBit_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	virtual task body();
		anvu_ahb_init_info ahbInfo = nocAhbInitInfoByFlowId[flow.id()];
		int cmds[2] = '{svt_ahb_transaction::READ,svt_ahb_transaction::WRITE};
		int totalTransactionSent = 0;
		int nSignal,nValue;
		// Signal order 0 to n : Prot, User, HNonsec, HMaster
		nSignal = 4;
		foreach(cmds[k]) begin
			for(int l=0;l<nSignal;l++) begin
				case (l)
					0 : nValue = log2(ahbInfo.wProt);
					1 : nValue = ahbInfo.wUser;
					2 : nValue = 1;
					3 : nValue = ahbInfo.wMaster;
				endcase
				for(int m=0;m<nValue;m++) begin
					`uvm_create(req)
					req.build();
					if ( req.randomize() with {
						addr                  >= startAddr;
						addr+req.nBytePerData <= endAddr;
						xact_type  == cmds[k];
						burst_size == req.log2NBytePerData;
						burst_type == svt_ahb_transaction::SINGLE;
						if (ahbInfo.busyIgnoreWaits) {
							foreach(num_busy_cycles[i]) {
								num_busy_cycles[i]==0;
							}
						}
						
						(l==0) -> prot0_type == m[0];
						(l==0) -> prot1_type == m[1];
						(l==0) -> prot2_type == m[2];
						(l==0) -> prot3_type == m[3];
						(l==1) -> control_huser == 32'b1 << m;
						(l==2) -> nonsec_trans  == 32'b1 << m;
//						(l==3) -> control_hmaster  == 32'b1 << m; //not yet supported on AHB5
						req.lock == 0;
					}) begin
						`uvm_send(req)
						totalTransactionSent += 1;
					end else begin
						`uvm_info("anvu_test",$psprintf("Invalid user bit %d value %d",l,m) , uvm_pkg::UVM_MEDIUM)
					end
				end
			end
		end
		`uvm_info("anvu_test",$psprintf("Total transaction sent : %d",totalTransactionSent) , uvm_pkg::UVM_MEDIUM)
	endtask
endclass

class anvu_ahb_master_flowControl_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_flowControl_seq)
	rand longint  startAddr         ;
	rand longint  endAddr           ;
	rand t_opcode opcode            ;
	rand int      userDelay         ;
	anvu_flow     flow              ;
	int unsigned  securityBase = 0  ;
	int unsigned  securityMask = 0  ;
	int           nbWordsSent  = 0  ;
	int           nbWordsToSend= 128;
	
	function new(string name = "anvu_ahb_master_flowControl_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		longint curAddress,firstAddress;
		int wordLength,byteLength;
		anvu_ahb_init_info ahbInfo = nocAhbInitInfoByFlowId[flow.id()];
		
		wordLength   = 16;
		byteLength   = wordLength*ahbInfo.wData/8;
		firstAddress = (startAddr%byteLength)==0 ? startAddr:startAddr-(startAddr%byteLength)+byteLength;
		curAddress   = firstAddress;
		
		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			if (!( req.randomize() with {
				addr       == curAddress;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_ahb_transaction::READ : svt_ahb_transaction::WRITE );
				burst_size == req.log2NBytePerData;
				burst_type == svt_ahb_transaction::INCR16;
				foreach(num_busy_cycles[i]) {
					num_busy_cycles[i]==0;
				}
				req.lock == 0;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			curAddress = (curAddress+2*byteLength)<=endAddr ? curAddress+byteLength : firstAddress;
			nbWordsSent+=16;
		end
	endtask
endclass

class anvu_ahb_master_oneWord_seq extends uvm_sequence #(anvu_ahb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_ahb_master_oneWord_seq)
	longint      address         ;
	bit          write           ;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;
	int unsigned userBase     = 0;
	int unsigned userMask     = 0;
	
	function new(string name = "anvu_ahb_master_oneWord_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.userBase     = userBase    ;
		req.userMask     = userMask    ;
		req.build();
		if (!( req.randomize() with {
			addr       == address;
			xact_type  == ( write ? svt_ahb_transaction::WRITE : svt_ahb_transaction::READ );
			burst_size == req.log2NBytePerData;
			burst_type == svt_ahb_transaction::SINGLE;
			foreach(num_busy_cycles[i]) {
				num_busy_cycles[i]==0;
			}
			req.lock == 0;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass

// cfg object controlling target behaviour
class anvu_ahb_rsp_cfg extends uvm_object;
	// parameter to configure how the target should generate the response status
	eStatusBehaviour statusBehaviour = STATUSRAND;
	// parameter to configure how the target should randomize delays
	eDelaysBehaviour delaysBehaviour = DELAYRAND;
	// Ready delay
	int readyDelay = 0 ;
	// assert this bit so that the field pReadyDelay is set to 0 after the next adress phase completion.
	int setToZeroReadyDelay = 0;
	
	`uvm_object_utils_begin(anvu_ahb_rsp_cfg)
		`uvm_field_enum(eStatusBehaviour   ,statusBehaviour,UVM_ALL_ON)
		`uvm_field_enum(eDelaysBehaviour   ,delaysBehaviour,UVM_ALL_ON)
		`uvm_field_int (readyDelay         ,                UVM_ALL_ON)
		`uvm_field_int (setToZeroReadyDelay,                UVM_ALL_ON)
	`uvm_object_utils_end
	
	function new( string name = "rspCfg" );
		super.new(name);
	endfunction
endclass

//! Sequence which gets response request from the response_request_port port and put them onto the response driver.
//! This overload allow to control the response characteristics, using the anvu_ahb_rsp_cfg.
class anvu_ahb_slave_sequence extends svt_ahb_slave_transaction_base_sequence;
	anvu_ahb_rsp_cfg rspCfg;
	
	`uvm_object_utils(anvu_ahb_slave_sequence)
	function new(string name="anvu_ahb_slave_sequence");
		super.new(name);
		rspCfg=new();
	endfunction
	
	virtual task body();
		svt_configuration get_cfg;
		svt_ahb_slave_agent agent;
		p_sequencer.get_cfg(get_cfg);
		if (!$cast(cfg, get_cfg))
			`uvm_fatal("anvu_test", "Unable to $cast the configuration to a svt_ahb_slave_configuration class")
		$cast(agent,p_sequencer.get_parent());
		
		forever begin
			// Gets the request from monitor
			p_sequencer.response_request_port.peek(req);
			uvm_config_db#(anvu_ahb_rsp_cfg)::get(agent,"","rspCfg",rspCfg);
			if (req.cfg == null) begin
				req.cfg = cfg;
			end
			
			if (!( req.randomize() with {
				response_type inside {svt_ahb_slave_transaction::OKAY,svt_ahb_slave_transaction::ERROR}; //no retry/split
				( rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSERR ) -> {
					response_type == svt_ahb_slave_transaction::ERROR;
				}
				( rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSOK ) -> {
					response_type == svt_ahb_slave_transaction::OKAY;
				}
				( rspCfg.delaysBehaviour==anvu_commons_pkg::FAST ) -> {
					num_wait_cycles == 0;
				}
				num_wait_cycles < 20;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			
			/**
			 * If write transaction, write data into slave built-in memory, else get
			 * data from slave built-in memory
			 */
			
			if(req.xact_type == svt_ahb_slave_transaction::WRITE) begin
				put_write_transaction_data_to_mem(req);
			end
			else begin
				get_read_data_from_mem_to_transaction(req);
			end
			
			if (rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL) req.num_wait_cycles = rspCfg.readyDelay;
			if (rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL && rspCfg.setToZeroReadyDelay==1) rspCfg.readyDelay=0;
			uvm_config_db#(anvu_ahb_rsp_cfg  )::set(agent,"","rspCfg",rspCfg);
			
			// Finally send the response
			`uvm_send(req)
		end
	endtask
endclass

