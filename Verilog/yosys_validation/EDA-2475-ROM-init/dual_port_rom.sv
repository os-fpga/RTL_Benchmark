module dual_port_rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10)
(
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial $readmemh("memory_test.mem",rom);  //reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	always @ (posedge clk)
	begin
		q_a <= rom[addr_a];
		q_b <= rom[addr_b];
	end

endmodule

