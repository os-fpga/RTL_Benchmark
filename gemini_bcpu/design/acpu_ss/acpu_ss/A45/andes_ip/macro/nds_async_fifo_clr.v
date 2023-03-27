// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module nds_async_fifo_clr(
	w_reset_n,
	r_reset_n,
	w_clk,
	r_clk,
	w_fifo_clr,
	r_fifo_clr,
	wr,
	wr_data,
	rd,
	rd_data,
	empty,
	full,
	w_data_num,
	r_data_num
);

parameter DATA_WIDTH = 32;
parameter FIFO_DEPTH = 8;
parameter POINTER_INDEX_WIDTH = 4;

input				  w_reset_n;
input  				  r_reset_n;
input  				  w_clk;
input  				  r_clk;
input				  w_fifo_clr;
input  				  r_fifo_clr;
input				  wr;
input	[DATA_WIDTH-1:0]	  wr_data;
input				  rd;
output	[DATA_WIDTH-1:0]	  rd_data;
output 				  empty;
output 				  full;
output 	[POINTER_INDEX_WIDTH-1:0] w_data_num;
output 	[POINTER_INDEX_WIDTH-1:0] r_data_num;

reg	[DATA_WIDTH-1:0]	  mem[0:FIFO_DEPTH-1];
reg				  empty;
reg				  full;
reg		[POINTER_INDEX_WIDTH-1:0] next_full;
reg  	[POINTER_INDEX_WIDTH-1:0] bin_wr_ptr;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_wr_ptr;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_wr_ptr_sync1;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_wr_ptr_sync2;
reg  	[POINTER_INDEX_WIDTH-1:0] bin_wr_ptr_r_clk;
reg  	[POINTER_INDEX_WIDTH-1:0] bin_rd_ptr;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_rd_ptr;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_rd_ptr_sync1;
reg  	[POINTER_INDEX_WIDTH-1:0] gray_rd_ptr_sync2;
reg  	[POINTER_INDEX_WIDTH-2:0] bin_rd_ptr_w_clk;

wire	[DATA_WIDTH-1:0]	  rd_data;
reg		[POINTER_INDEX_WIDTH-2:0] wr_index;
reg		[POINTER_INDEX_WIDTH-2:0] rd_index;
wire	[POINTER_INDEX_WIDTH-1:0] next_bin_wr_ptr;
wire	[POINTER_INDEX_WIDTH-1:0] next_gray_wr_ptr;
wire 	[POINTER_INDEX_WIDTH-1:0] next_bin_rd_ptr;
wire	[POINTER_INDEX_WIDTH-1:0] next_gray_rd_ptr;



always @* begin : wr_index_blk
	integer		i;
	for (i = POINTER_INDEX_WIDTH - 2; i >= 0; i = i - 1) begin
		if(i == POINTER_INDEX_WIDTH - 2)
			wr_index[i] = gray_wr_ptr[i+1] ^ gray_wr_ptr[i];
		else
			wr_index[i] = gray_wr_ptr[i];
	end
end


always @(posedge w_clk) begin
	if (wr)
		mem[wr_index] <= wr_data;
end

always @(gray_wr_ptr) begin : bin_wr_ptr_blk
	integer		j;
	for (j = 0; j < POINTER_INDEX_WIDTH; j = j + 1)
		bin_wr_ptr[j] = ^(gray_wr_ptr>>j);
end

assign next_bin_wr_ptr = bin_wr_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}}, wr};

assign next_gray_wr_ptr = (next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:0] ^ {1'b0, next_bin_wr_ptr[POINTER_INDEX_WIDTH-1:1]});

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n)
		gray_wr_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else if (w_fifo_clr)
		gray_wr_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else
		gray_wr_ptr <= next_gray_wr_ptr;
end

