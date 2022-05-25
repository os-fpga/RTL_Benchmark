
class spi_driver extends uvm_driver#(spi_seq_item);
	`uvm_component_utils(spi_driver)

	//uvm_analysis_port#(spi_seq_item) spi_ap;

	virtual spi_if v_intf;
	integer cnt=0;
	spi_seq_item txn;

function new(string name,uvm_component parent);
	super.new(name,parent);
	//apb_ap = new("apb_ap",this);
endfunction

function void build_phase(uvm_phase phase);
	if(!uvm_config_db #(virtual spi_if)::get(this,"","spi_vif",v_intf))
		`uvm_fatal("NO_SPI_V_INTF","Virtual interface couldn't be obtained for spi driver")
	txn = spi_seq_item::type_id::create("txn");
endfunction

task run_phase(uvm_phase phase);
	//txn = spi_seq_item::type_id::create("txn");
	forever
	begin
		fork
		begin
			txn.rdata = txn.ss0_data;
			wait(v_intf.SS==1'b0);
			for(int i=0;i<=`SPI_REG_WIDTH-1;i++)
			begin
				@(posedge v_intf.SCLK)
				v_intf.MISO = txn.rdata[i];
			end
		end
		begin
			wait(v_intf.SS==1'b0);
			for(int i=0;i<=`SPI_REG_WIDTH-1;i++)
			begin
				@(posedge v_intf.SCLK)
				txn.wdata[i] = v_intf.MOSI;
			end
			txn.ss0_data = txn.wdata;
		end
		join
	end
endtask 

endclass
		
