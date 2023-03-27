// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_sink_id_pool(
    	  clk,
    	  resetn,
    	  req_valid,
    	  rsp_valid,
    	  rsp_sink,
    	  ack_valid,
    	  ack_sink,
    	  busy,
    	  next_sink
);

parameter SINK_WIDTH = 3;

localparam ENT_NUM = 2**SINK_WIDTH;

input clk;
input resetn;

input                   req_valid;
input                   rsp_valid;
input  [SINK_WIDTH-1:0] rsp_sink;
input                   ack_valid;
input  [SINK_WIDTH-1:0] ack_sink;

output                  busy;
output [SINK_WIDTH-1:0] next_sink;

wire          [ENT_NUM-1:0] ent_enq_valid;
wire          [ENT_NUM-1:0] ent_rsp_valid;
wire          [ENT_NUM-1:0] ent_deq_valid;
wire          [ENT_NUM-1:0] ent_valid;

wire          [ENT_NUM-1:0] avalible_idx;
wire          [ENT_NUM-1:0] next_idx;
wire          [ENT_NUM-1:0] ack_idx;
wire          [ENT_NUM-1:0] rsp_idx;

atctlc2axi500_ffs #(.WIDTH(ENT_NUM)) u_next_idx (.out(next_idx), .in(avalible_idx));
atctlc2axi500_onehot2bin #(.N(ENT_NUM)) u_next_sink (.out(next_sink), .in(next_idx));

atctlc2axi500_bin2onehot #(.N(ENT_NUM)) u_ack_idx (.out(ack_idx), .in(ack_sink));
atctlc2axi500_bin2onehot #(.N(ENT_NUM)) u_rsp_sink (.out(rsp_idx), .in(rsp_sink));

assign busy          = &ent_valid;
assign avalible_idx  = ~ent_valid;
assign ent_enq_valid = {ENT_NUM{req_valid}} & next_idx;
assign ent_rsp_valid = {ENT_NUM{rsp_valid}} & rsp_idx;
assign ent_deq_valid = {ENT_NUM{ack_valid}} & ack_idx;

generate
genvar i;
for(i = 0; i < ENT_NUM; i = i + 1)begin : gen_ent
    atctlc2axi500_sink_id_ent
    u_sink_id_ent(
        .clk(clk),
        .resetn(resetn),
        .enq_valid(ent_enq_valid[i]),
        .rsp_valid(ent_rsp_valid[i]),
        .deq_valid(ent_deq_valid[i]),
        .valid(ent_valid[i])
    );
end
endgenerate

endmodule
