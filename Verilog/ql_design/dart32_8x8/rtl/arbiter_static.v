`timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns

/* Static arbiter. Grant to the first request starting from the
 * least-significant bit
 */

 module arbiter_static #(
    parameter SIZE = 10
)
(
    input   [SIZE-1:0]  requests,
    output  [SIZE-1:0]  grants,
    output              grant_valid
);
    
    // This module only supports SIZE = 1, 2, 4, 8
    // psl ERROR_unsupported_arbiter_size: assert always {(SIZE > 0 && SIZE <= 10) || SIZE == 16};
    
    reg [SIZE:0] grant_temp;
    assign {grant_valid, grants} = grant_temp;

    generate
        if (SIZE == 1)
        begin
            always @(*)
            begin
                grant_temp = {requests, requests};
            end
        end
        else if (SIZE == 2)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 3'b101;
                else if (requests[1])   grant_temp = 3'b110;
                else                    grant_temp = 3'b000;
            end
        end
        else if (SIZE == 3)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 4'b1001;
                else if (requests[1])   grant_temp = 4'b1010;
                else if (requests[2])   grant_temp = 4'b1100;
                else                    grant_temp = 4'b0000;
            end
        end
        else if (SIZE == 4)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 5'b10001;
                else if (requests[1])   grant_temp = 5'b10010;
                else if (requests[2])   grant_temp = 5'b10100;
                else if (requests[3])   grant_temp = 5'b11000;
                else                    grant_temp = 5'b00000;
            end
        end
        else if (SIZE == 5)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 6'b10_0001;
                else if (requests[1])   grant_temp = 6'b10_0010;
                else if (requests[2])   grant_temp = 6'b10_0100;
                else if (requests[3])   grant_temp = 6'b10_1000;
                else if (requests[4])   grant_temp = 6'b11_0000;
                else                    grant_temp = 6'b00_0000;
            end
        end
        else if (SIZE == 6)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 7'b100_0001;
                else if (requests[1])   grant_temp = 7'b100_0010;
                else if (requests[2])   grant_temp = 7'b100_0100;
                else if (requests[3])   grant_temp = 7'b100_1000;
                else if (requests[4])   grant_temp = 7'b101_0000;
                else if (requests[5])   grant_temp = 7'b110_0000;
                else                    grant_temp = 7'b000_0000;
            end
        end
        else if (SIZE == 7)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 8'b1000_0001;
                else if (requests[1])   grant_temp = 8'b1000_0010;
                else if (requests[2])   grant_temp = 8'b1000_0100;
                else if (requests[3])   grant_temp = 8'b1000_1000;
                else if (requests[4])   grant_temp = 8'b1001_0000;
                else if (requests[5])   grant_temp = 8'b1010_0000;
                else if (requests[6])   grant_temp = 8'b1100_0000;
                else                    grant_temp = 8'b0000_0000;
            end
        end
        else if (SIZE == 8)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 9'b10000_0001;
                else if (requests[1])   grant_temp = 9'b10000_0010;
                else if (requests[2])   grant_temp = 9'b10000_0100;
                else if (requests[3])   grant_temp = 9'b10000_1000;
                else if (requests[4])   grant_temp = 9'b10001_0000;
                else if (requests[5])   grant_temp = 9'b10010_0000;
                else if (requests[6])   grant_temp = 9'b10100_0000;
                else if (requests[7])   grant_temp = 9'b11000_0000;
                else                    grant_temp = 9'b00000_0000;
            end
        end
        else if (SIZE == 9)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 10'b10_0000_0001;
                else if (requests[1])   grant_temp = 10'b10_0000_0010;
                else if (requests[2])   grant_temp = 10'b10_0000_0100;
                else if (requests[3])   grant_temp = 10'b10_0000_1000;
                else if (requests[4])   grant_temp = 10'b10_0001_0000;
                else if (requests[5])   grant_temp = 10'b10_0010_0000;
                else if (requests[6])   grant_temp = 10'b10_0100_0000;
                else if (requests[7])   grant_temp = 10'b10_1000_0000;
                else if (requests[8])   grant_temp = 10'b11_0000_0000;
                else                    grant_temp = 10'b00_0000_0000;
            end
        end
        else if (SIZE == 10)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 11'b100_0000_0001;
                else if (requests[1])   grant_temp = 11'b100_0000_0010;
                else if (requests[2])   grant_temp = 11'b100_0000_0100;
                else if (requests[3])   grant_temp = 11'b100_0000_1000;
                else if (requests[4])   grant_temp = 11'b100_0001_0000;
                else if (requests[5])   grant_temp = 11'b100_0010_0000;
                else if (requests[6])   grant_temp = 11'b100_0100_0000;
                else if (requests[7])   grant_temp = 11'b100_1000_0000;
                else if (requests[8])   grant_temp = 11'b101_0000_0000;
                else if (requests[9])   grant_temp = 11'b110_0000_0000;
                else                    grant_temp = 11'b000_0000_0000;
            end
        end
        else if (SIZE == 16)
        begin
            always @(*)
            begin
                if (requests[0])        grant_temp = 17'h10001;
                else if (requests[1])   grant_temp = 17'h10002;
                else if (requests[2])   grant_temp = 17'h10004;
                else if (requests[3])   grant_temp = 17'h10008;
                else if (requests[4])   grant_temp = 17'h10010;
                else if (requests[5])   grant_temp = 17'h10020;
                else if (requests[6])   grant_temp = 17'h10040;
                else if (requests[7])   grant_temp = 17'h10080;
                else if (requests[8])   grant_temp = 17'h10100;
                else if (requests[9])   grant_temp = 17'h10200;
                else if (requests[10])  grant_temp = 17'h10400;
                else if (requests[11])  grant_temp = 17'h10800;
                else if (requests[12])  grant_temp = 17'h11000;
                else if (requests[13])  grant_temp = 17'h12000;
                else if (requests[14])  grant_temp = 17'h14000;
                else if (requests[15])  grant_temp = 17'h18000;
                else                    grant_temp = 17'h00000;
            end
        end
    endgenerate
endmodule
