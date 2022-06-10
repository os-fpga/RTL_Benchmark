`ifndef _adder_tree_
`define _adder_tree_

// DELAY = $clog2(N)
(* multstyle = "dsp" *) module adder_tree #(parameter
	N = 32, DATA_WIDTH = 33, RESULT_WIDTH = ((N-1) < 2**$clog2(N)) ? DATA_WIDTH + $clog2(N) : DATA_WIDTH + $clog2(N) + 1
)(
	input clock, clock_ena,
	input signed [DATA_WIDTH-1:0] data[N-1:0],
	output signed [RESULT_WIDTH-1:0] result
);
	generate
		if (N == 2)
			add #(.DATAA_WIDTH(DATA_WIDTH), .DATAB_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RESULT_WIDTH))
				add_inst(.clock(clock), .clock_ena(clock_ena), .dataa(data[0]), .datab(data[1]), .result(result));
		else
			begin
				localparam RES_WIDTH = (RESULT_WIDTH > DATA_WIDTH + 1) ? DATA_WIDTH + 1 : RESULT_WIDTH;
				localparam RESULTS = (N % 2 == 0) ? N/2 : N/2 + 1;
				
				wire signed [RES_WIDTH-1:0] res[RESULTS - 1:0];
				
				add_pairs #(.N(N), .DATA_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RES_WIDTH))
					add_pairs_inst(.clock(clock), .clock_ena(clock_ena), .data(data), .result(res));
				
				adder_tree #(.N(RESULTS), .DATA_WIDTH(RES_WIDTH))
					adder_tree_inst(.clock(clock), .clock_ena(clock_ena), .data(res), .result(result));
			end
	endgenerate
	
endmodule :adder_tree

//////////////////////
module add_pairs #(parameter
	N = 32, DATA_WIDTH = 18, RESULT_WIDTH = DATA_WIDTH + 1, RESULTS = (N % 2 == 0) ? N/2 : N/2 + 1
)(
	input clock, clock_ena,
	input signed [DATA_WIDTH-1:0] data[N - 1:0],
	output signed [RESULT_WIDTH-1:0] result[RESULTS - 1:0]
);
	genvar i;
	
	generate
		for (i = 0; i < N/2; i++)
			begin :a
				add #(.DATAA_WIDTH(DATA_WIDTH), .DATAB_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RESULT_WIDTH))
					add_inst(.clock, .clock_ena, .dataa(data[2*i]), .datab(data[2*i + 1]), .result(result[i]));
			end
		
		if (RESULTS == N/2 + 1)
			begin
				reg [RESULT_WIDTH-1:0] res;
			
				always @(posedge clock)
					if (clock_ena)
						res <= data[N-1];
				
				assign result[RESULTS-1] = res;
			end
	endgenerate
endmodule :add_pairs

//////////////////////
module add #(parameter
	DATAA_WIDTH = 16, DATAB_WIDTH = 17, RESULT_WIDTH = (DATAA_WIDTH > DATAB_WIDTH) ? DATAA_WIDTH + 1 : DATAB_WIDTH + 1
)(
	input clock, clock_ena,
	input signed [DATAA_WIDTH-1:0] dataa,
	input signed [DATAB_WIDTH-1:0] datab,
	output reg signed [RESULT_WIDTH-1:0] result
);
	always_ff @(posedge clock)
		if (clock_ena)
			result <= dataa + datab;
endmodule :add

`endif
