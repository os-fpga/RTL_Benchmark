//-----------------------------------------------------
// File Name   : simple_unsigned_4tap_fir
// Function    : A behavorial model with 4 multipliers, designed to test the 
//               functionality of DSP block.
//-----------------------------------------------------

module add_output_of_four_multipliers
  #(
    parameter INPUT_WIDTH = 14,
    parameter OUTPUT_WIDTH = 28
  )
  (
    input wire clk,
    input wire reset,
    input wire [INPUT_WIDTH-1:0] a,
    input wire [INPUT_WIDTH-1:0] b,
    output reg [OUTPUT_WIDTH-1:0] y
  );

  wire   [OUTPUT_WIDTH-1:0] mult0, mult1, mult2, mult3, adder_output;
    

// Multipliers

  mult_unsigned mult_inst0 (
    .A(a),
    .B(b),
    .Y(mult0) 
  );

  mult_unsigned mult_inst1 (
    .A(a),
    .B(b),
    .Y(mult1) 
  );

  mult_unsigned mult_inst2 (
    .A(a),
    .B(b),
    .Y(mult2) 
  );

  mult_unsigned mult_inst3 (
    .A(a),
    .B(b),
    .Y(mult3) 
  );
    
// Adders
    assign adder_output = mult0 + mult1 + mult2 + mult3;  

  always@ (posedge clk) begin
    if (reset)
      y <= 0;
    else
      y <= adder_output;
  end

endmodule