// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_tlu_sizeup (
    us_a_opcode,
    us_a_param,
    us_a_user,
    us_a_size,
    us_a_address,
    us_a_source,
    us_a_data,
    us_a_mask,
    us_a_corrupt,
    us_a_valid,
    us_a_ready,
    us_d_opcode,
    us_d_param,
    us_d_size,
    us_d_user,
    us_d_data,
    us_d_source,
    us_d_sink,
    us_d_denied,
    us_d_corrupt,
    us_d_valid,
    us_d_ready,
    ds_a_opcode,
    ds_a_param,
    ds_a_user,
    ds_a_size,
    ds_a_address,
    ds_a_data,
    ds_a_mask,
    ds_a_source,
    ds_a_corrupt,
    ds_a_valid,
    ds_a_ready,
    ds_d_opcode,
    ds_d_param,
    ds_d_user,
    ds_d_size,
    ds_d_data,
    ds_d_source,
    ds_d_sink,
    ds_d_denied,
    ds_d_corrupt,
    ds_d_valid,
    ds_d_ready,
    clk,
    resetn
);
parameter AW = 32;
parameter US_DW = 32;
parameter DS_DW = 64;
parameter OW = 2;
parameter IW = 2;
parameter A_UW = 2;
parameter D_UW = 2;
parameter OST_GET_NUM = 2;
localparam RATIO = DS_DW / US_DW;
localparam RATIO_LOG2 = $unsigned($clog2(RATIO));
localparam US_A_WIDTH = 6 + A_UW + 3 + AW + OW + US_DW + (US_DW / 8) + 1;
localparam DS_D_WIDTH = 5 + D_UW + 3 + OW + DS_DW + IW + 1 + 1;
localparam US_MSB = US_DW == 32 ? 1 : US_DW == 64 ? 2 : 3;
localparam DS_MSB = DS_DW == 32 ? 1 : DS_DW == 64 ? 2 : DS_DW == 128 ? 3 : 4;
localparam US_IDX = US_MSB + 1;
localparam US_SIZE = (US_DW == 32) ? 3'd2 : (US_DW == 64) ? 3'd3 : 3'd4;
localparam DS_SIZE = (DS_DW == 64) ? 3'd3 : (DS_DW == 128) ? 3'd4 : 3'd5;
localparam US_MASK = (US_DW == 128) ? 5'h3 : (US_DW == 64) ? 5'h1 : 5'h0;
localparam US_BEAT_SIZE = US_DW == 32 ? 5'd1 : US_DW == 64 ? 5'd2 : 5'd4;
input [2:0] us_a_opcode;
input [2:0] us_a_param;
input [A_UW - 1:0] us_a_user;
input [2:0] us_a_size;
input [AW - 1:0] us_a_address;
input [OW - 1:0] us_a_source;
input [US_DW - 1:0] us_a_data;
input [(US_DW / 8) - 1:0] us_a_mask;
input us_a_corrupt;
input us_a_valid;
output us_a_ready;
output [2:0] us_d_opcode;
output [1:0] us_d_param;
output [2:0] us_d_size;
output [D_UW - 1:0] us_d_user;
output [US_DW - 1:0] us_d_data;
output [OW - 1:0] us_d_source;
output [IW - 1:0] us_d_sink;
output us_d_denied;
output us_d_corrupt;
output us_d_valid;
input us_d_ready;
output [2:0] ds_a_opcode;
output [2:0] ds_a_param;
output [A_UW - 1:0] ds_a_user;
output [2:0] ds_a_size;
output [AW - 1:0] ds_a_address;
output [DS_DW - 1:0] ds_a_data;
output [(DS_DW / 8) - 1:0] ds_a_mask;
output [OW - 1:0] ds_a_source;
output ds_a_corrupt;
output ds_a_valid;
input ds_a_ready;
input [2:0] ds_d_opcode;
input [1:0] ds_d_param;
input [D_UW - 1:0] ds_d_user;
input [2:0] ds_d_size;
input [DS_DW - 1:0] ds_d_data;
input [OW - 1:0] ds_d_source;
input [IW - 1:0] ds_d_sink;
input ds_d_denied;
input ds_d_corrupt;
input ds_d_valid;
output ds_d_ready;
input clk;
input resetn;


