// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_queue (
    clk,
    reset_n,
    lm_reset_done,
    ax_command_valid,
    ax_command_ready,
    ax_command_data,
    b_resp_valid,
    b_resp_ready,
    b_resp_data,
    r_resp_valid,
    r_resp_ready,
    r_resp_data,
    csr_milmb_eccen,
    csr_mdlmb_eccen,
    slvp_ipipe_local_int,
    slvp_ipipe_ecc_corr,
    slvp_ipipe_ecc_ramid,
    issue_valid,
    issue_ready,
    issue_ptr,
    issue_addr,
    issue_a_mask,
    issue_func,
    issue_user,
    ilm_w_req_ptr,
    ilm_w_req_data,
    ilm_w_req_strb,
    ilm_w_resp_ready,
    dlm0_w_req_ptr,
    dlm0_w_req_data,
    dlm0_w_req_strb,
    dlm0_w_resp_ready,
    dlm1_w_req_ptr,
    dlm1_w_req_data,
    dlm1_w_req_strb,
    dlm1_w_resp_ready,
    dlm2_w_req_ptr,
    dlm2_w_req_data,
    dlm2_w_req_strb,
    dlm2_w_resp_ready,
    dlm3_w_req_ptr,
    dlm3_w_req_data,
    dlm3_w_req_strb,
    dlm3_w_resp_ready,
    ilm_resp_valid,
    ilm_resp_ptr,
    ilm_resp_data,
    ilm_resp_status,
    dlm0_resp_valid,
    dlm0_resp_ptr,
    dlm0_resp_data,
    dlm0_resp_status,
    dlm1_resp_valid,
    dlm1_resp_ptr,
    dlm1_resp_data,
    dlm1_resp_status,
    dlm2_resp_valid,
    dlm2_resp_ptr,
    dlm2_resp_data,
    dlm2_resp_status,
    dlm3_resp_valid,
    dlm3_resp_ptr,
    dlm3_resp_data,
    dlm3_resp_status
);
parameter ID_WIDTH = 4;
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter QUEUE_DEPTH = 8;
parameter PTR_WIDTH = $clog2(QUEUE_DEPTH);
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
localparam ILM_MERGE_LSB = $clog2(64 / 8);
localparam ILM_MERGE_WIDTH = $clog2(DATA_WIDTH / 8) - ILM_MERGE_LSB;
localparam ILM_MERGE_MSB = (ILM_MERGE_WIDTH == 0) ? ILM_MERGE_LSB : ILM_MERGE_LSB + ILM_MERGE_WIDTH - 1;
localparam DLM_MERGE_LSB = $clog2(32 / 8);
localparam DLM_MERGE_WIDTH = $clog2(DATA_WIDTH / 8) - DLM_MERGE_LSB;
localparam DLM_MERGE_MSB = (DLM_MERGE_WIDTH == 0) ? DLM_MERGE_LSB : DLM_MERGE_LSB + DLM_MERGE_WIDTH - 1;
parameter AX_CMD_WIDTH = ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4;
parameter B_RESP_WIDTH = ID_WIDTH + 1;
parameter R_RESP_WIDTH = ID_WIDTH + DATA_WIDTH + 1 + 1;
localparam QUEUE_ECC_WIDTH = ((ILM_ECC_TYPE_INT == 0) & (DLM_ECC_TYPE_INT == 0)) ? 0 : 3;
localparam QUEUE_WIDTH = ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1 + QUEUE_ECC_WIDTH + 1;
input clk;
input reset_n;
input lm_reset_done;
input ax_command_valid;
output ax_command_ready;
input [(AX_CMD_WIDTH - 1):0] ax_command_data;
output b_resp_valid;
input b_resp_ready;
output [(B_RESP_WIDTH - 1):0] b_resp_data;
output r_resp_valid;
input r_resp_ready;
output [(R_RESP_WIDTH - 1):0] r_resp_data;
input [1:0] csr_milmb_eccen;
input [1:0] csr_mdlmb_eccen;
output slvp_ipipe_local_int;
output slvp_ipipe_ecc_corr;
output [3:0] slvp_ipipe_ecc_ramid;
output issue_valid;
input issue_ready;
output [(PTR_WIDTH - 1):0] issue_ptr;
output [(ADDR_WIDTH - 1):0] issue_addr;
output [1:0] issue_a_mask;
output [1:0] issue_func;
output issue_user;
input [(PTR_WIDTH - 1):0] ilm_w_req_ptr;
output [63:0] ilm_w_req_data;
output [7:0] ilm_w_req_strb;
input ilm_w_resp_ready;
input [(PTR_WIDTH - 1):0] dlm0_w_req_ptr;
output [63:0] dlm0_w_req_data;
output [7:0] dlm0_w_req_strb;
input dlm0_w_resp_ready;
input [(PTR_WIDTH - 1):0] dlm1_w_req_ptr;
output [63:0] dlm1_w_req_data;
output [7:0] dlm1_w_req_strb;
input dlm1_w_resp_ready;
input [(PTR_WIDTH - 1):0] dlm2_w_req_ptr;
output [63:0] dlm2_w_req_data;
output [7:0] dlm2_w_req_strb;
input dlm2_w_resp_ready;
input [(PTR_WIDTH - 1):0] dlm3_w_req_ptr;
output [63:0] dlm3_w_req_data;
output [7:0] dlm3_w_req_strb;
input dlm3_w_resp_ready;
input ilm_resp_valid;
input [(PTR_WIDTH - 1):0] ilm_resp_ptr;
input [63:0] ilm_resp_data;
input [13:0] ilm_resp_status;
input dlm0_resp_valid;
input [(PTR_WIDTH - 1):0] dlm0_resp_ptr;
input [63:0] dlm0_resp_data;
input [13:0] dlm0_resp_status;
input dlm1_resp_valid;
input [(PTR_WIDTH - 1):0] dlm1_resp_ptr;
input [63:0] dlm1_resp_data;
input [13:0] dlm1_resp_status;
input dlm2_resp_valid;
input [(PTR_WIDTH - 1):0] dlm2_resp_ptr;
input [63:0] dlm2_resp_data;
input [13:0] dlm2_resp_status;
input dlm3_resp_valid;
input [(PTR_WIDTH - 1):0] dlm3_resp_ptr;
input [63:0] dlm3_resp_data;
input [13:0] dlm3_resp_status;


