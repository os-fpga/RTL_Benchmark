// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_brg (
    dcu_clk,
    dcu_reset_n,
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
    agent_d_sink,
    agent_d_data,
    agent_d_denied,
    agent_d_corrupt,
    agent_d_valid,
    agent_d_ready,
    agent_e_valid,
    agent_e_sink,
    agent_e_ready,
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
    dcu_c_user,
    dcu_c_size,
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
    dcu_e_ready
);
parameter PALEN = 32;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 32;
parameter DCU_DATA_WIDTH = 32;
parameter SINK_WIDTH = 2;
parameter MSHR_DEPTH = 3;
parameter TL_SIZE_WIDTH = 3;
parameter A_UW = 12;
parameter C_UW = 8;
parameter D_UW = 6;
parameter SOURCE_WIDTH = 2;
parameter CM_SUPPORT_INT = 0;
localparam SOURCE_DEPTH = MSHR_DEPTH;
localparam DCU_SOURCE_WIDTH = 3;
input dcu_clk;
input dcu_reset_n;
input [2:0] agent_a_opcode;
input [2:0] agent_a_param;
input [A_UW - 1:0] agent_a_user;
input [TL_SIZE_WIDTH - 1:0] agent_a_size;
input [SOURCE_WIDTH - 1:0] agent_a_source;
input [PALEN - 1:0] agent_a_address;
input [DCU_DATA_WIDTH - 1:0] agent_a_data;
input [(DCU_DATA_WIDTH / 8) - 1:0] agent_a_mask;
input agent_a_corrupt;
input agent_a_valid;
output agent_a_ready;
output [2:0] agent_b_opcode;
output [2:0] agent_b_param;
output [2:0] agent_b_size;
output [SOURCE_WIDTH - 1:0] agent_b_source;
output [PALEN - 1:0] agent_b_address;
output [DCU_DATA_WIDTH - 1:0] agent_b_data;
output [(DCU_DATA_WIDTH / 8) - 1:0] agent_b_mask;
output agent_b_corrupt;
output agent_b_valid;
input agent_b_ready;
input [2:0] agent_c_opcode;
input [2:0] agent_c_param;
input [2:0] agent_c_size;
input [C_UW - 1:0] agent_c_user;
input [SOURCE_WIDTH - 1:0] agent_c_source;
input [PALEN - 1:0] agent_c_address;
input [DCU_DATA_WIDTH - 1:0] agent_c_data;
input agent_c_corrupt;
input agent_c_valid;
output agent_c_ready;
output [2:0] agent_d_opcode;
output [1:0] agent_d_param;
output [D_UW - 1:0] agent_d_user;
output [2:0] agent_d_size;
output [SOURCE_WIDTH - 1:0] agent_d_source;
output [SINK_WIDTH - 1:0] agent_d_sink;
output [DCU_DATA_WIDTH - 1:0] agent_d_data;
output agent_d_denied;
output agent_d_corrupt;
output agent_d_valid;
input agent_d_ready;
input agent_e_valid;
input [SINK_WIDTH - 1:0] agent_e_sink;
output agent_e_ready;
output [2:0] dcu_a_opcode;
output [2:0] dcu_a_param;
output [A_UW - 1:0] dcu_a_user;
output [TL_SIZE_WIDTH - 1:0] dcu_a_size;
output [DCU_SOURCE_WIDTH - 1:0] dcu_a_source;
output [L2_ADDR_WIDTH - 1:0] dcu_a_address;
output [L2_DATA_WIDTH - 1:0] dcu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] dcu_a_mask;
output dcu_a_corrupt;
output dcu_a_valid;
input dcu_a_ready;
input [2:0] dcu_b_opcode;
input [2:0] dcu_b_param;
input [2:0] dcu_b_size;
input [DCU_SOURCE_WIDTH - 1:0] dcu_b_source;
input [L2_ADDR_WIDTH - 1:0] dcu_b_address;
input [L2_DATA_WIDTH - 1:0] dcu_b_data;
input [(L2_DATA_WIDTH / 8) - 1:0] dcu_b_mask;
input dcu_b_corrupt;
input dcu_b_valid;
output dcu_b_ready;
output [2:0] dcu_c_opcode;
output [2:0] dcu_c_param;
output [C_UW - 1:0] dcu_c_user;
output [2:0] dcu_c_size;
output [DCU_SOURCE_WIDTH - 1:0] dcu_c_source;
output [L2_ADDR_WIDTH - 1:0] dcu_c_address;
output [L2_DATA_WIDTH - 1:0] dcu_c_data;
output dcu_c_corrupt;
output dcu_c_valid;
input dcu_c_ready;
input [2:0] dcu_d_opcode;
input [1:0] dcu_d_param;
input [D_UW - 1:0] dcu_d_user;
input [2:0] dcu_d_size;
input [DCU_SOURCE_WIDTH - 1:0] dcu_d_source;
input [L2_DATA_WIDTH - 1:0] dcu_d_data;
input dcu_d_denied;
input dcu_d_corrupt;
input [SINK_WIDTH - 1:0] dcu_d_sink;
input dcu_d_valid;
output dcu_d_ready;
output dcu_e_valid;
output [SINK_WIDTH - 1:0] dcu_e_sink;
input dcu_e_ready;
localparam D_WIDTH = 5 + D_UW + 3 + SOURCE_WIDTH + DCU_DATA_WIDTH + 1 + 1 + SINK_WIDTH;


