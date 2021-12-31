`timescale 1ns / 1ps
/* encoder_N.v
 * General N-bit encoder (input is one-hot)
 */
module encoder_N(
    decoded,
    encoded,
    valid
);
`include "math.v"

    parameter SIZE = 8;
    localparam LOG_SIZE = CLogB2(SIZE-1);
    localparam NPOT = 1 << LOG_SIZE;
    
    input        [SIZE-1:0] decoded;
    output   [LOG_SIZE-1:0] encoded;
    output                  valid;
    
    wire [NPOT-1:0] w_decoded;

    assign valid = |decoded;
    
    generate
        if (NPOT == SIZE)
            assign w_decoded = decoded;
        else
            assign w_decoded = {{(NPOT-SIZE){1'b0}}, decoded};
    endgenerate

    // Only a set of input sizes are selected
    // psl ERROR_encoder_size: assert always {LOG_SIZE <= 4 && LOG_SIZE != 0};

    generate
        if (LOG_SIZE == 1)
        begin
            assign encoded = w_decoded[1];
        end
        else if (LOG_SIZE == 2)
        begin
            assign encoded = {w_decoded[2] | w_decoded[3], w_decoded[1] | w_decoded[3]};
        end
        else if (LOG_SIZE == 3)
        begin
            // This produces slightly smaller area than the case-statement based implementation
            assign encoded = {w_decoded[4] | w_decoded[5] | w_decoded[6] | w_decoded[7],
                              w_decoded[2] | w_decoded[3] | w_decoded[6] | w_decoded[7],
                              w_decoded[1] | w_decoded[3] | w_decoded[5] | w_decoded[7]};
        end
        else if (LOG_SIZE == 4)
        begin
            reg [LOG_SIZE-1:0] w_encoded;
            assign encoded = w_encoded;
            always @(*)
            begin
                case (w_decoded)
                    16'h0001: w_encoded = 4'h0;
                    16'h0002: w_encoded = 4'h1;
                    16'h0004: w_encoded = 4'h2;
                    16'h0008: w_encoded = 4'h3;
                    16'h0010: w_encoded = 4'h4;
                    16'h0020: w_encoded = 4'h5;
                    16'h0040: w_encoded = 4'h6;
                    16'h0080: w_encoded = 4'h7;
                    16'h0100: w_encoded = 4'h8;
                    16'h0200: w_encoded = 4'h9;
                    16'h0400: w_encoded = 4'hA;
                    16'h0800: w_encoded = 4'hB;
                    16'h1000: w_encoded = 4'hC;
                    16'h2000: w_encoded = 4'hD;
                    16'h4000: w_encoded = 4'hE;
                    16'h8000: w_encoded = 4'hF;
                    default: w_encoded = 4'bxxxx;
                endcase
            end
        end
    endgenerate
endmodule

