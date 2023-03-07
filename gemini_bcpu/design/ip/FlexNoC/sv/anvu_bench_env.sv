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

typedef class anvu_bench_env;

`include "anvu_axi_sequence.sv"
`include "anvu_axi_thorough_sequence.sv"
`include "anvu_apb_sequence.sv"
`include "anvu_apb_thorough_sequence.sv"
`include "anvu_ahb_sequence.sv"
`include "anvu_ahb_thorough_sequence.sv"

class anvu_bench_env extends uvm_env;
	`uvm_component_utils(anvu_bench_env)
	
	//! For each initiator sockets, associate the number of ended transactions
	int nbTransactionDoneBySocket[string];
	//! For each initiator sockets, associate a modifier to apply to the number of transaction sent
	//! to the VIP to be able to match nbTransactionDone
	int nbTransactionSentBySocket[string];
	//! Each time a transaction is ended, this event is trigged.
	event updateTransactionDone;
	
	//! Path where all the text files loaded in the environment are stored
	string txtFilesDir;
	
	//! NoC Memory Map
	anvu_memoryMap        memoryMap;
	
	//! Power state of the NoC.
	//! It can be used by any scenario to know a given initiator is powered and can generates transactions.
	anvu_pwrState_handler         pwrStateHandler;
	
	//! List of the ClkRegime driver components for the NoC
	anvu_clk_driver    clkRegimeDriverVip [];
	
	//! List of the RstN driver components for the NoC
	anvu_rstn_driver    rstnDriverVip [];
	
	//! List of Signal driver components for the NoC.
	anvu_signal_driver  signalDriverVip[];
	
	//! List of Signal reader components for the NoC.
	anvu_signal_reader  signalReaderVip[];
	
	//! List of ModePort driver components for the NoC.
	anvu_signal_driver  modePortDriverVip[];
	
	
	//! List of the APB Master Active VIP for the NoC
	svt_apb_master_agent            apbInitVip [];
	//! List of the APB subscriber connected to the VIP monitor
	anvu_apb_subscriber             apbSubscriber[];
	//! List of the events triggered by the APB subscribers
	uvm_event                       apbSubscriberEvent[];
	//! List of the APB Slave Active VIP for the NoC
	svt_apb_slave_agent             apbTargVip [];
	
	//! List of the AXI Master Active VIP for the NoC
	svt_axi_master_agent            axiInitVip [];
	//! List of the AXI subscriber connected to the VIP monitor
	anvu_axi_subscriber             axiSubscriber[];
	//! List of the events triggered by the AXI subscribers (Read transaction received)
	uvm_event                       axiSubscriberRdEvent[];
	//! List of the events triggered by the AXI subscribers (Write transaction received)
	uvm_event                       axiSubscriberWrEvent[];
	//! List of the AXI Slave Active VIP for the NoC
	svt_axi_slave_agent             axiTargVip [];
	
	//! List of the AHB Master Active VIP for the NoC
	svt_ahb_master_agent            ahbInitVip [];
	//! List of the AHB subscriber connected to the VIP monitor
	anvu_ahb_subscriber             ahbSubscriber[];
	//! List of the events triggered by the AHB subscribers
	uvm_event                       ahbSubscriberEvent[];
	//! List of the AHB Slave Active VIP for the NoC
	svt_ahb_slave_agent             ahbTargVip [];
	
	
	function new(string name = "anvu_bench_env" , uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase) ;
	
	
		super.build_phase(phase);
		
		anvu_noc_definitions_fillStrArrays();
		
		memoryMap = new();
		if (!memoryMap.load({txtFilesDir,"/MemoryMap.txt"}))
			`uvm_error("anvu_bench",$psprintf("Could not load memoryMap file named %s",{txtFilesDir,"/MemoryMap.txt"}))
		pwrStateHandler = new();
		pwrStateHandler.loadRouteFromFile({txtFilesDir,"/PowerDomains.txt"});
		
		clkRegimeDriverVip = new[nocClkRegimeDriverNb];
		
		foreach( nocClkRegimeDriverName[i] ) _D_Flow_declareSocket(nocClkRegimeDriverName[i],1,0,0,0);
		
		foreach( clkRegimeDriverVip[i] ) begin
			anvu_flow socketFlow = Flow_fromName(nocClkRegimeDriverName[i]);
			clkRegimeDriverVip[i] = anvu_clk_driver::type_id::create(nocClkRegimeDriverName[i],this);
			clkRegimeDriverVip[i].socketFlow = socketFlow;
			clkRegimeDriverVip[i].setPeriod(nocClkRegimePsPeriod[i]);
		end
		
		rstnDriverVip       = new[nocRstnDriverNb];
		
		foreach( nocRstnDriverName[i] ) _D_Flow_declareSocket(nocRstnDriverName[i],1,0,0,0);
		
		foreach( rstnDriverVip[i] ) begin
			anvu_flow socketFlow = Flow_fromName(nocRstnDriverName[i]);
			rstnDriverVip[i] = anvu_rstn_driver::type_id::create(nocRstnDriverName[i],this);
			rstnDriverVip[i].socketFlow  = socketFlow;
		end
		
		signalDriverVip     = new[nocSignalDriverNb];
		
		foreach( nocSignalDriverName[i] ) _D_Flow_declareSocket(nocSignalDriverName[i],1,0,0,0);
		
		foreach( signalDriverVip[i] ) begin
			anvu_flow socketFlow = Flow_fromName(nocSignalDriverName[i]);
			signalDriverVip[i] = anvu_signal_driver::type_id::create(nocSignalDriverName[i],this);
			signalDriverVip[i].socketFlow  = socketFlow;
		end
		
		signalReaderVip     = new[nocSignalReaderNb];
		
		foreach( nocSignalReaderName[i] ) _D_Flow_declareSocket(nocSignalReaderName[i],0,0,0,0);
		
		foreach( signalReaderVip[i] ) begin
			anvu_flow socketFlow = Flow_fromName(nocSignalReaderName[i]);
			signalReaderVip[i] = anvu_signal_reader::type_id::create(nocSignalReaderName[i],this);
			signalReaderVip[i].socketFlow  = socketFlow;
		end
		
		modePortDriverVip     = new[nocModePortDriverNb];
		
		foreach( nocModePortDriverName[i] ) _D_Flow_declareSocket(nocModePortDriverName[i],1,0,0,0);
		
		foreach( modePortDriverVip[i] ) begin
			anvu_flow socketFlow = Flow_fromName(nocModePortDriverName[i]);
			modePortDriverVip[i] = anvu_signal_driver::type_id::create(nocModePortDriverName[i],this);
			modePortDriverVip[i].socketFlow  = socketFlow;
		end
		
		apbInitVip         = new[nocApbInitNb];
		apbSubscriber      = new[nocApbInitNb];
		apbSubscriberEvent = new[nocApbInitNb];
		apbTargVip         = new[nocApbTargNb];
		
		foreach( nocApbInitName[i] ) _D_Flow_declareSocket(nocApbInitName[i],1,0,1,0);
		foreach( nocApbTargName[i] ) _D_Flow_declareSocket(nocApbTargName[i],0,0,1,0);
		
		foreach( apbInitVip[i] ) begin
			svt_apb_system_configuration cfg = svt_apb_system_configuration::type_id::create({nocApbInitName[i],"_cfg"},this);
			cfg.paddr_width = svt_apb_system_configuration::PADDR_WIDTH_64; //max value here because arteris set of possible values (1,2,3..32) is larger than SNPS set of possible config values (8,16,32)
			cfg.pdata_width = (nocApbInitInfo[i].wData!=32)?((nocApbInitInfo[i].wData==8)?svt_apb_system_configuration::PDATA_WIDTH_8:svt_apb_system_configuration::PDATA_WIDTH_16):svt_apb_system_configuration::PDATA_WIDTH_32;
			cfg.num_slaves=1;
			cfg.apb3_enable = 1;
			cfg.apb4_enable = (nocApbInitInfo[i].version==4);
			cfg.slave_addr_ranges[0].start_addr=0;
			cfg.slave_addr_ranges[0].end_addr='hfffffffffffff;
			apbInitVip[i] = svt_apb_master_agent::type_id::create(nocApbInitName[i],this);
			uvm_config_db#(svt_apb_system_configuration)::set(this, nocApbInitName[i], "cfg", cfg);
			uvm_config_db#(uvm_active_passive_enum)::set(this, nocApbInitName[i], "is_active", UVM_ACTIVE);
			
			apbSubscriberEvent[i] = new();
			apbSubscriber[i]=anvu_apb_subscriber::type_id::create({nocApbInitName[i],"_subscriber"},this);
			apbSubscriber[i].evt=apbSubscriberEvent[i];
		end
		foreach( apbTargVip[i] ) begin
			svt_apb_system_configuration cfg = svt_apb_system_configuration::type_id::create({nocApbTargName[i],"_cfg"},this);
			cfg.paddr_width = svt_apb_system_configuration::PADDR_WIDTH_64; //max value here because arteris set of possible values (1,2,3..32) is larger than SNPS set of possible config values (8,16,32)
			cfg.pdata_width = (nocApbTargInfo[i].wData!=32)?((nocApbTargInfo[i].wData==8)?svt_apb_system_configuration::PDATA_WIDTH_8:svt_apb_system_configuration::PDATA_WIDTH_16):svt_apb_system_configuration::PDATA_WIDTH_32;
			cfg.num_slaves=1;
			cfg.apb3_enable = (nocApbTargInfo[i].version inside {3,4});
			cfg.apb4_enable = (nocApbTargInfo[i].version==4);
			cfg.create_sub_cfgs(1);
			cfg.slave_cfg[0].mem_enable=1;
			apbTargVip[i] = svt_apb_slave_agent::type_id::create(nocApbTargName[i],this);
			uvm_config_db#(svt_apb_slave_configuration)::set(this, nocApbTargName[i], "cfg", cfg.slave_cfg[0]);
			uvm_config_db#(uvm_active_passive_enum)::set(this, nocApbTargName[i], "is_active", UVM_ACTIVE);
		end
		
		ahbInitVip         = new[nocAhbInitNb];
		ahbSubscriber      = new[nocAhbInitNb];
		ahbSubscriberEvent = new[nocAhbInitNb];
		ahbTargVip         = new[nocAhbTargNb];
		
		foreach( nocAhbInitName[i] ) _D_Flow_declareSocket(nocAhbInitName[i],1,0,1,0);
		foreach( nocAhbTargName[i] ) _D_Flow_declareSocket(nocAhbTargName[i],0,0,1,0);
		
		foreach( ahbInitVip[i] ) begin
			svt_ahb_system_configuration cfg = new();
			cfg.num_masters   = 1;
			cfg.num_slaves    = 0;
			cfg.ahb_lite      = 1;
			cfg.ahb5          = (nocAhbInitInfo[i].version==5);
			cfg.little_endian = (nocAhbInitInfo[i].littleEndian==0);
			cfg.error_response_policy = svt_ahb_system_configuration::ABORT_ON_ERROR;
			cfg.create_sub_cfgs(1,0);
			cfg.master_cfg[0].secure_enable          =  nocAhbTargInfo[i].wNonSec==0;
			cfg.master_cfg[0].addr_width             =  nocAhbInitInfo[i].wAddr;
			cfg.master_cfg[0].invariant_mode         = (nocAhbInitInfo[i].littleEndian==3) ? svt_ahb_configuration::NO_INVARIANT  :
			                                           (nocAhbInitInfo[i].littleEndian==1) ? svt_ahb_configuration::BYTE_INVARIANT:
			                                                                                 svt_ahb_configuration::WORD_INVARIANT;
			cfg.master_cfg[0].data_width             =  nocAhbInitInfo[i].wData;
			cfg.master_cfg[0].busy_ignore_waits      =  nocAhbInitInfo[i].busyIgnoreWaits;
			cfg.master_cfg[0].protocol_checks_enable = 1;
			cfg.master_cfg[0].control_huser_enable   = (nocAhbInitInfo[i].wUser!=0);
			cfg.master_cfg[0].control_huser_width    =  nocAhbInitInfo[i].wUser;
			ahbInitVip[i] = svt_ahb_master_agent::type_id::create(nocAhbInitName[i],this);
			uvm_config_db#(svt_ahb_master_configuration)::set(this,  nocAhbInitName[i]      , "cfg"      , cfg.master_cfg[0]);
			uvm_config_db#(uvm_active_passive_enum     )::set(this, {nocAhbInitName[i],".*"}, "is_active", UVM_ACTIVE       );
			
			ahbSubscriberEvent[i] = new();
			ahbSubscriber[i] = anvu_ahb_subscriber::type_id::create({nocAhbInitName[i],"_subscriber"},this);
			ahbSubscriber[i].evt = ahbSubscriberEvent[i];
		end
		foreach( ahbTargVip[i] ) begin
			svt_ahb_system_configuration cfg = new();
			cfg.num_masters           = 0;
			cfg.num_slaves            = 1;
			cfg.ahb_lite              = 1;
			cfg.ahb5                  = (nocAhbTargInfo[i].version     ==5);
			cfg.little_endian         = (nocAhbTargInfo[i].littleEndian==0);
			cfg.error_response_policy = svt_ahb_system_configuration::CONTINUE_ON_ERROR;
			cfg.set_addr_range(0, 0, (64'h1<<nocAhbTargInfo[i].wAddr)-1);
			cfg.create_sub_cfgs(0,1);
			cfg.slave_cfg[0].secure_enable          =  nocAhbTargInfo[i].wNonSec==0;
			cfg.slave_cfg[0].addr_width             =  nocAhbTargInfo[i].wAddr;
			cfg.slave_cfg[0].invariant_mode         = (nocAhbTargInfo[i].littleEndian==3) ? svt_ahb_configuration::NO_INVARIANT  :
			                                          (nocAhbTargInfo[i].littleEndian==1) ? svt_ahb_configuration::BYTE_INVARIANT:
			                                                                                svt_ahb_configuration::WORD_INVARIANT;
			cfg.slave_cfg[0].data_width             =  nocAhbTargInfo[i].wData;
			cfg.slave_cfg[0].protocol_checks_enable = 1;
			ahbTargVip[i] = svt_ahb_slave_agent::type_id::create(nocAhbTargName[i],this);
			uvm_config_db#(svt_ahb_slave_configuration)::set(this,  nocAhbTargName[i]      , "cfg"      , cfg.slave_cfg[0]);
			uvm_config_db#(uvm_active_passive_enum    )::set(this, {nocAhbTargName[i],".*"}, "is_active", UVM_ACTIVE      );
		end
		
		axiInitVip           = new[nocAxiInitNb];
		axiSubscriber        = new[nocAxiInitNb];
		axiSubscriberRdEvent = new[nocAxiInitNb];
		axiSubscriberWrEvent = new[nocAxiInitNb];
		axiTargVip           = new[nocAxiTargNb];
		
		foreach( nocAxiInitName[i] ) _D_Flow_declareSocket(nocAxiInitName[i],1,0,1,0);
		foreach( nocAxiTargName[i] ) _D_Flow_declareSocket(nocAxiTargName[i],0,0,1,0);
		foreach( axiInitVip[i] ) begin
			svt_axi_system_configuration cfg = svt_axi_system_configuration::type_id::create({nocAxiInitName[i],"_sysCfg"},this);
			axiInitVip[i] = svt_axi_master_agent::type_id::create(nocAxiInitName[i],this);
			cfg.create_sub_cfgs(1,0);
			cfg.common_clock_mode=0;
			cfg.bus_inactivity_timeout   = 0;
			cfg.rdata_watchdog_timeout   = 0;
			cfg.arready_watchdog_timeout = 0; //in number of clk cycle
			cfg.awready_watchdog_timeout = 0;
			cfg.bready_watchdog_timeout  = 0;
			cfg.excl_wr_watchdog_timeout = 0;
			cfg.rready_watchdog_timeout  = 0;
			cfg.wready_watchdog_timeout  = 0;
			cfg.bresp_watchdog_timeout   = 0;
			cfg.master_cfg[0].addr_user_width = nocAxiInitInfo[i].wUser;
			cfg.master_cfg[0].awuser_enable   = (nocAxiInitInfo[i].wUser!=0);
			cfg.master_cfg[0].aruser_enable   = (nocAxiInitInfo[i].wUser!=0);
			cfg.master_cfg[0].addr_width = nocAxiInitInfo[i].wAddr;
			cfg.master_cfg[0].data_width = nocAxiInitInfo[i].wData;
			cfg.master_cfg[0].exclusive_access_enable = 1; //don't want to restrict VIP here, but rather in transactions constraints
			case (nocAxiInitInfo[i].version)
				anvu_xactors_pkg::V3           : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI3;
				anvu_xactors_pkg::V4           : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4;
				anvu_xactors_pkg::ACE_LITE     : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::ACE_LITE;
				anvu_xactors_pkg::ACE_LITE_DVM : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI_ACE;
				anvu_xactors_pkg::ACE          : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI_ACE;
				anvu_xactors_pkg::AXI_LITE     : cfg.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_LITE;
			endcase
			cfg.master_cfg[0].id_width = nocAxiInitInfo[i].wAid;
			cfg.master_cfg[0].read_chan_id_width = nocAxiInitInfo[i].wAid;
			cfg.master_cfg[0].write_chan_id_width = nocAxiInitInfo[i].wAid;
			cfg.master_cfg[0].is_active = 1;
			cfg.master_cfg[0].num_outstanding_xact = 200;
			cfg.master_cfg[0].num_write_outstanding_xact = 100;
			cfg.master_cfg[0].num_read_outstanding_xact = 100;
			cfg.master_cfg[0].read_data_interleave_size = 1;
			cfg.master_cfg[0].read_data_reordering_depth = 50;
			cfg.master_cfg[0].awregion_enable = (nocAxiInitInfo[i].version!=anvu_xactors_pkg::V3); //region/qos are not activated by default
			cfg.master_cfg[0].arregion_enable = (nocAxiInitInfo[i].version!=anvu_xactors_pkg::V3);
			cfg.master_cfg[0].arqos_enable    = (nocAxiInitInfo[i].version!=anvu_xactors_pkg::V3);
			cfg.master_cfg[0].awqos_enable    = (nocAxiInitInfo[i].version!=anvu_xactors_pkg::V3);
			if (nocAxiInitInfo[i].version inside {anvu_xactors_pkg::ACE}) begin
				cfg.master_cfg[0].cache_line_size  = nocAxiInitInfo[i].cacheLineSize;
			end
			if (nocAxiInitInfo[i].version inside {anvu_xactors_pkg::ACE_LITE_DVM,anvu_xactors_pkg::ACE}) begin
				cfg.master_cfg[0].snoop_data_width = nocAxiInitInfo[i].wData;
			end
			uvm_config_db#(svt_axi_port_configuration)::set(this, nocAxiInitName[i], "cfg", cfg.master_cfg[0]);
			uvm_config_db#(uvm_active_passive_enum)::set(this, nocAxiInitName[i], "is_active", UVM_ACTIVE);
			
			axiSubscriberRdEvent[i] = new();
			axiSubscriberWrEvent[i] = new();
			axiSubscriber[i]=anvu_axi_subscriber::type_id::create({nocAxiInitName[i],"_subscriber"},this);
			axiSubscriber[i].rdEvt=axiSubscriberRdEvent[i];
			axiSubscriber[i].wrEvt=axiSubscriberWrEvent[i];
		end
		foreach( axiTargVip[i] ) begin
			svt_axi_system_configuration cfg = svt_axi_system_configuration::type_id::create({nocAxiTargName[i],"_sysCfg"},this);
			axiTargVip[i] = svt_axi_slave_agent::type_id::create(nocAxiTargName[i],this);
			cfg.create_sub_cfgs(0,1);
			cfg.common_clock_mode=0;
			cfg.bus_inactivity_timeout   = 0;
			cfg.arready_watchdog_timeout = 10000; //in number of clk cycle
			cfg.awready_watchdog_timeout = 10000;
			cfg.bready_watchdog_timeout  = 10000;
			cfg.excl_wr_watchdog_timeout = 10000;
			cfg.rready_watchdog_timeout  = 10000;
			cfg.wready_watchdog_timeout  = 10000;
			cfg.slave_cfg[0].addr_width = nocAxiTargInfo[i].wAddr;
			cfg.slave_cfg[0].data_width = nocAxiTargInfo[i].wData;
			cfg.slave_cfg[0].exclusive_access_enable = 1; //don't want to restrict VIP here, but rather in transactions constraints
			case (nocAxiTargInfo[i].version)
				V3           : cfg.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI3;
				V4           : cfg.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4;
				ACE_LITE     : cfg.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::ACE_LITE;
				ACE_LITE_DVM : cfg.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::ACE_LITE; //drive DVM using snoop channel not supported with this VIP at the moment.
				AXI_LITE     : cfg.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_LITE;
			endcase
			cfg.slave_cfg[0].id_width = nocAxiTargInfo[i].wAid;
			cfg.slave_cfg[0].read_chan_id_width = nocAxiTargInfo[i].wAid;
			cfg.slave_cfg[0].write_chan_id_width = nocAxiTargInfo[i].wAid;
			cfg.slave_cfg[0].is_active = 1;
			cfg.slave_cfg[0].num_outstanding_xact = 200;
			cfg.slave_cfg[0].num_write_outstanding_xact = 100;
			cfg.slave_cfg[0].num_read_outstanding_xact = 100;
			cfg.slave_cfg[0].read_data_interleave_size = (nocAxiTargInfo[i].inOrder==1)?0:1;
			cfg.slave_cfg[0].read_data_reordering_depth = 50;
			cfg.slave_cfg[0].awregion_enable = (nocAxiTargInfo[i].version!=anvu_xactors_pkg::V3); //region/qos are not activated by default
			cfg.slave_cfg[0].arregion_enable = (nocAxiTargInfo[i].version!=anvu_xactors_pkg::V3);
			cfg.slave_cfg[0].arqos_enable    = (nocAxiTargInfo[i].version!=anvu_xactors_pkg::V3);
			cfg.slave_cfg[0].awqos_enable    = (nocAxiTargInfo[i].version!=anvu_xactors_pkg::V3);
			uvm_config_db#(svt_axi_port_configuration)::set(this, nocAxiTargName[i], "cfg", cfg.slave_cfg[0]);
			uvm_config_db#(uvm_active_passive_enum)::set(this, nocAxiTargName[i], "is_active", UVM_ACTIVE);
		end
		
		anvu_noc_definitions_init();
		
	endfunction
		
	function void end_of_elaboration();
		super.end_of_elaboration();
		
		// Disabling some Synopsys AXI checks.
		foreach( axiInitVip[i] ) begin
			axiInitVip[i].monitor.checks.disable_check(axiInitVip[i].monitor.checks.awvalid_awcache_active_check);
			axiInitVip[i].monitor.checks.disable_check(axiInitVip[i].monitor.checks.arvalid_arcache_active_check);
		end
		foreach( axiTargVip[i] ) begin
			axiTargVip[i].monitor.checks.disable_check(axiTargVip[i].monitor.checks.awvalid_awcache_active_check);
			axiTargVip[i].monitor.checks.disable_check(axiTargVip[i].monitor.checks.arvalid_arcache_active_check);
		end
		// Disabling some Synopsys AHB checks.
		foreach( ahbInitVip[i] ) begin
			ahbInitVip[i].monitor.checks.disable_check(ahbInitVip[i].monitor.checks.zero_wait_cycle_okay);
		end
		foreach( ahbTargVip[i] ) begin
			ahbTargVip[i].monitor.checks.disable_check(ahbTargVip[i].monitor.checks.burst_terminated_early_after_okay);
		end
	
	endfunction
	
	
	//! Modify the ModePort values to reflect the ones provided as argument.
	//! ModePort values in the array must be in the order of the nocModePortDriverName array.
	task setModePorts(int modePortValues[]);
		int mode;
		if (nocModeFlagNb == 0) return;
		mode = getModeFromModePortValues(modePortValues);
		for(int i=0;i<nocModePortDriverNb;i++) begin
			modePortDriverVip[i].setValue(modePortValues[i]);
		end
		memoryMap.setMode(mode);
		#(10*nocSlowestClkPeriod); // Wait for the modePort modification to properly inside the NoC
	endtask
	
	//! Modify the ModePort values so that the noc reach the provided mode.
	task setMode(int mode);
		int values[] = new[nocModePortDriverNb];
		if (nocModeFlagNb == 0) return;
		#(50*nocSlowestClkPeriod);
		computeModePortValuesForMode(mode,values);
		setModePorts(values);
	endtask
	
	//! Performs a complete Reset of the NoC.
	//! The following actions are performed :
	//!  - Activate all input RstN signals.
	//!  - Set all Driven signal to their reset value.
	//!  - Set all ModePort signal to 0.
	//!  - Wait 20 cycles of the slowest clock of the NoC.
	//!  - Desactivate all input RstN signals.
	//!  - Wait for all RstN signals to be effectively deactivated ( resynchronization requirements can delay effective deactivation).
	//!  - Wait for all Power interfaces to be ON.
	task performNocReset(bit withRetRstN=0);
		fork
			begin
				// Create a timeOut for the reset sequence
				#(200*nocSlowestClkPeriod);
				`uvm_error("anvu_test","TimeOut on the NoC reset sequence. One of the power interface is probably still not on.")
			end
			begin
				`uvm_info("anvu_test","Start of the NoC reset sequence.",uvm_pkg::UVM_HIGH)
				foreach ( rstnDriverVip[i] )
					rstnDriverVip[i].setValue(0);
				foreach ( signalDriverVip[i])
					if (withRetRstN || !nocSignalDriverOnRetRstn[i])
						signalDriverVip[i].setValue(nocSignalDriverResetValue[i]);
				setMode(nocDfltMode);
				#(30*nocSlowestClkPeriod);
				foreach ( rstnDriverVip[i] )
					rstnDriverVip[i].setValue(1);
				foreach ( rstnDriverVip[i] )
					wait( rstnDriverVip[i].port.RstN == 1'b1);
				#(10*nocSlowestClkPeriod);
				`uvm_info("anvu_test","End of the NoC reset sequence.",uvm_pkg::UVM_HIGH)
			end
		join_any
		disable fork;
	endtask
	
	//! Return True if the power domain associated with the given initiator flow is currently active.
	//! This allows to avoid queuing any transaction on an initiator currently not powered, thus potentially hanging the simulation.
	function bit isPowerActiveForFlow(anvu_flow flow);
		int pwrFlowId;
		if (!nocPwrFlowIdBySocketFlowId.exists(flow.id())) return 1;
		// This power domain is not associated to any signal interface, this is an ALWAYS ON domain
		return 1;
	endfunction
	
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		foreach( apbInitVip[i] ) begin
			apbInitVip[i].monitor.item_observed_port.connect(apbSubscriber[i].analysis_export);
		end
		foreach( apbTargVip[i] ) begin
			//Read rata returned by memory model if no previously written = addr+offset
			apbTargVip[i].apb_slave_mem.meminit=svt_mem::ADDRESS;
			apbTargVip[i].apb_slave_mem.meminit_address_offset = 'h43a156d8;
		end
		foreach( ahbInitVip[i] ) begin
			ahbInitVip[i].monitor.item_observed_port.connect(ahbSubscriber[i].analysis_export);
		end
		foreach( ahbTargVip[i] ) begin
			//Read rata returned by memory model if no previously written = addr+offset
			ahbTargVip[i].ahb_slave_mem.meminit=svt_mem::ADDRESS;
			ahbTargVip[i].ahb_slave_mem.meminit_address_offset = 'h43a156d8;
		end
		foreach( axiInitVip[i] ) begin
			axiInitVip[i].monitor.item_observed_port.connect(axiSubscriber[i].analysis_export);
		end
		foreach( axiTargVip[i] ) begin
			//Read rata returned by memory model if no previously written = addr+offset
			axiTargVip[i].axi_slave_mem.meminit=svt_mem::ADDRESS;
			axiTargVip[i].axi_slave_mem.meminit_address_offset = 'h54e894c3;
		end
		
	endfunction
	
	task run_phase(uvm_phase phase);
		//! Run a process for each initiator vip that counts the number of completed transaction on this VIP
		foreach( apbInitVip[i] ) begin
			fork
				automatic int j = i;
				forever begin
					apbSubscriberEvent[j].wait_trigger;
					nbTransactionDoneBySocket[nocApbInitName[j]]=nbTransactionDoneBySocket[nocApbInitName[j]]+1;
					->updateTransactionDone;
				end
			join_none
		end
		foreach( ahbInitVip[i] ) begin
			fork
				automatic int j = i;
				forever begin
					ahbSubscriberEvent[j].wait_trigger;
				    nbTransactionDoneBySocket[nocAhbInitName[j]]=nbTransactionDoneBySocket[nocAhbInitName[j]]+1;
					->updateTransactionDone;
				end
			join_none
		end
		foreach( axiInitVip[i] ) begin
			fork
				automatic int j = i;
				forever begin
					axiSubscriberRdEvent[j].wait_trigger;
				    nbTransactionDoneBySocket[nocAxiInitName[j]]=nbTransactionDoneBySocket[nocAxiInitName[j]]+1;
					->updateTransactionDone;
				end
				forever begin
					axiSubscriberWrEvent[j].wait_trigger;
				    nbTransactionDoneBySocket[nocAxiInitName[j]]=nbTransactionDoneBySocket[nocAxiInitName[j]]+1;
					->updateTransactionDone;
				end
			join_none
		end
	endtask
endclass
