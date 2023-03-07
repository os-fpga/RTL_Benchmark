// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_dispatch (
    clk,
    reset_n,
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
    dlm3_resp_status,
    slv_ilm_a_valid,
    slv_ilm_a_stall,
    slv_ilm_a_ready,
    slv_ilm_a_addr,
    slv_ilm_a_mask,
    slv_ilm_a_func,
    slv_ilm_a_user,
    slv_ilm_d_valid,
    slv_ilm_d_data,
    slv_ilm_d_status,
    slv_ilm_d_user,
    slv_ilm_w_valid,
    slv_ilm_w_data,
    slv_ilm_w_mask,
    slv_ilm_w_ready,
    slv_dlm0_a_valid,
    slv_dlm0_a_stall,
    slv_dlm0_a_ready,
    slv_dlm0_a_addr,
    slv_dlm0_a_func,
    slv_dlm0_a_user,
    slv_dlm0_d_valid,
    slv_dlm0_d_data,
    slv_dlm0_d_status,
    slv_dlm0_d_user,
    slv_dlm0_w_valid,
    slv_dlm0_w_data,
    slv_dlm0_w_mask,
    slv_dlm0_w_ready,
    slv_dlm1_a_valid,
    slv_dlm1_a_stall,
    slv_dlm1_a_ready,
    slv_dlm1_a_addr,
    slv_dlm1_a_func,
    slv_dlm1_a_user,
    slv_dlm1_d_valid,
    slv_dlm1_d_data,
    slv_dlm1_d_status,
    slv_dlm1_d_user,
    slv_dlm1_w_valid,
    slv_dlm1_w_data,
    slv_dlm1_w_mask,
    slv_dlm1_w_ready,
    slv_dlm2_a_valid,
    slv_dlm2_a_stall,
    slv_dlm2_a_ready,
    slv_dlm2_a_addr,
    slv_dlm2_a_func,
    slv_dlm2_a_user,
    slv_dlm2_d_valid,
    slv_dlm2_d_data,
    slv_dlm2_d_status,
    slv_dlm2_d_user,
    slv_dlm2_w_valid,
    slv_dlm2_w_data,
    slv_dlm2_w_mask,
    slv_dlm2_w_ready,
    slv_dlm3_a_valid,
    slv_dlm3_a_stall,
    slv_dlm3_a_ready,
    slv_dlm3_a_addr,
    slv_dlm3_a_func,
    slv_dlm3_a_user,
    slv_dlm3_d_valid,
    slv_dlm3_d_data,
    slv_dlm3_d_status,
    slv_dlm3_d_user,
    slv_dlm3_w_valid,
    slv_dlm3_w_data,
    slv_dlm3_w_mask,
    slv_dlm3_w_ready
);
parameter ADDR_WIDTH = 32;
parameter ILM_UW = 1;
parameter DLM_UW = 1;
parameter QUEUE_DEPTH = 8;
parameter PTR_WIDTH = $clog2(QUEUE_DEPTH);
parameter DLM_BANK = 1;
parameter SOURCE_ID = 1'b0;
parameter ILM_AMSB = 32;
parameter DLM_AMSB = 32;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
localparam DLM_DEC_LSB = $clog2(32 / 8);
localparam DLM_DEC_MSB = ((DLM_BANK == 1) ? 0 : ($clog2(DLM_BANK) - 1)) + DLM_DEC_LSB;
input clk;
input reset_n;
input issue_valid;
output issue_ready;
input [(PTR_WIDTH - 1):0] issue_ptr;
input [(ADDR_WIDTH - 1):0] issue_addr;
input [1:0] issue_a_mask;
input [1:0] issue_func;
input issue_user;
output [(PTR_WIDTH - 1):0] ilm_w_req_ptr;
input [63:0] ilm_w_req_data;
input [7:0] ilm_w_req_strb;
output ilm_w_resp_ready;
output [(PTR_WIDTH - 1):0] dlm0_w_req_ptr;
input [63:0] dlm0_w_req_data;
input [7:0] dlm0_w_req_strb;
output dlm0_w_resp_ready;
output [(PTR_WIDTH - 1):0] dlm1_w_req_ptr;
input [63:0] dlm1_w_req_data;
input [7:0] dlm1_w_req_strb;
output dlm1_w_resp_ready;
output [(PTR_WIDTH - 1):0] dlm2_w_req_ptr;
input [63:0] dlm2_w_req_data;
input [7:0] dlm2_w_req_strb;
output dlm2_w_resp_ready;
output [(PTR_WIDTH - 1):0] dlm3_w_req_ptr;
input [63:0] dlm3_w_req_data;
input [7:0] dlm3_w_req_strb;
output dlm3_w_resp_ready;
output ilm_resp_valid;
output [(PTR_WIDTH - 1):0] ilm_resp_ptr;
output [63:0] ilm_resp_data;
output [13:0] ilm_resp_status;
output dlm0_resp_valid;
output [(PTR_WIDTH - 1):0] dlm0_resp_ptr;
output [63:0] dlm0_resp_data;
output [13:0] dlm0_resp_status;
output dlm1_resp_valid;
output [(PTR_WIDTH - 1):0] dlm1_resp_ptr;
output [63:0] dlm1_resp_data;
output [13:0] dlm1_resp_status;
output dlm2_resp_valid;
output [(PTR_WIDTH - 1):0] dlm2_resp_ptr;
output [63:0] dlm2_resp_data;
output [13:0] dlm2_resp_status;
output dlm3_resp_valid;
output [(PTR_WIDTH - 1):0] dlm3_resp_ptr;
output [63:0] dlm3_resp_data;
output [13:0] dlm3_resp_status;
output slv_ilm_a_valid;
output slv_ilm_a_stall;
input slv_ilm_a_ready;
output [ILM_AMSB:0] slv_ilm_a_addr;
output [1:0] slv_ilm_a_mask;
output [2:0] slv_ilm_a_func;
output [ILM_UW - 1:0] slv_ilm_a_user;
input slv_ilm_d_valid;
input [63:0] slv_ilm_d_data;
input [13:0] slv_ilm_d_status;
input [ILM_UW - 1:0] slv_ilm_d_user;
output slv_ilm_w_valid;
output [63:0] slv_ilm_w_data;
output [7:0] slv_ilm_w_mask;
input slv_ilm_w_ready;
output slv_dlm0_a_valid;
output slv_dlm0_a_stall;
input slv_dlm0_a_ready;
output [DLM_AMSB:0] slv_dlm0_a_addr;
output [2:0] slv_dlm0_a_func;
output [DLM_UW - 1:0] slv_dlm0_a_user;
input slv_dlm0_d_valid;
input [31:0] slv_dlm0_d_data;
input [13:0] slv_dlm0_d_status;
input [DLM_UW - 1:0] slv_dlm0_d_user;
output slv_dlm0_w_valid;
output [31:0] slv_dlm0_w_data;
output [3:0] slv_dlm0_w_mask;
input slv_dlm0_w_ready;
output slv_dlm1_a_valid;
output slv_dlm1_a_stall;
input slv_dlm1_a_ready;
output [DLM_AMSB:0] slv_dlm1_a_addr;
output [2:0] slv_dlm1_a_func;
output [DLM_UW - 1:0] slv_dlm1_a_user;
input slv_dlm1_d_valid;
input [31:0] slv_dlm1_d_data;
input [13:0] slv_dlm1_d_status;
input [DLM_UW - 1:0] slv_dlm1_d_user;
output slv_dlm1_w_valid;
output [31:0] slv_dlm1_w_data;
output [3:0] slv_dlm1_w_mask;
input slv_dlm1_w_ready;
output slv_dlm2_a_valid;
output slv_dlm2_a_stall;
input slv_dlm2_a_ready;
output [DLM_AMSB:0] slv_dlm2_a_addr;
output [2:0] slv_dlm2_a_func;
output [DLM_UW - 1:0] slv_dlm2_a_user;
input slv_dlm2_d_valid;
input [31:0] slv_dlm2_d_data;
input [13:0] slv_dlm2_d_status;
input [DLM_UW - 1:0] slv_dlm2_d_user;
output slv_dlm2_w_valid;
output [31:0] slv_dlm2_w_data;
output [3:0] slv_dlm2_w_mask;
input slv_dlm2_w_ready;
output slv_dlm3_a_valid;
output slv_dlm3_a_stall;
input slv_dlm3_a_ready;
output [DLM_AMSB:0] slv_dlm3_a_addr;
output [2:0] slv_dlm3_a_func;
output [DLM_UW - 1:0] slv_dlm3_a_user;
input slv_dlm3_d_valid;
input [31:0] slv_dlm3_d_data;
input [13:0] slv_dlm3_d_status;
input [DLM_UW - 1:0] slv_dlm3_d_user;
output slv_dlm3_w_valid;
output [31:0] slv_dlm3_w_data;
output [3:0] slv_dlm3_w_mask;
input slv_dlm3_w_ready;


