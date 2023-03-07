// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mmu_eccenc (
    data,
    dataout
);
parameter DW = 32;
parameter PW = (DW > 32) ? 8 : 7;
input [DW - 1:0] data;
output [PW - 1:0] dataout;


wire [63:0] s0;
kv_zero_ext #(
    .IW(DW),
    .OW(64)
) u_data_zext (
    .in(data),
    .out(s0)
);
generate
    if (DW > 32) begin:gen_eccenc64
        kv_eccenc64 u_eccenc64(
            .data(s0[63:0]),
            .dataout(dataout)
        );
    end
    else begin:gen_eccenc32
        kv_eccenc32 u_eccenc32(
            .data(s0[31:0]),
            .dataout(dataout)
        );
    end
endgenerate
endmodule

