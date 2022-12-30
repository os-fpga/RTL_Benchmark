`ifndef _cascade_n_
`define _cascade_n_
`include "butterfly.sv"
`include "yx_addr.sv"
`include "delay_line.sv"

module cascade_n #(parameter
	ADDR_WIDTH = 9,
	DATA_WIDTH = 32,
//	RES_WIDTH = DATA_WIDTH + 1,
	POW = 3, // 1...ADDR_WIDTH/2
	POW_WIDTH = (2**$clog2(ADDR_WIDTH) > ADDR_WIDTH - 1) ? $clog2(ADDR_WIDTH) : $clog2(ADDR_WIDTH) + 1
)(
	input aclr, clk, sink_ready,
	output [ADDR_WIDTH-1:0] sink_rdaddr,
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	output reg sink_rdack,
	input [POW_WIDTH-1:0] pow, // 4..ADDR_WIDTH
	input [ADDR_WIDTH-1:0] addr_max,
	
	input [ADDR_WIDTH-1:0] source_rdaddr,
	input source_rdack,
	output reg signed [DATA_WIDTH:0] source_Re, source_Im,
	output reg source_ready
);
	localparam DELAY = (POW == 1 || POW == 2) ? 3 : 4;
	
	reg wr_buf = 1'b0, rd_buf = 1'b0;
	reg signed [DATA_WIDTH:0] mem_Re[2][2**ADDR_WIDTH];
	reg signed [DATA_WIDTH:0] mem_Im[2][2**ADDR_WIDTH];
	
	reg [ADDR_WIDTH-1:0] cnt, cnt_dly;
	reg sop = 1'b0;
	wire [ADDR_WIDTH-1:0] wraddr;
	wire wrvalid;
	wire [DATA_WIDTH:0] bf_Re, bf_Im;
	
	always @(posedge clk, posedge aclr)
		if (aclr)
			cnt <= '0;
		else if (!sink_ready || sink_rdack || cnt == addr_max)
			cnt <= '0;
		else
			cnt <= cnt + 1'b1;
	
	yx_addr #(.WIDTH(ADDR_WIDTH), .POW(POW)) yx0(.cnt, .yx_cnt(sink_rdaddr));
	
	always_ff @(posedge clk) begin
		sink_rdack <= cnt == addr_max - 1'b1; // at last addr
		sop <= cnt == 'h0;
	end
	
	butterfly #(.DATA_WIDTH(DATA_WIDTH), .POW(POW)) bf( // 3,4 clocks delay
		.clk, .sync(sop), .sink_Re, .sink_Im, // y, x
		.source_Re(bf_Re), .source_Im(bf_Im) // y, x
	);
	
	// Delay line. Butterfly (3 or 4) + memory read (1)
	delay_lines_reg #(.DELAY(DELAY + 1), .WIDTH(ADDR_WIDTH)) dly0(
		.aclr(1'b0), .sclr(1'b0), .clock(clk), .clock_ena(1'b1),
		.sig_in(cnt), .sig_out(cnt_dly)
	);
	
	delay_line_reg #(.DELAY(DELAY + 1)) dly1(
		.aclr, .sclr(1'b0), .clock(clk), .clock_ena(1'b1),
		.sig_in(sink_ready), .sig_out(wrvalid)
	);
	
	yx_addr #(.WIDTH(ADDR_WIDTH), .POW(POW)) yx1(.cnt(cnt_dly), .yx_cnt(wraddr));
	
	always_ff @(posedge clk)
		if (wrvalid)
			begin
				mem_Re[wr_buf][wraddr] <= bf_Re;
				mem_Im[wr_buf][wraddr] <= bf_Im;
			end
	
	always_ff @(posedge clk) begin
		source_Re <= mem_Re[rd_buf][source_rdaddr];
		source_Im <= mem_Im[rd_buf][source_rdaddr];
	end
			
	generate
		if (POW == ADDR_WIDTH)
			begin
				always_ff @(posedge clk, posedge aclr)
					if (aclr)
						source_ready <= 1'b0;
					else if (wrvalid && cnt_dly == 2**(POW-1)) // last cascade, ready to line read
						source_ready <= 1'b1;
					else if (source_rdack) // end
						source_ready <= 1'b0;
			end
		else
			begin
				always_ff @(posedge clk, posedge aclr)
					if (aclr)
						source_ready <= 1'b0;
					else if (pow == POW && wrvalid && cnt_dly == 2**(POW-1)) // last cascade, ready to line read
						source_ready <= 1'b1;
					else if (wrvalid && wraddr == 2**POW)
						source_ready <= 1'b1;
					else if (source_rdack) // end
						source_ready <= 1'b0;
			end
	endgenerate
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			wr_buf <= 1'b0;
		else if (wrvalid && cnt_dly == addr_max)
			wr_buf <= !wr_buf;
			
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			rd_buf <= 1'b0;
		else if (source_ready && source_rdack)
			rd_buf <= !rd_buf;
	
endmodule :cascade_n

`endif
