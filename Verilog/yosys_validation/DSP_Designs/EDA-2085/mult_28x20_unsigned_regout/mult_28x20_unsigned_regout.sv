`define MULT_28X20_UNSIGNED_REGOUT 2

module mult(
  input reset,
  input clock0,
  input [0:27] A,
  input [0:19] B,
  output reg [0:47] Y
);

  always @(posedge clock0) begin
    if (reset) begin
      Y <= 0;
    end else begin
      Y <= A*B;
    end
  end
endmodule

module mult_28x20_unsigned_regout
(
  input [0: $clog2(`MULT_28X20_UNSIGNED_REGOUT+1) - 1] id,
  input reset,
  input clock0,
  input [0:27] A,
  input [0:19] B,
  output [0:47] Y
);
wire [0:47] output_Y [0:`MULT_28X20_UNSIGNED_REGOUT - 1];
wire [0:27] input_A [0:`MULT_28X20_UNSIGNED_REGOUT - 1];
wire [0:19] input_B [0:`MULT_28X20_UNSIGNED_REGOUT - 1];

genvar i;
generate
  for(i=0; i < `MULT_28X20_UNSIGNED_REGOUT; i =i + 1)begin
    mult instance0(reset,clock0,input_A[i],input_B[i],output_Y[i]);
    if(i > 0) begin
      assign input_A[i] = output_Y[i-1][0:27];
      assign input_B[i] = output_Y[i-1][28:47];
    end
  end
endgenerate
assign input_A[0] = A;
assign input_B[0] = B;
assign Y = output_Y[id];
  
endmodule
