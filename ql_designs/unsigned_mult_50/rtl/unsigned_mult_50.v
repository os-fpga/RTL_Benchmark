module top (out, a, b);
output [25:0] out;
wire [50:0] mult_wire;
	input  [25:0] a;
	input  [25:0] b;

	assign mult_wire = a * b;
    assign out = mult_wire[50:25] | mult_wire[24:0];

endmodule
