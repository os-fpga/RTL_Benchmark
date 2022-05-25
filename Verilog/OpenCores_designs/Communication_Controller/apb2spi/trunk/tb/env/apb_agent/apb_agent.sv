

class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)

apb_seqr apb_sqr;
apb_driver apb_drvr;
apb_monitor apb_montr;
apb_env_config apb_env_cfg;
uvm_analysis_port #(apb_seq_item) apb_agent_ap;

uvm_active_passive_enum is_active=UVM_ACTIVE;

function new(string name, uvm_component parent)
	super.new(name,parent);
endfunction


function build_phase(uvm_phase phase)
	super.build();
	if(is_active==UVM_ACTIVE)begin
		drvr = apb_driver::type_id::create("drvr",this);
		sqr = apb_sequencer::type_id::create("sqr",this);
	end
	apb_agent_ap = new();
	//montr = apb_monitor::type_id::create("montr",this);
	//cfg = apb_config::type_id::create("cfg",this);
endfunction

function connect_phase();
endfunction
	

endclass

