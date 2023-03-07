// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_rstgen_stub (
    core_reset_n,
    slv_reset_n,
    slv1_reset_n,
    lm_clk,
    slv_clk,
    slv1_clk,
    test_mode,
    lm_reset_n,
    slv_reset_n_int,
    slv1_reset_n_int
);
parameter SLAVE_PORT_SUPPORT_INT = 1;
parameter SLAVE_PORT_ASYNC_SUPPORT = 1;
parameter SLAVE_PORT_SOURCE_NUM = 1;
localparam SYNC_STAGE = 2;
input core_reset_n;
input slv_reset_n;
input slv1_reset_n;
input lm_clk;
input slv_clk;
input slv1_clk;
input test_mode;
output lm_reset_n;
output slv_reset_n_int;
output slv1_reset_n_int;


wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_slv_reset_n = slv_reset_n;
wire nds_unused_slv1_reset_n = slv1_reset_n;
wire nds_unused_lm_clk = lm_clk;
wire nds_unused_slv_clk = slv_clk;
wire nds_unused_slv1_clk = slv1_clk;
wire nds_unused_test_mode = test_mode;
assign lm_reset_n = 1'b0;
assign slv_reset_n_int = 1'b0;
assign slv1_reset_n_int = 1'b0;
endmodule

