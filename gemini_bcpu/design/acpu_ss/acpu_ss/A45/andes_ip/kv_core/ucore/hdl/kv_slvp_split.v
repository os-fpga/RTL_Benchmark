// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_slvp_split (
    clk,
    reset_n,
    wcq_rdata,
    wcq_rvalid,
    wcq_rready,
    wdq_rdata,
    wdq_rvalid,
    wdq_rready,
    brq_wdata,
    brq_wvalid,
    brq_wready,
    rcq_rdata,
    rcq_rvalid,
    rcq_rready,
    rdq_wdata,
    rdq_wvalid,
    rdq_wready,
    ax_command_valid,
    ax_command_ready,
    ax_command_data,
    b_resp_valid,
    b_resp_ready,
    b_resp_data,
    r_resp_valid,
    r_resp_ready,
    r_resp_data
);
parameter DATA_WIDTH = 32;
parameter ID_WIDTH = 4;
parameter ILM_AMSB = 19;
parameter DLM_AMSB = 19;
parameter MAX_AMSB = (DLM_AMSB > ILM_AMSB) ? DLM_AMSB : ILM_AMSB;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_ECC_TYPE_INT = 0;
parameter WCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1 + 1;
parameter WDQ_WIDTH = DATA_WIDTH + (DATA_WIDTH / 8) + 1;
parameter BRQ_WIDTH = ID_WIDTH + 1;
parameter RCQ_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2 + 1 + 1;
parameter RDQ_WIDTH = ID_WIDTH + DATA_WIDTH + 1 + 1;
parameter AX_CMD_WIDTH = ID_WIDTH + MAX_AMSB + 1 + 8 + 1 + 64 + 8 + 2 + 2 + 8 + 4 + 4;
localparam ILM_MERGE_LSB = $clog2(64 / 8);
localparam ILM_MERGE_WIDTH = $clog2(DATA_WIDTH / 8) - ILM_MERGE_LSB;
localparam ILM_MERGE_MSB = (ILM_MERGE_WIDTH == 0) ? ILM_MERGE_LSB : ILM_MERGE_LSB + ILM_MERGE_WIDTH - 1;
localparam DLM_MERGE_LSB = $clog2(32 / 8);
localparam DLM_MERGE_WIDTH = $clog2(DATA_WIDTH / 8) - DLM_MERGE_LSB;
localparam DLM_MERGE_MSB = (DLM_MERGE_WIDTH == 0) ? DLM_MERGE_LSB : DLM_MERGE_LSB + DLM_MERGE_WIDTH - 1;
localparam AXI_BURST_FIXED = 2'd0;
localparam AXI_BURST_INCR = 2'd1;
localparam AXI_BURST_WRAP = 2'd2;
localparam AXI_BURST_RSVD = 2'd3;
localparam AXI_SIZE_BYTE = 3'd0;
localparam AXI_SIZE_HWORD = 3'd1;
localparam AXI_SIZE_WORD = 3'd2;
localparam AXI_SIZE_DWORD = 3'd3;
localparam AXI_SIZE_QWORD = 3'd4;
localparam AXI_SIZE_DQWORD = 3'd5;
localparam AXI_SIZE_QQWORD = 3'd6;
localparam AXI_SIZE_DQQWORD = 3'd7;
localparam STATE_IDLE = 3'b001;
localparam STATE_AW = 3'b010;
localparam STATE_AR = 3'b100;
input clk;
input reset_n;
input [(WCQ_WIDTH - 1):0] wcq_rdata;
input wcq_rvalid;
output wcq_rready;
input [(WDQ_WIDTH - 1):0] wdq_rdata;
input wdq_rvalid;
output wdq_rready;
output [(BRQ_WIDTH - 1):0] brq_wdata;
output brq_wvalid;
input brq_wready;
input [(RCQ_WIDTH - 1):0] rcq_rdata;
input rcq_rvalid;
output rcq_rready;
output [(RDQ_WIDTH - 1):0] rdq_wdata;
output rdq_wvalid;
input rdq_wready;
output ax_command_valid;
input ax_command_ready;
output [(AX_CMD_WIDTH - 1):0] ax_command_data;
input b_resp_valid;
output b_resp_ready;
input [(BRQ_WIDTH - 1):0] b_resp_data;
input r_resp_valid;
output r_resp_ready;
input [(RDQ_WIDTH - 1):0] r_resp_data;


