// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module a45_core (
    lm_local_int,
    lm_clk,
    bus_clk_en,
    araddr,
    arburst,
    arcache,
    arid,
    arlen,
    arlock,
    arprot,
    arready,
    arsize,
    arvalid,
    awaddr,
    awburst,
    awcache,
    awid,
    awlen,
    awlock,
    awprot,
    awready,
    awsize,
    awvalid,
    bid,
    bready,
    bresp,
    bvalid,
    rdata,
    rid,
    rlast,
    rready,
    rresp,
    rvalid,
    wdata,
    wlast,
    wready,
    wstrb,
    wvalid,
    ilm0_addr,
    ilm0_byte_we,
    ilm0_cs,
    ilm0_rdata,
    ilm0_user,
    ilm0_wdata,
    ilm0_we,
    ilm1_addr,
    ilm1_byte_we,
    ilm1_cs,
    ilm1_rdata,
    ilm1_user,
    ilm1_wdata,
    ilm1_we,
    dlm_addr,
    dlm_byte_we,
    dlm_cs,
    dlm_rdata,
    dlm_user,
    dlm_wdata,
    dlm_we,
    btb0_addr,
    btb0_cs,
    btb0_rdata,
    btb0_wdata,
    btb0_we,
    btb1_addr,
    btb1_cs,
    btb1_rdata,
    btb1_wdata,
    btb1_we,
    icache_disable_init,
    icache_data0_cs,
    icache_data0_we,
    icache_data0_addr,
    icache_data0_wdata,
    icache_data0_rdata,
    icache_data1_cs,
    icache_data1_we,
    icache_data1_addr,
    icache_data1_wdata,
    icache_data1_rdata,
    icache_data2_cs,
    icache_data2_we,
    icache_data2_addr,
    icache_data2_wdata,
    icache_data2_rdata,
    icache_data3_cs,
    icache_data3_we,
    icache_data3_addr,
    icache_data3_wdata,
    icache_data3_rdata,
    icache_data4_cs,
    icache_data4_we,
    icache_data4_addr,
    icache_data4_wdata,
    icache_data4_rdata,
    icache_data5_cs,
    icache_data5_we,
    icache_data5_addr,
    icache_data5_wdata,
    icache_data5_rdata,
    icache_data6_cs,
    icache_data6_we,
    icache_data6_addr,
    icache_data6_wdata,
    icache_data6_rdata,
    icache_data7_cs,
    icache_data7_we,
    icache_data7_addr,
    icache_data7_wdata,
    icache_data7_rdata,
    icache_tag0_cs,
    icache_tag0_we,
    icache_tag0_addr,
    icache_tag0_wdata,
    icache_tag0_rdata,
    icache_tag1_cs,
    icache_tag1_we,
    icache_tag1_addr,
    icache_tag1_wdata,
    icache_tag1_rdata,
    icache_tag2_cs,
    icache_tag2_we,
    icache_tag2_addr,
    icache_tag2_wdata,
    icache_tag2_rdata,
    icache_tag3_cs,
    icache_tag3_we,
    icache_tag3_addr,
    icache_tag3_wdata,
    icache_tag3_rdata,
    dcache_disable_init,
    dcache_data0_cs,
    dcache_data0_we,
    dcache_data0_byte_we,
    dcache_data0_addr,
    dcache_data0_wdata,
    dcache_data0_rdata,
    dcache_tag0_cs,
    dcache_tag0_we,
    dcache_tag0_addr,
    dcache_tag0_wdata,
    dcache_tag0_rdata,
    dcache_data1_cs,
    dcache_data1_we,
    dcache_data1_byte_we,
    dcache_data1_addr,
    dcache_data1_wdata,
    dcache_data1_rdata,
    dcache_data2_cs,
    dcache_data2_we,
    dcache_data2_byte_we,
    dcache_data2_addr,
    dcache_data2_wdata,
    dcache_data2_rdata,
    dcache_data3_cs,
    dcache_data3_we,
    dcache_data3_byte_we,
    dcache_data3_addr,
    dcache_data3_wdata,
    dcache_data3_rdata,
    dcache_tag1_cs,
    dcache_tag1_we,
    dcache_tag1_addr,
    dcache_tag1_wdata,
    dcache_tag1_rdata,
    dcache_tag2_cs,
    dcache_tag2_we,
    dcache_tag2_addr,
    dcache_tag2_wdata,
    dcache_tag2_rdata,
    dcache_tag3_cs,
    dcache_tag3_we,
    dcache_tag3_addr,
    dcache_tag3_wdata,
    dcache_tag3_rdata,
    stlb0_addr,
    stlb0_cs,
    stlb0_rdata,
    stlb0_wdata,
    stlb0_we,
    stlb1_addr,
    stlb1_cs,
    stlb1_rdata,
    stlb1_wdata,
    stlb1_we,
    stlb2_addr,
    stlb2_cs,
    stlb2_rdata,
    stlb2_wdata,
    stlb2_we,
    stlb3_addr,
    stlb3_cs,
    stlb3_rdata,
    stlb3_wdata,
    stlb3_we,
    ace_acr_dirty_set,
    ace_cmd_beat,
    ace_cmd_hartid,
    ace_cmd_inst,
    ace_cmd_pc,
    ace_cmd_priv,
    ace_cmd_ready,
    ace_cmd_rs1,
    ace_cmd_rs2,
    ace_cmd_rs3,
    ace_cmd_rs4,
    ace_cmd_valid,
    ace_cmd_vl,
    ace_cmd_vtype,
    ace_error,
    ace_interrupt,
    ace_standby_ready,
    ace_sync_ack,
    ace_sync_ack_status,
    ace_sync_req,
    ace_sync_type,
    ace_xrf_rd1_data,
    ace_xrf_rd1_index,
    ace_xrf_rd1_ready,
    ace_xrf_rd1_status,
    ace_xrf_rd1_valid,
    ace_xrf_rd2_data,
    ace_xrf_rd2_index,
    ace_xrf_rd2_ready,
    ace_xrf_rd2_status,
    ace_xrf_rd2_valid,
    seip,
    seiack,
    seiid,
    ueip,
    ueiack,
    ueiid,
    debugint,
    resethaltreq,
    hart_unavail,
    hart_halted,
    hart_under_reset,
    stoptime,
    hart_id,
    core_clk,
    core_reset_n,
    test_mode,
    scan_enable,
    reset_vector,
    core_wfi_mode,
    nmi,
    meip,
    meiack,
    meiid,
    mtip,
    msip
);
parameter CPUID = 16'h0000;
parameter MIMPID = 32'h00000000;
parameter ILM_BASE = 64'h0000_0000;
parameter DLM_BASE = 64'h0020_0000;
parameter DEBUG_VEC = 64'he680_0000;
parameter CLUSTER_SUPPORT_INT = 0;
parameter TL_SINK_WIDTH = 2;
parameter L2_SOURCE_WIDTH = 3;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 128;
parameter CORE_BRG_REG = 0;
parameter CORE_BRG_ASYNC = 0;
parameter L2_CLK_SYNC_STAGE = 2;
parameter CORE_CLK_SYNC_STAGE = 2;
parameter BIU_PATH_X2_INT = 0;
parameter DEVICE_REGION0_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION0_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION1_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION1_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION2_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION2_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION3_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION3_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION4_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION4_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION5_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION5_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION6_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION6_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION7_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION7_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION0_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION0_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION1_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION1_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION2_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION2_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION3_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION3_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION4_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION4_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION5_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION5_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION6_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION6_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION7_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION7_MASK = 64'h00000000_00000000;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter BTB_RAM_ADDR_WIDTH = 4;
parameter BTB_RAM_DATA_WIDTH = 42;
parameter STLB_RAM_AW = 1;
parameter STLB_RAM_DW = 1;
parameter STLB_TAG_RAM_DW = 1;
parameter STLB_DATA_RAM_DW = 1;
parameter ICACHE_TAG_RAM_AW = 1;
parameter ICACHE_TAG_RAM_DW = 1;
parameter ICACHE_DATA_RAM_AW = 1;
parameter ICACHE_DATA_RAM_DW = 1;
parameter DCACHE_TAG_RAM_AW = 1;
parameter DCACHE_TAG_RAM_DW = 1;
parameter DCACHE_DATA_RAM_AW = 1;
parameter DCACHE_DATA_RAM_DW = 1;
parameter DCACHE_DATA_RAM_BWEW = 1;
parameter DCACHE_WPT_RAM_AW = 11;
parameter DCACHE_WPT_RAM_DW = 16;
parameter DCACHE_WPT_RAM_BWEW = 2;
parameter DLM_RAM_AW = 9;
parameter DLM_RAM_DW = 1;
parameter DLM_RAM_BWEW = 1;
parameter DLM_ECC_TYPE_INT = 0;
parameter DLM_WAIT_CYCLE = 0;
parameter ILM_RAM_AW = 9;
parameter ILM_RAM_DW = 1;
parameter ILM_RAM_BWEW = 1;
parameter ILM_ECC_TYPE_INT = 0;
parameter ILM_WAIT_CYCLE = 1;
parameter ISA_BASE_INT = 1;
parameter RVC_SUPPORT_INT = 1;
parameter RVN_SUPPORT_INT = 1;
parameter RVA_SUPPORT_INT = 1;
parameter RVB_SUPPORT_INT = 1;
parameter RVV_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 1;
parameter ACE_SUPPORT_INT = 1;
parameter POWERBRAKE_SUPPORT_INT = 0;
parameter VECTOR_PLIC_SUPPORT_INT = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter CODENSE_SUPPORT_INT = 0;
parameter UNALIGNED_ACCESS_INT = 0;
parameter FPU_TYPE_INT = 0;
parameter FP16_SUPPORT_INT = 0;
parameter BFLOAT16_SUPPORT_INT = 0;
parameter PUSHPOP_TYPE = 0;
parameter SLAVE_PORT_SUPPORT_INT = 0;
parameter PC_GPR_PROBING_SUPPORT_INT = 0;
parameter SLAVE_PORT_ID_WIDTH = 8;
parameter SLAVE_PORT_DATA_WIDTH = 32;
parameter SLAVE_PORT_SOURCE_NUM = 1;
parameter SLAVE_PORT_ASYNC_SUPPORT = 0;
parameter NUM_PRIVILEGE_LEVELS = 0;
parameter NUM_DLM_BANKS = 1;
parameter MMU_SCHEME_INT = 0;
parameter ITLB_ENTRIES = 0;
parameter DTLB_ENTRIES = 0;
parameter STLB_ENTRIES = 0;
parameter STLB_SP_ENTRIES = 0;
parameter STLB_ECC_TYPE = 0;
parameter BIU_ASYNC_SUPPORT = 0;
parameter BIU_ADDR_WIDTH = 39;
parameter PALEN = 39;
parameter BIU_DATA_WIDTH = 64;
parameter BIU_ID_WIDTH = 4;
parameter PMP_ENTRIES = 0;
parameter PMP_GRANULARITY = 8;
parameter PMA_ENTRIES = 0;
parameter LM_INTERFACE_INT = 0;
parameter LM_ENABLE_CTRL_INT = 0;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter CACHE_LINE_SIZE = 32;
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_LRU_INT = 0;
parameter ICACHE_WAY = 2;
parameter ICACHE_ECC_TYPE_INT = 0;
parameter ICACHE_FIRST_WORD_FIRST_INT = 0;
parameter FENCE_FLUSH_DCACHE_INT = 1;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_LRU_INT = 0;
parameter DCACHE_WAY = 2;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter MSHR_DEPTH = 3;
parameter CM_SUPPORT_INT = 0;
parameter WPT_SUPPORT = 0;
parameter L2C_CACHE_SIZE_KB = 0;
parameter L2C_REG_BASE = 64'h00000000E0500000;
parameter IOCP_NUM = 0;
parameter NCORE_CLUSTER = 1;
parameter VLEN = 512;
parameter MULTIPLIER_INT = 1;
parameter BRANCH_PREDICTION_INT = 0;
parameter DEBUG_SUPPORT_INT = 0;
parameter NUM_TRIGGER = 0;
parameter TRACE_INTERFACE_INT = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
localparam ILM_HDATA_WIDTH = 32;
localparam DLM_HDATA_WIDTH = 32;
localparam VALEN = 32;
localparam XLEN = 32;
output lm_local_int;
input lm_clk;
input bus_clk_en;
output [(BIU_ADDR_WIDTH - 1):0] araddr;
output [1:0] arburst;
output [3:0] arcache;
output [(BIU_ID_WIDTH - 1):0] arid;
output [7:0] arlen;
output arlock;
output [2:0] arprot;
input arready;
output [2:0] arsize;
output arvalid;
output [(BIU_ADDR_WIDTH - 1):0] awaddr;
output [1:0] awburst;
output [3:0] awcache;
output [(BIU_ID_WIDTH - 1):0] awid;
output [7:0] awlen;
output awlock;
output [2:0] awprot;
input awready;
output [2:0] awsize;
output awvalid;
input [(BIU_ID_WIDTH - 1):0] bid;
output bready;
input [1:0] bresp;
input bvalid;
input [(BIU_DATA_WIDTH - 1):0] rdata;
input [(BIU_ID_WIDTH - 1):0] rid;
input rlast;
output rready;
input [1:0] rresp;
input rvalid;
output [(BIU_DATA_WIDTH - 1):0] wdata;
output wlast;
input wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] wstrb;
output wvalid;
output [ILM_RAM_AW - 1:0] ilm0_addr;
output [ILM_RAM_BWEW - 1:0] ilm0_byte_we;
output ilm0_cs;
input [ILM_RAM_DW - 1:0] ilm0_rdata;
output [1:0] ilm0_user;
output [ILM_RAM_DW - 1:0] ilm0_wdata;
output ilm0_we;
output [ILM_RAM_AW - 1:0] ilm1_addr;
output [ILM_RAM_BWEW - 1:0] ilm1_byte_we;
output ilm1_cs;
input [ILM_RAM_DW - 1:0] ilm1_rdata;
output [1:0] ilm1_user;
output [ILM_RAM_DW - 1:0] ilm1_wdata;
output ilm1_we;
output [DLM_RAM_AW - 1:0] dlm_addr;
output [DLM_RAM_BWEW - 1:0] dlm_byte_we;
output dlm_cs;
input [DLM_RAM_DW - 1:0] dlm_rdata;
output [1:0] dlm_user;
output [DLM_RAM_DW - 1:0] dlm_wdata;
output dlm_we;
output [BTB_RAM_ADDR_WIDTH - 1:0] btb0_addr;
output btb0_cs;
input [BTB_RAM_DATA_WIDTH - 1:0] btb0_rdata;
output [BTB_RAM_DATA_WIDTH - 1:0] btb0_wdata;
output btb0_we;
output [BTB_RAM_ADDR_WIDTH - 1:0] btb1_addr;
output btb1_cs;
input [BTB_RAM_DATA_WIDTH - 1:0] btb1_rdata;
output [BTB_RAM_DATA_WIDTH - 1:0] btb1_wdata;
output btb1_we;
input icache_disable_init;
output icache_data0_cs;
output icache_data0_we;
output [ICACHE_DATA_RAM_AW - 1:0] icache_data0_addr;
output [ICACHE_DATA_RAM_DW - 1:0] icache_data0_wdata;
input [ICACHE_DATA_RAM_DW - 1:0] icache_data0_rdata;
output icache_data1_cs;
output icache_data1_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data1_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_rdata;
output icache_data2_cs;
output icache_data2_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data2_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_rdata;
output icache_data3_cs;
output icache_data3_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data3_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_rdata;
output icache_data4_cs;
output icache_data4_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data4_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_rdata;
output icache_data5_cs;
output icache_data5_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data5_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_rdata;
output icache_data6_cs;
output icache_data6_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data6_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_rdata;
output icache_data7_cs;
output icache_data7_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data7_addr;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_wdata;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_rdata;
output icache_tag0_cs;
output icache_tag0_we;
output [ICACHE_TAG_RAM_AW - 1:0] icache_tag0_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag0_wdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag0_rdata;
output icache_tag1_cs;
output icache_tag1_we;
output [ICACHE_TAG_RAM_AW - 1:0] icache_tag1_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag1_wdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag1_rdata;
output icache_tag2_cs;
output icache_tag2_we;
output [ICACHE_TAG_RAM_AW - 1:0] icache_tag2_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag2_wdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag2_rdata;
output icache_tag3_cs;
output icache_tag3_we;
output [ICACHE_TAG_RAM_AW - 1:0] icache_tag3_addr;
output [ICACHE_TAG_RAM_DW - 1:0] icache_tag3_wdata;
input [ICACHE_TAG_RAM_DW - 1:0] icache_tag3_rdata;
input dcache_disable_init;
output dcache_data0_cs;
output dcache_data0_we;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data0_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data0_addr;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data0_wdata;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data0_rdata;
output dcache_tag0_cs;
output dcache_tag0_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag0_addr;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag0_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag0_rdata;
output dcache_data1_cs;
output dcache_data1_we;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data1_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data1_addr;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data1_wdata;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data1_rdata;
output dcache_data2_cs;
output dcache_data2_we;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data2_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data2_addr;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data2_wdata;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data2_rdata;
output dcache_data3_cs;
output dcache_data3_we;
output [DCACHE_DATA_RAM_BWEW - 1:0] dcache_data3_byte_we;
output [DCACHE_DATA_RAM_AW - 1:0] dcache_data3_addr;
output [DCACHE_DATA_RAM_DW - 1:0] dcache_data3_wdata;
input [DCACHE_DATA_RAM_DW - 1:0] dcache_data3_rdata;
output dcache_tag1_cs;
output dcache_tag1_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag1_addr;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag1_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag1_rdata;
output dcache_tag2_cs;
output dcache_tag2_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag2_addr;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag2_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag2_rdata;
output dcache_tag3_cs;
output dcache_tag3_we;
output [DCACHE_TAG_RAM_AW - 1:0] dcache_tag3_addr;
output [DCACHE_TAG_RAM_DW - 1:0] dcache_tag3_wdata;
input [DCACHE_TAG_RAM_DW - 1:0] dcache_tag3_rdata;
output [STLB_RAM_AW - 1:0] stlb0_addr;
output stlb0_cs;
input [STLB_RAM_DW - 1:0] stlb0_rdata;
output [STLB_RAM_DW - 1:0] stlb0_wdata;
output stlb0_we;
output [STLB_RAM_AW - 1:0] stlb1_addr;
output stlb1_cs;
input [STLB_RAM_DW - 1:0] stlb1_rdata;
output [STLB_RAM_DW - 1:0] stlb1_wdata;
output stlb1_we;
output [STLB_RAM_AW - 1:0] stlb2_addr;
output stlb2_cs;
input [STLB_RAM_DW - 1:0] stlb2_rdata;
output [STLB_RAM_DW - 1:0] stlb2_wdata;
output stlb2_we;
output [STLB_RAM_AW - 1:0] stlb3_addr;
output stlb3_cs;
input [STLB_RAM_DW - 1:0] stlb3_rdata;
output [STLB_RAM_DW - 1:0] stlb3_wdata;
output stlb3_we;
input ace_acr_dirty_set;
output [31:0] ace_cmd_beat;
output [(XLEN - 1):0] ace_cmd_hartid;
output [31:7] ace_cmd_inst;
output [(VALEN - 1):0] ace_cmd_pc;
output [1:0] ace_cmd_priv;
input ace_cmd_ready;
output [(XLEN - 1):0] ace_cmd_rs1;
output [(XLEN - 1):0] ace_cmd_rs2;
output [(XLEN - 1):0] ace_cmd_rs3;
output [(XLEN - 1):0] ace_cmd_rs4;
output ace_cmd_valid;
output [(XLEN - 1):0] ace_cmd_vl;
output [(XLEN - 1):0] ace_cmd_vtype;
input ace_error;
output ace_interrupt;
input ace_standby_ready;
input ace_sync_ack;
input ace_sync_ack_status;
output ace_sync_req;
output [31:0] ace_sync_type;
input [(XLEN - 1):0] ace_xrf_rd1_data;
input [4:0] ace_xrf_rd1_index;
output ace_xrf_rd1_ready;
input ace_xrf_rd1_status;
input ace_xrf_rd1_valid;
input [(XLEN - 1):0] ace_xrf_rd2_data;
input [4:0] ace_xrf_rd2_index;
output ace_xrf_rd2_ready;
input ace_xrf_rd2_status;
input ace_xrf_rd2_valid;
input seip;
output seiack;
input [9:0] seiid;
input ueip;
output ueiack;
input [9:0] ueiid;
input debugint;
input resethaltreq;
output hart_unavail;
output hart_halted;
output hart_under_reset;
output stoptime;
input [63:0] hart_id;
input core_clk;
input core_reset_n;
input test_mode;
input scan_enable;
input [VALEN - 1:0] reset_vector;
output core_wfi_mode;
input nmi;
input meip;
output meiack;
input [9:0] meiid;
input mtip;
input msip;


