// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on


module clk_source (
	input   reset_in,
	input   clk_in,
	output  reset_out,
	output	clk_out

);


	altera_reset_synchronizer sync(
	
    		.reset_in	(reset_in), 
		.clk		(clk_in),
    		.reset_out	(reset_out)
	);

	assign clk_out=clk_in;


endmodule




