`timescale 1ns / 1ps
module is_less_than (
    a,
    b,
    a_lt_b
);
    parameter N = 32;
    
    input   [N-1:0] a;
    input   [N-1:0] b;
    output          a_lt_b;
    
    wire    [N-1:0] diff;
    assign diff = a - b;
    assign a_lt_b = diff[N-1];
endmodule
