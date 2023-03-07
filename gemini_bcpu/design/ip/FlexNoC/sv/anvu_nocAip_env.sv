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

`uvm_analysis_imp_decl(_start_transaction)
`uvm_analysis_imp_decl(_end_transaction)

`include "anvu_nocAip_abstract.sv"


//! UVM environment for the NoC AIP.
//! It instantiates the appropriate Monitor VIP for all of the supported interfaces.
//! It connects monitors to their associated abstractors.
//! It connects the abstractors to the NoC scoreboard.
class anvu_nocAip_env extends uvm_env;
	`uvm_component_utils(anvu_nocAip_env)
	
	//! Path where all the text files loaded in the environment are stored
	string txtFilesDir;
	//! List of the ModePort monitor VIP
	anvu_signal_monitor                  modePortDriverMon [];
	//!  Abstractor for the ModPort monitors 
	anvu_modePort_scoreboard_abstractor  modePortDriverAbstractor;
	
	//! List of the AXI monitor VIP for AXI initiator socket of the NoC
	anvu_axi_monitor                axiInitMon [];
	//! List of the AXI abstractors for AXI initiator monitors
	anvu_axi_scoreboard_abstractor  axiInitAbstractor[];
	
	//! List of the AXI monitor VIP for AXI target socket of the NoC
	anvu_axi_monitor                axiTargMon [];
	//! List of the AXI abstractors for AXI target monitors
	anvu_axi_scoreboard_abstractor  axiTargAbstractor[];
	
	//! List of the APB monitor VIP for APB initiator socket of the NoC
	anvu_apb_monitor                apbInitMon [];
	//! List of the APB abstractors for APB initiator monitors
	anvu_apb_scoreboard_abstractor  apbInitAbstractor[];
	
	//! List of the APB monitor VIP for APB target socket of the NoC
	anvu_apb_monitor                apbTargMon [];
	//! List of the APB abstractors for ABP target monitors
	anvu_apb_scoreboard_abstractor  apbTargAbstractor[];
	
	//! List of the AHB monitor VIP for AHB initiator socket of the NoC
	anvu_ahb_monitor                ahbInitMon [];
	//! List of the AHB abstractors for AHB initiator monitors
	anvu_ahb_scoreboard_abstractor  ahbInitAbstractor[];
	
	//! List of the AHB monitor VIP for AHB target socket of the NoC
	anvu_ahb_monitor                ahbTargMon [];
	//! List of the AHB abstractors for ABP target monitors
	anvu_ahb_scoreboard_abstractor  ahbTargAbstractor[];
	
	
	//! Scoreboard 
	anvu_nocAip_scoreboard scoreboard;
	//! NoC Memory Map
	anvu_memoryMap        memoryMap;
	
	//! Enable coverage on initiator flows
	int covInit=1;	
	//! Enable coverage on target flows
	int covTarg=1;
	//! Allow global coverage (one per flow), or allow several coverage per memory map segment.
	int covInitGlobal=1;	
	//! Allow coverage for connections not reaching any target
	bit covInitToNowhere  = 1;
	//! Allow coverage for connections to internal target
	bit covInitToInternal = 1;
	
	
	function new(string name = "anvu_nocAip_env" , uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase) ;
		super.build_phase(phase);
		
		scoreboard = anvu_nocAip_scoreboard::type_id::create("NoC scoreboard",this);
		scoreboard.loadFromFiles({txtFilesDir,"/MemoryMap.txt"},{txtFilesDir,"/PowerDomains.txt"});
		memoryMap = new();
		if (!memoryMap.load({txtFilesDir,"/MemoryMap.txt"}))
			`uvm_error("anvu_bench",$psprintf("Could not load memoryMap file named %s",{txtFilesDir,"/MemoryMap.txt"}))
		
		anvu_noc_definitions_fillStrArrays();
		
		foreach( nocModePortDriverName[i] ) _D_Flow_declareSocket(nocModePortDriverName[i],1,0,0,0);
		
		modePortDriverMon        = new[nocModePortDriverNb];
		
		if (nocModePortDriverNb > 0) begin
			modePortDriverAbstractor = anvu_modePort_scoreboard_abstractor::type_id::create("modePorts_abstractor",this);
			modePortDriverAbstractor.scoreboard = scoreboard;
		end
		for(int i=0;i<nocModePortDriverNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocModePortDriverName[i]);
			modePortDriverMon[i] = anvu_signal_monitor::type_id::create({nocModePortDriverName[i],"_monitor"},this);
			modePortDriverMon[i].socketFlow = socketFlow;
		end
		foreach( nocAxiInitName[i] ) _D_Flow_declareSocket(nocAxiInitName[i],1,0,1,0);
		foreach( nocAxiTargName[i] ) _D_Flow_declareSocket(nocAxiTargName[i],0,0,1,0);
		
		axiInitMon        = new[nocAxiInitNb];
		axiInitAbstractor = new[nocAxiInitNb];
		
		axiTargMon        = new[nocAxiTargNb];
		axiTargAbstractor = new[nocAxiTargNb];
		
		for(int i=0;i<nocAxiInitNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocAxiInitName[i]);
			anvu_axi_init_info axiInitInfo = nocAxiInitInfoByFlowId[socketFlow.id()];
			axiInitMon[i] = anvu_axi_monitor::type_id::create({nocAxiInitName[i],"_monitor"},this);
			axiInitMon[i].socketFlow = socketFlow;
			axiInitMon[i].version = axiInitInfo.version;
			axiInitAbstractor[i] = anvu_axi_scoreboard_abstractor::type_id::create({nocAxiInitName[i],"_abstractor"},this);
			axiInitAbstractor[i].scoreboard = scoreboard;
		end
		
		for(int i=0;i<nocAxiTargNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocAxiTargName[i]);
			anvu_noc_definitions_pkg::anvu_axi_targ_info axiTargInfo = nocAxiTargInfoByFlowId[socketFlow.id()];
			axiTargMon[i] = anvu_axi_monitor::type_id::create({nocAxiTargName[i],"_monitor"},this);
			axiTargMon[i].socketFlow = socketFlow;
			axiTargMon[i].version = axiTargInfo.version;
			axiTargAbstractor[i] = anvu_axi_scoreboard_abstractor::type_id::create({nocAxiTargName[i],"_abstractor"},this);
			axiTargAbstractor[i].scoreboard = scoreboard;
		end
		
		foreach( nocApbInitName[i] ) _D_Flow_declareSocket(nocApbInitName[i],1,0,1,0);
		foreach( nocApbTargName[i] ) _D_Flow_declareSocket(nocApbTargName[i],0,0,1,0);
		
		apbInitMon        = new[nocApbInitNb];
		apbInitAbstractor = new[nocApbInitNb];
		
		apbTargMon        = new[nocApbTargNb];
		apbTargAbstractor = new[nocApbTargNb];
		
		for(int i=0;i<nocApbInitNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocApbInitName[i]);
			apbInitMon[i] = anvu_apb_monitor::type_id::create({nocApbInitName[i],"_monitor"},this);
			apbInitMon[i].socketFlow = socketFlow;
			apbInitAbstractor[i] = anvu_apb_scoreboard_abstractor::type_id::create({nocApbInitName[i],"_abstractor"},this);
			apbInitAbstractor[i].scoreboard = scoreboard;
		end
		
		for(int i=0;i<nocApbTargNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocApbTargName[i]);
			apbTargMon[i] = anvu_apb_monitor::type_id::create({nocApbTargName[i],"_monitor"},this);
			apbTargMon[i].socketFlow = socketFlow;
			apbTargAbstractor[i] = anvu_apb_scoreboard_abstractor::type_id::create({nocApbTargName[i],"_abstractor"},this);
			apbTargAbstractor[i].scoreboard = scoreboard;
		end
		
		foreach( nocAhbInitName[i] ) _D_Flow_declareSocket(nocAhbInitName[i],1,0,1,0);
		foreach( nocAhbTargName[i] ) _D_Flow_declareSocket(nocAhbTargName[i],0,0,1,0);
		
		ahbInitMon        = new[nocAhbInitNb];
		ahbInitAbstractor = new[nocAhbInitNb];
		
		ahbTargMon        = new[nocAhbTargNb];
		ahbTargAbstractor = new[nocAhbTargNb];
		
		for(int i=0;i<nocAhbInitNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocAhbInitName[i]);
			ahbInitMon[i] = anvu_ahb_monitor::type_id::create({nocAhbInitName[i],"_monitor"},this);
			ahbInitMon[i].socketFlow = socketFlow;
			ahbInitAbstractor[i] = anvu_ahb_scoreboard_abstractor::type_id::create({nocAhbInitName[i],"_abstractor"},this);
			ahbInitAbstractor[i].scoreboard = scoreboard;
		end
		
		for(int i=0;i<nocAhbTargNb;i++) begin
			anvu_flow socketFlow = Flow_fromName(nocAhbTargName[i]);
			ahbTargMon[i] = anvu_ahb_monitor::type_id::create({nocAhbTargName[i],"_monitor"},this);
			ahbTargMon[i].socketFlow = socketFlow;
			ahbTargAbstractor[i] = anvu_ahb_scoreboard_abstractor::type_id::create({nocAhbTargName[i],"_abstractor"},this);
			ahbTargAbstractor[i].scoreboard = scoreboard;
		end
		
		
		anvu_noc_definitions_init();
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		for(int i=0;i<nocModePortDriverNb;i++) begin
			modePortDriverMon[i].transaction_port.connect(modePortDriverAbstractor.transaction_port);
		end
		
		if (!nocScoreboardDisabled) begin
			for(int i=0;i<nocAxiInitNb;i++) begin
				axiInitMon[i].transaction_start_port.connect(axiInitAbstractor[i].transaction_start_port);
				axiInitMon[i].transaction_end_port  .connect(axiInitAbstractor[i].transaction_end_port);
			end
			for(int i=0;i<nocAxiTargNb;i++) begin
				axiTargMon[i].transaction_start_port.connect(axiTargAbstractor[i].transaction_start_port);
				axiTargMon[i].transaction_end_port  .connect(axiTargAbstractor[i].transaction_end_port);
			end
			for(int i=0;i<nocApbInitNb;i++) begin
				apbInitMon[i].transaction_start_port.connect(apbInitAbstractor[i].transaction_start_port);
				apbInitMon[i].transaction_end_port  .connect(apbInitAbstractor[i].transaction_end_port);
			end
			for(int i=0;i<nocApbTargNb;i++) begin
				apbTargMon[i].transaction_start_port.connect(apbTargAbstractor[i].transaction_start_port);
				apbTargMon[i].transaction_end_port  .connect(apbTargAbstractor[i].transaction_end_port);
			end
			for(int i=0;i<nocAhbInitNb;i++) begin
				ahbInitMon[i].transaction_start_port.connect(ahbInitAbstractor[i].transaction_start_port);
				ahbInitMon[i].transaction_end_port  .connect(ahbInitAbstractor[i].transaction_end_port);
			end
			for(int i=0;i<nocAhbTargNb;i++) begin
				ahbTargMon[i].transaction_start_port.connect(ahbTargAbstractor[i].transaction_start_port);
				ahbTargMon[i].transaction_end_port  .connect(ahbTargAbstractor[i].transaction_end_port);
			end
		end
	endfunction
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
	
	endfunction

endclass
