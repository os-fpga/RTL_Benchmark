
class spi_seq_item extends uvm_sequence_item;

	`uvm_object_utils(spi_seq_item)

		bit [`SPI_REG_WIDTH-1:0] wdata;
		bit [`SPI_REG_WIDTH-1:0] rdata;
		bit [`SPI_REG_WIDTH-1:0] ss0_data;

	function new(string name="");
		super.new(name);
	endfunction


endclass
