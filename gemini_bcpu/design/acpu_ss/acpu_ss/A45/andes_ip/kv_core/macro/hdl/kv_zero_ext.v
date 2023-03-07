// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_zero_ext #(
    parameter OW = 8,
    parameter IW = 8)  (
    out,
    in
);
output [OW - 1:0] out;
input [IW - 1:0] in;


assign out[IW - 1:0] = in[IW - 1:0];
generate
    if (OW > IW) begin:gen_msbs
        assign out[OW - 1:IW] = {(OW - IW){1'b0}};
    end
endgenerate
endmodule