wire a_wvalid;
wire a_wready;
wire [US_A_WIDTH - 1:0] a_wdata;
wire a_valid;
wire a_ready;
wire [US_A_WIDTH - 1:0] a_rdata;
wire a_grant = a_valid & a_ready;
wire [2:0] a_opcode;
wire [2:0] a_param;
wire [A_UW - 1:0] a_user;
wire [2:0] a_size;
wire [AW - 1:0] a_address;
wire [OW - 1:0] a_source;
wire [US_DW - 1:0] a_data;
wire [(US_DW / 8) - 1:0] a_mask;
wire a_corrupt;
wire a_opcode_get = a_opcode == 3'd4;
wire a_opcode_put = a_opcode == 3'd1;
wire a_single;
wire a_2beats;
wire a_4beats;
wire a_8beats;
wire [DS_MSB:US_IDX] a_lane;
wire [RATIO - 1:0] a_lane_onehot;
wire [RATIO - 1:0] a_lane_sel;
wire [RATIO - 1:0] a_lane_sel_get;
wire a_all_lane;
wire a_last_lane;
wire a_first_lane;
wire [6:2] a_offset;
wire [6:2] a_offset_add_one;
wire [OST_GET_NUM - 1:0] a_hit_ptr;
wire a_hit = |a_hit_ptr;
wire fsm_a_offset_en;
reg [6:2] fsm_a_offset;
wire [6:2] fsm_a_offset_nx;
wire ds_a_ctrl_en;
wire [RATIO - 1:0] ds_a_data_en;
wire [RATIO - 1:0] ds_a_mask_en;
reg [2:0] ds_a_opcode;
reg [2:0] ds_a_param;
reg [A_UW - 1:0] ds_a_user;
reg [2:0] ds_a_size;
reg [AW - 1:0] ds_a_address;
reg [DS_DW - 1:0] ds_a_data;
reg [(DS_DW / 8) - 1:0] ds_a_mask;
reg [OW - 1:0] ds_a_source;
reg ds_a_corrupt;
reg ds_a_valid;
wire ds_a_valid_nx;
wire ds_a_valid_en;
wire ds_a_valid_set;
wire ds_a_valid_clr;
wire [DS_D_WIDTH - 1:0] ds_d_wdata;
wire d_valid;
wire d_ready;
wire [DS_D_WIDTH - 1:0] d_rdata;
wire [2:0] d_opcode;
wire [1:0] d_param;
wire [D_UW - 1:0] d_user;
wire [2:0] d_size;
wire [DS_DW - 1:0] d_data;
wire [OW - 1:0] d_source;
wire [IW - 1:0] d_sink;
wire d_denied;
wire d_corrupt;
wire [OST_GET_NUM - 1:0] d_hit_ptr;
wire [6:2] d_offset;
wire [DS_MSB - US_MSB - 1:0] d_offset_lsb;
wire d_last_lane;
wire d_hit_last_lane;
wire d_hit = |d_hit_ptr;
wire [OST_GET_NUM - 1:0] ent_valid;
wire [OST_GET_NUM - 1:0] ent_invalid = ~ent_valid;
wire [OST_GET_NUM - 1:0] free_ptr;
wire [(5 * OST_GET_NUM) - 1:0] ent_offset;
wire ent_full = &ent_valid;
wire [OST_GET_NUM - 1:0] ent_last_lane;
wire us_d_grant = us_d_valid & us_d_ready;
wire ds_a_grant = ds_a_valid & ds_a_ready;
wire ds_d_grant = ds_d_valid & ds_d_ready;
kv_zdb #(
    .WIDTH(US_A_WIDTH)
) u_zdb_a (
    .clk(clk),
    .reset_n(resetn),
    .wvalid(a_wvalid),
    .wready(a_wready),
    .wdata(a_wdata),
    .rvalid(a_valid),
    .rready(a_ready),
    .rdata(a_rdata)
);
assign a_wvalid = us_a_valid & ~ent_full;
assign a_wdata = {us_a_opcode,us_a_param,us_a_user,us_a_size,us_a_address,us_a_source,us_a_data,us_a_mask,us_a_corrupt};
assign us_a_ready = a_wready & ~ent_full;
assign {a_opcode,a_param,a_user,a_size,a_address,a_source,a_data,a_mask,a_corrupt} = a_rdata;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        ds_a_valid <= 1'b0;
    end
    else if (ds_a_valid_en) begin
        ds_a_valid <= ds_a_valid_nx;
    end
