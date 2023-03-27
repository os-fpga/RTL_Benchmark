
`include "global.inc"

`ifdef N22_HAS_DLM

  `ifdef N22_LM_MASTER_SRAM
    `ifdef N22_LM_MASTER_AHBL
       `Error!!! The DLM master interface have been configured to SRAM type, cannot be configured to AHB-Lite again.
    `endif
    `ifdef N22_LM_MASTER_ICB
       `Error!!! The DLM master interface have been configured to SRAM type, cannot be configured to ICB again.
    `endif
  `endif

  `ifdef N22_LM_MASTER_ICB
    `ifdef N22_LM_MASTER_AHBL
       `Error!!! The DLM master interface have been configured to ICB type, cannot be configured to AHB-Lite again.
    `endif
    `ifdef N22_LM_MASTER_SRAM
       `Error!!! The DLM master interface have been configured to ICB type, cannot be configured to SRAM again.
    `endif
  `endif

  `ifdef N22_LM_MASTER_AHBL
    `ifdef N22_LM_MASTER_SRAM
       `Error!!! The DLM master interface have been configured to AHB-Lite type, cannot be configured to SRAM again.
    `endif
    `ifdef N22_LM_MASTER_ICB
       `Error!!! The DLM master interface have been configured to AHB-Lite type, cannot be configured to ICB again.
    `endif
  `endif


