// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module nds_async_fifo_afe(
	w_reset_n,
	r_reset_n,
	w_clk,
	r_clk,
	wr,
	wr_data,
	rd,
	rd_data,
	almost_empty,
	almost_full,
	empty,
	full
);

parameter DATA_WIDTH = 32;
parameter FIFO_DEPTH = 8;
parameter ALMOST_FULL_THRESHOLD  = 0;
parameter ALMOST_EMPTY_THRESHOLD = 0;

localparam POINTER_INDEX_WIDTH = $clog2(FIFO_DEPTH) + 1;
localparam IDX_MSB = POINTER_INDEX_WIDTH - 1;

input				w_reset_n;
input  				r_reset_n;
input  				w_clk;
input  				r_clk;
input				wr;
input	[DATA_WIDTH-1:0]	wr_data;
input				rd;
output	[DATA_WIDTH-1:0]	rd_data;
output 				empty;
output 				full;
output 				almost_empty;
output 				almost_full;

reg	[DATA_WIDTH-1:0]	mem[0:FIFO_DEPTH-1];
reg				empty;
reg				full;
wire				almost_full;
wire				almost_empty;

reg	[POINTER_INDEX_WIDTH-1:0]	next_full;
wire					next_empty;
reg	[POINTER_INDEX_WIDTH-1:0]	bin_wr_ptr;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_wr_ptr;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_wr_ptr_sync1;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_wr_ptr_sync2;
reg	[POINTER_INDEX_WIDTH-1:0]	bin_rd_ptr;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_rd_ptr;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_rd_ptr_sync1;
reg	[POINTER_INDEX_WIDTH-1:0]	gray_rd_ptr_sync2;
wire	[DATA_WIDTH-1:0]		rd_data;
wire	[POINTER_INDEX_WIDTH-2:0]	wr_index;
wire	[POINTER_INDEX_WIDTH-2:0]	rd_index;
wire	[POINTER_INDEX_WIDTH-1:0]	next_bin_wr_ptr;
wire	[POINTER_INDEX_WIDTH-1:0]	next_gray_wr_ptr;
wire 	[POINTER_INDEX_WIDTH-1:0]	next_bin_rd_ptr;
wire	[POINTER_INDEX_WIDTH-1:0]	next_gray_rd_ptr;
wire	[POINTER_INDEX_WIDTH-1:0]	almost_full_next_bin_wr_ptr;






assign  wr_index = bin_wr_ptr[POINTER_INDEX_WIDTH-2:0];

always @(posedge w_clk) begin
	if (wr)
		mem[wr_index] <= wr_data;
end

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n) bin_wr_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else            bin_wr_ptr <= next_bin_wr_ptr;
end

assign   next_bin_wr_ptr = bin_wr_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}}, wr};


assign   next_gray_wr_ptr = (next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:0] ^ {1'b0, next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:1]});

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n)
		gray_wr_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else
		gray_wr_ptr <= next_gray_wr_ptr;
