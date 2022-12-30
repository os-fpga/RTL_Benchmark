`ifndef _cascade_0_
`define _cascade_0_
`include "bitrev.sv"

module cascade_0 #(parameter
	ADDR_WIDTH = 9,
	DATA_WIDTH = 32
)(
	input clk, aclr, sink_sop, sink_eop, sink_valid,
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	
	input [ADDR_WIDTH-1:0] source_rdaddr,
	output reg signed [DATA_WIDTH-1:0] source_Re, source_Im,	
	output reg source_ready,
	input source_rdack,
	output reg error
);
	reg wr_buf = 1'b0, rd_buf = 1'b0;
	reg signed [DATA_WIDTH-1:0] mem_Re[2][2**ADDR_WIDTH];
	reg signed [DATA_WIDTH-1:0] mem_Im[2][2**ADDR_WIDTH];
	
	reg [ADDR_WIDTH-1:0] wraddr = '0;
	wire [ADDR_WIDTH-1:0] wraddr_rev;
	reg valid_reg = 1'b0, eop_reg = 1'b0;
	reg signed [DATA_WIDTH-1:0] Re_reg, Im_reg;
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			wraddr <= '0;
		else if (sink_valid)
			if (sink_sop)
				wraddr <= '0;
			else if (wraddr != 2**ADDR_WIDTH - 1)
				wraddr <= wraddr + 1'b1;
				
	bitrev #(.WIDTH(ADDR_WIDTH)) bitrev_inst(.x(wraddr), .y(wraddr_rev));
	
	always_ff @(posedge clk, posedge aclr) begin
		valid_reg <= (aclr) ? 1'b0 : sink_valid;
		eop_reg <= (aclr) ? 1'b0 : sink_eop;
	end
	
	always_ff @(posedge clk) begin
		Re_reg <= sink_Re;
		Im_reg <= sink_Im;
		
		if (valid_reg) begin
			mem_Re[wr_buf][wraddr_rev] <= Re_reg;
			mem_Im[wr_buf][wraddr_rev] <= Im_reg;
		end
	end
	
	always_ff @(posedge clk) begin
		source_Re <= mem_Re[rd_buf][source_rdaddr];
		source_Im <= mem_Im[rd_buf][source_rdaddr];
	end
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			source_ready <= 1'b0;
		else if (valid_reg && eop_reg && wraddr == {ADDR_WIDTH{1'b1}})
			source_ready <= 1'b1;
		else if (source_rdack)
			source_ready <= 1'b0;
			
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			wr_buf <= 1'b0;
		else if (valid_reg && eop_reg && wraddr == {ADDR_WIDTH{1'b1}})
			wr_buf <= !wr_buf;
			
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			rd_buf <= 1'b0;
		else if (source_rdack)
			rd_buf <= !rd_buf;
	
	always_ff @(posedge clk, posedge aclr)
		error <= (aclr) ? 1'b0 : (sink_sop || sink_eop) && !sink_valid || sink_eop && wraddr != {ADDR_WIDTH{1'b1}} - 1'b1;
endmodule :cascade_0

`endif
