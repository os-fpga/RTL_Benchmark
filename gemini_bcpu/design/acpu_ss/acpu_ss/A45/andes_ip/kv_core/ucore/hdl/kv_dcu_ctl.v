// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_ctl (
    dcu_clk,
    dcu_reset_n,
    ctl_idle,
    dcu_standby_ready,
    dcu_async_write_error,
    dcu_wbf_flush,
    evb_async_ecc_error,
    evb_async_ecc_corr,
    dcu_async_ecc_error,
    dcu_async_ecc_corr,
    dcu_async_ecc_ramid,
    dcu_event,
    csr_mcache_ctl_dc_eccen,
    csr_mcache_ctl_dc_rwecc,
    csr_mecc_code,
    mant_idle,
    mant_req_valid,
    mant_req_func,
    mant_req_addr,
    mant_req_way,
    mant_req_wdata,
    mant_req_ready,
    mant_ack_valid,
    mant_ack_rdata,
    mant_ack_status,
    mant_ack_defer,
    dcu_req_addr,
    dcu_req_id,
    dcu_req_func,
    dcu_req_valid,
    dcu_req_stall,
    dcu_req_ready,
    dcu_ack_valid,
    dcu_ack_id,
    dcu_ack_rdata,
    dcu_ack_status,
    dcu_cmt_valid,
    dcu_cmt_addr,
    dcu_cmt_func,
    dcu_cmt_wdata,
    dcu_cmt_wmask,
    probe_req_valid,
    probe_req_func,
    probe_req_addr,
    probe_req_source,
    probe_req_ready,
    probe_ack_valid,
    probe_ack_status,
    mshr_cmp_addr,
    mshr_cmp_func,
    mshr_cmp_hit,
    mshr_cmp_sameidx,
    mshr_cmp_way,
    mshr_cmp_tagw,
    mshr_cmp_mesi,
    mshr_cmp_changing,
    mshr_enq_valid,
    mshr_enq_stall,
    mshr_enq_mrg,
    mshr_enq_addr,
    mshr_enq_spec,
    mshr_enq_func,
    mshr_enq_id,
    mshr_enq_state,
    mshr_enq_way,
    mshr_enq_mrg_ptr,
    mshr_enq_l2_ways,
    mshr_free_ptr,
    mshr_full,
    mshr_empty,
    mshr_ent_speculative,
    mshr_ent_killed,
    mshr_ent_wt,
    mshr_ent_na,
    mshr_ent_na_mrg,
    mshr_ent_wbf,
    mshr_ent_wbf_cft,
    mshr_ent_write,
    mshr_ent_write_mrg,
    mshr_cmt_valid,
    mshr_cmt_ptr,
    mshr_cmt_addr,
    mshr_cmt_kill,
    mshr_cmt_attr,
    mshr_cmt_wdata,
    mshr_cmt_wmask,
    mshr_wbf_flush,
    mshr_async_write_error,
    mshr_prb_valid,
    mshr_prb_ptr,
    mshr_prb_mesi,
    sb_empty,
    sb_full,
    sb_afull,
    sb_pending,
    sb_cmp_addr,
    sb_cmp_hit,
    sb_cmp_hit_ptr,
    sb_cmp_hit_line_ptr,
    sb_cmp_hit_beat_ptr,
    sb_cmp_rdata,
    sb_cmp_rmask,
    sb_cmp_beat_data,
    sb_cmp_beat_mask,
    sb_fil_valid,
    sb_fil_last,
    sb_fil_mesi,
    sb_fil_fault,
    sb_fil_payload,
    sb_evt_valid,
    sb_evt_exclusive,
    sb_probe_valid,
    sb_probe_2n,
    sb_probe_2b,
    sb_enq_valid,
    sb_enq_spec,
    sb_enq_mrg,
    sb_enq_mrg_ptr,
    sb_enq_addr,
    sb_enq_mesi,
    sb_enq_way,
    sb_enq_rmw,
    sb_enq_rmwdata,
    sb_enq_free_ptr,
    sb_fil_beat_data,
    sb_req_hit_line,
    sb_req_hit_beat,
    sb_cmt_valid,
    sb_cmt_wdata,
    sb_cmt_kill0,
    sb_cmt_kill1,
    sb_cmt_kill1_en,
    sb_cmt_wmask,
    sb_cmt_miss,
    sb_cmt_ptr,
    sb_drain_valid,
    sb_drain_way,
    sb_drain_addr,
    sb_drain_data,
    sb_drain_mask,
    sb_drain_ready,
    lru_req_valid,
    lru_req_idx,
    lru_ack_rdata,
    lru_cmt_valid,
    lru_cmt_idx,
    lru_cmt_way,
    fil_valid,
    fil_addr,
    fil_way,
    fil_last,
    fil_fault,
    fil_lock,
    fil_mesi,
    fil_wdata,
    fil_payload,
    fil_data_way,
    fil_reserve,
    fil_exclusive,
    fil_l2_ways,
    fil_ready,
    evb_empty,
    evb_cmp_addr,
    evb_cmp_hit_ptr,
    evb_cmp_speculative,
    evb_cmp_cft,
    evb_enq_ready,
    evb_enq_valid,
    evb_enq_source,
    evb_enq_spec,
    evb_enq_eccen,
    evb_enq_addr,
    evb_enq_state,
    evb_enq_way,
    evb_enq_wbf,
    evb_enq_func,
    evb_enq_ptr,
    evb_mrg_valid,
    evb_mrg_ptr,
    evb_probe_func,
    evb_cmt_valid,
    evb_cmt_kill,
    evb_cmt_ptr,
    evb_async_write_error,
    evt_req_valid,
    evt_req_addr,
    evt_req_way,
    evt_req_mesi,
    evt_req_lock,
    evt_req_data,
    evt_req_ready,
    evt_ack_valid,
    evt_ack_rdata,
    evt_ack_error1,
    evt_ack_error2,
    wbf_a0_valid,
    wbf_a0_kill,
    wbf_a0_index,
    wbf_a0_ready,
    wa_cmt_valid,
    wa_cmt_kill,
    wa_cmt_addr,
    wa_cmt_wmask,
    wa_cmt_func,
    wna_mode,
    wpt_req_valid,
    wpt_req_we,
    wpt_req_addr,
    wpt_req_data,
    wpt_ack_data,
    dcache_tag0_cs,
    dcache_tag0_wdata,
    dcache_tag0_rdata,
    dcache_tag0_we,
    dcache_tag0_addr,
    dcache_data0_cs,
    dcache_data0_we,
    dcache_data0_wdata,
    dcache_data0_byte_we,
    dcache_data0_addr,
    dcache_data0_rdata,
    dcache_tag1_cs,
    dcache_tag1_wdata,
    dcache_tag1_rdata,
    dcache_tag1_we,
    dcache_tag1_addr,
    dcache_data1_cs,
    dcache_data1_we,
    dcache_data1_wdata,
    dcache_data1_byte_we,
    dcache_data1_addr,
    dcache_data1_rdata,
    dcache_tag2_cs,
    dcache_tag2_wdata,
    dcache_tag2_rdata,
    dcache_tag2_we,
    dcache_tag2_addr,
    dcache_data2_cs,
    dcache_data2_we,
    dcache_data2_wdata,
    dcache_data2_byte_we,
    dcache_data2_addr,
    dcache_data2_rdata,
    dcache_tag3_cs,
    dcache_tag3_wdata,
    dcache_tag3_rdata,
    dcache_tag3_we,
    dcache_tag3_addr,
    dcache_data3_cs,
    dcache_data3_we,
    dcache_data3_wdata,
    dcache_data3_byte_we,
    dcache_data3_addr,
    dcache_data3_rdata
);
parameter PALEN = 32;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter CM_SUPPORT_INT = 0;
parameter WPT_SUPPORT = 0;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_WAY = 2;
parameter MSHR_DEPTH = 3;
parameter SB_DEPTH = 6;
parameter WBF_DEPTH = 3;
parameter EVB_DEPTH = 3;
parameter SOURCE_WIDTH = 2;
parameter CACHE_LINE_SIZE = 64;
parameter DCACHE_TAG_RAM_AW = 9;
parameter DCACHE_TAG_RAM_DW = 28;
parameter DCACHE_DATA_RAM_AW = 11;
parameter DCACHE_DATA_RAM_DW = 32;
parameter DCACHE_DATA_RAM_BWEW = 4;
parameter DCACHE_DATA_DW = 32;
parameter DCACHE_LRU_INT = 0;
localparam TAG_S = 0;
localparam TAG_E = 1;
localparam TAG_M = 2;
localparam TAG_L = 3;
localparam GRN_LSB = 2;
localparam GRN_MSB = 5;
localparam IDX_LSB = 6;
localparam IDX_WIDTH = $unsigned($clog2(DCACHE_SIZE_KB * 1024 / DCACHE_WAY / 64));
localparam IDX_MSB = IDX_LSB + IDX_WIDTH - 1;
localparam TAG_LSB = IDX_LSB + IDX_WIDTH;
localparam TAG_MSB = PALEN - 1;
localparam TAG_WIDTH = TAG_MSB - TAG_LSB + 1;
localparam ID_WIDTH = 1;
localparam DATA_ARB_EVB = 0;
localparam DATA_ARB_REPAIR = 1;
localparam DATA_ARB_MANT = 2;
localparam DATA_ARB_FIL = 3;
localparam DATA_ARB_LSU = 4;
localparam DATA_ARB_DRAIN = 5;
localparam DATA_ARB_BITS = 6;
localparam TAG_ARB_EVB = 0;
localparam TAG_ARB_REPAIR = 1;
localparam TAG_ARB_MANT = 2;
localparam TAG_ARB_FIL = 3;
localparam TAG_ARB_PROBE = 4;
localparam TAG_ARB_LSU = 5;
localparam TAG_ARB_BITS = 6;
localparam CMT_FIFO_DW = 17 + MSHR_DEPTH + SB_DEPTH + EVB_DEPTH;
localparam DATA_RAM_DW = 32;
localparam DATA_RAM_PW = 7;
localparam TAG_RAM_PW = (DCACHE_ECC_TYPE_INT == 0) ? 0 : (DCACHE_TAG_RAM_DW > 39) ? 8 : 7;
localparam TAG_RAM_DW = DCACHE_TAG_RAM_DW - TAG_RAM_PW;
input dcu_clk;
input dcu_reset_n;
output ctl_idle;
output dcu_standby_ready;
output dcu_async_write_error;
input dcu_wbf_flush;
input evb_async_ecc_error;
input evb_async_ecc_corr;
output dcu_async_ecc_error;
output dcu_async_ecc_corr;
output [3:0] dcu_async_ecc_ramid;
output [6:0] dcu_event;
input [1:0] csr_mcache_ctl_dc_eccen;
input csr_mcache_ctl_dc_rwecc;
input [31:0] csr_mecc_code;
input mant_idle;
input mant_req_valid;
input [8:0] mant_req_func;
input [PALEN - 1:0] mant_req_addr;
input [3:0] mant_req_way;
input [31:0] mant_req_wdata;
output mant_req_ready;
output mant_ack_valid;
output [31:0] mant_ack_rdata;
output [11:0] mant_ack_status;
output mant_ack_defer;
input [PALEN - 1:0] dcu_req_addr;
input [ID_WIDTH - 1:0] dcu_req_id;
input [21:0] dcu_req_func;
input dcu_req_valid;
input dcu_req_stall;
output dcu_req_ready;
output dcu_ack_valid;
output [ID_WIDTH - 1:0] dcu_ack_id;
output [31:0] dcu_ack_rdata;
output [18:0] dcu_ack_status;
input dcu_cmt_valid;
input [PALEN - 1:0] dcu_cmt_addr;
input [10:0] dcu_cmt_func;
input [31:0] dcu_cmt_wdata;
input [3:0] dcu_cmt_wmask;
input probe_req_valid;
input [3:0] probe_req_func;
input [PALEN - 1:0] probe_req_addr;
input [SOURCE_WIDTH - 1:0] probe_req_source;
output probe_req_ready;
output probe_ack_valid;
output [1:0] probe_ack_status;
output [PALEN - 1:0] mshr_cmp_addr;
output [1:0] mshr_cmp_func;
input [MSHR_DEPTH - 1:0] mshr_cmp_hit;
input [MSHR_DEPTH - 1:0] mshr_cmp_sameidx;
input [3:0] mshr_cmp_way;
input [3:0] mshr_cmp_tagw;
input [2:0] mshr_cmp_mesi;
input mshr_cmp_changing;
output mshr_enq_valid;
output mshr_enq_stall;
output mshr_enq_mrg;
output [PALEN - 1:0] mshr_enq_addr;
output mshr_enq_spec;
output [18:0] mshr_enq_func;
output [ID_WIDTH - 1:0] mshr_enq_id;
output [3:0] mshr_enq_state;
output [3:0] mshr_enq_way;
output [MSHR_DEPTH - 1:0] mshr_enq_mrg_ptr;
output [7:0] mshr_enq_l2_ways;
input [MSHR_DEPTH - 1:0] mshr_free_ptr;
input mshr_full;
input mshr_empty;
input [MSHR_DEPTH - 1:0] mshr_ent_speculative;
input [MSHR_DEPTH - 1:0] mshr_ent_killed;
input [MSHR_DEPTH - 1:0] mshr_ent_wt;
input [MSHR_DEPTH - 1:0] mshr_ent_na;
input [MSHR_DEPTH - 1:0] mshr_ent_na_mrg;
input [MSHR_DEPTH - 1:0] mshr_ent_wbf;
input [MSHR_DEPTH - 1:0] mshr_ent_wbf_cft;
input [MSHR_DEPTH - 1:0] mshr_ent_write;
input [MSHR_DEPTH - 1:0] mshr_ent_write_mrg;
output mshr_cmt_valid;
output [MSHR_DEPTH - 1:0] mshr_cmt_ptr;
output [PALEN - 1:0] mshr_cmt_addr;
output mshr_cmt_kill;
output [5:0] mshr_cmt_attr;
output [31:0] mshr_cmt_wdata;
output [3:0] mshr_cmt_wmask;
output mshr_wbf_flush;
input mshr_async_write_error;
output mshr_prb_valid;
output [MSHR_DEPTH - 1:0] mshr_prb_ptr;
output [2:0] mshr_prb_mesi;
input sb_empty;
input sb_full;
input sb_afull;
input [SB_DEPTH - 1:0] sb_pending;
output [PALEN - 1:0] sb_cmp_addr;
input sb_cmp_hit;
input [SB_DEPTH - 1:0] sb_cmp_hit_ptr;
input [SB_DEPTH - 1:0] sb_cmp_hit_line_ptr;
input [SB_DEPTH - 1:0] sb_cmp_hit_beat_ptr;
input [31:0] sb_cmp_rdata;
input [3:0] sb_cmp_rmask;
input [127:0] sb_cmp_beat_data;
input [15:0] sb_cmp_beat_mask;
output sb_fil_valid;
output sb_fil_last;
output [2:0] sb_fil_mesi;
output sb_fil_fault;
output sb_fil_payload;
output sb_evt_valid;
output sb_evt_exclusive;
output sb_probe_valid;
output sb_probe_2n;
output sb_probe_2b;
output sb_enq_valid;
output sb_enq_spec;
output sb_enq_mrg;
output [SB_DEPTH - 1:0] sb_enq_mrg_ptr;
output [PALEN - 1:0] sb_enq_addr;
output [2:0] sb_enq_mesi;
output [3:0] sb_enq_way;
output sb_enq_rmw;
output [31:0] sb_enq_rmwdata;
input [SB_DEPTH - 1:0] sb_enq_free_ptr;
output [127:0] sb_fil_beat_data;
output [SB_DEPTH - 1:0] sb_req_hit_line;
output [SB_DEPTH - 1:0] sb_req_hit_beat;
output sb_cmt_valid;
output [31:0] sb_cmt_wdata;
output sb_cmt_kill0;
output sb_cmt_kill1;
output sb_cmt_kill1_en;
output [3:0] sb_cmt_wmask;
output sb_cmt_miss;
output [SB_DEPTH - 1:0] sb_cmt_ptr;
input sb_drain_valid;
input [3:0] sb_drain_way;
input [PALEN - 1:0] sb_drain_addr;
input [31:0] sb_drain_data;
input [3:0] sb_drain_mask;
output sb_drain_ready;
output lru_req_valid;
output [IDX_WIDTH - 1:0] lru_req_idx;
input [2:0] lru_ack_rdata;
output lru_cmt_valid;
output [IDX_WIDTH - 1:0] lru_cmt_idx;
output [3:0] lru_cmt_way;
input fil_valid;
input [PALEN - 1:0] fil_addr;
input [3:0] fil_way;
input fil_last;
input fil_fault;
input fil_lock;
input [2:0] fil_mesi;
input [127:0] fil_wdata;
input fil_payload;
input [3:0] fil_data_way;
input fil_reserve;
input fil_exclusive;
input [7:0] fil_l2_ways;
output fil_ready;
input evb_empty;
output [PALEN - 1:0] evb_cmp_addr;
input [EVB_DEPTH - 1:0] evb_cmp_hit_ptr;
input [EVB_DEPTH - 1:0] evb_cmp_speculative;
input [3:0] evb_cmp_cft;
input evb_enq_ready;
output evb_enq_valid;
output [SOURCE_WIDTH - 1:0] evb_enq_source;
output evb_enq_spec;
output [1:0] evb_enq_eccen;
output [PALEN - 1:0] evb_enq_addr;
output [3:0] evb_enq_state;
output [3:0] evb_enq_way;
output [WBF_DEPTH - 1:0] evb_enq_wbf;
output [5:0] evb_enq_func;
input [EVB_DEPTH - 1:0] evb_enq_ptr;
output evb_mrg_valid;
output [EVB_DEPTH - 1:0] evb_mrg_ptr;
output [3:0] evb_probe_func;
output evb_cmt_valid;
output evb_cmt_kill;
output [EVB_DEPTH - 1:0] evb_cmt_ptr;
input evb_async_write_error;
input evt_req_valid;
input [PALEN - 1:0] evt_req_addr;
input [3:0] evt_req_way;
input [2:0] evt_req_mesi;
input evt_req_lock;
input evt_req_data;
output evt_req_ready;
output evt_ack_valid;
output [127:0] evt_ack_rdata;
output evt_ack_error1;
output evt_ack_error2;
output wbf_a0_valid;
output wbf_a0_kill;
input [WBF_DEPTH - 1:0] wbf_a0_index;
input wbf_a0_ready;
output wa_cmt_valid;
output wa_cmt_kill;
output [PALEN - 1:0] wa_cmt_addr;
output [3:0] wa_cmt_wmask;
output [2:0] wa_cmt_func;
input wna_mode;
output wpt_req_valid;
output wpt_req_we;
output [PALEN - 1:0] wpt_req_addr;
output [7:0] wpt_req_data;
input [7:0] wpt_ack_data;
output dcache_tag0_cs;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag0_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag0_rdata;
output dcache_tag0_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag0_addr;
output dcache_data0_cs;
output dcache_data0_we;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data0_wdata;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data0_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data0_addr;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data0_rdata;
output dcache_tag1_cs;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag1_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag1_rdata;
output dcache_tag1_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag1_addr;
output dcache_data1_cs;
output dcache_data1_we;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data1_wdata;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data1_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data1_addr;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data1_rdata;
output dcache_tag2_cs;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag2_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag2_rdata;
output dcache_tag2_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag2_addr;
output dcache_data2_cs;
output dcache_data2_we;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data2_wdata;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data2_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data2_addr;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data2_rdata;
output dcache_tag3_cs;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag3_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag3_rdata;
output dcache_tag3_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag3_addr;
output dcache_data3_cs;
output dcache_data3_we;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data3_wdata;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data3_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data3_addr;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data3_rdata;