module n22_dlm_ctrl
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
  output dlm_active,
  input  tcm_cgstop,


  input  icb_cmd_valid,
  output icb_cmd_ready,
  input  [AW-1:0]   icb_cmd_addr,
  input  icb_cmd_read,
  input  [DW-1:0] icb_cmd_wdata,
  input  [MW-1:0] icb_cmd_wmask,
  input  [2-1:0] icb_cmd_size,
  input  icb_cmd_mmode,
  input  icb_cmd_dmode,

  output icb_rsp_valid,
  input  icb_rsp_ready,
  output icb_rsp_err,
  output [DW-1:0] icb_rsp_rdata,
  output icb_rsp_excl_ok,


  `ifdef N22_LM_MASTER_SRAM
  output              ram_cs,
  output [RAM_AW-1:0] ram_addr,
  output [RAM_MW-1:0] ram_wem,
  output [RAM_DW-1:0] ram_din,
  input  [RAM_DW-1:0] ram_dout,
  output              clk_ram,
  `endif

  `ifdef N22_LM_MASTER_AHBL
  output [1:0]       ram_ahbl_htrans,
  output             ram_ahbl_hwrite,
  output             ram_ahbl_hmastlock,
  output [AW    -1:0]ram_ahbl_haddr,
  output [2:0]       ram_ahbl_hsize,
  output [2:0]       ram_ahbl_hburst,
  output [3:0]       ram_ahbl_hprot,
  output [1:0]       ram_ahbl_hattri,
  output [1:0]       ram_ahbl_master,
  output [DW    -1:0]ram_ahbl_hwdata,
  input  [DW    -1:0]ram_ahbl_hrdata,
  input  [1:0]       ram_ahbl_hresp,
  input              ram_ahbl_hready,
  `endif

  `ifdef N22_LM_MASTER_ICB
  output             ram_icb_cmd_valid,
  input              ram_icb_cmd_ready,
  output             ram_icb_cmd_read,
  output             ram_icb_cmd_mmode,
  output             ram_icb_cmd_dmode,
  output [AW-1:0]    ram_icb_cmd_addr,
  output [2-1:0]     ram_icb_cmd_size,
  output [DW-1:0]    ram_icb_cmd_wdata,
  output [MW-1:0]  ram_icb_cmd_wmask,

  input              ram_icb_rsp_valid,
  output             ram_icb_rsp_ready,
  input              ram_icb_rsp_err,
  input  [DW-1:0]    ram_icb_rsp_rdata,
  `endif


  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );

  wire s0;
  wire s1;
  wire [AW-1:0]   s2;
  wire s3;
  wire [DW-1:0] s4;
  wire [MW-1:0] s5;
  wire [2-1:0] s6;
  wire s7;
  wire s8;

  wire s9;
  wire s10;
  wire s11;
  wire [DW-1:0] s12;
  wire s13;



  assign s0 = icb_cmd_valid;
  assign icb_cmd_ready = s1;

  assign s2   = icb_cmd_addr  ;
  assign s3   = icb_cmd_read  ;
  assign s4  = icb_cmd_wdata ;
  assign s5  = icb_cmd_wmask ;
  assign s6   = icb_cmd_size  ;
  assign s7  = icb_cmd_mmode ;
  assign s8  = icb_cmd_dmode ;

  assign icb_rsp_valid   = s9  ;
  assign s10   = icb_rsp_ready  ;
  assign icb_rsp_err     = s11    ;
  assign icb_rsp_excl_ok = s13;
  assign icb_rsp_rdata   = s12  ;







  wire s14;
  wire s15;
  wire s16;
  wire [DW-1:0] s17;
  wire s18;


  wire [DW+2-1:0]s19;
  wire [DW+2-1:0]s20;

  assign s19 = {
                          s18,
                          s16,
                          s17
                          };

  assign {
                          s13,
                          s11,
                          s12
                          } = s20;




  assign s20 = s19;
  assign s9 = s14;
  assign s15 = s10;



  `ifndef N22_HAS_ECC
  n22_lm_icb_ctrl #(
      .I_OR_D (0),
      .DW     (DW),
      .AW     (AW),
      .MW     (MW),
      .AW_LSB (2)
  ) u_n22_icb_ctrl(
     .tcm_cgstop       (tcm_cgstop),

     .i_icb_cmd_valid (s0),
     .i_icb_cmd_ready (s1),
     .i_icb_cmd_read  (s3 ),
     .i_icb_cmd_addr  (s2 ),
     .i_icb_cmd_size  (s6 ),
     .i_icb_cmd_mmode (s7 ),
     .i_icb_cmd_dmode (s8 ),
     .i_icb_cmd_vmode (1'b0),
     .i_icb_cmd_instr (1'b0),
     .i_icb_cmd_wdata (s4),
     .i_icb_cmd_wmask (s5),

     .i_icb_rsp_valid (s14),
     .i_icb_rsp_ready (s15),
     .i_icb_rsp_rdata (s17),
     .i_icb_rsp_err   (s16),

  `ifdef N22_LM_MASTER_SRAM
     .ram_cs   (ram_cs  ),
     .ram_addr (ram_addr),
     .ram_wem  (ram_wem ),
     .ram_din  (ram_din ),
     .ram_dout (ram_dout),
     .clk_ram  (clk_ram ),
  `endif

  `ifdef N22_LM_MASTER_AHBL
     .ram_ahbl_htrans (ram_ahbl_htrans),
     .ram_ahbl_hwrite (ram_ahbl_hwrite),
     .ram_ahbl_hlock  (ram_ahbl_hmastlock),
     .ram_ahbl_haddr  (ram_ahbl_haddr ),
     .ram_ahbl_hsize  (ram_ahbl_hsize ),
     .ram_ahbl_hburst (ram_ahbl_hburst),
     .ram_ahbl_hprot  (ram_ahbl_hprot ),
     .ram_ahbl_hattri (ram_ahbl_hattri),
     .ram_ahbl_master (ram_ahbl_master),
     .ram_ahbl_hwdata (ram_ahbl_hwdata),
     .ram_ahbl_hrdata (ram_ahbl_hrdata),
     .ram_ahbl_hresp  (ram_ahbl_hresp ),
     .ram_ahbl_hready (ram_ahbl_hready),
  `endif

  `ifdef N22_LM_MASTER_ICB
     .ram_icb_cmd_valid (ram_icb_cmd_valid),
     .ram_icb_cmd_ready (ram_icb_cmd_ready),
     .ram_icb_cmd_read  (ram_icb_cmd_read ),
     .ram_icb_cmd_mmode (ram_icb_cmd_mmode),
     .ram_icb_cmd_dmode (ram_icb_cmd_dmode),
     .ram_icb_cmd_addr  (ram_icb_cmd_addr ),
     .ram_icb_cmd_size  (ram_icb_cmd_size ),
     .ram_icb_cmd_wdata (ram_icb_cmd_wdata),
     .ram_icb_cmd_wmask (ram_icb_cmd_wmask),

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




  wire s21;

  n22_gnrl_icb_active # (
    .OUTS_CNT_W(ECM_OUT_NUM)
  ) u_lsu_icb_active(

      .icb_active    (s21),

      .icb_cmd_valid (s0),
      .icb_cmd_ready (s1),

      .icb_rsp_valid (s9),
      .icb_rsp_ready (s10),

      .clk           (clk  ),
      .rst_n         (rst_n)
  );



  assign dlm_active = s21 ;

  assign s18 = 1'b0;

endmodule
  `endif

