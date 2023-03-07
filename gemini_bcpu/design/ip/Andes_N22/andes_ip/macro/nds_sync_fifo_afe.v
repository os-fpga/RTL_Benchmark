// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module nds_sync_fifo_afe (
	reset_n,
	clk,
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

input				reset_n;
input				clk;
input				wr;
input	[DATA_WIDTH-1:0]	wr_data;
input				rd;
output	[DATA_WIDTH-1:0]	rd_data;
wire	[DATA_WIDTH-1:0]	rd_data;
output				almost_empty;
output				almost_full;
output				empty;
output				full;

reg	[DATA_WIDTH-1:0]		mem[0:FIFO_DEPTH-1];
reg	[POINTER_INDEX_WIDTH-1:0]	wr_ptr;
reg	[POINTER_INDEX_WIDTH-1:0]	rd_ptr;
wire	[POINTER_INDEX_WIDTH-1:0]	next_rd_ptr;
wire	[POINTER_INDEX_WIDTH-1:0]	next_wr_ptr;
reg					empty;
reg					full;
wire					almost_empty;
wire					almost_full;

wire [POINTER_INDEX_WIDTH-2:0] wr_index;

assign wr_index = wr_ptr[POINTER_INDEX_WIDTH-2:0];
always @(posedge clk) begin
	if (wr)
		mem[wr_index] <= wr_data;
end

assign next_wr_ptr = wr_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}}, wr};

