
`include "global.inc"

module n22_ifu_ift2icb(

  input  ifu_req_valid,
  output ifu_req_ready,
  input  [`N22_PC_SIZE-1:0] ifu_req_pc,
  input  ifu_req_dmode,
  input  ifu_req_vmode,
  input  ifu_req_mmode,
  input  ifu_req_seq,
  input  ifu_req_seq_rv32,
  output ifu_rsp_valid,
  input  ifu_rsp_ready,
  output ifu_rsp_err,
  output ifu_rsp_err_btm,
  output ifu_rsp_pmperr,
  output [32-1:0] ifu_rsp_instr,

  input  ifu_flush_req,


  output ifu_icb_cmd_valid,
  input  ifu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   ifu_icb_cmd_addr,
  output ifu_icb_cmd_dmode,
  output ifu_icb_cmd_vmode,
  output ifu_icb_cmd_mmode,
  output ifu_icb_cmd_seq,

  input  ifu_icb_rsp_valid,
  input  ifu_icb_rsp_err,
  input  ifu_icb_rsp_pmperr,
  input  [`N22_SYSMEM_DATA_WIDTH-1:0] ifu_icb_rsp_rdata,



  input  clk,
  input  rst_n
  );





  wire s0    ;
  wire s1   ;
  wire s2;
  wire s3    ;
  wire s4;
  wire s5;
  wire s6;

  wire s7 = (ifu_req_pc[1] == 1'b1);
  wire s8 = (ifu_req_pc[1] == 1'b0);



  wire s9   = (~ifu_req_seq) & s8;
  wire s10 = (~ifu_req_seq) & s7;

  wire s11      = ifu_req_seq & s8 & (~ifu_req_seq_rv32);
  wire s12      = ifu_req_seq & s8 & ifu_req_seq_rv32;
  wire s13    = ifu_req_seq & s7;

  wire s14 = s10;
  wire s15 = s11;

  wire s16;
  wire s17;
  wire s18;

  wire s19 = ifu_req_valid & ifu_req_ready;
  wire s20 = ifu_rsp_valid & ifu_rsp_ready;

  wire s21 ;
  wire s22 ;

  n22_gnrl_dfflr #(1) req_need_2uop_dfflr       (s19, s14, s16      , clk, rst_n);
  n22_gnrl_dfflr #(1) req_need_0uop_dfflr       (s19, s15, s17      , clk, rst_n);
  n22_gnrl_dfflr #(1) req_unalgn_seq_1uop_dfflr (s19, s13  , s18, clk, rst_n);

  n22_gnrl_dfflr #(1) ifu_req_mmode_dfflr       (s19, ifu_req_mmode  , s21      , clk, rst_n);
  n22_gnrl_dfflr #(1) ifu_req_dmode_dfflr       (s19, ifu_req_dmode  , s22      , clk, rst_n);

  assign ifu_icb_cmd_valid =
                   (s6 & (~s15))
                 | (
                     (
                         (
                              s4
                              & s0 & s5
                         )
                       |  s2
                     )
                   )
                     ;


  wire s23 =
                              s4 &
                                (
                                     s0
                                  |  s2
                                );
  wire s24 = s13 | s23;

  wire [`N22_PC_SIZE-1:0] s25;
  wire [`N22_PC_SIZE-1:0] s26 = s24 ? (s25 + `N22_ADDR_SIZE'd4) : ifu_req_pc;

  assign ifu_icb_cmd_addr   = {s26[`N22_PC_SIZE-1:2],2'b0};
  assign ifu_icb_cmd_mmode  = s23 ? s21 : ifu_req_mmode;
  assign ifu_icb_cmd_dmode  = s23 ? s22 : ifu_req_dmode;
  assign ifu_icb_cmd_vmode  = s23 ? 1'b0
                                          : ifu_req_vmode;
  assign ifu_icb_cmd_seq    = s23 ? 1'b1
                                          : ifu_req_seq  ;

  wire s27;
  wire s28 = s27 | s19;
  n22_gnrl_dfflr #(`N22_ADDR_SIZE)icb_addr_dfflr(s27, ifu_icb_cmd_addr, s25, clk,rst_n);






  wire s29 = 1'b1;



  assign s27 = ifu_icb_cmd_valid & ifu_icb_cmd_ready;
  assign s5 = ifu_icb_rsp_valid & s29;




  localparam ICB_STATE_WIDTH  = 2;
  localparam ICB_STATE_IDLE = 2'd0;
  localparam ICB_STATE_1ST  = 2'd1;
  localparam ICB_STATE_WAIT2ND  = 2'd2;
  localparam ICB_STATE_2ND  = 2'd3;

  wire [ICB_STATE_WIDTH-1:0] s30;
  wire [ICB_STATE_WIDTH-1:0] s31;
  wire s32;
  wire [ICB_STATE_WIDTH-1:0] s33   ;
  wire [ICB_STATE_WIDTH-1:0] s34    ;
  wire [ICB_STATE_WIDTH-1:0] s35;
  wire [ICB_STATE_WIDTH-1:0] s36    ;
  wire s37     ;
  wire s38      ;
  wire s39  ;
  wire s40      ;

  assign s1    = (s31 == ICB_STATE_IDLE   );
  assign s0     = (s31 == ICB_STATE_1ST    );
  assign s2 = (s31 == ICB_STATE_WAIT2ND);
  assign s3     = (s31 == ICB_STATE_2ND    );

  assign s37 = s1 & s19;
  assign s33      = ICB_STATE_1ST;

  wire s41 = ifu_flush_req;
  assign s4 = s16 & (~s41);
  wire s42;
  assign s38  = s0 & (
                                  s4 ? s5 :
                                                      s20
                             );
  assign s34     =
                (
                  (s4 & (~ifu_icb_cmd_ready)) ?  ICB_STATE_WAIT2ND
                  : (s4 & ifu_icb_cmd_ready) ?  ICB_STATE_2ND
                  :  s19  ?  ICB_STATE_1ST
                                    : ICB_STATE_IDLE
                ) ;

  assign s39 = s2 &  ifu_icb_cmd_ready;
  assign s35      = ICB_STATE_2ND;

  assign s40     =  s3 &  s20;
  assign s36          =
                (
                  s19  ?  ICB_STATE_1ST :
                      ICB_STATE_IDLE
                );

  assign s32 =
            s37 | s38 | s39 | s40;

  assign s30 =
              ({ICB_STATE_WIDTH{s37   }} & s33   )
            | ({ICB_STATE_WIDTH{s38    }} & s34    )
            | ({ICB_STATE_WIDTH{s39}} & s35)
            | ({ICB_STATE_WIDTH{s40    }} & s36    )
              ;

  n22_gnrl_dfflr #(ICB_STATE_WIDTH) icb_state_dfflr (s32, s30, s31, clk, rst_n);


  wire s43;


  assign ifu_req_ready     = s43;
  assign s6 = ifu_req_valid    ;

  assign s43 = ifu_icb_cmd_ready;


`ifdef N22_IFU_RSP_2CYCLE
  wire s44;

  wire [`N22_XLEN-1:0] s45;
  wire s46  ;
  wire s47;

  wire [32-1:0] s48 = s45 ;
  wire s49            = s46   ;
  wire s50         = s47;

  wire s51;
  wire s52 = s11 & s19;
  wire s53 = (
                           ((~s44) & ifu_icb_rsp_valid & (~s42))
                         | (s52)
                         );
  wire s54 = s44 & s51;
  wire s55 = s53 | s54;
  wire s56 = s53 | (~s54);
  n22_gnrl_dfflr #(1)  icb_rsp_vld_dfflr(s55, s56, s44, clk, rst_n);

  wire s57 = s53 & (~s44);
  n22_gnrl_dfflr  #(32) rsp_rdata_dfflr  (s57, ifu_icb_rsp_rdata , s45 , clk, rst_n);
  n22_gnrl_dfflr  #(1)  rsp_err_dfflr    (s57, ifu_icb_rsp_err   , s46   , clk, rst_n);
  n22_gnrl_dfflr  #(1)  rsp_pmperr_dfflr (s57, ifu_icb_rsp_pmperr, s47, clk, rst_n);


  wire s58 = s44;

`else
  wire s44;

  wire [`N22_XLEN-1:0] s45;
  wire s46  ;
  wire s47;

  wire [32-1:0] s48 = s44 ? s45  : ifu_icb_rsp_rdata;
  wire s49            = s44 ? s46    : ifu_icb_rsp_err;
  wire s50         = s44 ? s47 : ifu_icb_rsp_pmperr;

  wire s51;
  wire s52 = s11 & s19;
  wire s53 = (
                           ((~s44) & ifu_icb_rsp_valid & (~s42) & (~s51))
                         | (s52)
                         );
  wire s54 = s44 & s51;
  wire s55 = s53 | s54;
  wire s56 = s53 | (~s54);
  n22_gnrl_dfflr #(1)  icb_rsp_vld_dfflr(s55, s56, s44, clk, rst_n);

  wire s57 = s53 & (~s44);
  n22_gnrl_dfflr  #(32) rsp_rdata_dfflr  (s57, s48 , s45 , clk, rst_n);
  n22_gnrl_dfflr  #(1)  rsp_err_dfflr    (s57, s49   , s46   , clk, rst_n);
  n22_gnrl_dfflr  #(1)  rsp_pmperr_dfflr (s57, s50, s47, clk, rst_n);


  wire s58 = s44 | ifu_icb_rsp_valid;
