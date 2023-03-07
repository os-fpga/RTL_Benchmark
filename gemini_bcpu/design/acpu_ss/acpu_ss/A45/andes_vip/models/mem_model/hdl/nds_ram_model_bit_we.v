// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ns/1ps

module nds_ram_model_bit_we (
	  clk,
	  cs,
	  we,
	  addr,
	  din,
	  dout
);

parameter ADDR_WIDTH = 5;
parameter DATA_WIDTH = 32;
parameter OUT_DELAY = 1.0;
parameter [0:0]	HOLD_DOUT = 1'b1;
parameter  ENABLE = "yes";

localparam ARRAY_SIZE = 1 << ADDR_WIDTH;

input				clk;
input				cs;
input [(DATA_WIDTH - 1):0]	we;
input [(ADDR_WIDTH - 1):0]	addr;
input [(DATA_WIDTH - 1):0]	din;
output [(DATA_WIDTH - 1):0]	dout;

reg [(ADDR_WIDTH - 1):0]	addr_d1;

// synthesis translate_off
reg [(DATA_WIDTH - 1):0]	mem [0:(ARRAY_SIZE - 1)];	/* sparse */
// synthesis translate_on

reg				drive_dout;
always @(posedge clk) begin : gen_mem
	// synthesis translate_off
	integer		j;
	for (j = 0; j < DATA_WIDTH; j = j + 1)
		mem[addr][j] <= (cs & we[j]) ? din[j] : mem[addr][j];
	// synthesis translate_on
end

always @(posedge clk)
	if (cs) begin
		if (~|we) begin
			addr_d1 <= addr;
			drive_dout <= 1'b1;
		end
		else begin
			drive_dout <= 1'b0;
		end
	end
	else begin
		if (HOLD_DOUT == 1'b0)
			drive_dout <= 1'b0;
	end

// synthesis translate_off
assign #(OUT_DELAY) dout = drive_dout ? mem[addr_d1] : {DATA_WIDTH{1'bx}};

`ifdef NDS_INTERNAL_SIM
initial begin
$display ("NDS_MEM_INFO:%m:ADDR_WIDTH = %2d", ADDR_WIDTH);
$display ("NDS_MEM_INFO:%m:DATA_WIDTH = %2d", DATA_WIDTH);
$display ("NDS_MEM_INFO:%m:WE_WIDTH   = %2d", DATA_WIDTH);
$display ("NDS_MEM_INFO:%m:ENABLE     = %3s", ENABLE);
end
`endif
// synthesis translate_on

endmodule
