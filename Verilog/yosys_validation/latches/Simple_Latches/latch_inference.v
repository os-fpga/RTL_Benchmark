// Creating a scaleable adder

module latch_inference(cout, sum, a, b,clk,cin,R,G,Q1,Q2,Q3,Q4,Q5,Q6);
parameter size = 10;  /* declare a parameter. default required */
output cout;
output reg [size-1:0] sum; 	 // sum uses the size parameter
input cin,R,G,clk;
input [size-1:0] a, b;  // 'a' and 'b' use the size parameter
output  Q1,Q2,Q3,Q4,Q5,Q6;

wire [size-1:0] sum_w;


assign {cout, sum_w} = a + b + cin;


always @(posedge clk)begin
    sum<=sum_w;
end

LATCH      llatch_inst (.D(cout),.G(G),.Q(Q1));

LATCHN     llatchn_inst (.D(cout),.G(G),.Q(Q2));

LATCHR     llatchr_inst (.D(cout),.G(G),.R(R),.Q(Q3));

LATCHS     llatchs_inst (.D(cout),.G(G),.R(R),.Q(Q4));

LATCHNR    llatchnr_inst (.D(cout),.G(G),.R(R),.Q(Q5));

LATCHNS    llatchns_inst (.D(cout),.G(G),.R(R),.Q(Q6));


endmodule









