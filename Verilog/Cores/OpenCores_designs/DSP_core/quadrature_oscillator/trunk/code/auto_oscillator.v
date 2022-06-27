// 
// Davi C. M. de Almeida
//
// Automatic Quadrature Oscillator system
//
// wo oscillation frequency: pi/50 rad (100 samples per period)
// 
// To oscillate just hold start at 1 
// 
// Output sin(wo*n) / cos(wo*n) in 8 bits of precision (8b8 signed fixed point format)
//
// This code is a simple state machine that automatically applies an impulse to the input
// of the quadrature oscillator and keeps it oscillating indefinitely.

module auto_oscillator(
	input	clk, rst, start,
	output signed [15:0] sin, cos
);

	// declare state register
	reg [1:0] state, next_state;

	// states definitions
	`define S0 2'b00
	`define S1 2'b01
	`define S2 2'b11
	
	// oscillator controller regs
	reg x, osc_rst;
	quad_oscillator osc1(.clk(clk), 
								.rst(osc_rst), 
								.x({7'd0, x, 8'd0}), 
								.sin(sin), 
								.cos(cos));
	
	// synchronism
	always @ (posedge clk or posedge rst) begin
		if (rst == 1)
			state <= `S0;
		else
			state <= next_state;
	end
	
	// state transition	
	always @ (*) begin
		case (state)
			`S0: next_state = (start)? `S1:`S0;
			`S1: next_state = (start)? `S2:`S0;
			`S2: next_state = (start)? `S2:`S0;
		endcase
	end
	
	// Output depends only on the state
	always @ (state) begin
		case (state)
			`S0: begin
				osc_rst <= 1'b1;
				x <= 1'b0;
			end
			`S1: begin
				osc_rst <= 1'b0;
				x <= 1'b1;
			end
			`S2: begin
				osc_rst <= 1'b0;
				x <= 1'b0;
			end
		endcase
	end

endmodule
