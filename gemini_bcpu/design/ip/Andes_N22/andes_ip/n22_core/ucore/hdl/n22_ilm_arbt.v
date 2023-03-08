
`include "global.inc"

`ifdef N22_HAS_ILM

module n22_ilm_arbt(

  output                         ilm_arbt_active,

  input                          lsu2ilm_icb_cmd_sel,

  input                          lsu2ilm_icb_cmd_valid,
  output                         lsu2ilm_icb_cmd_ready,
  input  [`N22_ILM_ADDR_WIDTH-1:0]   lsu2ilm_icb_cmd_addr,
  input                          lsu2ilm_icb_cmd_read,
  input  [`N22_XLEN-1:0]        lsu2ilm_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]     lsu2ilm_icb_cmd_wmask,
  input                          lsu2ilm_icb_cmd_lock,
  input                          lsu2ilm_icb_cmd_excl,
  input  [1:0]                   lsu2ilm_icb_cmd_size,
  input                          lsu2ilm_icb_cmd_dmode,
  input                          lsu2ilm_icb_cmd_mmode,

  output                         lsu2ilm_icb_rsp_valid,
  input                          lsu2ilm_icb_rsp_ready,
  output                         lsu2ilm_icb_rsp_err  ,
  output                         lsu2ilm_icb_rsp_excl_ok,
  output [`N22_XLEN-1:0]        lsu2ilm_icb_rsp_rdata,

  input                          ifu_icb_cmd_valid,
  output                         ifu_icb_cmd_ready,
  input  [`N22_ILM_ADDR_WIDTH-1:0]   ifu_icb_cmd_addr,
  input                          ifu_icb_cmd_mmode,
  input                          ifu_icb_cmd_dmode,
  input                          ifu_icb_cmd_vmode,

  output                         ifu_icb_rsp_valid,
  output                         ifu_icb_rsp_err  ,
  output [`N22_XLEN-1:0]        ifu_icb_rsp_rdata,


  output                         ilm_icb_cmd_valid,
  input                          ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ilm_icb_cmd_addr,
  output                         ilm_icb_cmd_read,
  output                         ilm_icb_cmd_mmode,
  output                         ilm_icb_cmd_dmode,
  output                         ilm_icb_cmd_vmode,
  output                         ilm_icb_cmd_instr,
  output [`N22_XLEN-1:0]        ilm_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]     ilm_icb_cmd_wmask,
  output [1:0]                   ilm_icb_cmd_size,

  input                          ilm_icb_rsp_valid,
  input                          ilm_icb_rsp_err  ,
  input  [`N22_XLEN-1:0]        ilm_icb_rsp_rdata,

  input  clk,
  input  rst_n
  );




  wire                         s0;
  wire                         s1;
  wire [`N22_ILM_ADDR_WIDTH-1:0]   s2;
  wire                         s3;
  wire [`N22_XLEN-1:0]        s4;
  wire [`N22_XLEN_MW-1:0]     s5;
  wire                         s6;
  wire                         s7;
  wire [1:0]                   s8;
  wire                         s9;
  wire                         s10;
  wire                         s11;

  wire                         s12;
  wire                         s13;
  wire                         s14  ;
  wire                         s15;
  wire [`N22_XLEN-1:0]        s16;





  assign s0 = ifu_icb_cmd_valid;
  assign ifu_icb_cmd_ready = s1;

  assign s2  = ifu_icb_cmd_addr ;
  assign s9 = ifu_icb_cmd_mmode;
  assign s10 = ifu_icb_cmd_dmode;
  assign s11 = ifu_icb_cmd_vmode;
  assign s3   = 1'b1;
  assign s4  = {`N22_XLEN{1'b0}};
  assign s5  = {`N22_XLEN_MW{1'b0}};
  assign s6   = 1'b0;
  assign s7   = 1'b0;
  assign s8   = `N22_IFU2BIU_SIZE_TYPE;

  assign ifu_icb_rsp_valid   = s12  ;
  assign s13   = 1'b1  ;
  assign ifu_icb_rsp_err     = s14    ;
  assign ifu_icb_rsp_rdata   = s16  ;



  localparam ARBT_I_NUM = 2;
  localparam ARBT_I_PTR_W = 1;

  localparam USR_W = 4;
  localparam USR_PACK_DMODE  = 0;
  localparam USR_PACK_MMODE  = 1;
  localparam USR_PACK_VMODE  = 2;
  localparam USR_PACK_INSTR  = 3;

  wire [USR_W-1:0] s17;
  wire [USR_W-1:0] s18;
  wire [USR_W-1:0] s19;

  wire   s20 = ~s11;
  assign s17[USR_PACK_DMODE ] = s10;
  assign s17[USR_PACK_MMODE ] = s9;
  assign s17[USR_PACK_VMODE ] = s11;
  assign s17[USR_PACK_INSTR ] = s20;

  assign s18[USR_PACK_DMODE ] = lsu2ilm_icb_cmd_dmode;
  assign s18[USR_PACK_MMODE ] = lsu2ilm_icb_cmd_mmode;
  assign s18[USR_PACK_VMODE ] = 1'b0;
  assign s18[USR_PACK_INSTR ] = 1'b0;

  assign ilm_icb_cmd_dmode = s19[USR_PACK_DMODE ];
  assign ilm_icb_cmd_mmode = s19[USR_PACK_MMODE ];
  assign ilm_icb_cmd_vmode = s19[USR_PACK_VMODE ];
  assign ilm_icb_cmd_instr = s19[USR_PACK_INSTR ];


  wire [ARBT_I_NUM*1-1:0] s21;
  wire [ARBT_I_NUM*1-1:0] s22;
  wire [ARBT_I_NUM*`N22_ILM_ADDR_WIDTH-1:0] s23;
  wire [ARBT_I_NUM*1-1:0] s24;
  wire [ARBT_I_NUM*`N22_XLEN-1:0] s25;
  wire [ARBT_I_NUM*`N22_XLEN_MW-1:0] s26;
  wire [ARBT_I_NUM*1-1:0] s27;
  wire [ARBT_I_NUM*1-1:0] s28;
  wire [ARBT_I_NUM*2-1:0] s29;
  wire [ARBT_I_NUM*USR_W-1:0] s30;

  wire [ARBT_I_NUM*1-1:0] s31;
  wire [ARBT_I_NUM*1-1:0] s32;
  wire [ARBT_I_NUM*1-1:0] s33;
  wire [ARBT_I_NUM*1-1:0] s34;
  wire [ARBT_I_NUM*`N22_XLEN-1:0] s35;

  assign s21 =
                           {
                             s0,
                             lsu2ilm_icb_cmd_valid
                           } ;

  wire[ARBT_I_NUM-1:0] s36 =
                           {
                             (~lsu2ilm_icb_cmd_sel)
                             , lsu2ilm_icb_cmd_sel
                           } ;

  assign s23 =
                           {
                             s2,
                             lsu2ilm_icb_cmd_addr
                           } ;

  assign s24 =
                           {
                             s3,
                             lsu2ilm_icb_cmd_read
                           } ;

  assign s25 =
                           {
                             s4,
                             lsu2ilm_icb_cmd_wdata
                           } ;

  assign s26 =
                           {
                             s5,
                             lsu2ilm_icb_cmd_wmask
                           } ;

  assign s27 =
                           {
                             s6,
                             lsu2ilm_icb_cmd_lock
                           } ;

  assign s28 =
                           {
                             s7,
                             lsu2ilm_icb_cmd_excl
                           } ;

  assign s29 =
                           {
                             s8,
                             lsu2ilm_icb_cmd_size
                           } ;

  assign s30 =
                           {
                             s17,
                             s18
                           } ;


  assign                   {
                             s1,
                             lsu2ilm_icb_cmd_ready
                           } = s22;

  assign                   {
                             s12,
                             lsu2ilm_icb_rsp_valid
                           } = s31;

  assign                   {
                             s14,
                             lsu2ilm_icb_rsp_err
                           } = s33;

  assign                   {
                             s15,
                             lsu2ilm_icb_rsp_excl_ok
                           } = s34;

  assign                   {
                             s16,
                             lsu2ilm_icb_rsp_rdata
                           } = s35;

  assign s32 = {
                             s13,
                             lsu2ilm_icb_rsp_ready
                           };


  n22_gnrl_icb_arbt # (
  .ALLOW_BURST (0),
  .ARBT_SCHEME (3),
  .FIFO_CUT_READY  (0),
  .ALLOW_0CYCL_RSP (0),
  .FIFO_OUTS_NUM   (`N22_BIU_OUTS_NUM),
  .ARBT_NUM   (ARBT_I_NUM),
  .ARBT_PTR_W (ARBT_I_PTR_W),
  .USR_W      (USR_W),
  .AW         (`N22_ILM_ADDR_WIDTH),
  .DW         (`N22_XLEN)
  ) u_biu_icb_arbt(
  .arbt_active            (ilm_arbt_active),

  .o_icb_cmd_valid        (ilm_icb_cmd_valid )     ,
  .o_icb_cmd_ready        (ilm_icb_cmd_ready )     ,
  .o_icb_cmd_read         (ilm_icb_cmd_read )      ,
  .o_icb_cmd_addr         (ilm_icb_cmd_addr )      ,
  .o_icb_cmd_size         (ilm_icb_cmd_size)     ,
  .o_icb_cmd_wdata        (ilm_icb_cmd_wdata )     ,
  .o_icb_cmd_wmask        (ilm_icb_cmd_wmask)      ,
  .o_icb_cmd_burst        ()     ,
  .o_icb_cmd_beat         ()     ,
  .o_icb_cmd_excl         ()     ,
  .o_icb_cmd_lock         ()     ,
  .o_icb_cmd_usr          (s19)     ,

  .o_icb_rsp_valid        (ilm_icb_rsp_valid )     ,
  .o_icb_rsp_ready        ()     ,
  .o_icb_rsp_err          (ilm_icb_rsp_err)        ,
  .o_icb_rsp_excl_ok      (1'b0)    ,
  .o_icb_rsp_rdata        (ilm_icb_rsp_rdata )     ,
  .o_icb_rsp_usr          ({USR_W{1'b0}}  )     ,

  .i_bus_icb_cmd_sel_vec  (s36) ,

  .i_bus_icb_cmd_ready    (s22 ) ,
  .i_bus_icb_cmd_valid    (s21 ) ,
  .i_bus_icb_cmd_read     (s24 )  ,
  .i_bus_icb_cmd_addr     (s23 )  ,
  .i_bus_icb_cmd_wdata    (s25 ) ,
  .i_bus_icb_cmd_wmask    (s26)  ,
  .i_bus_icb_cmd_burst    ({ARBT_I_NUM{3'b0}}),
  .i_bus_icb_cmd_beat     ({ARBT_I_NUM{2'b0}}),
  .i_bus_icb_cmd_excl     (s28 ),
  .i_bus_icb_cmd_lock     (s27 ),
  .i_bus_icb_cmd_size     (s29 ),
  .i_bus_icb_cmd_usr      (s30 ),

  .i_bus_icb_rsp_valid    (s31 ) ,
  .i_bus_icb_rsp_ready    (s32 ) ,
  .i_bus_icb_rsp_err      (s33)    ,
  .i_bus_icb_rsp_excl_ok  (s34),
  .i_bus_icb_rsp_rdata    (s35 ) ,
  .i_bus_icb_rsp_usr      () ,

  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );



endmodule

`endif
