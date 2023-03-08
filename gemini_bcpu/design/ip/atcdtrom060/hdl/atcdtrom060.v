// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module atcdtrom060 (
                     	  pclk,
                     	  paddr,
                     	  psel,
                     	  penable,
                     	  pwrite,
                     	  pwdata,
                     	  pready,
                     	  prdata,
                     	  pslverr
);

parameter  DATA_WIDTH      = 32;
parameter  SLAVE_MSB       = 19;
parameter  MEM_SIZE_KB     = (1 << (SLAVE_MSB+1-10));

localparam PRODUCT_ID      = 32'h000B0600;

localparam DATA_MSB        = DATA_WIDTH-1;
localparam MEM_ADDR_LSB    = $clog2(DATA_WIDTH/8);
localparam MEM_ADDR_MSB    = $clog2(MEM_SIZE_KB) - 1 + 10;
localparam MEM_ADDR_WIDTH  = MEM_ADDR_MSB - MEM_ADDR_LSB + 1;
localparam MEM_DEPTH       = (1 << MEM_ADDR_WIDTH);

input                   pclk;
input     [SLAVE_MSB:0] paddr;
input                   psel;
input                   penable;
input                   pwrite;
input      [DATA_MSB:0] pwdata;
output                  pready;
output     [DATA_MSB:0] prdata;
output                  pslverr;

wire [MEM_ADDR_WIDTH-1:0] mem_addr;
wire                      mem_cs;
reg          [DATA_MSB:0] mem_dout;

reg          [DATA_MSB:0] mem [0:MEM_DEPTH-1];

initial begin
	$readmemh("atcdtrom060.data", mem, 0, MEM_DEPTH-1);
end

assign pready   = 1'b1;
assign prdata   = mem_dout;
assign pslverr  = psel & penable & pwrite;
assign mem_addr = paddr[MEM_ADDR_MSB:MEM_ADDR_LSB];
assign mem_cs   = psel & !penable & !pwrite;

always @(posedge pclk) begin
	if (mem_cs)
		mem_dout <= mem[mem_addr];
end

endmodule
