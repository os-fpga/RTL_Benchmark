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


class anvu_axi_master_trans extends svt_axi_master_transaction;
	anvu_axi_init_info axiInfo;
	int master_id;
	int log2NBytePerData;
	int nBytePerData;
	anvu_flow socketFlow;
	rand t_opcode direction;
	
	`uvm_object_utils_begin(anvu_axi_master_trans)
		`uvm_field_int(master_id,uvm_pkg::UVM_ALL_ON  )
	`uvm_object_utils_end
	
	constraint protocol_constraints {
		//addr field limited by wGenAddr which can be forced smaller than wAddr + wRegion)
		addr     >= 0;
		addr     <= (64'h1<<(axiInfo.wGenAddr-axiInfo.wRegion))-1;
		//Length field is limited by axiInfo.wLength
		burst_length <= (64'h1<<axiInfo.wLength);
	}
	
	constraint other_constraints {
		//Groups all transactions into two sets : direction==WRITE or direction==READ, depending on the address channel used. Used to simplify constraint writing.
		if 	((axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE})) {
			if (xact_type==svt_axi_transaction::READ) {direction == anvu_noc_definitions_pkg::READ ;}
			else                                      {direction == anvu_noc_definitions_pkg::WRITE;}
		} else {
			if (coherent_xact_type inside {svt_axi_transaction::WRITENOSNOOP,svt_axi_transaction::WRITEUNIQUE,svt_axi_transaction::WRITECLEAN,svt_axi_transaction::WRITEBACK,svt_axi_transaction::EVICT,svt_axi_transaction::WRITEBARRIER}) {direction == anvu_noc_definitions_pkg::WRITE ;}
			else {direction == anvu_noc_definitions_pkg::READ;}
		}
		//ACE_LITE_DVM : we use VIP as ACE version, so that there are snoop channels (used for DVM), but the socket is still ACELite, which limits the set of possible coherent transaction types.
		if (axiInfo.version == anvu_xactors_pkg::ACE_LITE_DVM) {
			(coherent_xact_type inside {READNOSNOOP,WRITENOSNOOP,READONCE,WRITEUNIQUE,WRITELINEUNIQUE,CLEANSHARED,CLEANINVALID,MAKEINVALID});
		}
	}
	
	constraint niu_constraints {
		// With FIXED, address must be aligned on size
		(burst_type == svt_axi_transaction::FIXED) -> ( addr & ((1<<burst_size)-1) ) == 0;
		// Exclusive only supported for single word accesses
		(atomic_type == svt_axi_transaction::EXCLUSIVE) -> burst_length == 1;
		// Specific NIU support
		(burst_length > 1 ) -> burst_size >= axiInfo.minXferSize;
		(atomic_type  == svt_axi_transaction::EXCLUSIVE) -> (burst_type  != svt_axi_transaction::FIXED);
		(!axiInfo.enFixedBurst) -> burst_type  != svt_axi_transaction::FIXED;
		(!axiInfo.usePreLock  ) -> atomic_type != svt_axi_transaction::LOCKED;
		(!axiInfo.useSoftLock ) -> atomic_type  != svt_axi_transaction::EXCLUSIVE;
		(burst_type == svt_axi_transaction::WRAP) -> burst_length <=  axiInfo.wrapMax;
		(burst_type == svt_axi_transaction::WRAP) -> (addr&(axiInfo.minWrapAlign-1)) == 0;
		(burst_type == svt_axi_transaction::WRAP && axiInfo.version == anvu_xactors_pkg::ACE) -> (1<<burst_size) >= axiInfo.minWrapAlign;
		(!axiInfo.enRd)         -> direction !=  anvu_noc_definitions_pkg::READ;
		(!axiInfo.enWr)         -> direction !=  anvu_noc_definitions_pkg::WRITE;
		// If FIXED, strobe must be constant and different from 0
		(burst_type == svt_axi_transaction::FIXED && direction == anvu_noc_definitions_pkg::WRITE) -> {
			wstrb[0] != 0;
			foreach (wstrb[i]) { wstrb[i]==wstrb[0];}
		}
		// For ACE sockets, burst length is limitated by param maxBurst
		(axiInfo.version==anvu_xactors_pkg::ACE) -> burst_length <= (axiInfo.maxBurst/2)/(1<<(burst_size)); //### temp /2, waiting for extra bit in generic wle
	}
	
	function new(string name = "anvu_axi_master_trans");
		super.new(name);
		master_id = -1;
	endfunction : new
	
	function void build();
		if (master_id == -1 ) begin
			bit initFlowId[int];
			string masterName;
			svt_axi_uvm_pkg::svt_axi_master_agent agent;
			$cast(agent,m_sequencer.get_parent());
			masterName       = agent.get_name();
			axiInfo          = nocAxiInitInfo[nocAxiInitIdxByName[masterName]];
			nBytePerData     = axiInfo.wData/8;
			log2NBytePerData = log2(nBytePerData);
			socketFlow       = Flow_fromName(masterName);
			master_id        = socketFlow.id();
		end
	endfunction
endclass

class anvu_axi_master_trans_forcedFlags extends anvu_axi_master_trans;
	int unsigned  securityBase      = 0;
	int unsigned  securityMask      = 0;
	int unsigned  userBase          = 0;
	int unsigned  userMask          = 0;
	int unsigned  protBaseForSecu   = 0;
	int unsigned  protMaskForSecu   = 0;
	int unsigned  userBaseForSecu   = 0;
	int unsigned  userMaskForSecu   = 0;
	int unsigned  protBaseForUser   = 0;
	int unsigned  protMaskForUser   = 0;
	int unsigned  userBaseForUser   = 0;
	int unsigned  userMaskForUser   = 0;
	int unsigned  cacheBaseForUser  = 0;
	int unsigned  cacheMaskForUser  = 0;
	int unsigned  snoopBaseForUser  = 0;
	int unsigned  snoopMaskForUser  = 0;
	int unsigned  domainBaseForUser = 0;
	int unsigned  domainMaskForUser = 0;
	int unsigned  qosBaseForUser    = 0;
	int unsigned  qosMaskForUser    = 0;
	int  axiInitIdx;
	int tabProt [3] ;
	int tabCache[4] ;
	int tabUser [32];
	int tabQos  [32];
	
	`uvm_object_utils_begin(anvu_axi_master_trans_forcedFlags)
	`uvm_object_utils_end
	
	function new(string name = "anvu_axi_master_trans_forcedFlags");
		super.new(name);
	endfunction : new
	
	function void pre_randomize();
		int unsigned securityInv;
		int unsigned userInv;
		super.pre_randomize();
		securityInv = nocSecurityBitInversionByFlowId[socketFlow.id()];
		userInv = nocUserBitInversionByFlowId[socketFlow.id()];
		axiInitIdx = nocAxiInitIdxByFlowId[socketFlow.id()];
		for (int i=0;i<nocSecurityFlagNb;i++) begin
			anvu_flag_info flagDriver = nocAxiInitSecurityFlagMapping[axiInitIdx][i];
			bit flagValue = ((securityBase^securityInv)>>i)%2;
			if ((securityMask>>i)%2==0) continue;
			case (flagDriver.flagSrc)
				PROT : begin
					protBaseForSecu |= flagValue << flagDriver.index;
					protMaskForSecu |= 1 << flagDriver.index;
				end
				REQUSER : begin
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
			anvu_flag_info flagDriver = nocAxiInitUserFlagMapping[axiInitIdx][i];
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
				CACHE : begin
					cacheBaseForUser |= flagValue << flagDriver.index;
					cacheMaskForUser |= 1 << flagDriver.index;
				end
				QOS : begin
					qosBaseForUser |= flagValue << flagDriver.index;
					qosMaskForUser |= 1 << flagDriver.index;
				end
				//SNOOP always driven to 0 for aceLite at the moment
				//SNOOP : begin
				//	userSnoopForUser |= flagValue << flagDriver.index;
				//	userSnoopForUser |= 1 << flagDriver.index;
				//end
				//DOMAIN always driven to 0 for aceLite at the moment
				//DOMAIN : begin
				//	userDomainForUser |= flagValue << flagDriver.index;
				//	userDomainForUser |= 1 << flagDriver.index;
				//end
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
	endfunction

	//! Constrain the interface signals which drive the noc internal security and/or user flags, so that these flags match the securityBase/securityMask and/or userBase/securityMask
	constraint forceFlags {
		//can't express the conditions as "val&mask==base", it fails randomization
		foreach(tabProt[i] ) { (protMaskForSecu [i] == 1 ) -> prot_type [i] == protBaseForSecu [i]; }
		foreach(tabProt[i] ) { (protMaskForUser [i] == 1 ) -> prot_type [i] == protBaseForUser [i]; }
		foreach(tabCache[i]) { (cacheMaskForUser[i] == 1 ) -> cache_type[i] == cacheBaseForUser[i]; }
		(axiInfo.version != anvu_xactors_pkg::V3) -> {foreach(tabQos [i]) { (qosMaskForUser [i] == 1 ) -> qos      [i] == qosBaseForUser [i]; } }
		foreach(tabUser[i]) { (userMaskForUser[i] == 1 ) -> addr_user[i] == userBaseForUser[i]; }
		foreach(tabUser[i]) { (userMaskForSecu[i] == 1 ) -> addr_user[i] == userBaseForSecu[i]; }
	}
endclass

class anvu_axi_master_random_seq extends uvm_sequence #(anvu_axi_master_trans);
	`uvm_object_utils(anvu_axi_master_random_seq)
	int nTransaction;
	function new(string name = "anvu_axi_master_random_seq");
		  super.new(name);
		  nTransaction = 100;
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		for (int l=0; l<nTransaction ; l++ ) begin
			`uvm_create(req)
			req.build();
			if  (!( req.randomize() with {
				atomic_type != svt_axi_transaction::EXCLUSIVE;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
		end
	endtask
endclass

class anvu_axi_master_registerAccess_seq extends uvm_sequence #(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_registerAccess_seq)
	anvu_registerMap_access access;
	anvu_flow               flow  ;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;
	
	function new(string name = "anvu_axi_master_registerAccess_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		int aId;
		longint startAxiAddr,startRegion;
		flow = new(access.initFlowId);
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.build();
		aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
		startAxiAddr  = access.address   % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion));
		startRegion   = access.address   >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion) ;
		if (!( req.randomize() with {
			direction == ( access.write ? anvu_noc_definitions_pkg::WRITE : anvu_noc_definitions_pkg::READ );
			addr == startAxiAddr;
			(axiInfo.version != anvu_xactors_pkg::V3) ->  region == startRegion;
			burst_length == 1 ;
			burst_size   == 2;
			atomic_type == svt_axi_transaction::NORMAL;
			burst_type==svt_axi_transaction::INCR;
			(direction == anvu_noc_definitions_pkg::WRITE) -> {
				foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
			}
			id  == aId;
			data[0]==access.dataValue;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		
		`uvm_send(req)
		get_response(rsp);
		if ( !access.write && access.dataValue != -1) begin
			int data;
			data = rsp.data[0];
			if ((data &access.dataMask) != (access.dataValue&access.dataMask)) begin
				anvu_flow initFlow = new(req.master_id);
				`uvm_error("anvu_test",$psprintf("Initiator %s completed an access at address %x, it received data %x while it expected %x with a mask of %x.",initFlow.str(),access.address,data,access.dataValue,access.dataMask))
			end
		end
	endtask
endclass

class anvu_axi_master_connectivity_seq extends uvm_sequence#(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_connectivity_seq)
	longint       startAddr       ;
	longint       endAddr         ;
	longint       margin          ;
	t_opcode      opcode          ;
	anvu_flow     flow            ;
	int  unsigned securityBase = 0;
	int  unsigned securityMask = 0;
	
	function new(string name = "anvu_axi_master_connectivity_seq");
		  super.new(name);
		  margin = 64'h1000;
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		// Do two simple access at the bottom of the range and at the top of the range, with the defined opcode
		longint curStartAddr[2],startAxiAddr,startRegion;
		margin = margin<(endAddr-startAddr)?margin:(endAddr-startAddr);
		curStartAddr = '{ startAddr, endAddr-margin };
		foreach (curStartAddr[l] ) begin
			int aId;
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
			startAxiAddr  = curStartAddr[l] % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion));
			startRegion   = curStartAddr[l] >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion);
			if (!( req.randomize() with {
				direction == opcode;
				(axiInfo.version != anvu_xactors_pkg::V3) ->  region == startRegion;
				addr                  >= startAxiAddr;
				addr+req.nBytePerData <= startAxiAddr+margin;
				(addr & (req.nBytePerData-1)) == 0;
				atomic_type == svt_axi_transaction::NORMAL;
				burst_length == 1 ;
				burst_size== req.log2NBytePerData;
				burst_type==svt_axi_transaction::INCR;
				(direction == anvu_noc_definitions_pkg::WRITE) -> {
					foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
				}
				id  == aId;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
		end
	endtask
endclass

class anvu_axi_master_latency_seq extends uvm_sequence#(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_latency_seq)
	longint      startAddr       ;
	longint      endAddr         ;
	t_opcode     opcode          ;
	anvu_flow    flow            ;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;
	
	function new(string name = "anvu_axi_master_latency_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		int aId;
		longint startAxiAddr,endAxiAddr,startRegion,endRegion;
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.build();
		aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
		startAxiAddr  =   startAddr  % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion))   ;
		endAxiAddr    = ((endAddr-1) % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion)))+1;
		startRegion   =   startAddr  >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion)    ;
		endRegion     =  (endAddr-1) >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion)    ;
		// Do a single simple transaction within the address range, ensuring no delays are introduced
		if (!( req.randomize() with {
			direction == opcode;
			(axiInfo.version == anvu_xactors_pkg::V3) -> {
				addr                  >= startAxiAddr;
				addr+req.nBytePerData <= endAxiAddr;
			}
			(axiInfo.version != anvu_xactors_pkg::V3) -> {
				region >= startRegion;
				region <= endRegion  ;
				(region == startRegion) -> addr                  >= startAxiAddr;
				(region == endRegion  ) -> addr+req.nBytePerData <= endAxiAddr  ;
			}
			(addr & (req.nBytePerData-1)) == 0;
			atomic_type == svt_axi_transaction::NORMAL;
			burst_length == 1 ;
			burst_size== req.log2NBytePerData;
			burst_type==svt_axi_transaction::INCR;
			addr_valid_delay == 0;
			bready_delay == 0;
			foreach (wvalid_delay [i]) wvalid_delay[i] ==0;
			foreach (rready_delay[i]) rready_delay[i] ==0;
			reference_event_for_first_wvalid_delay == svt_axi_transaction::WRITE_ADDR_VALID;//necessary to have awvalid/wvalid asserted at the same time
			(direction == anvu_noc_definitions_pkg::WRITE) -> {
				foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
			}
			id  == aId;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass

class anvu_axi_master_throughput_seq extends uvm_sequence #(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_throughput_seq)
	longint      startAddr         ;
	longint      endAddr           ;
	t_opcode     opcode            ;
	anvu_flow    flow              ;
	int unsigned securityBase = 0  ;
	int unsigned securityMask = 0  ;
	int          nbWordsSent  = 0  ;
	int          nbWordsToSend= 128;
	
	function new(string name = "anvu_axi_master_throughput_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		longint startAxiAddr,endAxiAddr,startRegion,endRegion;
		longint firstAddress,curAddress;
		int wordLength,byteLength;
		anvu_axi_init_info axiInfo = nocAxiInitInfoByFlowId[flow.id()];
		
		// translate generic start/end addr to specific start/end addr and start/end region
		startAxiAddr  =   startAddr  % (1<<(axiInfo.wGenAddr-axiInfo.wRegion))   ;
		endAxiAddr    = ((endAddr-1) % (1<<(axiInfo.wGenAddr-axiInfo.wRegion)))+1;
		startRegion   =   startAddr  >>    (axiInfo.wGenAddr-axiInfo.wRegion)    ;
		endRegion     =  (endAddr-1) >>    (axiInfo.wGenAddr-axiInfo.wRegion)    ;
		// find the largest possible length, to do the accesses on burst aligned address
		for (int i=0;i<8;i++) begin
			wordLength = 128>>i;
			byteLength=wordLength*axiInfo.wData/8;
			if (axiInfo.version == anvu_xactors_pkg::ACE && byteLength > axiInfo.maxBurst/2   ) continue; //### temp /2
			if (axiInfo.version == anvu_xactors_pkg::ACE && byteLength > axiInfo.cacheLineSize) continue;
			if (wordLength > (1<<axiInfo.wLength)) continue;
			firstAddress = (startAxiAddr%byteLength)==0 ? startAxiAddr:startAxiAddr-(startAxiAddr%byteLength)+byteLength; //firstAddress = startAxiAddr rounded up to the next address aligned on byteLength
			if (startRegion==endRegion) begin
				if ( firstAddress+byteLength<=endAxiAddr        ) break;
			end else
				if ( firstAddress+byteLength<=(1<<axiInfo.wAddr)) break;
		end
		curAddress=firstAddress;
		
		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			int aId;
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
			req.reasonable_burst_length.constraint_mode(0);
			if (!( req.randomize() with {
				direction == opcode;
				addr         == curAddress;
				region       == startRegion;
				burst_length == wordLength;
				
				atomic_type == svt_axi_transaction::NORMAL;
				burst_size== req.log2NBytePerData;
				burst_type==svt_axi_transaction::INCR;
				addr_valid_delay == 0;
				bready_delay == 0;
				foreach (wvalid_delay [i]) wvalid_delay[i] ==0;
				foreach (rready_delay[i]) rready_delay[i] ==0;
				reference_event_for_first_wvalid_delay == svt_axi_transaction::WRITE_ADDR_VALID;//necessary to have awvalid/wvalid asserted at the same time
				(direction == anvu_noc_definitions_pkg::WRITE) -> {
					foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
				}
				id  == aId;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			`uvm_send(req)
			nbWordsSent+=req.burst_length;
			if (startRegion==endRegion) curAddress = (curAddress+2*byteLength)<=endAxiAddr         ? curAddress+byteLength:firstAddress;
			else                        curAddress = (curAddress+2*byteLength)<=(1<<axiInfo.wAddr) ? curAddress+byteLength:firstAddress;
		end
	endtask
