
`include "global.inc"

module n22_ifu #(
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
  output reset_flag_r,
  input [31:0] csr_uitb_addr,

  input bus_clk_en,

  input core_wfi,
  input excp_active,

  output ifu_active,

  input  [`N22_PC_SIZE-1:0] pc_rtvec,



  output ifu2biu_icb_cmd_valid,
  input  ifu2biu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   ifu2biu_icb_cmd_addr,
  output ifu2biu_icb_cmd_mmode,
  output ifu2biu_icb_cmd_dmode,
  output ifu2biu_icb_cmd_device,
  output ifu2biu_icb_cmd_vmode,
  output ifu2biu_icb_cmd_err,
  output ifu2biu_icb_cmd_seq,

  input  ifu2biu_icb_rsp_valid,
  input  ifu2biu_icb_rsp_err,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu2biu_icb_rsp_rdata,



  `ifdef N22_HAS_ILM

  output ifu2ilm_icb_cmd_valid,
  input  ifu2ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ifu2ilm_icb_cmd_addr,
  output ifu2ilm_icb_cmd_mmode,
  output ifu2ilm_icb_cmd_dmode,
  output ifu2ilm_icb_cmd_vmode,

  input  ifu2ilm_icb_rsp_valid,
  input  ifu2ilm_icb_rsp_err,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu2ilm_icb_rsp_rdata,

  `endif

  `ifdef N22_D_SHARE_DLM

  output ifu2dlm_icb_cmd_valid,
  input  ifu2dlm_icb_cmd_ready,
  output [`N22_DLM_ADDR_WIDTH-1:0]   ifu2dlm_icb_cmd_addr,
  output ifu2dlm_icb_cmd_mmode,
  output ifu2dlm_icb_cmd_dmode,

  input  ifu2dlm_icb_rsp_valid,
  input  ifu2dlm_icb_rsp_err,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu2dlm_icb_rsp_rdata,

  `endif

  input  csr_bpu_enable   ,
  input  csr_ilm_enable   ,
  input  csr_icache_enable,
  input  csr_rvcompm_enable,

  `ifdef N22_HAS_ICACHE
  input  icache_disable_init,

  output                           icache_w0_tram_cs,
  output                           icache_w0_tram_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_w0_tram_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w0_tram_din,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w0_tram_dout,
  output                       clk_icache_w0_tram,

  output                           icache_w0_dram_cs,
  output                           icache_w0_dram_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_w0_dram_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w0_dram_din,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w0_dram_dout,
  output                       clk_icache_w0_dram,

     `ifdef N22_ICACHE_2WAYS
  output                           icache_w1_tram_cs,
  output                           icache_w1_tram_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_w1_tram_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w1_tram_din,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w1_tram_dout,
  output                       clk_icache_w1_tram,


  output                           icache_w1_dram_cs,
  output                           icache_w1_dram_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_w1_dram_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w1_dram_din,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w1_dram_dout,
  output                       clk_icache_w1_dram,
     `endif

  output  icache_icb_cmd_valid,
  input   icache_icb_cmd_ready,
  output  [`N22_ADDR_SIZE-1:0] icache_icb_cmd_addr,
  output  icache_icb_cmd_mmode,
  output  icache_icb_cmd_dmode,
  output  icache_icb_cmd_vmode,
  output  icache_icb_cmd_read,
  output  [2:0] icache_icb_cmd_burst,
  output  [1:0] icache_icb_cmd_beat,

  input   icache_icb_rsp_valid,
  input   icache_icb_rsp_err,
  input   [32-1:0] icache_icb_rsp_rdata,

  input  icache_ram_cgstop,

  output icache_active,
  input  clk_icache,
  `endif

  output pft_active,
  input  clk_pft,
  output [`N22_INSTR_SIZE-1:0] ifu_o_ir,
  output [`N22_PC_SIZE-1:0] ifu_o_pc,
  output ifu_o_pc_mmode,
  output ifu_o_pc_dmode,
  output ifu_o_pc_vld,
  output ifu_o_misalgn,
  output ifu_o_buserr,
  output ifu_o_buserr_btm,
  output ifu_o_pmperr,
  output [`N22_RFIDX_WIDTH-1:0] ifu_o_rs1idx,
  output [`N22_RFIDX_WIDTH-1:0] ifu_o_rs2idx,
  output ifu_o_prdt_taken,
  output [`N22_BPU_IDX_W-1:0] ifu_o_prdt_bpu_idx,
  output ifu_o_muldiv_b2b,
  output ifu_o_valid,
  input  ifu_o_ready,
  output  ifu_o_replaced,
  output  [`N22_PC_SIZE-1:0] ifu_o_replaced_pc,

  `ifdef N22_HAS_DYNAMIC_BPU
  input  bpu_updt_ena ,
  input  bpu_updt_take,
  input  [`N22_BPU_IDX_W-1:0] bpu_updt_idx,
  `endif
  output  p1_flush_ack,
  input   p1_flush_req,
  `ifdef N22_TIMING_BOOST
  input   [`N22_PC_SIZE-1:0] p1_flush_pc,
  input   p1_flush_pc_mmode,
  input   p1_flush_pc_dmode,
  input   p1_flush_pc_vmode,
  input   p1_flush_fencei,
  `endif

  output  p2_flush_ack,
  input   p2_flush_req,
  input   [`N22_PC_SIZE-1:0] p2_flush_pc,
  input   p2_flush_pc_mmode,
  input   p2_flush_pc_dmode,
  input   p2_flush_pc_vmode,
  input   p2_flush_fencei,

  input  ifu_halt_req,
  output ifu_halt_ack,

  input  oitf_empty,
  input  [`N22_XLEN-1:0] rf2ifu_x1,
  input  [`N22_XLEN-1:0] rf2ifu_rs2,
  input  dec2ifu_rden,
  input  dec2ifu_rs2en,
  input  [`N22_RFIDX_WIDTH-1:0] dec2ifu_rdidx,
  input  dec2ifu_mulhsu,
  input  dec2ifu_div   ,
  input  dec2ifu_rem   ,
  input  dec2ifu_divu  ,
  input  dec2ifu_remu  ,
  `ifdef N22_HAS_CLIC
  output minhv_clear_r,
  `endif
  `ifdef N22_HAS_PMP
  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,

  `endif



  input  clkgate_bypass,
  input  clk_ifu,
  input  rst_n
  );

  wire ifu_req_valid;
  wire ifu_req_ready;
  wire [`N22_PC_SIZE-1:0]   ifu_req_pc;
  wire ifu_req_mmode;
  wire ifu_req_dmode;
  wire ifu_req_vmode;
  wire ifu_req_seq;
  wire ifu_req_seq_rv32;
  wire ifu_rsp_valid;
  wire ifu_rsp_ready;
  wire ifu_rsp_err;
  wire ifu_rsp_err_btm;
  wire ifu_rsp_pmperr;
  wire [`N22_INSTR_SIZE-1:0] ifu_rsp_instr;


  wire pft_no_outs;

  `ifdef N22_HAS_ICACHE
   wire icache_flush_req ;
   wire icache_flush_done;
   wire icache_no_outs;
  `endif

  wire ifu_flush_req;

  n22_ifu_ifetch   #(
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
  )  u_n22_ifu_ifetch(
    .csr_uitb_addr  (csr_uitb_addr  ),
    .inspect_pc   (),
    .pc_rtvec      (pc_rtvec),
    .ifu_req_valid (ifu_req_valid),
    .ifu_req_ready (ifu_req_ready),
    .ifu_req_pc    (ifu_req_pc   ),
    .ifu_req_mmode (ifu_req_mmode),
    .ifu_req_dmode (ifu_req_dmode),
    .ifu_req_vmode (ifu_req_vmode),
    .ifu_req_seq     (ifu_req_seq     ),
    .ifu_req_seq_rv32(ifu_req_seq_rv32),

    .ifu_rsp_valid (ifu_rsp_valid),
    .ifu_rsp_ready (ifu_rsp_ready),
    .ifu_rsp_err   (ifu_rsp_err  ),
    .ifu_rsp_err_btm   (ifu_rsp_err_btm  ),
    .ifu_rsp_pmperr(ifu_rsp_pmperr  ),
    .ifu_rsp_instr (ifu_rsp_instr),

    .ifu_flush_req(ifu_flush_req),
  `ifdef N22_HAS_CLIC
    .minhv_clear_r   (minhv_clear_r),
  `endif

    .ifu_o_ir      (ifu_o_ir     ),
    .ifu_o_pc      (ifu_o_pc     ),
    .ifu_o_pc_mmode(ifu_o_pc_mmode),
    .ifu_o_pc_dmode(ifu_o_pc_dmode),
    .ifu_o_pc_vld  (ifu_o_pc_vld ),
    .ifu_o_misalgn (ifu_o_misalgn),
    .ifu_o_buserr  (ifu_o_buserr ),
    .ifu_o_buserr_btm  (ifu_o_buserr_btm ),
    .ifu_o_pmperr  (ifu_o_pmperr ),
    .ifu_o_rs1idx  (ifu_o_rs1idx),
    .ifu_o_rs2idx  (ifu_o_rs2idx),
    .ifu_o_prdt_taken(ifu_o_prdt_taken),
    .ifu_o_prdt_bpu_idx(ifu_o_prdt_bpu_idx),
    .ifu_o_muldiv_b2b(ifu_o_muldiv_b2b),
    .ifu_o_valid   (ifu_o_valid  ),
    .ifu_o_ready   (ifu_o_ready  ),
    .ifu_o_replaced   (ifu_o_replaced   ),
    .ifu_o_replaced_pc(ifu_o_replaced_pc),
  `ifdef N22_HAS_DYNAMIC_BPU
    .bpu_updt_ena (bpu_updt_ena ),
    .bpu_updt_take(bpu_updt_take),
    .bpu_updt_idx (bpu_updt_idx),
  `endif
    .p1_flush_ack     (p1_flush_ack    ),
    .p1_flush_req     (p1_flush_req    ),
  `ifdef N22_TIMING_BOOST
    .p1_flush_pc      (p1_flush_pc),
    .p1_flush_fencei  (p1_flush_fencei),
    .p1_flush_pc_dmode(p1_flush_pc_dmode),
    .p1_flush_pc_vmode(p1_flush_pc_vmode),
    .p1_flush_pc_mmode(p1_flush_pc_mmode),
  `endif
    .p2_flush_ack       (p2_flush_ack     ),
    .p2_flush_req       (p2_flush_req     ),
    .p2_flush_pc        (p2_flush_pc      ),
    .p2_flush_pc_mmode  (p2_flush_pc_mmode),
    .p2_flush_pc_dmode  (p2_flush_pc_dmode),
    .p2_flush_pc_vmode  (p2_flush_pc_vmode),
    .p2_flush_fencei  (p2_flush_fencei),

    .pft_no_outs  (pft_no_outs),

    .ifu_halt_req  (ifu_halt_req ),
    .ifu_halt_ack  (ifu_halt_ack ),

    .oitf_empty    (oitf_empty   ),
    .rf2ifu_x1     (rf2ifu_x1    ),
    .rf2ifu_rs2    (rf2ifu_rs2   ),
    .dec2ifu_rden  (dec2ifu_rden ),
    .dec2ifu_rs2en (dec2ifu_rs2en),
    .dec2ifu_rdidx (dec2ifu_rdidx),
    .dec2ifu_mulhsu(dec2ifu_mulhsu),
    .dec2ifu_div   (dec2ifu_div   ),
    .dec2ifu_rem   (dec2ifu_rem   ),
    .dec2ifu_divu  (dec2ifu_divu  ),
    .dec2ifu_remu  (dec2ifu_remu  ),

    .reset_flag_r  (reset_flag_r),
  `ifdef N22_HAS_ICACHE
    .icache_flush_req (icache_flush_req),
    .icache_flush_done(icache_flush_done),
    .icache_no_outs   (icache_no_outs),
  `endif
    .csr_icache_enable(csr_icache_enable),
    .csr_bpu_enable   (csr_bpu_enable),
    .csr_rvcompm_enable   (csr_rvcompm_enable),

    .clk           (clk_ifu      ),
    .rst_n         (rst_n        )
  );


  `ifdef N22_HAS_ICACHE
  wire ifu2icache_icb_cmd_valid;
  wire ifu2icache_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0] ifu2icache_icb_cmd_addr;
  wire ifu2icache_icb_cmd_mmode ;
  wire ifu2icache_icb_cmd_vmode ;
  wire ifu2icache_icb_cmd_dmode ;
  wire ifu2icache_icb_cmd_err;

  wire ifu2icache_icb_rsp_valid;
  wire ifu2icache_icb_rsp_err;
  wire [`N22_ICACHE_DATA_WIDTH-1:0] ifu2icache_icb_rsp_rdata;

  `endif


  wire ifu_icb_cmd_valid;
  wire ifu_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   ifu_icb_cmd_addr;
  wire ifu_icb_cmd_dmode;
  wire ifu_icb_cmd_vmode;
  wire ifu_icb_cmd_mmode;
  wire ifu_icb_cmd_seq;

  wire ifu_icb_rsp_valid;
  wire ifu_icb_rsp_err;
  wire ifu_icb_rsp_pmperr;
  wire [`N22_SYSMEM_DATA_WIDTH-1:0] ifu_icb_rsp_rdata;


  n22_ifu_ift2icb u_n22_ifu_ift2icb (
    .ifu_req_valid (ifu_req_valid),
    .ifu_req_ready (ifu_req_ready),
    .ifu_req_pc    (ifu_req_pc   ),
    .ifu_req_mmode (ifu_req_mmode),
    .ifu_req_dmode (ifu_req_dmode),
    .ifu_req_vmode (ifu_req_vmode),
    .ifu_req_seq     (ifu_req_seq     ),
    .ifu_req_seq_rv32(ifu_req_seq_rv32),

    .ifu_rsp_valid (ifu_rsp_valid),
    .ifu_rsp_ready (ifu_rsp_ready),
    .ifu_rsp_err   (ifu_rsp_err  ),
    .ifu_rsp_err_btm   (ifu_rsp_err_btm  ),
    .ifu_rsp_pmperr(ifu_rsp_pmperr  ),
    .ifu_rsp_instr (ifu_rsp_instr),

    .ifu_flush_req(ifu_flush_req),


    .ifu_icb_cmd_valid (ifu_icb_cmd_valid ),
    .ifu_icb_cmd_ready (ifu_icb_cmd_ready ),
    .ifu_icb_cmd_addr  (ifu_icb_cmd_addr  ),
    .ifu_icb_cmd_dmode (ifu_icb_cmd_dmode ),
    .ifu_icb_cmd_vmode (ifu_icb_cmd_vmode ),
    .ifu_icb_cmd_mmode (ifu_icb_cmd_mmode ),
    .ifu_icb_cmd_seq   (ifu_icb_cmd_seq   ),

    .ifu_icb_rsp_valid (ifu_icb_rsp_valid ),
    .ifu_icb_rsp_err   (ifu_icb_rsp_err   ),
    .ifu_icb_rsp_pmperr(ifu_icb_rsp_pmperr),
    .ifu_icb_rsp_rdata (ifu_icb_rsp_rdata ),


    .clk           (clk_ifu   ),
    .rst_n         (rst_n     )
  );

  n22_ifu_icbctrl   #(
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
  )  u_n22_ifu_icbctrl(
    .csr_ilm_enable   (csr_ilm_enable   ),
    .csr_icache_enable(csr_icache_enable),

    .ifu_icb_cmd_valid (ifu_icb_cmd_valid ),
    .ifu_icb_cmd_ready (ifu_icb_cmd_ready ),
    .ifu_icb_cmd_addr  (ifu_icb_cmd_addr  ),
    .ifu_icb_cmd_dmode (ifu_icb_cmd_dmode ),
    .ifu_icb_cmd_vmode (ifu_icb_cmd_vmode ),
    .ifu_icb_cmd_mmode (ifu_icb_cmd_mmode ),
    .ifu_icb_cmd_seq   (ifu_icb_cmd_seq   ),

    .ifu_icb_rsp_valid (ifu_icb_rsp_valid ),
    .ifu_icb_rsp_err   (ifu_icb_rsp_err   ),
    .ifu_icb_rsp_pmperr(ifu_icb_rsp_pmperr),
    .ifu_icb_rsp_rdata (ifu_icb_rsp_rdata ),


    .ifu2biu_icb_cmd_valid(ifu2biu_icb_cmd_valid),
    .ifu2biu_icb_cmd_ready(ifu2biu_icb_cmd_ready),
    .ifu2biu_icb_cmd_addr (ifu2biu_icb_cmd_addr ),
    .ifu2biu_icb_cmd_mmode (ifu2biu_icb_cmd_mmode ),
    .ifu2biu_icb_cmd_dmode (ifu2biu_icb_cmd_dmode ),
    .ifu2biu_icb_cmd_device (ifu2biu_icb_cmd_device ),
    .ifu2biu_icb_cmd_vmode (ifu2biu_icb_cmd_vmode ),
    .ifu2biu_icb_cmd_err (ifu2biu_icb_cmd_err ),
    .ifu2biu_icb_cmd_seq (ifu2biu_icb_cmd_seq ),

    .ifu2biu_icb_rsp_valid(ifu2biu_icb_rsp_valid),
    .ifu2biu_icb_rsp_err  (ifu2biu_icb_rsp_err  ),
    .ifu2biu_icb_rsp_rdata(ifu2biu_icb_rsp_rdata),



  `ifdef N22_HAS_ILM
    .ifu2ilm_icb_cmd_valid(ifu2ilm_icb_cmd_valid),
    .ifu2ilm_icb_cmd_ready(ifu2ilm_icb_cmd_ready),
    .ifu2ilm_icb_cmd_addr (ifu2ilm_icb_cmd_addr ),
    .ifu2ilm_icb_cmd_mmode(ifu2ilm_icb_cmd_mmode ),
    .ifu2ilm_icb_cmd_dmode(ifu2ilm_icb_cmd_dmode ),
    .ifu2ilm_icb_cmd_vmode (ifu2ilm_icb_cmd_vmode),

    .ifu2ilm_icb_rsp_valid(ifu2ilm_icb_rsp_valid),
    .ifu2ilm_icb_rsp_err  (ifu2ilm_icb_rsp_err  ),
    .ifu2ilm_icb_rsp_rdata(ifu2ilm_icb_rsp_rdata),

  `endif


  `ifdef N22_HAS_ICACHE

    .ifu2icache_icb_cmd_valid (ifu2icache_icb_cmd_valid),
    .ifu2icache_icb_cmd_ready (ifu2icache_icb_cmd_ready),
    .ifu2icache_icb_cmd_addr  (ifu2icache_icb_cmd_addr ),
    .ifu2icache_icb_cmd_mmode  (ifu2icache_icb_cmd_mmode ),
    .ifu2icache_icb_cmd_vmode  (ifu2icache_icb_cmd_vmode ),
    .ifu2icache_icb_cmd_dmode  (ifu2icache_icb_cmd_dmode ),
    .ifu2icache_icb_cmd_err (ifu2icache_icb_cmd_err ),

    .ifu2icache_icb_rsp_valid (ifu2icache_icb_rsp_valid),
    .ifu2icache_icb_rsp_err   (ifu2icache_icb_rsp_err  ),
    .ifu2icache_icb_rsp_rdata (ifu2icache_icb_rsp_rdata),

  `endif


  `ifdef N22_HAS_PMP
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),
  `endif

    .pft_no_outs  (pft_no_outs),

    .pft_active    (pft_active),
    .clk_ifu       (clk_ifu   ),
    .clk_pft       (clk_pft   ),
    .rst_n         (rst_n     )
  );

  `ifdef N22_HAS_ICACHE
  n22_icache u_n22_icache(
     .icache_active    (icache_active    ),
     .icache_ram_cgstop (icache_ram_cgstop ),
     .icache_rstinit_dis(icache_disable_init),

     .bus_clk_en     (bus_clk_en),

     .icache_flush_req (icache_flush_req),
     .icache_flush_done(icache_flush_done),
     .icache_no_outs   (icache_no_outs),

     .icb_cmd_valid  (ifu2icache_icb_cmd_valid),
     .icb_cmd_ready  (ifu2icache_icb_cmd_ready),
     .icb_cmd_addr   (ifu2icache_icb_cmd_addr ),
     .icb_cmd_mmode  (ifu2icache_icb_cmd_mmode),
     .icb_cmd_vmode  (ifu2icache_icb_cmd_vmode),
     .icb_cmd_err    (ifu2icache_icb_cmd_err  ),

     .icb_rsp_valid  (ifu2icache_icb_rsp_valid),
     .icb_rsp_err    (ifu2icache_icb_rsp_err  ),
     .icb_rsp_rdata  (ifu2icache_icb_rsp_rdata),



     .icache_w0_tram_cs    (icache_w0_tram_cs  ),
     .icache_w0_tram_we    (icache_w0_tram_we  ),
     .icache_w0_tram_addr  (icache_w0_tram_addr),
     .icache_w0_tram_din   (icache_w0_tram_din ),
     .icache_w0_tram_dout  (icache_w0_tram_dout),
     .clk_icache_w0_tram   (clk_icache_w0_tram ),

     .icache_w0_dram_cs    (icache_w0_dram_cs  ),
     .icache_w0_dram_we    (icache_w0_dram_we  ),
     .icache_w0_dram_addr  (icache_w0_dram_addr),
     .icache_w0_dram_din   (icache_w0_dram_din ),
     .icache_w0_dram_dout  (icache_w0_dram_dout),
     .clk_icache_w0_dram   (clk_icache_w0_dram ),

     `ifdef N22_ICACHE_2WAYS
     .icache_w1_tram_cs    (icache_w1_tram_cs  ),
     .icache_w1_tram_we    (icache_w1_tram_we  ),
     .icache_w1_tram_addr  (icache_w1_tram_addr),
     .icache_w1_tram_din   (icache_w1_tram_din ),
     .icache_w1_tram_dout  (icache_w1_tram_dout),
     .clk_icache_w1_tram   (clk_icache_w1_tram ),

     .icache_w1_dram_cs    (icache_w1_dram_cs  ),
     .icache_w1_dram_we    (icache_w1_dram_we  ),
     .icache_w1_dram_addr  (icache_w1_dram_addr),
     .icache_w1_dram_din   (icache_w1_dram_din ),
     .icache_w1_dram_dout  (icache_w1_dram_dout),
     .clk_icache_w1_dram   (clk_icache_w1_dram ),
     `endif


     .miss_icb_cmd_valid (icache_icb_cmd_valid),
     .miss_icb_cmd_ready (icache_icb_cmd_ready),
     .miss_icb_cmd_addr  (icache_icb_cmd_addr ),
     .miss_icb_cmd_read  (icache_icb_cmd_read ),
     .miss_icb_cmd_burst (icache_icb_cmd_burst),
     .miss_icb_cmd_beat  (icache_icb_cmd_beat),
     .miss_icb_cmd_mmode (icache_icb_cmd_mmode),
     .miss_icb_cmd_dmode (icache_icb_cmd_dmode),
     .miss_icb_cmd_vmode (icache_icb_cmd_vmode),

     .miss_icb_rsp_valid (icache_icb_rsp_valid),
     .miss_icb_rsp_err   (icache_icb_rsp_err),
     .miss_icb_rsp_rdata (icache_icb_rsp_rdata),

    .reset_flag_r(reset_flag_r),

    .clkgate_bypass  (clkgate_bypass),
    .clk           (clk_icache    ),
    .rst_n         (rst_n        )
  );
  `endif


  assign ifu_active = (~core_wfi);

endmodule