wire issue_ilm_done;
wire issue_ilm_ptr_wvalid;
wire issue_ilm_ptr_wready;
wire [(PTR_WIDTH - 1):0] issue_ilm_ptr_wdata;
wire issue_ilm_ptr_rvalid;
wire issue_ilm_ptr_rready;
wire [(PTR_WIDTH - 1):0] issue_ilm_ptr_rdata;
wire ilm_resp_ptr_wvalid;
wire ilm_resp_ptr_wready;
wire [(PTR_WIDTH - 1):0] ilm_resp_ptr_wdata;
wire ilm_resp_ptr_rvalid;
wire ilm_resp_ptr_rready;
wire [(PTR_WIDTH - 1):0] ilm_resp_ptr_rdata;
wire [(DLM_BANK - 1):0] issue_dlm_done;
wire [(DLM_BANK - 1):0] issue_dlm_ptr_wvalid;
wire [(DLM_BANK - 1):0] issue_dlm_ptr_wready;
wire [(PTR_WIDTH - 1):0] issue_dlm_ptr_wdata[0:(DLM_BANK - 1)];
wire [(DLM_BANK - 1):0] issue_dlm_ptr_rvalid;
wire [(DLM_BANK - 1):0] issue_dlm_ptr_rready;
wire [(PTR_WIDTH - 1):0] issue_dlm_ptr_rdata[0:(DLM_BANK - 1)];
wire [(DLM_BANK - 1):0] dlm_resp_ptr_wvalid;
wire [(DLM_BANK - 1):0] dlm_resp_ptr_wready;
wire [(PTR_WIDTH - 1):0] dlm_resp_ptr_wdata[0:(DLM_BANK - 1)];
wire [(DLM_BANK - 1):0] dlm_resp_ptr_rvalid;
wire [(DLM_BANK - 1):0] dlm_resp_ptr_rready;
wire [(PTR_WIDTH - 1):0] dlm_resp_ptr_rdata[0:(DLM_BANK - 1)];
wire ilm_force_ready;
wire dlm_force_ready;
generate
    assign ilm_force_ready = (ILM_SIZE_KB == 0) ? 1'b1 : 1'b0;
    assign dlm_force_ready = (DLM_SIZE_KB == 0) ? 1'b1 : 1'b0;
