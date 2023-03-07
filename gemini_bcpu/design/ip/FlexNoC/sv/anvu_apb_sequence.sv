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


class anvu_apb_master_trans extends svt_apb_master_transaction;
	int                master_id   ;
	int                nBytePerData;
	anvu_flow          socketFlow  ;
	anvu_apb_init_info apbInfo     ;
	anvu_bench_env     bench       ;

	`uvm_object_utils_begin(anvu_apb_master_trans)
		`uvm_field_int(master_id,uvm_pkg::UVM_ALL_ON  )
	`uvm_object_utils_end

	constraint protocol_constraints {
		address     >= 0;
		address     <= (64'h1<<apbInfo.wAddr)-1;
		data        >= 0;
		data        <= (64'h1<<apbInfo.wData)-1;
		address%nBytePerData == 0;
	}
	constraint niu_constraints {
	}

	function new(string name = "anvu_apb_master_trans");
  		super.new(name);
	endfunction : new  

	//! During set_sequencer also store apbInfo and agent and bench pointers.
	virtual function void set_sequencer(uvm_sequencer_base sequencer);
		string masterName; 
		svt_apb_master_agent agent;
		super.set_sequencer(sequencer);
		$cast(agent,sequencer.get_parent());
		$cast(bench,agent.get_parent());
		masterName   = agent.get_name();
		apbInfo      = nocApbInitInfo[nocApbInitIdxByName[masterName]];
		nBytePerData = apbInfo.wData/8;
		socketFlow   = Flow_fromName(masterName);
		master_id    = socketFlow.id();
	endfunction

endclass

class anvu_apb_master_trans_forcedFlags extends anvu_apb_master_trans;
	int unsigned securityBase      = 0;
	int unsigned securityMask      = 0;
	int unsigned userBase          = 0;
	int unsigned userMask          = 0;
	int unsigned protBaseForSecu   = 0;
	int unsigned protMaskForSecu   = 0;
	int unsigned userBaseForSecu   = 0;
	int unsigned userMaskForSecu   = 0;
	int unsigned protBaseForUser   = 0;
	int unsigned protMaskForUser   = 0;
	int unsigned userBaseForUser   = 0;
	int unsigned userMaskForUser   = 0;
	int          apbInitIdx           ;

	`uvm_object_utils_begin(anvu_apb_master_trans_forcedFlags)
	`uvm_object_utils_end

	function new(string name = "anvu_apb_master_trans_forcedFlags");
  		super.new(name);
	endfunction : new  

	function void pre_randomize();
		int unsigned securityInv;
		int unsigned userInv;
		super.pre_randomize();
		securityInv = nocSecurityBitInversionByFlowId[socketFlow.id()];
		userInv = nocUserBitInversionByFlowId[socketFlow.id()];
		apbInitIdx = nocApbInitIdxByFlowId[socketFlow.id()];
		for (int i=0;i<nocSecurityFlagNb;i++) begin
			anvu_flag_info flagDriver = nocApbInitSecurityFlagMapping[apbInitIdx][i];
			bit flagValue = ((securityBase^securityInv)>>i)%2;
			if ((securityMask>>i)%2==0) continue;
			case (flagDriver.flagSrc)
				PROT : begin
					protBaseForSecu |= flagValue << flagDriver.index;
					protMaskForSecu |= 1 << flagDriver.index;
				end
				REQUSER : begin
					//apb has no user field, so no constraint can be infered from userBaseForSecu/userMaskForSecu (this is already taken into account by nocApbInitReachableSecurityLevels[]). 
					userBaseForSecu |= flagValue << flagDriver.index;
					userMaskForSecu |= 1 << flagDriver.index;
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
			anvu_flag_info flagDriver = nocApbInitUserFlagMapping[apbInitIdx][i];
			bit flagValue = ((userBase^userInv)>>i)%2;
			if ((userMask>>i)%2==0) continue;
			case (flagDriver.flagSrc)
				PROT : begin
					protBaseForUser |= flagValue << flagDriver.index;
					protMaskForUser |= 1 << flagDriver.index;
				end
				REQUSER : begin
					//apb has no user field, so no constraint can be infered from userBaseForSecu/userMaskForSecu (this is already taken into account by nocApbInitReachableSecurityLevels[]). 
					userBaseForUser |= flagValue << flagDriver.index;
					userMaskForUser |= 1 << flagDriver.index;
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

	endfunction

	//! Constrain the interface signals which drive the noc internal security and/or user flags, so that these flags match the securityBase/securityMask and/or userBase/securityMask
	constraint forceFlags {
		(protMaskForSecu[0]==1) -> pprot0   == ( protBaseForSecu[0] == 0 ? svt_apb_transaction::NORMAL    : svt_apb_transaction::PRIVILEGED         );
		(protMaskForSecu[1]==1) -> pprot1   == ( protBaseForSecu[1] == 0 ? svt_apb_transaction::SECURE    : svt_apb_transaction::NON_SECURE         );
		(protMaskForSecu[2]==1) -> pprot2   == ( protBaseForSecu[2] == 0 ? svt_apb_transaction::DATA      : svt_apb_transaction::INSTRUCTION        );
		(protMaskForUser[0]==1) -> pprot0   == ( protBaseForUser[0] == 0 ? svt_apb_transaction::NORMAL    : svt_apb_transaction::PRIVILEGED         );
		(protMaskForUser[1]==1) -> pprot1   == ( protBaseForUser[1] == 0 ? svt_apb_transaction::SECURE    : svt_apb_transaction::NON_SECURE         );
		(protMaskForUser[2]==1) -> pprot2   == ( protBaseForUser[2] == 0 ? svt_apb_transaction::DATA      : svt_apb_transaction::INSTRUCTION        );
	}

endclass

virtual class anvu_apb_sequence #(type REQ=anvu_apb_master_trans,type RSP=REQ) extends uvm_sequence#(REQ,RSP);

	function new (string name = "anvu_apb_sequence");
		super.new(name);
	endfunction

	//! post_do is used to increment number of transaction sent to the VIP for synchronization.
	//! Not incremented when the transaction is an IDLE as this does not trigger a transaction on the analysis port.
	virtual function void post_do(uvm_sequence_item this_item);
		anvu_apb_master_trans apbTr;
		super.post_do(this_item);
		$cast(apbTr,this_item);
		if (apbTr.xact_type != svt_apb_transaction::IDLE) begin
			apbTr.bench.nbTransactionSentBySocket[apbTr.socketFlow.str()] = apbTr.bench.nbTransactionSentBySocket[apbTr.socketFlow.str()]+1;
		end
	endfunction
endclass

class anvu_apb_master_random_seq extends anvu_apb_sequence #(anvu_apb_master_trans);
	`uvm_object_utils(anvu_apb_master_random_seq) 
	int nTransaction ;
	function new(string name = "anvu_apb_master_random_seq");
		super.new(name);
		nTransaction = 100;
		set_response_queue_error_report_disabled(1);
	endfunction : new  
   
	task body();
		for (int l=0; l<nTransaction ; l++ ) begin
			`uvm_create(req)
			if  (!( req.randomize() with {
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
		end
	endtask

endclass

class anvu_apb_master_registerAccess_seq extends anvu_apb_sequence #(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_registerAccess_seq) 
	anvu_registerMap_access access       ;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;

	function new(string name = "anvu_apb_master_registerAccess_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		int dataValue;
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		if (!req.apbInfo.littleEndian)
			dataValue = {access.dataValue[7:0],access.dataValue[15:8],access.dataValue[23:16],access.dataValue[31:24]};
		else
			dataValue = access.dataValue;
		if (!( req.randomize() with {
			address      == access.address;
			xact_type    == ( access.write ? svt_apb_transaction::WRITE : svt_apb_transaction::READ );
			(apbInfo.version == 4 ) -> pstrb  == 'b1111;
			if (access.write) {
				data     == dataValue;
			}
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
		get_response(rsp);
		if ( !access.write && access.dataValue != -1) begin
			int data;
			data = rsp.data >> ((access.address%req.nBytePerData)*8);
			if (!req.apbInfo.littleEndian)
				data = {data[7:0],data[15:8],data[23:16],data[31:24]};
			if ((data &access.dataMask) != (access.dataValue&access.dataMask)) begin
				anvu_flow initFlow = new(req.master_id);
				`uvm_error("anvu_test",$psprintf("Initiator %s completed an access at address %x, it received data %x while it expected %x with a mask of %x.",initFlow.str(),access.address,data,access.dataValue,access.dataMask))
			end
		end
	endtask
