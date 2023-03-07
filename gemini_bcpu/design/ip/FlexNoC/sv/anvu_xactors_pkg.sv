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

`timescale 1ps/1ps

`include "anvu_interfaces.sv"
`include "anvu_uvm_macros.sv"
`include "uvm_macros.svh"

//! Package that contains arteris transactors (monitors and drivers) and associated classes
package anvu_xactors_pkg;
	import uvm_pkg::*;
	import anvu_commons_pkg::*;
	import svt_uvm_pkg::*;
	import svt_apb_uvm_pkg::*;
	import svt_axi_uvm_pkg::*;
	import svt_ahb_uvm_pkg::*;

	`include "anvu_axi_monitor.sv"
	// Build the flowIdx from the aid and flowId map
	function automatic int getSlvIdxFromAidAndMap(int aid, int flowIdMap);
		int nBit         = 0;
		int curAid       = aid;
		int curFlowIdMap = flowIdMap;
		int flowIdx = 0;
		while ( curFlowIdMap != 0 ) begin
			if (curFlowIdMap%2) begin
				flowIdx |=  curAid[0]<<nBit;
				nBit += 1;
			end
			curFlowIdMap = curFlowIdMap >> 1;
			curAid       = curAid       >> 1;
		end
		return flowIdx;
	endfunction

	`include "anvu_apb_monitor.sv"
	`include "anvu_ahb_monitor.sv"

	
	//! UVM Component connected to an input RstN signal of the NoC.
	//! Currently does not inherits uvm_driver because it does not use a sequencer
	class anvu_rstn_driver extends uvm_component;
		`uvm_component_utils(anvu_rstn_driver)
		//! Reference to the RstN interface.
		virtual interface anvu_rstn_if port;
		//! Flow corresponding to this xactor. This parameter is used for naming of objects, and logging.
		anvu_flow socketFlow;
		
		//! Assigns the value passed as an argument to RstN.
		//! \note The value will only be visible on the interface outside the xactor
		//!       upon the next active state of all ClkEnable signals associated with the clock of this RstN.
		task setValue(bit value,bit async=0);
			if (async) begin
				port.RstN_async     <= value;
				port.driver_cb.RstN <= 1'hz;
			end else begin
				port.driver_cb.RstN <= value;
				port.RstN_async     <= 1'hz;
			end
		endtask
		//! Returns the current value of the RstN.
		//! \note This function cannot be used within a wait function call. Use function wait(this.port.RstN == 1'b1) instead.
		function bit getValue();
			return port.RstN;
		endfunction
		//! Wait for the RstN signal to be equal to the provided value.
		task waitValue(bit value);
			wait(port.RstN == value);
		endtask
		
		function new(string name = "anvu_rstn_driver" , uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void assign_vif(string configName);
			virtual anvu_rstn_if port;
			`ANVU_GET_CONFIG( virtual anvu_rstn_if , port , configName );
			this.port = port;
		endfunction
	endclass
	
	//! UVM Component connected to possibly drive a ClkRegime clock from the testbench.
	//! At initialization the clock is not started and the
	class anvu_clk_driver extends uvm_component;
		`uvm_component_utils(anvu_clk_driver)
		
		//! Reference to the Clk interface.
		virtual interface anvu_clk_if.driver_port port;
		
		//! Flow corresponding to this xactor. This parameter is used for naming of objects, and logging.
		anvu_flow socketFlow;
		
		//! Defines if the regime clock for the DUT is the one build with this UVM component (1) or if it is the verilog oscillator (0)
		//! Start at 0
		bit drivenFromTestBench = 0;
		
		//! Defines if the clock build by this component is oscillating (1) or if it is stucked to 0 (0)
		bit started = 0;
		
		//! Defines the period of the clock build by this component when it is started.
		real psPeriod;
		
		function new(string name = "anvu_clk_driver" , uvm_component parent);
			super.new(name,parent);
		endfunction
		
		//! Force the regime Clock for the DUT to be the one build by this UVM component
		//! Raise a warning if this is already the case
		function void driveFromTestBench();
			if (drivenFromTestBench) begin
				`uvm_warning("anvu_bench",$psprintf("The clock for regime '%s' is already driven by the testbench component.",socketFlow.str()))
			end else begin
				drivenFromTestBench = 1;
				port.Sel <= 1;
				`uvm_info("anvu_bench",$psprintf("The clock for regime '%s' is now driven by the testbench component.",socketFlow.str()),uvm_pkg::UVM_MEDIUM)
			end
		endfunction
		
		//! Force the clock regime Clock for the DUT to be the one build by the Verilog oscillator
		//! Raise a warning if this is already the case
		function void driveFromVerilog();
			if (!drivenFromTestBench) begin
				`uvm_warning("anvu_bench",$psprintf("The clock for regime '%s' is already driven by the verilog oscillator.",socketFlow.str()))
			end else begin
				drivenFromTestBench = 0;
				port.Sel <= 0;
				`uvm_info("anvu_bench",$psprintf("The clock for regime '%s' is now driven by the verilog oscillator.",socketFlow.str()),uvm_pkg::UVM_MEDIUM)
			end
		endfunction
		
		//! Defines the frequency of the clock build by this component in Mhz
		//! This method can be called while the clock is started, the new frequency will be used starting at the next clock cycle
		function void setFrequency(real frequency);
			psPeriod = (1/frequency)*1e6;
		endfunction
		
		//! Defines the peroiod of the clock build by this component in picoseconds
		//! This method can be called while the clock is started, the new period will be used starting at the next clock cycle
		function void setPeriod(longint newPsPeriod);
			psPeriod = newPsPeriod;
		endfunction
		
		//! Start the clock build by this component.
		//! Beware that the DUT will only receive this clock if driveFromTestBench method has also been called
		function void startClock();
			if (started) begin
				`uvm_warning("anvu_bench",$psprintf("The clock for regime '%s' has already been started.",socketFlow.str()))
			end else begin
				started = 1;
				`uvm_info("anvu_bench",$psprintf("The clock for regime '%s' has been started.",socketFlow.str()),uvm_pkg::UVM_MEDIUM)
				port.Clk <= 1;
			end
		endfunction
		
		//! Stop the clock build by this component.
		//! It will be stucked to 0;
		function void stopClock();
			if (!started) begin
				`uvm_warning("anvu_bench",$psprintf("The clock for regime '%s' has already been stopped.",socketFlow.str()))
			end else begin
				started = 0;
				`uvm_info("anvu_bench",$psprintf("The clock for regime '%s' has been stopped.",socketFlow.str()),uvm_pkg::UVM_MEDIUM)
			end
		endfunction
		
		function void assign_vif(string configName);
			virtual anvu_clk_if port;
			`ANVU_GET_CONFIG( virtual anvu_clk_if , port , configName );
			this.port = port;
		endfunction
		
		task run_phase(uvm_phase phase);
			//Nothing special performed. Main point is currently to use the setValue and getValue methods
			port.Sel <= 0;
			port.Clk <= 0;
			forever begin
				wait(started);
				#((psPeriod/nocTimeUnitInPsFactor)/2);
				port.Clk <= 0;
				#((psPeriod/nocTimeUnitInPsFactor)/2);
				port.Clk <= 1;
			end
		endtask
	endclass
	
	//! UVM Component connected to an input signal of the NoC.
	//! Currently does not inherits uvm_driver because it does not use a sequencer
	class anvu_signal_driver extends uvm_component;
		`uvm_component_utils(anvu_signal_driver)
		//! Reference to the signal driver interface.
		virtual interface anvu_signal_if port;
		//! Flow corresponding to this xactor. This parameter is used for naming of objects, and logging.
		anvu_flow socketFlow;
		//! Configuration variable to configure signal driving mode (async/sync)
		bit isAsync = 0;
		
		//! Assigns the value passed as an argument to the signal.
		//! \note The value will only be visible on the interface outside the xactor
		//!       upon the next active state of all ClkEnable signals associated with the clock of this signal.
		task setValue(bit[63:0] value);
			if (isAsync) begin
				port.Signal_async     <= value;
				port.driver_cb.Signal <= 64'hzzzzzzzzzzzzzzzz;
			end else begin
				port.driver_cb.Signal <= value;
				port.Signal_async     <= 64'hzzzzzzzzzzzzzzzz;
			end
		endtask
		//! Returns the current value of the signal.
		//! \note This function cannot be used within a wait function call. Use function wait(this.port.Signal == 1'b1) instead.
		function bit[63:0] getValue();
			return port.Signal;
		endfunction
		
		function new(string name = "anvu_signal_driver" , uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void assign_vif(string configName);
			virtual anvu_signal_if port;
			`ANVU_GET_CONFIG( virtual anvu_signal_if , port , configName );
			this.port = port;
		endfunction : assign_vif
	endclass
	
	//! UVM Component connected to an output signal of the NoC.
	//! Currently does not inherits uvm_driver because it does not use a sequencer
	class anvu_signal_reader extends uvm_component;
		`uvm_component_utils(anvu_signal_reader)
		//! Reference to the signal reader interface.
		virtual interface anvu_signal_if.reader_port port;
		//! Flow corresponding to this xactor. This parameter is used for naming of objects, and logging.
		anvu_flow socketFlow;
		
		//! Returns the current value of the signal.
		//! \note This function cannot be used within a wait function call. Use function wait(this.port.Signal == 1'b1) instead.
		function bit[63:0] getValue();
			return port.Signal;
		endfunction
		
		function new(string name = "anvu_signal_reader" , uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void assign_vif(string configName);
			virtual anvu_signal_if port;
			`ANVU_GET_CONFIG( virtual anvu_signal_if , port , configName );
			this.port = port;
		endfunction
		
		task run_phase(uvm_phase phase);
			string name = socketFlow.str();
			bit faultDetect = (name.len()>=23 && (name.substr(0,22)=="ResilienceMissionFault_") && (name.len()<=30));
			if (faultDetect)
				fork
					forever begin
						@(port.reader_cb.Signal);
						if ( port.reader_cb.Signal != 1'b0)  begin
							`uvm_error("anvu_bench",$psprintf("%s detected !",name))
						end
					end
				join_none
		endtask
	endclass
	
	//! UVM transaction used to transmit the value of a signal between two uvm components
	class anvu_signal_transaction extends uvm_sequence_item;
		anvu_flow socketFlow;
		bit [63:0] Signal;
		`uvm_object_utils_begin(anvu_signal_transaction)
			`uvm_field_int      (Signal , uvm_pkg::UVM_ALL_ON )
		`uvm_object_utils_end
		function new(string name = "anvu_signal_transaction" );
			super.new();
		endfunction
	endclass
	
	//! UVM Component used to monitor a signal in the nocAip
	class anvu_signal_monitor extends uvm_monitor;
		`uvm_component_utils(anvu_signal_monitor)
		//! Flow corresponding to this xactor. This parameter is used for naming of objects, and logging.
		anvu_flow socketFlow;
		//! UVM analysis port used to send transactions to the abstractor
		uvm_analysis_port #(anvu_signal_transaction) transaction_port ;
		//! Reference to the signal monitor interface
		virtual anvu_signal_if.mon_port port;
		//! UVM transaction sent to the abstractor
		anvu_signal_transaction tr;
		
		function new(string name = "anvu_signal_monitor" , uvm_component parent);
			super.new(name,parent);
			transaction_port = new("transaction_port",this);
		endfunction
		
		function void assign_vif(string configName);
			virtual anvu_signal_if port;
			`ANVU_GET_CONFIG( virtual anvu_signal_if , port , configName );
			this.port = port;
		endfunction : assign_vif
		
		task run_phase(uvm_phase phase);
			fork
				forever begin
					@(port.Signal);
					tr = new();
					tr.Signal = port.Signal;
					tr.socketFlow = socketFlow;
					transaction_port.write(tr);
				end
			join_none
		endtask
	endclass
	
	class anvu_apb_subscriber extends uvm_subscriber #(svt_apb_transaction);
		`uvm_component_utils(anvu_apb_subscriber)
		uvm_event evt;
		function new(string name, uvm_component parent);
			super.new(name,parent);
		endfunction
		function void write(svt_apb_transaction t);
			evt.trigger(t);
		endfunction
	endclass
	class anvu_axi_subscriber extends uvm_subscriber #(svt_axi_transaction);
		`uvm_component_utils(anvu_axi_subscriber)
		uvm_event rdEvt;
		uvm_event wrEvt;
		function new(string name, uvm_component parent);
			super.new(name,parent);
		endfunction
		function void write(svt_axi_transaction t);
			if (
				t.xact_type == svt_axi_transaction::WRITE
			||	(	t.xact_type == svt_axi_transaction::COHERENT
				&&  t.coherent_xact_type inside {svt_axi_transaction::WRITENOSNOOP,svt_axi_transaction::WRITEUNIQUE,svt_axi_transaction::WRITECLEAN,svt_axi_transaction::WRITEBACK,svt_axi_transaction::EVICT,svt_axi_transaction::WRITEBARRIER}
				)
			) 	wrEvt.trigger(t);
			else
				rdEvt.trigger(t);
		endfunction
	endclass
	class anvu_ahb_subscriber extends uvm_subscriber #(svt_ahb_transaction);
		`uvm_component_utils(anvu_ahb_subscriber)
		uvm_event evt;
		function new(string name, uvm_component parent);
			super.new(name,parent);
		endfunction
		function void write(svt_ahb_transaction t);
			evt.trigger(t);
		endfunction
	endclass
endpackage
