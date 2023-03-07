// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary




module async_clkmux (
	  reset0_n,
	  reset1_n,
	  clk_in0,
	  clk_in1,
	  select,
	  test_mode,
	  clk_out
);
parameter	ASYNC_CLK_MUX = "yes";

input	reset0_n;
input	reset1_n;
input	clk_in0;
input	clk_in1;
input	select;
input   test_mode;
output	clk_out;

generate
if (ASYNC_CLK_MUX == "yes") begin : gen_async_clkmux

	reg	select_sync1_clk0;
	reg	select_sync2_clk0;
	reg	select_sync1_clk1;
	reg	select_sync2_clk1;

	reg	clk0_en_sync1;
	reg	clk0_en_sync2;
	reg	clk1_en_sync1;
	reg	clk1_en_sync2;

	wire	clk0_en;
	wire	clk1_en;

	reg	clk0_en_reg;
	reg	clk1_en_reg;

	wire	gated_clk0;
	wire	gated_clk1;

	always @(posedge clk_in0 or negedge reset0_n) begin
		if (!reset0_n) begin
			select_sync1_clk0 <= 1'b0;
			select_sync2_clk0 <= 1'b0;
		end
		else begin
			select_sync1_clk0 <= select;
			select_sync2_clk0 <= select_sync1_clk0;
		end
	end

	always @(posedge clk_in0 or negedge reset0_n) begin
		if (!reset0_n) begin
			clk1_en_sync1 <= 1'b1;
			clk1_en_sync2 <= 1'b1;
		end
		else begin
			clk1_en_sync1 <= clk1_en_reg;
			clk1_en_sync2 <= clk1_en_sync1;
		end
	end

	always @(posedge clk_in0 or negedge reset0_n) begin
		if (!reset0_n)
			clk0_en_reg <= 1'b1;
		else
			clk0_en_reg <= clk0_en;
	end

	always @(posedge clk_in1 or negedge reset1_n) begin
		if (!reset1_n) begin
			select_sync1_clk1 <= 1'b0;
			select_sync2_clk1 <= 1'b0;
		end
		else begin
			select_sync1_clk1 <= select;
			select_sync2_clk1 <= select_sync1_clk1;
		end
	end

	always @(posedge clk_in1 or negedge reset1_n) begin
		if (!reset1_n) begin
			clk0_en_sync1 <= 1'b1;
			clk0_en_sync2 <= 1'b1;
		end
		else begin
			clk0_en_sync1 <= clk0_en_reg;
			clk0_en_sync2 <= clk0_en_sync1;
		end
	end

	always @(posedge clk_in1 or negedge reset1_n) begin
		if (!reset1_n)
			clk1_en_reg <= 1'b0;
		else
			clk1_en_reg <= clk1_en;
	end

	assign clk0_en = ~select_sync2_clk0 & ~clk1_en_sync2;
	assign clk1_en =  select_sync2_clk1 & ~clk0_en_sync2;

	gck u_gck_clk0 (
		.clk_out(gated_clk0),
		.clk_en(clk0_en),
		.clk_in(clk_in0),
		.test_en(test_mode)
	);
	gck u_gck_clk1 (
		.clk_out(gated_clk1),
		.clk_en(clk1_en),
		.clk_in(clk_in1),
		.test_en(test_mode)
	);

	nds_or2 u_clk_or( .O(clk_out), .I1(gated_clk0), .I2(gated_clk1) );
end
else begin : gen_sync_clkmux

	wire	clk0_en;
	wire	clk1_en;

	wire	gated_clk0;
	wire	gated_clk1;

	reg	clk0_en_reg;
	reg	clk1_en_reg;

	assign  clk0_en = ~select & ~clk1_en_reg;
	assign  clk1_en = select & ~clk0_en_reg;

	always @(posedge clk_in0 or negedge reset0_n) begin
		if (!reset0_n)
			clk0_en_reg <= 1'b1;
		else
			clk0_en_reg <= clk0_en;
	end

	always @(posedge clk_in1 or negedge reset1_n) begin
		if (!reset1_n)
			clk1_en_reg <= 1'b1;
		else
			clk1_en_reg <= clk1_en;
	end

	gck gck_clk0 (
		.clk_out(gated_clk0),
		.clk_en(clk0_en),
		.clk_in(clk_in0),
		.test_en(test_mode)
	);

	gck gck_clk1 (
		.clk_out(gated_clk1),
		.clk_en(clk1_en),
		.clk_in(clk_in1),
		.test_en(test_mode)
	);
	nds_or2 u_clk_or( .O(clk_out), .I1(gated_clk0), .I2(gated_clk1) );
end
endgenerate

endmodule

