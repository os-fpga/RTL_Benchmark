`ifndef _fft_int_
`define _fft_int_
`include "cascade_0.sv"
`include "cascade_n.sv"

// Integer streaming FFT
module fft_int #(parameter
	POW = 9, // FFT length N = 2**POW
	DATA_WIDTH = 32,
	RES_WIDTH = DATA_WIDTH + POW // not divided by 1/sqrt(N)
)(
	input clk, aclr,
	input sink_sop, sink_eop, sink_valid,
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	output reg source_sop, source_eop, source_valid,
	output signed [RES_WIDTH-1:0] source_Re, source_Im,
	output error
);
	
	wire [POW:0][POW-1:0] rdaddr;
	wire [POW:0] ready, rdack;
	
	genvar k;
	generate for (k = 0; k <= POW; k++)
		begin :res
			wire signed [DATA_WIDTH + k - 1:0] re, im;
		end
	endgenerate

	// input controller
	cascade_0 #(.ADDR_WIDTH(POW), .DATA_WIDTH(DATA_WIDTH)) c0(
		.clk, .aclr, .sink_sop, .sink_eop, .sink_valid,
		.sink_Re, .sink_Im,
		
		.source_rdaddr(rdaddr[0]),
		.source_Re(res[0].re), .source_Im(res[0].im),
		.source_ready(ready[0]),
		.source_rdack(rdack[0]),
		.error
	);
	
	genvar i;
	generate for (i = 1; i <= POW; i++)
		begin :gen			
			cascade_n #(.ADDR_WIDTH(POW), .DATA_WIDTH(DATA_WIDTH + i - 1), .POW(i)) cn(
				.clk, .aclr, .sink_ready(ready[i-1]),
				.sink_rdaddr(rdaddr[i-1]),
				.sink_Re(res[i-1].re), .sink_Im(res[i-1].im),
				.sink_rdack(rdack[i-1]),
				.source_rdaddr(rdaddr[i]),
				.source_Re(res[i].re), .source_Im(res[i].im),
				.source_ready(ready[i]),
				.source_rdack(rdack[i])
			);
		end
	endgenerate
	
	// todo: to module
	reg [POW-1:0] cnt = '0;
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			cnt <= '0;
		else if (!ready[POW])
			cnt <= '0;
		else
			cnt <= cnt + 1'b1;
	
	assign rdaddr[POW] = cnt;
	assign rdack[POW] = cnt == '1;
	
	always_ff @(posedge clk) begin
		source_sop <= ready[POW] && cnt == '0;
		source_valid <= ready[POW] || rdack[POW];
		source_eop <= cnt == '1;
	end
	
	assign source_Re = res[POW].re;
	assign source_Im = res[POW].im;
	
endmodule :fft_int

`endif
