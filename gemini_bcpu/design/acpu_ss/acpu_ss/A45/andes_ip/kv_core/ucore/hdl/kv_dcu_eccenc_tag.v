// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_eccenc_tag (
    data,
    dataout
);
parameter DW = 32;
localparam PW = (DW > 32) ? 8 : 7;
localparam DW_ZE = (DW > 32) ? 64 : 32;
input [DW - 1:0] data;
output [PW - 1:0] dataout;


wire [DW_ZE - 1:0] s0;
kv_zero_ext #(
    .OW(DW_ZE),
    .IW(DW)
) u_data_ze (
    .out(s0),
    .in(data)
);
generate
    if (DW > 32) begin:gen_eccenc_64
        kv_eccenc64 u_dataout(
            .data(s0),
            .dataout(dataout)
        );
    end
    else begin:gen_eccenc_32
        kv_eccenc32 u_dataout(
            .data(s0),
            .dataout(dataout)
        );
    end
endgenerate
endmodule

