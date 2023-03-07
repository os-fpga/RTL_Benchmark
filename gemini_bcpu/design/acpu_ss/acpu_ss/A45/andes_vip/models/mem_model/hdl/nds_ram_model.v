// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nds_ram_model(
	clk,
	we,
	cs,
	addr,
	din,
	dout
);
parameter  WRITE_WIDTH		= 64;
parameter  ADDR_WIDTH		= 5;
parameter  OUT_DELAY		= 0;
parameter  ENABLE		= "yes";

localparam MEM_SIZE		= 2 ** ADDR_WIDTH;
localparam DATA_WIDTH           = WRITE_WIDTH;

input				clk;
input				we;
input				cs;
input [(ADDR_WIDTH-1):0]	addr;
input [(WRITE_WIDTH-1):0]	din;
output [(WRITE_WIDTH-1):0]	dout;

// synthesis translate_off
wire [(WRITE_WIDTH-1):0]	p_dout;
reg [(WRITE_WIDTH-1):0]		mem[0:(MEM_SIZE-1)];
// synthesis translate_on

reg [(ADDR_WIDTH-1):0]		read_addr;

always @(posedge clk) begin
	if (cs) begin
		if (we) begin
			// synthesis translate_off
			mem[addr] <= din;
			// synthesis translate_on
		end
	end
end

always @(posedge clk) begin
	if (cs) begin
		if (we)
			read_addr <= {ADDR_WIDTH{1'bx}};
		else
			read_addr <= addr;
	end
end

// synthesis translate_off
assign p_dout = mem[read_addr];
assign #(OUT_DELAY) dout = p_dout;

`ifdef NDS_INTERNAL_SIM
initial begin
$display ("NDS_MEM_INFO:%m:ADDR_WIDTH = %2d", ADDR_WIDTH);
$display ("NDS_MEM_INFO:%m:DATA_WIDTH = %2d", WRITE_WIDTH);
$display ("NDS_MEM_INFO:%m:WE_WIDTH   = %2d", 1);
$display ("NDS_MEM_INFO:%m:ENABLE     = %3s", ENABLE);
end
`endif
// synthesis translate_on


endmodule
