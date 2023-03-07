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
`include "anvu_ahb_defines.sv"
`include "anvu_defines.sv"

typedef enum {
	ANVU_AHB_SINGLE
,	ANVU_AHB_INCR
,	ANVU_AHB_WRAP4
,	ANVU_AHB_INCR4
,	ANVU_AHB_WRAP8
,	ANVU_AHB_INCR8
,	ANVU_AHB_WRAP16
,	ANVU_AHB_INCR16
} eAnvuAhbBurst;

class anvu_ahb_monitor_transaction extends uvm_sequence_item;
	anvu_flow                            socketFlow ;

	rand bit [`ANVU_AHB_MAX_WADDR   -1:0] addr        ;
	rand bit                              write       ;
	rand eAnvuAhbBurst                    burst       ;
	rand bit [                       2:0] size        ;
	rand bit [                       1:0] lock        ;
	rand bit [`ANVU_AHB_MAX_WPROT   -1:0] prot        ;
	rand bit [`ANVU_AHB_MAX_WAUSER  -1:0] user        ;
	rand bit [`ANVU_AHB_MAX_WMASTER -1:0] master      ;
	rand bit  nonsec        ;

	rand bit [`ANVU_AHB_MAX_WUSER  -1:0] duser[$]    ;
	rand bit [`ANVU_AHB_MAX_WDATA  -1:0] data[$]     ;
	rand bit [`ANVU_AHB_MAX_WSTRB  -1:0] strb[$]     ;
	rand bit [`ANVU_AHB_MAX_WDATA  -1:0] resp[$]     ;

	longint                              startTime;
	longint                              endTime  ;

	longint                              dataTime[$];
	longint                              respTime[$];
	
	`uvm_object_utils_begin(anvu_ahb_monitor_transaction)
		`uvm_field_int      (addr               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (write              , uvm_pkg::UVM_ALL_ON )
		`uvm_field_enum     (eAnvuAhbBurst,burst, uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (size               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (lock               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (prot               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (user               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(duser              , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (nonsec             , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (master             , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(data               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(strb               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(resp               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (startTime          , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (endTime            , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(dataTime           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(respTime           , uvm_pkg::UVM_ALL_ON )
	`uvm_object_utils_end

	function void do_print (uvm_printer printer);
		printer.print_string("socketFlow", socketFlow.str());
		super.do_print(printer);
	endfunction

	function new(string name = "anvu_ahb_monitor_transaction");
		super.new(name);
	endfunction: new
endclass


class anvu_ahb_monitor extends uvm_monitor;

   uvm_analysis_port #(anvu_ahb_monitor_transaction) transaction_start_port   ;
   uvm_analysis_port #(anvu_ahb_monitor_transaction) transaction_end_port ;

	anvu_flow socketFlow;
	
	`uvm_component_utils(anvu_ahb_monitor)

	virtual anvu_ahb_if port;

	function new(string name = "anvu_ahb_monitor" , uvm_component parent);
		super.new(name,parent);
		transaction_start_port = new("transaction_start_port",this);
		transaction_end_port   = new("transaction_end_port"  ,this);
	endfunction

	function void assign_vif(string configName);
		virtual anvu_ahb_if port;
		`ANVU_GET_CONFIG( virtual anvu_ahb_if , port , configName );
		this.port = port;
	endfunction

	task run_phase(uvm_phase phase);
		// Detection of events corresponding to the start of a new transaction
		anvu_ahb_monitor_transaction curTr;
		anvu_ahb_monitor_transaction prevTr;
		bit prevBusy;
		bit [`ANVU_AHB_MAX_WSTRB-1:0] cmdStrb;
 		fork
			begin
				forever begin
					@(posedge port.Clk);
					if (port.RstN == 1'b0) begin
						curTr    = null;
						prevTr   = null;
						prevBusy = 0;
						cmdStrb  = 0;
 					end else begin
						if (port.HSel && port.HTrans == 2 && curTr == null) begin
							curTr = new();
							curTr.write       = port.HWrite                 ;
							curTr.socketFlow  = socketFlow                  ;
							curTr.startTime   = getTimeInPs()               ;
							curTr.addr        = port.HAddr                  ;
							curTr.burst       = eAnvuAhbBurst'(port.HBurst) ;
							curTr.size        = port.HSize                  ;
							curTr.lock        = {port.HMastLock, port.HExcl};
							curTr.prot        = port.HProt                  ;
							curTr.user        = port.HAUser |  port.ReqUser ;
							curTr.master      = port.HMaster                ;
							curTr.nonsec      = port.HNonSec                ;

							transaction_start_port.write(curTr);
						end
						if (prevTr != null && prevTr.data.size()==prevTr.dataTime.size() && !prevBusy) begin
							if (prevTr.write) begin
								prevTr.data.push_back(port.HWData);
								prevTr.duser.push_back(port.HWUser);
								prevTr.strb.push_back(port.HWBe & cmdStrb);
							end 
						end
						if (port.HReadySel && prevTr != null && !prevBusy) begin
							prevTr.resp.push_back({port.HExOkay,port.HResp});
							if (!prevTr.write) begin
								prevTr.data.push_back(port.HRData);
								prevTr.duser.push_back(port.HRUser);
							end
							prevTr.respTime.push_back(getTimeInPs());
							prevTr.dataTime.push_back(getTimeInPs());
						end
						if (port.HReadySel && prevTr != null && port.HTrans inside {0,2}) begin
							prevTr.endTime = getTimeInPs();
							transaction_end_port.write(prevTr);
							prevTr = null;
						end

						if (port.HSel && port.HReadySel && port.HTrans == 2 ) begin
							prevTr = curTr;
							curTr = null;
						end
						if (port.HSel && port.HReadySel && port.HTrans == 0 ) begin
							if (curTr != null) begin
								curTr.endTime = getTimeInPs();
								transaction_end_port.write(curTr);
							end
							curTr = null;
						end
						if (port.HSel && port.HTrans inside {2,3} && port.HReadySel) begin
							cmdStrb = port.HBStrb;
						end
						prevBusy = port.HSel && port.HReadySel && port.HTrans == 1;
					end
				end
			end
		join_none
	endtask
endclass
