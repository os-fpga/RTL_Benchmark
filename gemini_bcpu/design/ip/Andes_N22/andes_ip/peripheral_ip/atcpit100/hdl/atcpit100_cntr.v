// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module atcpit100_cntr(
                       	  pclk,
                       	  presetn,
                       	  clk_en,
                       	  off,
                       	  decr,
                       	  load,
                       	  func,
                       	  pit_pause,
                       	  eq0,
                       	  cntr
);

input			pclk;
input			presetn;
input			clk_en;
input			off;
input			decr;
input			load;
input	[7:0]		func;
input			pit_pause;
output			eq0;
output	[7:0]		cntr;

reg	[7:0]		cntr;
wire	[7:0]		s0;
wire			s1;


assign eq0	= cntr == 8'b0;

assign s1	= off | (~pit_pause & clk_en & (load | decr));

assign s0	= (off | load) ? func : cntr - 8'h1;

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		cntr <= 8'h0;
	else if (s1)
		cntr <= s0;
end

endmodule

