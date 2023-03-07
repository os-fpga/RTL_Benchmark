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
`include "anvu_apb_defines.sv"
`include "anvu_defines.sv"

typedef enum { ANVU_APB_READ , ANVU_APB_WRITE } eAnvApbOpc;

class anvu_apb_monitor_transaction extends uvm_sequence_item;
	anvu_flow                            socketFlow ;

	rand eAnvApbOpc                      opc;
	rand bit [`ANVU_APB_MAX_WADDR  -1:0] addr;
	rand bit [`ANVU_APB_MAX_WDATA  -1:0] data;
	rand bit [`ANVU_APB_MAX_WSTRB  -1:0] strb;
	rand bit [`ANVU_APB_MAX_WPROT  -1:0] prot;
	rand bit                             err;
	rand bit [`ANVU_APB_MAX_WUSER  -1:0] user;

	longint                              startTime;
	longint                              endTime;

	`uvm_object_utils_begin(anvu_apb_monitor_transaction)
		`uvm_field_enum     (eAnvApbOpc,opc , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (addr           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (data           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (strb           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (prot           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (err            , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (user           , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (startTime      , uvm_pkg::UVM_ALL_ON )
		`uvm_field_int      (endTime        , uvm_pkg::UVM_ALL_ON )
	`uvm_object_utils_end

	function void do_print (uvm_printer printer);
		printer.print_string("socketFlow", socketFlow.str());
		super.do_print(printer);
	endfunction

	function new(string name = "anvu_apb_monitor_transaction");
		super.new(name);
	endfunction

endclass


class anvu_apb_monitor extends uvm_monitor;

   uvm_analysis_port #(anvu_apb_monitor_transaction) transaction_start_port;
   uvm_analysis_port #(anvu_apb_monitor_transaction) transaction_end_port;

	anvu_flow socketFlow;

	`uvm_component_utils(anvu_apb_monitor)

	virtual anvu_apb_if port;


	anvu_apb_monitor_transaction curTr;

	function new(string name, uvm_component parent);
		super.new(name,parent);
		transaction_start_port = new("transaction_start_port",this);
		transaction_end_port   = new("transaction_end_port"  ,this);
	endfunction

	function void assign_vif(string configName);
		virtual anvu_apb_if port;
		`ANVU_GET_CONFIG( virtual anvu_apb_if , port , configName );
		this.port = port;
	endfunction

	task run_phase(uvm_phase phase);
		fork
			forever begin
				@(posedge port.Clk);
				if (!port.RstN) begin
					curTr = null;
				end
				if (~port.PEnable && port.PSel) begin
					if (curTr == null ) begin
						curTr = new();
						curTr.socketFlow = socketFlow    ;
						if (port.PWrite) begin
							curTr.opc    = ANVU_APB_WRITE;
						end else begin	
							curTr.opc    = ANVU_APB_READ ;
						end 
						curTr.addr       = port.PAddr    ;
						curTr.startTime  = getTimeInPs() ;
						transaction_start_port.write(curTr);
					end
				end
				if (port.PEnable && port.PSel && port.PReady) begin
					curTr.endTime        = getTimeInPs();
					curTr.err            = port.PSlvErr ;
					curTr.user           = port.ReqUser ;
					curTr.strb           = port.PStrb   ;
					curTr.prot           = port.PProt   ;
					if (port.PWrite) begin
						curTr.data       = port.PWData  ;
					end else begin
						curTr.data       = port.PRData  ;
					end
					transaction_end_port.write(curTr);
					curTr = null;
				end
			end
		join_none
	endtask
endclass


