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

`include "uvm_macros.svh"
`include "anvu_axi_defines.sv"
`include "anvu_uvm_macros.sv"

typedef enum { ANVU_AXI_READ , ANVU_AXI_WRITE } eAnvAxiOpc;
//! Enum to describe the version of the AXI socket
`ifndef ANVU_AXIVERSION_DEFINE
`define ANVU_AXIVERSION_DEFINE
typedef enum { V3 , V4 , V5 , ACE_LITE , ACE_LITE_DVM , ACE , AXI_LITE } eAxiVersion;
`endif

class anvu_axi_monitor_transaction extends uvm_sequence_item;
	anvu_flow                            socketFlow ;

	rand eAnvAxiOpc                      opc     ;
	rand bit [`ANVU_AXI_MAX_WADDR  -1:0] addr    ;
	rand bit [`ANVU_AXI_MAX_WID    -1:0] id      ;
	rand bit [`ANVU_AXI_MAX_WLEN   -1:0] len     ;
	rand bit [                      2:0] size    ;
	rand bit [                      1:0] burst   ;
	rand bit [                      1:0] lock    ;
	rand bit [                      3:0] cache   ;
	rand bit [                      2:0] prot    ;
	rand bit [`ANVU_AXI_MAX_WUSER  -1:0] user    ;
	rand bit [`ANVU_AXI_MAX_WREGION-1:0] region  ;
	rand bit [`ANVU_AXI_MAX_WQOS   -1:0] qos     ;
	rand bit [                      3:0] snoop   ;
	rand bit [                      2:0] bar     ;
	rand bit [                      2:0] domain  ;
	rand bit [                      5:0] atop    ;

	rand bit [`ANVU_AXI_MAX_WDATA  -1:0] data[$] ;
	rand bit [`ANVU_AXI_MAX_WSTRB  -1:0] strb[$] ;
	rand bit [`ANVU_AXI_MAX_WDATA  -1:0] resp[$] ;

	longint                             startTime;
	longint                             endTime;

	longint                             dataTime[$];
	longint                             respTime[$];
	//! AXI version 
	eAxiVersion                         version;

	`uvm_object_utils_begin(anvu_axi_monitor_transaction)
		`uvm_field_enum     (eAnvAxiOpc,opc     , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (addr               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (id                 , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (len                , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (size               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (burst              , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (lock               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (cache              , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (prot               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (user               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (region             , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (qos                , uvm_pkg::UVM_ALL_ON )
	    `uvm_field_int      (atop                , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (snoop              , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (bar                , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (domain             , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(data               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(strb               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(resp               , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (startTime          , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (endTime            , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(dataTime           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_queue_int(respTime           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_enum     (eAxiVersion,version, uvm_pkg::UVM_ALL_ON )
	`uvm_object_utils_end

	function void do_print (uvm_printer printer);
		printer.print_string("socketFlow", socketFlow.str());
		super.do_print(printer);
	endfunction

	function new(string name = "anvu_axi_monitor_transaction");
		super.new(name);
	endfunction

endclass

typedef struct {
	bit [`ANVU_AXI_MAX_WDATA-1:0] data;
	bit [`ANVU_AXI_MAX_WSTRB-1:0] strb;
	longint                       dataTime;
} anvu_axi_monitor_data;

class anvu_axi_monitor extends uvm_monitor;

	uvm_analysis_port #(anvu_axi_monitor_transaction) transaction_start_port ;
	uvm_analysis_port #(anvu_axi_monitor_transaction) transaction_end_port ;

	anvu_flow socketFlow;
	//! version 
	eAxiVersion version;

	`uvm_component_utils(anvu_axi_monitor)

	virtual anvu_axi_if port;

	anvu_axi_monitor_transaction wrTr  [*][$];
	anvu_axi_monitor_transaction rdTr  [*][$];
	anvu_axi_monitor_data        wrData[*][$];

	anvu_axi_monitor_transaction curRdTr;
	anvu_axi_monitor_transaction curWrTr;
	anvu_axi_monitor_transaction curAtomTr;

	//! Queue used to reassociate write commands and the coresponding data when the write response is send. Used only with AXI V4 (for which write data don't have id)
	int writeDataLengthAndIdFifo[$][2];

	function new(string name, uvm_component parent);
		super.new(name,parent);
		transaction_start_port = new("transaction_start_port",this);
		transaction_end_port   = new("transaction_end_port"  ,this);
	endfunction

	function void assign_vif(string configName);
		virtual anvu_axi_if port;
		`ANVU_GET_CONFIG( virtual anvu_axi_if , port , configName );
		this.port = port;
	endfunction

	task run_phase(uvm_phase phase);
		fork
			forever begin
				@(posedge port.Clk);
				if (!port.RstN) begin
					wrTr.delete;
					rdTr.delete;
					wrData.delete;
					curRdTr   = null;
					curWrTr   = null;
					curAtomTr = null;
				end
				if (port.ArValid ) begin
					if (curRdTr == null ) begin
						curRdTr = new();
						curRdTr.socketFlow = socketFlow    ;
						curRdTr.opc        = ANVU_AXI_READ ;
						curRdTr.startTime  = getTimeInPs() ;
						curRdTr.addr       = port.ArAddr   ;
						curRdTr.id         = port.ArId     ;
						curRdTr.len        = port.ArLen    ;
						curRdTr.size       = port.ArSize   ;
						curRdTr.burst      = port.ArBurst  ;
						curRdTr.lock       = port.ArLock   ;
						curRdTr.cache      = port.ArCache  ;
						curRdTr.prot       = port.ArProt   ;
						curRdTr.user       = port.ArUser   ;
						curRdTr.region     = port.ArRegion ;
						curRdTr.qos        = port.ArQos    ;
						curRdTr.snoop      = port.ArSnoop  ;
						curRdTr.bar        = port.ArBar    ;
						curRdTr.domain     = port.ArDomain ;
						curRdTr.version    = version       ;
						transaction_start_port.write(curRdTr);
					end
					if (port.ArReady) begin
						if (!rdTr.exists(curRdTr.id)) rdTr[curRdTr.id] = {};
						rdTr[curRdTr.id].push_back(curRdTr);
						curRdTr = null;
					end
				end
				if (port.AwValid ) begin
					if (curWrTr == null ) begin
						curWrTr = new();
						curWrTr.socketFlow = socketFlow    ;
						curWrTr.opc        = ANVU_AXI_WRITE;
						curWrTr.startTime  = getTimeInPs() ;
						curWrTr.addr       = port.AwAddr   ;
						curWrTr.id         = port.AwId     ;
						curWrTr.len        = port.AwLen    ;
						curWrTr.size       = port.AwSize   ;
						curWrTr.burst      = port.AwBurst  ;
						curWrTr.lock       = port.AwLock   ;
						curWrTr.cache      = port.AwCache  ;
						curWrTr.prot       = port.AwProt   ;
						curWrTr.user       = port.AwUser   ;
						curWrTr.region     = port.AwRegion ;
						curWrTr.qos        = port.AwQos    ;
						curWrTr.snoop      = port.AwSnoop  ;
						curWrTr.bar        = port.AwBar    ;
						curWrTr.domain     = port.AwDomain ;
						curWrTr.atop       = port.AwAtop ;
						curWrTr.version    = version       ;
						transaction_start_port.write(curWrTr);
						if (curWrTr.atop != 0  && ((curWrTr.atop>>4)!=1)) begin
							//atomic access but not atomic store, has RD response
							curAtomTr = new();
							curAtomTr.socketFlow = socketFlow    ;
							curAtomTr.opc        = ANVU_AXI_READ ;
							curAtomTr.startTime  = getTimeInPs() ;
							curAtomTr.addr       = port.AwAddr   ;
							curAtomTr.id         = port.AwId     ;
							curAtomTr.len        = port.AwLen    ;
							curAtomTr.size       = port.AwSize   ;
							curAtomTr.burst      = port.AwBurst  ;
							curAtomTr.lock       = port.AwLock   ;
							curAtomTr.cache      = port.AwCache  ;
							curAtomTr.prot       = port.AwProt   ;
							curAtomTr.user       = port.AwUser   ;
							curAtomTr.region     = port.AwRegion ;
							curAtomTr.qos        = port.AwQos    ;
							curAtomTr.snoop      = port.AwSnoop  ;
							curAtomTr.bar        = port.AwBar    ;
							curAtomTr.domain     = port.AwDomain ;
							curAtomTr.atop       = port.AwAtop   ;
							curAtomTr.version    = version       ;
							if (curAtomTr.atop == 49) begin
								// Atomic compare
								if (curAtomTr.len>0) begin
									curAtomTr.len = curAtomTr.len/2;
								end else begin
									curAtomTr.size = curAtomTr.size-1;
								end
							end
							transaction_start_port.write(curAtomTr);
						end
					end
					if (port.AwReady) begin
						if (!wrTr.exists(curWrTr.id)) wrTr[curWrTr.id] = {};
						wrTr[curWrTr.id].push_back(curWrTr);
						if (version!=V3) begin
							writeDataLengthAndIdFifo.push_back('{curWrTr.len,curWrTr.id});
						end
						curWrTr   = null;
						if (curAtomTr != null) begin
							if (!rdTr.exists(curAtomTr.id)) rdTr[curAtomTr.id] = {};
							rdTr[curAtomTr.id].push_back(curAtomTr);
							curAtomTr = null;
						end
					end
				end
				if (port.WValid && port.WReady ) begin
					anvu_axi_monitor_data data;
					data.data     = port.WData;
					data.strb     = port.WStrb;
					data.dataTime = getTimeInPs();
					if (version==V3) begin 
						if (!wrData.exists(port.WId)) wrData[port.WId] = {};
						wrData[port.WId].push_back(data);
					end else begin //queuing all write data in queue of index fake Id = -1
						if (!wrData.exists(-1)) wrData[-1] = {};
						wrData[-1].push_back(data);
					end
				end
				if (port.BValid && port.BReady ) begin
					anvu_axi_monitor_transaction tr ;
					if (wrTr[port.BId].size() == 0) begin
						`uvm_error("anvu_nocAip",$psprintf("On AXI monitor %s, received a WR response without an associated request",socketFlow.str()))
					end else begin
						tr = wrTr[port.BId].pop_front();
						if (version==V3) begin 
							for(int i=0;i<tr.len+1;i++) begin
								anvu_axi_monitor_data data = wrData[port.BId].pop_front();
								tr.data.push_back(data.data);
								tr.strb.push_back(data.strb);
								tr.dataTime.push_back(data.dataTime);
							end
						end else begin //finding the data index in the write data queue (wrData[-1]) to associate the response to the coresponding data (this dataIndex is non-null if there is disorder)
							int len,dataIndex = 0;
							foreach (writeDataLengthAndIdFifo[i]) begin
								if (writeDataLengthAndIdFifo[i][1] == port.BId) begin
									len = writeDataLengthAndIdFifo[i][0];
									writeDataLengthAndIdFifo.delete(i);
									break;
								end
								dataIndex += writeDataLengthAndIdFifo[i][0]+1;
							end
							for(int i=dataIndex;i<dataIndex+len+1;i++) begin
								anvu_axi_monitor_data data = wrData[-1][dataIndex];
								tr.data.push_back(data.data);
								tr.strb.push_back(data.strb);
								tr.dataTime.push_back(data.dataTime);
								wrData[-1].delete(dataIndex);
							end
						end
					end
					tr.resp.push_back(port.BResp);
					tr.respTime.push_back(getTimeInPs());
					tr.endTime     = getTimeInPs();
					
					transaction_end_port.write(tr);
				end
				if (port.RValid && port.RReady ) begin
					anvu_axi_monitor_transaction tr ;
					if (rdTr[port.RId].size() == 0) begin
						`uvm_error("anvu_nocAip",$psprintf("On AXI monitor %s, received a RD response without an associated request",socketFlow.str()))
					end else begin
						tr = rdTr[port.RId][0];
						tr.data.push_back(port.RData);
						tr.resp.push_back(port.RResp);
						tr.dataTime.push_back(getTimeInPs());
						tr.respTime.push_back(getTimeInPs());
						
						if (port.RLast) begin
							tr.endTime = getTimeInPs();
							rdTr[port.RId].delete(0);
							transaction_end_port.write(tr);
						end
					end
				end
			end
		join_none
	endtask
endclass
