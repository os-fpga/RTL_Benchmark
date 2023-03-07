// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`include "atcspi200_config.vh"
`include "atcspi200_const.vh"


module atcspi200 (
`ifdef ATCSPI200_AHBBUS_EXIST
	  hclk,
	  hresetn,
`endif
`ifdef ATCSPI200_EILMBUS_EXIST
	  eilm_addr,
	  eilm_clk,
	  eilm_rdata,
	  eilm_req,
	  eilm_resetn,
	  eilm_wait,
	  eilm_wait_cnt,
	  eilm_wdata,
	  eilm_web,
`endif
`ifdef ATCSPI200_REG_APB
	  pclk,
	  presetn,
	  paddr,
	  penable,
	  prdata,
	  pready,
	  psel,
	  pwdata,
	  pwrite,
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
	  haddr_mem,
	  hrdata_mem,
	  hreadyin_mem,
	  hreadyout_mem,
	  hresp_mem,
	  hsel_mem,
	  htrans_mem,
	  hwrite_mem,
`endif
`ifdef ATCSPI200_REG_AHB
	  haddr_reg,
	  hrdata_reg,
	  hreadyin_reg,
	  hreadyout_reg,
	  hresp_reg,
	  hsel_reg,
	  htrans_reg,
	  hwdata_reg,
	  hwrite_reg,
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
	  spi_default_as_slave,
	  spi_cs_n_in,
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	  spi_hold_n_in,
	  spi_hold_n_oe,
	  spi_hold_n_out,
	  spi_wp_n_in,
	  spi_wp_n_oe,
	  spi_wp_n_out,
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
	  ahb2eilm_clken,
   `endif
   `ifdef ATCSPI200_REG_APB
	  apb2ahb_clken,
   `endif
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_HSPLIT_SUPPORT
	  hmaster_mem,
	  hsplit_mem,
   `endif
`endif
`ifdef ATCSPI200_REG_EILM
   `ifdef ATCSPI200_EILM_MEM_SUPPORT
	  eilm_reg_sel,
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	  spi_cs_n_in,
   `endif
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
	  apb2eilm_clken,
      `endif
   `endif
