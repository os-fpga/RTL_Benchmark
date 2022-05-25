
class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)

	uvm_analysis_port#(spi_seq_item) spi_ap;
	virtual spi_if m_v_intf;
	spi_seq_item txn;
	integer cnt=0;

function new(string name="spi_monitor",uvm_component parent);
	super.new(name,parent);
	spi_ap=new("spi_ap",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(virtual spi_if)::get(this,"*","spi_vif",m_v_intf))
		`uvm_fatal("NO_SPI_MON_V_INTF","Virtual interface couldn't be obtained for spi monitor")
endfunction

virtual task run_phase(uvm_phase phase);
	txn = spi_seq_item::type_id::create("txn");
	forever
	begin
		wait(m_v_intf.SS==1'b0);
		for(int i=0;i<=`SPI_REG_WIDTH-1;i++)
		begin
			@(posedge m_v_intf.SCLK)
			txn.wdata[i] = m_v_intf.MOSI;
			txn.rdata[i] = m_v_intf.MISO;
			cnt++;
		end
		wait(m_v_intf.SS==1'b1);
		spi_ap.write(txn);
	end
endtask 

endclass
