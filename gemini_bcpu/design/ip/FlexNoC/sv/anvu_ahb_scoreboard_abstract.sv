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

//! AHB Monitor callback that will feed the Scoreboard with the appropriate byte transfers.
class anvu_ahb_scoreboard_abstractor extends uvm_component;
	`uvm_component_utils(anvu_ahb_scoreboard_abstractor)
	//! The reference to the scoreboard object.
	anvu_nocAip_scoreboard scoreboard;
	//! The port for
	uvm_analysis_imp_start_transaction #(anvu_ahb_monitor_transaction,anvu_ahb_scoreboard_abstractor) transaction_start_port;
	uvm_analysis_imp_end_transaction   #(anvu_ahb_monitor_transaction,anvu_ahb_scoreboard_abstractor) transaction_end_port;

	function new(string name = "anvu_ahb_scoreboard_abstractor" , uvm_component parent);
		super.new(name,parent);
		transaction_start_port = new("transaction_start_port",this);
		transaction_end_port   = new("transaction_end_port"  ,this);
	endfunction
	virtual function void write_start_transaction( anvu_ahb_monitor_transaction ahbTr );
		scoreboard.startTransaction(ahbTr.startTime,ahbTr);
	endfunction
	virtual function void write_end_transaction( anvu_ahb_monitor_transaction ahbTr );
		anvu_flow flow       = ahbTr.socketFlow.get(0);
		bit  isInit          = nocAhbInitIdxByFlowId.exists(flow.id());
		int  idx = isInit ? nocAhbInitIdxByFlowId[flow.id()] : nocAhbTargIdxByFlowId[flow.id()] ;
		bit  posted;
		t_opcode opcode;
		longint unsigned securityFlags     = 0;
		longint unsigned securityFlagsMask = (nocSecurityFlagNb>=64)?-1:(1<<nocSecurityFlagNb)-1;
		longint unsigned userFlags         = 0;
		longint unsigned userFlagsMask     = (nocUserFlagNb>=64)?-1:(1<<nocUserFlagNb)-1;
		longint offset  ;
		longint baseAddr;
		int expNumBeats;
		int realNumBeats = ahbTr.data.size(); // Transaction can be shorter than expected, due to error for example
		int littleEndian = isInit ? nocAhbInitInfo[idx].littleEndian : nocAhbTargInfo[idx].littleEndian;
		int wData        = isInit ? nocAhbInitInfo[idx].wData        : nocAhbTargInfo[idx].wData;
		int useStrb      = isInit ? nocAhbInitInfo[idx].useStrb      : nocAhbTargInfo[idx].useStrb;
		int expNumBytes;
		
		if (ahbTr.write) begin
			opcode = anvu_noc_definitions_pkg::WRITE;
			posted = ahbTr.prot[2] == 1; //bufferable
		end else begin
			opcode = anvu_noc_definitions_pkg::READ;
			posted = 0;
		end
		case (ahbTr.burst)
			0   : expNumBeats = 1;
			1   : expNumBeats = realNumBeats;
			2,3 : expNumBeats = 4;
			4,5 : expNumBeats = 8;
			6,7 : expNumBeats = 16;
		endcase
		expNumBytes = expNumBeats*(1<<ahbTr.size);
		
		if (ahbTr.burst inside {0,1,3,5,7}) begin
			offset   = 0;
			baseAddr = ahbTr.addr;
		end else begin
			offset   = ahbTr.addr%expNumBytes;
			baseAddr = ahbTr.addr-offset;
		end
		
		//Build flags and mask based on conversion mappings.
		begin
			anvu_flag_info flagDriver;
			for (int i=0;i<nocSecurityFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocAhbInitSecurityFlagMapping[idx][i] : nocAhbTargSecurityFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::CONST        : securityFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::REQUSER      : securityFlags |= (ahbTr.user[flagDriver.index])<<i ;
					anvu_noc_definitions_pkg::SEC          : securityFlags |= (ahbTr.nonsec)<<i ;
					anvu_noc_definitions_pkg::NONE         : securityFlagsMask &= ~(1<<i);
					anvu_noc_definitions_pkg::PROT         : begin
						if      (flagDriver.index==0) securityFlags |= (!ahbTr.prot [flagDriver.index])<<i;
						else if (flagDriver.index==1) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==2) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==3) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==4) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==5) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==6) securityFlags |=   ahbTr.prot [flagDriver.index] <<i;
					end
					default : begin
						`uvm_error("anvu_test","Unexpected security flag source type")
					end
				endcase
			end
			securityFlags = securityFlags ^ nocSecurityBitInversionByFlowId[ahbTr.socketFlow.id()];
			for (int i=0;i<nocUserFlagNb;i++) begin
				if (i >= 64) break;
				flagDriver = isInit ? nocAhbInitUserFlagMapping[idx][i] : nocAhbTargUserFlagMapping[idx][i];
				case (flagDriver.flagSrc)
					anvu_noc_definitions_pkg::CONST        : userFlags |= (flagDriver.index)<<i ;
					anvu_noc_definitions_pkg::REQUSER      : userFlags |= (ahbTr.user[flagDriver.index])<<i ;
					anvu_noc_definitions_pkg::SEC          : userFlags |= (ahbTr.nonsec)<<i ;
					anvu_noc_definitions_pkg::CONNID       : userFlags |= (ahbTr.master[flagDriver.index])<<i ;
					anvu_noc_definitions_pkg::MASTER       : userFlags |= (ahbTr.master[flagDriver.index])<<i ;
					anvu_noc_definitions_pkg::NONE         : userFlagsMask &= ~(1<<i);
					anvu_noc_definitions_pkg::PROT         : begin
						if      (flagDriver.index==0) userFlags |= (!ahbTr.prot [flagDriver.index])<<i;
						else if (flagDriver.index==1) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==2) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==3) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==4) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==5) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
						else if (flagDriver.index==6) userFlags |=   ahbTr.prot [flagDriver.index] <<i;
					end
					default : begin
						`uvm_error("anvu_test","Unexpected user flag source type")
					end
				endcase
			end
			userFlags = userFlags ^ nocUserBitInversionByFlowId[ahbTr.socketFlow.id()];
		end
		for (int j=0;j<realNumBeats;j++) begin
			for (int i=0;i<(1<<ahbTr.size);i++) begin
				int byteNb  = (baseAddr+offset+i)%(wData/8);
				int bytePos = (littleEndian==0) ? byteNb :
				              (littleEndian==1) ? (byteNb/(1<<ahbTr.size)+1)*(1<<ahbTr.size)-(byteNb%(1<<ahbTr.size))-1 :
				              (littleEndian==2) ? (wData/8>=4 ? ((ahbTr.size == 0) ? ((byteNb/4)+1)*4 - (byteNb%4) - 1 :
				                                                 (ahbTr.size == 1) ? ((byteNb%4)==0  ? ((byteNb/4)+1)*4 - 2 :
				                                                                      (byteNb%4)==1  ? ((byteNb/4)+1)*4 - 1 :
				                                                                      (byteNb%4)==2  ? ((byteNb/4)+1)*4 - 4 :
				                                                                     ((byteNb/4)+1)*4 - 3):
				                                                                     byteNb) :
				                                  ((ahbTr.size == 0) ? (wData/8-1-byteNb) : byteNb)) :
				                                  (wData/8-1-byteNb);
				anvu_nocAip_byteTransfer bt = new();
				if (useStrb && ahbTr.write && ahbTr.strb[j][bytePos] != 1) continue;
				bt.m_flow              = flow;
				bt.m_status            = ahbTr.resp[j]==4 ? anvu_scoreboard_pkg::ANVU_SC_VALID :
					                 ahbTr.lock   ==1 ? anvu_scoreboard_pkg::ANVU_SC_ERROR :
					                 ahbTr.resp[j]==0 ? anvu_scoreboard_pkg::ANVU_SC_VALID :
					                                    anvu_scoreboard_pkg::ANVU_SC_ERROR ;
				bt.m_opcode            = opcode;
				bt.m_userFlags         = userFlags;
				bt.m_userFlagsMask     = userFlagsMask;
				bt.m_securityFlags     = securityFlags;
				bt.m_securityFlagsMask = securityFlagsMask;
				if (opcode == anvu_noc_definitions_pkg::WRITE && j!=ahbTr.data.size()-1)
					bt.m_posted    = 1;  // All Write beats but the last can be answered straightaway by the NoC
				else
					bt.m_posted    = posted;
				bt.m_transaction       = ahbTr;
				bt.m_address           = baseAddr+offset+i;
				bt.m_data              = ahbTr.data[j]>> (8*bytePos);
				bt.m_data              = bt.m_data[7:0]; // Do not use modulo, not working with x in the data.
				bt.m_requestDate       = ahbTr.startTime;
				bt.m_responseDate      = ahbTr.endTime;
				bt.m_dataDate          = ahbTr.dataTime[j];
				scoreboard.feedByteTransfer( bt );
			end
			if (ahbTr.burst inside {0,1,3,5,7}) offset += 1<<ahbTr.size;
			else                                offset  = (offset+(1<<ahbTr.size))%expNumBytes;
		end
		scoreboard.endTransaction(ahbTr.endTime,ahbTr);
	endfunction
endclass
