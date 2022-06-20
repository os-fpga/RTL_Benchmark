// 
// Davi C. M. de Almeida
//
// Quadrature Oscillator
//
// System that impulse response is sin(wo*n) / cos(wo*n) waves with period of 100 samples (wo = pi/50)
//
// Input x in 8b8 signed fixed point format
// Output y in 8b8 signed fixed point format
//
// To make the system oscilate just give him an impulse!
// (That is, put x to 1 (16'd256) for one clock cicle and 0 in the rest)
//
// If you want more bits of resolution in the waves just multiply the impulse by powers of 2
// Eg. For 9 bits of resolution use an impulse x of 16'd256 * 2 = 16'd512  
// 	 For 10 bits of resolution use an impulse x of 16'd256 * 4 = 16'd1024

module quad_oscillator(
	input	clk, rst,
	input signed [15:0] x,
	output signed [15:0] sin, cos
);

	
	// registers z^(-1)
	reg signed [15:0] z1, z2;
	
	
	// auxiliary wires
	wire signed [23:0] za1, za2, zb1_sin, zb1_cos, sx1;
	wire signed [15:0] v;

	// synchronism
	always @ (posedge clk or posedge rst) begin
		if (rst == 1) begin
			z1 <= 16'd0;
			z2 <= 16'd0;
		end
		else begin
			z1 <= v;
			z2 <= z1;
		end
	end
		
	// routing
	assign za1 = (z1 <<< 9) - z1;
	assign za2 = (z2 <<< 8);
	assign zb1_sin = (z1 <<< 4);
	assign zb1_cos = -(z1 <<< 8) + z1;
	
	assign sx1 = za1 - za2;
	assign v = x + sx1[23:8];

	// outputs
	assign sin = zb1_sin[23:8];
	assign cos = v + zb1_cos[23:8];
	
endmodule