end

always @(posedge clk) begin
    if (ds_a_ctrl_en) begin
        ds_a_opcode <= a_opcode;
        ds_a_param <= a_param;
        ds_a_user <= a_user;
        ds_a_size <= a_size;
        ds_a_address <= a_address;
        ds_a_source <= a_source;
        ds_a_corrupt <= a_corrupt;
    end
end

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        fsm_a_offset <= 5'd0;
    end
    else if (fsm_a_offset_en) begin
        fsm_a_offset <= fsm_a_offset_nx;
    end
end

generate
    genvar i;
    for (i = 0; i < RATIO; i = i + 1) begin:gen_a
        wire [US_DW / 8 - 1:0] a_mask_nx = ({(US_DW / 8){a_lane_sel[i]}} & a_mask);
        always @(posedge clk) begin
            if (ds_a_data_en[i]) begin
                ds_a_data[i * US_DW +:US_DW] <= a_data;
            end
        end

        always @(posedge clk) begin
            if (ds_a_mask_en[i]) begin
                ds_a_mask[i * (US_DW / 8) +:(US_DW / 8)] <= a_mask_nx;
            end
        end

    end
endgenerate
kv_bin2onehot #(
    .N(RATIO)
) u_a_lane_onehot (
    .out(a_lane_onehot),
    .in(a_lane)
);
assign a_offset = a_first_lane ? a_address[6:2] : fsm_a_offset[6:2];
assign a_offset_add_one = a_offset[6:2] + US_BEAT_SIZE;
assign a_lane = a_offset[DS_MSB:US_IDX];
assign a_all_lane = a_opcode_get & (a_size >= DS_SIZE);
assign a_lane_sel = a_lane_onehot | ({RATIO{a_opcode_get}} & a_lane_sel_get);
assign a_single = (a_size <= US_SIZE);
assign a_2beats = ((US_DW == 32) & (DS_DW == 64) & (a_size >= 3'd3)) | ((US_DW == 32) & (DS_DW == 128) & (a_size == 3'd3)) | ((US_DW == 32) & (DS_DW == 256) & (a_size == 3'd3)) | ((US_DW == 64) & (DS_DW == 128) & (a_size >= 3'd4)) | ((US_DW == 64) & (DS_DW == 256) & (a_size == 3'd4)) | ((US_DW == 128) & (DS_DW == 256) & (a_size >= 3'd5));
assign a_4beats = ((US_DW == 32) & (DS_DW == 128) & (a_size >= 3'd4)) | ((US_DW == 32) & (DS_DW == 256) & (a_size == 3'd4)) | ((US_DW == 64) & (DS_DW == 256) & (a_size >= 3'd5));
assign a_8beats = ((US_DW == 32) & (DS_DW == 256) & (a_size >= 3'd5));
assign fsm_a_offset_en = a_grant & ~a_single & a_opcode_put;
assign fsm_a_offset_nx = a_last_lane ? 5'd0 : a_offset_add_one;
assign a_last_lane = a_single | (a_2beats & a_offset[US_IDX]) | (a_4beats & (&a_offset[US_IDX +:2])) | (a_8beats & (&a_offset[US_IDX +:3]));
generate
    if ((US_DW == 32) & (DS_DW == 64)) begin:gen_32_64
        assign a_lane_sel_get = ({2{(a_size >= 3'd3)}} & 2'h3);
    end
    else if ((US_DW == 32) & (DS_DW == 128)) begin:gen_32_128
        assign a_lane_sel_get = ({4{(a_size == 3'd3) && a_lane_onehot[0]}} & 4'h3) | ({4{(a_size == 3'd3) && a_lane_onehot[2]}} & 4'hc) | ({4{(a_size >= 3'd4)}} & 4'hf);
    end
    else if ((US_DW == 32) & (DS_DW == 256)) begin:gen_32_256
        assign a_lane_sel_get = ({8{(a_size == 3'd3) && a_lane_onehot[0]}} & 8'h03) | ({8{(a_size == 3'd3) && a_lane_onehot[2]}} & 8'h0c) | ({8{(a_size == 3'd3) && a_lane_onehot[4]}} & 8'h30) | ({8{(a_size == 3'd3) && a_lane_onehot[6]}} & 8'hc0) | ({8{(a_size == 3'd4) && a_lane_onehot[0]}} & 8'h0f) | ({8{(a_size == 3'd4) && a_lane_onehot[4]}} & 8'hf0) | ({8{(a_size >= 3'd5)}} & 8'hff);
    end
    else if ((US_DW == 64) & (DS_DW == 128)) begin:gen_64_128
        assign a_lane_sel_get = ({2{(a_size >= 3'd4)}} & 2'h3);
    end
    else if ((US_DW == 64) & (DS_DW == 256)) begin:gen_64_256
        assign a_lane_sel_get = ({4{(a_size == 3'd4) && a_lane_onehot[0]}} & 4'h3) | ({4{(a_size == 3'd4) && a_lane_onehot[2]}} & 4'hc) | ({4{(a_size >= 3'd5)}} & 4'hf);
    end
    else if ((US_DW == 128) & (DS_DW == 256)) begin:gen_128_256
        assign a_lane_sel_get = ({2{(a_size >= 3'd5)}} & 2'h3);
    end
endgenerate
assign a_first_lane = ~|fsm_a_offset;
assign ds_a_mask_en = ({RATIO{a_grant & a_first_lane}}) | ({RATIO{a_grant & a_opcode_put}} & a_lane_onehot);
assign ds_a_data_en = {RATIO{a_grant & a_opcode_put}} & a_lane_onehot;
assign ds_a_valid_en = ds_a_valid_set | ds_a_valid_clr;
assign ds_a_valid_nx = ds_a_valid_set | (ds_a_valid & ~ds_a_valid_clr);
assign ds_a_valid_clr = ds_a_valid & ds_a_ready;
assign ds_a_valid_set = (a_grant & a_opcode_put & a_last_lane) | (a_grant & a_opcode_get);
assign ds_a_ctrl_en = ds_a_valid_set;
assign a_ready = (~ds_a_valid | ds_a_ready) & ~a_hit;
generate
    if (OST_GET_NUM > 1) begin:gen_free_ptr
        kv_ffs #(
            .WIDTH(OST_GET_NUM)
        ) u_free_ptr (
            .out(free_ptr),
            .in(ent_invalid)
        );
    end
    else begin:gen_free_ptr_stub
        assign free_ptr = ent_invalid[0];
    end
endgenerate
generate
    genvar j;
    for (j = 0; j < OST_GET_NUM; j = j + 1) begin:gen_ent
        reg valid;
        wire valid_set;
        wire valid_clr;
        wire valid_en;
        wire valid_nx;
        reg [OW - 1:0] source;
        reg [2:0] size;
        wire us_d_hit;
        wire last;
        wire last_lane;
        reg [6:2] offset;
        wire [6:2] offset_nx;
        wire offset_en;
        wire [6:2] offset_add_one = offset + US_BEAT_SIZE;
        wire [6:2] offset_masked;
        wire us_d_grant_hit = us_d_grant & us_d_hit;
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                valid <= 1'b0;
            end
            else if (valid_en) begin
                valid <= valid_nx;
            end
        end

        always @(posedge clk) begin
            if (valid_set) begin
                size <= a_size;
                source <= a_source;
            end
        end

        always @(posedge clk) begin
            if (offset_en) begin
                offset <= offset_nx;
            end
        end

        assign valid_en = valid_set | valid_clr;
        assign valid_set = a_grant & a_opcode_get & free_ptr[j];
        assign valid_clr = us_d_grant_hit & last;
        assign valid_nx = valid_set | (valid & ~valid_clr);
        assign offset_en = valid_set | us_d_grant_hit;
        assign offset_nx = valid_set ? a_address[6:2] : offset_add_one;
        assign us_d_hit = valid & (us_d_source == source);
        assign offset_masked = offset | US_MASK;
        assign last = ((size <= 3'd2)) | ((size == 3'd3) & (&offset_masked[2:2])) | ((size == 3'd4) & (&offset_masked[3:2])) | ((size == 3'd5) & (&offset_masked[4:2])) | ((size == 3'd6) & (&offset_masked[5:2])) | ((size == 3'd7) & (&offset_masked[6:2]));
        assign last_lane = (size <= US_SIZE) | ((US_DW == 32) & (DS_DW == 64) & (size >= 3'd3) & (&offset_masked[2:2])) | ((US_DW == 32) & (DS_DW == 128) & (size == 3'd3) & (&offset_masked[2:2])) | ((US_DW == 32) & (DS_DW == 128) & (size >= 3'd4) & (&offset_masked[3:2])) | ((US_DW == 32) & (DS_DW == 256) & (size == 3'd3) & (&offset_masked[2:2])) | ((US_DW == 32) & (DS_DW == 256) & (size == 3'd4) & (&offset_masked[3:2])) | ((US_DW == 32) & (DS_DW == 256) & (size >= 3'd5) & (&offset_masked[4:2])) | ((US_DW == 64) & (DS_DW == 128) & (size >= 3'd4) & (&offset_masked[3:3])) | ((US_DW == 64) & (DS_DW == 256) & (size == 3'd4) & (&offset_masked[3:3])) | ((US_DW == 64) & (DS_DW == 256) & (size >= 3'd5) & (&offset_masked[4:3])) | ((US_DW == 128) & (DS_DW == 256) & (size >= 3'd5) & (&offset_masked[4:4]));
        assign ent_valid[j] = valid;
        assign ent_offset[j * 5 +:5] = offset;
        assign ent_last_lane[j] = last_lane;
        assign d_hit_ptr[j] = valid & (d_source == source);
        assign a_hit_ptr[j] = valid & (a_source == source);
    end
endgenerate
kv_zdb #(
    .WIDTH(DS_D_WIDTH)
) u_zdb_d (
    .clk(clk),
    .reset_n(resetn),
    .wvalid(ds_d_valid),
    .wready(ds_d_ready),
    .wdata(ds_d_wdata),
    .rvalid(d_valid),
    .rready(d_ready),
    .rdata(d_rdata)
);
assign ds_d_wdata = {ds_d_opcode,ds_d_param,ds_d_user,ds_d_size,ds_d_data,ds_d_source,ds_d_sink,ds_d_denied,ds_d_corrupt};
assign {d_opcode,d_param,d_user,d_size,d_data,d_source,d_sink,d_denied,d_corrupt} = d_rdata;
kv_mux_onehot #(
    .N(OST_GET_NUM),
    .W(5)
) u_d_offset (
    .out(d_offset),
    .sel(d_hit_ptr),
    .in(ent_offset)
);
kv_mux_onehot #(
    .N(OST_GET_NUM),
    .W(1)
) u_d_hit_last (
    .out(d_hit_last_lane),
    .sel(d_hit_ptr),
    .in(ent_last_lane)
);
assign d_last_lane = ~d_hit | d_hit_last_lane;
assign d_offset_lsb = d_offset[DS_MSB:US_IDX];
kv_mux #(
    .N(RATIO),
    .W(US_DW)
) u_us_d_data (
    .out(us_d_data),
    .sel(d_offset_lsb),
    .in(d_data)
);
assign us_d_valid = d_valid;
assign d_ready = us_d_ready & d_last_lane;
assign us_d_opcode = d_opcode;
assign us_d_param = d_param;
assign us_d_user = d_user;
assign us_d_size = d_size;
assign us_d_source = d_source;
assign us_d_sink = d_sink;
assign us_d_denied = d_denied;
assign us_d_corrupt = d_corrupt;
endmodule