wire nds_unused_core_coherent_enable;
wire [(L2_ADDR_WIDTH - 1):0] nds_unused_m0_a_address;
wire nds_unused_m0_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_m0_a_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] nds_unused_m0_a_mask;
wire [2:0] nds_unused_m0_a_opcode;
wire [2:0] nds_unused_m0_a_param;
wire [2:0] nds_unused_m0_a_size;
wire [(3 - 1):0] nds_unused_m0_a_source;
wire [11:0] nds_unused_m0_a_user;
wire nds_unused_m0_a_valid;
wire nds_unused_m0_b_ready;
wire [(L2_ADDR_WIDTH - 1):0] nds_unused_m0_c_address;
wire nds_unused_m0_c_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_m0_c_data;
wire [2:0] nds_unused_m0_c_opcode;
wire [2:0] nds_unused_m0_c_param;
wire [2:0] nds_unused_m0_c_size;
wire [(3 - 1):0] nds_unused_m0_c_source;
wire [7:0] nds_unused_m0_c_user;
wire nds_unused_m0_c_valid;
wire nds_unused_m0_d_ready;
wire [(TL_SINK_WIDTH - 1):0] nds_unused_m0_e_sink;
wire nds_unused_m0_e_valid;
wire [(L2_ADDR_WIDTH - 1):0] nds_unused_m1_a_address;
wire nds_unused_m1_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_m1_a_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] nds_unused_m1_a_mask;
wire [2:0] nds_unused_m1_a_opcode;
wire [2:0] nds_unused_m1_a_param;
wire [2:0] nds_unused_m1_a_size;
wire [(3 - 1):0] nds_unused_m1_a_source;
wire [11:0] nds_unused_m1_a_user;
wire nds_unused_m1_a_valid;
wire nds_unused_m1_d_ready;
wire [(L2_ADDR_WIDTH - 1):0] nds_unused_m2_a_address;
wire nds_unused_m2_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] nds_unused_m2_a_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] nds_unused_m2_a_mask;
wire [2:0] nds_unused_m2_a_opcode;
wire [2:0] nds_unused_m2_a_param;
wire [2:0] nds_unused_m2_a_size;
wire [(3 - 1):0] nds_unused_m2_a_source;
wire [11:0] nds_unused_m2_a_user;
wire nds_unused_m2_a_valid;
wire nds_unused_m2_d_ready;
wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_d_araddr;
wire [1:0] nds_unused_d_arburst;
wire [3:0] nds_unused_d_arcache;
wire [(BIU_ID_WIDTH - 1):0] nds_unused_d_arid;
wire [7:0] nds_unused_d_arlen;
wire nds_unused_d_arlock;
wire [2:0] nds_unused_d_arprot;
wire [2:0] nds_unused_d_arsize;
wire nds_unused_d_arvalid;
wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_d_awaddr;
wire [1:0] nds_unused_d_awburst;
wire [3:0] nds_unused_d_awcache;
wire [(BIU_ID_WIDTH - 1):0] nds_unused_d_awid;
wire [7:0] nds_unused_d_awlen;
wire nds_unused_d_awlock;
wire [2:0] nds_unused_d_awprot;
wire [2:0] nds_unused_d_awsize;
wire nds_unused_d_awvalid;
wire nds_unused_d_bready;
wire nds_unused_d_rready;
wire [(BIU_DATA_WIDTH - 1):0] nds_unused_d_wdata;
wire nds_unused_d_wlast;
wire [(BIU_DATA_WIDTH / 8) - 1:0] nds_unused_d_wstrb;
wire nds_unused_d_wvalid;
wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_i_araddr;
wire [1:0] nds_unused_i_arburst;
wire [3:0] nds_unused_i_arcache;
wire [(BIU_ID_WIDTH - 1):0] nds_unused_i_arid;
wire [7:0] nds_unused_i_arlen;
wire nds_unused_i_arlock;
wire [2:0] nds_unused_i_arprot;
wire [2:0] nds_unused_i_arsize;
wire nds_unused_i_arvalid;
wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_i_awaddr;
wire [1:0] nds_unused_i_awburst;
wire [3:0] nds_unused_i_awcache;
wire [(BIU_ID_WIDTH - 1):0] nds_unused_i_awid;
wire [7:0] nds_unused_i_awlen;
wire nds_unused_i_awlock;
wire [2:0] nds_unused_i_awprot;
wire [2:0] nds_unused_i_awsize;
wire nds_unused_i_awvalid;
wire nds_unused_i_bready;
wire nds_unused_i_rready;
wire [(BIU_DATA_WIDTH - 1):0] nds_unused_i_wdata;
wire nds_unused_i_wlast;
wire [(BIU_DATA_WIDTH / 8) - 1:0] nds_unused_i_wstrb;
wire nds_unused_i_wvalid;
wire nds_unused_slv_arready;
wire nds_unused_slv_awready;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv_bid;
wire [1:0] nds_unused_slv_bresp;
wire nds_unused_slv_bvalid;
wire [(SLAVE_PORT_DATA_WIDTH - 1):0] nds_unused_slv_rdata;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv_rid;
wire nds_unused_slv_rlast;
wire [1:0] nds_unused_slv_rresp;
wire nds_unused_slv_rvalid;
wire nds_unused_slv_wready;
wire nds_unused_slv1_arready;
wire nds_unused_slv1_awready;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv1_bid;
wire [1:0] nds_unused_slv1_bresp;
wire nds_unused_slv1_bvalid;
wire [(SLAVE_PORT_DATA_WIDTH - 1):0] nds_unused_slv1_rdata;
wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv1_rid;
wire nds_unused_slv1_rlast;
wire [1:0] nds_unused_slv1_rresp;
wire nds_unused_slv1_rvalid;
wire nds_unused_slv1_wready;
wire nds_unused_lm_reset_n;
wire [(ILM_RAM_AW + 2):3] nds_unused_ilm_a_addr;
wire [63:0] nds_unused_ilm_a_data;
wire [7:0] nds_unused_ilm_a_mask;
wire [2:0] nds_unused_ilm_a_opcode;
wire [7:0] nds_unused_ilm_a_parity0;
wire [7:0] nds_unused_ilm_a_parity1;
wire [2:0] nds_unused_ilm_a_size;
wire [1:0] nds_unused_ilm_a_user;
wire nds_unused_ilm_a_valid;
wire nds_unused_ilm_d_ready;
wire [15:2] nds_unused_dlm_a_addr;
wire [(32 - 1):0] nds_unused_dlm_a_data;
wire [(32 / 8) - 1:0] nds_unused_dlm_a_mask;
wire [2:0] nds_unused_dlm_a_opcode;
wire [7:0] nds_unused_dlm_a_parity;
wire [2:0] nds_unused_dlm_a_size;
wire [1:0] nds_unused_dlm_a_user;
wire nds_unused_dlm_a_valid;
wire nds_unused_dlm_d_ready;
wire [(14 - 1):0] nds_unused_dlm1_addr;
wire [(DLM_RAM_BWEW - 1):0] nds_unused_dlm1_byte_we;
wire nds_unused_dlm1_cs;
wire [1:0] nds_unused_dlm1_user;
wire [(DLM_RAM_DW - 1):0] nds_unused_dlm1_wdata;
wire nds_unused_dlm1_we;
wire [(14 - 1):0] nds_unused_dlm2_addr;
wire [(DLM_RAM_BWEW - 1):0] nds_unused_dlm2_byte_we;
wire nds_unused_dlm2_cs;
wire [1:0] nds_unused_dlm2_user;
wire [(DLM_RAM_DW - 1):0] nds_unused_dlm2_wdata;
wire nds_unused_dlm2_we;
wire [(14 - 1):0] nds_unused_dlm3_addr;
wire [(DLM_RAM_BWEW - 1):0] nds_unused_dlm3_byte_we;
wire nds_unused_dlm3_cs;
wire [1:0] nds_unused_dlm3_user;
wire [(DLM_RAM_DW - 1):0] nds_unused_dlm3_wdata;
wire nds_unused_dlm3_we;
wire [(DCACHE_WPT_RAM_AW - 1):0] nds_unused_dcache_wpt_addr;
wire [(DCACHE_WPT_RAM_BWEW - 1):0] nds_unused_dcache_wpt_byte_we;
wire nds_unused_dcache_wpt_cs;
wire [(DCACHE_WPT_RAM_DW - 1):0] nds_unused_dcache_wpt_wdata;
wire nds_unused_dcache_wpt_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_data0_addr;
wire nds_unused_stlb_data0_cs;
wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data0_wdata;
wire nds_unused_stlb_data0_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_data1_addr;
wire nds_unused_stlb_data1_cs;
wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data1_wdata;
wire nds_unused_stlb_data1_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_data2_addr;
wire nds_unused_stlb_data2_cs;
wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data2_wdata;
wire nds_unused_stlb_data2_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_data3_addr;
wire nds_unused_stlb_data3_cs;
wire [(STLB_DATA_RAM_DW - 1):0] nds_unused_stlb_data3_wdata;
wire nds_unused_stlb_data3_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_tag0_addr;
wire nds_unused_stlb_tag0_cs;
wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag0_wdata;
wire nds_unused_stlb_tag0_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_tag1_addr;
wire nds_unused_stlb_tag1_cs;
wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag1_wdata;
wire nds_unused_stlb_tag1_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_tag2_addr;
wire nds_unused_stlb_tag2_cs;
wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag2_wdata;
wire nds_unused_stlb_tag2_we;
wire [(STLB_RAM_AW - 1):0] nds_unused_stlb_tag3_addr;
wire nds_unused_stlb_tag3_cs;
wire [(STLB_TAG_RAM_DW - 1):0] nds_unused_stlb_tag3_wdata;
wire nds_unused_stlb_tag3_we;
wire [(VALEN - 1):0] nds_unused_core_current_pc;
wire [(XLEN - 1):0] nds_unused_core_selected_gpr_value;
wire [19:0] nds_unused_gen1_trace_cause;
wire [(VALEN * 2) - 1:0] nds_unused_gen1_trace_iaddr;
wire [1:0] nds_unused_gen1_trace_iexception;
wire [63:0] nds_unused_gen1_trace_instr;
wire [1:0] nds_unused_gen1_trace_interrupt;
wire [1:0] nds_unused_gen1_trace_ivalid;
wire [3:0] nds_unused_gen1_trace_priv;
wire [XLEN * 2 - 1:0] nds_unused_gen1_trace_tval;
wire nds_unused_trace_halted;
wire [(VALEN * 2) - 1:0] nds_unused_trace_iaddr;
wire [1:0] nds_unused_trace_ilastsize;
wire [3:0] nds_unused_trace_iretire;
wire [7:0] nds_unused_trace_itype;
wire [1:0] nds_unused_trace_priv;
wire nds_unused_trace_reset;
wire [5:0] nds_unused_trace_trigger;
wire [(XLEN - 1):0] nds_unused_trace_tval;
wire [9:0] nds_unused_trce_cause;
wire [63:0] nds_unused_vpu_cmt_i0_op1;
wire [63:0] nds_unused_vpu_cmt_i1_op1;
wire nds_unused_vpu_cmt_kill;
wire nds_unused_vpu_cmt_valid;
wire nds_unused_vpu_init_rf;
wire nds_unused_vpu_pma_resp_fault;
wire [3:0] nds_unused_vpu_pma_resp_mtype;
wire [3:0] nds_unused_vpu_pmp_resp_permission;
wire [16:0] nds_unused_vpu_req_i0_ctrl;
wire [31:0] nds_unused_vpu_req_i0_instr;
wire [63:0] nds_unused_vpu_req_i0_op1;
wire [63:0] nds_unused_vpu_req_i0_op2;
wire [16:0] nds_unused_vpu_req_i1_ctrl;
wire [31:0] nds_unused_vpu_req_i1_instr;
wire [63:0] nds_unused_vpu_req_i1_op1;
wire [63:0] nds_unused_vpu_req_i1_op2;
wire [1:0] nds_unused_vpu_req_ls_privilege;
wire [1:0] nds_unused_vpu_req_valid;
wire [10:0] nds_unused_vpu_req_vl;
wire [9:0] nds_unused_vpu_req_vstart;
wire [8:0] nds_unused_vpu_req_vtype;
wire nds_unused_vpu_srf_wready;
wire nds_unused_vpu_vtlb_flush;
wire slv_sync_clk;
wire [(XLEN - 1):0] csr_marchid;
wire [(XLEN - 1):0] csr_mimpid;
assign slv_sync_clk = lm_clk;
kv_cpuid #(
    .CPUID(CPUID),
    .MIMPID(MIMPID),
    .XLEN(XLEN)
) kv_cpuid (
    .csr_marchid(csr_marchid),
    .csr_mimpid(csr_mimpid)
);
kv_core #(
    .ACE_GPR_2W_SUPPORT_INT(0),
    .ACE_GPR_3R_SUPPORT_INT(0),
    .ACE_LS_SUPPORT_INT(0),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .BFLOAT16_SUPPORT_INT(BFLOAT16_SUPPORT_INT),
    .BIU_ADDR_WIDTH(BIU_ADDR_WIDTH),
    .BIU_ASYNC_SUPPORT(BIU_ASYNC_SUPPORT),
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BIU_ID_WIDTH(BIU_ID_WIDTH),
    .BIU_PATH_X2_INT(BIU_PATH_X2_INT),
    .BRANCH_PREDICTION_INT(BRANCH_PREDICTION_INT),
    .BTB_RAM_ADDR_WIDTH(BTB_RAM_ADDR_WIDTH),
    .BTB_RAM_DATA_WIDTH(BTB_RAM_DATA_WIDTH),
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .CODENSE_SUPPORT_INT(CODENSE_SUPPORT_INT),
    .CORE_BRG_ASYNC(CORE_BRG_ASYNC),
    .CORE_BRG_REG(CORE_BRG_REG),
    .CORE_CLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
    .CPUID(CPUID),
    .DCACHE_DATA_RAM_AW(DCACHE_DATA_RAM_AW),
    .DCACHE_DATA_RAM_BWEW(DCACHE_DATA_RAM_BWEW),
    .DCACHE_DATA_RAM_DW(DCACHE_DATA_RAM_DW),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_LRU_INT(DCACHE_LRU_INT),
    .DCACHE_PREFETCH_SUPPORT_INT(DCACHE_PREFETCH_SUPPORT_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_TAG_RAM_AW(DCACHE_TAG_RAM_AW),
    .DCACHE_TAG_RAM_DW(DCACHE_TAG_RAM_DW),
    .DCACHE_WAY(DCACHE_WAY),
    .DCACHE_WPT_RAM_AW(DCACHE_WPT_RAM_AW),
    .DCACHE_WPT_RAM_BWEW(DCACHE_WPT_RAM_BWEW),
    .DCACHE_WPT_RAM_DW(DCACHE_WPT_RAM_DW),
    .DEBUG_SUPPORT_INT(DEBUG_SUPPORT_INT),
    .DEBUG_VEC(DEBUG_VEC),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
    .DLM_BASE(DLM_BASE),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_RAM_AW(DLM_RAM_AW),
    .DLM_RAM_BWEW(DLM_RAM_BWEW),
    .DLM_RAM_DW(DLM_RAM_DW),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DLM_WAIT_CYCLE(DLM_WAIT_CYCLE),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .DTLB_ENTRIES(DTLB_ENTRIES),
    .FENCE_FLUSH_DCACHE_INT(FENCE_FLUSH_DCACHE_INT),
    .FP16_SUPPORT_INT(FP16_SUPPORT_INT),
    .FPU_TYPE_INT(FPU_TYPE_INT),
    .ICACHE_DATA_RAM_AW(ICACHE_DATA_RAM_AW),
    .ICACHE_DATA_RAM_DW(ICACHE_DATA_RAM_DW),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ICACHE_FIRST_WORD_FIRST_INT(ICACHE_FIRST_WORD_FIRST_INT),
    .ICACHE_LRU_INT(ICACHE_LRU_INT),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ICACHE_TAG_RAM_AW(ICACHE_TAG_RAM_AW),
    .ICACHE_TAG_RAM_DW(ICACHE_TAG_RAM_DW),
    .ICACHE_WAY(ICACHE_WAY),
    .ILM_BASE(ILM_BASE),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_RAM_AW(ILM_RAM_AW),
    .ILM_RAM_BWEW(ILM_RAM_BWEW),
    .ILM_RAM_DW(ILM_RAM_DW),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ILM_WAIT_CYCLE(ILM_WAIT_CYCLE),
    .IOCP_NUM(IOCP_NUM),
    .ISA_BASE_INT(ISA_BASE_INT),
    .ITLB_ENTRIES(ITLB_ENTRIES),
    .L2C_CACHE_SIZE_KB(L2C_CACHE_SIZE_KB),
    .L2C_REG_BASE(L2C_REG_BASE),
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_CLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .L2_SOURCE_WIDTH(L2_SOURCE_WIDTH),
    .LM_ENABLE_CTRL_INT(LM_ENABLE_CTRL_INT),
    .LM_INTERFACE_INT(LM_INTERFACE_INT),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .MIMPID(MIMPID),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .MSHR_DEPTH(MSHR_DEPTH),
    .MULTIPLIER_INT(MULTIPLIER_INT),
    .NCORE_CLUSTER(NCORE_CLUSTER),
    .NUM_DLM_BANKS(NUM_DLM_BANKS),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .NUM_TRIGGER(NUM_TRIGGER),
    .PALEN(BIU_ADDR_WIDTH),
    .PC_GPR_PROBING_SUPPORT_INT(PC_GPR_PROBING_SUPPORT_INT),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .PMA_ENTRIES(PMA_ENTRIES),
    .PMP_ENTRIES(PMP_ENTRIES),
    .PMP_GRANULARITY(PMP_GRANULARITY),
    .POWERBRAKE_SUPPORT_INT(POWERBRAKE_SUPPORT_INT),
    .PUSHPOP_TYPE(PUSHPOP_TYPE),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVB_SUPPORT_INT(RVB_SUPPORT_INT),
    .RVC_SUPPORT_INT(RVC_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .RVV_SUPPORT_INT(RVV_SUPPORT_INT),
    .SLAVE_PORT_ASYNC_SUPPORT(SLAVE_PORT_ASYNC_SUPPORT),
    .SLAVE_PORT_DATA_WIDTH(SLAVE_PORT_DATA_WIDTH),
    .SLAVE_PORT_ID_WIDTH(SLAVE_PORT_ID_WIDTH),
    .SLAVE_PORT_SOURCE_NUM(SLAVE_PORT_SOURCE_NUM),
    .SLAVE_PORT_SUPPORT_INT(SLAVE_PORT_SUPPORT_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .STLB_DATA_RAM_DW(STLB_DATA_RAM_DW),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .STLB_ENTRIES(STLB_ENTRIES),
    .STLB_RAM_AW(STLB_RAM_AW),
    .STLB_RAM_DW(STLB_RAM_DW),
    .STLB_SP_ENTRIES(STLB_SP_ENTRIES),
    .STLB_TAG_RAM_DW(STLB_TAG_RAM_DW),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .UNALIGNED_ACCESS_INT(UNALIGNED_ACCESS_INT),
    .VECTOR_PLIC_SUPPORT_INT(VECTOR_PLIC_SUPPORT_INT),
    .VLEN(VLEN),
    .WPT_SUPPORT(WPT_SUPPORT),
    .WRITETHROUGH_REGION0_BASE(WRITETHROUGH_REGION0_BASE),
    .WRITETHROUGH_REGION0_MASK(WRITETHROUGH_REGION0_MASK),
    .WRITETHROUGH_REGION1_BASE(WRITETHROUGH_REGION1_BASE),
    .WRITETHROUGH_REGION1_MASK(WRITETHROUGH_REGION1_MASK),
    .WRITETHROUGH_REGION2_BASE(WRITETHROUGH_REGION2_BASE),
    .WRITETHROUGH_REGION2_MASK(WRITETHROUGH_REGION2_MASK),
    .WRITETHROUGH_REGION3_BASE(WRITETHROUGH_REGION3_BASE),
    .WRITETHROUGH_REGION3_MASK(WRITETHROUGH_REGION3_MASK),
    .WRITETHROUGH_REGION4_BASE(WRITETHROUGH_REGION4_BASE),
    .WRITETHROUGH_REGION4_MASK(WRITETHROUGH_REGION4_MASK),
    .WRITETHROUGH_REGION5_BASE(WRITETHROUGH_REGION5_BASE),
    .WRITETHROUGH_REGION5_MASK(WRITETHROUGH_REGION5_MASK),
    .WRITETHROUGH_REGION6_BASE(WRITETHROUGH_REGION6_BASE),
    .WRITETHROUGH_REGION6_MASK(WRITETHROUGH_REGION6_MASK),
    .WRITETHROUGH_REGION7_BASE(WRITETHROUGH_REGION7_BASE),
    .WRITETHROUGH_REGION7_MASK(WRITETHROUGH_REGION7_MASK),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) kv_core (
    .core_clk(core_clk),
    .lm_clk(lm_clk),
    .lm_local_int(lm_local_int),
    .core_reset_n(core_reset_n),
    .test_mode(test_mode),
    .scan_enable(scan_enable),
    .reset_vector(reset_vector),
    .hart_id(hart_id),
    .csr_marchid(csr_marchid),
    .csr_mimpid(csr_mimpid),
    .slv_clk_en(1'b1),
    .slv_clk(slv_sync_clk),
    .slv1_clk_en(1'b1),
    .slv1_clk(slv_sync_clk),
    .bus_clk(1'b0),
    .bus_clk_en(bus_clk_en),
    .l2_clk(1'b0),
    .l2_reset_n(1'b0),
    .m0_a_address(nds_unused_m0_a_address),
    .m0_a_corrupt(nds_unused_m0_a_corrupt),
    .m0_a_data(nds_unused_m0_a_data),
    .m0_a_mask(nds_unused_m0_a_mask),
    .m0_a_opcode(nds_unused_m0_a_opcode),
    .m0_a_param(nds_unused_m0_a_param),
    .m0_a_ready(1'b0),
    .m0_a_size(nds_unused_m0_a_size),
    .m0_a_source(nds_unused_m0_a_source),
    .m0_a_user(nds_unused_m0_a_user),
    .m0_a_valid(nds_unused_m0_a_valid),
    .m0_b_address({BIU_ADDR_WIDTH{1'b0}}),
    .m0_b_corrupt(1'b0),
    .m0_b_data({BIU_DATA_WIDTH{1'b0}}),
    .m0_b_mask({(BIU_DATA_WIDTH / 8){1'b0}}),
    .m0_b_opcode(3'b0),
    .m0_b_param(3'b0),
    .m0_b_ready(nds_unused_m0_b_ready),
    .m0_b_size(3'b0),
    .m0_b_source(3'b0),
    .m0_b_valid(1'b0),
    .m0_c_user(nds_unused_m0_c_user),
    .m0_c_address(nds_unused_m0_c_address),
    .m0_c_corrupt(nds_unused_m0_c_corrupt),
    .m0_c_data(nds_unused_m0_c_data),
    .m0_c_opcode(nds_unused_m0_c_opcode),
    .m0_c_param(nds_unused_m0_c_param),
    .m0_c_ready(1'b0),
    .m0_c_size(nds_unused_m0_c_size),
    .m0_c_source(nds_unused_m0_c_source),
    .m0_c_valid(nds_unused_m0_c_valid),
    .m0_d_corrupt(1'b0),
    .m0_d_data({BIU_DATA_WIDTH{1'b0}}),
    .m0_d_denied(1'b0),
    .m0_d_opcode(3'b0),
    .m0_d_param(2'b0),
    .m0_d_ready(nds_unused_m0_d_ready),
    .m0_d_sink({TL_SINK_WIDTH{1'b0}}),
    .m0_d_size(3'b0),
    .m0_d_source(3'b0),
    .m0_d_user(6'b0),
    .m0_d_valid(1'b0),
    .m0_e_ready(1'b0),
    .m0_e_sink(nds_unused_m0_e_sink),
    .m0_e_valid(nds_unused_m0_e_valid),
    .m1_a_address(nds_unused_m1_a_address),
    .m1_a_corrupt(nds_unused_m1_a_corrupt),
    .m1_a_data(nds_unused_m1_a_data),
    .m1_a_mask(nds_unused_m1_a_mask),
    .m1_a_opcode(nds_unused_m1_a_opcode),
    .m1_a_param(nds_unused_m1_a_param),
    .m1_a_ready(1'b0),
    .m1_a_size(nds_unused_m1_a_size),
    .m1_a_source(nds_unused_m1_a_source),
    .m1_a_user(nds_unused_m1_a_user),
    .m1_a_valid(nds_unused_m1_a_valid),
    .m1_d_corrupt(1'b0),
    .m1_d_data({BIU_DATA_WIDTH{1'b0}}),
    .m1_d_denied(1'b0),
    .m1_d_opcode(3'b0),
    .m1_d_param(2'b0),
    .m1_d_ready(nds_unused_m1_d_ready),
    .m1_d_sink({TL_SINK_WIDTH{1'b0}}),
    .m1_d_size(3'b0),
    .m1_d_source({L2_SOURCE_WIDTH{1'b0}}),
    .m1_d_user(6'b0),
    .m1_d_valid(1'b0),
    .m2_a_address(nds_unused_m2_a_address),
    .m2_a_corrupt(nds_unused_m2_a_corrupt),
    .m2_a_data(nds_unused_m2_a_data),
    .m2_a_mask(nds_unused_m2_a_mask),
    .m2_a_opcode(nds_unused_m2_a_opcode),
    .m2_a_param(nds_unused_m2_a_param),
    .m2_a_ready(1'b0),
    .m2_a_size(nds_unused_m2_a_size),
    .m2_a_source(nds_unused_m2_a_source),
    .m2_a_user(nds_unused_m2_a_user),
    .m2_a_valid(nds_unused_m2_a_valid),
    .m2_d_corrupt(1'b0),
    .m2_d_data({BIU_DATA_WIDTH{1'b0}}),
    .m2_d_denied(1'b0),
    .m2_d_opcode(3'b0),
    .m2_d_param(2'b0),
    .m2_d_ready(nds_unused_m2_d_ready),
    .m2_d_sink({TL_SINK_WIDTH{1'b0}}),
    .m2_d_size(3'b0),
    .m2_d_source({L2_SOURCE_WIDTH{1'b0}}),
    .m2_d_user(6'b0),
    .m2_d_valid(1'b0),
    .core_coherent_enable(nds_unused_core_coherent_enable),
    .core_coherent_state(1'b0),
    .i_awid(nds_unused_i_awid),
    .i_awaddr(nds_unused_i_awaddr),
    .i_awlen(nds_unused_i_awlen),
    .i_awsize(nds_unused_i_awsize),
    .i_awburst(nds_unused_i_awburst),
    .i_awlock(nds_unused_i_awlock),
    .i_awcache(nds_unused_i_awcache),
    .i_awprot(nds_unused_i_awprot),
    .i_awvalid(nds_unused_i_awvalid),
    .i_awready(1'b1),
    .i_arid(nds_unused_i_arid),
    .i_araddr(nds_unused_i_araddr),
    .i_arlen(nds_unused_i_arlen),
    .i_arsize(nds_unused_i_arsize),
    .i_arburst(nds_unused_i_arburst),
    .i_arlock(nds_unused_i_arlock),
    .i_arcache(nds_unused_i_arcache),
    .i_arprot(nds_unused_i_arprot),
    .i_arvalid(nds_unused_i_arvalid),
    .i_arready(1'b1),
    .d_awid(nds_unused_d_awid),
    .d_awaddr(nds_unused_d_awaddr),
    .d_awlen(nds_unused_d_awlen),
    .d_awsize(nds_unused_d_awsize),
    .d_awburst(nds_unused_d_awburst),
    .d_awlock(nds_unused_d_awlock),
    .d_awcache(nds_unused_d_awcache),
    .d_awprot(nds_unused_d_awprot),
    .d_awvalid(nds_unused_d_awvalid),
    .d_awready(1'b1),
    .d_arid(nds_unused_d_arid),
    .d_araddr(nds_unused_d_araddr),
    .d_arlen(nds_unused_d_arlen),
    .d_arsize(nds_unused_d_arsize),
    .d_arburst(nds_unused_d_arburst),
    .d_arlock(nds_unused_d_arlock),
    .d_arcache(nds_unused_d_arcache),
    .d_arprot(nds_unused_d_arprot),
    .d_arvalid(nds_unused_d_arvalid),
    .d_arready(1'b1),
    .i_wdata(nds_unused_i_wdata),
    .i_wstrb(nds_unused_i_wstrb),
    .i_wlast(nds_unused_i_wlast),
    .i_wvalid(nds_unused_i_wvalid),
    .i_wready(1'b1),
    .i_bid({(BIU_ID_WIDTH){1'b0}}),
    .i_bresp({(2){1'b0}}),
    .i_bvalid(1'b0),
    .i_bready(nds_unused_i_bready),
    .i_rid({(BIU_ID_WIDTH){1'b0}}),
    .i_rdata({(BIU_DATA_WIDTH){1'b0}}),
    .i_rresp({(2){1'b0}}),
    .i_rlast(1'b0),
    .i_rvalid(1'b0),
    .i_rready(nds_unused_i_rready),
    .d_wdata(nds_unused_d_wdata),
    .d_wstrb(nds_unused_d_wstrb),
    .d_wlast(nds_unused_d_wlast),
    .d_wvalid(nds_unused_d_wvalid),
    .d_wready(1'b1),
    .d_bid({(BIU_ID_WIDTH){1'b0}}),
    .d_bresp({(2){1'b0}}),
    .d_bvalid(1'b0),
    .d_bready(nds_unused_d_bready),
    .d_rid({(BIU_ID_WIDTH){1'b0}}),
    .d_rdata({(BIU_DATA_WIDTH){1'b0}}),
    .d_rresp({(2){1'b0}}),
    .d_rlast(1'b0),
    .d_rvalid(1'b0),
    .d_rready(nds_unused_d_rready),
    .awid(awid),
    .awaddr(awaddr),
    .awlen(awlen),
    .awsize(awsize),
    .awburst(awburst),
    .awlock(awlock),
    .awcache(awcache),
    .awprot(awprot),
    .awvalid(awvalid),
    .awready(awready),
    .arid(arid),
    .araddr(araddr),
    .arlen(arlen),
    .arsize(arsize),
    .arburst(arburst),
    .arlock(arlock),
    .arcache(arcache),
    .arprot(arprot),
    .arvalid(arvalid),
    .arready(arready),
    .wdata(wdata),
    .wstrb(wstrb),
    .wlast(wlast),
    .wvalid(wvalid),
    .wready(wready),
    .bid(bid),
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),
    .rid(rid),
    .rdata(rdata),
    .rresp(rresp),
    .rlast(rlast),
    .rvalid(rvalid),
    .rready(rready),
    .slv_reset_n(1'b0),
    .slv_araddr({BIU_ADDR_WIDTH{1'b0}}),
    .slv_arburst(2'b0),
    .slv_arcache(4'b0),
    .slv_arid({(SLAVE_PORT_ID_WIDTH){1'b0}}),
    .slv_arlen(8'b0),
    .slv_arlock(1'b0),
    .slv_arprot(3'b0),
    .slv_arready(nds_unused_slv_arready),
    .slv_arsize(3'b0),
    .slv_aruser(1'b0),
    .slv_arvalid(1'b0),
    .slv_awaddr({(BIU_ADDR_WIDTH){1'b0}}),
    .slv_awburst(2'b0),
    .slv_awcache(4'b0),
    .slv_awid({(SLAVE_PORT_ID_WIDTH){1'b0}}),
    .slv_awlen(8'b0),
    .slv_awlock(1'b0),
    .slv_awprot(3'b0),
    .slv_awready(nds_unused_slv_awready),
    .slv_awsize(3'b0),
    .slv_awuser(1'b0),
    .slv_awvalid(1'b0),
    .slv_bid(nds_unused_slv_bid),
    .slv_bready(1'b0),
    .slv_bresp(nds_unused_slv_bresp),
    .slv_bvalid(nds_unused_slv_bvalid),
    .slv_rdata(nds_unused_slv_rdata),
    .slv_rid(nds_unused_slv_rid),
    .slv_rlast(nds_unused_slv_rlast),
    .slv_rready(1'b0),
    .slv_rresp(nds_unused_slv_rresp),
    .slv_rvalid(nds_unused_slv_rvalid),
    .slv_wdata({(SLAVE_PORT_DATA_WIDTH){1'b0}}),
    .slv_wlast(1'b0),
    .slv_wready(nds_unused_slv_wready),
    .slv_wstrb({(SLAVE_PORT_DATA_WIDTH / 8){1'b0}}),
    .slv_wvalid(1'b0),
    .slv1_reset_n(1'b0),
    .slv1_araddr({BIU_ADDR_WIDTH{1'b0}}),
    .slv1_arburst(2'b0),
    .slv1_arcache(4'b0),
    .slv1_arid({(SLAVE_PORT_ID_WIDTH){1'b0}}),
    .slv1_arlen(8'b0),
    .slv1_arlock(1'b0),
    .slv1_arprot(3'b0),
    .slv1_arready(nds_unused_slv1_arready),
    .slv1_arsize(3'b0),
    .slv1_aruser(1'b0),
    .slv1_arvalid(1'b0),
    .slv1_awaddr({(BIU_ADDR_WIDTH){1'b0}}),
    .slv1_awburst(2'b0),
    .slv1_awcache(4'b0),
    .slv1_awid({(SLAVE_PORT_ID_WIDTH){1'b0}}),
    .slv1_awlen(8'b0),
    .slv1_awlock(1'b0),
    .slv1_awprot(3'b0),
    .slv1_awready(nds_unused_slv1_awready),
    .slv1_awsize(3'b0),
    .slv1_awuser(1'b0),
    .slv1_awvalid(1'b0),
    .slv1_bid(nds_unused_slv1_bid),
    .slv1_bready(1'b0),
    .slv1_bresp(nds_unused_slv1_bresp),
    .slv1_bvalid(nds_unused_slv1_bvalid),
    .slv1_rdata(nds_unused_slv1_rdata),
    .slv1_rid(nds_unused_slv1_rid),
    .slv1_rlast(nds_unused_slv1_rlast),
    .slv1_rready(1'b0),
    .slv1_rresp(nds_unused_slv1_rresp),
    .slv1_rvalid(nds_unused_slv1_rvalid),
    .slv1_wdata({(SLAVE_PORT_DATA_WIDTH){1'b0}}),
    .slv1_wlast(1'b0),
    .slv1_wready(nds_unused_slv1_wready),
    .slv1_wstrb({(SLAVE_PORT_DATA_WIDTH / 8){1'b0}}),
    .slv1_wvalid(1'b0),
    .lm_reset_n(nds_unused_lm_reset_n),
    .ilm_a_addr(nds_unused_ilm_a_addr),
    .ilm_a_data(nds_unused_ilm_a_data),
    .ilm_a_mask(nds_unused_ilm_a_mask),
    .ilm_a_opcode(nds_unused_ilm_a_opcode),
    .ilm_a_parity0(nds_unused_ilm_a_parity0),
    .ilm_a_parity1(nds_unused_ilm_a_parity1),
    .ilm_a_ready(1'b1),
    .ilm_a_size(nds_unused_ilm_a_size),
    .ilm_a_user(nds_unused_ilm_a_user),
    .ilm_a_valid(nds_unused_ilm_a_valid),
    .ilm_d_denied(1'b0),
    .ilm_d_data(64'b0),
    .ilm_d_parity0(8'b0),
    .ilm_d_parity1(8'b0),
    .ilm_d_ready(nds_unused_ilm_d_ready),
    .ilm_d_valid(1'b0),
    .ilm0_addr(ilm0_addr),
    .ilm0_byte_we(ilm0_byte_we),
    .ilm0_cs(ilm0_cs),
    .ilm0_we(ilm0_we),
    .ilm0_rdata(ilm0_rdata),
    .ilm0_user(ilm0_user),
    .ilm0_wdata(ilm0_wdata),
    .ilm1_addr(ilm1_addr),
    .ilm1_byte_we(ilm1_byte_we),
    .ilm1_cs(ilm1_cs),
    .ilm1_we(ilm1_we),
    .ilm1_rdata(ilm1_rdata),
    .ilm1_user(ilm1_user),
    .ilm1_wdata(ilm1_wdata),
    .dlm_a_addr(nds_unused_dlm_a_addr),
    .dlm_a_data(nds_unused_dlm_a_data),
    .dlm_a_mask(nds_unused_dlm_a_mask),
    .dlm_a_opcode(nds_unused_dlm_a_opcode),
    .dlm_a_parity(nds_unused_dlm_a_parity),
    .dlm_a_ready(1'b1),
    .dlm_a_size(nds_unused_dlm_a_size),
    .dlm_a_user(nds_unused_dlm_a_user),
    .dlm_a_valid(nds_unused_dlm_a_valid),
    .dlm_d_denied(1'b0),
    .dlm_d_data({XLEN{1'b0}}),
    .dlm_d_parity(8'b0),
    .dlm_d_ready(nds_unused_dlm_d_ready),
    .dlm_d_valid(1'b0),
    .dlm_addr(dlm_addr),
    .dlm_byte_we(dlm_byte_we),
    .dlm_cs(dlm_cs),
    .dlm_we(dlm_we),
    .dlm_rdata(dlm_rdata),
    .dlm_user(dlm_user),
    .dlm_wdata(dlm_wdata),
    .dlm1_addr(nds_unused_dlm1_addr),
    .dlm1_byte_we(nds_unused_dlm1_byte_we),
    .dlm1_cs(nds_unused_dlm1_cs),
    .dlm1_we(nds_unused_dlm1_we),
    .dlm1_rdata({DLM_RAM_DW{1'b0}}),
    .dlm1_user(nds_unused_dlm1_user),
    .dlm1_wdata(nds_unused_dlm1_wdata),
    .dlm2_addr(nds_unused_dlm2_addr),
    .dlm2_byte_we(nds_unused_dlm2_byte_we),
    .dlm2_cs(nds_unused_dlm2_cs),
    .dlm2_we(nds_unused_dlm2_we),
    .dlm2_rdata({DLM_RAM_DW{1'b0}}),
    .dlm2_user(nds_unused_dlm2_user),
    .dlm2_wdata(nds_unused_dlm2_wdata),
    .dlm3_addr(nds_unused_dlm3_addr),
    .dlm3_byte_we(nds_unused_dlm3_byte_we),
    .dlm3_cs(nds_unused_dlm3_cs),
    .dlm3_we(nds_unused_dlm3_we),
    .dlm3_rdata({DLM_RAM_DW{1'b0}}),
    .dlm3_user(nds_unused_dlm3_user),
    .dlm3_wdata(nds_unused_dlm3_wdata),
    .btb0_addr(btb0_addr),
    .btb0_cs(btb0_cs),
    .btb0_rdata(btb0_rdata),
    .btb0_wdata(btb0_wdata),
    .btb0_we(btb0_we),
    .btb1_addr(btb1_addr),
    .btb1_cs(btb1_cs),
    .btb1_rdata(btb1_rdata),
    .btb1_wdata(btb1_wdata),
    .btb1_we(btb1_we),
    .icache_disable_init(icache_disable_init),
    .icache_data0_addr(icache_data0_addr),
    .icache_data0_cs(icache_data0_cs),
    .icache_data0_rdata(icache_data0_rdata),
    .icache_data0_wdata(icache_data0_wdata),
    .icache_data0_we(icache_data0_we),
    .icache_data1_addr(icache_data1_addr),
    .icache_data1_cs(icache_data1_cs),
    .icache_data1_rdata(icache_data1_rdata),
    .icache_data1_wdata(icache_data1_wdata),
    .icache_data1_we(icache_data1_we),
    .icache_data2_addr(icache_data2_addr),
    .icache_data2_cs(icache_data2_cs),
    .icache_data2_rdata(icache_data2_rdata),
    .icache_data2_wdata(icache_data2_wdata),
    .icache_data2_we(icache_data2_we),
    .icache_data3_addr(icache_data3_addr),
    .icache_data3_cs(icache_data3_cs),
    .icache_data3_rdata(icache_data3_rdata),
    .icache_data3_wdata(icache_data3_wdata),
    .icache_data3_we(icache_data3_we),
    .icache_data4_addr(icache_data4_addr),
    .icache_data4_cs(icache_data4_cs),
    .icache_data4_rdata(icache_data4_rdata),
    .icache_data4_wdata(icache_data4_wdata),
    .icache_data4_we(icache_data4_we),
    .icache_data5_addr(icache_data5_addr),
    .icache_data5_cs(icache_data5_cs),
    .icache_data5_rdata(icache_data5_rdata),
    .icache_data5_wdata(icache_data5_wdata),
    .icache_data5_we(icache_data5_we),
    .icache_data6_addr(icache_data6_addr),
    .icache_data6_cs(icache_data6_cs),
    .icache_data6_rdata(icache_data6_rdata),
    .icache_data6_wdata(icache_data6_wdata),
    .icache_data6_we(icache_data6_we),
    .icache_data7_addr(icache_data7_addr),
    .icache_data7_cs(icache_data7_cs),
    .icache_data7_rdata(icache_data7_rdata),
    .icache_data7_wdata(icache_data7_wdata),
    .icache_data7_we(icache_data7_we),
    .icache_tag0_addr(icache_tag0_addr),
    .icache_tag0_cs(icache_tag0_cs),
    .icache_tag0_rdata(icache_tag0_rdata),
    .icache_tag0_wdata(icache_tag0_wdata),
    .icache_tag0_we(icache_tag0_we),
    .icache_tag1_addr(icache_tag1_addr),
    .icache_tag1_cs(icache_tag1_cs),
    .icache_tag1_rdata(icache_tag1_rdata),
    .icache_tag1_wdata(icache_tag1_wdata),
    .icache_tag1_we(icache_tag1_we),
    .icache_tag2_addr(icache_tag2_addr),
    .icache_tag2_cs(icache_tag2_cs),
    .icache_tag2_rdata(icache_tag2_rdata),
    .icache_tag2_wdata(icache_tag2_wdata),
    .icache_tag2_we(icache_tag2_we),
    .icache_tag3_addr(icache_tag3_addr),
    .icache_tag3_cs(icache_tag3_cs),
    .icache_tag3_rdata(icache_tag3_rdata),
    .icache_tag3_wdata(icache_tag3_wdata),
    .icache_tag3_we(icache_tag3_we),
    .dcu_clk(core_clk),
    .dcache_disable_init(dcache_disable_init),
    .dcache_tag0_addr(dcache_tag0_addr),
    .dcache_tag0_cs(dcache_tag0_cs),
    .dcache_tag0_rdata(dcache_tag0_rdata),
    .dcache_tag0_wdata(dcache_tag0_wdata),
    .dcache_tag0_we(dcache_tag0_we),
    .dcache_data0_addr(dcache_data0_addr),
    .dcache_data0_cs(dcache_data0_cs),
    .dcache_data0_we(dcache_data0_we),
    .dcache_data0_byte_we(dcache_data0_byte_we),
    .dcache_data0_rdata(dcache_data0_rdata),
    .dcache_data0_wdata(dcache_data0_wdata),
    .dcache_data1_addr(dcache_data1_addr),
    .dcache_data1_cs(dcache_data1_cs),
    .dcache_data1_we(dcache_data1_we),
    .dcache_data1_byte_we(dcache_data1_byte_we),
    .dcache_data1_rdata(dcache_data1_rdata),
    .dcache_data1_wdata(dcache_data1_wdata),
    .dcache_data2_addr(dcache_data2_addr),
    .dcache_data2_cs(dcache_data2_cs),
    .dcache_data2_we(dcache_data2_we),
    .dcache_data2_byte_we(dcache_data2_byte_we),
    .dcache_data2_rdata(dcache_data2_rdata),
    .dcache_data2_wdata(dcache_data2_wdata),
    .dcache_data3_addr(dcache_data3_addr),
    .dcache_data3_cs(dcache_data3_cs),
    .dcache_data3_we(dcache_data3_we),
    .dcache_data3_byte_we(dcache_data3_byte_we),
    .dcache_data3_rdata(dcache_data3_rdata),
    .dcache_data3_wdata(dcache_data3_wdata),
    .dcache_tag1_addr(dcache_tag1_addr),
    .dcache_tag1_cs(dcache_tag1_cs),
    .dcache_tag1_rdata(dcache_tag1_rdata),
    .dcache_tag1_wdata(dcache_tag1_wdata),
    .dcache_tag1_we(dcache_tag1_we),
    .dcache_tag2_addr(dcache_tag2_addr),
    .dcache_tag2_cs(dcache_tag2_cs),
    .dcache_tag2_rdata(dcache_tag2_rdata),
    .dcache_tag2_wdata(dcache_tag2_wdata),
    .dcache_tag2_we(dcache_tag2_we),
    .dcache_tag3_addr(dcache_tag3_addr),
    .dcache_tag3_cs(dcache_tag3_cs),
    .dcache_tag3_rdata(dcache_tag3_rdata),
    .dcache_tag3_wdata(dcache_tag3_wdata),
    .dcache_tag3_we(dcache_tag3_we),
    .dcache_wpt_addr(nds_unused_dcache_wpt_addr),
    .dcache_wpt_byte_we(nds_unused_dcache_wpt_byte_we),
    .dcache_wpt_cs(nds_unused_dcache_wpt_cs),
    .dcache_wpt_rdata({DCACHE_WPT_RAM_DW{1'b0}}),
    .dcache_wpt_wdata(nds_unused_dcache_wpt_wdata),
    .dcache_wpt_we(nds_unused_dcache_wpt_we),
    .stlb0_addr(stlb0_addr),
    .stlb0_cs(stlb0_cs),
    .stlb0_rdata(stlb0_rdata),
    .stlb0_wdata(stlb0_wdata),
    .stlb0_we(stlb0_we),
    .stlb1_addr(stlb1_addr),
    .stlb1_cs(stlb1_cs),
    .stlb1_rdata(stlb1_rdata),
    .stlb1_wdata(stlb1_wdata),
    .stlb1_we(stlb1_we),
    .stlb2_addr(stlb2_addr),
    .stlb2_cs(stlb2_cs),
    .stlb2_rdata(stlb2_rdata),
    .stlb2_wdata(stlb2_wdata),
    .stlb2_we(stlb2_we),
    .stlb3_addr(stlb3_addr),
    .stlb3_cs(stlb3_cs),
    .stlb3_rdata(stlb3_rdata),
    .stlb3_wdata(stlb3_wdata),
    .stlb3_we(stlb3_we),
    .stlb_tag0_addr(nds_unused_stlb_tag0_addr),
    .stlb_tag0_cs(nds_unused_stlb_tag0_cs),
    .stlb_tag0_rdata({STLB_TAG_RAM_DW{1'b0}}),
    .stlb_tag0_wdata(nds_unused_stlb_tag0_wdata),
    .stlb_tag0_we(nds_unused_stlb_tag0_we),
    .stlb_tag1_addr(nds_unused_stlb_tag1_addr),
    .stlb_tag1_cs(nds_unused_stlb_tag1_cs),
    .stlb_tag1_rdata({STLB_TAG_RAM_DW{1'b0}}),
    .stlb_tag1_wdata(nds_unused_stlb_tag1_wdata),
    .stlb_tag1_we(nds_unused_stlb_tag1_we),
    .stlb_tag2_addr(nds_unused_stlb_tag2_addr),
    .stlb_tag2_cs(nds_unused_stlb_tag2_cs),
    .stlb_tag2_rdata({STLB_TAG_RAM_DW{1'b0}}),
    .stlb_tag2_wdata(nds_unused_stlb_tag2_wdata),
    .stlb_tag2_we(nds_unused_stlb_tag2_we),
    .stlb_tag3_addr(nds_unused_stlb_tag3_addr),
    .stlb_tag3_cs(nds_unused_stlb_tag3_cs),
    .stlb_tag3_rdata({STLB_TAG_RAM_DW{1'b0}}),
    .stlb_tag3_wdata(nds_unused_stlb_tag3_wdata),
    .stlb_tag3_we(nds_unused_stlb_tag3_we),
    .stlb_data0_addr(nds_unused_stlb_data0_addr),
    .stlb_data0_cs(nds_unused_stlb_data0_cs),
    .stlb_data0_rdata({STLB_DATA_RAM_DW{1'b0}}),
    .stlb_data0_wdata(nds_unused_stlb_data0_wdata),
    .stlb_data0_we(nds_unused_stlb_data0_we),
    .stlb_data1_addr(nds_unused_stlb_data1_addr),
    .stlb_data1_cs(nds_unused_stlb_data1_cs),
    .stlb_data1_rdata({STLB_DATA_RAM_DW{1'b0}}),
    .stlb_data1_wdata(nds_unused_stlb_data1_wdata),
    .stlb_data1_we(nds_unused_stlb_data1_we),
    .stlb_data2_addr(nds_unused_stlb_data2_addr),
    .stlb_data2_cs(nds_unused_stlb_data2_cs),
    .stlb_data2_rdata({STLB_DATA_RAM_DW{1'b0}}),
    .stlb_data2_wdata(nds_unused_stlb_data2_wdata),
    .stlb_data2_we(nds_unused_stlb_data2_we),
    .stlb_data3_addr(nds_unused_stlb_data3_addr),
    .stlb_data3_cs(nds_unused_stlb_data3_cs),
    .stlb_data3_rdata({STLB_DATA_RAM_DW{1'b0}}),
    .stlb_data3_wdata(nds_unused_stlb_data3_wdata),
    .stlb_data3_we(nds_unused_stlb_data3_we),
    .ace_cmd_inst(ace_cmd_inst),
    .ace_cmd_pc(ace_cmd_pc),
    .ace_cmd_ready(ace_cmd_ready),
    .ace_cmd_rs1(ace_cmd_rs1),
    .ace_cmd_rs2(ace_cmd_rs2),
    .ace_cmd_rs3(ace_cmd_rs3),
    .ace_cmd_rs4(ace_cmd_rs4),
    .ace_cmd_valid(ace_cmd_valid),
    .ace_cmd_priv(ace_cmd_priv),
    .ace_cmd_beat(ace_cmd_beat),
    .ace_cmd_vl(ace_cmd_vl),
    .ace_cmd_vtype(ace_cmd_vtype),
    .ace_cmd_hartid(ace_cmd_hartid),
    .ace_error(ace_error),
    .ace_standby_ready(ace_standby_ready),
    .ace_interrupt(ace_interrupt),
    .ace_sync_ack(ace_sync_ack),
    .ace_sync_ack_status(ace_sync_ack_status),
    .ace_sync_req(ace_sync_req),
    .ace_sync_type(ace_sync_type),
    .ace_xrf_rd1_data(ace_xrf_rd1_data),
    .ace_xrf_rd1_index(ace_xrf_rd1_index),
    .ace_xrf_rd1_ready(ace_xrf_rd1_ready),
    .ace_xrf_rd1_status(ace_xrf_rd1_status),
    .ace_xrf_rd1_valid(ace_xrf_rd1_valid),
    .ace_xrf_rd2_data(ace_xrf_rd2_data),
    .ace_xrf_rd2_index(ace_xrf_rd2_index),
    .ace_xrf_rd2_ready(ace_xrf_rd2_ready),
    .ace_xrf_rd2_status(ace_xrf_rd2_status),
    .ace_xrf_rd2_valid(ace_xrf_rd2_valid),
    .ace_acr_dirty_set(ace_acr_dirty_set),
    .core_current_pc(nds_unused_core_current_pc),
    .core_selected_gpr_value(nds_unused_core_selected_gpr_value),
    .core_gpr_index(13'b0),
    .meip(meip),
    .meiack(meiack),
    .meiid(meiid),
    .mtip(mtip),
    .msip(msip),
    .nmi(nmi),
    .seip(seip),
    .seiack(seiack),
    .seiid(seiid),
    .ueip(ueip),
    .ueiack(ueiack),
    .ueiid(ueiid),
    .debugint(debugint),
    .resethaltreq(resethaltreq),
    .stoptime(stoptime),
    .hart_unavail(hart_unavail),
    .hart_halted(hart_halted),
    .hart_under_reset(hart_under_reset),
    .gen1_trace_enabled(1'b0),
    .gen1_trace_cause(nds_unused_gen1_trace_cause),
    .gen1_trace_iaddr(nds_unused_gen1_trace_iaddr),
    .gen1_trace_iexception(nds_unused_gen1_trace_iexception),
    .gen1_trace_instr(nds_unused_gen1_trace_instr),
    .gen1_trace_interrupt(nds_unused_gen1_trace_interrupt),
    .gen1_trace_ivalid(nds_unused_gen1_trace_ivalid),
    .gen1_trace_priv(nds_unused_gen1_trace_priv),
    .gen1_trace_tval(nds_unused_gen1_trace_tval),
    .trace_enabled(1'b0),
    .trace_itype(nds_unused_trace_itype),
    .trace_cause(nds_unused_trce_cause),
    .trace_tval(nds_unused_trace_tval),
    .trace_priv(nds_unused_trace_priv),
    .trace_iaddr(nds_unused_trace_iaddr),
    .trace_iretire(nds_unused_trace_iretire),
    .trace_ilastsize(nds_unused_trace_ilastsize),
    .trace_halted(nds_unused_trace_halted),
    .trace_reset(nds_unused_trace_reset),
    .trace_trigger(nds_unused_trace_trigger),
    .trace_stall(1'b0),
    .vpu_init_rf(nds_unused_vpu_init_rf),
    .vpu_viq_size(4'd0),
    .vpu_req_valid(nds_unused_vpu_req_valid),
    .vpu_req_vl(nds_unused_vpu_req_vl),
    .vpu_req_vstart(nds_unused_vpu_req_vstart),
    .vpu_req_vtype(nds_unused_vpu_req_vtype),
    .vpu_req_ls_privilege(nds_unused_vpu_req_ls_privilege),
    .vpu_req_i0_ctrl(nds_unused_vpu_req_i0_ctrl),
    .vpu_req_i0_instr(nds_unused_vpu_req_i0_instr),
    .vpu_req_i0_op1(nds_unused_vpu_req_i0_op1),
    .vpu_req_i0_op2(nds_unused_vpu_req_i0_op2),
    .vpu_req_i1_ctrl(nds_unused_vpu_req_i1_ctrl),
    .vpu_req_i1_instr(nds_unused_vpu_req_i1_instr),
    .vpu_req_i1_op1(nds_unused_vpu_req_i1_op1),
    .vpu_req_i1_op2(nds_unused_vpu_req_i1_op2),
    .vpu_vtlb_flush(nds_unused_vpu_vtlb_flush),
    .vpu_cmt_valid(nds_unused_vpu_cmt_valid),
    .vpu_cmt_kill(nds_unused_vpu_cmt_kill),
    .vpu_cmt_i0_op1(nds_unused_vpu_cmt_i0_op1),
    .vpu_cmt_i1_op1(nds_unused_vpu_cmt_i1_op1),
    .vpu_ack_status(2'b0),
    .vpu_ack_valid(1'b0),
    .vpu_pma_req_pa({(BIU_ADDR_WIDTH){1'b0}}),
    .vpu_pma_resp_fault(nds_unused_vpu_pma_resp_fault),
    .vpu_pma_resp_mtype(nds_unused_vpu_pma_resp_mtype),
    .vpu_pmp_req_pa({(BIU_ADDR_WIDTH){1'b0}}),
    .vpu_pmp_resp_permission(nds_unused_vpu_pmp_resp_permission),
    .vpu_srf_wvalid(1'd0),
    .vpu_srf_wready(nds_unused_vpu_srf_wready),
    .vpu_srf_wfrf(1'd0),
    .vpu_srf_waddr(5'd0),
    .vpu_srf_wdata(64'd0),
    .core_wfi_mode(core_wfi_mode)
);
endmodule

