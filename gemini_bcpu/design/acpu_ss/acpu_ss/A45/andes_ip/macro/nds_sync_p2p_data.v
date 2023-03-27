// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nds_sync_p2p_data (
	  a_reset_n,
	  a_clk,
	  a_pulse,
	  a_data,
	  b_reset_n,
	  b_clk,
	  b_pulse,
	  b_data,
	  b_level,
	  b_level_d1
);

parameter DATA_BIT = 32;
parameter RESET_VALUE = 1'b0;
parameter RESET_DATA_VALUE = {DATA_BIT{1'b0}};

input			a_reset_n;
input			a_clk;
input			a_pulse;
input	[DATA_BIT-1:0]	a_data;

input			b_reset_n;
input			b_clk;
output			b_pulse;
output	[DATA_BIT-1:0]	b_data;
output			b_level;
output			b_level_d1;

reg	[DATA_BIT-1:0]	b_data_r;

nds_sync_p2p #(
        .RESET_VALUE (RESET_VALUE)
) nds_sync_p2p (
	.a_reset_n       (a_reset_n ),
	.a_clk           (a_clk     ),
	.a_pulse         (a_pulse   ),
	.b_reset_n       (b_reset_n ),
	.b_clk           (b_clk     ),
	.b_pulse         (b_pulse   ),
	.b_level         (b_level   ),
	.b_level_d1      (b_level_d1)
);

always @(negedge b_reset_n or posedge b_clk)
begin
	if (!b_reset_n)
	    b_data_r <= RESET_DATA_VALUE;
        else if (b_pulse)
	    b_data_r <= a_data;
end

assign b_data = b_data_r;

endmodule