reg [PTR_WIDTH:0] wptr;
wire wptr_en;
wire [PTR_WIDTH:0] wptr_nx;
wire wptr_full;
reg [PTR_WIDTH:0] rptr;
wire rptr_en;
wire [PTR_WIDTH:0] rptr_nx;
wire rptr_empty;
reg [PTR_WIDTH:0] ret_ptr;
wire ret_ptr_en;
wire [PTR_WIDTH:0] ret_ptr_nx;
wire ret_ptr_empty;
reg [(QUEUE_WIDTH - 1):0] queue_data[0:(QUEUE_DEPTH - 1)];
wire [(QUEUE_DEPTH - 1):0] queue_idle;
wire resp_valid;
wire need_replay;
wire need_retire;
wire replay_valid;
wire retire_valid;
wire [7:0] retire_tot_len;
wire [7:0] retire_cur_len;
wire [3:0] retire_tot_pkt;
wire [3:0] retire_cur_pkt;
wire retire_write;
wire retire_dlm;
wire [63:0] retire_data;
wire [3:0] retire_status;
wire retire_ecc_replayed;
wire retire_ready;
wire [(DATA_WIDTH - 1):0] load_merge_data;
wire [(DATA_WIDTH - 1):0] load_merge_ilm_data;
wire [(DATA_WIDTH - 1):0] load_merge_dlm_data;
reg [(DATA_WIDTH - 1):0] load_buf;
wire load_buf_en;
reg [1:0] resp_buf;
wire [1:0] resp_buf_nx;
reg issue_suspend;
wire issue_suspend_set;
wire issue_suspend_clr;
wire issue_suspend_nx;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        wptr <= {(PTR_WIDTH + 1){1'b0}};
    end
    else if (wptr_en) begin
        wptr <= wptr_nx;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rptr <= {(PTR_WIDTH + 1){1'b0}};
    end
    else if (rptr_en) begin
        rptr <= rptr_nx;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ret_ptr <= {(PTR_WIDTH + 1){1'b0}};
    end
    else if (ret_ptr_en) begin
        ret_ptr <= ret_ptr_nx;
    end
end

assign wptr_full = ((ret_ptr[PTR_WIDTH] == ~wptr[PTR_WIDTH]) & (ret_ptr[(PTR_WIDTH - 1):0] == wptr[(PTR_WIDTH - 1):0]));
assign rptr_empty = (rptr[PTR_WIDTH:0] == wptr[PTR_WIDTH:0]);
assign ret_ptr_empty = (ret_ptr[PTR_WIDTH:0] == rptr[PTR_WIDTH:0]);
assign ax_command_ready = ~wptr_full;
assign wptr_en = ax_command_valid & ax_command_ready;
assign wptr_nx = wptr + {{(PTR_WIDTH){1'b0}},1'b1};
assign rptr_en = (issue_valid & issue_ready) | replay_valid;
assign rptr_nx = replay_valid ? ret_ptr : rptr + {{(PTR_WIDTH){1'b0}},1'b1};
assign ret_ptr_en = retire_valid & retire_ready;
assign ret_ptr_nx = ret_ptr + {{(PTR_WIDTH){1'b0}},1'b1};
assign issue_valid = ~(rptr_empty | issue_suspend) & lm_reset_done;
assign issue_ptr = rptr[(PTR_WIDTH - 1):0];
assign issue_addr = queue_data[rptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH) +:ADDR_WIDTH];
assign issue_a_mask = queue_data[rptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8) +:2];
assign issue_func = queue_data[rptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2) +:2];
assign issue_user = queue_data[rptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8) +:1];
assign ilm_w_req_data = queue_data[ilm_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
assign ilm_w_req_strb = queue_data[ilm_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
assign dlm0_w_req_data = queue_data[dlm0_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
assign dlm0_w_req_strb = queue_data[dlm0_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
assign dlm1_w_req_data = queue_data[dlm1_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
assign dlm1_w_req_strb = queue_data[dlm1_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
assign dlm2_w_req_data = queue_data[dlm2_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
assign dlm2_w_req_strb = queue_data[dlm2_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
assign dlm3_w_req_data = queue_data[dlm3_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
assign dlm3_w_req_strb = queue_data[dlm3_w_req_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
assign resp_valid = ~ret_ptr_empty & queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] & (~queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 1) +:1] | queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1) +:1]);
generate
    if (QUEUE_ECC_WIDTH == 0) begin:gen_need_replay_non_ecc
        assign need_replay = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:1];
    end
    else begin:gen_need_replay_ecc
        assign need_replay = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:1] | queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1) +:1];
    end
endgenerate
assign need_retire = ~need_replay;
assign replay_valid = resp_valid & need_replay & (&queue_idle);
assign retire_valid = resp_valid & need_retire & ~ret_ptr_empty;
assign retire_tot_len = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH) +:8];
assign retire_cur_len = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2) +:8];
assign retire_tot_pkt = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8) +:4];
assign retire_cur_pkt = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4) +:4];
assign retire_write = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 1) +:1];
assign retire_dlm = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8) +:1];
assign retire_data = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64];
generate
    if (QUEUE_ECC_WIDTH == 0) begin:gen_retire_status_non_ecc
        assign retire_status = {queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1) +:1],2'b0,queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:1]};
    end
    else begin:gen_retire_status_ecc
        assign retire_status = {queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3 + 1) +:1],queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:3]};
    end
