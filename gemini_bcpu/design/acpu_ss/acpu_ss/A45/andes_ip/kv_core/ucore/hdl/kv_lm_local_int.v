// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_local_int (
    core_clk,
    core_reset_n,
    lm_clk,
    lm_reset_n,
    ilm_async_write_error,
    dlm0_async_write_error,
    dlm1_async_write_error,
    dlm2_async_write_error,
    dlm3_async_write_error,
    slvp_async_ecc_corr,
    slvp_async_ecc_ramid,
    slvp_async_local_int,
    lm_async_write_error,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    slvp_ipipe_local_int,
    lm_local_int
);
parameter SLAVE_PORT_SUPPORT = 0;
input core_clk;
input core_reset_n;
input lm_clk;
input lm_reset_n;
input ilm_async_write_error;
input dlm0_async_write_error;
input dlm1_async_write_error;
input dlm2_async_write_error;
input dlm3_async_write_error;
input slvp_async_ecc_corr;
input [3:0] slvp_async_ecc_ramid;
input slvp_async_local_int;
output lm_async_write_error;
output slvp_ipipe_ecc_corr;
output [3:0] slvp_ipipe_ecc_ramid;
output slvp_ipipe_local_int;
output lm_local_int;


reg s0;
wire s1;
reg s2;
wire s3 = ilm_async_write_error | dlm0_async_write_error | dlm1_async_write_error | dlm2_async_write_error | dlm3_async_write_error;
always @(posedge lm_clk or negedge lm_reset_n) begin
    if (!lm_reset_n) begin
        s0 <= 1'b0;
    end
    else begin
        s0 <= s1;
    end
end

always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s2 <= 1'b0;
    end
    else begin
        s2 <= s0;
    end
end

assign s1 = s3 | (s0 & ~s2);
assign lm_async_write_error = s0 & ~s2;
generate
    if (SLAVE_PORT_SUPPORT == 1) begin:gen_slvp_local_int
        reg s4;
        reg [3:0] s5;
        reg s6;
        wire s7;
        wire [3:0] s8;
        wire s9;
        reg s10;
        wire s11 = slvp_async_ecc_corr;
        wire [3:0] s12 = slvp_async_ecc_ramid;
        wire s13 = slvp_async_local_int;
        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s6 <= 1'b0;
            end
            else begin
                s6 <= s9;
            end
        end

        always @(posedge lm_clk or negedge lm_reset_n) begin
            if (!lm_reset_n) begin
                s4 <= 1'b0;
                s5 <= 4'b0;
            end
            else if (s13) begin
                s4 <= s7;
                s5 <= s8;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s10 <= 1'b0;
            end
            else begin
                s10 <= s6;
            end
        end

        assign s7 = s11;
        assign s8 = s12;
        assign s9 = s13 | (s6 & ~s10);
        assign slvp_ipipe_ecc_corr = s4;
        assign slvp_ipipe_ecc_ramid = s5;
        assign slvp_ipipe_local_int = s6 & ~s10;
        assign lm_local_int = s0 | slvp_ipipe_local_int;
    end
    else begin:gen_slvp_no_local_int
        assign lm_local_int = s0;
        wire nds_unused_slvp_async_ecc_corr = slvp_async_ecc_corr;
        wire [3:0] nds_unused_slvp_async_ecc_ramid = slvp_async_ecc_ramid;
        wire nds_unused_slvp_async_local_int = slvp_async_local_int;
        assign slvp_ipipe_ecc_corr = 1'b0;
        assign slvp_ipipe_ecc_ramid = 4'b0;
        assign slvp_ipipe_local_int = 1'b0;
    end
endgenerate
endmodule

