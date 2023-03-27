// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module a45_core_top (
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
    icache_disable_init,
    dcache_disable_init,
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
    core_wfi_mode,
    reset_vector,
    dti_1pr_rwm,
    dti_sp_rwm,
    dti_sp_dly,
    nmi,
    meip,
    meiack,
    meiid,
    mtip,
    msip
);
parameter ILM_BASE = 64'h0000000000000000;
parameter DLM_BASE = 64'h0000000000010000;
parameter DEBUG_VEC = 64'h00000000E6800000;
parameter DEVICE_REGION0_BASE = 64'h00000000C0000000;
parameter DEVICE_REGION0_MASK = 64'hFFFFFFFFC0000000;
parameter DEVICE_REGION1_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION1_MASK = 64'h0000000000000000;
parameter DEVICE_REGION2_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION2_MASK = 64'h0000000000000000;
parameter DEVICE_REGION3_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION3_MASK = 64'h0000000000000000;
parameter DEVICE_REGION4_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION4_MASK = 64'h0000000000000000;
parameter DEVICE_REGION5_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION5_MASK = 64'h0000000000000000;
parameter DEVICE_REGION6_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION6_MASK = 64'h0000000000000000;
parameter DEVICE_REGION7_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter DEVICE_REGION7_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION0_BASE = 64'h0000000040000000;
parameter WRITETHROUGH_REGION0_MASK = 64'hFFFFFFFFC0000000;
parameter WRITETHROUGH_REGION1_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION1_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION2_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION2_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION3_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION3_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION4_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION4_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION5_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION5_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION6_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION6_MASK = 64'h0000000000000000;
parameter WRITETHROUGH_REGION7_BASE = 64'hFFFFFFFFFFFFFFFF;
parameter WRITETHROUGH_REGION7_MASK = 64'h0000000000000000;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter L2_CLK_SYNC_STAGE = 2;
parameter CORE_CLK_SYNC_STAGE = 2;
localparam CPUID = 16'h0a45;
localparam MIMPID = 32'h00000d00;
localparam ACE_SUPPORT_INT = 1;
localparam BFLOAT16_SUPPORT_INT = 1;
localparam BIU_PATH_X2_INT = 0;
localparam BRANCH_PREDICTION_INT = 4;
localparam CLUSTER_SUPPORT_INT = 0;
localparam CODENSE_SUPPORT_INT = 1;
localparam DCACHE_ECC_TYPE_INT = 0;
localparam DCACHE_LRU_INT = 0;
localparam DCACHE_PREFETCH_SUPPORT_INT = 1;
localparam DEBUG_SUPPORT_INT = 1;
localparam DLM_ECC_TYPE_INT = 0;
localparam DSP_SUPPORT_INT = 1;
localparam FENCE_FLUSH_DCACHE_INT = 0;
localparam FP16_SUPPORT_INT = 1;
localparam FPU_TYPE_INT = 2;
localparam ICACHE_ECC_TYPE_INT = 0;
localparam ICACHE_FIRST_WORD_FIRST_INT = 1;
localparam ICACHE_LRU_INT = 0;
localparam ILM_ECC_TYPE_INT = 0;
localparam ISA_BASE_INT = 1;
localparam LM_ENABLE_CTRL_INT = 0;
localparam LM_INTERFACE_INT = 0;
localparam MMU_SCHEME_INT = 1;
localparam MULTIPLIER_INT = 0;
localparam PC_GPR_PROBING_SUPPORT_INT = 0;
localparam PERFORMANCE_MONITOR_INT = 1;
localparam POWERBRAKE_SUPPORT_INT = 1;
localparam RVA_SUPPORT_INT = 1;
localparam RVB_SUPPORT_INT = 0;
localparam RVC_SUPPORT_INT = 1;
localparam RVN_SUPPORT_INT = 1;
localparam RVV_SUPPORT_INT = 0;
localparam SLAVE_PORT_SUPPORT_INT = 0;
localparam STACKSAFE_SUPPORT_INT = 1;
localparam TRACE_INTERFACE_INT = 0;
localparam UNALIGNED_ACCESS_INT = 0;
localparam VECTOR_PLIC_SUPPORT_INT = 1;
localparam WRITE_AROUND_SUPPORT_INT = 1;
localparam PUSHPOP_TYPE = 0;
localparam SLAVE_PORT_ID_WIDTH = 8;
localparam SLAVE_PORT_DATA_WIDTH = 64;
localparam SLAVE_PORT_SOURCE_NUM = 1;
localparam SLAVE_PORT_ASYNC_SUPPORT = 0;
localparam NUM_PRIVILEGE_LEVELS = 3;
localparam NUM_DLM_BANKS = 1;
localparam ITLB_ENTRIES = 4;
localparam DTLB_ENTRIES = 8;
localparam STLB_ENTRIES = 32;
localparam STLB_SP_ENTRIES = 4;
localparam STLB_ECC_TYPE = 0;
localparam STLB_RAM_AW = 3;
localparam STLB_RAM_DW = 55;
localparam STLB_TAG_RAM_DW = 27;
localparam STLB_DATA_RAM_DW = 28;
localparam TL_SINK_WIDTH = 3;
localparam L2_SOURCE_WIDTH = 3;
localparam L2_ADDR_WIDTH = 32;
localparam L2_DATA_WIDTH = 64;
localparam L2C_CACHE_SIZE_KB = 0;
localparam L2C_REG_BASE = 64'h00000000E0500000;
localparam IOCP_NUM = 0;
localparam NCORE_CLUSTER = 1;
localparam CORE_BRG_TYPE = 0;
localparam CORE_BRG_ASYNC = (CORE_BRG_TYPE == 2) ? 1 : 0;
localparam CORE_BRG_REG = (CORE_BRG_TYPE != 0) ? 1 : 0;
localparam BIU_ASYNC_SUPPORT = 0;
localparam BIU_ADDR_WIDTH = 32;
localparam PALEN = 32;
localparam BIU_DATA_WIDTH = 64;
localparam BIU_ID_WIDTH = 4;
localparam PMP_ENTRIES = 8;
localparam PMP_GRANULARITY = 8;
localparam PMA_ENTRIES = 0;
localparam ILM_SIZE_KB = 64;
localparam ILM_RAM_AW = 13;
localparam ILM_RAM_DW = 32;
localparam ILM_RAM_BWEW = 4;
localparam ILM_WAIT_CYCLE = 0;
localparam DLM_SIZE_KB = 64;
localparam DLM_RAM_AW = 14;
localparam DLM_RAM_DW = 32;
localparam DLM_RAM_BWEW = 4;
localparam DLM_WAIT_CYCLE = 0;
localparam CACHE_LINE_SIZE = 64;
localparam ICACHE_SIZE_KB = 32;
localparam ICACHE_WAY = 4;
localparam ICACHE_TAG_RAM_AW = 7;
localparam ICACHE_TAG_RAM_DW = 23;
localparam ICACHE_DATA_RAM_AW = 10;
localparam ICACHE_DATA_RAM_DW = 32;
localparam DCACHE_SIZE_KB = 32;
localparam DCACHE_WAY = 4;
localparam MSHR_DEPTH = 4;
localparam DCACHE_TAG_RAM_AW = 7;
localparam DCACHE_TAG_RAM_DW = 23;
localparam DCACHE_DATA_RAM_AW = 11;
localparam DCACHE_DATA_RAM_DW = 32;
localparam DCACHE_DATA_RAM_BWEW = 4;
localparam DCACHE_WPT_RAM_AW = 1;
localparam DCACHE_WPT_RAM_DW = 1;
localparam DCACHE_WPT_RAM_BWEW = 1;
localparam CM_SUPPORT_INT = 0;
localparam WPT_SUPPORT = (0 != 0);
localparam VLEN = 512;
localparam NUM_TRIGGER = 2;
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
input icache_disable_init;
input dcache_disable_init;
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
output core_wfi_mode;
input [(32) - 1:0] reset_vector;
input [2:0] dti_1pr_rwm;
input [2:0] dti_sp_rwm;
input [2:0] dti_sp_dly;
input nmi;
input meip;
output meiack;
input [9:0] meiid;
input mtip;
input msip;


