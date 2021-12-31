module myadder 
  #(parameter WIDTH=32) 
   (input  [WIDTH-1:0] a,b,
    output [WIDTH-1:0] sum,
    output 	       cout);

   
   assign {cout,sum} = a + b;

endmodule
