// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_core_brg (
    core_clk,
    dcu_clk,
    core_reset_n,
    l2_clk,
    l2_reset_n,
    dcu_a_opcode,
    dcu_a_param,
    dcu_a_user,
    dcu_a_size,
    dcu_a_source,
    dcu_a_address,
    dcu_a_data,
    dcu_a_mask,
    dcu_a_corrupt,
    dcu_a_valid,
    dcu_a_ready,
    dcu_b_opcode,
    dcu_b_param,
    dcu_b_size,
    dcu_b_source,
    dcu_b_address,
    dcu_b_data,
    dcu_b_mask,
    dcu_b_corrupt,
    dcu_b_valid,
    dcu_b_ready,
    dcu_c_opcode,
    dcu_c_param,
    dcu_c_size,
    dcu_c_user,
    dcu_c_source,
    dcu_c_address,
    dcu_c_data,
    dcu_c_corrupt,
    dcu_c_valid,
    dcu_c_ready,
    dcu_d_opcode,
    dcu_d_param,
    dcu_d_user,
    dcu_d_size,
    dcu_d_source,
    dcu_d_data,
    dcu_d_denied,
    dcu_d_corrupt,
    dcu_d_sink,
    dcu_d_valid,
    dcu_d_ready,
    dcu_e_valid,
    dcu_e_sink,
    dcu_e_ready,
    lsu_a_opcode,
    lsu_a_param,
    lsu_a_user,
    lsu_a_size,
    lsu_a_source,
    lsu_a_address,
    lsu_a_data,
    lsu_a_mask,
    lsu_a_corrupt,
    lsu_a_valid,
    lsu_a_ready,
    lsu_d_opcode,
    lsu_d_param,
    lsu_d_user,
    lsu_d_size,
    lsu_d_source,
    lsu_d_sink,
    lsu_d_data,
    lsu_d_denied,
    lsu_d_corrupt,
    lsu_d_valid,
    lsu_d_ready,
    icu_a_opcode,
    icu_a_param,
    icu_a_user,
    icu_a_size,
    icu_a_source,
    icu_a_address,
    icu_a_data,
    icu_a_mask,
    icu_a_corrupt,
    icu_a_valid,
    icu_a_ready,
    icu_d_opcode,
    icu_d_param,
    icu_d_user,
    icu_d_size,
    icu_d_source,
    icu_d_sink,
    icu_d_data,
    icu_d_denied,
    icu_d_corrupt,
    icu_d_valid,
    icu_d_ready,
    m0_a_opcode,
    m0_a_param,
    m0_a_user,
    m0_a_size,
    m0_a_source,
    m0_a_address,
    m0_a_data,
    m0_a_mask,
    m0_a_corrupt,
    m0_a_valid,
    m0_a_ready,
    m0_b_opcode,
    m0_b_param,
    m0_b_size,
    m0_b_source,
    m0_b_address,
    m0_b_data,
    m0_b_mask,
    m0_b_corrupt,
    m0_b_valid,
    m0_b_ready,
    m0_c_opcode,
    m0_c_param,
    m0_c_size,
    m0_c_user,
    m0_c_source,
    m0_c_address,
    m0_c_data,
    m0_c_corrupt,
    m0_c_valid,
    m0_c_ready,
    m0_d_opcode,
    m0_d_param,
    m0_d_user,
    m0_d_size,
    m0_d_source,
    m0_d_data,
    m0_d_denied,
    m0_d_corrupt,
    m0_d_sink,
    m0_d_valid,
    m0_d_ready,
    m0_e_valid,
    m0_e_sink,
    m0_e_ready,
    m1_a_opcode,
    m1_a_param,
    m1_a_user,
    m1_a_size,
    m1_a_source,
    m1_a_address,
    m1_a_data,
    m1_a_mask,
    m1_a_corrupt,
    m1_a_valid,
    m1_a_ready,
    m1_d_opcode,
    m1_d_param,
    m1_d_user,
    m1_d_size,
    m1_d_source,
    m1_d_sink,
    m1_d_data,
    m1_d_denied,
    m1_d_corrupt,
    m1_d_valid,
    m1_d_ready,
    m2_a_opcode,
    m2_a_param,
    m2_a_user,
    m2_a_size,
    m2_a_source,
    m2_a_address,
    m2_a_data,
    m2_a_mask,
    m2_a_corrupt,
    m2_a_valid,
    m2_a_ready,
    m2_d_opcode,
    m2_d_param,
    m2_d_user,
    m2_d_size,
    m2_d_source,
    m2_d_sink,
    m2_d_data,
    m2_d_denied,
    m2_d_corrupt,
    m2_d_valid,
    m2_d_ready,
    core_coherent_enable_int,
    core_coherent_state_int,
    core_coherent_enable,
    core_coherent_state
);
parameter TL_SIZE_WIDTH = 3;
parameter TL_SINK_WIDTH = 2;
parameter L2_SOURCE_WIDTH = 3;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter CORE_BRG_REG = 0;
parameter CORE_BRG_ASYNC = 0;
parameter L2_CLK_SYNC_STAGE = 3;
parameter CORE_CLK_SYNC_STAGE = 3;
localparam ASYNC_DEPTH = 8;
localparam LSU_SOURCE_WIDTH = 1;
localparam ICU_SOURCE_WIDTH = 2;
localparam DCU_SOURCE_WIDTH = 3;
localparam DCU_D_USER_WIDTH = 6;
input core_clk;
input dcu_clk;
input core_reset_n;
input l2_clk;
input l2_reset_n;
input [2:0] dcu_a_opcode;
input [2:0] dcu_a_param;
input [11:0] dcu_a_user;
input [TL_SIZE_WIDTH - 1:0] dcu_a_size;
input [DCU_SOURCE_WIDTH - 1:0] dcu_a_source;
input [L2_ADDR_WIDTH - 1:0] dcu_a_address;
input [L2_DATA_WIDTH - 1:0] dcu_a_data;
input [(L2_DATA_WIDTH / 8) - 1:0] dcu_a_mask;
input dcu_a_corrupt;
input dcu_a_valid;
output dcu_a_ready;
output [2:0] dcu_b_opcode;
output [2:0] dcu_b_param;
output [2:0] dcu_b_size;
output [DCU_SOURCE_WIDTH - 1:0] dcu_b_source;
output [L2_ADDR_WIDTH - 1:0] dcu_b_address;
output [L2_DATA_WIDTH - 1:0] dcu_b_data;
output [(L2_DATA_WIDTH / 8) - 1:0] dcu_b_mask;
output dcu_b_corrupt;
output dcu_b_valid;
input dcu_b_ready;
input [2:0] dcu_c_opcode;
input [2:0] dcu_c_param;
input [2:0] dcu_c_size;
input [7:0] dcu_c_user;
input [DCU_SOURCE_WIDTH - 1:0] dcu_c_source;
input [L2_ADDR_WIDTH - 1:0] dcu_c_address;
input [L2_DATA_WIDTH - 1:0] dcu_c_data;
input dcu_c_corrupt;
input dcu_c_valid;
output dcu_c_ready;
output [2:0] dcu_d_opcode;
output [1:0] dcu_d_param;
output [5:0] dcu_d_user;
output [2:0] dcu_d_size;
output [DCU_SOURCE_WIDTH - 1:0] dcu_d_source;
output [L2_DATA_WIDTH - 1:0] dcu_d_data;
output dcu_d_denied;
output dcu_d_corrupt;
output [TL_SINK_WIDTH - 1:0] dcu_d_sink;
output dcu_d_valid;
input dcu_d_ready;
input dcu_e_valid;
input [TL_SINK_WIDTH - 1:0] dcu_e_sink;
output dcu_e_ready;
input [2:0] lsu_a_opcode;
input [2:0] lsu_a_param;
input [7:0] lsu_a_user;
input [TL_SIZE_WIDTH - 1:0] lsu_a_size;
input [LSU_SOURCE_WIDTH - 1:0] lsu_a_source;
input [L2_ADDR_WIDTH - 1:0] lsu_a_address;
input [L2_DATA_WIDTH - 1:0] lsu_a_data;
input [(L2_DATA_WIDTH / 8) - 1:0] lsu_a_mask;
input lsu_a_corrupt;
input lsu_a_valid;
output lsu_a_ready;
output [2:0] lsu_d_opcode;
output [1:0] lsu_d_param;
output [1:0] lsu_d_user;
output [TL_SIZE_WIDTH - 1:0] lsu_d_size;
output [LSU_SOURCE_WIDTH - 1:0] lsu_d_source;
output [TL_SINK_WIDTH - 1:0] lsu_d_sink;
output [L2_DATA_WIDTH - 1:0] lsu_d_data;
output lsu_d_denied;
output lsu_d_corrupt;
output lsu_d_valid;
input lsu_d_ready;
input [2:0] icu_a_opcode;
input [2:0] icu_a_param;
input [7:0] icu_a_user;
input [TL_SIZE_WIDTH - 1:0] icu_a_size;
input [ICU_SOURCE_WIDTH - 1:0] icu_a_source;
input [L2_ADDR_WIDTH - 1:0] icu_a_address;
input [L2_DATA_WIDTH - 1:0] icu_a_data;
input [(L2_DATA_WIDTH / 8) - 1:0] icu_a_mask;
input icu_a_corrupt;
input icu_a_valid;
output icu_a_ready;
output [2:0] icu_d_opcode;
output [1:0] icu_d_param;
output [1:0] icu_d_user;
output [TL_SIZE_WIDTH - 1:0] icu_d_size;
output [ICU_SOURCE_WIDTH - 1:0] icu_d_source;
output [TL_SINK_WIDTH - 1:0] icu_d_sink;
output [L2_DATA_WIDTH - 1:0] icu_d_data;
output icu_d_denied;
output icu_d_corrupt;
output icu_d_valid;
input icu_d_ready;
output [2:0] m0_a_opcode;
output [2:0] m0_a_param;
output [11:0] m0_a_user;
output [TL_SIZE_WIDTH - 1:0] m0_a_size;
output [L2_SOURCE_WIDTH - 1:0] m0_a_source;
output [L2_ADDR_WIDTH - 1:0] m0_a_address;
output [L2_DATA_WIDTH - 1:0] m0_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m0_a_mask;
output m0_a_corrupt;
output m0_a_valid;
input m0_a_ready;
input [2:0] m0_b_opcode;
input [2:0] m0_b_param;
input [2:0] m0_b_size;
input [L2_SOURCE_WIDTH - 1:0] m0_b_source;
input [L2_ADDR_WIDTH - 1:0] m0_b_address;
input [L2_DATA_WIDTH - 1:0] m0_b_data;
input [(L2_DATA_WIDTH / 8) - 1:0] m0_b_mask;
input m0_b_corrupt;
input m0_b_valid;
output m0_b_ready;
output [2:0] m0_c_opcode;
output [2:0] m0_c_param;
output [2:0] m0_c_size;
output [7:0] m0_c_user;
output [L2_SOURCE_WIDTH - 1:0] m0_c_source;
output [L2_ADDR_WIDTH - 1:0] m0_c_address;
output [L2_DATA_WIDTH - 1:0] m0_c_data;
output m0_c_corrupt;
output m0_c_valid;
input m0_c_ready;
input [2:0] m0_d_opcode;
input [1:0] m0_d_param;
input [5:0] m0_d_user;
input [2:0] m0_d_size;
input [L2_SOURCE_WIDTH - 1:0] m0_d_source;
input [L2_DATA_WIDTH - 1:0] m0_d_data;
input m0_d_denied;
input m0_d_corrupt;
input [TL_SINK_WIDTH - 1:0] m0_d_sink;
input m0_d_valid;
output m0_d_ready;
output m0_e_valid;
output [TL_SINK_WIDTH - 1:0] m0_e_sink;
input m0_e_ready;
output [2:0] m1_a_opcode;
output [2:0] m1_a_param;
output [11:0] m1_a_user;
output [TL_SIZE_WIDTH - 1:0] m1_a_size;
output [L2_SOURCE_WIDTH - 1:0] m1_a_source;
output [L2_ADDR_WIDTH - 1:0] m1_a_address;
output [L2_DATA_WIDTH - 1:0] m1_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m1_a_mask;
output m1_a_corrupt;
output m1_a_valid;
input m1_a_ready;
input [2:0] m1_d_opcode;
input [1:0] m1_d_param;
input [5:0] m1_d_user;
input [TL_SIZE_WIDTH - 1:0] m1_d_size;
input [L2_SOURCE_WIDTH - 1:0] m1_d_source;
input [TL_SINK_WIDTH - 1:0] m1_d_sink;
input [L2_DATA_WIDTH - 1:0] m1_d_data;
input m1_d_denied;
input m1_d_corrupt;
input m1_d_valid;
output m1_d_ready;
output [2:0] m2_a_opcode;
output [2:0] m2_a_param;
output [11:0] m2_a_user;
output [TL_SIZE_WIDTH - 1:0] m2_a_size;
output [L2_SOURCE_WIDTH - 1:0] m2_a_source;
output [L2_ADDR_WIDTH - 1:0] m2_a_address;
output [L2_DATA_WIDTH - 1:0] m2_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m2_a_mask;
output m2_a_corrupt;
output m2_a_valid;
input m2_a_ready;
input [2:0] m2_d_opcode;
input [1:0] m2_d_param;
input [5:0] m2_d_user;
input [TL_SIZE_WIDTH - 1:0] m2_d_size;
input [L2_SOURCE_WIDTH - 1:0] m2_d_source;
input [TL_SINK_WIDTH - 1:0] m2_d_sink;
input [L2_DATA_WIDTH - 1:0] m2_d_data;
input m2_d_denied;
input m2_d_corrupt;
input m2_d_valid;
output m2_d_ready;
input core_coherent_enable_int;
output core_coherent_state_int;
output core_coherent_enable;
input core_coherent_state;


