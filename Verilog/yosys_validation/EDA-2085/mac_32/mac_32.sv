`define MAC_32 2


module mac_32_unit(clock0, reset, A, B, Y);

   input clock0, reset;
   input signed [15 : 0] A, B;
   output signed [31 : 0] Y;
   
   reg signed [31 : 0] Y;

      always @(posedge clock0)
       begin
         if(reset) Y <= 0;
         else Y <= Y + (A * B);
       end

endmodule



module mac_32(id, clock0, reset, A,B, Y);
   
   input clock0, reset;
   input signed [15 : 0] A,B;
   output signed [31 : 0] Y;
   input [0:$clog2(`MAC_32+1) - 1] id;
   
   
   wire signed [31:0] output_bus [0:`MAC_32 - 1];
   reg signed [15:0] input_a [0:`MAC_32 - 1];
   reg signed [15:0] input_b [0:`MAC_32 - 1];


   genvar i;
   generate
      for(i = 0; i < `MAC_32; i = i + 1)begin
         mac_32_unit a0(clock0, reset, input_a[i], input_b[i], output_bus[i]);
         // assign Y = output_bus[i];
      end
   endgenerate
   assign Y = output_bus[id];
   integer j;
   
   always @(*) begin
      for (j = 0; j < `MAC_32; j=j+1) begin
         input_a[j]           = 'd0;
         input_b[j]           = 'd0;
         // input_a[j] = A;
         // input_b[j] = B;
      end
      input_a[id] = A;
      input_b[id] = B;
  end

endmodule