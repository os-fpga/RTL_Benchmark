
`include "global.inc"

  `ifdef N22_MISALIGNED_AMO
module n22_lsu_unalgnamo(
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

  input                        agu_icb_cmd_valid,
  output                       agu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0] agu_icb_cmd_addr,
  input                        agu_icb_cmd_read,
  input  [`N22_XLEN-1:0]      agu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]   agu_icb_cmd_wmask,
  input  [1:0]                 agu_icb_cmd_size,
  input  [`N22_ITAG_WIDTH-1:0]agu_icb_cmd_itag,
  input                        agu_icb_cmd_usign,
  input                        agu_icb_cmd_mmode,
  input                        agu_icb_cmd_dmode,
  input                        agu_icb_cmd_x0base,
  input                        agu_icb_cmd_sel,
  `ifdef N22_LDST_EXCP_PRECISE
  input                        agu_icb_cmd_rv32,
  `endif

  input      agu_unalgn  ,
  input      agu_load    ,
  input      agu_store   ,

  `ifdef N22_HAS_AMO
  input      agu_amo     ,
  input      agu_excl    ,
  input      agu_amoswap ,
  input      agu_amoadd  ,
  input      agu_amoand  ,
  input      agu_amoor   ,
  input      agu_amoxor  ,
  input      agu_amomax  ,
  input      agu_amomin  ,
  input      agu_amomaxu ,
  input      agu_amominu ,
  input  [`N22_XLEN-1:0]      agu_amo_rs2,
  `endif

  output     lock_clear_ena ,


  output                       lsu_icb_cmd_valid,
  input                        lsu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0] lsu_icb_cmd_addr,
  output                       lsu_icb_cmd_read,
  output [`N22_XLEN-1:0]      lsu_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]   lsu_icb_cmd_wmask,
  output                       lsu_icb_cmd_back2agu,
  output                       lsu_icb_cmd_lock,
  output                       lsu_icb_cmd_excl,
  output [1:0]                 lsu_icb_cmd_size,
  output [`N22_ITAG_WIDTH-1:0]lsu_icb_cmd_itag,
  output                       lsu_icb_cmd_usign,
  output                       lsu_icb_cmd_mmode,
  output                       lsu_icb_cmd_dmode,
  output                       lsu_icb_cmd_x0base,
  output                       lsu_icb_cmd_sel,
  `ifdef N22_LDST_EXCP_PRECISE
  output                       lsu_icb_cmd_rv32,
  `endif

  input                        lsu_icb_rsp_valid,
  output                       lsu_icb_rsp_ready,
  input                        lsu_icb_rsp_err  ,
  input                        lsu_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]      lsu_icb_rsp_rdata,

  output                         wbck_o_valid,
  input                          wbck_o_ready,
  output [`N22_XLEN-1:0]        wbck_o_wdat,
  output [`N22_ITAG_WIDTH -1:0] wbck_o_itag,
  output                         wbck_o_err ,
  output                         wbck_o_cmt_buserr,
  output                         wbck_o_cmt_pmperr,
  output [`N22_ADDR_SIZE -1:0]  wbck_o_cmt_badaddr,
  output [`N22_PC_SIZE   -1:0]  wbck_o_cmt_pc,
  output                         wbck_o_cmt_ld,
  output                         wbck_o_cmt_stamo,

  output unalignamo_active,
  output unalignamo_sta_not_idle,
  `ifdef N22_LDST_EXCP_PRECISE
  output unalignamo_sta_pend_rv32,
  `endif

  input  clk,
  input  rst_n
  );



  wire state_idle_exit_ena;

  wire sdb_ena = state_idle_exit_ena;


  wire sdb_load   ;
  wire sdb_store  ;
  wire sdb_unalgn ;
  `ifdef N22_HAS_AMO
  wire sdb_amo    ;
  wire sdb_excl   ;
  wire sdb_amoswap;
  wire sdb_amoadd ;
  wire sdb_amoand ;
  wire sdb_amoor  ;
  wire sdb_amoxor ;
  wire sdb_amomax ;
  wire sdb_amomin ;
  wire sdb_amomaxu;
  wire sdb_amominu;
  wire [`N22_XLEN-1:0]      sdb_rs2;
  `endif
  wire [`N22_XLEN-1:0]      sdb_pc;
  `ifdef N22_LDST_EXCP_PRECISE
  wire                       sdb_rv32;
  `endif

  wire  [1:0]                 sdb_icb_cmd_size  ;
  wire  [`N22_ITAG_WIDTH-1:0]sdb_icb_cmd_itag  ;
  wire                        sdb_icb_cmd_usign ;
  wire                        sdb_icb_cmd_mmode ;
  wire                        sdb_icb_cmd_dmode ;
  wire                        sdb_icb_cmd_x0base;

  `ifdef N22_HAS_PMP
  wire sdb_mpp_m_mode;
  `endif

  n22_gnrl_dfflr #(1) sdb_load_dfflr    (sdb_ena, agu_load   , sdb_load   , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_store_dfflr   (sdb_ena, agu_store  , sdb_store  , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_unalgn_dfflr  (sdb_ena, agu_unalgn , sdb_unalgn , clk, rst_n);
  `ifdef N22_HAS_AMO
  n22_gnrl_dfflr #(1) sdb_amo_dfflr     (sdb_ena, agu_amo    , sdb_amo    , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_excl_dfflr    (sdb_ena, agu_excl   , sdb_excl   , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amoswap_dfflr (sdb_ena, agu_amoswap, sdb_amoswap, clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amoadd_dfflr  (sdb_ena, agu_amoadd , sdb_amoadd , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amoand_dfflr  (sdb_ena, agu_amoand , sdb_amoand , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amoor_dfflr   (sdb_ena, agu_amoor  , sdb_amoor  , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amoxor_dfflr  (sdb_ena, agu_amoxor , sdb_amoxor , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amomax_dfflr  (sdb_ena, agu_amomax , sdb_amomax , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amomin_dfflr  (sdb_ena, agu_amomin , sdb_amomin , clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amomaxu_dfflr (sdb_ena, agu_amomaxu, sdb_amomaxu, clk, rst_n);
  n22_gnrl_dfflr #(1) sdb_amominu_dfflr (sdb_ena, agu_amominu, sdb_amominu, clk, rst_n);
  n22_gnrl_dfflr #(`N22_XLEN) sdb_rs2_dfflr (sdb_ena, agu_amo_rs2, sdb_rs2, clk, rst_n);
  `endif
  `ifdef N22_LDST_EXCP_PRECISE
  assign sdb_pc = `N22_PC_SIZE'b0;
  n22_gnrl_dfflr #(1) sdb_rv32_dfflr (sdb_ena, agu_icb_cmd_rv32, sdb_rv32, clk, rst_n);
  `else
  assign sdb_pc = `N22_PC_SIZE'b0;
  `endif

  n22_gnrl_dfflr #(2)                sdb_icb_cmd_size_dfflr   (sdb_ena, agu_icb_cmd_size  , sdb_icb_cmd_size  , clk, rst_n);
  n22_gnrl_dfflr #(`N22_ITAG_WIDTH) sdb_icb_cmd_itag_dfflr   (sdb_ena, agu_icb_cmd_itag  , sdb_icb_cmd_itag  , clk, rst_n);
  n22_gnrl_dfflr #(1)                sdb_icb_cmd_usign_dfflr  (sdb_ena, agu_icb_cmd_usign , sdb_icb_cmd_usign , clk, rst_n);
  n22_gnrl_dfflr #(1)                sdb_icb_cmd_mmode_dfflr  (sdb_ena, agu_icb_cmd_mmode , sdb_icb_cmd_mmode , clk, rst_n);
  n22_gnrl_dfflr #(1)                sdb_icb_cmd_dmode_dfflr  (sdb_ena, agu_icb_cmd_dmode , sdb_icb_cmd_dmode , clk, rst_n);
  n22_gnrl_dfflr #(1)                sdb_icb_cmd_x0base_dfflr (sdb_ena, agu_icb_cmd_x0base, sdb_icb_cmd_x0base, clk, rst_n);

  `ifdef N22_HAS_PMP
  n22_gnrl_dfflr #(1) sdb_mpp_m_mode_dfflr (sdb_ena, mpp_m_mode, sdb_mpp_m_mode, clk, rst_n);
  `endif

  wire sdb_size_b  = (sdb_icb_cmd_size == 2'b00);
  wire sdb_size_h  = (sdb_icb_cmd_size == 2'b01);
  wire sdb_size_w  = (sdb_icb_cmd_size == 2'b10);

  wire agu_unalgnld = (agu_unalgn & agu_load) ;
  wire agu_unalgnst = (agu_unalgn & agu_store) ;
  wire agu_unalgnldst = (agu_unalgnld | agu_unalgnst);

  wire sdb_unalgnld = (sdb_unalgn & sdb_load) ;
  wire sdb_unalgnst = (sdb_unalgn & sdb_store) ;
  wire sdb_unalgnldst = (sdb_unalgnld | sdb_unalgnst);

  wire icb_sta_is_idle;

  wire [`N22_XLEN-1:0] agu_req_alu_op1;
  wire [`N22_XLEN-1:0] agu_req_alu_op2;
  wire agu_req_alu_swap;
  wire agu_req_alu_add ;
  wire agu_req_alu_and ;
  wire agu_req_alu_or  ;
  wire agu_req_alu_xor ;
  wire agu_req_alu_max ;
  wire agu_req_alu_min ;
  wire agu_req_alu_maxu;
  wire agu_req_alu_minu;
  wire [`N22_XLEN-1:0] agu_req_alu_res;

  wire agu_sbf_0_ena;
  wire [`N22_XLEN-1:0] agu_sbf_0_nxt;
  wire [`N22_XLEN-1:0] agu_sbf_0_r;

  wire agu_sbf_1_ena;
  wire [`N22_XLEN-1:0] agu_sbf_1_nxt;
  wire [`N22_XLEN-1:0] agu_sbf_1_r;


  localparam ICB_STATE_WIDTH = 4;

  wire icb_state_ena;
  wire [ICB_STATE_WIDTH-1:0] icb_state_nxt;
  wire [ICB_STATE_WIDTH-1:0] icb_state_r;

  localparam ICB_STATE_IDLE = 4'd0;
  localparam ICB_STATE_1ST  = 4'd1;
  localparam ICB_STATE_2ND  = 4'd2;
  localparam ICB_STATE_WBCK  = 4'd3;
  localparam ICB_STATE_WAIT2ND  = 4'd4;
  `ifdef N22_MISALIGNED_ACCESS
  localparam ICB_STATE_WAIT3RD  = 4'd5;
  localparam ICB_STATE_3RD  = 4'd6;
  localparam ICB_STATE_WAIT4TH  = 4'd7;
  localparam ICB_STATE_4TH  = 4'd8;
  `endif




  wire [ICB_STATE_WIDTH-1:0] state_idle_nxt   ;
  wire [ICB_STATE_WIDTH-1:0] state_1st_nxt    ;
  wire [ICB_STATE_WIDTH-1:0] state_wait2nd_nxt;
  wire [ICB_STATE_WIDTH-1:0] state_2nd_nxt    ;
  wire [ICB_STATE_WIDTH-1:0] state_wbck_nxt ;
  `ifdef N22_MISALIGNED_ACCESS
  wire [ICB_STATE_WIDTH-1:0] state_wait3rd_nxt;
  wire [ICB_STATE_WIDTH-1:0] state_3rd_nxt    ;
  wire [ICB_STATE_WIDTH-1:0] state_wait4th_nxt;
  wire [ICB_STATE_WIDTH-1:0] state_4th_nxt    ;
  `endif

  wire state_1st_exit_ena      ;
  wire state_wait2nd_exit_ena  ;
  wire state_2nd_exit_ena      ;
  wire state_wbck_exit_ena   ;
  `ifdef N22_MISALIGNED_ACCESS
  wire state_wait3rd_exit_ena  ;
  wire state_3rd_exit_ena      ;
  wire state_wait4th_exit_ena  ;
  wire state_4th_exit_ena      ;
  `endif

  assign icb_sta_is_idle    = (icb_state_r == ICB_STATE_IDLE   );
  wire   icb_sta_is_1st     = (icb_state_r == ICB_STATE_1ST    );
  `ifdef N22_HAS_AMO
  wire   icb_sta_is_amoalu  = (icb_state_r == ICB_STATE_WAIT2ND ) & sdb_amo;
  `endif
  wire   icb_sta_is_wait2nd = (icb_state_r == ICB_STATE_WAIT2ND);
  wire   icb_sta_is_2nd     = (icb_state_r == ICB_STATE_2ND    );
  wire   icb_sta_is_wbck    = (icb_state_r == ICB_STATE_WBCK    );
  `ifdef N22_MISALIGNED_ACCESS
  wire   icb_sta_is_wait3rd = (icb_state_r == ICB_STATE_WAIT3RD);
  wire   icb_sta_is_3rd     = (icb_state_r == ICB_STATE_3RD    );
  wire   icb_sta_is_wait4th = (icb_state_r == ICB_STATE_WAIT4TH);
  wire   icb_sta_is_4th     = (icb_state_r == ICB_STATE_4TH    );
  `endif


  wire lsu_icb_cmd_hsked = lsu_icb_cmd_valid & lsu_icb_cmd_ready;
  wire lsu_icb_rsp_hsked = lsu_icb_rsp_valid & lsu_icb_rsp_ready;
  `ifdef N22_HAS_AMO
  wire agu_icb_cmd_hsked = agu_icb_cmd_valid & agu_icb_cmd_ready;
  wire [`N22_XLEN-1:0] excl_addr_r;
  wire excl_flag_r;
  wire excl_addr_hit = (excl_addr_r == agu_icb_cmd_addr) & excl_flag_r;
  wire excl_st_hit = excl_addr_hit & excl_flag_r & agu_store & agu_excl;
  wire excl_st_nohit = ((~excl_addr_hit) | (~excl_flag_r)) & agu_store & agu_excl;
  `endif


  wire state_idle_to_exit =    ( 1'b0
                               `ifdef N22_HAS_AMO
                                 | agu_amo
                                 | agu_excl
                               `endif
                               `ifdef N22_MISALIGNED_ACCESS
                                 | agu_unalgnldst
                               `endif
                                 );
  assign state_idle_exit_ena = icb_sta_is_idle & state_idle_to_exit
                               & (lsu_icb_cmd_hsked
                               `ifdef N22_HAS_AMO
                                  | (excl_st_nohit & agu_icb_cmd_hsked)
                               `endif
                               );
  assign state_idle_nxt      =
                               `ifdef N22_HAS_AMO
                               agu_excl ? ((excl_st_hit | agu_load) ? ICB_STATE_2ND : ICB_STATE_WBCK) :
                			   `endif
                               ICB_STATE_1ST;

  assign state_1st_exit_ena = icb_sta_is_1st & lsu_icb_rsp_hsked;
  assign state_1st_nxt      =
                (
                `ifdef N22_MISALIGNED_ACCESS
                  sdb_unalgnldst ?  (lsu_icb_rsp_err ? ICB_STATE_WBCK : ICB_STATE_WAIT2ND) :
                `endif
                `ifdef N22_HAS_AMO
                  (sdb_amo) ? (lsu_icb_rsp_err ? ICB_STATE_WBCK : ICB_STATE_WAIT2ND) :
                `endif
                  ICB_STATE_1ST
                );

  wire  sdb_unalgnldst_pmperr;
  assign state_wait2nd_exit_ena = icb_sta_is_wait2nd & (lsu_icb_cmd_ready | sdb_unalgnldst_pmperr);
  assign state_wait2nd_nxt      = sdb_unalgnldst_pmperr ? ICB_STATE_WBCK : ICB_STATE_2ND;

  assign state_2nd_exit_ena = icb_sta_is_2nd & lsu_icb_rsp_hsked;
  assign state_2nd_nxt      =
                (
                `ifdef N22_MISALIGNED_ACCESS
                  (sdb_unalgnldst & sdb_size_w) ?  (lsu_icb_rsp_err ? ICB_STATE_WBCK : ICB_STATE_WAIT3RD) :
                `endif
                  ICB_STATE_WBCK
                );

  `ifdef N22_MISALIGNED_ACCESS
  assign state_wait3rd_exit_ena = icb_sta_is_wait3rd & (lsu_icb_cmd_ready | sdb_unalgnldst_pmperr);
  assign state_wait3rd_nxt      = sdb_unalgnldst_pmperr ? ICB_STATE_WBCK : ICB_STATE_3RD;

  assign state_3rd_exit_ena = icb_sta_is_3rd & lsu_icb_rsp_hsked;
  assign state_3rd_nxt      =
                (
                  (lsu_icb_rsp_err ? ICB_STATE_WBCK : ICB_STATE_WAIT4TH)
                );

  assign state_wait4th_exit_ena = icb_sta_is_wait4th & (lsu_icb_cmd_ready | sdb_unalgnldst_pmperr);
  assign state_wait4th_nxt      = sdb_unalgnldst_pmperr ? ICB_STATE_WBCK : ICB_STATE_4TH;

  assign state_4th_exit_ena = icb_sta_is_4th & lsu_icb_rsp_hsked;
  assign state_4th_nxt      =
                (
                ICB_STATE_WBCK
                );
  `endif

  assign state_wbck_exit_ena = icb_sta_is_wbck & wbck_o_ready;
  assign state_wbck_nxt      = ICB_STATE_IDLE;





  assign icb_state_ena = 1'b0
            | state_idle_exit_ena
            | state_1st_exit_ena
            | state_wait2nd_exit_ena
            | state_2nd_exit_ena
            | state_wbck_exit_ena
         `ifdef N22_MISALIGNED_ACCESS
            | state_wait3rd_exit_ena
            | state_3rd_exit_ena
            | state_wait4th_exit_ena
            | state_4th_exit_ena
          `endif
          ;

  assign icb_state_nxt =
              ({ICB_STATE_WIDTH{1'b0}})
            | ({ICB_STATE_WIDTH{state_idle_exit_ena   }} & state_idle_nxt   )
            | ({ICB_STATE_WIDTH{state_1st_exit_ena    }} & state_1st_nxt    )
            | ({ICB_STATE_WIDTH{state_wait2nd_exit_ena}} & state_wait2nd_nxt)
            | ({ICB_STATE_WIDTH{state_2nd_exit_ena    }} & state_2nd_nxt    )
            | ({ICB_STATE_WIDTH{state_wbck_exit_ena   }} & state_wbck_nxt   )
         `ifdef N22_MISALIGNED_ACCESS
            | ({ICB_STATE_WIDTH{state_wait3rd_exit_ena}} & state_wait3rd_nxt)
            | ({ICB_STATE_WIDTH{state_3rd_exit_ena    }} & state_3rd_nxt    )
            | ({ICB_STATE_WIDTH{state_wait4th_exit_ena}} & state_wait4th_nxt)
            | ({ICB_STATE_WIDTH{state_4th_exit_ena    }} & state_4th_nxt    )
          `endif
              ;


  n22_gnrl_dfflr #(ICB_STATE_WIDTH) icb_state_dfflr (icb_state_ena, icb_state_nxt, icb_state_r, clk, rst_n);

  wire state_1st_enter_ena = icb_state_ena & (icb_state_nxt == ICB_STATE_1ST);
  wire state_wbck_enter_ena = icb_state_ena & (icb_state_nxt == ICB_STATE_WBCK);

  wire icb_sta_is_last = icb_sta_is_wbck;
  wire state_last_exit_ena = state_wbck_exit_ena;



  assign unalignamo_active = ((~icb_sta_is_idle) | agu_icb_cmd_valid);
  assign unalignamo_sta_not_idle = (~icb_sta_is_idle);
  `ifdef N22_LDST_EXCP_PRECISE
  assign unalignamo_sta_pend_rv32 = sdb_rv32;
  `endif
  wire leftover_ena;
  wire [`N22_XLEN-1:0] leftover_nxt;
  wire [`N22_XLEN-1:0] leftover_r;
  wire leftover_err_ena;
  wire leftover_err_nxt;
  wire leftover_err_r;

  wire [`N22_XLEN-1:0] leftover_1_r;
  wire leftover_1_ena;
  wire [`N22_XLEN-1:0] leftover_1_nxt;
 `ifdef N22_HAS_AMO
  wire amo_1stuop = icb_sta_is_1st & sdb_amo;
  wire amo_2nduop = icb_sta_is_2nd & sdb_amo;
  wire excl_ld_enter_2nd = agu_excl & agu_load & state_idle_exit_ena;
  wire excl_st_enter_wbck = excl_st_nohit & state_idle_exit_ena;
  wire excl_ld_uop_rsp = icb_sta_is_2nd & sdb_excl & sdb_load;
  wire excl_st_uop_rsp = icb_sta_is_2nd & sdb_excl & sdb_store;
 `endif
 `ifdef N22_MISALIGNED_ACCESS
  wire unalgnst_enter_1st = agu_unalgnst & state_idle_exit_ena;
  wire unalgnldst_enter_1st = agu_unalgnldst & state_idle_exit_ena;
  wire uop_rsp = ( icb_sta_is_1st
                        | icb_sta_is_2nd
                        | icb_sta_is_3rd
                        | icb_sta_is_4th);
  wire unalgnld_uop_rsp = uop_rsp & sdb_unalgnld;
  wire unalgnldst_uop_rsp = uop_rsp & sdb_unalgnldst;
 `endif


  `ifdef N22_MISALIGNED_ACCESS
  wire [8-1:0] rsp_rdata_byte =
                                  ({8{(leftover_1_r[1:0] == 2'b00)}} & lsu_icb_rsp_rdata[7:0])
                                | ({8{(leftover_1_r[1:0] == 2'b01)}} & lsu_icb_rsp_rdata[15:8])
                                | ({8{(leftover_1_r[1:0] == 2'b10)}} & lsu_icb_rsp_rdata[23:16])
                                | ({8{(leftover_1_r[1:0] == 2'b11)}} & lsu_icb_rsp_rdata[31:24])
                                ;
  wire [32-1:0] rsp_rdata_byte_replic = {4{rsp_rdata_byte}};

  wire [`N22_XLEN-1:0] unalgnld_mask =
            ({`N22_XLEN{icb_sta_is_1st}} & `N22_XLEN'h0000_00FF)
          | ({`N22_XLEN{icb_sta_is_2nd}} & `N22_XLEN'h0000_FF00)
          | ({`N22_XLEN{icb_sta_is_3rd}} & `N22_XLEN'h00FF_0000)
          | ({`N22_XLEN{icb_sta_is_4th}} & `N22_XLEN'hFF00_0000)
          ;


  wire [`N22_XLEN-1:0] unalgnld_merged_data = ((leftover_r & (~unalgnld_mask)) | (rsp_rdata_byte_replic & unalgnld_mask));

  wire sdb_rsp_lhu = (sdb_size_h  &   sdb_icb_cmd_usign);
  wire sdb_rsp_lh  = (sdb_size_h  & (~sdb_icb_cmd_usign));
  wire sdb_rsp_lw  =  sdb_size_w;

  wire [`N22_XLEN-1:0] leftover_r_ext = `N22_XLEN'b0
          | ({`N22_XLEN{sdb_rsp_lhu}} & {{16{          1'b0}}, leftover_r[15:0]})
          | ({`N22_XLEN{sdb_rsp_lh }} & {{16{leftover_r[15]}}, leftover_r[15:0]})
          | ({`N22_XLEN{sdb_rsp_lw }} &                        leftover_r[31:0] );

  `endif

  assign leftover_ena = (
                   1'b0
                   `ifdef N22_HAS_AMO
                   | (lsu_icb_rsp_hsked & amo_1stuop)
                   | excl_st_enter_wbck
                   | (lsu_icb_rsp_hsked & excl_ld_uop_rsp)
                   | (lsu_icb_rsp_hsked & excl_st_uop_rsp)
                   `endif
                   `ifdef N22_MISALIGNED_ACCESS
                   | unalgnst_enter_1st
                   | (lsu_icb_rsp_hsked & unalgnld_uop_rsp)
                   `endif
                   );

  assign leftover_nxt =
              {`N22_XLEN{1'b0}}
         `ifdef N22_HAS_AMO
            | ({`N22_XLEN{amo_1stuop        }} & lsu_icb_rsp_rdata)
            | ({`N22_XLEN{excl_st_enter_wbck}} & 32'h1)
            | ({`N22_XLEN{excl_ld_uop_rsp   }} & lsu_icb_rsp_rdata)
            | ({`N22_XLEN{excl_st_uop_rsp   }} & 32'h0)
         `endif
         `ifdef N22_MISALIGNED_ACCESS
            | ({`N22_XLEN{unalgnst_enter_1st}} & agu_icb_cmd_wdata)
            | ({`N22_XLEN{unalgnld_uop_rsp}} & unalgnld_merged_data)
         `endif
            ;

  assign leftover_err_ena = 1'b0
         `ifdef N22_HAS_AMO
                   | amo_1stuop
                   | amo_2nduop
                   | excl_st_enter_wbck
                   | excl_ld_uop_rsp
                   | excl_st_uop_rsp
         `endif
         `ifdef N22_MISALIGNED_ACCESS
                   | (lsu_icb_rsp_hsked & unalgnldst_uop_rsp)
         `endif
         ;

  assign leftover_err_nxt = 1'b0
         `ifdef N22_HAS_AMO
            | (amo_1stuop         & lsu_icb_rsp_err)
            | (amo_2nduop         & lsu_icb_rsp_err)
            | (excl_st_enter_wbck & 1'b0)
            | (excl_ld_uop_rsp    & lsu_icb_rsp_err)
            | (excl_st_uop_rsp    & lsu_icb_rsp_err)
         `endif
         `ifdef N22_MISALIGNED_ACCESS
            | (unalgnldst_uop_rsp & lsu_icb_rsp_err)
         `endif
         ;


  `ifdef N22_HAS_AMO
  wire excl_flag_set = excl_ld_enter_2nd;
  wire excl_flag_clr = (agu_icb_cmd_hsked & ~excl_flag_set)
                       | (excl_ld_uop_rsp & lsu_icb_rsp_err)
					   ;
  wire excl_flag_ena = excl_flag_set | excl_flag_clr;
  wire excl_flag_nxt = excl_flag_set | ~excl_flag_clr;
  `endif
  assign agu_sbf_0_ena = leftover_ena;
  assign agu_sbf_0_nxt = leftover_nxt;
  assign leftover_r    = agu_sbf_0_r;

  n22_gnrl_dfflr #(1) icb_leftover_err_dfflr (leftover_err_ena, leftover_err_nxt, leftover_err_r, clk, rst_n);


         `ifdef N22_MISALIGNED_ACCESS
  wire leftover_pmperr_r;
  wire leftover_pmperr_ena = state_wbck_enter_ena;
  wire leftover_pmperr_nxt =
                           ((  icb_sta_is_wait2nd
                             | icb_sta_is_wait3rd
                             | icb_sta_is_wait4th
                            ) & sdb_unalgnldst_pmperr);

  n22_gnrl_dfflr #(1) icb_leftover_pmperr_dfflr (leftover_pmperr_ena, leftover_pmperr_nxt, leftover_pmperr_r, clk, rst_n);
         `endif
         `ifndef N22_MISALIGNED_ACCESS
  wire leftover_pmperr_r = 1'b0;
         `endif


  `ifdef N22_HAS_AMO
  n22_gnrl_dfflr #(1) excl_flag_dfflr (excl_flag_ena, excl_flag_nxt, excl_flag_r, clk, rst_n);
  `endif

         `ifdef N22_MISALIGNED_ACCESS
  wire unalgnldst_uop_cmd_hsked = (unalgnldst_enter_1st)
                              | ( (  icb_sta_is_wait2nd
                                   | icb_sta_is_wait3rd
                                   | icb_sta_is_wait4th)
                                   & sdb_unalgnldst & lsu_icb_cmd_hsked
                                 );
         `endif
         `ifdef N22_HAS_AMO
  wire amo_enter_1st = agu_amo & state_idle_exit_ena;
  wire excl_exit_idle = agu_excl & state_idle_exit_ena;
         `endif
  assign leftover_1_ena = 1'b0
         `ifdef N22_HAS_AMO
             | amo_enter_1st
             | excl_exit_idle
         `endif
         `ifdef N22_MISALIGNED_ACCESS
           | unalgnldst_uop_cmd_hsked
           | (leftover_pmperr_ena & leftover_pmperr_nxt)
         `endif
         ;
  assign leftover_1_nxt = (
                          `ifdef N22_MISALIGNED_ACCESS
                           unalgnldst_enter_1st
                          `endif
                          `ifdef N22_HAS_AMO
                          | amo_enter_1st
                          | excl_exit_idle
                          `endif
                          ) ? agu_icb_cmd_addr : agu_req_alu_res;
  assign agu_sbf_1_ena   = leftover_1_ena;
  assign agu_sbf_1_nxt   = leftover_1_nxt;
  assign leftover_1_r = agu_sbf_1_r;
  `ifdef N22_HAS_AMO
  assign excl_addr_r = leftover_1_r;
  `endif



  assign agu_req_alu_add  = 1'b0
                     `ifdef N22_HAS_AMO
                           | (icb_sta_is_amoalu & sdb_amoadd)
                     `endif
                     `ifdef N22_MISALIGNED_ACCESS
                           | (sdb_unalgnldst & (icb_sta_is_wait2nd
                                              | icb_sta_is_wait3rd
                                              | icb_sta_is_wait4th)
                             )
                     `endif
                           ;

  assign agu_req_alu_op1 =
                     `ifdef N22_HAS_AMO
                            icb_sta_is_amoalu ? leftover_r :
                     `endif
                     `ifdef N22_MISALIGNED_ACCESS
                            leftover_1_r
                     `endif
                     `ifndef N22_MISALIGNED_ACCESS
                            `N22_XLEN'd0
                     `endif
                     ;

  assign agu_req_alu_op2 =
                     `ifdef N22_HAS_AMO
                            icb_sta_is_amoalu ? sdb_rs2 :
                     `endif
                     `ifdef N22_MISALIGNED_ACCESS
                            `N22_XLEN'd1
                     `endif
                     `ifndef N22_MISALIGNED_ACCESS
                            `N22_XLEN'd0
                     `endif
                     ;

  `ifdef N22_HAS_AMO
  assign agu_req_alu_swap = (icb_sta_is_amoalu & sdb_amoswap );
  assign agu_req_alu_and  = (icb_sta_is_amoalu & sdb_amoand  );
  assign agu_req_alu_or   = (icb_sta_is_amoalu & sdb_amoor   );
  assign agu_req_alu_xor  = (icb_sta_is_amoalu & sdb_amoxor  );
  assign agu_req_alu_max  = (icb_sta_is_amoalu & sdb_amomax  );
  assign agu_req_alu_min  = (icb_sta_is_amoalu & sdb_amomin  );
  assign agu_req_alu_maxu = (icb_sta_is_amoalu & sdb_amomaxu );
  assign agu_req_alu_minu = (icb_sta_is_amoalu & sdb_amominu );
  `endif

  `ifndef N22_HAS_AMO
  assign agu_req_alu_swap = 1'b0;
  assign agu_req_alu_and  = 1'b0;
  assign agu_req_alu_or   = 1'b0;
  assign agu_req_alu_xor  = 1'b0;
  assign agu_req_alu_max  = 1'b0;
  assign agu_req_alu_min  = 1'b0;
  assign agu_req_alu_maxu = 1'b0;
  assign agu_req_alu_minu = 1'b0;
  `endif



  assign agu_icb_cmd_ready = icb_sta_is_idle & lsu_icb_cmd_ready;




  assign wbck_o_valid =
      icb_sta_is_last
      ;

  assign wbck_o_wdat = {`N22_XLEN{1'b0 }}
       `ifdef N22_MISALIGNED_ACCESS
                    | ({`N22_XLEN{sdb_unalgnld }} & leftover_r_ext)
                    | ({`N22_XLEN{sdb_unalgnst }} & `N22_XLEN'b0)
       `endif
       `ifdef N22_HAS_AMO
                    | ({`N22_XLEN{sdb_amo  }} & leftover_r)
                    | ({`N22_XLEN{sdb_excl     }} & leftover_r)
       `endif
       ;


  wire wbck_o_cmt_buserr_raw;
  assign {wbck_o_cmt_buserr_raw, wbck_o_cmt_pmperr} = (2'b0
                `ifdef N22_MISALIGNED_ACCESS
                      | ({2{sdb_unalgnldst}} & {leftover_err_r, leftover_pmperr_r})
                `endif
                `ifdef N22_HAS_AMO
                      | ({2{sdb_amo}}    & {leftover_err_r, 1'b0})
                      | ({2{sdb_excl}} & {leftover_err_r, 1'b0} )
                `endif
                      )
                ;

   assign wbck_o_itag  = sdb_icb_cmd_itag;
   assign wbck_o_err   = wbck_o_cmt_buserr_raw | wbck_o_cmt_pmperr;
   assign wbck_o_cmt_buserr   = wbck_o_err;

   assign wbck_o_cmt_badaddr = (sdb_unalgnldst
                        `ifdef N22_HAS_AMO
                                | sdb_amo
                                | sdb_excl
                        `endif
							   ) ? leftover_1_r[`N22_ADDR_SIZE-1:0] : `N22_ADDR_SIZE'b0;
   assign wbck_o_cmt_ld    = sdb_load;
   assign wbck_o_cmt_stamo = sdb_store
                        `ifdef N22_HAS_AMO
                           | sdb_amo
                        `endif
                           ;
   assign wbck_o_cmt_pc    = sdb_pc;




  assign lsu_icb_rsp_ready = 1'b1;




  assign lsu_icb_cmd_sel   = agu_icb_cmd_sel | (~icb_sta_is_idle);
  assign lsu_icb_cmd_valid = icb_sta_is_idle ?
                            (
                             `ifdef N22_HAS_AMO
							 (excl_st_hit | agu_load | ~agu_excl) &
                             `endif
                             agu_icb_cmd_valid ) :
                            ((  icb_sta_is_wait2nd
                             `ifdef N22_MISALIGNED_ACCESS
                             | icb_sta_is_wait3rd
                             | icb_sta_is_wait4th
                             `endif
                              `ifdef N22_HAS_AMO
						     | icb_sta_is_amoalu
                              `endif
                            ) & (~sdb_unalgnldst_pmperr))
                            ;
  assign lsu_icb_cmd_addr = (~icb_sta_is_idle) ?
                             (
                            `ifdef N22_HAS_AMO
			                 sdb_amo ? leftover_1_r[`N22_ADDR_SIZE-1:0] :
                            `endif
							 agu_req_alu_res[`N22_ADDR_SIZE-1:0]) :
							 agu_icb_cmd_addr[`N22_ADDR_SIZE-1:0];

  `ifdef N22_LDST_EXCP_PRECISE
  assign lsu_icb_cmd_rv32 = (~icb_sta_is_idle) ? sdb_rv32 : agu_icb_cmd_rv32;
  `endif

  assign lsu_icb_cmd_read = (~icb_sta_is_idle) ?
          (
          `ifdef N22_MISALIGNED_ACCESS
            (sdb_unalgnldst & (sdb_load ? 1'b1 : 1'b0))
          `endif
          `ifdef N22_HAS_AMO
          | (sdb_amo & ( icb_sta_is_amoalu ? 1'b0 : 1'b1))
          `endif
          ) : (agu_icb_cmd_read
          `ifdef N22_HAS_AMO
               | agu_amo
          `endif
              )
          ;

   `ifdef N22_HAS_PMP
  wire chk_pmperr;

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
      .i_mpp_m_mode  (sdb_mpp_m_mode),

      .i_r    (sdb_load),
      .i_w    (sdb_store),
      .i_x    (1'b0),

      .i_mmode(sdb_icb_cmd_mmode),
      .i_dmode(sdb_icb_cmd_dmode),
      .i_addr (agu_req_alu_res),

      .o_err  (chk_pmperr)
  );

  assign sdb_unalgnldst_pmperr = chk_pmperr & sdb_unalgnldst;
    `endif

   `ifndef N22_HAS_PMP
  assign sdb_unalgnldst_pmperr = 1'b0;
   `endif

    `ifndef N22_HAS_PMP
    `endif



  `ifdef N22_MISALIGNED_ACCESS
  wire [`N22_XLEN-1:0] unalgnst_wdata =
            ({`N22_XLEN{icb_sta_is_idle}}     & {4{agu_icb_cmd_wdata[ 7: 0]}})
          | ({`N22_XLEN{icb_sta_is_wait2nd }} & {4{leftover_r[15: 8]}})
          | ({`N22_XLEN{icb_sta_is_wait3rd }} & {4{leftover_r[23:16]}})
          | ({`N22_XLEN{icb_sta_is_wait4th }} & {4{leftover_r[31:24]}});

  wire [`N22_XLEN_MW-1:0] unalgnst_wmask = 4'b0001 << lsu_icb_cmd_addr[1:0];
  `endif

  assign lsu_icb_cmd_wdata = (~icb_sta_is_idle) ? (
  `ifdef N22_HAS_AMO
      (sdb_amo & icb_sta_is_amoalu) ? agu_req_alu_res :
  `endif
  `ifdef N22_MISALIGNED_ACCESS
      sdb_unalgnst ? unalgnst_wdata :
  `endif
      `N22_XLEN'b0)
  `ifdef N22_MISALIGNED_ACCESS
      : agu_unalgnst ? unalgnst_wdata
  `endif
          : agu_icb_cmd_wdata;

  assign lsu_icb_cmd_wmask = (~icb_sta_is_idle) ? (
  `ifdef N22_HAS_AMO
      sdb_amo ? 4'hF :
  `endif
  `ifdef N22_MISALIGNED_ACCESS
      sdb_unalgnst ? unalgnst_wmask :
  `endif
      `N22_XLEN_MW'b0)
  `ifdef N22_MISALIGNED_ACCESS
      : agu_unalgnst ? unalgnst_wmask
  `endif
          : agu_icb_cmd_wmask;

  assign lsu_icb_cmd_back2agu =
             `ifdef N22_MISALIGNED_ACCESS
                             agu_unalgnldst |
             `endif
             `ifdef N22_HAS_AMO
                             agu_amo |
							 agu_excl|
             `endif
                                (~icb_sta_is_idle);

  assign lsu_icb_cmd_lock     = (~icb_sta_is_idle) ? (
                   1'b0
             ) : (
             `ifdef N22_HAS_AMO
                   agu_amo
			     | (agu_excl & agu_load)
             `endif
             `ifndef N22_HAS_AMO
			     1'b0
             `endif
			 );
  `ifdef N22_HAS_AMO
  assign lock_clear_ena = (state_1st_exit_ena & sdb_amo & lsu_icb_rsp_err & lsu_icb_rsp_hsked)
                          | (excl_ld_uop_rsp & lsu_icb_rsp_err & lsu_icb_rsp_hsked)
                          | (excl_st_nohit & agu_icb_cmd_hsked);
  `endif
  `ifndef N22_HAS_AMO
  assign lock_clear_ena = 1'b0;
  `endif
  assign lsu_icb_cmd_excl     =
             `ifndef N22_HAS_AMO
              1'b0;
             `endif
             `ifdef N22_HAS_AMO
              1'b0;
             `endif

  assign lsu_icb_cmd_itag     = (~icb_sta_is_idle) ? sdb_icb_cmd_itag : agu_icb_cmd_itag;
  assign lsu_icb_cmd_usign    = (~icb_sta_is_idle) ? sdb_icb_cmd_usign : agu_icb_cmd_usign;
  assign lsu_icb_cmd_size     = (~icb_sta_is_idle) ? (
             `ifdef N22_MISALIGNED_ACCESS
                sdb_unalgnldst  ? 2'b0 :
             `endif
                sdb_icb_cmd_size
                ) : (agu_unalgn ? 2'b0 : agu_icb_cmd_size);

  assign lsu_icb_cmd_mmode     = (~icb_sta_is_idle) ? sdb_icb_cmd_mmode  : agu_icb_cmd_mmode ;
  assign lsu_icb_cmd_dmode     = (~icb_sta_is_idle) ? sdb_icb_cmd_dmode  : agu_icb_cmd_dmode ;
  assign lsu_icb_cmd_x0base    = (~icb_sta_is_idle) ? sdb_icb_cmd_x0base : agu_icb_cmd_x0base;



    n22_exu_alu_dpath u_n22_exu_alu_dpath(
      .alu_req_alu         (1'b0      ),
      .alu_req_alu_add     (1'b0      ),
      .alu_req_alu_sub     (1'b0      ),
      .alu_req_alu_xor     (1'b0      ),
      .alu_req_alu_sll     (1'b0      ),
      .alu_req_alu_srl     (1'b0      ),
      .alu_req_alu_sra     (1'b0      ),
      .alu_req_alu_or      (1'b0      ),
      .alu_req_alu_and     (1'b0      ),
      .alu_req_alu_slt     (1'b0      ),
      .alu_req_alu_sltu    (1'b0      ),
      .alu_req_alu_lui     (1'b0      ),
      .alu_req_alu_op1     (`N22_XLEN'b0  ),
      .alu_req_alu_op2     (`N22_XLEN'b0  ),
      .alu_req_alu_res     (),

      .bjp_req_alu         (1'b0           ),
      .bjp_req_alu_op1     (`N22_XLEN'b0  ),
      .bjp_req_alu_op2     (`N22_XLEN'b0  ),
      .bjp_req_alu_cmp_eq  (1'b0),
      .bjp_req_alu_cmp_ne  (1'b0),
      .bjp_req_alu_cmp_lt  (1'b0),
      .bjp_req_alu_cmp_gt  (1'b0),
      .bjp_req_alu_cmp_ltu (1'b0),
      .bjp_req_alu_cmp_gtu (1'b0),
      .bjp_req_alu_add     (1'b0),
      .bjp_req_alu_cmp_res (),
      .bjp_req_alu_add_res (),

      .agu_req_alu         (1'b1           ),
      .agu_req_alu_op1     (agu_req_alu_op1       ),
      .agu_req_alu_op2     (agu_req_alu_op2       ),
      .agu_req_alu_swap    (agu_req_alu_swap      ),
      .agu_req_alu_add     (agu_req_alu_add       ),
      .agu_req_alu_and     (agu_req_alu_and       ),
      .agu_req_alu_or      (agu_req_alu_or        ),
      .agu_req_alu_xor     (agu_req_alu_xor       ),
      .agu_req_alu_max     (agu_req_alu_max       ),
      .agu_req_alu_min     (agu_req_alu_min       ),
      .agu_req_alu_maxu    (agu_req_alu_maxu      ),
      .agu_req_alu_minu    (agu_req_alu_minu      ),
      .agu_req_alu_res     (agu_req_alu_res       ),

      .agu_sbf_0_ena    (agu_sbf_0_ena),
      .agu_sbf_0_nxt    (agu_sbf_0_nxt),
      .agu_sbf_0_r      (agu_sbf_0_r  ),

      .agu_sbf_1_ena    (agu_sbf_1_ena),
      .agu_sbf_1_nxt    (agu_sbf_1_nxt),
      .agu_sbf_1_r      (agu_sbf_1_r  ),

`ifdef N22_SHARE_MULDIV
      .muldiv_req_alu      (1'b0    ),

      .muldiv_req_alu_op1  (`N22_ALU_ADDER_WIDTH'b0),
      .muldiv_req_alu_op2  (`N22_ALU_ADDER_WIDTH'b0),
      .muldiv_req_alu_add  (                    1'b0),
      .muldiv_req_alu_sub  (                    1'b0),
      .muldiv_req_alu_res  (),

      .muldiv_sbf_0_ena    (1'b0  ),
      .muldiv_sbf_0_nxt    (33'b0  ),
      .muldiv_sbf_0_r      (),

      .muldiv_sbf_1_ena    (1'b0  ),
      .muldiv_sbf_1_nxt    (33'b0  ),
      .muldiv_sbf_1_r      (),
`endif

      .clk                 (clk  ),
      .rst_n               (rst_n)
    );



endmodule
  `endif