wire [SOURCE_WIDTH - 1:0] s0;
wire [SOURCE_WIDTH - 1:0] s1;
wire [SOURCE_WIDTH - 1:0] s2;
wire [SOURCE_WIDTH - 1:0] s3;
wire s4;
wire s5;
generate
    if (CM_SUPPORT_INT == 1) begin:gen_b
        assign s4 = dcu_b_valid;
        assign dcu_b_ready = s5;
    end
    else begin:gen_b_stub
        assign s4 = 1'b0;
        assign dcu_b_ready = 1'b0;
    end
endgenerate
generate
    if ((L2_DATA_WIDTH == 256) && (DCU_DATA_WIDTH == 128)) begin:gen_a_sizeup
        reg [DCU_DATA_WIDTH - 1:0] s6;
        reg [DCU_DATA_WIDTH / 8 - 1:0] s7;
        reg s8;
        wire s9;
        wire s10;
        wire s11;
        wire s12;
        wire s13 = (agent_a_opcode == 3'd1);
        wire s14 = (agent_a_opcode == 3'd4);
        wire s15 = (agent_a_opcode == 3'd6);
        wire s16 = (agent_a_opcode == 3'd7);
        wire s17 = s15 | s16 | s14 | (s13 & (agent_a_size <= 3'd4));
        wire s18 = (s14 | s13) & (agent_a_size <= 3'd4);
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s8 <= 1'b0;
            end
            else if (s11) begin
                s8 <= s12;
            end
        end

        always @(posedge dcu_clk) begin
            if (s9) begin
                s6 <= agent_a_data;
                s7 <= agent_a_mask;
            end
        end

        assign s11 = s9 | s10;
        assign s9 = agent_a_valid & agent_a_ready & ~s17 & ~s8;
        assign s10 = dcu_a_valid & dcu_a_ready;
        assign s12 = ~s10 & (s8 | s9);
        assign dcu_a_data[0 +:DCU_DATA_WIDTH] = s8 ? s6 : agent_a_data;
        assign dcu_a_data[DCU_DATA_WIDTH +:DCU_DATA_WIDTH] = agent_a_data;
        assign dcu_a_mask[0 +:DCU_DATA_WIDTH / 8] = s8 ? s7 : (s18 & agent_a_address[4]) ? {DCU_DATA_WIDTH / 8{1'b0}} : agent_a_mask;
        assign dcu_a_mask[DCU_DATA_WIDTH / 8 +:DCU_DATA_WIDTH / 8] = (s18 & ~agent_a_address[4]) ? {DCU_DATA_WIDTH / 8{1'b0}} : agent_a_mask;
        assign dcu_a_opcode = agent_a_opcode;
        assign dcu_a_param = agent_a_param;
        assign dcu_a_size = agent_a_size;
        assign dcu_a_user = agent_a_user;
        assign s0 = agent_a_source;
        assign dcu_a_address = agent_a_address;
        assign dcu_a_corrupt = agent_a_corrupt;
        assign dcu_a_valid = agent_a_valid & (s8 | s17);
        assign agent_a_ready = dcu_a_ready | (~s17 & ~s8);
    end
    else begin:gen_a_stub
        assign dcu_a_opcode = agent_a_opcode;
        assign dcu_a_param = agent_a_param;
        assign dcu_a_user = agent_a_user;
        assign dcu_a_size = agent_a_size;
        assign s0 = agent_a_source;
        assign dcu_a_address = agent_a_address;
        assign dcu_a_data = agent_a_data;
        assign dcu_a_mask = agent_a_mask;
        assign dcu_a_corrupt = agent_a_corrupt;
        assign dcu_a_valid = agent_a_valid;
        assign agent_a_ready = dcu_a_ready;
    end
endgenerate
assign agent_b_opcode = dcu_b_opcode;
assign agent_b_param = dcu_b_param;
assign agent_b_size = dcu_b_size;
assign agent_b_source = s1;
assign agent_b_address = dcu_b_address;
assign agent_b_data = dcu_b_data[DCU_DATA_WIDTH - 1:0];
assign agent_b_mask = dcu_b_mask[DCU_DATA_WIDTH / 8 - 1:0];
assign agent_b_corrupt = dcu_b_corrupt;
assign agent_b_valid = s4;
assign s5 = agent_b_ready;
generate
    if ((L2_DATA_WIDTH == 256) && (DCU_DATA_WIDTH == 128)) begin:gen_c_sizeup
        reg [DCU_DATA_WIDTH - 1:0] s19;
        reg s20;
        wire s21;
        wire s22;
        wire s23;
        wire s24;
        wire s25 = (agent_c_opcode == 3'd4);
        wire s26 = (agent_c_opcode == 3'd6);
        wire s27 = s26 | s25;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s20 <= 1'b0;
            end
            else if (s23) begin
                s20 <= s24;
            end
        end

        always @(posedge dcu_clk) begin
            if (s21) begin
                s19 <= agent_c_data;
            end
        end

        assign s23 = s21 | s22;
        assign s21 = agent_c_valid & agent_c_ready & ~s27 & ~s20;
        assign s22 = dcu_c_valid & dcu_c_ready;
        assign s24 = ~s22 & (s20 | s21);
        assign dcu_c_data[0 +:DCU_DATA_WIDTH] = s19;
        assign dcu_c_data[DCU_DATA_WIDTH +:DCU_DATA_WIDTH] = agent_c_data;
        assign dcu_c_opcode = agent_c_opcode;
        assign dcu_c_param = agent_c_param;
        assign dcu_c_size = agent_c_size;
        assign dcu_c_user = agent_c_user;
        assign s2 = agent_c_source;
        assign dcu_c_address = agent_c_address;
        assign dcu_c_corrupt = agent_c_corrupt;
        assign dcu_c_valid = agent_c_valid & (s20 | s27);
        assign agent_c_ready = dcu_c_ready | (~s27 & ~s20);
    end
    else begin:gen_c_stub
        assign dcu_c_opcode = agent_c_opcode;
        assign dcu_c_param = agent_c_param;
        assign dcu_c_size = agent_c_size;
        assign dcu_c_user = agent_c_user;
        assign s2 = agent_c_source;
        assign dcu_c_address = agent_c_address;
        assign dcu_c_data = agent_c_data;
        assign dcu_c_corrupt = agent_c_corrupt;
        assign dcu_c_valid = agent_c_valid;
        assign agent_c_ready = dcu_c_ready;
    end
endgenerate
generate
    if ((L2_DATA_WIDTH == 256) && (DCU_DATA_WIDTH == 128)) begin:gen_d_sizeup
        reg [D_WIDTH - 1:0] s28;
        wire [D_WIDTH - 1:0] s29;
        wire [D_WIDTH - 1:0] s30;
        reg [SOURCE_DEPTH - 1:0] s31;
        wire s32;
        wire [SOURCE_DEPTH - 1:0] s33;
        wire [SOURCE_DEPTH - 1:0] s34;
        wire [SOURCE_DEPTH - 1:0] s35;
        wire [SOURCE_DEPTH - 1:0] s36;
        wire s37;
        reg s38;
        wire s39;
        wire s40;
        wire s41;
        wire s42;
        wire s43 = (dcu_d_opcode == 3'd1);
        wire s44 = (dcu_d_opcode == 3'd5);
        wire s45 = s43 | s44;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                s38 <= 1'b0;
            end
            else if (s41) begin
                s38 <= s42;
            end
        end

        always @(posedge dcu_clk) begin
            if (s32) begin
                s31 <= s33;
            end
        end

        always @(posedge dcu_clk) begin
            if (s39) begin
                s28 <= s30;
            end
        end

        kv_bin2onehot #(
            .N(SOURCE_DEPTH)
        ) u_agent_a_source_onehot (
            .out(s36),
            .in(agent_a_source)
        );
        kv_mux #(
            .N(SOURCE_DEPTH),
            .W(1)
        ) u_dcu_d_addr4 (
            .out(s37),
            .sel(s3),
            .in(s31)
        );
        assign s32 = agent_a_valid & agent_a_ready & (agent_a_size <= 3'd4) & (agent_a_opcode == 3'd4);
        assign s34 = s36 & {SOURCE_DEPTH{agent_a_address[4]}};
        assign s35 = s36 & {SOURCE_DEPTH{~agent_a_address[4]}};
        assign s33 = s34 | (~s35 & s31);
        assign {agent_d_data,agent_d_user,agent_d_corrupt,agent_d_denied,agent_d_sink,agent_d_source,agent_d_size,agent_d_param,agent_d_opcode} = s38 ? s28 : ((dcu_d_size <= 3'd4) & s37) ? s30 : s29;
        assign s29 = {dcu_d_data[0 +:DCU_DATA_WIDTH],dcu_d_user,dcu_d_corrupt,dcu_d_denied,dcu_d_sink,s3,dcu_d_size,dcu_d_param,dcu_d_opcode};
        assign s30 = {dcu_d_data[DCU_DATA_WIDTH +:DCU_DATA_WIDTH],dcu_d_user,dcu_d_corrupt,dcu_d_denied,dcu_d_sink,s3,dcu_d_size,dcu_d_param,dcu_d_opcode};
        assign s41 = s39 | s40;
        assign s39 = dcu_d_valid & dcu_d_ready & s45 & (dcu_d_size >= 3'd5);
        assign s40 = agent_d_valid & agent_d_ready & s38;
        assign s42 = s39 | (s38 & ~s40);
        assign agent_d_valid = dcu_d_valid | s38;
        assign dcu_d_ready = agent_d_ready & ~s38;
    end
    else begin:gen_d_stub
        assign agent_d_opcode = dcu_d_opcode;
        assign agent_d_param = dcu_d_param;
        assign agent_d_user = dcu_d_user;
        assign agent_d_size = dcu_d_size;
        assign agent_d_source = s3;
        assign agent_d_sink = dcu_d_sink;
        assign agent_d_data = dcu_d_data;
        assign agent_d_denied = dcu_d_denied;
        assign agent_d_corrupt = dcu_d_corrupt;
        assign agent_d_valid = dcu_d_valid;
        assign dcu_d_ready = agent_d_ready;
    end
endgenerate
assign dcu_e_valid = agent_e_valid;
assign dcu_e_sink = agent_e_sink;
assign agent_e_ready = dcu_e_ready;
kv_zero_ext #(
    .OW(DCU_SOURCE_WIDTH),
    .IW(SOURCE_WIDTH)
) u_dcu_a_source (
    .out(dcu_a_source),
    .in(s0)
);
kv_zero_ext #(
    .OW(DCU_SOURCE_WIDTH),
    .IW(SOURCE_WIDTH)
) u_dcu_c_source (
    .out(dcu_c_source),
    .in(s2)
);
assign s1 = dcu_b_source[SOURCE_WIDTH - 1:0];
assign s3 = dcu_d_source[SOURCE_WIDTH - 1:0];
endmodule

