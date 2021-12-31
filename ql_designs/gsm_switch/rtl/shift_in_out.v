
`include "timescale.v"

module shift_data_in
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 8,	// group size, number of gsm_unit in each group
	parameter	DWIDTH	= 128	// data width = 16 bytes
)
(clk, clr, sig_i, sig_o);
	input  clk, sig_i, clr;
	output reg  [MWIDTH*GSIZE*DWIDTH-1:0]	sig_o;
	always @(posedge clk or posedge clr)
	begin
	   if (clr)
			begin
			sig_o <= 0;
			end
		else
			begin
	      sig_o <= {sig_o[MWIDTH*GSIZE*DWIDTH-2:0], sig_i};
			end
	end
endmodule

module shift_data_out
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 8,	// group size, number of gsm_unit in each group
	parameter	DWIDTH	= 128	// data width = 16 bytes
)
(clk, clr, sig_i, sig_o);
	input  clk, clr;
	input [MWIDTH*GSIZE*DWIDTH-1:0] sig_i;
	output sig_o;

	reg [MWIDTH*GSIZE*DWIDTH-1:0] tmp;
	always @(posedge clk or posedge clr)
	begin
	   if (clr)
			begin
			tmp <= sig_i;
			end
	   else
			begin
	      tmp <= {tmp[MWIDTH*GSIZE*DWIDTH-2:0], sig_i[MWIDTH*GSIZE*DWIDTH-1]};
			//tmp <= sig_i;
			end
	end
	assign sig_o = tmp[MWIDTH*GSIZE*DWIDTH-1];
endmodule