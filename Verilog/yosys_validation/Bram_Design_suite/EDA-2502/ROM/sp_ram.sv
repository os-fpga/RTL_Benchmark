module sp_ram  #(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10) (
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	initial $readmemh("memory_test.mem",ram);
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk)
	begin
		addr_reg <= addr;
	end
	  
	assign q = ram[addr_reg];

endmodule 
