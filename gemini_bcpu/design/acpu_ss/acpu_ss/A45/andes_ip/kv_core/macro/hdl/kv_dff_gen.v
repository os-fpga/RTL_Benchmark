// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dff_gen (
    clk,
    en,
    d,
    q
);
parameter EXPRESSION = 1;
parameter W = 8;
input clk;
input en;
input [W - 1:0] d;
output [W - 1:0] q;


generate
    if (EXPRESSION) begin:gen_dff
        reg [W - 1:0] s0;
        always @(posedge clk) begin
            if (en) begin
                s0 <= d;
            end
        end

        assign q = s0;
    end
    else begin:gen_stub
        assign q = {W{1'b0}};
    end
endgenerate
endmodule

