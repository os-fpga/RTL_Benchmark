`timescale 1ns / 1ps
module is_greater_than (
    a,
    b,
    a_gt_b
);
    parameter N = 32;
    
    input   [N-1:0] a;
    input   [N-1:0] b;
    output          a_gt_b;
    
    wire    [N-1:0] diff;
    assign diff = b - a;
    assign a_gt_b = diff[N-1];
endmodule
