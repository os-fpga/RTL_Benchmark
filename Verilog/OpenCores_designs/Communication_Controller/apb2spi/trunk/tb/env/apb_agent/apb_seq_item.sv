
class apb_seq_item extends uvm_sequence_item;

		rand bit [`APB_ADDR_WIDTH-1:0] paddr;
		rand bit pwrite;
		rand bit [`APB_DATA_WIDTH-1:0] pwdata;
		rand bit presetn;
		//bit psel;
		//bit penable;
		//bit pready;
		bit [`APB_DATA_WIDTH-1:0] prdata;

	`uvm_object_utils_begin(apb_seq_item)
		`uvm_field_int(paddr,UVM_ALL_ON)
		`uvm_field_int(pwrite,UVM_ALL_ON)
		`uvm_field_int(pwdata,UVM_ALL_ON)
		`uvm_field_int(presetn,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name="");
		super.new(name);
	endfunction


endclass