always @(negedge reset_n or posedge clk) begin
	if (!reset_n)
		wr_ptr <= {POINTER_INDEX_WIDTH{1'b0}};
	else
		wr_ptr <= next_wr_ptr;
end

wire  next_full = (next_wr_ptr[POINTER_INDEX_WIDTH-2:0] == next_rd_ptr[POINTER_INDEX_WIDTH-2:0]) &&
                  (next_wr_ptr[POINTER_INDEX_WIDTH-1]   != next_rd_ptr[POINTER_INDEX_WIDTH-1]  );
always @(negedge reset_n or posedge clk) begin
	if (!reset_n)
		full <= 1'b0;
	else
		full <= next_full;
end


generate
if (ALMOST_FULL_THRESHOLD == 0) begin : gen_almost_full_0
	assign almost_full = 1'b0;
end
else if ((ALMOST_FULL_THRESHOLD == 1) && (POINTER_INDEX_WIDTH > 2)) begin : gen_almost_full_1
	reg					almost_full_r;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_full_next_wr_ptr;
	assign almost_full_next_wr_ptr = wr_ptr + {{(POINTER_INDEX_WIDTH-2){1'b0}}, wr, ~wr};

	always @(negedge reset_n or posedge clk) begin
		if (!reset_n)
			almost_full_r <= 1'b0;
		else
			almost_full_r <= (almost_full_next_wr_ptr[POINTER_INDEX_WIDTH-2:0] == next_rd_ptr[POINTER_INDEX_WIDTH-2:0]) &&
			                 (almost_full_next_wr_ptr[POINTER_INDEX_WIDTH-1]   != next_rd_ptr[POINTER_INDEX_WIDTH-1]  );
	end
	assign almost_full = almost_full_r;
end
else if ((ALMOST_FULL_THRESHOLD == 1) && (POINTER_INDEX_WIDTH == 2)) begin : gen_almost_full_2
	reg					almost_full_r;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_full_next_wr_ptr;
	assign almost_full_next_wr_ptr = wr_ptr + {wr, ~wr};

	always @(negedge reset_n or posedge clk) begin
		if (!reset_n)
			almost_full_r <= 1'b0;
		else
			almost_full_r <= (almost_full_next_wr_ptr[POINTER_INDEX_WIDTH-2:0] == next_rd_ptr[POINTER_INDEX_WIDTH-2:0]) &&
			                 (almost_full_next_wr_ptr[POINTER_INDEX_WIDTH-1]   != next_rd_ptr[POINTER_INDEX_WIDTH-1]  );
	end
	assign almost_full = almost_full_r;
end
else if (ALMOST_FULL_THRESHOLD < FIFO_DEPTH) begin : gen_almost_full_n
	reg					almost_full_r;
	reg					next_almost_full;
	wire	[POINTER_INDEX_WIDTH-1:0]	almost_full_next_wr_ptr;
	assign almost_full_next_wr_ptr  = wr_ptr + ALMOST_FULL_THRESHOLD[POINTER_INDEX_WIDTH-1:0] + {{(POINTER_INDEX_WIDTH-1){1'b0}}, wr};

	always @* begin
		case({next_rd_ptr[IDX_MSB], next_wr_ptr[IDX_MSB], almost_full_next_wr_ptr[IDX_MSB]})
		3'b000,
		3'b111: next_almost_full = 1'b0;

		3'b010,
		3'b101: next_almost_full = 1'b1;

		3'b001,
		3'b011,
		3'b110,
		3'b100: next_almost_full = (almost_full_next_wr_ptr[IDX_MSB-1:0] >= next_rd_ptr[IDX_MSB-1:0]);
		default: next_almost_full = 1'bx;
		endcase
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			almost_full_r <= 1'b0;
		else
			almost_full_r <= (!next_full) & next_almost_full;
	end
	assign almost_full = almost_full_r;
end
endgenerate

assign next_rd_ptr = rd_ptr + {{(POINTER_INDEX_WIDTH-1) {1'b0}}, rd };
always @(negedge reset_n or posedge clk) begin
	if (!reset_n)
		rd_ptr <=  { POINTER_INDEX_WIDTH { 1'b0 }};
	else
		rd_ptr <= next_rd_ptr;
end

wire next_empty = (next_rd_ptr[POINTER_INDEX_WIDTH-1:0] == next_wr_ptr[POINTER_INDEX_WIDTH-1:0]);
always @(negedge reset_n or posedge clk) begin
	if (!reset_n)
		empty <= 1'b1;
	else
		empty <= next_empty;
end

generate
if (ALMOST_EMPTY_THRESHOLD == 0) begin : gen_almost_empty_0
	assign almost_empty = 1'b0;
end
else if ((ALMOST_EMPTY_THRESHOLD == 1) &&( POINTER_INDEX_WIDTH > 2)) begin : gen_almost_empty_1
	reg					almost_empty_r;
	wire 	[POINTER_INDEX_WIDTH-1:0]	almost_empty_next_rd_ptr;
	assign almost_empty_next_rd_ptr = rd_ptr + {{(POINTER_INDEX_WIDTH-2){1'b0}}, rd, ~rd};

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			almost_empty_r <= 1'b0;
		else
			almost_empty_r <= (almost_empty_next_rd_ptr[POINTER_INDEX_WIDTH-1:0] == next_wr_ptr[POINTER_INDEX_WIDTH-1:0]);
	end
	assign almost_empty = almost_empty_r;
end
else if ((ALMOST_EMPTY_THRESHOLD == 1) &&( POINTER_INDEX_WIDTH == 2)) begin : gen_almost_empty_2
	reg					almost_empty_r;
	wire 	[POINTER_INDEX_WIDTH-1:0]	almost_empty_next_rd_ptr;
	assign almost_empty_next_rd_ptr = rd_ptr + {rd, ~rd};

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			almost_empty_r <= 1'b0;
		else
			almost_empty_r <= (almost_empty_next_rd_ptr[POINTER_INDEX_WIDTH-1:0] == next_wr_ptr[POINTER_INDEX_WIDTH-1:0]);
	end
	assign almost_empty = almost_empty_r;
end
else if (ALMOST_EMPTY_THRESHOLD < FIFO_DEPTH) begin : gen_almost_empty_n
	reg					almost_empty_r;
	reg					next_almost_empty;
	wire 	[POINTER_INDEX_WIDTH-1:0]	almost_empty_next_rd_ptr;
	assign almost_empty_next_rd_ptr = rd_ptr + ALMOST_FULL_THRESHOLD[POINTER_INDEX_WIDTH-1:0] + {{(POINTER_INDEX_WIDTH-1){1'b0}}, rd};

	always @* begin
		case({next_wr_ptr[IDX_MSB], next_rd_ptr[IDX_MSB], almost_empty_next_rd_ptr[IDX_MSB]})
		3'b011,
		3'b100: next_almost_empty = 1'b0;

		3'b001,
		3'b110: next_almost_empty = 1'b1;

		3'b000,
		3'b010,
		3'b101,
		3'b111: next_almost_empty = (almost_empty_next_rd_ptr[IDX_MSB-1:0] >= next_wr_ptr[IDX_MSB-1:0]);
		default: next_almost_empty = 1'bx;
		endcase
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			almost_empty_r <= 1'b0;
		else
			almost_empty_r <= (~next_empty) & next_almost_empty;
	end
	assign almost_empty = almost_empty_r;
end
endgenerate

wire	[POINTER_INDEX_WIDTH-2:0]	rd_index;
assign rd_index = rd_ptr[POINTER_INDEX_WIDTH-2:0];
assign rd_data = mem[rd_index];


endmodule

