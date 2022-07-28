`include "minsoc_bench_defines.v"
`include "minsoc_defines.v"

`include "timescale.v"


module minsoc_bench_clock();

`ifdef POSITIVE_RESET
    localparam RESET_LEVEL = 1'b1;
`elsif NEGATIVE_RESET
    localparam RESET_LEVEL = 1'b0;
`else
    localparam RESET_LEVEL = 1'b1;
`endif

reg clock, reset, eth_tx_clk, eth_rx_clk;

minsoc_bench_core minsoc_bench_core_0(
    .clock(clock),
    .reset(reset),
    .eth_tx_clk(eth_tx_clk),
    .eth_rx_clk(eth_rx_clk)
);

initial begin
    reset = ~RESET_LEVEL;
    clock = 1'b0;
	eth_tx_clk = 1'b0;
	eth_rx_clk = 1'b0;
    // Reset controller
    repeat (2) @ (negedge clock);
    reset = RESET_LEVEL;
    repeat (16) @ (negedge clock);
    reset = ~RESET_LEVEL;
end

//
//	Regular clocking and output
//
always begin
    #((`CLK_PERIOD)/2) clock <= ~clock;
end

//Generate tx and rx clocks
always begin
	#((`ETH_PHY_PERIOD)/2) eth_tx_clk <= ~eth_tx_clk;
end
always begin
	#((`ETH_PHY_PERIOD)/2) eth_rx_clk <= ~eth_rx_clk;	
end
//~Generate tx and rx clocks

endmodule
