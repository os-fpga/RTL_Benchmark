// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_bpu_ras (
    core_clk,
    core_reset_n,
    reset_vector,
    redirect,
    redirect_ras_ptr,
    csr_mmisc_ctl_brpe,
    csr_halt_mode,
    ras_push,
    ras_push_priv,
    ras_pop,
    ras_push_addr,
    ras_pred_target,
    ras_pred_valid
);
parameter VALEN = 64;
parameter BTB_SIZE = 256;
parameter DEBUG_VEC = 64'h0000_0000;
parameter RAS_DEPTH = 4;
parameter RAS_PTR_MSB = 1;
parameter RAS_WRAP_NUM = 2'b11;
input core_clk;
input core_reset_n;
input [VALEN - 1:0] reset_vector;
input redirect;
input [RAS_PTR_MSB:0] redirect_ras_ptr;
input csr_mmisc_ctl_brpe;
input csr_halt_mode;
input ras_push;
input ras_pop;
input [VALEN - 1:0] ras_push_addr;
input ras_push_priv;
output [VALEN - 1:0] ras_pred_target;
output ras_pred_valid;


generate
    if (BTB_SIZE != 0) begin:gen_ras_yes
        reg [RAS_PTR_MSB:0] s0;
        reg [RAS_PTR_MSB:0] s1;
        wire [RAS_PTR_MSB:0] s2;
        wire [RAS_PTR_MSB:0] s3;
        wire [RAS_PTR_MSB:0] s4;
        wire [RAS_PTR_MSB:0] s5;
        wire [RAS_PTR_MSB:0] s6;
        wire [RAS_PTR_MSB:0] s7;
        wire [RAS_PTR_MSB:0] s8;
        reg [VALEN - 1:1] s9[0:RAS_DEPTH - 1];
        reg s10[0:RAS_DEPTH - 1];
        reg s11[0:RAS_DEPTH - 1];
        wire [VALEN - 1:1] s12;
        wire s13;
        wire s14;
        wire [RAS_PTR_MSB:0] s15 = {RAS_PTR_MSB + 1{1'b0}};
        wire [RAS_PTR_MSB:0] s16 = {{RAS_PTR_MSB{1'b0}},1'b1};
        reg s17;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s17 <= 1'b1;
            end
            else begin
                s17 <= 1'b0;
            end
        end

        assign s13 = redirect & ~csr_halt_mode & csr_mmisc_ctl_brpe;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s0 <= s15;
            end
            else if (s14) begin
                s0 <= s8;
            end
        end

        assign s14 = s13 | (ras_push ^ ras_pop);
        assign s3 = (s0 == s15) ? RAS_WRAP_NUM : s0 - s16;
        assign s4 = (s0 == RAS_WRAP_NUM) ? s15 : s0 + s16;
        assign s8 = s13 ? redirect_ras_ptr : ras_push ? s4 : s3;
        assign s7 = (redirect_ras_ptr == s15) ? RAS_WRAP_NUM : redirect_ras_ptr - s16;
        assign s5 = (s1 == s15) ? RAS_WRAP_NUM : s1 - s16;
        assign s6 = (s1 == RAS_WRAP_NUM) ? s15 : s1 + s16;
        assign s2 = s13 ? s7 : ras_push ? s6 : s5;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s1 <= s15;
            end
            else if (s14) begin
                s1 <= s2;
            end
        end

        integer s18;
        always @(posedge core_clk) begin
            if (s17) begin
                for (s18 = 0; s18 < RAS_DEPTH; s18 = s18 + 1) begin
                    s9[s18] <= reset_vector[(VALEN - 1):1];
                    s10[s18] <= 1'b0;
                    s11[s18] <= 1'b0;
                end
            end
            else if (ras_push & ras_pop) begin
                s9[s3] <= ras_push_addr[VALEN - 1:1];
                s10[s3] <= 1'b1;
                s11[s3] <= ras_push_priv;
            end
            else if (ras_push) begin
                s9[s0] <= ras_push_addr[VALEN - 1:1];
                s10[s0] <= 1'b1;
                s11[s0] <= ras_push_priv;
            end
        end

        assign s12 = s9[s1];
        assign ras_pred_target = {s12,1'b0};
        assign ras_pred_valid = s10[s1] & ~(s11[s1] ^ ras_push_priv);
    end
    else begin:gen_ras_else_case
        assign ras_pred_target = {(VALEN){1'b0}};
        assign ras_pred_valid = 1'b0;
    end
endgenerate
endmodule

