
class spi_agent extends uvm_agent;

spi_sequencer spi_sqr;
spi_driver spi_drvr;
spi_monitor spi_mntr;
//spi_env_config spi_env_cfg;
uvm_analysis_port #(spi_seq_item) spi_agent_ap;

	`uvm_component_utils(spi_agent)

//uvm_active_passive_enum spi_is_active=UVM_ACTIVE;

function new(string name="spi_agent", uvm_component parent=null);
	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
	super.build_phase(phase);
//	if(spi_is_active==UVM_ACTIVE)begin
		spi_sqr = spi_sequencer::type_id::create("spi_sqr",this);
		spi_drvr = spi_driver::type_id::create("spi_drvr",this);
//	end
	spi_agent_ap = new("spi_agent_ap",this);
	spi_mntr = spi_monitor::type_id::create("spi_mntr",this);
endfunction

function void connect_phase(uvm_phase phase);
//	if(spi_is_active==UVM_ACTIVE)begin
		spi_drvr.seq_item_port.connect(spi_sqr.seq_item_export);
//	end
	spi_mntr.spi_ap.connect(spi_agent_ap);
endfunction

endclass

