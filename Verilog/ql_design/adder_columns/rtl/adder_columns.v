module adder_columns(cout,sum,a,b,cin);

input [379:0]a,b;
output [379:0]sum;
input [1:0]cin;
output [1:0]cout;

adder_max ad1(.a(a[189:0]),.b(b[189:0]),.cin(cin[0]),.sum(sum[189:0]),.cout(cout[0]));
adder_max ad2(.a(a[379:190]),.b(b[379:190]),.cin(cin[1]),.sum(sum[379:190]),.cout(cout[1]));

endmodule



module adder_max(cout, sum, a, b, cin);
parameter size = 190;  /* declare a parameter. default required */
output cout;
output [size-1:0] sum; 	 // sum uses the size parameter
input cin;
input [size-1:0] a, b;  // 'a' and 'b' use the size parameter

assign {cout, sum} = a + b + cin;

endmodule









