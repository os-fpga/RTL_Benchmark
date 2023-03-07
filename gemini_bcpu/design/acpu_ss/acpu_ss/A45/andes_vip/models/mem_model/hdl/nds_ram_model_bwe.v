// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module nds_ram_model_bwe (
	  clk,
	  cs,
	  bwe,
	  addr,
	  din,
	  dout
);

parameter ADDR_WIDTH		= 5;
parameter DATA_BYTE		= 4;
parameter IN_DELAY		= 0;
parameter OUT_DELAY		= 0;
parameter [0:0]	HOLD_DOUT	= 1'b1;
parameter ENABLE		= "yes";
parameter BIT_PER_BYTE		= 8;

localparam DATA_WIDTH		= DATA_BYTE * BIT_PER_BYTE;
localparam ARRAY_SIZE		= 1 << ADDR_WIDTH;

input				clk;
input				cs;
input [(DATA_BYTE-1):0]		bwe;
input [(ADDR_WIDTH-1):0]	addr;
input [(DATA_WIDTH-1):0]	din;
output [(DATA_WIDTH-1):0]	dout;


// synthesis translate_off
reg [(DATA_WIDTH-1):0]		mem[0:(ARRAY_SIZE-1)];	/* sparse */
// synthesis translate_on
wire				cs_dly;
wire [(DATA_BYTE-1):0]		bwe_dly;
wire [(ADDR_WIDTH-1):0]		addr_dly;
wire [(DATA_WIDTH-1):0]		din_dly;
reg [(ADDR_WIDTH-1):0]		addr_d1;
reg [(DATA_WIDTH-1):0]		tmp;
reg				drive_dout;

assign #(IN_DELAY) cs_dly   = cs;
assign #(IN_DELAY) bwe_dly  = bwe;
assign #(IN_DELAY) addr_dly = addr;
assign #(IN_DELAY) din_dly  = din;

always @(posedge clk) begin: gen_mem
	integer		i;
	if (cs_dly) begin
		if (|bwe_dly) begin
			// synthesis translate_off
			tmp = mem[addr_dly];
			// synthesis translate_on
			for (i = 0; i < DATA_BYTE; i = i + 1)
				if (bwe_dly[i])
					tmp[(i*BIT_PER_BYTE)+:BIT_PER_BYTE] = din_dly[(i*BIT_PER_BYTE)+:BIT_PER_BYTE];
			// synthesis translate_off
			mem[addr_dly] <= tmp;
			// synthesis translate_on
		end
	end
end

always @(posedge clk)
	if (cs_dly) begin
		if (~|bwe_dly) begin
			addr_d1 <= addr_dly;
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
$display ("NDS_MEM_INFO:%m:ADDR_WIDTH   = %2d", ADDR_WIDTH);
$display ("NDS_MEM_INFO:%m:DATA_WIDTH   = %2d", DATA_WIDTH);
$display ("NDS_MEM_INFO:%m:WE_WIDTH     = %2d", DATA_BYTE);
$display ("NDS_MEM_INFO:%m:BIT_PER_BYTE = %2d", BIT_PER_BYTE);
$display ("NDS_MEM_INFO:%m:ENABLE       = %3s", ENABLE);
end
`endif
// synthesis translate_on

endmodule
