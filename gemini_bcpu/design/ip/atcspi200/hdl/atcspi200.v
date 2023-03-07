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

`ifdef ATCSPI200_AHB_MEM_SUPPORT
wire                                     ahb_cmd_chg;
wire                                     s0;
wire                                     s1;
wire                                     ahb_mem_idle_regclk;
wire                                     ahb_rxf_rd;
wire                              [31:0] ahb_spi_addr;
wire                                     ahb_spi_req;
wire                                     ahb_addr_latched;
wire                                     ahb_other_req;
wire                                     ahb_rxf_empty;
wire                                     ahb_spi_busy;
`endif
`ifdef ATCSPI200_REG_EILM
wire                              [19:2] s2;
wire                                     s3;
wire                              [31:0] s4;
wire                               [3:0] s5;
wire                              [31:0] s6;
wire                                     s7;
`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
wire                                     s8;
wire                              [21:2] s9;
wire                                     s10;
wire                                     eilm_cmd_chg;
wire                                     s11;
wire                                     s12;
wire                              [31:0] s13;
wire                               [3:0] s14;
wire                                     eilm_addr_latched;
wire                                     eilm_other_req;
wire                                     eilm_rxf_empty;
wire                                     eilm_spi_busy;
wire                              [31:0] s15;
wire                                     eilm_rxf_rd;
wire                              [31:0] eilm_spi_addr;
wire                                     eilm_spi_req;
wire                                     s16;
`endif
`ifdef ATCSPI200_MEM_SUPPORT
wire                                     arb_mem_req_sysclk;
wire                                     mem_cmd_chg_window;
wire                                     arb_addr_latched_sclk;
wire                               [1:0] mem_addr_len;
wire                                     mem_cmd_chg;
wire                               [7:0] mem_read_opcode;
wire                              [30:0] mem_read_trans_ctrl;
wire                               [7:0] mem_write_opcode;
wire                              [30:0] mem_write_trans_ctrl;
wire                                     arb_addr_latched_sysclk;
wire                                     arb_mem_req_sclk;
`endif
`ifdef ATCSPI200_SLAVE_SUPPORT
wire                                     rxf_overrun_sclk;
wire                               [7:0] slave_cmd;
wire                                     slave_cmd_wr_sclk;
wire                                     slave_rcnt_inc_sclk;
wire                                     slave_wcnt_inc_sclk;
wire                                     txf_underrun_sclk;
wire                              [31:0] slave_status;
wire                                     slv_data_only_regclk;
wire                                     spi_master;
wire                                     spi_slave_cs_assert;
wire                                     rxf_overrun_regclk;
wire                                     slave_cmd_wr_regclk;
wire                                     slave_rcnt_inc_regclk;
wire                                     slave_wcnt_inc_regclk;
wire                                     slv_data_only_sclk;
wire                                     txf_underrun_regclk;
`endif
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
wire                                     pio_cs_oe;
wire                                     pio_cs_out;
wire                                     pio_enable;
wire                                     pio_miso_oe;
wire                                     pio_miso_out;
wire                                     pio_mosi_oe;
wire                                     pio_mosi_out;
wire                                     pio_sclk_oe;
wire                                     pio_sclk_out;
wire                                     pio_cs_in;
wire                                     pio_miso_in;
wire                                     pio_mosi_in;
wire                                     pio_sclk_in;
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                     spi_quad;
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
wire                                     spi_dual;
`endif
`ifdef ATCSPI200_REG_EILM
   `ifdef ATCSPI200_EILM_MEM_SUPPORT
reg                                      s17;
   `endif
`endif
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
   `ifdef ATCSPI200_QUADSPI_SUPPORT
wire                                     pio_hold_oe;
wire                                     pio_hold_out;
wire                                     pio_wp_oe;
wire                                     pio_wp_out;
wire                                     pio_hold_in;
wire                                     pio_wp_in;
   `endif
