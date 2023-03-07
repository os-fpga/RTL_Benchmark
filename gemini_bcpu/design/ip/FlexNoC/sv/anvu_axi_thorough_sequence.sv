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


class anvu_axi_master_cross_base_seq extends uvm_sequence #(anvu_axi_master_trans);
	`uvm_object_utils(anvu_axi_master_cross_base_seq) 
	
	anvu_axi_init_info axiInfo           ;
	int                log2NBytePerData  ;
	int                nBytePerData      ;
	
	function void getCmdDirection(ref int vals[$]);
		vals.delete;
		if (axiInfo.enRd) vals.push_back(anvu_noc_definitions_pkg::READ);
		if (axiInfo.enWr) vals.push_back(anvu_noc_definitions_pkg::WRITE);
	endfunction
	function void getCmdBurstType(ref int vals[$]);
		integer init_vals[2] = '{svt_axi_transaction::INCR, svt_axi_transaction::WRAP} ;
		vals.delete;
		foreach(init_vals[i]) vals[i] = init_vals[i];
		if (axiInfo.enFixedBurst) begin
			vals.push_back(svt_axi_transaction::FIXED);
		end
	endfunction
	function void getSizes(ref int vals[$]);
		vals = {};
		for (int i=0;i<=(log2NBytePerData);i++)
			vals.push_back(i);
	endfunction
	function void getLengths(ref int vals[$]);
		vals = {};
		for(int i=1;i<=2**axiInfo.wLength;++i)
			vals.push_back(i);
	endfunction
	function new(string name = "anvu_axi_master_cross_base_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	function void build();
		string masterName;
		svt_axi_uvm_pkg::svt_axi_master_agent agent;
		$cast(agent,m_sequencer.get_parent());
		masterName       = agent.get_name();
		axiInfo          = nocAxiInitInfo[nocAxiInitIdxByName[masterName]];
		nBytePerData     = axiInfo.wData/8;
		log2NBytePerData = log2(nBytePerData);
	endfunction
	
	task body();
	endtask
endclass

class anvu_axi_master_cross_cmdLengthSize_seq extends anvu_axi_master_cross_base_seq;
	`uvm_object_utils(anvu_axi_master_cross_cmdLengthSize_seq) 
	
	longint   startAddr,endAddr,startAxiAddr,endAxiAddr,startRegion,endRegion;
	anvu_flow flow;
	
	function new(string name = "anvu_axi_master_cross_cmdLengthSize_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	virtual task body();
		int total = 0;
		int lengths[$],directions[$],sizes[$],burstTypes[$], atomicOpType[$], isAtomic[$];
		build();
		getLengths     (lengths);
		getCmdDirection(directions);
		getCmdBurstType(burstTypes);
		getSizes       (sizes);
				foreach(directions[k]) begin
					foreach(burstTypes[l]) begin
						foreach(lengths[m]) begin
							foreach(sizes[n]) begin
								int aId;
								`uvm_create(req)
								req.build();
								if(
										(burstTypes[l] == svt_axi_transaction::WRAP                 // for wrapping burst transfers
											&& (  !(lengths[m] > 1 && (lengths[m] & lengths[m]-1)==0)  // length must be 2, 4, 8 or 16
												|| (lengths[m] > req.axiInfo.wrapMax)                  // part of niu_constraints in class anvu_axi_master_trans
											)
										)
										|| (lengths[m]>1 && sizes[n]<req.axiInfo.minXferSize)          // part of niu_constraints in class anvu_axi_master_trans
										)
											continue;
										startAxiAddr  =  startAddr  % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion));
										endAxiAddr    = (endAddr-1) % (1<<(req.axiInfo.wGenAddr-req.axiInfo.wRegion));
										startRegion   =  startAddr  >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion) ;
										endRegion     = (endAddr-1) >>    (req.axiInfo.wGenAddr-req.axiInfo.wRegion) ;
										req.direction   .rand_mode(0); $cast(req.direction,directions [k]);
										req.burst_type  .rand_mode(0); $cast(req.burst_type,burstTypes[l]);
										req.burst_length.rand_mode(0); $cast(req.burst_length,lengths [m]);
										req.burst_size  .rand_mode(0); $cast(req.burst_size,sizes     [n]);
										aId = nocAxiInitMastIdxMapByFlowId[req.socketFlow.id()].getAidFromMstIdx(flow.index());
										if ( req.randomize() with {
											id == aId;
											(axiInfo.version == anvu_xactors_pkg::V3) -> {
												addr                             >= startAxiAddr;
												addr+lengths[m]*req.nBytePerData <= endAxiAddr  ;
											}
											(axiInfo.version != anvu_xactors_pkg::V3) -> {
												region >= startRegion;
												region <= endRegion  ;
												(region == startRegion) -> addr                             >= startAxiAddr;
												(region == endRegion  ) -> addr+lengths[m]*req.nBytePerData <= endAxiAddr  ;
											}
											!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> barrier_type       == svt_axi_transaction::NORMAL_ACCESS_RESPECT_BARRIER;
											!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> coherent_xact_type == svt_axi_transaction::READNOSNOOP || coherent_xact_type == svt_axi_transaction::WRITENOSNOOP ;
											!(axiInfo.version inside {anvu_xactors_pkg::V3,anvu_xactors_pkg::V4,anvu_xactors_pkg::V5,anvu_xactors_pkg::AXI_LITE}) -> domain_type        == svt_axi_transaction::NONSHAREABLE;
										}) begin
											`uvm_send(req)
											total += 1;
										end else begin
											`uvm_info("anvu_test",$psprintf("Invalid xact_type %d burst_type %d burst_length %d burst_size %d",directions[k],burstTypes[l],lengths[m],sizes[n]) , uvm_pkg::UVM_MEDIUM)
										end
									end
								end
							end
						end
		`uvm_info("anvu_test",$psprintf("Total transaction sent : %d",total) , uvm_pkg::UVM_MEDIUM)
	endtask
endclass

class anvu_axi_master_thorough_seq extends uvm_sequence;
	`uvm_object_utils(anvu_axi_master_thorough_seq) 
	
	longint   sAddr        ;
	longint   eAddr        ;
	anvu_flow flow         ;
	
	function new(string name = "anvu_axi_master_thorough_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction
	task body();
		anvu_axi_master_cross_cmdLengthSize_seq seq = anvu_axi_master_cross_cmdLengthSize_seq::type_id::create();
		seq.startAddr    = sAddr       ;
		seq.endAddr      = eAddr       ;
		seq.flow         = flow        ;
		seq.start(m_sequencer);
	endtask
endclass