endgenerate
generate
    if (QUEUE_ECC_WIDTH == 0) begin:gen_retire_ecc_replayed_non_ecc
        assign retire_ecc_replayed = 1'b0;
    end
    else begin:gen_retire_ecc_replayed_ecc
        assign retire_ecc_replayed = queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3) +:1];
    end
endgenerate
assign retire_ready = (b_resp_valid & b_resp_ready) | (r_resp_valid & r_resp_ready) | ~(retire_tot_pkt == retire_cur_pkt) | retire_write & ~(retire_tot_len == retire_cur_len);
assign b_resp_valid = retire_valid & retire_write & (retire_tot_len == retire_cur_len) & (retire_tot_pkt == retire_cur_pkt);
assign b_resp_data = {((|resp_buf) | retire_status[2] | retire_status[3]),queue_data[ret_ptr[(PTR_WIDTH - 1):0]][0 +:ID_WIDTH]};
assign r_resp_valid = retire_valid & ~retire_write & (retire_tot_pkt == retire_cur_pkt);
assign r_resp_data = {(retire_tot_len == retire_cur_len),load_merge_data,((|resp_buf) | retire_status[2] | retire_status[3]),queue_data[ret_ptr[(PTR_WIDTH - 1):0]][0 +:ID_WIDTH]};
generate
    genvar ilm_merge_loop;
    if (ILM_MERGE_WIDTH == 0) begin:gen_merge_ilm_dw_eq
        assign load_merge_ilm_data = retire_data;
        wire [(DATA_WIDTH - 1):0] nds_unused_load_buf = load_buf;
    end
    else begin:gen_merge_ilm_dw_neq
        for (ilm_merge_loop = 0; ilm_merge_loop < (2 ** ILM_MERGE_WIDTH); ilm_merge_loop = ilm_merge_loop + 1) begin:gen_merge_ilm_data
            assign load_merge_ilm_data[ilm_merge_loop * 64 +:64] = (queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + ILM_MERGE_MSB):(0 + ID_WIDTH + ILM_MERGE_LSB)] == ilm_merge_loop[(ILM_MERGE_WIDTH - 1):0]) ? retire_data[0 +:64] : load_buf[ilm_merge_loop * 64 +:64];
        end
    end
