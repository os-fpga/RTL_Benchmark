 `timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns
 /* max2
  * max2.v
  *
  * Combinational logic to select the larger signal of the two
  */
module max2 (
    a,
    b,
    out
);
    parameter WIDTH = 10;
    
    input   [WIDTH-1:0] a;
    input   [WIDTH-1:0] b;
    output  [WIDTH-1:0] out;
	
	wire    [WIDTH-1:0] diff = b-a;
    
    assign out = (diff[WIDTH-1]) ? a : b;
endmodule
