module soc_ss (
    // input OSC clock
    input  logic        clk_osc                    ,
    // input PLL clocks
    input  logic        clk_soc_pll0               ,
    input  logic        clk_soc_pll1               ,
    // input FPGA clocks
    input  logic        clk_fpga0                  ,
    input  logic        clk_fpga1                  ,
    input  logic        clk_fpga_s                 ,
    output logic        rst_n_fpga0                ,
    output logic        rst_n_fpga1                ,
    output logic        rst_n_fpga_s               ,
    // pll control signals
    output logic        soc_pll_ctl_dacen          ,
    output logic        soc_pll_ctl_dskewcalbyp    ,
    output logic [ 2:0] soc_pll_ctl_dskewcalcnt    ,
    output logic        soc_pll_ctl_dskewcalen     ,
    output logic [11:0] soc_pll_ctl_dskewcalin     ,
    output logic        soc_pll_ctl_dskewfastcal   ,
    output logic        soc_pll_ctl_dsmen          ,
    output logic        soc_pll_ctl_pllen          ,
    output logic [ 3:0] soc_pll_ctl_fouten         ,
    output logic [ 4:0] soc_pll_ctl_foutvcobyp     ,
    output logic        soc_pll_ctl_foutvcoen      ,
    output logic [ 5:0] soc_pll_ctl_refdiv         ,
    output logic [23:0] soc_pll_ctl_frac           ,
    output logic [ 3:0] soc_pll_ctl_postdiv0       ,
    output logic [ 3:0] soc_pll_ctl_postdiv1       ,
    output logic [ 3:0] soc_pll_ctl_postdiv2       ,
    output logic [ 3:0] soc_pll_ctl_postdiv3       ,
    output logic [11:0] soc_pll_ctl_fbdiv          ,
    // pll status signals
    input  logic [11:0] soc_pll_status_dskewcalout ,
    input  logic        soc_pll_status_dskewcallock,
    input  logic        soc_pll_status_lock        ,
    // I2C interface signals
    output logic        scl_o                      ,
    // QSPI interface signals
    output logic        spi_clk_oe                 ,
    output logic        spi_clk_out                ,
    // GPIO interface signals
    output logic [31:0] gpio_pulldown              ,
    output logic [31:0] gpio_pullup                ,
    // GPT interface signals
    input  logic        pit_pause                  ,
    // GbE interface signals
    output logic        mdio_mdc                   ,
    // USB interface signals
    inout  wire         usb_dp                     ,
    inout  wire  [31:0] usb_dn                     ,
    input  logic        usb_xtal_in                ,
    output logic        usb_xtal_out               ,
    // PAD control
    input  logic [31:0] pad_c                      ,
    output logic [31:0] pad_st                     ,
    output logic [31:0] pad_pu                     ,
    output logic [31:0] pad_pd                     ,
    output logic [31:0] pad_i                      ,
    output logic [31:0] pad_ie                     ,
    output logic [31:0] pad_oen                    ,
    output logic [31:0] pad_ds0                    ,
    output logic [31:0] pad_ds1                    ,
    output logic [31:0] pad_ds2                    ,
    // FCB/PCB interface signals
    output logic [35:0] pl_data_o                  ,
    output logic [31:0] pl_addr_o                  ,
    output logic        pl_ena_o                   ,
    output logic        pl_clk_o                   ,
    output logic        pl_ren_o                   ,
    output logic        pl_init_o                  ,
    output logic [ 1:0] pl_wen_o                   ,
    input  logic [35:0] pl_data_i                  ,
    output logic [0:31] cfg_blsr_region_0_o        ,
    output logic [0:31] cfg_wlsr_region_0_o        ,
    output logic        cfg_done_o                 ,
    output logic        cfg_rst_no                 ,
    output logic        cfg_blsr_region_0_clk_o    ,
    output logic        cfg_wlsr_region_0_clk_o    ,
    output logic        cfg_blsr_region_0_wen_o    ,
    output logic        cfg_blsr_region_0_ren_o    ,
    output logic        cfg_wlsr_region_0_wen_o    ,
    output logic        cfg_wlsr_region_0_ren_o    ,
    input  logic [0:31] cfg_blsr_region_0_i        ,
    input  logic [0:31] cfg_wlsr_region_0_i        ,
    // JTAG intf
    output logic [ 1:0] jtag_control               ,
    input  logic        acpu_jtag_tck              ,
    input  logic        acpu_jtag_tdi              ,
    output logic        acpu_jtag_tdo              ,
    input  logic        acpu_jtag_tms              ,
    input  logic        bcpu_jtag_tck              ,
    input  logic        bcpu_jtag_tdi              ,
    output logic        bcpu_jtag_tdo              ,
    input  logic        bcpu_jtag_tms              ,
    // ATB interface
    input  logic        atclk                      ,
    input  logic        atclken                    ,
    input  logic        atresetn                   ,
    output logic        atbytes                    ,
    output logic [15:0] atdata                     ,
    output logic [ 7:0] atid                       ,
    input  logic        atready                    ,
    output logic        atvalid                    ,
    input  logic        afvalid                    ,
    output logic        afready                    ,
    // DDR interface
    output logic [18:0] mem_a                      ,
    output logic        mem_act_n                  ,
    output logic [ 1:0] mem_ba                     ,
    output logic [ 1:0] mem_bg                     ,
    output logic [ 1:0] mem_cke                    ,
    output logic [ 1:0] mem_clk                    ,
    output logic [ 1:0] mem_clk_n                  ,
    output logic [ 1:0] mem_cs                     ,
    output logic [ 1:0] mem_odt                    ,
    output logic        mem_reset_n                ,
    inout  wire  [ 7:0] dm                         ,
    inout  wire  [63:0] dq                         ,
    inout  wire  [ 7:0] dqs                        ,
    inout  wire  [ 7:0] dqs_n                      ,
    // FPGA signals
    //interrupts
    input  logic [15:0] fpga_irq_src               ,
    output logic [11:0] fpga_irq_set               ,
    // DMA request/acknowledge pairs for FPGA hardware handshake
    input  logic [ 3:0] dma_req_fpga               ,
    output logic [ 3:0] dma_ack_fpga               ,
    // FPGA AHB Slave
    output logic [31:0] fpga_ahb_s0_haddr          ,
    output logic [ 2:0] fpga_ahb_s0_hburst         ,
    output logic        fpga_ahb_s0_hmastlock      ,
    output logic [ 3:0] fpga_ahb_s0_hprot          ,
    input  logic [31:0] fpga_ahb_s0_hrdata         ,
    input  logic        fpga_ahb_s0_hready         ,
    input  logic        fpga_ahb_s0_hresp          ,
    output logic        fpga_ahb_s0_hsel           ,
    output logic [ 2:0] fpga_ahb_s0_hsize          ,
    output logic [ 1:0] fpga_ahb_s0_htrans         ,
    output logic [ 3:0] fpga_ahb_s0_hwbe           ,
    output logic [31:0] fpga_ahb_s0_hwdata         ,
    output logic        fpga_ahb_s0_hwrite         ,
    // FPGA AXI Master 0
    input  logic [31:0] fpga_axi_m0_ar_addr        ,
    input  logic [ 1:0] fpga_axi_m0_ar_burst       ,
    input  logic [ 3:0] fpga_axi_m0_ar_cache       ,
    input  logic [ 3:0] fpga_axi_m0_ar_id          ,
    input  logic [ 2:0] fpga_axi_m0_ar_len         ,
    input  logic        fpga_axi_m0_ar_lock        ,
    input  logic [ 2:0] fpga_axi_m0_ar_prot        ,
    output logic        fpga_axi_m0_ar_ready       ,
    input  logic [ 2:0] fpga_axi_m0_ar_size        ,
    input  logic        fpga_axi_m0_ar_valid       ,
    input  logic [31:0] fpga_axi_m0_aw_addr        ,
    input  logic [ 1:0] fpga_axi_m0_aw_burst       ,
    input  logic [ 3:0] fpga_axi_m0_aw_cache       ,
    input  logic [ 3:0] fpga_axi_m0_aw_id          ,
    input  logic [ 2:0] fpga_axi_m0_aw_len         ,
    input  logic        fpga_axi_m0_aw_lock        ,
    input  logic [ 2:0] fpga_axi_m0_aw_prot        ,
    output logic        fpga_axi_m0_aw_ready       ,
    input  logic [ 2:0] fpga_axi_m0_aw_size        ,
    input  logic        fpga_axi_m0_aw_valid       ,
    output logic [ 3:0] fpga_axi_m0_b_id           ,
    input  logic        fpga_axi_m0_b_ready        ,
    output logic [ 1:0] fpga_axi_m0_b_resp         ,
    output logic        fpga_axi_m0_b_valid        ,
    output logic [63:0] fpga_axi_m0_r_data         ,
    output logic [ 3:0] fpga_axi_m0_r_id           ,
    output logic        fpga_axi_m0_r_last         ,
    input  logic        fpga_axi_m0_r_ready        ,
    output logic [ 1:0] fpga_axi_m0_r_resp         ,
    output logic        fpga_axi_m0_r_valid        ,
    input  logic [63:0] fpga_axi_m0_w_data         ,
    input  logic        fpga_axi_m0_w_last         ,
    output logic        fpga_axi_m0_w_ready        ,
    input  logic [ 7:0] fpga_axi_m0_w_strb         ,
    input  logic        fpga_axi_m0_w_valid        ,
    // FPGA AXI Master 0
    input  logic [31:0] fpga_axi_m1_ar_addr        ,
    input  logic [ 1:0] fpga_axi_m1_ar_burst       ,
    input  logic [ 3:0] fpga_axi_m1_ar_cache       ,
    input  logic [ 3:0] fpga_axi_m1_ar_id          ,
    input  logic [ 3:0] fpga_axi_m1_ar_len         ,
    input  logic        fpga_axi_m1_ar_lock        ,
    input  logic [ 2:0] fpga_axi_m1_ar_prot        ,
    output logic        fpga_axi_m1_ar_ready       ,
    input  logic [ 2:0] fpga_axi_m1_ar_size        ,
    input  logic        fpga_axi_m1_ar_valid       ,
    input  logic [31:0] fpga_axi_m1_aw_addr        ,
    input  logic [ 1:0] fpga_axi_m1_aw_burst       ,
    input  logic [ 3:0] fpga_axi_m1_aw_cache       ,
    input  logic [ 3:0] fpga_axi_m1_aw_id          ,
    input  logic [ 3:0] fpga_axi_m1_aw_len         ,
    input  logic        fpga_axi_m1_aw_lock        ,
    input  logic [ 2:0] fpga_axi_m1_aw_prot        ,
    output logic        fpga_axi_m1_aw_ready       ,
    input  logic [ 2:0] fpga_axi_m1_aw_size        ,
    input  logic        fpga_axi_m1_aw_valid       ,
    output logic [ 3:0] fpga_axi_m1_b_id           ,
    input  logic        fpga_axi_m1_b_ready        ,
    output logic [ 1:0] fpga_axi_m1_b_resp         ,
    output logic        fpga_axi_m1_b_valid        ,
    output logic [31:0] fpga_axi_m1_r_data         ,
    output logic [ 3:0] fpga_axi_m1_r_id           ,
    output logic        fpga_axi_m1_r_last         ,
    input  logic        fpga_axi_m1_r_ready        ,
    output logic [ 1:0] fpga_axi_m1_r_resp         ,
    output logic        fpga_axi_m1_r_valid        ,
    input  logic [31:0] fpga_axi_m1_w_data         ,
    input  logic        fpga_axi_m1_w_last         ,
    output logic        fpga_axi_m1_w_ready        ,
    input  logic [ 3:0] fpga_axi_m1_w_strb         ,
    input  logic        fpga_axi_m1_w_valid        ,
  // PAD IOs
    inout		RST_N,
    inout		XIN,
    inout		REF_CLK_1,
    inout		REF_CLK_2,
    inout		REF_CLK_3,
    inout		REF_CLK_4,
    inout		TESTMODE,
    inout		BOOTM0,
    inout		BOOTM1,
    inout		BOOTM2,
    inout		CLKSEL_0,
    inout		CLKSEL_1,
    inout		JTAG_TDI,
    inout		JTAG_TDO,
    inout		JTAG_TMS,
    inout		JTAG_TCK,
    inout		JTAG_TRSTN,
    inout		GPIO_A_0,
    inout		GPIO_A_1,
    inout		GPIO_A_2,
    inout		GPIO_A_3,
    inout		GPIO_A_4,
    inout		GPIO_A_5,
    inout		GPIO_A_6,
    inout		GPIO_A_7,
    inout		GPIO_A_8,
    inout		GPIO_A_9,
    inout		GPIO_A_10,
    inout		GPIO_A_11,
    inout		GPIO_A_12,
    inout		GPIO_A_13,
    inout		GPIO_A_14,
    inout		GPIO_A_15,
    inout		GPIO_B_0,
    inout		GPIO_B_1,
    inout		GPIO_B_2,
    inout		GPIO_B_3,
    inout		GPIO_B_4,
    inout		GPIO_B_5,
    inout		GPIO_B_6,
    inout		GPIO_B_7,
    inout		GPIO_B_8,
    inout		GPIO_B_9,
    inout		GPIO_B_10,
    inout		GPIO_B_11,
    inout		GPIO_B_12,
    inout		GPIO_B_13,
    inout		GPIO_B_14,
    inout		GPIO_B_15,
    inout		GPIO_C_0,
    inout		GPIO_C_1,
    inout		GPIO_C_2,
    inout		GPIO_C_3,
    inout		GPIO_C_4,
    inout		GPIO_C_5,
    inout		GPIO_C_6,
    inout		GPIO_C_7,
    inout		GPIO_C_8,
    inout		GPIO_C_9,
    inout		GPIO_C_10,
    inout		GPIO_C_11,
    inout		GPIO_C_12,
    inout		GPIO_C_13,
    inout		GPIO_C_14,
    inout		GPIO_C_15,
    inout		I2C_SCL,
    inout		SPI_SCLK,
    inout		GPT_RTC,
    inout		MDIO_MDC,
    inout		MDIO_DATA,
    inout		RGMII_TXD0,
    inout		RGMII_TXD1,
    inout		RGMII_TXD2,
    inout		RGMII_TXD3,
    inout		RGMII_TX_CTL,
    inout		RGMII_TXC,
    inout		RGMII_RXD0,
    inout		RGMII_RXD1,
    inout		RGMII_RXD2,
    inout		RGMII_RXD3,
    inout		RGMII_RX_CTL,
    inout		RGMII_RXC,
    inout		USB_DP,
    inout		USB_DN,
    inout		USB_XTAL_OUT,
    inout		USB_XTAL_IN,
    // isolation cells control
    output logic        ace_isolation_ctl          ,
    output logic        irq_isolation_ctl          ,
    output logic        fcb_isolation_ctl          ,
    output logic        ahb_isolation_ctl          ,
    output logic        axi1_isolation_ctl         ,
    output logic        axi0_isolation_ctl
);
// mem_ss parameters
localparam ADDR_WIDTH  = 32             ;
localparam SRAM_DWIDTH = 32             ;
localparam DDR_DWIDTH  = 64             ;
localparam SRAM_SWIDTH = (SRAM_DWIDTH/8);
localparam DDR_SWIDTH  = (DDR_DWIDTH/8) ;
// clocks 
logic clk_apb_ug;
logic clk_bcpu;
logic clk_acpu;

