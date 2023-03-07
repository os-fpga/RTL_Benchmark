
`include "global.inc"

    `ifdef N22_HAS_DEBUG_PRIVATE

module n22_sync_l2l (
b_reset_n,
b_clk,
a_signal,
b_signal,
b_signal_rising_edge_pulse,
b_signal_falling_edge_pulse,
b_signal_edge_pulse
);

parameter RESET_VALUE = 1'b0;

input  b_reset_n;
input  b_clk;
input  a_signal;
output b_signal;
output b_signal_rising_edge_pulse;
output b_signal_falling_edge_pulse;
output b_signal_edge_pulse;
reg    b_signal;
wire   b_signal_rising_edge_pulse;
wire   b_signal_falling_edge_pulse;
wire   b_signal_edge_pulse;
reg    b_signal_d1;
reg    a_signal_sync1;

always @(negedge b_reset_n or posedge b_clk)
begin
	if (!b_reset_n)
	    a_signal_sync1 <= RESET_VALUE;
        else
	    a_signal_sync1 <= a_signal;
end

always @(negedge b_reset_n or posedge b_clk)
begin
	if (!b_reset_n)
	    b_signal <= RESET_VALUE;
        else
	    b_signal <= a_signal_sync1;
end

always @(negedge b_reset_n or posedge b_clk)
begin
	if (!b_reset_n)
	    b_signal_d1 <= RESET_VALUE;
        else
	    b_signal_d1 <= b_signal;
end

assign b_signal_rising_edge_pulse = b_signal && !b_signal_d1;
assign b_signal_falling_edge_pulse = !(b_signal || !b_signal_d1);
assign b_signal_edge_pulse = b_signal ^ b_signal_d1;

endmodule
`endif
