  `define EIGHT_MULT_20x18_UNSIGNED_REGOUT 2
module mult
(
  input reset,
  input clock0,
  input [0:19] A,
  input [0:17] B,
  output reg [0:37] Y
);

  always @(posedge clock0) begin
    if (reset) begin
      Y <= 0;
    end else begin
      Y <= A * B;
    end
  end
  
endmodule

module eight_mult_20x18_unsigned_regout
(
  input  reset,
  input  clock0,
  input  [0:$clog2(`EIGHT_MULT_20x18_UNSIGNED_REGOUT) - 1] id,
  input  [0:19] A,
  input  [0:17] B,
  output [0:37] Y
);
  wire [0:19] input_A  [0:`EIGHT_MULT_20x18_UNSIGNED_REGOUT-1];
  wire [0:17] input_B  [0:`EIGHT_MULT_20x18_UNSIGNED_REGOUT-1];
  wire [0:37] output_Y [0:`EIGHT_MULT_20x18_UNSIGNED_REGOUT-1];
  genvar i;
  generate
    for(i=0; i < `EIGHT_MULT_20x18_UNSIGNED_REGOUT; i=i+1)begin
    mult mult_instance
    (
      reset,
      clock0,
      input_A[i],
      input_B[i],
      output_Y[i]
    );
    if(i > 0)begin
      assign input_A[i] = output_Y[i-1][0:19];
      assign input_B[i] = output_Y[i-1][20:37];
    end
    end
  
  endgenerate
  assign input_A[0] = A;
  assign input_B[0] = B;
  assign Y = output_Y[id];


endmodule

