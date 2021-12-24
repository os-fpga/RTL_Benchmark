module ksa 
  #(parameter WIDTH=32) 
   (input  [WIDTH-1:0] a,b,
    output [WIDTH-1:0] sum,
    output 	       cout);

   wire [WIDTH-1:0]    b_w;
   wire [WIDTH-1:0]    p,g;
   wire [WIDTH-1:0]    cp1,cg1, c_gen,s_gen;
   
   assign b_w = b;
   assign p = a ^ b_w;
   assign g = a & b_w;
   
   assign cp1[0] = p[0];
   assign cg1[0] = g[0];
   
   assign c_gen[0] = g[0];
   assign s_gen[0] = p[0];
   
   genvar 	       cp_idx; 
   generate 
      for( cp_idx=1; cp_idx<WIDTH; cp_idx=cp_idx+1 ) begin  
	 assign cp1[cp_idx] = (p[cp_idx] & p[cp_idx-1]); 
	 assign cg1[cp_idx] = ((p[cp_idx] & g[cp_idx-1]) | g[cp_idx]);
	 assign c_gen[cp_idx] = (cp1[cp_idx] & c_gen[cp_idx-1]) | cg1[cp_idx]; 
	 assign s_gen[cp_idx] = p[cp_idx] ^ c_gen[cp_idx-1]; 
      end 
   endgenerate
   
   assign cout = c_gen[WIDTH-1];
   assign sum  = s_gen;
endmodule
