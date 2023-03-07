
`include "global.inc"

`ifdef N22_HAS_ILM

  `ifdef N22_ILM_MASTER_SRAM
    `ifdef N22_ILM_MASTER_AHBL
       `Error!!! The ILM master interface have been configured to SRAM type, cannot be configured to AHB-Lite again.
    `endif
    `ifdef N22_ILM_MASTER_ICB
       `Error!!! The ILM master interface have been configured to SRAM type, cannot be configured to ICB again.
    `endif
  `endif

  `ifdef N22_ILM_MASTER_ICB
    `ifdef N22_ILM_MASTER_AHBL
       `Error!!! The ILM master interface have been configured to ICB type, cannot be configured to AHB-Lite again.
    `endif
    `ifdef N22_ILM_MASTER_SRAM
       `Error!!! The ILM master interface have been configured to ICB type, cannot be configured to SRAM again.
    `endif
  `endif

  `ifdef N22_ILM_MASTER_AHBL
    `ifdef N22_ILM_MASTER_SRAM
       `Error!!! The ILM master interface have been configured to AHB-Lite type, cannot be configured to SRAM again.
    `endif
    `ifdef N22_ILM_MASTER_ICB
       `Error!!! The ILM master interface have been configured to AHB-Lite type, cannot be configured to ICB again.
    `endif
  `endif


