// Wrapper Design

//parameter size = 90;  /* declare a parameter. default required */

module wrapper_adder_max #(parameter size = 90)(cout, sum, a, b, cin);
output cout;
output [size-1:0] sum; 	 // sum uses the size parameter
input cin;
input [size-1:0] a, b;  // 'a' and 'b' use the size parameter

assign {cout, sum} = a + b + cin;

endmodule









