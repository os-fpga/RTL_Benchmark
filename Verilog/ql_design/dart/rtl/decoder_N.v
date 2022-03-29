`timescale 1ns / 1ps
/* decoder_N.v
 * General N-bit decoder (one-hot)
 */
module decoder_N(
    encoded,
    decoded
);
    `include "math.v"
    
    parameter SIZE = 8;

    input     [CLogB2(SIZE-1)-1: 0] encoded;
    output              [SIZE-1: 0] decoded;
    reg                 [SIZE-1: 0] decoded;
    
    genvar i;
    generate
        for (i = 0; i < SIZE; i = i + 1)
        begin : decode
            always @(*)
            begin
                if (i == encoded)
                    decoded[i] = 1'b1;
                else
                    decoded[i] = 1'b0;
            end
        end
    endgenerate
endmodule
