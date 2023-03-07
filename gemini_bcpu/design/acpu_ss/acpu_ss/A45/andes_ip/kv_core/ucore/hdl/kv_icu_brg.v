// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_icu_brg (
    agent_a_opcode,
    agent_a_param,
    agent_a_user,
    agent_a_size,
    agent_a_address,
    agent_a_source,
    agent_a_data,
    agent_a_mask,
    agent_a_corrupt,
    agent_a_valid,
    agent_a_ready,
    agent_d_opcode,
    agent_d_param,
    agent_d_user,
    agent_d_size,
    agent_d_source,
    agent_d_sink,
    agent_d_data,
    agent_d_denied,
    agent_d_corrupt,
    agent_d_valid,
    agent_d_ready,
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
    core_clk,
    core_reset_n
);
parameter PALEN = 32;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 64;
parameter ICU_DATA_WIDTH = 256;
parameter TL_SIZE_WIDTH = 3;
parameter ICU_SOURCE_WIDTH = 2;
parameter TL_SINK_WIDTH = 2;
input [2:0] agent_a_opcode;
input [2:0] agent_a_param;
input [7:0] agent_a_user;
input [TL_SIZE_WIDTH - 1:0] agent_a_size;
input [PALEN - 1:0] agent_a_address;
input [ICU_SOURCE_WIDTH - 1:0] agent_a_source;
input [ICU_DATA_WIDTH - 1:0] agent_a_data;
input [(ICU_DATA_WIDTH / 8) - 1:0] agent_a_mask;
input agent_a_corrupt;
input agent_a_valid;
output agent_a_ready;
output [2:0] agent_d_opcode;
output [1:0] agent_d_param;
output [1:0] agent_d_user;
output [TL_SIZE_WIDTH - 1:0] agent_d_size;
output [ICU_SOURCE_WIDTH - 1:0] agent_d_source;
output [TL_SINK_WIDTH - 1:0] agent_d_sink;
output [ICU_DATA_WIDTH - 1:0] agent_d_data;
output agent_d_denied;
output agent_d_corrupt;
output agent_d_valid;
input agent_d_ready;
output [2:0] icu_a_opcode;
output [2:0] icu_a_param;
output [7:0] icu_a_user;
output [TL_SIZE_WIDTH - 1:0] icu_a_size;
output [ICU_SOURCE_WIDTH - 1:0] icu_a_source;
output [L2_ADDR_WIDTH - 1:0] icu_a_address;
output [L2_DATA_WIDTH - 1:0] icu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] icu_a_mask;
output icu_a_corrupt;
output icu_a_valid;
input icu_a_ready;
input [2:0] icu_d_opcode;
input [1:0] icu_d_param;
input [1:0] icu_d_user;
input [TL_SIZE_WIDTH - 1:0] icu_d_size;
input [ICU_SOURCE_WIDTH - 1:0] icu_d_source;
input [TL_SINK_WIDTH - 1:0] icu_d_sink;
input [L2_DATA_WIDTH - 1:0] icu_d_data;
input icu_d_denied;
input icu_d_corrupt;
input icu_d_valid;
output icu_d_ready;
input core_clk;
input core_reset_n;


