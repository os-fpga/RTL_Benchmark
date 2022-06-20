`ifndef _cordic_atan_abs_
`define _cordic_atan_abs_
`include "cordic_atan_iq.sv"

module cordic_atan_abs(clk, IS, QS, angle, abs);
	import ConstPkg::K_u32;

	input wire clk;
	input wire signed [29:0] IS, QS;
	output reg signed [31:0] angle;
	output reg [30:0] abs; // sqrt(I^2 + Q^2)
	
	wire signed [31:0] angle_res;
	wire [31:0] coe_radius;
	
	cordic_atan_iq cordic_inst(.clk, .IS, .QS, .angle(angle_res), .coe_radius);

	reg [($bits(coe_radius) + $bits(K_u32) - 1):0] abs_reg;
	
	always_ff @(posedge clk)
		abs_reg <= coe_radius * K_u32;
		
	assign abs = abs_reg[$bits(K_u32)+:31];
	
	always_ff @(posedge clk)
		angle <= angle_res;

endmodule :cordic_atan_abs

`endif
