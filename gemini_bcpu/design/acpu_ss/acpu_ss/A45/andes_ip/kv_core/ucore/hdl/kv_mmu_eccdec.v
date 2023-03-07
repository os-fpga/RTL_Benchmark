// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_mmu_eccdec (
    clk,
    resetn,
    i_valid,
    i_data,
    i_par,
    o_data,
    o_par,
    o_ecc_corr,
    o_ecc_uncorr
);
parameter DW = 32;
parameter PW = (DW > 32) ? 8 : 7;
input clk;
input resetn;
input i_valid;
input [DW - 1:0] i_data;
input [PW - 1:0] i_par;
output [DW - 1:0] o_data;
output [PW - 1:0] o_par;
output o_ecc_corr;
output o_ecc_uncorr;


wire nds_unused_error;
wire nds_unused_invalidate;
wire nds_unused_replay;
wire nds_unused_xcpt;
wire [63:0] s0;
wire [63:0] s1;
kv_zero_ext #(
    .IW(DW),
    .OW(64)
) u_data_zext (
    .in(i_data),
    .out(s0)
);
assign o_data[(DW - 1):0] = s1[(DW - 1):0];
generate
    if (DW > 32) begin:gen_eccdec64
        kv_eccdec64 u_eccdec64(
            .data(s0),
            .parin(i_par),
            .check_en(i_valid),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s1),
            .parout(o_par),
            .sec(o_ecc_corr),
            .ded(o_ecc_uncorr),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
    end
    else begin:gen_eccdec32
        kv_eccdec32 u_eccdec32(
            .data(s0[31:0]),
            .parin(i_par),
            .check_en(i_valid),
            .correct_1bit(1'b0),
            .report_1bit(1'b0),
            .report_2bit(1'b1),
            .dataout(s1[31:0]),
            .parout(o_par),
            .sec(o_ecc_corr),
            .ded(o_ecc_uncorr),
            .error(nds_unused_error),
            .invalidate(nds_unused_invalidate),
            .replay(nds_unused_replay),
            .xcpt(nds_unused_xcpt)
        );
        assign s1[63:32] = 32'b0;
    end
endgenerate
endmodule

