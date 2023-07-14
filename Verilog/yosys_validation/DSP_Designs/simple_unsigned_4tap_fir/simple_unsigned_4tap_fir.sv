//-----------------------------------------------------
// File Name   : simple_unsigned_4tap_fir
// Function    : A behavorial model with 4 multipliers, designed to test the 
//               functionality of DSP block.
//-----------------------------------------------------
`include "mult_unsigned.sv"
`include "d_ff.sv"
module simple_unsigned_4tap_fir
  #(
    parameter INPUT_WIDTH = 14,
    parameter OUTPUT_WIDTH = 28
  )
  (
    input wire clk,
    input wire reset,
    input wire [INPUT_WIDTH-1:0] x,
    output reg [OUTPUT_WIDTH-1:0] y
  );

  wire   [14-1:0] H0,H1,H2,H3;
  wire   [OUTPUT_WIDTH-1:0] mult0, mult1, mult2, mult3, adder1, adder2, adder3;
  wire   [OUTPUT_WIDTH-1:0] Q1,Q2,Q3;
    
//Filter coefficients
    assign H0 = 1;
    assign H1 = 2;
    assign H2 = 4;
    assign H3 = 8;

// Multipliers

  mult_unsigned mult_inst0 (
    .A(x),
    .B(H0),
    .Y(mult0) 
  );

  mult_unsigned mult_inst1 (
    .A(x),
    .B(H1),
    .Y(mult1) 
  );

  mult_unsigned mult_inst2 (
    .A(x),
    .B(H2),
    .Y(mult2) 
  );

  mult_unsigned mult_inst3 (
    .A(x),
    .B(H3),
    .Y(mult3) 
  );
    
// Adders
    assign adder1 = Q1 + mult2;
    assign adder2 = Q2 + mult1;
    assign adder3 = Q3 + mult0;    

// delay elements

    d_ff #(.DATA_WIDTH(28)) dff1 (.clk(clk),.reset(reset),.D(mult3),.Q(Q1));
    d_ff #(.DATA_WIDTH(28)) dff2 (.clk(clk),.reset(reset),.D(adder1),.Q(Q2));
    d_ff #(.DATA_WIDTH(28)) dff3 (.clk(clk),.reset(reset),.D(adder2),.Q(Q3));

//Assign the last adder output to final output
  always@ (posedge clk) begin
    if (reset)
      y <= 0;
    else
      y <= adder3;
  end

  //assign y = adder3;

endmodule