generate
    if (L2_DATA_WIDTH == 256) begin:gen_icu_brg_stub
        assign icu_a_opcode = agent_a_opcode;
        assign icu_a_param = agent_a_param;
        assign icu_a_user = agent_a_user;
        assign icu_a_size = agent_a_size;
        assign icu_a_source = agent_a_source;
        assign icu_a_address = agent_a_address;
        assign icu_a_data = agent_a_data;
        assign icu_a_mask = agent_a_mask;
        assign icu_a_corrupt = agent_a_corrupt;
        assign icu_a_valid = agent_a_valid;
        assign agent_a_ready = icu_a_ready;
        assign agent_d_opcode = icu_d_opcode;
        assign agent_d_param = icu_d_param;
        assign agent_d_user = icu_d_user;
        assign agent_d_size = icu_d_size;
        assign agent_d_source = icu_d_source;
        assign agent_d_sink = icu_d_sink;
        assign agent_d_data = icu_d_data;
        assign agent_d_denied = icu_d_denied;
        assign agent_d_corrupt = icu_d_corrupt;
        assign agent_d_valid = icu_d_valid;
        assign icu_d_ready = agent_d_ready;
    end
    else begin:gen_icu_brg
        wire [2:0] nds_unused_us_b_opcode;
        wire [2:0] nds_unused_us_b_param;
        wire [2:0] nds_unused_us_b_size;
        wire [ICU_SOURCE_WIDTH - 1:0] s0;
        wire [1:0] nds_unused_us_b_user;
        wire [ICU_DATA_WIDTH - 1:0] s1;
        wire [(ICU_DATA_WIDTH / 8) - 1:0] s2;
        wire nds_unused_us_b_corrupt;
        wire [L2_ADDR_WIDTH - 1:0] s3;
        wire nds_unused_us_b_valid;
        wire nds_unused_us_c_ready;
        wire nds_unused_us_e_ready;
        wire nds_unused_ds_b_ready;
        wire nds_unused_ds_c_valid;
        wire [2:0] nds_unused_ds_c_opcode;
        wire [2:0] nds_unused_ds_c_param;
        wire [2:0] nds_unused_ds_c_size;
        wire [ICU_SOURCE_WIDTH - 1:0] s4;
        wire [L2_ADDR_WIDTH - 1:0] s5;
        wire [1:0] nds_unused_ds_c_user;
        wire [L2_DATA_WIDTH - 1:0] s6;
        wire nds_unused_ds_c_corrupt;
        wire nds_unused_ds_e_valid;
        wire [1:0] nds_unused_ds_e_user;
        wire [TL_SINK_WIDTH - 1:0] s7;
        atcsizedn500 #(
            .AW(L2_ADDR_WIDTH),
            .US_DW(ICU_DATA_WIDTH),
            .DS_DW(L2_DATA_WIDTH),
            .OW(ICU_SOURCE_WIDTH),
            .IW(TL_SINK_WIDTH),
            .A_UW(8),
            .B_UW(2),
            .C_UW(2),
            .D_UW(2),
            .E_UW(2)
        ) icu_tlu_szdn (
            .us_a_opcode(agent_a_opcode),
            .us_a_param(agent_a_param),
            .us_a_user(agent_a_user),
            .us_a_size(agent_a_size),
            .us_a_address(agent_a_address),
            .us_a_data(agent_a_data),
            .us_a_source(agent_a_source),
            .us_a_mask(agent_a_mask),
            .us_a_corrupt(agent_a_corrupt),
            .us_a_valid(agent_a_valid),
            .us_a_ready(agent_a_ready),
            .us_d_opcode(agent_d_opcode),
            .us_d_param(agent_d_param),
            .us_d_user(agent_d_user),
            .us_d_size(agent_d_size),
            .us_d_source(agent_d_source),
            .us_d_sink(agent_d_sink),
            .us_d_data(agent_d_data),
            .us_d_denied(agent_d_denied),
            .us_d_corrupt(agent_d_corrupt),
            .us_d_valid(agent_d_valid),
            .us_d_ready(agent_d_ready),
            .ds_a_opcode(icu_a_opcode),
            .ds_a_param(icu_a_param),
            .ds_a_user(icu_a_user),
            .ds_a_size(icu_a_size),
            .ds_a_address(icu_a_address),
            .ds_a_data(icu_a_data),
            .ds_a_source(icu_a_source),
            .ds_a_mask(icu_a_mask),
            .ds_a_corrupt(icu_a_corrupt),
            .ds_a_valid(icu_a_valid),
            .ds_a_ready(icu_a_ready),
            .ds_d_opcode(icu_d_opcode),
            .ds_d_param(icu_d_param),
            .ds_d_user(icu_d_user),
            .ds_d_size(icu_d_size),
            .ds_d_data(icu_d_data),
            .ds_d_source(icu_d_source),
            .ds_d_sink(icu_d_sink),
            .ds_d_denied(icu_d_denied),
            .ds_d_corrupt(icu_d_corrupt),
            .ds_d_valid(icu_d_valid),
            .ds_d_ready(icu_d_ready),
            .clk(core_clk),
            .resetn(core_reset_n),
            .us_b_opcode(nds_unused_us_b_opcode),
            .us_b_param(nds_unused_us_b_param),
            .us_b_size(nds_unused_us_b_size),
            .us_b_source(s0),
            .us_b_address(s3),
            .us_b_user(nds_unused_us_b_user),
            .us_b_data(s1),
            .us_b_mask(s2),
            .us_b_corrupt(nds_unused_us_b_corrupt),
            .us_b_valid(nds_unused_us_b_valid),
            .us_b_ready(1'b0),
            .us_c_opcode({3{1'b0}}),
            .us_c_param({3{1'b0}}),
            .us_c_size({3{1'b0}}),
            .us_c_source({(ICU_SOURCE_WIDTH){1'b0}}),
            .us_c_address({(L2_ADDR_WIDTH){1'b0}}),
            .us_c_data({(ICU_DATA_WIDTH){1'b0}}),
            .us_c_user({2{1'b0}}),
            .us_c_corrupt(1'b0),
            .us_c_valid(1'b0),
            .us_c_ready(nds_unused_us_c_ready),
            .us_e_valid(1'b0),
            .us_e_sink({(TL_SINK_WIDTH){1'b0}}),
            .us_e_user({2{1'b0}}),
            .us_e_ready(nds_unused_us_e_ready),
            .ds_b_opcode({3{1'b0}}),
            .ds_b_param({3{1'b0}}),
            .ds_b_size({3{1'b0}}),
            .ds_b_source({(ICU_SOURCE_WIDTH){1'b0}}),
            .ds_b_address({(L2_ADDR_WIDTH){1'b0}}),
            .ds_b_data({(L2_DATA_WIDTH){1'b0}}),
            .ds_b_mask({(L2_DATA_WIDTH / 8){1'b0}}),
            .ds_b_user({2{1'b0}}),
            .ds_b_corrupt(1'b0),
            .ds_b_valid(1'b0),
            .ds_b_ready(nds_unused_ds_b_ready),
            .ds_c_opcode(nds_unused_ds_c_opcode),
            .ds_c_param(nds_unused_ds_c_param),
            .ds_c_size(nds_unused_ds_c_size),
            .ds_c_source(s4),
            .ds_c_user(nds_unused_ds_c_user),
            .ds_c_address(s5),
            .ds_c_data(s6),
            .ds_c_corrupt(nds_unused_ds_c_corrupt),
            .ds_c_valid(nds_unused_ds_c_valid),
            .ds_c_ready(1'b0),
            .ds_e_valid(nds_unused_ds_e_valid),
            .ds_e_user(nds_unused_ds_e_user),
            .ds_e_sink(s7),
            .ds_e_ready(1'b0)
        );
    end
endgenerate
endmodule