// interfaces signals
logic [           31:0] acpu_wdt_s0_paddr   ;
logic                   acpu_wdt_s0_psel    ;
logic                   acpu_wdt_s0_penable ;
logic                   acpu_wdt_s0_pwrite  ;
logic [           31:0] acpu_wdt_s0_pwdata  ;
logic [           31:0] acpu_wdt_s0_prdata  ;
logic                   acpu_wdt_s0_pready  ;
logic                   acpu_wdt_s0_pslverr ;
logic [           31:0] bcpu_wdt_s0_paddr   ;
logic                   bcpu_wdt_s0_psel    ;
logic                   bcpu_wdt_s0_penable ;
logic                   bcpu_wdt_s0_pwrite  ;
logic [           31:0] bcpu_wdt_s0_pwdata  ;
logic [           31:0] bcpu_wdt_s0_prdata  ;
logic                   bcpu_wdt_s0_pready  ;
logic                   bcpu_wdt_s0_pslverr ;
logic [           31:0] dma_s0_paddr        ;
logic                   dma_s0_psel         ;
logic                   dma_s0_penable      ;
logic                   dma_s0_pwrite       ;
logic [           31:0] dma_s0_pwdata       ;
logic [           31:0] dma_s0_prdata       ;
logic                   dma_s0_pready       ;
logic                   dma_s0_pslverr      ;
logic [           31:0] fcb_s0_paddr        ;
logic                   fcb_s0_psel         ;
logic                   fcb_s0_penable      ;
logic                   fcb_s0_pwrite       ;
logic [           31:0] fcb_s0_pwdata       ;
logic [            3:0] fcb_s0_pstrb        ;
logic [           31:0] fcb_s0_prdata       ;
logic                   fcb_s0_pready       ;
logic                   fcb_s0_pslverr      ;
logic [           31:0] gpio_s0_paddr       ;
logic                   gpio_s0_psel        ;
logic                   gpio_s0_penable     ;
logic                   gpio_s0_pwrite      ;
logic [           31:0] gpio_s0_pwdata      ;
logic [           31:0] gpio_s0_prdata      ;
logic                   gpio_s0_pready      ;
logic                   gpio_s0_pslverr     ;
logic [           31:0] gpt_s0_paddr        ;
logic                   gpt_s0_psel         ;
logic                   gpt_s0_penable      ;
logic                   gpt_s0_pwrite       ;
logic [           31:0] gpt_s0_pwdata       ;
logic [           31:0] gpt_s0_prdata       ;
logic                   gpt_s0_pready       ;
logic                   gpt_s0_pslverr      ;
logic [           31:0] i2c_s0_paddr        ;
logic                   i2c_s0_psel         ;
logic                   i2c_s0_penable      ;
logic                   i2c_s0_pwrite       ;
logic [           31:0] i2c_s0_pwdata       ;
logic [           31:0] i2c_s0_prdata       ;
logic                   i2c_s0_pready       ;
logic                   i2c_s0_pslverr      ;
logic [           31:0] mbox_s0_paddr       ;
logic                   mbox_s0_psel        ;
logic                   mbox_s0_penable     ;
logic                   mbox_s0_pwrite      ;
logic [           31:0] mbox_s0_pwdata      ;
logic [            3:0] mbox_s0_pstrb       ;
logic [           31:0] mbox_s0_prdata      ;
logic                   mbox_s0_pready      ;
logic                   mbox_s0_pslverr     ;
logic [           31:0] scu_s0_paddr        ;
logic                   scu_s0_psel         ;
logic                   scu_s0_penable      ;
logic                   scu_s0_pwrite       ;
logic [           31:0] scu_s0_pwdata       ;
logic [            3:0] scu_s0_pstrb        ;
logic [           31:0] scu_s0_prdata       ;
logic                   scu_s0_pready       ;
logic                   scu_s0_pslverr      ;
logic [           31:0] spi_reg_s0_haddr    ;
logic [            2:0] spi_reg_s0_hburst   ;
logic                   spi_reg_s0_hmastlock;
logic [            3:0] spi_reg_s0_hprot    ;
logic [           31:0] spi_reg_s0_hrdata   ;
logic                   spi_reg_s0_hready   ;
logic                   spi_reg_s0_hresp    ;
logic                   spi_reg_s0_hsel     ;
logic [            1:0] spi_reg_s0_htrans   ;
logic [           31:0] spi_reg_s0_hwdata   ;
logic                   spi_reg_s0_hwrite   ;
logic [           31:0] spi_mem_s0_haddr    ;
logic [            2:0] spi_mem_s0_hburst   ;
logic                   spi_mem_s0_hmastlock;
logic [            3:0] spi_mem_s0_hprot    ;
logic [           31:0] spi_mem_s0_hrdata   ;
logic                   spi_mem_s0_hready   ;
logic                   spi_mem_s0_hresp    ;
logic                   spi_mem_s0_hsel     ;
logic [            2:0] spi_mem_s0_hsize    ;
logic [            1:0] spi_mem_s0_htrans   ;
logic                   spi_mem_s0_hwrite   ;
logic [           31:0] uart_s0_paddr       ;
logic                   uart_s0_psel        ;
logic                   uart_s0_penable     ;
logic                   uart_s0_pwrite      ;
logic [           31:0] uart_s0_pwdata      ;
logic [           31:0] uart_s0_prdata      ;
logic                   uart_s0_pready      ;
logic                   uart_s0_pslverr     ;
logic [           31:0] uart_s1_paddr       ;
logic                   uart_s1_psel        ;
logic                   uart_s1_penable     ;
logic                   uart_s1_pwrite      ;
logic [           31:0] uart_s1_pwdata      ;
logic [           31:0] uart_s1_prdata      ;
logic                   uart_s1_pready      ;
logic                   uart_s1_pslverr     ;
logic [           31:0] usb_s0_araddr       ;
logic [            2:0] usb_s0_arprot       ;
logic                   usb_s0_arready      ;
logic                   usb_s0_arvalid      ;
logic [           31:0] usb_s0_awaddr       ;
logic [            2:0] usb_s0_awprot       ;
logic                   usb_s0_awready      ;
logic                   usb_s0_awvalid      ;
logic                   usb_s0_bready       ;
logic [            1:0] usb_s0_bresp        ;
logic                   usb_s0_bvalid       ;
logic [           31:0] usb_s0_rdata        ;
logic                   usb_s0_rready       ;
logic [            1:0] usb_s0_rresp        ;
logic                   usb_s0_rvalid       ;
logic [           31:0] usb_s0_wdata        ;
logic                   usb_s0_wready       ;
logic [            3:0] usb_s0_wstrb        ;
logic                   usb_s0_wvalid       ;
logic [           31:0] acpu_m0_araddr      ;
logic [            1:0] acpu_m0_arburst     ;
logic [            3:0] acpu_m0_arcache     ;
logic [            3:0] acpu_m0_arid        ;
logic [            7:0] acpu_m0_arlen       ;
logic                   acpu_m0_arlock      ;
logic [            2:0] acpu_m0_arprot      ;
logic                   acpu_m0_arready     ;
logic [            2:0] acpu_m0_arsize      ;
logic                   acpu_m0_arvalid     ;
logic [           31:0] acpu_m0_awaddr      ;
logic [            1:0] acpu_m0_awburst     ;
logic [            3:0] acpu_m0_awcache     ;
logic [            3:0] acpu_m0_awid        ;
logic [            7:0] acpu_m0_awlen       ;
logic                   acpu_m0_awlock      ;
logic [            2:0] acpu_m0_awprot      ;
logic                   acpu_m0_awready     ;
logic [            2:0] acpu_m0_awsize      ;
logic                   acpu_m0_awvalid     ;
logic [            3:0] acpu_m0_bid         ;
logic                   acpu_m0_bready      ;
logic [            1:0] acpu_m0_bresp       ;
logic                   acpu_m0_bvalid      ;
logic [           63:0] acpu_m0_rdata       ;
logic [            3:0] acpu_m0_rid         ;
logic                   acpu_m0_rlast       ;
logic                   acpu_m0_rready      ;
logic [            1:0] acpu_m0_rresp       ;
logic                   acpu_m0_rvalid      ;
logic [           63:0] acpu_m0_wdata       ;
logic                   acpu_m0_wlast       ;
logic                   acpu_m0_wready      ;
logic [            7:0] acpu_m0_wstrb       ;
logic                   acpu_m0_wvalid      ;
logic [           31:0] bcpu_m0_hrdata      ;
logic                   bcpu_m0_hready      ;
logic [            1:0] bcpu_m0_hresp       ;
logic [           31:0] bcpu_m0_haddr       ;
logic                   bcpu_m0_hsel        ;
logic [            2:0] bcpu_m0_hburst      ;
logic [            3:0] bcpu_m0_hprot       ;
logic [            2:0] bcpu_m0_hsize       ;
logic [            1:0] bcpu_m0_htrans      ;
logic [           31:0] bcpu_m0_hwdata      ;
logic                   bcpu_m0_hwrite      ;
logic [           31:0] dma_m0_araddr       ;
logic [            1:0] dma_m0_arburst      ;
logic [            3:0] dma_m0_arcache      ;
logic [            2:0] dma_m0_arid         ;
logic [            7:0] dma_m0_arlen        ;
logic                   dma_m0_arlock       ;
logic [            2:0] dma_m0_arprot       ;
logic                   dma_m0_arready      ;
logic [            2:0] dma_m0_arsize       ;
logic                   dma_m0_arvalid      ;
logic [           31:0] dma_m0_awaddr       ;
logic [            1:0] dma_m0_awburst      ;
logic [            3:0] dma_m0_awcache      ;
logic [            2:0] dma_m0_awid         ;
logic [            7:0] dma_m0_awlen        ;
logic                   dma_m0_awlock       ;
logic [            2:0] dma_m0_awprot       ;
logic                   dma_m0_awready      ;
logic [            2:0] dma_m0_awsize       ;
logic                   dma_m0_awvalid      ;
logic [            3:0] dma_m0_bid          ;
logic                   dma_m0_bready       ;
logic [            1:0] dma_m0_bresp        ;
logic                   dma_m0_bvalid       ;
logic [           31:0] dma_m0_rdata        ;
logic [            3:0] dma_m0_rid          ;
logic                   dma_m0_rlast        ;
logic                   dma_m0_rready       ;
logic [            1:0] dma_m0_rresp        ;
logic                   dma_m0_rvalid       ;
logic [           31:0] dma_m0_wdata        ;
logic                   dma_m0_wlast        ;
logic                   dma_m0_wready       ;
logic [            3:0] dma_m0_wstrb        ;
logic                   dma_m0_wvalid       ;
logic [           31:0] dma_m1_araddr       ;
logic [            1:0] dma_m1_arburst      ;
logic [            3:0] dma_m1_arcache      ;
logic [            2:0] dma_m1_arid         ;
logic [            7:0] dma_m1_arlen        ;
logic                   dma_m1_arlock       ;
logic [            2:0] dma_m1_arprot       ;
logic                   dma_m1_arready      ;
logic [            2:0] dma_m1_arsize       ;
logic                   dma_m1_arvalid      ;
logic [           31:0] dma_m1_awaddr       ;
logic [            1:0] dma_m1_awburst      ;
logic [            3:0] dma_m1_awcache      ;
logic [            2:0] dma_m1_awid         ;
logic [            7:0] dma_m1_awlen        ;
logic                   dma_m1_awlock       ;
logic [            2:0] dma_m1_awprot       ;
logic                   dma_m1_awready      ;
logic [            2:0] dma_m1_awsize       ;
logic                   dma_m1_awvalid      ;
logic [            3:0] dma_m1_bid          ;
logic                   dma_m1_bready       ;
logic [            1:0] dma_m1_bresp        ;
logic                   dma_m1_bvalid       ;
logic [           31:0] dma_m1_rdata        ;
logic [            3:0] dma_m1_rid          ;
logic                   dma_m1_rlast        ;
logic                   dma_m1_rready       ;
logic [            1:0] dma_m1_rresp        ;
logic                   dma_m1_rvalid       ;
logic [           31:0] dma_m1_wdata        ;
logic                   dma_m1_wlast        ;
logic                   dma_m1_wready       ;
logic [            3:0] dma_m1_wstrb        ;
logic                   dma_m1_wvalid       ;
logic [           31:0] gbe_s0_paddr        ;
logic                   gbe_s0_psel         ;
logic                   gbe_s0_penable      ;
logic                   gbe_s0_pwrite       ;
logic [           31:0] gbe_s0_pwdata       ;
logic [            3:0] gbe_s0_pstrb        ;
logic [           31:0] gbe_s0_prdata       ;
logic                   gbe_s0_pready       ;
logic                   gbe_s0_pslverr      ;
logic [           31:0] gbe_m0_araddr       ;
logic [            1:0] gbe_m0_arburst      ;
logic [            3:0] gbe_m0_arcache      ;
logic [            2:0] gbe_m0_arid         ;
logic [            7:0] gbe_m0_arlen        ;
logic                   gbe_m0_arlock       ;
logic [            2:0] gbe_m0_arprot       ;
logic                   gbe_m0_arready      ;
logic [            2:0] gbe_m0_arsize       ;
logic                   gbe_m0_arvalid      ;
logic [           31:0] gbe_m0_awaddr       ;
logic [            1:0] gbe_m0_awburst      ;
logic [            3:0] gbe_m0_awcache      ;
logic [            2:0] gbe_m0_awid         ;
logic [            7:0] gbe_m0_awlen        ;
logic                   gbe_m0_awlock       ;
logic [            2:0] gbe_m0_awprot       ;
logic                   gbe_m0_awready      ;
logic [            2:0] gbe_m0_awsize       ;
logic                   gbe_m0_awvalid      ;
logic [            3:0] gbe_m0_bid          ;
logic                   gbe_m0_bready       ;
logic [            1:0] gbe_m0_bresp        ;
logic                   gbe_m0_bvalid       ;
logic [           31:0] gbe_m0_rdata        ;
logic [            3:0] gbe_m0_rid          ;
logic                   gbe_m0_rlast        ;
logic                   gbe_m0_rready       ;
logic [            1:0] gbe_m0_rresp        ;
logic                   gbe_m0_rvalid       ;
logic [           31:0] gbe_m0_wdata        ;
logic                   gbe_m0_wlast        ;
logic                   gbe_m0_wready       ;
logic [            3:0] gbe_m0_wstrb        ;
logic                   gbe_m0_wvalid       ;
logic [           31:0] usb_m0_araddr       ;
logic [            1:0] usb_m0_arburst      ;
logic [            3:0] usb_m0_arcache      ;
logic [            2:0] usb_m0_arid         ;
logic [            7:0] usb_m0_arlen        ;
logic                   usb_m0_arlock       ;
logic [            2:0] usb_m0_arprot       ;
logic                   usb_m0_arready      ;
logic [            2:0] usb_m0_arsize       ;
logic                   usb_m0_arvalid      ;
logic [           31:0] usb_m0_awaddr       ;
logic [            1:0] usb_m0_awburst      ;
logic [            3:0] usb_m0_awcache      ;
logic [            2:0] usb_m0_awid         ;
logic [            7:0] usb_m0_awlen        ;
logic                   usb_m0_awlock       ;
logic [            2:0] usb_m0_awprot       ;
logic                   usb_m0_awready      ;
logic [            2:0] usb_m0_awsize       ;
logic                   usb_m0_awvalid      ;
logic [            3:0] usb_m0_bid          ;
logic                   usb_m0_bready       ;
logic [            1:0] usb_m0_bresp        ;
logic                   usb_m0_bvalid       ;
logic [           31:0] usb_m0_rdata        ;
logic [            3:0] usb_m0_rid          ;
logic                   usb_m0_rlast        ;
logic                   usb_m0_rready       ;
logic [            1:0] usb_m0_rresp        ;
logic                   usb_m0_rvalid       ;
logic [           31:0] usb_m0_wdata        ;
logic                   usb_m0_wlast        ;
logic                   usb_m0_wready       ;
logic [            3:0] usb_m0_wstrb        ;
logic                   usb_m0_wvalid       ;
logic                   ddr0_awvalid        ;
logic                   ddr0_awready        ;
logic [ ADDR_WIDTH-1:0] ddr0_awaddr         ;
logic [            2:0] ddr0_awsize         ;
logic [            1:0] ddr0_awburst        ;
logic [            3:0] ddr0_awcache        ;
logic [            2:0] ddr0_awprot         ;
logic                   ddr0_awlock         ;
logic [            3:0] ddr0_awqos          ;
logic [            3:0] ddr0_awid           ;
logic [            3:0] ddr0_awlen          ;
logic                   ddr0_wvalid         ;
logic                   ddr0_wready         ;
logic                   ddr0_wlast          ;
logic [ DDR_DWIDTH-1:0] ddr0_wdata          ;
logic [ DDR_SWIDTH-1:0] ddr0_wstrb          ;
logic [            3:0] ddr0_wid            ;
logic                   ddr0_bvalid         ;
logic                   ddr0_bready         ;
logic [            1:0] ddr0_bresp          ;
logic [            3:0] ddr0_bid            ;
logic                   ddr0_arvalid        ;
logic                   ddr0_arready        ;
logic [ ADDR_WIDTH-1:0] ddr0_araddr         ;
logic [            2:0] ddr0_arsize         ;
logic [            1:0] ddr0_arburst        ;
logic [            3:0] ddr0_arcache        ;
logic [            2:0] ddr0_arprot         ;
logic                   ddr0_arlock         ;
logic [            3:0] ddr0_arqos          ;
logic [            3:0] ddr0_arid           ;
logic [            3:0] ddr0_arlen          ;
logic                   ddr0_rvalid         ;
logic                   ddr0_rready         ;
logic                   ddr0_rlast          ;
logic [ DDR_DWIDTH-1:0] ddr0_rdata          ;
logic [            1:0] ddr0_rresp          ;
logic [            3:0] ddr0_rid            ;
logic                   ddr1_awvalid        ;
logic                   ddr1_awready        ;
logic [ ADDR_WIDTH-1:0] ddr1_awaddr         ;
logic [            2:0] ddr1_awsize         ;
logic [            1:0] ddr1_awburst        ;
logic [            3:0] ddr1_awcache        ;
logic [            2:0] ddr1_awprot         ;
logic                   ddr1_awlock         ;
logic [            3:0] ddr1_awqos          ;
logic [            3:0] ddr1_awid           ;
logic [            3:0] ddr1_awlen          ;
logic                   ddr1_wvalid         ;
logic                   ddr1_wready         ;
logic                   ddr1_wlast          ;
logic [ DDR_DWIDTH-1:0] ddr1_wdata          ;
logic [ DDR_SWIDTH-1:0] ddr1_wstrb          ;
logic [            3:0] ddr1_wid            ;
logic                   ddr1_bvalid         ;
logic                   ddr1_bready         ;
logic [            1:0] ddr1_bresp          ;
logic [            3:0] ddr1_bid            ;
logic                   ddr1_arvalid        ;
logic                   ddr1_arready        ;
logic [ ADDR_WIDTH-1:0] ddr1_araddr         ;
logic [            2:0] ddr1_arsize         ;
logic [            1:0] ddr1_arburst        ;
logic [            3:0] ddr1_arcache        ;
logic [            2:0] ddr1_arprot         ;
logic                   ddr1_arlock         ;
logic [            3:0] ddr1_arqos          ;
logic [            3:0] ddr1_arid           ;
logic [            3:0] ddr1_arlen          ;
logic                   ddr1_rvalid         ;
logic                   ddr1_rready         ;
logic                   ddr1_rlast          ;
logic [ DDR_DWIDTH-1:0] ddr1_rdata          ;
logic [            1:0] ddr1_rresp          ;
logic [            3:0] ddr1_rid            ;
logic                   ddr2_awvalid        ;
logic                   ddr2_awready        ;
logic [ ADDR_WIDTH-1:0] ddr2_awaddr         ;
logic [            2:0] ddr2_awsize         ;
logic [            1:0] ddr2_awburst        ;
logic [            3:0] ddr2_awcache        ;
logic [            2:0] ddr2_awprot         ;
logic                   ddr2_awlock         ;
logic [            3:0] ddr2_awqos          ;
logic [            3:0] ddr2_awid           ;
logic [            3:0] ddr2_awlen          ;
logic                   ddr2_wvalid         ;
logic                   ddr2_wready         ;
logic                   ddr2_wlast          ;
logic [ DDR_DWIDTH-1:0] ddr2_wdata          ;
logic [ DDR_SWIDTH-1:0] ddr2_wstrb          ;
logic [            3:0] ddr2_wid            ;
logic                   ddr2_bvalid         ;
logic                   ddr2_bready         ;
logic [            1:0] ddr2_bresp          ;
logic [            3:0] ddr2_bid            ;
logic                   ddr2_arvalid        ;
logic                   ddr2_arready        ;
logic [ ADDR_WIDTH-1:0] ddr2_araddr         ;
logic [            2:0] ddr2_arsize         ;
logic [            1:0] ddr2_arburst        ;
logic [            3:0] ddr2_arcache        ;
logic [            2:0] ddr2_arprot         ;
logic                   ddr2_arlock         ;
logic [            3:0] ddr2_arqos          ;
logic [            3:0] ddr2_arid           ;
logic [            3:0] ddr2_arlen          ;
logic                   ddr2_rvalid         ;
logic                   ddr2_rready         ;
logic                   ddr2_rlast          ;
logic [ DDR_DWIDTH-1:0] ddr2_rdata          ;
logic [            1:0] ddr2_rresp          ;
logic [            3:0] ddr2_rid            ;
logic                   ddr3_awvalid        ;
logic                   ddr3_awready        ;
logic [ ADDR_WIDTH-1:0] ddr3_awaddr         ;
logic [            2:0] ddr3_awsize         ;
logic [            1:0] ddr3_awburst        ;
logic [            3:0] ddr3_awcache        ;
logic [            2:0] ddr3_awprot         ;
logic                   ddr3_awlock         ;
logic [            3:0] ddr3_awqos          ;
logic [            3:0] ddr3_awid           ;
logic [            3:0] ddr3_awlen          ;
logic                   ddr3_wvalid         ;
logic                   ddr3_wready         ;
logic                   ddr3_wlast          ;
logic [ DDR_DWIDTH-1:0] ddr3_wdata          ;
logic [ DDR_SWIDTH-1:0] ddr3_wstrb          ;
logic [            3:0] ddr3_wid            ;
logic                   ddr3_bvalid         ;
logic                   ddr3_bready         ;
logic [            1:0] ddr3_bresp          ;
logic [            3:0] ddr3_bid            ;
logic                   ddr3_arvalid        ;
logic                   ddr3_arready        ;
logic [ ADDR_WIDTH-1:0] ddr3_araddr         ;
logic [            2:0] ddr3_arsize         ;
logic [            1:0] ddr3_arburst        ;
logic [            3:0] ddr3_arcache        ;
logic [            2:0] ddr3_arprot         ;
logic                   ddr3_arlock         ;
logic [            3:0] ddr3_arqos          ;
logic [            3:0] ddr3_arid           ;
logic [            3:0] ddr3_arlen          ;
logic                   ddr3_rvalid         ;
logic                   ddr3_rready         ;
logic                   ddr3_rlast          ;
logic [ DDR_DWIDTH-1:0] ddr3_rdata          ;
logic [            1:0] ddr3_rresp          ;
logic [            3:0] ddr3_rid            ;
logic                   sramb0_awvalid      ;
logic                   sramb0_awready      ;
logic [ ADDR_WIDTH-1:0] sramb0_awaddr       ;
logic [            2:0] sramb0_awsize       ;
logic [            1:0] sramb0_awburst      ;
logic [            3:0] sramb0_awid         ;
logic [            3:0] sramb0_awlen        ;
logic                   sramb0_wvalid       ;
logic                   sramb0_wready       ;
logic                   sramb0_wlast        ;
logic [SRAM_DWIDTH-1:0] sramb0_wdata        ;
logic [SRAM_SWIDTH-1:0] sramb0_wstrb        ;
logic [            3:0] sramb0_wid          ;
logic                   sramb0_bvalid       ;
logic                   sramb0_bready       ;
logic [            1:0] sramb0_bresp        ;
logic [            3:0] sramb0_bid          ;
logic                   sramb0_arvalid      ;
logic                   sramb0_arready      ;
logic [ ADDR_WIDTH-1:0] sramb0_araddr       ;
logic [            2:0] sramb0_arsize       ;
logic [            1:0] sramb0_arburst      ;
logic [            3:0] sramb0_arid         ;
logic [            3:0] sramb0_arlen        ;
logic                   sramb0_rvalid       ;
logic                   sramb0_rready       ;
logic                   sramb0_rlast        ;
logic [SRAM_DWIDTH-1:0] sramb0_rdata        ;
logic [            1:0] sramb0_rresp        ;
logic [            3:0] sramb0_rid          ;
logic                   sramb1_awvalid      ;
logic                   sramb1_awready      ;
logic [ ADDR_WIDTH-1:0] sramb1_awaddr       ;
logic [            2:0] sramb1_awsize       ;
logic [            1:0] sramb1_awburst      ;
logic [            3:0] sramb1_awid         ;
logic [            3:0] sramb1_awlen        ;
logic                   sramb1_wvalid       ;
logic                   sramb1_wready       ;
logic                   sramb1_wlast        ;
logic [SRAM_DWIDTH-1:0] sramb1_wdata        ;
logic [SRAM_SWIDTH-1:0] sramb1_wstrb        ;
logic [            3:0] sramb1_wid          ;
logic                   sramb1_bvalid       ;
logic                   sramb1_bready       ;
logic [            1:0] sramb1_bresp        ;
logic [            3:0] sramb1_bid          ;
logic                   sramb1_arvalid      ;
logic                   sramb1_arready      ;
logic [ ADDR_WIDTH-1:0] sramb1_araddr       ;
logic [            2:0] sramb1_arsize       ;
logic [            1:0] sramb1_arburst      ;
logic [            3:0] sramb1_arid         ;
logic [            3:0] sramb1_arlen        ;
logic                   sramb1_rvalid       ;
logic                   sramb1_rready       ;
logic                   sramb1_rlast        ;
logic [SRAM_DWIDTH-1:0] sramb1_rdata        ;
logic [            1:0] sramb1_rresp        ;
logic [            3:0] sramb1_rid          ;
logic                   sramb2_awvalid      ;
logic                   sramb2_awready      ;
logic [ ADDR_WIDTH-1:0] sramb2_awaddr       ;
logic [            2:0] sramb2_awsize       ;
logic [            1:0] sramb2_awburst      ;
logic [            3:0] sramb2_awid         ;
logic [            3:0] sramb2_awlen        ;
logic                   sramb2_wvalid       ;
logic                   sramb2_wready       ;
logic                   sramb2_wlast        ;
logic [SRAM_DWIDTH-1:0] sramb2_wdata        ;
logic [SRAM_SWIDTH-1:0] sramb2_wstrb        ;
logic [            3:0] sramb2_wid          ;
logic                   sramb2_bvalid       ;
logic                   sramb2_bready       ;
logic [            1:0] sramb2_bresp        ;
logic [            3:0] sramb2_bid          ;
logic                   sramb2_arvalid      ;
logic                   sramb2_arready      ;
logic [ ADDR_WIDTH-1:0] sramb2_araddr       ;
logic [            2:0] sramb2_arsize       ;
logic [            1:0] sramb2_arburst      ;
logic [            3:0] sramb2_arid         ;
logic [            3:0] sramb2_arlen        ;
logic                   sramb2_rvalid       ;
logic                   sramb2_rready       ;
logic                   sramb2_rlast        ;
logic [SRAM_DWIDTH-1:0] sramb2_rdata        ;
logic [            1:0] sramb2_rresp        ;
logic [            3:0] sramb2_rid          ;
logic                   sramb3_awvalid      ;
logic                   sramb3_awready      ;
logic [ ADDR_WIDTH-1:0] sramb3_awaddr       ;
logic [            2:0] sramb3_awsize       ;
logic [            1:0] sramb3_awburst      ;
logic [            3:0] sramb3_awid         ;
logic [            3:0] sramb3_awlen        ;
logic                   sramb3_wvalid       ;
logic                   sramb3_wready       ;
logic                   sramb3_wlast        ;
logic [SRAM_DWIDTH-1:0] sramb3_wdata        ;
logic [SRAM_SWIDTH-1:0] sramb3_wstrb        ;
logic [            3:0] sramb3_wid          ;
logic                   sramb3_bvalid       ;
logic                   sramb3_bready       ;
logic [            1:0] sramb3_bresp        ;
logic [            3:0] sramb3_bid          ;
logic                   sramb3_arvalid      ;
logic                   sramb3_arready      ;
logic [ ADDR_WIDTH-1:0] sramb3_araddr       ;
logic [            2:0] sramb3_arsize       ;
logic [            1:0] sramb3_arburst      ;
logic [            3:0] sramb3_arid         ;
logic [            3:0] sramb3_arlen        ;
logic                   sramb3_rvalid       ;
logic                   sramb3_rready       ;
logic                   sramb3_rlast        ;
logic [SRAM_DWIDTH-1:0] sramb3_rdata        ;
logic [            1:0] sramb3_rresp        ;
logic [            3:0] sramb3_rid          ;
logic                   cntl_arready        ;
logic                   cntl_awready        ;
logic [            1:0] cntl_bresp          ;
logic                   cntl_bvalid         ;
logic [           31:0] cntl_rdata          ;
logic [            1:0] cntl_rresp          ;
logic                   cntl_rvalid         ;
logic                   cntl_wready         ;
logic [           31:0] cntl_araddr         ;
logic                   cntl_arvalid        ;
logic [           31:0] cntl_awaddr         ;
logic                   cntl_awvalid        ;
logic                   cntl_bready         ;
logic                   cntl_clk            ;
logic                   cntl_reset_n        ;
logic                   cntl_rready         ;
logic [           31:0] cntl_wdata          ;
logic                   cntl_wvalid         ;
logic [           31:0] acpu_irq_set        ;
logic                   rst_n_bcpu          ;
logic                   rst_n_bcpu_bus      ;
logic                   rst_n_sram          ;
logic                   rst_n_acpu          ;
logic                   rst_n_acpu_bus      ;
logic                   rst_n_ddr           ;
logic                   rst_n_133           ;
logic                   rst_n_266           ;
logic                   rst_n_533           ;


    ae350_cpu_subsystem acpu (
        .arid                     (acpu_m0_arid             ),
        .araddr                   (acpu_m0_araddr           ),
        .arlen                    (acpu_m0_arlen            ),
        .arsize                   (acpu_m0_arsize           ),
        .arburst                  (acpu_m0_arburst          ),
        .arlock                   (acpu_m0_arlock           ),
        .arcache                  (acpu_m0_arcache          ),
        .arprot                   (acpu_m0_arprot           ),
        .arvalid                  (acpu_m0_arvalid          ),
        .arready                  (acpu_m0_arready          ),
        .awid                     (acpu_m0_awid             ),
        .awaddr                   (acpu_m0_awaddr           ),
        .awlen                    (acpu_m0_awlen            ),
        .awsize                   (acpu_m0_awsize           ),
        .awburst                  (acpu_m0_awburst          ),
        .awlock                   (acpu_m0_awlock           ),
        .awcache                  (acpu_m0_awcache          ),
        .awprot                   (acpu_m0_awprot           ),
        .awvalid                  (acpu_m0_awvalid          ),
        .awready                  (acpu_m0_awready          ),
        .wdata                    (acpu_m0_wdata            ),
        .wstrb                    (acpu_m0_wstrb            ),
        .wlast                    (acpu_m0_wlast            ),
        .wvalid                   (acpu_m0_wvalid           ),
        .wready                   (acpu_m0_wready           ),
        .bid                      (acpu_m0_bid              ),
        .bresp                    (acpu_m0_bresp            ),
        .bvalid                   (acpu_m0_bvalid           ),
        .bready                   (acpu_m0_bready           ),
        .rid                      (acpu_m0_rid              ),
        .rdata                    (acpu_m0_rdata            ),
        .rresp                    (acpu_m0_rresp            ),
        .rlast                    (acpu_m0_rlast            ),
        .rvalid                   (acpu_m0_rvalid           ),
        .rready                   (acpu_m0_rready           ),
        .axi_bus_clk_en           (1'b1                     ),
        .core_clk                 (clk_acpu                 ),
        .core_resetn              (rst_n_acpu               ),
        .dbg_srst_req             (                         ),
        .dc_clk                   (clk_acpu                 ),
        .hart0_wakeup_event       (                         ),
        .lm_clk                   (clk_acpu                 ),
        .slvp_resetn              (rst_n_acpu_bus           ),
        .test_rstn                (1'b0                     ),
        .aclk                     (clk_acpu                 ),
        .aresetn                  (rst_n_acpu_bus           ),
        .scan_enable              (                         ),
        .test_mode                (testmode                ),
        .int_src                  (acpu_irq_set[31:1]       ),
        .mtime_clk                (clk_acpu                 ),
        .por_rstn                 (rst_n_acpu_bus           ),
        .hart0_reset_vector       (32'h00000000             ),
        .hart0_icache_disable_init(1'b0                     ),
        .hart0_dcache_disable_init(1'b0                     ),
        .hart0_core_wfi_mode      (                         ),
        .hart0_nmi                (acpu_irq_set[0]          ),
        .jtag_tck                 (acpu_jtag_tck            ),
        .jtag_tdi                 (acpu_jtag_tdi            ),
        .jtag_tdo                 (acpu_jtag_tdo            ),
        .jtag_tms                 (acpu_jtag_tms            )
    );


    soc_config_subsystem config_ss (
        .clk_osc                    (clk_osc                    ),
        .clk_soc_pll0               (clk_soc_pll0               ),
        .clk_soc_pll1               (clk_soc_pll1               ),
        .clk_fpga0                  (clk_fpga0                  ),
        .clk_fpga1                  (clk_fpga1                  ),
        .clk_fpga_s                 (clk_fpga_s                 ),
        .clk_acpu                   (clk_acpu                   ),
        .clk_bcpu                   (clk_bcpu                   ),
        .clk_ddr_phy                (clk_ddr_phy                ),
        .clk_ddr_ctl                (clk_ddr_ctl                ),
        .clk_ddr_cfg                (clk_ddr_cfg                ),
        .clk_apb_ug                 (clk_apb_ug                 ),
        .rst_n_bcpu                 (rst_n_bcpu                 ),
        .rst_n_bcpu_bus             (rst_n_bcpu_bus             ),
        .rst_n_sram                 (rst_n_sram                 ),
        .rst_n_acpu                 (rst_n_acpu                 ),
        .rst_n_acpu_bus             (rst_n_acpu_bus             ),
        .rst_n_fpga0                (rst_n_fpga0                ),
        .rst_n_fpga1                (rst_n_fpga1                ),
        .rst_n_fpga_s               (rst_n_fpga_s               ),
        .rst_n_ddr                  (rst_n_ddr                  ),
        .rst_n_133                  (rst_n_133                  ),
        .rst_n_266                  (rst_n_266                  ),
        .rst_n_533                  (rst_n_533                  ),
        .acpu_wdt_s0_paddr          (acpu_wdt_s0_paddr          ),
        .acpu_wdt_s0_psel           (acpu_wdt_s0_psel           ),
        .acpu_wdt_s0_penable        (acpu_wdt_s0_penable        ),
        .acpu_wdt_s0_pwrite         (acpu_wdt_s0_pwrite         ),
        .acpu_wdt_s0_pwdata         (acpu_wdt_s0_pwdata         ),
        .acpu_wdt_s0_prdata         (acpu_wdt_s0_prdata         ),
        .acpu_wdt_s0_pready         (acpu_wdt_s0_pready         ),
        .acpu_wdt_s0_pslverr        (acpu_wdt_s0_pslverr        ),
        .bcpu_wdt_s0_paddr          (bcpu_wdt_s0_paddr          ),
        .bcpu_wdt_s0_psel           (bcpu_wdt_s0_psel           ),
        .bcpu_wdt_s0_penable        (bcpu_wdt_s0_penable        ),
        .bcpu_wdt_s0_pwrite         (bcpu_wdt_s0_pwrite         ),
        .bcpu_wdt_s0_pwdata         (bcpu_wdt_s0_pwdata         ),
        .bcpu_wdt_s0_prdata         (bcpu_wdt_s0_prdata         ),
        .bcpu_wdt_s0_pready         (bcpu_wdt_s0_pready         ),
        .bcpu_wdt_s0_pslverr        (bcpu_wdt_s0_pslverr        ),
        .dma_s0_paddr               (dma_s0_paddr               ),
        .dma_s0_psel                (dma_s0_psel                ),
        .dma_s0_penable             (dma_s0_penable             ),
        .dma_s0_pwrite              (dma_s0_pwrite              ),
        .dma_s0_pwdata              (dma_s0_pwdata              ),
        .dma_s0_prdata              (dma_s0_prdata              ),
        .dma_s0_pready              (dma_s0_pready              ),
        .dma_s0_pslverr             (dma_s0_pslverr             ),
        .fcb_s0_paddr               (fcb_s0_paddr               ),
        .fcb_s0_psel                (fcb_s0_psel                ),
        .fcb_s0_penable             (fcb_s0_penable             ),
        .fcb_s0_pwrite              (fcb_s0_pwrite              ),
        .fcb_s0_pwdata              (fcb_s0_pwdata              ),
        .fcb_s0_pstrb               (fcb_s0_pstrb               ),
        .fcb_s0_prdata              (fcb_s0_prdata              ),
        .fcb_s0_pready              (fcb_s0_pready              ),
        .fcb_s0_pslverr             (fcb_s0_pslverr             ),
        .gpio_s0_paddr              (gpio_s0_paddr              ),
        .gpio_s0_psel               (gpio_s0_psel               ),
        .gpio_s0_penable            (gpio_s0_penable            ),
        .gpio_s0_pwrite             (gpio_s0_pwrite             ),
        .gpio_s0_pwdata             (gpio_s0_pwdata             ),
        .gpio_s0_prdata             (gpio_s0_prdata             ),
        .gpio_s0_pready             (gpio_s0_pready             ),
        .gpio_s0_pslverr            (gpio_s0_pslverr            ),
        .gpt_s0_paddr               (gpt_s0_paddr               ),
        .gpt_s0_psel                (gpt_s0_psel                ),
        .gpt_s0_penable             (gpt_s0_penable             ),
        .gpt_s0_pwrite              (gpt_s0_pwrite              ),
        .gpt_s0_pwdata              (gpt_s0_pwdata              ),
        .gpt_s0_prdata              (gpt_s0_prdata              ),
        .gpt_s0_pready              (gpt_s0_pready              ),
        .gpt_s0_pslverr             (gpt_s0_pslverr             ),
        .i2c_s0_paddr               (i2c_s0_paddr               ),
        .i2c_s0_psel                (i2c_s0_psel                ),
        .i2c_s0_penable             (i2c_s0_penable             ),
        .i2c_s0_pwrite              (i2c_s0_pwrite              ),
        .i2c_s0_pwdata              (i2c_s0_pwdata              ),
        .i2c_s0_prdata              (i2c_s0_prdata              ),
        .i2c_s0_pready              (i2c_s0_pready              ),
        .i2c_s0_pslverr             (i2c_s0_pslverr             ),
        .mbox_s0_paddr              (mbox_s0_paddr              ),
        .mbox_s0_psel               (mbox_s0_psel               ),
        .mbox_s0_penable            (mbox_s0_penable            ),
        .mbox_s0_pwrite             (mbox_s0_pwrite             ),
        .mbox_s0_pwdata             (mbox_s0_pwdata             ),
        .mbox_s0_pstrb              (mbox_s0_pstrb              ),
        .mbox_s0_prdata             (mbox_s0_prdata             ),
        .mbox_s0_pready             (mbox_s0_pready             ),
        .mbox_s0_pslverr            (mbox_s0_pslverr            ),
        .scu_s0_paddr               (scu_s0_paddr               ),
        .scu_s0_psel                (scu_s0_psel                ),
        .scu_s0_penable             (scu_s0_penable             ),
        .scu_s0_pwrite              (scu_s0_pwrite              ),
        .scu_s0_pwdata              (scu_s0_pwdata              ),
        .scu_s0_pstrb               (scu_s0_pstrb               ),
        .scu_s0_prdata              (scu_s0_prdata              ),
        .scu_s0_pready              (scu_s0_pready              ),
        .scu_s0_pslverr             (scu_s0_pslverr             ),
        .spi_reg_s0_haddr           (spi_reg_s0_haddr           ),
        .spi_reg_s0_hrdata          (spi_reg_s0_hrdata          ),
        .spi_reg_s0_hready          (spi_reg_s0_hready          ),
        .spi_reg_s0_hresp           (spi_reg_s0_hresp           ),
        .spi_reg_s0_hsel            (spi_reg_s0_hsel            ),
        .spi_reg_s0_htrans          (spi_reg_s0_htrans          ),
        .spi_reg_s0_hwdata          (spi_reg_s0_hwdata          ),
        .spi_reg_s0_hwrite          (spi_reg_s0_hwrite          ),
        .spi_mem_s0_haddr           (spi_mem_s0_haddr           ),
        .spi_mem_s0_hrdata          (spi_mem_s0_hrdata          ),
        .spi_mem_s0_hready          (spi_mem_s0_hready          ),
        .spi_mem_s0_hresp           (spi_mem_s0_hresp           ),
        .spi_mem_s0_hsel            (spi_mem_s0_hsel            ),
        .spi_mem_s0_htrans          (spi_mem_s0_htrans          ),
        .spi_mem_s0_hwrite          (spi_mem_s0_hwrite          ),
        .uart_s0_paddr              (uart_s0_paddr              ),
        .uart_s0_psel               (uart_s0_psel               ),
        .uart_s0_penable            (uart_s0_penable            ),
        .uart_s0_pwrite             (uart_s0_pwrite             ),
        .uart_s0_pwdata             (uart_s0_pwdata             ),
        .uart_s0_prdata             (uart_s0_prdata             ),
        .uart_s0_pready             (uart_s0_pready             ),
        .uart_s0_pslverr            (uart_s0_pslverr            ),
        .uart_s1_paddr              (uart_s1_paddr              ),
        .uart_s1_psel               (uart_s1_psel               ),
        .uart_s1_penable            (uart_s1_penable            ),
        .uart_s1_pwrite             (uart_s1_pwrite             ),
        .uart_s1_pwdata             (uart_s1_pwdata             ),
        .uart_s1_prdata             (uart_s1_prdata             ),
        .uart_s1_pready             (uart_s1_pready             ),
        .uart_s1_pslverr            (uart_s1_pslverr            ),
        .usb_s0_araddr              (usb_s0_araddr              ),
        .usb_s0_arprot              (usb_s0_arprot              ),
        .usb_s0_arready             (usb_s0_arready             ),
        .usb_s0_arvalid             (usb_s0_arvalid             ),
        .usb_s0_awaddr              (usb_s0_awaddr              ),
        .usb_s0_awprot              (usb_s0_awprot              ),
        .usb_s0_awready             (usb_s0_awready             ),
        .usb_s0_awvalid             (usb_s0_awvalid             ),
        .usb_s0_bready              (usb_s0_bready              ),
        .usb_s0_bresp               (usb_s0_bresp               ),
        .usb_s0_bvalid              (usb_s0_bvalid              ),
        .usb_s0_rdata               (usb_s0_rdata               ),
        .usb_s0_rready              (usb_s0_rready              ),
        .usb_s0_rresp               (usb_s0_rresp               ),
        .usb_s0_rvalid              (usb_s0_rvalid              ),
        .usb_s0_wdata               (usb_s0_wdata               ),
        .usb_s0_wready              (usb_s0_wready              ),
        .usb_s0_wstrb               (usb_s0_wstrb               ),
        .usb_s0_wvalid              (usb_s0_wvalid              ),
        .bcpu_m0_hrdata             (bcpu_m0_hrdata             ),
        .bcpu_m0_hready             (bcpu_m0_hready             ),
        .bcpu_m0_hresp              ({1'b0,bcpu_m0_hresp[0]}    ),
        .bcpu_m0_haddr              (bcpu_m0_haddr              ),
        .bcpu_m0_hsel               (bcpu_m0_hsel               ),
        .bcpu_m0_hburst             (bcpu_m0_hburst             ),
        .bcpu_m0_hprot              (bcpu_m0_hprot              ),
        .bcpu_m0_hsize              (bcpu_m0_hsize              ),
        .bcpu_m0_htrans             (bcpu_m0_htrans             ),
        .bcpu_m0_hwdata             (bcpu_m0_hwdata             ),
        .bcpu_m0_hwrite             (bcpu_m0_hwrite             ),
        .dma_m0_araddr              (dma_m0_araddr              ),
        .dma_m0_arburst             (dma_m0_arburst             ),
        .dma_m0_arcache             (dma_m0_arcache             ),
        .dma_m0_arid                (dma_m0_arid                ),
        .dma_m0_arlen               (dma_m0_arlen               ),
        .dma_m0_arlock              (dma_m0_arlock              ),
        .dma_m0_arprot              (dma_m0_arprot              ),
        .dma_m0_arready             (dma_m0_arready             ),
        .dma_m0_arsize              (dma_m0_arsize              ),
        .dma_m0_arvalid             (dma_m0_arvalid             ),
        .dma_m0_awaddr              (dma_m0_awaddr              ),
        .dma_m0_awburst             (dma_m0_awburst             ),
        .dma_m0_awcache             (dma_m0_awcache             ),
        .dma_m0_awid                (dma_m0_awid                ),
        .dma_m0_awlen               (dma_m0_awlen               ),
        .dma_m0_awlock              (dma_m0_awlock              ),
        .dma_m0_awprot              (dma_m0_awprot              ),
        .dma_m0_awready             (dma_m0_awready             ),
        .dma_m0_awsize              (dma_m0_awsize              ),
        .dma_m0_awvalid             (dma_m0_awvalid             ),
        .dma_m0_bid                 (dma_m0_bid[2:0]            ),
        .dma_m0_bready              (dma_m0_bready              ),
        .dma_m0_bresp               (dma_m0_bresp               ),
        .dma_m0_bvalid              (dma_m0_bvalid              ),
        .dma_m0_rdata               (dma_m0_rdata               ),
        .dma_m0_rid                 (dma_m0_rid[2:0]            ),
        .dma_m0_rlast               (dma_m0_rlast               ),
        .dma_m0_rready              (dma_m0_rready              ),
        .dma_m0_rresp               (dma_m0_rresp               ),
        .dma_m0_rvalid              (dma_m0_rvalid              ),
        .dma_m0_wdata               (dma_m0_wdata               ),
        .dma_m0_wlast               (dma_m0_wlast               ),
        .dma_m0_wready              (dma_m0_wready              ),
        .dma_m0_wstrb               (dma_m0_wstrb               ),
        .dma_m0_wvalid              (dma_m0_wvalid              ),
        .dma_m1_araddr              (dma_m1_araddr              ),
        .dma_m1_arburst             (dma_m1_arburst             ),
        .dma_m1_arcache             (dma_m1_arcache             ),
        .dma_m1_arid                (dma_m1_arid                ),
        .dma_m1_arlen               (dma_m1_arlen               ),
        .dma_m1_arlock              (dma_m1_arlock              ),
        .dma_m1_arprot              (dma_m1_arprot              ),
        .dma_m1_arready             (dma_m1_arready             ),
        .dma_m1_arsize              (dma_m1_arsize              ),
        .dma_m1_arvalid             (dma_m1_arvalid             ),
        .dma_m1_awaddr              (dma_m1_awaddr              ),
        .dma_m1_awburst             (dma_m1_awburst             ),
        .dma_m1_awcache             (dma_m1_awcache             ),
        .dma_m1_awid                (dma_m1_awid                ),
        .dma_m1_awlen               (dma_m1_awlen               ),
        .dma_m1_awlock              (dma_m1_awlock              ),
        .dma_m1_awprot              (dma_m1_awprot              ),
        .dma_m1_awready             (dma_m1_awready             ),
        .dma_m1_awsize              (dma_m1_awsize              ),
        .dma_m1_awvalid             (dma_m1_awvalid             ),
        .dma_m1_bid                 (dma_m1_bid[2:0]            ),
        .dma_m1_bready              (dma_m1_bready              ),
        .dma_m1_bresp               (dma_m1_bresp               ),
        .dma_m1_bvalid              (dma_m1_bvalid              ),
        .dma_m1_rdata               (dma_m1_rdata               ),
        .dma_m1_rid                 (dma_m1_rid[2:0]            ),
        .dma_m1_rlast               (dma_m1_rlast               ),
        .dma_m1_rready              (dma_m1_rready              ),
        .dma_m1_rresp               (dma_m1_rresp               ),
        .dma_m1_rvalid              (dma_m1_rvalid              ),
        .dma_m1_wdata               (dma_m1_wdata               ),
        .dma_m1_wlast               (dma_m1_wlast               ),
        .dma_m1_wready              (dma_m1_wready              ),
        .dma_m1_wstrb               (dma_m1_wstrb               ),
        .dma_m1_wvalid              (dma_m1_wvalid              ),
        .gbe_s0_paddr               (gbe_s0_paddr               ),
        .gbe_s0_psel                (gbe_s0_psel                ),
        .gbe_s0_penable             (gbe_s0_penable             ),
        .gbe_s0_pwrite              (gbe_s0_pwrite              ),
        .gbe_s0_pwdata              (gbe_s0_pwdata              ),
        .gbe_s0_pstrb               (gbe_s0_pstrb               ),
        .gbe_s0_prdata              (gbe_s0_prdata              ),
        .gbe_s0_pready              (gbe_s0_pready              ),
        .gbe_s0_pslverr             (gbe_s0_pslverr             ),
        .gbe_m0_araddr              (gbe_m0_araddr              ),
        .gbe_m0_arburst             (gbe_m0_arburst             ),
        .gbe_m0_arcache             (gbe_m0_arcache             ),
        .gbe_m0_arid                (gbe_m0_arid                ),
        .gbe_m0_arlen               (gbe_m0_arlen               ),
        .gbe_m0_arlock              (gbe_m0_arlock              ),
        .gbe_m0_arprot              (gbe_m0_arprot              ),
        .gbe_m0_arready             (gbe_m0_arready             ),
        .gbe_m0_arsize              (gbe_m0_arsize              ),
        .gbe_m0_arvalid             (gbe_m0_arvalid             ),
        .gbe_m0_awaddr              (gbe_m0_awaddr              ),
        .gbe_m0_awburst             (gbe_m0_awburst             ),
        .gbe_m0_awcache             (gbe_m0_awcache             ),
        .gbe_m0_awid                (gbe_m0_awid                ),
        .gbe_m0_awlen               (gbe_m0_awlen               ),
        .gbe_m0_awlock              (gbe_m0_awlock              ),
        .gbe_m0_awprot              (gbe_m0_awprot              ),
        .gbe_m0_awready             (gbe_m0_awready             ),
        .gbe_m0_awsize              (gbe_m0_awsize              ),
        .gbe_m0_awvalid             (gbe_m0_awvalid             ),
        .gbe_m0_bid                 (gbe_m0_bid[2:0]            ),
        .gbe_m0_bready              (gbe_m0_bready              ),
        .gbe_m0_bresp               (gbe_m0_bresp               ),
        .gbe_m0_bvalid              (gbe_m0_bvalid              ),
        .gbe_m0_rdata               (gbe_m0_rdata               ),
        .gbe_m0_rid                 (gbe_m0_rid[2:0]            ),
        .gbe_m0_rlast               (gbe_m0_rlast               ),
        .gbe_m0_rready              (gbe_m0_rready              ),
        .gbe_m0_rresp               (gbe_m0_rresp               ),
        .gbe_m0_rvalid              (gbe_m0_rvalid              ),
        .gbe_m0_wdata               (gbe_m0_wdata               ),
        .gbe_m0_wlast               (gbe_m0_wlast               ),
        .gbe_m0_wready              (gbe_m0_wready              ),
        .gbe_m0_wstrb               (gbe_m0_wstrb               ),
        .gbe_m0_wvalid              (gbe_m0_wvalid              ),
        .usb_m0_araddr              (usb_m0_araddr              ),
        .usb_m0_arburst             (usb_m0_arburst             ),
        .usb_m0_arcache             (usb_m0_arcache             ),
        .usb_m0_arid                (usb_m0_arid                ),
        .usb_m0_arlen               (usb_m0_arlen               ),
        .usb_m0_arlock              (usb_m0_arlock              ),
        .usb_m0_arprot              (usb_m0_arprot              ),
        .usb_m0_arready             (usb_m0_arready             ),
        .usb_m0_arsize              (usb_m0_arsize              ),
        .usb_m0_arvalid             (usb_m0_arvalid             ),
        .usb_m0_awaddr              (usb_m0_awaddr              ),
        .usb_m0_awburst             (usb_m0_awburst             ),
        .usb_m0_awcache             (usb_m0_awcache             ),
        .usb_m0_awid                (usb_m0_awid                ),
        .usb_m0_awlen               (usb_m0_awlen               ),
        .usb_m0_awlock              (usb_m0_awlock              ),
        .usb_m0_awprot              (usb_m0_awprot              ),
        .usb_m0_awready             (usb_m0_awready             ),
        .usb_m0_awsize              (usb_m0_awsize              ),
        .usb_m0_awvalid             (usb_m0_awvalid             ),
        .usb_m0_bid                 (usb_m0_bid[2:0]            ),
        .usb_m0_bready              (usb_m0_bready              ),
        .usb_m0_bresp               (usb_m0_bresp               ),
        .usb_m0_bvalid              (usb_m0_bvalid              ),
        .usb_m0_rdata               (usb_m0_rdata               ),
        .usb_m0_rid                 (usb_m0_rid[2:0]            ),
        .usb_m0_rlast               (usb_m0_rlast               ),
        .usb_m0_rready              (usb_m0_rready              ),
        .usb_m0_rresp               (usb_m0_rresp               ),
        .usb_m0_rvalid              (usb_m0_rvalid              ),
        .usb_m0_wdata               (usb_m0_wdata               ),
        .usb_m0_wlast               (usb_m0_wlast               ),
        .usb_m0_wready              (usb_m0_wready              ),
        .usb_m0_wstrb               (usb_m0_wstrb               ),
        .usb_m0_wvalid              (usb_m0_wvalid              ),
        .soc_pll_ctl_dacen          (soc_pll_ctl_dacen          ),
        .soc_pll_ctl_dskewcalbyp    (soc_pll_ctl_dskewcalbyp    ),
        .soc_pll_ctl_dskewcalcnt    (soc_pll_ctl_dskewcalcnt    ),
        .soc_pll_ctl_dskewcalen     (soc_pll_ctl_dskewcalen     ),
        .soc_pll_ctl_dskewcalin     (soc_pll_ctl_dskewcalin     ),
        .soc_pll_ctl_dskewfastcal   (soc_pll_ctl_dskewfastcal   ),
        .soc_pll_ctl_dsmen          (soc_pll_ctl_dsmen          ),
        .soc_pll_ctl_pllen          (soc_pll_ctl_pllen          ),
        .soc_pll_ctl_fouten         (soc_pll_ctl_fouten         ),
        .soc_pll_ctl_foutvcobyp     (soc_pll_ctl_foutvcobyp     ),
        .soc_pll_ctl_foutvcoen      (soc_pll_ctl_foutvcoen      ),
        .soc_pll_ctl_refdiv         (soc_pll_ctl_refdiv         ),
        .soc_pll_ctl_frac           (soc_pll_ctl_frac           ),
        .soc_pll_ctl_postdiv0       (soc_pll_ctl_postdiv0       ),
        .soc_pll_ctl_postdiv1       (soc_pll_ctl_postdiv1       ),
        .soc_pll_ctl_postdiv2       (soc_pll_ctl_postdiv2       ),
        .soc_pll_ctl_postdiv3       (soc_pll_ctl_postdiv3       ),
        .soc_pll_ctl_fbdiv          (soc_pll_ctl_fbdiv          ),
        .soc_pll_status_dskewcalout (soc_pll_status_dskewcalout ),
        .soc_pll_status_dskewcallock(soc_pll_status_dskewcallock),
        .soc_pll_status_lock        (soc_pll_status_lock        ),
        .jtag_control               (jtag_control               ),
        .fpga_irq_src               (fpga_irq_src               ),
        .ddr_irq_src                (ddr_irq_src                ),
        .acpu_irq_set               (acpu_irq_set               ),
        .fpga_irq_set               (fpga_irq_set               ),
        .ace_isolation_ctl          (ace_isolation_ctl          ),
        .irq_isolation_ctl          (irq_isolation_ctl          ),
        .fcb_isolation_ctl          (fcb_isolation_ctl          ),
        .ahb_isolation_ctl          (ahb_isolation_ctl          ),
        .axi1_isolation_ctl         (axi1_isolation_ctl         ),
        .axi0_isolation_ctl         (axi0_isolation_ctl         ),
        .scl_o                      (scl_o                      ),
        .spi_clk_oe                 (spi_clk_oe                 ),
        .spi_clk_out                (spi_clk_out                ),
        .gpio_pulldown              (gpio_pulldown              ),
        .gpio_pullup                (gpio_pullup                ),
        .pit_pause                  (pit_pause                  ),
        .dma_req_fpga               (dma_req_fpga               ),
        .dma_ack_fpga               (dma_ack_fpga               ),
        .mdio_mdc                   (mdio_mdc                   ),
        .usb_dp                     (usb_dp                     ),
        .usb_dn                     (usb_dn                     ),
        .usb_xtal_in                (usb_xtal_in                ),
        .usb_xtal_out               (usb_xtal_out               ),
        .pl_data_o                  (pl_data_o                  ),
        .pl_addr_o                  (pl_addr_o                  ),
        .pl_ena_o                   (pl_ena_o                   ),
        .pl_clk_o                   (pl_clk_o                   ),
        .pl_ren_o                   (pl_ren_o                   ),
        .pl_init_o                  (pl_init_o                  ),
        .pl_wen_o                   (pl_wen_o                   ),
        .pl_data_i                  (pl_data_i                  ),
        .cfg_blsr_region_0_o        (cfg_blsr_region_0_o        ),
        .cfg_wlsr_region_0_o        (cfg_wlsr_region_0_o        ),
        .cfg_done_o                 (cfg_done_o                 ),
        .cfg_rst_no                 (cfg_rst_no                 ),
        .cfg_blsr_region_0_clk_o    (cfg_blsr_region_0_clk_o    ),
        .cfg_wlsr_region_0_clk_o    (cfg_wlsr_region_0_clk_o    ),
        .cfg_blsr_region_0_wen_o    (cfg_blsr_region_0_wen_o    ),
        .cfg_blsr_region_0_ren_o    (cfg_blsr_region_0_ren_o    ),
        .cfg_wlsr_region_0_wen_o    (cfg_wlsr_region_0_wen_o    ),
        .cfg_wlsr_region_0_ren_o    (cfg_wlsr_region_0_ren_o    ),
        .cfg_blsr_region_0_i        (cfg_blsr_region_0_i        ),
        .cfg_wlsr_region_0_i        (cfg_wlsr_region_0_i        ),
        .pad_c                      (pad_c                      ),
        .pad_st                     (pad_st                     ),
        .pad_pu                     (pad_pu                     ),
        .pad_pd                     (pad_pd                     ),
        .pad_i                      (pad_i                      ),
        .pad_ie                     (pad_ie                     ),
        .pad_oen                    (pad_oen                    ),
        .pad_ds0                    (pad_ds0                    ),
        .pad_ds1                    (pad_ds1                    ),
        .pad_ds2                    (pad_ds2                    ),
        .bcpu_jtag_tck              (bcpu_jtag_tck              ),
        .bcpu_jtag_tdi              (bcpu_jtag_tdi              ),
        .bcpu_jtag_tdo              (bcpu_jtag_tdo              ),
        .bcpu_jtag_tms              (bcpu_jtag_tms              ),
	.RST_N 			    (RST_N),
	.XIN (XIN),
	.REF_CLK_1 (REF_CLK_1),
	.REF_CLK_2 (REF_CLK_2),
	.REF_CLK_3 (REF_CLK_3),
	.REF_CLK_4 (REF_CLK_4),
	.TESTMODE (TESTMODE),
	.BOOTM0 (BOOTM0),
	.BOOTM1 (BOOTM1),
	.BOOTM2 (BOOTM2),
	.CLKSEL_0 (CLKSEL_0),
	.CLKSEL_1 (CLKSEL_1),
	.JTAG_TDI (JTAG_TDI),
	.JTAG_TDO (JTAG_TDO),
	.JTAG_TMS (JTAG_TMS),
	.JTAG_TCK (JTAG_TCK),
	.JTAG_TRSTN (JTAG_TRSTN),
	.GPIO_B_0 (GPIO_B_0),
	.GPIO_B_1 (GPIO_B_1),
	.GPIO_B_2 (GPIO_B_2),
	.GPIO_B_3 (GPIO_B_3),
	.GPIO_B_4 (GPIO_B_4),
	.GPIO_B_5 (GPIO_B_5),
	.GPIO_B_6 (GPIO_B_6),
	.GPIO_B_7 (GPIO_B_7),
	.GPIO_B_8 (GPIO_B_8),
	.GPIO_B_9 (GPIO_B_9),
	.GPIO_B_10 (GPIO_B_10),
	.GPIO_B_11 (GPIO_B_11),
	.GPIO_B_12 (GPIO_B_12),
	.GPIO_B_13 (GPIO_B_13),
	.GPIO_B_14 (GPIO_B_14),
	.GPIO_B_15 (GPIO_B_15),
	.GPIO_C_0 (GPIO_C_0),
	.GPIO_C_1 (GPIO_C_1),
	.GPIO_C_2 (GPIO_C_2),
	.GPIO_C_3 (GPIO_C_3),
	.GPIO_C_4 (GPIO_C_4),
	.GPIO_C_5 (GPIO_C_5),
	.GPIO_C_6 (GPIO_C_6),
	.GPIO_C_7 (GPIO_C_7),
	.GPIO_C_8 (GPIO_C_8),
	.GPIO_C_9 (GPIO_C_9),
	.GPIO_C_10 (GPIO_C_10),
	.GPIO_C_11 (GPIO_C_11),
	.GPIO_C_12 (GPIO_C_12),
	.GPIO_C_13 (GPIO_C_13),
	.GPIO_C_14 (GPIO_C_14),
	.GPIO_C_15 (GPIO_C_15),
	.I2C_SCL (I2C_SCL),
	.SPI_SCLK (SPI_SCLK),
	.GPT_RTC (GPT_RTC),
	.MDIO_MDC (MDIO_MDC),
	.MDIO_DATA (MDIO_DATA),
	.RGMII_TXD0 (RGMII_TXD0),
	.RGMII_TXD1 (RGMII_TXD1),
	.RGMII_TXD2 (RGMII_TXD2),
	.RGMII_TXD3 (RGMII_TXD3),
	.RGMII_TX_CTL (RGMII_TX_CTL),
	.RGMII_TXC (RGMII_TXC),
	.RGMII_RXD0 (RGMII_RXD0),
	.RGMII_RXD1 (RGMII_RXD1),
	.RGMII_RXD2 (RGMII_RXD2),
	.RGMII_RXD3 (RGMII_RXD3),
	.RGMII_RX_CTL (RGMII_RX_CTL),
	.RGMII_RXC (RGMII_RXC),
        .testmode                   (testmode	                )
    );

    assign sramb3_wid = 'h0;
    assign sramb2_wid = 'h0;
    assign sramb1_wid = 'h0;
    assign sramb0_wid = 'h0;
    assign ddr3_arqos = 'h0;
    assign ddr3_awqos = 'h0;
    assign ddr2_arqos = 'h0;
    assign ddr2_awqos = 'h0;
    assign ddr1_arqos = 'h0;
    assign ddr1_awqos = 'h0;
    assign ddr0_arqos = 'h0;
    assign ddr0_awqos = 'h0;

    memss #(
        .ADDR_WIDTH (ADDR_WIDTH ),
        .SRAM_DWIDTH(SRAM_DWIDTH),
        .DDR_DWIDTH (DDR_DWIDTH ),
        .SRAM_SWIDTH(SRAM_SWIDTH),
        .DDR_SWIDTH (DDR_SWIDTH )
    ) memory_ss (
        .ddr_sys_clk    (clk_ddr_ctl          ),
        .ddr_phy_clk    (clk_ddr_phy          ),
        .ddr_sys_resetn (rst_n_ddr            ),
        .sram_sys_clk   (clk_acpu             ),
        .sram_sys_resetn(rst_n_sram           ),
        .ddr0_aclk      (clk_acpu             ),
        .ddr1_aclk      (clk_acpu             ),
        .ddr2_aclk      (clk_acpu             ),
        .ddr3_aclk      (clk_acpu             ),
        .sramb0_aclk    (clk_acpu             ),
        .sramb1_aclk    (clk_acpu             ),
        .sramb2_aclk    (clk_acpu             ),
        .sramb3_aclk    (clk_acpu             ),
        .cntl_aclk      (clk_ddr_cfg          ),
        .ddr0_aresetn   (rst_n_acpu_bus       ),
        .ddr1_aresetn   (rst_n_acpu_bus       ),
        .ddr2_aresetn   (rst_n_acpu_bus       ),
        .ddr3_aresetn   (rst_n_acpu_bus       ),
        .sramb0_aresetn (rst_n_acpu_bus       ),
        .sramb1_aresetn (rst_n_acpu_bus       ),
        .sramb2_aresetn (rst_n_acpu_bus       ),
        .sramb3_aresetn (rst_n_acpu_bus       ),
        .cntl_aresetn   (rst_n_133            ),
        .ddr0_awvalid   (ddr0_awvalid         ),
        .ddr0_awready   (ddr0_awready         ),
        .ddr0_awaddr    (ddr0_awaddr          ),
        .ddr0_awsize    (ddr0_awsize          ),
        .ddr0_awburst   (ddr0_awburst         ),
        .ddr0_awcache   (ddr0_awcache         ),
        .ddr0_awprot    (ddr0_awprot          ),
        .ddr0_awlock    (ddr0_awlock          ),
        .ddr0_awqos     (ddr0_awqos           ), //not connected
        .ddr0_awid      (ddr0_awid            ),
        .ddr0_awlen     ({1'b0,ddr0_awlen[2:0]}),
        .ddr0_wvalid    (ddr0_wvalid          ),
        .ddr0_wready    (ddr0_wready          ),
        .ddr0_wlast     (ddr0_wlast           ),
        .ddr0_wdata     (ddr0_wdata           ),
        .ddr0_wstrb     (ddr0_wstrb           ),
        .ddr0_bvalid    (ddr0_bvalid          ),
        .ddr0_bready    (ddr0_bready          ),
        .ddr0_bresp     (ddr0_bresp           ),
        .ddr0_bid       (ddr0_bid             ),
        .ddr0_arvalid   (ddr0_arvalid         ),
        .ddr0_arready   (ddr0_arready         ),
        .ddr0_araddr    (ddr0_araddr          ),
        .ddr0_arsize    (ddr0_arsize          ),
        .ddr0_arburst   (ddr0_arburst         ),
        .ddr0_arcache   (ddr0_arcache         ),
        .ddr0_arprot    (ddr0_arprot          ),
        .ddr0_arlock    (ddr0_arlock          ),
        .ddr0_arqos     (ddr0_arqos           ), //not connected
        .ddr0_arid      (ddr0_arid            ),
        .ddr0_arlen     ({1'b0,ddr0_arlen[2:0]}),
        .ddr0_rvalid    (ddr0_rvalid          ),
        .ddr0_rready    (ddr0_rready          ),
        .ddr0_rlast     (ddr0_rlast           ),
        .ddr0_rdata     (ddr0_rdata           ),
        .ddr0_rresp     (ddr0_rresp           ),
        .ddr0_rid       (ddr0_rid             ),
        .ddr1_awvalid   (ddr1_awvalid         ),
        .ddr1_awready   (ddr1_awready         ),
        .ddr1_awaddr    (ddr1_awaddr          ),
        .ddr1_awsize    (ddr1_awsize          ),
        .ddr1_awburst   (ddr1_awburst         ),
        .ddr1_awcache   (ddr1_awcache         ),
        .ddr1_awprot    (ddr1_awprot          ),
        .ddr1_awlock    (ddr1_awlock          ),
        .ddr1_awqos     (ddr1_awqos           ), //not connected
        .ddr1_awid      (ddr1_awid            ),
        .ddr1_awlen     ({1'b0,ddr1_awlen[2:0]}),
        .ddr1_wvalid    (ddr1_wvalid          ),
        .ddr1_wready    (ddr1_wready          ),
        .ddr1_wlast     (ddr1_wlast           ),
        .ddr1_wdata     (ddr1_wdata           ),
        .ddr1_wstrb     (ddr1_wstrb           ),
        .ddr1_bvalid    (ddr1_bvalid          ),
        .ddr1_bready    (ddr1_bready          ),
        .ddr1_bresp     (ddr1_bresp           ),
        .ddr1_bid       (ddr1_bid             ),
        .ddr1_arvalid   (ddr1_arvalid         ),
        .ddr1_arready   (ddr1_arready         ),
        .ddr1_araddr    (ddr1_araddr          ),
        .ddr1_arsize    (ddr1_arsize          ),
        .ddr1_arburst   (ddr1_arburst         ),
        .ddr1_arcache   (ddr1_arcache         ),
        .ddr1_arprot    (ddr1_arprot          ),
        .ddr1_arlock    (ddr1_arlock          ),
        .ddr1_arqos     (ddr1_arqos           ), //not connected
        .ddr1_arid      (ddr1_arid            ),
        .ddr1_arlen     ({1'b0,ddr1_arlen[2:0]}),
        .ddr1_rvalid    (ddr1_rvalid          ),
        .ddr1_rready    (ddr1_rready          ),
        .ddr1_rlast     (ddr1_rlast           ),
        .ddr1_rdata     (ddr1_rdata           ),
        .ddr1_rresp     (ddr1_rresp           ),
        .ddr1_rid       (ddr1_rid             ),
        .ddr2_awvalid   (ddr2_awvalid         ),
        .ddr2_awready   (ddr2_awready         ),
        .ddr2_awaddr    (ddr2_awaddr          ),
        .ddr2_awsize    (ddr2_awsize          ),
        .ddr2_awburst   (ddr2_awburst         ),
        .ddr2_awcache   (ddr2_awcache         ),
        .ddr2_awprot    (ddr2_awprot          ),
        .ddr2_awlock    (ddr2_awlock          ),
        .ddr2_awqos     (ddr2_awqos           ), //not connected
        .ddr2_awid      (ddr2_awid            ),
        .ddr2_awlen     ({1'b0,ddr2_awlen[2:0]}),
        .ddr2_wvalid    (ddr2_wvalid          ),
        .ddr2_wready    (ddr2_wready          ),
        .ddr2_wlast     (ddr2_wlast           ),
        .ddr2_wdata     (ddr2_wdata           ),
        .ddr2_wstrb     (ddr2_wstrb           ),
        .ddr2_bvalid    (ddr2_bvalid          ),
        .ddr2_bready    (ddr2_bready          ),
        .ddr2_bresp     (ddr2_bresp           ),
        .ddr2_bid       (ddr2_bid             ),
        .ddr2_arvalid   (ddr2_arvalid         ),
        .ddr2_arready   (ddr2_arready         ),
        .ddr2_araddr    (ddr2_araddr          ),
        .ddr2_arsize    (ddr2_arsize          ),
        .ddr2_arburst   (ddr2_arburst         ),
        .ddr2_arcache   (ddr2_arcache         ),
        .ddr2_arprot    (ddr2_arprot          ),
        .ddr2_arlock    (ddr2_arlock          ),
        .ddr2_arqos     (ddr2_arqos           ), //not connected
        .ddr2_arid      (ddr2_arid            ),
        .ddr2_arlen     ({1'b0,ddr2_arlen[2:0]}),
        .ddr2_rvalid    (ddr2_rvalid          ),
        .ddr2_rready    (ddr2_rready          ),
        .ddr2_rlast     (ddr2_rlast           ),
        .ddr2_rdata     (ddr2_rdata           ),
        .ddr2_rresp     (ddr2_rresp           ),
        .ddr2_rid       (ddr2_rid             ),
        .ddr3_awvalid   (ddr3_awvalid         ),
        .ddr3_awready   (ddr3_awready         ),
        .ddr3_awaddr    (ddr3_awaddr          ),
        .ddr3_awsize    (ddr3_awsize          ),
        .ddr3_awburst   (ddr3_awburst         ),
        .ddr3_awcache   (ddr3_awcache         ),
        .ddr3_awprot    (ddr3_awprot          ),
        .ddr3_awlock    (ddr3_awlock          ),
        .ddr3_awqos     (ddr3_awqos           ), //not connected
        .ddr3_awid      (ddr3_awid            ),
        .ddr3_awlen     ({1'b0,ddr3_awlen[2:0]}),
        .ddr3_wvalid    (ddr3_wvalid          ),
        .ddr3_wready    (ddr3_wready          ),
        .ddr3_wlast     (ddr3_wlast           ),
        .ddr3_wdata     (ddr3_wdata           ),
        .ddr3_wstrb     (ddr3_wstrb           ),
        .ddr3_bvalid    (ddr3_bvalid          ),
        .ddr3_bready    (ddr3_bready          ),
        .ddr3_bresp     (ddr3_bresp           ),
        .ddr3_bid       (ddr3_bid             ),
        .ddr3_arvalid   (ddr3_arvalid         ),
        .ddr3_arready   (ddr3_arready         ),
        .ddr3_araddr    (ddr3_araddr          ),
        .ddr3_arsize    (ddr3_arsize          ),
        .ddr3_arburst   (ddr3_arburst         ),
        .ddr3_arcache   (ddr3_arcache         ),
        .ddr3_arprot    (ddr3_arprot          ),
        .ddr3_arlock    (ddr3_arlock          ),
        .ddr3_arqos     (ddr3_arqos           ), //not connected
        .ddr3_arid      (ddr3_arid            ),
        .ddr3_arlen     ({1'b0,ddr3_arlen[2:0]}),
        .ddr3_rvalid    (ddr3_rvalid          ),
        .ddr3_rready    (ddr3_rready          ),
        .ddr3_rlast     (ddr3_rlast           ),
        .ddr3_rdata     (ddr3_rdata           ),
        .ddr3_rresp     (ddr3_rresp           ),
        .ddr3_rid       (ddr3_rid             ),
        .sramb0_awvalid (sramb0_awvalid       ),
        .sramb0_awready (sramb0_awready       ),
        .sramb0_awaddr  (sramb0_awaddr        ),
        .sramb0_awsize  (sramb0_awsize        ),
        .sramb0_awburst (sramb0_awburst       ),
        .sramb0_awid    (sramb0_awid          ),
        .sramb0_awlen   (sramb0_awlen         ),
        .sramb0_wvalid  (sramb0_wvalid        ),
        .sramb0_wready  (sramb0_wready        ),
        .sramb0_wlast   (sramb0_wlast         ),
        .sramb0_wdata   (sramb0_wdata         ),
        .sramb0_wstrb   (sramb0_wstrb         ),
        .sramb0_wid     (sramb0_wid           ),
        .sramb0_bvalid  (sramb0_bvalid        ),
        .sramb0_bready  (sramb0_bready        ),
        .sramb0_bresp   (sramb0_bresp         ),
        .sramb0_bid     (sramb0_bid           ),
        .sramb0_arvalid (sramb0_arvalid       ),
        .sramb0_arready (sramb0_arready       ),
        .sramb0_araddr  (sramb0_araddr        ),
        .sramb0_arsize  (sramb0_arsize        ),
        .sramb0_arburst (sramb0_arburst       ),
        .sramb0_arid    (sramb0_arid          ),
        .sramb0_arlen   (sramb0_arlen         ),
        .sramb0_rvalid  (sramb0_rvalid        ),
        .sramb0_rready  (sramb0_rready        ),
        .sramb0_rlast   (sramb0_rlast         ),
        .sramb0_rdata   (sramb0_rdata         ),
        .sramb0_rresp   (sramb0_rresp         ),
        .sramb0_rid     (sramb0_rid           ),
        .sramb1_awvalid (sramb1_awvalid       ),
        .sramb1_awready (sramb1_awready       ),
        .sramb1_awaddr  (sramb1_awaddr        ),
        .sramb1_awsize  (sramb1_awsize        ),
        .sramb1_awburst (sramb1_awburst       ),
        .sramb1_awid    (sramb1_awid          ),
        .sramb1_awlen   (sramb1_awlen         ),
        .sramb1_wvalid  (sramb1_wvalid        ),
        .sramb1_wready  (sramb1_wready        ),
        .sramb1_wlast   (sramb1_wlast         ),
        .sramb1_wdata   (sramb1_wdata         ),
        .sramb1_wstrb   (sramb1_wstrb         ),
        .sramb1_wid     (sramb1_wid           ),
        .sramb1_bvalid  (sramb1_bvalid        ),
        .sramb1_bready  (sramb1_bready        ),
        .sramb1_bresp   (sramb1_bresp         ),
        .sramb1_bid     (sramb1_bid           ),
        .sramb1_arvalid (sramb1_arvalid       ),
        .sramb1_arready (sramb1_arready       ),
        .sramb1_araddr  (sramb1_araddr        ),
        .sramb1_arsize  (sramb1_arsize        ),
        .sramb1_arburst (sramb1_arburst       ),
        .sramb1_arid    (sramb1_arid          ),
        .sramb1_arlen   (sramb1_arlen         ),
        .sramb1_rvalid  (sramb1_rvalid        ),
        .sramb1_rready  (sramb1_rready        ),
        .sramb1_rlast   (sramb1_rlast         ),
        .sramb1_rdata   (sramb1_rdata         ),
        .sramb1_rresp   (sramb1_rresp         ),
        .sramb1_rid     (sramb1_rid           ),
        .sramb2_awvalid (sramb2_awvalid       ),
        .sramb2_awready (sramb2_awready       ),
        .sramb2_awaddr  (sramb2_awaddr        ),
        .sramb2_awsize  (sramb2_awsize        ),
        .sramb2_awburst (sramb2_awburst       ),
        .sramb2_awid    (sramb2_awid          ),
        .sramb2_awlen   (sramb2_awlen         ),
        .sramb2_wvalid  (sramb2_wvalid        ),
        .sramb2_wready  (sramb2_wready        ),
        .sramb2_wlast   (sramb2_wlast         ),
        .sramb2_wdata   (sramb2_wdata         ),
        .sramb2_wstrb   (sramb2_wstrb         ),
        .sramb2_wid     (sramb2_wid           ),
        .sramb2_bvalid  (sramb2_bvalid        ),
        .sramb2_bready  (sramb2_bready        ),
        .sramb2_bresp   (sramb2_bresp         ),
        .sramb2_bid     (sramb2_bid           ),
        .sramb2_arvalid (sramb2_arvalid       ),
        .sramb2_arready (sramb2_arready       ),
        .sramb2_araddr  (sramb2_araddr        ),
        .sramb2_arsize  (sramb2_arsize        ),
        .sramb2_arburst (sramb2_arburst       ),
        .sramb2_arid    (sramb2_arid          ),
        .sramb2_arlen   (sramb2_arlen         ),
        .sramb2_rvalid  (sramb2_rvalid        ),
        .sramb2_rready  (sramb2_rready        ),
        .sramb2_rlast   (sramb2_rlast         ),
        .sramb2_rdata   (sramb2_rdata         ),
        .sramb2_rresp   (sramb2_rresp         ),
        .sramb2_rid     (sramb2_rid           ),
        .sramb3_awvalid (sramb3_awvalid       ),
        .sramb3_awready (sramb3_awready       ),
        .sramb3_awaddr  (sramb3_awaddr        ),
        .sramb3_awsize  (sramb3_awsize        ),
        .sramb3_awburst (sramb3_awburst       ),
        .sramb3_awid    (sramb3_awid          ),
        .sramb3_awlen   (sramb3_awlen         ),
        .sramb3_wvalid  (sramb3_wvalid        ),
        .sramb3_wready  (sramb3_wready        ),
        .sramb3_wlast   (sramb3_wlast         ),
        .sramb3_wdata   (sramb3_wdata         ),
        .sramb3_wstrb   (sramb3_wstrb         ),
        .sramb3_wid     (sramb3_wid           ),
        .sramb3_bvalid  (sramb3_bvalid        ),
        .sramb3_bready  (sramb3_bready        ),
        .sramb3_bresp   (sramb3_bresp         ),
        .sramb3_bid     (sramb3_bid           ),
        .sramb3_arvalid (sramb3_arvalid       ),
        .sramb3_arready (sramb3_arready       ),
        .sramb3_araddr  (sramb3_araddr        ),
        .sramb3_arsize  (sramb3_arsize        ),
        .sramb3_arburst (sramb3_arburst       ),
        .sramb3_arid    (sramb3_arid          ),
        .sramb3_arlen   (sramb3_arlen         ),
        .sramb3_rvalid  (sramb3_rvalid        ),
        .sramb3_rready  (sramb3_rready        ),
        .sramb3_rlast   (sramb3_rlast         ),
        .sramb3_rdata   (sramb3_rdata         ),
        .sramb3_rresp   (sramb3_rresp         ),
        .sramb3_rid     (sramb3_rid           ),
        .cntl_arready   (cntl_arready         ),
        .cntl_awready   (cntl_awready         ),
        .cntl_bresp     (cntl_bresp           ),
        .cntl_bvalid    (cntl_bvalid          ),
        .cntl_rdata     (cntl_rdata           ),
        .cntl_rresp     (cntl_rresp           ),
        .cntl_rvalid    (cntl_rvalid          ),
        .cntl_wready    (cntl_wready          ),
        .cntl_araddr    (cntl_araddr          ),
        .cntl_arvalid   (cntl_arvalid         ),
        .cntl_awaddr    (cntl_awaddr          ),
        .cntl_awvalid   (cntl_awvalid         ),
        .cntl_bready    (cntl_bready          ),
        .cntl_rready    (cntl_rready          ),
        .cntl_wdata     (cntl_wdata           ),
        .cntl_wvalid    (cntl_wvalid          ),
        .MEM_A          (mem_a                ),
        .MEM_ACT_N      (mem_act_n            ),
        .MEM_BA         (mem_ba               ),
        .MEM_BG         (mem_bg               ),
        .MEM_CKE        (mem_cke              ),
        .MEM_CLK        (mem_clk              ),
        .MEM_CLK_N      (mem_clk_n            ),
        .MEM_CS         (mem_cs               ),
        .MEM_ODT        (mem_odt              ),
        .MEM_RESET_N    (mem_reset_n          ),
        .DM             (dm                   ),
        .DQ             (dq                   ),
        .DQS            (dqs                  ),
        .DQS_N          (dqs_n                ),
        .int_gc_fsm     (ddr_irq_src          )


    );


rsnoc flexnoc (
    .ACPU_WDT_PAddr       (acpu_wdt_s0_paddr    ),
    .ACPU_WDT_PEnable     (acpu_wdt_s0_penable  ),
    .ACPU_WDT_PRData      (acpu_wdt_s0_prdata   ),
    .ACPU_WDT_PReady      (acpu_wdt_s0_pready   ),
    .ACPU_WDT_PSel        (acpu_wdt_s0_psel     ),
    .ACPU_WDT_PSlvErr     (acpu_wdt_s0_pslverr  ),
    .ACPU_WDT_PWBe        (/*not used*/         ),
    .ACPU_WDT_PWData      (acpu_wdt_s0_pwdata   ),
    .ACPU_WDT_PWrite      (acpu_wdt_s0_pwrite   ),
    .BCPU_WDT_PAddr       (bcpu_wdt_s0_paddr    ),
    .BCPU_WDT_PEnable     (bcpu_wdt_s0_penable  ),
    .BCPU_WDT_PRData      (bcpu_wdt_s0_prdata   ),
    .BCPU_WDT_PReady      (bcpu_wdt_s0_pready   ),
    .BCPU_WDT_PSel        (bcpu_wdt_s0_psel     ),
    .BCPU_WDT_PSlvErr     (bcpu_wdt_s0_pslverr  ),
    .BCPU_WDT_PWBe        (/*not used*/         ),
    .BCPU_WDT_PWData      (bcpu_wdt_s0_pwdata   ),
    .BCPU_WDT_PWrite      (bcpu_wdt_s0_pwrite   ),
    .DMA_apb_s0_paddr     (dma_s0_paddr         ),
    .DMA_apb_s0_penable   (dma_s0_penable       ),
    .DMA_apb_s0_prdata    (dma_s0_prdata        ),
    .DMA_apb_s0_pready    (dma_s0_pready        ),
    .DMA_apb_s0_psel      (dma_s0_psel          ),
    .DMA_apb_s0_pslverr   (dma_s0_pslverr       ),
    .DMA_apb_s0_pwbe      (/*not used*/         ),
    .DMA_apb_s0_pwdata    (dma_s0_pwdata        ),
    .DMA_apb_s0_pwrite    (dma_s0_pwrite        ),
    .FCB_apb_s0_paddr     (fcb_s0_paddr         ),
    .FCB_apb_s0_penable   (fcb_s0_penable       ),
    .FCB_apb_s0_prdata    (fcb_s0_prdata        ),
    .FCB_apb_s0_pready    (fcb_s0_pready        ),
    .FCB_apb_s0_psel      (fcb_s0_psel          ),
    .FCB_apb_s0_pslverr   (fcb_s0_pslverr       ),
    .FCB_apb_s0_pwbe      (fcb_s0_pstrb         ),
    .FCB_apb_s0_pwdata    (fcb_s0_pwdata        ),
    .FCB_apb_s0_pwrite    (fcb_s0_pwrite        ),
    .GPIO_apb_s0_paddr    (gpio_s0_paddr        ),
    .GPIO_apb_s0_penable  (gpio_s0_penable      ),
    .GPIO_apb_s0_prdata   (gpio_s0_prdata       ),
    .GPIO_apb_s0_pready   (gpio_s0_pready       ),
    .GPIO_apb_s0_psel     (gpio_s0_psel         ),
    .GPIO_apb_s0_pslverr  (gpio_s0_pslverr      ),
    .GPIO_apb_s0_pwbe     (/*not used*/         ),
    .GPIO_apb_s0_pwdata   (gpio_s0_pwdata       ),
    .GPIO_apb_s0_pwrite   (gpio_s0_pwrite       ),
    .GPT_apb_s0_paddr     (gpt_s0_paddr         ),
    .GPT_apb_s0_penable   (gpt_s0_penable       ),
    .GPT_apb_s0_prdata    (gpt_s0_prdata        ),
    .GPT_apb_s0_pready    (gpt_s0_pready        ),
    .GPT_apb_s0_psel      (gpt_s0_psel          ),
    .GPT_apb_s0_pslverr   (gpt_s0_pslverr       ),
    .GPT_apb_s0_pwbe      (/*not used*/         ),
    .GPT_apb_s0_pwdata    (gpt_s0_pwdata        ),
    .GPT_apb_s0_pwrite    (gpt_s0_pwrite        ),
    .I2C_apb_s0_paddr     (i2c_s0_paddr         ),
    .I2C_apb_s0_penable   (i2c_s0_penable       ),
    .I2C_apb_s0_prdata    (i2c_s0_prdata        ),
    .I2C_apb_s0_pready    (i2c_s0_pready        ),
    .I2C_apb_s0_psel      (i2c_s0_psel          ),
    .I2C_apb_s0_pslverr   (i2c_s0_pslverr       ),
    .I2C_apb_s0_pwbe      (/*not used*/         ),
    .I2C_apb_s0_pwdata    (i2c_s0_pwdata        ),
    .I2C_apb_s0_pwrite    (i2c_s0_pwrite        ),
    .MBOX_apb_s0_paddr    (mbox_s0_paddr        ),
    .MBOX_apb_s0_penable  (mbox_s0_penable      ),
    .MBOX_apb_s0_prdata   (mbox_s0_prdata       ),
    .MBOX_apb_s0_pready   (mbox_s0_pready       ),
    .MBOX_apb_s0_psel     (mbox_s0_psel         ),
    .MBOX_apb_s0_pslverr  (mbox_s0_pslverr      ),
    .MBOX_apb_s0_pwbe     (mbox_s0_pstrb        ),
    .MBOX_apb_s0_pwdata   (mbox_s0_pwdata       ),
    .MBOX_apb_s0_pwrite   (mbox_s0_pwrite       ),
    .SCU_PAddr            (scu_s0_paddr         ),
    .SCU_PEnable          (scu_s0_penable       ),
    .SCU_PRData           (scu_s0_prdata        ),
    .SCU_PReady           (scu_s0_pready        ),
    .SCU_PSel             (scu_s0_psel          ),
    .SCU_PSlvErr          (scu_s0_pslverr       ),
    .SCU_PWBe             (scu_s0_pstrb         ),
    .SCU_PWData           (scu_s0_pwdata        ),
    .SCU_PWrite           (scu_s0_pwrite        ),
    .SPI_ahb_s0_haddr     (spi_reg_s0_haddr     ),
    .SPI_ahb_s0_hburst    (/*not used*/         ),
    .SPI_ahb_s0_hmastlock (/*not used*/         ),
    .SPI_ahb_s0_hprot     (/*not used*/         ),
    .SPI_ahb_s0_hrdata    (spi_reg_s0_hrdata    ),
    .SPI_ahb_s0_hready    (spi_reg_s0_hready    ),
    .SPI_ahb_s0_hresp     (spi_reg_s0_hresp     ),
    .SPI_ahb_s0_hsel      (spi_reg_s0_hsel      ),
    .SPI_ahb_s0_hsize     (/*not used*/         ),
    .SPI_ahb_s0_htrans    (spi_reg_s0_htrans    ),
    .SPI_ahb_s0_hwbe      (/*not used*/         ),
    .SPI_ahb_s0_hwdata    (spi_reg_s0_hwdata    ),
    .SPI_ahb_s0_hwrite    (spi_reg_s0_hwrite    ),
    .SPI_mem_ahb_haddr    (spi_mem_s0_haddr     ),
    .SPI_mem_ahb_hburst   (/*not used*/         ),
    .SPI_mem_ahb_hmastlock(/*not used*/         ),
    .SPI_mem_ahb_hprot    (/*not used*/         ),
    .SPI_mem_ahb_hrdata   (spi_mem_s0_hrdata    ),
    .SPI_mem_ahb_hready   (spi_mem_s0_hready    ),
    .SPI_mem_ahb_hresp    (spi_mem_s0_hresp     ),
    .SPI_mem_ahb_hsel     (spi_mem_s0_hsel      ),
    .SPI_mem_ahb_hsize    (/*not used*/         ),
    .SPI_mem_ahb_htrans   (spi_mem_s0_htrans    ),
    .SPI_mem_ahb_hwbe     (/*not used*/         ),
    .SPI_mem_ahb_hwdata   (/*not used*/         ),
    .SPI_mem_ahb_hwrite   (spi_mem_s0_hwrite    ),
    .UART_apb_s0_paddr    (uart_s0_paddr        ),
    .UART_apb_s0_penable  (uart_s0_penable      ),
    .UART_apb_s0_prdata   (uart_s0_prdata       ),
    .UART_apb_s0_pready   (uart_s0_pready       ),
    .UART_apb_s0_psel     (uart_s0_psel         ),
    .UART_apb_s0_pslverr  (uart_s0_pslverr      ),
    .UART_apb_s0_pwbe     (/*not used*/         ),
    .UART_apb_s0_pwdata   (uart_s0_pwdata       ),
    .UART_apb_s0_pwrite   (uart_s0_pwrite       ),
    .UART_apb_s1_paddr    (uart_s1_paddr        ),
    .UART_apb_s1_penable  (uart_s1_penable      ),
    .UART_apb_s1_prdata   (uart_s1_prdata       ),
    .UART_apb_s1_pready   (uart_s1_pready       ),
    .UART_apb_s1_psel     (uart_s1_psel         ),
    .UART_apb_s1_pslverr  (uart_s1_pslverr      ),
    .UART_apb_s1_pwbe     (/*not used*/         ),
    .UART_apb_s1_pwdata   (uart_s1_pwdata       ),
    .UART_apb_s1_pwrite   (uart_s1_pwrite       ),
    .USB_axi_s0_ar_addr   (usb_s0_araddr        ),
    .USB_axi_s0_ar_prot   (usb_s0_arprot        ),
    .USB_axi_s0_ar_ready  (usb_s0_arready       ),
    .USB_axi_s0_ar_valid  (usb_s0_arvalid       ),
    .USB_axi_s0_aw_addr   (usb_s0_awaddr        ),
    .USB_axi_s0_aw_prot   (usb_s0_awprot        ),
    .USB_axi_s0_aw_ready  (usb_s0_awready       ),
    .USB_axi_s0_aw_valid  (usb_s0_awvalid       ),
    .USB_axi_s0_b_ready   (usb_s0_bready        ),
    .USB_axi_s0_b_resp    (usb_s0_bresp         ),
    .USB_axi_s0_b_valid   (usb_s0_bvalid        ),
    .USB_axi_s0_r_data    (usb_s0_rdata         ),
    .USB_axi_s0_r_ready   (usb_s0_rready        ),
    .USB_axi_s0_r_resp    (usb_s0_rresp         ),
    .USB_axi_s0_r_valid   (usb_s0_rvalid        ),
    .USB_axi_s0_w_data    (usb_s0_wdata         ),
    .USB_axi_s0_w_ready   (usb_s0_wready        ),
    .USB_axi_s0_w_strb    (usb_s0_wstrb         ),
    .USB_axi_s0_w_valid   (usb_s0_wvalid        ),
    .acpu_axi_m0_ar_addr  (acpu_m0_araddr       ),
    .acpu_axi_m0_ar_burst (acpu_m0_arburst      ),
    .acpu_axi_m0_ar_cache (acpu_m0_arcache      ),
    .acpu_axi_m0_ar_id    (acpu_m0_arid         ),
    .acpu_axi_m0_ar_len   (acpu_m0_arlen[2:0]   ),
    .acpu_axi_m0_ar_lock  (acpu_m0_arlock       ),
    .acpu_axi_m0_ar_prot  (acpu_m0_arprot       ),
    .acpu_axi_m0_ar_ready (acpu_m0_arready      ),
    .acpu_axi_m0_ar_size  (acpu_m0_arsize       ),
    .acpu_axi_m0_ar_valid (acpu_m0_arvalid      ),
    .acpu_axi_m0_aw_addr  (acpu_m0_awaddr       ),
    .acpu_axi_m0_aw_burst (acpu_m0_awburst      ),
    .acpu_axi_m0_aw_cache (acpu_m0_awcache      ),
    .acpu_axi_m0_aw_id    (acpu_m0_awid         ),
    .acpu_axi_m0_aw_len   (acpu_m0_awlen[2:0]   ),
    .acpu_axi_m0_aw_lock  (acpu_m0_awlock       ),
    .acpu_axi_m0_aw_prot  (acpu_m0_awprot       ),
    .acpu_axi_m0_aw_ready (acpu_m0_awready      ),
    .acpu_axi_m0_aw_size  (acpu_m0_awsize       ),
    .acpu_axi_m0_aw_valid (acpu_m0_awvalid      ),
    .acpu_axi_m0_b_id     (acpu_m0_bid          ),
    .acpu_axi_m0_b_ready  (acpu_m0_bready       ),
    .acpu_axi_m0_b_resp   (acpu_m0_bresp        ),
    .acpu_axi_m0_b_valid  (acpu_m0_bvalid       ),
    .acpu_axi_m0_r_data   (acpu_m0_rdata        ),
    .acpu_axi_m0_r_id     (acpu_m0_rid          ),
    .acpu_axi_m0_r_last   (acpu_m0_rlast        ),
    .acpu_axi_m0_r_ready  (acpu_m0_rready       ),
    .acpu_axi_m0_r_resp   (acpu_m0_rresp        ),
    .acpu_axi_m0_r_valid  (acpu_m0_rvalid       ),
    .acpu_axi_m0_w_data   (acpu_m0_wdata        ),
    .acpu_axi_m0_w_last   (acpu_m0_wlast        ),
    .acpu_axi_m0_w_ready  (acpu_m0_wready       ),
    .acpu_axi_m0_w_strb   (acpu_m0_wstrb        ),
    .acpu_axi_m0_w_valid  (acpu_m0_wvalid       ),
    .bcpu_ahb_m0_haddr    (bcpu_m0_haddr        ),
    .bcpu_ahb_m0_hburst   (bcpu_m0_hburst       ),
    .bcpu_ahb_m0_hmastlock(1'b0                 ), //? 1'b0
    .bcpu_ahb_m0_hprot    (bcpu_m0_hprot        ),
    .bcpu_ahb_m0_hrdata   (bcpu_m0_hrdata       ),
    .bcpu_ahb_m0_hready   (bcpu_m0_hready       ),
    .bcpu_ahb_m0_hresp    (bcpu_m0_hresp[0]     ),
    .bcpu_ahb_m0_hsel     (bcpu_m0_hsel         ), //? 1'b1
    .bcpu_ahb_m0_hsize    (bcpu_m0_hsize        ),
    .bcpu_ahb_m0_htrans   (bcpu_m0_htrans       ),
    .bcpu_ahb_m0_hwbe     (4'hF                 ), //? 4'hF
    .bcpu_ahb_m0_hwdata   (bcpu_m0_hwdata       ),
    .bcpu_ahb_m0_hwrite   (bcpu_m0_hwrite       ),
    .clk_133              (clk_apb_ug           ),
    .clk_266              (clk_bcpu             ),
    .clk_533              (clk_acpu             ),
    .ddr_axi_s0_ar_addr   (ddr0_araddr          ),
    .ddr_axi_s0_ar_burst  (ddr0_arburst         ),
    .ddr_axi_s0_ar_cache  (ddr0_arcache         ),
    .ddr_axi_s0_ar_id     (ddr0_arid            ),
    .ddr_axi_s0_ar_len    (ddr0_arlen[2:0]      ),
    .ddr_axi_s0_ar_lock   (ddr0_arlock          ),
    .ddr_axi_s0_ar_prot   (ddr0_arprot          ),
    .ddr_axi_s0_ar_ready  (ddr0_arready         ),
    .ddr_axi_s0_ar_size   (ddr0_arsize          ),
    .ddr_axi_s0_ar_valid  (ddr0_arvalid         ),
    .ddr_axi_s0_aw_addr   (ddr0_awaddr          ),
    .ddr_axi_s0_aw_burst  (ddr0_awburst         ),
    .ddr_axi_s0_aw_cache  (ddr0_awcache         ),
    .ddr_axi_s0_aw_id     (ddr0_awid            ),
    .ddr_axi_s0_aw_len    (ddr0_awlen[2:0]      ),
    .ddr_axi_s0_aw_lock   (ddr0_awlock          ),
    .ddr_axi_s0_aw_prot   (ddr0_awprot          ),
    .ddr_axi_s0_aw_ready  (ddr0_awready         ),
    .ddr_axi_s0_aw_size   (ddr0_awsize          ),
    .ddr_axi_s0_aw_valid  (ddr0_awvalid         ),
    .ddr_axi_s0_b_id      (ddr0_bid             ),
    .ddr_axi_s0_b_ready   (ddr0_bready          ),
    .ddr_axi_s0_b_resp    (ddr0_bresp           ),
    .ddr_axi_s0_b_valid   (ddr0_bvalid          ),
    .ddr_axi_s0_r_data    (ddr0_rdata           ),
    .ddr_axi_s0_r_id      (ddr0_rid             ),
    .ddr_axi_s0_r_last    (ddr0_rlast           ),
    .ddr_axi_s0_r_ready   (ddr0_rready          ),
    .ddr_axi_s0_r_resp    (ddr0_rresp           ),
    .ddr_axi_s0_r_valid   (ddr0_rvalid          ),
    .ddr_axi_s0_w_data    (ddr0_wdata           ),
    .ddr_axi_s0_w_last    (ddr0_wlast           ),
    .ddr_axi_s0_w_ready   (ddr0_wready          ),
    .ddr_axi_s0_w_strb    (ddr0_wstrb           ),
    .ddr_axi_s0_w_valid   (ddr0_wvalid          ),
    .ddr_axi_s1_ar_addr   (ddr1_araddr          ),
    .ddr_axi_s1_ar_burst  (ddr1_arburst         ),
    .ddr_axi_s1_ar_cache  (ddr1_arcache         ),
    .ddr_axi_s1_ar_id     (ddr1_arid            ),
    .ddr_axi_s1_ar_len    (ddr1_arlen[2:0]      ),
    .ddr_axi_s1_ar_lock   (ddr1_arlock          ),
    .ddr_axi_s1_ar_prot   (ddr1_arprot          ),
    .ddr_axi_s1_ar_ready  (ddr1_arready         ),
    .ddr_axi_s1_ar_size   (ddr1_arsize          ),
    .ddr_axi_s1_ar_valid  (ddr1_arvalid         ),
    .ddr_axi_s1_aw_addr   (ddr1_awaddr          ),
    .ddr_axi_s1_aw_burst  (ddr1_awburst         ),
    .ddr_axi_s1_aw_cache  (ddr1_awcache         ),
    .ddr_axi_s1_aw_id     (ddr1_awid            ),
    .ddr_axi_s1_aw_len    (ddr1_awlen[2:0]      ),
    .ddr_axi_s1_aw_lock   (ddr1_awlock          ),
    .ddr_axi_s1_aw_prot   (ddr1_awprot          ),
    .ddr_axi_s1_aw_ready  (ddr1_awready         ),
    .ddr_axi_s1_aw_size   (ddr1_awsize          ),
    .ddr_axi_s1_aw_valid  (ddr1_awvalid         ),
    .ddr_axi_s1_b_id      (ddr1_bid             ),
    .ddr_axi_s1_b_ready   (ddr1_bready          ),
    .ddr_axi_s1_b_resp    (ddr1_bresp           ),
    .ddr_axi_s1_b_valid   (ddr1_bvalid          ),
    .ddr_axi_s1_r_data    (ddr1_rdata           ),
    .ddr_axi_s1_r_id      (ddr1_rid             ),
    .ddr_axi_s1_r_last    (ddr1_rlast           ),
    .ddr_axi_s1_r_ready   (ddr1_rready          ),
    .ddr_axi_s1_r_resp    (ddr1_rresp           ),
    .ddr_axi_s1_r_valid   (ddr1_rvalid          ),
    .ddr_axi_s1_w_data    (ddr1_wdata           ),
    .ddr_axi_s1_w_last    (ddr1_wlast           ),
    .ddr_axi_s1_w_ready   (ddr1_wready          ),
    .ddr_axi_s1_w_strb    (ddr1_wstrb           ),
    .ddr_axi_s1_w_valid   (ddr1_wvalid          ),
    .ddr_axi_s2_ar_addr   (ddr2_araddr          ),
    .ddr_axi_s2_ar_burst  (ddr2_arburst         ),
    .ddr_axi_s2_ar_cache  (ddr2_arcache         ),
    .ddr_axi_s2_ar_id     (ddr2_arid            ),
    .ddr_axi_s2_ar_len    (ddr2_arlen[2:0]      ),
    .ddr_axi_s2_ar_lock   (ddr2_arlock          ),
    .ddr_axi_s2_ar_prot   (ddr2_arprot          ),
    .ddr_axi_s2_ar_ready  (ddr2_arready         ),
    .ddr_axi_s2_ar_size   (ddr2_arsize          ),
    .ddr_axi_s2_ar_valid  (ddr2_arvalid         ),
    .ddr_axi_s2_aw_addr   (ddr2_awaddr          ),
    .ddr_axi_s2_aw_burst  (ddr2_awburst         ),
    .ddr_axi_s2_aw_cache  (ddr2_awcache         ),
    .ddr_axi_s2_aw_id     (ddr2_awid            ),
    .ddr_axi_s2_aw_len    (ddr2_awlen[2:0]      ),
    .ddr_axi_s2_aw_lock   (ddr2_awlock          ),
    .ddr_axi_s2_aw_prot   (ddr2_awprot          ),
    .ddr_axi_s2_aw_ready  (ddr2_awready         ),
    .ddr_axi_s2_aw_size   (ddr2_awsize          ),
    .ddr_axi_s2_aw_valid  (ddr2_awvalid         ),
    .ddr_axi_s2_b_id      (ddr2_bid             ),
    .ddr_axi_s2_b_ready   (ddr2_bready          ),
    .ddr_axi_s2_b_resp    (ddr2_bresp           ),
    .ddr_axi_s2_b_valid   (ddr2_bvalid          ),
    .ddr_axi_s2_r_data    (ddr2_rdata           ),
    .ddr_axi_s2_r_id      (ddr2_rid             ),
    .ddr_axi_s2_r_last    (ddr2_rlast           ),
    .ddr_axi_s2_r_ready   (ddr2_rready          ),
    .ddr_axi_s2_r_resp    (ddr2_rresp           ),
    .ddr_axi_s2_r_valid   (ddr2_rvalid          ),
    .ddr_axi_s2_w_data    (ddr2_wdata           ),
    .ddr_axi_s2_w_last    (ddr2_wlast           ),
    .ddr_axi_s2_w_ready   (ddr2_wready          ),
    .ddr_axi_s2_w_strb    (ddr2_wstrb           ),
    .ddr_axi_s2_w_valid   (ddr2_wvalid          ),
    .ddr_axi_s3_ar_addr   (ddr3_araddr          ),
    .ddr_axi_s3_ar_burst  (ddr3_arburst         ),
    .ddr_axi_s3_ar_cache  (ddr3_arcache         ),
    .ddr_axi_s3_ar_id     (ddr3_arid            ),
    .ddr_axi_s3_ar_len    (ddr3_arlen[2:0]      ),
    .ddr_axi_s3_ar_lock   (ddr3_arlock          ),
    .ddr_axi_s3_ar_prot   (ddr3_arprot          ),
    .ddr_axi_s3_ar_ready  (ddr3_arready         ),
    .ddr_axi_s3_ar_size   (ddr3_arsize          ),
    .ddr_axi_s3_ar_valid  (ddr3_arvalid         ),
    .ddr_axi_s3_aw_addr   (ddr3_awaddr          ),
    .ddr_axi_s3_aw_burst  (ddr3_awburst         ),
    .ddr_axi_s3_aw_cache  (ddr3_awcache         ),
    .ddr_axi_s3_aw_id     (ddr3_awid            ),
    .ddr_axi_s3_aw_len    (ddr3_awlen[2:0]      ),
    .ddr_axi_s3_aw_lock   (ddr3_awlock          ),
    .ddr_axi_s3_aw_prot   (ddr3_awprot          ),
    .ddr_axi_s3_aw_ready  (ddr3_awready         ),
    .ddr_axi_s3_aw_size   (ddr3_awsize          ),
    .ddr_axi_s3_aw_valid  (ddr3_awvalid         ),
    .ddr_axi_s3_b_id      (ddr3_bid             ),
    .ddr_axi_s3_b_ready   (ddr3_bready          ),
    .ddr_axi_s3_b_resp    (ddr3_bresp           ),
    .ddr_axi_s3_b_valid   (ddr3_bvalid          ),
    .ddr_axi_s3_r_data    (ddr3_rdata           ),
    .ddr_axi_s3_r_id      (ddr3_rid             ),
    .ddr_axi_s3_r_last    (ddr3_rlast           ),
    .ddr_axi_s3_r_ready   (ddr3_rready          ),
    .ddr_axi_s3_r_resp    (ddr3_rresp           ),
    .ddr_axi_s3_r_valid   (ddr3_rvalid          ),
    .ddr_axi_s3_w_data    (ddr3_wdata           ),
    .ddr_axi_s3_w_last    (ddr3_wlast           ),
    .ddr_axi_s3_w_ready   (ddr3_wready          ),
    .ddr_axi_s3_w_strb    (ddr3_wstrb           ),
    .ddr_axi_s3_w_valid   (ddr3_wvalid          ),
    .ddr_axil_s0_ar_addr  (cntl_araddr          ),
    .ddr_axil_s0_ar_prot  (/*not used*/         ),
    .ddr_axil_s0_ar_ready (cntl_arready         ),
    .ddr_axil_s0_ar_valid (cntl_arvalid         ),
    .ddr_axil_s0_aw_addr  (cntl_awaddr          ),
    .ddr_axil_s0_aw_prot  (/*not used*/         ),
    .ddr_axil_s0_aw_ready (cntl_awready         ),
    .ddr_axil_s0_aw_valid (cntl_awvalid         ),
    .ddr_axil_s0_b_ready  (cntl_bready          ),
    .ddr_axil_s0_b_resp   (cntl_bresp           ),
    .ddr_axil_s0_b_valid  (cntl_bvalid          ),
    .ddr_axil_s0_r_data   (cntl_rdata           ),
    .ddr_axil_s0_r_ready  (cntl_rready          ),
    .ddr_axil_s0_r_resp   (cntl_rresp           ),
    .ddr_axil_s0_r_valid  (cntl_rvalid          ),
    .ddr_axil_s0_w_data   (cntl_wdata           ),
    .ddr_axil_s0_w_ready  (cntl_wready          ),
    .ddr_axil_s0_w_strb   (/*not used*/         ),
    .ddr_axil_s0_w_valid  (cntl_wvalid          ),
    .dma_axi_m0_ar_addr   (dma_m0_araddr        ),
    .dma_axi_m0_ar_burst  (dma_m0_arburst       ),
    .dma_axi_m0_ar_cache  (dma_m0_arcache       ),
    .dma_axi_m0_ar_id     ({1'b0,dma_m0_arid}   ),
    .dma_axi_m0_ar_len    (dma_m0_arlen[3:0]    ),
    .dma_axi_m0_ar_lock   (dma_m0_arlock        ),
    .dma_axi_m0_ar_prot   (dma_m0_arprot        ),
    .dma_axi_m0_ar_ready  (dma_m0_arready       ),
    .dma_axi_m0_ar_size   (dma_m0_arsize        ),
    .dma_axi_m0_ar_valid  (dma_m0_arvalid       ),
    .dma_axi_m0_aw_addr   (dma_m0_awaddr        ),
    .dma_axi_m0_aw_burst  (dma_m0_awburst       ),
    .dma_axi_m0_aw_cache  (dma_m0_awcache       ),
    .dma_axi_m0_aw_id     ({1'b0,dma_m0_awid}   ),
    .dma_axi_m0_aw_len    (dma_m0_awlen[3:0]    ),
    .dma_axi_m0_aw_lock   (dma_m0_awlock        ),
    .dma_axi_m0_aw_prot   (dma_m0_awprot        ),
    .dma_axi_m0_aw_ready  (dma_m0_awready       ),
    .dma_axi_m0_aw_size   (dma_m0_awsize        ),
    .dma_axi_m0_aw_valid  (dma_m0_awvalid       ),
    .dma_axi_m0_b_id      (dma_m0_bid           ),
    .dma_axi_m0_b_ready   (dma_m0_bready        ),
    .dma_axi_m0_b_resp    (dma_m0_bresp         ),
    .dma_axi_m0_b_valid   (dma_m0_bvalid        ),
    .dma_axi_m0_r_data    (dma_m0_rdata         ),
    .dma_axi_m0_r_id      (dma_m0_rid           ),
    .dma_axi_m0_r_last    (dma_m0_rlast         ),
    .dma_axi_m0_r_ready   (dma_m0_rready        ),
    .dma_axi_m0_r_resp    (dma_m0_rresp         ),
    .dma_axi_m0_r_valid   (dma_m0_rvalid        ),
    .dma_axi_m0_w_data    (dma_m0_wdata         ),
    .dma_axi_m0_w_last    (dma_m0_wlast         ),
    .dma_axi_m0_w_ready   (dma_m0_wready        ),
    .dma_axi_m0_w_strb    (dma_m0_wstrb         ),
    .dma_axi_m0_w_valid   (dma_m0_wvalid        ),
    .dma_axi_m1_ar_addr   (dma_m1_araddr        ),
    .dma_axi_m1_ar_burst  (dma_m1_arburst       ),
    .dma_axi_m1_ar_cache  (dma_m1_arcache       ),
    .dma_axi_m1_ar_id     ({1'b0,dma_m1_arid}   ),
    .dma_axi_m1_ar_len    (dma_m1_arlen[3:0]    ),
    .dma_axi_m1_ar_lock   (dma_m1_arlock        ),
    .dma_axi_m1_ar_prot   (dma_m1_arprot        ),
    .dma_axi_m1_ar_ready  (dma_m1_arready       ),
    .dma_axi_m1_ar_size   (dma_m1_arsize        ),
    .dma_axi_m1_ar_valid  (dma_m1_arvalid       ),
    .dma_axi_m1_aw_addr   (dma_m1_awaddr        ),
    .dma_axi_m1_aw_burst  (dma_m1_awburst       ),
    .dma_axi_m1_aw_cache  (dma_m1_awcache       ),
    .dma_axi_m1_aw_id     ({1'b0,dma_m1_awid}   ),
    .dma_axi_m1_aw_len    (dma_m1_awlen[3:0]    ),
    .dma_axi_m1_aw_lock   (dma_m1_awlock        ),
    .dma_axi_m1_aw_prot   (dma_m1_awprot        ),
    .dma_axi_m1_aw_ready  (dma_m1_awready       ),
    .dma_axi_m1_aw_size   (dma_m1_awsize        ),
    .dma_axi_m1_aw_valid  (dma_m1_awvalid       ),
    .dma_axi_m1_b_id      (dma_m1_bid           ),
    .dma_axi_m1_b_ready   (dma_m1_bready        ),
    .dma_axi_m1_b_resp    (dma_m1_bresp         ),
    .dma_axi_m1_b_valid   (dma_m1_bvalid        ),
    .dma_axi_m1_r_data    (dma_m1_rdata         ),
    .dma_axi_m1_r_id      (dma_m1_rid           ),
    .dma_axi_m1_r_last    (dma_m1_rlast         ),
    .dma_axi_m1_r_ready   (dma_m1_rready        ),
    .dma_axi_m1_r_resp    (dma_m1_rresp         ),
    .dma_axi_m1_r_valid   (dma_m1_rvalid        ),
    .dma_axi_m1_w_data    (dma_m1_wdata         ),
    .dma_axi_m1_w_last    (dma_m1_wlast         ),
    .dma_axi_m1_w_ready   (dma_m1_wready        ),
    .dma_axi_m1_w_strb    (dma_m1_wstrb         ),
    .dma_axi_m1_w_valid   (dma_m1_wvalid        ),
    .fpga_ahb_s0_haddr    (fpga_ahb_s0_haddr    ),
    .fpga_ahb_s0_hburst   (fpga_ahb_s0_hburst   ),
    .fpga_ahb_s0_hmastlock(fpga_ahb_s0_hmastlock),
    .fpga_ahb_s0_hprot    (fpga_ahb_s0_hprot    ),
    .fpga_ahb_s0_hrdata   (fpga_ahb_s0_hrdata   ),
    .fpga_ahb_s0_hready   (fpga_ahb_s0_hready   ),
    .fpga_ahb_s0_hresp    (fpga_ahb_s0_hresp    ),
    .fpga_ahb_s0_hsel     (fpga_ahb_s0_hsel     ),
    .fpga_ahb_s0_hsize    (fpga_ahb_s0_hsize    ),
    .fpga_ahb_s0_htrans   (fpga_ahb_s0_htrans   ),
    .fpga_ahb_s0_hwbe     (fpga_ahb_s0_hwbe     ),
    .fpga_ahb_s0_hwdata   (fpga_ahb_s0_hwdata   ),
    .fpga_ahb_s0_hwrite   (fpga_ahb_s0_hwrite   ),
    .fpga_axi_m0_ar_addr  (fpga_axi_m0_ar_addr  ),
    .fpga_axi_m0_ar_burst (fpga_axi_m0_ar_burst ),
    .fpga_axi_m0_ar_cache (fpga_axi_m0_ar_cache ),
    .fpga_axi_m0_ar_id    (fpga_axi_m0_ar_id    ),
    .fpga_axi_m0_ar_len   (fpga_axi_m0_ar_len   ),
    .fpga_axi_m0_ar_lock  (fpga_axi_m0_ar_lock  ),
    .fpga_axi_m0_ar_prot  (fpga_axi_m0_ar_prot  ),
    .fpga_axi_m0_ar_ready (fpga_axi_m0_ar_ready ),
    .fpga_axi_m0_ar_size  (fpga_axi_m0_ar_size  ),
    .fpga_axi_m0_ar_valid (fpga_axi_m0_ar_valid ),
    .fpga_axi_m0_aw_addr  (fpga_axi_m0_aw_addr  ),
    .fpga_axi_m0_aw_burst (fpga_axi_m0_aw_burst ),
    .fpga_axi_m0_aw_cache (fpga_axi_m0_aw_cache ),
    .fpga_axi_m0_aw_id    (fpga_axi_m0_aw_id    ),
    .fpga_axi_m0_aw_len   (fpga_axi_m0_aw_len   ),
    .fpga_axi_m0_aw_lock  (fpga_axi_m0_aw_lock  ),
    .fpga_axi_m0_aw_prot  (fpga_axi_m0_aw_prot  ),
    .fpga_axi_m0_aw_ready (fpga_axi_m0_aw_ready ),
    .fpga_axi_m0_aw_size  (fpga_axi_m0_aw_size  ),
    .fpga_axi_m0_aw_valid (fpga_axi_m0_aw_valid ),
    .fpga_axi_m0_b_id     (fpga_axi_m0_b_id     ),
    .fpga_axi_m0_b_ready  (fpga_axi_m0_b_ready  ),
    .fpga_axi_m0_b_resp   (fpga_axi_m0_b_resp   ),
    .fpga_axi_m0_b_valid  (fpga_axi_m0_b_valid  ),
    .fpga_axi_m0_r_data   (fpga_axi_m0_r_data   ),
    .fpga_axi_m0_r_id     (fpga_axi_m0_r_id     ),
    .fpga_axi_m0_r_last   (fpga_axi_m0_r_last   ),
    .fpga_axi_m0_r_ready  (fpga_axi_m0_r_ready  ),
    .fpga_axi_m0_r_resp   (fpga_axi_m0_r_resp   ),
    .fpga_axi_m0_r_valid  (fpga_axi_m0_r_valid  ),
    .fpga_axi_m0_w_data   (fpga_axi_m0_w_data   ),
    .fpga_axi_m0_w_last   (fpga_axi_m0_w_last   ),
    .fpga_axi_m0_w_ready  (fpga_axi_m0_w_ready  ),
    .fpga_axi_m0_w_strb   (fpga_axi_m0_w_strb   ),
    .fpga_axi_m0_w_valid  (fpga_axi_m0_w_valid  ),
    .fpga_axi_m1_ar_addr  (fpga_axi_m1_ar_addr  ),
    .fpga_axi_m1_ar_burst (fpga_axi_m1_ar_burst ),
    .fpga_axi_m1_ar_cache (fpga_axi_m1_ar_cache ),
    .fpga_axi_m1_ar_id    (fpga_axi_m1_ar_id    ),
    .fpga_axi_m1_ar_len   (fpga_axi_m1_ar_len   ),
    .fpga_axi_m1_ar_lock  (fpga_axi_m1_ar_lock  ),
    .fpga_axi_m1_ar_prot  (fpga_axi_m1_ar_prot  ),
    .fpga_axi_m1_ar_ready (fpga_axi_m1_ar_ready ),
    .fpga_axi_m1_ar_size  (fpga_axi_m1_ar_size  ),
    .fpga_axi_m1_ar_valid (fpga_axi_m1_ar_valid ),
    .fpga_axi_m1_aw_addr  (fpga_axi_m1_aw_addr  ),
    .fpga_axi_m1_aw_burst (fpga_axi_m1_aw_burst ),
    .fpga_axi_m1_aw_cache (fpga_axi_m1_aw_cache ),
    .fpga_axi_m1_aw_id    (fpga_axi_m1_aw_id    ),
    .fpga_axi_m1_aw_len   (fpga_axi_m1_aw_len   ),
    .fpga_axi_m1_aw_lock  (fpga_axi_m1_aw_lock  ),
    .fpga_axi_m1_aw_prot  (fpga_axi_m1_aw_prot  ),
    .fpga_axi_m1_aw_ready (fpga_axi_m1_aw_ready ),
    .fpga_axi_m1_aw_size  (fpga_axi_m1_aw_size  ),
    .fpga_axi_m1_aw_valid (fpga_axi_m1_aw_valid ),
    .fpga_axi_m1_b_id     (fpga_axi_m1_b_id     ),
    .fpga_axi_m1_b_ready  (fpga_axi_m1_b_ready  ),
    .fpga_axi_m1_b_resp   (fpga_axi_m1_b_resp   ),
    .fpga_axi_m1_b_valid  (fpga_axi_m1_b_valid  ),
    .fpga_axi_m1_r_data   (fpga_axi_m1_r_data   ),
    .fpga_axi_m1_r_id     (fpga_axi_m1_r_id     ),
    .fpga_axi_m1_r_last   (fpga_axi_m1_r_last   ),
    .fpga_axi_m1_r_ready  (fpga_axi_m1_r_ready  ),
    .fpga_axi_m1_r_resp   (fpga_axi_m1_r_resp   ),
    .fpga_axi_m1_r_valid  (fpga_axi_m1_r_valid  ),
    .fpga_axi_m1_w_data   (fpga_axi_m1_w_data   ),
    .fpga_axi_m1_w_last   (fpga_axi_m1_w_last   ),
    .fpga_axi_m1_w_ready  (fpga_axi_m1_w_ready  ),
    .fpga_axi_m1_w_strb   (fpga_axi_m1_w_strb   ),
    .fpga_axi_m1_w_valid  (fpga_axi_m1_w_valid  ),
    .fpga_clk_m0          (clk_fpga0            ),
    .fpga_clk_m1          (clk_fpga1            ),
    .fpga_clk_s0          (clk_fpga_s           ),
    .fpga_rstm0_n         (rst_n_fpga0          ),
    .fpga_rstm1_n         (rst_n_fpga1          ),
    .fpga_rsts0_n         (rst_n_fpga_s         ),
    .gbe_apb_s0_paddr     (gbe_s0_paddr         ),
    .gbe_apb_s0_penable   (gbe_s0_penable       ),
    .gbe_apb_s0_prdata    (gbe_s0_prdata        ),
    .gbe_apb_s0_pready    (gbe_s0_pready        ),
    .gbe_apb_s0_psel      (gbe_s0_psel          ),
    .gbe_apb_s0_pslverr   (gbe_s0_pslverr       ),
    .gbe_apb_s0_pwbe      (gbe_s0_pstrb         ),
    .gbe_apb_s0_pwdata    (gbe_s0_pwdata        ),
    .gbe_apb_s0_pwrite    (gbe_s0_pwrite        ),
    .gbe_axi_m0_ar_addr   (gbe_m0_araddr        ),
    .gbe_axi_m0_ar_burst  (gbe_m0_arburst       ),
    .gbe_axi_m0_ar_cache  (gbe_m0_arcache       ),
    .gbe_axi_m0_ar_id     ({1'b0,gbe_m0_arid}   ),
    .gbe_axi_m0_ar_len    (gbe_m0_arlen[3:0]    ),
    .gbe_axi_m0_ar_lock   (gbe_m0_arlock        ),
    .gbe_axi_m0_ar_prot   (gbe_m0_arprot        ),
    .gbe_axi_m0_ar_ready  (gbe_m0_arready       ),
    .gbe_axi_m0_ar_size   (gbe_m0_arsize        ),
    .gbe_axi_m0_ar_valid  (gbe_m0_arvalid       ),
    .gbe_axi_m0_aw_addr   (gbe_m0_awaddr        ),
    .gbe_axi_m0_aw_burst  (gbe_m0_awburst       ),
    .gbe_axi_m0_aw_cache  (gbe_m0_awcache       ),
    .gbe_axi_m0_aw_id     ({1'b0,gbe_m0_awid}   ),
    .gbe_axi_m0_aw_len    (gbe_m0_awlen[3:0]    ),
    .gbe_axi_m0_aw_lock   (gbe_m0_awlock        ),
    .gbe_axi_m0_aw_prot   (gbe_m0_awprot        ),
    .gbe_axi_m0_aw_ready  (gbe_m0_awready       ),
    .gbe_axi_m0_aw_size   (gbe_m0_awsize        ),
    .gbe_axi_m0_aw_valid  (gbe_m0_awvalid       ),
    .gbe_axi_m0_b_id      (gbe_m0_bid           ),
    .gbe_axi_m0_b_ready   (gbe_m0_bready        ),
    .gbe_axi_m0_b_resp    (gbe_m0_bresp         ),
    .gbe_axi_m0_b_valid   (gbe_m0_bvalid        ),
    .gbe_axi_m0_r_data    (gbe_m0_rdata         ),
    .gbe_axi_m0_r_id      (gbe_m0_rid           ),
    .gbe_axi_m0_r_last    (gbe_m0_rlast         ),
    .gbe_axi_m0_r_ready   (gbe_m0_rready        ),
    .gbe_axi_m0_r_resp    (gbe_m0_rresp         ),
    .gbe_axi_m0_r_valid   (gbe_m0_rvalid        ),
    .gbe_axi_m0_w_data    (gbe_m0_wdata         ),
    .gbe_axi_m0_w_last    (gbe_m0_wlast         ),
    .gbe_axi_m0_w_ready   (gbe_m0_wready        ),
    .gbe_axi_m0_w_strb    (gbe_m0_wstrb         ),
    .gbe_axi_m0_w_valid   (gbe_m0_wvalid        ),
    .rst_133_n            (rst_n_133            ), //?
    .rst_266_n            (rst_n_266            ), //?
    .rst_533_n            (rst_n_533            ), //?
    .sram_axi_s0_ar_addr  (sramb0_araddr        ),
    .sram_axi_s0_ar_burst (sramb0_arburst       ),
    .sram_axi_s0_ar_cache (/*not used*/         ),
    .sram_axi_s0_ar_id    (sramb0_arid          ),
    .sram_axi_s0_ar_len   (sramb0_arlen         ),
    .sram_axi_s0_ar_lock  (/*not used*/         ),
    .sram_axi_s0_ar_prot  (/*not used*/         ),
    .sram_axi_s0_ar_ready (sramb0_arready       ),
    .sram_axi_s0_ar_size  (sramb0_arsize        ),
    .sram_axi_s0_ar_valid (sramb0_arvalid       ),
    .sram_axi_s0_aw_addr  (sramb0_awaddr        ),
    .sram_axi_s0_aw_burst (sramb0_awburst       ),
    .sram_axi_s0_aw_cache (/*not used*/         ),
    .sram_axi_s0_aw_id    (sramb0_awid          ),
    .sram_axi_s0_aw_len   (sramb0_awlen         ),
    .sram_axi_s0_aw_lock  (/*not used*/         ),
    .sram_axi_s0_aw_prot  (/*not used*/         ),
    .sram_axi_s0_aw_ready (sramb0_awready       ),
    .sram_axi_s0_aw_size  (sramb0_awsize        ),
    .sram_axi_s0_aw_valid (sramb0_awvalid       ),
    .sram_axi_s0_b_id     (sramb0_bid           ),
    .sram_axi_s0_b_ready  (sramb0_bready        ),
    .sram_axi_s0_b_resp   (sramb0_bresp         ),
    .sram_axi_s0_b_valid  (sramb0_bvalid        ),
    .sram_axi_s0_r_data   (sramb0_rdata         ),
    .sram_axi_s0_r_id     (sramb0_rid           ),
    .sram_axi_s0_r_last   (sramb0_rlast         ),
    .sram_axi_s0_r_ready  (sramb0_rready        ),
    .sram_axi_s0_r_resp   (sramb0_rresp         ),
    .sram_axi_s0_r_valid  (sramb0_rvalid        ),
    .sram_axi_s0_w_data   (sramb0_wdata         ),
    .sram_axi_s0_w_last   (sramb0_wlast         ),
    .sram_axi_s0_w_ready  (sramb0_wready        ),
    .sram_axi_s0_w_strb   (sramb0_wstrb         ),
    .sram_axi_s0_w_valid  (sramb0_wvalid        ),
    .sram_axi_s1_ar_addr  (sramb1_araddr        ),
    .sram_axi_s1_ar_burst (sramb1_arburst       ),
    .sram_axi_s1_ar_cache (/*not1used*/         ),
    .sram_axi_s1_ar_id    (sramb1_arid          ),
    .sram_axi_s1_ar_len   (sramb1_arlen         ),
    .sram_axi_s1_ar_lock  (/*not1used*/         ),
    .sram_axi_s1_ar_prot  (/*not1used*/         ),
    .sram_axi_s1_ar_ready (sramb1_arready       ),
    .sram_axi_s1_ar_size  (sramb1_arsize        ),
    .sram_axi_s1_ar_valid (sramb1_arvalid       ),
    .sram_axi_s1_aw_addr  (sramb1_awaddr        ),
    .sram_axi_s1_aw_burst (sramb1_awburst       ),
    .sram_axi_s1_aw_cache (/*not1used*/         ),
    .sram_axi_s1_aw_id    (sramb1_awid          ),
    .sram_axi_s1_aw_len   (sramb1_awlen         ),
    .sram_axi_s1_aw_lock  (/*not1used*/         ),
    .sram_axi_s1_aw_prot  (/*not1used*/         ),
    .sram_axi_s1_aw_ready (sramb1_awready       ),
    .sram_axi_s1_aw_size  (sramb1_awsize        ),
    .sram_axi_s1_aw_valid (sramb1_awvalid       ),
    .sram_axi_s1_b_id     (sramb1_bid           ),
    .sram_axi_s1_b_ready  (sramb1_bready        ),
    .sram_axi_s1_b_resp   (sramb1_bresp         ),
    .sram_axi_s1_b_valid  (sramb1_bvalid        ),
    .sram_axi_s1_r_data   (sramb1_rdata         ),
    .sram_axi_s1_r_id     (sramb1_rid           ),
    .sram_axi_s1_r_last   (sramb1_rlast         ),
    .sram_axi_s1_r_ready  (sramb1_rready        ),
    .sram_axi_s1_r_resp   (sramb1_rresp         ),
    .sram_axi_s1_r_valid  (sramb1_rvalid        ),
    .sram_axi_s1_w_data   (sramb1_wdata         ),
    .sram_axi_s1_w_last   (sramb1_wlast         ),
    .sram_axi_s1_w_ready  (sramb1_wready        ),
    .sram_axi_s1_w_strb   (sramb1_wstrb         ),
    .sram_axi_s1_w_valid  (sramb1_wvalid        ),
    .sram_axi_s2_ar_addr  (sramb2_araddr        ),
    .sram_axi_s2_ar_burst (sramb2_arburst       ),
    .sram_axi_s2_ar_cache (/*not2used*/         ),
    .sram_axi_s2_ar_id    (sramb2_arid          ),
    .sram_axi_s2_ar_len   (sramb2_arlen[3:0]    ),
    .sram_axi_s2_ar_lock  (/*not2used*/         ),
    .sram_axi_s2_ar_prot  (/*not2used*/         ),
    .sram_axi_s2_ar_ready (sramb2_arready       ),
    .sram_axi_s2_ar_size  (sramb2_arsize        ),
    .sram_axi_s2_ar_valid (sramb2_arvalid       ),
    .sram_axi_s2_aw_addr  (sramb2_awaddr        ),
    .sram_axi_s2_aw_burst (sramb2_awburst       ),
    .sram_axi_s2_aw_cache (/*not2used*/         ),
    .sram_axi_s2_aw_id    (sramb2_awid          ),
    .sram_axi_s2_aw_len   (sramb2_awlen[3:0]    ),
    .sram_axi_s2_aw_lock  (/*not2used*/         ),
    .sram_axi_s2_aw_prot  (/*not2used*/         ),
    .sram_axi_s2_aw_ready (sramb2_awready       ),
    .sram_axi_s2_aw_size  (sramb2_awsize        ),
    .sram_axi_s2_aw_valid (sramb2_awvalid       ),
    .sram_axi_s2_b_id     (sramb2_bid           ),
    .sram_axi_s2_b_ready  (sramb2_bready        ),
    .sram_axi_s2_b_resp   (sramb2_bresp         ),
    .sram_axi_s2_b_valid  (sramb2_bvalid        ),
    .sram_axi_s2_r_data   (sramb2_rdata         ),
    .sram_axi_s2_r_id     (sramb2_rid           ),
    .sram_axi_s2_r_last   (sramb2_rlast         ),
    .sram_axi_s2_r_ready  (sramb2_rready        ),
    .sram_axi_s2_r_resp   (sramb2_rresp         ),
    .sram_axi_s2_r_valid  (sramb2_rvalid        ),
    .sram_axi_s2_w_data   (sramb2_wdata         ),
    .sram_axi_s2_w_last   (sramb2_wlast         ),
    .sram_axi_s2_w_ready  (sramb2_wready        ),
    .sram_axi_s2_w_strb   (sramb2_wstrb         ),
    .sram_axi_s2_w_valid  (sramb2_wvalid        ),
    .sram_axi_s3_ar_addr  (sramb3_araddr        ),
    .sram_axi_s3_ar_burst (sramb3_arburst       ),
    .sram_axi_s3_ar_cache (/*not3used*/         ),
    .sram_axi_s3_ar_id    (sramb3_arid          ),
    .sram_axi_s3_ar_len   (sramb3_arlen[3:0]    ),
    .sram_axi_s3_ar_lock  (/*not3used*/         ),
    .sram_axi_s3_ar_prot  (/*not3used*/         ),
    .sram_axi_s3_ar_ready (sramb3_arready       ),
    .sram_axi_s3_ar_size  (sramb3_arsize        ),
    .sram_axi_s3_ar_valid (sramb3_arvalid       ),
    .sram_axi_s3_aw_addr  (sramb3_awaddr        ),
    .sram_axi_s3_aw_burst (sramb3_awburst       ),
    .sram_axi_s3_aw_cache (/*not3used*/         ),
    .sram_axi_s3_aw_id    (sramb3_awid          ),
    .sram_axi_s3_aw_len   (sramb3_awlen[3:0]    ),
    .sram_axi_s3_aw_lock  (/*not3used*/         ),
    .sram_axi_s3_aw_prot  (/*not3used*/         ),
    .sram_axi_s3_aw_ready (sramb3_awready       ),
    .sram_axi_s3_aw_size  (sramb3_awsize        ),
    .sram_axi_s3_aw_valid (sramb3_awvalid       ),
    .sram_axi_s3_b_id     (sramb3_bid           ),
    .sram_axi_s3_b_ready  (sramb3_bready        ),
    .sram_axi_s3_b_resp   (sramb3_bresp         ),
    .sram_axi_s3_b_valid  (sramb3_bvalid        ),
    .sram_axi_s3_r_data   (sramb3_rdata         ),
    .sram_axi_s3_r_id     (sramb3_rid           ),
    .sram_axi_s3_r_last   (sramb3_rlast         ),
    .sram_axi_s3_r_ready  (sramb3_rready        ),
    .sram_axi_s3_r_resp   (sramb3_rresp         ),
    .sram_axi_s3_r_valid  (sramb3_rvalid        ),
    .sram_axi_s3_w_data   (sramb3_wdata         ),
    .sram_axi_s3_w_last   (sramb3_wlast         ),
    .sram_axi_s3_w_ready  (sramb3_wready        ),
    .sram_axi_s3_w_strb   (sramb3_wstrb         ),
    .sram_axi_s3_w_valid  (sramb3_wvalid        ),
    .tm                   (testmode            ),
    .usb_axi_m0_ar_addr   (usb_m0_araddr        ),
    .usb_axi_m0_ar_burst  (usb_m0_arburst       ),
    .usb_axi_m0_ar_cache  (usb_m0_arcache       ),
    .usb_axi_m0_ar_id     ({1'b0,usb_m0_arid}   ),
    .usb_axi_m0_ar_len    (usb_m0_arlen[3:0]    ),
    .usb_axi_m0_ar_lock   (usb_m0_arlock        ),
    .usb_axi_m0_ar_prot   (usb_m0_arprot        ),
    .usb_axi_m0_ar_ready  (usb_m0_arready       ),
    .usb_axi_m0_ar_size   (usb_m0_arsize        ),
    .usb_axi_m0_ar_valid  (usb_m0_arvalid       ),
    .usb_axi_m0_aw_addr   (usb_m0_awaddr        ),
    .usb_axi_m0_aw_burst  (usb_m0_awburst       ),
    .usb_axi_m0_aw_cache  (usb_m0_awcache       ),
    .usb_axi_m0_aw_id     ({1'b0,usb_m0_awid}   ),
    .usb_axi_m0_aw_len    (usb_m0_awlen[3:0]    ),
    .usb_axi_m0_aw_lock   (usb_m0_awlock        ),
    .usb_axi_m0_aw_prot   (usb_m0_awprot        ),
    .usb_axi_m0_aw_ready  (usb_m0_awready       ),
    .usb_axi_m0_aw_size   (usb_m0_awsize        ),
    .usb_axi_m0_aw_valid  (usb_m0_awvalid       ),
    .usb_axi_m0_b_id      (usb_m0_bid           ),
    .usb_axi_m0_b_ready   (usb_m0_bready        ),
    .usb_axi_m0_b_resp    (usb_m0_bresp         ),
    .usb_axi_m0_b_valid   (usb_m0_bvalid        ),
    .usb_axi_m0_r_data    (usb_m0_rdata         ),
    .usb_axi_m0_r_id      (usb_m0_rid           ),
    .usb_axi_m0_r_last    (usb_m0_rlast         ),
    .usb_axi_m0_r_ready   (usb_m0_rready        ),
    .usb_axi_m0_r_resp    (usb_m0_rresp         ),
    .usb_axi_m0_r_valid   (usb_m0_rvalid        ),
    .usb_axi_m0_w_data    (usb_m0_wdata         ),
    .usb_axi_m0_w_last    (usb_m0_wlast         ),
    .usb_axi_m0_w_ready   (usb_m0_wready        ),
    .usb_axi_m0_w_strb    (usb_m0_wstrb         ),
    .usb_axi_m0_w_valid   (usb_m0_wvalid        )
);


endmodule   
