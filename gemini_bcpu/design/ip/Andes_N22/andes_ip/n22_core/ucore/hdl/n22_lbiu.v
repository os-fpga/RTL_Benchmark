
`include "global.inc"

`ifdef N22_HAS_LBIU

module n22_lbiu(

  output                         lbiu_active,
  input                          lsu2lbiu_icb_cmd_valid,
  output                         lsu2lbiu_icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0]   lsu2lbiu_icb_cmd_addr,
  input                          lsu2lbiu_icb_cmd_read,
  input  [`N22_XLEN-1:0]        lsu2lbiu_icb_cmd_wdata,
  input  [`N22_XLEN_MW-1:0]      lsu2lbiu_icb_cmd_wmask,
  input  [2:0]                   lsu2lbiu_icb_cmd_burst,
  input  [1:0]                   lsu2lbiu_icb_cmd_beat,
  input                          lsu2lbiu_icb_cmd_lock,
  input                          lsu2lbiu_icb_cmd_excl,
  input  [1:0]                   lsu2lbiu_icb_cmd_size,
  input                          lsu2lbiu_icb_cmd_mmode,
  input                          lsu2lbiu_icb_cmd_dmode,
  input                          lsu2lbiu_icb_cmd_tmr,
  input                          lsu2lbiu_icb_cmd_clic,
  input                          lsu2lbiu_icb_cmd_ppi,
  input                          lsu2lbiu_icb_cmd_fio,

  output                         lsu2lbiu_icb_rsp_valid,
  input                          lsu2lbiu_icb_rsp_ready,
  output                         lsu2lbiu_icb_rsp_err  ,
  output                         lsu2lbiu_icb_rsp_excl_ok,
  output [`N22_XLEN-1:0]        lsu2lbiu_icb_rsp_rdata,

    `ifdef N22_TMR_PRIVATE
  output                         tmr_icb_cmd_valid,
  input                          tmr_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   tmr_icb_cmd_addr,
  output                         tmr_icb_cmd_read,
  output [`N22_XLEN-1:0]        tmr_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      tmr_icb_cmd_wmask,
  output [2:0]                   tmr_icb_cmd_burst,
  output [1:0]                   tmr_icb_cmd_beat,
  output                         tmr_icb_cmd_lock,
  output                         tmr_icb_cmd_excl,
  output [1:0]                   tmr_icb_cmd_size,
  output                         tmr_icb_cmd_mmode,
  output                         tmr_icb_cmd_dmode,
  input                          tmr_icb_rsp_valid,
  output                         tmr_icb_rsp_ready,
  input                          tmr_icb_rsp_err  ,
  input                          tmr_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]        tmr_icb_rsp_rdata,
    `endif

 `ifdef N22_HAS_CLIC
  output                         clic_icb_cmd_valid,
  input                          clic_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   clic_icb_cmd_addr,
  output                         clic_icb_cmd_read,
  output [`N22_XLEN-1:0]        clic_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      clic_icb_cmd_wmask,
  output [2:0]                   clic_icb_cmd_burst,
  output [1:0]                   clic_icb_cmd_beat,
  output                         clic_icb_cmd_lock,
  output                         clic_icb_cmd_excl,
  output [1:0]                   clic_icb_cmd_size,
  output                         clic_icb_cmd_mmode,
  output                         clic_icb_cmd_dmode,
  input                          clic_icb_rsp_valid,
  output                         clic_icb_rsp_ready,
  input                          clic_icb_rsp_err  ,
  input                          clic_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]        clic_icb_rsp_rdata,
    `endif

  `ifdef N22_HAS_PPI

      `ifdef N22_PPI_TYPE_ICB
  output                         ppi_icb_cmd_valid,
  input                          ppi_icb_cmd_ready,
  output [`N22_ADDR_SIZE-1:0]   ppi_icb_cmd_addr,
  output                         ppi_icb_cmd_read,
  output [`N22_XLEN-1:0]        ppi_icb_cmd_wdata,
  output [`N22_XLEN_MW-1:0]      ppi_icb_cmd_wmask,
  output [2:0]                   ppi_icb_cmd_burst,
  output [1:0]                   ppi_icb_cmd_beat,
  output                         ppi_icb_cmd_lock,
  output                         ppi_icb_cmd_excl,
  output [1:0]                   ppi_icb_cmd_size,
  output                         ppi_icb_cmd_mmode,
  output                         ppi_icb_cmd_dmode,
  input                          ppi_icb_rsp_valid,
  output                         ppi_icb_rsp_ready,
  input                          ppi_icb_rsp_err  ,
  input                          ppi_icb_rsp_excl_ok,
  input  [`N22_XLEN-1:0]        ppi_icb_rsp_rdata,
      `endif

      `ifdef N22_PPI_TYPE_APB
  output [`N22_PPI_ADDR_WIDTH-1:0]   ppi_apb_paddr,
  output                         ppi_apb_pwrite,
  output                         ppi_apb_dmode,
  output [2:0]                   ppi_apb_pprot,
  output [3:0]                   ppi_apb_pstrobe,
  output                         ppi_apb_psel,
  output                         ppi_apb_penable,
  output [`N22_XLEN-1:0]        ppi_apb_pwdata,
  input  [`N22_XLEN-1:0]        ppi_apb_prdata,
  input                          ppi_apb_pready ,
  input                          ppi_apb_pslverr,
      `endif

  `endif

 `ifdef N22_HAS_FIO
 output                         fio_icb_cmd_valid,
 input                          fio_icb_cmd_ready,
 output [`N22_FIO_ADDR_WIDTH-1:0]   fio_icb_cmd_addr,
 output                         fio_icb_cmd_read,
 output [`N22_XLEN-1:0]        fio_icb_cmd_wdata,
 output [`N22_XLEN_MW-1:0]      fio_icb_cmd_wmask,
 output [2:0]                   fio_icb_cmd_burst,
 output [1:0]                   fio_icb_cmd_beat,
 output                         fio_icb_cmd_lock,
 output                         fio_icb_cmd_excl,
 output [1:0]                   fio_icb_cmd_size,
 output                         fio_icb_cmd_mmode,
 output                         fio_icb_cmd_dmode,
 input                          fio_icb_rsp_valid,
 output                         fio_icb_rsp_ready,
 input                          fio_icb_rsp_err  ,
 input                          fio_icb_rsp_excl_ok,
 input  [`N22_XLEN-1:0]        fio_icb_rsp_rdata,
 `endif

  input  clk,
  input  rst_n
  );

  `ifdef N22_HAS_PPI
      `ifdef N22_PPI_TYPE_APB
  wire                         ppi_icb_cmd_valid;
  wire                         ppi_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0]   ppi_icb_cmd_addr;
  wire                         ppi_icb_cmd_read;
  wire [`N22_XLEN-1:0]        ppi_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0]      ppi_icb_cmd_wmask;
  wire [2:0]                   ppi_icb_cmd_burst;
  wire [1:0]                   ppi_icb_cmd_beat;
  wire                         ppi_icb_cmd_lock;
  wire                         ppi_icb_cmd_excl;
  wire [1:0]                   ppi_icb_cmd_size;
  wire                         ppi_icb_cmd_mmode;
  wire                         ppi_icb_cmd_dmode;

  wire                         ppi_icb_rsp_valid;
  wire                         ppi_icb_rsp_ready;
  wire                         ppi_icb_rsp_err  ;
  wire                         ppi_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0]        ppi_icb_rsp_rdata;
     `endif
  `endif


  localparam SPLT_I_NUM = 0;

 `ifdef N22_TMR_PRIVATE
  localparam SPLT_I_NUM_0 = (SPLT_I_NUM + 1);
 `endif
 `ifndef N22_TMR_PRIVATE
  localparam SPLT_I_NUM_0 = SPLT_I_NUM;
 `endif

 `ifdef N22_HAS_PPI
  localparam SPLT_I_NUM_1 = (SPLT_I_NUM_0 + 1);
 `endif
 `ifndef N22_HAS_PPI
  localparam SPLT_I_NUM_1 = SPLT_I_NUM_0;
 `endif

  `ifdef N22_HAS_CLIC
  localparam SPLT_I_NUM_2 = (SPLT_I_NUM_1 + 1);
 `endif
 `ifndef N22_HAS_CLIC
  localparam SPLT_I_NUM_2 = SPLT_I_NUM_1;
 `endif

 `ifdef N22_HAS_FIO
  localparam BIU_SPLT_I_NUM = (SPLT_I_NUM_2 + 1);
 `endif
 `ifndef N22_HAS_FIO
  localparam BIU_SPLT_I_NUM = SPLT_I_NUM_2;
 `endif

  localparam BIU_SPLT_I_PTR_W = 2;


  localparam USR_W = 6;
  localparam USR_PACK_DMODE= 0;
  localparam USR_PACK_MMODE= 1;
  localparam USR_PACK_TMR  = 2;
  localparam USR_PACK_CLIC  = 3;
  localparam USR_PACK_FIO  = 4;
  localparam USR_PACK_PPI  = 5;

  wire [USR_W-1:0] lsu2lbiu_icb_cmd_usr;
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_DMODE] = lsu2lbiu_icb_cmd_dmode;
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_MMODE] = lsu2lbiu_icb_cmd_mmode;

  `ifdef N22_TMR_PRIVATE
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_TMR  ] = lsu2lbiu_icb_cmd_tmr;
  `else
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_TMR  ] = 1'b0;
  `endif

  `ifdef N22_HAS_CLIC
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_CLIC  ] = lsu2lbiu_icb_cmd_clic;
  `endif
  `ifndef N22_HAS_CLIC
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_CLIC  ] = 1'b0;
  `endif

  `ifdef N22_HAS_PPI
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_PPI  ] = lsu2lbiu_icb_cmd_ppi;
  `endif
  `ifndef N22_HAS_PPI
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_PPI  ] = 1'b0;
  `endif


  `ifdef N22_HAS_FIO
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_FIO  ] = lsu2lbiu_icb_cmd_fio;
  `endif
  `ifndef N22_HAS_FIO
  assign lsu2lbiu_icb_cmd_usr[USR_PACK_FIO  ] = 1'b0;
  `endif


  wire buf_icb_cmd_valid;
  wire buf_icb_cmd_ready;
  wire [`N22_ADDR_SIZE-1:0] buf_icb_cmd_addr;
  wire buf_icb_cmd_read;
  wire [`N22_XLEN-1:0] buf_icb_cmd_wdata;
  wire [`N22_XLEN_MW-1:0] buf_icb_cmd_wmask;
  wire [2:0] buf_icb_cmd_burst;
  wire [1:0] buf_icb_cmd_beat;
  wire buf_icb_cmd_lock;
  wire buf_icb_cmd_excl;
  wire [1:0] buf_icb_cmd_size;
  wire [USR_W-1:0] buf_icb_cmd_usr;


  wire buf_icb_rsp_valid;
  wire buf_icb_rsp_ready;
  wire buf_icb_rsp_err;
  wire buf_icb_rsp_excl_ok;
  wire [`N22_XLEN-1:0] buf_icb_rsp_rdata;

  wire icb_buffer_active;

  n22_gnrl_icb_buffer # (
    .OUTS_CNT_W   (`N22_LSU_OUTS_CNT_W),
    .AW    (`N22_ADDR_SIZE),
    .DW    (`N22_XLEN),
    .CMD_DP(1),
    .RSP_DP(0),
    .RSP_ALWAYS_READY (0),

    .CMD_CUT_READY (0),
    .RSP_CUT_READY (0),
    .USR_W (USR_W)
  )u_lbiu_icb_buffer(
    .bus_clk_en (1'b1),
    .icb_buffer_active      (icb_buffer_active),
    .i_icb_cmd_valid        (lsu2lbiu_icb_cmd_valid),
    .i_icb_cmd_ready        (lsu2lbiu_icb_cmd_ready),
    .i_icb_cmd_read         (lsu2lbiu_icb_cmd_read ),
    .i_icb_cmd_addr         (lsu2lbiu_icb_cmd_addr ),
    .i_icb_cmd_wdata        (lsu2lbiu_icb_cmd_wdata),
    .i_icb_cmd_wmask        (lsu2lbiu_icb_cmd_wmask),
    .i_icb_cmd_lock         (lsu2lbiu_icb_cmd_lock ),
    .i_icb_cmd_excl         (lsu2lbiu_icb_cmd_excl ),
    .i_icb_cmd_size         (lsu2lbiu_icb_cmd_size ),
    .i_icb_cmd_burst        (lsu2lbiu_icb_cmd_burst),
    .i_icb_cmd_beat         (lsu2lbiu_icb_cmd_beat ),
    .i_icb_cmd_usr          (lsu2lbiu_icb_cmd_usr  ),

    .i_icb_rsp_valid        (lsu2lbiu_icb_rsp_valid),
    .i_icb_rsp_ready        (lsu2lbiu_icb_rsp_ready),
    .i_icb_rsp_err          (lsu2lbiu_icb_rsp_err  ),
    .i_icb_rsp_excl_ok      (lsu2lbiu_icb_rsp_excl_ok),
    .i_icb_rsp_rdata        (lsu2lbiu_icb_rsp_rdata),
    .i_icb_rsp_usr          (),

    .o_icb_cmd_valid        (buf_icb_cmd_valid),
    .o_icb_cmd_ready        (buf_icb_cmd_ready),
    .o_icb_cmd_read         (buf_icb_cmd_read ),
    .o_icb_cmd_addr         (buf_icb_cmd_addr ),
    .o_icb_cmd_wdata        (buf_icb_cmd_wdata),
    .o_icb_cmd_wmask        (buf_icb_cmd_wmask),
    .o_icb_cmd_lock         (buf_icb_cmd_lock ),
    .o_icb_cmd_excl         (buf_icb_cmd_excl ),
    .o_icb_cmd_size         (buf_icb_cmd_size ),
    .o_icb_cmd_burst        (buf_icb_cmd_burst),
    .o_icb_cmd_beat         (buf_icb_cmd_beat ),
    .o_icb_cmd_usr          (buf_icb_cmd_usr),

    .o_icb_rsp_valid        (buf_icb_rsp_valid),
    .o_icb_rsp_ready        (buf_icb_rsp_ready),
    .o_icb_rsp_err          (buf_icb_rsp_err  ),
    .o_icb_rsp_excl_ok      (buf_icb_rsp_excl_ok),
    .o_icb_rsp_rdata        (buf_icb_rsp_rdata),
    .o_icb_rsp_usr          ({USR_W{1'b0}}  ),

    .clk                    (clk  ),
    .rst_n                  (rst_n)
  );

 localparam RSP_PACK_W = (`N22_XLEN + 2);

 `ifdef N22_HAS_FIO
 wire                  i_fio_icb_rsp_valid;
 wire                  i_fio_icb_rsp_ready;
 wire                  i_fio_icb_rsp_err  ;
 wire                  i_fio_icb_rsp_excl_ok;
 wire [`N22_XLEN-1:0] i_fio_icb_rsp_rdata;

 wire [RSP_PACK_W-1:0]fio_icb_rsp_pack;
 wire [RSP_PACK_W-1:0]i_fio_icb_rsp_pack;

  assign fio_icb_rsp_pack = {
                          fio_icb_rsp_excl_ok,
                          fio_icb_rsp_err,
                          fio_icb_rsp_rdata
                          };

  assign {
                          i_fio_icb_rsp_excl_ok,
                          i_fio_icb_rsp_err,
                          i_fio_icb_rsp_rdata
                          } = i_fio_icb_rsp_pack;


