// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dff_bwe (
    clk,
    bwe,
    d,
    q
);
parameter BYTES = 1;
input clk;
input [BYTES - 1:0] bwe;
input [(BYTES * 8) - 1:0] d;
output [(BYTES * 8) - 1:0] q;


integer s0;
reg [(BYTES * 8) - 1:0] q;
always @(posedge clk) begin
    for (s0 = 0; s0 < BYTES; s0 = s0 + 1) begin
        if (bwe[s0]) begin
            q[s0 * 8 +:8] <= d[s0 * 8 +:8];
        end
    end
end

endmodule

