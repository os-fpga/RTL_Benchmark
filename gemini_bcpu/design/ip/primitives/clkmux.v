`ifndef CLKMUX
`define CLKMUX

module clkmux
(
    input  wire clka     ,
    input  wire clkb     ,
    input  wire select   ,

    output wire clk_out
);


assign clk_out = select?clka:clkb;

endmodule
`endif //CLKMUX