always @(posedge w_clk or negedge w_reset_n) begin
	if (!w_reset_n) begin
		gray_rd_ptr_sync1 <= {(POINTER_INDEX_WIDTH){1'b0}};
		gray_rd_ptr_sync2 <= {(POINTER_INDEX_WIDTH){1'b0}};
	end
	else if (w_fifo_clr) begin
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
	else if (w_fifo_clr)
		full <= 1'b0;
	else
		full <= &next_full;
end

always @* begin: next_full_blk
	integer		i;
	for (i = POINTER_INDEX_WIDTH - 1; i >= 0; i = i - 1) begin
		if(i == POINTER_INDEX_WIDTH - 1 || i == POINTER_INDEX_WIDTH - 2)
			next_full[i] = (next_gray_wr_ptr[i] != gray_rd_ptr_sync2[i]);
		else
			next_full[i] = (next_gray_wr_ptr[i] == gray_rd_ptr_sync2[i]);
	end
end

always @* begin: bin_rd_ptr_w_clk_blk
	integer		i;
	for (i = 0; i < POINTER_INDEX_WIDTH - 1; i = i + 1)
		bin_rd_ptr_w_clk[i] = ^(gray_rd_ptr_sync2>>i);
end

wire [POINTER_INDEX_WIDTH-1:0] non_full_data_num = {1'b0, (bin_wr_ptr[POINTER_INDEX_WIDTH-2:0] - bin_rd_ptr_w_clk[POINTER_INDEX_WIDTH-2:0])};
assign w_data_num = full ? FIFO_DEPTH[POINTER_INDEX_WIDTH-1:0] : non_full_data_num;
always @* begin: rd_index_blk
	integer		i;
	for (i = POINTER_INDEX_WIDTH - 2; i >= 0; i = i - 1) begin
		if(i == POINTER_INDEX_WIDTH - 2)
			rd_index[i] = gray_rd_ptr[i+1] ^ gray_rd_ptr[i];
		else
			rd_index[i] = gray_rd_ptr[i];
	end
end

assign rd_data  = mem[rd_index];

always @(gray_rd_ptr) begin: bin_rd_ptr_blk
	integer		i;
	for (i = 0; i < POINTER_INDEX_WIDTH; i = i + 1)
		bin_rd_ptr[i] = ^(gray_rd_ptr>>i);
end

assign next_bin_rd_ptr =  bin_rd_ptr + {{(POINTER_INDEX_WIDTH-1){1'b0}}, rd};

assign next_gray_rd_ptr = (next_bin_rd_ptr[POINTER_INDEX_WIDTH-1:0] ^ { 1'b0, next_bin_rd_ptr[POINTER_INDEX_WIDTH-1:1]});

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n)
		gray_rd_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else if (r_fifo_clr)
		gray_rd_ptr <= {(POINTER_INDEX_WIDTH){1'b0}};
	else
		gray_rd_ptr <= next_gray_rd_ptr;
end

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n) begin
		gray_wr_ptr_sync1 <= {(POINTER_INDEX_WIDTH){1'b0}};
		gray_wr_ptr_sync2 <= {(POINTER_INDEX_WIDTH){1'b0}};
	end
	else if (r_fifo_clr) begin
		gray_wr_ptr_sync1 <= {(POINTER_INDEX_WIDTH){1'b0}};
		gray_wr_ptr_sync2 <= {(POINTER_INDEX_WIDTH){1'b0}};
	end
	else begin
		gray_wr_ptr_sync1 <= gray_wr_ptr;
		gray_wr_ptr_sync2 <= gray_wr_ptr_sync1;
	end
end

always @(posedge r_clk or negedge r_reset_n) begin
	if (!r_reset_n)
		empty <= 1'b1;
	else if (r_fifo_clr)
		empty <= 1'b1;
	else
		empty <= (next_gray_rd_ptr[POINTER_INDEX_WIDTH-1:0] == gray_wr_ptr_sync2[POINTER_INDEX_WIDTH-1:0]);
end

always @* begin: bin_wr_ptr_r_clk_blk
	integer		i;
	for (i = 0; i < POINTER_INDEX_WIDTH; i = i + 1)
		bin_wr_ptr_r_clk[i] = ^(gray_wr_ptr_sync2>>i);
end

assign r_data_num = empty ? {(POINTER_INDEX_WIDTH){1'b0}} : {(bin_wr_ptr_r_clk[POINTER_INDEX_WIDTH-1:0] - bin_rd_ptr[POINTER_INDEX_WIDTH-1:0])};

endmodule
