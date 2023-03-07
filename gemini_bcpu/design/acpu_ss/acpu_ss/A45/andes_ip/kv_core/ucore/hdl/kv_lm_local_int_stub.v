// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_local_int_stub (
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


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_lm_reset_n = lm_reset_n;
wire nds_unused_ilm_async_write_error = ilm_async_write_error;
wire nds_unused_dlm0_async_write_error = dlm0_async_write_error;
wire nds_unused_dlm1_async_write_error = dlm1_async_write_error;
wire nds_unused_dlm2_async_write_error = dlm2_async_write_error;
wire nds_unused_dlm3_async_write_error = dlm3_async_write_error;
wire nds_unused_slvp_async_ecc_corr = slvp_async_ecc_corr;
wire [3:0] nds_unused_slvp_async_ecc_ramid = slvp_async_ecc_ramid;
wire nds_unused_slvp_async_local_int = slvp_async_local_int;
assign lm_async_write_error = 1'b0;
assign slvp_ipipe_ecc_corr = 1'b0;
assign slvp_ipipe_ecc_ramid = 4'b0;
assign slvp_ipipe_local_int = 1'b0;
assign lm_local_int = 1'b0;
endmodule

