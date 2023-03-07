// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_agent (
    dcu_clk,
    dcu_reset_n,
    mshr_a_valid,
    mshr_a_ready,
    mshr_a_ptr,
    mshr_a_opcode,
    mshr_a_address,
    mshr_a_size,
    mshr_a_param,
    mshr_a_user,
    mshr_a_data,
    mshr_a_mask,
    mshr_a_corrupt,
    mshr_d_valid,
    mshr_d_opcode,
    mshr_d_ptr,
    mshr_d_sink,
    mshr_d_data,
    mshr_d_param,
    mshr_d_payload,
    mshr_d_last,
    mshr_d_offset,
    mshr_d_error,
    mshr_d_fildata,
    mshr_d_fildata_last,
    mshr_d_l2_way,
    mshr_d_ready,
    mshr_e_valid,
    mshr_e_sink,
    mshr_e_ready,
    evb_c_valid,
    evb_c_opcode,
    evb_c_param,
    evb_c_addr,
    evb_c_data,
    evb_c_source,
    evb_c_ptr,
    evb_c_ready,
    evb_d_valid,
    evb_d_ready,
    evb_c_user,
    evb_d_ptr,
    evb_d_error,
    probe_b_valid,
    probe_b_opcode,
    probe_b_param,
    probe_b_source,
    probe_b_address,
    probe_b_ready,
    agent_a_opcode,
    agent_a_param,
    agent_a_user,
    agent_a_size,
    agent_a_source,
    agent_a_address,
    agent_a_data,
    agent_a_mask,
    agent_a_corrupt,
    agent_a_valid,
    agent_a_ready,
    agent_b_opcode,
    agent_b_param,
    agent_b_size,
    agent_b_source,
    agent_b_address,
    agent_b_data,
    agent_b_mask,
    agent_b_corrupt,
    agent_b_valid,
    agent_b_ready,
    agent_c_opcode,
    agent_c_param,
    agent_c_size,
    agent_c_user,
    agent_c_source,
    agent_c_address,
    agent_c_data,
    agent_c_corrupt,
    agent_c_valid,
    agent_c_ready,
    agent_d_opcode,
    agent_d_param,
    agent_d_user,
    agent_d_size,
    agent_d_source,
    agent_d_data,
    agent_d_denied,
    agent_d_corrupt,
    agent_d_sink,
    agent_d_valid,
    agent_d_ready,
    agent_e_valid,
    agent_e_sink,
    agent_e_ready
);
parameter PALEN = 32;
parameter DCU_DATA_WIDTH = 32;
parameter SOURCE_WIDTH = 2;
parameter SINK_WIDTH = 2;
parameter MSHR_DEPTH = 3;
parameter EVB_DEPTH = 3;
parameter CM_SUPPORT_INT = 0;
localparam SOURCE_DEPTH = MSHR_DEPTH;
localparam DW_RATIO = 128 / DCU_DATA_WIDTH;
localparam DW_RATIO_LOG2 = $clog2(DW_RATIO);
localparam L2_DW_LOG2 = $clog2(DCU_DATA_WIDTH / 8);
localparam A_UW = 12;
localparam C_UW = 8;
localparam D_UW = 6;
input dcu_clk;
input dcu_reset_n;
input mshr_a_valid;
output mshr_a_ready;
input [MSHR_DEPTH - 1:0] mshr_a_ptr;
input [2:0] mshr_a_opcode;
input [PALEN - 1:0] mshr_a_address;
input [2:0] mshr_a_size;
input [2:0] mshr_a_param;
input [11:0] mshr_a_user;
input [DCU_DATA_WIDTH - 1:0] mshr_a_data;
input [(DCU_DATA_WIDTH / 8) - 1:0] mshr_a_mask;
input mshr_a_corrupt;
output mshr_d_valid;
output [2:0] mshr_d_opcode;
output [MSHR_DEPTH - 1:0] mshr_d_ptr;
output [SINK_WIDTH - 1:0] mshr_d_sink;
output [DCU_DATA_WIDTH - 1:0] mshr_d_data;
output [1:0] mshr_d_param;
output mshr_d_payload;
output mshr_d_last;
output [5:3] mshr_d_offset;
output mshr_d_error;
output [127:0] mshr_d_fildata;
output mshr_d_fildata_last;
output [3:0] mshr_d_l2_way;
input mshr_d_ready;
input mshr_e_valid;
input [SINK_WIDTH - 1:0] mshr_e_sink;
output mshr_e_ready;
input evb_c_valid;
input [2:0] evb_c_opcode;
input [2:0] evb_c_param;
input [PALEN - 1:0] evb_c_addr;
input [DCU_DATA_WIDTH - 1:0] evb_c_data;
input [SOURCE_WIDTH - 1:0] evb_c_source;
input [EVB_DEPTH - 1:0] evb_c_ptr;
output evb_c_ready;
output evb_d_valid;
input evb_d_ready;
input [C_UW - 1:0] evb_c_user;
output [EVB_DEPTH - 1:0] evb_d_ptr;
output evb_d_error;
output probe_b_valid;
output [2:0] probe_b_opcode;
output [2:0] probe_b_param;
output [SOURCE_WIDTH - 1:0] probe_b_source;
output [PALEN - 1:0] probe_b_address;
input probe_b_ready;
output [2:0] agent_a_opcode;
output [2:0] agent_a_param;
output [A_UW - 1:0] agent_a_user;
output [2:0] agent_a_size;
output [SOURCE_WIDTH - 1:0] agent_a_source;
output [PALEN - 1:0] agent_a_address;
output [DCU_DATA_WIDTH - 1:0] agent_a_data;
output [(DCU_DATA_WIDTH / 8) - 1:0] agent_a_mask;
output agent_a_corrupt;
output agent_a_valid;
input agent_a_ready;
input [2:0] agent_b_opcode;
input [2:0] agent_b_param;
input [2:0] agent_b_size;
input [SOURCE_WIDTH - 1:0] agent_b_source;
input [PALEN - 1:0] agent_b_address;
input [DCU_DATA_WIDTH - 1:0] agent_b_data;
input [(DCU_DATA_WIDTH / 8) - 1:0] agent_b_mask;
input agent_b_corrupt;
input agent_b_valid;
output agent_b_ready;
output [2:0] agent_c_opcode;
output [2:0] agent_c_param;
output [2:0] agent_c_size;
output [C_UW - 1:0] agent_c_user;
output [SOURCE_WIDTH - 1:0] agent_c_source;
output [PALEN - 1:0] agent_c_address;
output [DCU_DATA_WIDTH - 1:0] agent_c_data;
output agent_c_corrupt;
output agent_c_valid;
input agent_c_ready;
input [2:0] agent_d_opcode;
input [1:0] agent_d_param;
input [D_UW - 1:0] agent_d_user;
input [2:0] agent_d_size;
input [SOURCE_WIDTH - 1:0] agent_d_source;
input [DCU_DATA_WIDTH - 1:0] agent_d_data;
input agent_d_denied;
input agent_d_corrupt;
input [SINK_WIDTH - 1:0] agent_d_sink;
input agent_d_valid;
output agent_d_ready;
output agent_e_valid;
output [SINK_WIDTH - 1:0] agent_e_sink;
input agent_e_ready;


