
`include "global.inc"

module n22_biu #(
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
  input                          lock_clear_ena,

  output                         biu_active,
  input                          lsu2biu_icb_cmd_sel,

  input                          lsu2biu_icb_cmd_valid,
  output                         lsu2biu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   lsu2biu_icb_cmd_addr,
  input                          lsu2biu_icb_cmd_read,
  input  [`N22_XLEN-1:0]        lsu2biu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]      lsu2biu_icb_cmd_wmask,
  input  [2:0]                   lsu2biu_icb_cmd_burst,
  input  [1:0]                   lsu2biu_icb_cmd_beat,
  input                          lsu2biu_icb_cmd_lock,
  input                          lsu2biu_icb_cmd_excl,
  input  [1:0]                   lsu2biu_icb_cmd_size,
  input                          lsu2biu_icb_cmd_mmode,
  input                          lsu2biu_icb_cmd_dmode,
  input                          lsu2biu_icb_cmd_device,
  input                          lsu2biu_icb_cmd_x0base,

  output                         lsu2biu_icb_rsp_valid,
  input                          lsu2biu_icb_rsp_ready,
  output                         lsu2biu_icb_rsp_err  ,
  output                         lsu2biu_icb_rsp_excl_ok,
  output [`N22_XLEN-1:0]        lsu2biu_icb_rsp_rdata,

  input                          ifu_icb_cmd_valid,
  output                         ifu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   ifu_icb_cmd_addr,
  input                          ifu_icb_cmd_mmode,
  input                          ifu_icb_cmd_dmode,
  input                          ifu_icb_cmd_device,
  input                          ifu_icb_cmd_vmode,
  input                          ifu_icb_cmd_err,
  input                          ifu_icb_cmd_seq,

  output                         ifu_icb_rsp_valid,
  output                         ifu_icb_rsp_err  ,
  output [`N22_XLEN-1:0]        ifu_icb_rsp_rdata,


  `ifdef N22_HAS_ICACHE
  input                          icach2biu_icb_cmd_valid,
  output                         icach2biu_icb_cmd_ready,
  input    [`N22_ADDR_SIZE-1:0] icach2biu_icb_cmd_addr,
  input                          icach2biu_icb_cmd_read,
  input  [`N22_XLEN-1:0]        icach2biu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]      icach2biu_icb_cmd_wmask,
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


    `ifdef N22_TMR_PRIVATE
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


      `ifdef N22_MEM_TYPE_AHBL

  input               mem_bus_clk_en,
  output [1:0]        mem_ahbl_htrans,
  output              mem_ahbl_hwrite,
  output [`N22_ADDR_SIZE    -1:0] mem_ahbl_haddr,
  output [2:0]        mem_ahbl_hsize,
  output [3:0]        mem_ahbl_hprot,
  output [1:0]        mem_ahbl_hattri,
  output [1:0]        mem_ahbl_master,
  output              mem_ahbl_hlock,
        `ifdef N22_HAS_AMO
  output              mem_ahbl_hexcl,
        `endif
  output [2:0]        mem_ahbl_hburst,
  output [`N22_XLEN    -1:0] mem_ahbl_hwdata,
  input  [`N22_XLEN    -1:0] mem_ahbl_hrdata,
  input  [1:0]        mem_ahbl_hresp,
        `ifdef N22_HAS_AMO
  input               mem_ahbl_hresp_exok,
        `endif
  input               mem_ahbl_hready,
      `endif


  input  clk,
  input  rst_n
  );



    `ifdef N22_HAS_CLIC
  wire [`N22_ADDR_SIZE-1:0] s0 = N22_CLIC_BASE_ADDR;
    `endif


    `ifdef N22_TMR_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] s1 = N22_TMR_BASE_ADDR;
    `endif

    `ifdef N22_HAS_DEBUG_PRIVATE
  wire                         s2;
  wire                         s3;
  wire [`N22_ADDR_SIZE-1:0]   s4;
  wire                         s5;
  wire [`N22_XLEN-1:0]        s6;
  wire [`N22_XLEN_MW-1:0]     s7;
  wire [2:0]                   s8;
  wire [1:0]                   s9;
  wire                         s10;
  wire                         s11;
  wire [1:0]                   s12;
  wire                         s13;
  wire                         s14;
  wire                         s15;
  wire                         s16;
  wire                         s17;
  wire                         s18    ;
  wire                         s19;
  wire [`N22_XLEN-1:0]        s20;

  `endif



  wire                         s21;
  wire                         s22;
  wire [`N22_ADDR_SIZE-1:0]   s23;
  wire                         s24;
  wire [`N22_XLEN-1:0]        s25;
  wire [`N22_XLEN_MW-1:0]      s26;
  wire [2:0]                   s27;
  wire [1:0]                   s28;
  wire                         s29;
  wire                         s30;
  wire [1:0]                   s31;
  wire                         s32;
  wire                         s33;
  wire                         s34;
  wire                         s35;
  wire                         s36;

  wire                         s37;
  wire                         s38;
  wire                         s39  ;
  wire                         s40;
  wire [`N22_XLEN-1:0]        s41;





  assign s21 = ifu_icb_cmd_valid;
  assign ifu_icb_cmd_ready = s22;

  assign s23   = ifu_icb_cmd_addr  ;
  assign s32  = ifu_icb_cmd_mmode ;
  assign s33  = ifu_icb_cmd_dmode ;
  assign s34  = ifu_icb_cmd_device ;
  assign s35  = ifu_icb_cmd_vmode ;
  assign s36    = ifu_icb_cmd_err;
  wire   s42    = ifu_icb_cmd_seq;

  assign s24   = 1'b1;
  assign s25  = {`N22_XLEN{1'b0}};
  assign s26  = {`N22_XLEN_MW{1'b0}};
  assign s27  = `N22_IFU2BIU_BURST_TYPE;
  assign s28   = 2'b0;
  assign s29   = 1'b0;
  assign s30   = 1'b0;
  assign s31   = `N22_IFU2BIU_SIZE_TYPE;

  assign ifu_icb_rsp_valid   = s37  ;
  assign s38   = 1'b1  ;
  assign ifu_icb_rsp_err     = s39    ;
  assign ifu_icb_rsp_rdata   = s41  ;





      localparam BIU_ARBT_I_NUM = 2;
      localparam BIU_ARBT_I_PTR_W = 1;


      localparam BIU_SPLT_I_NUM_0 = 1;

  `ifdef N22_IFU_NO_CHCK
      localparam BIU_SPLT_I_NUM_1 = BIU_SPLT_I_NUM_0;
  `else
      localparam BIU_SPLT_I_NUM_1 = BIU_SPLT_I_NUM_0 + 1;
  `endif

  `ifdef N22_HAS_DEBUG_PRIVATE
      localparam BIU_SPLT_I_NUM   = BIU_SPLT_I_NUM_1 + 1;
  `endif

  `ifndef N22_HAS_DEBUG_PRIVATE
      localparam BIU_SPLT_I_NUM   = BIU_SPLT_I_NUM_1;
  `endif

  `ifndef N22_IFU_NO_CHCK
  wire                         s43;
  wire                         s44;
  wire [`N22_ADDR_SIZE-1:0]   s45;
  wire                         s46;
  wire [3-1:0]                 s47;
  wire [2-1:0]                 s48;
  wire [`N22_XLEN-1:0]        s49;
  wire [`N22_XLEN_MW-1:0]     s50;
  wire                         s51;
  wire                         s52;
  wire [1:0]                   s53;
  wire                         s54;
  wire                         s55;
  wire                         s56;

  wire                         s57;
  wire                         s58;
  wire                         s59  ;
  wire                         s60;
  wire [`N22_XLEN-1:0]        s61;
  `endif

  localparam USR_W = 10;
  localparam USR_PACK_X0BASE = 0;
  localparam USR_PACK_DEVICE = 1;
  localparam USR_PACK_DMODE  = 2;
  localparam USR_PACK_MMODE  = 3;
  localparam USR_PACK_VMODE  = 4;
  localparam USR_PACK_IFU    = 5;
  localparam USR_PACK_ICACH  = 6;
  localparam USR_PACK_DCACH  = 7;
  localparam USR_PACK_ERR = 8;
  localparam USR_PACK_SEQ = 9;

  wire                         mem_icb_cmd_valid;
  wire                         mem_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   mem_icb_cmd_addr;
  wire                         mem_icb_cmd_read;
  wire [`N22_XLEN-1:0]        mem_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]     mem_icb_cmd_wmask;
  wire [2:0]                   mem_icb_cmd_burst;
  wire [1:0]                   mem_icb_cmd_beat;
  wire                         mem_icb_cmd_lock;
  wire                         mem_icb_cmd_excl;
  wire [1:0]                   mem_icb_cmd_size;
  wire [USR_W-1:0]             mem_icb_cmd_usr;

  wire                         mem_icb_rsp_valid;
  wire                         mem_icb_rsp_ready;
  wire                         mem_icb_rsp_err  ;
  wire                         mem_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0]        mem_icb_rsp_rdata;


  wire [USR_W-1:0] s62;
  assign s62[USR_PACK_X0BASE] = 1'b0;
  assign s62[USR_PACK_DEVICE ] = s34;
  assign s62[USR_PACK_DMODE ] = s33;
  assign s62[USR_PACK_MMODE ] = s32;
  assign s62[USR_PACK_VMODE ] = s35;
  assign s62[USR_PACK_IFU   ] = 1'b1;
  assign s62[USR_PACK_ICACH ] = 1'b0;
  assign s62[USR_PACK_DCACH ] = 1'b0;
  assign s62[USR_PACK_ERR] = s36;
  assign s62[USR_PACK_SEQ] = s42;

  wire [USR_W-1:0] s63;
  assign s63[USR_PACK_X0BASE] = lsu2biu_icb_cmd_x0base;
  assign s63[USR_PACK_DEVICE ] = lsu2biu_icb_cmd_device;
  assign s63[USR_PACK_DMODE ] = lsu2biu_icb_cmd_dmode;
  assign s63[USR_PACK_MMODE ] = lsu2biu_icb_cmd_mmode;
  assign s63[USR_PACK_VMODE ] = 1'b0;
  assign s63[USR_PACK_IFU   ] = 1'b0;
  assign s63[USR_PACK_ICACH ] = 1'b0;
  assign s63[USR_PACK_DCACH ] = 1'b0;
  assign s63[USR_PACK_ERR] = 1'b0;
  assign s63[USR_PACK_SEQ] = 1'b0;

  wire s64;
  wire s65;
  wire [`N22_ADDR_SIZE-1:0] s66;
  wire s67;
  wire [`N22_XLEN-1:0] s68;
  wire [`N22_XLEN_MW-1:0] s69;
  wire [2:0] s70;
  wire [1:0] s71;
  wire s72;
  wire s73;
  wire [1:0] s74;
  wire [USR_W-1:0] s75;


  wire s76;
  wire s77;
  wire s78;
  wire s79;
  wire [`N22_XLEN-1:0] s80;

  wire [BIU_ARBT_I_NUM*1-1:0] s81;
  wire [BIU_ARBT_I_NUM*1-1:0] s82;
  wire [BIU_ARBT_I_NUM*`N22_ADDR_SIZE-1:0] s83;
  wire [BIU_ARBT_I_NUM*1-1:0] s84;
  wire [BIU_ARBT_I_NUM*`N22_XLEN-1:0] s85;
  wire [BIU_ARBT_I_NUM*`N22_XLEN_MW-1:0] s86;
  wire [BIU_ARBT_I_NUM*3-1:0] s87;
  wire [BIU_ARBT_I_NUM*2-1:0] s88;
  wire [BIU_ARBT_I_NUM*1-1:0] s89;
  wire [BIU_ARBT_I_NUM*1-1:0] s90;
  wire [BIU_ARBT_I_NUM*2-1:0] s91;
  wire [BIU_ARBT_I_NUM*USR_W-1:0] s92;

  wire [BIU_ARBT_I_NUM*1-1:0] s93;
  wire [BIU_ARBT_I_NUM*1-1:0] s94;
  wire [BIU_ARBT_I_NUM*1-1:0] s95;
  wire [BIU_ARBT_I_NUM*1-1:0] s96;
  wire [BIU_ARBT_I_NUM*`N22_XLEN-1:0] s97;

  assign s81 =
                           {
                             s21,
                             lsu2biu_icb_cmd_valid
                           } ;

  wire[BIU_ARBT_I_NUM-1:0] s98 =
                           {
                             (~lsu2biu_icb_cmd_sel)
                             , lsu2biu_icb_cmd_sel
                           } ;

  assign s83 =
                           {
                             s23,
                             lsu2biu_icb_cmd_addr
                           } ;

  assign s84 =
                           {
                             s24,
                             lsu2biu_icb_cmd_read
                           } ;

  assign s85 =
                           {
                             s25,
                             lsu2biu_icb_cmd_wdata
                           } ;

  assign s86 =
                           {
                             s26,
                             lsu2biu_icb_cmd_wmask
                           } ;

  assign s87 =
                           {
                             s27,
                             lsu2biu_icb_cmd_burst
                           } ;

  assign s88 =
                           {
                             s28,
                             lsu2biu_icb_cmd_beat
                           } ;

  assign s89 =
                           {
                             s29,
                             lsu2biu_icb_cmd_lock
                           } ;

  assign s90 =
                           {
                             s30,
                             lsu2biu_icb_cmd_excl
                           } ;

  assign s91 =
                           {
                             s31,
                             lsu2biu_icb_cmd_size
                           } ;

 assign s92 =
                           {
                             s62,
                             s63
                           } ;

  assign                   {
                             s22,
                             lsu2biu_icb_cmd_ready
                           } = s82;

  assign                   {
                             s37,
                             lsu2biu_icb_rsp_valid
                           } = s93;

  assign                   {
                             s39,
                             lsu2biu_icb_rsp_err
                           } = s95;

  assign                   {
                             s40,
                             lsu2biu_icb_rsp_excl_ok
                           } = s96;

  assign                   {
                             s41,
                             lsu2biu_icb_rsp_rdata
                           } = s97;

  assign s94 = {
                             s38,
                             lsu2biu_icb_rsp_ready
                           };

  wire s99;

  n22_gnrl_icb_arbt # (
  .ALLOW_BURST (0),

  .ARBT_SCHEME (3),
  .FIFO_CUT_READY  (0),
  .ALLOW_0CYCL_RSP (0),
  .FIFO_OUTS_NUM   (`N22_BIU_OUTS_NUM),
  .ARBT_NUM   (BIU_ARBT_I_NUM),
  .ARBT_PTR_W (BIU_ARBT_I_PTR_W),
  .USR_W      (USR_W),
  .AW         (`N22_ADDR_SIZE),
  .DW         (`N22_XLEN)
  ) u_biu_icb_arbt(
  .arbt_active            (s99),
  .o_icb_cmd_valid        (s64 )     ,
  .o_icb_cmd_ready        (s65 )     ,
  .o_icb_cmd_read         (s67 )      ,
  .o_icb_cmd_addr         (s66 )      ,
  .o_icb_cmd_wdata        (s68 )     ,
  .o_icb_cmd_wmask        (s69)      ,
  .o_icb_cmd_burst        (s70)     ,
  .o_icb_cmd_beat         (s71 )     ,
  .o_icb_cmd_excl         (s73 )     ,
  .o_icb_cmd_lock         (s72 )     ,
  .o_icb_cmd_size         (s74 )     ,
  .o_icb_cmd_usr          (s75  )     ,

  .o_icb_rsp_valid        (s76 )     ,
  .o_icb_rsp_ready        (s77 )     ,
  .o_icb_rsp_err          (s78)        ,
  .o_icb_rsp_excl_ok      (s79)    ,
  .o_icb_rsp_rdata        (s80 )     ,
  .o_icb_rsp_usr          ({USR_W{1'b0}}   )     ,

  .i_bus_icb_cmd_sel_vec  (s98) ,

  .i_bus_icb_cmd_ready    (s82 ) ,
  .i_bus_icb_cmd_valid    (s81 ) ,
  .i_bus_icb_cmd_read     (s84 )  ,
  .i_bus_icb_cmd_addr     (s83 )  ,
  .i_bus_icb_cmd_wdata    (s85 ) ,
  .i_bus_icb_cmd_wmask    (s86)  ,
  .i_bus_icb_cmd_burst    (s87),
  .i_bus_icb_cmd_beat     (s88 ),
  .i_bus_icb_cmd_excl     (s90 ),
  .i_bus_icb_cmd_lock     (s89 ),
  .i_bus_icb_cmd_size     (s91 ),
  .i_bus_icb_cmd_usr      (s92 ),

  .i_bus_icb_rsp_valid    (s93 ) ,
  .i_bus_icb_rsp_ready    (s94 ) ,
  .i_bus_icb_rsp_err      (s95)    ,
  .i_bus_icb_rsp_excl_ok  (s96),
  .i_bus_icb_rsp_rdata    (s97 ) ,
  .i_bus_icb_rsp_usr      () ,

  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );


  wire s100;
  wire s101;
  wire [`N22_ADDR_SIZE-1:0] s102;
  wire s103;
  wire [`N22_XLEN-1:0] s104;
  wire [`N22_XLEN_MW-1:0] s105;
  wire [2:0] s106;
  wire [1:0] s107;
  wire s108;
  wire s109;
  wire [1:0] s110;
  wire [USR_W-1:0] s111;

  wire s112 = s111[USR_PACK_X0BASE];
  wire s113 = s111[USR_PACK_DEVICE];
  wire s114 = s111[USR_PACK_DMODE];
  wire s115 = s111[USR_PACK_MMODE];
  wire s116 = s111[USR_PACK_VMODE];
  wire s117 = s111[USR_PACK_IFU];
  wire s118 = s111[USR_PACK_ERR];

  wire s119;
  wire s120;
  wire s121;
  wire s122;
  wire [`N22_XLEN-1:0] s123;

  wire icb_buffer_active;

  n22_gnrl_icb_buffer # (
    .OUTS_CNT_W   (`N22_BIU_OUTS_CNT_W),
    .AW    (`N22_ADDR_SIZE),
    .DW    (`N22_XLEN),

  `ifdef N22_MEM_CMD_ADD_FLOP
      .CMD_DP(1),

    .CMD_MSKO(1),
  `else
    .CMD_DP(0),
  `endif

  `ifdef N22_MEM_RSP_ADD_FLOP
      .RSP_DP(1),

  `else
    .RSP_DP(0),
  `endif
    .RSP_ALWAYS_READY (0),
    .CMD_CUT_READY (0),
    .RSP_CUT_READY (0),
    .USR_W (USR_W)
  )u_biu_icb_buffer(
    .bus_clk_en             (mem_bus_clk_en),

    .icb_buffer_active      (icb_buffer_active),
    .i_icb_cmd_valid        (s64),
    .i_icb_cmd_ready        (s65),
    .i_icb_cmd_read         (s67 ),
    .i_icb_cmd_addr         (s66 ),
    .i_icb_cmd_wdata        (s68),
    .i_icb_cmd_wmask        (s69),
    .i_icb_cmd_lock         (s72 ),
    .i_icb_cmd_excl         (s73 ),
    .i_icb_cmd_size         (s74 ),
    .i_icb_cmd_burst        (s70),
    .i_icb_cmd_beat         (s71 ),
    .i_icb_cmd_usr          (s75  ),

    .i_icb_rsp_valid        (s76),
    .i_icb_rsp_ready        (s77),
    .i_icb_rsp_err          (s78  ),
    .i_icb_rsp_excl_ok      (s79),
    .i_icb_rsp_rdata        (s80),
    .i_icb_rsp_usr          (),

    .o_icb_cmd_valid        (s100),
    .o_icb_cmd_ready        (s101),
    .o_icb_cmd_read         (s103 ),
    .o_icb_cmd_addr         (s102 ),
    .o_icb_cmd_wdata        (s104),
    .o_icb_cmd_wmask        (s105),
    .o_icb_cmd_lock         (s108 ),
    .o_icb_cmd_excl         (s109 ),
    .o_icb_cmd_size         (s110 ),
    .o_icb_cmd_burst        (s106),
    .o_icb_cmd_beat         (s107 ),
    .o_icb_cmd_usr          (s111),

    .o_icb_rsp_valid        (s119),
    .o_icb_rsp_ready        (s120),
    .o_icb_rsp_err          (s121  ),
    .o_icb_rsp_excl_ok      (s122),
    .o_icb_rsp_rdata        (s123),
    .o_icb_rsp_usr          ({USR_W{1'b0}}  ),

    .clk                    (clk  ),
    .rst_n                  (rst_n)
  );

  `ifndef N22_IFU_NO_CHCK
  wire [USR_W-1:0] s124;
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
  wire [USR_W-1:0] s125;
  `endif



  `ifndef N22_IFU_NO_CHCK
  assign s55 = s124[USR_PACK_DMODE];
  assign s54 = s124[USR_PACK_MMODE];
  assign s56 = 1'b0;
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
  assign s14 = s125[USR_PACK_DMODE];
  assign s13 = s125[USR_PACK_MMODE];
  assign s15 = 1'b0;
  `endif

  wire [BIU_SPLT_I_NUM*1-1:0] s126;
  wire [BIU_SPLT_I_NUM*1-1:0] s127;
  wire [BIU_SPLT_I_NUM*`N22_ADDR_SIZE-1:0] s128;
  wire [BIU_SPLT_I_NUM*1-1:0] s129;
  wire [BIU_SPLT_I_NUM*`N22_XLEN-1:0] s130;
  wire [BIU_SPLT_I_NUM*`N22_XLEN_MW-1:0] s131;
  wire [BIU_SPLT_I_NUM*3-1:0] s132;
  wire [BIU_SPLT_I_NUM*2-1:0] s133;
  wire [BIU_SPLT_I_NUM*1-1:0] s134;
  wire [BIU_SPLT_I_NUM*1-1:0] s135;
  wire [BIU_SPLT_I_NUM*2-1:0] s136;
  wire [BIU_SPLT_I_NUM*USR_W-1:0] s137;

  wire [BIU_SPLT_I_NUM*1-1:0] s138;
  wire [BIU_SPLT_I_NUM*1-1:0] s139;
  wire [BIU_SPLT_I_NUM*1-1:0] s140;
  wire [BIU_SPLT_I_NUM*1-1:0] s141;
  wire [BIU_SPLT_I_NUM*`N22_XLEN-1:0] s142;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s43,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s2,
  `endif
                             mem_icb_cmd_valid
                           } = s126;


  assign {
  `ifndef N22_IFU_NO_CHCK
                             s45,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s4,
  `endif
                             mem_icb_cmd_addr
                           } = s128;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s46,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s5,
  `endif
                             mem_icb_cmd_read
                           } = s129;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s49,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s6,
  `endif
                             mem_icb_cmd_wdata
                           } = s130;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s50,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s7,
  `endif
                             mem_icb_cmd_wmask
                           } = s131;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s47,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s8,
  `endif
                             mem_icb_cmd_burst
                           } = s132;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s48,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s9,
  `endif
                             mem_icb_cmd_beat
                           } = s133;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s51,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s10,
  `endif
                             mem_icb_cmd_lock
                           } = s134;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s52,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s11,
  `endif
                             mem_icb_cmd_excl
                           } = s135;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s53,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s12,
  `endif
                             mem_icb_cmd_size
                           } = s136;

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s124,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s125,
  `endif
                             mem_icb_cmd_usr
                           } = s137;

  assign s127 = {
  `ifndef N22_IFU_NO_CHCK
                             s44,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s3,
  `endif
                             mem_icb_cmd_ready
                           };

  assign s138 = {
  `ifndef N22_IFU_NO_CHCK
                             s57,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s16,
  `endif
                             mem_icb_rsp_valid
                           };

  assign s140 = {
  `ifndef N22_IFU_NO_CHCK
                             s59,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s18,
  `endif
                             mem_icb_rsp_err
                           };

  assign s141 = {
  `ifndef N22_IFU_NO_CHCK
                             s60,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s19,
  `endif
                             mem_icb_rsp_excl_ok
                           };

  assign s142 = {
  `ifndef N22_IFU_NO_CHCK
                             s61,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s20,
  `endif
                             mem_icb_rsp_rdata
                           };

  assign {
  `ifndef N22_IFU_NO_CHCK
                             s58,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s17,
  `endif
                             mem_icb_rsp_ready
                           } = s139;


  `ifndef N22_IFU_NO_CHCK
  wire s143 =
                              s118
                          ;
  `endif


  `ifdef N22_HAS_DEBUG_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] s144 = N22_DEBUG_BASE_ADDR;
  wire s145 = s114 & (s102[`N22_DEBUG_BASE_REGION] ==  s144[`N22_DEBUG_BASE_REGION]);
  wire s146 = s145
                      `ifndef N22_IFU_NO_CHCK
                             & (~s143)
                      `endif
                      ;
  `endif

    `ifndef N22_HAS_DEBUG_PRIVATE
  wire s145 = 1'b0;
  wire s146 = 1'b0;
    `endif




  wire s147 =
                             (~s146)
                      `ifndef N22_IFU_NO_CHCK
                             & (~s143)
                      `endif
                             ;

  wire [BIU_SPLT_I_NUM-1:0] s148 =
      {
  `ifndef N22_IFU_NO_CHCK
                             s143,
  `endif
  `ifdef N22_HAS_DEBUG_PRIVATE
                             s146,
  `endif
                             s147
      };

  n22_gnrl_icb_splt # (
  .USE_ALL_READY(1),
  .ALLOW_DIFF (1),
  .VLD_MSK_PAYLOAD(0),
  .ALLOW_0CYCL_RSP (0),
  .FIFO_OUTS_NUM   (`N22_BIU_OUTS_NUM),
  .FIFO_CUT_READY  (0),
  .SPLT_NUM   (BIU_SPLT_I_NUM),
  .SPLT_PTR_W (BIU_SPLT_I_NUM),
  .SPLT_PTR_1HOT (1),
  .USR_W      (USR_W),
  .AW         (`N22_ADDR_SIZE),
  .DW         (`N22_XLEN)
  ) u_biu_icb_splt(
  .i_icb_splt_indic       (s148),

  .i_icb_cmd_valid        (s100 )     ,
  .i_icb_cmd_ready        (s101 )     ,
  .i_icb_cmd_read         (s103 )      ,
  .i_icb_cmd_addr         (s102 )      ,
  .i_icb_cmd_wdata        (s104 )     ,
  .i_icb_cmd_wmask        (s105)      ,
  .i_icb_cmd_burst        (s106)     ,
  .i_icb_cmd_beat         (s107 )     ,
  .i_icb_cmd_excl         (s109 )     ,
  .i_icb_cmd_lock         (s108 )     ,
  .i_icb_cmd_size         (s110 )     ,
  .i_icb_cmd_usr          (s111  )     ,

  .i_icb_rsp_valid        (s119 )     ,
  .i_icb_rsp_ready        (s120 )     ,
  .i_icb_rsp_err          (s121)        ,
  .i_icb_rsp_excl_ok      (s122)    ,
  .i_icb_rsp_rdata        (s123 )     ,
  .i_icb_rsp_usr          ( )     ,

  .o_bus_icb_cmd_ready    (s127 ) ,
  .o_bus_icb_cmd_valid    (s126 ) ,
  .o_bus_icb_cmd_read     (s129 )  ,
  .o_bus_icb_cmd_addr     (s128 )  ,
  .o_bus_icb_cmd_wdata    (s130 ) ,
  .o_bus_icb_cmd_wmask    (s131)  ,
  .o_bus_icb_cmd_burst    (s132),
  .o_bus_icb_cmd_beat     (s133 ),
  .o_bus_icb_cmd_excl     (s135 ),
  .o_bus_icb_cmd_lock     (s134 ),
  .o_bus_icb_cmd_size     (s136 ),
  .o_bus_icb_cmd_usr      (s137  ),

  .o_bus_icb_rsp_valid    (s138 ) ,
  .o_bus_icb_rsp_ready    (s139 ) ,
  .o_bus_icb_rsp_err      (s140)    ,
  .o_bus_icb_rsp_excl_ok  (s141),
  .o_bus_icb_rsp_rdata    (s142 ) ,
  .o_bus_icb_rsp_usr      ({BIU_SPLT_I_NUM*USR_W{1'b0}}) ,

  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );


  wire s149;
  wire cach_arbt_active;

  assign biu_active =
      cach_arbt_active |
      s99 |
      s21 |
      lsu2biu_icb_cmd_valid | icb_buffer_active |
      s149;

  `ifndef N22_IFU_NO_CHCK
  n22_gnrl_fifo # (
        .CUT_READY (1),
        .MSKO      (0),
        .DP  (1),
        .DW  (1)
  ) u_err_icb_rsp_fifo (
        .i_vld(s43),
        .i_rdy(s44),
        .i_dat(1'b0),
        .o_vld(s57),
        .o_rdy(s58),
        .o_dat(),

        .clk  (clk),
        .rst_n(rst_n)
  );


  assign  s59   = 1'b1;
  assign  s60 = 1'b0;
  assign  s61   = {`N22_XLEN{1'b0}};
  `endif

  wire                         o_icb_cmd_valid;
  wire                         o_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   o_icb_cmd_addr;
  wire                         o_icb_cmd_read;
  wire [`N22_XLEN-1:0]        o_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]     o_icb_cmd_wmask;
  wire [2:0]                   o_icb_cmd_burst;
  wire [1:0]                   o_icb_cmd_beat;
  wire                         o_icb_cmd_lock;
  wire                         o_icb_cmd_excl;
  wire [1:0]                   o_icb_cmd_size;
  wire [3:0]                   o_icb_cmd_hprot;
  wire [1:0]                   o_icb_cmd_attri;
  wire                         o_icb_cmd_dmode;
  wire                         o_icb_cmd_ifu;
  wire                         o_icb_cmd_seq;

  wire                         o_icb_rsp_valid;
  wire                         o_icb_rsp_ready;
  wire                         o_icb_rsp_err  ;
  wire                         o_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0]        o_icb_rsp_rdata;

  n22_biu_cach_arbt #(
    .USR_W          (USR_W          ),
    .USR_PACK_X0BASE(USR_PACK_X0BASE),
    .USR_PACK_DEVICE (USR_PACK_DEVICE ),
    .USR_PACK_DMODE (USR_PACK_DMODE ),
    .USR_PACK_MMODE (USR_PACK_MMODE ),
    .USR_PACK_VMODE (USR_PACK_VMODE ),
    .USR_PACK_IFU   (USR_PACK_IFU   ),
    .USR_PACK_ICACH (USR_PACK_ICACH ),
    .USR_PACK_DCACH (USR_PACK_DCACH ),
    .USR_PACK_ERR   (USR_PACK_ERR   )
  ) u_n22_biu_cach_arbt (

    .cach_arbt_active     (cach_arbt_active   ),

    .mem_icb_cmd_valid     (mem_icb_cmd_valid),
    .mem_icb_cmd_ready     (mem_icb_cmd_ready),
    .mem_icb_cmd_read      (mem_icb_cmd_read ),
    .mem_icb_cmd_addr      (mem_icb_cmd_addr ),
    .mem_icb_cmd_wdata     (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask     (mem_icb_cmd_wmask),
    .mem_icb_cmd_size      (mem_icb_cmd_size ),
    .mem_icb_cmd_lock      (mem_icb_cmd_lock ),
    .mem_icb_cmd_excl      (mem_icb_cmd_excl ),
    .mem_icb_cmd_burst     (mem_icb_cmd_burst),
    .mem_icb_cmd_beat      (mem_icb_cmd_beat ),
    .mem_icb_cmd_usr       (mem_icb_cmd_usr),

    .mem_icb_rsp_valid     (mem_icb_rsp_valid),
    .mem_icb_rsp_ready     (mem_icb_rsp_ready),
    .mem_icb_rsp_err       (mem_icb_rsp_err  ),
    .mem_icb_rsp_excl_ok   (mem_icb_rsp_excl_ok  ),
    .mem_icb_rsp_rdata     (mem_icb_rsp_rdata),

    `ifdef N22_HAS_ICACHE
    .icach2biu_icb_cmd_valid  (icach2biu_icb_cmd_valid  ),
    .icach2biu_icb_cmd_ready  (icach2biu_icb_cmd_ready  ),
    .icach2biu_icb_cmd_addr   (icach2biu_icb_cmd_addr   ),
    .icach2biu_icb_cmd_read   (icach2biu_icb_cmd_read   ),
    .icach2biu_icb_cmd_wdata  (icach2biu_icb_cmd_wdata  ),
    .icach2biu_icb_cmd_wmask  (icach2biu_icb_cmd_wmask  ),
    .icach2biu_icb_cmd_burst  (icach2biu_icb_cmd_burst  ),
    .icach2biu_icb_cmd_beat   (icach2biu_icb_cmd_beat   ),
    .icach2biu_icb_cmd_lock   (icach2biu_icb_cmd_lock   ),
    .icach2biu_icb_cmd_excl   (icach2biu_icb_cmd_excl   ),
    .icach2biu_icb_cmd_size   (icach2biu_icb_cmd_size   ),
    .icach2biu_icb_cmd_mmode  (icach2biu_icb_cmd_mmode  ),
    .icach2biu_icb_cmd_vmode  (icach2biu_icb_cmd_vmode  ),
    .icach2biu_icb_cmd_dmode  (icach2biu_icb_cmd_dmode  ),

    .icach2biu_icb_rsp_valid  (icach2biu_icb_rsp_valid  ),
    .icach2biu_icb_rsp_ready  (icach2biu_icb_rsp_ready  ),
    .icach2biu_icb_rsp_err    (icach2biu_icb_rsp_err    ),
    .icach2biu_icb_rsp_excl_ok(icach2biu_icb_rsp_excl_ok),
    .icach2biu_icb_rsp_rdata  (icach2biu_icb_rsp_rdata  ),
    `endif


    .o_icb_cmd_valid     (o_icb_cmd_valid),
    .o_icb_cmd_ready     (o_icb_cmd_ready),
    .o_icb_cmd_read      (o_icb_cmd_read ),
    .o_icb_cmd_addr      (o_icb_cmd_addr ),
    .o_icb_cmd_wdata     (o_icb_cmd_wdata),
    .o_icb_cmd_wmask     (o_icb_cmd_wmask),
    .o_icb_cmd_size      (o_icb_cmd_size ),
    .o_icb_cmd_lock      (o_icb_cmd_lock ),
    .o_icb_cmd_excl      (o_icb_cmd_excl ),
    .o_icb_cmd_burst     (o_icb_cmd_burst),
    .o_icb_cmd_beat      (o_icb_cmd_beat ),
    .o_icb_cmd_hprot     (o_icb_cmd_hprot),
    .o_icb_cmd_attri     (o_icb_cmd_attri),
    .o_icb_cmd_dmode     (o_icb_cmd_dmode),
    .o_icb_cmd_ifu       (o_icb_cmd_ifu),
    .o_icb_cmd_seq       (o_icb_cmd_seq),

    .o_icb_rsp_valid     (o_icb_rsp_valid),
    .o_icb_rsp_ready     (o_icb_rsp_ready),
    .o_icb_rsp_err       (o_icb_rsp_err  ),
    .o_icb_rsp_excl_ok   (o_icb_rsp_excl_ok  ),
    .o_icb_rsp_rdata     (o_icb_rsp_rdata),


    .clk               (clk  ),
    .rst_n             (rst_n)
  );






      `ifdef N22_MEM_TYPE_AHBL
        `ifndef N22_HAS_AMO
  wire mem_ahbl_hexcl;
  wire mem_ahbl_hresp_exok = 1'b0;
        `endif
  n22_gnrl_icb2ahbl

  #(
       `ifdef N22_HAS_AMO
       .SUPPORT_LOCK     (1),
       `endif

       `ifndef N22_HAS_AMO
       .SUPPORT_LOCK     (0),
       `endif

       `ifdef N22_HAS_CACHE
       .SUPPORT_BURST    (1),
       `endif

       `ifndef N22_HAS_CACHE
       .SUPPORT_BURST    (0),
       `endif

      .AW(`N22_ADDR_SIZE),
      .DW(`N22_XLEN)
    ) u_mem_icb2ahbl(
    .bus_clk_en        (mem_bus_clk_en),

    .icb2ahbl_pend_active(s149),

    .lock_clear_ena    (lock_clear_ena),

    .icb_cmd_valid     (o_icb_cmd_valid),
    .icb_cmd_ready     (o_icb_cmd_ready),
    .icb_cmd_read      (o_icb_cmd_read ),
    .icb_cmd_addr      (o_icb_cmd_addr ),
    .icb_cmd_wdata     (o_icb_cmd_wdata),
    .icb_cmd_wmask     (o_icb_cmd_wmask),
    .icb_cmd_size      (o_icb_cmd_size ),
    .icb_cmd_lock      (o_icb_cmd_lock ),
    .icb_cmd_excl      (o_icb_cmd_excl ),
    .icb_cmd_burst     (o_icb_cmd_burst),
    .icb_cmd_beat      (o_icb_cmd_beat ),
    .icb_cmd_hprot     (o_icb_cmd_hprot),
    .icb_cmd_attri     (o_icb_cmd_attri),
    .icb_cmd_dmode     (o_icb_cmd_dmode),

    .icb_rsp_valid     (o_icb_rsp_valid),
    .icb_rsp_err       (o_icb_rsp_err  ),
    .icb_rsp_excl_ok   (o_icb_rsp_excl_ok  ),
    .icb_rsp_rdata     (o_icb_rsp_rdata),

    .ahbl_htrans       (mem_ahbl_htrans  ),
    .ahbl_hwrite       (mem_ahbl_hwrite  ),
    .ahbl_haddr        (mem_ahbl_haddr   ),
    .ahbl_hsize        (mem_ahbl_hsize   ),
    .ahbl_hlock        (mem_ahbl_hlock   ),
    .ahbl_hexcl        (mem_ahbl_hexcl   ),
    .ahbl_hburst       (mem_ahbl_hburst  ),
    .ahbl_hwdata       (mem_ahbl_hwdata  ),
    .ahbl_hprot        (mem_ahbl_hprot   ),
    .ahbl_hattri       (mem_ahbl_hattri  ),
    .ahbl_master       (mem_ahbl_master  ),
    .ahbl_hrdata       (mem_ahbl_hrdata  ),
    .ahbl_hresp        (mem_ahbl_hresp   ),
    .ahbl_hresp_exok   (mem_ahbl_hresp_exok   ),
    .ahbl_hready       (mem_ahbl_hready  ),

    .clk               (clk  ),
    .rst_n             (rst_n)
  );
    `endif


    `ifdef N22_HAS_DEBUG_PRIVATE
  n22_gnrl_icb2ahbl

  #(
      .SUPPORT_LOCK     (0),
      .SUPPORT_BURST    (0),
      .AW(`N22_ADDR_SIZE),
      .DW(`N22_XLEN)
    ) u_dm_icb2ahbl(
    .icb2ahbl_pend_active(),
    .bus_clk_en        (1'b1),
    .lock_clear_ena    (1'b0),
    .icb_cmd_valid     (s2),
    .icb_cmd_ready     (s3),
    .icb_cmd_read      (s5 ),
    .icb_cmd_addr      (s4 ),
    .icb_cmd_wdata     (s6),
    .icb_cmd_wmask     (`N22_XLEN_MW'b0),
    .icb_cmd_size      (2'b10 ),
    .icb_cmd_lock      (1'b0 ),
    .icb_cmd_excl      (1'b0 ),
    .icb_cmd_burst     (3'b0),
    .icb_cmd_beat      (2'b0 ),
    .icb_cmd_hprot     (4'b0),
    .icb_cmd_attri     (2'b0),
    .icb_cmd_dmode     (1'b0),


    .icb_rsp_valid     (s16),
    .icb_rsp_err       (s18    ),
    .icb_rsp_excl_ok   (s19),
    .icb_rsp_rdata     (s20),

    .ahbl_htrans       (dm_ahbl_htrans  ),
    .ahbl_hwrite       (dm_ahbl_hwrite  ),
    .ahbl_haddr        (dm_ahbl_haddr   ),
    .ahbl_hsize        (dm_ahbl_hsize   ),
    .ahbl_hlock        (),
    .ahbl_hexcl        (),
    .ahbl_hburst       (dm_ahbl_hburst),
    .ahbl_hwdata       (dm_ahbl_hwdata  ),
    .ahbl_hprot        (dm_ahbl_hprot),
    .ahbl_hattri       (),
    .ahbl_master       (),
    .ahbl_hrdata       (dm_ahbl_hrdata  ),
    .ahbl_hresp        (dm_ahbl_hresp   ),
    .ahbl_hresp_exok   (1'b0   ),
    .ahbl_hready       (dm_ahbl_hready  ),

    .clk               (clk),
    .rst_n             (rst_n)
  );

  wire s150;
  wire s151 = s2 & s3;
  wire s152 = s16 & s17;
  wire s153 = s151 | s152;
  wire s154 = s151 | (~s152);
  n22_gnrl_dfflr #(1) dm_outs_dfflr (s153, s154, s150, clk, rst_n);

  assign dm_ahbl_active = s2 | s150;
    `endif


endmodule

