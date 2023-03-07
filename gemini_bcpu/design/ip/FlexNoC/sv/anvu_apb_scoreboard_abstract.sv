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

//! APB monitor callback that provides the scoreboard with the appropriate byte transfers.
class anvu_apb_scoreboard_abstractor extends uvm_component;
	`uvm_component_utils(anvu_apb_scoreboard_abstractor)	
	//! The reference to the scoreboard object.
	anvu_nocAip_scoreboard scoreboard;
	//! The port for 
	uvm_analysis_imp_start_transaction #(anvu_apb_monitor_transaction,anvu_apb_scoreboard_abstractor) transaction_start_port;
	uvm_analysis_imp_end_transaction   #(anvu_apb_monitor_transaction,anvu_apb_scoreboard_abstractor) transaction_end_port;
	//! Event triggered when a transaction begins.
	uvm_event startedTransactionEvent;
	//! Event triggered when a transaction ends.
	uvm_event finishedTransactionEvent;

   function new(string name = "anvu_apb_scoreboard_abstractor" , uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build();
		transaction_start_port   = new("transaction_start_port"  ,this);
		transaction_end_port     = new("transaction_end_port"    ,this);
		startedTransactionEvent  = new("startedTransactionEvent" );
		finishedTransactionEvent = new("finishedTransactionEvent");
	endfunction
	virtual function void write_start_transaction( anvu_apb_monitor_transaction apbTr );
		scoreboard.startTransaction(apbTr.startTime,apbTr);
		startedTransactionEvent.trigger(apbTr);
	endfunction
	virtual function void write_end_transaction( anvu_apb_monitor_transaction apbTr );
		anvu_flow  socketFlow  = apbTr.socketFlow;
		anvu_flow  flow;
		bit isInit = nocApbInitIdxByFlowId.exists(socketFlow.id());
		eAnvStatus status;
		int bytePos;
		longint unsigned securityFlags     = 0;
		longint unsigned securityFlagsMask = (nocSecurityFlagNb>=64)?-1:(1<<nocSecurityFlagNb)-1;
		longint unsigned userFlags         = 0;
		longint unsigned userFlagsMask     = (nocUserFlagNb>=64)?-1:(1<<nocUserFlagNb)-1;
		int nBytePerData;
		bit littleEndian; 
		if (isInit) begin
			anvu_apb_init_info apbInfo;
			apbInfo = nocApbInitInfoByFlowId[socketFlow.id()];
			nBytePerData = apbInfo.wData/8;
			littleEndian = apbInfo.littleEndian;
		end else begin
			anvu_apb_targ_info apbInfo;
			apbInfo = nocApbTargInfoByFlowId[socketFlow.id()];
			nBytePerData = apbInfo.wData/8;
			littleEndian = apbInfo.littleEndian;
		end
		flow = socketFlow.get(0);
		if (apbTr.err) status = anvu_scoreboard_pkg::ANVU_SC_ERROR;
		else           status = anvu_scoreboard_pkg::ANVU_SC_VALID;

		begin
			int idx = isInit ? nocApbInitIdxByFlowId[flow.id()] : nocApbTargIdxByFlowId[flow.id()] ;
			anvu_flag_info flagDriver;
			for (int i=0;i<nocSecurityFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocApbInitSecurityFlagMapping[idx][i] : nocApbTargSecurityFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::REQUSER : securityFlags |= (apbTr.user[flagDriver.index])<<i;
					anvu_noc_definitions_pkg::PROT    : securityFlags |= (apbTr.prot[flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CONST   : securityFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::NONE    : securityFlagsMask &= ~(1<<i);
					default : begin
						`uvm_error("anvu_test","Unexpected security flag source type")
					end
				endcase
			end
			securityFlags = securityFlags ^ nocSecurityBitInversionByFlowId[socketFlow.id()];
			for (int i=0;i<nocUserFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocApbInitUserFlagMapping[idx][i] : nocApbTargUserFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::REQUSER : userFlags |= (apbTr.user[flagDriver.index])<<i;
					anvu_noc_definitions_pkg::PROT    : userFlags |= (apbTr.prot[flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CONST   : userFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::NONE    : userFlagsMask &= ~(1<<i);
					default : begin
						`uvm_error("anvu_test","Unexpected user flag source type")
					end
				endcase
			end
			userFlags = userFlags ^ nocUserBitInversionByFlowId[socketFlow.id()];
		end

		for ( int i=0; i<nBytePerData;i++) begin
			anvu_nocAip_byteTransfer bt;
			if (littleEndian) bytePos = i;
			else              bytePos = nBytePerData-1-i;
			if (apbTr.opc==ANVU_APB_WRITE && apbTr.strb[bytePos]==0) continue;
			bt = new();
			bt.m_flow              = flow;
			bt.m_status            = status;
			bt.m_opcode            = apbTr.opc==ANVU_APB_WRITE ? anvu_noc_definitions_pkg::WRITE : anvu_noc_definitions_pkg::READ;
			bt.m_userFlags         = userFlags;
			bt.m_userFlagsMask     = userFlagsMask;
			bt.m_securityFlags     = securityFlags;
			bt.m_securityFlagsMask = securityFlagsMask;
			bt.m_posted            = 0;
			bt.m_transaction       = apbTr;
			bt.m_address           = apbTr.addr+i;
			bt.m_data              = (apbTr.data >> (8*bytePos) );
			bt.m_data              = bt.m_data[7:0]; // Do not use modulo, not working with x in the data.
			bt.m_requestDate       = apbTr.startTime;
			bt.m_responseDate      = apbTr.endTime;
			if (bt.m_opcode == anvu_noc_definitions_pkg::READ) begin
				bt.m_dataDate = apbTr.endTime;
			end else begin
				bt.m_dataDate  = apbTr.startTime;
			end
			scoreboard.feedByteTransfer( bt );
		end
		scoreboard.endTransaction(getTimeInPs(),apbTr);
		finishedTransactionEvent.trigger(apbTr);

	endfunction
endclass
