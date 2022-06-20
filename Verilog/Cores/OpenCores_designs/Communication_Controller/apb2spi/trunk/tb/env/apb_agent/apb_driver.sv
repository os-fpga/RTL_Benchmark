
class apb_driver extends uvm_driver#(apb_seq_item);
	`uvm_component_utils(apb_driver)

	//uvm_analysis_port#(apb_seq_item) apb_ap;

	virtual apb_if v_intf;
	apb_seq_item txns;

function new(string name,uvm_component parent);
	super.new(name,parent);
	//apb_ap = new("apb_ap",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual apb_if)::get(this,"*","apb_vif",v_intf))
		`uvm_fatal("NO_APB_V_INTF","Virtual interface couldn't be obtained for apb driver")
	else
		`uvm_info("APB_V_INTF","Virtual interface has been obtained driver",UVM_NONE)

	txns = apb_seq_item::type_id::create("txns");
endfunction

task run_phase(uvm_phase phase);
	v_intf.PENABLE = 1'b0;
	forever begin
		`uvm_info("DRVR_RUN","Inside the run phase of driver",UVM_NONE)
		seq_item_port.get_next_item(txns);
		`uvm_info("DRVR_RUN",$psprintf("After getting the seq_item from seq, value of seq_item is %p",this.txns),UVM_NONE)
		v_intf.PADDR = txns.paddr;
		//repeat(1)@(posedge v_intf.PCLK);
		`uvm_info("DRVR_RUN","After assigning PADDR from sequence_item",UVM_NONE)
		if(txns.pwrite==1'b1)begin
			`uvm_info("DRVR_RUN","Invoking the apb_write task",UVM_NONE)
			apb_write(txns);
		end else begin
			`uvm_info("DRVR_RUN","Invoking the apb_read task",UVM_NONE)
			apb_read(txns);
		end
		repeat(1)@(posedge v_intf.PCLK);	
		seq_item_port.item_done();
	end
endtask
	
task apb_write(apb_seq_item txns);
begin
	@(posedge v_intf.PCLK);	
	//wait(v_intf.PREADY==1'b0);
	v_intf.PSEL = 1'b1;
	v_intf.PENABLE = 1'b0;
	v_intf.PADDR = txns.paddr;
	v_intf.PWRITE = txns.pwrite;
	@(posedge v_intf.PCLK);	
	v_intf.PENABLE = 1'b1;
	wait(v_intf.PREADY==1'b1);
	v_intf.PWDATA = txns.pwdata;
	wait(v_intf.PREADY==1'b0);
	v_intf.PSEL = 1'b0;
	v_intf.PADDR = 'h0;
	v_intf.PWRITE = 'h0;
	v_intf.PENABLE = 1'b0;
end
endtask 

task apb_read(apb_seq_item txns);
begin
	@(posedge v_intf.PCLK);	
	//wait(v_intf.PREADY==1'b0);
	v_intf.PSEL = 1'b1;
	v_intf.PENABLE = 1'b0;
	v_intf.PADDR = txns.paddr;
	v_intf.PWRITE = 1'b0;
	repeat(1)@(posedge v_intf.PCLK);	
	v_intf.PENABLE = 1'b1;
	wait(v_intf.PREADY==1'b1);
	txns.prdata = v_intf.PRDATA;
	wait(v_intf.PREADY==1'b0);
	v_intf.PSEL = 1'b0;
	v_intf.PADDR = 'h0;
	v_intf.PWRITE = 'h0;
	v_intf.PENABLE = 1'b0;
end
endtask 


endclass
