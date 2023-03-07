// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ae350_cpu_subsystem (
    arid,
    araddr,
    arlen,
    arsize,
    arburst,
    arlock,
    arcache,
    arprot,
    arvalid,
    arready,
    awid,
    awaddr,
    awlen,
    awsize,
    awburst,
    awlock,
    awcache,
    awprot,
    awvalid,
    awready,
    wdata,
    wstrb,
    wlast,
    wvalid,
    wready,
    bid,
    bresp,
    bvalid,
    bready,
    rid,
    rdata,
    rresp,
    rlast,
    rvalid,
    rready,
    dm_sys_araddr,
    dm_sys_arburst,
    dm_sys_arcache,
    dm_sys_arid,
    dm_sys_arlen,
    dm_sys_arlock,
    dm_sys_arprot,
    dm_sys_arready,
    dm_sys_arsize,
    dm_sys_arvalid,
    dm_sys_awaddr,
    dm_sys_awburst,
    dm_sys_awcache,
    dm_sys_awid,
    dm_sys_awlen,
    dm_sys_awlock,
    dm_sys_awprot,
    dm_sys_awready,
    dm_sys_awsize,
    dm_sys_awvalid,
    dm_sys_bid,
    dm_sys_bready,
    dm_sys_bresp,
    dm_sys_bvalid,
    dm_sys_rdata,
    dm_sys_rid,
    dm_sys_rlast,
    dm_sys_rready,
    dm_sys_rresp,
    dm_sys_rvalid,
    dm_sys_wdata,
    dm_sys_wlast,
    dm_sys_wready,
    dm_sys_wstrb,
    dm_sys_wvalid,
    //core_clk,
    core_resetn,
    dbg_srst_req,
    //dc_clk,
    hart0_wakeup_event,
    //lm_clk,
    slvp_resetn,
    aclk,
    aresetn,
    scan_enable,
    test_mode,
    int_src,
    mtime_clk,
    por_rstn,
    hart0_core_wfi_mode,
    hart0_nmi,
    jtag_tck,
    jtag_tdi,
    jtag_tdo,
    jtag_tms,
    margin_ctrl,
    hart0_reset_vector
);
localparam SLVPORT_DLM_SEL_BIT = 21;
localparam PALEN = 32;
localparam BIU_ADDR_WIDTH = 32;
localparam BIU_ADDR_MSB = 32 - 1;
localparam BIU_ASYNC_SUPPORT = 0;
localparam XLEN = 32;
localparam VALEN = 32;
localparam ADDR_WIDTH = PALEN;
localparam ADDR_MSB = (ADDR_WIDTH - 1);
localparam RESET_VECTOR_WIDTH = (VALEN > 32) ? 64 : 32;
localparam BIU_DATA_WIDTH = 64;
localparam BIU_DATA_MSB = (BIU_DATA_WIDTH - 1);
localparam BIU_WSTRB_WIDTH = (BIU_DATA_WIDTH / 8);
localparam BIU_WSTRB_MSB = (BIU_WSTRB_WIDTH - 1);
localparam SLVPORT_ID_WIDTH = 8;
localparam SLVPORT_DATA_WIDTH = 64;
localparam SLVPORT_DATA_MSB = (SLVPORT_DATA_WIDTH - 1);
localparam SLVPORT_WSTRB_WIDTH = (SLVPORT_DATA_WIDTH / 8);
localparam SLVPORT_WSTRB_MSB = (SLVPORT_WSTRB_WIDTH - 1);
localparam BIU_ID_WIDTH = 4;
localparam BIU_ID_MSB = (BIU_ID_WIDTH - 1);
localparam VECTOR_PLIC_SUPPORT = "yes";
localparam NCE_DATA_WIDTH = (BIU_DATA_WIDTH > 64) ? 64 : BIU_DATA_WIDTH;
localparam NCE_DATA_MSB = (NCE_DATA_WIDTH - 1);
localparam NCE_WSTRB_WIDTH = (NCE_DATA_WIDTH / 8);
localparam NCE_WSTRB_MSB = (NCE_WSTRB_WIDTH - 1);
localparam DM_SYS_DATA_WIDTH = (BIU_DATA_WIDTH > 128) ? 128 : BIU_DATA_WIDTH;
localparam DM_SYS_DATA_MSB = (DM_SYS_DATA_WIDTH - 1);
localparam DM_SYS_WSTRB_WIDTH = (DM_SYS_DATA_WIDTH / 8);
localparam DM_SYS_WSTRB_MSB = (DM_SYS_WSTRB_WIDTH - 1);
localparam SIZEUP_DS_DATA_WIDTH = BIU_DATA_WIDTH;
localparam SIZEUP_DS_DATA_SIZE = $unsigned($clog2(SIZEUP_DS_DATA_WIDTH)) - 3;
localparam SIZEUP_ADDR_WIDTH = SIZEUP_DS_DATA_SIZE;
localparam SIZEUP_ADDR_MSB = (SIZEUP_ADDR_WIDTH - 1);
localparam NHART = 1;
localparam DLM_RAM_AW = 14;
localparam DLM_RAM_DW = 32;
localparam DLM_RAM_BWEW = 4;
localparam ILM_RAM_AW = 13;
localparam ILM_RAM_DW = 32;
localparam ILM_RAM_BWEW = 4;
localparam ILM_ECC_SUPPORT = "none" == "ecc";
localparam ILM_TL_UL_RAM_NUM = (XLEN == 64) ? 1 : 2;
localparam ILM_TL_UL_AW = ILM_RAM_AW + 3;
localparam ILM_TL_UL_EW = ILM_ECC_SUPPORT ? (XLEN == 64) ? 8 : 7 : 1;
localparam ILM_TL_UL_RAM_AW = ILM_RAM_AW;
localparam ILM_TL_UL_RAM_DW = (XLEN == 64) ? ILM_ECC_SUPPORT ? 72 : 64 : ILM_ECC_SUPPORT ? 39 : 32;
localparam ILM_TL_UL_RAM_BWEW = (ILM_TL_UL_RAM_DW == 39) ? 5 : ILM_TL_UL_RAM_DW / 8;
localparam PLIC_HW_TARGET_NUM = NHART * 2;
localparam PLIC_SW_TARGET_NUM = NHART;
localparam ILM_HDATA_WIDTH = XLEN;
localparam DLM_HDATA_WIDTH = XLEN;
localparam PROGBUF_SIZE = 8;
localparam HALTGROUP_COUNT = 0;
localparam PLDM_SYS_BUS_ACCESS = "yes";
output [BIU_ID_MSB:0] arid;
output [ADDR_MSB:0] araddr;
output [7:0] arlen;
output [2:0] arsize;
output [1:0] arburst;
output arlock;
output [3:0] arcache;
output [2:0] arprot;
output arvalid;
input arready;
output [BIU_ID_MSB:0] awid;
output [ADDR_MSB:0] awaddr;
output [7:0] awlen;
output [2:0] awsize;
output [1:0] awburst;
output awlock;
output [3:0] awcache;
output [2:0] awprot;
output awvalid;
input awready;
output [(BIU_DATA_WIDTH - 1):0] wdata;
output [((BIU_DATA_WIDTH / 8) - 1):0] wstrb;
output wlast;
output wvalid;
input wready;
input [BIU_ID_MSB:0] bid;
input [1:0] bresp;
input bvalid;
output bready;
input [BIU_ID_MSB:0] rid;
input [(BIU_DATA_WIDTH - 1):0] rdata;
input [1:0] rresp;
input rlast;
input rvalid;
output rready;
output [ADDR_MSB:0] dm_sys_araddr;
output [1:0] dm_sys_arburst;
output [3:0] dm_sys_arcache;
output [BIU_ID_MSB:0] dm_sys_arid;
output [7:0] dm_sys_arlen;
output dm_sys_arlock;
output [2:0] dm_sys_arprot;
input dm_sys_arready;
output [2:0] dm_sys_arsize;
output dm_sys_arvalid;
output [ADDR_MSB:0] dm_sys_awaddr;
output [1:0] dm_sys_awburst;
output [3:0] dm_sys_awcache;
output [BIU_ID_MSB:0] dm_sys_awid;
output [7:0] dm_sys_awlen;
output dm_sys_awlock;
output [2:0] dm_sys_awprot;
input dm_sys_awready;
output [2:0] dm_sys_awsize;
output dm_sys_awvalid;
input [BIU_ID_MSB:0] dm_sys_bid;
output dm_sys_bready;
input [1:0] dm_sys_bresp;
input dm_sys_bvalid;
input [(BIU_DATA_WIDTH - 1):0] dm_sys_rdata;
input [BIU_ID_MSB:0] dm_sys_rid;
input dm_sys_rlast;
output dm_sys_rready;
input [1:0] dm_sys_rresp;
input dm_sys_rvalid;
output [(BIU_DATA_WIDTH - 1):0] dm_sys_wdata;
output dm_sys_wlast;
input dm_sys_wready;
output [((BIU_DATA_WIDTH / 8) - 1):0] dm_sys_wstrb;
output dm_sys_wvalid;
//input [(NHART - 1):0] core_clk;
input [(NHART - 1):0] core_resetn;
output dbg_srst_req;
//input [(NHART - 1):0] dc_clk;
output [5:0] hart0_wakeup_event;
//input [(NHART - 1):0] lm_clk;
input [(NHART - 1):0] slvp_resetn;
input aclk;
input aresetn;
input scan_enable;
input test_mode;
input [31:1] int_src;
input mtime_clk;
input por_rstn;
output hart0_core_wfi_mode;
input hart0_nmi;
input  jtag_tck;
input  jtag_tdi;
output jtag_tdo;
input  jtag_tms;
input [31:0] margin_ctrl;
input  hart0_reset_vector;  


wire [(NHART - 1):0] dc_clk   ;
wire [(NHART - 1):0] lm_clk   ;
wire [(NHART - 1):0] core_clk ;