endclass

class anvu_apb_master_connectivity_seq extends anvu_apb_sequence #(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_connectivity_seq) 
	rand longint     startAddr    ;
	rand longint     endAddr      ;
	longint          margin       ;
    rand t_opcode    opcode       ;
	int unsigned securityBase  = 0;
	int unsigned securityMask  = 0;

	function new(string name = "anvu_apb_master_connectivity_seq");
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
			if (!( req.randomize() with {
				address >= curAddr[l];
				address <= curAddr[l]+margin;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_apb_transaction::READ : svt_apb_transaction::WRITE );
				(apbInfo.version == 4 ) -> pstrb  == 'b1111;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
		end
	endtask
endclass


class anvu_apb_master_latency_seq extends anvu_apb_sequence#(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_latency_seq) 
	rand longint  startAddr       ;
	rand longint  endAddr         ;
    rand t_opcode opcode          ;
	int  unsigned securityBase = 0;
	int  unsigned securityMask = 0;

	function new(string name = "anvu_apb_master_latency_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		if (!( req.randomize() with {
			address                  >= startAddr;
			address+req.nBytePerData <= endAddr;
			xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_apb_transaction::READ : svt_apb_transaction::WRITE );
			(apbInfo.version == 4 ) -> pstrb  == 'b1111;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass


class anvu_apb_master_throughput_seq extends anvu_apb_sequence #(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_throughput_seq) 
	rand longint  startAddr         ;
	rand longint  endAddr           ;
    rand t_opcode opcode            ;
	anvu_flow     flow              ;
	int  unsigned securityBase = 0  ;
	int  unsigned securityMask = 0  ;
	int           nbWordsSent  = 0  ;
	int           nbWordsToSend= 128;

	function new(string name = "anvu_apb_master_throughput_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		longint curAddress,firstAddress;
		int byteLength;
		anvu_apb_init_info apbInfo = nocApbInitInfoByFlowId[flow.id()];
		byteLength   = apbInfo.wData/8;
		firstAddress = startAddr;
		curAddress   = firstAddress;

		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			if (!( req.randomize() with {
				address    == curAddress;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_apb_transaction::READ : svt_apb_transaction::WRITE );
				(apbInfo.version == 4 ) -> pstrb  == 'b1111;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			curAddress = (curAddress+2*byteLength)<=endAddr ? curAddress+byteLength:firstAddress;
			nbWordsSent+=1;
		end
	endtask
endclass

class anvu_apb_master_userBit_seq extends anvu_apb_sequence#(anvu_apb_master_trans);
	`uvm_object_utils(anvu_apb_master_userBit_seq) 
	rand longint  startAddr    ;
	rand longint  endAddr      ;

	function new(string name = "anvu_apb_master_userBit_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		// user bits are not driven by APB initiators so nothing is sent here.
	endtask
endclass

class anvu_apb_master_flowControl_seq extends anvu_apb_sequence #(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_flowControl_seq) 
	rand longint  startAddr         ;
	rand longint  endAddr           ;
    rand t_opcode opcode            ;
	anvu_flow     flow              ;
	rand int userDelay              ;
	int  unsigned securityBase = 0  ;
	int  unsigned securityMask = 0  ;
	int           nbWordsSent  = 0  ;
	int           nbWordsToSend= 128;

	function new(string name = "anvu_apb_master_flowControl_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		longint curAddress,firstAddress;
		int byteLength;
		anvu_apb_init_info apbInfo = nocApbInitInfoByFlowId[flow.id()];
		byteLength   = apbInfo.wData/8;
		firstAddress = startAddr;
		curAddress   = firstAddress;

		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			if (!( req.randomize() with {
				address    == curAddress;
				xact_type  == ( opcode == anvu_noc_definitions_pkg::READ ? svt_apb_transaction::READ : svt_apb_transaction::WRITE );
				(apbInfo.version == 4 ) -> pstrb  == 'b1111;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			curAddress = (curAddress+2*byteLength)<=endAddr ? curAddress+byteLength:firstAddress;
			nbWordsSent+=1;
		end
	endtask
endclass

class anvu_apb_master_oneWord_seq extends anvu_apb_sequence #(anvu_apb_master_trans_forcedFlags);
	`uvm_object_utils(anvu_apb_master_oneWord_seq) 
	longint address                  ;
	bit     write                    ;
	int     unsigned securityBase = 0;
	int     unsigned securityMask = 0;
	int     unsigned userBase     = 0;
	int     unsigned userMask     = 0;

	function new(string name = "anvu_apb_master_oneWord_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new  

	task body();
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.userBase     = userBase;
		req.userMask     = userMask;
		if (!( req.randomize() with {
			address    == address;
			xact_type  == ( write ? svt_apb_transaction::WRITE : svt_apb_transaction::READ );
			(apbInfo.version == 4 ) -> pstrb  == 'b1111;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass

// cfg object controlling target behaviour.
class anvu_apb_rsp_cfg extends uvm_object;
	
	// parameter to configure how the target should generate the response status
	eStatusBehaviour statusBehaviour = STATUSRAND;
	// parameter to configure how the target should randomize delays
	eDelaysBehaviour delaysBehaviour = DELAYRAND;
	// pReady delay 
	int pReadyDelay = 0 ;
	// assert this bit so that the field pReadyDelay is set to 0 after the next adress phase completion.
	int setToZeroPreadyDelay = 0;

	`uvm_object_utils_begin(anvu_apb_rsp_cfg)
		`uvm_field_enum(eStatusBehaviour        ,statusBehaviour,UVM_ALL_ON)
		`uvm_field_enum(eDelaysBehaviour        ,delaysBehaviour,UVM_ALL_ON)
		`uvm_field_int (pReadyDelay             ,                UVM_ALL_ON)
		`uvm_field_int (setToZeroPreadyDelay    ,                UVM_ALL_ON)
	`uvm_object_utils_end
	
	function new( string name = "rspCfg" );
	  super.new(name);
	endfunction

endclass

//! Sequence which gets response request from the response_request_port port and put them onto the response driver.
//! This overload allow to control the response characteristics, using the anvu_axi_rsp_cfg object.
class anvu_apb_slave_sequence extends svt_apb_slave_memory_sequence;
  
 	anvu_apb_rsp_cfg rspCfg;
	
	`uvm_object_utils(anvu_apb_slave_sequence)
	function new(string name="anvu_apb_slave_sequence");
		super.new(name);
		rspCfg=new();
	endfunction

	virtual task body();
		svt_configuration get_cfg;
		svt_apb_slave_agent agent;
		p_sequencer.get_cfg(get_cfg);
		if (!$cast(cfg, get_cfg)) `uvm_fatal("anvu_test", "Unable to $cast the configuration to a svt_apb_slave_configuration class")
		//fork off a thread to pull the responses out of response queue
		sink_responses();
		// Instantiate the slave memory
		create_apb_slave_mem();
		$cast(agent,p_sequencer.get_parent());

		forever begin
			// Gets the request from monitor
			p_sequencer.response_request_port.peek(req);
			uvm_config_db#(anvu_apb_rsp_cfg)::get(agent,"","rspCfg",rspCfg);
			if (req.cfg == null) begin
				req.cfg = cfg;
			end

			if (req.xact_type != svt_apb_transaction::IDLE && !apb_slave_mem.is_in_bounds(req.address)) begin
				`uvm_warning("anvu_test", $sformatf("Attempted %s to paddr='h%0x failed.  Returning pslverr with this transaction.", req.xact_type.name(), req.address))
				if (cfg.sys_cfg.apb3_enable) req.pslverr_enable = 1;
			end else begin
				// Turn off rand_mode for the payload since it is retrieved from the memory and
				// then randomize the response.
				req.data.rand_mode(0);

				if (!( req.randomize() with {
				
					(cfg.sys_cfg.apb3_enable && rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSERR  )-> pslverr_enable  == 1;
					(cfg.sys_cfg.apb3_enable && rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSOK   )-> pslverr_enable  == 0;
					(cfg.sys_cfg.apb3_enable && rspCfg.delaysBehaviour==anvu_commons_pkg::FAST       )-> num_wait_cycles == 0;

				})) begin
					`uvm_error("anvu_test","Unexpected failing randomization")
				end

				if (!req.pslverr_enable) begin
					// For write transaction, put the write data to memory
					if(req.xact_type == svt_apb_transaction::WRITE) begin
						void'(apb_slave_mem.write(req.address,req.data,req.pstrb));
					end
					// For Read transaction, get the read data from memory
					else if(req.xact_type == svt_apb_transaction::READ)begin
						req.data = apb_slave_mem.read(req.address);
					end
				end
				else begin
					`uvm_info("body", $sformatf("pslverr issued for this transaction (address=%0d), so the memory was not updated.", req.address), UVM_HIGH)
        		end
			end
			
			if (cfg.sys_cfg.apb3_enable && rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL) req.num_wait_cycles = rspCfg.pReadyDelay;
			if (rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL && rspCfg.setToZeroPreadyDelay==1) rspCfg.pReadyDelay =0;
			uvm_config_db#(anvu_apb_rsp_cfg  )::set(agent,"","rspCfg",rspCfg);
			// Finally send the response
			`uvm_send(req)
		end
	endtask
endclass






