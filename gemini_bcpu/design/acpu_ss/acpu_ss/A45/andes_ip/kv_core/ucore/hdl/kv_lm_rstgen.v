// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lm_rstgen (
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


wire s0;
wire s1;
wire s2;
wire s3;
assign s0 = test_mode ? core_reset_n : (core_reset_n | slv_reset_n);
wire nds_unused_slv1_reset_n = slv1_reset_n;
generate
    if ((SLAVE_PORT_SUPPORT_INT == 1) && (SLAVE_PORT_ASYNC_SUPPORT == 1)) begin:gen_rst_async
        assign lm_reset_n = test_mode ? core_reset_n : s1;
        assign slv_reset_n_int = test_mode ? core_reset_n : s2;
        assign slv1_reset_n_int = test_mode ? core_reset_n : s3;
    end
    else if ((SLAVE_PORT_SUPPORT_INT == 1) && (SLAVE_PORT_ASYNC_SUPPORT == 0)) begin:gen_rst_sync
        assign lm_reset_n = test_mode ? core_reset_n : s1;
        assign slv_reset_n_int = test_mode ? core_reset_n : s1;
        assign slv1_reset_n_int = test_mode ? core_reset_n : s1;
        wire nds_unused_reset2slv_n = s2;
        wire nds_unused_reset2slv1_n = s3;
    end
    else begin:gen_rst_connection
        assign lm_reset_n = core_reset_n;
        assign slv_reset_n_int = 1'b0;
        assign slv1_reset_n_int = 1'b0;
        wire nds_unused_reset2lm_n = s1;
        wire nds_unused_reset2slv_n = s2;
        wire nds_unused_reset2slv1_n = s3;
    end
endgenerate
generate
    if (SLAVE_PORT_SUPPORT_INT == 1) begin:gen_rst2lm_syncer
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(SYNC_STAGE)
        ) u_lm_rst_sync (
            .resetn(s0),
            .clk(lm_clk),
            .d(1'b1),
            .q(s1)
        );
    end
    else begin:gen_rst2lm_no
        assign s1 = 1'b0;
        wire nds_unused_lm_clk = lm_clk;
        wire nds_unused_reset_n_src = s0;
    end
endgenerate
generate
    if ((SLAVE_PORT_SUPPORT_INT == 1) && (SLAVE_PORT_ASYNC_SUPPORT == 1)) begin:gen_rst2slv_syncer
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(SYNC_STAGE)
        ) u_slv_rst_sync (
            .resetn(s0),
            .clk(slv_clk),
            .d(1'b1),
            .q(s2)
        );
    end
    else begin:gen_rst2slv_no
        assign s2 = 1'b0;
        wire nds_unused_slv_clk = slv_clk;
    end
endgenerate
assign s3 = 1'b0;
wire nds_unused_slv1_clk = slv1_clk;
endmodule