wire [3:0] exmon_bid_dummy;
wire [3:0] exmon_rid_dummy;
wire exmon_arready;
wire exmon_awready;
wire [(BIU_ID_WIDTH - 1):0] exmon_bid;
wire [1:0] exmon_bresp;
wire exmon_bvalid;
wire [(BIU_DATA_WIDTH - 1):0] exmon_rdata;
wire [(BIU_ID_WIDTH - 1):0] exmon_rid;
wire exmon_rlast;
wire [1:0] exmon_rresp;
wire exmon_rvalid;
wire exmon_wready;
wire [3:0] unused_arqos;
wire [3:0] unused_arregion;
wire [3:0] unused_awqos;
wire [3:0] unused_awregion;
wire [(ADDR_WIDTH - 1):0] exmon_araddr;
wire [1:0] exmon_arburst;
wire [3:0] exmon_arcache;
wire [(BIU_ID_WIDTH - 1):0] exmon_arid;
wire [3:0] exmon_arid_dummy;
wire [7:0] exmon_arlen;
wire exmon_arlock;
wire [2:0] exmon_arprot;
wire [2:0] exmon_arsize;
wire exmon_arvalid;
wire [(ADDR_WIDTH - 1):0] exmon_awaddr;
wire [1:0] exmon_awburst;
wire [3:0] exmon_awcache;
wire [(BIU_ID_WIDTH - 1):0] exmon_awid;
wire [3:0] exmon_awid_dummy;
wire [7:0] exmon_awlen;
wire exmon_awlock;
wire [2:0] exmon_awprot;
wire [2:0] exmon_awsize;
wire exmon_awvalid;
wire exmon_bready;
wire exmon_rready;
wire [(BIU_DATA_WIDTH - 1):0] exmon_wdata;
wire exmon_wlast;
wire [(BIU_DATA_WIDTH / 8) - 1:0] exmon_wstrb;
wire exmon_wvalid;
wire hart0_arready;
wire hart0_awready;
wire [BIU_ID_MSB:0] hart0_bid;
wire [1:0] hart0_bresp;
wire hart0_bvalid;
wire [BIU_DATA_MSB:0] hart0_rdata;
wire [BIU_ID_MSB:0] hart0_rid;
wire hart0_rlast;
wire [1:0] hart0_rresp;
wire hart0_rvalid;
wire hart0_wready;
wire [ADDR_MSB:0] hart0_araddr;
wire [1:0] hart0_arburst;
wire [3:0] hart0_arcache;
wire [BIU_ID_MSB:0] hart0_arid;
wire [7:0] hart0_arlen;
wire hart0_arlock;
wire [2:0] hart0_arprot;
wire [2:0] hart0_arsize;
wire hart0_arvalid;
wire [ADDR_MSB:0] hart0_awaddr;
wire [1:0] hart0_awburst;
wire [3:0] hart0_awcache;
wire [BIU_ID_MSB:0] hart0_awid;
wire [7:0] hart0_awlen;
wire hart0_awlock;
wire [2:0] hart0_awprot;
wire [2:0] hart0_awsize;
wire hart0_awvalid;
wire hart0_bready;
wire hart0_rready;
wire [BIU_DATA_MSB:0] hart0_wdata;
wire hart0_wlast;
wire [BIU_WSTRB_MSB:0] hart0_wstrb;
wire hart0_wvalid;
wire [ADDR_MSB:0] dm_araddr;
wire [1:0] dm_arburst;
wire [3:0] dm_arcache;
wire [7:0] dm_arlen;
wire dm_arlock;
wire [2:0] dm_arprot;
wire [2:0] dm_arsize;
wire [ADDR_MSB:0] dm_awaddr;
wire [1:0] dm_awburst;
wire [3:0] dm_awcache;
wire [7:0] dm_awlen;
wire dm_awlock;
wire [2:0] dm_awprot;
wire [2:0] dm_awsize;
wire [1:0] dm_sup_bresp;
wire [NCE_DATA_MSB:0] dm_wdata;
wire dm_wlast;
wire [NCE_WSTRB_MSB:0] dm_wstrb;
wire dm_arvalid;
wire dm_awvalid;
wire dm_bready;
wire dm_rready;
wire dm_wvalid;
wire dm_sup_arready;
wire dm_sup_awready;
wire [BIU_ID_MSB:0] dm_sup_bid;
wire dm_sup_bvalid;
wire [DM_SYS_DATA_MSB:0] dm_sup_rdata;
wire [BIU_ID_MSB:0] dm_sup_rid;
wire dm_sup_rlast;
wire [1:0] dm_sup_rresp;
wire dm_sup_rvalid;
wire dm_sup_wready;
wire dm_arready;
wire dm_awready;
wire [1:0] dm_bresp;
wire dm_bvalid;
wire [NCE_DATA_MSB:0] dm_rdata;
wire dm_rlast;
wire [1:0] dm_rresp;
wire dm_rvalid;
wire [ADDR_MSB:0] dm_sup_araddr;
wire [1:0] dm_sup_arburst;
wire [3:0] dm_sup_arcache;
wire [BIU_ID_MSB:0] dm_sup_arid;
wire [7:0] dm_sup_arlen;
wire dm_sup_arlock;
wire [2:0] dm_sup_arprot;
wire [2:0] dm_sup_arsize;
wire dm_sup_arvalid;
wire [ADDR_MSB:0] dm_sup_awaddr;
wire [1:0] dm_sup_awburst;
wire [3:0] dm_sup_awcache;
wire [BIU_ID_MSB:0] dm_sup_awid;
wire [7:0] dm_sup_awlen;
wire dm_sup_awlock;
wire [2:0] dm_sup_awprot;
wire [2:0] dm_sup_awsize;
wire dm_sup_awvalid;
wire dm_sup_bready;
wire dm_sup_rready;
wire [DM_SYS_DATA_MSB:0] dm_sup_wdata;
wire dm_sup_wlast;
wire [DM_SYS_WSTRB_MSB:0] dm_sup_wstrb;
wire dm_sup_wvalid;
wire dm_wready;
wire ndmreset;
wire [3:0] nds_unused_dm_bid;
wire [(NCE_DATA_WIDTH - 1):0] nds_unused_dm_hrdata;
wire nds_unused_dm_hreadyout;
wire [1:0] nds_unused_dm_hresp;
wire [3:0] nds_unused_dm_rid;
wire [(ADDR_WIDTH - 1):0] nds_unused_dm_sup_haddr;
wire [2:0] nds_unused_dm_sup_hburst;
wire nds_unused_dm_sup_hbusreq;
wire [3:0] nds_unused_dm_sup_hprot;
wire [2:0] nds_unused_dm_sup_hsize;
wire [1:0] nds_unused_dm_sup_htrans;
wire [(DM_SYS_DATA_WIDTH - 1):0] nds_unused_dm_sup_hwdata;
wire nds_unused_dm_sup_hwrite;
wire lm_local_int;
wire nds_unused_hart0_ueiack;
wire nds_unused_hart0_hart_halted;
wire [3:0] nds_unused_plicsw_bid;
wire [(NCE_DATA_WIDTH - 1):0] nds_unused_plicsw_hrdata;
wire nds_unused_plicsw_hreadyout;
wire [1:0] nds_unused_plicsw_hresp;
wire [3:0] nds_unused_plicsw_rid;
wire [9:0] nds_unused_plicsw_t0_eiid;
wire [9:0] nds_unused_plicsw_t10_eiid;
wire nds_unused_plicsw_t10_eip;
wire [9:0] nds_unused_plicsw_t11_eiid;
wire nds_unused_plicsw_t11_eip;
wire [9:0] nds_unused_plicsw_t12_eiid;
wire nds_unused_plicsw_t12_eip;
wire [9:0] nds_unused_plicsw_t13_eiid;
wire nds_unused_plicsw_t13_eip;
wire [9:0] nds_unused_plicsw_t14_eiid;
wire nds_unused_plicsw_t14_eip;
wire [9:0] nds_unused_plicsw_t15_eiid;
wire nds_unused_plicsw_t15_eip;
wire [9:0] nds_unused_plicsw_t1_eiid;
wire nds_unused_plicsw_t1_eip;
wire [9:0] nds_unused_plicsw_t2_eiid;
wire nds_unused_plicsw_t2_eip;
wire [9:0] nds_unused_plicsw_t3_eiid;
wire nds_unused_plicsw_t3_eip;
wire [9:0] nds_unused_plicsw_t4_eiid;
wire nds_unused_plicsw_t4_eip;
wire [9:0] nds_unused_plicsw_t5_eiid;
wire nds_unused_plicsw_t5_eip;
wire [9:0] nds_unused_plicsw_t6_eiid;
wire nds_unused_plicsw_t6_eip;
wire [9:0] nds_unused_plicsw_t7_eiid;
wire nds_unused_plicsw_t7_eip;
wire [9:0] nds_unused_plicsw_t8_eiid;
wire nds_unused_plicsw_t8_eip;
wire [9:0] nds_unused_plicsw_t9_eiid;
wire nds_unused_plicsw_t9_eip;
wire [(NHART - 1):0] dm_hart_unavail;
wire [(NHART - 1):0] dm_hart_under_reset;
wire hart0_bus_clk;
wire hart0_bus_clk_en;
wire hart0_dcu_clk;
wire [63:0] hart0_hart_id;
wire hart0_lm_clk;
wire hart0_slv1_clk;
wire hart0_slv1_clk_en;
wire hart0_slv1_reset_n;
wire hart0_slv_clk;
wire hart0_slv_clk_en;
wire hart0_slv_reset_n;
wire hart0_ueip;
wire [ADDR_MSB:0] plic_araddr;
wire [1:0] plic_arburst;
wire [3:0] plic_arcache;
wire [7:0] plic_arlen;
wire plic_arlock;
wire [2:0] plic_arprot;
wire [2:0] plic_arsize;
wire [ADDR_MSB:0] plic_awaddr;
wire [1:0] plic_awburst;
wire [3:0] plic_awcache;
wire [7:0] plic_awlen;
wire plic_awlock;
wire [2:0] plic_awprot;
wire [2:0] plic_awsize;
wire [NCE_DATA_MSB:0] plic_wdata;
wire plic_wlast;
wire [NCE_WSTRB_MSB:0] plic_wstrb;
wire [ADDR_MSB:0] plicsw_araddr;
wire [1:0] plicsw_arburst;
wire [3:0] plicsw_arcache;
wire [7:0] plicsw_arlen;
wire plicsw_arlock;
wire [2:0] plicsw_arprot;
wire [2:0] plicsw_arsize;
wire [ADDR_MSB:0] plicsw_awaddr;
wire [1:0] plicsw_awburst;
wire [3:0] plicsw_awcache;
wire [7:0] plicsw_awlen;
wire plicsw_awlock;
wire [2:0] plicsw_awprot;
wire [2:0] plicsw_awsize;
wire [NCE_DATA_MSB:0] plicsw_wdata;
wire plicsw_wlast;
wire [NCE_WSTRB_MSB:0] plicsw_wstrb;
wire [ADDR_MSB:0] plmt_araddr;
wire [1:0] plmt_arburst;
wire [3:0] plmt_arcache;
wire [7:0] plmt_arlen;
wire plmt_arlock;
wire [2:0] plmt_arprot;
wire [2:0] plmt_arsize;
wire [ADDR_MSB:0] plmt_awaddr;
wire [1:0] plmt_awburst;
wire [3:0] plmt_awcache;
wire [7:0] plmt_awlen;
wire plmt_awlock;
wire [2:0] plmt_awprot;
wire [2:0] plmt_awsize;
wire [NCE_DATA_MSB:0] plmt_wdata;
wire plmt_wlast;
wire [NCE_WSTRB_MSB:0] plmt_wstrb;
wire [BIU_ID_MSB:0] sdn2busdec_arid;
wire [3:0] sdn2busdec_arid_dummy;
wire [BIU_ID_MSB:0] sdn2busdec_awid;
wire [3:0] sdn2busdec_awid_dummy;
wire stoptime;
wire [NHART - 1:0] stoptime_array;
wire [ADDR_MSB:0] inter2sdn_araddr;
wire [1:0] inter2sdn_arburst;
wire [3:0] inter2sdn_arcache;
wire [BIU_ID_MSB:0] inter2sdn_arid;
wire [3:0] inter2sdn_arid_dummy;
wire [7:0] inter2sdn_arlen;
wire inter2sdn_arlock;
wire [2:0] inter2sdn_arprot;
wire [2:0] inter2sdn_arsize;
wire inter2sdn_arvalid;
wire [ADDR_MSB:0] inter2sdn_awaddr;
wire [1:0] inter2sdn_awburst;
wire [3:0] inter2sdn_awcache;
wire [BIU_ID_MSB:0] inter2sdn_awid;
wire [3:0] inter2sdn_awid_dummy;
wire [7:0] inter2sdn_awlen;
wire inter2sdn_awlock;
wire [2:0] inter2sdn_awprot;
wire [2:0] inter2sdn_awsize;
wire inter2sdn_awvalid;
wire inter2sdn_bready;
wire inter2sdn_rready;
wire [BIU_DATA_MSB:0] inter2sdn_wdata;
wire inter2sdn_wlast;
wire [BIU_WSTRB_MSB:0] inter2sdn_wstrb;
wire inter2sdn_wvalid;
wire [ADDR_MSB:0] busdec2nce_araddr;
wire [1:0] busdec2nce_arburst;
wire [3:0] busdec2nce_arcache;
wire [7:0] busdec2nce_arlen;
wire busdec2nce_arlock;
wire [2:0] busdec2nce_arprot;
wire [2:0] busdec2nce_arsize;
wire [ADDR_MSB:0] busdec2nce_awaddr;
wire [1:0] busdec2nce_awburst;
wire [3:0] busdec2nce_awcache;
wire [7:0] busdec2nce_awlen;
wire busdec2nce_awlock;
wire [2:0] busdec2nce_awprot;
wire [2:0] busdec2nce_awsize;
wire [NCE_DATA_MSB:0] busdec2nce_wdata;
wire busdec2nce_wlast;
wire [NCE_WSTRB_MSB:0] busdec2nce_wstrb;
wire plic_arvalid;
wire plic_awvalid;
wire plic_bready;
wire plic_rready;
wire plic_wvalid;
wire plicsw_arvalid;
wire plicsw_awvalid;
wire plicsw_bready;
wire plicsw_rready;
wire plicsw_wvalid;
wire plmt_arvalid;
wire plmt_awvalid;
wire plmt_bready;
wire plmt_rready;
wire plmt_wvalid;
wire sdn2busdec_arready;
wire sdn2busdec_awready;
wire [BIU_ID_MSB:0] sdn2busdec_bid;
wire [3:0] sdn2busdec_bid_dummy;
wire [1:0] sdn2busdec_bresp;
wire sdn2busdec_bvalid;
wire [NCE_DATA_MSB:0] sdn2busdec_rdata;
wire [BIU_ID_MSB:0] sdn2busdec_rid;
wire [3:0] sdn2busdec_rid_dummy;
wire sdn2busdec_rlast;
wire [1:0] sdn2busdec_rresp;
wire sdn2busdec_rvalid;
wire sdn2busdec_wready;
wire inter2sdn_arready;
wire inter2sdn_awready;
wire [BIU_ID_MSB:0] inter2sdn_bid;
wire [3:0] inter2sdn_bid_dummy;
wire [1:0] inter2sdn_bresp;
wire inter2sdn_bvalid;
wire [BIU_DATA_MSB:0] inter2sdn_rdata;
wire [BIU_ID_MSB:0] inter2sdn_rid;
wire [3:0] inter2sdn_rid_dummy;
wire inter2sdn_rlast;
wire [1:0] inter2sdn_rresp;
wire inter2sdn_rvalid;
wire inter2sdn_wready;
wire [ADDR_MSB:0] sdn2busdec_araddr;
wire [1:0] sdn2busdec_arburst;
wire [3:0] sdn2busdec_arcache;
wire [7:0] sdn2busdec_arlen;
wire sdn2busdec_arlock;
wire [2:0] sdn2busdec_arprot;
wire [2:0] sdn2busdec_arsize;
wire sdn2busdec_arvalid;
wire [ADDR_MSB:0] sdn2busdec_awaddr;
wire [1:0] sdn2busdec_awburst;
wire [3:0] sdn2busdec_awcache;
wire [7:0] sdn2busdec_awlen;
wire sdn2busdec_awlock;
wire [2:0] sdn2busdec_awprot;
wire [2:0] sdn2busdec_awsize;
wire sdn2busdec_awvalid;
wire sdn2busdec_bready;
wire sdn2busdec_rready;
wire [NCE_DATA_MSB:0] sdn2busdec_wdata;
wire sdn2busdec_wlast;
wire [NCE_WSTRB_MSB:0] sdn2busdec_wstrb;
wire sdn2busdec_wvalid;
wire hart0_debugint;
wire hart0_meiack;
wire hart0_seiack;
wire hart0_stoptime;
wire plic_hart0_meiack;
wire hart0_meip;
wire hart0_msip;
wire hart0_mtip;
wire [(NHART - 1):0] dm_debugint;
wire [(NHART - 1):0] dm_resethaltreq;
wire [9:0] hart0_meiid;
wire [9:0] hart0_seiid;
wire [3:0] nds_unused_plic_bid;
wire [(NCE_DATA_WIDTH - 1):0] nds_unused_plic_hrdata;
wire nds_unused_plic_hreadyout;
wire [1:0] nds_unused_plic_hresp;
wire [3:0] nds_unused_plic_rid;
wire [9:0] nds_unused_plic_t10_eiid;
wire nds_unused_plic_t10_eip;
wire [9:0] nds_unused_plic_t11_eiid;
wire nds_unused_plic_t11_eip;
wire [9:0] nds_unused_plic_t12_eiid;
wire nds_unused_plic_t12_eip;
wire [9:0] nds_unused_plic_t13_eiid;
wire nds_unused_plic_t13_eip;
wire [9:0] nds_unused_plic_t14_eiid;
wire nds_unused_plic_t14_eip;
wire [9:0] nds_unused_plic_t15_eiid;
wire nds_unused_plic_t15_eip;
wire [9:0] nds_unused_plic_t2_eiid;
wire nds_unused_plic_t2_eip;
wire [9:0] nds_unused_plic_t3_eiid;
wire nds_unused_plic_t3_eip;
wire [9:0] nds_unused_plic_t4_eiid;
wire nds_unused_plic_t4_eip;
wire [9:0] nds_unused_plic_t5_eiid;
wire nds_unused_plic_t5_eip;
wire [9:0] nds_unused_plic_t6_eiid;
wire nds_unused_plic_t6_eip;
wire [9:0] nds_unused_plic_t7_eiid;
wire nds_unused_plic_t7_eip;
wire [9:0] nds_unused_plic_t8_eiid;
wire nds_unused_plic_t8_eip;
wire [9:0] nds_unused_plic_t9_eiid;
wire nds_unused_plic_t9_eip;
wire plic_arready;
wire plic_awready;
wire [1:0] plic_bresp;
wire plic_bvalid;
wire plic_hart0_meip;
wire plic_hart0_seip;
wire [NCE_DATA_MSB:0] plic_rdata;
wire plic_rlast;
wire [1:0] plic_rresp;
wire plic_rvalid;
wire plic_wready;
wire plicsw_arready;
wire plicsw_awready;
wire [1:0] plicsw_bresp;
wire plicsw_bvalid;
wire plicsw_hart0_msip;
wire [NCE_DATA_MSB:0] plicsw_rdata;
wire plicsw_rlast;
wire [1:0] plicsw_rresp;
wire plicsw_rvalid;
wire plicsw_wready;
wire [NHART - 1:0] mtip;
wire [3:0] nds_unused_plmt_bid;
wire [(NCE_DATA_WIDTH - 1):0] nds_unused_plmt_hrdata;
wire nds_unused_plmt_hreadyout;
wire [1:0] nds_unused_plmt_hresp;
wire [3:0] nds_unused_plmt_rid;
wire plmt_arready;
wire plmt_awready;
wire [1:0] plmt_bresp;
wire plmt_bvalid;
wire [NCE_DATA_MSB:0] plmt_rdata;
wire plmt_rlast;
wire [1:0] plmt_rresp;
wire plmt_rvalid;
wire plmt_wready;
wire plic_hart0_seiack;
wire hart0_seip;
wire hart0_core_clk;
wire hart0_core_reset_n;
wire hart0_resethaltreq;
wire hart0_unavail;
wire hart0_under_reset;
wire [(VALEN - 1):0] hart0_reset_vector;
wire [31:0] margin_ctrl;
wire  [2:0] dti_1pr_rwm;
wire  [2:0] dti_sp_rwm;
wire  [2:0] dti_sp_dly;
wire                                                    dmactive;
wire                                             [ 8:0] dmi_haddr;
wire                                             [ 2:0] dmi_hburst;
wire                                             [ 3:0] dmi_hprot;
wire                                             [31:0] dmi_hrdata;
wire                                                    dmi_hready;
wire                                             [ 1:0] dmi_hresp;
wire                                                    dmi_hsel;
wire                                             [ 2:0] dmi_hsize;
wire                                             [ 1:0] dmi_htrans;
wire                                             [31:0] dmi_hwdata;
wire                                                    dmi_hwrite;
wire                                                    dmi_resetn;
wire                                             [31:0] dmi_haddr_32w;

