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

class anvu_ahb_master_cross_base_seq extends uvm_sequence #(anvu_ahb_master_trans);
	`uvm_object_utils(anvu_ahb_master_cross_base_seq)
	anvu_ahb_init_info ahbInfo;
	int master_id;
	int nBytePerData;
	int log2NBytePerData;
	anvu_flow socketFlow;
	
	function void getDirections(ref int vals[$]);
		integer init_vals[2] = '{
			svt_ahb_transaction::READ
		,	svt_ahb_transaction::WRITE
		};
		
		vals.delete;
		foreach(init_vals[i]) vals[i] = init_vals[i];
	endfunction
	function void getBurstTypes(ref int vals[$]);
		integer init_vals[8] = '{
			svt_ahb_transaction::SINGLE
		,	svt_ahb_transaction::INCR
		,	svt_ahb_transaction::WRAP4
		,	svt_ahb_transaction::INCR4
		,	svt_ahb_transaction::WRAP8
		,	svt_ahb_transaction::INCR8
		,	svt_ahb_transaction::WRAP16
		,	svt_ahb_transaction::INCR16
		};
		
		vals.delete;
		foreach(init_vals[i]) vals[i] = init_vals[i];
	endfunction
	function void getSizes(ref int vals[$]);
		vals = {};
		for (int i=0;i<log2NBytePerData+1;i++)
			vals.push_back(i);
	endfunction
	
	function new(string name = "anvu_ahb_master_cross_base_seq");
		super.new(name);
		master_id = -1;
	endfunction : new
	
	function void build();
		if (master_id == -1 ) begin
			bit initFlowId[int];
			anvu_bench_env bench;
			string masterName;
			svt_ahb_master_agent agent;
			$cast(agent,m_sequencer.get_parent());
			$cast(bench,agent.get_parent());
			masterName       = agent.get_name();
			ahbInfo          = nocAhbInitInfo[nocAhbInitIdxByName[masterName]];
			nBytePerData     = ahbInfo.wData/8;
			log2NBytePerData = log2(nBytePerData);
			socketFlow       = Flow_fromName(masterName);
			master_id        = socketFlow.id();
		end
	endfunction
	
	task body();
	endtask
endclass

class anvu_ahb_master_cross_cmdLengthSize_seq extends anvu_ahb_master_cross_base_seq;
	`uvm_object_utils(anvu_ahb_master_cross_cmdLengthSize_seq)
	
	rand longint  startAddr;
	rand longint  endAddr  ;
	
	function new(string name = "anvu_ahb_master_cross_cmdLengthSize_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction : new
	
	virtual task body();
		int total = 0;
		int sizes[$],bursts[$],directions[$];
		build();
		getBurstTypes(bursts);
		getSizes     (sizes);
		getDirections(directions);
		
		foreach(directions[m]) begin
			foreach(bursts[n]) begin
				foreach(sizes[o]) begin
					`uvm_create(req)
					req.build();
					req.pre_randomize();
					req.xact_type .rand_mode(0); $cast(req.xact_type ,directions[m]);
					req.burst_type.rand_mode(0); $cast(req.burst_type,bursts    [n]);
					req.burst_size.rand_mode(0); $cast(req.burst_size,sizes     [o]);
					if(   (req.burst_type != svt_ahb_transaction::SINGLE && req.burst_size < ahbInfo.minXferSize)  // niu_constraints_narrowBurst in anvu_ahb_sequence.sv
					   || (req.burst_type == svt_ahb_transaction::WRAP4  && req.ahbInfo.wrapMax <  4            )  // niu_constraints_wrapMax  4  in anvu_ahb_sequence.sv
					   || (req.burst_type == svt_ahb_transaction::WRAP8  && req.ahbInfo.wrapMax <  8            )  // niu_constraints_wrapMax  8  in anvu_ahb_sequence.sv
					   || (req.burst_type == svt_ahb_transaction::WRAP16 && req.ahbInfo.wrapMax < 16            )  // niu_constraints_wrapMax 16  in anvu_ahb_sequence.sv
					)
						continue;
					if (req.randomize() with {
						addr                 >= startAddr;
						addr+16*nBytePerData <= endAddr;
						if (ahbInfo.busyIgnoreWaits) {
							foreach(num_busy_cycles[i]) {
								num_busy_cycles[i]==0;
							}
						}
						req.lock == 0;
					}) begin
						`uvm_send(req)
						total += 1;
					end else begin
						`uvm_info("anvu_test",$psprintf("Invalid Direction %d burstType %d sizes %d",directions[m],bursts[n],sizes[o]), uvm_pkg::UVM_MEDIUM)
					end
				end
			end
		end
		`uvm_info("anvu_test",$psprintf("Total transaction sent : %d",total) , uvm_pkg::UVM_MEDIUM)
	endtask
endclass

class anvu_ahb_master_thorough_seq extends uvm_sequence;
	`uvm_object_utils(anvu_ahb_master_thorough_seq)
	
	rand longint sAddr;
	rand longint eAddr;
	
	function new(string name = "anvu_ahb_master_thorough_seq");
		super.new(name);
		set_response_queue_error_report_disabled(1);
	endfunction
	task body();
		anvu_ahb_master_cross_cmdLengthSize_seq cmdLengthSizeSeq = anvu_ahb_master_cross_cmdLengthSize_seq::type_id::create();
		`uvm_do_with(cmdLengthSizeSeq,{
			startAddr == sAddr;
			endAddr   == eAddr;
		});
	endtask
endclass

