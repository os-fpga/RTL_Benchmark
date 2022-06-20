module SpwTCR_RX_CLOCK_RECOVER(
Din, 
Sin, 
clk_rx
);

input 	Din;
input 	Sin;
output logic 	clk_rx;

assign clk_rx = Din ^ Sin;

endmodule 