endclass

class anvu_axi_master_userBit_seq extends uvm_sequence #(anvu_axi_master_trans);
	`uvm_object_utils(anvu_axi_master_userBit_seq)
	
	int       totalTransactionSent;
	longint   startAddr           ;
	longint   endAddr             ;
	anvu_flow flow                ;
	
	function new(string name = "anvu_axi_master_userBit_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	virtual task body();
		int cmds[2] = '{ anvu_noc_definitions_pkg::READ, anvu_noc_definitions_pkg::WRITE};
		int totalTransactionSent = 0;
		int nSignal,nValue;
		// Signal order 0 to n : Cache, Prot, User
		nSignal = 3;
		foreach(cmds[k]) begin
			for(int l=0;l<nSignal;l++) begin
				case (l)
					0 : nValue = 16; // wCache = 4
					1 : nValue = 8;  // wProt  = 3
					2 : nValue = 32; // wReqUser Max = 32
				endcase
				for(int m=0;m<nValue;m++) begin
					int aId;
					longint startAxiAddr,endAxiAddr,startRegion,endRegion;
					`uvm_create(req)
					req.build();
					aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
					startAxiAddr  =   startAddr  % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion))   ;
					endAxiAddr    = ((endAddr-1) % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion)))+1;
					startRegion   =   startAddr  >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion)    ;
					endRegion     =  (endAddr-1) >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion)    ;
					
					//removing some cases which are forbidden to speed up simulation
					if (l==0 && m[1]==0 && (m[2]==1 || m[3]==1)                        ) continue;//removing cases which don't respect : non cacheable => no read/write allocate
					if (l==0 && req.axiInfo.version==anvu_xactors_pkg::AXI_LITE        ) continue;//in lite can't drive cache
					if (l==2 && req.axiInfo.version==anvu_xactors_pkg::V3              ) continue;//in v3 can't drive aXuser
					if (l==2 && m >= req.axiInfo.wUser                                 ) continue;
					if (cmds[k] == anvu_noc_definitions_pkg::READ  && !req.axiInfo.enRd) continue;
					if (cmds[k] == anvu_noc_definitions_pkg::WRITE && !req.axiInfo.enWr) continue;
					
					if ( req.randomize() with {
						direction == cmds[k];
						(axiInfo.version == anvu_xactors_pkg::V3) -> {
							addr                     >= startAxiAddr;
							addr+req.nBytePerData <= endAxiAddr  ;
						}
						(axiInfo.version != anvu_xactors_pkg::V3) -> {
							region >= startRegion;
							region <= endRegion  ;
							(region == startRegion) -> addr                     >= startAxiAddr;
							(region == endRegion  ) -> addr+req.nBytePerData <= endAxiAddr  ;
						}
						( addr & (req.nBytePerData-1) ) == 0;
						burst_length == 1;
						burst_size   == req.log2NBytePerData ;
						atomic_type == svt_axi_transaction::NORMAL;
						burst_type==svt_axi_transaction::INCR;
						id  == aId;
						
						(l==0) -> cache_type == m;
						(l==1) -> prot_type  == m;
						(l==2) -> addr_user  == 32'b1 << m;
						!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
						!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
						!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
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

class anvu_axi_master_flowControl_seq extends uvm_sequence #(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_flowControl_seq)
	longint      startAddr         ;
	longint      endAddr           ;
	t_opcode     opcode            ;
	int          userDelay         ;
	anvu_flow    flow              ;
	int unsigned securityBase = 0  ;
	int unsigned securityMask = 0  ;
	int          nbWordsSent  = 0  ;
	int          nbWordsToSend= 128;
	
	function new(string name = "anvu_axi_master_flowControl_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		longint startAxiAddr,endAxiAddr,startRegion,endRegion;
		longint firstAddress,curAddress;
		int wordLength,byteLength;
		bit firstTrans=1;
		anvu_axi_init_info axiInfo = nocAxiInitInfoByFlowId[flow.id()];
		
		// translate generic start/end addr to specific start/end addr and start/end region
		startAxiAddr  =   startAddr  % (1<<(axiInfo.wGenAddr-axiInfo.wRegion))   ;
		endAxiAddr    = ((endAddr-1) % (1<<(axiInfo.wGenAddr-axiInfo.wRegion)))+1;
		startRegion   =   startAddr  >>    (axiInfo.wGenAddr-axiInfo.wRegion)    ;
		endRegion     =  (endAddr-1) >>    (axiInfo.wGenAddr-axiInfo.wRegion)    ;
		// find the largest possible length, to do the accesses on burst aligned address
		for (int i=0;i<8;i++) begin
			wordLength = 128>>i;
			byteLength=wordLength*axiInfo.wData/8;
			if (axiInfo.version == anvu_xactors_pkg::ACE && byteLength > axiInfo.maxBurst/2   ) continue; //### temp /2
			if (axiInfo.version == anvu_xactors_pkg::ACE && byteLength > axiInfo.cacheLineSize) continue;
			if (wordLength > (1<<axiInfo.wLength)) continue;
			firstAddress = (startAxiAddr%byteLength)==0 ? startAxiAddr:startAxiAddr-(startAxiAddr%byteLength)+byteLength; //firstAddress = startAxiAddr rounded up to the next address aligned on byteLength
			if (startRegion==endRegion) begin
				if ( firstAddress+byteLength<=endAxiAddr        ) break;
			end else
				if ( firstAddress+byteLength<=(1<<axiInfo.wAddr)) break;
		end
		curAddress=firstAddress;
		
		// Generates enough transactions to reach at least nbWordsToSend words
		while(nbWordsSent<nbWordsToSend) begin
			int aId;
			`uvm_create(req)
			req.securityBase = securityBase;
			req.securityMask = securityMask;
			req.build();
			aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
			req.reasonable_burst_length.constraint_mode(0);
			req.reasonable_bready_delay.constraint_mode(0);
			if (!( req.randomize() with {
				direction == opcode;
				addr         == curAddress;
				region       == startRegion;
				burst_length == wordLength;
				
				burst_size== req.log2NBytePerData;
				atomic_type == svt_axi_transaction::NORMAL;
				burst_type==svt_axi_transaction::INCR;
				addr_valid_delay == 0;
				foreach (wvalid_delay [i]) wvalid_delay[i] ==0;
				reference_event_for_first_wvalid_delay == svt_axi_transaction::WRITE_ADDR_VALID;//necessary to have awvalid/wvalid asserted at the same time
				(direction == anvu_noc_definitions_pkg::WRITE) -> {
					foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
				}
				id  == aId;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
				!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			req.bready_delay = ( firstTrans == 1  ? userDelay : 0 );
			foreach (req.rready_delay[i]) req.rready_delay[i] = ( firstTrans == 1 && i == 0 ? userDelay : 0 );
			`uvm_send(req)
			nbWordsSent+=req.burst_length;
			if (startRegion==endRegion) curAddress = (curAddress+2*byteLength)<=endAxiAddr         ? curAddress+byteLength:firstAddress;
			else                        curAddress = (curAddress+2*byteLength)<=(1<<axiInfo.wAddr) ? curAddress+byteLength:firstAddress;
			firstTrans=0;
		end
	endtask
endclass

class anvu_axi_master_oneWord_seq extends uvm_sequence #(anvu_axi_master_trans_forcedFlags);
	`uvm_object_utils(anvu_axi_master_oneWord_seq)
	longint      address         ;
	bit          write           ;
	anvu_flow    flow            ;
	int unsigned securityBase = 0;
	int unsigned securityMask = 0;
	int unsigned userBase     = 0;
	int unsigned userMask     = 0;
	
	function new(string name = "anvu_axi_master_oneWord_seq");
		  super.new(name);
		  set_response_queue_error_report_disabled(1);
	endfunction : new
	
	task body();
		// Do a single simple transaction within the address range, ensuring no delays are introduced
		int aId;
		longint startAxiAddr,startRegion;
		`uvm_create(req)
		req.securityBase = securityBase;
		req.securityMask = securityMask;
		req.userBase     = userBase;
		req.userMask     = userMask;
		req.build();
		aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
		startAxiAddr  = address   % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion));
		startRegion   = address   >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion) ;
		if (!( req.randomize() with {
			direction == ( write ? anvu_noc_definitions_pkg::WRITE : anvu_noc_definitions_pkg::READ );
			addr      == startAxiAddr;
			(axiInfo.version != anvu_xactors_pkg::V3) ->  region == startRegion;
			atomic_type == svt_axi_transaction::NORMAL;
			burst_length == 1;
			burst_size== req.log2NBytePerData;
			burst_type==svt_axi_transaction::INCR;
			addr_valid_delay == 0;
			bready_delay == 0;
			foreach (wvalid_delay [i]) wvalid_delay[i] ==0;
			foreach (rready_delay[i]) rready_delay[i] ==0;
			reference_event_for_first_wvalid_delay == svt_axi_transaction::WRITE_ADDR_VALID;//necessary to have awvalid/wvalid asserted at the same time
			(direction == anvu_noc_definitions_pkg::WRITE) -> {
				foreach (wstrb[i]) { wstrb[i]==( 64'h1 << (64'h1<<burst_size) ) -1;}
			}
			id  == aId;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
			!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
		})) begin
			`uvm_error("anvu_test","Unexpected failing randomization")
		end
		`uvm_send(req)
	endtask
