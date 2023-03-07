
`include "global.inc"

module n22_lsu_ctrl #(
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
  output lsu_outs_valid,
  output lsu_outs_rv32,
  `endif

  input csr_ilm_enable,
  input csr_dlm_enable,
  output lsu_ctrl_active,
  `ifdef N22_D_SHARE_ILM
  input [`N22_ADDR_SIZE-1:0] ilm_region_indic,
  `endif
  `ifdef N22_HAS_DLM
  input [`N22_ADDR_SIZE-1:0] dlm_region_indic,
  `endif

  output lsu_o_valid,
  input  lsu_o_ready,
  output [`N22_XLEN-1:0] lsu_o_wbck_wdat,
  output [`N22_ITAG_WIDTH -1:0] lsu_o_wbck_itag,
  output lsu_o_wbck_err ,
  output lsu_o_cmt_buserr,
  output [`N22_ADDR_SIZE -1:0] lsu_o_cmt_badaddr,
  output [`N22_PC_SIZE -1:0] lsu_o_cmt_pc,
  output lsu_o_cmt_ld,
  output lsu_o_cmt_st,


  input                          agu_icb_cmd_sel,
  input                          agu_icb_cmd_valid,
  output                         agu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   agu_icb_cmd_addr,
  `ifdef N22_LDST_EXCP_PRECISE
  input                          agu_icb_cmd_rv32,
  `endif
  input                          agu_icb_cmd_read,
  input                          agu_icb_cmd_x0base,
  input                          agu_icb_cmd_mmode,
  input                          agu_icb_cmd_dmode,
  input  [`N22_XLEN-1:0]        agu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]      agu_icb_cmd_wmask,
  input                          agu_icb_cmd_lock,
  input                          agu_icb_cmd_excl,
  input  [1:0]                   agu_icb_cmd_size,
  input                          agu_icb_cmd_back2agu,
  input                          agu_icb_cmd_usign,
  input  [`N22_ITAG_WIDTH -1:0] agu_icb_cmd_itag,

  output                         agu_icb_rsp_valid,
  input                          agu_icb_rsp_ready,
  output                         agu_icb_rsp_err  ,
  output                         agu_icb_rsp_excl_ok,
  output [`N22_XLEN-1:0]        agu_icb_rsp_rdata,






  `ifdef N22_HAS_LBIU
  output                         lbiu_icb_cmd_valid,
  input                          lbiu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   lbiu_icb_cmd_addr,
  output                         lbiu_icb_cmd_read,
  output                         lbiu_icb_cmd_mmode,
  output                         lbiu_icb_cmd_dmode,
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
  input                          lbiu_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]        lbiu_icb_rsp_rdata,
  `endif




  `ifdef N22_D_SHARE_ILM
  output                         ilm_icb_cmd_sel,
  output                         ilm_icb_cmd_valid,
  input                          ilm_icb_cmd_ready,
  output [`N22_ILM_ADDR_WIDTH-1:0]   ilm_icb_cmd_addr,
  output                         ilm_icb_cmd_read,
  output                         ilm_icb_cmd_mmode,
  output                         ilm_icb_cmd_dmode,
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
  output                         dlm_icb_cmd_read,
  output                         dlm_icb_cmd_mmode,
  output                         dlm_icb_cmd_dmode,
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


  output                         biu_icb_cmd_sel,
  output                         biu_icb_cmd_valid,
  input                          biu_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   biu_icb_cmd_addr,
  output                         biu_icb_cmd_read,
  output                         biu_icb_cmd_mmode,
  output                         biu_icb_cmd_dmode,
  output                         biu_icb_cmd_device,
  output                         biu_icb_cmd_x0base,
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

  `ifdef N22_HAS_DEBUG_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] dm_region_indic = N22_DEBUG_BASE_ADDR;
  `endif
  `ifdef N22_HAS_CLIC
  wire [`N22_ADDR_SIZE-1:0] clic_region_indic = N22_CLIC_BASE_ADDR;
  `endif
  `ifdef N22_TMR_PRIVATE
  wire [`N22_ADDR_SIZE-1:0] tmr_region_indic = N22_TMR_BASE_ADDR;
  `endif
  `ifdef N22_HAS_PPI
  wire [`N22_ADDR_SIZE-1:0] ppi_region_indic = N22_PPI_BASE_ADDR;
  `endif



      `ifndef N22_HAS_FPU
      localparam LSU_ARBT_I_NUM   = 1;
      localparam LSU_ARBT_I_PTR_W = 1;
      `endif


  `ifndef N22_HAS_DTCM

  `endif
  wire                  pre_agu_icb_rsp_valid;
  wire                  pre_agu_icb_rsp_ready;
  wire                  pre_agu_icb_rsp_err  ;
  wire                  pre_agu_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0] pre_agu_icb_rsp_rdata;

  wire                         pre_agu_icb_rsp_back2agu;
  wire                         pre_agu_icb_rsp_usign;
  wire                         pre_agu_icb_rsp_read;
  wire                         pre_agu_icb_rsp_excl;
  wire [2-1:0]                 pre_agu_icb_rsp_size;
  wire [`N22_ITAG_WIDTH -1:0] pre_agu_icb_rsp_itag;
  wire [`N22_ADDR_SIZE-1:0]   pre_agu_icb_rsp_addr;
  `ifdef N22_LDST_EXCP_PRECISE
  wire                         pre_agu_icb_rsp_rv32;
  `endif
  wire pre_agu_icb_rsp_x0base;
  wire pre_agu_icb_rsp_mmode;
  wire pre_agu_icb_rsp_dmode;

  `ifdef N22_LDST_EXCP_PRECISE
  localparam USR_W = (`N22_ITAG_WIDTH+9+`N22_ADDR_SIZE+1);
  `else
  localparam USR_W = (`N22_ITAG_WIDTH+9+`N22_ADDR_SIZE);
  `endif
  localparam USR_PACK_EXCL = 3;
  localparam USR_PACK_X0BASE = 2;
  localparam USR_PACK_MMODE = 1;
  localparam USR_PACK_DMODE = 0;
  wire [USR_W-1:0] agu_icb_cmd_usr =
      {
         agu_icb_cmd_back2agu
        ,agu_icb_cmd_usign
        ,agu_icb_cmd_read
        ,agu_icb_cmd_size
        ,agu_icb_cmd_itag
        ,agu_icb_cmd_addr
  `ifdef N22_LDST_EXCP_PRECISE
        ,agu_icb_cmd_rv32
  `endif
        ,agu_icb_cmd_excl
        ,agu_icb_cmd_x0base
        ,agu_icb_cmd_mmode
        ,agu_icb_cmd_dmode
      };
  wire [USR_W-1:0] fpu_icb_cmd_usr = {USR_W{1'b0}};

  wire [USR_W-1:0]      pre_agu_icb_rsp_usr;
  assign
      {
         pre_agu_icb_rsp_back2agu
        ,pre_agu_icb_rsp_usign
        ,pre_agu_icb_rsp_read
        ,pre_agu_icb_rsp_size
        ,pre_agu_icb_rsp_itag
        ,pre_agu_icb_rsp_addr
  `ifdef N22_LDST_EXCP_PRECISE
        ,pre_agu_icb_rsp_rv32
  `endif
        ,pre_agu_icb_rsp_excl
        ,pre_agu_icb_rsp_x0base
        ,pre_agu_icb_rsp_mmode
        ,pre_agu_icb_rsp_dmode
      } = pre_agu_icb_rsp_usr;


  wire arbt_icb_cmd_valid;
  wire arbt_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0] arbt_icb_cmd_addr;
  wire arbt_icb_cmd_read;
  wire [`N22_XLEN-1:0] arbt_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0] arbt_icb_cmd_wmask;
  wire arbt_icb_cmd_lock;
  wire arbt_icb_cmd_excl;
  wire [1:0] arbt_icb_cmd_size;
  wire [2:0] arbt_icb_cmd_burst;
  wire [1:0] arbt_icb_cmd_beat;
  wire [USR_W-1:0] arbt_icb_cmd_usr;

  wire arbt_icb_cmd_mmode = arbt_icb_cmd_usr[USR_PACK_MMODE];
  wire arbt_icb_cmd_dmode = arbt_icb_cmd_usr[USR_PACK_DMODE];
  wire arbt_icb_cmd_x0base = arbt_icb_cmd_usr[USR_PACK_X0BASE];

  wire arbt_icb_rsp_valid;
  wire arbt_icb_rsp_ready;
  wire arbt_icb_rsp_err;
  wire arbt_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0] arbt_icb_rsp_rdata;
  wire [USR_W-1:0] arbt_icb_rsp_usr;

  wire splt_icb_rsp_valid;
  wire splt_icb_rsp_ready;
  wire splt_icb_rsp_err;
  wire splt_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0] splt_icb_rsp_rdata;
  wire [USR_W-1:0] splt_icb_rsp_usr;


  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_sel_vec;

  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_valid;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_ready;
  wire [LSU_ARBT_I_NUM*`N22_ADDR_SIZE-1:0] arbt_bus_icb_cmd_addr;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_read;
  wire [LSU_ARBT_I_NUM*`N22_XLEN-1:0] arbt_bus_icb_cmd_wdata;
  wire [LSU_ARBT_I_NUM*`N22_XLEN_MW-1:0] arbt_bus_icb_cmd_wmask;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_lock;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_excl;
  wire [LSU_ARBT_I_NUM*2-1:0] arbt_bus_icb_cmd_size;
  wire [LSU_ARBT_I_NUM*USR_W-1:0] arbt_bus_icb_cmd_usr;
  wire [LSU_ARBT_I_NUM*3-1:0] arbt_bus_icb_cmd_burst;
  wire [LSU_ARBT_I_NUM*2-1:0] arbt_bus_icb_cmd_beat;

  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_valid;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_ready;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_err;
  wire [LSU_ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_excl_ok;
  wire [LSU_ARBT_I_NUM*`N22_XLEN-1:0] arbt_bus_icb_rsp_rdata;
  wire [LSU_ARBT_I_NUM*USR_W-1:0] arbt_bus_icb_rsp_usr;

  assign arbt_bus_icb_cmd_valid =
                           {
                             agu_icb_cmd_valid
                           } ;



  assign arbt_bus_icb_cmd_sel_vec =
                           {
                             agu_icb_cmd_sel
                           } ;

  assign arbt_bus_icb_cmd_addr =
                           {
                             agu_icb_cmd_addr
                           } ;

  assign arbt_bus_icb_cmd_read =
                           {
                             agu_icb_cmd_read
                           } ;

  assign arbt_bus_icb_cmd_wdata =
                           {
                             agu_icb_cmd_wdata
                           } ;

  assign arbt_bus_icb_cmd_wmask =
                           {
                             agu_icb_cmd_wmask
                           } ;

  assign arbt_bus_icb_cmd_lock =
                           {
                             agu_icb_cmd_lock
                           } ;

  assign arbt_bus_icb_cmd_burst =
                           {
                             3'b0
                           } ;

  assign arbt_bus_icb_cmd_beat =
                           {
                             2'b0
                           } ;

  assign arbt_bus_icb_cmd_excl =
                           {
                             agu_icb_cmd_excl
                           } ;

  assign arbt_bus_icb_cmd_size =
                           {
                             agu_icb_cmd_size
                           } ;

  assign arbt_bus_icb_cmd_usr =
                           {
                             agu_icb_cmd_usr
                           } ;


  assign                   {
                             agu_icb_cmd_ready
                           } = arbt_bus_icb_cmd_ready;


  assign                   {
                             pre_agu_icb_rsp_valid
                           } = arbt_bus_icb_rsp_valid;

  assign                   {
                             pre_agu_icb_rsp_err
                           } = arbt_bus_icb_rsp_err;

  assign                   {
                             pre_agu_icb_rsp_excl_ok
                           } = arbt_bus_icb_rsp_excl_ok;


  assign                   {
                             pre_agu_icb_rsp_rdata
                           } = arbt_bus_icb_rsp_rdata;

  assign                   {
                             pre_agu_icb_rsp_usr
                           } = arbt_bus_icb_rsp_usr;

  assign arbt_bus_icb_rsp_ready = {
                             pre_agu_icb_rsp_ready
                           };

  wire arbt_icb_active;

  localparam CUT_READY = 0;

  n22_gnrl_icb_arbt # (
  .ARBT_SCHEME (3),
  .ALLOW_0CYCL_RSP (0),
  .FIFO_OUTS_NUM   (`N22_LSU_OUTS_NUM),
  .FIFO_CUT_READY  (CUT_READY),
  .ARBT_NUM   (LSU_ARBT_I_NUM),
  .ARBT_PTR_W (LSU_ARBT_I_PTR_W),
  .USR_W      (USR_W),
  .AW         (`N22_ADDR_SIZE),
  .DW         (`N22_XLEN)
  ) u_lsu_icb_arbt(
  .arbt_active            (arbt_icb_active )     ,

  .o_icb_cmd_valid        (arbt_icb_cmd_valid )     ,
  .o_icb_cmd_ready        (arbt_icb_cmd_ready )     ,
  .o_icb_cmd_read         (arbt_icb_cmd_read )      ,
  .o_icb_cmd_addr         (arbt_icb_cmd_addr )      ,
  .o_icb_cmd_wdata        (arbt_icb_cmd_wdata )     ,
  .o_icb_cmd_wmask        (arbt_icb_cmd_wmask)      ,
  .o_icb_cmd_burst        (arbt_icb_cmd_burst)     ,
  .o_icb_cmd_beat         (arbt_icb_cmd_beat )     ,
  .o_icb_cmd_excl         (arbt_icb_cmd_excl )     ,
  .o_icb_cmd_lock         (arbt_icb_cmd_lock )     ,
  .o_icb_cmd_size         (arbt_icb_cmd_size )     ,
  .o_icb_cmd_usr          (arbt_icb_cmd_usr  )     ,

  .o_icb_rsp_valid        (arbt_icb_rsp_valid )     ,
  .o_icb_rsp_ready        (arbt_icb_rsp_ready )     ,
  .o_icb_rsp_err          (arbt_icb_rsp_err)        ,
  .o_icb_rsp_excl_ok      (arbt_icb_rsp_excl_ok)    ,
  .o_icb_rsp_rdata        (arbt_icb_rsp_rdata )     ,
  .o_icb_rsp_usr          (arbt_icb_rsp_usr   )     ,

  .i_bus_icb_cmd_sel_vec  (arbt_bus_icb_cmd_sel_vec) ,

  .i_bus_icb_cmd_ready    (arbt_bus_icb_cmd_ready ) ,
  .i_bus_icb_cmd_valid    (arbt_bus_icb_cmd_valid ) ,
  .i_bus_icb_cmd_read     (arbt_bus_icb_cmd_read )  ,
  .i_bus_icb_cmd_addr     (arbt_bus_icb_cmd_addr )  ,
  .i_bus_icb_cmd_wdata    (arbt_bus_icb_cmd_wdata ) ,
  .i_bus_icb_cmd_wmask    (arbt_bus_icb_cmd_wmask)  ,
  .i_bus_icb_cmd_burst    (arbt_bus_icb_cmd_burst)  ,
  .i_bus_icb_cmd_beat     (arbt_bus_icb_cmd_beat )  ,
  .i_bus_icb_cmd_excl     (arbt_bus_icb_cmd_excl )  ,
  .i_bus_icb_cmd_lock     (arbt_bus_icb_cmd_lock )  ,
  .i_bus_icb_cmd_size     (arbt_bus_icb_cmd_size )  ,
  .i_bus_icb_cmd_usr      (arbt_bus_icb_cmd_usr  )  ,

  .i_bus_icb_rsp_valid    (arbt_bus_icb_rsp_valid ) ,
  .i_bus_icb_rsp_ready    (arbt_bus_icb_rsp_ready ) ,
  .i_bus_icb_rsp_err      (arbt_bus_icb_rsp_err)    ,
  .i_bus_icb_rsp_excl_ok  (arbt_bus_icb_rsp_excl_ok),
  .i_bus_icb_rsp_rdata    (arbt_bus_icb_rsp_rdata ) ,
  .i_bus_icb_rsp_usr      (arbt_bus_icb_rsp_usr) ,

  .clk                    (clk  ),
  .rst_n                  (rst_n)
  );


  wire arbt_icb_cmd2device;

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
     .i_addr   (arbt_icb_cmd_addr),
     .o_device (arbt_icb_cmd2device)
  );


  `ifdef N22_HAS_DEBUG_PRIVATE
  wire arbt_icb_cmd_dm  = arbt_icb_cmd_dmode & (arbt_icb_cmd_addr[`N22_DEBUG_BASE_REGION]  ==  dm_region_indic[`N22_DEBUG_BASE_REGION]);
  `endif

  `ifndef N22_HAS_DEBUG_PRIVATE
  wire arbt_icb_cmd_dm  = 1'b0;
  `endif

  `ifdef N22_HAS_CLIC
  wire arbt_icb_cmd_clic = (arbt_icb_cmd_addr[`N22_CLIC_BASE_REGION] ==  clic_region_indic[`N22_CLIC_BASE_REGION]);
  `else
  wire arbt_icb_cmd_clic = 1'b0;
  `endif

  `ifdef N22_TMR_PRIVATE
  wire arbt_icb_cmd_tmr = (arbt_icb_cmd_addr[`N22_TMR_BASE_REGION] ==  tmr_region_indic[`N22_TMR_BASE_REGION])
                        & (~arbt_icb_cmd_clic)
                        ;
  `else
  wire arbt_icb_cmd_tmr = 1'b0;
  `endif

  `ifdef N22_HAS_FIO
  wire [`N22_ADDR_SIZE-1:0] fio_region_indic = N22_FIO_BASE_ADDR;
  wire arbt_icb_cmd_fio = (arbt_icb_cmd_addr[`N22_FIO_BASE_REGION] ==  fio_region_indic[`N22_FIO_BASE_REGION])
                        & (~arbt_icb_cmd_tmr)
                        & (~arbt_icb_cmd_clic)
                        ;
  `endif
  `ifndef N22_HAS_FIO
  wire arbt_icb_cmd_fio = 1'b0;
  `endif

  `ifdef N22_HAS_PPI
  wire arbt_icb_cmd_ppi = (arbt_icb_cmd_addr[`N22_PPI_BASE_REGION] ==  ppi_region_indic[`N22_PPI_BASE_REGION])
                        & (~arbt_icb_cmd_tmr)
                        & (~arbt_icb_cmd_clic)
                        & (~arbt_icb_cmd_fio)
                        ;
  `endif
  `ifndef N22_HAS_PPI
  wire arbt_icb_cmd_ppi = 1'b0;
  `endif

  `ifdef N22_HAS_LBIU
  wire arbt_icb_cmd_lbiu = ( 1'b0
                           `ifdef N22_HAS_CLIC
                              | arbt_icb_cmd_clic
                           `endif
                           `ifdef N22_TMR_PRIVATE
                              | arbt_icb_cmd_tmr
                           `endif
                           `ifdef N22_HAS_PPI
                              | arbt_icb_cmd_ppi
                           `endif
                           `ifdef N22_HAS_FIO
                              | arbt_icb_cmd_fio
                           `endif
                              );
  `endif
  `ifndef N22_HAS_LBIU
  wire arbt_icb_cmd_lbiu = 1'b0;
  `endif

  wire arbt_icb_cmd_local = (arbt_icb_cmd_dm | arbt_icb_cmd_lbiu);

  wire arbt_icb_cmd_itcm = 1'b0;

  `ifdef N22_D_SHARE_ILM
  wire arbt_icb_cmd_ilm = csr_ilm_enable & (arbt_icb_cmd_addr[`N22_ILM_BASE_REGION] ==  ilm_region_indic[`N22_ILM_BASE_REGION])
                         & (~arbt_icb_cmd_local)
                         ;
  `else
  wire arbt_icb_cmd_ilm = 1'b0;
  `endif

  `ifdef N22_HAS_DLM
  wire arbt_icb_cmd_dlm = csr_dlm_enable & (arbt_icb_cmd_addr[`N22_DLM_BASE_REGION] ==  dlm_region_indic[`N22_DLM_BASE_REGION])
                         & (~arbt_icb_cmd_local)
                       `ifdef N22_D_SHARE_ILM
                         & (~arbt_icb_cmd_ilm)
                       `endif
                         ;
  `endif
  `ifndef N22_HAS_DLM
  wire arbt_icb_cmd_dlm = 1'b0;
  `endif

  wire arbt_icb_cmd_dtcm = 1'b0;

  wire arbt_icb_cmd_dcache = 1'b0;


  wire arbt_icb_cmd_biu    = ((~arbt_icb_cmd_ilm) &
                              (~arbt_icb_cmd_dlm) &
                              (~arbt_icb_cmd_itcm) &
                              (~arbt_icb_cmd_lbiu) &
                              (~arbt_icb_cmd_dtcm) &
                              (~arbt_icb_cmd_dcache)
                             ) | arbt_icb_cmd_dm;

  wire splt_fifo_wen = arbt_icb_cmd_valid & arbt_icb_cmd_ready;
  wire splt_fifo_ren = arbt_icb_rsp_valid & arbt_icb_rsp_ready;


  wire splt_fifo_i_ready;
  wire splt_fifo_i_valid = splt_fifo_wen;
  wire splt_fifo_full    = (~splt_fifo_i_ready);
  wire splt_fifo_o_valid;
  wire splt_fifo_o_ready = splt_fifo_ren;
  wire splt_fifo_empty   = (~splt_fifo_o_valid);

  wire splt_icb_rsp_biu;
  wire splt_icb_rsp_dcache;
  wire splt_icb_rsp_dtcm;
  wire splt_icb_rsp_lbiu;
  wire splt_icb_rsp_itcm;
  wire splt_icb_rsp_ilm;
  wire splt_icb_rsp_dlm;

  localparam SPLT_FIFO_W = (USR_W+7);
  wire [`N22_XLEN_MW-1:0] arbt_icb_cmd_wmask_pos = arbt_icb_cmd_wmask;

  wire [SPLT_FIFO_W-1:0] splt_fifo_wdat;
  wire [SPLT_FIFO_W-1:0] splt_fifo_rdat;

  assign splt_fifo_wdat =  {
          arbt_icb_cmd_biu,
          arbt_icb_cmd_dcache,
          arbt_icb_cmd_dtcm,
          arbt_icb_cmd_lbiu,
          arbt_icb_cmd_itcm,
          arbt_icb_cmd_ilm,
          arbt_icb_cmd_dlm,
          arbt_icb_cmd_usr
          };

  assign
      {
          splt_icb_rsp_biu,
          splt_icb_rsp_dcache,
          splt_icb_rsp_dtcm,
          splt_icb_rsp_lbiu,
          splt_icb_rsp_itcm,
          splt_icb_rsp_ilm,
          splt_icb_rsp_dlm,
          splt_icb_rsp_usr
          } = splt_fifo_rdat & {SPLT_FIFO_W{splt_fifo_o_valid}};

  assign arbt_icb_rsp_usr = splt_icb_rsp_usr;

  `ifdef N22_LSU_OUTS_NUM_IS_1
  n22_gnrl_pipe_stage # (
    .CUT_READY(CUT_READY),
    .DP(1),
    .DW(SPLT_FIFO_W)
  ) u_n22_lsu_splt_stage (
    .i_vld  (splt_fifo_i_valid),
    .i_rdy  (splt_fifo_i_ready),
    .i_dat  (splt_fifo_wdat ),
    .o_vld  (splt_fifo_o_valid),
    .o_rdy  (splt_fifo_o_ready),
    .o_dat  (splt_fifo_rdat ),

    .clk  (clk),
    .rst_n(rst_n)
  );
  `else
  n22_gnrl_fifo # (
    .CUT_READY (CUT_READY),
    .MSKO      (0),
    .DP  (`N22_LSU_OUTS_NUM),
    .DW  (SPLT_FIFO_W)
  ) u_n22_lsu_splt_fifo (
    .i_vld  (splt_fifo_i_valid),
    .i_rdy  (splt_fifo_i_ready),
    .i_dat  (splt_fifo_wdat ),
    .o_vld  (splt_fifo_o_valid),
    .o_rdy  (splt_fifo_o_ready),
    .o_dat  (splt_fifo_rdat ),
    .clk  (clk),
    .rst_n(rst_n)
  );
  `endif


  `ifdef N22_LDST_EXCP_PRECISE
  assign lsu_outs_valid = splt_fifo_o_valid;
  assign lsu_outs_rv32  = pre_agu_icb_rsp_rv32;
  `endif




  wire cmd_diff_branch = 1'b0;


  wire arbt_icb_cmd_addi_condi = (~splt_fifo_full) & (~cmd_diff_branch);
  wire arbt_icb_cmd_ready_pos;

  wire arbt_icb_cmd_valid_pos = arbt_icb_cmd_addi_condi & arbt_icb_cmd_valid;
  assign arbt_icb_cmd_ready     = arbt_icb_cmd_addi_condi & arbt_icb_cmd_ready_pos;

  wire all_icb_cmd_ready;
  wire all_icb_cmd_ready_excp_biu;
  wire all_icb_cmd_ready_excp_dcach;
  wire all_icb_cmd_ready_excp_dtcm;
  wire all_icb_cmd_ready_excp_lbiu;
  wire all_icb_cmd_ready_excp_itcm;
  wire all_icb_cmd_ready_excp_ilm;
  wire all_icb_cmd_ready_excp_dlm;




  `ifdef N22_HAS_LBIU
  assign lbiu_icb_cmd_valid = arbt_icb_cmd_valid_pos & arbt_icb_cmd_lbiu & all_icb_cmd_ready_excp_lbiu;
  assign lbiu_icb_cmd_addr  = arbt_icb_cmd_addr;
  assign lbiu_icb_cmd_mmode = arbt_icb_cmd_mmode;
  assign lbiu_icb_cmd_dmode = arbt_icb_cmd_dmode;
  assign lbiu_icb_cmd_read  = arbt_icb_cmd_read ;
  assign lbiu_icb_cmd_wdata = arbt_icb_cmd_wdata;
  assign lbiu_icb_cmd_wmask = arbt_icb_cmd_wmask_pos;
  assign lbiu_icb_cmd_lock  = arbt_icb_cmd_lock ;
  assign lbiu_icb_cmd_excl  = arbt_icb_cmd_excl ;
  assign lbiu_icb_cmd_size  = arbt_icb_cmd_size ;
  assign lbiu_icb_cmd_tmr   = arbt_icb_cmd_tmr;
  assign lbiu_icb_cmd_clic  = arbt_icb_cmd_clic;
  assign lbiu_icb_cmd_fio   = arbt_icb_cmd_fio;
  assign lbiu_icb_cmd_ppi   = arbt_icb_cmd_ppi;
  `endif


  `ifdef N22_D_SHARE_ILM
  assign ilm_icb_cmd_valid = arbt_icb_cmd_valid_pos & arbt_icb_cmd_ilm & all_icb_cmd_ready_excp_ilm;
  assign ilm_icb_cmd_addr  = arbt_icb_cmd_addr [`N22_ILM_ADDR_WIDTH-1:0];
  assign ilm_icb_cmd_mmode = arbt_icb_cmd_mmode;
  assign ilm_icb_cmd_dmode = arbt_icb_cmd_dmode;
  assign ilm_icb_cmd_read  = arbt_icb_cmd_read ;
  assign ilm_icb_cmd_wdata = arbt_icb_cmd_wdata;
  assign ilm_icb_cmd_wmask = arbt_icb_cmd_wmask_pos;
  assign ilm_icb_cmd_lock  = arbt_icb_cmd_lock ;
  assign ilm_icb_cmd_excl  = arbt_icb_cmd_excl ;
  assign ilm_icb_cmd_size  = arbt_icb_cmd_size ;
  `endif

  `ifdef N22_HAS_DLM
  assign dlm_icb_cmd_valid = arbt_icb_cmd_valid_pos & arbt_icb_cmd_dlm & all_icb_cmd_ready_excp_dlm;
  assign dlm_icb_cmd_addr  = arbt_icb_cmd_addr [`N22_DLM_ADDR_WIDTH-1:0];
  assign dlm_icb_cmd_mmode = arbt_icb_cmd_mmode;
  assign dlm_icb_cmd_dmode = arbt_icb_cmd_dmode;
  assign dlm_icb_cmd_read  = arbt_icb_cmd_read ;
  assign dlm_icb_cmd_wdata = arbt_icb_cmd_wdata;
  assign dlm_icb_cmd_wmask = arbt_icb_cmd_wmask_pos;
  assign dlm_icb_cmd_lock  = arbt_icb_cmd_lock ;
  assign dlm_icb_cmd_excl  = arbt_icb_cmd_excl ;
  assign dlm_icb_cmd_size  = arbt_icb_cmd_size ;
  `endif


  assign biu_icb_cmd_sel = (|arbt_bus_icb_cmd_sel_vec);
  `ifdef N22_HAS_DLM
  assign dlm_icb_cmd_sel = (|arbt_bus_icb_cmd_sel_vec);
  `endif
  `ifdef N22_D_SHARE_ILM
  assign ilm_icb_cmd_sel = (|arbt_bus_icb_cmd_sel_vec) & arbt_icb_cmd_ilm;
  `endif

  assign biu_icb_cmd_valid = arbt_icb_cmd_valid_pos & arbt_icb_cmd_biu & all_icb_cmd_ready_excp_biu;
  assign biu_icb_cmd_addr  = arbt_icb_cmd_addr ;
  assign biu_icb_cmd_mmode = arbt_icb_cmd_mmode;
  assign biu_icb_cmd_dmode = arbt_icb_cmd_dmode;
  assign biu_icb_cmd_device = arbt_icb_cmd2device;
  assign biu_icb_cmd_x0base = arbt_icb_cmd_x0base;
  assign biu_icb_cmd_read  = arbt_icb_cmd_read ;
  assign biu_icb_cmd_wdata = arbt_icb_cmd_wdata;
  assign biu_icb_cmd_wmask = arbt_icb_cmd_wmask_pos;
  assign biu_icb_cmd_lock  = arbt_icb_cmd_lock ;
  assign biu_icb_cmd_excl  = arbt_icb_cmd_excl ;
  assign biu_icb_cmd_size  = arbt_icb_cmd_size ;

  assign all_icb_cmd_ready =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

  assign all_icb_cmd_ready_excp_biu =
            1'b1
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

  assign all_icb_cmd_ready_excp_dcach =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;
  assign all_icb_cmd_ready_excp_dtcm =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

 assign all_icb_cmd_ready_excp_lbiu =
            (biu_icb_cmd_ready )
          & 1'b1
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

 assign all_icb_cmd_ready_excp_itcm =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

 assign all_icb_cmd_ready_excp_ilm =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & 1'b1
             `endif
             `ifdef N22_HAS_DLM
          & (dlm_icb_cmd_ready)
             `endif
             ;

 assign all_icb_cmd_ready_excp_dlm =
            (biu_icb_cmd_ready )
             `ifdef N22_HAS_LBIU
          & (lbiu_icb_cmd_ready)
             `endif
             `ifdef N22_D_SHARE_ILM
          & (ilm_icb_cmd_ready)
             `endif
             `ifdef N22_HAS_DLM
          & 1'b1
             `endif
             ;


  assign arbt_icb_cmd_ready_pos = all_icb_cmd_ready;



  localparam RSP_PACK_W = (2+`N22_XLEN);
  wire [RSP_PACK_W-1:0] rsp_fifo_i_dat = {
                                 splt_icb_rsp_err,
                                 splt_icb_rsp_excl_ok,
                                 splt_icb_rsp_rdata
                                 };

  wire [RSP_PACK_W-1:0] rsp_fifo_o_dat;

  assign {
                                 arbt_icb_rsp_err,
                                 arbt_icb_rsp_excl_ok,
                                 arbt_icb_rsp_rdata
                                 } = rsp_fifo_o_dat;

 `ifdef N22_NO_LSU_RSP_BYPBUF
  assign rsp_fifo_o_dat = rsp_fifo_i_dat;
  assign arbt_icb_rsp_valid = splt_icb_rsp_valid;
  assign splt_icb_rsp_ready = arbt_icb_rsp_ready;

 `else
  n22_gnrl_bypbuf # (
    .DP  (1),
    .DW  (RSP_PACK_W)
  ) u_lsu_splt_rsp_bypbuf (
    .i_vld(splt_icb_rsp_valid),
    .i_rdy(splt_icb_rsp_ready),
    .i_dat(rsp_fifo_i_dat ),
    .o_vld(arbt_icb_rsp_valid),
    .o_rdy(arbt_icb_rsp_ready),
    .o_dat(rsp_fifo_o_dat ),

    .clk  (clk),
    .rst_n(rst_n)
  );
 `endif








  assign {
          splt_icb_rsp_valid
        , splt_icb_rsp_err
        , splt_icb_rsp_excl_ok
        , splt_icb_rsp_rdata
         } =
            ({`N22_XLEN+3{splt_icb_rsp_biu}} &
                        { biu_icb_rsp_valid
                        , biu_icb_rsp_err
                        , biu_icb_rsp_excl_ok
                        , biu_icb_rsp_rdata
                        }
            )
             `ifdef N22_HAS_LBIU
          | ({`N22_XLEN+3{splt_icb_rsp_lbiu}} &
                        { lbiu_icb_rsp_valid
                        , lbiu_icb_rsp_err
                        , lbiu_icb_rsp_excl_ok
                        , lbiu_icb_rsp_rdata
                        }
            )
             `endif
             `ifdef N22_D_SHARE_ILM
          | ({`N22_XLEN+3{splt_icb_rsp_ilm}} &
                        { ilm_icb_rsp_valid
                        , ilm_icb_rsp_err
                        , ilm_icb_rsp_excl_ok
                        , ilm_icb_rsp_rdata
                        }
            )
             `endif
             `ifdef N22_HAS_DLM
          | ({`N22_XLEN+3{splt_icb_rsp_dlm}} &
                        { dlm_icb_rsp_valid
                        , dlm_icb_rsp_err
                        , dlm_icb_rsp_excl_ok
                        , dlm_icb_rsp_rdata
                        }
            )
             `endif
             ;

  assign biu_icb_rsp_ready    = splt_icb_rsp_biu    & splt_icb_rsp_ready;
             `ifdef N22_HAS_LBIU
  assign lbiu_icb_rsp_ready   = splt_icb_rsp_lbiu   & splt_icb_rsp_ready;
             `endif
             `ifdef N22_D_SHARE_ILM
  assign ilm_icb_rsp_ready   = splt_icb_rsp_ilm   & splt_icb_rsp_ready;
             `endif
             `ifdef N22_HAS_DLM
  assign dlm_icb_rsp_ready   = splt_icb_rsp_dlm   & splt_icb_rsp_ready;
             `endif


  assign lsu_o_valid       = pre_agu_icb_rsp_valid & (~pre_agu_icb_rsp_back2agu);
  assign agu_icb_rsp_valid = pre_agu_icb_rsp_valid &   pre_agu_icb_rsp_back2agu;

  assign pre_agu_icb_rsp_ready =
      pre_agu_icb_rsp_back2agu ?  agu_icb_rsp_ready : lsu_o_ready;

  assign agu_icb_rsp_err   = pre_agu_icb_rsp_err  ;
  assign agu_icb_rsp_excl_ok = pre_agu_icb_rsp_excl_ok  ;
  assign agu_icb_rsp_rdata = pre_agu_icb_rsp_rdata;

  assign lsu_o_wbck_itag   = pre_agu_icb_rsp_itag;

  wire [`N22_XLEN-1:0] rdata_algn =
      (pre_agu_icb_rsp_rdata >> {pre_agu_icb_rsp_addr[1:0],3'b0});

  wire rsp_lbu = (pre_agu_icb_rsp_size == 2'b00) & (pre_agu_icb_rsp_usign == 1'b1);
  wire rsp_lb  = (pre_agu_icb_rsp_size == 2'b00) & (pre_agu_icb_rsp_usign == 1'b0);
  wire rsp_lhu = (pre_agu_icb_rsp_size == 2'b01) & (pre_agu_icb_rsp_usign == 1'b1);
  wire rsp_lh  = (pre_agu_icb_rsp_size == 2'b01) & (pre_agu_icb_rsp_usign == 1'b0);
  wire rsp_lw  = (pre_agu_icb_rsp_size == 2'b10);

  assign lsu_o_wbck_wdat   =
          ( ({`N22_XLEN{rsp_lbu}} & {{24{          1'b0}}, rdata_algn[ 7:0]})
          | ({`N22_XLEN{rsp_lb }} & {{24{rdata_algn[ 7]}}, rdata_algn[ 7:0]})
          | ({`N22_XLEN{rsp_lhu}} & {{16{          1'b0}}, rdata_algn[15:0]})
          | ({`N22_XLEN{rsp_lh }} & {{16{rdata_algn[15]}}, rdata_algn[15:0]})
          | ({`N22_XLEN{rsp_lw }} & rdata_algn[31:0]));

  assign lsu_o_wbck_err    = pre_agu_icb_rsp_err;
  assign lsu_o_cmt_buserr  = pre_agu_icb_rsp_err;
  assign lsu_o_cmt_badaddr = pre_agu_icb_rsp_addr;
  `ifdef N22_LDST_EXCP_PRECISE
  assign lsu_o_cmt_pc      = `N22_PC_SIZE'b0;
  `else
  assign lsu_o_cmt_pc      = `N22_PC_SIZE'b0;
  `endif
  assign lsu_o_cmt_ld      =  pre_agu_icb_rsp_read;
  assign lsu_o_cmt_st      = ~pre_agu_icb_rsp_read;

  assign lsu_ctrl_active = (|arbt_bus_icb_cmd_valid) | splt_fifo_o_valid | arbt_icb_active;

endmodule

