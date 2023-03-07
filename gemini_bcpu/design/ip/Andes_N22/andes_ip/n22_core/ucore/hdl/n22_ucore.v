

`include "global.inc"

module n22_ucore #(
 parameter N22_DLM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_ILM_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_PPI_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_FIO_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION0_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION1_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION2_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION3_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION4_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION5_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION6_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEVICE_REGION7_BASE  = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_TMR_BASE_ADDR        = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_CLIC_BASE_ADDR       = {(`N22_ADDR_SIZE){1'b0}},
 parameter N22_DEBUG_BASE_ADDR      = {(`N22_ADDR_SIZE){1'b0}}
)(
    output trace_ivalid,
    output trace_iexception,
    output trace_interrupt,
    output [`N22_XLEN-1:0] trace_cause,
    output [`N22_XLEN-1:0] trace_tval,
    output [`N22_XLEN-1:0] trace_iaddr,
    output [`N22_XLEN-1:0] trace_instr,
    output [1:0] trace_priv,

      `ifdef N22_HAS_DEBUG_PRIVATE
    input  tap_dmi_active,
      `endif

      `ifdef N22_HAS_DEBUG
    input  resethaltreq,
    input  hart_under_reset,
    output hart_unavail    ,
      `endif


  `ifdef N22_HAS_ICACHE
  input  icache_disable_init,
  input  icache_ram_cgstop,
  `endif

  input   rx_evt_req,
  output  rx_evt_ack,

  output sleep_value,
  output tx_evt,
  output csr_wfe_bit,


  `ifdef N22_HAS_CSR_EAI
  output         eai_csr_valid,
  input          eai_csr_ready,
  output  [31:0] eai_csr_addr,
  output         eai_csr_wr,
  output  [31:0] eai_csr_wdata,
  input   [31:0] eai_csr_rdata,
  `endif
  output core_wfi,
  output  dbg_sleep,

  input  [`N22_PC_SIZE-1:0] pc_rtvec,

  input  [`N22_XLEN-1:0] core_mhartid,
  `ifdef N22_HAS_CLIC
  input clic_irq,
  output [7:0] mintstatus_mil_r,
  input [9:0] clic_irq_id,
  input [7:0] clic_irq_lvl,
  input clic_irq_shv,
  input clic_prio_gt_thod,
  output core_in_int,
  output clic_irq_taken,
  output mnxti_valid_taken,
  output mip_bwei,
  output mip_pmovi,
  output mip_imecci,
  output clic_int_mode,
  `endif
  output nmi_irq_taken,
  input  nmi_irq_r,
  input  ext_irq_r,
  input  sft_irq_r,
  input  tmr_irq_r,

 `ifdef N22_HAS_DEBUG
  input  dbg_halt,
  input  dbg_resethaltreq,

  output dbg_csr_ena,
  output dbg_csr_wr_en,
  output dbg_csr_rd_en,
  output dbg_wbck_csr_wen,
  output [12-1:0] dbg_csr_idx,
  output [`N22_XLEN-1:0] dbg_wbck_csr_dat,
  input  [`N22_XLEN-1:0] dbg_read_csr_dat,
  input  dbg_csr_addr_legal,
  input  dbg_csr_prv_ilgl,


    `ifdef N22_HAS_TRIGM
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  output icount_taken_ena,
    `endif



  output  [`N22_PC_SIZE-1:0] cmt_dpc,
  output  cmt_dpc_ena,
  output  [3-1:0] cmt_dcause,
  output  cmt_dcause_ena,

  input   [`N22_XLEN-1:0] dbg_dexc2dbg_r,
  output  [`N22_XLEN-1:0] cmt_ddcause,
  output  cmt_ddcause_ena,

  output  cmt_dprv_ena,
  output  [2-1:0] cmt_dprv,
  input   [2-1:0] dbg_prv_r,
  input  [`N22_XLEN-1:0] csr_dpc_r,

  input  dbg_mode,
  input  dbg_step_r,
  input  dbg_ebreakm_r,
  input  dbg_stopcount,
  input  dbg_ebreaku_r,
  input  dbg_stepie,
  input  dbg_mprven,
    `endif



    `ifdef N22_TMR_PRIVATE
  output                         tmr_icb_cmd_valid,
  input                          tmr_icb_cmd_ready,
  output  [`N22_ADDR_SIZE-1:0]  tmr_icb_cmd_addr,
  output                         tmr_icb_cmd_read,
  output                         tmr_icb_cmd_mmode,
  output                         tmr_icb_cmd_dmode,
  output  [`N22_XLEN-1:0]       tmr_icb_cmd_wdata,
  output  [`N22_XLEN_MW-1:0]     tmr_icb_cmd_wmask,

  input                          tmr_icb_rsp_valid,
  output                         tmr_icb_rsp_ready,
  input                          tmr_icb_rsp_err  ,
  input  [`N22_XLEN-1:0]        tmr_icb_rsp_rdata,
    `endif

    `ifdef N22_HAS_CLIC
  output                         clic_icb_cmd_valid,
  input                          clic_icb_cmd_ready,
  output  [`N22_ADDR_SIZE-1:0]  clic_icb_cmd_addr,
  output                         clic_icb_cmd_mmode,
  output                         clic_icb_cmd_dmode,
  output                         clic_icb_cmd_read,
  output  [`N22_XLEN-1:0]       clic_icb_cmd_wdata,
  output  [`N22_XLEN_MW-1:0]     clic_icb_cmd_wmask,

  input                          clic_icb_rsp_valid,
  output                         clic_icb_rsp_ready,
  input                          clic_icb_rsp_err  ,
  input  [`N22_XLEN-1:0]        clic_icb_rsp_rdata,
    `endif

  `ifdef N22_HAS_ILM
  output                         ifu2ilm_icb_cmd_valid,
  input                          ifu2ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ifu2ilm_icb_cmd_addr,
  output                         ifu2ilm_icb_cmd_mmode,
  output                         ifu2ilm_icb_cmd_dmode,
  output                         ifu2ilm_icb_cmd_vmode,

  input                          ifu2ilm_icb_rsp_valid,
  input                          ifu2ilm_icb_rsp_err,
  input  [`N22_XLEN-1:0]        ifu2ilm_icb_rsp_rdata,

  `endif

  `ifdef N22_D_SHARE_ILM
  output                        lsu2ilm_icb_cmd_sel,

  output                        lsu2ilm_icb_cmd_valid,
  input                         lsu2ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]  lsu2ilm_icb_cmd_addr,
  output                        lsu2ilm_icb_cmd_read,
  output [`N22_XLEN-1:0]       lsu2ilm_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]    lsu2ilm_icb_cmd_wmask,
  output                        lsu2ilm_icb_cmd_lock,
  output                        lsu2ilm_icb_cmd_excl,
  output [1:0]                  lsu2ilm_icb_cmd_size,
  output                        lsu2ilm_icb_cmd_mmode,
  output                        lsu2ilm_icb_cmd_dmode,

  input                         lsu2ilm_icb_rsp_valid,
  output                        lsu2ilm_icb_rsp_ready,
  input                         lsu2ilm_icb_rsp_err  ,
  input                         lsu2ilm_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        lsu2ilm_icb_rsp_rdata,
  `endif



  `ifdef N22_HAS_DLM
  output                         lsu2dlm_icb_cmd_sel,

  output                         lsu2dlm_icb_cmd_valid,
  input                          lsu2dlm_icb_cmd_ready,
  output [`N22_DLM_ADDR_WIDTH-1:0]   lsu2dlm_icb_cmd_addr,
  output                         lsu2dlm_icb_cmd_read,
  output [`N22_XLEN-1:0]        lsu2dlm_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      lsu2dlm_icb_cmd_wmask,
  output                         lsu2dlm_icb_cmd_lock,
  output                         lsu2dlm_icb_cmd_excl,
  output [1:0]                   lsu2dlm_icb_cmd_size,
  output                         lsu2dlm_icb_cmd_mmode,
  output                         lsu2dlm_icb_cmd_dmode,

  input                          lsu2dlm_icb_rsp_valid,
  output                         lsu2dlm_icb_rsp_ready,
  input                          lsu2dlm_icb_rsp_err  ,
  input                          lsu2dlm_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        lsu2dlm_icb_rsp_rdata,

  `endif



  `ifdef N22_HAS_ICACHE
  output                           icache_tag0_cs,
  output                           icache_tag0_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_tag0_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_tag0_wdata,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_tag0_rdata,
  output                       clk_icache_tag0,

  output                           icache_data0_cs,
  output                           icache_data0_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_data0_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_data0_wdata,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_data0_rdata,
  output                       clk_icache_data0,

     `ifdef N22_ICACHE_2WAYS
  output                           icache_tag1_cs,
  output                           icache_tag1_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_tag1_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_tag1_wdata,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_tag1_rdata,
  output                       clk_icache_tag1,


  output                           icache_data1_cs,
  output                           icache_data1_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_data1_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_data1_wdata,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_data1_rdata,
  output                       clk_icache_data1,
    `endif
  `endif

  output biu_active,
  input  clk_biu,
  `ifdef N22_HAS_LBIU
  output lbiu_active,
  input  clk_lbiu,
  `endif





      `ifdef N22_MEM_TYPE_AHBL
  input                            bus_clk_en,

  output [1:0]                     htrans,
  output                           hwrite,
  output [`N22_ADDR_SIZE    -1:0]  haddr,
  output [2:0]                     hsize,
  output [2:0]                     hburst,
  output [`N22_XLEN    -1:0]       hwdata,
  output [3:0]                     hprot,
  output [1:0]                     hattri,
  output [1:0]                     master,
  input  [`N22_XLEN    -1:0]       hrdata,
  input  [1:0]                     hresp,
  input                            hready,
  output                           hlock,
      `endif


  `ifdef N22_HAS_PPI

      `ifdef N22_PPI_TYPE_APB
  output [`N22_PPI_ADDR_WIDTH-1:0]  ppi_paddr,
  output                        ppi_pwrite,
  output                        ppi_psel,
  output                        ppi_dmode,
  output                        ppi_penable,
  output [2:0]                  ppi_pprot,
  output [3:0]                  ppi_pstrobe,
  output [`N22_XLEN-1:0]       ppi_pwdata,
  input  [`N22_XLEN-1:0]       ppi_prdata,
  input                         ppi_pready ,
  input                         ppi_pslverr,
      `endif

  `endif

  `ifdef N22_HAS_FIO
  output                        fio_cmd_valid,
  output [`N22_FIO_ADDR_WIDTH-1:0]   fio_cmd_addr,
  output                        fio_cmd_read,
  output                        fio_cmd_dmode,
  output                        fio_cmd_mmode,
  output [`N22_XLEN-1:0]        fio_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      fio_cmd_wmask,
  input                         fio_rsp_err  ,
  input  [`N22_XLEN-1:0]        fio_rsp_rdata,
  `endif

 `ifdef N22_HAS_DEBUG_PRIVATE
  output              dm_ahbl_active,
  output [1:0]        dm_ahbl_htrans,
  output              dm_ahbl_hwrite,
  output [`N22_ADDR_SIZE    -1:0] dm_ahbl_haddr,
  output [2:0]        dm_ahbl_hsize,
  output [2:0]        dm_ahbl_hburst,
  output [3:0]        dm_ahbl_hprot,
  output [`N22_XLEN    -1:0] dm_ahbl_hwdata,
  input  [`N22_XLEN    -1:0] dm_ahbl_hrdata,
  input  [1:0]        dm_ahbl_hresp,
  input               dm_ahbl_hready,
 `endif

  output pft_active,
  input  clk_pft,

  `ifdef N22_HAS_ICACHE
  output icache_active,
  input  clk_icache,
  `endif

  output exu_active,
  output ifu_active,
  output lsu_active,

  input  clk_ifu,
  input  clk_exu,
  input  clk_lsu,
  input  clk_aon,

  input  clkgate_bypass,
  input  rst_n
  );




  wire ifu_o_valid;
  wire ifu_o_ready;
  wire [`N22_INSTR_SIZE-1:0] ifu_o_ir;
  wire [`N22_PC_SIZE-1:0] ifu_o_pc;
  wire ifu_o_pc_mmode;
  wire ifu_o_pc_dmode;
  wire ifu_o_pc_vld;
  wire ifu_o_misalgn;
  wire ifu_o_buserr;
  wire ifu_o_buserr_btm;
  wire ifu_o_pmperr;
  wire [`N22_RFIDX_WIDTH-1:0] ifu_o_rs1idx;
  wire [`N22_RFIDX_WIDTH-1:0] ifu_o_rs2idx;
  wire ifu_o_prdt_taken;
  wire [`N22_BPU_IDX_W-1:0] ifu_o_prdt_bpu_idx;
  wire ifu_o_muldiv_b2b;
  wire ifu_o_replaced;
  wire [`N22_PC_SIZE-1:0] ifu_o_replaced_pc;

  wire wfi_halt_ifu_req;
  wire wfi_halt_ifu_ack;
  `ifdef N22_HAS_DYNAMIC_BPU
  wire bpu_updt_ena ;
  wire bpu_updt_take;
  wire [`N22_BPU_IDX_W-1:0] bpu_updt_idx;
  `endif
  wire p1_flush_ack;
  wire p1_flush_req;
  wire p1_flush_pc_mmode;
  wire p1_flush_pc_dmode;
  wire p1_flush_pc_vmode;
  `ifdef N22_TIMING_BOOST
  wire [`N22_PC_SIZE-1:0] p1_flush_pc;
  wire p1_flush_fencei;
  `endif

  wire p2_flush_ack;
  wire p2_flush_req;
  wire p2_flush_pc_mmode;
  wire p2_flush_pc_dmode;
  wire p2_flush_pc_vmode;
  wire [`N22_PC_SIZE-1:0] p2_flush_pc;
  wire p2_flush_fencei;


  wire oitf_empty;
  wire [`N22_XLEN-1:0] rf2ifu_x1;
  wire [`N22_XLEN-1:0] rf2ifu_rs2;
  wire dec2ifu_rden;
  wire dec2ifu_rs2en;
  wire [`N22_RFIDX_WIDTH-1:0] dec2ifu_rdidx;
  wire dec2ifu_mulhsu;
  wire dec2ifu_div   ;
  wire dec2ifu_rem   ;
  wire dec2ifu_divu  ;
  wire dec2ifu_remu  ;


  `ifdef N22_HAS_CLIC
  wire                         minhv_clear_r;
  `endif
  `ifdef N22_HAS_PMP
  wire [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r;
  wire [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r;
  wire [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w;
  wire [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x;
  wire [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a;
  wire [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l;
  `endif



  wire excp_active;


  wire                        ifu2biu_icb_cmd_valid;
  wire                        ifu2biu_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   ifu2biu_icb_cmd_addr;
  wire                        ifu2biu_icb_cmd_mmode;
  wire                        ifu2biu_icb_cmd_dmode;
  wire                        ifu2biu_icb_cmd_device;
  wire                        ifu2biu_icb_cmd_vmode;
  wire                        ifu2biu_icb_cmd_err;
  wire                        ifu2biu_icb_cmd_seq;

  wire                        ifu2biu_icb_rsp_valid;
  wire                        ifu2biu_icb_rsp_err  ;
  wire [`N22_XLEN-1:0]        ifu2biu_icb_rsp_rdata;

  `ifdef N22_HAS_ICACHE
  wire                        icache_icb_cmd_valid;
  wire                        icache_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   icache_icb_cmd_addr;
  wire                        icache_icb_cmd_read;
  wire [2:0]                  icache_icb_cmd_burst;
  wire [1:0]                  icache_icb_cmd_beat;
  wire                        icache_icb_cmd_mmode;
  wire                        icache_icb_cmd_dmode;
  wire                        icache_icb_cmd_vmode;

  wire                        icache_icb_rsp_valid;
  wire                        icache_icb_rsp_err  ;
  wire [`N22_XLEN-1:0]        icache_icb_rsp_rdata;

  `endif

  wire [31:0] csr_uitb_addr;

  wire reset_flag_r;

  wire csr_ilm_enable   ;
  wire csr_dlm_enable   ;
  wire csr_icache_enable;
  wire csr_bpu_enable;
  wire csr_rvcompm_enable;

  n22_ifu #(
    .N22_DLM_BASE_ADDR       (N22_DLM_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR       (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR       (N22_PPI_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR       (N22_FIO_BASE_ADDR       ),
    .N22_DEVICE_REGION0_BASE (N22_DEVICE_REGION0_BASE ),
    .N22_DEVICE_REGION1_BASE (N22_DEVICE_REGION1_BASE ),
    .N22_DEVICE_REGION2_BASE (N22_DEVICE_REGION2_BASE ),
    .N22_DEVICE_REGION3_BASE (N22_DEVICE_REGION3_BASE ),
    .N22_DEVICE_REGION4_BASE (N22_DEVICE_REGION4_BASE ),
    .N22_DEVICE_REGION5_BASE (N22_DEVICE_REGION5_BASE ),
    .N22_DEVICE_REGION6_BASE (N22_DEVICE_REGION6_BASE ),
    .N22_DEVICE_REGION7_BASE (N22_DEVICE_REGION7_BASE ),
    .N22_TMR_BASE_ADDR       (N22_TMR_BASE_ADDR       ),
    .N22_CLIC_BASE_ADDR      (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR     (N22_DEBUG_BASE_ADDR     )
  )u_n22_ifu(

    .bus_clk_en        (bus_clk_en),

    .csr_bpu_enable   (csr_bpu_enable),
    .csr_rvcompm_enable(csr_rvcompm_enable),

    .csr_ilm_enable   (csr_ilm_enable   ),
    .csr_icache_enable(csr_icache_enable),

    .reset_flag_r   (reset_flag_r),
    .csr_uitb_addr  (csr_uitb_addr  ),
    .core_wfi     (core_wfi   ),
    .excp_active  (excp_active),
`ifdef N22_HAS_CLIC
    .minhv_clear_r    (minhv_clear_r),
`endif
  `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),
  `endif


    .ifu_active      (ifu_active),
    .pc_rtvec        (pc_rtvec),


    .ifu2biu_icb_cmd_valid  (ifu2biu_icb_cmd_valid  ),
    .ifu2biu_icb_cmd_ready  (ifu2biu_icb_cmd_ready  ),
    .ifu2biu_icb_cmd_addr   (ifu2biu_icb_cmd_addr   ),
    .ifu2biu_icb_cmd_mmode  (ifu2biu_icb_cmd_mmode  ),
    .ifu2biu_icb_cmd_dmode  (ifu2biu_icb_cmd_dmode  ),
    .ifu2biu_icb_cmd_device  (ifu2biu_icb_cmd_device  ),
    .ifu2biu_icb_cmd_vmode  (ifu2biu_icb_cmd_vmode  ),
    .ifu2biu_icb_cmd_err (ifu2biu_icb_cmd_err ),
    .ifu2biu_icb_cmd_seq (ifu2biu_icb_cmd_seq ),

    .ifu2biu_icb_rsp_valid  (ifu2biu_icb_rsp_valid  ),
    .ifu2biu_icb_rsp_err    (ifu2biu_icb_rsp_err    ),
    .ifu2biu_icb_rsp_rdata  (ifu2biu_icb_rsp_rdata  ),

  `ifdef N22_HAS_ILM

    .ifu2ilm_icb_cmd_valid    (ifu2ilm_icb_cmd_valid  ),
    .ifu2ilm_icb_cmd_ready    (ifu2ilm_icb_cmd_ready  ),
    .ifu2ilm_icb_cmd_addr     (ifu2ilm_icb_cmd_addr   ),
    .ifu2ilm_icb_cmd_mmode    (ifu2ilm_icb_cmd_mmode  ),
    .ifu2ilm_icb_cmd_dmode    (ifu2ilm_icb_cmd_dmode  ),
    .ifu2ilm_icb_cmd_vmode    (ifu2ilm_icb_cmd_vmode  ),

    .ifu2ilm_icb_rsp_valid    (ifu2ilm_icb_rsp_valid  ),
    .ifu2ilm_icb_rsp_err      (ifu2ilm_icb_rsp_err    ),
    .ifu2ilm_icb_rsp_rdata    (ifu2ilm_icb_rsp_rdata  ),

  `endif


    .ifu_o_valid            (ifu_o_valid         ),
    .ifu_o_ready            (ifu_o_ready         ),
    .ifu_o_ir               (ifu_o_ir            ),
    .ifu_o_pc               (ifu_o_pc            ),
    .ifu_o_pc_mmode         (ifu_o_pc_mmode      ),
    .ifu_o_pc_dmode         (ifu_o_pc_dmode      ),
    .ifu_o_pc_vld           (ifu_o_pc_vld        ),
    .ifu_o_misalgn          (ifu_o_misalgn       ),
    .ifu_o_buserr           (ifu_o_buserr        ),
    .ifu_o_buserr_btm       (ifu_o_buserr_btm    ),
    .ifu_o_pmperr           (ifu_o_pmperr        ),
    .ifu_o_rs1idx           (ifu_o_rs1idx        ),
    .ifu_o_rs2idx           (ifu_o_rs2idx        ),
    .ifu_o_prdt_taken       (ifu_o_prdt_taken    ),
    .ifu_o_prdt_bpu_idx     (ifu_o_prdt_bpu_idx  ),
    .ifu_o_muldiv_b2b       (ifu_o_muldiv_b2b    ),
    .ifu_o_replaced         (ifu_o_replaced   ),
    .ifu_o_replaced_pc      (ifu_o_replaced_pc),

    .ifu_halt_req           (wfi_halt_ifu_req),
    .ifu_halt_ack           (wfi_halt_ifu_ack),
`ifdef N22_HAS_DYNAMIC_BPU
    .bpu_updt_ena           (bpu_updt_ena ),
    .bpu_updt_take          (bpu_updt_take),
    .bpu_updt_idx           (bpu_updt_idx),
`endif
    .p1_flush_ack         (p1_flush_ack      ),
    .p1_flush_req         (p1_flush_req      ),
    .p1_flush_pc_mmode    (p1_flush_pc_mmode),
    .p1_flush_pc_dmode    (p1_flush_pc_dmode),
    .p1_flush_pc_vmode    (p1_flush_pc_vmode),
  `ifdef N22_TIMING_BOOST
    .p1_flush_pc          (p1_flush_pc),
    .p1_flush_fencei      (p1_flush_fencei),
  `endif

    .p2_flush_ack           (p2_flush_ack     ),
    .p2_flush_req           (p2_flush_req     ),
    .p2_flush_pc_mmode      (p2_flush_pc_mmode),
    .p2_flush_pc_dmode      (p2_flush_pc_dmode),
    .p2_flush_pc_vmode      (p2_flush_pc_vmode),
    .p2_flush_pc            (p2_flush_pc      ),
    .p2_flush_fencei        (p2_flush_fencei),

    .oitf_empty             (oitf_empty   ),
    .rf2ifu_x1              (rf2ifu_x1    ),
    .rf2ifu_rs2             (rf2ifu_rs2   ),
    .dec2ifu_rden           (dec2ifu_rden ),
    .dec2ifu_rs2en          (dec2ifu_rs2en),
    .dec2ifu_rdidx          (dec2ifu_rdidx),
    .dec2ifu_mulhsu         (dec2ifu_mulhsu),
    .dec2ifu_div            (dec2ifu_div   ),
    .dec2ifu_rem            (dec2ifu_rem   ),
    .dec2ifu_divu           (dec2ifu_divu  ),
    .dec2ifu_remu           (dec2ifu_remu  ),

   `ifdef N22_HAS_ICACHE
    .icache_disable_init    (icache_disable_init),

    .icache_w0_tram_cs       (icache_tag0_cs   ),
    .icache_w0_tram_we       (icache_tag0_we   ),
    .icache_w0_tram_addr     (icache_tag0_addr ),
    .icache_w0_tram_din      (icache_tag0_wdata  ),
    .icache_w0_tram_dout     (icache_tag0_rdata ),
    .clk_icache_w0_tram      (clk_icache_tag0  ),

    .icache_w0_dram_cs       (icache_data0_cs   ),
    .icache_w0_dram_we       (icache_data0_we   ),
    .icache_w0_dram_addr     (icache_data0_addr ),
    .icache_w0_dram_din      (icache_data0_wdata  ),
    .icache_w0_dram_dout     (icache_data0_rdata ),
    .clk_icache_w0_dram      (clk_icache_data0  ),

       `ifdef N22_ICACHE_2WAYS
    .icache_w1_tram_cs       (icache_tag1_cs   ),
    .icache_w1_tram_we       (icache_tag1_we   ),
    .icache_w1_tram_addr     (icache_tag1_addr ),
    .icache_w1_tram_din      (icache_tag1_wdata  ),
    .icache_w1_tram_dout     (icache_tag1_rdata ),
    .clk_icache_w1_tram      (clk_icache_tag1  ),

    .icache_w1_dram_cs       (icache_data1_cs   ),
    .icache_w1_dram_we       (icache_data1_we   ),
    .icache_w1_dram_addr     (icache_data1_addr ),
    .icache_w1_dram_din      (icache_data1_wdata  ),
    .icache_w1_dram_dout     (icache_data1_rdata ),
    .clk_icache_w1_dram      (clk_icache_data1  ),
       `endif

    .icache_icb_cmd_valid    (icache_icb_cmd_valid),
    .icache_icb_cmd_ready    (icache_icb_cmd_ready),
    .icache_icb_cmd_addr     (icache_icb_cmd_addr ),
    .icache_icb_cmd_read     (icache_icb_cmd_read ),
    .icache_icb_cmd_mmode    (icache_icb_cmd_mmode),
    .icache_icb_cmd_dmode    (icache_icb_cmd_dmode),
    .icache_icb_cmd_vmode    (icache_icb_cmd_vmode),
    .icache_icb_cmd_burst    (icache_icb_cmd_burst),
    .icache_icb_cmd_beat     (icache_icb_cmd_beat ),

    .icache_icb_rsp_valid    (icache_icb_rsp_valid),
    .icache_icb_rsp_err      (icache_icb_rsp_err  ),
    .icache_icb_rsp_rdata    (icache_icb_rsp_rdata),

    .icache_ram_cgstop (icache_ram_cgstop),
    .icache_active (icache_active),
    .clk_icache    (clk_icache   ),

  `endif

    .pft_active (pft_active),
    .clk_pft    (clk_pft   ),

    .clkgate_bypass         (clkgate_bypass),
    .clk_ifu                (clk_ifu  ),
    .rst_n                  (rst_n         )
  );



  wire                         lsu_o_valid;
  wire                         lsu_o_ready;
  wire [`N22_XLEN-1:0]        lsu_o_wbck_wdat;
  wire [`N22_ITAG_WIDTH -1:0] lsu_o_wbck_itag;
  wire                         lsu_o_wbck_err ;
  wire                         lsu_o_cmt_buserr ;
  wire                         lsu_o_cmt_pmperr ;
  wire                         lsu_o_cmt_ld;
  wire                         lsu_o_cmt_st;
  wire [`N22_ADDR_SIZE -1:0]  lsu_o_cmt_badaddr;
  wire [`N22_ADDR_SIZE -1:0]  lsu_o_cmt_pc;

  wire                         agu_icb_cmd_sel;

  wire                         agu_icb_cmd_valid;
  wire                         agu_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   agu_icb_cmd_addr;
  wire                         agu_icb_cmd_mmode;
  wire                         agu_icb_cmd_dmode;
  wire                         agu_icb_cmd_x0base;
  wire                         agu_icb_cmd_read;
  wire [`N22_XLEN-1:0]        agu_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]      agu_icb_cmd_wmask;
  wire [1:0]                   agu_icb_cmd_size;
  wire                         agu_icb_cmd_usign;
  wire [`N22_ITAG_WIDTH -1:0] agu_icb_cmd_itag;
  `ifdef N22_LDST_EXCP_PRECISE
  wire                         agu_icb_cmd_rv32;
  `endif

  `ifdef N22_MISALIGNED_AMO
  wire agu_unalgn  ;
  wire agu_load    ;
  wire agu_store   ;
  `ifdef N22_HAS_AMO
  wire agu_amo     ;
  wire agu_excl    ;
  wire agu_amoswap ;
  wire agu_amoadd  ;
  wire agu_amoand  ;
  wire agu_amoor   ;
  wire agu_amoxor  ;
  wire agu_amomax  ;
  wire agu_amomin  ;
  wire agu_amomaxu ;
  wire agu_amominu ;
  wire  [`N22_XLEN-1:0] agu_amo_rs2;
  `endif
  `endif

  wire  mstatus_mprv;
  wire  mpp_m_mode;

  `ifdef N22_LDST_EXCP_PRECISE
  wire  lsu_pend_outs;
  wire  lsu_pend_rv32;
  `endif

  n22_exu  #(
    .N22_DLM_BASE_ADDR       (N22_DLM_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR       (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR       (N22_PPI_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR       (N22_FIO_BASE_ADDR       ),
    .N22_DEVICE_REGION0_BASE (N22_DEVICE_REGION0_BASE ),
    .N22_DEVICE_REGION1_BASE (N22_DEVICE_REGION1_BASE ),
    .N22_DEVICE_REGION2_BASE (N22_DEVICE_REGION2_BASE ),
    .N22_DEVICE_REGION3_BASE (N22_DEVICE_REGION3_BASE ),
    .N22_DEVICE_REGION4_BASE (N22_DEVICE_REGION4_BASE ),
    .N22_DEVICE_REGION5_BASE (N22_DEVICE_REGION5_BASE ),
    .N22_DEVICE_REGION6_BASE (N22_DEVICE_REGION6_BASE ),
    .N22_DEVICE_REGION7_BASE (N22_DEVICE_REGION7_BASE ),
    .N22_TMR_BASE_ADDR       (N22_TMR_BASE_ADDR       ),
    .N22_CLIC_BASE_ADDR      (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR     (N22_DEBUG_BASE_ADDR     )
  )u_n22_exu(

  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_pend_outs    (lsu_pend_outs),
    .lsu_pend_rv32    (lsu_pend_rv32),
  `endif

    .trace_ivalid     (trace_ivalid    ),
    .trace_iexception (trace_iexception),
    .trace_interrupt  (trace_interrupt ),
    .trace_cause      (trace_cause     ),
    .trace_tval       (trace_tval      ),
    .trace_iaddr      (trace_iaddr     ),
    .trace_instr      (trace_instr     ),
    .trace_priv       (trace_priv      ),

      `ifdef N22_HAS_DEBUG_PRIVATE
     .tap_dmi_active (tap_dmi_active),
      `endif

    .csr_bpu_enable   (csr_bpu_enable),
    .csr_rvcompm_enable(csr_rvcompm_enable),

    .csr_ilm_enable   (csr_ilm_enable   ),
    .csr_dlm_enable   (csr_dlm_enable   ),
    .csr_icache_enable(csr_icache_enable),
    .pc_rtvec        (pc_rtvec),
    .mstatus_mprv    (mstatus_mprv),
    .mpp_m_mode      (mpp_m_mode  ),
    .csr_uitb_addr  (csr_uitb_addr  ),

  `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),

  `endif


      .rx_evt_req          (rx_evt_req),
      .rx_evt_ack          (rx_evt_ack),

      .sleep_value     (sleep_value),
      .tx_evt          (tx_evt     ),
      .csr_wfe_bit     (csr_wfe_bit),




  `ifdef N22_HAS_CSR_EAI
    .eai_csr_valid (eai_csr_valid),
    .eai_csr_ready (eai_csr_ready),
    .eai_csr_addr  (eai_csr_addr ),
    .eai_csr_wr    (eai_csr_wr   ),
    .eai_csr_wdata (eai_csr_wdata),
    .eai_csr_rdata (eai_csr_rdata),
  `endif
  `ifdef N22_HAS_CLIC
    .minhv_clear_r          (minhv_clear_r),
    .mintstatus_mil_r     (mintstatus_mil_r),
    .clic_irq_id          (clic_irq_id),
    .clic_irq_lvl         (clic_irq_lvl),
    .clic_irq_shv         (clic_irq_shv),
    .clic_prio_gt_thod    (clic_prio_gt_thod),
    .mnxti_valid_taken    (mnxti_valid_taken),
    .mip_bwei             (mip_bwei    ),
    .mip_pmovi            (mip_pmovi    ),
    .mip_imecci           (mip_imecci    ),
    .core_in_int          (core_in_int),
    .clic_irq_taken       (clic_irq_taken),
    .clic_int_mode        (clic_int_mode),
  `endif

    .excp_active            (excp_active),
    .clkgate_bypass              (clkgate_bypass),
    .core_wfi               (core_wfi),
    .dbg_sleep     (dbg_sleep   ),
    .exu_active             (exu_active),

    .core_mhartid           (core_mhartid),
    `ifdef N22_HAS_CLIC
    .clic_irq                (clic_irq),
    `endif
    .nmi_irq_taken          (nmi_irq_taken),
    .nmi_irq_r              (nmi_irq_r),
    .ext_irq_r              (ext_irq_r),
    .sft_irq_r              (sft_irq_r),
    .tmr_irq_r              (tmr_irq_r),



    `ifndef N22_HAS_DEBUG
    .dbg_mode     (1'b0),
    `endif

    `ifdef N22_HAS_DEBUG
    .dbg_halt                (dbg_halt),
    .dbg_resethaltreq        (dbg_resethaltreq),

    .cmt_dpc                (cmt_dpc        ),
    .cmt_dpc_ena            (cmt_dpc_ena    ),
    .cmt_dcause             (cmt_dcause     ),
    .cmt_dcause_ena         (cmt_dcause_ena ),

    .dbg_dexc2dbg_r         (dbg_dexc2dbg_r  ),
    .cmt_ddcause           (cmt_ddcause    ),
    .cmt_ddcause_ena       (cmt_ddcause_ena),

    .cmt_dprv_ena    (cmt_dprv_ena),
    .cmt_dprv        (cmt_dprv    ),
    .dbg_prv_r       (dbg_prv_r   ),
    .csr_dpc_r       (csr_dpc_r),

    .dbg_csr_ena       (dbg_csr_ena     ),
    .dbg_csr_wr_en     (dbg_csr_wr_en   ),
    .dbg_csr_rd_en     (dbg_csr_rd_en   ),
    .dbg_wbck_csr_wen  (dbg_wbck_csr_wen),
    .dbg_csr_idx       (dbg_csr_idx     ),
    .dbg_wbck_csr_dat  (dbg_wbck_csr_dat),
    .dbg_read_csr_dat  (dbg_read_csr_dat),
    .dbg_csr_addr_legal(dbg_csr_addr_legal),
    .dbg_csr_prv_ilgl  (dbg_csr_prv_ilgl),


    `ifdef N22_HAS_TRIGM
    .dbg_tdata1      (dbg_tdata1      ),
    .dbg_tdata2      (dbg_tdata2      ),
    .icount_taken_ena(icount_taken_ena),
    `endif

    .dbg_mode               (dbg_mode  ),
    .dbg_step_r             (dbg_step_r),
    .dbg_ebreakm_r          (dbg_ebreakm_r),
    .dbg_stopcount          (dbg_stopcount),
    .dbg_ebreaku_r          (dbg_ebreaku_r),
    .dbg_stepie             (dbg_stepie   ),
    .dbg_mprven             (dbg_mprven   ),
    `endif

    .reset_flag_r           (reset_flag_r),

    .i_valid                (ifu_o_valid         ),
    .i_ready                (ifu_o_ready         ),
    .i_ir                   (ifu_o_ir            ),
    .i_pc                   (ifu_o_pc            ),
    .i_mmode                (ifu_o_pc_mmode      ),
    .i_dmode                (ifu_o_pc_dmode      ),
    .i_pc_vld               (ifu_o_pc_vld        ),
    .i_misalgn              (ifu_o_misalgn       ),
    .i_buserr               (ifu_o_buserr        ),
    .i_buserr_btm           (ifu_o_buserr_btm    ),
    .i_pmperr               (ifu_o_pmperr        ),
    .i_rs1idx               (ifu_o_rs1idx        ),
    .i_rs2idx               (ifu_o_rs2idx        ),
    .i_prdt_taken           (ifu_o_prdt_taken    ),
    .i_prdt_bpu_idx         (ifu_o_prdt_bpu_idx  ),
    .i_muldiv_b2b           (ifu_o_muldiv_b2b    ),
    .i_replaced             (ifu_o_replaced   ),
    .i_replaced_pc          (ifu_o_replaced_pc),

    .wfi_halt_ifu_req       (wfi_halt_ifu_req),
    .wfi_halt_ifu_ack       (wfi_halt_ifu_ack),

`ifdef N22_HAS_DYNAMIC_BPU
    .bpu_updt_ena           (bpu_updt_ena ),
    .bpu_updt_take          (bpu_updt_take),
    .bpu_updt_idx           (bpu_updt_idx),
`endif
    .p1_flush_ack         (p1_flush_ack      ),
    .p1_flush_req         (p1_flush_req      ),
    .p1_flush_pc_mmode    (p1_flush_pc_mmode),
    .p1_flush_pc_dmode    (p1_flush_pc_dmode),
    .p1_flush_pc_vmode    (p1_flush_pc_vmode),
  `ifdef N22_TIMING_BOOST
    .p1_flush_pc          (p1_flush_pc),
    .p1_flush_fencei      (p1_flush_fencei),
  `endif
    .p2_flush_ack           (p2_flush_ack     ),
    .p2_flush_req           (p2_flush_req     ),
    .p2_flush_pc_mmode      (p2_flush_pc_mmode),
    .p2_flush_pc_dmode      (p2_flush_pc_dmode),
    .p2_flush_pc_vmode      (p2_flush_pc_vmode),
    .p2_flush_pc            (p2_flush_pc      ),
    .p2_flush_fencei        (p2_flush_fencei),


    .lsu_o_valid            (lsu_o_valid   ),
    .lsu_o_ready            (lsu_o_ready   ),
    .lsu_o_wbck_wdat        (lsu_o_wbck_wdat    ),
    .lsu_o_wbck_itag        (lsu_o_wbck_itag    ),
    .lsu_o_wbck_err         (lsu_o_wbck_err     ),
    .lsu_o_cmt_pmperr       (lsu_o_cmt_pmperr     ),
    .lsu_o_cmt_buserr       (lsu_o_cmt_buserr     ),
    .lsu_o_cmt_ld           (lsu_o_cmt_ld),
    .lsu_o_cmt_st           (lsu_o_cmt_st),
    .lsu_o_cmt_badaddr      (lsu_o_cmt_badaddr     ),
    .lsu_o_cmt_pc           (lsu_o_cmt_pc),

    .agu_icb_cmd_sel        (agu_icb_cmd_sel     ),

  `ifdef N22_MISALIGNED_AMO
    .agu_unalgn  (agu_unalgn ),
    .agu_load    (agu_load   ),
    .agu_store   (agu_store  ),
  `ifdef N22_HAS_AMO
    .agu_amo     (agu_amo    ),
    .agu_excl    (agu_excl   ),
    .agu_amoswap (agu_amoswap),
    .agu_amoadd  (agu_amoadd ),
    .agu_amoand  (agu_amoand ),
    .agu_amoor   (agu_amoor  ),
    .agu_amoxor  (agu_amoxor ),
    .agu_amomax  (agu_amomax ),
    .agu_amomin  (agu_amomin ),
    .agu_amomaxu (agu_amomaxu),
    .agu_amominu (agu_amominu),
    .agu_amo_rs2 (agu_amo_rs2),
  `endif
  `endif


    .agu_icb_cmd_valid      (agu_icb_cmd_valid   ),
    .agu_icb_cmd_ready      (agu_icb_cmd_ready   ),
    .agu_icb_cmd_addr       (agu_icb_cmd_addr    ),
    .agu_icb_cmd_mmode      (agu_icb_cmd_mmode   ),
    .agu_icb_cmd_dmode      (agu_icb_cmd_dmode   ),
    .agu_icb_cmd_x0base     (agu_icb_cmd_x0base ),
    .agu_icb_cmd_read       (agu_icb_cmd_read    ),
    .agu_icb_cmd_wdata      (agu_icb_cmd_wdata   ),
    .agu_icb_cmd_wmask      (agu_icb_cmd_wmask   ),
    .agu_icb_cmd_size       (agu_icb_cmd_size    ),
    .agu_icb_cmd_usign      (agu_icb_cmd_usign   ),
    .agu_icb_cmd_itag       (agu_icb_cmd_itag    ),
  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32         (agu_icb_cmd_rv32),
  `endif

    .oitf_empty             (oitf_empty   ),
    .rf2ifu_x1              (rf2ifu_x1    ),
    .rf2ifu_rs2             (rf2ifu_rs2   ),
    .dec2ifu_rden           (dec2ifu_rden ),
    .dec2ifu_rs2en          (dec2ifu_rs2en),
    .dec2ifu_rdidx          (dec2ifu_rdidx),
    .dec2ifu_mulhsu         (dec2ifu_mulhsu),
    .dec2ifu_div            (dec2ifu_div   ),
    .dec2ifu_rem            (dec2ifu_rem   ),
    .dec2ifu_divu           (dec2ifu_divu  ),
    .dec2ifu_remu           (dec2ifu_remu  ),


    .clk_aon                (clk_aon),
    .clk                    (clk_exu),
    .rst_n                  (rst_n  )
  );


  wire                        lsu2biu_icb_cmd_sel;

  wire                        lsu2biu_icb_cmd_valid;
  wire                        lsu2biu_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   lsu2biu_icb_cmd_addr;
  wire                        lsu2biu_icb_cmd_read;
  wire [`N22_XLEN-1:0]        lsu2biu_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]      lsu2biu_icb_cmd_wmask;
  wire                        lsu2biu_icb_cmd_lock;
  wire                        lsu2biu_icb_cmd_excl;
  wire [1:0]                  lsu2biu_icb_cmd_size;
  wire                        lsu2biu_icb_cmd_mmode;
  wire                        lsu2biu_icb_cmd_dmode;
  wire                        lsu2biu_icb_cmd_device;
  wire                        lsu2biu_icb_cmd_x0base;

  wire                        lsu2biu_icb_rsp_valid;
  wire                        lsu2biu_icb_rsp_ready;
  wire                        lsu2biu_icb_rsp_err  ;
  wire                        lsu2biu_icb_rsp_excl_ok  ;
  wire [`N22_XLEN-1:0]        lsu2biu_icb_rsp_rdata;




  `ifdef N22_HAS_LBIU
  wire                        lsu2lbiu_icb_cmd_valid;
  wire                        lsu2lbiu_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   lsu2lbiu_icb_cmd_addr;
  wire                        lsu2lbiu_icb_cmd_read;
  wire [`N22_XLEN-1:0]        lsu2lbiu_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]      lsu2lbiu_icb_cmd_wmask;
  wire                        lsu2lbiu_icb_cmd_lock;
  wire                        lsu2lbiu_icb_cmd_excl;
  wire [1:0]                  lsu2lbiu_icb_cmd_size;
  wire                        lsu2lbiu_icb_cmd_mmode;
  wire                        lsu2lbiu_icb_cmd_dmode;
  wire                        lsu2lbiu_icb_cmd_tmr;
  wire                        lsu2lbiu_icb_cmd_ppi;
  wire                        lsu2lbiu_icb_cmd_clic;
  wire                        lsu2lbiu_icb_cmd_fio;
  wire                        lsu2lbiu_icb_rsp_valid;
  wire                        lsu2lbiu_icb_rsp_ready;
  wire                        lsu2lbiu_icb_rsp_err  ;
  wire                        lsu2lbiu_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0]        lsu2lbiu_icb_rsp_rdata;
  `endif

  wire lock_clear_ena;


  n22_lsu  #(
    .N22_DLM_BASE_ADDR       (N22_DLM_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR       (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR       (N22_PPI_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR       (N22_FIO_BASE_ADDR       ),
    .N22_DEVICE_REGION0_BASE (N22_DEVICE_REGION0_BASE ),
    .N22_DEVICE_REGION1_BASE (N22_DEVICE_REGION1_BASE ),
    .N22_DEVICE_REGION2_BASE (N22_DEVICE_REGION2_BASE ),
    .N22_DEVICE_REGION3_BASE (N22_DEVICE_REGION3_BASE ),
    .N22_DEVICE_REGION4_BASE (N22_DEVICE_REGION4_BASE ),
    .N22_DEVICE_REGION5_BASE (N22_DEVICE_REGION5_BASE ),
    .N22_DEVICE_REGION6_BASE (N22_DEVICE_REGION6_BASE ),
    .N22_DEVICE_REGION7_BASE (N22_DEVICE_REGION7_BASE ),
    .N22_TMR_BASE_ADDR       (N22_TMR_BASE_ADDR       ),
    .N22_CLIC_BASE_ADDR      (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR     (N22_DEBUG_BASE_ADDR     )
  )u_n22_lsu(
  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_pend_outs    (lsu_pend_outs),
    .lsu_pend_rv32    (lsu_pend_rv32),
  `endif
`ifdef N22_MISALIGNED_AMO
  `ifdef N22_HAS_PMP
   `ifdef N22_HAS_DEBUG
  .dbg_mprven  (dbg_mprven),
   `endif

  .pmpaddr_r   (pmpaddr_r   ),
  .pmpcfg_bit_r(pmpcfg_bit_r),
  .pmpcfg_bit_w(pmpcfg_bit_w),
  .pmpcfg_bit_x(pmpcfg_bit_x),
  .pmpcfg_bit_a(pmpcfg_bit_a),
  .pmpcfg_bit_l(pmpcfg_bit_l),

  .mstatus_mprv(mstatus_mprv),
  .mpp_m_mode  (mpp_m_mode  ),
  `endif
`endif

    .lock_clear_ena        (lock_clear_ena),
    .csr_ilm_enable        (csr_ilm_enable),
    .csr_dlm_enable        (csr_dlm_enable),
    .excp_active         (excp_active),
    .lsu_active          (lsu_active),
    .lsu_o_valid         (lsu_o_valid   ),
    .lsu_o_ready         (lsu_o_ready   ),
    .lsu_o_wbck_wdat     (lsu_o_wbck_wdat    ),
    .lsu_o_wbck_itag     (lsu_o_wbck_itag    ),
    .lsu_o_wbck_err      (lsu_o_wbck_err     ),
    .lsu_o_cmt_pmperr    (lsu_o_cmt_pmperr     ),
    .lsu_o_cmt_buserr    (lsu_o_cmt_buserr     ),
    .lsu_o_cmt_ld        (lsu_o_cmt_ld),
    .lsu_o_cmt_st        (lsu_o_cmt_st),
    .lsu_o_cmt_badaddr   (lsu_o_cmt_badaddr     ),
    .lsu_o_cmt_pc        (lsu_o_cmt_pc),

  `ifdef N22_MISALIGNED_AMO
    .agu_unalgn  (agu_unalgn ),
    .agu_load    (agu_load   ),
    .agu_store   (agu_store  ),
  `ifdef N22_HAS_AMO
    .agu_amo     (agu_amo    ),
    .agu_excl    (agu_excl   ),
    .agu_amoswap (agu_amoswap),
    .agu_amoadd  (agu_amoadd ),
    .agu_amoand  (agu_amoand ),
    .agu_amoor   (agu_amoor  ),
    .agu_amoxor  (agu_amoxor ),
    .agu_amomax  (agu_amomax ),
    .agu_amomin  (agu_amomin ),
    .agu_amomaxu (agu_amomaxu),
    .agu_amominu (agu_amominu),
    .agu_amo_rs2 (agu_amo_rs2),
  `endif
  `endif

    .agu_icb_cmd_sel        (agu_icb_cmd_sel     ),

    .agu_icb_cmd_valid   (agu_icb_cmd_valid ),
    .agu_icb_cmd_ready   (agu_icb_cmd_ready ),
    .agu_icb_cmd_addr    (agu_icb_cmd_addr  ),
    .agu_icb_cmd_mmode   (agu_icb_cmd_mmode ),
    .agu_icb_cmd_dmode   (agu_icb_cmd_dmode ),
    .agu_icb_cmd_x0base  (agu_icb_cmd_x0base ),
    .agu_icb_cmd_read    (agu_icb_cmd_read  ),
    .agu_icb_cmd_wdata   (agu_icb_cmd_wdata ),
    .agu_icb_cmd_wmask   (agu_icb_cmd_wmask ),
    .agu_icb_cmd_size    (agu_icb_cmd_size  ),

    .agu_icb_cmd_usign   (agu_icb_cmd_usign),
    .agu_icb_cmd_itag    (agu_icb_cmd_itag),

  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32         (agu_icb_cmd_rv32),
  `endif




  `ifdef N22_HAS_LBIU
    .lbiu_icb_cmd_valid  (lsu2lbiu_icb_cmd_valid),
    .lbiu_icb_cmd_ready  (lsu2lbiu_icb_cmd_ready),
    .lbiu_icb_cmd_addr   (lsu2lbiu_icb_cmd_addr ),
    .lbiu_icb_cmd_mmode  (lsu2lbiu_icb_cmd_mmode),
    .lbiu_icb_cmd_dmode  (lsu2lbiu_icb_cmd_dmode),
    .lbiu_icb_cmd_read   (lsu2lbiu_icb_cmd_read ),
    .lbiu_icb_cmd_wdata  (lsu2lbiu_icb_cmd_wdata),
    .lbiu_icb_cmd_wmask  (lsu2lbiu_icb_cmd_wmask),
    .lbiu_icb_cmd_lock   (lsu2lbiu_icb_cmd_lock ),
    .lbiu_icb_cmd_excl   (lsu2lbiu_icb_cmd_excl ),
    .lbiu_icb_cmd_size   (lsu2lbiu_icb_cmd_size ),
    .lbiu_icb_cmd_tmr    (lsu2lbiu_icb_cmd_tmr),
    .lbiu_icb_cmd_ppi    (lsu2lbiu_icb_cmd_ppi),
    .lbiu_icb_cmd_clic    (lsu2lbiu_icb_cmd_clic),
    .lbiu_icb_cmd_fio    (lsu2lbiu_icb_cmd_fio),

    .lbiu_icb_rsp_valid  (lsu2lbiu_icb_rsp_valid),
    .lbiu_icb_rsp_ready  (lsu2lbiu_icb_rsp_ready),
    .lbiu_icb_rsp_err    (lsu2lbiu_icb_rsp_err  ),
    .lbiu_icb_rsp_excl_ok(lsu2lbiu_icb_rsp_excl_ok  ),
    .lbiu_icb_rsp_rdata  (lsu2lbiu_icb_rsp_rdata),
  `endif

    .biu_icb_cmd_sel    (lsu2biu_icb_cmd_sel),

    .biu_icb_cmd_valid  (lsu2biu_icb_cmd_valid),
    .biu_icb_cmd_ready  (lsu2biu_icb_cmd_ready),
    .biu_icb_cmd_addr   (lsu2biu_icb_cmd_addr ),
    .biu_icb_cmd_read   (lsu2biu_icb_cmd_read ),
    .biu_icb_cmd_wdata  (lsu2biu_icb_cmd_wdata),
    .biu_icb_cmd_wmask  (lsu2biu_icb_cmd_wmask),
    .biu_icb_cmd_lock   (lsu2biu_icb_cmd_lock ),
    .biu_icb_cmd_excl   (lsu2biu_icb_cmd_excl ),
    .biu_icb_cmd_size   (lsu2biu_icb_cmd_size ),
    .biu_icb_cmd_mmode  (lsu2biu_icb_cmd_mmode),
    .biu_icb_cmd_dmode  (lsu2biu_icb_cmd_dmode),
    .biu_icb_cmd_device (lsu2biu_icb_cmd_device),
    .biu_icb_cmd_x0base (lsu2biu_icb_cmd_x0base),

    .biu_icb_rsp_valid  (lsu2biu_icb_rsp_valid),
    .biu_icb_rsp_ready  (lsu2biu_icb_rsp_ready),
    .biu_icb_rsp_err    (lsu2biu_icb_rsp_err  ),
    .biu_icb_rsp_excl_ok(lsu2biu_icb_rsp_excl_ok),
    .biu_icb_rsp_rdata  (lsu2biu_icb_rsp_rdata),


  `ifdef N22_D_SHARE_ILM

    .ilm_icb_cmd_sel      (lsu2ilm_icb_cmd_sel),

    .ilm_icb_cmd_valid    (lsu2ilm_icb_cmd_valid  ),
    .ilm_icb_cmd_ready    (lsu2ilm_icb_cmd_ready  ),
    .ilm_icb_cmd_addr     (lsu2ilm_icb_cmd_addr   ),
    .ilm_icb_cmd_mmode    (lsu2ilm_icb_cmd_mmode  ),
    .ilm_icb_cmd_dmode    (lsu2ilm_icb_cmd_dmode  ),
    .ilm_icb_cmd_read     (lsu2ilm_icb_cmd_read   ),
    .ilm_icb_cmd_wdata    (lsu2ilm_icb_cmd_wdata  ),
    .ilm_icb_cmd_wmask    (lsu2ilm_icb_cmd_wmask  ),
    .ilm_icb_cmd_lock     (lsu2ilm_icb_cmd_lock   ),
    .ilm_icb_cmd_excl     (lsu2ilm_icb_cmd_excl   ),
    .ilm_icb_cmd_size     (lsu2ilm_icb_cmd_size   ),

    .ilm_icb_rsp_valid    (lsu2ilm_icb_rsp_valid  ),
    .ilm_icb_rsp_ready    (lsu2ilm_icb_rsp_ready  ),
    .ilm_icb_rsp_err      (lsu2ilm_icb_rsp_err    ),
    .ilm_icb_rsp_excl_ok  (lsu2ilm_icb_rsp_excl_ok),
    .ilm_icb_rsp_rdata    (lsu2ilm_icb_rsp_rdata  ),
  `endif

  `ifdef N22_HAS_DLM
    .dlm_icb_cmd_sel      (lsu2dlm_icb_cmd_sel    ),

    .dlm_icb_cmd_valid    (lsu2dlm_icb_cmd_valid  ),
    .dlm_icb_cmd_ready    (lsu2dlm_icb_cmd_ready  ),
    .dlm_icb_cmd_addr     (lsu2dlm_icb_cmd_addr   ),
    .dlm_icb_cmd_mmode    (lsu2dlm_icb_cmd_mmode  ),
    .dlm_icb_cmd_dmode    (lsu2dlm_icb_cmd_dmode  ),
    .dlm_icb_cmd_read     (lsu2dlm_icb_cmd_read   ),
    .dlm_icb_cmd_wdata    (lsu2dlm_icb_cmd_wdata  ),
    .dlm_icb_cmd_wmask    (lsu2dlm_icb_cmd_wmask  ),
    .dlm_icb_cmd_lock     (lsu2dlm_icb_cmd_lock   ),
    .dlm_icb_cmd_excl     (lsu2dlm_icb_cmd_excl   ),
    .dlm_icb_cmd_size     (lsu2dlm_icb_cmd_size   ),

    .dlm_icb_rsp_valid    (lsu2dlm_icb_rsp_valid  ),
    .dlm_icb_rsp_ready    (lsu2dlm_icb_rsp_ready  ),
    .dlm_icb_rsp_err      (lsu2dlm_icb_rsp_err    ),
    .dlm_icb_rsp_excl_ok  (lsu2dlm_icb_rsp_excl_ok),
    .dlm_icb_rsp_rdata    (lsu2dlm_icb_rsp_rdata  ),
  `endif

    .clk           (clk_lsu ),
    .rst_n         (rst_n        )
  );






    n22_biu   #(
    .N22_DLM_BASE_ADDR       (N22_DLM_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR       (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR       (N22_PPI_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR       (N22_FIO_BASE_ADDR       ),
    .N22_DEVICE_REGION0_BASE (N22_DEVICE_REGION0_BASE ),
    .N22_DEVICE_REGION1_BASE (N22_DEVICE_REGION1_BASE ),
    .N22_DEVICE_REGION2_BASE (N22_DEVICE_REGION2_BASE ),
    .N22_DEVICE_REGION3_BASE (N22_DEVICE_REGION3_BASE ),
    .N22_DEVICE_REGION4_BASE (N22_DEVICE_REGION4_BASE ),
    .N22_DEVICE_REGION5_BASE (N22_DEVICE_REGION5_BASE ),
    .N22_DEVICE_REGION6_BASE (N22_DEVICE_REGION6_BASE ),
    .N22_DEVICE_REGION7_BASE (N22_DEVICE_REGION7_BASE ),
    .N22_TMR_BASE_ADDR       (N22_TMR_BASE_ADDR       ),
    .N22_CLIC_BASE_ADDR      (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR     (N22_DEBUG_BASE_ADDR     )
 )u_n22_biu(

    .lock_clear_ena        (lock_clear_ena),


    .biu_active             (biu_active),

    .lsu2biu_icb_cmd_sel    (lsu2biu_icb_cmd_sel  ),

    .lsu2biu_icb_cmd_valid  (lsu2biu_icb_cmd_valid),
    .lsu2biu_icb_cmd_ready  (lsu2biu_icb_cmd_ready),
    .lsu2biu_icb_cmd_addr   (lsu2biu_icb_cmd_addr ),
    .lsu2biu_icb_cmd_mmode  (lsu2biu_icb_cmd_mmode),
    .lsu2biu_icb_cmd_dmode  (lsu2biu_icb_cmd_dmode),
    .lsu2biu_icb_cmd_device (lsu2biu_icb_cmd_device),
    .lsu2biu_icb_cmd_x0base (lsu2biu_icb_cmd_x0base),
    .lsu2biu_icb_cmd_read   (lsu2biu_icb_cmd_read ),
    .lsu2biu_icb_cmd_wdata  (lsu2biu_icb_cmd_wdata),
    .lsu2biu_icb_cmd_wmask  (lsu2biu_icb_cmd_wmask),
    .lsu2biu_icb_cmd_lock   (lsu2biu_icb_cmd_lock ),
    .lsu2biu_icb_cmd_excl   (lsu2biu_icb_cmd_excl ),
    .lsu2biu_icb_cmd_size   (lsu2biu_icb_cmd_size ),
    .lsu2biu_icb_cmd_burst  (`N22_LSU2BIU_BURST_TYPE),
    .lsu2biu_icb_cmd_beat   (2'b0 ),

    .lsu2biu_icb_rsp_valid  (lsu2biu_icb_rsp_valid),
    .lsu2biu_icb_rsp_ready  (lsu2biu_icb_rsp_ready),
    .lsu2biu_icb_rsp_err    (lsu2biu_icb_rsp_err  ),
    .lsu2biu_icb_rsp_excl_ok(lsu2biu_icb_rsp_excl_ok),
    .lsu2biu_icb_rsp_rdata  (lsu2biu_icb_rsp_rdata),

    .ifu_icb_cmd_valid  (ifu2biu_icb_cmd_valid),
    .ifu_icb_cmd_ready  (ifu2biu_icb_cmd_ready),
    .ifu_icb_cmd_addr   (ifu2biu_icb_cmd_addr ),
    .ifu_icb_cmd_mmode  (ifu2biu_icb_cmd_mmode),
    .ifu_icb_cmd_dmode  (ifu2biu_icb_cmd_dmode),
    .ifu_icb_cmd_device  (ifu2biu_icb_cmd_device),
    .ifu_icb_cmd_vmode  (ifu2biu_icb_cmd_vmode),
    .ifu_icb_cmd_err    (ifu2biu_icb_cmd_err),
    .ifu_icb_cmd_seq    (ifu2biu_icb_cmd_seq),

    .ifu_icb_rsp_valid  (ifu2biu_icb_rsp_valid),
    .ifu_icb_rsp_err    (ifu2biu_icb_rsp_err  ),
    .ifu_icb_rsp_rdata  (ifu2biu_icb_rsp_rdata),

   `ifdef N22_HAS_ICACHE
    .icach2biu_icb_cmd_valid    (icache_icb_cmd_valid),
    .icach2biu_icb_cmd_ready    (icache_icb_cmd_ready),
    .icach2biu_icb_cmd_addr     (icache_icb_cmd_addr ),
    .icach2biu_icb_cmd_mmode    (icache_icb_cmd_mmode),
    .icach2biu_icb_cmd_dmode    (icache_icb_cmd_dmode),
    .icach2biu_icb_cmd_vmode    (icache_icb_cmd_vmode),
    .icach2biu_icb_cmd_read     (icache_icb_cmd_read ),
    .icach2biu_icb_cmd_wdata    (`N22_XLEN'b0),
    .icach2biu_icb_cmd_wmask    ({`N22_XLEN_MW{1'b0}}),
    .icach2biu_icb_cmd_lock     (1'b0 ),
    .icach2biu_icb_cmd_excl     (1'b0 ),
    .icach2biu_icb_cmd_size     (2'b10),
    .icach2biu_icb_cmd_burst    (icache_icb_cmd_burst),
    .icach2biu_icb_cmd_beat     (icache_icb_cmd_beat ),

    .icach2biu_icb_rsp_valid    (icache_icb_rsp_valid),
    .icach2biu_icb_rsp_ready    (1'b1),
    .icach2biu_icb_rsp_err      (icache_icb_rsp_err  ),
    .icach2biu_icb_rsp_rdata    (icache_icb_rsp_rdata),
    .icach2biu_icb_rsp_excl_ok  (),
   `endif



 `ifdef N22_HAS_DEBUG_PRIVATE
    .dm_ahbl_active    (dm_ahbl_active    ),
	.dm_ahbl_htrans    (dm_ahbl_htrans    ),
	.dm_ahbl_hwrite    (dm_ahbl_hwrite    ),
	.dm_ahbl_haddr     (dm_ahbl_haddr     ),
	.dm_ahbl_hsize     (dm_ahbl_hsize     ),
	.dm_ahbl_hburst    (dm_ahbl_hburst    ),
	.dm_ahbl_hwdata    (dm_ahbl_hwdata    ),
	.dm_ahbl_hprot     (dm_ahbl_hprot     ),
	.dm_ahbl_hrdata    (dm_ahbl_hrdata    ),
	.dm_ahbl_hready    (dm_ahbl_hready    ),
	.dm_ahbl_hresp     (dm_ahbl_hresp     ),
 `endif




     `ifdef N22_MEM_TYPE_ICB
    .mem_icb_cmd_valid     (mem_icb_cmd_valid),
    .mem_icb_cmd_ready     (mem_icb_cmd_ready),
    .mem_icb_cmd_addr      (mem_icb_cmd_addr ),
    .mem_icb_cmd_mmode     (mem_icb_cmd_mmode),
    .mem_icb_cmd_dmode     (mem_icb_cmd_dmode),
    .mem_icb_cmd_read      (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata     (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask     (mem_icb_cmd_wmask),
    .mem_icb_cmd_lock      (mem_icb_cmd_lock ),
    .mem_icb_cmd_excl      (mem_icb_cmd_excl ),
    .mem_icb_cmd_size      (mem_icb_cmd_size ),
    .mem_icb_cmd_burst     (mem_icb_cmd_burst),
    .mem_icb_cmd_beat      (mem_icb_cmd_beat ),

    .mem_icb_rsp_valid     (mem_icb_rsp_valid),
    .mem_icb_rsp_ready     (mem_icb_rsp_ready),
    .mem_icb_rsp_err       (mem_icb_rsp_err  ),
    .mem_icb_rsp_excl_ok   (mem_icb_rsp_excl_ok  ),
    .mem_icb_rsp_rdata     (mem_icb_rsp_rdata),

      `endif

      `ifdef N22_MEM_TYPE_AHBL

    .mem_bus_clk_en        (bus_clk_en),

    .mem_ahbl_htrans       (htrans),
    .mem_ahbl_hwrite       (hwrite),
    .mem_ahbl_haddr        (haddr ),
    .mem_ahbl_hsize        (hsize ),
    .mem_ahbl_hlock        (hlock ),
        `ifdef N22_HAS_AMO
    .mem_ahbl_hexcl        (),
    .mem_ahbl_hresp_exok   (1'b0 ),
        `endif
    .mem_ahbl_hburst       (hburst),
    .mem_ahbl_hwdata       (hwdata),
    .mem_ahbl_hrdata       (hrdata),
    .mem_ahbl_hresp        (hresp ),
    .mem_ahbl_hready       (hready),
    .mem_ahbl_hprot        (hprot ),
    .mem_ahbl_hattri       (hattri),
    .mem_ahbl_master       (master),

      `endif


    .clk                    (clk_biu ),
    .rst_n                  (rst_n )
  );



  `ifdef N22_HAS_LBIU
  n22_lbiu u_n22_lbiu(

    .lbiu_active         (lbiu_active),

    .lsu2lbiu_icb_cmd_valid  (lsu2lbiu_icb_cmd_valid),
    .lsu2lbiu_icb_cmd_ready  (lsu2lbiu_icb_cmd_ready),
    .lsu2lbiu_icb_cmd_addr   (lsu2lbiu_icb_cmd_addr ),
    .lsu2lbiu_icb_cmd_mmode  (lsu2lbiu_icb_cmd_mmode),
    .lsu2lbiu_icb_cmd_dmode  (lsu2lbiu_icb_cmd_dmode),
    .lsu2lbiu_icb_cmd_read   (lsu2lbiu_icb_cmd_read ),
    .lsu2lbiu_icb_cmd_wdata  (lsu2lbiu_icb_cmd_wdata),
    .lsu2lbiu_icb_cmd_wmask  (lsu2lbiu_icb_cmd_wmask),
    .lsu2lbiu_icb_cmd_lock   (lsu2lbiu_icb_cmd_lock ),
    .lsu2lbiu_icb_cmd_excl   (lsu2lbiu_icb_cmd_excl ),
    .lsu2lbiu_icb_cmd_size   (lsu2lbiu_icb_cmd_size ),
    .lsu2lbiu_icb_cmd_burst  (`N22_LSU2BIU_BURST_TYPE),
    .lsu2lbiu_icb_cmd_beat   (2'b0 ),
    .lsu2lbiu_icb_cmd_ppi    (lsu2lbiu_icb_cmd_ppi),
    .lsu2lbiu_icb_cmd_tmr    (lsu2lbiu_icb_cmd_tmr),
    .lsu2lbiu_icb_cmd_clic    (lsu2lbiu_icb_cmd_clic),
    .lsu2lbiu_icb_cmd_fio    (lsu2lbiu_icb_cmd_fio),

    .lsu2lbiu_icb_rsp_valid  (lsu2lbiu_icb_rsp_valid),
    .lsu2lbiu_icb_rsp_ready  (lsu2lbiu_icb_rsp_ready),
    .lsu2lbiu_icb_rsp_err    (lsu2lbiu_icb_rsp_err  ),
    .lsu2lbiu_icb_rsp_excl_ok(lsu2lbiu_icb_rsp_excl_ok),
    .lsu2lbiu_icb_rsp_rdata  (lsu2lbiu_icb_rsp_rdata),

  `ifdef N22_HAS_FIO
    .fio_icb_cmd_valid  (fio_cmd_valid),
    .fio_icb_cmd_ready  (1'b1),
    .fio_icb_cmd_addr   (fio_cmd_addr ),
    .fio_icb_cmd_read   (fio_cmd_read ),
    .fio_icb_cmd_mmode  (fio_cmd_mmode ),
    .fio_icb_cmd_dmode  (fio_cmd_dmode ),
    .fio_icb_cmd_wdata  (fio_cmd_wdata),
    .fio_icb_cmd_wmask  (fio_cmd_wmask),
    .fio_icb_cmd_lock   (),
    .fio_icb_cmd_excl   (),
    .fio_icb_cmd_size   (),
    .fio_icb_cmd_burst  (),
    .fio_icb_cmd_beat   (),

    .fio_icb_rsp_valid  (fio_cmd_valid),
    .fio_icb_rsp_ready  (),
    .fio_icb_rsp_err    (fio_rsp_err  ),
    .fio_icb_rsp_excl_ok(1'b0),
    .fio_icb_rsp_rdata  (fio_rsp_rdata),

  `endif

    `ifdef N22_HAS_PPI
      `ifdef N22_PPI_TYPE_ICB
    .ppi_icb_cmd_valid     (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready     (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr      (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_mmode     (ppi_icb_cmd_mmode),
    .ppi_icb_cmd_dmode     (ppi_icb_cmd_dmode),
    .ppi_icb_cmd_read      (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata     (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask     (ppi_icb_cmd_wmask),
    .ppi_icb_cmd_lock      (ppi_icb_cmd_lock ),
    .ppi_icb_cmd_excl      (ppi_icb_cmd_excl ),
    .ppi_icb_cmd_size      (ppi_icb_cmd_size ),
    .ppi_icb_cmd_burst     (),
    .ppi_icb_cmd_beat      (),

    .ppi_icb_rsp_valid     (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready     (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err       (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_excl_ok   (ppi_icb_rsp_excl_ok),
    .ppi_icb_rsp_rdata     (ppi_icb_rsp_rdata),
      `endif

      `ifdef N22_PPI_TYPE_APB
    .ppi_apb_paddr         (ppi_paddr  ),
    .ppi_apb_pwrite        (ppi_pwrite ),
    .ppi_apb_psel          (ppi_psel   ),
    .ppi_apb_dmode         (ppi_dmode  ),
    .ppi_apb_pprot         (ppi_pprot  ),
    .ppi_apb_pstrobe       (ppi_pstrobe),
    .ppi_apb_penable       (ppi_penable),
    .ppi_apb_pwdata        (ppi_pwdata ),
    .ppi_apb_prdata        (ppi_prdata ),
    .ppi_apb_pready        (ppi_pready ),
    .ppi_apb_pslverr       (ppi_pslverr),
      `endif
    `endif

    `ifdef N22_HAS_CLIC
    .clic_icb_cmd_valid     (clic_icb_cmd_valid),
    .clic_icb_cmd_ready     (clic_icb_cmd_ready),
    .clic_icb_cmd_addr      (clic_icb_cmd_addr ),
    .clic_icb_cmd_mmode     (clic_icb_cmd_mmode),
    .clic_icb_cmd_dmode     (clic_icb_cmd_dmode),
    .clic_icb_cmd_read      (clic_icb_cmd_read ),
    .clic_icb_cmd_wdata     (clic_icb_cmd_wdata),
    .clic_icb_cmd_wmask     (clic_icb_cmd_wmask),
    .clic_icb_cmd_lock      (),
    .clic_icb_cmd_excl      (),
    .clic_icb_cmd_size      (),
    .clic_icb_cmd_burst     (),
    .clic_icb_cmd_beat      (),

    .clic_icb_rsp_valid     (clic_icb_rsp_valid),
    .clic_icb_rsp_ready     (clic_icb_rsp_ready),
    .clic_icb_rsp_err       (clic_icb_rsp_err  ),
    .clic_icb_rsp_excl_ok   (1'b0),
    .clic_icb_rsp_rdata     (clic_icb_rsp_rdata),
    `endif

    `ifdef N22_TMR_PRIVATE
    .tmr_icb_cmd_valid     (tmr_icb_cmd_valid),
    .tmr_icb_cmd_ready     (tmr_icb_cmd_ready),
    .tmr_icb_cmd_addr      (tmr_icb_cmd_addr ),
    .tmr_icb_cmd_mmode     (tmr_icb_cmd_mmode),
    .tmr_icb_cmd_dmode     (tmr_icb_cmd_dmode),
    .tmr_icb_cmd_read      (tmr_icb_cmd_read ),
    .tmr_icb_cmd_wdata     (tmr_icb_cmd_wdata),
    .tmr_icb_cmd_wmask     (tmr_icb_cmd_wmask),
    .tmr_icb_cmd_lock      (),
    .tmr_icb_cmd_excl      (),
    .tmr_icb_cmd_size      (),
    .tmr_icb_cmd_burst     (),
    .tmr_icb_cmd_beat      (),

    .tmr_icb_rsp_valid     (tmr_icb_rsp_valid),
    .tmr_icb_rsp_ready     (tmr_icb_rsp_ready),
    .tmr_icb_rsp_err       (tmr_icb_rsp_err  ),
    .tmr_icb_rsp_excl_ok   (1'b0),
    .tmr_icb_rsp_rdata     (tmr_icb_rsp_rdata),
    `endif

    .clk                    (clk_lbiu ),
    .rst_n                  (rst_n )
  );

    `endif

      `ifdef N22_HAS_DEBUG
    assign hart_unavail = hart_under_reset;
      `endif

endmodule



