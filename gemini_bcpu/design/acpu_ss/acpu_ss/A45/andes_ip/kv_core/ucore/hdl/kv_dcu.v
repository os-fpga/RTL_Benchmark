// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu (
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
    dcu_async_ecc_corr,
    dcu_async_ecc_error,
    dcu_async_ecc_ramid,
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
    dcu_wbf_flush,
    dcu_acctl_ecc_corr,
    dcu_acctl_ecc_error,
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
localparam DCU_DATA_WIDTH = L2_DATA_WIDTH > 128 ? 128 : L2_DATA_WIDTH;
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
output dcu_async_ecc_corr;
output dcu_async_ecc_error;
output [3:0] dcu_async_ecc_ramid;
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
input dcu_wbf_flush;
output dcu_acctl_ecc_corr;
output dcu_acctl_ecc_error;
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
output [(DCACHE_WPT_RAM_AW - 1):0] dcache_wpt_addr;
output [(DCACHE_WPT_RAM_BWEW - 1):0] dcache_wpt_byte_we;
output dcache_wpt_cs;
input [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_rdata;
output [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_wdata;
output dcache_wpt_we;


wire [(PALEN - 1):0] agent_a_address;
wire agent_a_corrupt;
wire [(DCU_DATA_WIDTH - 1):0] agent_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] agent_a_mask;
wire [2:0] agent_a_opcode;
wire [2:0] agent_a_param;
wire [2:0] agent_a_size;
wire [(SOURCE_WIDTH - 1):0] agent_a_source;
wire [11:0] agent_a_user;
wire agent_a_valid;
wire agent_b_ready;
wire [(PALEN - 1):0] agent_c_address;
wire agent_c_corrupt;
wire [(DCU_DATA_WIDTH - 1):0] agent_c_data;
wire [2:0] agent_c_opcode;
wire [2:0] agent_c_param;
wire [2:0] agent_c_size;
wire [(SOURCE_WIDTH - 1):0] agent_c_source;
wire [7:0] agent_c_user;
wire agent_c_valid;
wire agent_d_ready;
wire [(SINK_WIDTH - 1):0] agent_e_sink;
wire agent_e_valid;
wire evb_c_ready;
wire evb_d_error;
wire [(EVB_DEPTH - 1):0] evb_d_ptr;
wire evb_d_valid;
wire mshr_a_ready;
wire [(DCU_DATA_WIDTH - 1):0] mshr_d_data;
wire mshr_d_error;
wire [127:0] mshr_d_fildata;
wire mshr_d_fildata_last;
wire [3:0] mshr_d_l2_way;
wire mshr_d_last;
wire [5:3] mshr_d_offset;
wire [2:0] mshr_d_opcode;
wire [1:0] mshr_d_param;
wire mshr_d_payload;
wire [(MSHR_DEPTH - 1):0] mshr_d_ptr;
wire [(SINK_WIDTH - 1):0] mshr_d_sink;
wire mshr_d_valid;
wire mshr_e_ready;
wire [(PALEN - 1):0] probe_b_address;
wire [2:0] probe_b_opcode;
wire [2:0] probe_b_param;
wire [(SOURCE_WIDTH - 1):0] probe_b_source;
wire probe_b_valid;
wire agent_a_ready;
wire [(PALEN - 1):0] agent_b_address;
wire agent_b_corrupt;
wire [(DCU_DATA_WIDTH - 1):0] agent_b_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] agent_b_mask;
wire [2:0] agent_b_opcode;
wire [2:0] agent_b_param;
wire [2:0] agent_b_size;
wire [(SOURCE_WIDTH - 1):0] agent_b_source;
wire agent_b_valid;
wire agent_c_ready;
wire agent_d_corrupt;
wire [(DCU_DATA_WIDTH - 1):0] agent_d_data;
wire agent_d_denied;
wire [2:0] agent_d_opcode;
wire [1:0] agent_d_param;
wire [(SINK_WIDTH - 1):0] agent_d_sink;
wire [2:0] agent_d_size;
wire [(SOURCE_WIDTH - 1):0] agent_d_source;
wire [5:0] agent_d_user;
wire agent_d_valid;
wire agent_e_ready;
wire ctl_idle;
wire [(PALEN - 1):0] evb_cmp_addr;
wire evb_cmt_kill;
wire [(EVB_DEPTH - 1):0] evb_cmt_ptr;
wire evb_cmt_valid;
wire [(PALEN - 1):0] evb_enq_addr;
wire [1:0] evb_enq_eccen;
wire [5:0] evb_enq_func;
wire [(SOURCE_WIDTH - 1):0] evb_enq_source;
wire evb_enq_spec;
wire [3:0] evb_enq_state;
wire evb_enq_valid;
wire [3:0] evb_enq_way;
wire [(DCACHE_WBF_DEPTH - 1):0] evb_enq_wbf;
wire [(EVB_DEPTH - 1):0] evb_mrg_ptr;
wire evb_mrg_valid;
wire [3:0] evb_probe_func;
wire evt_ack_error1;
wire evt_ack_error2;
wire [127:0] evt_ack_rdata;
wire evt_ack_valid;
wire evt_req_ready;
wire fil_ready;
wire [(DCACHE_TAG_RAM_AW - 1):0] lru_cmt_idx;
wire lru_cmt_valid;
wire [3:0] lru_cmt_way;
wire [(DCACHE_TAG_RAM_AW - 1):0] lru_req_idx;
wire lru_req_valid;
wire mant_ack_defer;
wire [31:0] mant_ack_rdata;
wire [11:0] mant_ack_status;
wire mant_ack_valid;
wire mant_req_ready;
wire [(PALEN - 1):0] mshr_cmp_addr;
wire [1:0] mshr_cmp_func;
wire [(PALEN - 1):0] mshr_cmt_addr;
wire [5:0] mshr_cmt_attr;
wire mshr_cmt_kill;
wire [(MSHR_DEPTH - 1):0] mshr_cmt_ptr;
wire mshr_cmt_valid;
wire [31:0] mshr_cmt_wdata;
wire [3:0] mshr_cmt_wmask;
wire [(PALEN - 1):0] mshr_enq_addr;
wire [18:0] mshr_enq_func;
wire [0:0] mshr_enq_id;
wire [7:0] mshr_enq_l2_ways;
wire mshr_enq_mrg;
wire [(MSHR_DEPTH - 1):0] mshr_enq_mrg_ptr;
wire mshr_enq_spec;
wire mshr_enq_stall;
wire [3:0] mshr_enq_state;
wire mshr_enq_valid;
wire [3:0] mshr_enq_way;
wire [2:0] mshr_prb_mesi;
wire [(MSHR_DEPTH - 1):0] mshr_prb_ptr;
wire mshr_prb_valid;
wire mshr_wbf_flush;
wire [1:0] probe_ack_status;
wire probe_ack_valid;
wire probe_req_ready;
wire [(PALEN - 1):0] sb_cmp_addr;
wire sb_cmt_kill0;
wire sb_cmt_kill1;
wire sb_cmt_kill1_en;
wire sb_cmt_miss;
wire [(SB_DEPTH - 1):0] sb_cmt_ptr;
wire sb_cmt_valid;
wire [31:0] sb_cmt_wdata;
wire [3:0] sb_cmt_wmask;
wire sb_drain_ready;
wire [(PALEN - 1):0] sb_enq_addr;
wire [2:0] sb_enq_mesi;
wire sb_enq_mrg;
wire [(SB_DEPTH - 1):0] sb_enq_mrg_ptr;
wire sb_enq_rmw;
wire [31:0] sb_enq_rmwdata;
wire sb_enq_spec;
wire sb_enq_valid;
wire [3:0] sb_enq_way;
wire sb_evt_exclusive;
wire sb_evt_valid;
wire [127:0] sb_fil_beat_data;
wire sb_fil_fault;
wire sb_fil_last;
wire [2:0] sb_fil_mesi;
wire sb_fil_payload;
wire sb_fil_valid;
wire sb_probe_2b;
wire sb_probe_2n;
wire sb_probe_valid;
wire [(SB_DEPTH - 1):0] sb_req_hit_beat;
wire [(SB_DEPTH - 1):0] sb_req_hit_line;
wire [(PALEN - 1):0] wa_cmt_addr;
wire [2:0] wa_cmt_func;
wire wa_cmt_kill;
wire wa_cmt_valid;
wire [3:0] wa_cmt_wmask;
wire wbf_a0_kill;
wire wbf_a0_valid;
wire [(PALEN - 1):0] wpt_req_addr;
wire [7:0] wpt_req_data;
wire wpt_req_valid;
wire wpt_req_we;
wire dcu_xcctl_ecc_corr;
wire dcu_xcctl_ecc_error;
wire evb_async_ecc_corr;
wire evb_async_ecc_error;
wire evb_async_write_error;
wire [(PALEN - 1):0] evb_c_addr;
wire [(DCU_DATA_WIDTH - 1):0] evb_c_data;
wire [2:0] evb_c_opcode;
wire [2:0] evb_c_param;
wire [(EVB_DEPTH - 1):0] evb_c_ptr;
wire [(SOURCE_WIDTH - 1):0] evb_c_source;
wire [7:0] evb_c_user;
wire evb_c_valid;
wire [3:0] evb_cmp_cft;
wire [(EVB_DEPTH - 1):0] evb_cmp_hit_ptr;
wire [(EVB_DEPTH - 1):0] evb_cmp_speculative;
wire evb_d_ready;
wire evb_empty;
wire [(EVB_DEPTH - 1):0] evb_enq_ptr;
wire evb_enq_ready;
wire [(PALEN - 1):0] evt_req_addr;
wire evt_req_data;
wire evt_req_lock;
wire [2:0] evt_req_mesi;
wire evt_req_valid;
wire [3:0] evt_req_way;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_d0_valid;
wire [5:3] wbf_r0_addr;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_r0_index;
wire [5:4] wbf_w0_addr;
wire [127:0] wbf_w0_data;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_w0_index;
wire wbf_w0_valid;
wire [2:0] lru_ack_rdata;
wire mant_idle;
wire [(PALEN - 1):0] mant_req_addr;
wire [8:0] mant_req_func;
wire mant_req_valid;
wire [3:0] mant_req_way;
wire [31:0] mant_req_wdata;
wire [(PALEN - 1):0] fil_addr;
wire [3:0] fil_data_way;
wire fil_exclusive;
wire fil_fault;
wire [7:0] fil_l2_ways;
wire fil_last;
wire fil_lock;
wire [2:0] fil_mesi;
wire fil_payload;
wire fil_reserve;
wire fil_valid;
wire [3:0] fil_way;
wire [127:0] fil_wdata;
wire [(PALEN - 1):0] mshr_a_address;
wire mshr_a_corrupt;
wire [(DCU_DATA_WIDTH - 1):0] mshr_a_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] mshr_a_mask;
wire [2:0] mshr_a_opcode;
wire [2:0] mshr_a_param;
wire [(MSHR_DEPTH - 1):0] mshr_a_ptr;
wire [2:0] mshr_a_size;
wire [11:0] mshr_a_user;
wire mshr_a_valid;
wire mshr_async_write_error;
wire mshr_cmp_changing;
wire [(MSHR_DEPTH - 1):0] mshr_cmp_hit;
wire [2:0] mshr_cmp_mesi;
wire [(MSHR_DEPTH - 1):0] mshr_cmp_sameidx;
wire [3:0] mshr_cmp_tagw;
wire [3:0] mshr_cmp_way;
wire mshr_d_ready;
wire [(SINK_WIDTH - 1):0] mshr_e_sink;
wire mshr_e_valid;
wire mshr_empty;
wire [(MSHR_DEPTH - 1):0] mshr_ent_killed;
wire [(MSHR_DEPTH - 1):0] mshr_ent_na;
wire [(MSHR_DEPTH - 1):0] mshr_ent_na_mrg;
wire [(MSHR_DEPTH - 1):0] mshr_ent_speculative;
wire [(MSHR_DEPTH - 1):0] mshr_ent_wbf;
wire [(MSHR_DEPTH - 1):0] mshr_ent_wbf_cft;
wire [(MSHR_DEPTH - 1):0] mshr_ent_write;
wire [(MSHR_DEPTH - 1):0] mshr_ent_write_mrg;
wire [(MSHR_DEPTH - 1):0] mshr_ent_wt;
wire [(MSHR_DEPTH - 1):0] mshr_free_ptr;
wire mshr_full;
wire wbf_a1_valid;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_d1_valid;
wire [5:3] wbf_r1_addr;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_r1_index;
wire [5:4] wbf_w1_addr;
wire [127:0] wbf_w1_data;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_w1_index;
wire [15:0] wbf_w1_mask;
wire wbf_w1_valid;
wire probe_b_ready;
wire [(PALEN - 1):0] probe_req_addr;
wire [3:0] probe_req_func;
wire [(SOURCE_WIDTH - 1):0] probe_req_source;
wire probe_req_valid;
wire sb_afull;
wire [127:0] sb_cmp_beat_data;
wire [15:0] sb_cmp_beat_mask;
wire sb_cmp_hit;
wire [(SB_DEPTH - 1):0] sb_cmp_hit_beat_ptr;
wire [(SB_DEPTH - 1):0] sb_cmp_hit_line_ptr;
wire [(SB_DEPTH - 1):0] sb_cmp_hit_ptr;
wire [31:0] sb_cmp_rdata;
wire [3:0] sb_cmp_rmask;
wire [(PALEN - 1):0] sb_drain_addr;
wire [31:0] sb_drain_data;
wire [3:0] sb_drain_mask;
wire sb_drain_valid;
wire [3:0] sb_drain_way;
wire sb_empty;
wire [(SB_DEPTH - 1):0] sb_enq_free_ptr;
wire sb_full;
wire [(SB_DEPTH - 1):0] sb_pending;
wire wna_mode;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_a0_index;
wire wbf_a0_ready;
wire [(DCACHE_WBF_DEPTH - 1):0] wbf_a1_index;
wire wbf_a1_ready;
wire [(DCU_DATA_WIDTH - 1):0] wbf_r0_data;
wire [(DCU_DATA_WIDTH - 1):0] wbf_r1_data;
wire [(DCU_DATA_WIDTH / 8) - 1:0] wbf_r1_mask;
wire [7:0] wpt_ack_data;
generate
    if (CM_SUPPORT_INT == 0) begin:gen_probe_stub
        assign probe_req_valid = 1'b0;
        assign probe_req_addr = {PALEN{1'b0}};
        assign probe_req_func = {4{1'b0}};
        assign probe_req_source = {SOURCE_WIDTH{1'b0}};
        assign probe_b_ready = 1'b1;
        wire nds_unused_probe_req_ready = probe_req_ready;
        wire nds_unused_probe_ack_valid = probe_ack_valid;
        wire [1:0] nds_unused_probe_ack_status = probe_ack_status;
        wire nds_unused_probe_b_valid = probe_b_valid;
        wire [2:0] nds_unused_probe_b_opcode = probe_b_opcode;
        wire [2:0] nds_unused_probe_b_param = probe_b_param;
        wire [SOURCE_WIDTH - 1:0] nds_unused_probe_b_source = probe_b_source;
        wire [PALEN - 1:0] nds_unused_probe_b_address = probe_b_address;
    end
    if (!((DCACHE_WAY > 1) & (DCACHE_LRU_INT == 0))) begin:gen_lru_stub
        wire [(DCACHE_TAG_RAM_AW - 1):0] nds_unused_lru_req_idx = lru_req_idx;
        wire nds_unused_lru_cmt_valid = lru_cmt_valid;
        wire [(DCACHE_TAG_RAM_AW - 1):0] nds_unused_lru_cmt_idx = lru_cmt_idx;
        wire [3:0] nds_unused_lru_cmt_way = lru_cmt_way;
    end
    if (!WPT_SUPPORT) begin:gen_wpt_stub
        wire nds_unused_wpt_req_valid = |wpt_req_valid;
        wire nds_unused_wpt_req_we = |wpt_req_we;
        wire nds_unused_wpt_req_addr = |wpt_req_addr;
        wire nds_unused_wpt_req_data = |wpt_req_data;
        assign wpt_ack_data = 8'b0;
        assign dcache_wpt_addr = {DCACHE_WPT_RAM_AW{1'b0}};
        assign dcache_wpt_byte_we = {DCACHE_WPT_RAM_BWEW{1'b0}};
        assign dcache_wpt_cs = 1'b0;
        assign dcache_wpt_wdata = {DCACHE_WPT_RAM_DW{1'b0}};
        assign dcache_wpt_we = 1'b0;
        wire nds_unused_dcache_wpt_rdata = |dcache_wpt_rdata;
    end
endgenerate
kv_dcu_ctl #(
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .DCACHE_DATA_RAM_AW(DCACHE_DATA_RAM_AW),
    .DCACHE_DATA_RAM_BWEW(DCACHE_DATA_RAM_BWEW),
    .DCACHE_DATA_RAM_DW(DCACHE_DATA_RAM_DW),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_LRU_INT(DCACHE_LRU_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_TAG_RAM_AW(DCACHE_TAG_RAM_AW),
    .DCACHE_TAG_RAM_DW(DCACHE_TAG_RAM_DW),
    .DCACHE_WAY(DCACHE_WAY),
    .EVB_DEPTH(EVB_DEPTH),
    .MSHR_DEPTH(MSHR_DEPTH),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .SB_DEPTH(SB_DEPTH),
    .SOURCE_WIDTH(SOURCE_WIDTH),
    .WBF_DEPTH(DCACHE_WBF_DEPTH),
    .WPT_SUPPORT(WPT_SUPPORT),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) u_dcu_ctl (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .ctl_idle(ctl_idle),
    .dcu_standby_ready(dcu_standby_ready),
    .dcu_async_write_error(dcu_async_write_error),
    .dcu_wbf_flush(dcu_wbf_flush),
    .evb_async_ecc_error(evb_async_ecc_error),
    .evb_async_ecc_corr(evb_async_ecc_corr),
    .dcu_async_ecc_error(dcu_async_ecc_error),
    .dcu_async_ecc_corr(dcu_async_ecc_corr),
    .dcu_async_ecc_ramid(dcu_async_ecc_ramid),
    .dcu_event(dcu_event),
    .csr_mcache_ctl_dc_eccen(csr_mcache_ctl_dc_eccen),
    .csr_mcache_ctl_dc_rwecc(csr_mcache_ctl_dc_rwecc),
    .csr_mecc_code(csr_mecc_code),
    .mant_idle(mant_idle),
    .mant_req_valid(mant_req_valid),
    .mant_req_func(mant_req_func),
    .mant_req_addr(mant_req_addr),
    .mant_req_way(mant_req_way),
    .mant_req_wdata(mant_req_wdata),
    .mant_req_ready(mant_req_ready),
    .mant_ack_valid(mant_ack_valid),
    .mant_ack_rdata(mant_ack_rdata),
    .mant_ack_status(mant_ack_status),
    .mant_ack_defer(mant_ack_defer),
    .dcu_req_addr(dcu_req_addr),
    .dcu_req_id(dcu_req_id),
    .dcu_req_func(dcu_req_func),
    .dcu_req_valid(dcu_req_valid),
    .dcu_req_stall(dcu_req_stall),
    .dcu_req_ready(dcu_req_ready),
    .dcu_ack_valid(dcu_ack_valid),
    .dcu_ack_id(dcu_ack_id),
    .dcu_ack_rdata(dcu_ack_rdata),
    .dcu_ack_status(dcu_ack_status),
    .dcu_cmt_valid(dcu_cmt_valid),
    .dcu_cmt_addr(dcu_cmt_addr),
    .dcu_cmt_func(dcu_cmt_func),
    .dcu_cmt_wdata(dcu_cmt_wdata),
    .dcu_cmt_wmask(dcu_cmt_wmask),
    .probe_req_valid(probe_req_valid),
    .probe_req_func(probe_req_func),
    .probe_req_addr(probe_req_addr),
    .probe_req_source(probe_req_source),
    .probe_req_ready(probe_req_ready),
    .probe_ack_valid(probe_ack_valid),
    .probe_ack_status(probe_ack_status),
    .mshr_cmp_addr(mshr_cmp_addr),
    .mshr_cmp_func(mshr_cmp_func),
    .mshr_cmp_hit(mshr_cmp_hit),
    .mshr_cmp_sameidx(mshr_cmp_sameidx),
    .mshr_cmp_way(mshr_cmp_way),
    .mshr_cmp_tagw(mshr_cmp_tagw),
    .mshr_cmp_mesi(mshr_cmp_mesi),
    .mshr_cmp_changing(mshr_cmp_changing),
    .mshr_enq_valid(mshr_enq_valid),
    .mshr_enq_stall(mshr_enq_stall),
    .mshr_enq_mrg(mshr_enq_mrg),
    .mshr_enq_addr(mshr_enq_addr),
    .mshr_enq_spec(mshr_enq_spec),
    .mshr_enq_func(mshr_enq_func),
    .mshr_enq_id(mshr_enq_id),
    .mshr_enq_state(mshr_enq_state),
    .mshr_enq_way(mshr_enq_way),
    .mshr_enq_mrg_ptr(mshr_enq_mrg_ptr),
    .mshr_enq_l2_ways(mshr_enq_l2_ways),
    .mshr_free_ptr(mshr_free_ptr),
    .mshr_full(mshr_full),
    .mshr_empty(mshr_empty),
    .mshr_ent_speculative(mshr_ent_speculative),
    .mshr_ent_killed(mshr_ent_killed),
    .mshr_ent_wt(mshr_ent_wt),
    .mshr_ent_na(mshr_ent_na),
    .mshr_ent_na_mrg(mshr_ent_na_mrg),
    .mshr_ent_wbf(mshr_ent_wbf),
    .mshr_ent_wbf_cft(mshr_ent_wbf_cft),
    .mshr_ent_write(mshr_ent_write),
    .mshr_ent_write_mrg(mshr_ent_write_mrg),
    .mshr_cmt_valid(mshr_cmt_valid),
    .mshr_cmt_ptr(mshr_cmt_ptr),
    .mshr_cmt_addr(mshr_cmt_addr),
    .mshr_cmt_kill(mshr_cmt_kill),
    .mshr_cmt_attr(mshr_cmt_attr),
    .mshr_cmt_wdata(mshr_cmt_wdata),
    .mshr_cmt_wmask(mshr_cmt_wmask),
    .mshr_wbf_flush(mshr_wbf_flush),
    .mshr_async_write_error(mshr_async_write_error),
    .mshr_prb_valid(mshr_prb_valid),
    .mshr_prb_ptr(mshr_prb_ptr),
    .mshr_prb_mesi(mshr_prb_mesi),
    .sb_empty(sb_empty),
    .sb_full(sb_full),
    .sb_afull(sb_afull),
    .sb_pending(sb_pending),
    .sb_cmp_addr(sb_cmp_addr),
    .sb_cmp_hit(sb_cmp_hit),
    .sb_cmp_hit_ptr(sb_cmp_hit_ptr),
    .sb_cmp_hit_line_ptr(sb_cmp_hit_line_ptr),
    .sb_cmp_hit_beat_ptr(sb_cmp_hit_beat_ptr),
    .sb_cmp_rdata(sb_cmp_rdata),
    .sb_cmp_rmask(sb_cmp_rmask),
    .sb_cmp_beat_data(sb_cmp_beat_data),
    .sb_cmp_beat_mask(sb_cmp_beat_mask),
    .sb_fil_valid(sb_fil_valid),
    .sb_fil_last(sb_fil_last),
    .sb_fil_mesi(sb_fil_mesi),
    .sb_fil_fault(sb_fil_fault),
    .sb_fil_payload(sb_fil_payload),
    .sb_evt_valid(sb_evt_valid),
    .sb_evt_exclusive(sb_evt_exclusive),
    .sb_probe_valid(sb_probe_valid),
    .sb_probe_2n(sb_probe_2n),
    .sb_probe_2b(sb_probe_2b),
    .sb_enq_valid(sb_enq_valid),
    .sb_enq_spec(sb_enq_spec),
    .sb_enq_mrg(sb_enq_mrg),
    .sb_enq_mrg_ptr(sb_enq_mrg_ptr),
    .sb_enq_addr(sb_enq_addr),
    .sb_enq_mesi(sb_enq_mesi),
    .sb_enq_way(sb_enq_way),
    .sb_enq_rmw(sb_enq_rmw),
    .sb_enq_rmwdata(sb_enq_rmwdata),
    .sb_enq_free_ptr(sb_enq_free_ptr),
    .sb_fil_beat_data(sb_fil_beat_data),
    .sb_req_hit_line(sb_req_hit_line),
    .sb_req_hit_beat(sb_req_hit_beat),
    .sb_cmt_valid(sb_cmt_valid),
    .sb_cmt_wdata(sb_cmt_wdata),
    .sb_cmt_kill0(sb_cmt_kill0),
    .sb_cmt_kill1(sb_cmt_kill1),
    .sb_cmt_kill1_en(sb_cmt_kill1_en),
    .sb_cmt_wmask(sb_cmt_wmask),
    .sb_cmt_miss(sb_cmt_miss),
    .sb_cmt_ptr(sb_cmt_ptr),
    .sb_drain_valid(sb_drain_valid),
    .sb_drain_way(sb_drain_way),
    .sb_drain_addr(sb_drain_addr),
    .sb_drain_data(sb_drain_data),
    .sb_drain_mask(sb_drain_mask),
    .sb_drain_ready(sb_drain_ready),
    .lru_req_valid(lru_req_valid),
    .lru_req_idx(lru_req_idx),
    .lru_ack_rdata(lru_ack_rdata),
    .lru_cmt_valid(lru_cmt_valid),
    .lru_cmt_idx(lru_cmt_idx),
    .lru_cmt_way(lru_cmt_way),
    .fil_valid(fil_valid),
    .fil_addr(fil_addr),
    .fil_way(fil_way),
    .fil_last(fil_last),
    .fil_fault(fil_fault),
    .fil_lock(fil_lock),
    .fil_mesi(fil_mesi),
    .fil_wdata(fil_wdata),
    .fil_payload(fil_payload),
    .fil_data_way(fil_data_way),
    .fil_reserve(fil_reserve),
    .fil_exclusive(fil_exclusive),
    .fil_l2_ways(fil_l2_ways),
    .fil_ready(fil_ready),
    .evb_empty(evb_empty),
    .evb_cmp_addr(evb_cmp_addr),
    .evb_cmp_hit_ptr(evb_cmp_hit_ptr),
    .evb_cmp_speculative(evb_cmp_speculative),
    .evb_cmp_cft(evb_cmp_cft),
    .evb_enq_ready(evb_enq_ready),
    .evb_enq_valid(evb_enq_valid),
    .evb_enq_source(evb_enq_source),
    .evb_enq_spec(evb_enq_spec),
    .evb_enq_eccen(evb_enq_eccen),
    .evb_enq_addr(evb_enq_addr),
    .evb_enq_state(evb_enq_state),
    .evb_enq_way(evb_enq_way),
    .evb_enq_wbf(evb_enq_wbf),
    .evb_enq_func(evb_enq_func),
    .evb_enq_ptr(evb_enq_ptr),
    .evb_mrg_valid(evb_mrg_valid),
    .evb_mrg_ptr(evb_mrg_ptr),
    .evb_probe_func(evb_probe_func),
    .evb_cmt_valid(evb_cmt_valid),
    .evb_cmt_kill(evb_cmt_kill),
    .evb_cmt_ptr(evb_cmt_ptr),
    .evb_async_write_error(evb_async_write_error),
    .evt_req_valid(evt_req_valid),
    .evt_req_addr(evt_req_addr),
    .evt_req_way(evt_req_way),
    .evt_req_mesi(evt_req_mesi),
    .evt_req_lock(evt_req_lock),
    .evt_req_data(evt_req_data),
    .evt_req_ready(evt_req_ready),
    .evt_ack_valid(evt_ack_valid),
    .evt_ack_rdata(evt_ack_rdata),
    .evt_ack_error1(evt_ack_error1),
    .evt_ack_error2(evt_ack_error2),
    .wbf_a0_valid(wbf_a0_valid),
    .wbf_a0_kill(wbf_a0_kill),
    .wbf_a0_index(wbf_a0_index),
    .wbf_a0_ready(wbf_a0_ready),
    .wa_cmt_valid(wa_cmt_valid),
    .wa_cmt_kill(wa_cmt_kill),
    .wa_cmt_addr(wa_cmt_addr),
    .wa_cmt_wmask(wa_cmt_wmask),
    .wa_cmt_func(wa_cmt_func),
    .wna_mode(wna_mode),
    .wpt_req_valid(wpt_req_valid),
    .wpt_req_we(wpt_req_we),
    .wpt_req_addr(wpt_req_addr),
    .wpt_req_data(wpt_req_data),
    .wpt_ack_data(wpt_ack_data),
    .dcache_tag0_cs(dcache_tag0_cs),
    .dcache_tag0_wdata(dcache_tag0_wdata),
    .dcache_tag0_rdata(dcache_tag0_rdata),
    .dcache_tag0_we(dcache_tag0_we),
    .dcache_tag0_addr(dcache_tag0_addr),
    .dcache_data0_cs(dcache_data0_cs),
    .dcache_data0_we(dcache_data0_we),
    .dcache_data0_wdata(dcache_data0_wdata),
    .dcache_data0_byte_we(dcache_data0_byte_we),
    .dcache_data0_addr(dcache_data0_addr),
    .dcache_data0_rdata(dcache_data0_rdata),
    .dcache_tag1_cs(dcache_tag1_cs),
    .dcache_tag1_wdata(dcache_tag1_wdata),
    .dcache_tag1_rdata(dcache_tag1_rdata),
    .dcache_tag1_we(dcache_tag1_we),
    .dcache_tag1_addr(dcache_tag1_addr),
    .dcache_data1_cs(dcache_data1_cs),
    .dcache_data1_we(dcache_data1_we),
    .dcache_data1_wdata(dcache_data1_wdata),
    .dcache_data1_byte_we(dcache_data1_byte_we),
    .dcache_data1_addr(dcache_data1_addr),
    .dcache_data1_rdata(dcache_data1_rdata),
    .dcache_tag2_cs(dcache_tag2_cs),
    .dcache_tag2_wdata(dcache_tag2_wdata),
    .dcache_tag2_rdata(dcache_tag2_rdata),
    .dcache_tag2_we(dcache_tag2_we),
    .dcache_tag2_addr(dcache_tag2_addr),
    .dcache_data2_cs(dcache_data2_cs),
    .dcache_data2_we(dcache_data2_we),
    .dcache_data2_wdata(dcache_data2_wdata),
    .dcache_data2_byte_we(dcache_data2_byte_we),
    .dcache_data2_addr(dcache_data2_addr),
    .dcache_data2_rdata(dcache_data2_rdata),
    .dcache_tag3_cs(dcache_tag3_cs),
    .dcache_tag3_wdata(dcache_tag3_wdata),
    .dcache_tag3_rdata(dcache_tag3_rdata),
    .dcache_tag3_we(dcache_tag3_we),
    .dcache_tag3_addr(dcache_tag3_addr),
    .dcache_data3_cs(dcache_data3_cs),
    .dcache_data3_we(dcache_data3_we),
    .dcache_data3_wdata(dcache_data3_wdata),
    .dcache_data3_byte_we(dcache_data3_byte_we),
    .dcache_data3_addr(dcache_data3_addr),
    .dcache_data3_rdata(dcache_data3_rdata)
);
kv_dcu_mant #(
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_WAY(DCACHE_WAY),
    .PALEN(PALEN)
) u_dcu_mant (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .dcache_disable_init(dcache_disable_init),
    .ctl_idle(ctl_idle),
    .dcu_ix_req(dcu_ix_req),
    .dcu_ix_addr(dcu_ix_addr),
    .dcu_ix_command(dcu_ix_command),
    .dcu_ix_wdata(dcu_ix_wdata),
    .dcu_ix_ack(dcu_ix_ack),
    .dcu_ix_rdata(dcu_ix_rdata),
    .dcu_ix_raddr(dcu_ix_raddr),
    .dcu_ix_status(dcu_ix_status),
    .evb_empty(evb_empty),
    .dcu_xcctl_ecc_error(dcu_xcctl_ecc_error),
    .dcu_xcctl_ecc_corr(dcu_xcctl_ecc_corr),
    .mant_idle(mant_idle),
    .mant_req_valid(mant_req_valid),
    .mant_req_func(mant_req_func),
    .mant_req_addr(mant_req_addr),
    .mant_req_way(mant_req_way),
    .mant_req_wdata(mant_req_wdata),
    .mant_req_ready(mant_req_ready),
    .mant_ack_valid(mant_ack_valid),
    .mant_ack_rdata(mant_ack_rdata),
    .mant_ack_status(mant_ack_status),
    .mant_ack_defer(mant_ack_defer)
);
generate
    if ((DCACHE_WAY > 1) & (DCACHE_LRU_INT == 0)) begin:gen_lru
        kv_dcu_lru #(
            .DCACHE_TAG_RAM_AW(DCACHE_TAG_RAM_AW),
            .DCACHE_WAY(DCACHE_WAY)
        ) u_dcu_lru (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .lru_req_valid(lru_req_valid),
            .lru_req_idx(lru_req_idx),
            .lru_ack_rdata(lru_ack_rdata),
            .lru_cmt_valid(lru_cmt_valid),
            .lru_cmt_idx(lru_cmt_idx),
            .lru_cmt_way(lru_cmt_way)
        );
    end
endgenerate
generate
    if ((DCACHE_WAY == 1) || (DCACHE_LRU_INT != 0)) begin:gen_rr
        kv_dcu_rr #(
            .DCACHE_WAY(DCACHE_WAY)
        ) u_dcu_rr (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .lru_cmt_valid(lru_cmt_valid),
            .lru_ack_rdata(lru_ack_rdata)
        );
    end
endgenerate
generate
    if (CM_SUPPORT_INT == 1) begin:gen_probe
        kv_dcu_probe #(
            .FIFO_DEPTH(MSHR_DEPTH),
            .PALEN(PALEN),
            .SOURCE_WIDTH(SOURCE_WIDTH)
        ) u_dcu_probe (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .probe_b_valid(probe_b_valid),
            .probe_b_opcode(probe_b_opcode),
            .probe_b_param(probe_b_param),
            .probe_b_source(probe_b_source),
            .probe_b_address(probe_b_address),
            .probe_b_ready(probe_b_ready),
            .probe_req_valid(probe_req_valid),
            .probe_req_func(probe_req_func),
            .probe_req_addr(probe_req_addr),
            .probe_req_source(probe_req_source),
            .probe_req_ready(probe_req_ready),
            .probe_ack_valid(probe_ack_valid),
            .probe_ack_status(probe_ack_status)
        );
    end
endgenerate
generate
    if (WPT_SUPPORT) begin:gen_wpt
        kv_dcu_wpt #(
            .DCACHE_WPT_RAM_AW(DCACHE_WPT_RAM_AW),
            .DCACHE_WPT_RAM_BWEW(DCACHE_WPT_RAM_BWEW),
            .DCACHE_WPT_RAM_DW(DCACHE_WPT_RAM_DW),
            .PALEN(PALEN)
        ) u_dcu_wpt (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(dcu_reset_n),
            .wpt_req_valid(wpt_req_valid),
            .wpt_req_we(wpt_req_we),
            .wpt_req_addr(wpt_req_addr),
            .wpt_req_data(wpt_req_data),
            .wpt_ack_data(wpt_ack_data),
            .dcache_wpt_cs(dcache_wpt_cs),
            .dcache_wpt_we(dcache_wpt_we),
            .dcache_wpt_wdata(dcache_wpt_wdata),
            .dcache_wpt_byte_we(dcache_wpt_byte_we),
            .dcache_wpt_addr(dcache_wpt_addr),
            .dcache_wpt_rdata(dcache_wpt_rdata)
        );
    end
endgenerate
kv_dcu_mshr #(
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_WAY(DCACHE_WAY),
    .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
    .MSHR_DEPTH(MSHR_DEPTH),
    .PALEN(PALEN),
    .SINK_WIDTH(SINK_WIDTH),
    .WBF_DEPTH(DCACHE_WBF_DEPTH),
    .WPT_SUPPORT(WPT_SUPPORT),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) u_dcu_mshr (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .dcu_wna_pending(dcu_wna_pending),
    .mshr_empty(mshr_empty),
    .mshr_full(mshr_full),
    .mshr_ent_speculative(mshr_ent_speculative),
    .mshr_ent_killed(mshr_ent_killed),
    .mshr_ent_wt(mshr_ent_wt),
    .mshr_ent_na(mshr_ent_na),
    .mshr_ent_na_mrg(mshr_ent_na_mrg),
    .mshr_ent_wbf(mshr_ent_wbf),
    .mshr_ent_wbf_cft(mshr_ent_wbf_cft),
    .mshr_ent_write(mshr_ent_write),
    .mshr_ent_write_mrg(mshr_ent_write_mrg),
    .mshr_event(mshr_event),
    .mshr_cmp_addr(mshr_cmp_addr),
    .mshr_cmp_func(mshr_cmp_func),
    .mshr_cmp_hit(mshr_cmp_hit),
    .mshr_cmp_sameidx(mshr_cmp_sameidx),
    .mshr_cmp_way(mshr_cmp_way),
    .mshr_cmp_tagw(mshr_cmp_tagw),
    .mshr_cmp_mesi(mshr_cmp_mesi),
    .mshr_cmp_changing(mshr_cmp_changing),
    .mshr_enq_valid(mshr_enq_valid),
    .mshr_enq_stall(mshr_enq_stall),
    .mshr_enq_mrg(mshr_enq_mrg),
    .mshr_enq_mrg_ptr(mshr_enq_mrg_ptr),
    .mshr_enq_id(mshr_enq_id),
    .mshr_enq_addr(mshr_enq_addr),
    .mshr_enq_spec(mshr_enq_spec),
    .mshr_enq_state(mshr_enq_state),
    .mshr_enq_way(mshr_enq_way),
    .mshr_enq_l2_ways(mshr_enq_l2_ways),
    .mshr_enq_func(mshr_enq_func),
    .mshr_free_ptr(mshr_free_ptr),
    .mshr_cmt_valid(mshr_cmt_valid),
    .mshr_cmt_ptr(mshr_cmt_ptr),
    .mshr_cmt_addr(mshr_cmt_addr),
    .mshr_cmt_kill(mshr_cmt_kill),
    .mshr_cmt_attr(mshr_cmt_attr),
    .mshr_cmt_wdata(mshr_cmt_wdata),
    .mshr_cmt_wmask(mshr_cmt_wmask),
    .mshr_wbf_flush(mshr_wbf_flush),
    .mshr_prb_valid(mshr_prb_valid),
    .mshr_prb_ptr(mshr_prb_ptr),
    .mshr_prb_mesi(mshr_prb_mesi),
    .wbf_a1_valid(wbf_a1_valid),
    .wbf_a1_index(wbf_a1_index),
    .wbf_a1_ready(wbf_a1_ready),
    .wbf_w1_valid(wbf_w1_valid),
    .wbf_w1_index(wbf_w1_index),
    .wbf_w1_addr(wbf_w1_addr),
    .wbf_w1_data(wbf_w1_data),
    .wbf_w1_mask(wbf_w1_mask),
    .wbf_r1_index(wbf_r1_index),
    .wbf_r1_addr(wbf_r1_addr),
    .wbf_r1_data(wbf_r1_data),
    .wbf_r1_mask(wbf_r1_mask),
    .wbf_d1_valid(wbf_d1_valid),
    .mshr_a_valid(mshr_a_valid),
    .mshr_a_ptr(mshr_a_ptr),
    .mshr_a_ready(mshr_a_ready),
    .mshr_a_opcode(mshr_a_opcode),
    .mshr_a_address(mshr_a_address),
    .mshr_a_size(mshr_a_size),
    .mshr_a_param(mshr_a_param),
    .mshr_a_user(mshr_a_user),
    .mshr_a_data(mshr_a_data),
    .mshr_a_mask(mshr_a_mask),
    .mshr_a_corrupt(mshr_a_corrupt),
    .mshr_d_valid(mshr_d_valid),
    .mshr_d_opcode(mshr_d_opcode),
    .mshr_d_ptr(mshr_d_ptr),
    .mshr_d_sink(mshr_d_sink),
    .mshr_d_data(mshr_d_data),
    .mshr_d_param(mshr_d_param),
    .mshr_d_offset(mshr_d_offset),
    .mshr_d_payload(mshr_d_payload),
    .mshr_d_error(mshr_d_error),
    .mshr_d_last(mshr_d_last),
    .mshr_d_fildata(mshr_d_fildata),
    .mshr_d_fildata_last(mshr_d_fildata_last),
    .mshr_d_l2_way(mshr_d_l2_way),
    .mshr_d_ready(mshr_d_ready),
    .mshr_e_valid(mshr_e_valid),
    .mshr_e_sink(mshr_e_sink),
    .mshr_e_ready(mshr_e_ready),
    .fil_valid(fil_valid),
    .fil_addr(fil_addr),
    .fil_last(fil_last),
    .fil_way(fil_way),
    .fil_mesi(fil_mesi),
    .fil_fault(fil_fault),
    .fil_lock(fil_lock),
    .fil_reserve(fil_reserve),
    .fil_exclusive(fil_exclusive),
    .fil_wdata(fil_wdata),
    .fil_payload(fil_payload),
    .fil_data_way(fil_data_way),
    .fil_l2_ways(fil_l2_ways),
    .fil_ready(fil_ready),
    .dcu_cri_valid(dcu_cri_valid),
    .dcu_cri_id(dcu_cri_id),
    .dcu_cri_rdata(dcu_cri_rdata),
    .dcu_cri_nbload_result(dcu_cri_nbload_result),
    .dcu_cri_status(dcu_cri_status),
    .mshr_async_write_error(mshr_async_write_error)
);
kv_dcu_wa #(
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .PALEN(PALEN),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) u_dcu_wa (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .csr_mcache_ctl_dc_waround(csr_mcache_ctl_dc_waround),
    .wa_cmt_valid(wa_cmt_valid),
    .wa_cmt_kill(wa_cmt_kill),
    .wa_cmt_addr(wa_cmt_addr),
    .wa_cmt_wmask(wa_cmt_wmask),
    .wa_cmt_func(wa_cmt_func),
    .wna_mode(wna_mode)
);
kv_dcu_sb #(
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .PALEN(PALEN),
    .SB_DEPTH(SB_DEPTH)
) u_dcu_sb (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .sb_empty(sb_empty),
    .sb_full(sb_full),
    .sb_afull(sb_afull),
    .sb_pending(sb_pending),
    .sb_cmp_addr(sb_cmp_addr),
    .sb_cmp_hit(sb_cmp_hit),
    .sb_cmp_hit_ptr(sb_cmp_hit_ptr),
    .sb_cmp_hit_line_ptr(sb_cmp_hit_line_ptr),
    .sb_cmp_hit_beat_ptr(sb_cmp_hit_beat_ptr),
    .sb_cmp_rdata(sb_cmp_rdata),
    .sb_cmp_rmask(sb_cmp_rmask),
    .sb_cmp_beat_data(sb_cmp_beat_data),
    .sb_cmp_beat_mask(sb_cmp_beat_mask),
    .sb_fil_beat_data(sb_fil_beat_data),
    .sb_req_hit_line(sb_req_hit_line),
    .sb_req_hit_beat(sb_req_hit_beat),
    .sb_fil_valid(sb_fil_valid),
    .sb_fil_last(sb_fil_last),
    .sb_fil_mesi(sb_fil_mesi),
    .sb_fil_fault(sb_fil_fault),
    .sb_fil_payload(sb_fil_payload),
    .sb_probe_valid(sb_probe_valid),
    .sb_probe_2n(sb_probe_2n),
    .sb_probe_2b(sb_probe_2b),
    .sb_evt_valid(sb_evt_valid),
    .sb_evt_exclusive(sb_evt_exclusive),
    .sb_cmt_valid(sb_cmt_valid),
    .sb_cmt_kill0(sb_cmt_kill0),
    .sb_cmt_kill1(sb_cmt_kill1),
    .sb_cmt_kill1_en(sb_cmt_kill1_en),
    .sb_cmt_wdata(sb_cmt_wdata),
    .sb_cmt_wmask(sb_cmt_wmask),
    .sb_cmt_miss(sb_cmt_miss),
    .sb_cmt_ptr(sb_cmt_ptr),
    .sb_enq_valid(sb_enq_valid),
    .sb_enq_spec(sb_enq_spec),
    .sb_enq_mrg(sb_enq_mrg),
    .sb_enq_mrg_ptr(sb_enq_mrg_ptr),
    .sb_enq_addr(sb_enq_addr),
    .sb_enq_mesi(sb_enq_mesi),
    .sb_enq_way(sb_enq_way),
    .sb_enq_rmw(sb_enq_rmw),
    .sb_enq_rmwdata(sb_enq_rmwdata),
    .sb_enq_free_ptr(sb_enq_free_ptr),
    .sb_drain_valid(sb_drain_valid),
    .sb_drain_way(sb_drain_way),
    .sb_drain_addr(sb_drain_addr),
    .sb_drain_data(sb_drain_data),
    .sb_drain_mask(sb_drain_mask),
    .sb_drain_ready(sb_drain_ready)
);
kv_dcu_evb #(
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_WAY(DCACHE_WAY),
    .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
    .EVB_DEPTH(EVB_DEPTH),
    .PALEN(PALEN),
    .SOURCE_WIDTH(SOURCE_WIDTH),
    .WBF_DEPTH(DCACHE_WBF_DEPTH),
    .WPT_SUPPORT(WPT_SUPPORT)
) u_dcu_evb (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .evb_empty(evb_empty),
    .evb_async_ecc_error(evb_async_ecc_error),
    .evb_async_ecc_corr(evb_async_ecc_corr),
    .dcu_acctl_ecc_error(dcu_acctl_ecc_error),
    .dcu_acctl_ecc_corr(dcu_acctl_ecc_corr),
    .dcu_xcctl_ecc_error(dcu_xcctl_ecc_error),
    .dcu_xcctl_ecc_corr(dcu_xcctl_ecc_corr),
    .evb_async_write_error(evb_async_write_error),
    .evb_cmp_addr(evb_cmp_addr),
    .evb_cmp_hit_ptr(evb_cmp_hit_ptr),
    .evb_cmp_speculative(evb_cmp_speculative),
    .evb_cmp_cft(evb_cmp_cft),
    .evb_enq_valid(evb_enq_valid),
    .evb_enq_source(evb_enq_source),
    .evb_enq_spec(evb_enq_spec),
    .evb_enq_addr(evb_enq_addr),
    .evb_enq_eccen(evb_enq_eccen),
    .evb_enq_state(evb_enq_state),
    .evb_enq_way(evb_enq_way),
    .evb_enq_func(evb_enq_func),
    .evb_enq_wbf(evb_enq_wbf),
    .evb_enq_ready(evb_enq_ready),
    .evb_enq_ptr(evb_enq_ptr),
    .evb_mrg_valid(evb_mrg_valid),
    .evb_mrg_ptr(evb_mrg_ptr),
    .evb_probe_func(evb_probe_func),
    .evb_cmt_valid(evb_cmt_valid),
    .evb_cmt_kill(evb_cmt_kill),
    .evb_cmt_ptr(evb_cmt_ptr),
    .evt_req_valid(evt_req_valid),
    .evt_req_addr(evt_req_addr),
    .evt_req_way(evt_req_way),
    .evt_req_mesi(evt_req_mesi),
    .evt_req_lock(evt_req_lock),
    .evt_req_data(evt_req_data),
    .evt_req_ready(evt_req_ready),
    .evt_ack_valid(evt_ack_valid),
    .evt_ack_rdata(evt_ack_rdata),
    .evt_ack_error1(evt_ack_error1),
    .evt_ack_error2(evt_ack_error2),
    .evb_c_valid(evb_c_valid),
    .evb_c_opcode(evb_c_opcode),
    .evb_c_param(evb_c_param),
    .evb_c_addr(evb_c_addr),
    .evb_c_data(evb_c_data),
    .evb_c_source(evb_c_source),
    .evb_c_ptr(evb_c_ptr),
    .evb_c_user(evb_c_user),
    .evb_c_ready(evb_c_ready),
    .evb_d_valid(evb_d_valid),
    .evb_d_ptr(evb_d_ptr),
    .evb_d_error(evb_d_error),
    .evb_d_ready(evb_d_ready),
    .wbf_w0_valid(wbf_w0_valid),
    .wbf_w0_index(wbf_w0_index),
    .wbf_w0_addr(wbf_w0_addr),
    .wbf_w0_data(wbf_w0_data),
    .wbf_r0_index(wbf_r0_index),
    .wbf_r0_addr(wbf_r0_addr),
    .wbf_r0_data(wbf_r0_data),
    .wbf_d0_valid(wbf_d0_valid)
);
kv_dcu_wbf #(
    .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
    .WBF_DEPTH(DCACHE_WBF_DEPTH),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) u_dcu_wbf (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .wbf_a0_valid(wbf_a0_valid),
    .wbf_a0_kill(wbf_a0_kill),
    .wbf_a0_index(wbf_a0_index),
    .wbf_a0_ready(wbf_a0_ready),
    .wbf_w0_valid(wbf_w0_valid),
    .wbf_w0_index(wbf_w0_index),
    .wbf_w0_addr(wbf_w0_addr),
    .wbf_w0_data(wbf_w0_data),
    .wbf_r0_index(wbf_r0_index),
    .wbf_r0_addr(wbf_r0_addr),
    .wbf_r0_data(wbf_r0_data),
    .wbf_d0_valid(wbf_d0_valid),
    .wbf_a1_valid(wbf_a1_valid),
    .wbf_a1_index(wbf_a1_index),
    .wbf_a1_ready(wbf_a1_ready),
    .wbf_w1_valid(wbf_w1_valid),
    .wbf_w1_index(wbf_w1_index),
    .wbf_w1_addr(wbf_w1_addr),
    .wbf_w1_data(wbf_w1_data),
    .wbf_w1_mask(wbf_w1_mask),
    .wbf_r1_index(wbf_r1_index),
    .wbf_r1_addr(wbf_r1_addr),
    .wbf_r1_data(wbf_r1_data),
    .wbf_r1_mask(wbf_r1_mask),
    .wbf_d1_valid(wbf_d1_valid)
);
kv_dcu_agent #(
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
    .EVB_DEPTH(EVB_DEPTH),
    .MSHR_DEPTH(MSHR_DEPTH),
    .PALEN(PALEN),
    .SINK_WIDTH(SINK_WIDTH),
    .SOURCE_WIDTH(SOURCE_WIDTH)
) u_dcu_agent (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .mshr_a_valid(mshr_a_valid),
    .mshr_a_ready(mshr_a_ready),
    .mshr_a_ptr(mshr_a_ptr),
    .mshr_a_opcode(mshr_a_opcode),
    .mshr_a_address(mshr_a_address),
    .mshr_a_size(mshr_a_size),
    .mshr_a_param(mshr_a_param),
    .mshr_a_user(mshr_a_user),
    .mshr_a_data(mshr_a_data),
    .mshr_a_mask(mshr_a_mask),
    .mshr_a_corrupt(mshr_a_corrupt),
    .mshr_d_valid(mshr_d_valid),
    .mshr_d_opcode(mshr_d_opcode),
    .mshr_d_ptr(mshr_d_ptr),
    .mshr_d_sink(mshr_d_sink),
    .mshr_d_data(mshr_d_data),
    .mshr_d_param(mshr_d_param),
    .mshr_d_payload(mshr_d_payload),
    .mshr_d_last(mshr_d_last),
    .mshr_d_offset(mshr_d_offset),
    .mshr_d_error(mshr_d_error),
    .mshr_d_fildata(mshr_d_fildata),
    .mshr_d_fildata_last(mshr_d_fildata_last),
    .mshr_d_l2_way(mshr_d_l2_way),
    .mshr_d_ready(mshr_d_ready),
    .mshr_e_valid(mshr_e_valid),
    .mshr_e_sink(mshr_e_sink),
    .mshr_e_ready(mshr_e_ready),
    .evb_c_valid(evb_c_valid),
    .evb_c_opcode(evb_c_opcode),
    .evb_c_param(evb_c_param),
    .evb_c_addr(evb_c_addr),
    .evb_c_data(evb_c_data),
    .evb_c_source(evb_c_source),
    .evb_c_ptr(evb_c_ptr),
    .evb_c_ready(evb_c_ready),
    .evb_d_valid(evb_d_valid),
    .evb_d_ready(evb_d_ready),
    .evb_c_user(evb_c_user),
    .evb_d_ptr(evb_d_ptr),
    .evb_d_error(evb_d_error),
    .probe_b_valid(probe_b_valid),
    .probe_b_opcode(probe_b_opcode),
    .probe_b_param(probe_b_param),
    .probe_b_source(probe_b_source),
    .probe_b_address(probe_b_address),
    .probe_b_ready(probe_b_ready),
    .agent_a_opcode(agent_a_opcode),
    .agent_a_param(agent_a_param),
    .agent_a_user(agent_a_user),
    .agent_a_size(agent_a_size),
    .agent_a_source(agent_a_source),
    .agent_a_address(agent_a_address),
    .agent_a_data(agent_a_data),
    .agent_a_mask(agent_a_mask),
    .agent_a_corrupt(agent_a_corrupt),
    .agent_a_valid(agent_a_valid),
    .agent_a_ready(agent_a_ready),
    .agent_b_opcode(agent_b_opcode),
    .agent_b_param(agent_b_param),
    .agent_b_size(agent_b_size),
    .agent_b_source(agent_b_source),
    .agent_b_address(agent_b_address),
    .agent_b_data(agent_b_data),
    .agent_b_mask(agent_b_mask),
    .agent_b_corrupt(agent_b_corrupt),
    .agent_b_valid(agent_b_valid),
    .agent_b_ready(agent_b_ready),
    .agent_c_opcode(agent_c_opcode),
    .agent_c_param(agent_c_param),
    .agent_c_size(agent_c_size),
    .agent_c_user(agent_c_user),
    .agent_c_source(agent_c_source),
    .agent_c_address(agent_c_address),
    .agent_c_data(agent_c_data),
    .agent_c_corrupt(agent_c_corrupt),
    .agent_c_valid(agent_c_valid),
    .agent_c_ready(agent_c_ready),
    .agent_d_opcode(agent_d_opcode),
    .agent_d_param(agent_d_param),
    .agent_d_user(agent_d_user),
    .agent_d_size(agent_d_size),
    .agent_d_source(agent_d_source),
    .agent_d_data(agent_d_data),
    .agent_d_denied(agent_d_denied),
    .agent_d_corrupt(agent_d_corrupt),
    .agent_d_sink(agent_d_sink),
    .agent_d_valid(agent_d_valid),
    .agent_d_ready(agent_d_ready),
    .agent_e_valid(agent_e_valid),
    .agent_e_sink(agent_e_sink),
    .agent_e_ready(agent_e_ready)
);
kv_dcu_brg #(
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .DCU_DATA_WIDTH(DCU_DATA_WIDTH),
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .MSHR_DEPTH(MSHR_DEPTH),
    .PALEN(PALEN),
    .SINK_WIDTH(SINK_WIDTH),
    .SOURCE_WIDTH(SOURCE_WIDTH)
) u_dcu_brg (
    .dcu_clk(dcu_clk),
    .dcu_reset_n(dcu_reset_n),
    .agent_a_opcode(agent_a_opcode),
    .agent_a_param(agent_a_param),
    .agent_a_user(agent_a_user),
    .agent_a_size(agent_a_size),
    .agent_a_source(agent_a_source),
    .agent_a_address(agent_a_address),
    .agent_a_data(agent_a_data),
    .agent_a_mask(agent_a_mask),
    .agent_a_corrupt(agent_a_corrupt),
    .agent_a_valid(agent_a_valid),
    .agent_a_ready(agent_a_ready),
    .agent_b_opcode(agent_b_opcode),
    .agent_b_param(agent_b_param),
    .agent_b_size(agent_b_size),
    .agent_b_source(agent_b_source),
    .agent_b_address(agent_b_address),
    .agent_b_data(agent_b_data),
    .agent_b_mask(agent_b_mask),
    .agent_b_corrupt(agent_b_corrupt),
    .agent_b_valid(agent_b_valid),
    .agent_b_ready(agent_b_ready),
    .agent_c_opcode(agent_c_opcode),
    .agent_c_param(agent_c_param),
    .agent_c_size(agent_c_size),
    .agent_c_user(agent_c_user),
    .agent_c_source(agent_c_source),
    .agent_c_address(agent_c_address),
    .agent_c_data(agent_c_data),
    .agent_c_corrupt(agent_c_corrupt),
    .agent_c_valid(agent_c_valid),
    .agent_c_ready(agent_c_ready),
    .agent_d_opcode(agent_d_opcode),
    .agent_d_param(agent_d_param),
    .agent_d_user(agent_d_user),
    .agent_d_size(agent_d_size),
    .agent_d_source(agent_d_source),
    .agent_d_sink(agent_d_sink),
    .agent_d_data(agent_d_data),
    .agent_d_denied(agent_d_denied),
    .agent_d_corrupt(agent_d_corrupt),
    .agent_d_valid(agent_d_valid),
    .agent_d_ready(agent_d_ready),
    .agent_e_valid(agent_e_valid),
    .agent_e_sink(agent_e_sink),
    .agent_e_ready(agent_e_ready),
    .dcu_a_opcode(dcu_a_opcode),
    .dcu_a_param(dcu_a_param),
    .dcu_a_user(dcu_a_user),
    .dcu_a_size(dcu_a_size),
    .dcu_a_source(dcu_a_source),
    .dcu_a_address(dcu_a_address),
    .dcu_a_data(dcu_a_data),
    .dcu_a_mask(dcu_a_mask),
    .dcu_a_corrupt(dcu_a_corrupt),
    .dcu_a_valid(dcu_a_valid),
    .dcu_a_ready(dcu_a_ready),
    .dcu_b_opcode(dcu_b_opcode),
    .dcu_b_param(dcu_b_param),
    .dcu_b_size(dcu_b_size),
    .dcu_b_source(dcu_b_source),
    .dcu_b_address(dcu_b_address),
    .dcu_b_data(dcu_b_data),
    .dcu_b_mask(dcu_b_mask),
    .dcu_b_corrupt(dcu_b_corrupt),
    .dcu_b_valid(dcu_b_valid),
    .dcu_b_ready(dcu_b_ready),
    .dcu_c_opcode(dcu_c_opcode),
    .dcu_c_param(dcu_c_param),
    .dcu_c_user(dcu_c_user),
    .dcu_c_size(dcu_c_size),
    .dcu_c_source(dcu_c_source),
    .dcu_c_address(dcu_c_address),
    .dcu_c_data(dcu_c_data),
    .dcu_c_corrupt(dcu_c_corrupt),
    .dcu_c_valid(dcu_c_valid),
    .dcu_c_ready(dcu_c_ready),
    .dcu_d_opcode(dcu_d_opcode),
    .dcu_d_param(dcu_d_param),
    .dcu_d_user(dcu_d_user),
    .dcu_d_size(dcu_d_size),
    .dcu_d_source(dcu_d_source),
    .dcu_d_data(dcu_d_data),
    .dcu_d_denied(dcu_d_denied),
    .dcu_d_corrupt(dcu_d_corrupt),
    .dcu_d_sink(dcu_d_sink),
    .dcu_d_valid(dcu_d_valid),
    .dcu_d_ready(dcu_d_ready),
    .dcu_e_valid(dcu_e_valid),
    .dcu_e_sink(dcu_e_sink),
    .dcu_e_ready(dcu_e_ready)
);
endmodule