wire [1 - 1:0] int_ilm0_ctrl_in;
wire [(ILM_RAM_AW - 1):0] ilm0_addr;
wire [(ILM_RAM_BWEW - 1):0] ilm0_byte_we;
wire ilm0_cs;
wire [1:0] ilm0_user;
wire [(ILM_RAM_DW - 1):0] ilm0_wdata;
wire ilm0_we;
wire [(ILM_RAM_DW - 1):0] ilm0_rdata;
wire [1 - 1:0] int_ilm0_ctrl_out;
wire [1 - 1:0] int_ilm1_ctrl_in;
wire [(ILM_RAM_AW - 1):0] ilm1_addr;
wire [(ILM_RAM_BWEW - 1):0] ilm1_byte_we;
wire ilm1_cs;
wire [1:0] ilm1_user;
wire [(ILM_RAM_DW - 1):0] ilm1_wdata;
wire ilm1_we;
wire [(ILM_RAM_DW - 1):0] ilm1_rdata;
wire [1 - 1:0] int_ilm1_ctrl_out;
wire [1 - 1:0] int_dlm_ctrl_in;
wire [(DLM_RAM_AW - 1):0] dlm_addr;
wire [(DLM_RAM_BWEW - 1):0] dlm_byte_we;
wire dlm_cs;
wire [1:0] dlm_user;
wire [(DLM_RAM_DW - 1):0] dlm_wdata;
wire dlm_we;
wire [(DLM_RAM_DW - 1):0] dlm_rdata;
wire [1 - 1:0] int_dlm_ctrl_out;
wire [1 - 1:0] int_btb0_ctrl_in;
wire [1 - 1:0] int_btb1_ctrl_in;
wire [(7) - 1:0] btb0_addr;
wire btb0_cs;
wire [(56) - 1:0] btb0_wdata;
wire btb0_we;
wire [(7) - 1:0] btb1_addr;
wire btb1_cs;
wire [(56) - 1:0] btb1_wdata;
wire btb1_we;
wire [(56) - 1:0] btb0_rdata;
wire [1 - 1:0] int_btb0_ctrl_out;
wire [(56) - 1:0] btb1_rdata;
wire [1 - 1:0] int_btb1_ctrl_out;
wire [1 - 1:0] int_icache_data0_ctrl_in;
wire [1 - 1:0] int_icache_data1_ctrl_in;
wire [1 - 1:0] int_icache_data2_ctrl_in;
wire [1 - 1:0] int_icache_data3_ctrl_in;
wire [1 - 1:0] int_icache_data4_ctrl_in;
wire [1 - 1:0] int_icache_data5_ctrl_in;
wire [1 - 1:0] int_icache_data6_ctrl_in;
wire [1 - 1:0] int_icache_data7_ctrl_in;
wire [1 - 1:0] int_icache_tag0_ctrl_in;
wire [1 - 1:0] int_icache_data0_ctrl_out;
wire [1 - 1:0] int_icache_data1_ctrl_out;
wire [1 - 1:0] int_icache_data2_ctrl_out;
wire [1 - 1:0] int_icache_data3_ctrl_out;
wire [1 - 1:0] int_icache_data4_ctrl_out;
wire [1 - 1:0] int_icache_data5_ctrl_out;
wire [1 - 1:0] int_icache_data6_ctrl_out;
wire [1 - 1:0] int_icache_data7_ctrl_out;
wire [1 - 1:0] int_icache_tag0_ctrl_out;
wire icache_data0_cs;
wire icache_data0_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data0_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data0_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data0_rdata;
wire icache_tag0_cs;
wire icache_tag0_we;
wire [(ICACHE_TAG_RAM_AW - 1):0] icache_tag0_addr;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag0_wdata;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag0_rdata;
wire icache_data1_cs;
wire icache_data1_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data1_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_rdata;
wire icache_data2_cs;
wire icache_data2_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data2_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_rdata;
wire icache_data3_cs;
wire icache_data3_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data3_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_rdata;
wire icache_data4_cs;
wire icache_data4_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data4_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_rdata;
wire icache_data5_cs;
wire icache_data5_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data5_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_rdata;
wire icache_data6_cs;
wire icache_data6_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data6_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_rdata;
wire icache_data7_cs;
wire icache_data7_we;
wire [(ICACHE_DATA_RAM_AW - 1):0] icache_data7_addr;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_wdata;
wire [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_rdata;
wire [1 - 1:0] int_icache_tag1_ctrl_in;
wire [1 - 1:0] int_icache_tag1_ctrl_out;
wire icache_tag1_cs;
wire icache_tag1_we;
wire [(ICACHE_TAG_RAM_AW - 1):0] icache_tag1_addr;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag1_wdata;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag1_rdata;
wire [1 - 1:0] int_icache_tag2_ctrl_in;
wire [1 - 1:0] int_icache_tag3_ctrl_in;
wire [1 - 1:0] int_icache_tag2_ctrl_out;
wire [1 - 1:0] int_icache_tag3_ctrl_out;
wire icache_tag2_cs;
wire icache_tag2_we;
wire [(ICACHE_TAG_RAM_AW - 1):0] icache_tag2_addr;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag2_wdata;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag2_rdata;
wire icache_tag3_cs;
wire icache_tag3_we;
wire [(ICACHE_TAG_RAM_AW - 1):0] icache_tag3_addr;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag3_wdata;
wire [(ICACHE_TAG_RAM_DW - 1):0] icache_tag3_rdata;
wire [1 - 1:0] int_dcache_data0_ctrl_in;
wire [1 - 1:0] int_dcache_data1_ctrl_in;
wire [1 - 1:0] int_dcache_data2_ctrl_in;
wire [1 - 1:0] int_dcache_data3_ctrl_in;
wire [1 - 1:0] int_dcache_tag0_ctrl_in;
wire [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data0_byte_we;
wire [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data1_byte_we;
wire [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data2_byte_we;
wire [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data3_byte_we;
wire [1 - 1:0] int_dcache_data0_ctrl_out;
wire [1 - 1:0] int_dcache_data1_ctrl_out;
wire [1 - 1:0] int_dcache_data2_ctrl_out;
wire [1 - 1:0] int_dcache_data3_ctrl_out;
wire [1 - 1:0] int_dcache_tag0_ctrl_out;
wire dcache_data0_cs;
wire dcache_data0_we;
wire [(DCACHE_DATA_RAM_AW - 1):0] dcache_data0_addr;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_wdata;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_rdata;
wire dcache_tag0_cs;
wire dcache_tag0_we;
wire [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag0_addr;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_wdata;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_rdata;
wire dcache_data1_cs;
wire dcache_data1_we;
wire [(DCACHE_DATA_RAM_AW - 1):0] dcache_data1_addr;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_wdata;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_rdata;
wire dcache_data2_cs;
wire dcache_data2_we;
wire [(DCACHE_DATA_RAM_AW - 1):0] dcache_data2_addr;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_wdata;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_rdata;
wire dcache_data3_cs;
wire dcache_data3_we;
wire [(DCACHE_DATA_RAM_AW - 1):0] dcache_data3_addr;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_wdata;
wire [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_rdata;
wire [1 - 1:0] int_dcache_tag1_ctrl_in;
wire [1 - 1:0] int_dcache_tag1_ctrl_out;
wire dcache_tag1_cs;
wire dcache_tag1_we;
wire [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag1_addr;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_wdata;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_rdata;
wire [1 - 1:0] int_dcache_tag2_ctrl_in;
wire [1 - 1:0] int_dcache_tag3_ctrl_in;
wire [1 - 1:0] int_dcache_tag2_ctrl_out;
wire [1 - 1:0] int_dcache_tag3_ctrl_out;
wire dcache_tag2_cs;
wire dcache_tag2_we;
wire [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag2_addr;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_wdata;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_rdata;
wire dcache_tag3_cs;
wire dcache_tag3_we;
wire [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag3_addr;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_wdata;
wire [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_rdata;
wire [1 - 1:0] int_stlb0_ctrl_in;
wire [1 - 1:0] int_stlb1_ctrl_in;
wire [1 - 1:0] int_stlb2_ctrl_in;
wire [1 - 1:0] int_stlb3_ctrl_in;
wire [(STLB_RAM_AW - 1):0] stlb0_addr;
wire stlb0_cs;
wire [(STLB_RAM_DW - 1):0] stlb0_wdata;
wire stlb0_we;
wire [(STLB_RAM_AW - 1):0] stlb1_addr;
wire stlb1_cs;
wire [(STLB_RAM_DW - 1):0] stlb1_wdata;
wire stlb1_we;
wire [(STLB_RAM_AW - 1):0] stlb2_addr;
wire stlb2_cs;
wire [(STLB_RAM_DW - 1):0] stlb2_wdata;
wire stlb2_we;
wire [(STLB_RAM_AW - 1):0] stlb3_addr;
wire stlb3_cs;
wire [(STLB_RAM_DW - 1):0] stlb3_wdata;
wire stlb3_we;
wire [1 - 1:0] int_stlb0_ctrl_out;
wire [(STLB_RAM_DW - 1):0] stlb0_rdata;
wire [1 - 1:0] int_stlb1_ctrl_out;
wire [(STLB_RAM_DW - 1):0] stlb1_rdata;
wire [1 - 1:0] int_stlb2_ctrl_out;
wire [(STLB_RAM_DW - 1):0] stlb2_rdata;
wire [1 - 1:0] int_stlb3_ctrl_out;
wire [(STLB_RAM_DW - 1):0] stlb3_rdata;
wire [31:7] ace_cmd_inst;
wire [((32) - 1):0] ace_cmd_pc;
wire [((32) - 1):0] ace_cmd_rs1;
wire [((32) - 1):0] ace_cmd_rs2;
wire [((32) - 1):0] ace_cmd_rs3;
wire [((32) - 1):0] ace_cmd_rs4;
wire ace_cmd_valid;
wire ace_interrupt;
wire ace_sync_req;
wire [31:0] ace_sync_type;
wire ace_xrf_rd1_ready;
wire ace_xrf_rd2_ready;
wire [31:0] nds_unused_ace_cmd_beat;
wire [((32) - 1):0] nds_unused_ace_cmd_hartid;
wire [1:0] nds_unused_ace_cmd_priv;
wire [((32) - 1):0] nds_unused_ace_cmd_vl;
wire [((32) - 1):0] nds_unused_ace_cmd_vtype;
wire ace_acr_dirty_set;
wire ace_cmd_ready;
wire ace_error;
wire ace_standby_ready;
wire ace_sync_ack;
wire ace_sync_ack_status;
wire [((32) - 1):0] ace_xrf_rd1_data;
wire [4:0] ace_xrf_rd1_index;
wire ace_xrf_rd1_status;
wire ace_xrf_rd1_valid;
wire [((32) - 1):0] ace_xrf_rd2_data;
wire [4:0] ace_xrf_rd2_index;
wire ace_xrf_rd2_status;
wire ace_xrf_rd2_valid;
wire dcache_clk;
wire dlm_clk;
wire ilm_clk;
assign ilm_clk = lm_clk;
assign dlm_clk = lm_clk;
wire [1:0] nds_unused_ilm0_user = ilm0_user;
wire [1:0] nds_unused_ilm1_user = ilm1_user;
wire [1:0] nds_unused_dlm_user = dlm_user;
assign dcache_clk = core_clk;
assign int_btb0_ctrl_in = {1{1'b0}};
wire nds_unused_btb0_ctrl_out = |{int_btb0_ctrl_out};
assign int_btb1_ctrl_in = {1{1'b0}};
wire nds_unused_btb1_ctrl_out = |{int_btb1_ctrl_out};
assign int_dcache_data0_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_data0_ctrl_out = |{int_dcache_data0_ctrl_out};
assign int_dcache_data1_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_data1_ctrl_out = |{int_dcache_data1_ctrl_out};
assign int_dcache_data2_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_data2_ctrl_out = |{int_dcache_data2_ctrl_out};
assign int_dcache_data3_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_data3_ctrl_out = |{int_dcache_data3_ctrl_out};
assign int_dcache_tag0_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_tag0_ctrl_out = |{int_dcache_tag0_ctrl_out};
assign int_dcache_tag1_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_tag1_ctrl_out = |{int_dcache_tag1_ctrl_out};
assign int_dcache_tag2_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_tag2_ctrl_out = |{int_dcache_tag2_ctrl_out};
assign int_dcache_tag3_ctrl_in = {1{1'b0}};
wire nds_unused_dcache_tag3_ctrl_out = |{int_dcache_tag3_ctrl_out};
assign int_dlm_ctrl_in = {1{1'b0}};
wire nds_unused_dlm_ctrl_out = |{int_dlm_ctrl_out};
assign int_icache_data0_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data0_ctrl_out = |{int_icache_data0_ctrl_out};
assign int_icache_data1_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data1_ctrl_out = |{int_icache_data1_ctrl_out};
assign int_icache_data2_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data2_ctrl_out = |{int_icache_data2_ctrl_out};
assign int_icache_data3_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data3_ctrl_out = |{int_icache_data3_ctrl_out};
assign int_icache_data4_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data4_ctrl_out = |{int_icache_data4_ctrl_out};
assign int_icache_data5_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data5_ctrl_out = |{int_icache_data5_ctrl_out};
assign int_icache_data6_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data6_ctrl_out = |{int_icache_data6_ctrl_out};
assign int_icache_data7_ctrl_in = {1{1'b0}};
wire nds_unused_icache_data7_ctrl_out = |{int_icache_data7_ctrl_out};
assign int_icache_tag0_ctrl_in = {1{1'b0}};
wire nds_unused_icache_tag0_ctrl_out = |{int_icache_tag0_ctrl_out};
assign int_icache_tag1_ctrl_in = {1{1'b0}};
wire nds_unused_icache_tag1_ctrl_out = |{int_icache_tag1_ctrl_out};
assign int_icache_tag2_ctrl_in = {1{1'b0}};
wire nds_unused_icache_tag2_ctrl_out = |{int_icache_tag2_ctrl_out};
assign int_icache_tag3_ctrl_in = {1{1'b0}};
wire nds_unused_icache_tag3_ctrl_out = |{int_icache_tag3_ctrl_out};
assign int_ilm0_ctrl_in = {1{1'b0}};
wire nds_unused_ilm0_ctrl_out = |{int_ilm0_ctrl_out};
assign int_ilm1_ctrl_in = {1{1'b0}};
wire nds_unused_ilm1_ctrl_out = |{int_ilm1_ctrl_out};
assign int_stlb0_ctrl_in = {1{1'b0}};
wire nds_unused_stlb0_ctrl_out = |{int_stlb0_ctrl_out};
assign int_stlb1_ctrl_in = {1{1'b0}};
wire nds_unused_stlb1_ctrl_out = |{int_stlb1_ctrl_out};
assign int_stlb2_ctrl_in = {1{1'b0}};
wire nds_unused_stlb2_ctrl_out = |{int_stlb2_ctrl_out};
assign int_stlb3_ctrl_in = {1{1'b0}};
wire nds_unused_stlb3_ctrl_out = |{int_stlb3_ctrl_out};
a45_core #(
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .BFLOAT16_SUPPORT_INT(BFLOAT16_SUPPORT_INT),
    .BIU_ADDR_WIDTH(BIU_ADDR_WIDTH),
    .BIU_ASYNC_SUPPORT(BIU_ASYNC_SUPPORT),
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BIU_ID_WIDTH(BIU_ID_WIDTH),
    .BIU_PATH_X2_INT(BIU_PATH_X2_INT),
    .BRANCH_PREDICTION_INT(BRANCH_PREDICTION_INT),
    .BTB_RAM_ADDR_WIDTH(7),
    .BTB_RAM_DATA_WIDTH(56),
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
) a45_core (
    .lm_local_int(lm_local_int),
    .lm_clk(lm_clk),
    .bus_clk_en(bus_clk_en),
    .araddr(araddr),
    .arburst(arburst),
    .arcache(arcache),
    .arid(arid),
    .arlen(arlen),
    .arlock(arlock),
    .arprot(arprot),
    .arready(arready),
    .arsize(arsize),
    .arvalid(arvalid),
    .awaddr(awaddr),
    .awburst(awburst),
    .awcache(awcache),
    .awid(awid),
    .awlen(awlen),
    .awlock(awlock),
    .awprot(awprot),
    .awready(awready),
    .awsize(awsize),
    .awvalid(awvalid),
    .bid(bid),
    .bready(bready),
    .bresp(bresp),
    .bvalid(bvalid),
    .rdata(rdata),
    .rid(rid),
    .rlast(rlast),
    .rready(rready),
    .rresp(rresp),
    .rvalid(rvalid),
    .wdata(wdata),
    .wlast(wlast),
    .wready(wready),
    .wstrb(wstrb),
    .wvalid(wvalid),
    .ilm0_addr(ilm0_addr),
    .ilm0_byte_we(ilm0_byte_we),
    .ilm0_cs(ilm0_cs),
    .ilm0_rdata(ilm0_rdata),
    .ilm0_user(ilm0_user),
    .ilm0_wdata(ilm0_wdata),
    .ilm0_we(ilm0_we),
    .ilm1_addr(ilm1_addr),
    .ilm1_byte_we(ilm1_byte_we),
    .ilm1_cs(ilm1_cs),
    .ilm1_rdata(ilm1_rdata),
    .ilm1_user(ilm1_user),
    .ilm1_wdata(ilm1_wdata),
    .ilm1_we(ilm1_we),
    .dlm_addr(dlm_addr),
    .dlm_byte_we(dlm_byte_we),
    .dlm_cs(dlm_cs),
    .dlm_rdata(dlm_rdata),
    .dlm_user(dlm_user),
    .dlm_wdata(dlm_wdata),
    .dlm_we(dlm_we),
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
    .icache_data0_cs(icache_data0_cs),
    .icache_data0_we(icache_data0_we),
    .icache_data0_addr(icache_data0_addr),
    .icache_data0_wdata(icache_data0_wdata),
    .icache_data0_rdata(icache_data0_rdata),
    .icache_data1_cs(icache_data1_cs),
    .icache_data1_we(icache_data1_we),
    .icache_data1_addr(icache_data1_addr),
    .icache_data1_wdata(icache_data1_wdata),
    .icache_data1_rdata(icache_data1_rdata),
    .icache_data2_cs(icache_data2_cs),
    .icache_data2_we(icache_data2_we),
    .icache_data2_addr(icache_data2_addr),
    .icache_data2_wdata(icache_data2_wdata),
    .icache_data2_rdata(icache_data2_rdata),
    .icache_data3_cs(icache_data3_cs),
    .icache_data3_we(icache_data3_we),
    .icache_data3_addr(icache_data3_addr),
    .icache_data3_wdata(icache_data3_wdata),
    .icache_data3_rdata(icache_data3_rdata),
    .icache_data4_cs(icache_data4_cs),
    .icache_data4_we(icache_data4_we),
    .icache_data4_addr(icache_data4_addr),
    .icache_data4_wdata(icache_data4_wdata),
    .icache_data4_rdata(icache_data4_rdata),
    .icache_data5_cs(icache_data5_cs),
    .icache_data5_we(icache_data5_we),
    .icache_data5_addr(icache_data5_addr),
    .icache_data5_wdata(icache_data5_wdata),
    .icache_data5_rdata(icache_data5_rdata),
    .icache_data6_cs(icache_data6_cs),
    .icache_data6_we(icache_data6_we),
    .icache_data6_addr(icache_data6_addr),
    .icache_data6_wdata(icache_data6_wdata),
    .icache_data6_rdata(icache_data6_rdata),
    .icache_data7_cs(icache_data7_cs),
    .icache_data7_we(icache_data7_we),
    .icache_data7_addr(icache_data7_addr),
    .icache_data7_wdata(icache_data7_wdata),
    .icache_data7_rdata(icache_data7_rdata),
    .icache_tag0_cs(icache_tag0_cs),
    .icache_tag0_we(icache_tag0_we),
    .icache_tag0_addr(icache_tag0_addr),
    .icache_tag0_wdata(icache_tag0_wdata),
    .icache_tag0_rdata(icache_tag0_rdata),
    .icache_tag1_cs(icache_tag1_cs),
    .icache_tag1_we(icache_tag1_we),
    .icache_tag1_addr(icache_tag1_addr),
    .icache_tag1_wdata(icache_tag1_wdata),
    .icache_tag1_rdata(icache_tag1_rdata),
    .icache_tag2_cs(icache_tag2_cs),
    .icache_tag2_we(icache_tag2_we),
    .icache_tag2_addr(icache_tag2_addr),
    .icache_tag2_wdata(icache_tag2_wdata),
    .icache_tag2_rdata(icache_tag2_rdata),
    .icache_tag3_cs(icache_tag3_cs),
    .icache_tag3_we(icache_tag3_we),
    .icache_tag3_addr(icache_tag3_addr),
    .icache_tag3_wdata(icache_tag3_wdata),
    .icache_tag3_rdata(icache_tag3_rdata),
    .dcache_disable_init(dcache_disable_init),
    .dcache_data0_cs(dcache_data0_cs),
    .dcache_data0_we(dcache_data0_we),
    .dcache_data0_byte_we(dcache_data0_byte_we),
    .dcache_data0_addr(dcache_data0_addr),
    .dcache_data0_wdata(dcache_data0_wdata),
    .dcache_data0_rdata(dcache_data0_rdata),
    .dcache_tag0_cs(dcache_tag0_cs),
    .dcache_tag0_we(dcache_tag0_we),
    .dcache_tag0_addr(dcache_tag0_addr),
    .dcache_tag0_wdata(dcache_tag0_wdata),
    .dcache_tag0_rdata(dcache_tag0_rdata),
    .dcache_data1_cs(dcache_data1_cs),
    .dcache_data1_we(dcache_data1_we),
    .dcache_data1_byte_we(dcache_data1_byte_we),
    .dcache_data1_addr(dcache_data1_addr),
    .dcache_data1_wdata(dcache_data1_wdata),
    .dcache_data1_rdata(dcache_data1_rdata),
    .dcache_data2_cs(dcache_data2_cs),
    .dcache_data2_we(dcache_data2_we),
    .dcache_data2_byte_we(dcache_data2_byte_we),
    .dcache_data2_addr(dcache_data2_addr),
    .dcache_data2_wdata(dcache_data2_wdata),
    .dcache_data2_rdata(dcache_data2_rdata),
    .dcache_data3_cs(dcache_data3_cs),
    .dcache_data3_we(dcache_data3_we),
    .dcache_data3_byte_we(dcache_data3_byte_we),
    .dcache_data3_addr(dcache_data3_addr),
    .dcache_data3_wdata(dcache_data3_wdata),
    .dcache_data3_rdata(dcache_data3_rdata),
    .dcache_tag1_cs(dcache_tag1_cs),
    .dcache_tag1_we(dcache_tag1_we),
    .dcache_tag1_addr(dcache_tag1_addr),
    .dcache_tag1_wdata(dcache_tag1_wdata),
    .dcache_tag1_rdata(dcache_tag1_rdata),
    .dcache_tag2_cs(dcache_tag2_cs),
    .dcache_tag2_we(dcache_tag2_we),
    .dcache_tag2_addr(dcache_tag2_addr),
    .dcache_tag2_wdata(dcache_tag2_wdata),
    .dcache_tag2_rdata(dcache_tag2_rdata),
    .dcache_tag3_cs(dcache_tag3_cs),
    .dcache_tag3_we(dcache_tag3_we),
    .dcache_tag3_addr(dcache_tag3_addr),
    .dcache_tag3_wdata(dcache_tag3_wdata),
    .dcache_tag3_rdata(dcache_tag3_rdata),
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
    .ace_acr_dirty_set(ace_acr_dirty_set),
    .ace_cmd_beat(nds_unused_ace_cmd_beat),
    .ace_cmd_hartid(nds_unused_ace_cmd_hartid),
    .ace_cmd_inst(ace_cmd_inst),
    .ace_cmd_pc(ace_cmd_pc),
    .ace_cmd_priv(nds_unused_ace_cmd_priv),
    .ace_cmd_ready(ace_cmd_ready),
    .ace_cmd_rs1(ace_cmd_rs1),
    .ace_cmd_rs2(ace_cmd_rs2),
    .ace_cmd_rs3(ace_cmd_rs3),
    .ace_cmd_rs4(ace_cmd_rs4),
    .ace_cmd_valid(ace_cmd_valid),
    .ace_cmd_vl(nds_unused_ace_cmd_vl),
    .ace_cmd_vtype(nds_unused_ace_cmd_vtype),
    .ace_error(ace_error),
    .ace_interrupt(ace_interrupt),
    .ace_standby_ready(ace_standby_ready),
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
    .seip(seip),
    .seiack(seiack),
    .seiid(seiid),
    .ueip(ueip),
    .ueiack(ueiack),
    .ueiid(ueiid),
    .debugint(debugint),
    .resethaltreq(resethaltreq),
    .hart_unavail(hart_unavail),
    .hart_halted(hart_halted),
    .hart_under_reset(hart_under_reset),
    .stoptime(stoptime),
    .hart_id(hart_id),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .test_mode(test_mode),
    .scan_enable(scan_enable),
    .reset_vector(reset_vector),
    .core_wfi_mode(core_wfi_mode),
    .nmi(nmi),
    .meip(meip),
    .meiack(meiack),
    .meiid(meiid),
    .mtip(mtip),
    .msip(msip)
);
kv_ilm_ram #(
    .ILM_RAM_AW(13),
    .ILM_RAM_BWEW(4),
    .ILM_RAM_CTRL_IN_WIDTH(1),
    .ILM_RAM_CTRL_OUT_WIDTH(1),
    .ILM_RAM_DW(32)
) u_ilm_ram0 (
    .clk(ilm_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .ilm_cs(ilm0_cs),
    .ilm_we(ilm0_we),
    .ilm_addr(ilm0_addr),
    .ilm_byte_we(ilm0_byte_we),
    .ilm_wdata(ilm0_wdata),
    .ilm_rdata(ilm0_rdata),
    .ilm_ctrl_in(int_ilm0_ctrl_in),
    .ilm_ctrl_out(int_ilm0_ctrl_out)
);
kv_ilm_ram #(
    .ILM_RAM_AW(13),
    .ILM_RAM_BWEW(4),
    .ILM_RAM_CTRL_IN_WIDTH(1),
    .ILM_RAM_CTRL_OUT_WIDTH(1),
    .ILM_RAM_DW(32)
) u_ilm_ram1 (
    .clk(ilm_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .ilm_cs(ilm1_cs),
    .ilm_we(ilm1_we),
    .ilm_addr(ilm1_addr),
    .ilm_byte_we(ilm1_byte_we),
    .ilm_wdata(ilm1_wdata),
    .ilm_rdata(ilm1_rdata),
    .ilm_ctrl_in(int_ilm1_ctrl_in),
    .ilm_ctrl_out(int_ilm1_ctrl_out)
);
kv_dlm_ram #(
    .DLM_RAM_AW(14),
    .DLM_RAM_BWEW(4),
    .DLM_RAM_CTRL_IN_WIDTH(1),
    .DLM_RAM_CTRL_OUT_WIDTH(1),
    .DLM_RAM_DW(32)
) u_dlm_ram0 (
    .clk(dlm_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .dlm_cs(dlm_cs),
    .dlm_we(dlm_we),
    .dlm_byte_we(dlm_byte_we),
    .dlm_addr(dlm_addr),
    .dlm_wdata(dlm_wdata),
    .dlm_rdata(dlm_rdata),
    .dlm_ctrl_in(int_dlm_ctrl_in),
    .dlm_ctrl_out(int_dlm_ctrl_out)
);
ace #(
    .VALEN(VALEN),
    .XLEN(XLEN)
) u_ace (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .ace_cmd_valid(ace_cmd_valid),
    .ace_cmd_inst(ace_cmd_inst),
    .ace_cmd_pc(ace_cmd_pc),
    .ace_cmd_rs1(ace_cmd_rs1),
    .ace_cmd_rs2(ace_cmd_rs2),
    .ace_cmd_rs3(ace_cmd_rs3),
    .ace_cmd_rs4(ace_cmd_rs4),
    .ace_cmd_ready(ace_cmd_ready),
    .ace_acr_dirty_set(ace_acr_dirty_set),
    .ace_error(ace_error),
    .ace_standby_ready(ace_standby_ready),
    .ace_xrf_rd1_ready(ace_xrf_rd1_ready),
    .ace_xrf_rd1_valid(ace_xrf_rd1_valid),
    .ace_xrf_rd1_index(ace_xrf_rd1_index),
    .ace_xrf_rd1_data(ace_xrf_rd1_data),
    .ace_xrf_rd1_status(ace_xrf_rd1_status),
    .ace_xrf_rd2_ready(ace_xrf_rd2_ready),
    .ace_xrf_rd2_valid(ace_xrf_rd2_valid),
    .ace_xrf_rd2_index(ace_xrf_rd2_index),
    .ace_xrf_rd2_data(ace_xrf_rd2_data),
    .ace_xrf_rd2_status(ace_xrf_rd2_status),
    .ace_interrupt(ace_interrupt),
    .ace_sync_ack(ace_sync_ack),
    .ace_sync_ack_status(ace_sync_ack_status),
    .ace_sync_req(ace_sync_req),
    .ace_sync_type(ace_sync_type)
);
kv_icache_tag_ram #(
    .ICACHE_TAG_RAM_AW(7),
    .ICACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_TAG_RAM_DW(23)
) u_icache_tag_ram0 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_tag_cs(icache_tag0_cs),
    .icache_tag_addr(icache_tag0_addr),
    .icache_tag_rdata(icache_tag0_rdata),
    .icache_tag_wdata(icache_tag0_wdata),
    .icache_tag_we(icache_tag0_we),
    .icache_tag_ctrl_in(int_icache_tag0_ctrl_in),
    .icache_tag_ctrl_out(int_icache_tag0_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram0 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data0_rdata),
    .icache_data_wdata(icache_data0_wdata),
    .icache_data_cs(icache_data0_cs),
    .icache_data_we(icache_data0_we),
    .icache_data_addr(icache_data0_addr),
    .icache_data_ctrl_in(int_icache_data0_ctrl_in),
    .icache_data_ctrl_out(int_icache_data0_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram1 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data1_rdata),
    .icache_data_wdata(icache_data1_wdata),
    .icache_data_cs(icache_data1_cs),
    .icache_data_we(icache_data1_we),
    .icache_data_addr(icache_data1_addr),
    .icache_data_ctrl_in(int_icache_data1_ctrl_in),
    .icache_data_ctrl_out(int_icache_data1_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram2 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data2_rdata),
    .icache_data_wdata(icache_data2_wdata),
    .icache_data_cs(icache_data2_cs),
    .icache_data_we(icache_data2_we),
    .icache_data_addr(icache_data2_addr),
    .icache_data_ctrl_in(int_icache_data2_ctrl_in),
    .icache_data_ctrl_out(int_icache_data2_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram3 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data3_rdata),
    .icache_data_wdata(icache_data3_wdata),
    .icache_data_cs(icache_data3_cs),
    .icache_data_we(icache_data3_we),
    .icache_data_addr(icache_data3_addr),
    .icache_data_ctrl_in(int_icache_data3_ctrl_in),
    .icache_data_ctrl_out(int_icache_data3_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram4 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data4_rdata),
    .icache_data_wdata(icache_data4_wdata),
    .icache_data_cs(icache_data4_cs),
    .icache_data_we(icache_data4_we),
    .icache_data_addr(icache_data4_addr),
    .icache_data_ctrl_in(int_icache_data4_ctrl_in),
    .icache_data_ctrl_out(int_icache_data4_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram5 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data5_rdata),
    .icache_data_wdata(icache_data5_wdata),
    .icache_data_cs(icache_data5_cs),
    .icache_data_we(icache_data5_we),
    .icache_data_addr(icache_data5_addr),
    .icache_data_ctrl_in(int_icache_data5_ctrl_in),
    .icache_data_ctrl_out(int_icache_data5_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram6 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data6_rdata),
    .icache_data_wdata(icache_data6_wdata),
    .icache_data_cs(icache_data6_cs),
    .icache_data_we(icache_data6_we),
    .icache_data_addr(icache_data6_addr),
    .icache_data_ctrl_in(int_icache_data6_ctrl_in),
    .icache_data_ctrl_out(int_icache_data6_ctrl_out)
);
kv_icache_data_ram #(
    .ICACHE_DATA_RAM_AW(10),
    .ICACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_DATA_RAM_DW(32)
) u_icache_data_ram7 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_data_rdata(icache_data7_rdata),
    .icache_data_wdata(icache_data7_wdata),
    .icache_data_cs(icache_data7_cs),
    .icache_data_we(icache_data7_we),
    .icache_data_addr(icache_data7_addr),
    .icache_data_ctrl_in(int_icache_data7_ctrl_in),
    .icache_data_ctrl_out(int_icache_data7_ctrl_out)
);
kv_icache_tag_ram #(
    .ICACHE_TAG_RAM_AW(7),
    .ICACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_TAG_RAM_DW(23)
) u_icache_tag_ram1 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_tag_cs(icache_tag1_cs),
    .icache_tag_addr(icache_tag1_addr),
    .icache_tag_rdata(icache_tag1_rdata),
    .icache_tag_wdata(icache_tag1_wdata),
    .icache_tag_we(icache_tag1_we),
    .icache_tag_ctrl_in(int_icache_tag1_ctrl_in),
    .icache_tag_ctrl_out(int_icache_tag1_ctrl_out)
);
kv_icache_tag_ram #(
    .ICACHE_TAG_RAM_AW(7),
    .ICACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_TAG_RAM_DW(23)
) u_icache_tag_ram2 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_tag_cs(icache_tag2_cs),
    .icache_tag_addr(icache_tag2_addr),
    .icache_tag_rdata(icache_tag2_rdata),
    .icache_tag_wdata(icache_tag2_wdata),
    .icache_tag_we(icache_tag2_we),
    .icache_tag_ctrl_in(int_icache_tag2_ctrl_in),
    .icache_tag_ctrl_out(int_icache_tag2_ctrl_out)
);
kv_icache_tag_ram #(
    .ICACHE_TAG_RAM_AW(7),
    .ICACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .ICACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .ICACHE_TAG_RAM_DW(23)
) u_icache_tag_ram3 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .icache_tag_cs(icache_tag3_cs),
    .icache_tag_addr(icache_tag3_addr),
    .icache_tag_rdata(icache_tag3_rdata),
    .icache_tag_wdata(icache_tag3_wdata),
    .icache_tag_we(icache_tag3_we),
    .icache_tag_ctrl_in(int_icache_tag3_ctrl_in),
    .icache_tag_ctrl_out(int_icache_tag3_ctrl_out)
);
kv_dcache_tag_ram #(
    .DCACHE_TAG_RAM_AW(7),
    .DCACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_TAG_RAM_DW(23)
) u_dcache_tag_ram0 (
    .clk(dcache_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .dcache_tag_cs(dcache_tag0_cs),
    .dcache_tag_we(dcache_tag0_we),
    .dcache_tag_addr(dcache_tag0_addr),
    .dcache_tag_wdata(dcache_tag0_wdata),
    .dcache_tag_rdata(dcache_tag0_rdata),
    .dcache_tag_ctrl_in(int_dcache_tag0_ctrl_in),
    .dcache_tag_ctrl_out(int_dcache_tag0_ctrl_out)
);
kv_dcache_data_ram #(
    .DCACHE_DATA_RAM_AW(11),
    .DCACHE_DATA_RAM_BWEW(4),
    .DCACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_DATA_RAM_DW(32)
) u_dcache_data_ram0 (
    .clk(dcache_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .dcache_data_rdata(dcache_data0_rdata),
    .dcache_data_wdata(dcache_data0_wdata),
    .dcache_data_cs(dcache_data0_cs),
    .dcache_data_we(dcache_data0_we),
    .dcache_data_byte_we(dcache_data0_byte_we),
    .dcache_data_addr(dcache_data0_addr),
    .dcache_data_ctrl_in(int_dcache_data0_ctrl_in),
    .dcache_data_ctrl_out(int_dcache_data0_ctrl_out)
);
kv_dcache_data_ram #(
    .DCACHE_DATA_RAM_AW(11),
    .DCACHE_DATA_RAM_BWEW(4),
    .DCACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_DATA_RAM_DW(32)
) u_dcache_data_ram1 (
    .clk(dcache_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .dcache_data_rdata(dcache_data1_rdata),
    .dcache_data_wdata(dcache_data1_wdata),
    .dcache_data_cs(dcache_data1_cs),
    .dcache_data_we(dcache_data1_we),
    .dcache_data_byte_we(dcache_data1_byte_we),
    .dcache_data_addr(dcache_data1_addr),
    .dcache_data_ctrl_in(int_dcache_data1_ctrl_in),
    .dcache_data_ctrl_out(int_dcache_data1_ctrl_out)
);
kv_dcache_data_ram #(
    .DCACHE_DATA_RAM_AW(11),
    .DCACHE_DATA_RAM_BWEW(4),
    .DCACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_DATA_RAM_DW(32)
) u_dcache_data_ram2 (
    .clk(dcache_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .dcache_data_rdata(dcache_data2_rdata),
    .dcache_data_wdata(dcache_data2_wdata),
    .dcache_data_cs(dcache_data2_cs),
    .dcache_data_we(dcache_data2_we),
    .dcache_data_byte_we(dcache_data2_byte_we),
    .dcache_data_addr(dcache_data2_addr),
    .dcache_data_ctrl_in(int_dcache_data2_ctrl_in),
    .dcache_data_ctrl_out(int_dcache_data2_ctrl_out)
);
kv_dcache_data_ram #(
    .DCACHE_DATA_RAM_AW(11),
    .DCACHE_DATA_RAM_BWEW(4),
    .DCACHE_DATA_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_DATA_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_DATA_RAM_DW(32)
) u_dcache_data_ram3 (
    .clk(dcache_clk),
    .dti_sp_rwm(dti_sp_rwm),
    .dti_sp_dly(dti_sp_dly),
    .dcache_data_rdata(dcache_data3_rdata),
    .dcache_data_wdata(dcache_data3_wdata),
    .dcache_data_cs(dcache_data3_cs),
    .dcache_data_we(dcache_data3_we),
    .dcache_data_byte_we(dcache_data3_byte_we),
    .dcache_data_addr(dcache_data3_addr),
    .dcache_data_ctrl_in(int_dcache_data3_ctrl_in),
    .dcache_data_ctrl_out(int_dcache_data3_ctrl_out)
);
kv_dcache_tag_ram #(
    .DCACHE_TAG_RAM_AW(7),
    .DCACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_TAG_RAM_DW(23)
) u_dcache_tag_ram1 (
    .clk(dcache_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .dcache_tag_cs(dcache_tag1_cs),
    .dcache_tag_we(dcache_tag1_we),
    .dcache_tag_addr(dcache_tag1_addr),
    .dcache_tag_wdata(dcache_tag1_wdata),
    .dcache_tag_rdata(dcache_tag1_rdata),
    .dcache_tag_ctrl_in(int_dcache_tag1_ctrl_in),
    .dcache_tag_ctrl_out(int_dcache_tag1_ctrl_out)
);
kv_dcache_tag_ram #(
    .DCACHE_TAG_RAM_AW(7),
    .DCACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_TAG_RAM_DW(23)
) u_dcache_tag_ram2 (
    .clk(dcache_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .dcache_tag_cs(dcache_tag2_cs),
    .dcache_tag_we(dcache_tag2_we),
    .dcache_tag_addr(dcache_tag2_addr),
    .dcache_tag_wdata(dcache_tag2_wdata),
    .dcache_tag_rdata(dcache_tag2_rdata),
    .dcache_tag_ctrl_in(int_dcache_tag2_ctrl_in),
    .dcache_tag_ctrl_out(int_dcache_tag2_ctrl_out)
);
kv_dcache_tag_ram #(
    .DCACHE_TAG_RAM_AW(7),
    .DCACHE_TAG_RAM_CTRL_IN_WIDTH(1),
    .DCACHE_TAG_RAM_CTRL_OUT_WIDTH(1),
    .DCACHE_TAG_RAM_DW(23)
) u_dcache_tag_ram3 (
    .clk(dcache_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .dcache_tag_cs(dcache_tag3_cs),
    .dcache_tag_we(dcache_tag3_we),
    .dcache_tag_addr(dcache_tag3_addr),
    .dcache_tag_wdata(dcache_tag3_wdata),
    .dcache_tag_rdata(dcache_tag3_rdata),
    .dcache_tag_ctrl_in(int_dcache_tag3_ctrl_in),
    .dcache_tag_ctrl_out(int_dcache_tag3_ctrl_out)
);
kv_btb_ram #(
    .BTB_RAM_ADDR_WIDTH(7),
    .BTB_RAM_CTRL_IN_WIDTH(1),
    .BTB_RAM_CTRL_OUT_WIDTH(1),
    .BTB_RAM_DATA_WIDTH(56)
) u_btb_ram0 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .btb_addr(btb0_addr),
    .btb_cs(btb0_cs),
    .btb_we(btb0_we),
    .btb_wdata(btb0_wdata),
    .btb_rdata(btb0_rdata),
    .btb_ctrl_in(int_btb0_ctrl_in),
    .btb_ctrl_out(int_btb0_ctrl_out)
);
kv_btb_ram #(
    .BTB_RAM_ADDR_WIDTH(7),
    .BTB_RAM_CTRL_IN_WIDTH(1),
    .BTB_RAM_CTRL_OUT_WIDTH(1),
    .BTB_RAM_DATA_WIDTH(56)
) u_btb_ram1 (
    .clk(core_clk),
    .dti_1pr_rwm(dti_1pr_rwm),
    .btb_addr(btb1_addr),
    .btb_cs(btb1_cs),
    .btb_we(btb1_we),
    .btb_wdata(btb1_wdata),
    .btb_rdata(btb1_rdata),
    .btb_ctrl_in(int_btb1_ctrl_in),
    .btb_ctrl_out(int_btb1_ctrl_out)
);
kv_stlb_ram #(
    .STLB_RAM_AW(3),
    .STLB_RAM_CTRL_IN_WIDTH(1),
    .STLB_RAM_CTRL_OUT_WIDTH(1),
    .STLB_RAM_DW(55)
) u_stlb_ram0 (
    .clk(core_clk),
    .stlb_cs(stlb0_cs),
    .stlb_we(stlb0_we),
    .stlb_addr(stlb0_addr),
    .stlb_wdata(stlb0_wdata),
    .stlb_rdata(stlb0_rdata),
    .stlb_ctrl_in(int_stlb0_ctrl_in),
    .stlb_ctrl_out(int_stlb0_ctrl_out)
);
kv_stlb_ram #(
    .STLB_RAM_AW(3),
    .STLB_RAM_CTRL_IN_WIDTH(1),
    .STLB_RAM_CTRL_OUT_WIDTH(1),
    .STLB_RAM_DW(55)
) u_stlb_ram1 (
    .clk(core_clk),
    .stlb_cs(stlb1_cs),
    .stlb_we(stlb1_we),
    .stlb_addr(stlb1_addr),
    .stlb_wdata(stlb1_wdata),
    .stlb_rdata(stlb1_rdata),
    .stlb_ctrl_in(int_stlb1_ctrl_in),
    .stlb_ctrl_out(int_stlb1_ctrl_out)
);
kv_stlb_ram #(
    .STLB_RAM_AW(3),
    .STLB_RAM_CTRL_IN_WIDTH(1),
    .STLB_RAM_CTRL_OUT_WIDTH(1),
    .STLB_RAM_DW(55)
) u_stlb_ram2 (
    .clk(core_clk),
    .stlb_cs(stlb2_cs),
    .stlb_we(stlb2_we),
    .stlb_addr(stlb2_addr),
    .stlb_wdata(stlb2_wdata),
    .stlb_rdata(stlb2_rdata),
    .stlb_ctrl_in(int_stlb2_ctrl_in),
    .stlb_ctrl_out(int_stlb2_ctrl_out)
);
kv_stlb_ram #(
    .STLB_RAM_AW(3),
    .STLB_RAM_CTRL_IN_WIDTH(1),
    .STLB_RAM_CTRL_OUT_WIDTH(1),
    .STLB_RAM_DW(55)
) u_stlb_ram3 (
    .clk(core_clk),
    .stlb_cs(stlb3_cs),
    .stlb_we(stlb3_we),
    .stlb_addr(stlb3_addr),
    .stlb_wdata(stlb3_wdata),
    .stlb_rdata(stlb3_rdata),
    .stlb_ctrl_in(int_stlb3_ctrl_in),
    .stlb_ctrl_out(int_stlb3_ctrl_out)
);
endmodule