wire xlen64 = 1'b0;
wire [5:3] beat_size = DCU_DATA_WIDTH[8:6];
wire cm_en = (CM_SUPPORT_INT == 1);
wire [SOURCE_DEPTH - 1:0] ent_a_free;
wire [MSHR_DEPTH * SOURCE_DEPTH - 1:0] ent_mshr_ptr;
wire [EVB_DEPTH * SOURCE_DEPTH - 1:0] ent_evb_ptr;
wire [SOURCE_DEPTH - 1:0] ent_c_free;
wire [SOURCE_DEPTH - 1:0] ent_a_grant_first;
wire [SOURCE_DEPTH - 1:0] ent_c_grant_first;
wire [SOURCE_DEPTH - 1:0] ent_d_grant;
wire [SOURCE_DEPTH - 1:0] ent_d_last;
wire [3 * SOURCE_DEPTH - 1:0] ent_d_offset;
wire d_op_releaseack = (agent_d_opcode == 3'd6);
wire d_op_accessack = (agent_d_opcode == 3'd0);
wire d_op_accessackdata = (agent_d_opcode == 3'd1);
wire d_op_grantdata = (agent_d_opcode == 3'd5);
wire d_op_grant = (agent_d_opcode == 3'd4);
wire a_op_putpart = (agent_a_opcode == 3'd1);
wire a_op_get = (agent_a_opcode == 3'd4);
wire a_op_acquireblock = (agent_a_opcode == 3'd6);
wire a_op_acquireperm = (agent_a_opcode == 3'd7);
wire c_op_probeack = (agent_c_opcode == 3'd4);
wire c_op_probeackdata = (agent_c_opcode == 3'd5);
wire c_op_release = (agent_c_opcode == 3'd6);
wire c_op_releasedata = (agent_c_opcode == 3'd7);
wire c_op_probeacks = (c_op_probeack | c_op_probeackdata) & cm_en;
wire c_op_releases = c_op_release | c_op_releasedata;
wire d_data = d_op_accessackdata | d_op_grantdata;
wire agent_a_rand_stall;
wire agent_b_rand_stall;
wire agent_c_rand_stall;
wire agent_d_rand_stall;
wire agent_e_rand_stall;
wire a_grant;
wire c_grant;
wire d_grant;
reg [5:3] a_offset;
wire [5:3] a_offset_nx;
wire [5:3] a_offset_incr = a_offset + beat_size;
wire a_offset_en;
wire a_first;
wire a_single_beat;
reg [SOURCE_WIDTH - 1:0] a_source;
wire a_source_en;
wire a_source_ready;
wire [SOURCE_DEPTH - 1:0] a_free_ptr;
wire [SOURCE_WIDTH - 1:0] a_source_free;
reg [5:3] c_offset;
wire [5:3] c_offset_nx;
wire [5:3] c_offset_incr = c_offset + beat_size;
wire c_offset_en;
wire c_first;
wire c_single_beat;
wire c_grant_first;
reg [SOURCE_WIDTH - 1:0] c_source;
wire c_source_en;
wire c_source_ready;
wire [SOURCE_DEPTH - 1:0] arb_c_valid;
wire [SOURCE_DEPTH - 1:0] arb_c_ptr;
wire [SOURCE_WIDTH - 1:0] arb_c_source;
wire [SOURCE_DEPTH - 1:0] d_source_onehot;
wire [SOURCE_DEPTH - 1:0] nds_unused_arb_c_ptr_ready;
assign agent_a_rand_stall = 1'b0;
assign agent_b_rand_stall = 1'b0;
assign agent_c_rand_stall = 1'b0;
assign agent_d_rand_stall = 1'b0;
assign agent_e_rand_stall = 1'b0;
generate
    genvar i;
    for (i = 0; i < SOURCE_DEPTH; i = i + 1) begin:gen_ent
        kv_dcu_agent_ent #(
            .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
            .MSHR_DEPTH(MSHR_DEPTH),
            .EVB_DEPTH(EVB_DEPTH),
            .CM_SUPPORT_INT(CM_SUPPORT_INT)
        ) u_ent (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .a_free(ent_a_free[i]),
            .mshr_ptr(ent_mshr_ptr[MSHR_DEPTH * i +:MSHR_DEPTH]),
            .c_free(ent_c_free[i]),
            .evb_ptr(ent_evb_ptr[EVB_DEPTH * i +:EVB_DEPTH]),
            .a_grant_first(ent_a_grant_first[i]),
            .a_opcode(agent_a_opcode),
            .a_param(agent_a_param),
            .a_mshr_ptr(mshr_a_ptr),
            .c_grant_first(ent_c_grant_first[i]),
            .c_opcode(agent_c_opcode),
            .c_evb_ptr(evb_c_ptr),
            .d_grant(ent_d_grant[i]),
            .d_opcode(agent_d_opcode),
            .d_param(agent_d_param),
            .d_offset(ent_d_offset[3 * i +:3]),
            .d_last(ent_d_last[i])
        );
    end
endgenerate
kv_ffs #(
    .WIDTH(SOURCE_DEPTH)
) u_a_free_ptr (
    .out(a_free_ptr),
    .in(ent_a_free)
);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        a_offset <= 3'd0;
    end
    else if (a_offset_en) begin
        a_offset <= a_offset_nx;
    end
end

always @(posedge dcu_clk) begin
    if (a_source_en) begin
        a_source <= agent_a_source;
    end
end

assign a_grant = agent_a_valid & agent_a_ready;
assign a_single_beat = a_op_get | a_op_acquireblock | a_op_acquireperm | (a_op_putpart & !agent_a_size[2]);
assign a_source_en = a_grant & a_first & ~a_single_beat;
assign a_offset_nx = a_offset_incr;
assign a_offset_en = a_grant & ~a_single_beat;
assign a_first = ~|a_offset;
kv_onehot2bin #(
    .N(SOURCE_DEPTH)
) u_a_source_free (
    .out(a_source_free),
    .in(a_free_ptr)
);
assign ent_a_grant_first = ({SOURCE_DEPTH{a_grant & a_first}} & a_free_ptr);
assign agent_a_source = a_first ? a_source_free : a_source;
assign a_source_ready = ~a_first | (|ent_a_free);
assign agent_a_valid = mshr_a_valid & ~agent_a_rand_stall & a_source_ready;
assign agent_a_opcode = mshr_a_opcode;
assign agent_a_address = mshr_a_address;
assign agent_a_size = mshr_a_size;
assign agent_a_param = mshr_a_param;
assign agent_a_user = mshr_a_user[0 +:A_UW];
assign agent_a_data = mshr_a_data;
assign agent_a_mask = mshr_a_mask;
assign agent_a_corrupt = mshr_a_corrupt;
assign mshr_a_ready = agent_a_ready & ~agent_a_rand_stall & a_source_ready;
kv_arb_rr #(
    .N(SOURCE_DEPTH)
) u_arb_c_ptr (
    .clk(dcu_clk),
    .resetn(dcu_reset_n),
    .en(c_grant_first),
    .valid(arb_c_valid),
    .ready(nds_unused_arb_c_ptr_ready),
    .grant(arb_c_ptr)
);
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        c_offset <= 3'd0;
    end
    else if (c_offset_en) begin
        c_offset <= c_offset_nx;
    end
end

always @(posedge dcu_clk) begin
    if (c_source_en) begin
        c_source <= agent_c_source;
    end
end

assign arb_c_valid = ent_c_free;
assign c_single_beat = c_op_release | c_op_probeack;
assign c_source_en = c_grant & c_first & ~c_single_beat;
assign c_source_ready = ~c_first | (|ent_c_free);
assign c_offset_nx = c_offset_incr;
assign c_offset_en = c_grant & ~c_single_beat;
assign c_first = ~|c_offset;
kv_onehot2bin #(
    .N(SOURCE_DEPTH)
) u_arb_c_source (
    .out(arb_c_source),
    .in(arb_c_ptr)
);
assign c_grant = agent_c_valid & agent_c_ready;
assign c_grant_first = c_grant & c_first;
assign ent_c_grant_first = {SOURCE_DEPTH{c_grant_first & c_op_releases}} & arb_c_ptr;
assign agent_c_valid = evb_c_valid & ~agent_c_rand_stall & c_source_ready;
assign agent_c_opcode = evb_c_opcode;
assign agent_c_param = evb_c_param;
assign agent_c_address = evb_c_addr;
assign agent_c_data = evb_c_data;
assign agent_c_size = 3'd6;
assign agent_c_user = evb_c_user[0 +:C_UW];
assign agent_c_corrupt = 1'b0;
assign agent_c_source = c_op_probeacks ? evb_c_source : c_first ? arb_c_source : c_source;
assign evb_c_ready = agent_c_ready & ~agent_c_rand_stall & c_source_ready;
assign evb_d_valid = agent_d_valid & agent_d_ready & d_op_releaseack & ~agent_d_rand_stall;
assign evb_d_error = agent_d_denied | agent_d_corrupt | agent_d_user[1];
kv_mux_onehot #(
    .N(SOURCE_DEPTH),
    .W(EVB_DEPTH)
) u_evb_d_ptr (
    .out(evb_d_ptr),
    .sel(d_source_onehot),
    .in(ent_evb_ptr)
);
kv_bin2onehot #(
    .N(SOURCE_DEPTH)
) u_d_source_onehot (
    .out(d_source_onehot),
    .in(agent_d_source)
);
assign d_grant = agent_d_valid & agent_d_ready;
assign ent_d_grant = {SOURCE_DEPTH{d_grant}} & d_source_onehot;
kv_mux_onehot #(
    .N(SOURCE_DEPTH),
    .W(MSHR_DEPTH)
) u_mshr_d_ptr (
    .out(mshr_d_ptr),
    .sel(d_source_onehot),
    .in(ent_mshr_ptr)
);
kv_mux_onehot #(
    .N(SOURCE_DEPTH),
    .W(1)
) u_mshr_d_last (
    .out(mshr_d_last),
    .sel(d_source_onehot),
    .in(ent_d_last)
);
kv_mux_onehot #(
    .N(SOURCE_DEPTH),
    .W(3)
) u_mshr_d_offset (
    .out(mshr_d_offset),
    .sel(d_source_onehot),
    .in(ent_d_offset)
);
assign agent_d_ready = ((d_data & mshr_d_ready) | (d_op_accessack & mshr_d_ready) | (d_op_grant & mshr_d_ready) | (d_op_releaseack & evb_d_ready)) & ~agent_d_rand_stall;
assign mshr_d_valid = agent_d_valid & (d_data | d_op_accessack | d_op_grant) & ~agent_d_rand_stall;
assign mshr_d_opcode = agent_d_opcode;
assign mshr_d_sink = agent_d_sink;
assign mshr_d_data = agent_d_data;
assign mshr_d_payload = d_data;
assign mshr_d_param = agent_d_param;
assign mshr_d_error = agent_d_denied | agent_d_corrupt | agent_d_user[1];
assign mshr_d_l2_way = agent_d_user[2 +:4];
generate
    genvar j;
    if (DW_RATIO_LOG2 != 0) begin:gen_fildata_buf
        wire [SOURCE_DEPTH - 1:0] ent_fildata_last;
        wire [(128 * SOURCE_DEPTH) - 1:0] ent_fildata;
        wire [127:0] fildata;
        kv_mux_onehot #(
            .N(SOURCE_DEPTH),
            .W(128)
        ) u_fildata (
            .out(fildata),
            .sel(d_source_onehot),
            .in(ent_fildata)
        );
        assign mshr_d_fildata_last = |(ent_fildata_last & d_source_onehot);
        assign mshr_d_fildata = {agent_d_data,fildata[128 - DCU_DATA_WIDTH - 1:0]};
        for (j = 0; j < SOURCE_DEPTH; j = j + 1) begin:gen_fildata_buf_ent
            wire fildata_en;
            wire [DW_RATIO - 1:0] fildata_byte_wmask;
            wire [127:0] fildata_bit_wmask;
            wire [127:0] fildata_bit_we;
            wire [128 - DCU_DATA_WIDTH - 1:0] fildata_nx;
            reg [128 - DCU_DATA_WIDTH - 1:0] fildata_r;
            kv_bin2onehot #(
                .N(DW_RATIO)
            ) u_fildata_byte_wmask (
                .out(fildata_byte_wmask),
                .in(mshr_d_offset[L2_DW_LOG2 +:DW_RATIO_LOG2])
            );
            kv_bit_expand #(
                .N(DW_RATIO),
                .M(DCU_DATA_WIDTH)
            ) u_fildata_bit_wmask (
                .out(fildata_bit_wmask),
                .in(fildata_byte_wmask)
            );
            assign fildata_en = d_grant & d_op_grantdata & d_source_onehot[j];
            assign fildata_bit_we = {128{fildata_en}} & fildata_bit_wmask;
            assign fildata_nx = {(DW_RATIO - 1){agent_d_data}} & fildata_bit_we[0 +:(128 - DCU_DATA_WIDTH)] | fildata_r & ~fildata_bit_we[0 +:(128 - DCU_DATA_WIDTH)];
            always @(posedge dcu_clk) begin
                fildata_r <= fildata_nx[0 +:(128 - DCU_DATA_WIDTH)];
            end

            assign ent_fildata_last[j] = fildata_byte_wmask[DW_RATIO - 1];
            assign ent_fildata[j * 128 +:128] = {{DCU_DATA_WIDTH{1'b0}},fildata_r};
        end
    end
    else begin:gen_fildata_buf_stub
        assign mshr_d_fildata_last = 1'b1;
        assign mshr_d_fildata = agent_d_data;
    end
endgenerate
assign agent_e_valid = mshr_e_valid & ~agent_e_rand_stall;
assign agent_e_sink = mshr_e_sink;
assign mshr_e_ready = agent_e_ready & ~agent_e_rand_stall;
assign probe_b_valid = agent_b_valid & ~agent_b_rand_stall;
assign probe_b_opcode = agent_b_opcode;
assign probe_b_param = agent_b_param;
assign probe_b_source = agent_b_source;
assign probe_b_address = agent_b_address;
assign agent_b_ready = probe_b_ready & ~agent_b_rand_stall;
wire nds_unused_signals = |{agent_b_size,agent_b_data,agent_b_mask,agent_b_corrupt,agent_d_size};
endmodule

