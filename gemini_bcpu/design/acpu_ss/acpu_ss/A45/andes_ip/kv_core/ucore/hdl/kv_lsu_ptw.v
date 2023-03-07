// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_lsu_ptw (
    core_clk,
    core_reset_n,
    mmu_ptw_req_valid,
    mmu_ptw_req_pa,
    ptw_mmu_req_ready,
    ptw_mmu_resp_valid,
    ptw_mmu_resp_status,
    ptw_mmu_resp_data,
    ptw_req_valid,
    ptw_req_pa,
    ptw_req_func,
    ptw_req_ready,
    ptw_ack_valid,
    ptw_ack_result,
    ptw_ack_status
);
parameter PALEN = 32;
input core_clk;
input core_reset_n;
input mmu_ptw_req_valid;
input [(PALEN - 1):0] mmu_ptw_req_pa;
output ptw_mmu_req_ready;
output ptw_mmu_resp_valid;
output [16:0] ptw_mmu_resp_status;
output [31:0] ptw_mmu_resp_data;
output ptw_req_valid;
output [PALEN - 1:0] ptw_req_pa;
output [36:0] ptw_req_func;
input ptw_req_ready;
input ptw_ack_valid;
input [31:0] ptw_ack_result;
input [44:0] ptw_ack_status;


wire s0;
wire s1;
wire [(PALEN - 1):0] s2;
wire s3;
reg s4;
wire s5;
wire s6;
wire s7;
wire s8;
wire s9;
assign s9 = ptw_ack_status[13] | ptw_ack_status[15] | ptw_ack_status[14];
assign s3 = ptw_req_valid & ptw_req_ready;
always @(posedge core_clk or negedge core_reset_n) begin
    if (!core_reset_n) begin
        s4 <= 1'b0;
    end
    else begin
        s4 <= s5;
    end
end

wire [2:0] nds_unused_defer_cnt;
kv_cnt_scnto #(
    .W(3),
    .COUNT_TO(3'd7)
) u_defer_cnt (
    .clk(core_clk),
    .rst_n(core_reset_n),
    .en(s8),
    .up_dn(1'b1),
    .load(s7),
    .data(3'h0),
    .cnt(nds_unused_defer_cnt),
    .tercnt(s6)
);
kv_eb_half #(
    .WIDTH(PALEN)
) u_req_pa (
    .clk(core_clk),
    .reset_n(core_reset_n),
    .wvalid(mmu_ptw_req_valid),
    .wready(ptw_mmu_req_ready),
    .wdata(mmu_ptw_req_pa),
    .rvalid(s0),
    .rready(s1),
    .rdata(s2)
);
assign ptw_req_valid = s0 & ~s4 & s6;
assign ptw_req_pa = s2;
assign ptw_req_func[0 +:2] = 2'd2;
assign ptw_req_func[34 +:3] = 3'd2;
assign ptw_req_func[2] = 1'b1;
assign ptw_req_func[3] = 1'b0;
assign ptw_req_func[4] = 1'b0;
assign ptw_req_func[5] = 1'b0;
assign ptw_req_func[6] = 1'b0;
assign ptw_req_func[7] = 1'b0;
assign ptw_req_func[8] = 1'b0;
assign ptw_req_func[9] = 1'b0;
assign ptw_req_func[10] = 1'b0;
assign ptw_req_func[11] = 1'b0;
assign ptw_req_func[12 +:4] = 4'd0;
assign ptw_req_func[16] = 1'd0;
assign ptw_req_func[17 +:5] = 5'd0;
assign ptw_req_func[22] = 1'd0;
assign ptw_req_func[23] = 1'd0;
assign ptw_req_func[24] = 1'd0;
assign ptw_req_func[25] = 1'd0;
assign ptw_req_func[29] = 1'd0;
assign ptw_req_func[26] = 1'd0;
assign ptw_req_func[27] = 1'd1;
assign ptw_req_func[28] = 1'd0;
assign ptw_req_func[30] = 1'd0;
assign ptw_req_func[31] = 1'd0;
assign ptw_req_func[32] = 1'd1;
assign ptw_req_func[33] = 1'd0;
assign s5 = s3 | (s4 & ~ptw_ack_valid);
assign s7 = ptw_ack_valid & s9;
assign s8 = ~s6 | s7;
assign ptw_mmu_resp_valid = ptw_ack_valid & ~s9;
assign ptw_mmu_resp_status = {ptw_ack_status[31 +:4],ptw_ack_status[30],ptw_ack_status[22 +:8],ptw_ack_status[8 +:3],ptw_ack_status[1]};
assign ptw_mmu_resp_data = ptw_ack_result;
assign s1 = ptw_mmu_resp_valid;
endmodule

