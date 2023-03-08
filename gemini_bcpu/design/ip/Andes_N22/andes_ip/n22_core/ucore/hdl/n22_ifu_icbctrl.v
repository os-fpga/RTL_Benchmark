
`include "global.inc"

module n22_ifu_icbctrl #(
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
  input  csr_ilm_enable,
  input  csr_icache_enable,
  output pft_no_outs,

  `ifdef N22_HAS_PMP
  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
  `endif

  input  ifu_icb_cmd_valid,
  output ifu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   ifu_icb_cmd_addr,
  input  ifu_icb_cmd_dmode,
  input  ifu_icb_cmd_vmode,
  input  ifu_icb_cmd_mmode,
  input  ifu_icb_cmd_seq,

  output ifu_icb_rsp_valid,
  output ifu_icb_rsp_err,
  output ifu_icb_rsp_pmperr,
  output [`N22_SYSMEM_DATA_WIDTH-1:0] ifu_icb_rsp_rdata,


  `ifdef N22_HAS_ILM

  output ifu2ilm_icb_cmd_valid,
  input  ifu2ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ifu2ilm_icb_cmd_addr,
  output ifu2ilm_icb_cmd_dmode,
  output ifu2ilm_icb_cmd_vmode,
  output ifu2ilm_icb_cmd_mmode,

  input  ifu2ilm_icb_rsp_valid,
  input  ifu2ilm_icb_rsp_err,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu2ilm_icb_rsp_rdata,

  `endif


  `ifdef N22_HAS_ICACHE

  output ifu2icache_icb_cmd_valid,
  input  ifu2icache_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0] ifu2icache_icb_cmd_addr,
  output ifu2icache_icb_cmd_dmode,
  output ifu2icache_icb_cmd_vmode,
  output ifu2icache_icb_cmd_mmode,
  output ifu2icache_icb_cmd_err,

  input  ifu2icache_icb_rsp_valid,
  input  ifu2icache_icb_rsp_err,
  input  [`N22_ICACHE_DATA_WIDTH-1:0] ifu2icache_icb_rsp_rdata,

  `endif


  output ifu2biu_icb_cmd_valid,
  input  ifu2biu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   ifu2biu_icb_cmd_addr,
  output ifu2biu_icb_cmd_dmode,
  output ifu2biu_icb_cmd_device,
  output ifu2biu_icb_cmd_vmode,
  output ifu2biu_icb_cmd_mmode,
  output ifu2biu_icb_cmd_err,
  output ifu2biu_icb_cmd_seq,

  input  ifu2biu_icb_rsp_valid,
  input  ifu2biu_icb_rsp_err,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu2biu_icb_rsp_rdata,




  output pft_active,

  input  clk_ifu,
  input  clk_pft,
  input  rst_n
  );

  wire s0;
  wire s1;
  wire [`N22_ADDR_SIZE-1:0]   s2;
  wire s3;
  wire s4;
  wire s5;
  wire s6;

  wire s7;
  wire s8;
  wire s9;
  wire [`N22_SYSMEM_DATA_WIDTH-1:0] s10;

  `ifdef N22_HAS_PREFETCH
  n22_ifu_pft #(
      .AW(`N22_ADDR_SIZE),
      .DW(`N22_SYSMEM_DATA_WIDTH)
  )u_n22_ifu_pft(
    .pft_no_outs  (pft_no_outs),

    .ifu_icb_cmd_valid(ifu_icb_cmd_valid),
    .ifu_icb_cmd_ready(ifu_icb_cmd_ready),
    .ifu_icb_cmd_addr (ifu_icb_cmd_addr ),
    .ifu_icb_cmd_dmode(ifu_icb_cmd_dmode),
    .ifu_icb_cmd_mmode(ifu_icb_cmd_mmode),
    .ifu_icb_cmd_vmode(ifu_icb_cmd_vmode),
    .ifu_icb_cmd_seq  (ifu_icb_cmd_seq  ),

    .ifu_icb_rsp_valid (ifu_icb_rsp_valid),
    .ifu_icb_rsp_err   (ifu_icb_rsp_err  ),
    .ifu_icb_rsp_pmperr(ifu_icb_rsp_pmperr),
    .ifu_icb_rsp_rdata (ifu_icb_rsp_rdata),

    .pft_icb_cmd_valid(s0),
    .pft_icb_cmd_ready(s1),
    .pft_icb_cmd_addr (s2 ),
    .pft_icb_cmd_dmode(s3),
    .pft_icb_cmd_vmode(s4),
    .pft_icb_cmd_mmode(s5),
    .pft_icb_cmd_seq  (s6),

    .pft_icb_rsp_valid (s7),
    .pft_icb_rsp_err   (s8  ),
    .pft_icb_rsp_pmperr(s9),
    .pft_icb_rsp_rdata (s10),

    .pft_active    (pft_active),
    .clk           (clk_pft),
    .rst_n         (rst_n  )
  );
  `endif

  `ifndef N22_HAS_PREFETCH
    assign pft_no_outs = 1'b1;
    assign pft_active = 1'b0;

    assign s0 = ifu_icb_cmd_valid;
    assign s2  = ifu_icb_cmd_addr ;
    assign s3 = ifu_icb_cmd_dmode;
    assign s4 = ifu_icb_cmd_vmode;
    assign s5 = ifu_icb_cmd_mmode;
    assign s6   = ifu_icb_cmd_seq;

    assign ifu_icb_cmd_ready  = s1;
    assign ifu_icb_rsp_valid  = s7;
    assign ifu_icb_rsp_err    = s8;
    assign ifu_icb_rsp_pmperr = s9;
    assign ifu_icb_rsp_rdata  = s10;


  `endif


  wire s11 = s0 & s1;



  wire s12;



   `ifdef N22_HAS_PMP
  wire s13 = ~s4;
  wire s14 = s4;
  wire s15 = 1'b0;

  n22_pmp_check u_n22_ifu_icb_check (
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),

   `ifdef N22_HAS_DEBUG
      .dbg_mprven    (1'b0),
   `endif
      .mstatus_mprv  (1'b0 ),
      .i_mpp_m_mode  (1'b0 ),

      .i_r    (s14),
      .i_w    (s15),
      .i_x    (s13),

      .i_mmode(s5),
      .i_dmode(s3),
      .i_addr (s2),
      .o_err  (s12 )
  );
    `endif

    `ifndef N22_HAS_PMP
  assign s12 = 1'b0;
    `endif

  wire s16;

  n22_device_range_chk  #(
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
  ) u_n22_device_range_chk(
     .i_addr   (s2),
     .o_device (s16)
  );

  wire s17 = s12;

`ifdef N22_HAS_DEBUG_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] s18 = N22_DEBUG_BASE_ADDR;
  wire s19 = s3 & (s2[`N22_DEBUG_BASE_REGION] == s18[`N22_DEBUG_BASE_REGION]);
