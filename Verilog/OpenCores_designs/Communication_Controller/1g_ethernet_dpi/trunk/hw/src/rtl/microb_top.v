//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module microb_top
(
  output [7:0] led_8bits_tri_o,
  input glbl_rst,
  input rs232_uart_rxd,
  output rs232_uart_txd,
    // 200MHz clock input from board
    input sys_diff_clock_clk_n,
    input sys_diff_clock_clk_p,
    // PHY rst
    output        phy_resetn,
    // RGMII Interface
    output [3:0]  rgmii_txd,
    output        rgmii_tx_ctl,
    output        rgmii_txc,
    input  [3:0]  rgmii_rxd,
    input         rgmii_rx_ctl,
    input         rgmii_rxc,
    // MDIO Interface
    inout         mdio,
    output        mdc
    
);
//--------------------------------------------------------------------------------
// Clock logic to generate required clocks from the 200MHz on board
  tri_mode_ethernet_mac_0_example_design_clocks example_clocks
   (
      // differential clock inputs
      .clk_in_p         (sys_diff_clock_clk_p),
      .clk_in_n         (sys_diff_clock_clk_n),

      // asynchronous control/resets
      .glbl_rst         (glbl_rst),   // in
      .dcm_locked       (dcm_locked), // out

      // clock outputs
      .gtx_clk_bufg     (gtx_clk_bufg),// 125MHz
      .refclk_bufg      (refclk_bufg), // 200 MHZ
      .s_axi_aclk       (s_axi_aclk)   // 100MHz
   );

assign tx_fifo_clock = gtx_clk_bufg;
assign rx_fifo_clock = gtx_clk_bufg;
//--------------------------------------------------------------------------------
// Generate resets required for the fifo side signals etc
   tri_mode_ethernet_mac_0_example_design_resets example_resets
   (
      // clocks
      .s_axi_aclk       (s_axi_aclk),
      .gtx_clk          (gtx_clk_bufg),

      // asynchronous resets
      .glbl_rst         (glbl_rst),
      .reset_error      (reset_error),
      .rx_reset         (rx_reset),
      .tx_reset         (tx_reset),

      .dcm_locked       (dcm_locked),

      // synchronous reset outputs
  
      .glbl_rst_intn    (glbl_rst_intn),
   
   
      .gtx_resetn       (gtx_resetn),
   
      .s_axi_resetn     (s_axi_resetn),
      .phy_resetn       (phy_resetn),
      .chk_resetn       ()
   );

assign tx_fifo_resetn = gtx_resetn;
assign rx_fifo_resetn = gtx_resetn;
//--------------------------------------------------------------------------------
base_microblaze_design  u0
(
// SYS_CON
.Clk              (s_axi_aclk),
.reset             (!s_axi_resetn),
// LED
.led_8bits_tri_o        (led_8bits_tri_o),
// UART
.rs232_uart_rxd         (rs232_uart_rxd),
.rs232_uart_txd         (rs232_uart_txd),
// TMEMAC
.tmemac_1_glbl_rstn     (glbl_rst_intn),
.tmemac_1_gtx_clk       (gtx_clk_bufg),
.tmemac_1_inband_clock_speed    (),
.tmemac_1_inband_duplex_status  (),
.tmemac_1_inband_link_status    (),
//  mdio
.tmemac_1_mdc           (mdc), // output
.tmemac_1_mdio          (mdio), // inout
// IDELAYCTRL-clk
.tmemac_1_refclk        (refclk_bufg),
//  RGMII-rx
.tmemac_1_rgmii_rx_ctl  (rgmii_rx_ctl),
.tmemac_1_rgmii_rxc     (rgmii_rxc),
.tmemac_1_rgmii_rxd     (rgmii_rxd),
//  RGMII-tx
.tmemac_1_rgmii_tx_ctl  (rgmii_tx_ctl),
.tmemac_1_rgmii_txc     (rgmii_txc),
.tmemac_1_rgmii_txd     (rgmii_txd)
);
//--------------------------------------------------------------------------------
endmodule
