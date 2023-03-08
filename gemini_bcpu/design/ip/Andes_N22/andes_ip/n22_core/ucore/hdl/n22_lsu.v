
`include "global.inc"

module n22_lsu #(
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
  `ifdef N22_LDST_EXCP_PRECISE
  output lsu_pend_outs,
  output lsu_pend_rv32,
  `endif

`ifdef N22_MISALIGNED_AMO
  `ifdef N22_HAS_PMP
   `ifdef N22_HAS_DEBUG
  input dbg_mprven,
   `endif

  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,

  input  mstatus_mprv,
  input  mpp_m_mode,
  `endif
`endif

  input csr_ilm_enable,
  input csr_dlm_enable,
  input  excp_active,
  output lsu_active,

  output lock_clear_ena,



  output lsu_o_valid,
  input  lsu_o_ready,
  output [`N22_XLEN-1:0] lsu_o_wbck_wdat,
  output [`N22_ITAG_WIDTH -1:0] lsu_o_wbck_itag,
  output lsu_o_wbck_err ,
  output lsu_o_cmt_ld,
  output lsu_o_cmt_st,
  output [`N22_ADDR_SIZE -1:0] lsu_o_cmt_badaddr,
  output [`N22_ADDR_SIZE -1:0] lsu_o_cmt_pc,
  output lsu_o_cmt_buserr ,
  output lsu_o_cmt_pmperr ,



  input                          agu_icb_cmd_sel,
  input                          agu_icb_cmd_valid,
  output                         agu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   agu_icb_cmd_addr,
  input                          agu_icb_cmd_read,
  input                          agu_icb_cmd_x0base,
  input                          agu_icb_cmd_mmode,
  input                          agu_icb_cmd_dmode,
  input  [`N22_XLEN-1:0]        agu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]      agu_icb_cmd_wmask,
  input  [1:0]                   agu_icb_cmd_size,
  input                          agu_icb_cmd_usign,
  input  [`N22_ITAG_WIDTH -1:0] agu_icb_cmd_itag,
  `ifdef N22_LDST_EXCP_PRECISE
  input                          agu_icb_cmd_rv32,
  `endif


  `ifdef N22_MISALIGNED_AMO
  input  agu_unalgn  ,
  input  agu_load    ,
  input  agu_store   ,
  `ifdef N22_HAS_AMO
  input  agu_amo     ,
  input  agu_excl    ,
  input  agu_amoswap ,
  input  agu_amoadd  ,
  input  agu_amoand  ,
  input  agu_amoor   ,
  input  agu_amoxor  ,
  input  agu_amomax  ,
  input  agu_amomin  ,
  input  agu_amomaxu ,
  input  agu_amominu ,
  input  [`N22_XLEN-1:0]      agu_amo_rs2,
  `endif
  `endif







   `ifdef N22_D_SHARE_ILM
  output                         ilm_icb_cmd_sel,
  output                         ilm_icb_cmd_valid,
  input                          ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ilm_icb_cmd_addr,
  output                         ilm_icb_cmd_mmode,
  output                         ilm_icb_cmd_dmode,
  output                         ilm_icb_cmd_read,
  output [`N22_XLEN-1:0]        ilm_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      ilm_icb_cmd_wmask,
  output                         ilm_icb_cmd_lock,
  output                         ilm_icb_cmd_excl,
  output [1:0]                   ilm_icb_cmd_size,
  input                          ilm_icb_rsp_valid,
  output                         ilm_icb_rsp_ready,
  input                          ilm_icb_rsp_err  ,
  input                          ilm_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        ilm_icb_rsp_rdata,
  `endif

  `ifdef N22_HAS_DLM
  output                         dlm_icb_cmd_sel,
  output                         dlm_icb_cmd_valid,
  input                          dlm_icb_cmd_ready,
  output [`N22_DLM_ADDR_WIDTH-1:0]   dlm_icb_cmd_addr,
  output                         dlm_icb_cmd_mmode,
  output                         dlm_icb_cmd_dmode,
  output                         dlm_icb_cmd_read,
  output [`N22_XLEN-1:0]        dlm_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      dlm_icb_cmd_wmask,
  output                         dlm_icb_cmd_lock,
  output                         dlm_icb_cmd_excl,
  output [1:0]                   dlm_icb_cmd_size,
  input                          dlm_icb_rsp_valid,
  output                         dlm_icb_rsp_ready,
  input                          dlm_icb_rsp_err  ,
  input                          dlm_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        dlm_icb_rsp_rdata,
  `endif


  `ifdef N22_HAS_LBIU
  output                         lbiu_icb_cmd_valid,
  input                          lbiu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   lbiu_icb_cmd_addr,
  output                         lbiu_icb_cmd_mmode,
  output                         lbiu_icb_cmd_dmode,
  output                         lbiu_icb_cmd_read,
  output [`N22_XLEN-1:0]        lbiu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      lbiu_icb_cmd_wmask,
  output                         lbiu_icb_cmd_lock,
  output                         lbiu_icb_cmd_excl,
  output [1:0]                   lbiu_icb_cmd_size,
  output                         lbiu_icb_cmd_ppi,
  output                         lbiu_icb_cmd_tmr,
  output                         lbiu_icb_cmd_clic,
  output                         lbiu_icb_cmd_fio,
  input                          lbiu_icb_rsp_valid,
  output                         lbiu_icb_rsp_ready,
  input                          lbiu_icb_rsp_err  ,
  input                          lbiu_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        lbiu_icb_rsp_rdata,
  `endif


  output                         biu_icb_cmd_sel,
  output                         biu_icb_cmd_valid,
  input                          biu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   biu_icb_cmd_addr,
  output                         biu_icb_cmd_mmode,
  output                         biu_icb_cmd_dmode,
  output                         biu_icb_cmd_device,
  output                         biu_icb_cmd_x0base,
  output                         biu_icb_cmd_read,
  output [`N22_XLEN-1:0]        biu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      biu_icb_cmd_wmask,
  output                         biu_icb_cmd_lock,
  output                         biu_icb_cmd_excl,
  output [1:0]                   biu_icb_cmd_size,
  input                          biu_icb_rsp_valid,
  output                         biu_icb_rsp_ready,
  input                          biu_icb_rsp_err  ,
  input                          biu_icb_rsp_excl_ok  ,
  input  [`N22_XLEN-1:0]        biu_icb_rsp_rdata,


  input  clk,
  input  rst_n
  );

  `ifdef N22_MISALIGNED_AMO
  wire s0;
  wire s1;
  wire [`N22_XLEN-1:0] s2;
  wire [`N22_ITAG_WIDTH -1:0] s3;
  wire s4 ;
  wire s5;
  wire s6;
  wire [`N22_ADDR_SIZE -1:0] s7;
  wire [`N22_ADDR_SIZE -1:0] s8;
  wire s9;

  wire                         s10;
  wire                         s11;
  wire [`N22_XLEN-1:0]        s12;
  wire [`N22_ITAG_WIDTH -1:0] s13;
  wire                         s14 ;
  wire                         s15;
  wire                         s16;
  wire [`N22_ADDR_SIZE -1:0]  s17;
  wire [`N22_ADDR_SIZE -1:0]  s18;
  wire                         s19;
  wire                         s20;

  wire                       s21;
  wire                       s22;
  wire [`N22_ADDR_SIZE-1:0] s23;
  wire                       s24;
  wire [`N22_XLEN-1:0]      s25;
  wire [`N22_XLEN_MW-1:0]   s26;
  wire                       s27;
  wire                       s28;
  wire                       s29;
  wire [1:0]                 s30;
  wire [`N22_ITAG_WIDTH-1:0]s31;
  wire                       s32;
  wire                       s33;
  wire                       s34;
  wire                       s35;
  wire                       s36;
  `ifdef N22_LDST_EXCP_PRECISE
  wire                       s37;
  wire                       unalignamo_sta_pend_rv32;
  `endif

  wire                       s38;
  wire                       s39;
  wire                       s40  ;
  wire                       s41;
  wire [`N22_XLEN-1:0]      s42;

  `endif

  `ifdef N22_LDST_EXCP_PRECISE
  wire lsu_outs_valid;
  wire lsu_outs_rv32;
  `endif


  wire lsu_ctrl_active;




  `ifdef N22_MISALIGNED_AMO
  wire unalignamo_active;
  wire unalignamo_sta_not_idle;

  n22_lsu_unalgnamo u_n22_lsu_unalgnamo(

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

    .agu_icb_cmd_valid (agu_icb_cmd_valid ),
    .agu_icb_cmd_ready (agu_icb_cmd_ready ),
    .agu_icb_cmd_addr  (agu_icb_cmd_addr  ),
    .agu_icb_cmd_read  (agu_icb_cmd_read  ),
    .agu_icb_cmd_wdata (agu_icb_cmd_wdata ),
    .agu_icb_cmd_wmask (agu_icb_cmd_wmask ),
    .agu_icb_cmd_size  (agu_icb_cmd_size  ),
    .agu_icb_cmd_itag  (agu_icb_cmd_itag  ),
    .agu_icb_cmd_usign (agu_icb_cmd_usign ),
    .agu_icb_cmd_mmode (agu_icb_cmd_mmode ),
    .agu_icb_cmd_dmode (agu_icb_cmd_dmode ),
    .agu_icb_cmd_x0base(agu_icb_cmd_x0base),
    .agu_icb_cmd_sel   (agu_icb_cmd_sel   ),
  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32    (agu_icb_cmd_rv32),
  `endif

    .agu_unalgn        (agu_unalgn ),
    .agu_load          (agu_load   ),
    .agu_store         (agu_store  ),
  `ifdef N22_HAS_AMO
    .agu_amo           (agu_amo    ),
    .agu_excl          (agu_excl   ),
    .agu_amoswap       (agu_amoswap),
    .agu_amoadd        (agu_amoadd ),
    .agu_amoand        (agu_amoand ),
    .agu_amoor         (agu_amoor  ),
    .agu_amoxor        (agu_amoxor ),
    .agu_amomax        (agu_amomax ),
    .agu_amomin        (agu_amomin ),
    .agu_amomaxu       (agu_amomaxu),
    .agu_amominu       (agu_amominu),
    .agu_amo_rs2       (agu_amo_rs2),
  `endif

    .lock_clear_ena    (lock_clear_ena),

    .lsu_icb_cmd_valid   (s21   ),
    .lsu_icb_cmd_ready   (s22   ),
    .lsu_icb_cmd_addr    (s23    ),
    .lsu_icb_cmd_read    (s24    ),
    .lsu_icb_cmd_wdata   (s25   ),
    .lsu_icb_cmd_wmask   (s26   ),
    .lsu_icb_cmd_back2agu(s27),
    .lsu_icb_cmd_lock    (s28    ),
    .lsu_icb_cmd_excl    (s29    ),
    .lsu_icb_cmd_size    (s30    ),
    .lsu_icb_cmd_itag    (s31    ),
    .lsu_icb_cmd_usign   (s32   ),
    .lsu_icb_cmd_mmode   (s33   ),
    .lsu_icb_cmd_dmode   (s34   ),
    .lsu_icb_cmd_x0base  (s35  ),
    .lsu_icb_cmd_sel     (s36     ),
  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_icb_cmd_rv32    (s37    ),
    .unalignamo_sta_pend_rv32 (unalignamo_sta_pend_rv32),
  `endif

    .lsu_icb_rsp_valid   (s38   ),
    .lsu_icb_rsp_ready   (s39   ),
    .lsu_icb_rsp_err     (s40     ),
    .lsu_icb_rsp_excl_ok (s41 ),
    .lsu_icb_rsp_rdata   (s42   ),

    .wbck_o_valid        (s10      ),
    .wbck_o_ready        (s11      ),
    .wbck_o_wdat         (s12       ),
    .wbck_o_itag         (s13       ),
    .wbck_o_err          (s14        ),
    .wbck_o_cmt_buserr   (s15 ),
    .wbck_o_cmt_pmperr   (s16 ),
    .wbck_o_cmt_badaddr  (s17),
    .wbck_o_cmt_pc       (s18),
    .wbck_o_cmt_ld       (s19     ),
    .wbck_o_cmt_stamo    (s20     ),

    .unalignamo_active   (unalignamo_active),
    .unalignamo_sta_not_idle(unalignamo_sta_not_idle),

    .clk                 (clk),
    .rst_n               (rst_n)
  );
  `endif






    `ifdef N22_HAS_ILM
  wire [`N22_ADDR_SIZE-1:0] ilm_region_indic = N22_ILM_BASE_ADDR;
    `endif
    `ifdef N22_HAS_DLM
  wire [`N22_ADDR_SIZE-1:0] dlm_region_indic = N22_DLM_BASE_ADDR;
    `endif


  n22_lsu_ctrl  #(
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
  )u_n22_lsu_ctrl(
  `ifdef N22_LDST_EXCP_PRECISE
    .lsu_outs_valid         (lsu_outs_valid),
    .lsu_outs_rv32          (lsu_outs_rv32),
  `endif
    .csr_ilm_enable        (csr_ilm_enable),
    .csr_dlm_enable        (csr_dlm_enable),
    .lsu_ctrl_active       (lsu_ctrl_active),
  `ifdef N22_D_SHARE_ILM
    .ilm_region_indic     (ilm_region_indic),
  `endif
  `ifdef N22_HAS_DLM
    .dlm_region_indic     (dlm_region_indic),
  `endif

  `ifdef N22_MISALIGNED_AMO
    .lsu_o_valid           (s0 ),
    .lsu_o_ready           (s1 ),
    .lsu_o_wbck_wdat       (s2),
    .lsu_o_wbck_itag       (s3),
    .lsu_o_wbck_err        (s4  ),
    .lsu_o_cmt_buserr      (s9  ),
    .lsu_o_cmt_badaddr     (s7 ),
    .lsu_o_cmt_pc          (s8 ),
    .lsu_o_cmt_ld          (s5 ),
    .lsu_o_cmt_st          (s6 ),

    .agu_icb_cmd_sel       (s36 ),

    .agu_icb_cmd_valid     (s21 ),
    .agu_icb_cmd_ready     (s22 ),
    .agu_icb_cmd_addr      (s23 ),
    .agu_icb_cmd_x0base    (s35),
    .agu_icb_cmd_mmode     (s33),
    .agu_icb_cmd_dmode     (s34),
    .agu_icb_cmd_read      (s24   ),
    .agu_icb_cmd_wdata     (s25 ),
    .agu_icb_cmd_wmask     (s26 ),
    .agu_icb_cmd_lock      (s28),
    .agu_icb_cmd_excl      (s29),
    .agu_icb_cmd_size      (s30),
  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32        (s37),
  `endif

    .agu_icb_cmd_back2agu  (s27 ),
    .agu_icb_cmd_usign     (s32),
    .agu_icb_cmd_itag      (s31),

    .agu_icb_rsp_valid     (s38 ),
    .agu_icb_rsp_ready     (s39 ),
    .agu_icb_rsp_err       (s40   ),
    .agu_icb_rsp_excl_ok   (s41),
    .agu_icb_rsp_rdata     (s42),

  `endif

   `ifndef N22_MISALIGNED_AMO
    .lsu_o_valid           (lsu_o_valid ),
    .lsu_o_ready           (lsu_o_ready ),
    .lsu_o_wbck_wdat       (lsu_o_wbck_wdat),
    .lsu_o_wbck_itag       (lsu_o_wbck_itag),
    .lsu_o_wbck_err        (lsu_o_wbck_err  ),
    .lsu_o_cmt_buserr      (lsu_o_cmt_buserr  ),
    .lsu_o_cmt_badaddr     (lsu_o_cmt_badaddr ),
    .lsu_o_cmt_pc          (lsu_o_cmt_pc      ),
    .lsu_o_cmt_ld          (lsu_o_cmt_ld ),
    .lsu_o_cmt_st          (lsu_o_cmt_st ),

    .agu_icb_cmd_sel       (agu_icb_cmd_sel ),

    .agu_icb_cmd_valid     (agu_icb_cmd_valid ),
    .agu_icb_cmd_ready     (agu_icb_cmd_ready ),
    .agu_icb_cmd_addr      (agu_icb_cmd_addr ),
    .agu_icb_cmd_x0base    (agu_icb_cmd_x0base),
    .agu_icb_cmd_mmode     (agu_icb_cmd_mmode),
    .agu_icb_cmd_dmode     (agu_icb_cmd_dmode),
    .agu_icb_cmd_read      (agu_icb_cmd_read   ),
    .agu_icb_cmd_wdata     (agu_icb_cmd_wdata ),
    .agu_icb_cmd_wmask     (agu_icb_cmd_wmask ),
    .agu_icb_cmd_lock      (1'b0),
    .agu_icb_cmd_excl      (1'b0),
    .agu_icb_cmd_size      (agu_icb_cmd_size),
  `ifdef N22_LDST_EXCP_PRECISE
    .agu_icb_cmd_rv32        (agu_icb_cmd_rv32),
  `endif

    .agu_icb_cmd_back2agu  (1'b0 ),
    .agu_icb_cmd_usign     (agu_icb_cmd_usign),
    .agu_icb_cmd_itag      (agu_icb_cmd_itag),

    .agu_icb_rsp_valid     (),
    .agu_icb_rsp_ready     (1'b0 ),
    .agu_icb_rsp_err       (),
    .agu_icb_rsp_excl_ok   (),
    .agu_icb_rsp_rdata     (),

  `endif







    .biu_icb_cmd_sel       (biu_icb_cmd_sel  ),

    .biu_icb_cmd_valid     (biu_icb_cmd_valid),
    .biu_icb_cmd_ready     (biu_icb_cmd_ready),
    .biu_icb_cmd_addr      (biu_icb_cmd_addr ),
    .biu_icb_cmd_mmode     (biu_icb_cmd_mmode),
    .biu_icb_cmd_dmode     (biu_icb_cmd_dmode),
    .biu_icb_cmd_device    (biu_icb_cmd_device),
    .biu_icb_cmd_x0base    (biu_icb_cmd_x0base),
    .biu_icb_cmd_read      (biu_icb_cmd_read ),
    .biu_icb_cmd_wdata     (biu_icb_cmd_wdata),
    .biu_icb_cmd_wmask     (biu_icb_cmd_wmask),
    .biu_icb_cmd_lock      (biu_icb_cmd_lock),
    .biu_icb_cmd_excl      (biu_icb_cmd_excl),
    .biu_icb_cmd_size      (biu_icb_cmd_size),

    .biu_icb_rsp_valid     (biu_icb_rsp_valid),
    .biu_icb_rsp_ready     (biu_icb_rsp_ready),
    .biu_icb_rsp_err       (biu_icb_rsp_err  ),
    .biu_icb_rsp_excl_ok   (biu_icb_rsp_excl_ok  ),
    .biu_icb_rsp_rdata     (biu_icb_rsp_rdata),


  `ifdef N22_HAS_LBIU
    .lbiu_icb_cmd_valid     (lbiu_icb_cmd_valid),
    .lbiu_icb_cmd_ready     (lbiu_icb_cmd_ready),
    .lbiu_icb_cmd_addr      (lbiu_icb_cmd_addr ),
    .lbiu_icb_cmd_mmode     (lbiu_icb_cmd_mmode),
    .lbiu_icb_cmd_dmode     (lbiu_icb_cmd_dmode),
    .lbiu_icb_cmd_read      (lbiu_icb_cmd_read ),
    .lbiu_icb_cmd_wdata     (lbiu_icb_cmd_wdata),
    .lbiu_icb_cmd_wmask     (lbiu_icb_cmd_wmask),
    .lbiu_icb_cmd_lock      (lbiu_icb_cmd_lock),
    .lbiu_icb_cmd_excl      (lbiu_icb_cmd_excl),
    .lbiu_icb_cmd_size      (lbiu_icb_cmd_size),
    .lbiu_icb_cmd_ppi       (lbiu_icb_cmd_ppi),
    .lbiu_icb_cmd_tmr       (lbiu_icb_cmd_tmr),
    .lbiu_icb_cmd_clic       (lbiu_icb_cmd_clic),
    .lbiu_icb_cmd_fio       (lbiu_icb_cmd_fio),

    .lbiu_icb_rsp_valid     (lbiu_icb_rsp_valid),
    .lbiu_icb_rsp_ready     (lbiu_icb_rsp_ready),
    .lbiu_icb_rsp_err       (lbiu_icb_rsp_err  ),
    .lbiu_icb_rsp_excl_ok   (lbiu_icb_rsp_excl_ok  ),
    .lbiu_icb_rsp_rdata     (lbiu_icb_rsp_rdata  ),
  `endif

   `ifdef N22_D_SHARE_ILM
    .ilm_icb_cmd_sel      (ilm_icb_cmd_sel    ),

    .ilm_icb_cmd_valid    (ilm_icb_cmd_valid  ),
    .ilm_icb_cmd_ready    (ilm_icb_cmd_ready  ),
    .ilm_icb_cmd_addr     (ilm_icb_cmd_addr   ),
    .ilm_icb_cmd_mmode    (ilm_icb_cmd_mmode  ),
    .ilm_icb_cmd_dmode    (ilm_icb_cmd_dmode  ),
    .ilm_icb_cmd_read     (ilm_icb_cmd_read   ),
    .ilm_icb_cmd_wdata    (ilm_icb_cmd_wdata  ),
    .ilm_icb_cmd_wmask    (ilm_icb_cmd_wmask  ),
    .ilm_icb_cmd_lock     (ilm_icb_cmd_lock   ),
    .ilm_icb_cmd_excl     (ilm_icb_cmd_excl   ),
    .ilm_icb_cmd_size     (ilm_icb_cmd_size   ),

    .ilm_icb_rsp_valid    (ilm_icb_rsp_valid  ),
    .ilm_icb_rsp_ready    (ilm_icb_rsp_ready  ),
    .ilm_icb_rsp_err      (ilm_icb_rsp_err    ),
    .ilm_icb_rsp_excl_ok  (ilm_icb_rsp_excl_ok),
    .ilm_icb_rsp_rdata    (ilm_icb_rsp_rdata  ),
  `endif

  `ifdef N22_HAS_DLM
    .dlm_icb_cmd_sel      (dlm_icb_cmd_sel    ),

    .dlm_icb_cmd_valid    (dlm_icb_cmd_valid  ),
    .dlm_icb_cmd_ready    (dlm_icb_cmd_ready  ),
    .dlm_icb_cmd_addr     (dlm_icb_cmd_addr   ),
    .dlm_icb_cmd_mmode    (dlm_icb_cmd_mmode  ),
    .dlm_icb_cmd_dmode    (dlm_icb_cmd_dmode  ),
    .dlm_icb_cmd_read     (dlm_icb_cmd_read   ),
    .dlm_icb_cmd_wdata    (dlm_icb_cmd_wdata  ),
    .dlm_icb_cmd_wmask    (dlm_icb_cmd_wmask  ),
    .dlm_icb_cmd_lock     (dlm_icb_cmd_lock   ),
    .dlm_icb_cmd_excl     (dlm_icb_cmd_excl   ),
    .dlm_icb_cmd_size     (dlm_icb_cmd_size   ),

    .dlm_icb_rsp_valid    (dlm_icb_rsp_valid  ),
    .dlm_icb_rsp_ready    (dlm_icb_rsp_ready  ),
    .dlm_icb_rsp_err      (dlm_icb_rsp_err    ),
    .dlm_icb_rsp_excl_ok  (dlm_icb_rsp_excl_ok),
    .dlm_icb_rsp_rdata    (dlm_icb_rsp_rdata  ),
  `endif

    .clk                   (clk),
    .rst_n                 (rst_n)
  );

  `ifdef N22_MISALIGNED_AMO
`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off