wire l2_clk_en = 1'b1;
generate
    if (CORE_BRG_ASYNC != 0) begin:gen_coherent_async
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(2)
        ) u_coherent_enable_sync (
            .resetn(l2_reset_n),
            .clk(l2_clk),
            .d(core_coherent_enable_int),
            .q(core_coherent_enable)
        );
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(2)
        ) u_coherent_state_sync (
            .resetn(core_reset_n),
            .clk(core_clk),
            .d(core_coherent_state),
            .q(core_coherent_state_int)
        );
    end
    else if (CORE_BRG_REG != 0) begin:gen_coherent_reg
        reg core_coherent_enable_r;
        reg core_coherent_state_r;
        assign core_coherent_enable = core_coherent_enable_r;
        assign core_coherent_state_int = core_coherent_state_r;
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                core_coherent_enable_r <= 1'b0;
            end
            else begin
                core_coherent_enable_r <= core_coherent_enable_int;
            end
        end

        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                core_coherent_state_r <= 1'b0;
            end
            else begin
                core_coherent_state_r <= core_coherent_state;
            end
        end

    end
    else begin:gen_coherent
        assign core_coherent_enable = core_coherent_enable_int;
        assign core_coherent_state_int = core_coherent_state;
    end
endgenerate
assign m1_a_user[8 +:4] = 4'b0;
assign m2_a_user[8 +:4] = 4'b0;
generate
    if ((CORE_BRG_REG == 1) && (CORE_BRG_ASYNC == 1)) begin:gen_async_reg_out
        wire [2:0] ff_dcu_a_opcode;
        wire [2:0] ff_dcu_a_param;
        wire [11:0] ff_dcu_a_user;
        wire [TL_SIZE_WIDTH - 1:0] ff_dcu_a_size;
        wire [DCU_SOURCE_WIDTH - 1:0] ff_dcu_a_source;
        wire [L2_ADDR_WIDTH - 1:0] ff_dcu_a_address;
        wire [L2_DATA_WIDTH - 1:0] ff_dcu_a_data;
        wire [(L2_DATA_WIDTH / 8) - 1:0] ff_dcu_a_mask;
        wire ff_dcu_a_corrupt;
        wire ff_dcu_a_valid;
        wire ff_dcu_a_ready;
        wire [2:0] ff_dcu_b_opcode;
        wire [2:0] ff_dcu_b_param;
        wire [2:0] ff_dcu_b_size;
        wire [DCU_SOURCE_WIDTH - 1:0] ff_dcu_b_source;
        wire [L2_ADDR_WIDTH - 1:0] ff_dcu_b_address;
        wire [L2_DATA_WIDTH - 1:0] ff_dcu_b_data;
        wire [(L2_DATA_WIDTH / 8) - 1:0] ff_dcu_b_mask;
        wire ff_dcu_b_corrupt;
        wire ff_dcu_b_valid;
        wire ff_dcu_b_ready;
        wire [2:0] ff_dcu_c_opcode;
        wire [2:0] ff_dcu_c_param;
        wire [2:0] ff_dcu_c_size;
        wire [7:0] ff_dcu_c_user;
        wire [DCU_SOURCE_WIDTH - 1:0] ff_dcu_c_source;
        wire [L2_ADDR_WIDTH - 1:0] ff_dcu_c_address;
        wire [L2_DATA_WIDTH - 1:0] ff_dcu_c_data;
        wire ff_dcu_c_corrupt;
        wire ff_dcu_c_valid;
        wire ff_dcu_c_ready;
        wire [2:0] ff_dcu_d_opcode;
        wire [1:0] ff_dcu_d_param;
        wire [5:0] ff_dcu_d_user;
        wire [2:0] ff_dcu_d_size;
        wire [DCU_SOURCE_WIDTH - 1:0] ff_dcu_d_source;
        wire [L2_DATA_WIDTH - 1:0] ff_dcu_d_data;
        wire ff_dcu_d_denied;
        wire ff_dcu_d_corrupt;
        wire [TL_SINK_WIDTH - 1:0] ff_dcu_d_sink;
        wire ff_dcu_d_valid;
        wire ff_dcu_d_ready;
        wire ff_dcu_e_valid;
        wire [TL_SINK_WIDTH - 1:0] ff_dcu_e_sink;
        wire ff_dcu_e_ready;
        wire [2:0] ff_lsu_a_opcode;
        wire [2:0] ff_lsu_a_param;
        wire [7:0] ff_lsu_a_user;
        wire [TL_SIZE_WIDTH - 1:0] ff_lsu_a_size;
        wire [LSU_SOURCE_WIDTH - 1:0] ff_lsu_a_source;
        wire [L2_ADDR_WIDTH - 1:0] ff_lsu_a_address;
        wire [L2_DATA_WIDTH - 1:0] ff_lsu_a_data;
        wire [(L2_DATA_WIDTH / 8) - 1:0] ff_lsu_a_mask;
        wire ff_lsu_a_corrupt;
        wire ff_lsu_a_valid;
        wire ff_lsu_a_ready;
        wire [2:0] ff_lsu_d_opcode;
        wire [1:0] ff_lsu_d_param;
        wire [1:0] ff_lsu_d_user;
        wire [TL_SIZE_WIDTH - 1:0] ff_lsu_d_size;
        wire [LSU_SOURCE_WIDTH - 1:0] ff_lsu_d_source;
        wire [TL_SINK_WIDTH - 1:0] ff_lsu_d_sink;
        wire [L2_DATA_WIDTH - 1:0] ff_lsu_d_data;
        wire ff_lsu_d_denied;
        wire ff_lsu_d_corrupt;
        wire ff_lsu_d_valid;
        wire ff_lsu_d_ready;
        wire [2:0] ff_icu_a_opcode;
        wire [2:0] ff_icu_a_param;
        wire [7:0] ff_icu_a_user;
        wire [TL_SIZE_WIDTH - 1:0] ff_icu_a_size;
        wire [ICU_SOURCE_WIDTH - 1:0] ff_icu_a_source;
        wire [L2_ADDR_WIDTH - 1:0] ff_icu_a_address;
        wire [L2_DATA_WIDTH - 1:0] ff_icu_a_data;
        wire [(L2_DATA_WIDTH / 8) - 1:0] ff_icu_a_mask;
        wire ff_icu_a_corrupt;
        wire ff_icu_a_valid;
        wire ff_icu_a_ready;
        wire [2:0] ff_icu_d_opcode;
        wire [1:0] ff_icu_d_param;
        wire [1:0] ff_icu_d_user;
        wire [TL_SIZE_WIDTH - 1:0] ff_icu_d_size;
        wire [ICU_SOURCE_WIDTH - 1:0] ff_icu_d_source;
        wire [TL_SINK_WIDTH - 1:0] ff_icu_d_sink;
        wire [L2_DATA_WIDTH - 1:0] ff_icu_d_data;
        wire ff_icu_d_denied;
        wire ff_icu_d_corrupt;
        wire ff_icu_d_valid;
        wire ff_icu_d_ready;
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(18 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) ff_dcu_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_a_valid),
            .wready(dcu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(ff_dcu_a_valid),
            .rready(ff_dcu_a_ready),
            .wdata({dcu_a_opcode,dcu_a_param,dcu_a_user,dcu_a_size,dcu_a_address,dcu_a_data,dcu_a_mask,dcu_a_corrupt,dcu_a_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({ff_dcu_a_opcode,ff_dcu_a_param,ff_dcu_a_user,ff_dcu_a_size,ff_dcu_a_address,ff_dcu_a_data,ff_dcu_a_mask,ff_dcu_a_corrupt,ff_dcu_a_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(6 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) ff_dcu_b_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(ff_dcu_b_valid),
            .wready(ff_dcu_b_ready),
            .rclk(dcu_clk),
            .rreset_n(core_reset_n),
            .rvalid(dcu_b_valid),
            .rready(dcu_b_ready),
            .wdata({ff_dcu_b_opcode,ff_dcu_b_param,ff_dcu_b_size,ff_dcu_b_address,ff_dcu_b_data,ff_dcu_b_mask,ff_dcu_b_corrupt,ff_dcu_b_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({dcu_b_opcode,dcu_b_param,dcu_b_size,dcu_b_address,dcu_b_data,dcu_b_mask,dcu_b_corrupt,dcu_b_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(6 + TL_SIZE_WIDTH + 8 + L2_ADDR_WIDTH + L2_DATA_WIDTH + 1 + DCU_SOURCE_WIDTH)
        ) ff_dcu_c_fifo (
            .wclk(dcu_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_c_valid),
            .wready(dcu_c_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(ff_dcu_c_valid),
            .rready(ff_dcu_c_ready),
            .wdata({dcu_c_opcode,dcu_c_param,dcu_c_size,dcu_c_user,dcu_c_address,dcu_c_data,dcu_c_corrupt,dcu_c_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({ff_dcu_c_opcode,ff_dcu_c_param,ff_dcu_c_size,ff_dcu_c_user,ff_dcu_c_address,ff_dcu_c_data,ff_dcu_c_corrupt,ff_dcu_c_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 6 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + DCU_SOURCE_WIDTH)
        ) ff_dcu_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(ff_dcu_d_valid),
            .wready(ff_dcu_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(dcu_d_valid),
            .rready(dcu_d_ready),
            .wdata({ff_dcu_d_opcode,ff_dcu_d_param,ff_dcu_d_size,ff_dcu_d_user,ff_dcu_d_sink,ff_dcu_d_data,ff_dcu_d_denied,ff_dcu_d_corrupt,ff_dcu_d_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({dcu_d_opcode,dcu_d_param,dcu_d_size,dcu_d_user,dcu_d_sink,dcu_d_data,dcu_d_denied,dcu_d_corrupt,dcu_d_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(TL_SINK_WIDTH)
        ) ff_dcu_e_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_e_valid),
            .wready(dcu_e_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(ff_dcu_e_valid),
            .rready(ff_dcu_e_ready),
            .wdata(dcu_e_sink),
            .rdata(ff_dcu_e_sink)
        );
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + LSU_SOURCE_WIDTH)
        ) ff_lsu_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(lsu_a_valid),
            .wready(lsu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(ff_lsu_a_valid),
            .rready(ff_lsu_a_ready),
            .wdata({lsu_a_opcode,lsu_a_param,lsu_a_user,lsu_a_size,lsu_a_address,lsu_a_data,lsu_a_mask,lsu_a_corrupt,lsu_a_source[0 +:LSU_SOURCE_WIDTH]}),
            .rdata({ff_lsu_a_opcode,ff_lsu_a_param,ff_lsu_a_user,ff_lsu_a_size,ff_lsu_a_address,ff_lsu_a_data,ff_lsu_a_mask,ff_lsu_a_corrupt,ff_lsu_a_source[0 +:LSU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + LSU_SOURCE_WIDTH)
        ) ff_lsu_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(ff_lsu_d_valid),
            .wready(ff_lsu_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(lsu_d_valid),
            .rready(lsu_d_ready),
            .wdata({ff_lsu_d_opcode,ff_lsu_d_param,ff_lsu_d_size,ff_lsu_d_user,ff_lsu_d_sink,ff_lsu_d_data,ff_lsu_d_denied,ff_lsu_d_corrupt,ff_lsu_d_source[0 +:LSU_SOURCE_WIDTH]}),
            .rdata({lsu_d_opcode,lsu_d_param,lsu_d_size,lsu_d_user,lsu_d_sink,lsu_d_data,lsu_d_denied,lsu_d_corrupt,lsu_d_source[0 +:LSU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + ICU_SOURCE_WIDTH)
        ) ff_icu_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(icu_a_valid),
            .wready(icu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(ff_icu_a_valid),
            .rready(ff_icu_a_ready),
            .wdata({icu_a_opcode,icu_a_param,icu_a_user,icu_a_size,icu_a_address,icu_a_data,icu_a_mask,icu_a_corrupt,icu_a_source[0 +:ICU_SOURCE_WIDTH]}),
            .rdata({ff_icu_a_opcode,ff_icu_a_param,ff_icu_a_user,ff_icu_a_size,ff_icu_a_address,ff_icu_a_data,ff_icu_a_mask,ff_icu_a_corrupt,ff_icu_a_source[0 +:ICU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + ICU_SOURCE_WIDTH)
        ) ff_icu_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(ff_icu_d_valid),
            .wready(ff_icu_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(icu_d_valid),
            .rready(icu_d_ready),
            .wdata({ff_icu_d_opcode,ff_icu_d_param,ff_icu_d_size,ff_icu_d_user,ff_icu_d_sink,ff_icu_d_data,ff_icu_d_denied,ff_icu_d_corrupt,ff_icu_d_source[0 +:ICU_SOURCE_WIDTH]}),
            .rdata({icu_d_opcode,icu_d_param,icu_d_size,icu_d_user,icu_d_sink,icu_d_data,icu_d_denied,icu_d_corrupt,icu_d_source[0 +:ICU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(18 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_a_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(ff_dcu_a_valid),
            .i_ready(ff_dcu_a_ready),
            .o_valid(m0_a_valid),
            .o_ready(m0_a_ready),
            .din({ff_dcu_a_opcode,ff_dcu_a_param,ff_dcu_a_user,ff_dcu_a_size,ff_dcu_a_address,ff_dcu_a_data,ff_dcu_a_mask,ff_dcu_a_corrupt,ff_dcu_a_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({m0_a_opcode,m0_a_param,m0_a_user,m0_a_size,m0_a_address,m0_a_data,m0_a_mask,m0_a_corrupt,m0_a_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_i #(
            .DW(6 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_b_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(m0_b_valid),
            .i_ready(m0_b_ready),
            .o_valid(ff_dcu_b_valid),
            .o_ready(ff_dcu_b_ready),
            .din({m0_b_opcode,m0_b_param,m0_b_size,m0_b_address,m0_b_data,m0_b_mask,m0_b_corrupt,m0_b_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({ff_dcu_b_opcode,ff_dcu_b_param,ff_dcu_b_size,ff_dcu_b_address,ff_dcu_b_data,ff_dcu_b_mask,ff_dcu_b_corrupt,ff_dcu_b_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(6 + TL_SIZE_WIDTH + 8 + L2_ADDR_WIDTH + L2_DATA_WIDTH + 1 + DCU_SOURCE_WIDTH)
        ) m0_c_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(ff_dcu_c_valid),
            .i_ready(ff_dcu_c_ready),
            .o_valid(m0_c_valid),
            .o_ready(m0_c_ready),
            .din({ff_dcu_c_opcode,ff_dcu_c_param,ff_dcu_c_size,ff_dcu_c_user,ff_dcu_c_address,ff_dcu_c_data,ff_dcu_c_corrupt,ff_dcu_c_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({m0_c_opcode,m0_c_param,m0_c_size,m0_c_user,m0_c_address,m0_c_data,m0_c_corrupt,m0_c_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 6 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + DCU_SOURCE_WIDTH)
        ) m0_d_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(m0_d_valid),
            .i_ready(m0_d_ready),
            .o_valid(ff_dcu_d_valid),
            .o_ready(ff_dcu_d_ready),
            .din({m0_d_opcode,m0_d_param,m0_d_size,m0_d_user,m0_d_sink,m0_d_data,m0_d_denied,m0_d_corrupt,m0_d_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({ff_dcu_d_opcode,ff_dcu_d_param,ff_dcu_d_size,ff_dcu_d_user,ff_dcu_d_sink,ff_dcu_d_data,ff_dcu_d_denied,ff_dcu_d_corrupt,ff_dcu_d_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(TL_SINK_WIDTH)
        ) m0_e_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(ff_dcu_e_valid),
            .i_ready(ff_dcu_e_ready),
            .o_valid(m0_e_valid),
            .o_ready(m0_e_ready),
            .din(ff_dcu_e_sink),
            .dout(m0_e_sink)
        );
        kv_eb_full_o #(
            .DW(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + LSU_SOURCE_WIDTH)
        ) m1_a_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(ff_lsu_a_valid),
            .i_ready(ff_lsu_a_ready),
            .o_valid(m1_a_valid),
            .o_ready(m1_a_ready),
            .din({ff_lsu_a_opcode,ff_lsu_a_param,ff_lsu_a_user,ff_lsu_a_size,ff_lsu_a_address,ff_lsu_a_data,ff_lsu_a_mask,ff_lsu_a_corrupt,ff_lsu_a_source[0 +:LSU_SOURCE_WIDTH]}),
            .dout({m1_a_opcode,m1_a_param,m1_a_user[7:0],m1_a_size,m1_a_address,m1_a_data,m1_a_mask,m1_a_corrupt,m1_a_source[0 +:LSU_SOURCE_WIDTH]})
        );
        assign m1_a_source[L2_SOURCE_WIDTH - 1:LSU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - LSU_SOURCE_WIDTH){1'b0}};
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + LSU_SOURCE_WIDTH)
        ) m1_d_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(m1_d_valid),
            .i_ready(m1_d_ready),
            .o_valid(ff_lsu_d_valid),
            .o_ready(ff_lsu_d_ready),
            .din({m1_d_opcode,m1_d_param,m1_d_size,m1_d_user[1:0],m1_d_sink,m1_d_data,m1_d_denied,m1_d_corrupt,m1_d_source[0 +:LSU_SOURCE_WIDTH]}),
            .dout({ff_lsu_d_opcode,ff_lsu_d_param,ff_lsu_d_size,ff_lsu_d_user,ff_lsu_d_sink,ff_lsu_d_data,ff_lsu_d_denied,ff_lsu_d_corrupt,ff_lsu_d_source[0 +:LSU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + ICU_SOURCE_WIDTH)
        ) m2_a_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(ff_icu_a_valid),
            .i_ready(ff_icu_a_ready),
            .o_valid(m2_a_valid),
            .o_ready(m2_a_ready),
            .din({ff_icu_a_opcode,ff_icu_a_param,ff_icu_a_user,ff_icu_a_size,ff_icu_a_address,ff_icu_a_data,ff_icu_a_mask,ff_icu_a_corrupt,ff_icu_a_source[0 +:ICU_SOURCE_WIDTH]}),
            .dout({m2_a_opcode,m2_a_param,m2_a_user[7:0],m2_a_size,m2_a_address,m2_a_data,m2_a_mask,m2_a_corrupt,m2_a_source[0 +:ICU_SOURCE_WIDTH]})
        );
        assign m2_a_source[L2_SOURCE_WIDTH - 1:ICU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - ICU_SOURCE_WIDTH){1'b0}};
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + ICU_SOURCE_WIDTH)
        ) m2_d_buffer (
            .clk(l2_clk),
            .resetn(l2_reset_n),
            .clk_en(1'b1),
            .i_valid(m2_d_valid),
            .i_ready(m2_d_ready),
            .o_valid(ff_icu_d_valid),
            .o_ready(ff_icu_d_ready),
            .din({m2_d_opcode,m2_d_param,m2_d_size,m2_d_user[1:0],m2_d_sink,m2_d_data,m2_d_denied,m2_d_corrupt,m2_d_source[0 +:ICU_SOURCE_WIDTH]}),
            .dout({ff_icu_d_opcode,ff_icu_d_param,ff_icu_d_size,ff_icu_d_user,ff_icu_d_sink,ff_icu_d_data,ff_icu_d_denied,ff_icu_d_corrupt,ff_icu_d_source[0 +:ICU_SOURCE_WIDTH]})
        );
    end
    else if (!(CORE_BRG_REG == 1) && (CORE_BRG_ASYNC == 1)) begin:gen_async
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(18 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_a_valid),
            .wready(dcu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(m0_a_valid),
            .rready(m0_a_ready),
            .wdata({dcu_a_opcode,dcu_a_param,dcu_a_user,dcu_a_size,dcu_a_address,dcu_a_data,dcu_a_mask,dcu_a_corrupt,dcu_a_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({m0_a_opcode,m0_a_param,m0_a_user,m0_a_size,m0_a_address,m0_a_data,m0_a_mask,m0_a_corrupt,m0_a_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(6 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_b_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(m0_b_valid),
            .wready(m0_b_ready),
            .rclk(dcu_clk),
            .rreset_n(core_reset_n),
            .rvalid(dcu_b_valid),
            .rready(dcu_b_ready),
            .wdata({m0_b_opcode,m0_b_param,m0_b_size,m0_b_address,m0_b_data,m0_b_mask,m0_b_corrupt,m0_b_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({dcu_b_opcode,dcu_b_param,dcu_b_size,dcu_b_address,dcu_b_data,dcu_b_mask,dcu_b_corrupt,dcu_b_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(6 + TL_SIZE_WIDTH + 8 + L2_ADDR_WIDTH + L2_DATA_WIDTH + 1 + DCU_SOURCE_WIDTH)
        ) m0_c_fifo (
            .wclk(dcu_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_c_valid),
            .wready(dcu_c_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(m0_c_valid),
            .rready(m0_c_ready),
            .wdata({dcu_c_opcode,dcu_c_param,dcu_c_size,dcu_c_user,dcu_c_address,dcu_c_data,dcu_c_corrupt,dcu_c_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({m0_c_opcode,m0_c_param,m0_c_size,m0_c_user,m0_c_address,m0_c_data,m0_c_corrupt,m0_c_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 6 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + DCU_SOURCE_WIDTH)
        ) m0_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(m0_d_valid),
            .wready(m0_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(dcu_d_valid),
            .rready(dcu_d_ready),
            .wdata({m0_d_opcode,m0_d_param,m0_d_size,m0_d_user,m0_d_sink,m0_d_data,m0_d_denied,m0_d_corrupt,m0_d_source[0 +:DCU_SOURCE_WIDTH]}),
            .rdata({dcu_d_opcode,dcu_d_param,dcu_d_size,dcu_d_user,dcu_d_sink,dcu_d_data,dcu_d_denied,dcu_d_corrupt,dcu_d_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(TL_SINK_WIDTH)
        ) m0_e_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(dcu_e_valid),
            .wready(dcu_e_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(m0_e_valid),
            .rready(m0_e_ready),
            .wdata(dcu_e_sink),
            .rdata(m0_e_sink)
        );
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + LSU_SOURCE_WIDTH)
        ) m1_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(lsu_a_valid),
            .wready(lsu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(m1_a_valid),
            .rready(m1_a_ready),
            .wdata({lsu_a_opcode,lsu_a_param,lsu_a_user,lsu_a_size,lsu_a_address,lsu_a_data,lsu_a_mask,lsu_a_corrupt,lsu_a_source[0 +:LSU_SOURCE_WIDTH]}),
            .rdata({m1_a_opcode,m1_a_param,m1_a_user[7:0],m1_a_size,m1_a_address,m1_a_data,m1_a_mask,m1_a_corrupt,m1_a_source[0 +:LSU_SOURCE_WIDTH]})
        );
        assign m1_a_source[L2_SOURCE_WIDTH - 1:LSU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - LSU_SOURCE_WIDTH){1'b0}};
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + LSU_SOURCE_WIDTH)
        ) m1_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(m1_d_valid),
            .wready(m1_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(lsu_d_valid),
            .rready(lsu_d_ready),
            .wdata({m1_d_opcode,m1_d_param,m1_d_size,m1_d_user[1:0],m1_d_sink,m1_d_data,m1_d_denied,m1_d_corrupt,m1_d_source[0 +:LSU_SOURCE_WIDTH]}),
            .rdata({lsu_d_opcode,lsu_d_param,lsu_d_size,lsu_d_user,lsu_d_sink,lsu_d_data,lsu_d_denied,lsu_d_corrupt,lsu_d_source[0 +:LSU_SOURCE_WIDTH]})
        );
        kv_async_fifo #(
            .DEPTH(2),
            .WCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .WIDTH(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + ICU_SOURCE_WIDTH)
        ) m2_a_fifo (
            .wclk(core_clk),
            .wreset_n(core_reset_n),
            .wvalid(icu_a_valid),
            .wready(icu_a_ready),
            .rclk(l2_clk),
            .rreset_n(l2_reset_n),
            .rvalid(m2_a_valid),
            .rready(m2_a_ready),
            .wdata({icu_a_opcode,icu_a_param,icu_a_user,icu_a_size,icu_a_address,icu_a_data,icu_a_mask,icu_a_corrupt,icu_a_source[0 +:ICU_SOURCE_WIDTH]}),
            .rdata({m2_a_opcode,m2_a_param,m2_a_user[7:0],m2_a_size,m2_a_address,m2_a_data,m2_a_mask,m2_a_corrupt,m2_a_source[0 +:ICU_SOURCE_WIDTH]})
        );
        assign m2_a_source[L2_SOURCE_WIDTH - 1:ICU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - ICU_SOURCE_WIDTH){1'b0}};
        kv_async_fifo #(
            .DEPTH(ASYNC_DEPTH),
            .WCLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .RCLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .WIDTH(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + ICU_SOURCE_WIDTH)
        ) m2_d_fifo (
            .wclk(l2_clk),
            .wreset_n(l2_reset_n),
            .wvalid(m2_d_valid),
            .wready(m2_d_ready),
            .rclk(core_clk),
            .rreset_n(core_reset_n),
            .rvalid(icu_d_valid),
            .rready(icu_d_ready),
            .wdata({m2_d_opcode,m2_d_param,m2_d_size,m2_d_user,m2_d_sink,m2_d_data,m2_d_denied,m2_d_corrupt,m2_d_source[0 +:ICU_SOURCE_WIDTH]}),
            .rdata({icu_d_opcode,icu_d_param,icu_d_size,icu_d_user[1:0],icu_d_sink,icu_d_data,icu_d_denied,icu_d_corrupt,icu_d_source})
        );
    end
    else if ((CORE_BRG_REG == 1) && !(CORE_BRG_ASYNC == 1)) begin:gen_sync_reg_out
        kv_eb_full_o #(
            .DW(18 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_a_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(dcu_a_valid),
            .i_ready(dcu_a_ready),
            .o_valid(m0_a_valid),
            .o_ready(m0_a_ready),
            .din({dcu_a_opcode,dcu_a_param,dcu_a_user,dcu_a_size,dcu_a_address,dcu_a_data,dcu_a_mask,dcu_a_corrupt,dcu_a_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({m0_a_opcode,m0_a_param,m0_a_user,m0_a_size,m0_a_address,m0_a_data,m0_a_mask,m0_a_corrupt,m0_a_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_i #(
            .DW(6 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + DCU_SOURCE_WIDTH)
        ) m0_b_buffer (
            .clk(dcu_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(m0_b_valid),
            .i_ready(m0_b_ready),
            .o_valid(dcu_b_valid),
            .o_ready(dcu_b_ready),
            .din({m0_b_opcode,m0_b_param,m0_b_size,m0_b_address,m0_b_data,m0_b_mask,m0_b_corrupt,m0_b_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({dcu_b_opcode,dcu_b_param,dcu_b_size,dcu_b_address,dcu_b_data,dcu_b_mask,dcu_b_corrupt,dcu_b_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(6 + TL_SIZE_WIDTH + 8 + L2_ADDR_WIDTH + L2_DATA_WIDTH + 1 + DCU_SOURCE_WIDTH)
        ) m0_c_buffer (
            .clk(dcu_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(dcu_c_valid),
            .i_ready(dcu_c_ready),
            .o_valid(m0_c_valid),
            .o_ready(m0_c_ready),
            .din({dcu_c_opcode,dcu_c_param,dcu_c_size,dcu_c_user,dcu_c_address,dcu_c_data,dcu_c_corrupt,dcu_c_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({m0_c_opcode,m0_c_param,m0_c_size,m0_c_user,m0_c_address,m0_c_data,m0_c_corrupt,m0_c_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 6 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + DCU_SOURCE_WIDTH)
        ) m0_d_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(m0_d_valid),
            .i_ready(m0_d_ready),
            .o_valid(dcu_d_valid),
            .o_ready(dcu_d_ready),
            .din({m0_d_opcode,m0_d_param,m0_d_size,m0_d_user,m0_d_sink,m0_d_data,m0_d_denied,m0_d_corrupt,m0_d_source[0 +:DCU_SOURCE_WIDTH]}),
            .dout({dcu_d_opcode,dcu_d_param,dcu_d_size,dcu_d_user,dcu_d_sink,dcu_d_data,dcu_d_denied,dcu_d_corrupt,dcu_d_source[0 +:DCU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(TL_SINK_WIDTH)
        ) m0_e_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(dcu_e_valid),
            .i_ready(dcu_e_ready),
            .o_valid(m0_e_valid),
            .o_ready(m0_e_ready),
            .din(dcu_e_sink),
            .dout(m0_e_sink)
        );
        kv_eb_full_o #(
            .DW(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + LSU_SOURCE_WIDTH)
        ) m1_a_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(lsu_a_valid),
            .i_ready(lsu_a_ready),
            .o_valid(m1_a_valid),
            .o_ready(m1_a_ready),
            .din({lsu_a_opcode,lsu_a_param,lsu_a_user,lsu_a_size,lsu_a_address,lsu_a_data,lsu_a_mask,lsu_a_corrupt,lsu_a_source[0 +:LSU_SOURCE_WIDTH]}),
            .dout({m1_a_opcode,m1_a_param,m1_a_user[7:0],m1_a_size,m1_a_address,m1_a_data,m1_a_mask,m1_a_corrupt,m1_a_source[0 +:LSU_SOURCE_WIDTH]})
        );
        assign m1_a_source[L2_SOURCE_WIDTH - 1:LSU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - LSU_SOURCE_WIDTH){1'b0}};
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + LSU_SOURCE_WIDTH)
        ) m1_d_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(m1_d_valid),
            .i_ready(m1_d_ready),
            .o_valid(lsu_d_valid),
            .o_ready(lsu_d_ready),
            .din({m1_d_opcode,m1_d_param,m1_d_size,m1_d_user[1:0],m1_d_sink,m1_d_data,m1_d_denied,m1_d_corrupt,m1_d_source[0 +:LSU_SOURCE_WIDTH]}),
            .dout({lsu_d_opcode,lsu_d_param,lsu_d_size,lsu_d_user,lsu_d_sink,lsu_d_data,lsu_d_denied,lsu_d_corrupt,lsu_d_source[0 +:LSU_SOURCE_WIDTH]})
        );
        kv_eb_full_o #(
            .DW(14 + TL_SIZE_WIDTH + L2_ADDR_WIDTH + L2_DATA_WIDTH + L2_DATA_WIDTH / 8 + 1 + ICU_SOURCE_WIDTH)
        ) m2_a_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(icu_a_valid),
            .i_ready(icu_a_ready),
            .o_valid(m2_a_valid),
            .o_ready(m2_a_ready),
            .din({icu_a_opcode,icu_a_param,icu_a_user,icu_a_size,icu_a_address,icu_a_data,icu_a_mask,icu_a_corrupt,icu_a_source[0 +:ICU_SOURCE_WIDTH]}),
            .dout({m2_a_opcode,m2_a_param,m2_a_user[7:0],m2_a_size,m2_a_address,m2_a_data,m2_a_mask,m2_a_corrupt,m2_a_source[0 +:ICU_SOURCE_WIDTH]})
        );
        assign m2_a_source[L2_SOURCE_WIDTH - 1:ICU_SOURCE_WIDTH] = {(L2_SOURCE_WIDTH - ICU_SOURCE_WIDTH){1'b0}};
        kv_eb_full_i #(
            .DW(5 + TL_SIZE_WIDTH + 2 + TL_SINK_WIDTH + L2_DATA_WIDTH + 1 + 1 + ICU_SOURCE_WIDTH)
        ) m2_d_buffer (
            .clk(core_clk),
            .resetn(core_reset_n),
            .clk_en(l2_clk_en),
            .i_valid(m2_d_valid),
            .i_ready(m2_d_ready),
            .o_valid(icu_d_valid),
            .o_ready(icu_d_ready),
            .din({m2_d_opcode,m2_d_param,m2_d_size,m2_d_user[1:0],m2_d_sink,m2_d_data,m2_d_denied,m2_d_corrupt,m2_d_source[0 +:ICU_SOURCE_WIDTH]}),
            .dout({icu_d_opcode,icu_d_param,icu_d_size,icu_d_user,icu_d_sink,icu_d_data,icu_d_denied,icu_d_corrupt,icu_d_source[0 +:ICU_SOURCE_WIDTH]})
        );
    end
    else if (!(CORE_BRG_REG == 1) && !(CORE_BRG_ASYNC == 1)) begin:gen_connection
        assign m0_a_opcode = dcu_a_opcode;
        assign m0_a_param = dcu_a_param;
        assign m0_a_user = dcu_a_user;
        assign m0_a_size = dcu_a_size;
        assign m0_a_address = dcu_a_address;
        assign m0_a_data = dcu_a_data;
        assign m0_a_mask = dcu_a_mask;
        assign m0_a_corrupt = dcu_a_corrupt;
        assign m0_a_valid = dcu_a_valid;
        assign dcu_a_ready = m0_a_ready;
        assign m0_b_ready = dcu_b_ready;
        assign dcu_b_valid = m0_b_valid;
        assign dcu_b_opcode = m0_b_opcode;
        assign dcu_b_param = m0_b_param;
        assign dcu_b_size = m0_b_size;
        assign dcu_b_address = m0_b_address;
        assign dcu_b_data = m0_b_data;
        assign dcu_b_mask = m0_b_mask;
        assign dcu_b_corrupt = m0_b_corrupt;
        assign m0_c_valid = dcu_c_valid;
        assign m0_c_opcode = dcu_c_opcode;
        assign m0_c_param = dcu_c_param;
        assign m0_c_size = dcu_c_size;
        assign m0_c_user = dcu_c_user;
        assign m0_c_address = dcu_c_address;
        assign m0_c_data = dcu_c_data;
        assign m0_c_corrupt = dcu_c_corrupt;
        assign dcu_c_ready = m0_c_ready;
        assign dcu_d_opcode = m0_d_opcode;
        assign dcu_d_param = m0_d_param;
        assign dcu_d_size = m0_d_size;
        assign dcu_d_user = m0_d_user;
        assign dcu_d_sink = m0_d_sink;
        assign dcu_d_data = m0_d_data;
        assign dcu_d_denied = m0_d_denied;
        assign dcu_d_corrupt = m0_d_corrupt;
        assign dcu_d_valid = m0_d_valid;
        assign m0_d_ready = dcu_d_ready;
        assign m0_e_sink = dcu_e_sink;
        assign m0_e_valid = dcu_e_valid;
        assign dcu_e_ready = m0_e_ready;
        kv_zero_ext #(
            .OW(L2_SOURCE_WIDTH),
            .IW(DCU_SOURCE_WIDTH)
        ) u_m0_a_source (
            .out(m0_a_source),
            .in(dcu_a_source)
        );
        kv_zero_ext #(
            .OW(L2_SOURCE_WIDTH),
            .IW(DCU_SOURCE_WIDTH)
        ) u_m0_c_source (
            .out(m0_c_source),
            .in(dcu_c_source)
        );
        assign dcu_b_source = m0_b_source[DCU_SOURCE_WIDTH - 1:0];
        assign dcu_d_source = m0_d_source[DCU_SOURCE_WIDTH - 1:0];
        assign m1_a_opcode = lsu_a_opcode;
        assign m1_a_param = lsu_a_param;
        assign m1_a_user[7:0] = lsu_a_user;
        assign m1_a_size = lsu_a_size;
        assign m1_a_address = lsu_a_address;
        assign m1_a_data = lsu_a_data;
        assign m1_a_mask = lsu_a_mask;
        assign m1_a_corrupt = lsu_a_corrupt;
        assign m1_a_valid = lsu_a_valid;
        assign lsu_a_ready = m1_a_ready;
        assign lsu_d_opcode = m1_d_opcode;
        assign lsu_d_param = m1_d_param;
        assign lsu_d_size = m1_d_size;
        assign lsu_d_user = m1_d_user[1:0];
        assign lsu_d_sink = m1_d_sink;
        assign lsu_d_data = m1_d_data;
        assign lsu_d_denied = m1_d_denied;
        assign lsu_d_corrupt = m1_d_corrupt;
        assign lsu_d_valid = m1_d_valid;
        assign m1_d_ready = lsu_d_ready;
        kv_zero_ext #(
            .OW(L2_SOURCE_WIDTH),
            .IW(LSU_SOURCE_WIDTH)
        ) u_m1_a_source (
            .out(m1_a_source),
            .in(lsu_a_source)
        );
        assign lsu_d_source = m1_d_source[LSU_SOURCE_WIDTH - 1:0];
        assign m2_a_opcode = icu_a_opcode;
        assign m2_a_param = icu_a_param;
        assign m2_a_user[7:0] = icu_a_user;
        assign m2_a_size = icu_a_size;
        assign m2_a_address = icu_a_address;
        assign m2_a_data = icu_a_data;
        assign m2_a_mask = icu_a_mask;
        assign m2_a_corrupt = icu_a_corrupt;
        assign m2_a_valid = icu_a_valid;
        assign icu_a_ready = m2_a_ready;
        assign icu_d_opcode = m2_d_opcode;
        assign icu_d_param = m2_d_param;
        assign icu_d_size = m2_d_size;
        assign icu_d_user = m2_d_user[1:0];
        assign icu_d_sink = m2_d_sink;
        assign icu_d_data = m2_d_data;
        assign icu_d_denied = m2_d_denied;
        assign icu_d_corrupt = m2_d_corrupt;
        assign icu_d_valid = m2_d_valid;
        assign m2_d_ready = icu_d_ready;
        kv_zero_ext #(
            .OW(L2_SOURCE_WIDTH),
            .IW(ICU_SOURCE_WIDTH)
        ) u_m2_a_source (
            .out(m2_a_source),
            .in(icu_a_source)
        );
        assign icu_d_source = m2_d_source[ICU_SOURCE_WIDTH - 1:0];
    end
endgenerate
endmodule

