// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`ifdef NO_TIMESCALE
`else
`timescale 1ns/100ps
`endif

module nds_sync_fifo_data(
w_reset_n,
r_reset_n,
w_clk,
r_clk,
wr,
wr_data,
rd,
rd_data,
w_clk_empty,
empty,
full
);

parameter DATA_WIDTH = 32;
parameter FIFO_DEPTH = 8;
parameter POINTER_INDEX_WIDTH = 4;

input  w_reset_n;
input  r_reset_n;
input  w_clk;
input  r_clk;
input  wr;
input  [DATA_WIDTH-1:0] wr_data;
input  rd;
output [DATA_WIDTH-1:0] rd_data;
wire   [DATA_WIDTH-1:0] rd_data;
output w_clk_empty;
reg w_clk_empty;
output empty;
output full;
reg  [DATA_WIDTH-1:0] mem[0:FIFO_DEPTH-1];

reg  [POINTER_INDEX_WIDTH-1:0] wr_ptr;
reg  [POINTER_INDEX_WIDTH-1:0] rd_ptr;
wire [POINTER_INDEX_WIDTH-1:0] next_rd_ptr;
wire [POINTER_INDEX_WIDTH-1:0] next_wr_ptr;
wire [POINTER_INDEX_WIDTH-2:0] rd_addr;
reg empty;
reg full;



wire [POINTER_INDEX_WIDTH-2:0] index;
assign index = wr_ptr[POINTER_INDEX_WIDTH-2:0];
always @(posedge w_clk)
begin
	if (wr && !full)
	    mem[index] <= wr_data;
end

`ifdef NO_TIMESCALE
assign next_wr_ptr = ( (wr && !full) ? wr_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : wr_ptr);
`else
	`ifdef SYNTHESIS
assign next_wr_ptr = ( (wr && !full) ? wr_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : wr_ptr);
	`else
assign #0.1 next_wr_ptr = ( (wr && !full) ? wr_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : wr_ptr);
	`endif
`endif


always @(negedge w_reset_n or posedge w_clk)
begin
     if (!w_reset_n)
	     wr_ptr <=  { POINTER_INDEX_WIDTH { 1'b0 }};
     else
	     wr_ptr <= next_wr_ptr;
end

always @(negedge w_reset_n or posedge w_clk)
begin
     if (!w_reset_n)
        w_clk_empty <= 1'b1;
     else
        w_clk_empty <= (next_wr_ptr[POINTER_INDEX_WIDTH-1:0] == rd_ptr[POINTER_INDEX_WIDTH-1:0]);
end

always @(negedge w_reset_n or posedge w_clk)
begin
     if (!w_reset_n)
        full <= 1'b0;
     else
        full <= (next_wr_ptr[POINTER_INDEX_WIDTH-2:0] == rd_ptr[POINTER_INDEX_WIDTH-2:0]) &&
                (next_wr_ptr[POINTER_INDEX_WIDTH-1] != rd_ptr[POINTER_INDEX_WIDTH-1]);
end


`ifdef NO_TIMESCALE
assign next_rd_ptr = ( (rd && !empty) ? rd_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : rd_ptr);
`else
	`ifdef SYNTHESIS
assign next_rd_ptr = ( (rd && !empty) ? rd_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : rd_ptr);
	`else
assign #0.1 next_rd_ptr = ( (rd && !empty) ? rd_ptr + { {(POINTER_INDEX_WIDTH-1) {1'b0} }, 1'b1 } : rd_ptr);
	`endif
`endif
always @(negedge r_reset_n or posedge r_clk)
begin
     if (!r_reset_n)
	rd_ptr <=  { POINTER_INDEX_WIDTH { 1'b0 }};
     else
	rd_ptr <= next_rd_ptr;
end

always @(negedge r_reset_n or posedge r_clk)
begin
     if (!r_reset_n)
        empty <= 1'b1;
     else
        empty <= (next_rd_ptr[POINTER_INDEX_WIDTH-1:0] == wr_ptr[POINTER_INDEX_WIDTH-1:0]);
end

assign rd_addr = rd_ptr[POINTER_INDEX_WIDTH-2:0];
assign rd_data = mem[rd_addr];

endmodule
