/*
Pre-processing cascade
It make bit-reversal permutation
First FFT cascade reads data from it
*/


`ifndef _cascade_0_
`define _cascade_0_
`include "bitrev_cnt.sv"

module cascade_0 #(parameter
	ADDR_WIDTH = 9,
	DATA_WIDTH = 32,
	POW_WIDTH = (2**$clog2(ADDR_WIDTH) > ADDR_WIDTH - 1) ? $clog2(ADDR_WIDTH) : $clog2(ADDR_WIDTH) + 1
)(
	input clk, aclr,
	
	// input data stream
	input sink_sop, sink_eop, sink_valid, // valid must be solid
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	
	// current pow and last addr
	input [POW_WIDTH-1:0] pow,
	input [ADDR_WIDTH-1:0] addr_max,
	
	// access to output buffer
	input [ADDR_WIDTH-1:0] rdaddr, // read address
	output reg signed [DATA_WIDTH-1:0] q_Re, q_Im, // read data	
	output reg ready, // buffer ready
	input rdack, // read data acknowledge
	
	output reg error // input stream error
);
	reg wr_buf = 1'b0, rd_buf = 1'b0;
	reg signed [DATA_WIDTH-1:0] mem_Re[2][2**ADDR_WIDTH];
	reg signed [DATA_WIDTH-1:0] mem_Im[2][2**ADDR_WIDTH];
	
	wire [ADDR_WIDTH-1:0] wraddr, wraddr_rev;
	reg valid_reg = 1'b0, eop_reg = 1'b0;
	reg signed [DATA_WIDTH-1:0] Re_reg, Im_reg;
	
	bitrev_cnt #(.WIDTH(ADDR_WIDTH)) cnt_inst(
		.clk, .aclr,
		.clk_ena(sink_valid), .sclr(sink_sop),
		.width(pow), .cnt_max(addr_max),
		.cnt(wraddr), .cnt_rev(wraddr_rev)
	);
	
	always_ff @(posedge clk, posedge aclr)
		valid_reg <= (aclr) ? 1'b0 : sink_valid;
	
	always_ff @(posedge clk) begin
		Re_reg <= sink_Re;
		Im_reg <= sink_Im;
		eop_reg <= sink_eop;
		
		if (valid_reg) begin
			mem_Re[wr_buf][wraddr_rev] <= Re_reg;
			mem_Im[wr_buf][wraddr_rev] <= Im_reg;
		end
	end
	
	always_ff @(posedge clk) begin
		q_Re <= mem_Re[rd_buf][rdaddr];
		q_Im <= mem_Im[rd_buf][rdaddr];
	end
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			ready <= 1'b0;
		else if (valid_reg && eop_reg && wraddr == addr_max)
			ready <= 1'b1;
		else if (rdack)
			ready <= 1'b0;
			
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			wr_buf <= 1'b0;
		else if (valid_reg && eop_reg && wraddr == addr_max)
			wr_buf <= !wr_buf;
			
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			rd_buf <= 1'b0;
		else if (rdack)
			rd_buf <= !rd_buf;
	
	always_ff @(posedge clk, posedge aclr)
		error <= (aclr) ? 1'b0 : (sink_sop || sink_eop) && !sink_valid || sink_eop && wraddr != addr_max - 1'b1;
endmodule :cascade_0

`endif
