// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_brg (
    lsbuf_a_opcode,
    lsbuf_a_param,
    lsbuf_a_user,
    lsbuf_a_size,
    lsbuf_a_address,
    lsbuf_a_source,
    lsbuf_a_data,
    lsbuf_a_mask,
    lsbuf_a_corrupt,
    lsbuf_a_valid,
    lsbuf_a_ready,
    lsbuf_d_opcode,
    lsbuf_d_param,
    lsbuf_d_user,
    lsbuf_d_size,
    lsbuf_d_source,
    lsbuf_d_sink,
    lsbuf_d_data,
    lsbuf_d_denied,
    lsbuf_d_corrupt,
    lsbuf_d_valid,
    lsbuf_d_ready,
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
    core_clk,
    core_reset_n
);
parameter PALEN = 32;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter TL_SINK_WIDTH = 2;
input [2:0] lsbuf_a_opcode;
input [2:0] lsbuf_a_param;
input [7:0] lsbuf_a_user;
input [2:0] lsbuf_a_size;
input [PALEN - 1:0] lsbuf_a_address;
input lsbuf_a_source;
input [31:0] lsbuf_a_data;
input [3:0] lsbuf_a_mask;
input lsbuf_a_corrupt;
input lsbuf_a_valid;
output lsbuf_a_ready;
output [2:0] lsbuf_d_opcode;
output [1:0] lsbuf_d_param;
output [1:0] lsbuf_d_user;
output [2:0] lsbuf_d_size;
output lsbuf_d_source;
output [TL_SINK_WIDTH - 1:0] lsbuf_d_sink;
output [31:0] lsbuf_d_data;
output lsbuf_d_denied;
output lsbuf_d_corrupt;
output lsbuf_d_valid;
input lsbuf_d_ready;
output [2:0] lsu_a_opcode;
output [2:0] lsu_a_param;
output [7:0] lsu_a_user;
output [2:0] lsu_a_size;
output lsu_a_source;
output [L2_ADDR_WIDTH - 1:0] lsu_a_address;
output [L2_DATA_WIDTH - 1:0] lsu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] lsu_a_mask;
output lsu_a_corrupt;
output lsu_a_valid;
input lsu_a_ready;
input [2:0] lsu_d_opcode;
input [1:0] lsu_d_param;
input [1:0] lsu_d_user;
input [2:0] lsu_d_size;
input lsu_d_source;
input [TL_SINK_WIDTH - 1:0] lsu_d_sink;
input [L2_DATA_WIDTH - 1:0] lsu_d_data;
input lsu_d_denied;
input lsu_d_corrupt;
input lsu_d_valid;
output lsu_d_ready;
input core_clk;
input core_reset_n;


generate
    if (32 < L2_DATA_WIDTH) begin:gen_sizeup
        kv_tlu_sizeup #(
            .AW(L2_ADDR_WIDTH),
            .US_DW(32),
            .DS_DW(L2_DATA_WIDTH),
            .OW(1),
            .IW(TL_SINK_WIDTH),
            .OST_GET_NUM(1),
            .A_UW(8),
            .D_UW(2)
        ) lsu_tlu_szup (
            .us_a_opcode(lsbuf_a_opcode),
            .us_a_param(lsbuf_a_param),
            .us_a_user(lsbuf_a_user),
            .us_a_size(lsbuf_a_size),
            .us_a_address(lsbuf_a_address),
            .us_a_data(lsbuf_a_data),
            .us_a_source(lsbuf_a_source),
            .us_a_mask(lsbuf_a_mask),
            .us_a_corrupt(lsbuf_a_corrupt),
            .us_a_valid(lsbuf_a_valid),
            .us_a_ready(lsbuf_a_ready),
            .us_d_opcode(lsbuf_d_opcode),
            .us_d_param(lsbuf_d_param),
            .us_d_user(lsbuf_d_user),
            .us_d_size(lsbuf_d_size),
            .us_d_source(lsbuf_d_source),
            .us_d_sink(lsbuf_d_sink),
            .us_d_data(lsbuf_d_data),
            .us_d_denied(lsbuf_d_denied),
            .us_d_corrupt(lsbuf_d_corrupt),
            .us_d_valid(lsbuf_d_valid),
            .us_d_ready(lsbuf_d_ready),
            .ds_a_opcode(lsu_a_opcode),
            .ds_a_param(lsu_a_param),
            .ds_a_user(lsu_a_user),
            .ds_a_size(lsu_a_size),
            .ds_a_address(lsu_a_address),
            .ds_a_data(lsu_a_data),
            .ds_a_source(lsu_a_source),
            .ds_a_mask(lsu_a_mask),
            .ds_a_corrupt(lsu_a_corrupt),
            .ds_a_valid(lsu_a_valid),
            .ds_a_ready(lsu_a_ready),
            .ds_d_opcode(lsu_d_opcode),
            .ds_d_param(lsu_d_param),
            .ds_d_user(lsu_d_user),
            .ds_d_size(lsu_d_size),
            .ds_d_data(lsu_d_data),
            .ds_d_source(lsu_d_source),
            .ds_d_sink(lsu_d_sink),
            .ds_d_denied(lsu_d_denied),
            .ds_d_corrupt(lsu_d_corrupt),
            .ds_d_valid(lsu_d_valid),
            .ds_d_ready(lsu_d_ready),
            .clk(core_clk),
            .resetn(core_reset_n)
        );
    end
    else begin:gen_sizeup_stub
        assign lsu_a_opcode = lsbuf_a_opcode;
        assign lsu_a_param = lsbuf_a_param;
        assign lsu_a_user = lsbuf_a_user;
        assign lsu_a_size = lsbuf_a_size;
        assign lsu_a_source = lsbuf_a_source;
        assign lsu_a_address = lsbuf_a_address;
        assign lsu_a_data = lsbuf_a_data;
        assign lsu_a_mask = lsbuf_a_mask;
        assign lsu_a_corrupt = lsbuf_a_corrupt;
        assign lsu_a_valid = lsbuf_a_valid;
        assign lsbuf_a_ready = lsu_a_ready;
        assign lsbuf_d_opcode = lsu_d_opcode;
        assign lsbuf_d_param = lsu_d_param;
        assign lsbuf_d_user = lsu_d_user;
        assign lsbuf_d_size = lsu_d_size;
        assign lsbuf_d_source = lsu_d_source;
        assign lsbuf_d_sink = lsu_d_sink;
        assign lsbuf_d_data = lsu_d_data;
        assign lsbuf_d_denied = lsu_d_denied;
        assign lsbuf_d_corrupt = lsu_d_corrupt;
        assign lsbuf_d_valid = lsu_d_valid;
        assign lsu_d_ready = lsbuf_d_ready;
        wire nds_unused_core_clk = core_clk;
        wire nds_unused_core_reset_n = core_reset_n;
    end
endgenerate
endmodule