wire wcmd_valid;
wire wcmd_ready;
wire wcmd_grant;
wire rcmd_valid;
wire rcmd_ready;
wire rcmd_grant;
kv_arb_rr #(
    .N(2)
) u_cmd_arb (
    .clk(clk),
    .resetn(reset_n),
    .en(1'b1),
    .valid({rcmd_valid,wcmd_valid}),
    .ready({rcmd_ready,wcmd_ready}),
    .grant({rcmd_grant,wcmd_grant})
);
wire nds_unused_wcmd_ready = wcmd_ready;
wire nds_unused_rcmd_ready = rcmd_ready;
assign wcmd_valid = wcq_rvalid;
assign rcmd_valid = rcq_rvalid;
wire ax_valid;
wire ax_ready;
wire ax_last_len;
wire ax_last_pkt;
wire [(ID_WIDTH - 1):0] ax_id;
wire ax_taken;
reg [MAX_AMSB:0] ax_addr;
wire [MAX_AMSB:0] ax_addr_aligned;
wire [6:0] ax_addr_ilm;
wire [6:0] ax_addr_dlm;
wire [MAX_AMSB:0] ax_addr_nx;
wire [9:0] ax_addr_wrap_nx;
wire [9:0] ax_addr_wrap_mask;
wire [11:0] ax_addr_incr_nx;
wire [2:0] ax_init_size;
wire [6:0] ax_addr_init_mask;
wire [MAX_AMSB:0] ax_addr_init;
wire ax_addr_en;
wire [1:0] ax_burst;
wire [2:0] ax_size;
wire [63:0] ax_data;
wire [63:0] ax_data_ilm[0:((DATA_WIDTH / 64) - 1)];
wire [31:0] ax_data_dlm[0:((DATA_WIDTH / 32) - 1)];
wire [7:0] ax_strb;
wire [7:0] ax_strb_ilm[0:((DATA_WIDTH / 64) - 1)];
wire [3:0] ax_strb_dlm[0:((DATA_WIDTH / 32) - 1)];
wire [1:0] ax_mask;
wire [7:0] ax_tot_len;
reg [7:0] ax_cur_len;
wire ax_cur_len_en;
wire [3:0] ax_tot_pkt;
wire [3:0] ax_cur_pkt;
wire ax_ilm;
wire ax_dlm;
wire ax_ilm_rmw;
wire ax_dlm_rmw;
reg [2:0] state_cs;
reg [2:0] state_ns;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state_cs <= STATE_IDLE;
    end
    else begin
        state_cs <= state_ns;
    end
end

always @* begin
    case (state_cs)
        STATE_IDLE: state_ns = {(rcmd_valid & rcmd_grant),(wcmd_valid & wcmd_grant),~((rcmd_valid & rcmd_grant) | (wcmd_valid & wcmd_grant))};
        STATE_AW: state_ns = (ax_taken & ax_last_len & ax_last_pkt) ? STATE_IDLE : STATE_AW;
        STATE_AR: state_ns = (ax_taken & ax_last_len & ax_last_pkt) ? STATE_IDLE : STATE_AR;
        default: state_ns = 3'b0;
    endcase
end

assign ax_valid = (state_cs[1] & wdq_rvalid) | state_cs[2];
assign ax_taken = ax_valid & ax_ready;
assign ax_last_len = (ax_tot_len == ax_cur_len);
assign ax_last_pkt = (ax_tot_pkt == ax_cur_pkt);
assign ax_id = ({(ID_WIDTH){state_cs[1]}} & wcq_rdata[0 +:ID_WIDTH]) | ({(ID_WIDTH){state_cs[2]}} & rcq_rdata[0 +:ID_WIDTH]);
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ax_addr <= {(MAX_AMSB + 1){1'b0}};
    end
    else if (ax_addr_en) begin
        ax_addr <= ax_addr_nx;
    end
end

assign ax_addr_en = (state_cs == STATE_IDLE) | (ax_taken & (ax_tot_pkt == ax_cur_pkt));
generate
    if (MAX_AMSB > 11) begin:gen_amsb_gt_11
        assign ax_addr_nx = (state_cs == STATE_IDLE) ? ax_addr_init : (ax_burst == AXI_BURST_WRAP) ? {ax_addr[MAX_AMSB:10],ax_addr_wrap_nx[9:0]} : (ax_burst == AXI_BURST_INCR) ? {ax_addr[MAX_AMSB:12],ax_addr_incr_nx[11:0]} : ax_addr;
    end
    else begin:gen_amsb_le_11
        assign ax_addr_nx = (state_cs == STATE_IDLE) ? ax_addr_init : (ax_burst == AXI_BURST_WRAP) ? {ax_addr[11:10],ax_addr_wrap_nx[9:0]} : (ax_burst == AXI_BURST_INCR) ? ax_addr_incr_nx[11:0] : ax_addr;
    end
endgenerate
assign ax_init_size = {3{wcmd_grant}} & wcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8) +:3] | {3{rcmd_grant}} & rcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8) +:3];
assign ax_addr_init_mask = ({7{(ax_init_size == AXI_SIZE_BYTE)}} & 7'b1111111) | ({7{(ax_init_size == AXI_SIZE_HWORD)}} & 7'b1111110) | ({7{(ax_init_size == AXI_SIZE_WORD)}} & 7'b1111100) | ({7{(ax_init_size == AXI_SIZE_DWORD)}} & 7'b1111000) | ({7{(ax_init_size == AXI_SIZE_QWORD)}} & 7'b1110000) | ({7{(ax_init_size == AXI_SIZE_DQWORD)}} & 7'b1100000) | ({7{(ax_init_size == AXI_SIZE_QQWORD)}} & 7'b1000000);
assign ax_addr_init = {(MAX_AMSB + 1){wcmd_grant}} & wcq_rdata[ID_WIDTH +:MAX_AMSB + 1] & {{(MAX_AMSB + 1 - 7){1'b1}},ax_addr_init_mask} | {(MAX_AMSB + 1){rcmd_grant}} & rcq_rdata[ID_WIDTH +:MAX_AMSB + 1] & {{(MAX_AMSB + 1 - 7){1'b1}},ax_addr_init_mask};
assign ax_addr_incr_nx = ax_addr[11:0] + (12'h1 << ax_size);
assign ax_addr_wrap_mask = ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_BYTE))}} & 10'b1111111110) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_HWORD))}} & 10'b1111111100) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_WORD))}} & 10'b1111111000) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_DWORD))}} & 10'b1111110000) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_QWORD))}} & 10'b1111100000) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_DQWORD))}} & 10'b1111000000) | ({10{((ax_tot_len == 8'h1) & (ax_size == AXI_SIZE_QQWORD))}} & 10'b1110000000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_BYTE))}} & 10'b1111111100) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_HWORD))}} & 10'b1111111000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_WORD))}} & 10'b1111110000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_DWORD))}} & 10'b1111100000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_QWORD))}} & 10'b1111000000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_DQWORD))}} & 10'b1110000000) | ({10{((ax_tot_len == 8'h3) & (ax_size == AXI_SIZE_QQWORD))}} & 10'b1100000000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_BYTE))}} & 10'b1111111000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_HWORD))}} & 10'b1111110000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_WORD))}} & 10'b1111100000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_DWORD))}} & 10'b1111000000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_QWORD))}} & 10'b1110000000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_DQWORD))}} & 10'b1100000000) | ({10{((ax_tot_len == 8'h7) & (ax_size == AXI_SIZE_QQWORD))}} & 10'b1000000000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_BYTE))}} & 10'b1111110000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_HWORD))}} & 10'b1111100000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_WORD))}} & 10'b1111000000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_DWORD))}} & 10'b1110000000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_QWORD))}} & 10'b1100000000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_DQWORD))}} & 10'b1000000000) | ({10{((ax_tot_len == 8'hf) & (ax_size == AXI_SIZE_QQWORD))}} & 10'b0000000000);
assign ax_addr_wrap_nx = (ax_addr[9:0] & (ax_addr_wrap_mask)) | (ax_addr_incr_nx[9:0] & (~ax_addr_wrap_mask));
assign ax_burst = {2{state_cs[1]}} & wcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8 + 3) +:2] | {2{state_cs[2]}} & rcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8 + 3) +:2];
assign ax_size = {3{state_cs[1]}} & wcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8) +:3] | {3{state_cs[2]}} & rcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8) +:3];
assign ax_tot_len = {8{state_cs[1]}} & wcq_rdata[(ID_WIDTH + MAX_AMSB + 1) +:8] | {8{state_cs[2]}} & rcq_rdata[(ID_WIDTH + MAX_AMSB + 1) +:8];
assign ax_dlm = state_cs[1] & wcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2) +:1] | state_cs[2] & rcq_rdata[(ID_WIDTH + MAX_AMSB + 1 + 8 + 3 + 2) +:1];
assign ax_ilm = ~ax_dlm;
assign ax_cur_len_en = ax_last_pkt & ax_taken;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ax_cur_len <= 8'b0;
    end
    else if (ax_cur_len_en) begin
        ax_cur_len <= ax_last_len ? 8'b0 : ax_cur_len + 8'b1;
    end
