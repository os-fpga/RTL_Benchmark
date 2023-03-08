
`include "global.inc"


module n22_dtm_iso(
	  tck,
	  pwr_rst_n,
	  dbg_sleep,
	  a_req,
	  a_ack,
	  a_data,
	  b_req,
	  b_ack,
	  b_data
);
input		tck;
input		pwr_rst_n;
input		dbg_sleep;

input		a_req;
output		a_ack;
output	[31:0]	a_data;


output		b_req;
input		b_ack;
input	[31:0]	b_data;


reg		a_ack;
wire		s0;
wire		s1;
wire		s2;

reg		b_req;
wire		s3;
wire		s4;
wire		s5;

wire	[31:0]	s6;


always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n)
		a_ack <= 1'b0;
	else
		a_ack <= s0;
end

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n)
		b_req <= 1'b0;
	else
		b_req <= s3;
end


assign s0 = ~s2 & (a_ack | s1);
assign s3 = ~s5 & (b_req | s4);

assign s1 = a_req & (dbg_sleep | b_ack);
assign s2 = ~a_req;

assign s4 = a_req & (~dbg_sleep);
assign s5 = dbg_sleep | b_ack;

assign s6[31:27] = 5'd0;
assign s6[26:24] = 3'd0;
assign s6[23]    = 1'd0;
assign s6[22]    = 1'b1;
assign s6[21:20] = 2'd0;
assign s6[19]    = 1'b0;
assign s6[18]    = 1'b0;
assign s6[17]    = 1'b0;
assign s6[16]    = 1'b0;
assign s6[15]    = 1'b0;
assign s6[14]    = 1'b0;
assign s6[13]    = 1'b1;
assign s6[12]    = 1'b1;
assign s6[11]    = 1'b0;
assign s6[10]    = 1'b0;
assign s6[9]     = 1'b0;
assign s6[8]     = 1'b0;
assign s6[7]     = 1'b1;
assign s6[6]     = 1'b0;
assign s6[5]     = 1'b1;
assign s6[4]     = 1'b0;
assign s6[3:0]   = 4'd2;

assign a_data = dbg_sleep ? s6 : b_data;

endmodule