`endif

`ifndef N22_HAS_DEBUG_PRIVATE
  wire s19 = 1'b0;
`endif


  wire s20 = s19;


  `ifdef N22_HAS_ILM
  wire [`N22_ADDR_SIZE-1:0] s21 = N22_ILM_BASE_ADDR;
  wire s22 = csr_ilm_enable
                    & (s2[`N22_ILM_BASE_REGION] == s21[`N22_ILM_BASE_REGION])
                       & (~s20);
  `endif

  `ifdef N22_HAS_ICACHE
  wire s23 = (~s3)
                         & csr_icache_enable
                         & (~s20)
                       `ifdef N22_HAS_ILM
                         & (~s22)
                       `endif
                         & (~s16)
                         ;
  `endif

  wire s24 =  (1'b1
                        `ifdef N22_HAS_ICACHE
                         & (~s23)
                        `endif
                        `ifdef N22_HAS_ILM
                          & (~s22)
                        `endif
                       ) | s20   ;



  `ifdef N22_HAS_ILM
  wire s25;
  n22_gnrl_dfflr #(1) icb2ilm_dfflr(s11, s22, s25, clk_ifu, rst_n);
  `endif
  `ifdef N22_HAS_ICACHE
  wire s26;
  n22_gnrl_dfflr #(1) icb2icache_dfflr(s11, s23, s26, clk_ifu, rst_n);
  `endif

  wire s27;
  n22_gnrl_dfflr #(1) icb2mem_dfflr (s11, s24 , s27,  clk_ifu, rst_n);


  wire s28;
  n22_gnrl_dfflr #(1) icb_pmperr_dfflr(s11, s12, s28, clk_ifu, rst_n);



  `ifdef N22_HAS_ILM
  assign ifu2ilm_icb_cmd_valid = s0 & s22;
  assign ifu2ilm_icb_cmd_addr = s2[`N22_ILM_ADDR_WIDTH-1:0];
  assign ifu2ilm_icb_cmd_mmode = s5;
  assign ifu2ilm_icb_cmd_dmode = s3;
  assign ifu2ilm_icb_cmd_vmode = s4;
  `endif


  `ifdef N22_HAS_ICACHE
  assign ifu2icache_icb_cmd_valid = s0 & s23;
  assign ifu2icache_icb_cmd_addr = s2[`N22_ADDR_SIZE-1:0];
  assign ifu2icache_icb_cmd_mmode = s5;
  assign ifu2icache_icb_cmd_dmode = s3;
  assign ifu2icache_icb_cmd_vmode = s4;
  assign ifu2icache_icb_cmd_err = s17;
  `endif


  assign ifu2biu_icb_cmd_valid = s0 & s24;
  assign ifu2biu_icb_cmd_addr  = s2[`N22_ADDR_SIZE-1:0];
  assign ifu2biu_icb_cmd_mmode = s5;
  assign ifu2biu_icb_cmd_dmode = s3;
  assign ifu2biu_icb_cmd_device = s16;
  assign ifu2biu_icb_cmd_vmode = s4;
  assign ifu2biu_icb_cmd_err   = s17;
  assign ifu2biu_icb_cmd_seq   = s6 & s27;


  assign s1 = 1'b0
    `ifdef N22_HAS_ILM
        | (s22 & ifu2ilm_icb_cmd_ready)
    `endif
    `ifdef N22_HAS_ICACHE
        | (s23 & ifu2icache_icb_cmd_ready)
    `endif

        | (s24  & ifu2biu_icb_cmd_ready)

        ;



  assign s7 = 1'b0
                     `ifdef N22_HAS_ILM
                       | (s25 & ifu2ilm_icb_rsp_valid)
                     `endif
                     `ifdef N22_HAS_ICACHE
                       | (s26 & ifu2icache_icb_rsp_valid)
                     `endif

                       | (s27  & ifu2biu_icb_rsp_valid)

                        ;

`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off


//synopsys translate_on
`endif
`endif


  assign s10= 32'b0
                     `ifdef N22_HAS_ILM
                       | ({32{s25}} & ifu2ilm_icb_rsp_rdata)
                     `endif
                     `ifdef N22_HAS_ICACHE
                       | ({32{s26}} & ifu2icache_icb_rsp_rdata)
                     `endif

                       | ({32{s27}}  & ifu2biu_icb_rsp_rdata)

`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
`endif
`endif
                        ;




  assign s8 = (1'b0
                     `ifdef N22_HAS_ILM
                       | (s25 & ifu2ilm_icb_rsp_err)
                     `endif
                     `ifdef N22_HAS_ICACHE
                       | (s26 & ifu2icache_icb_rsp_err)
                     `endif

                       | (s27  & ifu2biu_icb_rsp_err)

                       )
                       | s9
                       ;

  assign s9 = s28;


endmodule




