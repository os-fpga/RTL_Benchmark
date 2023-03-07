// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_bit_expand (
    out,
    in
);
parameter N = 8;
parameter M = 8;
output [(N * M) - 1:0] out;
input [N - 1:0] in;


integer s0;
reg [(N * M) - 1:0] out;
always @(in) begin
    for (s0 = 0; s0 < N; s0 = s0 + 1) begin
        out[s0 * M +:M] = {M{in[s0]}};
    end
end

endmodule

