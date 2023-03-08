
`include "global.inc"

module n22_exu_alu_lsuagu #(
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

  input csr_unalgn_enable,

  input agu_op,

   `ifdef N22_HAS_ECLIC
  input [31:0] csr_mxstatus ,
  input [31:0] csr_mcause ,
  input [`N22_PC_SIZE-1:0] csr_mepc ,
   `endif

   `ifdef N22_HAS_DEBUG
  input dbg_mprven,
   `endif
    `ifdef N22_HAS_TRIGM
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  input  [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
    `endif

  `ifdef N22_HAS_PMP
  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
  `endif

  input  mstatus_mprv,
  input  mpp_m_mode,

  input  agu_i_valid,
  output agu_i_ready,

  input  [`N22_XLEN-1:0] agu_i_rs1,
  input  [`N22_XLEN-1:0] agu_i_rs2,
  input  [`N22_XLEN-1:0] agu_i_imm,
  input  [`N22_DECINFO_AGU_WIDTH-1:0] agu_i_info,
  input  [`N22_ITAG_WIDTH-1:0] agu_i_itag,
  input  agu_i_mmode,
  input  agu_i_dmode,
  input  agu_i_x0base,
  `ifdef N22_LDST_EXCP_PRECISE
  input                      agu_i_rv32,
  `endif

  output agu_i_longpipe,



  output agu_o_valid,
  input  agu_o_ready,
  output agu_o_cmt_misalgn,
  output agu_o_cmt_ld,
  output agu_o_cmt_stamo,
  output agu_o_cmt_pmperr,
  output [`N22_ADDR_SIZE-1:0] agu_o_cmt_badaddr,
    `ifdef N22_HAS_TRIGM
  output agu_o_cmt_trigaddr_2dm,
  output agu_o_cmt_trigaddr_2excp,
    `endif


  output                       agu_icb_cmd_sel,
  output                       agu_icb_cmd_valid,
  input                        agu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0] agu_icb_cmd_addr,
  output                       agu_icb_cmd_read,
  output [`N22_XLEN-1:0]      agu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]   agu_icb_cmd_wmask,
  output [1:0]                 agu_icb_cmd_size,
  output [`N22_ITAG_WIDTH-1:0]agu_icb_cmd_itag,
  output                       agu_icb_cmd_usign,
  output                       agu_icb_cmd_mmode,
  output                       agu_icb_cmd_dmode,
  output                       agu_icb_cmd_x0base,
  `ifdef N22_LDST_EXCP_PRECISE
  output                       agu_icb_cmd_rv32,
  `endif


  `ifdef N22_MISALIGNED_AMO
  output  agu_unalgn  ,
  output  agu_load    ,
  output  agu_store   ,
  `ifdef N22_HAS_AMO
  output  agu_amo     ,
  output  agu_excl    ,
  output  agu_amoswap ,
  output  agu_amoadd  ,
  output  agu_amoand  ,
  output  agu_amoor   ,
  output  agu_amoxor  ,
  output  agu_amomax  ,
  output  agu_amomin  ,
  output  agu_amomaxu ,
  output  agu_amominu ,
  output  [`N22_XLEN-1:0]      agu_amo_rs2,
  `endif
  `endif


  output agu_req_alu_add,
  output [`N22_XLEN-1:0] agu_req_alu_op1,
  output [`N22_XLEN-1:0] agu_req_alu_op2,
  input  [`N22_XLEN-1:0] agu_req_alu_res,



  input  clk,
  input  rst_n
  );






  wire       agu_i_load    = agu_i_info [`N22_DECINFO_AGU_LOAD   ];
  wire       agu_i_store   = agu_i_info [`N22_DECINFO_AGU_STORE  ];
  wire       agu_i_amo     = agu_i_info [`N22_DECINFO_AGU_AMO    ];

  wire [1:0] agu_i_size    = agu_i_info [`N22_DECINFO_AGU_SIZE   ];
  wire       agu_i_usign   = agu_i_info [`N22_DECINFO_AGU_USIGN  ];
  wire       agu_i_excl    = agu_i_info [`N22_DECINFO_AGU_EXCL   ];
  wire       agu_i_amoswap = agu_i_info [`N22_DECINFO_AGU_AMOSWAP];
  wire       agu_i_amoadd  = agu_i_info [`N22_DECINFO_AGU_AMOADD ];
  wire       agu_i_amoand  = agu_i_info [`N22_DECINFO_AGU_AMOAND ];
  wire       agu_i_amoor   = agu_i_info [`N22_DECINFO_AGU_AMOOR  ];
  wire       agu_i_amoxor  = agu_i_info [`N22_DECINFO_AGU_AMOXOR ];
  wire       agu_i_amomax  = agu_i_info [`N22_DECINFO_AGU_AMOMAX ];
  wire       agu_i_amomin  = agu_i_info [`N22_DECINFO_AGU_AMOMIN ];
  wire       agu_i_amomaxu = agu_i_info [`N22_DECINFO_AGU_AMOMAXU];
  wire       agu_i_amominu = agu_i_info [`N22_DECINFO_AGU_AMOMINU];
                   `ifdef N22_HAS_ECLIC
  wire       agu_i_pushmxstatus = agu_i_info [`N22_DECINFO_AGU_PUSHMXSTATUS];
  wire       agu_i_pushmepc = agu_i_info [`N22_DECINFO_AGU_PUSHEPC];
  wire       agu_i_pushcause = agu_i_info [`N22_DECINFO_AGU_PUSHCAUSE];
                   `endif



  wire agu_i_size_b  = (agu_i_size == 2'b00);
  wire agu_i_size_hw = (agu_i_size == 2'b01);
  wire agu_i_size_w  = (agu_i_size == 2'b10);

  wire agu_i_addr_unalgn =
            (agu_i_size_hw &  agu_icb_cmd_addr[0])
          | (agu_i_size_w  &  (|agu_icb_cmd_addr[1:0]));


  wire agu_addr_unalgn = agu_i_addr_unalgn;

  `ifdef N22_HAS_TRIGM
  wire agu_o_cmt_trigaddr;
  `endif

  wire agu_i_ldst = (agu_i_load | agu_i_store);

  wire agu_i_algnldst = (~agu_addr_unalgn) & agu_i_ldst;

  wire agu_i_unalgnldst = agu_addr_unalgn & agu_i_ldst;

  wire agu_i_unalgnamo = (agu_addr_unalgn & agu_i_amo);

  wire agu_i_ofst0  = agu_i_amo | ((agu_i_load | agu_i_store) & agu_i_excl);







  wire [`N22_XLEN-1:0] agu_addr_gen_op2 = agu_i_ofst0 ? `N22_XLEN'b0 : agu_i_imm;

  assign agu_req_alu_add = 1'b1;
  assign agu_req_alu_op1 =
       `ifdef N22_HAS_DEBUG
            (agu_i_dmode & agu_i_x0base) ? N22_DEBUG_BASE_ADDR :
       `endif
                         agu_i_rs1;
  assign agu_req_alu_op2 = agu_addr_gen_op2 ;




  assign agu_i_ready =
      (agu_icb_cmd_ready & agu_o_ready) ;




  assign agu_o_valid =
         agu_i_valid
          & agu_icb_cmd_ready
          ;



  assign agu_o_cmt_badaddr = agu_icb_cmd_addr;

    `ifdef N22_HAS_TRIGM
  n22_trigm_addrpc_chck u_n22_trigm_addrpc_chck(

    .d_mode     (agu_i_dmode ),
    .m_mode     (agu_i_mmode ),
    .addrpc     (agu_icb_cmd_addr    ),
    .typ_load   (agu_i_load  ),
    .typ_store  (agu_i_store ),
    .typ_amo    (agu_i_amo   ),
    .typ_pc     (1'b0   ),
    .dbg_tdata2 (dbg_tdata2),
    .dbg_tdata1 (dbg_tdata1),

    .trigger_2dm  (agu_o_cmt_trigaddr_2dm),
    .trigger_2excp(agu_o_cmt_trigaddr_2excp)
  );

  assign agu_o_cmt_trigaddr = agu_o_cmt_trigaddr_2excp | agu_o_cmt_trigaddr_2dm;
    `endif


  wire agu_icb_cmd_pmp_err;
    `ifdef N22_HAS_PMP

  wire pmp_check_r = agu_i_amo | agu_i_load;
  wire pmp_check_w = agu_i_amo | agu_i_store;

  n22_pmp_check u_n22_pmpaddr_check (
   `ifdef N22_HAS_DEBUG
      .dbg_mprven    (dbg_mprven),
   `endif
      .pmpaddr_r     (pmpaddr_r   ),
      .pmpcfg_bit_r  (pmpcfg_bit_r),
      .pmpcfg_bit_w  (pmpcfg_bit_w),
      .pmpcfg_bit_x  (pmpcfg_bit_x),
      .pmpcfg_bit_a  (pmpcfg_bit_a),
      .pmpcfg_bit_l  (pmpcfg_bit_l),

      .mstatus_mprv  (mstatus_mprv ),
      .i_mpp_m_mode   (mpp_m_mode  ),

      .i_r    (pmp_check_r),
      .i_w    (pmp_check_w),
      .i_x    (1'b0),

      .i_mmode(agu_i_mmode),
      .i_dmode(agu_icb_cmd_dmode),
      .i_addr (agu_icb_cmd_addr),
      .o_err  (agu_icb_cmd_pmp_err)
  );
    `endif

    `ifndef N22_HAS_PMP
  assign agu_icb_cmd_pmp_err = 1'b0;
    `endif


  assign agu_o_cmt_misalgn = (1'b0
                       | agu_i_unalgnamo
                       | (agu_i_unalgnldst & agu_i_excl)
    `ifndef N22_MISALIGNED_ACCESS
                       | (agu_i_unalgnldst)
    `endif
    `ifdef N22_MISALIGNED_ACCESS
                       | (csr_unalgn_enable ? 1'b0 : agu_i_unalgnldst)
    `endif
                       )
                       ;

  assign agu_o_cmt_pmperr = agu_icb_cmd_pmp_err
  `ifdef N22_HAS_TRIGM
                           & (~agu_o_cmt_trigaddr)
  `endif
                           & (~agu_o_cmt_misalgn)
                           ;

  wire agu_o_cmt_err = 1'b0
  `ifdef N22_HAS_TRIGM
                     | agu_o_cmt_trigaddr
  `endif
                     | agu_o_cmt_misalgn
                     | agu_o_cmt_pmperr;

  assign agu_i_longpipe = ~agu_o_cmt_err;

  assign agu_o_cmt_ld      = agu_i_load;
  assign agu_o_cmt_stamo   = agu_i_store | agu_i_amo;









  assign agu_icb_cmd_sel   = agu_i_valid;

  assign agu_icb_cmd_valid =
            (
              (~agu_o_cmt_err) & agu_i_valid
              & agu_i_ready
            );

  assign agu_icb_cmd_addr = agu_req_alu_res[`N22_ADDR_SIZE-1:0];

  assign agu_icb_cmd_read = agu_i_load;


  wire [`N22_XLEN-1:0] algnst_wdata =
            ({`N22_XLEN{agu_i_size_b }} & {4{agu_i_rs2[ 7:0]}})
          | ({`N22_XLEN{agu_i_size_hw}} & {2{agu_i_rs2[15:0]}})
          | ({`N22_XLEN{agu_i_size_w }} & (
                   `ifdef N22_HAS_ECLIC
                                   agu_i_pushmxstatus ? csr_mxstatus :
                                   agu_i_pushcause ? csr_mcause :
                                   agu_i_pushmepc ?
                                      `ifdef N22_ADDR_SIZE_IS_32
                                              csr_mepc
                                      `endif
                                      `ifdef N22_ADDR_SIZE_IS_24
                                              {{32-`N22_ADDR_SIZE{1'b0}},csr_mepc}
                                      `endif
                                              :
                   `endif
                                   agu_i_rs2));

  wire [`N22_XLEN_MW-1:0] algnst_wmask =
            ({`N22_XLEN_MW{agu_i_size_b }} & (4'b0001 << agu_icb_cmd_addr[1:0]))
          | ({`N22_XLEN_MW{agu_i_size_hw}} & (4'b0011 << {agu_icb_cmd_addr[1],1'b0}))
          | ({`N22_XLEN_MW{agu_i_size_w }} & (4'b1111));



  assign agu_icb_cmd_wdata = algnst_wdata;
  assign agu_icb_cmd_wmask = algnst_wmask;


  assign agu_icb_cmd_itag     = agu_i_itag;
  assign agu_icb_cmd_usign    = agu_i_usign;
  assign agu_icb_cmd_size     = agu_i_size;
  assign agu_icb_cmd_dmode     = agu_i_dmode;
  assign agu_icb_cmd_x0base    = agu_i_x0base;

  wire mprv_real =
   `ifdef N22_HAS_DEBUG
                (agu_i_dmode ? dbg_mprven : 1'b1) &
   `endif
                 mstatus_mprv;

  wire mmode_hack = (mprv_real) ? mpp_m_mode : (agu_i_mmode | agu_i_dmode);
  assign agu_icb_cmd_mmode     = mmode_hack;

    `ifdef N22_MISALIGNED_AMO
  assign  agu_unalgn  = agu_addr_unalgn;
  assign  agu_load    = agu_i_load    ;
  assign  agu_store   = agu_i_store   ;
  `ifdef N22_HAS_AMO
  assign  agu_amo     = agu_i_amo     ;
  assign  agu_excl    = agu_i_excl    ;
  assign  agu_amoswap = agu_i_amoswap ;
  assign  agu_amoadd  = agu_i_amoadd  ;
  assign  agu_amoand  = agu_i_amoand  ;
  assign  agu_amoor   = agu_i_amoor   ;
  assign  agu_amoxor  = agu_i_amoxor  ;
  assign  agu_amomax  = agu_i_amomax  ;
  assign  agu_amomin  = agu_i_amomin  ;
  assign  agu_amomaxu = agu_i_amomaxu ;
  assign  agu_amominu = agu_i_amominu ;
  assign  agu_amo_rs2 = agu_i_rs2;
  `endif
  `endif

  `ifdef N22_LDST_EXCP_PRECISE
  assign agu_icb_cmd_rv32 = agu_i_rv32;
  `endif

endmodule