endgenerate
generate
    genvar dlm_merge_loop;
    if (DLM_MERGE_WIDTH == 0) begin:gen_merge_dlm_dw_eq
        assign load_merge_dlm_data = retire_data;
        wire [(DATA_WIDTH - 1):0] nds_unused_load_buf = load_buf;
    end
    else begin:gen_merge_dlm_dw_neq
        for (dlm_merge_loop = 0; dlm_merge_loop < (2 ** DLM_MERGE_WIDTH); dlm_merge_loop = dlm_merge_loop + 1) begin:gen_merge_dlm_data
            assign load_merge_dlm_data[dlm_merge_loop * 32 +:32] = (queue_data[ret_ptr[(PTR_WIDTH - 1):0]][(0 + ID_WIDTH + DLM_MERGE_MSB):(0 + ID_WIDTH + DLM_MERGE_LSB)] == dlm_merge_loop[(DLM_MERGE_WIDTH - 1):0]) ? retire_data[0 +:32] : load_buf[dlm_merge_loop * 32 +:32];
        end
    end
endgenerate
assign load_merge_data = retire_dlm ? load_merge_dlm_data : load_merge_ilm_data;
assign load_buf_en = retire_valid & retire_ready;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        load_buf <= {DATA_WIDTH{1'b0}};
    end
    else if (load_buf_en) begin
        load_buf <= load_merge_data;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        resp_buf <= 2'b0;
    end
    else if (load_buf_en) begin
        resp_buf <= resp_buf_nx;
    end
end

assign resp_buf_nx = ((b_resp_valid & b_resp_ready) | (r_resp_valid & r_resp_ready)) ? 2'b0 : resp_buf | {retire_status[3],retire_status[2]};
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        issue_suspend <= 1'b0;
    end
    else if (issue_suspend_clr) begin
        issue_suspend <= 1'b0;
    end
    else if (issue_suspend_set) begin
        issue_suspend <= issue_suspend_nx;
    end
end

assign issue_suspend_nx = issue_suspend | (ilm_resp_valid & (|ilm_resp_status[1:0])) | (dlm0_resp_valid & (|dlm0_resp_status[1:0])) | (dlm1_resp_valid & (|dlm1_resp_status[1:0])) | (dlm2_resp_valid & (|dlm2_resp_status[1:0])) | (dlm3_resp_valid & (|dlm3_resp_status[1:0]));
assign issue_suspend_set = ilm_resp_valid | dlm0_resp_valid | dlm1_resp_valid | dlm2_resp_valid | dlm3_resp_valid;
assign issue_suspend_clr = replay_valid | ret_ptr_empty;
generate
    genvar i;
    for (i = 0; i < QUEUE_DEPTH; i = i + 1) begin:gen_queue
        wire update_new = wptr_en & (wptr[(PTR_WIDTH - 1):0] == i[(PTR_WIDTH - 1):0]);
        wire update_issue = rptr_en & (rptr[(PTR_WIDTH - 1):0] == i[(PTR_WIDTH - 1):0]) & ~issue_suspend;
        wire update_resp_ilm = (ilm_resp_valid & (ilm_resp_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_dlm0 = (dlm0_resp_valid & (dlm0_resp_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_dlm1 = (dlm1_resp_valid & (dlm1_resp_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_dlm2 = (dlm2_resp_valid & (dlm2_resp_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_dlm3 = (dlm3_resp_valid & (dlm3_resp_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp = update_resp_ilm | update_resp_dlm0 | update_resp_dlm1 | update_resp_dlm2 | update_resp_dlm3;
        wire update_resp_w_ilm = (ilm_w_resp_ready & (ilm_w_req_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_w_dlm0 = (dlm0_w_resp_ready & (dlm0_w_req_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_w_dlm1 = (dlm1_w_resp_ready & (dlm1_w_req_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_w_dlm2 = (dlm2_w_resp_ready & (dlm2_w_req_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_w_dlm3 = (dlm3_w_resp_ready & (dlm3_w_req_ptr == i[(PTR_WIDTH - 1):0]));
        wire update_resp_w = update_resp_w_ilm | update_resp_w_dlm0 | update_resp_w_dlm1 | update_resp_w_dlm2 | update_resp_w_dlm3;
        wire update_retire = ret_ptr_en & (ret_ptr[(PTR_WIDTH - 1):0] == i[(PTR_WIDTH - 1):0]);
        wire [63:0] data_nx = ({64{update_new}} & ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64]) | ({64{update_resp_ilm}} & ilm_resp_data) | ({64{update_resp_dlm0}} & dlm0_resp_data) | ({64{update_resp_dlm1}} & dlm1_resp_data) | ({64{update_resp_dlm2}} & dlm2_resp_data) | ({64{update_resp_dlm3}} & dlm3_resp_data);
        wire resp_cnt_inc;
        wire resp_cnt_dec;
        wire resp_cnt_en = resp_cnt_inc | resp_cnt_dec;
        reg [1:0] resp_cnt;
        wire [1:0] resp_cnt_nx;
        wire w_cnt_inc;
        wire w_cnt_dec;
        wire w_cnt_en = w_cnt_inc | w_cnt_dec;
        reg [1:0] w_cnt;
        wire [1:0] w_cnt_nx;
        wire resp_valid_nx = update_resp;
        wire resp_w_valid_nx = update_resp_w & (w_cnt_nx == 2'b0);
        wire [13:0] resp_status_nx = ({14{update_resp_ilm}} & ilm_resp_status) | ({14{update_resp_dlm0}} & dlm0_resp_status) | ({14{update_resp_dlm1}} & dlm1_resp_status) | ({14{update_resp_dlm2}} & dlm2_resp_status) | ({14{update_resp_dlm3}} & dlm3_resp_status);
        wire resp_ecc_replayed_nx;
        if (QUEUE_ECC_WIDTH == 0) begin:gen_resp_ecc_replayed_nx_non_ecc
            assign resp_ecc_replayed_nx = 1'b0;
        end
        else begin:gen_resp_ecc_replayed_nx_ecc
            assign resp_ecc_replayed_nx = (update_issue & queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] & queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1) +:1]) | (update_issue & queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3) +:1]);
        end
        wire resp_write = queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 1) +:1];
        assign resp_cnt_inc = update_issue;
        assign resp_cnt_dec = update_resp;
        assign resp_cnt_nx = resp_cnt + {1'b0,resp_cnt_inc} - {1'b0,resp_cnt_dec};
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                resp_cnt <= 2'b0;
            end
            else if (resp_cnt_en) begin
                resp_cnt <= resp_cnt_nx;
            end
        end

        assign w_cnt_inc = update_issue & resp_write;
        assign w_cnt_dec = update_resp_w;
        assign w_cnt_nx = w_cnt + {1'b0,w_cnt_inc} - {1'b0,w_cnt_dec};
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                w_cnt <= 2'b0;
            end
            else if (w_cnt_en) begin
                w_cnt <= w_cnt_nx;
            end
        end

        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                queue_data[i][0 +:ID_WIDTH] <= {(ID_WIDTH){1'b0}};
                queue_data[i][(0 + ID_WIDTH) +:ADDR_WIDTH] <= {(ADDR_WIDTH){1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH) +:8] <= {8{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8) +:1] <= {1{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8] <= {8{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8) +:2] <= {2{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2) +:2] <= {2{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2) +:8] <= {8{1'b0}};
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8) +:4] <= 4'b0;
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4) +:4] <= 4'b0;
            end
            else if (update_new) begin
                queue_data[i][0 +:ID_WIDTH] <= ax_command_data[0 +:ID_WIDTH];
                queue_data[i][(0 + ID_WIDTH) +:ADDR_WIDTH] <= ax_command_data[(0 + ID_WIDTH) +:ADDR_WIDTH];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH) +:8] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH) +:8];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8) +:1] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8) +:1];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64) +:8];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8) +:2] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8) +:2];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2) +:2] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2) +:2];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2) +:8] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2) +:8];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8) +:4] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8) +:4];
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4) +:4] <= ax_command_data[(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4) +:4];
            end
        end

        wire queue_data_update_en = update_new | (update_resp & !resp_write);
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64] <= {64{1'b0}};
            end
            else if (queue_data_update_en) begin
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1) +:64] <= data_nx;
            end
        end

        wire queue_w_valid_update_en = update_issue | update_resp_w | update_retire;
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1) +:1] <= {1{1'b0}};
            end
            else if (queue_w_valid_update_en) begin
                queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1) +:1] <= resp_w_valid_nx;
            end
        end

        if (QUEUE_ECC_WIDTH == 0) begin:gen_queue_data_non_ecc
            wire queue_resp_update_en = update_issue | update_resp | update_retire;
            always @(posedge clk or negedge reset_n) begin
                if (!reset_n) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] <= {1{1'b0}};
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:1] <= {1{1'b0}};
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1) +:1] <= {1{1'b0}};
                end
                else if (queue_resp_update_en) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] <= resp_valid_nx;
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:1] <= resp_status_nx[0];
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 1) +:1] <= resp_status_nx[13];
                end
            end

            wire nds_unused_resp_ecc_replayed_nx = resp_ecc_replayed_nx;
        end
        else begin:gen_queue_data_nx_ecc
            wire queue_resp_update_en = update_issue | update_resp | update_retire;
            wire queue_ecc_update_en = update_new | update_issue;
            always @(posedge clk or negedge reset_n) begin
                if (!reset_n) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] <= {1{1'b0}};
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:3] <= {3{1'b0}};
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3 + 1) +:1] <= {1{1'b0}};
                end
                else if (queue_resp_update_en) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4) +:1] <= resp_valid_nx;
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1) +:3] <= resp_status_nx[2:0];
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3 + 1) +:1] <= resp_status_nx[13];
                end
            end

            always @(posedge clk or negedge reset_n) begin
                if (!reset_n) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3) +:1] <= {1{1'b0}};
                end
                else if (queue_ecc_update_en) begin
                    queue_data[i][(0 + ID_WIDTH + ADDR_WIDTH + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4 + 1 + 1 + 3) +:1] <= resp_ecc_replayed_nx;
                end
            end

        end
        assign queue_idle[i] = (resp_cnt == 2'b0) && (w_cnt == 2'b0);
    end
endgenerate
assign slvp_ipipe_ecc_corr = retire_ecc_replayed;
wire slvp_ipipe_ecc_uncorr = resp_buf[0] | retire_status[2];
assign slvp_ipipe_ecc_ramid = {3'b100,retire_dlm};
wire slvp_ipipe_corr_local_int = (~retire_dlm & (csr_milmb_eccen == 2'b11) & (slvp_ipipe_ecc_corr)) | (retire_dlm & (csr_mdlmb_eccen == 2'b11) & (slvp_ipipe_ecc_corr));
wire slvp_ipipe_uncorr_local_int = (~retire_dlm & (csr_milmb_eccen[1] == 1'b1) & (slvp_ipipe_ecc_uncorr)) | (retire_dlm & (csr_mdlmb_eccen[1] == 1'b1) & (slvp_ipipe_ecc_uncorr));
assign slvp_ipipe_local_int = retire_valid & retire_ready & (slvp_ipipe_corr_local_int | slvp_ipipe_uncorr_local_int);
endmodule