`endif
wire                                     reg2sys_clken;
wire                                     regclk;
wire                                     regrstn;
wire                                     sysclk;
wire                                     sysrstn;
wire                              [31:0] arb_addr;
wire                               [1:0] arb_addr_len;
wire                                     arb_data_merge;
wire                                     arb_mem_idle_regclk;
wire                               [7:0] arb_opcode;
wire                                     arb_req_sysclk;
wire                                     arb_rxf_clr;
wire                                     arb_rxf_rd;
wire                              [30:0] arb_trans_ctrl;
wire                                     arb_txf_clr;
wire                                     arb_txf_wr;
wire                              [31:0] arb_txf_wr_data;
wire                                     reg_busy;
wire                                     reg_rxf_empty;
wire        [`ATCSPI200_RXFPTR_BITS-1:0] reg_rxf_entries;
wire                                     reg_trans_end_sysclk;
wire        [`ATCSPI200_TXFPTR_BITS-1:0] reg_txf_entries;
wire                                     reg_txf_full;
wire                                     arb_busy_sclk;
wire                                     arb_trans_end_sclk;
wire                                     first_slv_tx_bit;
wire                                     first_slv_tx_word;
wire                                     mem_intf_idle_clr_sclk;
wire                                     rxf_wr;
wire                              [31:0] rxf_wr_data;
wire                               [2:0] spi_oe;
wire                                     spi_req;
wire                                     spi_rx_hold;
wire                                     spi_tx_hold;
wire                               [3:0] spi_txdata;
wire                                     txf_rd;
wire                                     rxf_clr_level;
wire                                     rxf_empty;
wire        [`ATCSPI200_RXFPTR_BITS-1:0] rxf_entries;
wire                                     rxf_full;
wire                              [31:0] rxf_rd_data;
wire                                     txf_clr_level;
wire                                     txf_empty;
wire        [`ATCSPI200_TXFPTR_BITS-1:0] txf_entries;
wire                                     txf_full;
wire                              [31:0] txf_rd_data;
wire                               [1:0] reg_addr_len;
wire                                     reg_busy_status;
wire                                     reg_data_merge;
wire                               [7:0] reg_opcode;
wire                              [31:0] reg_rdata;
wire                                     reg_req_regclk;
wire                                     reg_rx_dma_en;
wire                                     reg_rxf_clr_regclk;
wire                                     reg_rxf_rd_regclk;
wire                              [31:0] reg_spi_addr;
wire                               [3:0] reg_spi_tramode;
wire                              [13:0] reg_spiif_setting;
wire                              [30:0] reg_trans_ctrl;
wire                                     reg_tx_dma_en;
wire                                     reg_txf_clr_regclk;
wire                               [8:0] reg_txf_data_num;
wire                                     reg_txf_wr_regclk;
wire                                     rxf_threshold_trigger;
wire                                     spi_3line;
wire                               [4:0] spi_data_len;
wire                                     spi_lsb;
wire                               [1:0] spi_mode;
wire                                     spi_reset_regclk;
wire                                     txf_threshold_trigger;
wire                               [6:2] reg_raddr;
wire                                     reg_rd_a;
wire                               [6:2] reg_waddr;
wire                              [31:0] reg_wdata;
wire                                     reg_wr_a;
wire                                     spi_busy;
wire                                     spi_cs_deassert;
wire                               [3:0] spi_rxdata;
wire                                     spi_rxdata_wr;
wire                                     spi_txdata_rd;
wire                                     arb_busy_sysclk;
wire                                     arb_req_sclk;
wire                                     arb_trans_end_sysclk;
wire                                     mem_intf_idle_clr_regclk;
wire                                     reg_mem_idle_clr_sysclk;
wire                                     reg_req_sysclk;
wire                                     reg_rxf_clr_sysclk;
wire                                     reg_rxf_rd_sysclk;
wire                                     reg_trans_end_regclk;
wire                                     reg_txf_clr_sysclk;
wire                                     reg_txf_wr_sysclk;
wire                                     spi_reset_sclk;
wire                                     spi_reset_sysclk;

`ifdef ATCSPI200_AHB_MEM_SUPPORT
  assign s1 = hresetn;
  assign s0 = hclk;
`endif
`ifdef ATCSPI200_REG_EILM
  assign s5 = eilm_web;
  assign s4 = eilm_wdata;
  assign s2 = eilm_addr;
`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
  assign s12 = eilm_resetn;
  assign s10 = eilm_clk;
  assign s9 = eilm_addr;
  assign s13 = eilm_wdata;
  assign s14 = eilm_web;
  `ifdef ATCSPI200_AHBBUS_EXIST
    assign s8 = ahb2eilm_clken;
  `else
    assign s8 = 1'b1;
  `endif
`endif
`ifdef ATCSPI200_EILMBUS_EXIST
  reg [1:0] s18;

  always@(negedge eilm_resetn or posedge eilm_clk)
  begin
    if (~eilm_resetn)
      s18 <= 2'h0;
    else if (eilm_wait_cnt == 2'h0)
      s18 <= 2'h0;
    else if ((s18 == 2'h0) & ~eilm_req)
      s18 <= 2'h0;
    else if ((s18 >= eilm_wait_cnt) & ~eilm_wait)
      s18 <= 2'h0;
    else if ((s18 >= eilm_wait_cnt) &  eilm_wait)
      s18 <= s18;
    else
      s18 <= s18 + 2'h1;
  end
`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
    assign eilm_cmd_chg       = mem_cmd_chg;
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
    assign ahb_cmd_chg        = mem_cmd_chg;
`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
  `ifdef ATCSPI200_REG_EILM
    assign s11 = eilm_req & (s18 == 2'h0) & ~eilm_reg_sel;
    assign s3 = eilm_req & (s18 == 2'h0) &  eilm_reg_sel;
    assign eilm_wait    = s16  | s7;

    always@(negedge eilm_resetn or posedge eilm_clk)
    begin
      if (~eilm_resetn)
        s17 <= 1'b1;
      else if (eilm_req & (s18 == 2'h0) & (&eilm_web))
        s17 <= eilm_reg_sel;
      else
        s17 <= s17;
    end

    assign eilm_rdata   = s17 ? s6 :  s15;

  `else
    assign s11 = eilm_req & (s18 == 2'h0);
    assign eilm_wait    = s16;
    assign eilm_rdata   = s15;
  `endif
`else
  `ifdef ATCSPI200_REG_EILM
    assign s3 = eilm_req & (s18 == 2'h0);
    assign eilm_wait    = s7;
    assign eilm_rdata   = s6;
  `endif
`endif
`ifdef ATCSPI200_AHBBUS_EXIST
  assign sysclk  = hclk;
  assign sysrstn = hresetn;
`else
  `ifdef ATCSPI200_EILMBUS_EXIST
    assign sysclk  = eilm_clk;
    assign sysrstn = eilm_resetn;
  `else
    assign sysclk  = pclk;
    assign sysrstn = presetn;
  `endif
`endif
`ifdef ATCSPI200_REG_AHB
  assign regclk       = hclk;
  assign regrstn      = hresetn;
  assign reg2sys_clken = 1'b1;
`elsif ATCSPI200_REG_EILM
  assign regclk       = eilm_clk;
  assign regrstn      = eilm_resetn;
  assign reg2sys_clken = 1'b1;
`else
    assign regclk       = pclk;
    assign regrstn      = presetn;
    `ifdef ATCSPI200_AHBBUS_EXIST
      assign reg2sys_clken = apb2ahb_clken;
    `elsif ATCSPI200_EILMBUS_EXIST
      assign reg2sys_clken = apb2eilm_clken;
    `else
      assign reg2sys_clken = 1'b1;
    `endif
`endif


`ifdef ATCSPI200_AHB_MEM_SUPPORT
atcspi200_ahbif_ctrl u_spi_ahbif_ctrl (
	.hresetn                 (s1             ),
	.hclk                    (s0                ),
	.hsel                    (hsel_mem                ),
	.hwrite                  (hwrite_mem              ),
	.haddr                   (haddr_mem               ),
	.htrans                  (htrans_mem              ),
	.hreadyin                (hreadyin_mem            ),
	.hreadyout               (hreadyout_mem           ),
	.hrdata                  (hrdata_mem              ),
	.hresp                   (hresp_mem               ),
   `ifdef ATCSPI200_HSPLIT_SUPPORT
	.hmaster                 (hmaster_mem             ),
	.hsplit                  (hsplit_mem              ),
   `endif
	.ahb_spi_busy            (ahb_spi_busy            ),
	.ahb_spi_req             (ahb_spi_req             ),
	.ahb_rxf_empty           (ahb_rxf_empty           ),
	.ahb_rxf_rd_data         (rxf_rd_data             ),
	.ahb_rxf_rd              (ahb_rxf_rd              ),
	.ahb_addr_latched        (ahb_addr_latched        ),
	.ahb_other_req           (ahb_other_req           ),
	.ahb_spi_addr            (ahb_spi_addr            ),
	.ahb_cmd_chg             (ahb_cmd_chg             ),
	.mem_intf_idle_clr_regclk(mem_intf_idle_clr_regclk),
	.reg_mem_idle_clr_sysclk (reg_mem_idle_clr_sysclk ),
	.ahb_mem_idle_regclk     (ahb_mem_idle_regclk     )
);

`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
atcspi200_eilmif_ctrl u_spi_eilmif_ctrl (
	.eilm_resetn             (s12         ),
	.eilm_clk                (s10            ),
	.ahb2eilm_clken          (s8      ),
	.eilm_req                (s11            ),
	.eilm_web                (s14            ),
	.eilm_addr               (s9           ),
	.eilm_wait               (s16           ),
	.eilm_wdata              (s13          ),
	.eilm_rdata              (s15          ),
	.eilm_spi_busy           (eilm_spi_busy           ),
	.eilm_spi_req            (eilm_spi_req            ),
	.eilm_rxf_rd_data        (rxf_rd_data             ),
	.eilm_rxf_rd             (eilm_rxf_rd             ),
	.eilm_addr_latched       (eilm_addr_latched       ),
	.eilm_other_req          (eilm_other_req          ),
	.eilm_spi_addr           (eilm_spi_addr           ),
	.eilm_cmd_chg            (eilm_cmd_chg            ),
	.eilm_rxf_empty          (eilm_rxf_empty          ),
	.mem_intf_idle_clr_regclk(mem_intf_idle_clr_regclk),
	.reg_mem_idle_clr_sysclk (reg_mem_idle_clr_sysclk )
);

`endif
atcspi200_regif u_spi_regif (
`ifdef ATCSPI200_REG_AHB
	.regrstn                (regrstn                ),
	.regclk                 (regclk                 ),
	.hsel_reg               (hsel_reg               ),
	.hwrite                 (hwrite_reg             ),
	.haddr                  (haddr_reg[6:2]         ),
	.htrans                 (htrans_reg             ),
	.hreadyin               (hreadyin_reg           ),
	.hreadyout_reg          (hreadyout_reg          ),
	.hwdata                 (hwdata_reg             ),
	.hrdata_reg             (hrdata_reg             ),
	.hresp_reg              (hresp_reg              ),
`endif
`ifdef ATCSPI200_REG_EILM
	.eilm_req               (s3           ),
	.eilm_web               (s5           ),
	.eilm_addr              (s2          ),
	.eilm_wdata             (s4         ),
	.eilm_wait              (s7          ),
	.eilm_rdata             (s6         ),
`endif
`ifdef ATCSPI200_REG_APB
	.regrstn                (regrstn                ),
	.regclk                 (regclk                 ),
	.psel                   (psel                   ),
	.penable                (penable                ),
	.pwrite                 (pwrite                 ),
	.paddr                  (paddr                  ),
	.pwdata                 (pwdata                 ),
	.prdata                 (prdata                 ),
	.pready                 (pready                 ),
`endif
	.reg_rdata              (reg_rdata              ),
	.reg_rd_a               (reg_rd_a               ),
	.reg_wr_a               (reg_wr_a               ),
	.reg_raddr              (reg_raddr              ),
	.reg_waddr              (reg_waddr              ),
	.reg_wdata              (reg_wdata              ),
	.reg_txf_full           (reg_txf_full           ),
	.reg_rxf_empty          (reg_rxf_empty          ),
	.reg_txf_entries        (reg_txf_entries        ),
	.reg_busy_status        (reg_busy_status        ),
	.reg_mem_idle_clr_sysclk(reg_mem_idle_clr_sysclk)
);

atcspi200_reg u_spi_reg (
	.regrstn                (regrstn                ),
	.regclk                 (regclk                 ),
	.reg_rd_a               (reg_rd_a               ),
	.reg_wr_a               (reg_wr_a               ),
	.reg_raddr              (reg_raddr              ),
	.reg_rdata              (reg_rdata              ),
	.reg_waddr              (reg_waddr              ),
	.reg_wdata              (reg_wdata              ),
	.spi_boot_intr          (spi_boot_intr          ),
	.spi_default_mode3      (spi_default_mode3      ),
	.spi_reset_regclk       (spi_reset_regclk       ),
	.spi_reset_sysclk       (spi_reset_sysclk       ),
	.reg_spiif_setting      (reg_spiif_setting      ),
`ifdef ATCSPI200_MEM_SUPPORT
	.mem_cmd_chg_window     (mem_cmd_chg_window     ),
	.mem_cmd_chg            (mem_cmd_chg            ),
	.mem_write_trans_ctrl   (mem_write_trans_ctrl   ),
	.mem_read_trans_ctrl    (mem_read_trans_ctrl    ),
	.mem_write_opcode       (mem_write_opcode       ),
	.mem_read_opcode        (mem_read_opcode        ),
	.mem_addr_len           (mem_addr_len           ),
`endif
	.reg_opcode             (reg_opcode             ),
	.reg_spi_addr           (reg_spi_addr           ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_master             (spi_master             ),
	.spi_default_as_slave   (spi_default_as_slave   ),
	.slave_cmd              (slave_cmd              ),
	.slave_cmd_wr_regclk    (slave_cmd_wr_regclk    ),
	.slave_status           (slave_status           ),
	.slave_rcnt_inc_regclk  (slave_rcnt_inc_regclk  ),
	.slave_wcnt_inc_regclk  (slave_wcnt_inc_regclk  ),
	.txf_underrun_regclk    (txf_underrun_regclk    ),
	.rxf_overrun_regclk     (rxf_overrun_regclk     ),
	.slv_data_only_regclk   (slv_data_only_regclk   ),
`endif
	.spi_mode               (spi_mode               ),
	.reg_addr_len           (reg_addr_len           ),
	.spi_data_len           (spi_data_len           ),
	.spi_lsb                (spi_lsb                ),
	.spi_3line              (spi_3line              ),
	.reg_trans_end_regclk   (reg_trans_end_regclk   ),
	.reg_busy               (reg_busy               ),
	.reg_req_regclk         (reg_req_regclk         ),
	.reg_trans_ctrl         (reg_trans_ctrl         ),
	.reg_spi_tramode        (reg_spi_tramode        ),
	.reg_data_merge         (reg_data_merge         ),
	.reg_txf_data_num       (reg_txf_data_num       ),
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.pio_sclk_in            (pio_sclk_in            ),
	.pio_miso_in            (pio_miso_in            ),
	.pio_mosi_in            (pio_mosi_in            ),
	.pio_cs_in              (pio_cs_in              ),
	.pio_enable             (pio_enable             ),
	.pio_sclk_out           (pio_sclk_out           ),
	.pio_miso_out           (pio_miso_out           ),
	.pio_mosi_out           (pio_mosi_out           ),
	.pio_cs_out             (pio_cs_out             ),
	.pio_sclk_oe            (pio_sclk_oe            ),
	.pio_miso_oe            (pio_miso_oe            ),
	.pio_mosi_oe            (pio_mosi_oe            ),
	.pio_cs_oe              (pio_cs_oe              ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.pio_wp_in              (pio_wp_in              ),
	.pio_wp_out             (pio_wp_out             ),
	.pio_wp_oe              (pio_wp_oe              ),
	.pio_hold_in            (pio_hold_in            ),
	.pio_hold_out           (pio_hold_out           ),
	.pio_hold_oe            (pio_hold_oe            ),
   `endif
`endif
	.reg_tx_dma_en          (reg_tx_dma_en          ),
	.reg_rx_dma_en          (reg_rx_dma_en          ),
	.rxf_rd_data            (rxf_rd_data            ),
	.reg_rxf_empty          (reg_rxf_empty          ),
	.reg_txf_full           (reg_txf_full           ),
	.reg_txf_wr_regclk      (reg_txf_wr_regclk      ),
	.reg_txf_clr_regclk     (reg_txf_clr_regclk     ),
	.txf_clr_level          (txf_clr_level          ),
	.reg_rxf_rd_regclk      (reg_rxf_rd_regclk      ),
	.reg_rxf_clr_regclk     (reg_rxf_clr_regclk     ),
	.rxf_clr_level          (rxf_clr_level          ),
	.reg_txf_entries        (reg_txf_entries        ),
	.reg_rxf_entries        (reg_rxf_entries        ),
	.txf_threshold_trigger  (txf_threshold_trigger  ),
	.rxf_threshold_trigger  (rxf_threshold_trigger  ),
	.reg_busy_status        (reg_busy_status        ),
	.reg_mem_idle_clr_sysclk(reg_mem_idle_clr_sysclk)
);

atcspi200_regif_ctrl u_spi_regif_ctrl (
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_master           (spi_master           ),
`endif
	.reg_txf_data_num     (reg_txf_data_num     ),
	.reg_data_merge       (reg_data_merge       ),
	.reg_txf_wr_regclk    (reg_txf_wr_regclk    ),
	.reg_trans_end_regclk (reg_trans_end_regclk ),
	.regrstn              (regrstn              ),
	.regclk               (regclk               ),
	.spi_reset_regclk     (spi_reset_regclk     ),
	.reg_spi_tramode      (reg_spi_tramode      ),
	.reg_txf_full         (reg_txf_full         ),
	.reg_rxf_empty        (reg_rxf_empty        ),
	.reg_tx_dma_en        (reg_tx_dma_en        ),
	.reg_rx_dma_en        (reg_rx_dma_en        ),
	.spi_tx_dma_req       (spi_tx_dma_req       ),
	.spi_rx_dma_req       (spi_rx_dma_req       ),
	.spi_tx_dma_ack       (spi_tx_dma_ack       ),
	.spi_rx_dma_ack       (spi_rx_dma_ack       ),
	.txf_threshold_trigger(txf_threshold_trigger),
	.rxf_threshold_trigger(rxf_threshold_trigger),
	.reg_opcode           (reg_opcode           )
);

atcspi200_arbiter u_spi_arbiter (
	.sysrstn                (sysrstn                ),
	.sysclk                 (sysclk                 ),
	.reg2sys_clken          (reg2sys_clken          ),
	.spi_reset_sysclk       (spi_reset_sysclk       ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_master             (spi_master             ),
`endif
`ifdef ATCSPI200_AHB_MEM_SUPPORT
	.ahb_spi_req            (ahb_spi_req            ),
	.ahb_rxf_rd             (ahb_rxf_rd             ),
	.ahb_addr_latched       (ahb_addr_latched       ),
	.ahb_other_req          (ahb_other_req          ),
	.ahb_spi_addr           (ahb_spi_addr           ),
	.ahb_rxf_empty          (ahb_rxf_empty          ),
	.ahb_spi_busy           (ahb_spi_busy           ),
	.ahb_mem_idle_regclk    (ahb_mem_idle_regclk    ),
`endif
`ifdef ATCSPI200_EILM_MEM_SUPPORT
	.eilm_spi_req           (eilm_spi_req           ),
	.eilm_rxf_rd            (eilm_rxf_rd            ),
	.eilm_addr_latched      (eilm_addr_latched      ),
	.eilm_other_req         (eilm_other_req         ),
	.eilm_spi_addr          (eilm_spi_addr          ),
	.eilm_rxf_empty         (eilm_rxf_empty         ),
	.eilm_spi_busy          (eilm_spi_busy          ),
`endif
`ifdef ATCSPI200_MEM_SUPPORT
	.mem_write_trans_ctrl   (mem_write_trans_ctrl   ),
	.mem_read_trans_ctrl    (mem_read_trans_ctrl    ),
	.mem_write_opcode       (mem_write_opcode       ),
	.mem_read_opcode        (mem_read_opcode        ),
	.mem_cmd_chg            (mem_cmd_chg            ),
	.mem_addr_len           (mem_addr_len           ),
	.mem_cmd_chg_window     (mem_cmd_chg_window     ),
`endif
	.reg_trans_ctrl         (reg_trans_ctrl         ),
	.reg_opcode             (reg_opcode             ),
	.reg_spi_addr           (reg_spi_addr           ),
	.reg_req_sysclk         (reg_req_sysclk         ),
	.reg_txf_wr_data        (reg_wdata              ),
	.reg_txf_wr_sysclk      (reg_txf_wr_sysclk      ),
	.reg_rxf_rd_sysclk      (reg_rxf_rd_sysclk      ),
	.reg_rxf_clr_sysclk     (reg_rxf_clr_sysclk     ),
	.reg_txf_clr_sysclk     (reg_txf_clr_sysclk     ),
	.reg_data_merge         (reg_data_merge         ),
	.reg_addr_len           (reg_addr_len           ),
	.reg_busy               (reg_busy               ),
	.reg_rxf_empty          (reg_rxf_empty          ),
	.reg_txf_full           (reg_txf_full           ),
	.reg_rxf_entries        (reg_rxf_entries        ),
	.reg_txf_entries        (reg_txf_entries        ),
	.arb_busy_sysclk        (arb_busy_sysclk        ),
	.arb_req_sysclk         (arb_req_sysclk         ),
	.arb_opcode             (arb_opcode             ),
	.arb_addr               (arb_addr               ),
	.arb_trans_end_sysclk   (arb_trans_end_sysclk   ),
	.reg_trans_end_sysclk   (reg_trans_end_sysclk   ),
`ifdef ATCSPI200_MEM_SUPPORT
	.arb_mem_req_sysclk     (arb_mem_req_sysclk     ),
	.arb_addr_latched_sysclk(arb_addr_latched_sysclk),
`endif
	.arb_addr_len           (arb_addr_len           ),
	.arb_data_merge         (arb_data_merge         ),
	.arb_trans_ctrl         (arb_trans_ctrl         ),
	.arb_txf_wr_data        (arb_txf_wr_data        ),
	.arb_txf_wr             (arb_txf_wr             ),
	.arb_rxf_rd             (arb_rxf_rd             ),
	.arb_rxf_clr            (arb_rxf_clr            ),
	.arb_txf_clr            (arb_txf_clr            ),
	.rxf_clr_level          (rxf_clr_level          ),
	.rxf_empty              (rxf_empty              ),
	.txf_full               (txf_full               ),
	.rxf_entries            (rxf_entries            ),
	.txf_entries            (txf_entries            ),
	.reg_mem_idle_clr_sysclk(reg_mem_idle_clr_sysclk),
	.arb_mem_idle_regclk    (arb_mem_idle_regclk    )
);

atcspi200_fifo u_spi_fifo (
	.spi_clock     (spi_clock      ),
	.spi_rstn      (spi_rstn       ),
	.sysclk        (sysclk         ),
	.sysrstn       (sysrstn        ),
	.txf_clr_sysclk(arb_txf_clr    ),
	.txf_wr        (arb_txf_wr     ),
	.txf_wr_data   (arb_txf_wr_data),
	.txf_rd        (txf_rd         ),
	.txf_rd_data   (txf_rd_data    ),
	.txf_empty     (txf_empty      ),
	.txf_full      (txf_full       ),
	.txf_entries   (txf_entries    ),
	.txf_clr_level (txf_clr_level  ),
	.rxf_clr_sysclk(arb_rxf_clr    ),
	.rxf_wr        (rxf_wr         ),
	.rxf_wr_data   (rxf_wr_data    ),
	.rxf_rd        (arb_rxf_rd     ),
	.rxf_rd_data   (rxf_rd_data    ),
	.rxf_empty     (rxf_empty      ),
	.rxf_full      (rxf_full       ),
	.rxf_entries   (rxf_entries    ),
	.rxf_clr_level (rxf_clr_level  )
);

atcspi200_sync u_spi_sync (
	.sysclk                  (sysclk                  ),
	.sysrstn                 (sysrstn                 ),
	.spi_clock               (spi_clock               ),
	.spi_rstn                (spi_rstn                ),
	.regclk                  (regclk                  ),
	.regrstn                 (regrstn                 ),
	.reg2sys_clken           (reg2sys_clken           ),
	.arb_req_sysclk          (arb_req_sysclk          ),
	.arb_req_sclk            (arb_req_sclk            ),
	.arb_busy_sclk           (arb_busy_sclk           ),
	.arb_busy_sysclk         (arb_busy_sysclk         ),
	.arb_trans_end_sclk      (arb_trans_end_sclk      ),
	.arb_trans_end_sysclk    (arb_trans_end_sysclk    ),
`ifdef ATCSPI200_MEM_SUPPORT
	.arb_mem_req_sclk        (arb_mem_req_sclk        ),
	.arb_mem_req_sysclk      (arb_mem_req_sysclk      ),
	.arb_addr_latched_sclk   (arb_addr_latched_sclk   ),
	.arb_addr_latched_sysclk (arb_addr_latched_sysclk ),
`endif
	.spi_reset_regclk        (spi_reset_regclk        ),
	.spi_reset_sclk          (spi_reset_sclk          ),
	.spi_reset_sysclk        (spi_reset_sysclk        ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.slave_cmd_wr_sclk       (slave_cmd_wr_sclk       ),
	.slave_rcnt_inc_sclk     (slave_rcnt_inc_sclk     ),
	.slave_wcnt_inc_sclk     (slave_wcnt_inc_sclk     ),
	.rxf_overrun_sclk        (rxf_overrun_sclk        ),
	.txf_underrun_sclk       (txf_underrun_sclk       ),
	.slv_data_only_regclk    (slv_data_only_regclk    ),
	.slave_cmd_wr_regclk     (slave_cmd_wr_regclk     ),
	.slave_rcnt_inc_regclk   (slave_rcnt_inc_regclk   ),
	.slave_wcnt_inc_regclk   (slave_wcnt_inc_regclk   ),
	.rxf_overrun_regclk      (rxf_overrun_regclk      ),
	.txf_underrun_regclk     (txf_underrun_regclk     ),
	.slv_data_only_sclk      (slv_data_only_sclk      ),
`endif
	.reg_trans_end_sysclk    (reg_trans_end_sysclk    ),
	.reg_trans_end_regclk    (reg_trans_end_regclk    ),
	.reg_req_regclk          (reg_req_regclk          ),
	.reg_txf_wr_regclk       (reg_txf_wr_regclk       ),
	.reg_txf_clr_regclk      (reg_txf_clr_regclk      ),
	.reg_rxf_rd_regclk       (reg_rxf_rd_regclk       ),
	.reg_rxf_clr_regclk      (reg_rxf_clr_regclk      ),
	.reg_req_sysclk          (reg_req_sysclk          ),
	.reg_txf_wr_sysclk       (reg_txf_wr_sysclk       ),
	.reg_txf_clr_sysclk      (reg_txf_clr_sysclk      ),
	.reg_rxf_rd_sysclk       (reg_rxf_rd_sysclk       ),
	.reg_rxf_clr_sysclk      (reg_rxf_clr_sysclk      ),
	.mem_intf_idle_clr_sclk  (mem_intf_idle_clr_sclk  ),
	.mem_intf_idle_clr_regclk(mem_intf_idle_clr_regclk),
	.reg_mem_idle_clr_sysclk (reg_mem_idle_clr_sysclk ),
	.arb_mem_idle_regclk     (arb_mem_idle_regclk     )
);

atcspi200_ctrl u_spi_ctrl (
	.spi_clock             (spi_clock             ),
	.spi_rstn              (spi_rstn              ),
	.spi_reset_sclk        (spi_reset_sclk        ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_master            (spi_master            ),
	.slave_cmd             (slave_cmd             ),
	.slave_cmd_wr_sclk     (slave_cmd_wr_sclk     ),
	.slave_status          (slave_status          ),
	.slave_rcnt_inc_sclk   (slave_rcnt_inc_sclk   ),
	.slave_wcnt_inc_sclk   (slave_wcnt_inc_sclk   ),
	.rxf_overrun_sclk      (rxf_overrun_sclk      ),
	.txf_underrun_sclk     (txf_underrun_sclk     ),
	.spi_slave_cs_assert   (spi_slave_cs_assert   ),
	.slv_data_only_sclk    (slv_data_only_sclk    ),
`endif
	.first_slv_tx_word     (first_slv_tx_word     ),
	.first_slv_tx_bit      (first_slv_tx_bit      ),
	.spi_mode              (spi_mode              ),
	.arb_addr_len          (arb_addr_len          ),
	.spi_data_len          (spi_data_len          ),
	.spi_lsb               (spi_lsb               ),
	.spi_3line             (spi_3line             ),
	.spi_busy              (spi_busy              ),
	.arb_busy_sclk         (arb_busy_sclk         ),
	.arb_trans_ctrl        (arb_trans_ctrl        ),
	.arb_data_merge        (arb_data_merge        ),
	.arb_req_sclk          (arb_req_sclk          ),
	.arb_trans_end_sclk    (arb_trans_end_sclk    ),
	.arb_opcode            (arb_opcode            ),
	.arb_addr              (arb_addr              ),
	.txf_empty             (txf_empty             ),
	.rxf_full              (rxf_full              ),
	.txf_rd                (txf_rd                ),
	.rxf_wr                (rxf_wr                ),
	.txf_rd_data           (txf_rd_data           ),
	.rxf_wr_data           (rxf_wr_data           ),
`ifdef ATCSPI200_MEM_SUPPORT
	.arb_mem_req_sclk      (arb_mem_req_sclk      ),
	.arb_addr_latched_sclk (arb_addr_latched_sclk ),
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_quad              (spi_quad              ),
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
	.spi_dual              (spi_dual              ),
`endif
	.spi_cs_deassert       (spi_cs_deassert       ),
	.spi_txdata_rd         (spi_txdata_rd         ),
	.spi_rxdata_wr         (spi_rxdata_wr         ),
	.spi_req               (spi_req               ),
	.spi_txdata            (spi_txdata            ),
	.spi_oe                (spi_oe                ),
	.spi_rxdata            (spi_rxdata            ),
	.spi_tx_hold           (spi_tx_hold           ),
	.spi_rx_hold           (spi_rx_hold           ),
	.mem_intf_idle_clr_sclk(mem_intf_idle_clr_sclk)
);

atcspi200_spiif u_spi_spiif (
	.spi_rstn           (spi_rstn           ),
	.spi_clock          (spi_clock          ),
	.scan_test          (scan_test          ),
	.scan_enable        (scan_enable        ),
	.spi_reset_sclk     (spi_reset_sclk     ),
	.spi_req            (spi_req            ),
	.spi_busy           (spi_busy           ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_master         (spi_master         ),
	.spi_slave_cs_assert(spi_slave_cs_assert),
`endif
	.first_slv_tx_word  (first_slv_tx_word  ),
	.first_slv_tx_bit   (first_slv_tx_bit   ),
	.spi_mode           (spi_mode           ),
	.spi_3line          (spi_3line          ),
`ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_quad           (spi_quad           ),
`endif
`ifdef ATCSPI200_QUADDUAL_SUPPORT
	.spi_dual           (spi_dual           ),
`endif
	.reg_spiif_setting  (reg_spiif_setting  ),
	.spi_cs_deassert    (spi_cs_deassert    ),
	.spi_txdata_rd      (spi_txdata_rd      ),
	.spi_rxdata_wr      (spi_rxdata_wr      ),
	.spi_tx_hold        (spi_tx_hold        ),
	.spi_rx_hold        (spi_rx_hold        ),
	.spi_txdata         (spi_txdata         ),
	.spi_oe             (spi_oe             ),
	.spi_rxdata         (spi_rxdata         ),
`ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.pio_enable         (pio_enable         ),
	.pio_sclk_out       (pio_sclk_out       ),
	.pio_sclk_in        (pio_sclk_in        ),
	.pio_sclk_oe        (pio_sclk_oe        ),
	.pio_cs_out         (pio_cs_out         ),
	.pio_cs_in          (pio_cs_in          ),
	.pio_cs_oe          (pio_cs_oe          ),
	.pio_miso_out       (pio_miso_out       ),
	.pio_miso_in        (pio_miso_in        ),
	.pio_miso_oe        (pio_miso_oe        ),
	.pio_mosi_out       (pio_mosi_out       ),
	.pio_mosi_in        (pio_mosi_in        ),
	.pio_mosi_oe        (pio_mosi_oe        ),
   `ifdef ATCSPI200_QUADSPI_SUPPORT
	.pio_wp_out         (pio_wp_out         ),
	.pio_wp_in          (pio_wp_in          ),
	.pio_wp_oe          (pio_wp_oe          ),
	.pio_hold_out       (pio_hold_out       ),
	.pio_hold_in        (pio_hold_in        ),
	.pio_hold_oe        (pio_hold_oe        ),
   `endif
`endif
`ifdef ATCSPI200_QUADSPI_SUPPORT
	.spi_wp_n_in        (spi_wp_n_in        ),
	.spi_wp_n_out       (spi_wp_n_out       ),
	.spi_wp_n_oe        (spi_wp_n_oe        ),
	.spi_hold_n_in      (spi_hold_n_in      ),
	.spi_hold_n_out     (spi_hold_n_out     ),
	.spi_hold_n_oe      (spi_hold_n_oe      ),
`endif
	.spi_clk_in         (spi_clk_in         ),
	.spi_clk_out        (spi_clk_out        ),
	.spi_clk_oe         (spi_clk_oe         ),
`ifdef ATCSPI200_SLAVE_SUPPORT
	.spi_cs_n_in        (spi_cs_n_in        ),
`else
   `ifdef ATCSPI200_DIRECT_IO_SUPPORT
	.spi_cs_n_in        (spi_cs_n_in        ),
   `endif
`endif
	.spi_cs_n_out       (spi_cs_n_out       ),
	.spi_cs_n_oe        (spi_cs_n_oe        ),
	.spi_mosi_in        (spi_mosi_in        ),
	.spi_mosi_out       (spi_mosi_out       ),
	.spi_mosi_oe        (spi_mosi_oe        ),
	.spi_miso_in        (spi_miso_in        ),
	.spi_miso_out       (spi_miso_out       ),
	.spi_miso_oe        (spi_miso_oe        )
);

endmodule

