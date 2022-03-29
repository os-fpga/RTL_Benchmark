`timescale 1ns / 1ps
/* mux_Nto1.v
 * N-to-1 mux with encoded select
 * N has to be a power of 2
 */
module mux_Nto1 (
    in,
    sel,
    out
);
`include "math.v"
    parameter WIDTH = 1;
    parameter SIZE = 10;
    
    input      [WIDTH*SIZE-1:0] in;
    input  [CLogB2(SIZE-1)-1:0] sel;
    output          [WIDTH-1:0] out;

    // MUX function
    genvar i, j;
    generate
        for (i = 0; i < WIDTH; i = i + 1)
        begin : scramble
            wire [SIZE-1:0] din;
            
            for (j = 0; j < SIZE; j = j + 1)
            begin : in_inf
                assign din[j] = in[j*WIDTH + i];
            end

            assign out[i] = din[sel];
        end
    endgenerate

endmodule

