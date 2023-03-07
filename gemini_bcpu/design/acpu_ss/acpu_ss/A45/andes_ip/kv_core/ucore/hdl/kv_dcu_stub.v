// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_stub (
    dcu_clk,
    dcu_reset_n,
    dcu_a_address,
    dcu_a_corrupt,
    dcu_a_data,
    dcu_a_mask,
    dcu_a_opcode,
    dcu_a_param,
    dcu_a_ready,
    dcu_a_size,
    dcu_a_source,
    dcu_a_user,
    dcu_a_valid,
    dcu_b_address,
    dcu_b_corrupt,
    dcu_b_data,
    dcu_b_mask,
    dcu_b_opcode,
    dcu_b_param,
    dcu_b_ready,
    dcu_b_size,
    dcu_b_source,
    dcu_b_valid,
    dcu_c_address,
    dcu_c_corrupt,
    dcu_c_data,
    dcu_c_opcode,
    dcu_c_param,
    dcu_c_ready,
    dcu_c_size,
    dcu_c_source,
    dcu_c_user,
    dcu_c_valid,
    dcu_d_corrupt,
    dcu_d_data,
    dcu_d_denied,
    dcu_d_opcode,
    dcu_d_param,
    dcu_d_ready,
    dcu_d_sink,
    dcu_d_size,
    dcu_d_source,
    dcu_d_user,
    dcu_d_valid,
    dcu_e_ready,
    dcu_e_sink,
    dcu_e_valid,
    csr_mcache_ctl_dc_eccen,
    csr_mcache_ctl_dc_rwecc,
    csr_mecc_code,
    dcache_data0_addr,
    dcache_data0_byte_we,
    dcache_data0_cs,
    dcache_data0_rdata,
    dcache_data0_wdata,
    dcache_data0_we,
    dcache_data1_addr,
    dcache_data1_byte_we,
    dcache_data1_cs,
    dcache_data1_rdata,
    dcache_data1_wdata,
    dcache_data1_we,
    dcache_data2_addr,
    dcache_data2_byte_we,
    dcache_data2_cs,
    dcache_data2_rdata,
    dcache_data2_wdata,
    dcache_data2_we,
    dcache_data3_addr,
    dcache_data3_byte_we,
    dcache_data3_cs,
    dcache_data3_rdata,
    dcache_data3_wdata,
    dcache_data3_we,
    dcache_tag0_addr,
    dcache_tag0_cs,
    dcache_tag0_rdata,
    dcache_tag0_wdata,
    dcache_tag0_we,
    dcache_tag1_addr,
    dcache_tag1_cs,
    dcache_tag1_rdata,
    dcache_tag1_wdata,
    dcache_tag1_we,
    dcache_tag2_addr,
    dcache_tag2_cs,
    dcache_tag2_rdata,
    dcache_tag2_wdata,
    dcache_tag2_we,
    dcache_tag3_addr,
    dcache_tag3_cs,
    dcache_tag3_rdata,
    dcache_tag3_wdata,
    dcache_tag3_we,
    dcu_ack_id,
    dcu_ack_rdata,
    dcu_ack_status,
    dcu_ack_valid,
    dcu_async_write_error,
    dcu_cmt_addr,
    dcu_cmt_func,
    dcu_cmt_valid,
    dcu_cmt_wdata,
    dcu_cmt_wmask,
    dcu_event,
    dcu_req_addr,
    dcu_req_func,
    dcu_req_id,
    dcu_req_ready,
    dcu_req_stall,
    dcu_req_valid,
    dcu_standby_ready,
    dcu_acctl_ecc_corr,
    dcu_acctl_ecc_error,
    dcu_async_ecc_corr,
    dcu_async_ecc_error,
    dcu_async_ecc_ramid,
    dcache_disable_init,
    dcu_ix_ack,
    dcu_ix_addr,
    dcu_ix_command,
    dcu_ix_raddr,
    dcu_ix_rdata,
    dcu_ix_req,
    dcu_ix_status,
    dcu_ix_wdata,
    dcu_cri_id,
    dcu_cri_nbload_result,
    dcu_cri_rdata,
    dcu_cri_status,
    dcu_cri_valid,
    dcu_wna_pending,
    mshr_event,
    csr_mcache_ctl_dc_waround,
    dcu_wbf_flush,
    dcache_wpt_addr,
    dcache_wpt_byte_we,
    dcache_wpt_cs,
    dcache_wpt_rdata,
    dcache_wpt_wdata,
    dcache_wpt_we
);
parameter PALEN = 32;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 32;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter DCACHE_SIZE_KB = 0;
parameter CACHE_LINE_SIZE = 64;
parameter DCACHE_TAG_RAM_AW = 9;
parameter DCACHE_TAG_RAM_DW = 28;
parameter DCACHE_DATA_RAM_AW = 11;
parameter DCACHE_DATA_RAM_DW = 32;
parameter DCACHE_DATA_RAM_BWEW = 4;
parameter DCACHE_WPT_RAM_AW = 11;
parameter DCACHE_WPT_RAM_DW = 16;
parameter DCACHE_WPT_RAM_BWEW = 2;
parameter DCACHE_LRU_INT = 0;
parameter DCACHE_WAY = 2;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter MSHR_DEPTH = 3;
parameter DCACHE_WBF_DEPTH = 2;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter CM_SUPPORT_INT = 0;
parameter WPT_SUPPORT = 1;
parameter SINK_WIDTH = 2;
localparam SB_DEPTH = 8;
localparam EVB_DEPTH = 3;
localparam SOURCE_WIDTH = $unsigned($clog2(MSHR_DEPTH));
input dcu_clk;
input dcu_reset_n;
output [(L2_ADDR_WIDTH - 1):0] dcu_a_address;
output dcu_a_corrupt;
output [(L2_DATA_WIDTH - 1):0] dcu_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] dcu_a_mask;
output [2:0] dcu_a_opcode;
output [2:0] dcu_a_param;
input dcu_a_ready;
output [2:0] dcu_a_size;
output [2:0] dcu_a_source;
output [11:0] dcu_a_user;
output dcu_a_valid;
input [(L2_ADDR_WIDTH - 1):0] dcu_b_address;
input dcu_b_corrupt;
input [(L2_DATA_WIDTH - 1):0] dcu_b_data;
input [(L2_DATA_WIDTH / 8) - 1:0] dcu_b_mask;
input [2:0] dcu_b_opcode;
input [2:0] dcu_b_param;
output dcu_b_ready;
input [2:0] dcu_b_size;
input [2:0] dcu_b_source;
input dcu_b_valid;
output [(L2_ADDR_WIDTH - 1):0] dcu_c_address;
output dcu_c_corrupt;
output [(L2_DATA_WIDTH - 1):0] dcu_c_data;
output [2:0] dcu_c_opcode;
output [2:0] dcu_c_param;
input dcu_c_ready;
output [2:0] dcu_c_size;
output [2:0] dcu_c_source;
output [7:0] dcu_c_user;
output dcu_c_valid;
input dcu_d_corrupt;
input [(L2_DATA_WIDTH - 1):0] dcu_d_data;
input dcu_d_denied;
input [2:0] dcu_d_opcode;
input [1:0] dcu_d_param;
output dcu_d_ready;
input [(SINK_WIDTH - 1):0] dcu_d_sink;
input [2:0] dcu_d_size;
input [2:0] dcu_d_source;
input [5:0] dcu_d_user;
input dcu_d_valid;
input dcu_e_ready;
output [(SINK_WIDTH - 1):0] dcu_e_sink;
output dcu_e_valid;
input [1:0] csr_mcache_ctl_dc_eccen;
input csr_mcache_ctl_dc_rwecc;
input [31:0] csr_mecc_code;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data0_addr;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data0_byte_we;
output dcache_data0_cs;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_wdata;
output dcache_data0_we;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data1_addr;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data1_byte_we;
output dcache_data1_cs;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_wdata;
output dcache_data1_we;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data2_addr;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data2_byte_we;
output dcache_data2_cs;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_wdata;
output dcache_data2_we;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data3_addr;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data3_byte_we;
output dcache_data3_cs;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_wdata;
output dcache_data3_we;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag0_addr;
output dcache_tag0_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_wdata;
output dcache_tag0_we;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag1_addr;
output dcache_tag1_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_wdata;
output dcache_tag1_we;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag2_addr;
output dcache_tag2_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_wdata;
output dcache_tag2_we;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag3_addr;
output dcache_tag3_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_wdata;
output dcache_tag3_we;
output [0:0] dcu_ack_id;
output [31:0] dcu_ack_rdata;
output [18:0] dcu_ack_status;
output dcu_ack_valid;
output dcu_async_write_error;
input [(PALEN - 1):0] dcu_cmt_addr;
input [10:0] dcu_cmt_func;
input dcu_cmt_valid;
input [31:0] dcu_cmt_wdata;
input [3:0] dcu_cmt_wmask;
output [6:0] dcu_event;
input [(PALEN - 1):0] dcu_req_addr;
input [21:0] dcu_req_func;
input [0:0] dcu_req_id;
output dcu_req_ready;
input dcu_req_stall;
input dcu_req_valid;
output dcu_standby_ready;
output dcu_acctl_ecc_corr;
output dcu_acctl_ecc_error;
output dcu_async_ecc_corr;
output dcu_async_ecc_error;
output [3:0] dcu_async_ecc_ramid;
input dcache_disable_init;
output dcu_ix_ack;
input [31:0] dcu_ix_addr;
input [7:0] dcu_ix_command;
output [31:0] dcu_ix_raddr;
output [31:0] dcu_ix_rdata;
input dcu_ix_req;
output [11:0] dcu_ix_status;
input [31:0] dcu_ix_wdata;
output [0:0] dcu_cri_id;
output [31:0] dcu_cri_nbload_result;
output [31:0] dcu_cri_rdata;
output [8:0] dcu_cri_status;
output dcu_cri_valid;
output dcu_wna_pending;
output [15:0] mshr_event;
input [1:0] csr_mcache_ctl_dc_waround;
input dcu_wbf_flush;
output [(DCACHE_WPT_RAM_AW - 1):0] dcache_wpt_addr;
output [(DCACHE_WPT_RAM_BWEW - 1):0] dcache_wpt_byte_we;
output dcache_wpt_cs;
input [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_rdata;
output [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_wdata;
output dcache_wpt_we;


wire nds_unused_dcu_clk = dcu_clk;
wire nds_unused_dcu_reset_n = dcu_reset_n;
assign dcu_a_address = {((L2_ADDR_WIDTH - 1) + 1){1'b0}};
assign dcu_a_corrupt = 1'b0;
assign dcu_a_data = {((L2_DATA_WIDTH - 1) + 1){1'b0}};
assign dcu_a_mask = {(L2_DATA_WIDTH / 8){1'b0}};
assign dcu_a_opcode = 3'b0;
assign dcu_a_param = 3'b0;
wire nds_unused_dcu_a_ready = dcu_a_ready;
assign dcu_a_size = 3'b0;
assign dcu_a_source = 3'b0;
assign dcu_a_user = 12'b0;
assign dcu_a_valid = 1'b0;
wire [(L2_ADDR_WIDTH - 1):0] nds_unused_dcu_b_address = dcu_b_address;
wire nds_unused_dcu_b_corrupt = dcu_b_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_dcu_b_data = dcu_b_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] nds_unused_dcu_b_mask = dcu_b_mask;
wire [2:0] nds_unused_dcu_b_opcode = dcu_b_opcode;
wire [2:0] nds_unused_dcu_b_param = dcu_b_param;
assign dcu_b_ready = 1'b0;
wire [2:0] nds_unused_dcu_b_size = dcu_b_size;
wire [2:0] nds_unused_dcu_b_source = dcu_b_source;
wire nds_unused_dcu_b_valid = dcu_b_valid;
assign dcu_c_address = {((L2_ADDR_WIDTH - 1) + 1){1'b0}};
assign dcu_c_corrupt = 1'b0;
assign dcu_c_data = {((L2_DATA_WIDTH - 1) + 1){1'b0}};
assign dcu_c_opcode = 3'b0;
assign dcu_c_param = 3'b0;
wire nds_unused_dcu_c_ready = dcu_c_ready;
assign dcu_c_size = 3'b0;
assign dcu_c_source = 3'b0;
assign dcu_c_user = 8'b0;
assign dcu_c_valid = 1'b0;
wire nds_unused_dcu_d_corrupt = dcu_d_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_dcu_d_data = dcu_d_data;
wire nds_unused_dcu_d_denied = dcu_d_denied;
wire [2:0] nds_unused_dcu_d_opcode = dcu_d_opcode;
wire [1:0] nds_unused_dcu_d_param = dcu_d_param;
assign dcu_d_ready = 1'b0;
wire [(SINK_WIDTH - 1):0] nds_unused_dcu_d_sink = dcu_d_sink;
wire [2:0] nds_unused_dcu_d_size = dcu_d_size;
wire [2:0] nds_unused_dcu_d_source = dcu_d_source;
wire [5:0] nds_unused_dcu_d_user = dcu_d_user;
wire nds_unused_dcu_d_valid = dcu_d_valid;
wire nds_unused_dcu_e_ready = dcu_e_ready;
assign dcu_e_sink = {((SINK_WIDTH - 1) + 1){1'b0}};
assign dcu_e_valid = 1'b0;
wire [1:0] nds_unused_csr_mcache_ctl_dc_eccen = csr_mcache_ctl_dc_eccen;
wire nds_unused_csr_mcache_ctl_dc_rwecc = csr_mcache_ctl_dc_rwecc;
wire [31:0] nds_unused_csr_mecc_code = csr_mecc_code;
assign dcache_data0_addr = {((DCACHE_DATA_RAM_AW - 1) + 1){1'b0}};
assign dcache_data0_byte_we = {((DCACHE_DATA_RAM_BWEW - 1) + 1){1'b0}};
assign dcache_data0_cs = 1'b0;
wire [(DCACHE_DATA_RAM_DW - 1):0] nds_unused_dcache_data0_rdata = dcache_data0_rdata;
assign dcache_data0_wdata = {((DCACHE_DATA_RAM_DW - 1) + 1){1'b0}};
assign dcache_data0_we = 1'b0;
assign dcache_data1_addr = {((DCACHE_DATA_RAM_AW - 1) + 1){1'b0}};
assign dcache_data1_byte_we = {((DCACHE_DATA_RAM_BWEW - 1) + 1){1'b0}};
assign dcache_data1_cs = 1'b0;
wire [(DCACHE_DATA_RAM_DW - 1):0] nds_unused_dcache_data1_rdata = dcache_data1_rdata;
assign dcache_data1_wdata = {((DCACHE_DATA_RAM_DW - 1) + 1){1'b0}};
assign dcache_data1_we = 1'b0;
assign dcache_data2_addr = {((DCACHE_DATA_RAM_AW - 1) + 1){1'b0}};
assign dcache_data2_byte_we = {((DCACHE_DATA_RAM_BWEW - 1) + 1){1'b0}};
assign dcache_data2_cs = 1'b0;
wire [(DCACHE_DATA_RAM_DW - 1):0] nds_unused_dcache_data2_rdata = dcache_data2_rdata;
assign dcache_data2_wdata = {((DCACHE_DATA_RAM_DW - 1) + 1){1'b0}};
assign dcache_data2_we = 1'b0;
assign dcache_data3_addr = {((DCACHE_DATA_RAM_AW - 1) + 1){1'b0}};
assign dcache_data3_byte_we = {((DCACHE_DATA_RAM_BWEW - 1) + 1){1'b0}};
assign dcache_data3_cs = 1'b0;
wire [(DCACHE_DATA_RAM_DW - 1):0] nds_unused_dcache_data3_rdata = dcache_data3_rdata;
assign dcache_data3_wdata = {((DCACHE_DATA_RAM_DW - 1) + 1){1'b0}};
assign dcache_data3_we = 1'b0;
assign dcache_tag0_addr = {((DCACHE_TAG_RAM_AW - 1) + 1){1'b0}};
assign dcache_tag0_cs = 1'b0;
wire [(DCACHE_TAG_RAM_DW - 1):0] nds_unused_dcache_tag0_rdata = dcache_tag0_rdata;
assign dcache_tag0_wdata = {((DCACHE_TAG_RAM_DW - 1) + 1){1'b0}};
assign dcache_tag0_we = 1'b0;
assign dcache_tag1_addr = {((DCACHE_TAG_RAM_AW - 1) + 1){1'b0}};
assign dcache_tag1_cs = 1'b0;
wire [(DCACHE_TAG_RAM_DW - 1):0] nds_unused_dcache_tag1_rdata = dcache_tag1_rdata;
assign dcache_tag1_wdata = {((DCACHE_TAG_RAM_DW - 1) + 1){1'b0}};
assign dcache_tag1_we = 1'b0;
assign dcache_tag2_addr = {((DCACHE_TAG_RAM_AW - 1) + 1){1'b0}};
assign dcache_tag2_cs = 1'b0;
wire [(DCACHE_TAG_RAM_DW - 1):0] nds_unused_dcache_tag2_rdata = dcache_tag2_rdata;
assign dcache_tag2_wdata = {((DCACHE_TAG_RAM_DW - 1) + 1){1'b0}};
assign dcache_tag2_we = 1'b0;
assign dcache_tag3_addr = {((DCACHE_TAG_RAM_AW - 1) + 1){1'b0}};
assign dcache_tag3_cs = 1'b0;
wire [(DCACHE_TAG_RAM_DW - 1):0] nds_unused_dcache_tag3_rdata = dcache_tag3_rdata;
assign dcache_tag3_wdata = {((DCACHE_TAG_RAM_DW - 1) + 1){1'b0}};
assign dcache_tag3_we = 1'b0;
assign dcu_ack_id = 1'b0;
assign dcu_ack_rdata = {32{1'b0}};
assign dcu_ack_status = {19{1'b0}};
assign dcu_ack_valid = 1'b0;
assign dcu_async_write_error = 1'b0;
wire [(PALEN - 1):0] nds_unused_dcu_cmt_addr = dcu_cmt_addr;
wire [10:0] nds_unused_dcu_cmt_func = dcu_cmt_func;
wire nds_unused_dcu_cmt_valid = dcu_cmt_valid;
wire [31:0] nds_unused_dcu_cmt_wdata = dcu_cmt_wdata;
wire [3:0] nds_unused_dcu_cmt_wmask = dcu_cmt_wmask;
assign dcu_event = {7{1'b0}};
wire [(PALEN - 1):0] nds_unused_dcu_req_addr = dcu_req_addr;
wire [21:0] nds_unused_dcu_req_func = dcu_req_func;
wire [0:0] nds_unused_dcu_req_id = dcu_req_id;
assign dcu_req_ready = 1'b1;
wire nds_unused_dcu_req_stall = dcu_req_stall;
wire nds_unused_dcu_req_valid = dcu_req_valid;
assign dcu_standby_ready = 1'b1;
assign dcu_acctl_ecc_corr = 1'b0;
assign dcu_acctl_ecc_error = 1'b0;
assign dcu_async_ecc_corr = 1'b0;
assign dcu_async_ecc_error = 1'b0;
assign dcu_async_ecc_ramid = 4'b0;
wire nds_unused_dcache_disable_init = dcache_disable_init;
assign dcu_ix_ack = 1'b1;
wire [31:0] nds_unused_dcu_ix_addr = dcu_ix_addr;
wire [7:0] nds_unused_dcu_ix_command = dcu_ix_command;
assign dcu_ix_raddr = {32{1'b0}};
assign dcu_ix_rdata = {32{1'b0}};
wire nds_unused_dcu_ix_req = dcu_ix_req;
assign dcu_ix_status = {12{1'b0}};
wire [31:0] nds_unused_dcu_ix_wdata = dcu_ix_wdata;
assign dcu_cri_id = 1'b0;
assign dcu_cri_nbload_result = {32{1'b0}};
assign dcu_cri_rdata = {32{1'b0}};
assign dcu_cri_status = {9{1'b0}};
assign dcu_cri_valid = 1'b0;
assign dcu_wna_pending = 1'b0;
assign mshr_event = {16{1'b0}};
wire [1:0] nds_unused_csr_mcache_ctl_dc_waround = csr_mcache_ctl_dc_waround;
wire nds_unused_dcu_wbf_flush = dcu_wbf_flush;
assign dcache_wpt_addr = {((DCACHE_WPT_RAM_AW - 1) + 1){1'b0}};
assign dcache_wpt_byte_we = {((DCACHE_WPT_RAM_BWEW - 1) + 1){1'b0}};
assign dcache_wpt_cs = 1'b0;
wire [(DCACHE_WPT_RAM_DW - 1):0] nds_unused_dcache_wpt_rdata = dcache_wpt_rdata;
assign dcache_wpt_wdata = {((DCACHE_WPT_RAM_DW - 1) + 1){1'b0}};
assign dcache_wpt_we = 1'b0;
endmodule

