//Wrapper Design


module wrapper_adder_columns(cout,sum,a,b,cin);
parameter size = 49;  /* declare a parameter. default required */
input [size*2-1:0]a,b;
output [size*2-1:0]sum;
input [1:0]cin;
output [1:0]cout;

adder_max ad1(.a(a[size-1:0]),.b(b[size-1:0]),.cin(cin[0]),.sum(sum[size-1:0]),.cout(cout[0]));
adder_max ad2(.a(a[size*2-1:size]),.b(b[size*2-1:size]),.cin(cin[1]),.sum(sum[size*2-1:size]),.cout(cout[1]));

endmodule



module adder_max #(parameter size = 49)(cout, sum, a, b, cin);
output cout;
output [size-1:0] sum; 	 // sum uses the size parameter
input cin;
input [size-1:0] a, b;  // 'a' and 'b' use the size parameter

assign {cout, sum} = a + b + cin;

endmodule










