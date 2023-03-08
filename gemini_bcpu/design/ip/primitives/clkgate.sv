`ifndef CLKGATE
`define CLKGATE

module clkgate 
(
    input  logic clk      , // input clock
    input  logic clk_en   , // clock enable
	
    output logic clk_out    // output gated clock
);

logic clk_en_r;

always_latch begin
    if(~clk) clk_en_r = clk_en;
end

assign clk_out = clk & clk_en_r;

endmodule
`endif