wire axi_bus_clk_en;
wire hart0_icache_disable_init;
wire hart0_dcache_disable_init;

assign dc_clk[0]   = aclk ;
assign lm_clk[0]   = aclk ;
assign core_clk[0] = aclk ;


assign dti_1pr_rwm = margin_ctrl[8:6];
assign dti_sp_rwm  = margin_ctrl[2:0];
assign dti_sp_dly  = margin_ctrl[17:15];

assign axi_bus_clk_en     = 1'b1;
assign hart0_icache_disable_init = 1'b0;
assign hart0_dcache_disable_init = 1'b0;

assign hart0_core_clk = core_clk[0];
assign hart0_core_reset_n = core_resetn[0];
assign hart0_slv_reset_n = slvp_resetn[0];
assign hart0_slv1_reset_n = slvp_resetn[0];
assign hart0_bus_clk_en = axi_bus_clk_en;
assign hart0_bus_clk = aclk;
assign hart0_slv_clk_en = axi_bus_clk_en;
assign hart0_slv_clk = aclk;
assign hart0_slv1_clk_en = axi_bus_clk_en;
assign hart0_slv1_clk = aclk;
assign hart0_lm_clk = lm_clk[0];
assign hart0_dcu_clk = dc_clk[0];
assign hart0_ueip = 1'b0;
assign hart0_wakeup_event = {(plic_hart0_meip | lm_local_int),plic_hart0_seip,1'b0,mtip[0],plicsw_hart0_msip,dm_debugint[0]};
assign exmon_bid_dummy = 4'b0;
assign exmon_rid_dummy = 4'b0;
generate
    if (BIU_DATA_WIDTH > NCE_DATA_WIDTH) begin:gen_connect_axi_sdn
        assign {sdn2busdec_arid,sdn2busdec_arid_dummy} = {(BIU_ID_WIDTH + 4){1'b0}};
        assign {sdn2busdec_awid,sdn2busdec_awid_dummy} = {(BIU_ID_WIDTH + 4){1'b0}};
    end
    else begin:gen_connect_axi
        assign sdn2busdec_araddr = inter2sdn_araddr;
        assign sdn2busdec_arburst = inter2sdn_arburst;
        assign sdn2busdec_arcache = inter2sdn_arcache;
        assign {sdn2busdec_arid,sdn2busdec_arid_dummy} = {inter2sdn_arid,inter2sdn_arid_dummy};
        assign sdn2busdec_arlen = inter2sdn_arlen;
        assign sdn2busdec_arlock = inter2sdn_arlock;
        assign sdn2busdec_arprot = inter2sdn_arprot;
        assign sdn2busdec_arsize = inter2sdn_arsize;
        assign sdn2busdec_arvalid = inter2sdn_arvalid;
        assign inter2sdn_arready = sdn2busdec_arready;
        assign sdn2busdec_awaddr = inter2sdn_awaddr;
        assign sdn2busdec_awburst = inter2sdn_awburst;
        assign sdn2busdec_awcache = inter2sdn_awcache;
        assign {sdn2busdec_awid,sdn2busdec_awid_dummy} = {inter2sdn_awid,inter2sdn_awid_dummy};
        assign sdn2busdec_awlen = inter2sdn_awlen;
        assign sdn2busdec_awlock = inter2sdn_awlock;
        assign sdn2busdec_awprot = inter2sdn_awprot;
        assign sdn2busdec_awsize = inter2sdn_awsize;
        assign sdn2busdec_awvalid = inter2sdn_awvalid;
        assign inter2sdn_awready = sdn2busdec_awready;
        assign {inter2sdn_bid,inter2sdn_bid_dummy} = {sdn2busdec_bid,sdn2busdec_bid_dummy};
        assign inter2sdn_bresp = sdn2busdec_bresp;
        assign inter2sdn_bvalid = sdn2busdec_bvalid;
        assign sdn2busdec_bready = inter2sdn_bready;
        assign inter2sdn_rdata = sdn2busdec_rdata;
        assign {inter2sdn_rid,inter2sdn_rid_dummy} = {sdn2busdec_rid,sdn2busdec_rid_dummy};
        assign inter2sdn_rlast = sdn2busdec_rlast;
        assign inter2sdn_rresp = sdn2busdec_rresp;
        assign inter2sdn_rvalid = sdn2busdec_rvalid;
        assign sdn2busdec_rready = inter2sdn_rready;
        assign sdn2busdec_wdata = inter2sdn_wdata;
        assign sdn2busdec_wlast = inter2sdn_wlast;
        assign sdn2busdec_wstrb = inter2sdn_wstrb;
        assign sdn2busdec_wvalid = inter2sdn_wvalid;
        assign inter2sdn_wready = sdn2busdec_wready;
    end
endgenerate
assign plic_awaddr = busdec2nce_awaddr;
assign plic_awlen = busdec2nce_awlen;
assign plic_awsize = busdec2nce_awsize;
assign plic_awburst = busdec2nce_awburst;
assign plic_awlock = busdec2nce_awlock;
assign plic_awcache = busdec2nce_awcache;
assign plic_awprot = busdec2nce_awprot;
assign plic_wdata = busdec2nce_wdata;
assign plic_wstrb = busdec2nce_wstrb;
assign plic_wlast = busdec2nce_wlast;
assign plic_araddr = busdec2nce_araddr;
assign plic_arlen = busdec2nce_arlen;
assign plic_arsize = busdec2nce_arsize;
assign plic_arburst = busdec2nce_arburst;
assign plic_arlock = busdec2nce_arlock;
assign plic_arcache = busdec2nce_arcache;
assign plic_arprot = busdec2nce_arprot;
assign plmt_awaddr = busdec2nce_awaddr;
assign plmt_awlen = busdec2nce_awlen;
assign plmt_awsize = busdec2nce_awsize;
assign plmt_awburst = busdec2nce_awburst;
assign plmt_awlock = busdec2nce_awlock;
assign plmt_awcache = busdec2nce_awcache;
assign plmt_awprot = busdec2nce_awprot;
assign plmt_wdata = busdec2nce_wdata;
assign plmt_wstrb = busdec2nce_wstrb;
assign plmt_wlast = busdec2nce_wlast;
assign plmt_araddr = busdec2nce_araddr;
assign plmt_arlen = busdec2nce_arlen;
assign plmt_arsize = busdec2nce_arsize;
assign plmt_arburst = busdec2nce_arburst;
assign plmt_arlock = busdec2nce_arlock;
assign plmt_arcache = busdec2nce_arcache;
assign plmt_arprot = busdec2nce_arprot;
assign plicsw_awaddr = busdec2nce_awaddr;
assign plicsw_awlen = busdec2nce_awlen;
assign plicsw_awsize = busdec2nce_awsize;
assign plicsw_awburst = busdec2nce_awburst;
assign plicsw_awlock = busdec2nce_awlock;
assign plicsw_awcache = busdec2nce_awcache;
assign plicsw_awprot = busdec2nce_awprot;
assign plicsw_wdata = busdec2nce_wdata;
assign plicsw_wstrb = busdec2nce_wstrb;
assign plicsw_wlast = busdec2nce_wlast;
assign plicsw_araddr = busdec2nce_araddr;
assign plicsw_arlen = busdec2nce_arlen;
assign plicsw_arsize = busdec2nce_arsize;
assign plicsw_arburst = busdec2nce_arburst;
assign plicsw_arlock = busdec2nce_arlock;
assign plicsw_arcache = busdec2nce_arcache;
assign plicsw_arprot = busdec2nce_arprot;
assign dm_awaddr = busdec2nce_awaddr;
assign dm_awlen = busdec2nce_awlen;
assign dm_awsize = busdec2nce_awsize;
assign dm_awburst = busdec2nce_awburst;
assign dm_awlock = busdec2nce_awlock;
assign dm_awcache = busdec2nce_awcache;
assign dm_awprot = busdec2nce_awprot;
assign dm_wdata = busdec2nce_wdata;
assign dm_wstrb = busdec2nce_wstrb;
assign dm_wlast = busdec2nce_wlast;
assign dm_araddr = busdec2nce_araddr;
assign dm_arlen = busdec2nce_arlen;
assign dm_arsize = busdec2nce_arsize;
assign dm_arburst = busdec2nce_arburst;
assign dm_arlock = busdec2nce_arlock;
assign dm_arcache = busdec2nce_arcache;
assign dm_arprot = busdec2nce_arprot;
assign stoptime_array[0] = hart0_stoptime;
assign stoptime = |stoptime_array;
generate
    if (BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH) begin:gen_connect_axi_dm_sup
        assign dm_sys_araddr = dm_sup_araddr;
        assign dm_sys_arburst = dm_sup_arburst;
        assign dm_sys_arcache = dm_sup_arcache;
        assign dm_sys_arid = {BIU_ID_WIDTH{1'b0}};
        assign dm_sys_arlen = dm_sup_arlen;
        assign dm_sys_arlock = dm_sup_arlock;
        assign dm_sys_arprot = dm_sup_arprot;
        assign dm_sys_arsize = dm_sup_arsize;
        assign dm_sys_awaddr = dm_sup_awaddr;
        assign dm_sys_awburst = dm_sup_awburst;
        assign dm_sys_awcache = dm_sup_awcache;
        assign dm_sys_awid = {BIU_ID_WIDTH{1'b0}};
        assign dm_sys_awlen = dm_sup_awlen;
        assign dm_sys_awlock = dm_sup_awlock;
        assign dm_sys_awprot = dm_sup_awprot;
        assign dm_sys_awsize = dm_sup_awsize;
        assign dm_sup_bresp = dm_sys_bresp;
    end
    else begin:gen_connect_axi_dm
        assign dm_sup_arready = dm_sys_arready;
        assign dm_sup_awready = dm_sys_awready;
        assign dm_sup_rvalid = dm_sys_rvalid;
        assign dm_sup_rdata = dm_sys_rdata;
        assign dm_sup_rid = dm_sys_rid;
        assign dm_sup_rlast = dm_sys_rlast;
        assign dm_sup_rresp = dm_sys_rresp;
        assign dm_sup_wready = dm_sys_wready;
        assign dm_sup_bvalid = dm_sys_bvalid;
        assign dm_sup_bid = dm_sys_bid;
        assign dm_sup_bresp = dm_sys_bresp;
        assign dm_sys_araddr = dm_sup_araddr;
        assign dm_sys_arburst = dm_sup_arburst;
        assign dm_sys_arcache = dm_sup_arcache;
        assign dm_sys_arid = dm_sup_arid;
        assign dm_sys_arlen = dm_sup_arlen;
        assign dm_sys_arlock = dm_sup_arlock;
        assign dm_sys_arprot = dm_sup_arprot;
        assign dm_sys_arsize = dm_sup_arsize;
        assign dm_sys_arvalid = dm_sup_arvalid;
        assign dm_sys_awaddr = dm_sup_awaddr;
        assign dm_sys_awburst = dm_sup_awburst;
        assign dm_sys_awcache = dm_sup_awcache;
        assign dm_sys_awid = dm_sup_awid;
        assign dm_sys_awlen = dm_sup_awlen;
        assign dm_sys_awlock = dm_sup_awlock;
        assign dm_sys_awprot = dm_sup_awprot;
        assign dm_sys_awsize = dm_sup_awsize;
        assign dm_sys_awvalid = dm_sup_awvalid;
        assign dm_sys_rready = dm_sup_rready;
        assign dm_sys_wdata = dm_sup_wdata;
        assign dm_sys_wlast = dm_sup_wlast;
        assign dm_sys_wstrb = dm_sup_wstrb;
        assign dm_sys_wvalid = dm_sup_wvalid;
        assign dm_sys_bready = dm_sup_bready;
    end
endgenerate
assign dbg_srst_req = ndmreset;
assign hart0_hart_id = 64'd0;
assign dm_hart_unavail[0] = hart0_unavail;
assign dm_hart_under_reset[0] = hart0_under_reset;
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_debugint_connection
        assign hart0_debugint = dm_debugint[0];
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_resethaltreq_connection
        assign hart0_resethaltreq = dm_resethaltreq[0];
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_seip_connection
        assign hart0_seip = plic_hart0_seip;
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_seiack_connection
        assign plic_hart0_seiack = hart0_seiack;
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_meip_connection
        assign hart0_meip = plic_hart0_meip;
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_meiack_connection
        assign plic_hart0_meiack = hart0_meiack;
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_msip_connection
        assign hart0_msip = plicsw_hart0_msip;
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 0) begin:gen_mtip_connection
        assign hart0_mtip = mtip[0];
    end
endgenerate
atcbmc301 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(BIU_DATA_WIDTH)
) u_axi_bmc_x1 (
    .us0_araddr(hart0_araddr[ADDR_MSB:0]),
    .us0_arburst(hart0_arburst),
    .us0_arcache(hart0_arcache),
    .us0_arid(hart0_arid),
    .us0_arlen(hart0_arlen),
    .us0_arlock(hart0_arlock),
    .us0_arprot(hart0_arprot),
    .us0_arready(hart0_arready),
    .us0_arsize(hart0_arsize),
    .us0_arvalid(hart0_arvalid),
    .us0_awaddr(hart0_awaddr[ADDR_MSB:0]),
    .us0_awburst(hart0_awburst),
    .us0_awcache(hart0_awcache),
    .us0_awid(hart0_awid),
    .us0_awlen(hart0_awlen),
    .us0_awlock(hart0_awlock),
    .us0_awprot(hart0_awprot),
    .us0_awready(hart0_awready),
    .us0_awsize(hart0_awsize),
    .us0_awvalid(hart0_awvalid),
    .us0_bid(hart0_bid),
    .us0_bready(hart0_bready),
    .us0_bresp(hart0_bresp),
    .us0_bvalid(hart0_bvalid),
    .us0_rdata(hart0_rdata),
    .us0_rid(hart0_rid),
    .us0_rlast(hart0_rlast),
    .us0_rready(hart0_rready),
    .us0_rresp(hart0_rresp),
    .us0_rvalid(hart0_rvalid),
    .us0_wdata(hart0_wdata),
    .us0_wlast(hart0_wlast),
    .us0_wready(hart0_wready),
    .us0_wstrb(hart0_wstrb),
    .us0_wvalid(hart0_wvalid),
    .ds1_araddr(inter2sdn_araddr),
    .ds1_arburst(inter2sdn_arburst),
    .ds1_arcache(inter2sdn_arcache),
    .ds1_arid({inter2sdn_arid,inter2sdn_arid_dummy}),
    .ds1_arlen(inter2sdn_arlen),
    .ds1_arlock(inter2sdn_arlock),
    .ds1_arprot(inter2sdn_arprot),
    .ds1_arready(inter2sdn_arready),
    .ds1_arsize(inter2sdn_arsize),
    .ds1_arvalid(inter2sdn_arvalid),
    .ds1_awaddr(inter2sdn_awaddr),
    .ds1_awburst(inter2sdn_awburst),
    .ds1_awcache(inter2sdn_awcache),
    .ds1_awid({inter2sdn_awid,inter2sdn_awid_dummy}),
    .ds1_awlen(inter2sdn_awlen),
    .ds1_awlock(inter2sdn_awlock),
    .ds1_awprot(inter2sdn_awprot),
    .ds1_awready(inter2sdn_awready),
    .ds1_awsize(inter2sdn_awsize),
    .ds1_awvalid(inter2sdn_awvalid),
    .ds1_bid({inter2sdn_bid,inter2sdn_bid_dummy}),
    .ds1_bready(inter2sdn_bready),
    .ds1_bresp(inter2sdn_bresp),
    .ds1_bvalid(inter2sdn_bvalid),
    .ds1_rdata(inter2sdn_rdata),
    .ds1_rid({inter2sdn_rid,inter2sdn_rid_dummy}),
    .ds1_rlast(inter2sdn_rlast),
    .ds1_rready(inter2sdn_rready),
    .ds1_rresp(inter2sdn_rresp),
    .ds1_rvalid(inter2sdn_rvalid),
    .ds1_wdata(inter2sdn_wdata),
    .ds1_wlast(inter2sdn_wlast),
    .ds1_wready(inter2sdn_wready),
    .ds1_wstrb(inter2sdn_wstrb),
    .ds1_wvalid(inter2sdn_wvalid),
    .ds2_araddr(exmon_araddr),
    .ds2_arburst(exmon_arburst),
    .ds2_arcache(exmon_arcache),
    .ds2_arid({exmon_arid,exmon_arid_dummy}),
    .ds2_arlen(exmon_arlen),
    .ds2_arlock(exmon_arlock),
    .ds2_arprot(exmon_arprot),
    .ds2_arready(exmon_arready),
    .ds2_arsize(exmon_arsize),
    .ds2_arvalid(exmon_arvalid),
    .ds2_awaddr(exmon_awaddr),
    .ds2_awburst(exmon_awburst),
    .ds2_awcache(exmon_awcache),
    .ds2_awid({exmon_awid,exmon_awid_dummy}),
    .ds2_awlen(exmon_awlen),
    .ds2_awlock(exmon_awlock),
    .ds2_awprot(exmon_awprot),
    .ds2_awready(exmon_awready),
    .ds2_awsize(exmon_awsize),
    .ds2_awvalid(exmon_awvalid),
    .ds2_bid({exmon_bid,exmon_bid_dummy}),
    .ds2_bready(exmon_bready),
    .ds2_bresp(exmon_bresp),
    .ds2_bvalid(exmon_bvalid),
    .ds2_rdata(exmon_rdata),
    .ds2_rid({exmon_rid,exmon_rid_dummy}),
    .ds2_rlast(exmon_rlast),
    .ds2_rready(exmon_rready),
    .ds2_rresp(exmon_rresp),
    .ds2_rvalid(exmon_rvalid),
    .ds2_wdata(exmon_wdata),
    .ds2_wlast(exmon_wlast),
    .ds2_wready(exmon_wready),
    .ds2_wstrb(exmon_wstrb),
    .ds2_wvalid(exmon_wvalid),
    .aclk(aclk),
    .aresetn(aresetn)
);
atcexmon300 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(BIU_DATA_WIDTH),
    .ID_WIDTH(BIU_ID_WIDTH),
    .NUM_EX_SEQ(2)
) u_atcexmon300 (
    .aclk(aclk),
    .aresetn(aresetn),
    .us_awid(exmon_awid),
    .us_awaddr(exmon_awaddr),
    .us_awlock(exmon_awlock),
    .us_awburst(exmon_awburst),
    .us_awlen(exmon_awlen),
    .us_awcache(exmon_awcache),
    .us_awprot(exmon_awprot),
    .us_awsize(exmon_awsize),
    .us_awqos(4'b0),
    .us_awregion(4'b0),
    .us_awvalid(exmon_awvalid),
    .us_awready(exmon_awready),
    .us_wdata(exmon_wdata),
    .us_wstrb(exmon_wstrb),
    .us_wlast(exmon_wlast),
    .us_wvalid(exmon_wvalid),
    .us_wready(exmon_wready),
    .us_bresp(exmon_bresp),
    .us_bid(exmon_bid),
    .us_bvalid(exmon_bvalid),
    .us_bready(exmon_bready),
    .us_arid(exmon_arid),
    .us_araddr(exmon_araddr),
    .us_arlock(exmon_arlock),
    .us_arburst(exmon_arburst),
    .us_arlen(exmon_arlen),
    .us_arcache(exmon_arcache),
    .us_arprot(exmon_arprot),
    .us_arsize(exmon_arsize),
    .us_arqos(4'b0),
    .us_arregion(4'b0),
    .us_arvalid(exmon_arvalid),
    .us_arready(exmon_arready),
    .us_rid(exmon_rid),
    .us_rresp(exmon_rresp),
    .us_rdata(exmon_rdata),
    .us_rlast(exmon_rlast),
    .us_rvalid(exmon_rvalid),
    .us_rready(exmon_rready),
    .ds_awid(awid),
    .ds_awaddr(awaddr),
    .ds_awlock(awlock),
    .ds_awburst(awburst),
    .ds_awlen(awlen),
    .ds_awcache(awcache),
    .ds_awprot(awprot),
    .ds_awsize(awsize),
    .ds_awqos(unused_awqos),
    .ds_awregion(unused_awregion),
    .ds_awvalid(awvalid),
    .ds_awready(awready),
    .ds_wdata(wdata),
    .ds_wstrb(wstrb),
    .ds_wlast(wlast),
    .ds_wvalid(wvalid),
    .ds_wready(wready),
    .ds_bresp(bresp),
    .ds_bid(bid),
    .ds_bvalid(bvalid),
    .ds_bready(bready),
    .ds_arid(arid),
    .ds_araddr(araddr),
    .ds_arlock(arlock),
    .ds_arburst(arburst),
    .ds_arlen(arlen),
    .ds_arcache(arcache),
    .ds_arprot(arprot),
    .ds_arsize(arsize),
    .ds_arqos(unused_arqos),
    .ds_arregion(unused_arregion),
    .ds_arvalid(arvalid),
    .ds_arready(arready),
    .ds_rid(rid),
    .ds_rresp(rresp),
    .ds_rdata(rdata),
    .ds_rlast(rlast),
    .ds_rvalid(rvalid),
    .ds_rready(rready)
);
generate
    if ((BIU_DATA_WIDTH > NCE_DATA_WIDTH)) begin:gen_axi_sdn
        atcsizedn300 #(
            .ADDR_WIDTH(ADDR_WIDTH),
            .DS_DATA_WIDTH(NCE_DATA_WIDTH),
            .ID_WIDTH(BIU_ID_WIDTH + 4),
            .US_DATA_WIDTH(BIU_DATA_WIDTH)
        ) u_axi_sdn (
            .ds_bready(sdn2busdec_bready),
            .ds_bresp(sdn2busdec_bresp),
            .ds_bvalid(sdn2busdec_bvalid),
            .ds_rdata(sdn2busdec_rdata),
            .ds_rlast(sdn2busdec_rlast),
            .ds_rready(sdn2busdec_rready),
            .ds_rresp(sdn2busdec_rresp),
            .ds_rvalid(sdn2busdec_rvalid),
            .ds_wdata(sdn2busdec_wdata),
            .ds_wlast(sdn2busdec_wlast),
            .ds_wready(sdn2busdec_wready),
            .ds_wstrb(sdn2busdec_wstrb),
            .ds_wvalid(sdn2busdec_wvalid),
            .us_bid({inter2sdn_bid,inter2sdn_bid_dummy}),
            .us_bready(inter2sdn_bready),
            .us_bresp(inter2sdn_bresp),
            .us_bvalid(inter2sdn_bvalid),
            .us_rdata(inter2sdn_rdata),
            .us_rid({inter2sdn_rid,inter2sdn_rid_dummy}),
            .us_rlast(inter2sdn_rlast),
            .us_rready(inter2sdn_rready),
            .us_rresp(inter2sdn_rresp),
            .us_rvalid(inter2sdn_rvalid),
            .us_wdata(inter2sdn_wdata),
            .us_wlast(inter2sdn_wlast),
            .us_wready(inter2sdn_wready),
            .us_wstrb(inter2sdn_wstrb),
            .us_wvalid(inter2sdn_wvalid),
            .ds_arready(sdn2busdec_arready),
            .aclk(aclk),
            .aresetn(aresetn),
            .ds_awready(sdn2busdec_awready),
            .ds_araddr(sdn2busdec_araddr),
            .ds_arburst(sdn2busdec_arburst),
            .ds_arcache(sdn2busdec_arcache),
            .ds_arlen(sdn2busdec_arlen),
            .ds_arlock(sdn2busdec_arlock),
            .ds_arprot(sdn2busdec_arprot),
            .ds_arsize(sdn2busdec_arsize),
            .ds_arvalid(sdn2busdec_arvalid),
            .us_araddr(inter2sdn_araddr),
            .us_arburst(inter2sdn_arburst),
            .us_arcache(inter2sdn_arcache),
            .us_arid({inter2sdn_arid,inter2sdn_arid_dummy}),
            .us_arlen(inter2sdn_arlen),
            .us_arlock(inter2sdn_arlock),
            .us_arprot(inter2sdn_arprot),
            .us_arready(inter2sdn_arready),
            .us_arsize(inter2sdn_arsize),
            .us_arvalid(inter2sdn_arvalid),
            .ds_awaddr(sdn2busdec_awaddr),
            .ds_awburst(sdn2busdec_awburst),
            .ds_awcache(sdn2busdec_awcache),
            .ds_awlen(sdn2busdec_awlen),
            .ds_awlock(sdn2busdec_awlock),
            .ds_awprot(sdn2busdec_awprot),
            .ds_awsize(sdn2busdec_awsize),
            .ds_awvalid(sdn2busdec_awvalid),
            .us_awaddr(inter2sdn_awaddr),
            .us_awburst(inter2sdn_awburst),
            .us_awcache(inter2sdn_awcache),
            .us_awid({inter2sdn_awid,inter2sdn_awid_dummy}),
            .us_awlen(inter2sdn_awlen),
            .us_awlock(inter2sdn_awlock),
            .us_awprot(inter2sdn_awprot),
            .us_awready(inter2sdn_awready),
            .us_awsize(inter2sdn_awsize),
            .us_awvalid(inter2sdn_awvalid)
        );
    end
endgenerate
atcbusdec301 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(NCE_DATA_WIDTH),
    .ID_WIDTH(BIU_ID_WIDTH + 4)
) u_axi_busdec (
    .ds1_awvalid(plic_awvalid),
    .ds1_awready(plic_awready),
    .ds1_wvalid(plic_wvalid),
    .ds1_wready(plic_wready),
    .ds1_bresp(plic_bresp),
    .ds1_bvalid(plic_bvalid),
    .ds1_bready(plic_bready),
    .ds1_arvalid(plic_arvalid),
    .ds1_arready(plic_arready),
    .ds1_rdata(plic_rdata),
    .ds1_rresp(plic_rresp),
    .ds1_rlast(plic_rlast),
    .ds1_rvalid(plic_rvalid),
    .ds1_rready(plic_rready),
    .ds2_awvalid(plmt_awvalid),
    .ds2_awready(plmt_awready),
    .ds2_wvalid(plmt_wvalid),
    .ds2_wready(plmt_wready),
    .ds2_bresp(plmt_bresp),
    .ds2_bvalid(plmt_bvalid),
    .ds2_bready(plmt_bready),
    .ds2_arvalid(plmt_arvalid),
    .ds2_arready(plmt_arready),
    .ds2_rdata(plmt_rdata),
    .ds2_rresp(plmt_rresp),
    .ds2_rlast(plmt_rlast),
    .ds2_rvalid(plmt_rvalid),
    .ds2_rready(plmt_rready),
    .ds3_awvalid(plicsw_awvalid),
    .ds3_awready(plicsw_awready),
    .ds3_wvalid(plicsw_wvalid),
    .ds3_wready(plicsw_wready),
    .ds3_bresp(plicsw_bresp),
    .ds3_bvalid(plicsw_bvalid),
    .ds3_bready(plicsw_bready),
    .ds3_arvalid(plicsw_arvalid),
    .ds3_arready(plicsw_arready),
    .ds3_rdata(plicsw_rdata),
    .ds3_rresp(plicsw_rresp),
    .ds3_rlast(plicsw_rlast),
    .ds3_rvalid(plicsw_rvalid),
    .ds3_rready(plicsw_rready),
    .ds4_awvalid(dm_awvalid),
    .ds4_awready(dm_awready),
    .ds4_wvalid(dm_wvalid),
    .ds4_wready(dm_wready),
    .ds4_bresp(dm_bresp),
    .ds4_bvalid(dm_bvalid),
    .ds4_bready(dm_bready),
    .ds4_arvalid(dm_arvalid),
    .ds4_arready(dm_arready),
    .ds4_rdata(dm_rdata),
    .ds4_rresp(dm_rresp),
    .ds4_rlast(dm_rlast),
    .ds4_rvalid(dm_rvalid),
    .ds4_rready(dm_rready),
    .ds_awaddr(busdec2nce_awaddr),
    .ds_awlen(busdec2nce_awlen),
    .ds_awsize(busdec2nce_awsize),
    .ds_awburst(busdec2nce_awburst),
    .ds_awlock(busdec2nce_awlock),
    .ds_awcache(busdec2nce_awcache),
    .ds_awprot(busdec2nce_awprot),
    .ds_wdata(busdec2nce_wdata),
    .ds_wstrb(busdec2nce_wstrb),
    .ds_wlast(busdec2nce_wlast),
    .ds_araddr(busdec2nce_araddr),
    .ds_arlen(busdec2nce_arlen),
    .ds_arsize(busdec2nce_arsize),
    .ds_arburst(busdec2nce_arburst),
    .ds_arlock(busdec2nce_arlock),
    .ds_arcache(busdec2nce_arcache),
    .ds_arprot(busdec2nce_arprot),
    .us_awid({sdn2busdec_awid,sdn2busdec_awid_dummy}),
    .us_awaddr(sdn2busdec_awaddr),
    .us_awlen(sdn2busdec_awlen),
    .us_awsize(sdn2busdec_awsize),
    .us_awburst(sdn2busdec_awburst),
    .us_awlock(sdn2busdec_awlock),
    .us_awcache(sdn2busdec_awcache),
    .us_awprot(sdn2busdec_awprot),
    .us_awvalid(sdn2busdec_awvalid),
    .us_awready(sdn2busdec_awready),
    .us_wdata(sdn2busdec_wdata),
    .us_wstrb(sdn2busdec_wstrb),
    .us_wlast(sdn2busdec_wlast),
    .us_wvalid(sdn2busdec_wvalid),
    .us_wready(sdn2busdec_wready),
    .us_bid({sdn2busdec_bid,sdn2busdec_bid_dummy}),
    .us_bresp(sdn2busdec_bresp),
    .us_bvalid(sdn2busdec_bvalid),
    .us_bready(sdn2busdec_bready),
    .us_arid({sdn2busdec_arid,sdn2busdec_arid_dummy}),
    .us_araddr(sdn2busdec_araddr),
    .us_arlen(sdn2busdec_arlen),
    .us_arsize(sdn2busdec_arsize),
    .us_arburst(sdn2busdec_arburst),
    .us_arlock(sdn2busdec_arlock),
    .us_arcache(sdn2busdec_arcache),
    .us_arprot(sdn2busdec_arprot),
    .us_arvalid(sdn2busdec_arvalid),
    .us_arready(sdn2busdec_arready),
    .us_rid({sdn2busdec_rid,sdn2busdec_rid_dummy}),
    .us_rdata(sdn2busdec_rdata),
    .us_rresp(sdn2busdec_rresp),
    .us_rlast(sdn2busdec_rlast),
    .us_rvalid(sdn2busdec_rvalid),
    .us_rready(sdn2busdec_rready),
    .aclk(aclk),
    .aresetn(aresetn)
);
a45_core_top u_kv_core_top0(
    .lm_local_int(lm_local_int),
    .lm_clk(hart0_lm_clk),
    .bus_clk_en(hart0_bus_clk_en),
    .araddr(hart0_araddr),
    .arburst(hart0_arburst),
    .arcache(hart0_arcache),
    .arid(hart0_arid),
    .arlen(hart0_arlen),
    .arlock(hart0_arlock),
    .arprot(hart0_arprot),
    .arready(hart0_arready),
    .arsize(hart0_arsize),
    .arvalid(hart0_arvalid),
    .awaddr(hart0_awaddr),
    .awburst(hart0_awburst),
    .awcache(hart0_awcache),
    .awid(hart0_awid),
    .awlen(hart0_awlen),
    .awlock(hart0_awlock),
    .awprot(hart0_awprot),
    .awready(hart0_awready),
    .awsize(hart0_awsize),
    .awvalid(hart0_awvalid),
    .bid(hart0_bid),
    .bready(hart0_bready),
    .bresp(hart0_bresp),
    .bvalid(hart0_bvalid),
    .rdata(hart0_rdata),
    .rid(hart0_rid),
    .rlast(hart0_rlast),
    .rready(hart0_rready),
    .rresp(hart0_rresp),
    .rvalid(hart0_rvalid),
    .wdata(hart0_wdata),
    .wlast(hart0_wlast),
    .wready(hart0_wready),
    .wstrb(hart0_wstrb),
    .wvalid(hart0_wvalid),
    .icache_disable_init(hart0_icache_disable_init),
    .dcache_disable_init(hart0_dcache_disable_init),
    .seip(hart0_seip),
    .seiack(hart0_seiack),
    .seiid(hart0_seiid),
    .ueip(1'b0),
    .ueiack(nds_unused_hart0_ueiack),
    .ueiid(10'b0),
    .debugint(hart0_debugint),
    .resethaltreq(hart0_resethaltreq),
    .hart_unavail(hart0_unavail),
    .hart_halted(nds_unused_hart0_hart_halted),
    .hart_under_reset(hart0_under_reset),
    .stoptime(hart0_stoptime),
    .hart_id(hart0_hart_id),
    .core_clk(hart0_core_clk),
    .core_reset_n(hart0_core_reset_n),
    .test_mode(test_mode),
    .scan_enable(scan_enable),
    .core_wfi_mode(hart0_core_wfi_mode),
    .reset_vector(hart0_reset_vector),
    .dti_1pr_rwm (dti_1pr_rwm),
    .dti_sp_rwm  (dti_sp_rwm),
    .dti_sp_dly  (dti_sp_dly),
    .nmi(hart0_nmi),
    .meip(hart0_meip),
    .meiack(hart0_meiack),
    .meiid(hart0_meiid),
    .mtip(hart0_mtip),
    .msip(hart0_msip)
);

wire plmt_mtime_clk;
wire plmt_aclk;

CKBD10BWP7D5T16P96CPD plmt_acpu_clk_buf_u   (.I(mtime_clk), .Z(plmt_mtime_clk) );
CKBD10BWP7D5T16P96CPD plmt_mtime_clk_buf_u  (.I(aclk),      .Z(plmt_aclk)      );

nceplmt100 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .BUS_TYPE("axi"),
    .DATA_WIDTH(NCE_DATA_WIDTH),
    .GRAY_WIDTH(2),
    .NHART(NHART),
    .SYNC_STAGE(3)
) u_plmt (
    .araddr(plmt_araddr),
    .arburst(plmt_arburst),
    .arcache(plmt_arcache),
    .arid(4'd0),
    .arlen(plmt_arlen),
    .arlock(plmt_arlock),
    .arprot(plmt_arprot),
    .arready(plmt_arready),
    .arsize(plmt_arsize),
    .arvalid(plmt_arvalid),
    .awaddr(plmt_awaddr),
    .awburst(plmt_awburst),
    .awcache(plmt_awcache),
    .awid(4'd0),
    .awlen(plmt_awlen),
    .awlock(plmt_awlock),
    .awprot(plmt_awprot),
    .awready(plmt_awready),
    .awsize(plmt_awsize),
    .awvalid(plmt_awvalid),
    .bid(nds_unused_plmt_bid),
    .bready(plmt_bready),
    .bresp(plmt_bresp),
    .bvalid(plmt_bvalid),
    .haddr({ADDR_WIDTH{1'b0}}),
    .hburst(3'd0),
    .hrdata(nds_unused_plmt_hrdata),
    .hready(1'd0),
    .hreadyout(nds_unused_plmt_hreadyout),
    .hresp(nds_unused_plmt_hresp),
    .hsel(1'd0),
    .hsize(3'd0),
    .htrans(2'd0),
    .hwdata({(NCE_DATA_WIDTH){1'b0}}),
    .hwrite(1'd0),
    .mtip(mtip),
    .rdata(plmt_rdata),
    .rid(nds_unused_plmt_rid),
    .rlast(plmt_rlast),
    .rready(plmt_rready),
    .rresp(plmt_rresp),
    .rvalid(plmt_rvalid),
    .wdata(plmt_wdata),
    .wlast(plmt_wlast),
    .wready(plmt_wready),
    .wstrb(plmt_wstrb),
    .wvalid(plmt_wvalid),
    .clk(plmt_aclk),
    .resetn(aresetn),
    .mtime_clk(plmt_mtime_clk),
    .por_rstn(por_rstn),
    .test_mode(test_mode),
    .stoptime(stoptime)
);
ncepldm200 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(NCE_DATA_WIDTH),
    .HALTGROUP_COUNT(HALTGROUP_COUNT),
    .NHART(NHART),
    .PROGBUF_SIZE(PROGBUF_SIZE),
    .RV_BUS_TYPE("axi"),
    .SYNC_STAGE(3),
    .SYSTEM_BUS_ACCESS_SUPPORT(PLDM_SYS_BUS_ACCESS),
    .SYS_ADDR_WIDTH(ADDR_WIDTH),
    .SYS_BUS_TYPE("axi"),
    .SYS_DATA_WIDTH(DM_SYS_DATA_WIDTH),
    .SYS_ID_WIDTH(BIU_ID_WIDTH)
) u_pldm (
    .debugint(dm_debugint),
    .resethaltreq(dm_resethaltreq),
    .dmactive(dmactive),
    .ndmreset(ndmreset),
    .clk(aclk),
    .dmi_resetn(dmi_resetn),
    .hart_unavail(dm_hart_unavail),
    .hart_under_reset(dm_hart_under_reset),
    .bus_resetn(aresetn),
    .rv_haddr({ADDR_WIDTH{1'b0}}),
    .rv_htrans(2'd0),
    .rv_hwrite(1'd0),
    .rv_hsize(3'd0),
    .rv_hburst(3'd0),
    .rv_hprot(4'd0),
    .rv_hwdata({(NCE_DATA_WIDTH){1'b0}}),
    .rv_hsel(1'd0),
    .rv_hready(1'd0),
    .rv_hrdata(nds_unused_dm_hrdata),
    .rv_hreadyout(nds_unused_dm_hreadyout),
    .rv_hresp(nds_unused_dm_hresp),
    .rv_awid(4'd0),
    .rv_awaddr(dm_awaddr),
    .rv_awlen(dm_awlen),
    .rv_awsize(dm_awsize),
    .rv_awburst(dm_awburst),
    .rv_awlock(dm_awlock),
    .rv_awcache(dm_awcache),
    .rv_awprot(dm_awprot),
    .rv_awvalid(dm_awvalid),
    .rv_awready(dm_awready),
    .rv_wdata(dm_wdata),
    .rv_wstrb(dm_wstrb),
    .rv_wlast(dm_wlast),
    .rv_wvalid(dm_wvalid),
    .rv_wready(dm_wready),
    .rv_bid(nds_unused_dm_bid),
    .rv_bresp(dm_bresp),
    .rv_bvalid(dm_bvalid),
    .rv_bready(dm_bready),
    .rv_arid(4'd0),
    .rv_araddr(dm_araddr),
    .rv_arlen(dm_arlen),
    .rv_arsize(dm_arsize),
    .rv_arburst(dm_arburst),
    .rv_arlock(dm_arlock),
    .rv_arcache(dm_arcache),
    .rv_arprot(dm_arprot),
    .rv_arvalid(dm_arvalid),
    .rv_arready(dm_arready),
    .rv_rid(nds_unused_dm_rid),
    .rv_rdata(dm_rdata),
    .rv_rresp(dm_rresp),
    .rv_rlast(dm_rlast),
    .rv_rvalid(dm_rvalid),
    .rv_rready(dm_rready),
    .sys_awid(dm_sup_awid),
    .sys_awaddr(dm_sup_awaddr),
    .sys_awlen(dm_sup_awlen),
    .sys_awsize(dm_sup_awsize),
    .sys_awburst(dm_sup_awburst),
    .sys_awlock(dm_sup_awlock),
    .sys_awcache(dm_sup_awcache),
    .sys_awprot(dm_sup_awprot),
    .sys_awvalid(dm_sup_awvalid),
    .sys_awready(dm_sup_awready),
    .sys_wdata(dm_sup_wdata),
    .sys_wstrb(dm_sup_wstrb),
    .sys_wlast(dm_sup_wlast),
    .sys_wvalid(dm_sup_wvalid),
    .sys_wready(dm_sup_wready),
    .sys_bid(dm_sup_bid),
    .sys_bresp(dm_sup_bresp),
    .sys_bvalid(dm_sup_bvalid),
    .sys_bready(dm_sup_bready),
    .sys_arid(dm_sup_arid),
    .sys_araddr(dm_sup_araddr),
    .sys_arlen(dm_sup_arlen),
    .sys_arsize(dm_sup_arsize),
    .sys_arburst(dm_sup_arburst),
    .sys_arlock(dm_sup_arlock),
    .sys_arcache(dm_sup_arcache),
    .sys_arprot(dm_sup_arprot),
    .sys_arvalid(dm_sup_arvalid),
    .sys_arready(dm_sup_arready),
    .sys_rid(dm_sup_rid),
    .sys_rdata(dm_sup_rdata),
    .sys_rresp(dm_sup_rresp),
    .sys_rlast(dm_sup_rlast),
    .sys_rvalid(dm_sup_rvalid),
    .sys_rready(dm_sup_rready),
    .sys_haddr(nds_unused_dm_sup_haddr),
    .sys_htrans(nds_unused_dm_sup_htrans),
    .sys_hwrite(nds_unused_dm_sup_hwrite),
    .sys_hsize(nds_unused_dm_sup_hsize),
    .sys_hburst(nds_unused_dm_sup_hburst),
    .sys_hprot(nds_unused_dm_sup_hprot),
    .sys_hwdata(nds_unused_dm_sup_hwdata),
    .sys_hbusreq(nds_unused_dm_sup_hbusreq),
    .sys_hrdata({DM_SYS_DATA_WIDTH{1'b0}}),
    .sys_hready(1'b0),
    .sys_hresp(2'h0),
    .sys_hgrant(1'b0),
    .dmi_haddr(dmi_haddr),
    .dmi_htrans(dmi_htrans),
    .dmi_hwrite(dmi_hwrite),
    .dmi_hsize(dmi_hsize),
    .dmi_hburst(dmi_hburst),
    .dmi_hprot(dmi_hprot),
    .dmi_hwdata(dmi_hwdata),
    .dmi_hsel(dmi_hsel),
    .dmi_hready(dmi_hready),
    .dmi_hrdata(dmi_hrdata),
    .dmi_hreadyout(dmi_hready),
    .dmi_hresp(dmi_hresp)
);
generate
    if ((BIU_DATA_WIDTH > DM_SYS_DATA_WIDTH)) begin:gen_axi_dm_sup
        atcsizeup300 #(
            .DS_DATA_WIDTH(SIZEUP_DS_DATA_WIDTH),
            .ID_WIDTH(BIU_ID_WIDTH),
            .US_DATA_WIDTH(DM_SYS_DATA_WIDTH)
        ) u_axi_dm_sup (
            .aclk(aclk),
            .aresetn(aresetn),
            .us_arvalid(dm_sup_arvalid),
            .us_arid(dm_sup_arid),
            .us_araddr(dm_sup_araddr[SIZEUP_ADDR_MSB:0]),
            .us_arlen(dm_sup_arlen[3:0]),
            .us_arsize(dm_sup_arsize),
            .us_arburst(dm_sup_arburst),
            .us_arready(dm_sup_arready),
            .us_awvalid(dm_sup_awvalid),
            .us_awid(dm_sup_awid),
            .us_awaddr(dm_sup_awaddr[SIZEUP_ADDR_MSB:0]),
            .us_awlen(dm_sup_awlen[3:0]),
            .us_awsize(dm_sup_awsize),
            .us_awburst(dm_sup_awburst),
            .us_awready(dm_sup_awready),
            .ds_arvalid(dm_sys_arvalid),
            .ds_arready(dm_sys_arready),
            .ds_awvalid(dm_sys_awvalid),
            .ds_awready(dm_sys_awready),
            .us_rid(dm_sup_rid),
            .us_rvalid(dm_sup_rvalid),
            .us_rdata(dm_sup_rdata),
            .us_rready(dm_sup_rready),
            .ds_rlast(dm_sys_rlast),
            .ds_rvalid(dm_sys_rvalid),
            .ds_rdata(dm_sys_rdata),
            .ds_rready(dm_sys_rready),
            .us_wstrb(dm_sup_wstrb),
            .us_wlast(dm_sup_wlast),
            .us_wvalid(dm_sup_wvalid),
            .us_wdata(dm_sup_wdata),
            .us_wready(dm_sup_wready),
            .ds_wstrb(dm_sys_wstrb),
            .ds_wvalid(dm_sys_wvalid),
            .ds_wdata(dm_sys_wdata),
            .ds_wready(dm_sys_wready),
            .ds_wlast(dm_sys_wlast),
            .us_rlast(dm_sup_rlast),
            .us_rresp(dm_sup_rresp),
            .ds_rresp(dm_sys_rresp),
            .us_bid(dm_sup_bid),
            .us_bvalid(dm_sup_bvalid),
            .us_bready(dm_sup_bready),
            .ds_bvalid(dm_sys_bvalid),
            .ds_bready(dm_sys_bready)
        );
    end
endgenerate
nceplic100 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .ASYNC_INT(1024'hc000000),
    .DATA_WIDTH(NCE_DATA_WIDTH),
    .EDGE_TRIGGER(1024'h0),
    .INT_NUM(31),
    .MAX_PRIORITY(3),
    .PLIC_BUS("axi"),
    .SYNC_STAGE(3),
    .TARGET_NUM(PLIC_HW_TARGET_NUM[5:0]),
    .VECTOR_PLIC_SUPPORT(VECTOR_PLIC_SUPPORT)
) u_plic (
    .araddr(plic_araddr),
    .arburst(plic_arburst),
    .arcache(plic_arcache),
    .arid(4'd0),
    .arlen(plic_arlen),
    .arlock(plic_arlock),
    .arprot(plic_arprot),
    .arready(plic_arready),
    .arsize(plic_arsize),
    .arvalid(plic_arvalid),
    .awaddr(plic_awaddr),
    .awburst(plic_awburst),
    .awcache(plic_awcache),
    .awid(4'd0),
    .awlen(plic_awlen),
    .awlock(plic_awlock),
    .awprot(plic_awprot),
    .awready(plic_awready),
    .awsize(plic_awsize),
    .awvalid(plic_awvalid),
    .bid(nds_unused_plic_bid),
    .bready(plic_bready),
    .bresp(plic_bresp),
    .bvalid(plic_bvalid),
    .haddr({ADDR_WIDTH{1'b0}}),
    .hburst(3'd0),
    .hrdata(nds_unused_plic_hrdata),
    .hready(1'b0),
    .hreadyout(nds_unused_plic_hreadyout),
    .hresp(nds_unused_plic_hresp),
    .hsel(1'b0),
    .hsize(3'd0),
    .htrans(2'd0),
    .hwdata({NCE_DATA_WIDTH{1'b0}}),
    .hwrite(1'b0),
    .rdata(plic_rdata),
    .rid(nds_unused_plic_rid),
    .rlast(plic_rlast),
    .rready(plic_rready),
    .rresp(plic_rresp),
    .rvalid(plic_rvalid),
    .wdata(plic_wdata),
    .wlast(plic_wlast),
    .wready(plic_wready),
    .wstrb(plic_wstrb),
    .wvalid(plic_wvalid),
    .clk(aclk),
    .reset_n(aresetn),
    .int_src(int_src),
    .t0_eip(plic_hart0_meip),
    .t0_eiid(hart0_meiid),
    .t0_eiack(plic_hart0_meiack),
    .t1_eip(plic_hart0_seip),
    .t1_eiid(hart0_seiid),
    .t1_eiack(plic_hart0_seiack),
    .t2_eip(nds_unused_plic_t2_eip),
    .t2_eiid(nds_unused_plic_t2_eiid),
    .t2_eiack(1'b0),
    .t3_eip(nds_unused_plic_t3_eip),
    .t3_eiid(nds_unused_plic_t3_eiid),
    .t3_eiack(1'b0),
    .t4_eip(nds_unused_plic_t4_eip),
    .t4_eiid(nds_unused_plic_t4_eiid),
    .t4_eiack(1'b0),
    .t5_eip(nds_unused_plic_t5_eip),
    .t5_eiid(nds_unused_plic_t5_eiid),
    .t5_eiack(1'b0),
    .t6_eip(nds_unused_plic_t6_eip),
    .t6_eiid(nds_unused_plic_t6_eiid),
    .t6_eiack(1'b0),
    .t7_eip(nds_unused_plic_t7_eip),
    .t7_eiid(nds_unused_plic_t7_eiid),
    .t7_eiack(1'b0),
    .t8_eip(nds_unused_plic_t8_eip),
    .t8_eiid(nds_unused_plic_t8_eiid),
    .t8_eiack(1'b0),
    .t9_eip(nds_unused_plic_t9_eip),
    .t9_eiid(nds_unused_plic_t9_eiid),
    .t9_eiack(1'b0),
    .t10_eip(nds_unused_plic_t10_eip),
    .t10_eiid(nds_unused_plic_t10_eiid),
    .t10_eiack(1'b0),
    .t11_eip(nds_unused_plic_t11_eip),
    .t11_eiid(nds_unused_plic_t11_eiid),
    .t11_eiack(1'b0),
    .t12_eip(nds_unused_plic_t12_eip),
    .t12_eiid(nds_unused_plic_t12_eiid),
    .t12_eiack(1'b0),
    .t13_eip(nds_unused_plic_t13_eip),
    .t13_eiid(nds_unused_plic_t13_eiid),
    .t13_eiack(1'b0),
    .t14_eip(nds_unused_plic_t14_eip),
    .t14_eiid(nds_unused_plic_t14_eiid),
    .t14_eiack(1'b0),
    .t15_eip(nds_unused_plic_t15_eip),
    .t15_eiid(nds_unused_plic_t15_eiid),
    .t15_eiack(1'b0)
);
nceplic100 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(NCE_DATA_WIDTH),
    .EDGE_TRIGGER(1024'd0),
    .INT_NUM(31),
    .MAX_PRIORITY(3),
    .PLIC_BUS("axi"),
    .TARGET_NUM(PLIC_SW_TARGET_NUM[5:0]),
    .VECTOR_PLIC_SUPPORT("no")
) u_plic_sw (
    .araddr(plicsw_araddr),
    .arburst(plicsw_arburst),
    .arcache(plicsw_arcache),
    .arid(4'd0),
    .arlen(plicsw_arlen),
    .arlock(plicsw_arlock),
    .arprot(plicsw_arprot),
    .arready(plicsw_arready),
    .arsize(plicsw_arsize),
    .arvalid(plicsw_arvalid),
    .awaddr(plicsw_awaddr),
    .awburst(plicsw_awburst),
    .awcache(plicsw_awcache),
    .awid(4'd0),
    .awlen(plicsw_awlen),
    .awlock(plicsw_awlock),
    .awprot(plicsw_awprot),
    .awready(plicsw_awready),
    .awsize(plicsw_awsize),
    .awvalid(plicsw_awvalid),
    .bid(nds_unused_plicsw_bid),
    .bready(plicsw_bready),
    .bresp(plicsw_bresp),
    .bvalid(plicsw_bvalid),
    .haddr({ADDR_WIDTH{1'b0}}),
    .hburst(3'd0),
    .hrdata(nds_unused_plicsw_hrdata),
    .hready(1'b0),
    .hreadyout(nds_unused_plicsw_hreadyout),
    .hresp(nds_unused_plicsw_hresp),
    .hsel(1'b0),
    .hsize(3'd0),
    .htrans(2'd0),
    .hwdata({NCE_DATA_WIDTH{1'b0}}),
    .hwrite(1'b0),
    .rdata(plicsw_rdata),
    .rid(nds_unused_plicsw_rid),
    .rlast(plicsw_rlast),
    .rready(plicsw_rready),
    .rresp(plicsw_rresp),
    .rvalid(plicsw_rvalid),
    .wdata(plicsw_wdata),
    .wlast(plicsw_wlast),
    .wready(plicsw_wready),
    .wstrb(plicsw_wstrb),
    .wvalid(plicsw_wvalid),
    .clk(aclk),
    .reset_n(aresetn),
    .int_src(31'd0),
    .t0_eip(plicsw_hart0_msip),
    .t0_eiid(nds_unused_plicsw_t0_eiid),
    .t0_eiack(1'b0),
    .t1_eip(nds_unused_plicsw_t1_eip),
    .t1_eiid(nds_unused_plicsw_t1_eiid),
    .t1_eiack(1'b0),
    .t2_eip(nds_unused_plicsw_t2_eip),
    .t2_eiid(nds_unused_plicsw_t2_eiid),
    .t2_eiack(1'b0),
    .t3_eip(nds_unused_plicsw_t3_eip),
    .t3_eiid(nds_unused_plicsw_t3_eiid),
    .t3_eiack(1'b0),
    .t4_eip(nds_unused_plicsw_t4_eip),
    .t4_eiid(nds_unused_plicsw_t4_eiid),
    .t4_eiack(1'b0),
    .t5_eip(nds_unused_plicsw_t5_eip),
    .t5_eiid(nds_unused_plicsw_t5_eiid),
    .t5_eiack(1'b0),
    .t6_eip(nds_unused_plicsw_t6_eip),
    .t6_eiid(nds_unused_plicsw_t6_eiid),
    .t6_eiack(1'b0),
    .t7_eip(nds_unused_plicsw_t7_eip),
    .t7_eiid(nds_unused_plicsw_t7_eiid),
    .t7_eiack(1'b0),
    .t8_eip(nds_unused_plicsw_t8_eip),
    .t8_eiid(nds_unused_plicsw_t8_eiid),
    .t8_eiack(1'b0),
    .t9_eip(nds_unused_plicsw_t9_eip),
    .t9_eiid(nds_unused_plicsw_t9_eiid),
    .t9_eiack(1'b0),
    .t10_eip(nds_unused_plicsw_t10_eip),
    .t10_eiid(nds_unused_plicsw_t10_eiid),
    .t10_eiack(1'b0),
    .t11_eip(nds_unused_plicsw_t11_eip),
    .t11_eiid(nds_unused_plicsw_t11_eiid),
    .t11_eiack(1'b0),
    .t12_eip(nds_unused_plicsw_t12_eip),
    .t12_eiid(nds_unused_plicsw_t12_eiid),
    .t12_eiack(1'b0),
    .t13_eip(nds_unused_plicsw_t13_eip),
    .t13_eiid(nds_unused_plicsw_t13_eiid),
    .t13_eiack(1'b0),
    .t14_eip(nds_unused_plicsw_t14_eip),
    .t14_eiid(nds_unused_plicsw_t14_eiid),
    .t14_eiack(1'b0),
    .t15_eip(nds_unused_plicsw_t15_eip),
    .t15_eiid(nds_unused_plicsw_t15_eiid),
    .t15_eiack(1'b0)
);
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_debugint_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_debugint_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(dm_debugint[0]),
            .q(hart0_debugint)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_resethaltreq_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_resethaltreq_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(dm_resethaltreq[0]),
            .q(hart0_resethaltreq)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_seip_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_seip_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(plic_hart0_seip),
            .q(hart0_seip)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_seiack_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_seiack_sync (
            .resetn(aresetn),
            .clk(aclk),
            .d(hart0_seiack),
            .q(plic_hart0_seiack)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_meip_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_meip_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(plic_hart0_meip),
            .q(hart0_meip)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_meiack_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_meiack_sync (
            .resetn(aresetn),
            .clk(aclk),
            .d(hart0_meiack),
            .q(plic_hart0_meiack)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_msip_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_msip_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(plicsw_hart0_msip),
            .q(hart0_msip)
        );
    end
endgenerate
generate
    if (BIU_ASYNC_SUPPORT == 1) begin:gen_mtip_sync
        kv_sync_l2l #(
            .RESET_VALUE(1'b0),
            .SYNC_STAGE(3)
        ) u_mtip_sync (
            .resetn(hart0_core_reset_n),
            .clk(hart0_core_clk),
            .d(mtip[0]),
            .q(hart0_mtip)
        );
    end
endgenerate

assign dmi_haddr = dmi_haddr_32w[8:0];

ncejdtm200 ncejdtm200 (
    .dbg_wakeup_req(             ),
    .tms_out_en    (             ),
    .test_mode     (test_mode    ),
    .pwr_rst_n     (por_rstn     ),
    .tck           (jtag_tck     ),
    .tms           (jtag_tms     ),
    .tdi           (jtag_tdi     ),
    .tdo           (jtag_tdo     ),
    .tdo_out_en    (             ),
    .dmi_hresetn   (dmi_resetn   ),
    .dmi_hclk      (aclk         ),
    .dmi_hsel      (dmi_hsel     ),
    .dmi_htrans    (dmi_htrans   ),
    .dmi_haddr     (dmi_haddr_32w),
    .dmi_hsize     (dmi_hsize    ),
    .dmi_hburst    (dmi_hburst   ),
    .dmi_hprot     (dmi_hprot    ),
    .dmi_hwdata    (dmi_hwdata   ),
    .dmi_hwrite    (dmi_hwrite   ),
    .dmi_hrdata    (dmi_hrdata   ),
    .dmi_hready    (dmi_hready   ),
    .dmi_hresp     (dmi_hresp[0] )
);

endmodule