//synopsys translate_on
`endif
`endif



  assign s11 = lsu_o_ready;
  assign s1          = lsu_o_ready;

  assign lsu_o_valid       = s10 | s0;
  assign lsu_o_wbck_wdat   = s10 ? s12        : s2;
  assign lsu_o_wbck_itag   = s10 ? s13        : s3;
  assign lsu_o_wbck_err    = s10 ? s14         : s4 ;
  assign lsu_o_cmt_ld      = s10 ? s19      : s5;
  assign lsu_o_cmt_st      = s10 ? s20   : s6;
  assign lsu_o_cmt_badaddr = s10 ? s17 : s7;
  assign lsu_o_cmt_pc      = s10 ? s18      : s8     ;
  assign lsu_o_cmt_buserr  = s10 ? s15  : s9;
  assign lsu_o_cmt_pmperr  = s10 ? s16  : 1'b0;

  `endif
  `ifndef N22_MISALIGNED_AMO
  assign lsu_o_cmt_pmperr  = 1'b0;
  assign lock_clear_ena = 1'b0;
  `endif

  assign lsu_active = lsu_ctrl_active
                    `ifdef N22_MISALIGNED_AMO
                      | unalignamo_active
                    `endif
                  ;

  `ifdef N22_LDST_EXCP_PRECISE
  assign lsu_pend_outs = lsu_outs_valid
                      `ifdef N22_MISALIGNED_AMO
                       | unalignamo_sta_not_idle
                      `endif
                      ;

  assign lsu_pend_rv32 =
                      `ifdef N22_MISALIGNED_AMO
                         unalignamo_sta_not_idle ? unalignamo_sta_pend_rv32 :
                      `endif
                         lsu_outs_rv32
                      ;
  `endif

endmodule