`endif
	  spi_clock,
	  spi_rstn,
	  spi_boot_intr,
	  spi_default_mode3,
	  spi_rx_dma_ack,
	  spi_rx_dma_req,
	  spi_tx_dma_ack,
	  spi_tx_dma_req,
	  scan_enable,
	  scan_test,
	  spi_clk_in,
	  spi_clk_oe,
	  spi_clk_out,
	  spi_cs_n_oe,
	  spi_cs_n_out,
	  spi_miso_in,
	  spi_miso_oe,
	  spi_miso_out,
	  spi_mosi_in,
	  spi_mosi_oe,
	  spi_mosi_out
);

`ifdef ATCSPI200_AHBBUS_EXIST
input                                    hclk;
input                                    hresetn;
`endif
`ifdef ATCSPI200_EILMBUS_EXIST
input                             [21:2] eilm_addr;
input                                    eilm_clk;
output                            [31:0] eilm_rdata;
input                                    eilm_req;
input                                    eilm_resetn;
output                                   eilm_wait;
input                              [1:0] eilm_wait_cnt;
input                             [31:0] eilm_wdata;
input                              [3:0] eilm_web;
`endif
`ifdef ATCSPI200_REG_APB
input                                    pclk;
input                                    presetn;
input                             [31:0] paddr;
input                                    penable;
output                            [31:0] prdata;
output                                   pready;
input                                    psel;
input                             [31:0] pwdata;
input                                    pwrite;
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
input       [`ATCSPI200_HADDR_WIDTH-1:0] haddr_mem;
output                            [31:0] hrdata_mem;
input                                    hreadyin_mem;
output                                   hreadyout_mem;
output                             [1:0] hresp_mem;
input                                    hsel_mem;
input                              [1:0] htrans_mem;
input                                    hwrite_mem;
`endif
`ifdef ATCSPI200_REG_AHB
input       [`ATCSPI200_HADDR_WIDTH-1:0] haddr_reg;
output                            [31:0] hrdata_reg;
input                                    hreadyin_reg;
output                                   hreadyout_reg;
output                             [1:0] hresp_reg;
input                                    hsel_reg;
input                              [1:0] htrans_reg;
input                             [31:0] hwdata_reg;
input                                    hwrite_reg;
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
input                                    spi_default_as_slave;
input                                    spi_cs_n_in;
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
input                                    spi_hold_n_in;
output                                   spi_hold_n_oe;
output                                   spi_hold_n_out;
input                                    spi_wp_n_in;
output                                   spi_wp_n_oe;
output                                   spi_wp_n_out;
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
   `ifdef ATCSPI200_EILMBUS_EXIST
input                                    ahb2eilm_clken;
   `endif
   `ifdef ATCSPI200_REG_APB
input                                    apb2ahb_clken;
   `endif
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
   `ifdef ATCSPI200_HSPLIT_SUPPORT
input       [`ATCSPI200_HMASTER_BIT-1:0] hmaster_mem;
output       [`ATCSPI200_HSPLIT_BIT-1:0] hsplit_mem;
   `endif
`endif
`ifdef ATCSPI200_REG_EILM
   `ifdef ATCSPI200_EILM_MEM_SUPPORT
input                                    eilm_reg_sel;
   `endif
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
input                                    spi_cs_n_in;
   `endif
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
`else
   `ifdef ATCSPI200_EILMBUS_EXIST
      `ifdef ATCSPI200_REG_APB
input                                    apb2eilm_clken;
      `endif
   `endif
`endif
input                                    spi_clock;
input                                    spi_rstn;
output                                   spi_boot_intr;
input                                    spi_default_mode3;
input                                    spi_rx_dma_ack;
output                                   spi_rx_dma_req;
input                                    spi_tx_dma_ack;
output                                   spi_tx_dma_req;
input                                    scan_enable;
input                                    scan_test;
input                                    spi_clk_in;
output                                   spi_clk_oe;
output                                   spi_clk_out;
output                                   spi_cs_n_oe;
output                                   spi_cs_n_out;
input                                    spi_miso_in;
output                                   spi_miso_oe;
output                                   spi_miso_out;
input                                    spi_mosi_in;
output                                   spi_mosi_oe;
output                                   spi_mosi_out;

assign /*output                            [31:0] */eilm_rdata='d0;
assign /*output                                   */eilm_wait='d0;
assign /*output                            [31:0] */prdata='d0;
assign /*output                                   */pready='d0;
assign /*output                            [31:0] */hrdata_mem='d0;
assign /*output                                   */hreadyout_mem='d0;
assign /*output                             [1:0] */hresp_mem='d0;
assign /*output                            [31:0] */hrdata_reg='d0;
assign /*output                                   */hreadyout_reg='d0;
assign /*output                             [1:0] */hresp_reg='d0;
assign /*output                                   */spi_hold_n_oe='d0;
assign /*output                                   */spi_hold_n_out='d0;
assign /*output                                   */spi_wp_n_oe='d0;
assign /*output                                   */spi_wp_n_out='d0;
assign /*output       [`ATCSPI200_HSPLIT_BIT-1:0] */hsplit_mem='d0;
assign /*output                                   */spi_boot_intr='d0;
assign /*output                                   */spi_rx_dma_req='d0;
assign /*output                                   */spi_tx_dma_req='d0;
assign /*output                                   */spi_clk_oe='d0;
assign /*output                                   */spi_clk_out='d0;
assign /*output                                   */spi_cs_n_oe='d0;
assign /*output                                   */spi_cs_n_out='d0;
assign /*output                                   */spi_miso_oe='d0;
assign /*output                                   */spi_miso_out='d0;
assign /*output                                   */spi_mosi_oe='d0;
assign /*output                                   */spi_mosi_out='d0;

endmodule