`endif

  wire s59;
  wire [15:0] s60;
  wire [15:0] s61;
  wire s62;
  wire s63;
  wire s64;
  wire s65;

  wire s66 = s19 & s13;
  wire s67 = s5 & s42;

  assign s59 = s66 | s67;

`ifdef N22_IFU_RSP_2CYCLE
  assign s60 = s67 ? ifu_icb_rsp_rdata[31:16] : s48[31:16];
`else
  assign s60 = s48[31:16];
`endif
  assign s62 = s49;
  assign s64 = s50;

  n22_gnrl_dfflr #(16) leftover_dfflr     (s59, s60,     s61,     clk, rst_n);
  n22_gnrl_dfflr #(1) leftover_err_dfflr (s59, s62, s63, clk, rst_n);
  n22_gnrl_dfflr #(1) leftover_pmperr_dfflr (s59, s64, s65, clk, rst_n);



  wire s68 = s0 & s17;
  assign s42 = s4 & s0;

  wire s69;
  wire s70;

  assign ifu_rsp_valid = s68 | s70;
  assign s69 = ifu_rsp_ready;
  assign s70     = s42 ? 1'b0 : s58;
  assign s51 = s42 ? 1'b1 : s69;


  wire s71 = (   s0
                                  & s18
                                )
                              | s3;

  assign ifu_rsp_instr =  s71 ? {s48[15:0], s61} : s48;
  wire s72 = s71 ? (|{s50, s65}) : s50;
  wire s73 = s71 & s50 & (~s65);
  wire s74 = s71 ? (|{s49, s63}) : s49;
  assign ifu_rsp_err_btm =  ~(s71 & (s49 & (~s63)));
  wire s75 = ~ifu_rsp_err_btm;
  assign ifu_rsp_err = s74 & (~(s75 & (~ifu_req_seq_rv32)));
  assign ifu_rsp_pmperr = s72 & (~(s73 & (~ifu_req_seq_rv32)));




`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off




//synopsys translate_on
`endif
`endif




endmodule