endgenerate
kv_slvp_sync_fifo #(
    .DEPTH(4),
    .WIDTH(PTR_WIDTH)
) u_ilm_w_ptr (
    .clk(clk),
    .reset_n(reset_n),
    .wdata(issue_ilm_ptr_wdata),
    .wvalid(issue_ilm_ptr_wvalid),
    .wready(issue_ilm_ptr_wready),
    .rdata(issue_ilm_ptr_rdata),
    .rvalid(issue_ilm_ptr_rvalid),
    .rready(issue_ilm_ptr_rready)
);
kv_slvp_sync_fifo #(
    .DEPTH(4),
    .WIDTH(PTR_WIDTH)
) u_ilm_resp_ptr (
    .clk(clk),
    .reset_n(reset_n),
    .wdata(ilm_resp_ptr_wdata),
    .wvalid(ilm_resp_ptr_wvalid),
    .wready(ilm_resp_ptr_wready),
    .rdata(ilm_resp_ptr_rdata),
    .rvalid(ilm_resp_ptr_rvalid),
    .rready(ilm_resp_ptr_rready)
);
generate
    genvar i;
    for (i = 0; i < DLM_BANK; i = i + 1) begin:gen_dlm_ptr
        kv_slvp_sync_fifo #(
            .DEPTH(4),
            .WIDTH(PTR_WIDTH)
        ) u_dlm_w_ptr (
            .clk(clk),
            .reset_n(reset_n),
            .wdata(issue_dlm_ptr_wdata[i]),
            .wvalid(issue_dlm_ptr_wvalid[i]),
            .wready(issue_dlm_ptr_wready[i]),
            .rdata(issue_dlm_ptr_rdata[i]),
            .rvalid(issue_dlm_ptr_rvalid[i]),
            .rready(issue_dlm_ptr_rready[i])
        );
        kv_slvp_sync_fifo #(
            .DEPTH(4),
            .WIDTH(PTR_WIDTH)
        ) u_dlm_resp_ptr (
            .clk(clk),
            .reset_n(reset_n),
            .wdata(dlm_resp_ptr_wdata[i]),
            .wvalid(dlm_resp_ptr_wvalid[i]),
            .wready(dlm_resp_ptr_wready[i]),
            .rdata(dlm_resp_ptr_rdata[i]),
            .rvalid(dlm_resp_ptr_rvalid[i]),
            .rready(dlm_resp_ptr_rready[i])
        );
    end