end

generate
    genvar ilm_offset;
    genvar dlm_offset;
    if ((DATA_WIDTH / 32) == 1) begin:gen_ratio_eq_1
        assign ax_tot_pkt = 4'b0000;
        assign ax_cur_pkt = 4'b0000;
    end
    if ((DATA_WIDTH / 32) > 1) begin:gen_ratio_gt_1
        assign ax_tot_pkt = ({4{ax_ilm & (ax_size == AXI_SIZE_QWORD)}} & 4'b0001) | ({4{ax_ilm & (ax_size == AXI_SIZE_DQWORD)}} & 4'b0011) | ({4{ax_ilm & (ax_size == AXI_SIZE_QQWORD)}} & 4'b0111) | ({4{ax_dlm & (ax_size == AXI_SIZE_DWORD) & 1'b1}} & 4'b0001) | ({4{ax_dlm & (ax_size == AXI_SIZE_QWORD) & 1'b1}} & 4'b0011) | ({4{ax_dlm & (ax_size == AXI_SIZE_DQWORD) & 1'b1}} & 4'b0111) | ({4{ax_dlm & (ax_size == AXI_SIZE_QQWORD) & 1'b1}} & 4'b1111) | ({4{ax_dlm & (ax_size == AXI_SIZE_QWORD) & 1'b0}} & 4'b0001) | ({4{ax_dlm & (ax_size == AXI_SIZE_DQWORD) & 1'b0}} & 4'b0011) | ({4{ax_dlm & (ax_size == AXI_SIZE_QQWORD) & 1'b0}} & 4'b0111);
        reg [3:0] ax_cur_pkt_reg;
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                ax_cur_pkt_reg <= 4'b0;
            end
            else if (ax_taken) begin
                ax_cur_pkt_reg <= ax_last_pkt ? 4'b0 : ax_cur_pkt_reg + 4'b1;
            end
        end

        assign ax_cur_pkt = ax_cur_pkt_reg;
    end
    assign ax_addr_ilm = {ax_cur_pkt,3'b0};
    assign ax_addr_dlm = {1'b0,ax_cur_pkt,2'b0};
    for (ilm_offset = 0; ilm_offset < (DATA_WIDTH / 64); ilm_offset = ilm_offset + 1) begin:gen_ilm_data_strb
        assign ax_data_ilm[ilm_offset] = wdq_rdata[ilm_offset * 64 +:64];
        assign ax_strb_ilm[ilm_offset] = wdq_rdata[DATA_WIDTH + (ilm_offset * 8) +:8];
    end
    for (dlm_offset = 0; dlm_offset < (DATA_WIDTH / 32); dlm_offset = dlm_offset + 1) begin:gen_dlm_data_strb
        assign ax_data_dlm[dlm_offset] = wdq_rdata[dlm_offset * 32 +:32];
        assign ax_strb_dlm[dlm_offset] = wdq_rdata[DATA_WIDTH + (dlm_offset * 4) +:4];
    end
    assign ax_data = ({64{ax_ilm & ~(ILM_MERGE_WIDTH == 0)}} & ax_data_ilm[ax_addr_aligned[ILM_MERGE_MSB:ILM_MERGE_LSB]]) | ({64{ax_ilm & (ILM_MERGE_WIDTH == 0)}} & ax_data_ilm[0]) | {{32{1'b0}},({32{ax_dlm & ~(DLM_MERGE_WIDTH == 0)}} & ax_data_dlm[ax_addr_aligned[DLM_MERGE_MSB:DLM_MERGE_LSB]])} | {{32{1'b0}},({32{ax_dlm & (DLM_MERGE_WIDTH == 0)}} & ax_data_dlm[0])};
    assign ax_strb = ({8{ax_ilm & ~(ILM_MERGE_WIDTH == 0)}} & ax_strb_ilm[ax_addr_aligned[ILM_MERGE_MSB:ILM_MERGE_LSB]]) | ({8{ax_ilm & (ILM_MERGE_WIDTH == 0)}} & ax_strb_ilm[0]) | {{4{1'b0}},({4{ax_dlm & ~(DLM_MERGE_WIDTH == 0)}} & ax_strb_dlm[ax_addr_aligned[DLM_MERGE_MSB:DLM_MERGE_LSB]])} | {{4{1'b0}},({4{ax_dlm & (DLM_MERGE_WIDTH == 0)}} & ax_strb_dlm[0])};
    assign ax_ilm_rmw = (ax_ilm & (ax_size == AXI_SIZE_BYTE) & ~(ILM_ECC_TYPE_INT == 0)) | (ax_ilm & (ax_size == AXI_SIZE_HWORD) & ~(ILM_ECC_TYPE_INT == 0)) | (ax_ilm & (ax_size == AXI_SIZE_WORD) & ~(ILM_ECC_TYPE_INT == 0)) | (ax_ilm & (ax_size == AXI_SIZE_DWORD) & (~&ax_strb) & ~(ILM_ECC_TYPE_INT == 0)) | (ax_ilm & (ax_size[2]) & (~&ax_strb) & ~(ILM_ECC_TYPE_INT == 0));
    assign ax_dlm_rmw = ax_dlm & (~&ax_strb[3:0]) & ~(DLM_ECC_TYPE_INT == 0);
endgenerate
assign ax_addr_aligned = ax_addr | {(MAX_AMSB + 1){ax_ilm}} & {{(MAX_AMSB - 6){1'b0}},ax_addr_ilm} | {(MAX_AMSB + 1){ax_dlm}} & {{(MAX_AMSB - 6){1'b0}},ax_addr_dlm};
assign ax_mask = ({2{ax_ilm & (ax_size == AXI_SIZE_BYTE) & ~ax_addr[2]}} & 2'b01) | ({2{ax_ilm & (ax_size == AXI_SIZE_HWORD) & ~ax_addr[2]}} & 2'b01) | ({2{ax_ilm & (ax_size == AXI_SIZE_WORD) & ~ax_addr[2]}} & 2'b01) | ({2{ax_ilm & (ax_size == AXI_SIZE_BYTE) & ax_addr[2]}} & 2'b10) | ({2{ax_ilm & (ax_size == AXI_SIZE_HWORD) & ax_addr[2]}} & 2'b10) | ({2{ax_ilm & (ax_size == AXI_SIZE_WORD) & ax_addr[2]}} & 2'b10) | ({2{ax_ilm & (ax_size == AXI_SIZE_DWORD)}} & 2'b11) | ({2{ax_ilm & (ax_size == AXI_SIZE_QWORD)}} & 2'b11) | ({2{ax_ilm & (ax_size == AXI_SIZE_DQWORD)}} & 2'b11) | ({2{ax_ilm & (ax_size == AXI_SIZE_QQWORD)}} & 2'b11) | ({2{ax_dlm}} & 2'b11);
assign ax_command_valid = ax_valid;
assign ax_ready = ax_command_ready;
assign ax_command_data = {ax_cur_pkt,ax_tot_pkt,ax_cur_len,state_cs[1],(state_cs[2] | ((ax_ilm_rmw | ax_dlm_rmw) & state_cs[1])),ax_mask,ax_strb,ax_data,ax_dlm,ax_tot_len,ax_addr_aligned,ax_id};
assign wcq_rready = ax_taken & (ax_tot_len == ax_cur_len) & (ax_tot_pkt == ax_cur_pkt) & state_cs[1];
assign wdq_rready = ax_taken & (ax_tot_pkt == ax_cur_pkt) & state_cs[1];
assign rcq_rready = ax_taken & (ax_tot_len == ax_cur_len) & (ax_tot_pkt == ax_cur_pkt) & state_cs[2];
assign brq_wvalid = b_resp_valid;
assign b_resp_ready = brq_wready;
assign brq_wdata = b_resp_data;
assign rdq_wvalid = r_resp_valid;
assign r_resp_ready = rdq_wready;
assign rdq_wdata = r_resp_data;
endmodule

