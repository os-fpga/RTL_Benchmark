`include "apb_slave.v"
module tb();

		reg pclk_i;
		reg presetn_i;
		reg [3:0] paddr_i; 
		reg pwrite_i;
		reg [1:0] psel_i; // For future implementations using multiple SPIs
		reg penable_i;
		reg [7:0] pwdata_i;
		wire pready_o; 
		wire [7:0] prdata_o; 
		
		reg [7:0] spi_data_i;
		wire [7:0] spi_data_o; 
		reg spi_txn_cmpl_i;

	apb_slave a1(	
		pclk_i,
		presetn_i,
		paddr_i, 
		pwrite_i,
		psel_i, // For future implementations using multiple SPIs
		penable_i,
		pwdata_i,
		pready_o, 
		prdata_o, 
		
		spi_data_i,
		spi_data_o, 
		spi_txn_cmpl_i);

initial
begin
	presetn_i = 1'b0;
	pclk_i = 1'b0;
	spi_data_i = 'hab;
	#100 presetn_i = 1'b1;
	$dumpfile("rcc.vcd");
	$dumpvars(0,tb);
	write();	
	read();
	#100 $finish;
end

initial
	forever #10 pclk_i = ~pclk_i;

task write();
begin
	paddr_i = 'h0;
	@(posedge pclk_i);
	psel_i = 2'b01;
	pwrite_i = 1'b1;
	pwdata_i = $random;
	@(posedge pclk_i);
	penable_i = 1'b1;
	spi_txn_cmpl_i = 1'b0;
	@(posedge pclk_i);
	spi_txn_cmpl_i = 1'b1;
	@(posedge pclk_i);
	penable_i = 1'b0;
end
endtask

task read();
begin
	paddr_i = 'h0;
	@(posedge pclk_i);
	psel_i = 2'b11;
	pwrite_i = 1'b0;
	spi_data_i= $random;

	@(posedge pclk_i);
	penable_i = 1'b1;
	spi_txn_cmpl_i = 1'b0;
	@(posedge pclk_i);
	spi_txn_cmpl_i = 1'b1;

end
endtask

endmodule
