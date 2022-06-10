`ifndef _cordic_atan_iq_
`define _cordic_atan_iq_
`include "atan32_table.sv"

// Calc delay 32 clocks
module cordic_atan_iq(clk, IS, QS, angle, coe_radius);
	import ConstPkg::atan_table;	
	localparam STEPS = ConstPkg::STEPS;

	input wire clk; // todo: clk_ena
	input wire signed [29:0] IS, QS;
	output signed [31:0] angle;
	output [31:0] coe_radius; // sqrt(I^2 + Q^2) / K
	
	wire isign;
	reg isign_reg;
	reg signed [31:0] x[STEPS], y[STEPS-1]; // + 2 bit for carry (sqrt(2) * (1 + k)) todo: x unsigned and increase input vector width
	reg signed [31:0] a[STEPS-1:1];
	
	assign isign = IS < 'sh0;
	
	// rotate to working range -90..+90
	always_ff @(posedge clk) begin
		x[0] <= (isign) ? 32'sh0 - IS : 32'sh0 + IS;
		y[0] <= (isign) ? 32'sh0 + QS : 32'sh0 - QS; // invert y sign for true result sign
		isign_reg <= isign; // save rotate on 180 deg
	end
	
	always_ff @(posedge clk)
		if (y[0] > 'sh0)
			begin
				x[1] <= x[0] + y[0];
				y[1] <= y[0] - x[0];
				
				if (isign_reg)
					a[1] <= signed'({1'b0, {31{1'b1}}}) - (atan_table[0] - 1'b1); // rotate 180 - 45 deg
				else
					a[1] <= -atan_table[0]; // rotate -45 deg
			end
		else
			begin
				x[1] <= x[0] - y[0];
				y[1] <= y[0] + x[0];
				
				if (isign_reg)
					a[1] <= signed'({1'b1, {31{1'b0}}}) + atan_table[0]; // rotate -180 + 45 deg
				else
					a[1] <= atan_table[0]; // rotate +45 deg
			end
	
	genvar i;
	generate for(i = 2; i < STEPS-1; i++)
		begin :gen
			always_ff @(posedge clk)
				if (y[i-1] > 'sh0)
					begin
						x[i] <= x[i-1] + (y[i-1] >>> (i - 1));
						y[i] <= y[i-1] - (x[i-1] >>> (i - 1));
						a[i] <= a[i-1] - atan_table[i-1];
					end
				else
					begin
						x[i] <= x[i-1] - (y[i-1] >>> (i - 1));
						y[i] <= y[i-1] + (x[i-1] >>> (i - 1));
						a[i] <= a[i-1] + atan_table[i-1];
					end
		end
	endgenerate
	
	always_ff @(posedge clk)
		if (y[STEPS-2] > 'sh0)
			begin
				x[STEPS-1] <= x[STEPS-2] + (y[STEPS-2] >>> (STEPS-2));
				a[STEPS-1] <= a[STEPS-2] - atan_table[STEPS-2];
			end
		else
			begin
				x[STEPS-1] <= x[STEPS-2] - (y[STEPS-2] >>> (STEPS-2));
				a[STEPS-1] <= a[STEPS-2] + atan_table[STEPS-2];
			end
	
	assign angle = a[STEPS-1];
	assign coe_radius = x[STEPS-1];

endmodule : cordic_atan_iq

`endif