module n22_ilm_ctrl
 #(
    parameter ECM_OUT_NUM = 1,
    parameter AW = 32,
    parameter DW = 32,
    parameter MW = 4,
    parameter RAM_AW = 16,
    parameter RAM_DW = 32,
    parameter RAM_MW = 4,
    parameter RAM_ECC_DW = 7,
    parameter RAM_ECC_MW = 1
    )
  (
  output ilm_active,
  input  tcm_cgstop,

  input  lsu2dlm_icb_cmd_sel,

  `ifdef N22_D_SHARE_ILM
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
  `endif

  input  ifu_icb_cmd_valid,
  output ifu_icb_cmd_ready,
  input  [AW-1:0] ifu_icb_cmd_addr,
  input  ifu_icb_cmd_mmode,
  input  ifu_icb_cmd_dmode,
  input  ifu_icb_cmd_vmode,

  output ifu_icb_rsp_valid,
  output ifu_icb_rsp_err,
  output [DW-1:0] ifu_icb_rsp_rdata,


  `ifdef N22_ILM_MASTER_SRAM
  output              ram_cs,
  output [RAM_AW-1:0] ram_addr,
  output [RAM_MW-1:0] ram_wem,
  output [RAM_DW-1:0] ram_din,
  input  [RAM_DW-1:0] ram_dout,
  output              clk_ram,
  `endif

  `ifdef N22_ILM_MASTER_AHBL
  output [1:0]       ram_ahbl_htrans,
  output [AW    -1:0]ram_ahbl_haddr,
  output [2:0]       ram_ahbl_hsize,
  output [2:0]       ram_ahbl_hburst,
  output [3:0]       ram_ahbl_hprot,
  output [1:0]       ram_ahbl_hattri,
  output [1:0]       ram_ahbl_master,
  output             ram_ahbl_hwrite,
  output             ram_ahbl_hmastlock,
  output [DW    -1:0]ram_ahbl_hwdata,
  input  [DW    -1:0]ram_ahbl_hrdata,
  input  [1:0]       ram_ahbl_hresp,
  input              ram_ahbl_hready,
  `endif

  `ifdef N22_ILM_MASTER_ICB
  output             ram_icb_cmd_valid,
  input              ram_icb_cmd_ready,
  output [AW-1:0]    ram_icb_cmd_addr,
  output [2-1:0]     ram_icb_cmd_size,
  output             ram_icb_cmd_mmode,
  output             ram_icb_cmd_dmode,

  input              ram_icb_rsp_valid,
  output             ram_icb_rsp_ready,
  input              ram_icb_rsp_err,
  input  [DW-1:0]    ram_icb_rsp_rdata,
  `endif


  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );


  wire icb_cmd_valid;
  wire icb_cmd_ready;
  wire s0;
  wire [AW-1:0] s1;
  wire s2;
  wire s3;
  wire s4;
  wire s5;
  wire [DW-1:0] s6;
  wire [MW-1:0] s7;
  wire [2-1:0] s8;

  wire icb_rsp_valid;
  wire icb_rsp_ready = 1'b1;
  wire s9;
  wire [DW-1:0] s10;

  `ifdef N22_D_SHARE_ILM
  wire ilm_arbt_active;

  n22_ilm_arbt u_n22_ilm_arbt(

     .ilm_arbt_active(ilm_arbt_active),

     .lsu2ilm_icb_cmd_sel (lsu2ilm_icb_cmd_sel),

     .lsu2ilm_icb_cmd_valid(lsu2ilm_icb_cmd_valid),
     .lsu2ilm_icb_cmd_ready(lsu2ilm_icb_cmd_ready),
     .lsu2ilm_icb_cmd_addr (lsu2ilm_icb_cmd_addr ),
     .lsu2ilm_icb_cmd_read (lsu2ilm_icb_cmd_read ),
     .lsu2ilm_icb_cmd_wdata(lsu2ilm_icb_cmd_wdata),
     .lsu2ilm_icb_cmd_wmask(lsu2ilm_icb_cmd_wmask),
     .lsu2ilm_icb_cmd_lock (lsu2ilm_icb_cmd_lock ),
     .lsu2ilm_icb_cmd_excl (lsu2ilm_icb_cmd_excl ),
     .lsu2ilm_icb_cmd_size (lsu2ilm_icb_cmd_size ),
     .lsu2ilm_icb_cmd_dmode (lsu2ilm_icb_cmd_dmode ),
     .lsu2ilm_icb_cmd_mmode (lsu2ilm_icb_cmd_mmode ),

     .lsu2ilm_icb_rsp_valid  (lsu2ilm_icb_rsp_valid  ),
     .lsu2ilm_icb_rsp_ready  (lsu2ilm_icb_rsp_ready  ),
     .lsu2ilm_icb_rsp_err    (lsu2ilm_icb_rsp_err    ),
     .lsu2ilm_icb_rsp_excl_ok(lsu2ilm_icb_rsp_excl_ok),
     .lsu2ilm_icb_rsp_rdata  (lsu2ilm_icb_rsp_rdata  ),

     .ifu_icb_cmd_valid (ifu_icb_cmd_valid),
     .ifu_icb_cmd_ready (ifu_icb_cmd_ready),
     .ifu_icb_cmd_addr  (ifu_icb_cmd_addr ),
     .ifu_icb_cmd_mmode (ifu_icb_cmd_mmode),
     .ifu_icb_cmd_dmode (ifu_icb_cmd_dmode),
     .ifu_icb_cmd_vmode (ifu_icb_cmd_vmode),

     .ifu_icb_rsp_valid (ifu_icb_rsp_valid),
     .ifu_icb_rsp_err   (ifu_icb_rsp_err  ),
     .ifu_icb_rsp_rdata (ifu_icb_rsp_rdata),


     .ilm_icb_cmd_valid (icb_cmd_valid),
     .ilm_icb_cmd_ready (icb_cmd_ready),
     .ilm_icb_cmd_addr  (s1 ),
     .ilm_icb_cmd_read  (s0 ),
     .ilm_icb_cmd_mmode (s2),
     .ilm_icb_cmd_dmode (s3),
     .ilm_icb_cmd_vmode (s4),
     .ilm_icb_cmd_instr (s5),
     .ilm_icb_cmd_wdata (s6),
     .ilm_icb_cmd_wmask (s7),
     .ilm_icb_cmd_size  (s8 ),

     .ilm_icb_rsp_valid (icb_rsp_valid),
     .ilm_icb_rsp_err   (s9  ),
     .ilm_icb_rsp_rdata (s10),

     .clk  (clk  ),
     .rst_n(rst_n)
  );


  `else
  assign ifu_icb_cmd_ready = icb_cmd_ready;
  assign icb_cmd_valid = ifu_icb_cmd_valid;

  assign s1  = ifu_icb_cmd_addr;
  assign s2 = ifu_icb_cmd_mmode;
  assign s3 = ifu_icb_cmd_dmode;
  assign s4 = ifu_icb_cmd_vmode;
  assign s5 = ~ifu_icb_cmd_vmode;

  assign ifu_icb_rsp_valid = icb_rsp_valid;
  assign ifu_icb_rsp_err   = s9  ;
  assign ifu_icb_rsp_rdata = s10;

  assign s0 = 1'b1;
  assign s6 = {DW{1'b0}};
  assign s7 = {MW{1'b0}};
  assign s8 = `N22_IFU2BIU_SIZE_TYPE;

  `endif












  wire i_icb_cmd_valid;
  wire i_icb_cmd_ready;

  `ifdef N22_ILM_DLM_EXCLUSIVE
  assign i_icb_cmd_valid = (~lsu2dlm_icb_cmd_sel) & icb_cmd_valid;
  assign icb_cmd_ready   = (~lsu2dlm_icb_cmd_sel) & i_icb_cmd_ready;
  `else
  assign i_icb_cmd_valid = icb_cmd_valid;
  assign icb_cmd_ready   = i_icb_cmd_ready;
  `endif





  `ifndef N22_HAS_ECC
  n22_lm_icb_ctrl #(
      .I_OR_D (1),
      .DW     (DW),
      .AW     (AW),
      .MW     (MW),
      .AW_LSB (2)
  ) u_n22_ilm_icb_ctrl(
     .tcm_cgstop       (tcm_cgstop),

     .i_icb_cmd_valid (i_icb_cmd_valid),
     .i_icb_cmd_ready (i_icb_cmd_ready),
     .i_icb_cmd_read  (s0 ),
     .i_icb_cmd_addr  (s1 ),
     .i_icb_cmd_size  (s8 ),
     .i_icb_cmd_mmode (s2),
     .i_icb_cmd_dmode (s3),
     .i_icb_cmd_vmode (s4),
     .i_icb_cmd_instr (s5),
     .i_icb_cmd_wdata (s6),
     .i_icb_cmd_wmask (s7),

     .i_icb_rsp_valid (icb_rsp_valid),
     .i_icb_rsp_ready (icb_rsp_ready),
     .i_icb_rsp_rdata (s10),
     .i_icb_rsp_err   (s9),

  `ifdef N22_ILM_MASTER_SRAM
     .ram_cs   (ram_cs  ),
     .ram_addr (ram_addr),
     .ram_wem  (ram_wem ),
     .ram_din  (ram_din ),
     .ram_dout (ram_dout),
     .clk_ram  (clk_ram ),
  `endif

  `ifdef N22_ILM_MASTER_AHBL
     .ram_ahbl_htrans (ram_ahbl_htrans),
     .ram_ahbl_hwrite (ram_ahbl_hwrite),
     .ram_ahbl_haddr  (ram_ahbl_haddr ),
     .ram_ahbl_hsize  (ram_ahbl_hsize ),
     .ram_ahbl_hburst (ram_ahbl_hburst),
     .ram_ahbl_hprot  (ram_ahbl_hprot ),
     .ram_ahbl_hattri (ram_ahbl_hattri),
     .ram_ahbl_master (ram_ahbl_master),
     .ram_ahbl_hlock  (ram_ahbl_hmastlock),
     .ram_ahbl_hwdata (ram_ahbl_hwdata),
     .ram_ahbl_hrdata (ram_ahbl_hrdata),
     .ram_ahbl_hresp  (ram_ahbl_hresp ),
     .ram_ahbl_hready (ram_ahbl_hready),
  `endif

  `ifdef N22_ILM_MASTER_ICB
     .ram_icb_cmd_valid (ram_icb_cmd_valid),
     .ram_icb_cmd_ready (ram_icb_cmd_ready),
     .ram_icb_cmd_read  (),
     .ram_icb_cmd_addr  (ram_icb_cmd_addr ),
     .ram_icb_cmd_size  (ram_icb_cmd_size ),
     .ram_icb_cmd_wdata (),
     .ram_icb_cmd_wmask (),

     .ram_icb_rsp_valid (ram_icb_rsp_valid),
     .ram_icb_rsp_ready (ram_icb_rsp_ready),
     .ram_icb_rsp_rdata (ram_icb_rsp_rdata),
     .ram_icb_rsp_err   (ram_icb_rsp_err),
  `endif

     .clkgate_bypass(clkgate_bypass  ),
     .clk  (clk  ),
     .rst_n(rst_n)
    );

  `endif





  wire icb_active;

  n22_gnrl_icb_active # (
    .OUTS_CNT_W(ECM_OUT_NUM)
  ) u_icb_active(

      .icb_active    (icb_active),

      .icb_cmd_valid (icb_cmd_valid),
      .icb_cmd_ready (icb_cmd_ready),

      .icb_rsp_valid (icb_rsp_valid),
      .icb_rsp_ready (icb_rsp_ready),

      .clk           (clk  ),
      .rst_n         (rst_n)
  );


  assign ilm_active = icb_active
          `ifdef N22_D_SHARE_ILM
                    | ilm_arbt_active
          `else
          `endif
                    ;


endmodule

`endif
