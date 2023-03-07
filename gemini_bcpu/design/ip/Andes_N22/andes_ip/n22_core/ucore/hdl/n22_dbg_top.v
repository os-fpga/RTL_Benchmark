

`include "global.inc"

`ifdef N22_HAS_DEBUG
module n22_dbg_top (

    `ifndef N22_HAS_DEBUG_PRIVATE
  input  debugint,
    `endif

    `ifdef N22_HAS_DEBUG_PRIVATE
  input   core_clk_dbg,
  output  dbg_active,
  output  tap_dmi_active,
  input   dbg_sleep,
  output  dmactive,

  input  hart_unavail,
  input  hart_under_reset,
  input  jtag_tdi_in,
  output jtag_tdi_out,
  output jtag_tdi_out_en,
  input  jtag_tdo_in,
  output jtag_tdo_out,
  output jtag_tdo_out_en,
  input  jtag_tms_in,
  output jtag_tms_out,
  output jtag_tms_out_en,
  input  jtag_trst_in,
  output jtag_trst_out,
  output jtag_trst_out_en,
  input  jtag_tck,

  input  por_reset_n,
  input  reset_bypass,
  input  clkgate_bypass,
  input  disable_ext_debugger,

  output resethaltreq,
  output dbg_srst_req,
    `endif

  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,
  input wbck_csr_wen,
  input  [`N22_XLEN-1:0] wbck_csr_dat,
  output [`N22_XLEN-1:0] read_csr_dat,
  output csr_addr_legal,
  output csr_prv_ilgl,

  input   [`N22_PC_SIZE-1:0] cmt_dpc,
  input   cmt_dpc_ena,

  input   [3-1:0] cmt_dcause,
  input   cmt_dcause_ena,

  output  [`N22_XLEN-1:0] dbg_dexc2dbg_r,
  input   [`N22_XLEN-1:0] cmt_ddcause,
  input   cmt_ddcause_ena,


  input  cmt_dprv_ena,
  input  [2-1:0] cmt_dprv,
  output [2-1:0] dbg_prv_r,


`ifdef N22_HAS_TRIGM
  output [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  output [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  input  icount_taken_ena,
`endif


  output dbg_mode,
  output dbg_step_r,
  output dbg_ebreakm_r,
  output dbg_stopcount,
  output dbg_stoptime ,

  output dbg_halt,

  output dbg_ebreaku_r,
  output dbg_stepie,
  output dbg_mprven,
  input  nmi_irq_r,

  output [`N22_XLEN-1:0] csr_dpc_r,


    `ifdef N22_HAS_DEBUG_PRIVATE
  input              dm_ahbl_active,
  input [1:0]        dm_ahbl_htrans,
  input              dm_ahbl_hwrite,
  input [`N22_ADDR_SIZE    -1:0] dm_ahbl_haddr,
  input [2:0]        dm_ahbl_hsize,
  input [2:0]        dm_ahbl_hburst,
  input [3:0]        dm_ahbl_hprot,
  input [`N22_XLEN    -1:0] dm_ahbl_hwdata,
  output [`N22_XLEN    -1:0] dm_ahbl_hrdata,
  output [1:0]        dm_ahbl_hresp,
  output              dm_ahbl_hready,
    `endif



  input   clk_csr,
  input   rst_csr
);

parameter DEBUG_INTERFACE	= "jtag";
parameter PROGBUF_SIZE	        = 8;

    `ifdef N22_HAS_DEBUG_PRIVATE
  wire debugint;
    `endif

  assign dbg_halt = debugint;


  n22_dbg_csr u_n22_dbg_csr (
    .csr_ena         (csr_ena       ),
    .csr_wr_en       (csr_wr_en     ),
    .csr_rd_en       (csr_rd_en     ),
    .csr_idx         (csr_idx       ),
    .wbck_csr_wen    (wbck_csr_wen  ),
    .wbck_csr_dat    (wbck_csr_dat  ),
    .read_csr_dat    (read_csr_dat  ),
    .csr_addr_legal  (csr_addr_legal),
    .csr_prv_ilgl    (csr_prv_ilgl),

    .cmt_dpc         (cmt_dpc        ),
    .cmt_dpc_ena     (cmt_dpc_ena    ),
    .cmt_dcause      (cmt_dcause     ),
    .cmt_dcause_ena  (cmt_dcause_ena ),

    .dbg_dexc2dbg_r         (dbg_dexc2dbg_r  ),
    .cmt_ddcause           (cmt_ddcause    ),
    .cmt_ddcause_ena       (cmt_ddcause_ena),

    .cmt_dprv_ena    (cmt_dprv_ena),
    .cmt_dprv        (cmt_dprv    ),
    .dbg_prv_r       (dbg_prv_r   ),

`ifdef N22_HAS_TRIGM
    .dbg_tdata1      (dbg_tdata1),
    .dbg_tdata2      (dbg_tdata2),
    .icount_taken_ena(icount_taken_ena),
`endif

    .dbg_ebreaku_r   (dbg_ebreaku_r),
    .dbg_stepie      (dbg_stepie   ),
    .dbg_mprven      (dbg_mprven   ),
    .nmi_irq_r       (nmi_irq_r    ),


    .dbg_stopcount   (dbg_stopcount),
    .dbg_stoptime    (dbg_stoptime ),
    .dbg_mode        (dbg_mode),
    .dbg_step_r      (dbg_step_r),
    .dbg_ebreakm_r   (dbg_ebreakm_r),
    .csr_dpc_r       (csr_dpc_r),

    .clk             (clk_csr),
    .rst_n           (rst_csr)
  );




  `ifdef N22_HAS_DEBUG_PRIVATE
  wire  clk_dbg;
  wire  clk_dmi;

  wire dbg_clken = dbg_active & (~dbg_sleep);
  wire dmi_clken = (~dbg_sleep);

  n22_clkgate u_dbg_clkgate(
    .clk_in   (core_clk_dbg    ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (dbg_clken),
    .clk_out  (clk_dbg)
  );

  n22_clkgate u_dmi_clkgate(
    .clk_in   (core_clk_dbg    ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (dmi_clken),
    .clk_out  (clk_dmi)
  );


  wire por_rst_n_tck;
  wire por_rst_n_clk;

  n22_reset_sync u_por_reset_tck_sync (
    .clk      (jtag_tck),
    .rst_n_a  (por_reset_n),
    .reset_bypass(reset_bypass),
    .rst_n_sync(por_rst_n_tck)
  );

  n22_reset_sync u_por_reset_clk_sync (
    .clk      (core_clk_dbg),
    .rst_n_a  (por_reset_n),
    .reset_bypass(reset_bypass),
    .rst_n_sync(por_rst_n_clk)
  );

  wire dmi_hresetn;
  wire dm_reset_n_sync;
  wire dm_reset_n = reset_bypass ? por_reset_n : dmi_hresetn;

  n22_reset_sync u_dm_reset_clk_sync (
    .clk      (core_clk_dbg),
    .rst_n_a  (dm_reset_n),
    .reset_bypass(reset_bypass),
    .rst_n_sync(dm_reset_n_sync)
  );


  n22_debug_subsystem #(
        .DEBUG_INTERFACE(DEBUG_INTERFACE),
        .PROGBUF_SIZE(PROGBUF_SIZE)
  )u_n22_debug_subsystem (
      .dmactive              (dmactive),
      .dbg_sleep             (dbg_sleep),

      .dmi_hresetn           (dmi_hresetn    ),
      .dm_reset_n_sync       (dm_reset_n_sync),
      .tap_dmi_active        (tap_dmi_active),

	  .debugint              (debugint        ),
	  .hart_halted           (dbg_mode        ),
	  .hart_unavail          (hart_unavail    ),
	  .hart_under_reset      (hart_under_reset),
	  .pin_tdi_in            (jtag_tdi_in),
	  .pin_tdi_out           (jtag_tdi_out),
	  .pin_tdi_out_en        (jtag_tdi_out_en),
	  .pin_tdo_in            (jtag_tdo_in),
	  .pin_tdo_out           (jtag_tdo_out),
	  .pin_tdo_out_en        (jtag_tdo_out_en ),
	  .pin_tms_in            (jtag_tms_in),
	  .pin_tms_out           (jtag_tms_out),
	  .pin_tms_out_en        (jtag_tms_out_en),
	  .pin_trst_in           (jtag_trst_in),
	  .pin_trst_out          (jtag_trst_out),
	  .pin_trst_out_en       (jtag_trst_out_en),
	  .dbg_tck               (jtag_tck),

	  .reset_n               (1'b0),

	  .resethaltreq          (resethaltreq),
	  .dmi_clk               (clk_dmi),

      .por_rst_n_tck         (por_rst_n_tck),
      .por_rst_n_clk         (por_rst_n_clk),
      .reset_bypass          (reset_bypass),

	  .dbg_srst_req          (dbg_srst_req),

	  .hsel                  (1'b1               ),
	  .hclk_aon              (core_clk_dbg      ),
	  .hclk                  (clk_dbg           ),

	  .htrans                (dm_ahbl_htrans    ),
	  .hwrite                (dm_ahbl_hwrite    ),
	  .haddr                 (dm_ahbl_haddr     ),
	  .hsize                 (dm_ahbl_hsize     ),

	  .hburst                (dm_ahbl_hburst    ),
	  .hwdata                (dm_ahbl_hwdata    ),
	  .hprot                 (dm_ahbl_hprot     ),

	  .hrdata                (dm_ahbl_hrdata    ),
	  .hready                (dm_ahbl_hready    ),
	  .hreadyout             (dm_ahbl_hready    ),
	  .hresp                 (dm_ahbl_hresp     ),


	  .rv_araddr             (32'b0),
	  .rv_arburst            (2'b0),
	  .rv_arcache            (4'b0),
	  .rv_arid               (4'b0),
	  .rv_arlen              (8'b0),
	  .rv_arlock             (1'b0),
	  .rv_arprot             (3'b0),
	  .rv_arready            (),
	  .rv_arsize             (3'b0),
	  .rv_arvalid            (1'b0),

      .rv_awaddr             (32'b0),
	  .rv_awburst            (2'b0),
	  .rv_awcache            (4'b0),
	  .rv_awid               (4'b0),
	  .rv_awlen              (8'b0),
	  .rv_awlock             (1'b0),
	  .rv_awprot             (3'b0),
	  .rv_awready            (),
	  .rv_awsize             (3'b0),
	  .rv_awvalid            (1'b0),


	  .rv_bid                (),
	  .rv_bready             (1'b0),
	  .rv_bresp              (),
	  .rv_bvalid             (),
	  .rv_rdata              (),
	  .rv_rid                (),
	  .rv_rlast              (),
	  .rv_rready             (1'b0),
	  .rv_rresp              (),
	  .rv_rvalid             (),
	  .rv_wdata              (32'b0),
	  .rv_wlast              (1'b0),
	  .rv_wready             (),
	  .rv_wstrb              (4'b0),
	  .rv_wvalid             (1'b0),

	  .sys_araddr            (),
	  .sys_arburst           (),
	  .sys_arcache           (),
	  .sys_arid              (),
	  .sys_arlen             (),
	  .sys_arlock            (),
	  .sys_arprot            (),
	  .sys_arready           (1'b0),
	  .sys_arsize            (),
	  .sys_arvalid           (),
	  .sys_awaddr            (),
	  .sys_awburst           (),
	  .sys_awcache           (),
	  .sys_awid              (),
	  .sys_awlen             (),
	  .sys_awlock            (),
	  .sys_awprot            (),
	  .sys_awready           (1'b0),
	  .sys_awsize            (),
	  .sys_awvalid           (),
	  .sys_bid               (4'b0),
	  .sys_bready            (),
	  .sys_bresp             (2'b0),
	  .sys_bvalid            (1'b0),
	  .sys_haddr             (),
	  .sys_hburst            (),
	  .sys_hbusreq           (),
	  .sys_hgrant            (1'b0),
	  .sys_hprot             (),
	  .sys_hrdata            (32'b0),
	  .sys_hready            (1'b0),
	  .sys_hresp             (2'b0),
	  .sys_hsize             (),
	  .sys_htrans            (),
	  .sys_hwdata            (),
	  .sys_hwrite            (),
	  .sys_rdata             (32'b0),
	  .sys_rid               (4'b0),
	  .sys_rlast             (1'b0),
	  .sys_rready            (),
	  .sys_rresp             (2'b0),
	  .sys_rvalid            (1'b0),
	  .sys_wdata             (),
	  .sys_wlast             (),
	  .sys_wready            (1'b0),
	  .sys_wstrb             (),
	  .sys_wvalid            ()
);

  assign dbg_active = (~disable_ext_debugger) & (
                                     dmactive       |
                                     tap_dmi_active |
                                     dm_ahbl_active
                                 );

    `endif


endmodule
`endif
