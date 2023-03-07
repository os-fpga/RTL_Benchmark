// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_agu (
    ag_op0,
    ag_op1,
    ag_result,
    hit_ilm,
    hit_dlm
);
parameter OP0LEN = 32;
parameter VALEN = 32;
parameter EXTVALEN = 32;
parameter ILM_SIZE_KB = 8;
parameter ILM_BASE = 64'h1000_0000;
parameter ILM_AMSB = 15;
parameter DLM_SIZE_KB = 8;
parameter DLM_BASE = 64'h2000_0000;
parameter DLM_AMSB = 15;
input [OP0LEN - 1:0] ag_op0;
input [20:0] ag_op1;
output [EXTVALEN - 1:0] ag_result;
output hit_ilm;
output hit_dlm;


wire [EXTVALEN - 1:0] s0;
wire [EXTVALEN - 1:0] s1;
kv_sign_ext #(
    .OW(EXTVALEN),
    .IW(21)
) u_ag_op1_se (
    .out(s0),
    .in(ag_op1)
);
assign s1 = ag_op0[EXTVALEN - 1:0] + s0;
assign ag_result[VALEN - 1:0] = s1[VALEN - 1:0];
generate
    if ((EXTVALEN > VALEN) && (OP0LEN > EXTVALEN)) begin:gen_ag_result_extmsb
        assign ag_result[EXTVALEN - 1] = ((&ag_op0[OP0LEN - 1:VALEN]) | (~|ag_op0[OP0LEN - 1:VALEN])) ? s1[VALEN] : ~s1[VALEN - 1];
    end
    else if (EXTVALEN > VALEN) begin:gen_ag_result_extmsb_una
        assign ag_result[EXTVALEN - 1] = s1[VALEN];
    end
endgenerate
generate
    if (ILM_SIZE_KB != 0) begin:gen_hit_ilm_cmp
        wire [VALEN - 1:ILM_AMSB + 1] s2 = ILM_BASE[VALEN - 1:ILM_AMSB + 1];
        kv_fasthit #(
            .M(VALEN),
            .N(ILM_AMSB + 1)
        ) u_ilm_match (
            .a(ag_op0[VALEN - 1:0]),
            .b(s0[VALEN - 1:0]),
            .k(s2[VALEN - 1:ILM_AMSB + 1]),
            .hit(hit_ilm)
        );
    end
    else begin:gen_hit_ilm_never
        assign hit_ilm = 1'b0;
    end
endgenerate
generate
    if (DLM_SIZE_KB != 0) begin:gen_hit_dlm_cmp
        wire [VALEN - 1:DLM_AMSB + 1] s3 = DLM_BASE[VALEN - 1:DLM_AMSB + 1];
        kv_fasthit #(
            .M(VALEN),
            .N(DLM_AMSB + 1)
        ) u_dlm_match (
            .a(ag_op0[VALEN - 1:0]),
            .b(s0[VALEN - 1:0]),
            .k(s3),
            .hit(hit_dlm)
        );
    end
    else begin:gen_hit_dlm_never
        assign hit_dlm = 1'b0;
    end
endgenerate
endmodule

