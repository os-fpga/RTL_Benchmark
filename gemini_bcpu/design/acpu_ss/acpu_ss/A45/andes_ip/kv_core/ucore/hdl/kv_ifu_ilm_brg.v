// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_ifu_ilm_brg (
    core_clk,
    core_reset_n,
    ifu_ilm_kill,
    ifu_ilm_req_valid,
    ifu_ilm_req_stall,
    ifu_ilm_req_addr,
    ifu_ilm_req_tag,
    ilm_ifu_req_ready,
    ilm_ifu_resp_valid,
    ilm_ifu_resp_rdata,
    ilm_ifu_resp_tag,
    ilm_ifu_resp_status,
    ifu_ilm_a_addr,
    ifu_ilm_a_func,
    ifu_ilm_a_ready,
    ifu_ilm_a_stall,
    ifu_ilm_a_user,
    ifu_ilm_a_valid,
    ifu_ilm_d_data,
    ifu_ilm_d_status,
    ifu_ilm_d_user,
    ifu_ilm_d_valid
);
parameter VALEN = 32;
parameter ILM_AMSB = 10;
localparam QUEUE_DEPTH = 3;
input core_clk;
input core_reset_n;
input ifu_ilm_kill;
input ifu_ilm_req_valid;
input ifu_ilm_req_stall;
input [VALEN - 1:0] ifu_ilm_req_addr;
input ifu_ilm_req_tag;
output ilm_ifu_req_ready;
output [3:0] ilm_ifu_resp_valid;
output [63:0] ilm_ifu_resp_rdata;
output ilm_ifu_resp_tag;
output [35:0] ilm_ifu_resp_status;
output [ILM_AMSB:0] ifu_ilm_a_addr;
output [2:0] ifu_ilm_a_func;
input ifu_ilm_a_ready;
output ifu_ilm_a_stall;
output [2:0] ifu_ilm_a_user;
output ifu_ilm_a_valid;
input [63:0] ifu_ilm_d_data;
input [13:0] ifu_ilm_d_status;
input [2:0] ifu_ilm_d_user;
input ifu_ilm_d_valid;


reg [QUEUE_DEPTH - 1:0] s0;
wire [QUEUE_DEPTH - 1:0] s1;
wire [QUEUE_DEPTH - 1:0] s2;
wire [QUEUE_DEPTH - 1:0] s3;
wire [QUEUE_DEPTH - 1:0] s4;
wire [QUEUE_DEPTH - 1:0] s5;
wire s6;
wire s7;
wire s8;
wire [1:0] s9;
wire [3:0] s10;
wire [QUEUE_DEPTH - 1:0] s11;
reg [QUEUE_DEPTH - 1:0] s12;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s0 <= {(QUEUE_DEPTH){1'b0}};
    end
    else begin
        s0 <= s1;
    end
end

kv_cnt_onehot #(
    .N(QUEUE_DEPTH)
) u_a_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(s6),
    .up_dn(1'b1),
    .load(1'b0),
    .data({(QUEUE_DEPTH){1'b0}}),
    .cnt(s4)
);
kv_cnt_onehot #(
    .N(QUEUE_DEPTH)
) u_d_ptr (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(s7),
    .up_dn(1'b1),
    .load(1'b0),
    .data({(QUEUE_DEPTH){1'b0}}),
    .cnt(s5)
);
kv_mux_onehot #(
    .N(QUEUE_DEPTH),
    .W(1)
) u_d_killed (
    .out(s8),
    .sel(s5),
    .in(s0)
);
generate
    genvar i;
    for (i = 0; i < QUEUE_DEPTH; i = i + 1) begin:gen_resp_inflight
        always @(posedge core_clk or negedge core_reset_n) begin
            if (!core_reset_n) begin
                s12[i] <= 1'b0;
            end
            else if (s7 & s5[i]) begin
                s12[i] <= 1'b0;
            end
            else if (s6 & s4[i]) begin
                s12[i] <= 1'b1;
            end
        end

        assign s11[i] = s12[i] & ~(ifu_ilm_d_valid & ~s8);
    end
endgenerate
assign s6 = ifu_ilm_a_valid & ifu_ilm_a_ready & ~ifu_ilm_a_stall;
assign s7 = ifu_ilm_d_valid;
assign s1 = ~s3 & (s0 | s2);
assign s2 = {(QUEUE_DEPTH){ifu_ilm_kill}};
assign s3 = s4 & {(QUEUE_DEPTH){s6}};
assign ifu_ilm_a_valid = ifu_ilm_req_valid;
assign ifu_ilm_a_addr = ifu_ilm_req_addr[ILM_AMSB:0];
assign ifu_ilm_a_func[0] = 1'b1;
assign ifu_ilm_a_func[1] = 1'b0;
assign ifu_ilm_a_func[2] = 1'b0;
assign ifu_ilm_a_user = {ifu_ilm_req_addr[2:1],ifu_ilm_req_tag};
assign ifu_ilm_a_stall = ifu_ilm_req_stall;
assign ilm_ifu_req_ready = ifu_ilm_a_ready;
assign {s9,ilm_ifu_resp_tag} = ifu_ilm_d_user;
kv_mux #(
    .N(4),
    .W(64)
) u_ilm_ifu_resp_rdata (
    .out(ilm_ifu_resp_rdata),
    .sel(s9),
    .in({48'd0,ifu_ilm_d_data[63:48],32'd0,ifu_ilm_d_data[63:32],16'd0,ifu_ilm_d_data[63:16],ifu_ilm_d_data[63:0]})
);
kv_mux #(
    .N(4),
    .W(4)
) u_d_mask (
    .out(s10),
    .sel(s9),
    .in({4'h1,4'h3,4'h7,4'hf})
);
assign ilm_ifu_resp_valid = {4{ifu_ilm_d_valid & ~s8}} & s10;
assign ilm_ifu_resp_status[0] = ifu_ilm_d_status[13];
assign ilm_ifu_resp_status[1 +:4] = {4{ifu_ilm_d_status[1] | ifu_ilm_d_status[2]}};
assign ilm_ifu_resp_status[16 +:2] = ifu_ilm_d_status[11 +:2];
assign ilm_ifu_resp_status[5 +:2] = 2'b01;
assign ilm_ifu_resp_status[7 +:8] = ifu_ilm_d_status[3 +:8];
assign ilm_ifu_resp_status[15] = ifu_ilm_d_status[1];
assign ilm_ifu_resp_status[18 +:4] = 4'd0;
assign ilm_ifu_resp_status[22] = 1'd0;
assign ilm_ifu_resp_status[23 +:4] = 4'd0;
assign ilm_ifu_resp_status[27 +:4] = 4'd0;
assign ilm_ifu_resp_status[31 +:3] = 3'd0;
assign ilm_ifu_resp_status[34] = ifu_ilm_d_status[0];
kv_mux_onehot #(
    .N(QUEUE_DEPTH),
    .W(1)
) u_ilm_ifu_resp_status_wait (
    .out(ilm_ifu_resp_status[35]),
    .sel(s5),
    .in(s11)
);
endmodule