endgenerate
assign slv_ilm_a_valid = issue_valid & ~issue_user;
assign slv_ilm_a_stall = (issue_func[1] & ~issue_ilm_ptr_wready) | ~ilm_resp_ptr_wready;
assign issue_ilm_done = slv_ilm_a_valid & (slv_ilm_a_ready | ilm_force_ready) & ~slv_ilm_a_stall;
assign issue_ilm_ptr_wvalid = issue_ilm_done & issue_func[1];
assign issue_ilm_ptr_wdata = issue_ptr;
assign slv_ilm_w_valid = issue_ilm_ptr_rvalid;
assign ilm_w_req_ptr = issue_ilm_ptr_rdata;
assign slv_ilm_w_data = ilm_w_req_data[0 +:64];
assign slv_ilm_w_mask = ilm_w_req_strb[0 +:8];
assign issue_ilm_ptr_rready = issue_ilm_ptr_rvalid & (slv_ilm_w_ready | ilm_force_ready);
assign ilm_w_resp_ready = issue_ilm_ptr_rready;
assign ilm_resp_ptr_wvalid = issue_ilm_done;
assign ilm_resp_ptr_wdata = issue_ptr;
assign ilm_resp_ptr_rready = (slv_ilm_d_valid | ilm_force_ready);
assign ilm_resp_valid = ilm_resp_ptr_rvalid & (slv_ilm_d_valid | ilm_force_ready);
assign ilm_resp_ptr = ilm_resp_ptr_rdata;
assign ilm_resp_data = slv_ilm_d_data;
assign ilm_resp_status = slv_ilm_d_status;
generate
    if (DLM_BANK > 2) begin:gen_dlm_a_valid_gt2
        assign slv_dlm0_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 2'b00);
        assign slv_dlm1_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 2'b01);
        assign slv_dlm2_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 2'b10);
        assign slv_dlm3_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 2'b11);
    end
    else if (DLM_BANK > 1) begin:gen_dlm_a_valid_gt1
        assign slv_dlm0_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 1'b0);
        assign slv_dlm1_a_valid = issue_valid & issue_user & (issue_addr[DLM_DEC_MSB:DLM_DEC_LSB] == 1'b1);
        assign slv_dlm2_a_valid = 1'b0;
        assign slv_dlm3_a_valid = 1'b0;
    end
    else begin:gen_dlm_a_valid_gt1
        assign slv_dlm0_a_valid = issue_valid & issue_user;
        assign slv_dlm1_a_valid = 1'b0;
        assign slv_dlm2_a_valid = 1'b0;
        assign slv_dlm3_a_valid = 1'b0;
    end
    assign slv_dlm0_a_stall = (issue_func[1] & ~issue_dlm_ptr_wready[0]) | ~dlm_resp_ptr_wready[0];
    assign issue_dlm_done[0] = slv_dlm0_a_valid & (slv_dlm0_a_ready | dlm_force_ready) & ~slv_dlm0_a_stall;
    assign issue_dlm_ptr_wvalid[0] = issue_dlm_done[0] & issue_func[1];
    assign issue_dlm_ptr_wdata[0] = issue_ptr;
    assign slv_dlm0_w_valid = issue_dlm_ptr_rvalid[0];
    assign dlm0_w_req_ptr = issue_dlm_ptr_rdata[0];
    assign slv_dlm0_w_data = dlm0_w_req_data[0 +:32];
    assign slv_dlm0_w_mask = dlm0_w_req_strb[0 +:4];
    assign issue_dlm_ptr_rready[0] = issue_dlm_ptr_rvalid[0] & (slv_dlm0_w_ready | dlm_force_ready);
    assign dlm0_w_resp_ready = issue_dlm_ptr_rready[0];
    assign dlm_resp_ptr_wvalid[0] = issue_dlm_done[0];
    assign dlm_resp_ptr_wdata[0] = issue_ptr;
    assign dlm_resp_ptr_rready[0] = (slv_dlm0_d_valid | dlm_force_ready);
    assign dlm0_resp_valid = dlm_resp_ptr_rvalid[0] & (slv_dlm0_d_valid | dlm_force_ready);
    assign dlm0_resp_ptr = dlm_resp_ptr_rdata[0];
    assign dlm0_resp_data[31:0] = slv_dlm0_d_data[31:0];
    assign dlm0_resp_status = slv_dlm0_d_status;
    if (DLM_BANK > 1) begin:gen_dlm_signals_b1
        assign slv_dlm1_a_stall = (issue_func[1] & ~issue_dlm_ptr_wready[1]) | ~dlm_resp_ptr_wready[1];
        assign issue_dlm_done[1] = slv_dlm1_a_valid & (slv_dlm1_a_ready | dlm_force_ready) & ~slv_dlm1_a_stall;
        assign issue_dlm_ptr_wvalid[1] = issue_dlm_done[1] & issue_func[1];
        assign issue_dlm_ptr_wdata[1] = issue_ptr;
        assign slv_dlm1_w_valid = issue_dlm_ptr_rvalid[1];
        assign dlm1_w_req_ptr = issue_dlm_ptr_rdata[1];
        assign slv_dlm1_w_data = dlm1_w_req_data[0 +:32];
        assign slv_dlm1_w_mask = dlm1_w_req_strb[0 +:4];
        assign issue_dlm_ptr_rready[1] = issue_dlm_ptr_rvalid[1] & (slv_dlm1_w_ready | dlm_force_ready);
        assign dlm1_w_resp_ready = issue_dlm_ptr_rready[1];
        assign dlm_resp_ptr_wvalid[1] = issue_dlm_done[1];
        assign dlm_resp_ptr_wdata[1] = issue_ptr;
        assign dlm_resp_ptr_rready[1] = (slv_dlm1_d_valid | dlm_force_ready);
        assign dlm1_resp_valid = dlm_resp_ptr_rvalid[1] & (slv_dlm1_d_valid | dlm_force_ready);
        assign dlm1_resp_ptr = {PTR_WIDTH{dlm_resp_ptr_rvalid[1]}} & dlm_resp_ptr_rdata[1];
        assign dlm1_resp_data[31:0] = slv_dlm1_d_data[31:0];
        assign dlm1_resp_status = slv_dlm1_d_status;
    end
    else begin:gen_dlm_signals_no_b1
        assign slv_dlm1_a_stall = 1'b0;
        assign slv_dlm1_w_valid = 1'b0;
        assign dlm1_w_req_ptr = {(PTR_WIDTH){1'b0}};
        assign slv_dlm1_w_data = {32{1'b0}};
        assign slv_dlm1_w_mask = {4{1'b0}};
        assign dlm1_w_resp_ready = 1'b0;
        assign dlm1_resp_valid = 1'b0;
        assign dlm1_resp_ptr = {(PTR_WIDTH){1'b0}};
        assign dlm1_resp_data[31:0] = {32{1'b0}};
        assign dlm1_resp_status = {14{1'b0}};
        wire nds_unused_slv_dlm1_a_ready = slv_dlm1_a_ready;
        wire nds_unused_slv_dlm1_d_valid = slv_dlm1_d_valid;
        wire [31:0] nds_unused_slv_dlm1_d_data = slv_dlm1_d_data;
        wire [13:0] nds_unused_slv_dlm1_d_status = slv_dlm1_d_status;
        wire nds_unused_slv_dlm1_w_ready = slv_dlm1_w_ready;
        wire [63:0] nds_unused_dlm1_w_req_data = dlm1_w_req_data;
        wire [7:0] nds_unused_dlm1_w_req_strb = dlm1_w_req_strb;
    end
    if (DLM_BANK > 2) begin:gen_dlm_signals_b2b3
        assign slv_dlm2_a_stall = (issue_func[1] & ~issue_dlm_ptr_wready[2]) | ~dlm_resp_ptr_wready[2];
        assign slv_dlm3_a_stall = (issue_func[1] & ~issue_dlm_ptr_wready[3]) | ~dlm_resp_ptr_wready[3];
        assign issue_dlm_done[2] = slv_dlm2_a_valid & (slv_dlm2_a_ready | dlm_force_ready) & ~slv_dlm2_a_stall;
        assign issue_dlm_done[3] = slv_dlm3_a_valid & (slv_dlm3_a_ready | dlm_force_ready) & ~slv_dlm3_a_stall;
        assign issue_dlm_ptr_wvalid[2] = issue_dlm_done[2] & issue_func[1];
        assign issue_dlm_ptr_wvalid[3] = issue_dlm_done[3] & issue_func[1];
        assign issue_dlm_ptr_wdata[2] = issue_ptr;
        assign issue_dlm_ptr_wdata[3] = issue_ptr;
        assign slv_dlm2_w_valid = issue_dlm_ptr_rvalid[2];
        assign slv_dlm3_w_valid = issue_dlm_ptr_rvalid[3];
        assign dlm2_w_req_ptr = issue_dlm_ptr_rdata[2];
        assign dlm3_w_req_ptr = issue_dlm_ptr_rdata[3];
        assign slv_dlm2_w_data = dlm2_w_req_data[0 +:32];
        assign slv_dlm3_w_data = dlm3_w_req_data[0 +:32];
        assign slv_dlm2_w_mask = dlm2_w_req_strb[0 +:4];
        assign slv_dlm3_w_mask = dlm3_w_req_strb[0 +:4];
        assign issue_dlm_ptr_rready[2] = issue_dlm_ptr_rvalid[2] & (slv_dlm2_w_ready | dlm_force_ready);
        assign issue_dlm_ptr_rready[3] = issue_dlm_ptr_rvalid[3] & (slv_dlm3_w_ready | dlm_force_ready);
        assign dlm2_w_resp_ready = issue_dlm_ptr_rready[2];
        assign dlm3_w_resp_ready = issue_dlm_ptr_rready[3];
        assign dlm_resp_ptr_wvalid[2] = issue_dlm_done[2];
        assign dlm_resp_ptr_wvalid[3] = issue_dlm_done[3];
        assign dlm_resp_ptr_wdata[2] = issue_ptr;
        assign dlm_resp_ptr_wdata[3] = issue_ptr;
        assign dlm_resp_ptr_rready[2] = (slv_dlm2_d_valid | dlm_force_ready);
        assign dlm_resp_ptr_rready[3] = (slv_dlm3_d_valid | dlm_force_ready);
        assign dlm2_resp_valid = dlm_resp_ptr_rvalid[2] & (slv_dlm2_d_valid | dlm_force_ready);
        assign dlm3_resp_valid = dlm_resp_ptr_rvalid[3] & (slv_dlm3_d_valid | dlm_force_ready);
        assign dlm2_resp_ptr = dlm_resp_ptr_rdata[2];
        assign dlm3_resp_ptr = dlm_resp_ptr_rdata[3];
        assign dlm2_resp_data[31:0] = slv_dlm2_d_data[31:0];
        assign dlm3_resp_data[31:0] = slv_dlm3_d_data[31:0];
        assign dlm2_resp_status = slv_dlm2_d_status;
        assign dlm3_resp_status = slv_dlm3_d_status;
    end
    else begin:gen_dlm_signals_no_b2b3
        assign slv_dlm2_a_stall = 1'b0;
        assign slv_dlm3_a_stall = 1'b0;
        assign slv_dlm2_w_valid = 1'b0;
        assign slv_dlm3_w_valid = 1'b0;
        assign dlm2_w_req_ptr = {(PTR_WIDTH){1'b0}};
        assign dlm3_w_req_ptr = {(PTR_WIDTH){1'b0}};
        assign slv_dlm2_w_data = {32{1'b0}};
        assign slv_dlm3_w_data = {32{1'b0}};
        assign slv_dlm2_w_mask = {4{1'b0}};
        assign slv_dlm3_w_mask = {4{1'b0}};
        assign dlm2_w_resp_ready = 1'b0;
        assign dlm3_w_resp_ready = 1'b0;
        assign dlm2_resp_valid = 1'b0;
        assign dlm3_resp_valid = 1'b0;
        assign dlm2_resp_ptr = {(PTR_WIDTH){1'b0}};
        assign dlm3_resp_ptr = {(PTR_WIDTH){1'b0}};
        assign dlm2_resp_data[31:0] = {32{1'b0}};
        assign dlm3_resp_data[31:0] = {32{1'b0}};
        assign dlm2_resp_status = {14{1'b0}};
        assign dlm3_resp_status = {14{1'b0}};
        wire nds_unused_slv_dlm2_a_ready = slv_dlm2_a_ready;
        wire nds_unused_slv_dlm2_d_valid = slv_dlm2_d_valid;
        wire [31:0] nds_unused_slv_dlm2_d_data = slv_dlm2_d_data;
        wire [13:0] nds_unused_slv_dlm2_d_status = slv_dlm2_d_status;
        wire nds_unused_slv_dlm2_w_ready = slv_dlm2_w_ready;
        wire nds_unused_slv_dlm3_a_ready = slv_dlm3_a_ready;
        wire nds_unused_slv_dlm3_d_valid = slv_dlm3_d_valid;
        wire [31:0] nds_unused_slv_dlm3_d_data = slv_dlm3_d_data;
        wire [13:0] nds_unused_slv_dlm3_d_status = slv_dlm3_d_status;
        wire nds_unused_slv_dlm3_w_ready = slv_dlm3_w_ready;
        wire [63:0] nds_unused_dlm2_w_req_data = dlm2_w_req_data;
        wire [7:0] nds_unused_dlm2_w_req_strb = dlm2_w_req_strb;
        wire [63:0] nds_unused_dlm3_w_req_data = dlm3_w_req_data;
        wire [7:0] nds_unused_dlm3_w_req_strb = dlm3_w_req_strb;
    end
    wire [ILM_UW - 1:0] nds_unused_slv_ilm_d_user = slv_ilm_d_user;
    wire [DLM_UW - 1:0] nds_unused_slv_dlm0_d_user = slv_dlm0_d_user;
    wire [DLM_UW - 1:0] nds_unused_slv_dlm1_d_user = slv_dlm1_d_user;
    wire [DLM_UW - 1:0] nds_unused_slv_dlm2_d_user = slv_dlm2_d_user;
    wire [DLM_UW - 1:0] nds_unused_slv_dlm3_d_user = slv_dlm3_d_user;
    assign dlm0_resp_data[63:32] = {32{1'b0}};
    assign dlm1_resp_data[63:32] = {32{1'b0}};
    assign dlm2_resp_data[63:32] = {32{1'b0}};
    assign dlm3_resp_data[63:32] = {32{1'b0}};
endgenerate
assign issue_ready = issue_ilm_done | (|issue_dlm_done);
assign slv_ilm_a_addr = issue_addr[ILM_AMSB:0];
assign slv_dlm0_a_addr = issue_addr[DLM_AMSB:0];
assign slv_dlm1_a_addr = issue_addr[DLM_AMSB:0];
assign slv_dlm2_a_addr = issue_addr[DLM_AMSB:0];
assign slv_dlm3_a_addr = issue_addr[DLM_AMSB:0];
assign slv_ilm_a_mask = issue_a_mask;
assign slv_ilm_a_func = {{1{1'b0}},issue_func};
assign slv_dlm0_a_func = {{1{1'b0}},issue_func};
assign slv_dlm1_a_func = {{1{1'b0}},issue_func};
assign slv_dlm2_a_func = {{1{1'b0}},issue_func};
assign slv_dlm3_a_func = {{1{1'b0}},issue_func};
assign slv_ilm_a_user[0] = SOURCE_ID;
assign slv_dlm0_a_user[0] = SOURCE_ID;
assign slv_dlm1_a_user[0] = SOURCE_ID;
assign slv_dlm2_a_user[0] = SOURCE_ID;
assign slv_dlm3_a_user[0] = SOURCE_ID;
generate
    if (ILM_UW > 1) begin:gen_ilm_user_zext
        assign slv_ilm_a_user[(ILM_UW - 1):1] = {(ILM_UW - 1){1'b0}};
    end
    if (DLM_UW > 1) begin:gen_dlm_user_zext
        assign slv_dlm0_a_user[(DLM_UW - 1):1] = {(DLM_UW - 1){1'b0}};
        assign slv_dlm1_a_user[(DLM_UW - 1):1] = {(DLM_UW - 1){1'b0}};
        assign slv_dlm2_a_user[(DLM_UW - 1):1] = {(DLM_UW - 1){1'b0}};
        assign slv_dlm3_a_user[(DLM_UW - 1):1] = {(DLM_UW - 1){1'b0}};
    end
endgenerate
endmodule

