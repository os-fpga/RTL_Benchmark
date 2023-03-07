// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_buf (
    core_clk,
    core_reset_n,
    lspipe_a_opcode,
    lspipe_a_param,
    lspipe_a_user,
    lspipe_a_size,
    lspipe_a_source,
    lspipe_a_address,
    lspipe_a_data,
    lspipe_a_mask,
    lspipe_a_corrupt,
    lspipe_a_valid,
    lspipe_a_ready,
    lspipe_d_opcode,
    lspipe_d_param,
    lspipe_d_user,
    lspipe_d_size,
    lspipe_d_source,
    lspipe_d_sink,
    lspipe_d_data,
    lspipe_d_denied,
    lspipe_d_corrupt,
    lspipe_d_valid,
    lspipe_d_ready,
    lsbuf_a_opcode,
    lsbuf_a_param,
    lsbuf_a_user,
    lsbuf_a_size,
    lsbuf_a_source,
    lsbuf_a_address,
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
    lsbuf_d_ready
);
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 64;
parameter NUM_BUF = 32;
parameter TL_SINK_WIDTH = 2;
localparam LINE_SIZE = 512;
input core_clk;
input core_reset_n;
input [(ADDR_WIDTH - 1):0] lspipe_a_address;
input lspipe_a_corrupt;
input [(DATA_WIDTH - 1):0] lspipe_a_data;
input [(DATA_WIDTH / 8) - 1:0] lspipe_a_mask;
input [2:0] lspipe_a_opcode;
input [2:0] lspipe_a_param;
output lspipe_a_ready;
input [2:0] lspipe_a_size;
input lspipe_a_source;
input [7:0] lspipe_a_user;
input lspipe_a_valid;
output lspipe_d_corrupt;
output [(DATA_WIDTH - 1):0] lspipe_d_data;
output lspipe_d_denied;
output [2:0] lspipe_d_opcode;
output [1:0] lspipe_d_param;
input lspipe_d_ready;
output [(TL_SINK_WIDTH - 1):0] lspipe_d_sink;
output [2:0] lspipe_d_size;
output lspipe_d_source;
output [1:0] lspipe_d_user;
output lspipe_d_valid;
output [(ADDR_WIDTH - 1):0] lsbuf_a_address;
output lsbuf_a_corrupt;
output [(DATA_WIDTH - 1):0] lsbuf_a_data;
output [(DATA_WIDTH / 8) - 1:0] lsbuf_a_mask;
output [2:0] lsbuf_a_opcode;
output [2:0] lsbuf_a_param;
input lsbuf_a_ready;
output [2:0] lsbuf_a_size;
output lsbuf_a_source;
output [7:0] lsbuf_a_user;
output lsbuf_a_valid;
input lsbuf_d_corrupt;
input [(DATA_WIDTH - 1):0] lsbuf_d_data;
input lsbuf_d_denied;
input [2:0] lsbuf_d_opcode;
input [1:0] lsbuf_d_param;
output lsbuf_d_ready;
input [(TL_SINK_WIDTH - 1):0] lsbuf_d_sink;
input [2:0] lsbuf_d_size;
input lsbuf_d_source;
input [1:0] lsbuf_d_user;
input lsbuf_d_valid;


generate
    if (NUM_BUF == 0) begin:gen_lsu_bypass
        assign lsbuf_a_address = lspipe_a_address;
        assign lsbuf_a_corrupt = lspipe_a_corrupt;
        assign lsbuf_a_data = lspipe_a_data;
        assign lsbuf_a_mask = lspipe_a_mask;
        assign lsbuf_a_opcode = lspipe_a_opcode;
        assign lsbuf_a_param = lspipe_a_param;
        assign lspipe_a_ready = lsbuf_a_ready;
        assign lsbuf_a_size = lspipe_a_size;
        assign lsbuf_a_source = lspipe_a_source;
        assign lsbuf_a_user = lspipe_a_user;
        assign lsbuf_a_valid = lspipe_a_valid;
        assign lspipe_d_corrupt = lsbuf_d_corrupt;
        assign lspipe_d_data = lsbuf_d_data;
        assign lspipe_d_denied = lsbuf_d_denied;
        assign lspipe_d_opcode = lsbuf_d_opcode;
        assign lspipe_d_param = lsbuf_d_param;
        assign lsbuf_d_ready = lspipe_d_ready;
        assign lspipe_d_sink = lsbuf_d_sink;
        assign lspipe_d_size = lsbuf_d_size;
        assign lspipe_d_source = lsbuf_d_source;
        assign lspipe_d_user = lsbuf_d_user;
        assign lspipe_d_valid = lsbuf_d_valid;
    end
    else begin:gen_lsu_buf
        assign lsbuf_a_address = lspipe_a_address;
        assign lsbuf_a_corrupt = lspipe_a_corrupt;
        assign lsbuf_a_data = lspipe_a_data;
        assign lsbuf_a_mask = lspipe_a_mask;
        assign lsbuf_a_opcode = lspipe_a_opcode;
        assign lsbuf_a_param = lspipe_a_param;
        assign lspipe_a_ready = lsbuf_a_ready;
        assign lsbuf_a_size = lspipe_a_size;
        assign lsbuf_a_source = lspipe_a_source;
        assign lsbuf_a_user = lspipe_a_user;
        assign lsbuf_a_valid = lspipe_a_valid;
        assign lspipe_d_corrupt = lsbuf_d_corrupt;
        assign lspipe_d_data = lsbuf_d_data;
        assign lspipe_d_denied = lsbuf_d_denied;
        assign lspipe_d_opcode = lsbuf_d_opcode;
        assign lspipe_d_param = lsbuf_d_param;
        assign lsbuf_d_ready = lspipe_d_ready;
        assign lspipe_d_sink = lsbuf_d_sink;
        assign lspipe_d_size = lsbuf_d_size;
        assign lspipe_d_source = lsbuf_d_source;
        assign lspipe_d_user = lsbuf_d_user;
        assign lspipe_d_valid = lsbuf_d_valid;
    end
endgenerate
endmodule