endclass

//! cfg object controlling target behaviour.
class anvu_axi_rsp_cfg extends uvm_object;
	
	// parameter to configure how the target should generate the response status
	eStatusBehaviour statusBehaviour = STATUSRAND;
	// parameter to configure how the target should randomize delays
	eDelaysBehaviour delaysBehaviour = DELAYRAND;
	// delay during which aXready is kept low after an address phase completion (aXready==aXValid==1). Used only if delaysBehaviour = FLOWCONTROL
	int aXreadyDelay = 0;
	// assert this bit so that the previous field setToZeroAXreadyDelay is set to zero after the next transaction
	int setToZeroAXreadyDelay = 0;
	
	`uvm_object_utils_begin(anvu_axi_rsp_cfg)
		`uvm_field_enum(eStatusBehaviour        ,statusBehaviour,UVM_ALL_ON)
		`uvm_field_enum(eDelaysBehaviour        ,delaysBehaviour,UVM_ALL_ON)
		`uvm_field_int (aXreadyDelay            ,                UVM_ALL_ON)
		`uvm_field_int (setToZeroAXreadyDelay   ,                UVM_ALL_ON)
	`uvm_object_utils_end
	
	function new( string name = "rspCfg" );
	  super.new(name);
	endfunction
endclass

//! Sequence which gets response request from the response_request_port port and put them onto the response driver.
//! This overload allow to control the response characteristics, using the anvu_axi_rsp_cfg object.
class anvu_axi_slave_sequence extends svt_axi_slave_base_sequence;
	`uvm_object_utils(anvu_axi_slave_sequence)
	
	svt_axi_slave_transaction req_resp;
	anvu_axi_rsp_cfg          rspCfg;
	
	function new(string name="anvu_axi_slave_sequence");
		super.new(name);
		rspCfg=new();
	endfunction
	
	virtual task body();
		string slaveName;
		svt_configuration get_cfg;
		svt_axi_slave_agent agent;
		anvu_axi_targ_info axiInfo;
		bit inOrder;
		$cast(agent,m_sequencer.get_parent());
		p_sequencer.get_cfg(get_cfg);
		if (!$cast(cfg, get_cfg)) `uvm_fatal("anvu_test", "Unable to $cast the configuration to a svt_axi_port_configuration class")
		slaveName = agent.get_name();

		axiInfo = nocAxiTargInfo[nocAxiTargIdxByName[slaveName]];

		inOrder = axiInfo.inOrder;
		
		forever begin
			p_sequencer.response_request_port.peek(req_resp);
			uvm_config_db#(anvu_axi_rsp_cfg)::get(agent,"","rspCfg",rspCfg);
			if (!( req_resp.randomize() with {
				enable_interleave == !inOrder;
				( rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSERR ) -> {
					bresp == svt_axi_transaction::SLVERR;
					foreach(rresp[i])
						rresp[i] == svt_axi_transaction::SLVERR;
				}
				( rspCfg.statusBehaviour==anvu_commons_pkg::ALWAYSOK ) -> {
					bresp == svt_axi_transaction::OKAY;
					foreach(rresp[i])
						rresp[i] inside { svt_axi_transaction::OKAY, svt_axi_transaction::EXOKAY };
				}
				( rspCfg.delaysBehaviour==anvu_commons_pkg::FAST ) -> {
					addr_ready_delay == 0;
					bvalid_delay ==0;
					foreach (rvalid_delay[i])
						rvalid_delay[i] ==0;
					foreach (wready_delay[i])
						wready_delay[i] ==0;
				}
			})) begin
				`uvm_error("anvu_test","Unexpected failing randomization")
			end
			if (
				req_resp.xact_type == svt_axi_transaction::WRITE
			||	(	req_resp.xact_type == svt_axi_transaction::COHERENT
				&&  req_resp.coherent_xact_type inside {svt_axi_transaction::WRITENOSNOOP,svt_axi_transaction::WRITEUNIQUE,svt_axi_transaction::WRITECLEAN,svt_axi_transaction::WRITEBACK,svt_axi_transaction::EVICT,svt_axi_transaction::WRITEBARRIER}
				)
			) begin
				put_write_transaction_data_to_mem(req_resp);
			end else if (req_resp.xact_type == svt_axi_transaction::COHERENT) begin
				get_read_data_from_mem_to_transaction(req_resp);
			end
			if (rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL)
				req_resp.addr_ready_delay = rspCfg.aXreadyDelay;
			if (rspCfg.delaysBehaviour==anvu_commons_pkg::FLOWCONTROL && rspCfg.setToZeroAXreadyDelay==1)
				rspCfg.aXreadyDelay=0;
			uvm_config_db#(anvu_axi_rsp_cfg)::set(agent,"","rspCfg",rspCfg);
			$cast(req,req_resp);
			`uvm_send(req)
		end
	endtask: body
endclass