wire way1 = DCACHE_WAY == 1;
wire way2 = DCACHE_WAY == 2;
wire way4 = DCACHE_WAY == 4;
wire ecccfg = (DCACHE_ECC_TYPE_INT == 2);
wire xlen64 = 1'b0;
wire cm_en = (CM_SUPPORT_INT == 1);
wire dcu_func_read = dcu_req_func[0];
wire dcu_func_write = dcu_req_func[1];
wire dcu_func_lr = dcu_req_func[2];
wire dcu_func_sc = dcu_req_func[3];
wire dcu_func_inval = dcu_req_func[4];
wire dcu_func_wb = dcu_req_func[5];
wire dcu_func_wbinval = dcu_req_func[6];
wire dcu_func_lock = dcu_req_func[15];
wire dcu_func_unlock = dcu_req_func[16];
wire [1:0] dcu_func_size = dcu_req_func[7 +:2];
wire [2:0] dcu_func_fmt = dcu_req_func[18 +:3];
wire dcu_func_nbload = dcu_req_func[9];
wire [4:0] dcu_func_rd = dcu_req_func[10 +:5];
wire dcu_func_prefetch = dcu_req_func[17];
wire dcu_func_halt = dcu_req_func[21];
wire dcu_func_part;
wire dcu_func_rmw;
wire dcu_cmt_kill = dcu_cmt_func[0];
wire dcu_cmt_na = dcu_cmt_func[1];
wire dcu_cmt_wt = dcu_cmt_func[2];
wire [3:0] dcu_cmt_pma = dcu_cmt_func[3 +:4];
wire [DCACHE_TAG_RAM_AW - 1:0] tag_ram_addr;
wire [DCACHE_TAG_RAM_DW - 1:0] tag_ram_wdata;
wire tag_ram_we;
wire [TAG_RAM_DW - 1:0] tag_ram_wdata_fil;
wire [TAG_RAM_DW - 1:0] tag_ram_wdata_repair;
wire [TAG_RAM_DW - 1:0] tag_ram_wdata_evb;
wire [TAG_RAM_DW - 1:0] tag_ram_wdata_mant;
wire tag_ram_mant_we;
wire tag_ram_fil_we;
wire tag_ram_evb_we;
wire [TAG_ARB_BITS - 1:0] tag_arb_valid;
wire [TAG_ARB_BITS - 1:0] tag_arb_ready;
wire [TAG_ARB_BITS - 1:0] tag_arb_grant;
wire [DATA_ARB_BITS - 1:0] data_arb_valid;
wire [DATA_ARB_BITS - 1:0] data_arb_ready;
wire [DATA_ARB_BITS - 1:0] data_arb_grant;
reg [DATA_ARB_BITS - 1:0] m1_data_arb_grant;
wire [3:0] drain_data_ram_cs;
wire [3:0] mant_data_ram_cs;
wire [7:0] mant_ack_parity;
wire m0_valid;
wire m0_lsu_tag_req;
wire m0_lsu_data_req;
wire m0_lsu_grant;
wire [PALEN - 1:0] m0_addr;
wire [ID_WIDTH - 1:0] m0_id;
wire [29:0] m0_func;
wire [29:0] m0_func_lsu;
wire [29:0] m0_func_mant;
wire [29:0] m0_func_probe;
wire m0_struct_hazard;
wire [SOURCE_WIDTH - 1:0] m0_source;
wire [1:0] m0_eccen = csr_mcache_ctl_dc_eccen;
wire m0_sb_valid;
wire m0_sb_read;
wire m0_sb_write;
wire m0_sb_read_lsu;
wire m0_sb_write_lsu;
reg m1_valid;
wire m1_ctrl_en;
reg m1_lsu_valid;
reg [PALEN - 1:0] m1_addr;
reg [29:0] m1_func;
reg [ID_WIDTH - 1:0] m1_id;
wire m1_addr_en;
wire [3:0] m1_grn;
wire m1_write = m1_func[28];
wire m1_ix_rdata = m1_func[18];
reg m1_wbf_flush;
reg m1_sb_valid;
reg m1_sb_read;
reg m1_sb_write;
wire [3:0] m1_sb_rmask;
wire m1_sb_rdata_valid;
wire [31:0] m1_sb_rdata;
wire m1_hit_cmt;
wire m1_hit_fil;
wire m1_hit_enq;
wire m1_evb_hit_enq;
wire [EVB_DEPTH - 1:0] m1_evb_hit_ptr;
wire m1_evb_hit_speculative;
wire [3:0] m1_evb_cft;
wire [3:0] m1_ram_rdata_sel;
wire [3:0] m1_data0_mask;
wire [3:0] m1_data1_mask;
wire [3:0] m1_data2_mask;
wire [3:0] m1_data3_mask;
wire [1:0] m1_eccen;
wire [3:0] m1_way;
wire [3:0] m1_hitmiss_way;
wire [MSHR_DEPTH - 1:0] m1_mshr_hit_ptr;
wire m1_mshr_sameidx;
wire [MSHR_DEPTH - 1:0] m1_mshr_sameidx_ptr;
wire m1_mshr_hit;
wire [3:0] m1_mshr_hit_way;
wire m1_mshr_hit_changing;
wire [2:0] m1_mshr_hit_mesi;
wire m1_m2_match_idx;
wire m1_m2_match_tag;
wire m1_m2_same_line;
wire m1_m2_same_beat;
wire m1_m2_same_xlen;
wire m1_m2_same_idx;
wire m1_mshr_bypass_hit;
wire m1_mshr_bypass_sameidx;
wire m1_m2_sb_hit;
wire [SB_DEPTH - 1:0] m1_m2_sb_hit_ptr;
wire [SB_DEPTH - 1:0] m1_m2_sb_hit_line_ptr;
wire [SB_DEPTH - 1:0] m1_m2_sb_hit_beat_ptr;
reg m1_evt_valid;
reg [3:0] m1_evt_way;
reg m1_evt_exclusive;
wire [DCACHE_TAG_RAM_DW - 1:0] m1_tag0_codeword = dcache_tag0_rdata;
wire [DCACHE_TAG_RAM_DW - 1:0] m1_tag1_codeword = dcache_tag1_rdata;
wire [DCACHE_TAG_RAM_DW - 1:0] m1_tag2_codeword = dcache_tag2_rdata;
wire [DCACHE_TAG_RAM_DW - 1:0] m1_tag3_codeword = dcache_tag3_rdata;
wire [SOURCE_WIDTH - 1:0] m1_source;
reg m1_fil_valid;
reg m1_fil_payload;
reg m1_fil_last;
reg [2:0] m1_fil_mesi;
reg m1_fil_fault;
wire [127:0] m1_fil_data;
wire [3:0] m1_rmask_cmt;
wire [31:0] m1_rdata_fil;
wire [31:0] m1_rdata_cmt;
wire [3:0] m1_rmask_fil;
wire [31:0] m1_rmask_fil_bit;
wire [31:0] m1_rmask_cmt_bit;
wire [31:0] sb_cmp_rmask_bit;
wire [31:0] m1_fil_bypass_data;
wire [EVB_DEPTH - 1:0] evb_cmt_valid_ptr;
wire m2_ctrl_en;
wire [SOURCE_WIDTH - 1:0] m2_source;
reg m2_lsu_valid;
reg [3:0] m2_way;
wire [3:0] m2_lsu_way;
reg [PALEN - 1:0] m2_addr;
wire m2_addr_en;
reg [29:0] m2_func;
reg [ID_WIDTH - 1:0] m2_id;
wire [TAG_RAM_DW - 1:0] m2_tag_codeword;
wire [31:0] m2_mant_tag_codeword_ze;
wire m2_mant_defer0;
wire m2_mant_defer1;
wire m2_mant_defer2;
wire m2_mant_defer_wbf;
wire m2_mant_defer_evb;
wire [TAG_RAM_DW - 1:0] m2_tag_corrdata;
wire m2_hit;
wire m2_modified;
wire m2_locked;
wire [MSHR_DEPTH - 1:0] m2_mshr_ptr;
reg m2_mshr_hit;
reg [MSHR_DEPTH - 1:0] m2_mshr_hit_ptr;
reg [3:0] m2_mshr_hit_way;
wire m2_mshr_hit_na_mrg;
wire m2_mshr_hit_wbf;
reg m2_mshr_hit_changing;
reg [2:0] m2_mshr_hit_mesi;
wire m2_mshr_defer;
wire m2_mshr_defer_hit_killed;
wire m2_mshr_defer_na;
wire m2_mshr_defer_write;
wire [MSHR_DEPTH - 1:0] m2_mshr_ent_defer_na;
wire [MSHR_DEPTH - 1:0] m2_mshr_ent_defer_write;
wire m2_mshr_speculative = |mshr_ent_speculative;
wire m2_mshr_wt = |mshr_ent_wt;
reg m2_mshr_sameidx;
reg [MSHR_DEPTH - 1:0] m2_mshr_sameidx_ptr;
wire m2_mshr_sameidx_wbf;
wire m2_mshr_abort;
reg [EVB_DEPTH - 1:0] m2_evb_hit_ptr;
reg m2_evb_hit_speculative;
wire m2_evb_hit = |m2_evb_hit_ptr;
reg [3:0] m2_evb_cft;
wire [1:0] m2_size = m2_func[22 +:2];
wire [2:0] m2_fmt = m2_func[3 +:3];
wire m2_part;
wire m2_rmw;
wire [SB_DEPTH - 1:0] m2_sb_ptr;
reg m2_wbf_flush;
wire m2_sb_en;
wire m2_sb_rdata_en;
reg m2_sb_hit;
reg [SB_DEPTH - 1:0] m2_sb_hit_ptr;
reg [SB_DEPTH - 1:0] m2_sb_hit_line_ptr;
reg [SB_DEPTH - 1:0] m2_sb_hit_beat_ptr;
reg [31:0] m2_sb_rdata;
reg m2_sb_rdata_valid;
wire m2_wa;
wire m2_na_switch;
wire m2_disable_na;
wire m2_na_int;
reg m2_evt_valid;
reg [3:0] m2_evt_way;
reg m2_evt_exclusive;
reg m2_fil_valid;
wire m2_fil_en;
reg m2_fil_last;
reg [2:0] m2_fil_mesi;
reg m2_fil_fault;
reg m2_fil_payload;
reg [127:0] m2_beat_data;
wire [127:0] m2_beat_data_nx;
wire m2_beat_data_en;
reg [15:0] m2_beat_mask;
wire [15:0] m2_beat_mask_nx;
wire m2_beat_mask_en;
wire [1:0] m2_eccen;
wire m2_eccen2 = (m2_eccen == 2'd2);
wire m2_eccen3 = (m2_eccen == 2'd3);
wire m2_eccen23 = m2_eccen2 | m2_eccen3;
wire m2_data_error1;
wire m2_data_error2;
wire m2_tag_error1;
wire m2_tag_error2;
wire m2_tag_error = m2_tag_error1 | m2_tag_error2;
wire [3:0] m2_tag_repair_way;
wire m2_corr_error;
wire m2_uncorr_error;
wire m2_fault;
wire [7:0] m2_ecc_code;
wire [3:0] m2_replace_way;
wire [TAG_RAM_DW - 1:0] m2_replace_tag;
wire m2_replace_valid = m2_replace_tag[TAG_S];
wire m2_replace_locked = m2_replace_tag[TAG_L];
wire m2_replace_way_hit_evb;
wire m2_nullify;
wire m2_defer;
wire m2_evb_kill;
wire m2_evb_replace;
wire m2_probe_defer;
wire m2_probe_nullify;
wire m2_hit_pending_sb;
wire m2_mshr_wbf_cft;
wire m2_pending_speculative;
wire m2_read = m2_func[19];
wire m2_write = m2_func[28];
wire m2_lr = m2_func[9];
wire m2_sc = m2_func[21];
wire m2_inval = m2_func[7];
wire m2_wb = m2_func[25];
wire m2_wbinval = m2_func[26];
wire m2_lock = m2_func[8];
wire m2_unlock = m2_func[24];
wire m2_nbload = m2_func[10];
wire m2_prefetch = m2_func[11];
wire m2_ix_rtag = m2_func[20];
wire m2_ix_rdata = m2_func[18];
wire m2_cap2n = m2_func[1];
wire m2_cap2b = m2_func[0];
wire m2_cap2t = m2_func[2];
wire m2_probeblock = m2_func[12];
wire m2_halt = m2_func[6];
wire m2_release = m2_inval | m2_wb | m2_wbinval;
wire m2_lr_fail;
wire m2_sc_fail;
wire m2_sc_retry;
wire m2_read_hit = m2_read & m2_hit;
wire m2_tag_rdata_en;
reg [DCACHE_DATA_RAM_DW - 1:0] m2_data0_codeword;
reg [DCACHE_DATA_RAM_DW - 1:0] m2_data1_codeword;
reg [DCACHE_DATA_RAM_DW - 1:0] m2_data2_codeword;
reg [DCACHE_DATA_RAM_DW - 1:0] m2_data3_codeword;
wire [31:0] m2_data0_corrdata;
wire [31:0] m2_data1_corrdata;
wire [31:0] m2_data2_corrdata;
wire [31:0] m2_data3_corrdata;
reg [3:0] m2_data0_mask;
reg [3:0] m2_data1_mask;
reg [3:0] m2_data2_mask;
reg [3:0] m2_data3_mask;
wire [31:0] m2_data0_mask_bit;
wire [31:0] m2_data1_mask_bit;
wire [31:0] m2_data2_mask_bit;
wire [31:0] m2_data3_mask_bit;
wire [31:0] m2_corrdata;
reg [DCACHE_TAG_RAM_DW - 1:0] m2_tag0_codeword;
reg [DCACHE_TAG_RAM_DW - 1:0] m2_tag1_codeword;
reg [DCACHE_TAG_RAM_DW - 1:0] m2_tag2_codeword;
reg [DCACHE_TAG_RAM_DW - 1:0] m2_tag3_codeword;
wire [TAG_RAM_DW - 1:0] m2_tag0_corrdata;
wire [TAG_RAM_DW - 1:0] m2_tag1_corrdata;
wire [TAG_RAM_DW - 1:0] m2_tag2_corrdata;
wire [TAG_RAM_DW - 1:0] m2_tag3_corrdata;
wire probe_async_ecc_error;
wire probe_async_ecc_corr;
wire m2_ram_rdata_en;
wire [TAG_RAM_DW - 1:0] m2_replace_tag_corrdata;
wire m2_replace;
wire [31:0] m2_rdata;
wire [31:0] m2_ram_rdata;
reg [3:0] m2_ram_rdata_sel;
wire [127:0] m2_beat_mask_bit;
wire [127:0] m2_edata;
wire repair_valid;
wire [PALEN - 1:0] tag_repair_addr;
wire [TAG_RAM_DW - 1:0] tag_repair_corrdata;
wire [3:0] tag_repair_way;
wire [31:0] data_repair_corrdata;
wire sb_full_final;
wire m0_mant_grant = mant_req_valid & mant_req_ready;
wire m0_mant_wtag = mant_req_valid & mant_req_func[3];
wire m0_mant_wdata = mant_req_valid & mant_req_func[6];
wire [3:0] m0_mant_way = mant_req_way;
reg m1_mant_valid;
reg [3:0] m1_mant_way;
reg m2_mant_valid;
wire [7:0] m2_mant_tag_parity_ze;
wire [7:0] m2_mant_data_parity_ze;
wire m0_probe_valid;
wire m0_probe_grant;
reg m1_probe_valid;
reg m2_probe_valid;
wire cmt_fifo_wvalid;
wire cmt_fifo_rvalid;
wire [CMT_FIFO_DW - 1:0] cmt_fifo_wdata;
wire [CMT_FIFO_DW - 1:0] cmt_fifo_rdata;
wire cmt_fifo_hit;
wire cmt_fifo_modified;
wire cmt_fifo_sc_retry;
wire [3:0] cmt_fifo_way;
wire cmt_fifo_evb_enq;
wire [EVB_DEPTH - 1:0] cmt_fifo_evb_ptr;
wire cmt_fifo_evb_kill;
wire cmt_fifo_evb_replace;
wire cmt_fifo_null;
wire cmt_fifo_halt;
wire cmt_fifo_na_int;
wire cmt_fifo_mshr_abort;
wire cmt_fifo_mshr_hit;
wire [MSHR_DEPTH - 1:0] cmt_fifo_mshr_ptr;
wire cmt_fifo_disable_na;
wire cmt_fifo_wa;
wire [SB_DEPTH - 1:0] cmt_fifo_sb_ptr;
wire [MSHR_DEPTH - 1:0] cmt_mshr_ptr;
wire cmt_mshr_hit;
wire cmt_mshr_abort;
wire cmt_null;
wire cmt_halt;
wire cmt_na_int;
wire cmt_evb_enq;
wire cmt_evb_kill;
wire [EVB_DEPTH - 1:0] cmt_evb_ptr;
wire cmt_evb_replace;
wire [3:0] cmt_way;
wire cmt_hit;
wire cmt_modified;
wire cmt_miss = ~cmt_hit;
wire cmt_sc_retry;
wire dcu_cmt_read = dcu_cmt_func[7];
wire dcu_cmt_write = dcu_cmt_func[8];
wire cmt_unlock = dcu_cmt_func[9];
wire cmt_prefetch = dcu_cmt_func[10];
wire cmt_na;
wire cmt_wa;
wire cmt_disable_na;
wire [SB_DEPTH - 1:0] cmt_sb_ptr;
wire [3:0] cmt_bypass_wmask;
wire [63:0] linemask;
wire linemask_full;
wire [63:0] cmt_linemask;
wire lru_cmt_kill;
wire [5:0] evb_func_lsu;
wire [5:0] evb_func_mant;
wire [5:0] evb_func_probe;
wire evt_req_grant;
wire [DCACHE_DATA_RAM_AW - 1:0] evt_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] evt_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] evt_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] evt_data3_addr;
wire fil_req_grant;
wire [DCACHE_DATA_RAM_AW - 1:0] fil_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] fil_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] fil_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] fil_data3_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] drn_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] drn_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] drn_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] drn_data3_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] lsu_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] lsu_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] lsu_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] lsu_data3_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] man_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] man_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] man_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] man_data3_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] rep_data0_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] rep_data1_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] rep_data2_addr;
wire [DCACHE_DATA_RAM_AW - 1:0] rep_data3_addr;
wire probe_req_grant;
wire probe_disable;
wire fil_data0_cs;
wire fil_data1_cs;
wire fil_data2_cs;
wire fil_data3_cs;
wire fil_data0_we;
wire fil_data1_we;
wire fil_data2_we;
wire fil_data3_we;
wire [3:0] fil_data0_byte_we;
wire [3:0] fil_data1_byte_we;
wire [3:0] fil_data2_byte_we;
wire [3:0] fil_data3_byte_we;
wire [31:0] fil_data0_wdata;
wire [31:0] fil_data1_wdata;
wire [31:0] fil_data2_wdata;
wire [31:0] fil_data3_wdata;
wire drain_data0_cs;
wire drain_data1_cs;
wire drain_data2_cs;
wire drain_data3_cs;
wire drain_data0_we;
wire drain_data1_we;
wire drain_data2_we;
wire drain_data3_we;
wire [3:0] drain_data0_byte_we;
wire [3:0] drain_data1_byte_we;
wire [3:0] drain_data2_byte_we;
wire [3:0] drain_data3_byte_we;
wire [31:0] drain_data0_wdata;
wire [31:0] drain_data1_wdata;
wire [31:0] drain_data2_wdata;
wire [31:0] drain_data3_wdata;
wire mant_data0_cs;
wire mant_data1_cs;
wire mant_data2_cs;
wire mant_data3_cs;
wire mant_data0_we;
wire mant_data1_we;
wire mant_data2_we;
wire mant_data3_we;
wire [3:0] mant_data0_byte_we;
wire [3:0] mant_data1_byte_we;
wire [3:0] mant_data2_byte_we;
wire [3:0] mant_data3_byte_we;
wire [31:0] mant_data0_wdata;
wire [31:0] mant_data1_wdata;
wire [31:0] mant_data2_wdata;
wire [31:0] mant_data3_wdata;
wire rep_data0_cs;
wire rep_data1_cs;
wire rep_data2_cs;
wire rep_data3_cs;
wire rep_data0_we;
wire rep_data1_we;
wire rep_data2_we;
wire rep_data3_we;
wire [3:0] rep_data0_byte_we;
wire [3:0] rep_data1_byte_we;
wire [3:0] rep_data2_byte_we;
wire [3:0] rep_data3_byte_we;
wire [31:0] rep_data0_wdata;
wire [31:0] rep_data1_wdata;
wire [31:0] rep_data2_wdata;
wire [31:0] rep_data3_wdata;
wire [3:0] tb_lock = 4'b0;
wire tb_reserve_valid_clr = 1'b0;
wire cmt_wna;
wire [15:0] cmt_addr_onehot;
wire sb_cmt_kill;
assign m0_struct_hazard = ~mant_idle | ~evb_enq_ready | (sb_full_final & dcu_func_write);
assign dcu_req_ready = ~m0_struct_hazard & data_arb_ready[DATA_ARB_LSU] & tag_arb_ready[TAG_ARB_LSU];
assign m0_lsu_tag_req = dcu_req_valid & ~m0_struct_hazard;
assign dcu_func_part = (dcu_func_size == 2'd0) | (dcu_func_size == 2'd1) | ((dcu_func_size == 2'd2) & xlen64);
assign dcu_func_rmw = dcu_func_write & dcu_func_part & ecccfg;
assign m0_lsu_data_req = dcu_req_valid & ~m0_struct_hazard & (~dcu_func_write | dcu_func_rmw);
assign m0_lsu_grant = dcu_req_valid & dcu_req_ready & ~dcu_req_stall;
assign m0_func_lsu[19] = dcu_func_read;
assign m0_func_lsu[28] = dcu_func_write;
assign m0_func_lsu[9] = dcu_func_lr;
assign m0_func_lsu[21] = dcu_func_sc;
assign m0_func_lsu[7] = dcu_func_inval;
assign m0_func_lsu[25] = dcu_func_wb;
assign m0_func_lsu[26] = dcu_func_wbinval;
assign m0_func_lsu[8] = dcu_func_lock;
assign m0_func_lsu[24] = dcu_func_unlock;
assign m0_func_lsu[29] = 1'b0;
assign m0_func_lsu[20] = 1'b0;
assign m0_func_lsu[27] = 1'b0;
assign m0_func_lsu[18] = 1'b0;
assign m0_func_lsu[22 +:2] = dcu_func_size;
assign m0_func_lsu[3 +:3] = dcu_func_fmt;
assign m0_func_lsu[10] = dcu_func_nbload;
assign m0_func_lsu[13 +:5] = dcu_func_rd;
assign m0_func_lsu[11] = dcu_func_prefetch;
assign m0_func_lsu[6] = dcu_func_halt;
assign m0_func_lsu[1] = 1'b0;
assign m0_func_lsu[0] = 1'b0;
assign m0_func_lsu[2] = 1'b0;
assign m0_func_lsu[12] = 1'b0;
assign m0_func_mant[19] = 1'b0;
assign m0_func_mant[28] = 1'b0;
assign m0_func_mant[9] = 1'b0;
assign m0_func_mant[21] = 1'b0;
assign m0_func_mant[7] = mant_req_func[0];
assign m0_func_mant[25] = mant_req_func[2];
assign m0_func_mant[26] = mant_req_func[1];
assign m0_func_mant[8] = 1'b0;
assign m0_func_mant[24] = 1'b0;
assign m0_func_mant[29] = mant_req_func[3];
assign m0_func_mant[20] = mant_req_func[4];
assign m0_func_mant[27] = mant_req_func[6];
assign m0_func_mant[18] = mant_req_func[5];
assign m0_func_mant[22 +:2] = mant_req_func[7 +:2];
assign m0_func_mant[3 +:3] = {1'b0,mant_req_func[7 +:2]};
assign m0_func_mant[10] = 1'b0;
assign m0_func_mant[13 +:5] = 5'd0;
assign m0_func_mant[11] = 1'b0;
assign m0_func_mant[6] = 1'b0;
assign m0_func_mant[1] = 1'b0;
assign m0_func_mant[0] = 1'b0;
assign m0_func_mant[2] = 1'b0;
assign m0_func_mant[12] = 1'b0;
assign m0_func_probe[19] = 1'b0;
assign m0_func_probe[28] = 1'b0;
assign m0_func_probe[9] = 1'b0;
assign m0_func_probe[21] = 1'b0;
assign m0_func_probe[7] = 1'b0;
assign m0_func_probe[25] = 1'b0;
assign m0_func_probe[26] = 1'b0;
assign m0_func_probe[8] = 1'b0;
assign m0_func_probe[24] = 1'b0;
assign m0_func_probe[29] = 1'b0;
assign m0_func_probe[20] = 1'b0;
assign m0_func_probe[27] = 1'b0;
assign m0_func_probe[18] = 1'b0;
assign m0_func_probe[22 +:2] = 2'b0;
assign m0_func_probe[3 +:3] = 3'b0;
assign m0_func_probe[10] = 1'b0;
assign m0_func_probe[13 +:5] = 5'd0;
assign m0_func_probe[11] = 1'b0;
assign m0_func_probe[6] = 1'b0;
assign m0_func_probe[1] = probe_req_func[0];
assign m0_func_probe[0] = probe_req_func[1];
assign m0_func_probe[2] = probe_req_func[2];
assign m0_func_probe[12] = probe_req_func[3];
assign m0_addr = ({PALEN{tag_arb_grant[TAG_ARB_MANT]}} & mant_req_addr) | ({PALEN{tag_arb_grant[TAG_ARB_EVB]}} & evt_req_addr) | ({PALEN{tag_arb_grant[TAG_ARB_FIL]}} & fil_addr) | ({PALEN{tag_arb_grant[TAG_ARB_LSU]}} & dcu_req_addr) | ({PALEN{tag_arb_grant[TAG_ARB_PROBE]}} & probe_req_addr) | ({PALEN{tag_arb_grant[TAG_ARB_REPAIR]}} & tag_repair_addr);
assign m0_func = ({30{tag_arb_grant[TAG_ARB_MANT]}} & m0_func_mant) | ({30{tag_arb_grant[TAG_ARB_LSU]}} & m0_func_lsu) | ({30{tag_arb_grant[TAG_ARB_PROBE]}} & m0_func_probe);
assign lsu_data0_addr = dcu_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign lsu_data1_addr = dcu_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign lsu_data2_addr = dcu_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign lsu_data3_addr = dcu_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign man_data0_addr = mant_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign man_data1_addr = mant_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign man_data2_addr = mant_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign man_data3_addr = mant_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign m0_id = dcu_req_id;
assign m0_valid = (|tag_arb_grant) | (|data_arb_grant);
assign m0_source = probe_req_source;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m1_valid <= 1'b0;
    end
    else begin
        m1_valid <= m0_valid;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m1_lsu_valid <= 1'b0;
        m1_mant_valid <= 1'b0;
        m1_evt_valid <= 1'b0;
        m1_probe_valid <= 1'b0;
        m1_fil_valid <= 1'b0;
        m1_sb_valid <= 1'b0;
    end
    else begin
        m1_lsu_valid <= m0_lsu_grant;
        m1_mant_valid <= m0_mant_grant;
        m1_evt_valid <= evt_req_grant;
        m1_probe_valid <= m0_probe_grant;
        m1_fil_valid <= fil_req_grant;
        m1_sb_valid <= m0_sb_valid;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m1_wbf_flush <= 1'b0;
    end
    else begin
        m1_wbf_flush <= dcu_wbf_flush;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m1_evt_way <= 4'b0001;
        m1_evt_exclusive <= 1'b0;
    end
    else if (evt_req_grant) begin
        m1_evt_way <= evt_req_way;
        m1_evt_exclusive <= evt_req_mesi[TAG_E];
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m1_data_arb_grant <= {DATA_ARB_BITS{1'b0}};
        m1_sb_read <= 1'b0;
        m1_sb_write <= 1'b0;
        m1_fil_payload <= 1'b0;
        m1_fil_last <= 1'b0;
        m1_fil_mesi <= 3'd0;
        m1_fil_fault <= 1'd0;
    end
    else if (m1_ctrl_en) begin
        m1_data_arb_grant <= data_arb_grant;
        m1_sb_read <= m0_sb_read;
        m1_sb_write <= m0_sb_write;
        m1_fil_payload <= fil_payload;
        m1_fil_last <= fil_last;
        m1_fil_mesi <= fil_mesi;
        m1_fil_fault <= fil_fault;
    end
end

always @(posedge dcu_clk) begin
    if (m1_addr_en) begin
        m1_addr <= m0_addr;
        m1_func <= m0_func;
        m1_id <= m0_id;
        m1_mant_way <= m0_mant_way;
    end
end

kv_dff_gen #(
    .EXPRESSION(CM_SUPPORT_INT),
    .W(SOURCE_WIDTH)
) u_m1_source (
    .clk(dcu_clk),
    .en(m0_probe_grant),
    .d(m0_source),
    .q(m1_source)
);
kv_dff_gen #(
    .EXPRESSION(DCACHE_ECC_TYPE_INT == 2),
    .W(2)
) u_m1_eccen (
    .clk(dcu_clk),
    .en(m1_ctrl_en),
    .d(m0_eccen),
    .q(m1_eccen)
);
assign m1_hitmiss_way[0] = (m1_addr[TAG_LSB +:TAG_WIDTH] == m1_tag0_codeword[TAG_RAM_DW - 1:4]) & m1_tag0_codeword[TAG_S];
assign m1_hitmiss_way[1] = (m1_addr[TAG_LSB +:TAG_WIDTH] == m1_tag1_codeword[TAG_RAM_DW - 1:4]) & m1_tag1_codeword[TAG_S] & (DCACHE_WAY >= 2);
assign m1_hitmiss_way[2] = (m1_addr[TAG_LSB +:TAG_WIDTH] == m1_tag2_codeword[TAG_RAM_DW - 1:4]) & m1_tag2_codeword[TAG_S] & (DCACHE_WAY >= 4);
assign m1_hitmiss_way[3] = (m1_addr[TAG_LSB +:TAG_WIDTH] == m1_tag3_codeword[TAG_RAM_DW - 1:4]) & m1_tag3_codeword[TAG_S] & (DCACHE_WAY >= 4);
assign m1_ctrl_en = m0_valid;
assign m1_addr_en = tag_arb_grant[TAG_ARB_MANT] | m0_lsu_grant | evt_req_grant | fil_req_grant | probe_req_grant;
assign m1_way = m1_mant_valid ? m1_mant_way : m1_hitmiss_way;
kv_bin2onehot #(
    .N(4)
) u_m1_grn (
    .out(m1_grn),
    .in(m1_addr[GRN_LSB +:2])
);
assign m1_ram_rdata_sel[0] = (way1 & m1_grn[0]) | (way2 & m1_grn[0] & m1_way[0]) | (way2 & m1_grn[2] & m1_way[1]) | (way4 & m1_grn[0] & m1_way[0]) | (way4 & m1_grn[1] & m1_way[3]) | (way4 & m1_grn[2] & m1_way[2]) | (way4 & m1_grn[3] & m1_way[1]);
assign m1_ram_rdata_sel[1] = (way1 & m1_grn[1]) | (way2 & m1_grn[1] & m1_way[0]) | (way2 & m1_grn[3] & m1_way[1]) | (way4 & m1_grn[0] & m1_way[1]) | (way4 & m1_grn[1] & m1_way[0]) | (way4 & m1_grn[2] & m1_way[3]) | (way4 & m1_grn[3] & m1_way[2]);
assign m1_ram_rdata_sel[2] = (way1 & m1_grn[2]) | (way2 & m1_grn[0] & m1_way[1]) | (way2 & m1_grn[2] & m1_way[0]) | (way4 & m1_grn[0] & m1_way[2]) | (way4 & m1_grn[1] & m1_way[1]) | (way4 & m1_grn[2] & m1_way[0]) | (way4 & m1_grn[3] & m1_way[3]);
assign m1_ram_rdata_sel[3] = (way1 & m1_grn[3]) | (way2 & m1_grn[1] & m1_way[1]) | (way2 & m1_grn[3] & m1_way[0]) | (way4 & m1_grn[0] & m1_way[3]) | (way4 & m1_grn[1] & m1_way[2]) | (way4 & m1_grn[2] & m1_way[1]) | (way4 & m1_grn[3] & m1_way[0]);
assign m1_data0_mask = {4{m1_ram_rdata_sel[0]}} & ~m1_sb_rmask;
assign m1_data1_mask = {4{m1_ram_rdata_sel[1]}} & ~m1_sb_rmask;
assign m1_data2_mask = {4{m1_ram_rdata_sel[2]}} & ~m1_sb_rmask;
assign m1_data3_mask = {4{m1_ram_rdata_sel[3]}} & ~m1_sb_rmask;
assign m1_m2_match_tag = (m1_addr[PALEN - 1:TAG_LSB] == m2_addr[PALEN - 1:TAG_LSB]);
assign m1_m2_match_idx = (m1_addr[IDX_MSB:IDX_LSB] == m2_addr[IDX_MSB:IDX_LSB]);
assign m1_m2_same_idx = m1_m2_match_idx & ~m1_m2_match_tag;
assign m1_m2_same_line = m1_m2_match_idx & m1_m2_match_tag;
assign m1_m2_same_beat = m1_m2_same_line & (m1_addr[IDX_LSB - 1:GRN_LSB + 2] == m2_addr[IDX_LSB - 1:GRN_LSB + 2]);
assign m1_m2_same_xlen = m1_m2_same_beat & (m1_addr[GRN_LSB +:2] == m2_addr[GRN_LSB +:2]);
assign m1_m2_sb_hit = sb_cmp_hit | (sb_enq_valid & m1_m2_same_xlen);
assign m1_m2_sb_hit_ptr = sb_cmp_hit ? sb_cmp_hit_ptr : sb_enq_free_ptr;
assign m1_m2_sb_hit_line_ptr = sb_cmp_hit_line_ptr | ({SB_DEPTH{sb_enq_valid & m1_m2_same_line}} & sb_enq_free_ptr);
assign m1_m2_sb_hit_beat_ptr = sb_cmp_hit_beat_ptr | ({SB_DEPTH{sb_enq_valid & ~sb_enq_mrg & m1_m2_same_beat}} & sb_enq_free_ptr);
assign m1_sb_rdata_valid = m1_m2_sb_hit & |m1_sb_rmask;
assign m2_fil_en = m1_fil_valid;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_lsu_valid <= 1'b0;
        m2_mant_valid <= 1'b0;
        m2_probe_valid <= 1'b0;
        m2_evt_valid <= 1'b0;
        m2_fil_valid <= 1'b0;
    end
    else begin
        m2_lsu_valid <= m1_lsu_valid;
        m2_mant_valid <= m1_mant_valid;
        m2_probe_valid <= m1_probe_valid;
        m2_evt_valid <= m1_evt_valid;
        m2_fil_valid <= m1_fil_valid;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_wbf_flush <= 1'b0;
    end
    else begin
        m2_wbf_flush <= m1_wbf_flush;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_evt_way <= 4'b0001;
        m2_evt_exclusive <= 1'd0;
    end
    else if (m1_evt_valid) begin
        m2_evt_way <= m1_evt_way;
        m2_evt_exclusive <= m1_evt_exclusive;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_fil_mesi <= 3'd0;
        m2_fil_payload <= 1'd0;
        m2_fil_fault <= 1'd0;
        m2_fil_last <= 1'd0;
    end
    else if (m2_fil_en) begin
        m2_fil_mesi <= m1_fil_mesi;
        m2_fil_payload <= m1_fil_payload;
        m2_fil_fault <= m1_fil_fault;
        m2_fil_last <= m1_fil_last;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_mshr_hit <= 1'b0;
        m2_mshr_hit_ptr <= {MSHR_DEPTH{1'b0}};
        m2_mshr_hit_way <= 4'd0;
        m2_mshr_hit_mesi <= 3'b0;
        m2_mshr_hit_changing <= 1'b0;
        m2_mshr_sameidx <= 1'b0;
        m2_mshr_sameidx_ptr <= {MSHR_DEPTH{1'b0}};
        m2_evb_hit_ptr <= {EVB_DEPTH{1'b0}};
        m2_evb_hit_speculative <= 1'b0;
        m2_evb_cft <= 4'b0;
    end
    else if (m2_addr_en) begin
        m2_mshr_hit <= m1_mshr_hit;
        m2_mshr_hit_ptr <= m1_mshr_hit_ptr;
        m2_mshr_hit_way <= m1_mshr_hit_way;
        m2_mshr_hit_changing <= m1_mshr_hit_changing;
        m2_mshr_hit_mesi <= m1_mshr_hit_mesi;
        m2_mshr_sameidx <= m1_mshr_sameidx;
        m2_mshr_sameidx_ptr <= m1_mshr_sameidx_ptr;
        m2_evb_hit_ptr <= m1_evb_hit_ptr;
        m2_evb_hit_speculative <= m1_evb_hit_speculative;
        m2_evb_cft <= m1_evb_cft;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        m2_way <= 4'd0;
    end
    else if (m2_addr_en) begin
        m2_way <= m1_way;
    end
end

always @(posedge dcu_clk) begin
    if (m2_addr_en) begin
        m2_func <= m1_func;
        m2_addr <= m1_addr;
        m2_id <= m1_id;
    end
end

always @(posedge dcu_clk) begin
    if (m2_sb_en) begin
        m2_sb_hit <= m1_m2_sb_hit;
        m2_sb_hit_ptr <= m1_m2_sb_hit_ptr;
        m2_sb_hit_line_ptr <= m1_m2_sb_hit_line_ptr;
        m2_sb_hit_beat_ptr <= m1_m2_sb_hit_beat_ptr;
    end
end

always @(posedge dcu_clk) begin
    if (m2_sb_rdata_en) begin
        m2_sb_rdata <= m1_sb_rdata;
        m2_sb_rdata_valid <= m1_sb_rdata_valid;
    end
end

always @(posedge dcu_clk) begin
    if (m2_beat_data_en) begin
        m2_beat_data <= m2_beat_data_nx;
    end
end

always @(posedge dcu_clk) begin
    if (m2_beat_mask_en) begin
        m2_beat_mask <= m2_beat_mask_nx;
    end
end

always @(posedge dcu_clk) begin
    if (m2_tag_rdata_en) begin
        m2_tag0_codeword <= m1_tag0_codeword;
        m2_tag1_codeword <= m1_tag1_codeword;
        m2_tag2_codeword <= m1_tag2_codeword;
        m2_tag3_codeword <= m1_tag3_codeword;
    end
end

always @(posedge dcu_clk) begin
    if (m2_ram_rdata_en) begin
        m2_data0_codeword <= dcache_data0_rdata;
        m2_data1_codeword <= dcache_data1_rdata;
        m2_data2_codeword <= dcache_data2_rdata;
        m2_data3_codeword <= dcache_data3_rdata;
        m2_ram_rdata_sel <= m1_ram_rdata_sel;
        m2_data0_mask <= m1_data0_mask;
        m2_data1_mask <= m1_data1_mask;
        m2_data2_mask <= m1_data2_mask;
        m2_data3_mask <= m1_data3_mask;
    end
end

kv_dff_gen #(
    .EXPRESSION(DCACHE_ECC_TYPE_INT == 2),
    .W(2)
) u_m2_eccen (
    .clk(dcu_clk),
    .en(m2_ctrl_en),
    .d(m1_eccen),
    .q(m2_eccen)
);
kv_dff_gen #(
    .EXPRESSION(CM_SUPPORT_INT),
    .W(SOURCE_WIDTH)
) u_m2_source (
    .clk(dcu_clk),
    .en(m1_probe_valid),
    .d(m1_source),
    .q(m2_source)
);
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_eccdec
        wire m1_inval = m1_func[7];
        wire m1_wb = m1_func[25];
        wire m1_wbinval = m1_func[26];
        wire m1_release = m1_inval | m1_wb | m1_wbinval;
        wire m1_tag0_check_en;
        wire m1_tag1_check_en;
        wire m1_tag2_check_en;
        wire m1_tag3_check_en;
        wire m1_data_check_en;
        wire m1_eccen23 = m1_eccen[1];
        wire [1:0] m2_tag0_error;
        wire [1:0] m2_tag1_error;
        wire [1:0] m2_tag2_error;
        wire [1:0] m2_tag3_error;
        wire [7:0] m2_tag_ecc_code;
        wire [7:0] m2_data_ecc_code;
        reg m2_tag0_check_en;
        reg m2_tag1_check_en;
        reg m2_tag2_check_en;
        reg m2_tag3_check_en;
        reg m2_data_check_en;
        wire [1:0] m2_data0_error;
        wire [1:0] m2_data1_error;
        wire [1:0] m2_data2_error;
        wire [1:0] m2_data3_error;
        wire [1:0] m2_ram_rdata_error;
        wire [TAG_RAM_PW - 1:0] m2_tag0_parity;
        wire [TAG_RAM_PW - 1:0] m2_tag1_parity;
        wire [TAG_RAM_PW - 1:0] m2_tag2_parity;
        wire [TAG_RAM_PW - 1:0] m2_tag3_parity;
        wire [TAG_RAM_PW - 1:0] m2_mant_tag_parity;
        wire [TAG_RAM_PW - 1:0] m2_tag_parity;
        wire [DATA_RAM_PW - 1:0] m2_data0_parity;
        wire [DATA_RAM_PW - 1:0] m2_data1_parity;
        wire [DATA_RAM_PW - 1:0] m2_data2_parity;
        wire [DATA_RAM_PW - 1:0] m2_data3_parity;
        wire [DATA_RAM_PW - 1:0] m2_mant_data_parity;
        wire [DATA_RAM_PW - 1:0] m2_data_parity;
        wire [3:0] m2_edata_error1;
        wire [3:0] m2_edata_error2;
        wire [3:0] nds_unused_tag_repair_way_ready;
        wire [TAG_RAM_DW - 1:0] m2_tag0_decdata;
        wire [TAG_RAM_DW - 1:0] m2_tag1_decdata;
        wire [TAG_RAM_DW - 1:0] m2_tag2_decdata;
        wire [TAG_RAM_DW - 1:0] m2_tag3_decdata;
        assign m2_tag0_corrdata = m2_tag0_decdata ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[0] & m2_tag0_decdata[0],3'b0};
        assign m2_tag1_corrdata = m2_tag1_decdata ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[1] & m2_tag1_decdata[0],3'b0};
        assign m2_tag2_corrdata = m2_tag2_decdata ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[2] & m2_tag2_decdata[0],3'b0};
        assign m2_tag3_corrdata = m2_tag3_decdata ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[3] & m2_tag3_decdata[0],3'b0};
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                m2_tag0_check_en <= 1'b0;
                m2_tag1_check_en <= 1'b0;
                m2_tag2_check_en <= 1'b0;
                m2_tag3_check_en <= 1'b0;
                m2_data_check_en <= 1'b0;
            end
            else begin
                m2_tag0_check_en <= m1_tag0_check_en;
                m2_tag1_check_en <= m1_tag1_check_en;
                m2_tag2_check_en <= m1_tag2_check_en;
                m2_tag3_check_en <= m1_tag3_check_en;
                m2_data_check_en <= m1_data_check_en;
            end
        end

        kv_dcu_eccdec_data #(
            .DATA_RAM_CW(DCACHE_DATA_RAM_DW)
        ) u_eccdec_data (
            .check_en(m2_data_check_en),
            .data0_codeword(m2_data0_codeword),
            .data1_codeword(m2_data1_codeword),
            .data2_codeword(m2_data2_codeword),
            .data3_codeword(m2_data3_codeword),
            .data0_corrdata(m2_data0_corrdata),
            .data1_corrdata(m2_data1_corrdata),
            .data2_corrdata(m2_data2_corrdata),
            .data3_corrdata(m2_data3_corrdata),
            .data0_error(m2_data0_error),
            .data1_error(m2_data1_error),
            .data2_error(m2_data2_error),
            .data3_error(m2_data3_error)
        );
        kv_dcu_eccdec_tag #(
            .DCACHE_WAY(DCACHE_WAY),
            .TAG_RAM_CW(DCACHE_TAG_RAM_DW)
        ) u_eccdec_tag (
            .tag0_check_en(m2_tag0_check_en),
            .tag1_check_en(m2_tag1_check_en),
            .tag2_check_en(m2_tag2_check_en),
            .tag3_check_en(m2_tag3_check_en),
            .tag0_codeword(m2_tag0_codeword),
            .tag1_codeword(m2_tag1_codeword),
            .tag2_codeword(m2_tag2_codeword),
            .tag3_codeword(m2_tag3_codeword),
            .tag0_corrdata(m2_tag0_decdata),
            .tag1_corrdata(m2_tag1_decdata),
            .tag2_corrdata(m2_tag2_decdata),
            .tag3_corrdata(m2_tag3_decdata),
            .tag0_error(m2_tag0_error),
            .tag1_error(m2_tag1_error),
            .tag2_error(m2_tag2_error),
            .tag3_error(m2_tag3_error)
        );
        assign m2_tag0_parity = m2_tag0_codeword[TAG_RAM_DW +:TAG_RAM_PW];
        assign m2_tag1_parity = m2_tag1_codeword[TAG_RAM_DW +:TAG_RAM_PW];
        assign m2_tag2_parity = m2_tag2_codeword[TAG_RAM_DW +:TAG_RAM_PW];
        assign m2_tag3_parity = m2_tag3_codeword[TAG_RAM_DW +:TAG_RAM_PW];
        assign m2_data0_parity = m2_data0_codeword[DATA_RAM_DW +:DATA_RAM_PW];
        assign m2_data1_parity = m2_data1_codeword[DATA_RAM_DW +:DATA_RAM_PW];
        assign m2_data2_parity = m2_data2_codeword[DATA_RAM_DW +:DATA_RAM_PW];
        assign m2_data3_parity = m2_data3_codeword[DATA_RAM_DW +:DATA_RAM_PW];
        assign m2_tag_parity = (|m2_tag0_error) ? m2_tag0_parity : (|m2_tag1_error) ? m2_tag1_parity : (|m2_tag2_error) ? m2_tag2_parity : m2_tag3_parity;
        assign m2_data_parity = (|m2_data0_error) ? m2_data0_parity : (|m2_data1_error) ? m2_data1_parity : (|m2_data2_error) ? m2_data2_parity : m2_data3_parity;
        kv_zero_ext #(
            .OW(8),
            .IW(TAG_RAM_PW)
        ) u_m2_tag_ecc_code (
            .out(m2_tag_ecc_code),
            .in(m2_tag_parity)
        );
        kv_zero_ext #(
            .OW(8),
            .IW(DATA_RAM_PW)
        ) u_m2_datd_ecc_code (
            .out(m2_data_ecc_code),
            .in(m2_data_parity)
        );
        kv_mux_onehot #(
            .N(4),
            .W(2)
        ) u_m2_rdata_error (
            .out(m2_ram_rdata_error),
            .sel(m2_ram_rdata_sel),
            .in({m2_data3_error,m2_data2_error,m2_data1_error,m2_data0_error})
        );
        kv_arb_fp #(
            .N(4)
        ) u_tag_repair_way (
            .valid({m2_tag3_error[0],m2_tag2_error[0],m2_tag1_error[0],m2_tag0_error[0]}),
            .ready(nds_unused_tag_repair_way_ready),
            .grant(m2_tag_repair_way)
        );
        kv_mux_onehot #(
            .N(4),
            .W(TAG_RAM_PW)
        ) u_m2_victim_tag_corrdata (
            .out(m2_mant_tag_parity),
            .sel(m2_way[3:0]),
            .in({m2_tag3_parity,m2_tag2_parity,m2_tag1_parity,m2_tag0_parity})
        );
        kv_dcu_shuffle #(
            .DCACHE_WAY(DCACHE_WAY),
            .W(1),
            .REVERSE(1)
        ) u_m2_edata_error1 (
            .way(m2_evt_way),
            .din({m2_data3_error[0],m2_data2_error[0],m2_data1_error[0],m2_data0_error[0]}),
            .dout(m2_edata_error1[3:0])
        );
        kv_dcu_shuffle #(
            .DCACHE_WAY(DCACHE_WAY),
            .W(1),
            .REVERSE(1)
        ) u_m2_edata_error2 (
            .way(m2_evt_way),
            .din({m2_data3_error[1],m2_data2_error[1],m2_data1_error[1],m2_data0_error[1]}),
            .dout(m2_edata_error2[3:0])
        );
        kv_zero_ext #(
            .OW(8),
            .IW(TAG_RAM_PW)
        ) u_m2_mant_tag_parity_ze (
            .out(m2_mant_tag_parity_ze),
            .in(m2_mant_tag_parity)
        );
        assign {m2_data_error2,m2_data_error1} = m2_sb_rdata_valid ? 2'd0 : (m2_hit & (m2_read | m2_rmw) & ~m2_tag_error) ? m2_ram_rdata_error[1:0] : 2'd0;
        kv_mux_onehot #(
            .N(4),
            .W(DATA_RAM_PW)
        ) u_m2_mant_data_parity (
            .out(m2_mant_data_parity),
            .sel(m2_ram_rdata_sel),
            .in({m2_data3_parity,m2_data2_parity,m2_data1_parity,m2_data0_parity})
        );
        kv_zero_ext #(
            .OW(8),
            .IW(DATA_RAM_PW)
        ) u_m2_mant_data_parity_ze (
            .out(m2_mant_data_parity_ze),
            .in(m2_mant_data_parity)
        );
        assign m1_tag0_check_en = m1_eccen23 & (m1_lsu_valid | m1_probe_valid | (m1_mant_valid & m1_way[0] & m1_release));
        assign m1_tag1_check_en = m1_eccen23 & (m1_lsu_valid | m1_probe_valid | (m1_mant_valid & m1_way[1] & m1_release));
        assign m1_tag2_check_en = m1_eccen23 & (m1_lsu_valid | m1_probe_valid | (m1_mant_valid & m1_way[2] & m1_release));
        assign m1_tag3_check_en = m1_eccen23 & (m1_lsu_valid | m1_probe_valid | (m1_mant_valid & m1_way[3] & m1_release));
        assign m1_data_check_en = m1_eccen23;
        assign m2_tag_error1 = m2_tag0_error[0] | m2_tag1_error[0] | m2_tag2_error[0] | m2_tag3_error[0];
        assign m2_tag_error2 = m2_tag0_error[1] | m2_tag1_error[1] | m2_tag2_error[1] | m2_tag3_error[1];
        assign m2_corr_error = m2_tag_error1 | m2_data_error1 | (m2_data_error2 & ~m2_tag_corrdata[TAG_M]);
        assign m2_uncorr_error = m2_tag_error2 | (m2_data_error2 & m2_tag_corrdata[TAG_M]);
        assign m2_fault = (m2_eccen2 & (m2_uncorr_error)) | (m2_eccen3 & (m2_uncorr_error | m2_corr_error));
        assign m2_ecc_code = m2_tag_error ? m2_tag_ecc_code : m2_data_ecc_code;
        assign evt_ack_error1 = (~m2_beat_mask[0] & m2_edata_error1[0]) | (~m2_beat_mask[4] & m2_edata_error1[1]) | (~m2_beat_mask[8] & m2_edata_error1[2]) | (~m2_beat_mask[12] & m2_edata_error1[3]);
        assign evt_ack_error2 = (~m2_beat_mask[0] & m2_edata_error2[0]) | (~m2_beat_mask[4] & m2_edata_error2[1]) | (~m2_beat_mask[8] & m2_edata_error2[2]) | (~m2_beat_mask[12] & m2_edata_error2[3]);
    end
    else begin:gen_eccdec_stub
        assign m2_data_error1 = 1'b0;
        assign m2_data_error2 = 1'b0;
        assign m2_data0_corrdata = m2_data0_codeword[31:0];
        assign m2_data1_corrdata = m2_data1_codeword[31:0];
        assign m2_data2_corrdata = m2_data2_codeword[31:0];
        assign m2_data3_corrdata = m2_data3_codeword[31:0];
        assign m2_tag_repair_way = 4'd0;
        assign m2_tag0_corrdata = m2_tag0_codeword[TAG_RAM_DW - 1:0] ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[0] & m2_tag0_codeword[0],3'b0};
        assign m2_tag1_corrdata = m2_tag1_codeword[TAG_RAM_DW - 1:0] ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[1] & m2_tag1_codeword[0],3'b0};
        assign m2_tag2_corrdata = m2_tag2_codeword[TAG_RAM_DW - 1:0] ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[2] & m2_tag2_codeword[0],3'b0};
        assign m2_tag3_corrdata = m2_tag3_codeword[TAG_RAM_DW - 1:0] ^ {{TAG_RAM_DW - 4{1'b0}},tb_lock[3] & m2_tag3_codeword[0],3'b0};
        assign m2_tag_error1 = 1'b0;
        assign m2_tag_error2 = 1'b0;
        assign m2_mant_tag_parity_ze = 8'd0;
        assign m2_mant_data_parity_ze = 8'd0;
        assign m2_corr_error = 1'b0;
        assign m2_uncorr_error = 1'b0;
        assign m2_fault = 1'b0;
        assign m2_ecc_code = 8'd0;
        assign evt_ack_error1 = 1'b0;
        assign evt_ack_error2 = 1'b0;
    end
endgenerate
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_dcu_async_ecc_error
        reg async_ecc_error;
        wire async_ecc_error_set;
        reg async_ecc_corr;
        wire async_ecc_corr_nx;
        reg [3:0] async_ecc_ramid;
        wire [3:0] async_ecc_ramid_nx;
        wire async_ecc_error_sel_evb;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                async_ecc_error <= 1'b0;
            end
            else begin
                async_ecc_error <= async_ecc_error_set;
            end
        end

        always @(posedge dcu_clk) begin
            if (async_ecc_error_set) begin
                async_ecc_corr <= async_ecc_corr_nx;
                async_ecc_ramid <= async_ecc_ramid_nx;
            end
        end

        assign async_ecc_error_set = evb_async_ecc_error | probe_async_ecc_error;
        assign async_ecc_error_sel_evb = (evb_async_ecc_error & ~evb_async_ecc_corr) ? 1'b1 : (probe_async_ecc_error & ~probe_async_ecc_corr) ? 1'b0 : evb_async_ecc_error;
        assign async_ecc_corr_nx = async_ecc_error_sel_evb ? evb_async_ecc_corr : probe_async_ecc_corr;
        assign async_ecc_ramid_nx = async_ecc_error_sel_evb ? 4'd5 : 4'd4;
        assign dcu_async_ecc_error = async_ecc_error;
        assign dcu_async_ecc_corr = async_ecc_corr;
        assign dcu_async_ecc_ramid = async_ecc_ramid;
    end
    else begin:gen_dcu_async_ecc_error_stub
        assign dcu_async_ecc_error = 1'b0;
        assign dcu_async_ecc_corr = 1'b0;
        assign dcu_async_ecc_ramid = 4'd0;
    end
endgenerate
generate
    if ((DCACHE_ECC_TYPE_INT == 2) && (CM_SUPPORT_INT == 1)) begin:gen_probe_async_ecc_error
        assign probe_async_ecc_error = (m2_probe_valid & m2_eccen2 & (m2_tag_error2)) | (m2_probe_valid & m2_eccen3 & (m2_tag_error1 | m2_tag_error2));
        assign probe_async_ecc_corr = ~m2_tag_error2;
    end
    else begin:gen_probe_async_ecc_error_stub
        assign probe_async_ecc_error = 1'b0;
        assign probe_async_ecc_corr = 1'b0;
    end
endgenerate
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_fil_data_ecc
        reg [127:0] reg_m1_fil_data;
        wire reg_m1_fil_data_en;
        always @(posedge dcu_clk) begin
            if (reg_m1_fil_data_en) begin
                reg_m1_fil_data <= fil_wdata;
            end
        end

        assign reg_m1_fil_data_en = fil_req_grant & fil_payload;
        assign m1_fil_data = reg_m1_fil_data;
    end
    else begin:gen_fil_data_stub
        assign m1_fil_data = {128{1'b0}};
    end
endgenerate
assign m2_beat_mask_en = m1_evt_valid;
assign m2_beat_mask_nx = sb_cmp_beat_mask;
assign m2_beat_data_en = m1_evt_valid | (m1_fil_valid & m1_fil_payload & ecccfg);
assign m2_beat_data_nx = ({128{m1_evt_valid}} & sb_cmp_beat_data) | ({128{m1_fil_valid}} & m1_fil_data);
assign m2_ctrl_en = m1_valid;
assign m2_tag_rdata_en = m1_lsu_valid | m1_mant_valid | m1_probe_valid;
assign m2_addr_en = m1_lsu_valid | m1_mant_valid | m1_probe_valid;
assign m2_sb_en = m1_sb_valid;
assign m2_sb_rdata_en = m1_sb_valid & m1_sb_read & m1_lsu_valid;
assign m2_sb_ptr = sb_enq_mrg ? sb_enq_mrg_ptr : sb_enq_free_ptr;
assign m2_ram_rdata_en = |m1_data_arb_grant;
kv_bit_expand #(
    .N(4),
    .M(8)
) u_m2_data0_mask_bit (
    .out(m2_data0_mask_bit),
    .in(m2_data0_mask)
);
kv_bit_expand #(
    .N(4),
    .M(8)
) u_m2_data1_mask_bit (
    .out(m2_data1_mask_bit),
    .in(m2_data1_mask)
);
kv_bit_expand #(
    .N(4),
    .M(8)
) u_m2_data2_mask_bit (
    .out(m2_data2_mask_bit),
    .in(m2_data2_mask)
);
kv_bit_expand #(
    .N(4),
    .M(8)
) u_m2_data3_mask_bit (
    .out(m2_data3_mask_bit),
    .in(m2_data3_mask)
);
assign m2_ram_rdata = (m2_data0_mask_bit & m2_data0_codeword[31:0]) | (m2_data1_mask_bit & m2_data1_codeword[31:0]) | (m2_data2_mask_bit & m2_data2_codeword[31:0]) | (m2_data3_mask_bit & m2_data3_codeword[31:0]);
kv_mux_onehot #(
    .N(4),
    .W(32)
) u_m2_ecc_data (
    .out(m2_corrdata),
    .sel(m2_ram_rdata_sel),
    .in({m2_data3_corrdata,m2_data2_corrdata,m2_data1_corrdata,m2_data0_corrdata})
);
assign m2_rdata = m2_ram_rdata | m2_sb_rdata;
assign m2_part = (m2_size == 2'd0) | (m2_size == 2'd1) | ((m2_size == 2'd2) & xlen64);
assign m2_rmw = m2_write & m2_part & ecccfg;
assign m2_hit = |m2_way;
assign m2_modified = m2_tag_corrdata[TAG_M];
assign m2_locked = m2_tag_corrdata[TAG_L];
kv_dcu_replace_way #(
    .DCACHE_WAY(DCACHE_WAY),
    .TAG_RAM_DW(TAG_RAM_DW)
) u_replace_way (
    .tag0_rdata(m2_tag0_codeword[TAG_RAM_DW - 1:0]),
    .tag1_rdata(m2_tag1_codeword[TAG_RAM_DW - 1:0]),
    .tag2_rdata(m2_tag2_codeword[TAG_RAM_DW - 1:0]),
    .tag3_rdata(m2_tag3_codeword[TAG_RAM_DW - 1:0]),
    .lru_rdata(lru_ack_rdata),
    .replace_way(m2_replace_way),
    .replace_tag(m2_replace_tag)
);
kv_mux_onehot #(
    .N(4),
    .W(TAG_RAM_DW)
) u_m2_mant_tag_codeword (
    .out(m2_tag_codeword),
    .sel(m2_way[3:0]),
    .in({m2_tag3_codeword[TAG_RAM_DW - 1:0],m2_tag2_codeword[TAG_RAM_DW - 1:0],m2_tag1_codeword[TAG_RAM_DW - 1:0],m2_tag0_codeword[TAG_RAM_DW - 1:0]})
);
kv_mux_onehot #(
    .N(4),
    .W(TAG_RAM_DW)
) u_m2_tag_corrdata (
    .out(m2_tag_corrdata),
    .sel(m2_way[3:0]),
    .in({m2_tag3_corrdata[TAG_RAM_DW - 1:0],m2_tag2_corrdata[TAG_RAM_DW - 1:0],m2_tag1_corrdata[TAG_RAM_DW - 1:0],m2_tag0_corrdata[TAG_RAM_DW - 1:0]})
);
kv_mux_onehot #(
    .N(4),
    .W(TAG_RAM_DW)
) u_m2_replace_tag_corrdata (
    .out(m2_replace_tag_corrdata),
    .sel(m2_replace_way[3:0]),
    .in({m2_tag3_corrdata[TAG_RAM_DW - 1:0],m2_tag2_corrdata[TAG_RAM_DW - 1:0],m2_tag1_corrdata[TAG_RAM_DW - 1:0],m2_tag0_corrdata[TAG_RAM_DW - 1:0]})
);
assign m2_replace = (m2_read | m2_write | m2_lock) & ~m2_hit & ~m2_mshr_hit & m2_replace_valid & ~m2_replace_locked & ~m2_na_int & ~(~cmt_fifo_rvalid & dcu_cmt_valid & dcu_cmt_na);
assign m2_evb_replace = (m2_read | m2_write | m2_lock) & ~m2_hit;
assign m2_evb_kill = (m2_read | m2_write | m2_lock) & m2_replace_locked & ~m2_data_error2;
assign m2_mshr_defer = m2_mshr_sameidx | m2_mshr_speculative | m2_mshr_wbf_cft | m2_mshr_defer_hit_killed | m2_mshr_defer_na | m2_mshr_defer_write;
assign m2_mshr_wbf_cft = m2_write & ~m2_mshr_hit & ~linemask_full & |mshr_ent_wbf_cft;
assign m2_mshr_defer_hit_killed = |(m2_mshr_hit_ptr & mshr_ent_killed);
assign m2_mshr_defer_na = (|m2_mshr_ent_defer_na);
assign m2_mshr_ent_defer_na = (m2_mshr_hit_ptr & mshr_ent_na) & ~(mshr_ent_na_mrg & {MSHR_DEPTH{m2_write & ~m2_wbf_flush & ~linemask_full}});
assign m2_mshr_defer_write = (|m2_mshr_ent_defer_write);
assign m2_mshr_ent_defer_write = (m2_mshr_hit_ptr & mshr_ent_write) & ~(mshr_ent_write_mrg & {MSHR_DEPTH{m2_write}});
assign m2_defer = m2_evb_hit | m2_mshr_wt | (~m2_read_hit & ~m2_mshr_hit & mshr_full) | (~m2_hit & ~evb_enq_ready) | (~m2_tag_codeword[TAG_S] & m2_replace_way_hit_evb) | (~m2_tag_codeword[TAG_S] & m2_mshr_defer) | (m2_write & ~m2_tag_codeword[TAG_M] & m2_mshr_defer) | (m2_read & ~m2_hit & m2_mshr_hit) | (m2_replace & m2_replace_tag[TAG_M] & ~wbf_a0_ready) | (m2_inval & m2_tag_codeword[TAG_S] & ~evb_enq_ready) | (m2_wb & m2_tag_codeword[TAG_M] & ~wbf_a0_ready) | (m2_wb & m2_tag_codeword[TAG_S] & ~evb_enq_ready) | (m2_wbinval & m2_tag_codeword[TAG_M] & ~wbf_a0_ready) | (m2_wbinval & m2_tag_codeword[TAG_S] & ~evb_enq_ready) | (m2_write & sb_full_final) | (m2_lr & ~(mshr_empty & evb_empty & sb_empty)) | repair_valid | m2_pending_speculative;
assign m2_nullify = m2_defer | m2_sc_fail | m2_lr_fail | m2_uncorr_error | m2_corr_error;
assign m2_lsu_way = m2_hit ? m2_way : m2_mshr_hit ? m2_mshr_hit_way : m2_replace_way;
assign m2_replace_way_hit_evb = |(m2_replace_way & m2_evb_cft);
assign m2_mant_defer0 = |(m2_evb_cft & m2_way) | m2_evb_hit;
assign m2_mant_defer1 = (m2_inval & m2_tag_codeword[TAG_M] & ~wbf_a0_ready) | (m2_wb & m2_tag_codeword[TAG_M] & ~wbf_a0_ready) | (m2_wbinval & m2_tag_codeword[TAG_M] & ~wbf_a0_ready);
assign m2_mant_defer2 = (m2_inval & ~evb_enq_ready) | (m2_wb & ~evb_enq_ready) | (m2_wbinval & ~evb_enq_ready);
assign m2_mant_defer_evb = m2_mant_defer0 | m2_mant_defer1;
assign m2_mant_defer_wbf = m2_mant_defer0 | m2_mant_defer2;
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_repair
        reg reg_tag_repair_valid;
        reg [IDX_MSB:IDX_LSB] reg_tag_repair_index;
        reg [3:0] reg_tag_repair_way;
        reg [TAG_RAM_DW - 1:0] reg_tag_repair_corrdata;
        wire reg_tag_repair_valid_set;
        wire reg_tag_repair_valid_clr;
        wire reg_tag_repair_valid_nx;
        reg reg_data_repair_valid;
        reg [PALEN - 1:0] reg_data_repair_addr;
        reg [3:0] reg_data_repair_way;
        reg [31:0] reg_data_repair_corrdata;
        wire reg_data_repair_valid_set;
        wire reg_data_repair_valid_clr;
        wire reg_data_repair_valid_nx;
        wire [3:0] rep_data_ram_cs;
        wire [3:0] rep_data_ram_cs_shuffle;
        reg m2_mshr_tagw;
        wire [TAG_RAM_DW - 1:0] m2_tag_repair_corrdata;
        wire m2_tag_repair_way_hit_evb;
        wire m1_mshr_tagw;
        wire m2_lsu_repair_tag;
        wire m2_mant_repair_tag;
        kv_mux_onehot #(
            .N(4),
            .W(TAG_RAM_DW)
        ) u_m2_tag_repair_corrdata (
            .out(m2_tag_repair_corrdata),
            .sel(m2_tag_repair_way[3:0]),
            .in({m2_tag3_corrdata[TAG_RAM_DW - 1:0],m2_tag2_corrdata[TAG_RAM_DW - 1:0],m2_tag1_corrdata[TAG_RAM_DW - 1:0],m2_tag0_corrdata[TAG_RAM_DW - 1:0]})
        );
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                m2_mshr_tagw <= 1'd0;
            end
            else if (m2_addr_en) begin
                m2_mshr_tagw <= m1_mshr_tagw;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                reg_tag_repair_valid <= 1'b0;
            end
            else begin
                reg_tag_repair_valid <= reg_tag_repair_valid_nx;
            end
        end

        always @(posedge dcu_clk) begin
            if (reg_tag_repair_valid_set) begin
                reg_tag_repair_index <= m2_addr[IDX_MSB:IDX_LSB];
                reg_tag_repair_way <= m2_tag_repair_way;
                reg_tag_repair_corrdata <= m2_tag_repair_corrdata;
            end
        end

        assign m1_mshr_tagw = |mshr_cmp_tagw;
        assign m2_tag_repair_way_hit_evb = |(m2_tag_repair_way & m2_evb_cft);
        assign m2_lsu_repair_tag = m2_lsu_valid & m2_tag_error1 & ~m2_mshr_hit & ~m2_mshr_defer & ~m2_mshr_tagw & ~m2_defer & ~m2_tag_repair_way_hit_evb;
        assign m2_mant_repair_tag = m2_mant_valid & ~m2_mant_defer_evb & m2_wb & m2_tag_error1 & ~m2_tag_corrdata[TAG_M];
        assign reg_tag_repair_valid_set = m2_lsu_repair_tag | m2_mant_repair_tag;
        assign reg_tag_repair_valid_clr = tag_arb_grant[TAG_ARB_REPAIR];
        assign reg_tag_repair_valid_nx = reg_tag_repair_valid_set | (reg_tag_repair_valid & ~reg_tag_repair_valid_clr);
        assign tag_repair_addr = {reg_tag_repair_corrdata[TAG_RAM_DW - 1:4],reg_tag_repair_index,{IDX_LSB{1'b0}}};
        assign tag_repair_corrdata = reg_tag_repair_corrdata;
        assign tag_repair_way = reg_tag_repair_way & {4{reg_tag_repair_valid}};
        always @(posedge dcu_clk) begin
            if (reg_data_repair_valid_set) begin
                reg_data_repair_addr <= m2_addr;
                reg_data_repair_way <= m2_way;
                reg_data_repair_corrdata <= m2_corrdata;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                reg_data_repair_valid <= 1'b0;
            end
            else begin
                reg_data_repair_valid <= reg_data_repair_valid_nx;
            end
        end

        assign reg_data_repair_valid_set = m2_lsu_valid & m2_data_error1 & ~m2_evb_hit & ~reg_data_repair_valid;
        assign reg_data_repair_valid_clr = data_arb_grant[DATA_ARB_REPAIR];
        assign reg_data_repair_valid_nx = reg_data_repair_valid_set | (reg_data_repair_valid & ~reg_data_repair_valid_clr);
        kv_bin2onehot #(
            .N(4)
        ) u_rep_data_ram_cs (
            .out(rep_data_ram_cs),
            .in(reg_data_repair_addr[GRN_LSB +:2])
        );
        kv_dcu_shuffle #(
            .DCACHE_WAY(DCACHE_WAY),
            .W(1)
        ) u_rep_shuffle (
            .way(reg_data_repair_way),
            .din({rep_data_ram_cs[3],rep_data_ram_cs[2],rep_data_ram_cs[1],rep_data_ram_cs[0]}),
            .dout({rep_data_ram_cs_shuffle[3],rep_data_ram_cs_shuffle[2],rep_data_ram_cs_shuffle[1],rep_data_ram_cs_shuffle[0]})
        );
        assign rep_data0_cs = reg_data_repair_valid & rep_data_ram_cs_shuffle[0];
        assign rep_data1_cs = reg_data_repair_valid & rep_data_ram_cs_shuffle[1];
        assign rep_data2_cs = reg_data_repair_valid & rep_data_ram_cs_shuffle[2];
        assign rep_data3_cs = reg_data_repair_valid & rep_data_ram_cs_shuffle[3];
        assign rep_data0_we = 1'b1;
        assign rep_data1_we = 1'b1;
        assign rep_data2_we = 1'b1;
        assign rep_data3_we = 1'b1;
        assign rep_data0_byte_we = {4{1'b1}};
        assign rep_data1_byte_we = {4{1'b1}};
        assign rep_data2_byte_we = {4{1'b1}};
        assign rep_data3_byte_we = {4{1'b1}};
        assign rep_data0_wdata = reg_data_repair_corrdata;
        assign rep_data1_wdata = reg_data_repair_corrdata;
        assign rep_data2_wdata = reg_data_repair_corrdata;
        assign rep_data3_wdata = reg_data_repair_corrdata;
        assign rep_data0_addr = reg_data_repair_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
        assign rep_data1_addr = reg_data_repair_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
        assign rep_data2_addr = reg_data_repair_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
        assign rep_data3_addr = reg_data_repair_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
        assign data_repair_corrdata = reg_data_repair_corrdata;
        assign repair_valid = reg_tag_repair_valid | reg_data_repair_valid;
    end
    else begin:gen_repair_stub
        assign repair_valid = 1'b0;
        assign tag_repair_addr = {PALEN{1'b0}};
        assign tag_repair_corrdata = {TAG_RAM_DW{1'b0}};
        assign tag_repair_way = 4'd0;
        assign data_repair_corrdata = {32{1'b0}};
        assign rep_data0_addr = {DCACHE_DATA_RAM_AW{1'b0}};
        assign rep_data1_addr = {DCACHE_DATA_RAM_AW{1'b0}};
        assign rep_data2_addr = {DCACHE_DATA_RAM_AW{1'b0}};
        assign rep_data3_addr = {DCACHE_DATA_RAM_AW{1'b0}};
        assign rep_data0_cs = 1'b0;
        assign rep_data1_cs = 1'b0;
        assign rep_data2_cs = 1'b0;
        assign rep_data3_cs = 1'b0;
        assign rep_data0_we = 1'b0;
        assign rep_data1_we = 1'b0;
        assign rep_data2_we = 1'b0;
        assign rep_data3_we = 1'b0;
        assign rep_data0_byte_we = {4{1'b0}};
        assign rep_data1_byte_we = {4{1'b0}};
        assign rep_data2_byte_we = {4{1'b0}};
        assign rep_data3_byte_we = {4{1'b0}};
        assign rep_data0_wdata = {32{1'b0}};
        assign rep_data1_wdata = {32{1'b0}};
        assign rep_data2_wdata = {32{1'b0}};
        assign rep_data3_wdata = {32{1'b0}};
    end
endgenerate
assign m1_mshr_bypass_hit = m2_lsu_valid & m1_m2_same_line & ~mshr_enq_stall & ~mshr_enq_mrg;
assign m1_mshr_bypass_sameidx = m2_lsu_valid & m1_m2_same_idx & ~mshr_enq_stall & ~mshr_enq_mrg;
assign mshr_cmp_addr = m1_addr;
assign mshr_cmp_func[0] = m1_func[19];
assign mshr_cmp_func[1] = m1_func[28];
assign m1_mshr_hit = m1_mshr_bypass_hit | (|mshr_cmp_hit);
assign m1_mshr_hit_ptr = m1_mshr_bypass_hit ? mshr_free_ptr : mshr_cmp_hit;
assign m1_mshr_hit_way = m1_mshr_bypass_hit ? mshr_enq_way : mshr_cmp_way;
assign m1_mshr_hit_mesi = m1_mshr_bypass_hit ? mshr_enq_state[2:0] : mshr_cmp_mesi;
assign m1_mshr_hit_changing = mshr_cmp_changing | (m2_lsu_valid & m2_write & m2_tag_codeword[TAG_E] & ~m2_tag_codeword[TAG_M] & m1_m2_same_line);
assign m1_mshr_sameidx = m1_mshr_bypass_sameidx | (|mshr_cmp_sameidx);
assign m1_mshr_sameidx_ptr = m1_mshr_bypass_sameidx ? mshr_free_ptr : mshr_cmp_sameidx;
assign m2_mshr_abort = (mshr_full & ~m2_mshr_hit) | mshr_enq_stall;
assign mshr_enq_valid = m2_lsu_valid;
assign mshr_enq_stall = m2_read_hit | m2_wb | m2_wbinval | m2_inval | m2_nullify | (m2_lock & m2_hit & m2_locked);
assign mshr_enq_mrg = m2_mshr_hit;
assign mshr_enq_mrg_ptr = m2_mshr_hit_ptr;
assign mshr_enq_id = m2_id;
assign mshr_enq_addr = m2_addr;
assign mshr_enq_spec = ~dcu_cmt_valid | cmt_fifo_rvalid;
assign mshr_enq_state[3:0] = m2_tag_corrdata[3:0];
assign mshr_enq_way = m2_mant_valid ? m2_way : m2_hit ? m2_way : m2_replace_way;
assign mshr_enq_l2_ways = wpt_ack_data;
assign mshr_enq_func[0] = m2_func[19];
assign mshr_enq_func[1] = m2_func[28];
assign mshr_enq_func[14] = m2_func[9];
assign mshr_enq_func[13] = m2_sc_retry;
assign mshr_enq_func[2 +:2] = m2_size;
assign mshr_enq_func[15 +:3] = m2_fmt;
assign mshr_enq_func[4] = m2_func[10];
assign mshr_enq_func[12] = m2_func[11];
assign mshr_enq_func[5 +:5] = m2_func[13 +:5];
assign mshr_enq_func[10] = m2_func[8] & ~m2_replace_locked;
assign mshr_enq_func[11] = m2_func[24];
assign mshr_enq_func[18] = m2_func[6];
assign m2_mshr_ptr = m2_mshr_hit ? m2_mshr_hit_ptr : mshr_free_ptr;
assign mshr_cmt_valid = dcu_cmt_valid & ~cmt_mshr_abort;
assign mshr_cmt_kill = dcu_cmt_kill | cmt_null;
assign mshr_cmt_addr = dcu_cmt_addr;
assign mshr_cmt_attr[0] = cmt_na;
assign mshr_cmt_attr[1] = dcu_cmt_wt;
assign mshr_cmt_attr[2 +:4] = (cmt_wa & (dcu_cmt_pma == 4'b1010)) ? 4'b1000 : (cmt_wa & (dcu_cmt_pma == 4'b1011)) ? 4'b1001 : dcu_cmt_pma;
assign mshr_cmt_wdata = dcu_cmt_wdata;
assign mshr_cmt_wmask = dcu_cmt_wmask;
assign mshr_cmt_ptr = cmt_mshr_ptr;
assign mshr_prb_valid = m2_probe_valid & ~m2_probe_nullify;
assign mshr_prb_ptr = m2_mshr_ptr;
assign mshr_prb_mesi[TAG_M] = 1'b0;
assign mshr_prb_mesi[TAG_E] = ~m2_cap2n & ~m2_cap2b;
assign mshr_prb_mesi[TAG_S] = ~m2_cap2n;
assign m2_mshr_sameidx_wbf = |(m2_mshr_sameidx_ptr & mshr_ent_wbf);
assign m2_mshr_hit_wbf = |(m2_mshr_hit_ptr & mshr_ent_wbf);
assign mshr_wbf_flush = m2_wbf_flush | linemask_full | (m2_lsu_valid & m2_lr) | (m2_lsu_valid & m2_replace & m2_replace_tag[TAG_M] & ~wbf_a0_ready) | (m2_lsu_valid & m2_wbinval & m2_tag_corrdata[TAG_M] & ~wbf_a0_ready) | (m2_lsu_valid & m2_wb & m2_tag_corrdata[TAG_M] & ~wbf_a0_ready) | (m2_mant_valid & m2_wb & m2_tag_corrdata[TAG_M] & ~wbf_a0_ready & ~m2_mant_defer_wbf) | (m2_mant_valid & m2_wbinval & m2_tag_corrdata[TAG_M] & ~wbf_a0_ready & ~m2_mant_defer_wbf) | (m2_probe_valid & m2_tag_corrdata[TAG_M] & ~wbf_a0_ready) | (m2_lsu_valid & m2_read & ~m2_tag_corrdata[TAG_S] & m2_mshr_sameidx_wbf) | (m2_lsu_valid & m2_read & ~m2_tag_corrdata[TAG_S] & m2_mshr_hit_wbf) | (m2_lsu_valid & m2_write & ~m2_tag_corrdata[TAG_M] & m2_mshr_sameidx_wbf) | (m2_lsu_valid & m2_write & ~m2_tag_corrdata[TAG_M] & m2_mshr_wbf_cft) | (m2_lsu_valid & m2_write & ~m2_tag_corrdata[TAG_M] & ~m2_mshr_hit_na_mrg);
wire nds_unused_cmt_fifo_wready;
kv_fifo #(
    .DEPTH(2),
    .WIDTH(CMT_FIFO_DW)
) u_cmt_null (
    .clk(dcu_clk),
    .reset_n(dcu_reset_n),
    .flush(1'b0),
    .wdata(cmt_fifo_wdata),
    .wvalid(cmt_fifo_wvalid),
    .wready(nds_unused_cmt_fifo_wready),
    .rdata(cmt_fifo_rdata),
    .rvalid(cmt_fifo_rvalid),
    .rready(dcu_cmt_valid)
);
assign cmt_fifo_wdata = {m2_hit,m2_modified,m2_sc_retry,m2_lsu_way,evb_enq_valid,evb_enq_ptr,m2_evb_kill,m2_evb_replace,m2_nullify,m2_halt,m2_na_int,m2_mshr_abort,m2_mshr_hit,m2_mshr_ptr,m2_disable_na,m2_wa,m2_sb_ptr};
assign cmt_fifo_wvalid = (m2_lsu_valid & ~dcu_cmt_valid) | (m2_lsu_valid & cmt_fifo_rvalid);
assign {cmt_fifo_hit,cmt_fifo_modified,cmt_fifo_sc_retry,cmt_fifo_way,cmt_fifo_evb_enq,cmt_fifo_evb_ptr,cmt_fifo_evb_kill,cmt_fifo_evb_replace,cmt_fifo_null,cmt_fifo_halt,cmt_fifo_na_int,cmt_fifo_mshr_abort,cmt_fifo_mshr_hit,cmt_fifo_mshr_ptr,cmt_fifo_disable_na,cmt_fifo_wa,cmt_fifo_sb_ptr} = cmt_fifo_rdata;
assign cmt_hit = cmt_fifo_rvalid ? cmt_fifo_hit : m2_hit;
assign cmt_modified = cmt_fifo_rvalid ? cmt_fifo_modified : m2_modified;
assign cmt_sc_retry = cmt_fifo_rvalid ? cmt_fifo_sc_retry : m2_sc_retry;
assign cmt_way = cmt_fifo_rvalid ? cmt_fifo_way : m2_lsu_way;
assign cmt_evb_enq = cmt_fifo_rvalid ? cmt_fifo_evb_enq : evb_enq_valid;
assign cmt_evb_ptr = cmt_fifo_rvalid ? cmt_fifo_evb_ptr : evb_enq_ptr;
assign cmt_evb_kill = cmt_fifo_rvalid ? cmt_fifo_evb_kill : m2_evb_kill;
assign cmt_evb_replace = cmt_fifo_rvalid ? cmt_fifo_evb_replace : m2_evb_replace;
assign cmt_null = cmt_fifo_rvalid ? cmt_fifo_null : m2_nullify;
assign cmt_halt = cmt_fifo_rvalid ? cmt_fifo_halt : m2_halt;
assign cmt_na_int = cmt_fifo_rvalid ? cmt_fifo_na_int : m2_na_int;
assign cmt_mshr_abort = cmt_fifo_rvalid ? cmt_fifo_mshr_abort : m2_mshr_abort;
assign cmt_mshr_hit = cmt_fifo_rvalid ? cmt_fifo_mshr_hit : m2_mshr_hit;
assign cmt_mshr_ptr = cmt_fifo_rvalid ? cmt_fifo_mshr_ptr : m2_mshr_ptr;
assign cmt_disable_na = cmt_fifo_rvalid ? cmt_fifo_disable_na : m2_disable_na;
assign cmt_wa = cmt_fifo_rvalid ? cmt_fifo_wa : m2_wa;
assign cmt_sb_ptr = cmt_fifo_rvalid ? cmt_fifo_sb_ptr : m2_sb_ptr;
assign m2_pending_speculative = cmt_fifo_rvalid;
assign m2_wa = m2_write & (m2_mshr_hit_na_mrg | wna_mode);
assign m2_na_switch = m2_wa | (m2_replace_locked & ~m2_unlock);
assign m2_disable_na = |(m2_mshr_hit_ptr & ~mshr_ent_na) | m2_hit;
assign m2_na_int = ~m2_disable_na & m2_na_switch;
assign cmt_na = cmt_na_int | (~cmt_disable_na & dcu_cmt_na);
assign m2_mshr_hit_na_mrg = |(m2_mshr_hit_ptr & mshr_ent_na_mrg);
generate
    if (WRITE_AROUND_SUPPORT_INT == 1) begin:gen_linemask
        reg [63:0] reg_linemask;
        wire [63:0] reg_linemask_nx;
        wire reg_linemask_en;
        wire [63:0] reg_linemask_clr;
        wire [63:0] reg_linemask_set;
        reg reg_linemask_full;
        wire reg_linemask_full_nx;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                reg_linemask <= 64'b0;
                reg_linemask_full <= 1'b0;
            end
            else if (reg_linemask_en) begin
                reg_linemask <= reg_linemask_nx;
                reg_linemask_full <= reg_linemask_full_nx;
            end
        end

        kv_bin2onehot #(
            .N(16)
        ) u_cmt_addr_onehot (
            .out(cmt_addr_onehot),
            .in(dcu_cmt_addr[5:GRN_LSB])
        );
        assign reg_linemask_en = cmt_wna | linemask_full;
        assign reg_linemask_nx = reg_linemask_set | (reg_linemask & ~reg_linemask_clr);
        assign reg_linemask_set = {64{cmt_wna}} & cmt_linemask;
        assign reg_linemask_clr = {64{cmt_wna & ~cmt_mshr_hit}} | {64{mshr_wbf_flush}};
        assign reg_linemask_full_nx = &(cmt_linemask | reg_linemask) & cmt_wna & cmt_mshr_hit & ~mshr_wbf_flush;
        assign linemask = reg_linemask;
        assign linemask_full = reg_linemask_full;
    end
    else begin:gen_linemask_stub
        assign linemask = 64'b0;
        assign linemask_full = 1'b0;
        assign cmt_addr_onehot = {16{1'b0}};
    end
endgenerate
assign cmt_wna = mshr_cmt_valid & ~mshr_cmt_kill & dcu_cmt_write & cmt_na;
assign cmt_linemask[0 +:4] = {4{cmt_addr_onehot[0]}} & mshr_cmt_wmask;
assign cmt_linemask[4 +:4] = {4{cmt_addr_onehot[1]}} & mshr_cmt_wmask;
assign cmt_linemask[8 +:4] = {4{cmt_addr_onehot[2]}} & mshr_cmt_wmask;
assign cmt_linemask[12 +:4] = {4{cmt_addr_onehot[3]}} & mshr_cmt_wmask;
assign cmt_linemask[16 +:4] = {4{cmt_addr_onehot[4]}} & mshr_cmt_wmask;
assign cmt_linemask[20 +:4] = {4{cmt_addr_onehot[5]}} & mshr_cmt_wmask;
assign cmt_linemask[24 +:4] = {4{cmt_addr_onehot[6]}} & mshr_cmt_wmask;
assign cmt_linemask[28 +:4] = {4{cmt_addr_onehot[7]}} & mshr_cmt_wmask;
assign cmt_linemask[32 +:4] = {4{cmt_addr_onehot[8]}} & mshr_cmt_wmask;
assign cmt_linemask[36 +:4] = {4{cmt_addr_onehot[9]}} & mshr_cmt_wmask;
assign cmt_linemask[40 +:4] = {4{cmt_addr_onehot[10]}} & mshr_cmt_wmask;
assign cmt_linemask[44 +:4] = {4{cmt_addr_onehot[11]}} & mshr_cmt_wmask;
assign cmt_linemask[48 +:4] = {4{cmt_addr_onehot[12]}} & mshr_cmt_wmask;
assign cmt_linemask[52 +:4] = {4{cmt_addr_onehot[13]}} & mshr_cmt_wmask;
assign cmt_linemask[56 +:4] = {4{cmt_addr_onehot[14]}} & mshr_cmt_wmask;
assign cmt_linemask[60 +:4] = {4{cmt_addr_onehot[15]}} & mshr_cmt_wmask;
assign m0_sb_valid = m0_lsu_grant | evt_req_grant | fil_req_grant | probe_req_grant;
assign m0_sb_read = (tag_arb_grant[TAG_ARB_LSU] & m0_sb_read_lsu) | (tag_arb_grant[TAG_ARB_EVB]);
assign m0_sb_write = (tag_arb_grant[TAG_ARB_LSU] & m0_sb_write_lsu);
assign sb_cmp_addr = {m1_addr[PALEN - 1:GRN_LSB],{GRN_LSB{1'b0}}};
kv_mux #(
    .N(4),
    .W(32)
) u_m1_fil_bypass_data (
    .out(m1_fil_bypass_data),
    .sel(sb_cmp_addr[GRN_LSB +:2]),
    .in(sb_fil_beat_data)
);
assign m1_hit_cmt = (sb_cmt_valid & ~sb_cmt_kill & sb_cmp_hit & (sb_cmt_ptr == sb_cmp_hit_ptr)) | (sb_cmt_valid & ~sb_cmt_kill & m1_hit_enq & (sb_cmt_ptr == sb_enq_free_ptr));
assign m1_rmask_cmt = {4{m1_hit_cmt}} & cmt_bypass_wmask;
kv_bit_expand #(
    .N(4),
    .M(8)
) u_m1_rmask_cmt_bit (
    .out(m1_rmask_cmt_bit),
    .in(m1_rmask_cmt)
);
kv_bit_expand #(
    .N(4),
    .M(8)
) u_sb_cmp_rmask_bit (
    .out(sb_cmp_rmask_bit),
    .in(sb_cmp_rmask)
);
assign m1_hit_fil = m2_fil_valid & |(m2_sb_hit_beat_ptr & sb_cmp_hit_ptr) & m2_fil_payload;
assign m1_hit_enq = sb_enq_valid & m1_m2_same_xlen;
assign m1_rmask_fil = {4{m1_hit_fil & ecccfg}};
assign m1_rmask_fil_bit = {32{m1_hit_fil & ecccfg}};
assign m1_rdata_fil = ~m1_rmask_cmt_bit & m1_rmask_fil_bit & ~sb_cmp_rmask_bit & m1_fil_bypass_data;
assign m1_rdata_cmt = m1_rmask_cmt_bit & sb_cmt_wdata;
assign m1_sb_rmask = (sb_cmp_rmask | m1_rmask_fil | m1_rmask_cmt) & ~{4{m1_ix_rdata}};
assign m1_sb_rdata = (sb_cmp_rdata & ~m1_rmask_cmt_bit & sb_cmp_rmask_bit) | m1_rdata_fil | m1_rdata_cmt;
assign m0_sb_read_lsu = dcu_func_read | dcu_func_rmw;
assign m0_sb_write_lsu = dcu_func_write;
assign sb_full_final = sb_full | (sb_afull & m1_sb_valid & m1_sb_write);
assign sb_req_hit_line = m2_sb_hit_line_ptr;
assign sb_req_hit_beat = m2_sb_hit_beat_ptr;
assign sb_fil_valid = m2_fil_valid;
assign sb_fil_last = m2_fil_last;
assign sb_fil_mesi = m2_fil_mesi;
assign sb_fil_fault = m2_fil_fault;
assign sb_fil_payload = m2_fil_payload;
assign sb_evt_valid = m2_evt_valid;
assign sb_evt_exclusive = m2_evt_exclusive;
assign sb_probe_valid = m2_probe_valid & ~m2_probe_nullify;
assign sb_probe_2n = m2_cap2n;
assign sb_probe_2b = m2_cap2b;
assign sb_enq_valid = m2_lsu_valid & m2_write & ~m2_defer & ~m2_sc_retry;
assign sb_enq_mrg = m2_sb_hit;
assign sb_enq_mrg_ptr = m2_sb_hit_ptr;
assign sb_enq_spec = ~dcu_cmt_valid | cmt_fifo_rvalid;
assign sb_enq_addr = {m2_addr[PALEN - 1:GRN_LSB],{GRN_LSB{1'b0}}};
assign sb_enq_way = m2_lsu_way;
assign sb_enq_rmw = m2_rmw & ~m2_nullify;
assign sb_enq_rmwdata = m2_rdata;
assign sb_enq_mesi = m2_mshr_hit ? m2_mshr_hit_mesi : m2_tag_corrdata[2:0];
assign sb_cmt_kill = sb_cmt_kill0 | (sb_cmt_kill1 & sb_cmt_kill1_en);
assign sb_cmt_kill0 = dcu_cmt_kill | ~dcu_cmt_write | (cmt_miss & cmt_na) | cmt_sc_retry | (cmt_fifo_rvalid & cmt_fifo_null);
assign sb_cmt_kill1_en = ~cmt_fifo_rvalid;
assign sb_cmt_kill1 = m2_nullify;
assign sb_cmt_valid = dcu_cmt_valid;
assign sb_cmt_ptr = cmt_sb_ptr;
assign sb_cmt_miss = cmt_miss;
assign sb_cmt_wmask = dcu_cmt_wmask;
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_sb_cmt_wdata_ecc
        wire [31:0] cmt_fifo_rmw_data;
        wire [31:0] cmt_rmw_data;
        wire [31:0] dcu_cmt_wmask_bit;
        wire nds_unused_cmt_fifo_wready;
        wire nds_unused_cmt_fifo_rvalid;
        kv_fifo #(
            .DEPTH(2),
            .WIDTH(32)
        ) u_cmt_fifo_rmw_data (
            .clk(dcu_clk),
            .reset_n(dcu_reset_n),
            .flush(1'b0),
            .wdata(m2_rdata),
            .wvalid(cmt_fifo_wvalid),
            .wready(nds_unused_cmt_fifo_wready),
            .rdata(cmt_fifo_rmw_data),
            .rvalid(nds_unused_cmt_fifo_rvalid),
            .rready(dcu_cmt_valid)
        );
        assign cmt_rmw_data = cmt_fifo_rvalid ? cmt_fifo_rmw_data : m2_rdata;
        kv_bit_expand #(
            .N(4),
            .M(8)
        ) u_dcu_cmt_wmask_bit (
            .out(dcu_cmt_wmask_bit),
            .in(dcu_cmt_wmask)
        );
        assign sb_cmt_wdata = (dcu_cmt_wdata & dcu_cmt_wmask_bit) | (cmt_rmw_data & ~dcu_cmt_wmask_bit);
        assign cmt_bypass_wmask = cmt_miss ? dcu_cmt_wmask : {4{1'b1}};
    end
    else begin:gen_sb_cmt_wdata_stub
        assign sb_cmt_wdata = dcu_cmt_wdata;
        assign cmt_bypass_wmask = dcu_cmt_wmask;
    end
endgenerate
assign sb_fil_beat_data = m2_beat_data;
generate
    if (PERFORMANCE_MONITOR_INT == 1) begin:gen_dcu_events
        reg [6:0] reg_dcu_event;
        wire [6:0] reg_dcu_event_nx;
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                reg_dcu_event <= {7{1'b0}};
            end
            else begin
                reg_dcu_event <= reg_dcu_event_nx;
            end
        end

        assign reg_dcu_event_nx[0] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch;
        assign reg_dcu_event_nx[1] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch & cmt_miss & ~cmt_mshr_hit;
        assign reg_dcu_event_nx[2] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch & dcu_cmt_read;
        assign reg_dcu_event_nx[3] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch & dcu_cmt_read & cmt_miss & ~cmt_mshr_hit;
        assign reg_dcu_event_nx[4] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch & dcu_cmt_write;
        assign reg_dcu_event_nx[5] = dcu_cmt_valid & ~dcu_cmt_kill & ~cmt_null & ~cmt_prefetch & dcu_cmt_write & cmt_miss & ~cmt_mshr_hit;
        assign reg_dcu_event_nx[6] = (evb_enq_valid & evb_enq_func[0] & evb_enq_state[TAG_M]) | (evb_enq_valid & evb_enq_func[1] & evb_enq_state[TAG_M]);
        assign dcu_event = reg_dcu_event;
    end
    else begin:gen_dcu_event_stub
        assign dcu_event = {7{1'b0}};
    end
endgenerate
assign wa_cmt_valid = dcu_cmt_valid;
assign wa_cmt_kill = dcu_cmt_kill | cmt_null;
assign wa_cmt_addr = dcu_cmt_addr;
assign wa_cmt_wmask = dcu_cmt_wmask;
assign wa_cmt_func[0] = cmt_miss;
assign wa_cmt_func[1] = dcu_cmt_read;
assign wa_cmt_func[2] = dcu_cmt_write;
assign wpt_req_valid = (tag_arb_grant[TAG_ARB_MANT]) | (tag_arb_grant[TAG_ARB_LSU] & ~dcu_req_stall) | (tag_arb_grant[TAG_ARB_FIL]) | (tag_arb_grant[TAG_ARB_PROBE]);
assign wpt_req_we = tag_arb_grant[TAG_ARB_FIL] & fil_payload & fil_last;
assign wpt_req_addr = m0_addr;
assign wpt_req_data = fil_l2_ways;
assign fil_req_grant = tag_arb_grant[TAG_ARB_FIL];
assign fil_data0_addr = ({DCACHE_DATA_RAM_AW{way1}} & fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 0]) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[2]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[3]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1});
assign fil_data1_addr = ({DCACHE_DATA_RAM_AW{way1}} & fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 0]) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[2]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[3]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2});
assign fil_data2_addr = ({DCACHE_DATA_RAM_AW{way1}} & fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 0]) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[2]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[3]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3});
assign fil_data3_addr = ({DCACHE_DATA_RAM_AW{way1}} & fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 0]) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way2 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[0]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[1]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[2]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & fil_data_way[3]}} & {fil_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0});
assign fil_ready = tag_arb_ready[TAG_ARB_FIL];
assign evb_cmp_addr = {m1_addr[PALEN - 1:IDX_LSB],{IDX_LSB{1'b0}}};
assign m1_evb_hit_enq = (evb_enq_valid & (evb_enq_addr[PALEN - 1:IDX_LSB] == evb_cmp_addr[PALEN - 1:IDX_LSB]));
assign m1_evb_hit_ptr = evb_cmp_hit_ptr | ({EVB_DEPTH{m1_evb_hit_enq}} & evb_enq_ptr);
assign m1_evb_hit_speculative = (|(evb_cmp_hit_ptr & evb_cmp_speculative & ~evb_cmt_valid_ptr)) | (m1_evb_hit_enq & m2_lsu_valid & mshr_enq_spec);
assign m1_evb_cft = evb_cmp_cft | ({4{evb_enq_valid & m1_m2_match_idx}} & evb_enq_way);
assign wbf_a0_valid = (m2_lsu_valid & m2_replace & m2_replace_tag[TAG_M]) | (m2_lsu_valid & m2_inval & m2_tag_corrdata[TAG_M]) | (m2_lsu_valid & m2_wb & m2_tag_corrdata[TAG_M]) | (m2_lsu_valid & m2_wbinval & m2_tag_corrdata[TAG_M]) | (m2_mant_valid & m2_inval & m2_tag_corrdata[TAG_M]) | (m2_mant_valid & m2_wb & m2_tag_corrdata[TAG_M]) | (m2_mant_valid & m2_wbinval & m2_tag_corrdata[TAG_M]) | (m2_probe_valid & m2_probeblock & m2_tag_corrdata[TAG_M]);
assign wbf_a0_kill = (m2_lsu_valid & m2_nullify) | (m2_mant_valid & m2_fault) | (m2_mant_valid & m2_mant_defer_wbf) | (m2_probe_valid & m2_probe_defer) | (m2_probe_valid & ~evb_enq_ready) | (m2_probe_valid & m2_evb_hit);
assign evb_enq_valid = (m2_lsu_valid & ~m2_nullify & m2_replace) | (m2_lsu_valid & ~m2_nullify & m2_inval & m2_tag_corrdata[TAG_S]) | (m2_lsu_valid & ~m2_nullify & m2_wb & m2_tag_corrdata[TAG_M]) | (m2_lsu_valid & ~m2_nullify & m2_wbinval & m2_tag_corrdata[TAG_S]) | (m2_mant_valid & ~m2_mant_defer_evb & ~m2_fault & m2_inval & m2_tag_corrdata[TAG_S]) | (m2_mant_valid & ~m2_mant_defer_evb & ~m2_fault & m2_wb & m2_tag_corrdata[TAG_M]) | (m2_mant_valid & ~m2_mant_defer_evb & ~m2_fault & m2_wbinval & m2_tag_corrdata[TAG_M]) | (m2_mant_valid & ~m2_mant_defer_evb & ~m2_fault & m2_wbinval & ~m2_tag_corrdata[TAG_M] & m2_tag_corrdata[TAG_S]) | (m2_lsu_valid & ~m2_defer & m2_data_error2 & ~m2_tag_corrdata[TAG_M] & m2_tag_corrdata[TAG_S]) | (m2_probe_valid & ~m2_probe_defer & ~m2_evb_hit);
assign evb_enq_spec = m2_lsu_valid;
assign evb_enq_eccen = m2_eccen;
assign evb_enq_addr[IDX_LSB - 1:0] = {IDX_LSB{1'b0}};
assign evb_enq_addr[IDX_MSB:IDX_LSB] = m2_addr[IDX_MSB:IDX_LSB];
assign evb_enq_addr[PALEN - 1:TAG_LSB] = m2_probe_valid ? m2_addr[PALEN - 1:IDX_MSB + 1] : m2_mant_valid ? m2_tag_corrdata[TAG_RAM_DW - 1:4] : m2_hit ? m2_tag_corrdata[TAG_RAM_DW - 1:4] : m2_replace_tag_corrdata[TAG_RAM_DW - 1:4];
assign evb_enq_state = m2_probe_valid ? m2_tag_corrdata[3:0] : m2_mant_valid ? m2_tag_corrdata[3:0] : m2_hit ? m2_tag_corrdata[3:0] : m2_replace_tag_corrdata[3:0];
assign evb_enq_way = m2_probe_valid ? m2_way : m2_mant_valid ? m2_way : m2_hit ? m2_way : m2_replace_way;
assign evb_enq_source = m2_source;
assign evb_enq_wbf = wbf_a0_index;
assign evb_func_lsu[0] = m2_wb;
assign evb_func_lsu[1] = m2_replace | m2_wbinval;
assign evb_func_lsu[2] = m2_inval | m2_data_error2;
assign evb_func_lsu[3] = 1'b0;
assign evb_func_lsu[4] = m2_wb | m2_wbinval | m2_inval;
assign evb_func_lsu[5] = 1'b0;
assign evb_func_mant[0] = m2_wb;
assign evb_func_mant[1] = m2_wbinval;
assign evb_func_mant[2] = m2_inval;
assign evb_func_mant[3] = 1'b1;
assign evb_func_mant[4] = 1'b0;
assign evb_func_mant[5] = 1'b0;
assign evb_func_probe[0] = 1'b0;
assign evb_func_probe[1] = 1'b0;
assign evb_func_probe[2] = 1'b0;
assign evb_func_probe[3] = 1'b0;
assign evb_func_probe[4] = 1'b0;
assign evb_func_probe[5] = 1'b1;
assign evb_enq_func = ({6{m2_lsu_valid}} & evb_func_lsu) | ({6{m2_mant_valid}} & evb_func_mant) | ({6{m2_probe_valid}} & evb_func_probe);
assign evb_probe_func[0] = m2_cap2n | m2_evb_hit;
assign evb_probe_func[1] = m2_cap2b & ~m2_evb_hit;
assign evb_probe_func[2] = m2_cap2t & ~m2_evb_hit;
assign evb_probe_func[3] = m2_probeblock;
assign evb_cmt_valid = dcu_cmt_valid & cmt_evb_enq;
assign evb_cmt_kill = cmt_evb_kill | dcu_cmt_kill | (cmt_na & cmt_evb_replace);
assign evb_cmt_ptr = cmt_evb_ptr;
assign evb_mrg_valid = m2_probe_valid & m2_evb_hit & ~m2_probe_defer;
assign evb_mrg_ptr = m2_evb_hit_ptr;
assign evb_cmt_valid_ptr = {EVB_DEPTH{evb_cmt_valid}} & evb_cmt_ptr;
kv_bit_expand #(
    .N(16),
    .M(8)
) u_m2_beat_mask_bit (
    .out(m2_beat_mask_bit),
    .in(m2_beat_mask)
);
assign evt_req_grant = evt_req_valid & evt_req_ready;
assign evt_req_ready = 1'b1;
assign evt_data0_addr = ({DCACHE_DATA_RAM_AW{way1}} & evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW]) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[2]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[3]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1});
assign evt_data1_addr = ({DCACHE_DATA_RAM_AW{way1}} & evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW]) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[2]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[3]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2});
assign evt_data2_addr = ({DCACHE_DATA_RAM_AW{way1}} & evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW]) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[2]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[3]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3});
assign evt_data3_addr = ({DCACHE_DATA_RAM_AW{way1}} & evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW]) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd1}) | ({DCACHE_DATA_RAM_AW{way2 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 1],1'd0}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[0]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd3}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[1]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd2}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[2]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd1}) | ({DCACHE_DATA_RAM_AW{way4 & evt_req_way[3]}} & {evt_req_addr[IDX_MSB -:DCACHE_DATA_RAM_AW - 2],2'd0});
assign evt_ack_valid = m2_evt_valid;
kv_dcu_shuffle #(
    .DCACHE_WAY(DCACHE_WAY),
    .W(32),
    .REVERSE(1)
) u_m2_edata2 (
    .way(m2_evt_way),
    .din({m2_data3_corrdata,m2_data2_corrdata,m2_data1_corrdata,m2_data0_corrdata}),
    .dout(m2_edata)
);
assign evt_ack_rdata = (~m2_beat_mask_bit & m2_edata) | (m2_beat_mask_bit & m2_beat_data);
assign dcu_ack_valid = m2_lsu_valid;
assign dcu_ack_status[3] = m2_hit;
assign dcu_ack_status[0] = m2_defer | m2_sc_retry;
assign dcu_ack_status[1] = m2_corr_error & m2_eccen2;
assign dcu_ack_status[2] = m2_fault | m2_lr_fail;
assign dcu_ack_status[4] = m2_nbload & ~m2_hit;
assign dcu_ack_status[6] = m2_hit | ~m2_replace_locked;
assign dcu_ack_status[7 +:8] = m2_ecc_code;
assign dcu_ack_status[15] = ~m2_uncorr_error;
assign dcu_ack_status[16] = ~m2_tag_error;
assign dcu_ack_status[5] = ~m2_hit & ~m2_mshr_hit;
assign dcu_ack_status[17] = ~m2_sc_fail;
assign dcu_ack_status[18] = m2_fault;
assign dcu_ack_rdata = m2_rdata;
assign dcu_ack_id = m2_id;
assign ctl_idle = ~(m1_lsu_valid | m2_lsu_valid) & mshr_empty & evb_empty & sb_empty;
assign dcu_standby_ready = ctl_idle & mant_idle;
assign dcu_async_write_error = mshr_async_write_error | evb_async_write_error;
assign sb_drain_ready = data_arb_ready[DATA_ARB_DRAIN];
kv_bin2onehot #(
    .N(4)
) u_drain_data_ram_cs (
    .out(drain_data_ram_cs),
    .in(sb_drain_addr[GRN_LSB +:2])
);
assign drain_data0_byte_we = sb_drain_mask;
assign drain_data1_byte_we = sb_drain_mask;
assign drain_data2_byte_we = sb_drain_mask;
assign drain_data3_byte_we = sb_drain_mask;
assign drain_data0_we = |sb_drain_mask;
assign drain_data1_we = |sb_drain_mask;
assign drain_data2_we = |sb_drain_mask;
assign drain_data3_we = |sb_drain_mask;
assign drn_data0_addr = sb_drain_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign drn_data1_addr = sb_drain_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign drn_data2_addr = sb_drain_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign drn_data3_addr = sb_drain_addr[IDX_MSB -:DCACHE_DATA_RAM_AW];
assign tag_arb_valid[TAG_ARB_EVB] = evt_req_valid;
assign tag_arb_valid[TAG_ARB_REPAIR] = repair_valid;
assign tag_arb_valid[TAG_ARB_PROBE] = m0_probe_valid & ~probe_disable;
assign tag_arb_valid[TAG_ARB_FIL] = fil_valid;
assign tag_arb_valid[TAG_ARB_LSU] = m0_lsu_tag_req;
assign tag_arb_valid[TAG_ARB_MANT] = mant_req_valid;
kv_arb_fp #(
    .N(TAG_ARB_BITS)
) u_tag_arb (
    .valid(tag_arb_valid),
    .ready(tag_arb_ready),
    .grant(tag_arb_grant)
);
assign data_arb_valid[DATA_ARB_EVB] = evt_req_valid;
assign data_arb_valid[DATA_ARB_REPAIR] = repair_valid;
assign data_arb_valid[DATA_ARB_MANT] = mant_req_valid;
assign data_arb_valid[DATA_ARB_FIL] = fil_valid;
assign data_arb_valid[DATA_ARB_LSU] = m0_lsu_data_req;
assign data_arb_valid[DATA_ARB_DRAIN] = sb_drain_valid;
kv_arb_fp #(
    .N(DATA_ARB_BITS)
) u_data_arb_grant (
    .valid(data_arb_valid),
    .ready(data_arb_ready),
    .grant(data_arb_grant)
);
assign tag_ram_addr = m0_addr[IDX_MSB:IDX_LSB];
assign tag_ram_wdata_repair[TAG_RAM_DW - 1:0] = tag_repair_corrdata[TAG_RAM_DW - 1:0];
assign tag_ram_wdata_fil[TAG_RAM_DW - 1:0] = {fil_addr[TAG_MSB:TAG_LSB],fil_lock,fil_mesi[2:0]};
assign tag_ram_wdata_evb[TAG_RAM_DW - 1:0] = {evt_req_addr[TAG_MSB:TAG_LSB],evt_req_lock,evt_req_mesi[2:0]};
assign tag_ram_wdata_mant[TAG_RAM_DW - 1:0] = mant_req_wdata[TAG_RAM_DW - 1:0];
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_tag_eccenc
        wire [TAG_RAM_PW - 1:0] parity_fil;
        wire [TAG_RAM_PW - 1:0] parity_repair;
        wire [TAG_RAM_PW - 1:0] parity_evb;
        wire [TAG_RAM_PW - 1:0] parity_mant;
        wire [TAG_RAM_PW - 1:0] parity_rwecc = csr_mecc_code[TAG_RAM_PW - 1:0];
        kv_dcu_eccenc_tag #(
            .DW(TAG_RAM_DW)
        ) u_parity_fil (
            .dataout(parity_fil),
            .data(tag_ram_wdata_fil[TAG_RAM_DW - 1:0])
        );
        kv_dcu_eccenc_tag #(
            .DW(TAG_RAM_DW)
        ) u_parity_repair (
            .dataout(parity_repair),
            .data(tag_ram_wdata_repair[TAG_RAM_DW - 1:0])
        );
        kv_dcu_eccenc_tag #(
            .DW(TAG_RAM_DW)
        ) u_parity_evb (
            .dataout(parity_evb),
            .data(tag_ram_wdata_evb[TAG_RAM_DW - 1:0])
        );
        kv_dcu_eccenc_tag #(
            .DW(TAG_RAM_DW)
        ) u_parity_mant (
            .dataout(parity_mant),
            .data(tag_ram_wdata_mant[TAG_RAM_DW - 1:0])
        );
        kv_mux_onehot #(
            .N(5),
            .W(TAG_RAM_PW)
        ) u_data_ram_wdata_parity (
            .out(tag_ram_wdata[TAG_RAM_DW +:TAG_RAM_PW]),
            .in({parity_rwecc,parity_mant,parity_evb,parity_repair,parity_fil}),
            .sel({tag_arb_grant[TAG_ARB_MANT] & csr_mcache_ctl_dc_rwecc,tag_arb_grant[TAG_ARB_MANT] & ~csr_mcache_ctl_dc_rwecc,tag_arb_grant[TAG_ARB_EVB],tag_arb_grant[TAG_ARB_REPAIR],tag_arb_grant[TAG_ARB_FIL]})
        );
    end
endgenerate
assign tag_ram_wdata[TAG_RAM_DW - 1:0] = ({TAG_RAM_DW{tag_arb_grant[TAG_ARB_FIL]}} & tag_ram_wdata_fil) | ({TAG_RAM_DW{tag_arb_grant[TAG_ARB_EVB]}} & tag_ram_wdata_evb) | ({TAG_RAM_DW{tag_arb_grant[TAG_ARB_MANT]}} & tag_ram_wdata_mant) | ({TAG_RAM_DW{tag_arb_grant[TAG_ARB_REPAIR]}} & tag_ram_wdata_repair);
assign dcache_tag0_cs = (tag_arb_grant[TAG_ARB_MANT] & mant_req_way[0]) | (tag_arb_grant[TAG_ARB_LSU] & ~dcu_req_stall) | (tag_arb_grant[TAG_ARB_FIL] & fil_way[0]) | (tag_arb_grant[TAG_ARB_PROBE]) | (tag_arb_grant[TAG_ARB_REPAIR] & tag_repair_way[0]) | (evt_req_grant & evt_req_way[0]);
assign dcache_tag1_cs = (tag_arb_grant[TAG_ARB_MANT] & mant_req_way[1]) | (tag_arb_grant[TAG_ARB_LSU] & ~dcu_req_stall) | (tag_arb_grant[TAG_ARB_FIL] & fil_way[1]) | (tag_arb_grant[TAG_ARB_PROBE]) | (tag_arb_grant[TAG_ARB_REPAIR] & tag_repair_way[1]) | (evt_req_grant & evt_req_way[1]);
assign dcache_tag2_cs = (tag_arb_grant[TAG_ARB_MANT] & mant_req_way[2]) | (tag_arb_grant[TAG_ARB_LSU] & ~dcu_req_stall) | (tag_arb_grant[TAG_ARB_FIL] & fil_way[2]) | (tag_arb_grant[TAG_ARB_PROBE]) | (tag_arb_grant[TAG_ARB_REPAIR] & tag_repair_way[2]) | (evt_req_grant & evt_req_way[2]);
assign dcache_tag3_cs = (tag_arb_grant[TAG_ARB_MANT] & mant_req_way[3]) | (tag_arb_grant[TAG_ARB_LSU] & ~dcu_req_stall) | (tag_arb_grant[TAG_ARB_FIL] & fil_way[3]) | (tag_arb_grant[TAG_ARB_PROBE]) | (tag_arb_grant[TAG_ARB_REPAIR] & tag_repair_way[3]) | (evt_req_grant & evt_req_way[3]);
assign tag_ram_mant_we = m0_mant_wtag;
assign tag_ram_fil_we = fil_last;
assign tag_ram_evb_we = 1'b1;
assign tag_ram_we = (tag_arb_grant[TAG_ARB_MANT] & tag_ram_mant_we) | (tag_arb_grant[TAG_ARB_EVB] & tag_ram_evb_we) | (tag_arb_grant[TAG_ARB_FIL] & tag_ram_fil_we) | (tag_arb_grant[TAG_ARB_REPAIR]);
assign dcache_tag0_we = tag_ram_we;
assign dcache_tag0_addr = tag_ram_addr;
assign dcache_tag0_wdata = tag_ram_wdata;
assign dcache_tag1_we = tag_ram_we;
assign dcache_tag1_addr = tag_ram_addr;
assign dcache_tag1_wdata = tag_ram_wdata;
assign dcache_tag2_we = tag_ram_we;
assign dcache_tag2_addr = tag_ram_addr;
assign dcache_tag2_wdata = tag_ram_wdata;
assign dcache_tag3_we = tag_ram_we;
assign dcache_tag3_addr = tag_ram_addr;
assign dcache_tag3_wdata = tag_ram_wdata;
assign dcache_data0_addr = ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_EVB]}} & evt_data0_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_FIL]}} & fil_data0_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_LSU]}} & lsu_data0_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_MANT]}} & man_data0_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_DRAIN]}} & drn_data0_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_REPAIR]}} & rep_data0_addr);
assign dcache_data1_addr = ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_EVB]}} & evt_data1_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_FIL]}} & fil_data1_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_LSU]}} & lsu_data1_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_MANT]}} & man_data1_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_DRAIN]}} & drn_data1_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_REPAIR]}} & rep_data1_addr);
assign dcache_data2_addr = ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_EVB]}} & evt_data2_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_FIL]}} & fil_data2_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_LSU]}} & lsu_data2_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_MANT]}} & man_data2_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_DRAIN]}} & drn_data2_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_REPAIR]}} & rep_data2_addr);
assign dcache_data3_addr = ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_EVB]}} & evt_data3_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_FIL]}} & fil_data3_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_LSU]}} & lsu_data3_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_MANT]}} & man_data3_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_DRAIN]}} & drn_data3_addr) | ({DCACHE_DATA_RAM_AW{data_arb_grant[DATA_ARB_REPAIR]}} & rep_data3_addr);
wire fil_data_ram_cs = fil_valid & fil_payload;
kv_dcu_shuffle #(
    .DCACHE_WAY(DCACHE_WAY),
    .W(33)
) u_fil_shuffle (
    .way(fil_data_way),
    .din({fil_data_ram_cs,fil_wdata[96 +:32],fil_data_ram_cs,fil_wdata[64 +:32],fil_data_ram_cs,fil_wdata[32 +:32],fil_data_ram_cs,fil_wdata[0 +:32]}),
    .dout({fil_data3_cs,fil_data3_wdata,fil_data2_cs,fil_data2_wdata,fil_data1_cs,fil_data1_wdata,fil_data0_cs,fil_data0_wdata})
);
assign fil_data0_byte_we = {4{1'b1}};
assign fil_data1_byte_we = {4{1'b1}};
assign fil_data2_byte_we = {4{1'b1}};
assign fil_data3_byte_we = {4{1'b1}};
assign fil_data0_we = 1'b1;
assign fil_data1_we = 1'b1;
assign fil_data2_we = 1'b1;
assign fil_data3_we = 1'b1;
kv_dcu_shuffle #(
    .DCACHE_WAY(DCACHE_WAY),
    .W(33)
) u_drain_shuffle (
    .way(sb_drain_way),
    .din({drain_data_ram_cs[3],sb_drain_data,drain_data_ram_cs[2],sb_drain_data,drain_data_ram_cs[1],sb_drain_data,drain_data_ram_cs[0],sb_drain_data}),
    .dout({drain_data3_cs,drain_data3_wdata,drain_data2_cs,drain_data2_wdata,drain_data1_cs,drain_data1_wdata,drain_data0_cs,drain_data0_wdata})
);
kv_dcu_shuffle #(
    .DCACHE_WAY(DCACHE_WAY),
    .W(33)
) u_mant_shuffle (
    .way(mant_req_way),
    .din({mant_data_ram_cs[3],mant_req_wdata,mant_data_ram_cs[2],mant_req_wdata,mant_data_ram_cs[1],mant_req_wdata,mant_data_ram_cs[0],mant_req_wdata}),
    .dout({mant_data3_cs,mant_data3_wdata,mant_data2_cs,mant_data2_wdata,mant_data1_cs,mant_data1_wdata,mant_data0_cs,mant_data0_wdata})
);
wire lsu_data0_cs = dcu_req_ready & ~dcu_req_stall;
wire lsu_data1_cs = dcu_req_ready & ~dcu_req_stall;
wire lsu_data2_cs = dcu_req_ready & ~dcu_req_stall;
wire lsu_data3_cs = dcu_req_ready & ~dcu_req_stall;
wire evb_data0_cs = evt_req_data;
wire evb_data1_cs = evt_req_data;
wire evb_data2_cs = evt_req_data;
wire evb_data3_cs = evt_req_data;
kv_mux_onehot #(
    .N(6),
    .W(4)
) u_data_ram_cs (
    .out({dcache_data3_cs,dcache_data2_cs,dcache_data1_cs,dcache_data0_cs}),
    .in({mant_data3_cs,mant_data2_cs,mant_data1_cs,mant_data0_cs,rep_data3_cs,rep_data2_cs,rep_data1_cs,rep_data0_cs,drain_data3_cs,drain_data2_cs,drain_data1_cs,drain_data0_cs,lsu_data3_cs,lsu_data2_cs,lsu_data1_cs,lsu_data0_cs,fil_data3_cs,fil_data2_cs,fil_data1_cs,fil_data0_cs,evb_data3_cs,evb_data2_cs,evb_data1_cs,evb_data0_cs}),
    .sel({data_arb_grant[DATA_ARB_MANT],data_arb_grant[DATA_ARB_REPAIR],data_arb_grant[DATA_ARB_DRAIN],data_arb_grant[DATA_ARB_LSU],data_arb_grant[DATA_ARB_FIL],data_arb_grant[DATA_ARB_EVB]})
);
kv_mux_onehot #(
    .N(4),
    .W(16)
) u_data_ram_byte_we (
    .out({dcache_data3_byte_we,dcache_data2_byte_we,dcache_data1_byte_we,dcache_data0_byte_we}),
    .in({mant_data3_byte_we,mant_data2_byte_we,mant_data1_byte_we,mant_data0_byte_we,rep_data3_byte_we,rep_data2_byte_we,rep_data1_byte_we,rep_data0_byte_we,drain_data3_byte_we,drain_data2_byte_we,drain_data1_byte_we,drain_data0_byte_we,fil_data3_byte_we,fil_data2_byte_we,fil_data1_byte_we,fil_data0_byte_we}),
    .sel({data_arb_grant[DATA_ARB_MANT],data_arb_grant[DATA_ARB_REPAIR],data_arb_grant[DATA_ARB_DRAIN],data_arb_grant[DATA_ARB_FIL]})
);
kv_mux_onehot #(
    .N(4),
    .W(4)
) u_data_ram_we (
    .out({dcache_data3_we,dcache_data2_we,dcache_data1_we,dcache_data0_we}),
    .in({mant_data3_we,mant_data2_we,mant_data1_we,mant_data0_we,rep_data3_we,rep_data2_we,rep_data1_we,rep_data0_we,drain_data3_we,drain_data2_we,drain_data1_we,drain_data0_we,fil_data3_we,fil_data2_we,fil_data1_we,fil_data0_we}),
    .sel({data_arb_grant[DATA_ARB_MANT],data_arb_grant[DATA_ARB_REPAIR],data_arb_grant[DATA_ARB_DRAIN],data_arb_grant[DATA_ARB_FIL]})
);
kv_mux_onehot #(
    .N(4),
    .W(128)
) u_data_ram_wdata (
    .out({dcache_data3_wdata[31:0],dcache_data2_wdata[31:0],dcache_data1_wdata[31:0],dcache_data0_wdata[31:0]}),
    .in({mant_data3_wdata,mant_data2_wdata,mant_data1_wdata,mant_data0_wdata,rep_data3_wdata,rep_data2_wdata,rep_data1_wdata,rep_data0_wdata,drain_data3_wdata,drain_data2_wdata,drain_data1_wdata,drain_data0_wdata,fil_data3_wdata,fil_data2_wdata,fil_data1_wdata,fil_data0_wdata}),
    .sel({data_arb_grant[DATA_ARB_MANT],data_arb_grant[DATA_ARB_REPAIR],data_arb_grant[DATA_ARB_DRAIN],data_arb_grant[DATA_ARB_FIL]})
);
generate
    if (DCACHE_ECC_TYPE_INT == 2) begin:gen_data_eccenc
        wire [DATA_RAM_PW - 1:0] data0_parity;
        wire [DATA_RAM_PW - 1:0] data1_parity;
        wire [DATA_RAM_PW - 1:0] data2_parity;
        wire [DATA_RAM_PW - 1:0] data3_parity;
        wire [DATA_RAM_PW - 1:0] fil_data0_parity;
        wire [DATA_RAM_PW - 1:0] fil_data1_parity;
        wire [DATA_RAM_PW - 1:0] fil_data2_parity;
        wire [DATA_RAM_PW - 1:0] fil_data3_parity;
        wire [DATA_RAM_PW - 1:0] fil_wdata0_parity;
        wire [DATA_RAM_PW - 1:0] fil_wdata1_parity;
        wire [DATA_RAM_PW - 1:0] fil_wdata2_parity;
        wire [DATA_RAM_PW - 1:0] fil_wdata3_parity;
        wire [DATA_RAM_PW - 1:0] mant_parity;
        wire [DATA_RAM_PW - 1:0] drain_parity;
        wire [DATA_RAM_PW - 1:0] rep_parity;
        wire [DATA_RAM_PW - 1:0] rwecc_parity = csr_mecc_code[DATA_RAM_PW - 1:0];
        kv_dcu_shuffle #(
            .DCACHE_WAY(DCACHE_WAY),
            .W(DATA_RAM_PW)
        ) u_fil_shuffle (
            .way(fil_data_way),
            .din({fil_wdata3_parity,fil_wdata2_parity,fil_wdata1_parity,fil_wdata0_parity}),
            .dout({fil_data3_parity,fil_data2_parity,fil_data1_parity,fil_data0_parity})
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_data0_parity_fil (
            .data(fil_wdata[0 +:32]),
            .dataout(fil_wdata0_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_data1_parity_fil (
            .data(fil_wdata[32 +:32]),
            .dataout(fil_wdata1_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_data2_parity_fil (
            .data(fil_wdata[64 +:32]),
            .dataout(fil_wdata2_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_data3_parity_fil (
            .data(fil_wdata[96 +:32]),
            .dataout(fil_wdata3_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_parity_mant (
            .data(mant_req_wdata),
            .dataout(mant_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_parity_drain (
            .data(sb_drain_data),
            .dataout(drain_parity)
        );
        kv_dcu_eccenc_data #(
            .DW(32)
        ) u_parity_rep (
            .data(data_repair_corrdata),
            .dataout(rep_parity)
        );
        kv_mux_onehot #(
            .N(5),
            .W(DATA_RAM_PW * 4)
        ) u_data_ram_wdata (
            .out({data3_parity,data2_parity,data1_parity,data0_parity}),
            .in({rwecc_parity,rwecc_parity,rwecc_parity,rwecc_parity,mant_parity,mant_parity,mant_parity,mant_parity,drain_parity,drain_parity,drain_parity,drain_parity,rep_parity,rep_parity,rep_parity,rep_parity,fil_data3_parity,fil_data2_parity,fil_data1_parity,fil_data0_parity}),
            .sel({data_arb_grant[DATA_ARB_MANT] & csr_mcache_ctl_dc_rwecc,data_arb_grant[DATA_ARB_MANT] & ~csr_mcache_ctl_dc_rwecc,data_arb_grant[DATA_ARB_DRAIN],data_arb_grant[DATA_ARB_REPAIR],data_arb_grant[DATA_ARB_FIL]})
        );
        assign dcache_data0_wdata[32 +:DATA_RAM_PW] = data0_parity;
        assign dcache_data1_wdata[32 +:DATA_RAM_PW] = data1_parity;
        assign dcache_data2_wdata[32 +:DATA_RAM_PW] = data2_parity;
        assign dcache_data3_wdata[32 +:DATA_RAM_PW] = data3_parity;
    end
endgenerate
kv_zero_ext #(
    .OW(32),
    .IW(TAG_RAM_DW)
) u_m2_mant_tag_codeword_ze (
    .out(m2_mant_tag_codeword_ze),
    .in(m2_tag_codeword)
);
assign mant_ack_valid = m2_mant_valid;
assign mant_ack_rdata = ({32{m2_func[18]}} & m2_ram_rdata) | ({32{m2_func[20]}} & m2_mant_tag_codeword_ze);
assign mant_ack_parity = ({8{m2_func[18]}} & m2_mant_data_parity_ze) | ({8{m2_func[20]}} & m2_mant_tag_parity_ze);
assign mant_ack_defer = m2_mant_defer0 | m2_mant_defer1 | m2_mant_defer2;
assign mant_ack_status[0] = m2_fault & m2_release;
assign mant_ack_status[1 +:8] = mant_ack_parity;
assign mant_ack_status[9] = m2_corr_error;
assign mant_ack_status[10] = ~m2_tag_error;
assign mant_ack_status[11] = csr_mcache_ctl_dc_rwecc & (m2_ix_rdata | m2_ix_rtag);
assign mant_req_ready = tag_arb_ready[TAG_ARB_MANT];
kv_bin2onehot #(
    .N(4)
) u_mant_data_ram_cs (
    .out(mant_data_ram_cs),
    .in(mant_req_addr[GRN_LSB +:2])
);
assign mant_data0_byte_we = {4{m0_mant_wdata}};
assign mant_data1_byte_we = {4{m0_mant_wdata}};
assign mant_data2_byte_we = {4{m0_mant_wdata}};
assign mant_data3_byte_we = {4{m0_mant_wdata}};
assign mant_data0_we = m0_mant_wdata;
assign mant_data1_we = m0_mant_wdata;
assign mant_data2_we = m0_mant_wdata;
assign mant_data3_we = m0_mant_wdata;
assign probe_req_grant = tag_arb_grant[TAG_ARB_PROBE];
assign probe_req_ready = tag_arb_ready[TAG_ARB_PROBE] & ~probe_disable;
assign m0_probe_valid = cm_en & probe_req_valid;
assign m0_probe_grant = m0_probe_valid & probe_req_ready;
assign probe_ack_valid = m2_probe_valid;
assign probe_ack_status[0] = m2_probe_nullify;
assign m2_probe_nullify = m2_probe_defer | (~evb_enq_ready & ~m2_evb_hit);
assign probe_ack_status[1] = m2_corr_error & m2_eccen2;
assign m2_hit_pending_sb = |(m2_sb_hit_line_ptr & sb_pending);
assign m2_probe_defer = (m2_evb_hit & ~m2_evb_hit_speculative) | (m2_mshr_hit & m2_mshr_hit_changing) | (m2_corr_error & m2_eccen2) | (m2_tag_corrdata[TAG_M] & ~wbf_a0_ready) | repair_valid | m2_tag_error1 | (m2_hit_pending_sb & m2_tag_corrdata[TAG_M]);
assign lru_req_valid = m1_lsu_valid;
assign lru_req_idx = m1_addr[IDX_MSB:IDX_LSB];
assign lru_cmt_kill = cmt_null | cmt_halt | (cmt_miss & cmt_na) | dcu_cmt_kill;
assign lru_cmt_valid = dcu_cmt_valid & (dcu_cmt_read | dcu_cmt_write) & ~lru_cmt_kill;
assign lru_cmt_idx = dcu_cmt_addr[IDX_MSB:IDX_LSB];
assign lru_cmt_way = cmt_way;
generate
    if (CM_SUPPORT_INT == 1) begin:gen_m2_sc_fail
        reg reserve_valid;
        wire reserve_valid_nx;
        wire reserve_valid_set;
        wire reserve_valid_clr;
        reg m1_fil_reserve;
        wire m2_exclusive;
        reg m2_fil_reserve;
        wire m2_sc_scuccess;
        reg [5:0] probe_disable_cnt;
        wire [5:0] probe_disable_cnt_nx;
        wire [5:0] probe_disable_cnt_sub_one = probe_disable_cnt - 6'd1;
        wire probe_disable_cnt_en;
        wire m2_committed = ~cmt_fifo_rvalid & dcu_cmt_valid & ~dcu_cmt_kill;
        assign m2_exclusive = m2_tag_codeword[TAG_E];
        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                reserve_valid <= 1'b0;
            end
            else begin
                reserve_valid <= reserve_valid_nx;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                m1_fil_reserve <= 1'b0;
            end
            else if (m1_ctrl_en) begin
                m1_fil_reserve <= fil_reserve;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                probe_disable_cnt <= 6'd0;
            end
            else if (probe_disable_cnt_en) begin
                probe_disable_cnt <= probe_disable_cnt_nx;
            end
        end

        always @(posedge dcu_clk or negedge dcu_reset_n) begin
            if (!dcu_reset_n) begin
                m2_fil_reserve <= 1'd0;
            end
            else if (m2_fil_en) begin
                m2_fil_reserve <= m1_fil_reserve;
            end
        end

        assign reserve_valid_nx = reserve_valid_set | (~reserve_valid_clr & reserve_valid);
        assign reserve_valid_set = (m2_lsu_valid & m2_lr & m2_hit & ~m2_nullify & m2_committed) | (m2_fil_valid & m2_fil_reserve);
        assign reserve_valid_clr = (m2_probe_valid & m2_cap2n & m2_tag_corrdata[TAG_S]) | m2_sc_scuccess | tb_reserve_valid_clr;
        assign m2_sc_scuccess = m2_lsu_valid & m2_sc & m2_exclusive & ~m2_nullify & m2_committed;
        assign m2_sc_retry = m2_sc & reserve_valid & m2_hit & ~m2_exclusive;
        assign m2_sc_fail = m2_sc & ~(reserve_valid & m2_hit);
        assign probe_disable_cnt_en = probe_disable | (fil_req_grant & fil_exclusive) | m2_sc_scuccess;
        assign probe_disable_cnt_nx = m2_sc_scuccess ? 6'd0 : (fil_req_grant & fil_exclusive & ~probe_disable) ? {6{1'b1}} : probe_disable_cnt_sub_one;
        assign probe_disable = |probe_disable_cnt;
        assign m2_lr_fail = m2_lr & m2_replace_locked & ~m2_hit;
    end
    else begin:gen_m2_sc_fail_stub
        assign m2_sc_retry = 1'b0;
        assign m2_sc_fail = 1'b0;
        assign m2_lr_fail = 1'b0;
        assign probe_disable = 1'b1;
    end
endgenerate
wire nds_unused_signals = |{csr_mecc_code,fil_reserve,mshr_cmp_tagw,m2_lr,m2_sc,m2_sb_rdata_valid,m2_tag_repair_way,cmt_prefetch,fil_exclusive,linemask,cmt_linemask};
endmodule

