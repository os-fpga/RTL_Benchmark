`ifndef _ifft_int_
`define _ifft_int_
`include "fft_int.sv"

// Integer streaming IFFT divided by 2**DIV_POW
module ifft_int #(parameter
	POW = 14, // fft size 2**POW
	DATA_WIDTH = 32,
	DIV_POW = POW,
	RES_WIDTH = DATA_WIDTH - DIV_POW
)(
	input clk, aclr,
	input sink_sop, sink_eop, sink_valid,
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	
	output reg source_sop, source_eop, source_valid,
	output reg signed [RES_WIDTH-1:0] source_Re, source_Im,
	output error
);
	wire sop, eop, valid;
	wire signed [DATA_WIDTH + POW - 1:0] re, im;

	fft_int #(.POW(POW), .DATA_WIDTH(DATA_WIDTH)) ifft_inst(
		.clk, .aclr,
		.sink_sop, .sink_eop, .sink_valid,
		.sink_Re(sink_Im), .sink_Im(sink_Re),		
		.source_sop(sop), .source_eop(eop), .source_valid(valid),
		.source_Re(im), .source_Im(re),
		.error
	);
	
	always_ff @(posedge clk, posedge aclr)
		source_valid <= (aclr) ? 1'b0 : valid;
		
	always_ff @(posedge clk) begin
		source_sop <= sop;
		source_eop <= eop;
		source_Re <= div_pow2(re);
		source_Im <= div_pow2(im);
	end
	
	function signed [RES_WIDTH-1:0] div_pow2(input signed [DATA_WIDTH + POW - 1:0] x);
		logic signed [RES_WIDTH-1:0] y, res;
		
		y = x[DATA_WIDTH + POW - 1:POW];
		
		if (POW == 0)
			res = y;
		else
			if (y == '1 && x[POW-1] == 1'b1)
				res = 'sh0;
			else
				res = y;
			
		return res;
	endfunction

endmodule :ifft_int

`endif
