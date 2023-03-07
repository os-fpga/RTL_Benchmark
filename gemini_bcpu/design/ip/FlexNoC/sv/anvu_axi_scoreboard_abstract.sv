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

//! AXI Monitor callback that will feed the Scoreboard with the appropriate byte transfers.
class anvu_axi_scoreboard_abstractor extends uvm_component;
	`uvm_component_utils(anvu_axi_scoreboard_abstractor)
	//! The reference to the scoreboard object.
	anvu_nocAip_scoreboard scoreboard;
	//! The port for 
	uvm_analysis_imp_start_transaction #(anvu_axi_monitor_transaction,anvu_axi_scoreboard_abstractor) transaction_start_port;
	uvm_analysis_imp_end_transaction   #(anvu_axi_monitor_transaction,anvu_axi_scoreboard_abstractor) transaction_end_port;
	
	function new(string name = "anvu_axi_scoreboard_abstractor" , uvm_component parent);
		super.new(name,parent);
		transaction_start_port = new("transaction_start_port",this);
		transaction_end_port   = new("transaction_end_port"  ,this);
	endfunction
	virtual function void write_start_transaction( anvu_axi_monitor_transaction axiTr );
		scoreboard.startTransaction(axiTr.startTime,axiTr);
	endfunction
	virtual function void write_end_transaction( anvu_axi_monitor_transaction axiTr );
		anvu_flow  socketFlow  = axiTr.socketFlow;
		anvu_flow  flow;
		int aid = axiTr.id;
		bit isInit = nocAxiInitIdxByFlowId.exists(socketFlow.id());
		int okVal , flowIdMap;
		eAnvStatus status;
		longint unsigned securityFlags     = 0;
		longint unsigned securityFlagsMask = (nocSecurityFlagNb>=64)?-1:(1<<nocSecurityFlagNb)-1;
		longint unsigned userFlags         = 0;
		longint unsigned userFlagsMask     = (nocUserFlagNb>=64)?-1:(1<<nocUserFlagNb)-1;
		int byteStartPos;
		int nBytePerData;
		longint address ;
		int xferSize    = 2**axiTr.size;
		int xferByteLen = xferSize*(axiTr.len+1);
		bit forceNonBuf = 0;
		bit earlyWrRsp  = 0;
		if (isInit) begin
			int mstIdx;
			anvu_axi_init_info axiInfo = nocAxiInitInfoByFlowId[socketFlow.id()];
			mstIdx                     = nocAxiInitMastIdxMapByFlowId[socketFlow.id()].getMstIdxFromAid(aid);
			flow                       = socketFlow.get(mstIdx);
			nBytePerData               = axiInfo.wData/8;
			address                    = (axiTr.region<<(axiInfo.wGenAddr-axiInfo.wRegion))+axiTr.addr;
			forceNonBuf                = (
				(axiTr.opc==anvu_xactors_pkg::ANVU_AXI_WRITE && axiInfo.version!=anvu_xactors_pkg::ACE && axiInfo.forceNonBuf) //Cache0 (bufferable) is forced to 0 if bar==0 for ACE
				||  (axiInfo.version==anvu_xactors_pkg::ACE && axiTr.bar==0)
			);
			earlyWrRsp                 = (axiTr.opc == anvu_xactors_pkg::ANVU_AXI_WRITE && axiInfo.useEarlyWrRsp && axiTr.cache[0]);
		end else begin
			int slvIdx;
			anvu_axi_targ_info axiInfo = nocAxiTargInfoByFlowId[socketFlow.id()];
			flowIdMap                  = axiInfo.flowIdMap;
			slvIdx                     = getSlvIdxFromAidAndMap(aid,flowIdMap);
			flow                       = socketFlow.get(slvIdx);
			nBytePerData               = axiInfo.wData/8;
			address                    = (axiTr.region<<(axiInfo.wGenAddr-axiInfo.wRegion))+axiTr.addr;
		end
		
		//Build flags and mask based on conversion mappings.
		begin
			int idx = isInit ? nocAxiInitIdxByFlowId[flow.id()] : nocAxiTargIdxByFlowId[flow.id()] ;
			anvu_flag_info flagDriver;
			for (int i=0;i<nocSecurityFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocAxiInitSecurityFlagMapping[idx][i] : nocAxiTargSecurityFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::REQUSER : securityFlags |= (axiTr.user [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CONNID  : securityFlags |= (axiTr.id   [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CACHE   : begin 
						bit cacheBitVal = (forceNonBuf && flagDriver.index==0) ? 0 : axiTr.cache[flagDriver.index];
						securityFlags |= cacheBitVal<<i;
					end
					anvu_noc_definitions_pkg::PROT    : securityFlags |= (axiTr.prot [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CONST   : securityFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::NONE    : securityFlagsMask &= ~(1<<i);
				endcase
			end
			securityFlags = securityFlags ^ nocSecurityBitInversionByFlowId[socketFlow.id()];
			for (int i=0;i<nocUserFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocAxiInitUserFlagMapping[idx][i] : nocAxiTargUserFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::REQUSER : userFlags |= (axiTr.user [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CONNID  : userFlags |= (axiTr.id   [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::CACHE   : begin
						bit cacheBitVal = (forceNonBuf && flagDriver.index==0) ? 0 : axiTr.cache[flagDriver.index];
						userFlags |= cacheBitVal<<i;
					end
					anvu_noc_definitions_pkg::DOMAIN  : userFlags |= axiTr.domain[flagDriver.index]<<i;
					anvu_noc_definitions_pkg::SNOOP   : userFlags |= axiTr.snoop[flagDriver.index]<<i;
					anvu_noc_definitions_pkg::PROT    : userFlags |= (axiTr.prot [flagDriver.index])<<i;
					anvu_noc_definitions_pkg::QOS     : userFlags |= (axiTr.qos  [flagDriver.index])<<i;
					//anvu_noc_definitions_pkg::STRM    : userFlags |= (axiTr.burst == 0)<<i;
					anvu_noc_definitions_pkg::CONST   : userFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::NONE    : userFlagsMask &= ~(1<<i);
				endcase
			end
			userFlags = userFlags ^ nocUserBitInversionByFlowId[socketFlow.id()];
		end
		
		if (axiTr.lock == 1) okVal = 1;
		else                 okVal = 0;
		for(int i=0;i<axiTr.len+1;i++) begin
			for (int j=0;j<xferSize ; j ++ ) begin
				anvu_nocAip_byteTransfer bt = new();
				byteStartPos = address%(nBytePerData);
				if (((address+j)/xferSize) != (address/xferSize)) continue;
				if (axiTr.opc == ANVU_AXI_WRITE) begin
					if (axiTr.strb[i][j+byteStartPos] != 1) continue;
					// The NoC do not aggregate the WR status for a FIXED, so the status is not reliable for doing status checks
					// The NoC do not aggregate the WR status for narrow burst, so the status is not reliable for doing status checks between bytes for the all but the last word.
					if (
						(isInit && axiTr.burst == 0)
					||	(isInit && ((2**axiTr.size) < nBytePerData && axiTr.len>0) && i!=axiTr.len )
					)	
						status = anvu_scoreboard_pkg::ANVU_SC_UNRELIABLE;
					else if (axiTr.resp[0] == okVal)
						status = anvu_scoreboard_pkg::ANVU_SC_VALID;
					else
						status = anvu_scoreboard_pkg::ANVU_SC_ERROR;
				end else begin
					if (axiTr.resp[i] == okVal) status = anvu_scoreboard_pkg::ANVU_SC_VALID;
					else                        status = anvu_scoreboard_pkg::ANVU_SC_ERROR;
				end
				bt.m_flow              = flow;
				bt.m_status            = status;
				bt.m_opcode            = axiTr.opc==ANVU_AXI_WRITE ? anvu_noc_definitions_pkg::WRITE : anvu_noc_definitions_pkg::READ;
				bt.m_userFlags         = userFlags;
				bt.m_userFlagsMask     = userFlagsMask;
				bt.m_securityFlags     = securityFlags;
				bt.m_securityFlagsMask = securityFlagsMask;
				bt.m_posted            = earlyWrRsp;
				bt.m_transaction       = axiTr;
				bt.m_address           = address+j;
				bt.m_data              = (axiTr.data[i] >> (8*(j+byteStartPos)) );
				bt.m_data              = bt.m_data[7:0]; // Do not use modulo, not working with x in the data.
				bt.m_requestDate       = axiTr.startTime;
				bt.m_responseDate      = axiTr.endTime;
				bt.m_dataDate          = axiTr.dataTime[i];
				scoreboard.feedByteTransfer( bt );
			end
			if (axiTr.burst == 1 ) begin
				address = (address+xferSize) & (~(xferSize-1));
			end else if  (axiTr.burst == 2) begin
				address = ((address/xferByteLen)*xferByteLen)+(address+xferSize)%xferByteLen;
			end
		end
		scoreboard.endTransaction(axiTr.endTime,axiTr);
	endfunction
endclass
