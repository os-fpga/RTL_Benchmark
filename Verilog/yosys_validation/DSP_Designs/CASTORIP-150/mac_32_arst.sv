module mac_32_arst(clock0, reset, a, b, out);

	input clock0,reset;
	input signed [15:0] a, b;
	output reg signed [31:0] out;

	// reg signed [31:0] out;

	always @(posedge clock0 or posedge reset)
	begin
		if (reset) 
			out <= 32'h0;
    	else
			out <= out + (a * b);
	end

endmodule