end

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n) begin
		gray_rd_ptr_sync1 <= {(POINTER_INDEX_WIDTH){1'b0}};
		gray_rd_ptr_sync2 <= {(POINTER_INDEX_WIDTH){1'b0}};
	end
	else begin
		gray_rd_ptr_sync1 <= gray_rd_ptr;
		gray_rd_ptr_sync2 <= gray_rd_ptr_sync1;
	end
end

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n)
		full <= 1'b0;
	else
		full <= &next_full;
end

always @* begin: gen_next_full
	integer		i;
	for(i = POINTER_INDEX_WIDTH - 1; i >= 0; i = i - 1) begin
		if(i==POINTER_INDEX_WIDTH-1 || i==POINTER_INDEX_WIDTH-2)
			next_full[i] = (next_gray_wr_ptr[i] != gray_rd_ptr_sync2[i]);
		else
			next_full[i] = (next_gray_wr_ptr[i] == gray_rd_ptr_sync2[i]);
	end
end

generate
if (ALMOST_FULL_THRESHOLD == 0) begin : gen_almost_full_0
	assign almost_full = 1'b0;
	assign almost_full_next_bin_wr_ptr  = {(POINTER_INDEX_WIDTH){1'b0}};
end
else if (ALMOST_FULL_THRESHOLD == 1) begin : gen_almost_full_1
	reg					almost_full_r;
	reg	[POINTER_INDEX_WIDTH-1:0]	next_almost_full;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_full_next_gray_wr_ptr;

	assign almost_full_next_bin_wr_ptr  = bin_wr_ptr + {{(POINTER_INDEX_WIDTH-2){1'b0}}, wr, ~wr};
	assign almost_full_next_gray_wr_ptr = (almost_full_next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:0] ^ {1'b0, almost_full_next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:1]});
	always @* begin: gen_next_almost_full
		integer		i;
		for(i = POINTER_INDEX_WIDTH - 1; i >= 0; i = i - 1) begin
			if((i == POINTER_INDEX_WIDTH-1) || (i == POINTER_INDEX_WIDTH-2))
				next_almost_full[i] = (almost_full_next_gray_wr_ptr[i] != gray_rd_ptr_sync2[i]);
			else
				next_almost_full[i] = (almost_full_next_gray_wr_ptr[i] == gray_rd_ptr_sync2[i]);
		end
	end

	always @(posedge w_clk or negedge w_reset_n) begin
		if (!w_reset_n)
			almost_full_r <= 1'b0;
		else
			almost_full_r <= &next_almost_full;
	end
	assign almost_full = almost_full_r;
end
else if (ALMOST_FULL_THRESHOLD < FIFO_DEPTH) begin : gen_almost_full_n
	reg					almost_full_r;
	reg					next_almost_full;
	reg	[POINTER_INDEX_WIDTH-1:0]	bin_rd_ptr_sync2;
	assign almost_full_next_bin_wr_ptr  = bin_wr_ptr + ALMOST_FULL_THRESHOLD[POINTER_INDEX_WIDTH-1:0] + {{(POINTER_INDEX_WIDTH-1){1'b0}}, wr};

	always @(gray_rd_ptr_sync2) begin: gen_bin_rd_ptr_sync2
		integer		i;
		for (i=0; i<POINTER_INDEX_WIDTH; i=i+1)
			bin_rd_ptr_sync2[i] = ^(gray_rd_ptr_sync2>>i);
	end

	always @* begin
		case({bin_rd_ptr_sync2[IDX_MSB], next_bin_wr_ptr[IDX_MSB], almost_full_next_bin_wr_ptr[IDX_MSB]})
		3'b000,
		3'b111: next_almost_full = 1'b0;

		3'b010,
		3'b101: next_almost_full = 1'b1;

		3'b001,
		3'b011,
		3'b110,
		3'b100: next_almost_full = (almost_full_next_bin_wr_ptr[IDX_MSB-1:0] >= bin_rd_ptr_sync2[IDX_MSB-1:0]);
		default: next_almost_full = 1'bx;
		endcase
	end

	always @(posedge w_clk or negedge w_reset_n) begin
		if (!w_reset_n)
			almost_full_r <= 1'b0;
		else
			almost_full_r <= (~(&next_full)) & next_almost_full;
	end
	assign almost_full = almost_full_r;
end

endgenerate


assign rd_index = bin_rd_ptr[POINTER_INDEX_WIDTH-2:0];
assign rd_data  = mem[rd_index];

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n) bin_rd_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else            bin_rd_ptr <= next_bin_rd_ptr;
end

assign   next_bin_rd_ptr =  bin_rd_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}}, rd};

assign   next_gray_rd_ptr = (  next_bin_rd_ptr[POINTER_INDEX_WIDTH-1:0] ^ { 1'b0,   next_bin_rd_ptr[POINTER_INDEX_WIDTH-1:1]});

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n)
		gray_rd_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else
		gray_rd_ptr <= next_gray_rd_ptr;
end

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n) begin
		gray_wr_ptr_sync1 <= {(POINTER_INDEX_WIDTH){1'b0}};
		gray_wr_ptr_sync2 <= {(POINTER_INDEX_WIDTH){1'b0}};
	end
	else begin
		gray_wr_ptr_sync1 <= gray_wr_ptr;
		gray_wr_ptr_sync2 <= gray_wr_ptr_sync1;
	end
end
assign next_empty = (next_gray_rd_ptr[POINTER_INDEX_WIDTH-1:0] == gray_wr_ptr_sync2[POINTER_INDEX_WIDTH-1:0]);

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n)
		empty <= 1'b1;
	else
		empty <= next_empty;
end

generate
if (ALMOST_EMPTY_THRESHOLD == 0) begin : gen_almost_empty_0
	assign almost_empty = 1'b0;
end
else if (ALMOST_EMPTY_THRESHOLD == 1) begin : gen_almost_empty_1
	reg					almost_empty_r;
	wire 	[POINTER_INDEX_WIDTH-1:0]	almost_empty_bin_rd_ptr;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_empty_gray_rd_ptr;

	assign almost_empty_bin_rd_ptr  =  bin_rd_ptr + {{(POINTER_INDEX_WIDTH-2){1'b0}}, rd, ~rd};
	assign almost_empty_gray_rd_ptr = (almost_empty_bin_rd_ptr[POINTER_INDEX_WIDTH-1:0] ^ { 1'b0, almost_empty_bin_rd_ptr[POINTER_INDEX_WIDTH-1:1]});

	always @(posedge r_clk or negedge r_reset_n) begin
		if (!r_reset_n)
			almost_empty_r <= 1'b0;
		else
			almost_empty_r <= (almost_empty_gray_rd_ptr[POINTER_INDEX_WIDTH-1:0] == gray_wr_ptr_sync2[POINTER_INDEX_WIDTH-1:0]);
	end

	assign almost_empty = almost_empty_r;
end
else if (ALMOST_EMPTY_THRESHOLD < FIFO_DEPTH) begin : gen_almost_empty_n
	reg					almost_empty_r;
	reg					next_almost_empty;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_empty_next_bin_rd_ptr;
	reg	[POINTER_INDEX_WIDTH-1:0]	bin_wr_ptr_sync2;
	assign almost_empty_next_bin_rd_ptr  = bin_rd_ptr + ALMOST_EMPTY_THRESHOLD[POINTER_INDEX_WIDTH-1:0] + {{(POINTER_INDEX_WIDTH-1){1'b0}}, rd};

	always @(gray_wr_ptr_sync2) begin: gen_bin_wr_ptr_sync2
		integer		i;
		for (i = 0; i<POINTER_INDEX_WIDTH; i = i + 1)
			bin_wr_ptr_sync2[i] = ^(gray_wr_ptr_sync2>>i);
	end

	always @* begin
		case({bin_wr_ptr_sync2[IDX_MSB], next_bin_rd_ptr[IDX_MSB], almost_empty_next_bin_rd_ptr[IDX_MSB]})
		3'b011,
		3'b100: next_almost_empty = 1'b0;

		3'b001,
		3'b110: next_almost_empty = 1'b1;

		3'b000,
		3'b010,
		3'b101,
		3'b111: next_almost_empty = (almost_empty_next_bin_rd_ptr[IDX_MSB-1:0] >= bin_wr_ptr_sync2[IDX_MSB-1:0]);
		default: next_almost_empty = 1'bx;
		endcase
	end

	always @(posedge r_clk or negedge r_reset_n) begin
		if (!r_reset_n)
			almost_empty_r <= 1'b0;
		else
			almost_empty_r <= (~(&next_empty)) & next_almost_empty;
	end
	assign almost_empty = almost_empty_r;
end
endgenerate

endmodule

