
`include "global.inc"

module n22_biu_cach_arbt #(
  parameter USR_W = 10,
  parameter USR_PACK_X0BASE = 0,
  parameter USR_PACK_DEVICE = 1,
  parameter USR_PACK_DMODE  = 2,
  parameter USR_PACK_MMODE  = 3,
  parameter USR_PACK_VMODE  = 4,
  parameter USR_PACK_IFU    = 5,
  parameter USR_PACK_ICACH  = 6,
  parameter USR_PACK_DCACH  = 7,
  parameter USR_PACK_ERR = 8,
  parameter USR_PACK_SEQ = 9
)(

  output                         cach_arbt_active,


  input                          mem_icb_cmd_valid,
  output                         mem_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   mem_icb_cmd_addr,
  input                          mem_icb_cmd_read,
  input  [`N22_XLEN-1:0]        mem_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]     mem_icb_cmd_wmask,
  input  [2:0]                   mem_icb_cmd_burst,
  input  [1:0]                   mem_icb_cmd_beat,
  input                          mem_icb_cmd_lock,
  input                          mem_icb_cmd_excl,
  input  [1:0]                   mem_icb_cmd_size,
  input  [USR_W-1:0]             mem_icb_cmd_usr,

  output                         mem_icb_rsp_valid,
  input                          mem_icb_rsp_ready,
  output                         mem_icb_rsp_err  ,
  output                         mem_icb_rsp_excl_ok,
  output [`N22_XLEN-1:0]        mem_icb_rsp_rdata,



  `ifdef N22_HAS_ICACHE
  input                          icach2biu_icb_cmd_valid,
  output                         icach2biu_icb_cmd_ready,
  input    [`N22_ADDR_SIZE-1:0] icach2biu_icb_cmd_addr,
  input                          icach2biu_icb_cmd_read,
  input  [`N22_XLEN-1:0]        icach2biu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]     icach2biu_icb_cmd_wmask,
  input    [2:0]                 icach2biu_icb_cmd_burst,
  input    [1:0]                 icach2biu_icb_cmd_beat,
  input                          icach2biu_icb_cmd_lock,
  input                          icach2biu_icb_cmd_excl,
  input  [1:0]                   icach2biu_icb_cmd_size,
  input                          icach2biu_icb_cmd_mmode,
  input                          icach2biu_icb_cmd_vmode,
  input                          icach2biu_icb_cmd_dmode,

  output                         icach2biu_icb_rsp_valid,
  input                          icach2biu_icb_rsp_ready,
  output                         icach2biu_icb_rsp_err,
  output                         icach2biu_icb_rsp_excl_ok,
  output   [`N22_XLEN-1:0]      icach2biu_icb_rsp_rdata,

  `endif


  output                         o_icb_cmd_valid,
  input                          o_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   o_icb_cmd_addr,
  output                         o_icb_cmd_read,
  output [`N22_XLEN-1:0]        o_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]     o_icb_cmd_wmask,
  output [2:0]                   o_icb_cmd_burst,
  output [1:0]                   o_icb_cmd_beat,
  output                         o_icb_cmd_lock,
  output                         o_icb_cmd_excl,
  output [1:0]                   o_icb_cmd_size,
  output [3:0]                   o_icb_cmd_hprot,
  output [1:0]                   o_icb_cmd_attri,
  output                         o_icb_cmd_dmode,
  output                         o_icb_cmd_ifu,
  output                         o_icb_cmd_seq,

  input                          o_icb_rsp_valid,
  output                         o_icb_rsp_ready,
  input                          o_icb_rsp_err  ,
  input                          o_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]        o_icb_rsp_rdata,

  input  clk,
  input  rst_n
  );


  `ifdef N22_HAS_ICACHE
      localparam ARBT_I_NUM = 2;
      localparam ARBT_I_PTR_W = 1;
  `endif

  `ifndef N22_HAS_ICACHE
      localparam ARBT_I_NUM = 1;
      localparam ARBT_I_PTR_W = 1;
  `endif


  `ifdef N22_HAS_ICACHE
  wire [USR_W-1:0] s0;
  assign s0[USR_PACK_X0BASE] = 1'b0;
  assign s0[USR_PACK_DEVICE ] = 1'b0;
  assign s0[USR_PACK_DMODE ] = icach2biu_icb_cmd_dmode;
  assign s0[USR_PACK_MMODE ] = icach2biu_icb_cmd_mmode;
  assign s0[USR_PACK_VMODE ] = icach2biu_icb_cmd_vmode;
  assign s0[USR_PACK_IFU   ] = 1'b1;
  assign s0[USR_PACK_ICACH ] = 1'b1;
  assign s0[USR_PACK_DCACH ] = 1'b0;
  assign s0[USR_PACK_ERR] = 1'b0;
  assign s0[USR_PACK_SEQ] = 1'b0;
  `endif


  wire [USR_W-1:0] o_icb_cmd_usr;


  wire [ARBT_I_NUM*1-1:0] s1;
  wire [ARBT_I_NUM*1-1:0] s2;
  wire [ARBT_I_NUM*`N22_ADDR_SIZE-1:0] s3;
  wire [ARBT_I_NUM*1-1:0] s4;
  wire [ARBT_I_NUM*`N22_XLEN-1:0] s5;
  wire [ARBT_I_NUM*`N22_XLEN_MW-1:0] s6;
  wire [ARBT_I_NUM*3-1:0] s7;
  wire [ARBT_I_NUM*2-1:0] s8;
  wire [ARBT_I_NUM*1-1:0] s9;
  wire [ARBT_I_NUM*1-1:0] s10;
  wire [ARBT_I_NUM*2-1:0] s11;
  wire [ARBT_I_NUM*USR_W-1:0] s12;

  wire [ARBT_I_NUM*1-1:0] s13;
  wire [ARBT_I_NUM*1-1:0] s14;
  wire [ARBT_I_NUM*1-1:0] s15;
  wire [ARBT_I_NUM*1-1:0] s16;
  wire [ARBT_I_NUM*`N22_XLEN-1:0] s17;

                           `ifdef N22_HAS_ICACHE
  wire[ARBT_I_NUM-1:0] s18 =
                           {
                               icach2biu_icb_cmd_valid,
                             (~icach2biu_icb_cmd_valid)
                           } ;
                           `endif
                           `ifndef N22_HAS_ICACHE
  wire[ARBT_I_NUM-1:0] s18 = {ARBT_I_NUM{1'b0}};
                           `endif

  assign s1 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_valid,
                           `endif
                             mem_icb_cmd_valid
                           } ;

  assign s3 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_addr,
                           `endif
                             mem_icb_cmd_addr
                           } ;

  assign s4 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_read,
                           `endif
                             mem_icb_cmd_read
                           } ;

  assign s5 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_wdata,
                           `endif
                             mem_icb_cmd_wdata
                           } ;

  assign s6 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_wmask,
                           `endif
                             mem_icb_cmd_wmask
                           } ;

  assign s7 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_burst,
                           `endif
                             mem_icb_cmd_burst
                           } ;

  assign s8 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_beat,
                           `endif
                             mem_icb_cmd_beat
                           } ;

  assign s9 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_lock,
                           `endif
                             mem_icb_cmd_lock
                           } ;

  assign s10 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_excl,
                           `endif
                             mem_icb_cmd_excl
                           } ;

  assign s11 =
                           {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_size,
                           `endif
                             mem_icb_cmd_size
                           } ;

 assign s12 =
                           {
                           `ifdef N22_HAS_ICACHE
                             s0,
                           `endif
                             mem_icb_cmd_usr
                           } ;

  assign                   {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_cmd_ready,
                           `endif
                             mem_icb_cmd_ready
                           } = s2;

  assign                   {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_rsp_valid,
                           `endif
                             mem_icb_rsp_valid
                           } = s13;

  assign                   {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_rsp_err,
                           `endif
                             mem_icb_rsp_err
                           } = s15;

  assign                   {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_rsp_excl_ok,
                           `endif
                             mem_icb_rsp_excl_ok
                           } = s16;

  assign                   {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_rsp_rdata,
                           `endif
                             mem_icb_rsp_rdata
                           } = s17;

  assign s14 = {
                           `ifdef N22_HAS_ICACHE
                             icach2biu_icb_rsp_ready,
                           `endif
                             mem_icb_rsp_ready
                           };


  n22_gnrl_icb_arbt # (
  .ALLOW_BURST (0),

  .ARBT_SCHEME (2),
  .FIFO_CUT_READY  (0),
  .ALLOW_0CYCL_RSP (0),
  .FIFO_OUTS_NUM   (2),
  .ARBT_NUM   (ARBT_I_NUM),
  .ARBT_PTR_W (ARBT_I_PTR_W),
  .USR_W      (USR_W),
  .AW         (`N22_ADDR_SIZE),
  .DW         (`N22_XLEN)
  ) u_biu_cach_icb_arbt(
  .arbt_active            (cach_arbt_active),

  .o_icb_cmd_valid        (o_icb_cmd_valid )     ,
  .o_icb_cmd_ready        (o_icb_cmd_ready )     ,
  .o_icb_cmd_read         (o_icb_cmd_read )      ,
  .o_icb_cmd_addr         (o_icb_cmd_addr )      ,
  .o_icb_cmd_wdata        (o_icb_cmd_wdata )     ,
  .o_icb_cmd_wmask        (o_icb_cmd_wmask)      ,
  .o_icb_cmd_burst        (o_icb_cmd_burst)     ,
  .o_icb_cmd_beat         (o_icb_cmd_beat )     ,
  .o_icb_cmd_excl         (o_icb_cmd_excl )     ,
  .o_icb_cmd_lock         (o_icb_cmd_lock )     ,
  .o_icb_cmd_size         (o_icb_cmd_size )     ,
  .o_icb_cmd_usr          (o_icb_cmd_usr  )     ,

  .o_icb_rsp_valid        (o_icb_rsp_valid )     ,
  .o_icb_rsp_ready        (o_icb_rsp_ready )     ,
  .o_icb_rsp_err          (o_icb_rsp_err)        ,
  .o_icb_rsp_excl_ok      (o_icb_rsp_excl_ok)    ,
  .o_icb_rsp_rdata        (o_icb_rsp_rdata )     ,
  .o_icb_rsp_usr          ({USR_W{1'b0}}   )     ,

  .i_bus_icb_cmd_sel_vec  (s18) ,

  .i_bus_icb_cmd_ready    (s2 ) ,
  .i_bus_icb_cmd_valid    (s1 ) ,
  .i_bus_icb_cmd_read     (s4 )  ,
  .i_bus_icb_cmd_addr     (s3 )  ,
  .i_bus_icb_cmd_wdata    (s5 ) ,
  .i_bus_icb_cmd_wmask    (s6)  ,
  .i_bus_icb_cmd_burst    (s7),
  .i_bus_icb_cmd_beat     (s8 ),
  .i_bus_icb_cmd_excl     (s10 ),
  .i_bus_icb_cmd_lock     (s9 ),
  .i_bus_icb_cmd_size     (s11 ),
  .i_bus_icb_cmd_usr      (s12 ),

  .i_bus_icb_rsp_valid    (s13 ) ,
  .i_bus_icb_rsp_ready    (s14 ) ,
  .i_bus_icb_rsp_err      (s15)    ,
  .i_bus_icb_rsp_excl_ok  (s16),
  .i_bus_icb_rsp_rdata    (s17 ) ,
  .i_bus_icb_rsp_usr      () ,

  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );






  wire s19 = o_icb_cmd_usr[USR_PACK_ICACH];
  wire s20 = o_icb_cmd_usr[USR_PACK_DCACH];
  wire s21 = o_icb_cmd_usr[USR_PACK_DEVICE];
  wire s22 = o_icb_cmd_usr[USR_PACK_MMODE];
  wire s23 = o_icb_cmd_usr[USR_PACK_VMODE];
  assign o_icb_cmd_ifu   = o_icb_cmd_usr[USR_PACK_IFU];
  assign o_icb_cmd_seq   = o_icb_cmd_usr[USR_PACK_SEQ];




  assign o_icb_cmd_hprot[0] = (~o_icb_cmd_ifu) | s23;
  assign o_icb_cmd_hprot[1] = s22;
  assign o_icb_cmd_hprot[2] = (~s21);
  assign o_icb_cmd_hprot[3] = (~s21);

  assign o_icb_cmd_attri     = 2'b11;

  assign o_icb_cmd_dmode = o_icb_cmd_usr[USR_PACK_DMODE];

endmodule