assign i_fio_icb_rsp_pack = fio_icb_rsp_pack;
assign i_fio_icb_rsp_valid = fio_icb_rsp_valid;
assign fio_icb_rsp_ready = i_fio_icb_rsp_ready;

 `endif

 `ifdef N22_HAS_PPI
 wire                  i_ppi_icb_rsp_valid;
 wire                  i_ppi_icb_rsp_ready;
 wire                  i_ppi_icb_rsp_err  ;
 wire                  i_ppi_icb_rsp_excl_ok;
 wire [`N22_XLEN-1:0] i_ppi_icb_rsp_rdata;

 wire [RSP_PACK_W-1:0]ppi_icb_rsp_pack;
 wire [RSP_PACK_W-1:0]i_ppi_icb_rsp_pack;

  assign ppi_icb_rsp_pack = {
                          ppi_icb_rsp_excl_ok,
                          ppi_icb_rsp_err,
                          ppi_icb_rsp_rdata
                          };

  assign {
                          i_ppi_icb_rsp_excl_ok,
                          i_ppi_icb_rsp_err,
                          i_ppi_icb_rsp_rdata
                          } = i_ppi_icb_rsp_pack;


assign i_ppi_icb_rsp_pack = ppi_icb_rsp_pack;
assign i_ppi_icb_rsp_valid = ppi_icb_rsp_valid;
assign ppi_icb_rsp_ready = i_ppi_icb_rsp_ready;

 `endif




  `ifdef N22_HAS_FIO
  wire [USR_W-1:0] fio_icb_cmd_usr;
  `endif
 `ifdef N22_TMR_PRIVATE
  wire [USR_W-1:0] tmr_icb_cmd_usr;
  `endif
   `ifdef N22_HAS_CLIC
  wire [USR_W-1:0] clic_icb_cmd_usr;
   `endif
  `ifdef N22_HAS_PPI
  wire [USR_W-1:0] ppi_icb_cmd_usr;
  `endif

 `ifdef N22_TMR_PRIVATE
  assign tmr_icb_cmd_dmode = tmr_icb_cmd_usr[USR_PACK_DMODE];
  assign tmr_icb_cmd_mmode = tmr_icb_cmd_usr[USR_PACK_MMODE];
  `endif
   `ifdef N22_HAS_CLIC
  assign clic_icb_cmd_dmode = clic_icb_cmd_usr[USR_PACK_DMODE];
  assign clic_icb_cmd_mmode = clic_icb_cmd_usr[USR_PACK_MMODE];
   `endif
   `ifdef N22_HAS_FIO
  assign fio_icb_cmd_dmode = fio_icb_cmd_usr[USR_PACK_DMODE];
  assign fio_icb_cmd_mmode = fio_icb_cmd_usr[USR_PACK_MMODE];
   `endif
   `ifdef N22_HAS_PPI
  assign ppi_icb_cmd_dmode = ppi_icb_cmd_usr[USR_PACK_DMODE];
  assign ppi_icb_cmd_mmode = ppi_icb_cmd_usr[USR_PACK_MMODE];
   `endif

  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_valid;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_ready;
  wire [BIU_SPLT_I_NUM*`N22_ADDR_SIZE-1:0] splt_bus_icb_cmd_addr;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_read;
  wire [BIU_SPLT_I_NUM*`N22_XLEN-1:0] splt_bus_icb_cmd_wdata;
  wire [BIU_SPLT_I_NUM*`N22_XLEN_MW-1:0] splt_bus_icb_cmd_wmask;
  wire [BIU_SPLT_I_NUM*3-1:0] splt_bus_icb_cmd_burst;
  wire [BIU_SPLT_I_NUM*2-1:0] splt_bus_icb_cmd_beat;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_lock;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_excl;
  wire [BIU_SPLT_I_NUM*2-1:0] splt_bus_icb_cmd_size;
  wire [BIU_SPLT_I_NUM*USR_W-1:0] splt_bus_icb_cmd_usr;

  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_valid;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_ready;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_err;
  wire [BIU_SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_excl_ok;
  wire [BIU_SPLT_I_NUM*`N22_XLEN-1:0] splt_bus_icb_rsp_rdata;

  wire dummy0;
  wire dummy1;
  wire dummy2;
  wire dummy3;
  wire dummy4;
  wire dummy5;
  wire dummy6;
  wire dummy7;
  wire dummy8;
  wire dummy9;
  wire dummy10;
  wire dummy11;
  wire dummy12;
  wire dummy13;
  wire dummy14;
  wire dummy15;
  wire dummy16;

  assign {dummy0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_valid
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_valid
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_valid
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_valid
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_valid};

                           `ifdef N22_HAS_FIO
  wire [`N22_ADDR_SIZE-1:0]   fio_icb_cmd_addr_full;
  assign fio_icb_cmd_addr = fio_icb_cmd_addr_full[`N22_FIO_ADDR_WIDTH-1:0];
                           `endif

  assign {dummy1
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_addr
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_addr
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_addr_full
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_addr
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_addr};

  assign {dummy2
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_read
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_read
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_read
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_read
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_read};

  assign {dummy3
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_wdata
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_wdata
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_wdata
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_wdata
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_wdata};

  assign {dummy4
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_wmask
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_wmask
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_wmask
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_wmask
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_wmask};

  assign {dummy5
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_burst
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_burst
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_burst
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_burst
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_burst};

  assign {dummy6
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_beat
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_beat
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_beat
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_beat
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_beat};

  assign {dummy7
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_lock
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_lock
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_lock
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_lock
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_lock};

  assign {dummy8
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_excl
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_excl
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_excl
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_excl
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_excl};

  assign {dummy9
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_size
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_size
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_size
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_size
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_size};

  assign {dummy10
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_usr
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_usr
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_usr
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_usr
                           `endif
                           } = {1'b0,splt_bus_icb_cmd_usr};

  assign {dummy11,splt_bus_icb_cmd_ready} = {1'b0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_cmd_ready
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_cmd_ready
                           `endif
                           `ifdef N22_HAS_FIO
                           , fio_icb_cmd_ready
                           `endif
                           `ifdef N22_HAS_PPI
                           , ppi_icb_cmd_ready
                           `endif
                           };

  assign {dummy12,splt_bus_icb_rsp_valid} = {1'b0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_rsp_valid
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_rsp_valid
                           `endif
                           `ifdef N22_HAS_FIO
                           , i_fio_icb_rsp_valid
                           `endif
                           `ifdef N22_HAS_PPI
                           , i_ppi_icb_rsp_valid
                           `endif
                           };

  assign {dummy13,splt_bus_icb_rsp_err} = {1'b0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_rsp_err
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_rsp_err
                           `endif
                           `ifdef N22_HAS_FIO
                           , i_fio_icb_rsp_err
                           `endif
                           `ifdef N22_HAS_PPI
                           , i_ppi_icb_rsp_err
                           `endif
                           };

  assign {dummy14,splt_bus_icb_rsp_excl_ok} = {1'b0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_rsp_excl_ok
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_rsp_excl_ok
                           `endif
                           `ifdef N22_HAS_FIO
                           , i_fio_icb_rsp_excl_ok
                           `endif
                           `ifdef N22_HAS_PPI
                           , i_ppi_icb_rsp_excl_ok
                           `endif
                           };

  assign {dummy15,splt_bus_icb_rsp_rdata} = {1'b0
                           `ifdef N22_HAS_CLIC
                           , clic_icb_rsp_rdata
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_rsp_rdata
                           `endif
                           `ifdef N22_HAS_FIO
                           , i_fio_icb_rsp_rdata
                           `endif
                           `ifdef N22_HAS_PPI
                           , i_ppi_icb_rsp_rdata
                           `endif
                           };

  assign {dummy16
                           `ifdef N22_HAS_CLIC
                           , clic_icb_rsp_ready
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , tmr_icb_rsp_ready
                           `endif
                           `ifdef N22_HAS_FIO
                           , i_fio_icb_rsp_ready
                           `endif
                           `ifdef N22_HAS_PPI
                           , i_ppi_icb_rsp_ready
                           `endif
                           } = {1'b0,splt_bus_icb_rsp_ready};

  `ifdef N22_TMR_PRIVATE
  wire buf_icb_cmd_tmr = buf_icb_cmd_usr[USR_PACK_TMR];
  wire buf_icb_sel_tmr = buf_icb_cmd_tmr;
  `endif

  `ifdef N22_HAS_CLIC
  wire buf_icb_cmd_clic = buf_icb_cmd_usr[USR_PACK_CLIC];
  wire buf_icb_sel_clic = buf_icb_cmd_clic;
  `endif

  `ifdef N22_HAS_FIO
  wire buf_icb_cmd_fio = buf_icb_cmd_usr[USR_PACK_FIO];
  wire buf_icb_sel_fio = buf_icb_cmd_fio;
  `endif

  `ifdef N22_HAS_PPI
  wire buf_icb_cmd_ppi = buf_icb_cmd_usr[USR_PACK_PPI];
  wire buf_icb_sel_ppi = buf_icb_cmd_ppi;
  `endif



  wire dummy00;
  wire [BIU_SPLT_I_NUM-1:0] buf_icb_splt_indic;

  assign {dummy00, buf_icb_splt_indic} =
      {                    1'b0
                           `ifdef N22_HAS_CLIC
                           , buf_icb_sel_clic
                           `endif
                           `ifdef N22_TMR_PRIVATE
                           , buf_icb_sel_tmr
                           `endif
                           `ifdef N22_HAS_FIO
                           , buf_icb_sel_fio
                           `endif
                           `ifdef N22_HAS_PPI
                           , buf_icb_sel_ppi
                           `endif
      };

  n22_gnrl_icb_splt # (
  .ALLOW_DIFF (1),
  .ALLOW_0CYCL_RSP (1),
  .FIFO_OUTS_NUM   (`N22_LSU_OUTS_NUM),
  .FIFO_CUT_READY  (`N22_BIU_CMD_CUT_READY),
  .SPLT_NUM   (BIU_SPLT_I_NUM),
  .SPLT_PTR_W (BIU_SPLT_I_NUM),
  .SPLT_PTR_1HOT (1),
  .VLD_MSK_PAYLOAD(1),
  .USR_W      (USR_W),
  .AW         (`N22_ADDR_SIZE),
  .DW         (`N22_XLEN)
  ) u_lbiu_icb_splt(
  .i_icb_splt_indic       (buf_icb_splt_indic),

  .i_icb_cmd_valid        (buf_icb_cmd_valid )     ,
  .i_icb_cmd_ready        (buf_icb_cmd_ready )     ,
  .i_icb_cmd_read         (buf_icb_cmd_read )      ,
  .i_icb_cmd_addr         (buf_icb_cmd_addr )      ,
  .i_icb_cmd_wdata        (buf_icb_cmd_wdata )     ,
  .i_icb_cmd_wmask        (buf_icb_cmd_wmask)      ,
  .i_icb_cmd_burst        (buf_icb_cmd_burst)     ,
  .i_icb_cmd_beat         (buf_icb_cmd_beat )     ,
  .i_icb_cmd_excl         (buf_icb_cmd_excl )     ,
  .i_icb_cmd_lock         (buf_icb_cmd_lock )     ,
  .i_icb_cmd_size         (buf_icb_cmd_size )     ,
  .i_icb_cmd_usr          (buf_icb_cmd_usr  )     ,

  .i_icb_rsp_valid        (buf_icb_rsp_valid )     ,
  .i_icb_rsp_ready        (buf_icb_rsp_ready )     ,
  .i_icb_rsp_err          (buf_icb_rsp_err)        ,
  .i_icb_rsp_excl_ok      (buf_icb_rsp_excl_ok)    ,
  .i_icb_rsp_rdata        (buf_icb_rsp_rdata )     ,
  .i_icb_rsp_usr          ( )     ,

  .o_bus_icb_cmd_ready    (splt_bus_icb_cmd_ready ) ,
  .o_bus_icb_cmd_valid    (splt_bus_icb_cmd_valid ) ,
  .o_bus_icb_cmd_read     (splt_bus_icb_cmd_read )  ,
  .o_bus_icb_cmd_addr     (splt_bus_icb_cmd_addr )  ,
  .o_bus_icb_cmd_wdata    (splt_bus_icb_cmd_wdata ) ,
  .o_bus_icb_cmd_wmask    (splt_bus_icb_cmd_wmask)  ,
  .o_bus_icb_cmd_burst    (splt_bus_icb_cmd_burst),
  .o_bus_icb_cmd_beat     (splt_bus_icb_cmd_beat ),
  .o_bus_icb_cmd_excl     (splt_bus_icb_cmd_excl ),
  .o_bus_icb_cmd_lock     (splt_bus_icb_cmd_lock ),
  .o_bus_icb_cmd_size     (splt_bus_icb_cmd_size ),
  .o_bus_icb_cmd_usr      (splt_bus_icb_cmd_usr  ),

  .o_bus_icb_rsp_valid    (splt_bus_icb_rsp_valid ) ,
  .o_bus_icb_rsp_ready    (splt_bus_icb_rsp_ready ) ,
  .o_bus_icb_rsp_err      (splt_bus_icb_rsp_err)    ,
  .o_bus_icb_rsp_excl_ok  (splt_bus_icb_rsp_excl_ok),
  .o_bus_icb_rsp_rdata    (splt_bus_icb_rsp_rdata ) ,
  .o_bus_icb_rsp_usr      ({BIU_SPLT_I_NUM*USR_W{1'b0}}) ,

  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );


  assign lbiu_active = lsu2lbiu_icb_cmd_valid | icb_buffer_active;


  `ifdef N22_HAS_PPI

      `ifdef N22_PPI_TYPE_APB
  assign ppi_icb_rsp_excl_ok = 1'b0;

  n22_gnrl_icb2apb # (
    .AW(`N22_PPI_ADDR_WIDTH),
    .DW(`N22_XLEN)
  ) u_ppi_icb2apb (
    .icb_cmd_valid (ppi_icb_cmd_valid),
    .icb_cmd_ready (ppi_icb_cmd_ready),
    .icb_cmd_read  (ppi_icb_cmd_read ),
    .icb_cmd_addr  (ppi_icb_cmd_addr[`N22_PPI_ADDR_WIDTH-1:0] ),
    .icb_cmd_wdata (ppi_icb_cmd_wdata),
    .icb_cmd_wmask (ppi_icb_cmd_wmask),
    .icb_cmd_size  (ppi_icb_cmd_size ),
    .icb_cmd_dmode (ppi_icb_cmd_dmode),
    .icb_cmd_mmode (ppi_icb_cmd_mmode),

    .icb_rsp_valid (ppi_icb_rsp_valid),
    .icb_rsp_err   (ppi_icb_rsp_err  ),
    .icb_rsp_rdata (ppi_icb_rsp_rdata),

    .apb_paddr     (ppi_apb_paddr     ),
    .apb_pwrite    (ppi_apb_pwrite    ),
    .apb_dmode     (ppi_apb_dmode     ),
    .apb_pprot     (ppi_apb_pprot     ),
    .apb_pstrobe   (ppi_apb_pstrobe   ),
    .apb_psel      (ppi_apb_psel      ),
    .apb_penable   (ppi_apb_penable   ),
    .apb_pwdata    (ppi_apb_pwdata    ),
    .apb_prdata    (ppi_apb_prdata    ),
    .apb_pready    (ppi_apb_pready ),
    .apb_pslverr   (ppi_apb_pslverr),

    .clk           (clk  ),
    .rst_n         (rst_n)
  );

      `endif

  `endif


endmodule

`endif
