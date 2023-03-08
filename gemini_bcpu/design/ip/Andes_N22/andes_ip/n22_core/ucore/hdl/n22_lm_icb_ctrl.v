
`include "global.inc"

`ifdef N22_HAS_LM

module n22_lm_icb_ctrl #(
    parameter I_OR_D = 0,
    parameter DW = 32,
    parameter MW = 4,
    parameter AW = 32,
    parameter AW_LSB = 2
)(
  input  tcm_cgstop,

  input  i_icb_cmd_valid,
  output i_icb_cmd_ready,
  input  i_icb_cmd_read,
  input  [AW-1:0] i_icb_cmd_addr,
  input  [DW-1:0] i_icb_cmd_wdata,
  input  [MW-1:0] i_icb_cmd_wmask,
  input  [2-1:0] i_icb_cmd_size,
  input  i_icb_cmd_mmode,
  input  i_icb_cmd_dmode,
  input  i_icb_cmd_vmode,
  input  i_icb_cmd_instr,

  output i_icb_rsp_valid,
  input  i_icb_rsp_ready,
  output [DW-1:0] i_icb_rsp_rdata,
  output i_icb_rsp_err,

  `ifdef N22_LM_MASTER_SRAM
  output          ram_cs,
  output [AW-AW_LSB-1:0] ram_addr,
  output [MW-1:0] ram_wem,
  output [DW-1:0] ram_din,
  input  [DW-1:0] ram_dout,
  output          clk_ram,
  `endif

  `ifdef N22_LM_MASTER_AHBL
  output [1:0]       ram_ahbl_htrans,
  output             ram_ahbl_hwrite,
  output [AW    -1:0]ram_ahbl_haddr,
  output [2:0]       ram_ahbl_hsize,
  output [2:0]       ram_ahbl_hburst,
  output [3:0]       ram_ahbl_hprot,
  output [1:0]       ram_ahbl_hattri,
  output [1:0]       ram_ahbl_master,
  output             ram_ahbl_hlock,
  output [DW    -1:0]ram_ahbl_hwdata,
  input  [DW    -1:0]ram_ahbl_hrdata,
  input  [1:0]       ram_ahbl_hresp,
  input              ram_ahbl_hready,
  `endif

  `ifdef N22_LM_MASTER_ICB
  output             ram_icb_cmd_valid,
  input              ram_icb_cmd_ready,
  output [1-1:0]     ram_icb_cmd_read,
  output [AW-1:0]    ram_icb_cmd_addr,
  output [DW-1:0]    ram_icb_cmd_wdata,
  output [MW-1:0]  ram_icb_cmd_wmask,
  output [2-1:0]     ram_icb_cmd_size,

  input              ram_icb_rsp_valid,
  output             ram_icb_rsp_ready,
  input              ram_icb_rsp_err,
  input  [DW-1:0]    ram_icb_rsp_rdata,
  `endif

  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );




  n22_lm_sram_ctrl #(
      .I_OR_D (I_OR_D),
      .DW     (DW),
      .AW     (AW),
      .MW     (MW),
      .AW_LSB (AW_LSB)
  ) u_n22_lm_sram_ctrl(
     .tcm_cgstop       (tcm_cgstop),


     .uop_cmd_valid (i_icb_cmd_valid),
     .uop_cmd_ready (i_icb_cmd_ready),
     .uop_cmd_read  (i_icb_cmd_read ),
     .uop_cmd_addr  (i_icb_cmd_addr ),
     .uop_cmd_wdata (i_icb_cmd_wdata),
     .uop_cmd_wmask (i_icb_cmd_wmask),
     .uop_cmd_size  (i_icb_cmd_size ),
     .uop_cmd_mmode (i_icb_cmd_mmode),
     .uop_cmd_dmode (i_icb_cmd_dmode),
     .uop_cmd_vmode (i_icb_cmd_vmode),
     .uop_cmd_instr (i_icb_cmd_instr),

     .uop_rsp_valid (i_icb_rsp_valid),
     .uop_rsp_ready (i_icb_rsp_ready),
     .uop_rsp_rdata (i_icb_rsp_rdata),
     .uop_rsp_err   (i_icb_rsp_err  ),

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
     .ram_ahbl_hlock  (ram_ahbl_hlock),
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
     .ram_icb_cmd_addr  (ram_icb_cmd_addr ),
     .ram_icb_cmd_wdata (ram_icb_cmd_wdata),
     .ram_icb_cmd_wmask (ram_icb_cmd_wmask),
     .ram_icb_cmd_size  (ram_icb_cmd_size ),

     .ram_icb_rsp_valid (ram_icb_rsp_valid),
     .ram_icb_rsp_ready (ram_icb_rsp_ready),
     .ram_icb_rsp_rdata (ram_icb_rsp_rdata),
     .ram_icb_rsp_err   (ram_icb_rsp_err  ),
  `endif

     .clkgate_bypass(clkgate_bypass  ),
     .clk  (clk  ),
     .rst_n(rst_n)
    );


endmodule

`endif
