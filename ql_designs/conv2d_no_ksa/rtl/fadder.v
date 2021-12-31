module fadder 
  #(parameter WIDTH=32)
   (a,b,cin,sum,cout);
   input  cin;
   input [WIDTH-1:0] a,b;
   output [WIDTH-1:0] sum;
   output 	      cout;
   
   assign {cout,sum} = a + b + cin;

endmodule
