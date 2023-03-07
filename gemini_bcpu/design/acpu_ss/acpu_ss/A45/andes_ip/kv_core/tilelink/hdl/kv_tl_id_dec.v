// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_tl_id_dec (
    source,
    sel
);
parameter N = 3;
input [3:0] source;
output [N - 1:0] sel;


assign sel[0] = source[3:1] == 3'b000;
assign sel[1] = source[3] == 1'b1;
generate
    if (N == 3) begin:gen_icu_dec
        assign sel[2] = source[3:2] == 2'b01;
    end
endgenerate
endmodule

