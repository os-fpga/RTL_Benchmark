
class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)

	uvm_analysis_port#(apb_seq_item) apb_ap;
	virtual apb_if mon_v_intf;

function new(string name="apb_monitor",uvm_component parent);
	super.new(name,parent);
	apb_ap=new("apb_ap",this);
endfunction

function void build_phase(uvm_phase phase);
	if(!uvm_config_db#(virtual apb_if)::get(this,"*","apb_intf1",mon_v_intf))
		`uvm_fatal("NO_APB_MON_V_INTF","Virtual interface couldn't be obtained for apb monitor")
endfunction

endclass
