// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_eccenc_data (
    data,
    dataout
);
parameter DW = 32;
localparam PW = (DW > 32) ? 8 : 7;
input [DW - 1:0] data;
output [PW - 1:0] dataout;


generate
    if (DW == 32) begin:gen_eccenc32
        kv_eccenc32 u_data_out(
            .data(data),
            .dataout(dataout)
        );
    end
    else begin:gen_eccenc64
        kv_eccenc64 u_data_out(
            .data(data),
            .dataout(dataout)
        );
    end
endgenerate
endmodule

