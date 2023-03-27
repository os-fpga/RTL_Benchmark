// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module nds_sync_p2p (
	  a_reset_n,
	  a_clk,
	  a_pulse,
	  b_reset_n,
	  b_clk,
	  b_pulse,
	  b_level,
	  b_level_d1
);

parameter RESET_VALUE = 1'b0;

input			a_reset_n;
input			a_clk;
input			a_pulse;

input			b_reset_n;
input			b_clk;
output			b_pulse;
output			b_level;
output			b_level_d1;

reg		a_level_r;
reg		a_level_sync2b_syn1_r;
reg		a_level_sync2b_syn2_r;
reg		a_level_sync2b_syn3_r;

always @(negedge a_reset_n or posedge a_clk)
begin
	if (!a_reset_n)
	    a_level_r <= RESET_VALUE;
        else if (a_pulse)
	    a_level_r <= ~a_level_r;
end

always @(negedge b_reset_n or posedge b_clk)
begin
	if (!b_reset_n) begin
		a_level_sync2b_syn1_r <= RESET_VALUE;
		a_level_sync2b_syn2_r <= RESET_VALUE;
		a_level_sync2b_syn3_r <= RESET_VALUE;
	end
	else begin
		a_level_sync2b_syn1_r <= a_level_r;
		a_level_sync2b_syn2_r <= a_level_sync2b_syn1_r;
		a_level_sync2b_syn3_r <= a_level_sync2b_syn2_r;
	end
end

assign b_pulse = (a_level_sync2b_syn2_r ^ a_level_sync2b_syn3_r);
assign b_level = a_level_sync2b_syn2_r;
assign b_level_d1 = a_level_sync2b_syn3_r;

endmodule

