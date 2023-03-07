// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_fastmul_recode (
    mul_en,
    partial_y,
    mdu_signed_ex,
    mul_in0,
    mul_in0_neg,
    recode_pp
);
input mul_en;
input [2:0] partial_y;
input mdu_signed_ex;
input [31:0] mul_in0;
input [31:0] mul_in0_neg;
output [33:0] recode_pp;


wire s0;
reg [33:0] s1;
assign recode_pp = s1;
generate
    assign s0 = mdu_signed_ex & mul_in0[31];
    always @* begin
        if (mul_en) begin
            case (partial_y)
                3'b000: s1 = {1'b1,33'b0};
                3'b001: s1 = {~s0,s0,mul_in0};
                3'b010: s1 = {~s0,s0,mul_in0};
                3'b011: s1 = {~s0,mul_in0,1'b0};
                3'b100: s1 = {s0,mul_in0_neg,1'b1};
                3'b101: s1 = {s0,~s0,mul_in0_neg};
                3'b110: s1 = {s0,~s0,mul_in0_neg};
                3'b111: s1 = {1'b1,33'b0};
                default: s1 = 34'b0;
            endcase
        end
        else begin
            s1 = 34'b0;
        end
    end

endgenerate
endmodule

