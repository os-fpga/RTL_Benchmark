// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_arb_fp (
    valid,
    ready,
    grant
);
parameter N = 8;
input [N - 1:0] valid;
output [N - 1:0] ready;
output [N - 1:0] grant;


assign ready[0] = 1'b1;
generate
    genvar i;
    for (i = 1; i < N; i = i + 1) begin:gen_ready
        assign ready[i] = ~|valid[i - 1:0];
    end
endgenerate
assign grant = valid & ready;
endmodule

