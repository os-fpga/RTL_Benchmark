

module dpram_generic #(
	parameter ADDR_WIDTH = 3
)
(
	input			clk_a,
	input  [ADDR_WIDTH-1:0]	addr_a,
	input  [3:0]		we_a,
	input  [31:0]		di_a,
	output reg [31:0]	do_a,

	input			clk_b,
	input  [ADDR_WIDTH-1:0]	addr_b,
	input  [3:0]		we_b,
	input  [31:0]		di_b,
	output reg [31:0]	do_b
);

// Error (276001)
//Error (276001): Cannot synthesize dual-port RAM logic "wb_sdram_ctrl:SDRAM_CTRL_0|arbiter:arbiter|wb_port:wbports[0].wb_port|bufram:bufram|dpram_generic:dpram_generic.dpram_generic|mem0"

	reg [7:0]	mem0[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem1[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem2[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem3[(1<<ADDR_WIDTH)-1:0];

	always @(posedge clk_a) begin
		if (we_a[3])
			mem3[addr_a] <= di_a[31:24];
		if (we_a[2])
			mem2[addr_a] <= di_a[23:16];
		if (we_a[1])
			mem1[addr_a] <= di_a[15:8];
		if (we_a[0])
			mem0[addr_a] <= di_a[7:0];
		do_a <= {mem3[addr_a], mem2[addr_a],
			 mem1[addr_a], mem0[addr_a]};
	end

	always @(posedge clk_b) begin
		if (we_b[3])
			mem3[addr_b] <= di_b[31:24];
		if (we_b[2])
			mem2[addr_b] <= di_b[23:16];
		if (we_b[1])
			mem1[addr_b] <= di_b[15:8];
		if (we_b[0])
			mem0[addr_b] <= di_b[7:0];
		do_b <= {mem3[addr_b], mem2[addr_b],
			 mem1[addr_b], mem0[addr_b]};
	end
endmodule
