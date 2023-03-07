module soc_config_subsystem (
    input logic locked_proto,
     input logic reset_proto,
     input logic uart0_sin_proto,
     input logic clk_out4_proto,
     input logic clk_out3_proto,
     input logic clk_out2_proto,
     input logic clk_out1_proto,
  input       logic        clk_osc                      ,
  input       logic        clk_fpga0                    ,
  input       logic        clk_fpga1                    ,
  input       logic        clk_fpga_s                   ,
  input       logic [0:0] acpu_wdt_s0_paddr            ,
  input       logic        acpu_wdt_s0_psel             ,
  input       logic        acpu_wdt_s0_penable          ,
  input       logic        acpu_wdt_s0_pwrite           ,
  input       logic [0:0] acpu_wdt_s0_pwdata           ,
  input       logic [0:0] bcpu_wdt_s0_paddr            ,
  input       logic        bcpu_wdt_s0_psel             ,
  input       logic        bcpu_wdt_s0_penable          ,
  input       logic        bcpu_wdt_s0_pwrite           ,
  input       logic [0:0] bcpu_wdt_s0_pwdata           ,
  input       logic [0:0] dma_s0_paddr                 ,
  input       logic        dma_s0_psel                  ,
  input       logic        dma_s0_penable               ,
  input       logic        dma_s0_pwrite                ,
  input       logic [0:0] dma_s0_pwdata                ,
  input       logic [0:0] gpio_s0_paddr                ,
  input       logic        gpio_s0_psel                 ,
  input       logic        gpio_s0_penable              ,
  input       logic        gpio_s0_pwrite               ,
  input       logic [0:0] gpio_s0_pwdata               ,
  input       logic [0:0] gpt_s0_paddr                 ,
  input       logic        gpt_s0_psel                  ,
  input       logic        gpt_s0_penable               ,
  input       logic        gpt_s0_pwrite                ,
  input       logic [0:0] gpt_s0_pwdata                ,
  input       logic [0:0] i2c_s0_paddr                 ,
  input       logic        i2c_s0_psel                  ,
  input       logic        i2c_s0_penable               ,
  input       logic        i2c_s0_pwrite                ,
  input       logic [0:0] i2c_s0_pwdata                ,
  input       logic [0:0] mbox_s0_paddr                ,
  input       logic        mbox_s0_psel                 ,
  input       logic        mbox_s0_penable              ,
  input       logic        mbox_s0_pwrite               ,
  input       logic [0:0] mbox_s0_pwdata               ,
  input       logic [ 0:0] mbox_s0_pstrb                ,
  input       logic [0:0] pufcc_s0_paddr               ,
  input       logic        pufcc_s0_penable             ,
  input       logic        pufcc_s0_psel                ,
  input       logic [0:0] pufcc_s0_pwdata              ,
  input       logic        pufcc_s0_pwrite              ,
  input       logic [0:0] scu_s0_paddr                 ,
  input       logic        scu_s0_psel                  ,
  input       logic        scu_s0_penable               ,
  input       logic        scu_s0_pwrite                ,
  input       logic [0:0] scu_s0_pwdata                ,
  input       logic [ 0:0] scu_s0_pstrb                 ,
  input       logic [0:0] spi_reg_s0_haddr             ,
  input       logic        spi_reg_s0_hsel              ,
  input       logic [ 0:0] spi_reg_s0_htrans            ,
  input       logic [0:0] spi_reg_s0_hwdata            ,
  input       logic        spi_reg_s0_hwrite            ,
  input       logic [0:0] spi_mem_s0_haddr             ,
  input       logic        spi_mem_s0_hsel              ,
  input       logic [ 0:0] spi_mem_s0_htrans            ,
  input       logic        spi_mem_s0_hwrite            ,
  input       logic [0:0] uart_s0_paddr                ,
  input       logic        uart_s0_psel                 ,
  input       logic        uart_s0_penable              ,
  input       logic        uart_s0_pwrite               ,
  input       logic [0:0] uart_s0_pwdata               ,
  input       logic [0:0] uart_s1_paddr                ,
  input       logic        uart_s1_psel                 ,
  input       logic        uart_s1_penable              ,
  input       logic        uart_s1_pwrite               ,
  input       logic [0:0] uart_s1_pwdata               ,
  input       logic [0:0] usb_s0_araddr                ,
  input       logic [ 0:0] usb_s0_arprot                ,
  input       logic        usb_s0_arvalid               ,
  input       logic [0:0] usb_s0_awaddr                ,
  input       logic [ 0:0] usb_s0_awprot                ,
  input       logic        usb_s0_awvalid               ,
  input       logic        usb_s0_bready                ,
  input       logic        usb_s0_rready                ,
  input       logic [0:0] usb_s0_wdata                 ,
  input       logic [ 0:0] usb_s0_wstrb                 ,
  input       logic        usb_s0_wvalid                ,
  input       logic [0:0] bcpu_m0_hrdata               ,
  input       logic        bcpu_m0_hready               ,
  input       logic [ 0:0] bcpu_m0_hresp                ,
  input       logic        dma_m0_arready               ,
  input       logic        dma_m0_awready               ,
  input       logic [ 0:0] dma_m0_bid                   ,
  input       logic [ 0:0] dma_m0_bresp                 ,
  input       logic        dma_m0_bvalid                ,
  input       logic [0:0] dma_m0_rdata                 ,
  input       logic [ 0:0] dma_m0_rid                   ,
  input       logic        dma_m0_rlast                 ,
  input       logic [ 0:0] dma_m0_rresp                 ,
  input       logic        dma_m0_rvalid                ,
  input       logic        dma_m0_wready                ,
  input       logic        dma_m1_arready               ,
  input       logic        dma_m1_awready               ,
  input       logic [ 0:0] dma_m1_bid                   ,
  input       logic [ 0:0] dma_m1_bresp                 ,
  input       logic        dma_m1_bvalid                ,
  input       logic [0:0] dma_m1_rdata                 ,
  input       logic [ 0:0] dma_m1_rid                   ,
  input       logic        dma_m1_rlast                 ,
  input       logic [ 0:0] dma_m1_rresp                 ,
  input       logic        dma_m1_rvalid                ,
  input       logic        dma_m1_wready                ,
  input       logic [0:0] gbe_s0_paddr                 ,
  input       logic        gbe_s0_psel                  ,
  input       logic        gbe_s0_penable               ,
  input       logic        gbe_s0_pwrite                ,
  input       logic [0:0] gbe_s0_pwdata                ,
  input       logic        gbe_m0_arready               ,
  input       logic        gbe_m0_awready               ,
  input       logic [ 0:0] gbe_m0_bid                   ,
  input       logic [ 0:0] gbe_m0_bresp                 ,
  input       logic        gbe_m0_bvalid                ,
  input       logic [0:0] gbe_m0_rdata                 ,
  input       logic [ 0:0] gbe_m0_rid                   ,
  input       logic        gbe_m0_rlast                 ,
  input       logic [ 0:0] gbe_m0_rresp                 ,
  input       logic        gbe_m0_rvalid                ,
  input       logic        gbe_m0_wready                ,
  input       logic        pufcc_m0_ar_ready            ,
  input       logic        pufcc_m0_aw_ready            ,
  input       logic [ 0:0] pufcc_m0_b_resp              ,
  input       logic        pufcc_m0_b_valid             ,
  input       logic [0:0] pufcc_m0_r_data              ,
  input       logic        pufcc_m0_r_last              ,
  input       logic [ 0:0] pufcc_m0_r_resp              ,
  input       logic        pufcc_m0_r_valid             ,
  input       logic        pufcc_m0_w_ready             ,
  input       logic        usb_m0_arready               ,
  input       logic        usb_m0_awready               ,
  input       logic [ 0:0] usb_m0_bid                   ,
  input       logic [ 0:0] usb_m0_bresp                 ,
  input       logic        usb_m0_bvalid                ,
  input       logic [0:0] usb_m0_rdata                 ,
  input       logic [ 0:0] usb_m0_rid                   ,
  input       logic        usb_m0_rlast                 ,
  input       logic [ 0:0] usb_m0_rresp                 ,
  input       logic        usb_m0_rvalid                ,
  input       logic        usb_m0_wready                ,
  input       logic [0:0] fpga_irq_src                 ,
  input       logic        ddr_irq_src                  ,
  input       logic        pit_pause                    ,
  input       logic [ 0:0] dma_req_fpga                 ,
  input       logic        gbe_mdio_in                  ,
  input       logic             usb_xtal_in                  ,
  input       logic        bcpu_jtag_tck                ,
  input       logic        bcpu_jtag_tdi                ,
  input       logic        bcpu_jtag_tms                ,
  output      logic  [31:0] dummy_out
);
      // PAD IOs
//  inout                    RST_N                        ,
//  inout                    XIN                          ,
//  inout                    REF_CLK_1                    ,
//  inout                    REF_CLK_2                    ,
//  inout                    REF_CLK_3                    ,
//  inout                    REF_CLK_4                    ,
//  inout                    TESTMODE                     ,
//  inout                    BOOTM0                       ,
//  inout                    BOOTM1                       ,
//  inout                    BOOTM2                       ,
//  inout                    CLKSEL_0                     ,
//  inout                    CLKSEL_1                     ,
//  inout                    JTAG_TDI                     ,
//  inout                    JTAG_TDO                     ,
//  inout                    JTAG_TMS                     ,
//  inout                    JTAG_TCK                     ,
//  inout                    JTAG_TRSTN                   ,
//  inout                    GPIO_A_0                     ,
//  inout                    GPIO_A_1                     ,
//  inout                    GPIO_A_2                     ,
//  inout                    GPIO_A_3                     ,
//  inout                    GPIO_A_4                     ,
//  inout                    GPIO_A_5                     ,
//  inout                    GPIO_A_6                     ,
//  inout                    GPIO_A_7                     ,
//  inout                    GPIO_A_8                     ,
//  inout                    GPIO_A_9                     ,
//  inout                    GPIO_A_10                    ,
//  inout                    GPIO_A_11                    ,
//  inout                    GPIO_A_12                    ,
//  inout                    GPIO_A_13                    ,
//  inout                    GPIO_A_14                    ,
//  inout                    GPIO_A_15                    ,
//  inout                    GPIO_B_0                     ,
//  inout                    GPIO_B_1                     ,
//  inout                    GPIO_B_2                     ,
//  inout                    GPIO_B_3                     ,
//  inout                    GPIO_B_4                     ,
//  inout                    GPIO_B_5                     ,
//  inout                    GPIO_B_6                     ,
//  inout                    GPIO_B_7                     ,
//  inout                    GPIO_B_8                     ,
//  inout                    GPIO_B_9                     ,
//  inout                    GPIO_B_10                    ,
//  inout                    GPIO_B_11                    ,
//  inout                    GPIO_B_12                    ,
//  inout                    GPIO_B_13                    ,
//  inout                    GPIO_B_14                    ,
//  inout                    GPIO_B_15                    ,
//  inout                    GPIO_C_0                     ,
//  inout                    GPIO_C_1                     ,
//  inout                    GPIO_C_2                     ,
//  inout                    GPIO_C_3                     ,
//  inout                    GPIO_C_4                     ,
//  inout                    GPIO_C_5                     ,
//  inout                    GPIO_C_6                     ,
//  inout                    GPIO_C_7                     ,
//  inout                    GPIO_C_8                     ,
//  inout                    GPIO_C_9                     ,
//  inout                    GPIO_C_10                    ,
//  inout                    GPIO_C_11                    ,
//  inout                    GPIO_C_12                    ,
//  inout                    GPIO_C_13                    ,
//  inout                    GPIO_C_14                    ,
//  inout                    GPIO_C_15                    ,
//  inout                    I2C_SCL                      ,
//  inout                    SPI_SCLK                     ,
//  inout                    GPT_RTC                      ,
//  inout                    MDIO_MDC                     ,
//  inout                    MDIO_DATA                    ,
//  inout                    RGMII_TXD0                   ,
//  inout                    RGMII_TXD1                   ,
//  inout                    RGMII_TXD2                   ,
//  inout                    RGMII_TXD3                   ,
//  inout                    RGMII_TX_CTL                 ,
//  inout                    RGMII_TXC                    ,
//  inout                    RGMII_RXD0                   ,
//  inout                    RGMII_RXD1                   ,
//  inout                    RGMII_RXD2                   ,
//  inout                    RGMII_RXD3                   ,
//  inout                    RGMII_RX_CTL                 ,
//  inout                    RGMII_RXC                    ,
//  inout                    USB_DP                       ,
//  inout                    USB_DN                       ,
//  inout                    USB_XTAL_OUT                 ,
//  inout                    USB_XTAL_IN                  ,
  // PAD logic with core
//  output      logic        testmode                     ,
//  //rsnoc_feedthrough_issue
//  //////////////////////////////////////////////
//  // interface signals soc_fpga_intf
//  //////////////////////////////////////////////
//  output      logic [31:0] soc_fpga_intf_ahb_s0_haddr   ,
//  output      logic [ 2:0] soc_fpga_intf_ahb_s0_hburst  ,
// // output      logic        soc_fpga_intf_ahb_s0_hmastlock,
//  input       logic        soc_fpga_intf_ahb_s0_hready  ,
//  output      logic [ 3:0] soc_fpga_intf_ahb_s0_hprot   ,
//  input       logic [31:0] soc_fpga_intf_ahb_s0_hrdata  ,
//  input       logic        soc_fpga_intf_ahb_s0_hresp   ,
//  output      logic        soc_fpga_intf_ahb_s0_hsel    ,
//  output      logic [ 2:0] soc_fpga_intf_ahb_s0_hsize   ,
//  output      logic [ 1:0] soc_fpga_intf_ahb_s0_htrans  ,
//  output      logic [ 3:0] soc_fpga_intf_ahb_s0_hwbe    ,
//  output      logic [31:0] soc_fpga_intf_ahb_s0_hwdata  ,
//  output      logic        soc_fpga_intf_ahb_s0_hwrite  ,
//  // AXI master 0
//  input       logic [31:0] soc_fpga_intf_axi_m0_ar_addr ,
//  input       logic [ 1:0] soc_fpga_intf_axi_m0_ar_burst,
//  input       logic [ 3:0] soc_fpga_intf_axi_m0_ar_cache,
//  input       logic [ 3:0] soc_fpga_intf_axi_m0_ar_id   ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_ar_len  ,
//  input       logic        soc_fpga_intf_axi_m0_ar_lock ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_ar_prot ,
//  output      logic        soc_fpga_intf_axi_m0_ar_ready,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_ar_size ,
//  input       logic        soc_fpga_intf_axi_m0_ar_valid,
//  input       logic [31:0] soc_fpga_intf_axi_m0_aw_addr ,
//  input       logic [ 1:0] soc_fpga_intf_axi_m0_aw_burst,
//  input       logic [ 3:0] soc_fpga_intf_axi_m0_aw_cache,
//  input       logic [ 3:0] soc_fpga_intf_axi_m0_aw_id   ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_aw_len  ,
//  input       logic        soc_fpga_intf_axi_m0_aw_lock ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_aw_prot ,
//  output      logic        soc_fpga_intf_axi_m0_aw_ready,
//  input       logic [ 2:0] soc_fpga_intf_axi_m0_aw_size ,
//  input       logic        soc_fpga_intf_axi_m0_aw_valid,
//  output      logic [ 3:0] soc_fpga_intf_axi_m0_b_id    ,
//  input       logic        soc_fpga_intf_axi_m0_b_ready ,
//  output      logic [ 1:0] soc_fpga_intf_axi_m0_b_resp  ,
//  output      logic        soc_fpga_intf_axi_m0_b_valid ,
//  output      logic [63:0] soc_fpga_intf_axi_m0_r_data  ,
//  output      logic [ 3:0] soc_fpga_intf_axi_m0_r_id    ,
//  output      logic        soc_fpga_intf_axi_m0_r_last  ,
//  input       logic        soc_fpga_intf_axi_m0_r_ready ,
//  output      logic [ 1:0] soc_fpga_intf_axi_m0_r_resp  ,
//  output      logic        soc_fpga_intf_axi_m0_r_valid ,
//  input       logic [63:0] soc_fpga_intf_axi_m0_w_data  ,
//  input       logic        soc_fpga_intf_axi_m0_w_last  ,
//  output      logic        soc_fpga_intf_axi_m0_w_ready ,
//  input       logic [ 7:0] soc_fpga_intf_axi_m0_w_strb  ,
//  input       logic        soc_fpga_intf_axi_m0_w_valid ,
//  //AXI master 1
//  input       logic [31:0] soc_fpga_intf_axi_m1_ar_addr ,
//  input       logic [ 1:0] soc_fpga_intf_axi_m1_ar_burst,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_ar_cache,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_ar_id   ,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_ar_len  ,
//  input       logic        soc_fpga_intf_axi_m1_ar_lock ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m1_ar_prot ,
//  output      logic        soc_fpga_intf_axi_m1_ar_ready,
//  input       logic [ 2:0] soc_fpga_intf_axi_m1_ar_size ,
//  input       logic        soc_fpga_intf_axi_m1_ar_valid,
//  input       logic [31:0] soc_fpga_intf_axi_m1_aw_addr ,
//  input       logic [ 1:0] soc_fpga_intf_axi_m1_aw_burst,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_aw_cache,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_aw_id   ,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_aw_len  ,
//  input       logic        soc_fpga_intf_axi_m1_aw_lock ,
//  input       logic [ 2:0] soc_fpga_intf_axi_m1_aw_prot ,
//  output      logic        soc_fpga_intf_axi_m1_aw_ready,
//  input       logic [ 2:0] soc_fpga_intf_axi_m1_aw_size ,
//  input       logic        soc_fpga_intf_axi_m1_aw_valid,
//  output      logic [ 3:0] soc_fpga_intf_axi_m1_b_id    ,
//  input       logic        soc_fpga_intf_axi_m1_b_ready ,
//  output      logic [ 1:0] soc_fpga_intf_axi_m1_b_resp  ,
//  output      logic        soc_fpga_intf_axi_m1_b_valid ,
//  output      logic [31:0] soc_fpga_intf_axi_m1_r_data  ,
//  output      logic [ 3:0] soc_fpga_intf_axi_m1_r_id    ,
//  output      logic        soc_fpga_intf_axi_m1_r_last  ,
//  input       logic        soc_fpga_intf_axi_m1_r_ready ,
//  output      logic [ 1:0] soc_fpga_intf_axi_m1_r_resp  ,
//  output      logic        soc_fpga_intf_axi_m1_r_valid ,
//  input       logic [31:0] soc_fpga_intf_axi_m1_w_data  ,
//  input       logic        soc_fpga_intf_axi_m1_w_last  ,
//  output      logic        soc_fpga_intf_axi_m1_w_ready ,
//  input       logic [ 3:0] soc_fpga_intf_axi_m1_w_strb  ,
//  input       logic        soc_fpga_intf_axi_m1_w_valid ,
//  // FCB/PCB APB
//  output      logic [31:0] soc_fpga_intf_fcb_s0_paddr   ,
//  output      logic        soc_fpga_intf_fcb_s0_psel    ,
//  output      logic        soc_fpga_intf_fcb_s0_penable ,
//  output      logic        soc_fpga_intf_fcb_s0_pwrite  ,
//  output      logic [31:0] soc_fpga_intf_fcb_s0_pwdata  ,
//  input       logic [31:0] soc_fpga_intf_fcb_s0_prdata  ,
//  input       logic        soc_fpga_intf_fcb_s0_pready  ,
//  //////////////////////////////////////////////
//  // interface signals FlexNoC
//  //////////////////////////////////////////////
//  //AHB slave
//  input       logic [31:0] flexnoc_ahb_s0_haddr         ,
//  input       logic [ 2:0] flexnoc_ahb_s0_hburst        ,
//  // input       logic        flexnoc_ahb_s0_hmastlock     ,
//  input       logic [ 3:0] flexnoc_ahb_s0_hprot         ,
//  output      logic [31:0] flexnoc_ahb_s0_hrdata        ,
//  output      logic        flexnoc_ahb_s0_hready        ,
//  output      logic        flexnoc_ahb_s0_hresp         ,
//  input       logic        flexnoc_ahb_s0_hsel          ,
//  input       logic [ 2:0] flexnoc_ahb_s0_hsize         ,
//  input       logic [ 1:0] flexnoc_ahb_s0_htrans        ,
//  input       logic [ 3:0] flexnoc_ahb_s0_hwbe          ,
//  input       logic [31:0] flexnoc_ahb_s0_hwdata        ,
//  input       logic        flexnoc_ahb_s0_hwrite        ,
//  // AXI master 0
//  output      logic [31:0] flexnoc_axi_m0_ar_addr       ,
//  output      logic [ 1:0] flexnoc_axi_m0_ar_burst      ,
//  output      logic [ 3:0] flexnoc_axi_m0_ar_cache      ,
//  output      logic [ 3:0] flexnoc_axi_m0_ar_id         ,
//  output      logic [ 2:0] flexnoc_axi_m0_ar_len        ,
//  output      logic        flexnoc_axi_m0_ar_lock       ,
//  output      logic [ 2:0] flexnoc_axi_m0_ar_prot       ,
//  input       logic        flexnoc_axi_m0_ar_ready      ,
//  output      logic [ 2:0] flexnoc_axi_m0_ar_size       ,
//  output      logic        flexnoc_axi_m0_ar_valid      ,
//  output      logic [31:0] flexnoc_axi_m0_aw_addr       ,
//  output      logic [ 1:0] flexnoc_axi_m0_aw_burst      ,
//  output      logic [ 3:0] flexnoc_axi_m0_aw_cache      ,
//  output      logic [ 3:0] flexnoc_axi_m0_aw_id         ,
//  output      logic [ 2:0] flexnoc_axi_m0_aw_len        ,
//  output      logic        flexnoc_axi_m0_aw_lock       ,
//  output      logic [ 2:0] flexnoc_axi_m0_aw_prot       ,
//  input       logic        flexnoc_axi_m0_aw_ready      ,
//  output      logic [ 2:0] flexnoc_axi_m0_aw_size       ,
//  output      logic        flexnoc_axi_m0_aw_valid      ,
//  input       logic [ 3:0] flexnoc_axi_m0_b_id          ,
//  output      logic        flexnoc_axi_m0_b_ready       ,
//  input       logic [ 1:0] flexnoc_axi_m0_b_resp        ,
//  input       logic        flexnoc_axi_m0_b_valid       ,
//  input       logic [63:0] flexnoc_axi_m0_r_data        ,
//  input       logic [ 3:0] flexnoc_axi_m0_r_id          ,
//  input       logic        flexnoc_axi_m0_r_last        ,
//  output      logic        flexnoc_axi_m0_r_ready       ,
//  input       logic [ 1:0] flexnoc_axi_m0_r_resp        ,
//  input       logic        flexnoc_axi_m0_r_valid       ,
//  output      logic [63:0] flexnoc_axi_m0_w_data        ,
//  output      logic        flexnoc_axi_m0_w_last        ,
//  input       logic        flexnoc_axi_m0_w_ready       ,
//  output      logic [ 7:0] flexnoc_axi_m0_w_strb        ,
//  output      logic        flexnoc_axi_m0_w_valid       ,
//  //AXI master 1
//  output      logic [31:0] flexnoc_axi_m1_ar_addr       ,
//  output      logic [ 1:0] flexnoc_axi_m1_ar_burst      ,
//  output      logic [ 3:0] flexnoc_axi_m1_ar_cache      ,
//  output      logic [ 3:0] flexnoc_axi_m1_ar_id         ,
//  output      logic [ 3:0] flexnoc_axi_m1_ar_len        ,
//  output      logic        flexnoc_axi_m1_ar_lock       ,
//  output      logic [ 2:0] flexnoc_axi_m1_ar_prot       ,
//  input       logic        flexnoc_axi_m1_ar_ready      ,
//  output      logic [ 2:0] flexnoc_axi_m1_ar_size       ,
//  output      logic        flexnoc_axi_m1_ar_valid      ,
//  output      logic [31:0] flexnoc_axi_m1_aw_addr       ,
//  output      logic [ 1:0] flexnoc_axi_m1_aw_burst      ,
//  output      logic [ 3:0] flexnoc_axi_m1_aw_cache      ,
//  output      logic [ 3:0] flexnoc_axi_m1_aw_id         ,
//  output      logic [ 3:0] flexnoc_axi_m1_aw_len        ,
//  output      logic        flexnoc_axi_m1_aw_lock       ,
//  output      logic [ 2:0] flexnoc_axi_m1_aw_prot       ,
//  input       logic        flexnoc_axi_m1_aw_ready      ,
//  output      logic [ 2:0] flexnoc_axi_m1_aw_size       ,
//  output      logic        flexnoc_axi_m1_aw_valid      ,
//  input       logic [ 3:0] flexnoc_axi_m1_b_id          ,
//  output      logic        flexnoc_axi_m1_b_ready       ,
//  input       logic [ 1:0] flexnoc_axi_m1_b_resp        ,
//  input       logic        flexnoc_axi_m1_b_valid       ,
//  input       logic [31:0] flexnoc_axi_m1_r_data        ,
//  input       logic [ 3:0] flexnoc_axi_m1_r_id          ,
//  input       logic        flexnoc_axi_m1_r_last        ,
//  output      logic        flexnoc_axi_m1_r_ready       ,
//  input       logic [ 1:0] flexnoc_axi_m1_r_resp        ,
//  input       logic        flexnoc_axi_m1_r_valid       ,
//  output      logic [31:0] flexnoc_axi_m1_w_data        ,
//  output      logic        flexnoc_axi_m1_w_last        ,
//  input       logic        flexnoc_axi_m1_w_ready       ,
//  output      logic [ 3:0] flexnoc_axi_m1_w_strb        ,
//  output      logic        flexnoc_axi_m1_w_valid       ,
//  // FCB/PCB APBf
//  input       logic [31:0] flexnoc_fcb_s0_paddr         ,
//  input       logic        flexnoc_fcb_s0_psel          ,
//  input       logic        flexnoc_fcb_s0_penable       ,
//  input       logic        flexnoc_fcb_s0_pwrite        ,
//  input       logic [31:0] flexnoc_fcb_s0_pwdata        ,
//  output      logic [31:0] flexnoc_fcb_s0_prdata        ,
//  output      logic        flexnoc_fcb_s0_pready        ,
  // PLL ref clocks
//  output      logic        clk_fpga_ref1                ,
//  output      logic        clk_fpga_ref2                ,
//  output      logic        clk_fpga_ref3                ,
//  output      logic        clk_fpga_ref4
//);

// clocks and resets
  logic clk_dma   ;
  logic clk_bcpu_mtime;
  logic clk_gpt   ;
  logic clk_usb   ;
  logic clk_qspi  ;
  logic clk_i2c   ;
  logic clk_uart  ;
  logic clk_gpio  ;
  logic clk_pscc_xtl;
  logic rst_n_usb ;
  logic rst_n_emac;
  logic rst_n_dma ;

  logic [2:0] bootm;

// irq signals
  logic        timer_irq        ;
  logic        usb_irq          ;
  logic        emac_irq         ;
  logic        uart0_irq        ;
  logic        uart1_irq        ;
  logic        qspi_irq         ;
  logic        i2c_irq          ;
  logic        gpio_irq         ;
  logic        dma_irq          ;
  logic        acpu_mailbox_irq ;
  logic        bcpu_mailbox_irq ;
  logic        fpga0_mailbox_irq;
  logic        fpga1_mailbox_irq;
  logic [ 3:0] mbox_irq_bus     ;
  logic [31:0] bcpu_irq_set     ;
  logic        acpu_watchdog_irq;
  logic        bcpu_watchdog_irq;
  logic        pscc_irq         ;
// uart 0 signals
  logic uart0_dcdn ;
  logic uart0_dsrn ;
  logic uart0_rin  ;
  logic uart0_dtrn ;
  logic uart0_out1n;
  logic uart0_out2n;
  logic uart0_ctsn ;
  logic uart0_sin  ;
// uart 1 signals
  logic uart1_dcdn ;
  logic uart1_dsrn ;
  logic uart1_rin  ;
  logic uart1_dtrn ;
  logic uart1_out1n;
  logic uart1_out2n;
  logic uart1_ctsn ;
  logic uart1_sin  ;
// APB s0 read signals
  logic s0_sel_d        ;
  logic s0_wval         ;
  logic s0_rval         ;
  logic s0_set_apb_ready;
  logic s0_apb_ready_r  ;

  logic [31:0] s0_prdata_scu      ;
  logic        s0_pready_scu      ;
  logic        s0_pslverr_scu     ;
  logic [31:0] s0_prdata_acpu_wdt ;
  logic        s0_pready_acpu_wdt ;
  logic        s0_pslverr_acpu_wdt;
  logic [31:0] s0_prdata_bcpu_wdt ;
  logic        s0_pready_bcpu_wdt ;
  logic        s0_pslverr_bcpu_wdt;

  logic        s0_pslverr_mux  ;
  logic [31:0] s0_prdata_mux   ;
  logic        s0_pready_mux   ;
  logic        s0_pslverr_mux_d;
  logic [31:0] s0_prdata_mux_d ;
  logic        s0_pready_mux_d ;
// APB s1 read signals
  logic s1_sel_d        ;
  logic s1_wval         ;
  logic s1_rval         ;
  logic s1_set_apb_ready;
  logic s1_apb_ready_r  ;

  logic [31:0] s1_prdata_uart0 ;
  logic        s1_pready_uart0 ;
  logic        s1_pslverr_uart0;
  logic [31:0] s1_prdata_uart1 ;
  logic        s1_pready_uart1 ;
  logic        s1_pslverr_uart1;
  logic [31:0] s1_prdata_i2c   ;
  logic        s1_pready_i2c   ;
  logic        s1_pslverr_i2c  ;
  logic [31:0] s1_prdata_qspi  ;
  logic        s1_pready_qspi  ;
  logic        s1_pslverr_qspi ;
  logic [31:0] s1_prdata_gpio  ;
  logic        s1_pready_gpio  ;
  logic        s1_pslverr_gpio ;
  logic [31:0] s1_prdata_gpt   ;
  logic        s1_pready_gpt   ;
  logic        s1_pslverr_gpt  ;

  logic        s1_pslverr_mux  ;
  logic [31:0] s1_prdata_mux   ;
  logic        s1_pready_mux   ;
  logic        s1_pslverr_mux_d;
  logic [31:0] s1_prdata_mux_d ;
  logic        s1_pready_mux_d ;
// WDT signals
  logic acpu_wdt_pause           ;
  logic bcpu_wdt_pause           ;
  logic acpu_wathcdog_timer_reset;
  logic bcpu_wathcdog_timer_reset;
// DMA signals
// dma_ack
//  [10:7] - fpga ack
//  [6] - spi tx ack
//  [5] - spi rx ack
//  [4] - i2c ack
//  [3] - uart1 tx ack
//  [2] - uart1 rx ack
//  [1] - uart0 tx ack
//  [0] - uart0 rx ack
  logic [10:0] dma_ack;
// dma_req
//  [10:7] - fpga req
//  [6] - spi tx req
//  [5] - spi rx req
//  [4] - i2c req
//  [3] - uart1 tx req
//  [2] - uart1 rx req
//  [1] - uart0 tx req
//  [0] - uart0 rx req
  logic [10:0] dma_req;

// pad ctrl signals
logic [31:0]   pad_c             ;
logic [31:0]   pad_i             ;
logic [31:0]   pad_oen           ;
logic [31:0]   pad_ds0           ;
logic [31:0]   pad_ds1           ;
logic [31:0]   pad_pull_en       ;
logic [31:0]   pad_pull_dir      ;
logic [31:0]   pad_inp_mux [1:0] ;
logic [31:0]   pad_dir_mux [1:0] ;
logic [31:0]   pad_out_mux [1:0] ;

logic [31:0]   gpio_oe           ;
logic [31:0]   gpio_out          ;
logic [31:0]   gpio_in           ;
logic          uart0_sout        ;
logic          uart1_sout        ;
logic          spi_cs_n_out      ;
logic          spi_cs_n_oe       ;
logic          spi_mosi_out      ;
logic          spi_mosi_oe       ;
logic          spi_miso_out      ;
logic          spi_miso_oe       ;
logic          spi_wp_n_out      ;
logic          spi_wp_n_oe       ;
logic          spi_hold_n_out    ;
logic          spi_hold_n_oe     ;
logic          spi_cs_n_in       ;
logic          spi_mosi_in       ;
logic          spi_miso_in       ;
logic          spi_wp_n_in       ;
logic          spi_hold_n_in     ;
logic          sda_i             ;
logic          spi_s0_pslverr    ;
logic          sda_o             ;
logic          uart0_rtsn        ;
logic          uart1_rtsn        ;
logic          ch3_pwm           ;
logic          ch2_pwm           ;
logic          ch1_pwm           ;
logic          ch0_pwm           ;
logic          ch3_pwmoe         ;
logic          ch2_pwmoe         ;
logic          ch1_pwmoe         ;
logic          ch0_pwmoe         ;

logic          usb_s0_rlast      ;

logic          rgmii_rxc_n       ;
logic          rst_n_gbe_tx      ;
logic          rst_n_gbe_ntx     ;
logic          rst_n_gbe_rx      ;
logic          rst_n_gbe_nrx     ;

logic          rng_fre_en        ;
logic          rng_fre_sel       ;
logic          rng_fre_out       ;

  localparam REV_ID    = 8'h00   ; //TBD
  localparam CHIP_ID   = 8'h00   ; //TBD
  localparam VENDOR_ID = 16'h0000; //TBD

logic clk_usb_wakeup;
logic usb_wakeup;
logic usb_utmidrvvbus;
logic usb_utmi_suspendm;
logic usb_utmi_sleepm;
logic usb_vbusfault;
logic [1:0] usb_tsmode;
logic usb_tmodecustom;
logic [7:0] usb_tmodeselcustom;
logic usb_wuintreq;
logic usbintreq;
logic usb_pll_bypass;
logic usb_phy_biston;
logic [3:0] usb_phy_bistmodesel;
logic usb_phy_bistmodeen;
logic usb_phy_bistcomplete;
logic usb_phy_bisterror;
logic [7:0] usb_phy_bisterrorcount;
wire    [1:0] 			clksel;
wire	[3:0]			rgmii_txd;
wire	[3:0]			rgmii_rxd;
wire	[15:0]			gpio_b_in;
wire	[15:0]			gpio_b_out;
wire	[15:0]			gpio_b_oe;
wire	[15:0]			gpio_c_in;
wire	[15:0]			gpio_c_out;
wire	[15:0]			gpio_c_oe;
// SoC PLL ref clock
logic        clk_pll_soc_ref            ;
// SoC pll's clocks
logic        clk_soc_pll0               ;
logic        clk_soc_pll1               ;
logic        xin                        ;
logic        por                        ;
logic        rgmii_rxc                  ;
logic        i2c_scl                    ;
logic        spi_clk                    ;
logic        rtc_clk                    ;
logic        rgmii_tx_ctl               ;
logic        rgmii_rx_ctl               ;
logic        VDD                        ;   
logic        VDD2                       ;    
logic        VSS                        ;
logic        jtag_tdi                   ; 
logic        jtag_tms                   ; 
logic        jtag_tck                   ;
logic        jtag_trstn                 ;      
logic        mdio_data                  ;      
// SoC PLL control signals
logic        soc_pll_ctl_dacen          ;
logic        soc_pll_ctl_dskewcalbyp    ;
logic [ 2:0] soc_pll_ctl_dskewcalcnt    ;
logic        soc_pll_ctl_dskewcalen     ;
logic [11:0] soc_pll_ctl_dskewcalin     ;
logic        soc_pll_ctl_dskewfastcal   ;
logic        soc_pll_ctl_dsmen          ;
logic        soc_pll_ctl_pllen          ;
logic [ 3:0] soc_pll_ctl_fouten         ;
logic [ 4:0] soc_pll_ctl_foutvcobyp     ;
logic        soc_pll_ctl_foutvcoen      ;
logic [ 5:0] soc_pll_ctl_refdiv         ;
logic [23:0] soc_pll_ctl_frac           ;
logic [ 3:0] soc_pll_ctl_postdiv0       ;
logic [ 3:0] soc_pll_ctl_postdiv1       ;
logic [11:0] soc_pll_ctl_fbdiv          ;
logic        soc_pll_ctl_dacen_ff       ;
logic        soc_pll_ctl_dskewcalbyp_ff ;
logic [ 2:0] soc_pll_ctl_dskewcalcnt_ff ;
logic        soc_pll_ctl_dskewcalen_ff  ;
logic [11:0] soc_pll_ctl_dskewcalin_ff  ;
logic        soc_pll_ctl_dskewfastcal_ff;
logic        soc_pll_ctl_dsmen_ff       ;
logic [ 3:0] soc_pll_ctl_fouten_ff      ;
logic [ 4:0] soc_pll_ctl_foutvcobyp_ff  ;
logic        soc_pll_ctl_foutvcoen_ff   ;
logic [ 5:0] soc_pll_ctl_refdiv_ff      ;
logic [23:0] soc_pll_ctl_frac_ff        ;
logic [11:0] soc_pll_ctl_fbdiv_ff       ;
logic [ 3:0] soc_pll_ctl_postdiv0_ff    ;
// SoC PLL status signals
logic [11:0] soc_pll_status_dskewcalout ;
logic        soc_pll_status_dskewcallock;
logic        soc_pll_status_lock        ;
//              System Control Unit declaration
//*****************************************************************************
  soc_scu scu (
    .clk_sel0                   ('d0                  ),
    .clk_sel1                   ('d0                ),
    .clk_osc                    (clk_osc                    ),
    .clk_xtal_ref               (clk_out4_proto             ),
    .clk_pll_soc_ref            (clk_pll_soc_ref            ),
    .rst_n_poweron              (por /*rst_n_poweron*/      ),
    .clk0                       (clk_out1_proto       ),
    .clk1                       (clk_out2_proto       ),
    .clk_fpga0                  (clk_fpga0                  ),
    .clk_fpga1                  (clk_fpga1                  ),
    .clk_fpga_s                 (clk_fpga_s                 ),
    .clk_gbe_rx                 (rgmii_rxc                  ),
    .clk_gbe_rx_n               (rgmii_rxc_n                ),
    .clk_acpu                   (clk_acpu                   ),
    .clk_acpu_mtime             (clk_acpu_mtime             ),
    .clk_dma                    (clk_dma                    ),
    .clk_bcpu                   (clk_bcpu                   ),
    .clk_bcpu_mtime             (clk_bcpu_mtime             ),
    .clk_qspi                   (clk_qspi                   ),
    .clk_i2c                    (clk_i2c                    ),
    .clk_uart                   (clk_uart                   ),
    .clk_gpio                   (clk_gpio                   ),
    .clk_gpt                    (clk_gpt                    ),
    .clk_usb                    (clk_usb                    ),
    .clk_cru                    (clk_apb_ug                 ),
    .clk_ddr_phy                (clk_ddr_phy                ),
    .clk_ddr_ctl                (clk_ddr_ctl                ),
    .clk_ddr_cfg                (clk_ddr_cfg                ),
    .clk_pscc_xtl               (clk_pscc_xtl               ),
    .clk_usb_wakeup             (clk_usb_wakeup             ),
    .rst_n_bcpu                 (rst_n_bcpu                 ),
    .rst_n_bcpu_bus             (rst_n_bcpu_bus             ),
    .rst_n_sram                 (rst_n_sram                 ),
    .rst_n_acpu                 (rst_n_acpu                 ),
    .rst_n_acpu_bus             (rst_n_acpu_bus             ),
    .rst_n_per                  (rst_n_per                  ),
    .rst_n_fpga0                (rst_n_fpga0                ),
    .rst_n_fpga1                (rst_n_fpga1                ),
    .rst_n_fpga_s               (rst_n_fpga_s               ),
    .rst_n_ddr                  (rst_n_ddr                  ),
    .rst_n_usb                  (rst_n_usb                  ),
    .rst_n_emac                 (rst_n_emac                 ),
    .rst_n_dma                  (rst_n_dma                  ),
    .rst_n_133                  (rst_n_133                  ),
    .rst_n_266                  (rst_n_266                  ),
    .rst_n_533                  (rst_n_533                  ),
    .rst_n_gbe_tx               (rst_n_gbe_tx               ),
    .rst_n_gbe_ntx              (rst_n_gbe_ntx              ),
    .rst_n_gbe_rx               (rst_n_gbe_rx               ),
    .rst_n_gbe_nrx              (rst_n_gbe_nrx              ),
    .apb_addr                   (scu_s0_paddr[15:0]         ),
    .apb_sel                    (scu_s0_psel                ),
    .apb_en                     (scu_s0_penable             ),
    .apb_wr                     (scu_s0_pwrite              ),
    .apb_wdata                  (scu_s0_pwdata              ),
    .apb_strb                   (scu_s0_pstrb               ),
    .apb_rdata                  (scu_s0_prdata              ),
    .apb_ready                  (scu_s0_pready              ),
    .apb_err                    (scu_s0_pslverr             ),
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
    .soc_pll_ctl_fbdiv          (soc_pll_ctl_fbdiv          ),
    .soc_pll_status_dskewcalout (soc_pll_status_dskewcalout ),
    .soc_pll_status_dskewcallock(soc_pll_status_dskewcallock),
    .soc_pll_status_lock        (soc_pll_status_lock        ),
    .jtag_control               (jtag_control               ),
    .acpu_watchdog_irq          (acpu_watchdog_irq          ),
    .bcpu_watchdog_irq          (bcpu_watchdog_irq          ),
    .timer_irq                  (timer_irq                  ),
    .usb_irq                    (usb_irq                    ),
    .emac_irq                   (emac_irq                   ),
    .uart0_irq                  (uart0_irq                  ),
    .uart1_irq                  (uart1_irq                  ),
    .qspi_irq                   (qspi_irq                   ),
    .i2c_irq                    (i2c_irq                    ),
    .gpio_irq                   (gpio_irq                   ),
    .dma_irq                    (dma_irq                    ),
    .ddr_irq                    (ddr_irq_src                ),
    .acpu_mailbox_irq           (acpu_mailbox_irq           ),
    .bcpu_mailbox_irq           (bcpu_mailbox_irq           ),
    .fpga0_mailbox_irq          (fpga0_mailbox_irq          ),
    .fpga1_mailbox_irq          (fpga1_mailbox_irq          ),
    .pscc_irq                   (pscc_irq                   ),
    .fpga_irq_src               (fpga_irq_src               ),
    .acpu_irq_set               (acpu_irq_set               ),
    .bcpu_irq_set               (bcpu_irq_set               ),
    .fpga_irq_set               (fpga_irq_set               ),
    .ace_isolation_ctl          (ace_isolation_ctl          ),
    .irq_isolation_ctl          (irq_isolation_ctl          ),
    .fcb_isolation_ctl          (fcb_isolation_ctl          ),
    .ahb_isolation_ctl          (ahb_isolation_ctl          ),
    .axi1_isolation_ctl         (axi1_isolation_ctl         ),
    .axi0_isolation_ctl         (axi0_isolation_ctl         ),
    .bcpu_wathcdog_timer_reset  (bcpu_wathcdog_timer_reset  ),
    .acpu_wathcdog_timer_reset  (acpu_wathcdog_timer_reset  ),
    .pad_c                      (pad_c                      ),
    .pad_i                      (pad_i                      ),
    .pad_oen                    (pad_oen                    ),
    .pad_ds0                    (pad_ds0                    ),
    .pad_ds1                    (pad_ds1                    ),
    .pad_pull_en                (pad_pull_en                ),
    .pad_pull_dir               (pad_pull_dir               ),
    .pad_inp_mux                (pad_inp_mux                ),
    .pad_dir_mux                (pad_dir_mux                ),
    .pad_out_mux                (pad_out_mux                ),
    .pufcc_rng_fre_en           (rng_fre_en                 ),
    .pufcc_rng_fre_sel          (rng_fre_sel                ),
    .pufcc_rng_fre_out          (rng_fre_out                ),
    .rev_id                     (REV_ID                     ),
    .chip_id                    (CHIP_ID                    ),
    .vendor_id                  (VENDOR_ID                  ),
    .usb_wakeup                 (usb_wakeup                 ),
    .usb_vbusfault              (usb_vbusfault              ),
    .usb_tsmode                 (usb_tsmode                 ),
    .usb_tmodecustom            (usb_tmodecustom            ),
    .usb_tmodeselcustom         (usb_tmodeselcustom         ),
    .usb_pll_bypass             (usb_pll_bypass             ),
    .usb_phy_biston             (usb_phy_biston             ),
    .usb_phy_bistmodesel        (usb_phy_bistmodesel        ),
    .usb_phy_bistmodeen         (usb_phy_bistmodeen         ),
    .usb_phy_bistcomplete       (usb_phy_bistcomplete       ),
    .usb_phy_bisterror          (usb_phy_bisterror          ),
    .usb_phy_bisterrorcount     (usb_phy_bisterrorcount     ),
    .bootm                      (bootm                      ),
    .fpga_pll3_clk_sel          (fpga_pll3_clk_sel          ),
    .fpga_pll2_clk_sel          (fpga_pll2_clk_sel          ),
    .fpga_pll1_clk_sel          (fpga_pll1_clk_sel          ),
    .fpga_pll0_clk_sel          (fpga_pll0_clk_sel          ),
    .acpu_wdt_pause             (acpu_wdt_pause             ),
    .bcpu_wdt_pause             (bcpu_wdt_pause             )
  );

//*****************************************************************************
//             PADs muxing
//*****************************************************************************

assign                 pad_inp_mux[0] = gpio_out          ;
assign                 pad_dir_mux[0] = gpio_oe           ;
assign gpio_in       = pad_out_mux[0]                     ;

//UART0_TX
assign                 pad_inp_mux[1][0] = uart0_sout     ;
assign                 pad_dir_mux[1][0] = 1'b1           ;

//UART0_RX
assign                 pad_inp_mux[1][1] = 1'b0           ;
assign                 pad_dir_mux[1][1] = 1'b0           ;
assign uart0_sin     = pad_out_mux[1][1]                  ;

//UART1_TX
assign                 pad_inp_mux[1][2] = uart1_sout     ;
assign                 pad_dir_mux[1][2] = 1'b1           ;

//UART1_RX
assign                 pad_inp_mux[1][3] = 1'b0           ;
assign                 pad_dir_mux[1][3] = 1'b0           ;
assign uart1_sin     = pad_out_mux[1][3]                  ;

//SPI_CS
assign                 pad_inp_mux[1][4] = spi_cs_n_out   ;
assign                 pad_dir_mux[1][4] = spi_cs_n_oe    ;
assign spi_cs_n_in   = pad_out_mux[1][4]                  ;

//empty
assign                 pad_inp_mux[1][5] = 1'b0           ;
assign                 pad_dir_mux[1][5] = 1'b0           ;

// SPI_MOSI (DQ0)
assign                 pad_inp_mux[1][6] = spi_mosi_out   ;
assign                 pad_dir_mux[1][6] = spi_mosi_oe    ;
assign spi_mosi_in   = pad_out_mux[1][6]                  ;

// SPI_MISO (DQ1)
assign                 pad_inp_mux[1][7] = spi_miso_out   ;
assign                 pad_dir_mux[1][7] = spi_miso_oe    ;
assign spi_miso_in   = pad_out_mux[1][7]                  ;

// SPI_DQ2
assign                 pad_inp_mux[1][8] = spi_wp_n_out   ;
assign                 pad_dir_mux[1][8] = spi_wp_n_oe    ;
assign spi_wp_n_in   = pad_out_mux[1][8]                  ;

// SPI_DQ3
assign                 pad_inp_mux[1][9] = spi_hold_n_out ;
assign                 pad_dir_mux[1][9] = spi_hold_n_oe  ;
assign spi_hold_n_in = pad_out_mux[1][9]                  ;

// empty
assign                 pad_inp_mux[1][10] = 1'b0         ;
assign                 pad_dir_mux[1][10] = 1'b0         ;

// I2C_SDA
assign                 pad_inp_mux[1][11] =  sda_o       ;
assign                 pad_dir_mux[1][11] = ~sda_o       ;
assign sda_i         = pad_out_mux[1][11]                ;

// UART0_CTS
assign                 pad_inp_mux[1][12] = 1'b0         ;
assign                 pad_dir_mux[1][12] = 1'b0         ;
assign uart0_ctsn    = pad_out_mux[1][12]                ;

// UART0_RTS
assign                 pad_inp_mux[1][13] = uart0_rtsn   ;
assign                 pad_dir_mux[1][13] = 1'b1         ;

// UART1_CTS
assign                 pad_inp_mux[1][14] = 1'b0         ;
assign                 pad_dir_mux[1][14] = 1'b0         ;
assign uart1_ctsn    = pad_out_mux[1][14]                ;

// UART1_RTS
assign                 pad_inp_mux[1][15] = uart1_rtsn   ;
assign                 pad_dir_mux[1][15] = 1'b1         ;

// gpt_event
assign                 pad_inp_mux[1][19:16] =  4'b0     ;
assign                 pad_dir_mux[1][19:16] =  4'b0     ;
//assign               = pad_out_mux[1][19:16]           ;

// gpt_pwm_[3:0]
assign                 pad_inp_mux[1][23:20] = {ch3_pwm,   ch2_pwm,   ch1_pwm,   ch0_pwm  } ;
assign                 pad_dir_mux[1][23:20] = {ch3_pwmoe, ch2_pwmoe, ch1_pwmoe, ch0_pwmoe} ;

//empty
assign                 pad_inp_mux[1][31:24] = 8'b0 ;
assign                 pad_dir_mux[1][31:24] = 8'b0 ;


//*****************************************************************************
//             UART0 declaration
//*****************************************************************************
  assign uart_s0_pready  = uart_s0_psel & uart_s0_penable;
  assign uart_s0_pslverr = 1'b0;

  assign uart0_dcdn = 1'b1;
  assign uart0_dsrn = 1'b1;
  assign uart0_rin  = 1'b1;

  atcuart100 uart0 (
    .uclk      (clk_uart          ),
    .urstn     (rst_n_per         ),
    .dma_rx_ack(dma_ack[0]        ),
    .dma_tx_ack(dma_ack[1]        ),
    .paddr     (uart_s0_paddr[5:2]),
    .pclk      (clk_uart          ),
    .penable   (uart_s0_penable   ),
    .presetn   (rst_n_per         ),
    .psel      (uart_s0_psel      ),
    .pwdata    (uart_s0_pwdata    ),
    .pwrite    (uart_s0_pwrite    ),
    .uart_ctsn (uart0_ctsn        ),
    .uart_dcdn (uart0_dcdn        ),
    .uart_dsrn (uart0_dsrn        ),
    .uart_rin  (uart0_rin         ),
    .uart_sin  (uart0_sin_proto         ),
    .dma_rx_req(dma_req[0]        ),
    .dma_tx_req(dma_req[1]        ),
    .prdata    (uart_s0_prdata    ),
    .uart_dtrn (uart0_dtrn        ),
    .uart_intr (uart0_irq         ),
    .uart_out1n(uart0_out1n       ),
    .uart_out2n(uart0_out2n       ),
    .uart_rtsn (uart0_rtsn        ),
    .uart_sout (uart0_sout_proto        )
  );

//*****************************************************************************
//             UART1 declaration
//*****************************************************************************
  assign uart_s1_pready  = uart_s1_psel & uart_s1_penable;
  assign uart_s1_pslverr = 1'b0;

  assign uart1_dcdn = 1'b1;
  assign uart1_dsrn = 1'b1;
  assign uart1_rin  = 1'b1;

  atcuart100 uart1 (
    .uclk      (clk_uart          ),
    .urstn     (rst_n_per         ),
    .dma_rx_ack(dma_ack[2]        ),
    .dma_tx_ack(dma_ack[3]        ),
    .paddr     (uart_s1_paddr[5:2]),
    .pclk      (clk_uart          ),
    .penable   (uart_s1_penable   ),
    .presetn   (rst_n_per         ),
    .psel      (uart_s1_psel      ),
    .pwdata    (uart_s1_pwdata    ),
    .pwrite    (uart_s1_pwrite    ),
    .uart_ctsn (uart1_ctsn        ),
    .uart_dcdn (uart1_dcdn        ),
    .uart_dsrn (uart1_dsrn        ),
    .uart_rin  (uart1_rin         ),
    .uart_sin  (uart1_sin         ),
    .dma_rx_req(dma_req[2]        ),
    .dma_tx_req(dma_req[3]        ),
    .prdata    (uart_s1_prdata    ),
    .uart_dtrn (uart1_dtrn        ),
    .uart_intr (uart1_irq         ),
    .uart_out1n(uart1_out1n       ),
    .uart_out2n(uart1_out2n       ),
    .uart_rtsn (uart1_rtsn        ),
    .uart_sout (uart1_sout        )
  );
//*****************************************************************************
//             I2C declaration
//*****************************************************************************
  assign i2c_s0_pready  = i2c_s0_psel & i2c_s0_penable;
  assign i2c_s0_pslverr = 1'b0;

  atciic100 i2c_u (
    .i2c_int(i2c_irq          ),
    .paddr  (i2c_s0_paddr[5:2]),
    .penable(i2c_s0_penable   ),
    .prdata (i2c_s0_prdata    ),
    .psel   (i2c_s0_psel      ),
    .pwdata (i2c_s0_pwdata    ),
    .pwrite (i2c_s0_pwrite    ),
    .pclk   (clk_i2c          ),
    .presetn(rst_n_per        ),
    .dma_ack(dma_ack[4]       ),
    .dma_req(dma_req[4]       ),
    .scl_o  (scl_o            ),
    .sda_o  (sda_o            ),
    .scl_i  (i2c_scl          ),
    .sda_i  (sda_i            )
  );

//*****************************************************************************
//             MAILBOX/SEMAPHORE declaration
//*****************************************************************************

soc_mbox soc_mbox_u (
  .pclk   ( clk_apb_ug         ),
  .presetn( rst_n_per          ),
  .paddr  ( mbox_s0_paddr[7:0] ),
  .psel   ( mbox_s0_psel       ),
  .penable( mbox_s0_penable    ),
  .pwrite ( mbox_s0_pwrite     ),
  .pwdata ( mbox_s0_pwdata     ),
  .pstrb  ( mbox_s0_pstrb      ),
  .prdata ( mbox_s0_prdata     ),
  .pready ( mbox_s0_pready     ),
  .pslverr( mbox_s0_pslverr    ),
  .irq_o  ( mbox_irq_bus       )
);

assign {acpu_mailbox_irq, bcpu_mailbox_irq, fpga0_mailbox_irq, fpga1_mailbox_irq} = mbox_irq_bus;

//*****************************************************************************
//             SPI declaration
//*****************************************************************************
  assign spi_s0_pslverr = 1'b0;
logic [1:0]spi_mem_s0_hresp_int;
logic [1:0]spi_reg_s0_hresp_int;

assign spi_mem_s0_hresp = spi_mem_s0_hresp_int[0];
assign spi_reg_s0_hresp = spi_reg_s0_hresp_int[0];

  atcspi200 qspi (
    .hclk                (clk_qspi            ),
    .hresetn             (rst_n_per           ),
    .haddr_mem           (spi_mem_s0_haddr    ),
    .hrdata_mem          (spi_mem_s0_hrdata   ),
    .hreadyin_mem        (spi_mem_s0_hready   ),
    .hreadyout_mem       (spi_mem_s0_hready   ),
    .hresp_mem           (spi_mem_s0_hresp_int),
    .hsel_mem            (spi_mem_s0_hsel     ),
    .htrans_mem          (spi_mem_s0_htrans   ),
    .hwrite_mem          (spi_mem_s0_hwrite   ),
    .haddr_reg           (spi_reg_s0_haddr    ),
    .hrdata_reg          (spi_reg_s0_hrdata   ),
    .hreadyin_reg        (spi_reg_s0_hready   ),
    .hreadyout_reg       (spi_reg_s0_hready   ),
    .hresp_reg           (spi_reg_s0_hresp_int),
    .hsel_reg            (spi_reg_s0_hsel     ),
    .htrans_reg          (spi_reg_s0_htrans   ),
    .hwdata_reg          (spi_reg_s0_hwdata   ),
    .hwrite_reg          (spi_reg_s0_hwrite   ),
    .spi_default_as_slave(1'b1                ),
    .spi_hold_n_in       (spi_hold_n_in       ),
    .spi_hold_n_oe       (spi_hold_n_oe       ),
    .spi_hold_n_out      (spi_hold_n_out      ),
    .spi_wp_n_in         (spi_wp_n_in         ),
    .spi_wp_n_oe         (spi_wp_n_oe         ),
    .spi_wp_n_out        (spi_wp_n_out        ),
    .spi_clock           (clk_qspi            ),
    .spi_rstn            (rst_n_per           ),
    .spi_boot_intr       (qspi_irq            ),
    .spi_default_mode3   (1'b1                ),
    .spi_rx_dma_ack      (dma_ack[5]          ),
    .spi_rx_dma_req      (dma_req[5]          ),
    .spi_tx_dma_ack      (dma_ack[6]          ),
    .spi_tx_dma_req      (dma_req[6]          ),
    .scan_enable         (1'b0                ),
    .scan_test           (1'b0                ),
    .spi_clk_in          (spi_clk             ),
    .spi_clk_oe          (spi_clk_oe          ),
    .spi_clk_out         (spi_clk_out         ),
    .spi_cs_n_in         (spi_cs_n_in         ),
    .spi_cs_n_oe         (spi_cs_n_oe         ),
    .spi_cs_n_out        (spi_cs_n_out        ),
    .spi_miso_in         (spi_miso_in         ),
    .spi_miso_oe         (spi_miso_oe         ),
    .spi_miso_out        (spi_miso_out        ),
    .spi_mosi_in         (spi_mosi_in         ),
    .spi_mosi_oe         (spi_mosi_oe         ),
    .spi_mosi_out        (spi_mosi_out        )
  );

//*****************************************************************************
//             GPIO declaration
//*****************************************************************************
  assign gpio_s0_pready  = gpio_s0_psel & gpio_s0_penable;
  assign gpio_s0_pslverr = 1'b0;

  atcgpio100 gpio (
    .gpio_pulldown(gpio_pulldown     ),
    .gpio_pullup  (gpio_pullup       ),
    .gpio_intr    (gpio_irq          ),
    .gpio_oe      (gpio_oe           ),
    .gpio_out     (gpio_out          ),
    .paddr        (gpio_s0_paddr[7:0]),
    .penable      (gpio_s0_penable   ),
    .prdata       (gpio_s0_prdata    ),
    .psel         (gpio_s0_psel      ),
    .pwdata       (gpio_s0_pwdata    ),
    .pwrite       (gpio_s0_pwrite    ),
    .pclk         (clk_gpio          ),
    .presetn      (rst_n_per         ),
    .extclk       (1'b0              ),
    .gpio_in      (gpio_in           )
  );

//*****************************************************************************
//             GPT declaration
//*****************************************************************************

  assign gpt_s0_pready  = gpt_s0_psel & gpt_s0_penable;
  assign gpt_s0_pslverr = 1'b0;


  atcpit100 gpt (
    .ch0_pwm  (ch0_pwm          ),
    .ch0_pwmoe(ch0_pwmoe        ),
    .ch1_pwm  (ch1_pwm          ),
    .ch1_pwmoe(ch1_pwmoe        ),
    .ch2_pwm  (ch2_pwm          ),
    .ch2_pwmoe(ch2_pwmoe        ),
    .ch3_pwm  (ch3_pwm          ),
    .ch3_pwmoe(ch3_pwmoe        ),
    .extclk   (rtc_clk          ),
    .paddr    (gpt_s0_paddr[6:2]),
    .pclk     (clk_gpt          ),
    .penable  (gpt_s0_penable   ),
    .pit_pause(pit_pause        ),
    .presetn  (rst_n_per        ),
    .psel     (gpt_s0_psel      ),
    .pwdata   (gpt_s0_pwdata    ),
    .pwrite   (gpt_s0_pwrite    ),
    .pit_intr (timer_irq        ),
    .prdata   (gpt_s0_prdata    )
  );


//*****************************************************************************
//             ACPU WDT declaration
//*****************************************************************************
assign acpu_wdt_s0_pready = acpu_wdt_s0_psel & acpu_wdt_s0_penable;
assign acpu_wdt_s0_pslverr = 1'b0;

  atcwdt200 acpu_wdt (
    .extclk   (1'b0                     ),
    .wdt_pause(acpu_wdt_pause           ),
    .wdt_rst  (acpu_wathcdog_timer_reset),
    .wdt_int  (acpu_watchdog_irq        ),
    .pclk     (clk_apb_ug               ),
    .presetn  (rst_n_acpu               ),
    .psel     (acpu_wdt_s0_psel         ),
    .penable  (acpu_wdt_s0_penable      ),
    .paddr    (acpu_wdt_s0_paddr[4:2]   ),
    .pwrite   (acpu_wdt_s0_pwrite       ),
    .pwdata   (acpu_wdt_s0_pwdata       ),
    .prdata   (acpu_wdt_s0_prdata       )
  );

//*****************************************************************************
//             BCPU WDT declaration
//*****************************************************************************
assign bcpu_wdt_s0_pready = bcpu_wdt_s0_psel & bcpu_wdt_s0_penable;
assign bcpu_wdt_s0_pslverr = 1'b0;

  atcwdt200 bcpu_wdt (
    .extclk   (1'b0                     ),
    .wdt_pause(bcpu_wdt_pause           ),
    .wdt_rst  (bcpu_wathcdog_timer_reset),
    .wdt_int  (bcpu_watchdog_irq        ),
    .pclk     (clk_apb_ug               ),
    .presetn  (rst_n_bcpu               ),
    .psel     (bcpu_wdt_s0_psel         ),
    .penable  (bcpu_wdt_s0_penable      ),
    .paddr    (bcpu_wdt_s0_paddr[4:2]   ),
    .pwrite   (bcpu_wdt_s0_pwrite       ),
    .pwdata   (bcpu_wdt_s0_pwdata       ),
    .prdata   (bcpu_wdt_s0_prdata       )
  );

//*****************************************************************************
//             DMA declaration
//*****************************************************************************
  assign dma_ack_fpga  = dma_ack[10:7];
  assign dma_req[10:7] = dma_req_fpga;
  atcdmac300 dma (
    .aclk      (clk_dma       ),
    .aresetn   (rst_n_dma     ),
    .m0_araddr (dma_m0_araddr ),
    .m0_arburst(dma_m0_arburst),
    .m0_arcache(dma_m0_arcache),
    .m0_arid   (dma_m0_arid   ),
    .m0_arlen  (dma_m0_arlen  ),
    .m0_arlock (dma_m0_arlock ),
    .m0_arprot (dma_m0_arprot ),
    .m0_arready(dma_m0_arready),
    .m0_arsize (dma_m0_arsize ),
    .m0_arvalid(dma_m0_arvalid),
    .m0_awaddr (dma_m0_awaddr ),
    .m0_awburst(dma_m0_awburst),
    .m0_awcache(dma_m0_awcache),
    .m0_awid   (dma_m0_awid   ),
    .m0_awlen  (dma_m0_awlen  ),
    .m0_awlock (dma_m0_awlock ),
    .m0_awprot (dma_m0_awprot ),
    .m0_awready(dma_m0_awready),
    .m0_awsize (dma_m0_awsize ),
    .m0_awvalid(dma_m0_awvalid),
    .m0_bid    (dma_m0_bid    ),
    .m0_bready (dma_m0_bready ),
    .m0_bresp  (dma_m0_bresp  ),
    .m0_bvalid (dma_m0_bvalid ),
    .m0_rdata  (dma_m0_rdata  ),
    .m0_rid    (dma_m0_rid    ),
    .m0_rlast  (dma_m0_rlast  ),
    .m0_rready (dma_m0_rready ),
    .m0_rresp  (dma_m0_rresp  ),
    .m0_rvalid (dma_m0_rvalid ),
    .m0_wdata  (dma_m0_wdata  ),
    .m0_wlast  (dma_m0_wlast  ),
    .m0_wready (dma_m0_wready ),
    .m0_wstrb  (dma_m0_wstrb  ),
    .m0_wvalid (dma_m0_wvalid ),
    .m1_araddr (dma_m1_araddr ),
    .m1_arburst(dma_m1_arburst),
    .m1_arcache(dma_m1_arcache),
    .m1_arid   (dma_m1_arid   ),
    .m1_arlen  (dma_m1_arlen  ),
    .m1_arlock (dma_m1_arlock ),
    .m1_arprot (dma_m1_arprot ),
    .m1_arready(dma_m1_arready),
    .m1_arsize (dma_m1_arsize ),
    .m1_arvalid(dma_m1_arvalid),
    .m1_awaddr (dma_m1_awaddr ),
    .m1_awburst(dma_m1_awburst),
    .m1_awcache(dma_m1_awcache),
    .m1_awid   (dma_m1_awid   ),
    .m1_awlen  (dma_m1_awlen  ),
    .m1_awlock (dma_m1_awlock ),
    .m1_awprot (dma_m1_awprot ),
    .m1_awready(dma_m1_awready),
    .m1_awsize (dma_m1_awsize ),
    .m1_awvalid(dma_m1_awvalid),
    .m1_bid    (dma_m1_bid    ),
    .m1_bready (dma_m1_bready ),
    .m1_bresp  (dma_m1_bresp  ),
    .m1_bvalid (dma_m1_bvalid ),
    .m1_rdata  (dma_m1_rdata  ),
    .m1_rid    (dma_m1_rid    ),
    .m1_rlast  (dma_m1_rlast  ),
    .m1_rready (dma_m1_rready ),
    .m1_rresp  (dma_m1_rresp  ),
    .m1_rvalid (dma_m1_rvalid ),
    .m1_wdata  (dma_m1_wdata  ),
    .m1_wlast  (dma_m1_wlast  ),
    .m1_wready (dma_m1_wready ),
    .m1_wstrb  (dma_m1_wstrb  ),
    .m1_wvalid (dma_m1_wvalid ),
    .paddr     (dma_s0_paddr  ),
    .penable   (dma_s0_penable),
    .prdata    (dma_s0_prdata ),
    .pready    (dma_s0_pready ),
    .psel      (dma_s0_psel   ),
    .pslverr   (dma_s0_pslverr),
    .pwdata    (dma_s0_pwdata ),
    .pwrite    (dma_s0_pwrite ),
    .pclk      (clk_dma       ),
    .presetn   (rst_n_dma     ),
    .dma_ack   (dma_ack       ),
    .dma_req   (dma_req       ),
    .dma_int   (dma_irq       )
  );

//*****************************************************************************
//             GbE declaration
//*****************************************************************************

gbe_top gbe_u (
  .tx_clk_sig                (rgmii_rxc         ), // Slightly delayed version of tx_clk
  .tx_clk                    (rgmii_rxc         ),
  .rx_clk                    (rgmii_rxc         ),
  .n_tx_clk                  (rgmii_rxc_n       ),
  .n_rx_clk                  (rgmii_rxc_n       ),
  .n_txreset                 (rst_n_gbe_tx      ),
  .n_rxreset                 (rst_n_gbe_rx      ),
  .n_ntxreset                (rst_n_gbe_ntx     ),
  .n_nrxreset                (rst_n_gbe_nrx     ),
  .ethernet_int              (emac_irq          ),
  //APB
  .pclk                      (clk_dma           ),
  .n_preset                  (rst_n_per         ),
  .paddr                     (gbe_s0_paddr[11:2]),
  .prdata                    (gbe_s0_prdata     ),
  .pwdata                    (gbe_s0_pwdata     ),
  .pwrite                    (gbe_s0_pwrite     ),
  .penable                   (gbe_s0_penable    ),
  .psel                      (gbe_s0_psel       ),
  .perr                      (gbe_s0_pslverr    ),
  //AXI
  .aclk                      (clk_dma           ),
  .n_areset                  (rst_n_emac        ),
  .awid                      (gbe_m0_awid       ), // tied low
  .awaddr                    (gbe_m0_awaddr     ),
  .awlen                     (gbe_m0_awlen      ),
  .awsize                    (gbe_m0_awsize     ),
  .awburst                   (gbe_m0_awburst    ), // tied to 2’b01
  .awlock                    (gbe_m0_awlock     ), // tied low
  .awvalid                   (gbe_m0_awvalid    ),
  .awready                   (gbe_m0_awready    ),
  .wdata                     (gbe_m0_wdata      ),
  .wstrb                     (gbe_m0_wstrb      ),
  .wlast                     (gbe_m0_wlast      ),
  .wready                    (gbe_m0_wready     ),
  .wvalid                    (gbe_m0_wvalid     ),
  .bid                       (gbe_m0_bid        ), // Not used by IP
  .bresp                     (gbe_m0_bresp      ),
  .bvalid                    (gbe_m0_bvalid     ),
  .bready                    (gbe_m0_bready     ),
  .arid                      (gbe_m0_arid       ), // tied low
  .araddr                    (gbe_m0_araddr     ),
  .arlen                     (gbe_m0_arlen      ),
  .arsize                    (gbe_m0_arsize     ),
  .arburst                   (gbe_m0_arburst    ), // tied to 2’b01.
  .arlock                    (gbe_m0_arlock     ), // tied low
  .arcache                   (gbe_m0_arcache    ),
  .arprot                    (gbe_m0_arprot     ),
  .arvalid                   (gbe_m0_arvalid    ),
  .arready                   (gbe_m0_arready    ),
  .rdata                     (gbe_m0_rdata      ),
  .rresp                     (gbe_m0_rresp      ),
  .rlast                     (gbe_m0_rlast      ),
  .rvalid                    (gbe_m0_rvalid     ),
  .rready                    (gbe_m0_rready     ),
  .rid                       (gbe_m0_rid        ), // Not used by IP
  .awcache                   (gbe_m0_awcache    ),
  .awprot                    (gbe_m0_awprot     ),
  
  .rgmii_txd                 (rgmii_txd         ),
  .rgmii_tx_ctl              (rgmii_tx_ctl      ),
  .rgmii_rxd                 (rgmii_rxd         ),
  .rgmii_rx_ctl              (rgmii_rx_ctl      ),
  .mdc                       (mdio_mdc          ),
  .mdio_in                   (gbe_mdio_in       ),
  .mdio_out                  (gbe_mdio_out      ),
  .mdio_en                   (gbe_mdio_en       )
);

//*****************************************************************************
//             USB declaration
//*****************************************************************************



cdnsusbhs_chip_usbhs usb_ctl_phy (
  .wakeup                   ( usb_wakeup        ),  // To be connected to SCU reg bit
  .wakeup5kclk              ( clk_usb_wakeup    ),  // 5 kHz clock 

  .otgstate                 (                   ),  // N/C
  .downstrstate             (                   ),  // N/C
  .upstrstate               (                   ),  // N/C

  .utmidrvvbus              ( usb_utmidrvvbus   ),

  .utmi_suspendm_i          ( usb_utmi_suspendm ),
  .utmi_suspendm            ( usb_utmi_suspendm ),
  .utmi_sleepm              ( usb_utmi_sleepm   ),

  .phy_refclock             ( usb_xtal_in       ),
  .phy_RTRIM                ( usb_rtrim         ),

  .usb_DM                   ( usb_dn            ),
  .usb_DP                   ( usb_dp            ),

  .usb_ID                   ( usb_id            ),
  .usb_VBUS                 ( usb_vbus          ),

  .phy_biston               ( usb_phy_biston         ), // USB PHY BIST interface implemented through programmable registers in SCU
  .phy_bistmodesel          ( usb_phy_bistmodesel    ), // USB PHY BIST interface implemented through programmable registers in SCU
  .phy_bistmodeen           ( usb_phy_bistmodeen     ), // USB PHY BIST interface implemented through programmable registers in SCU
  .phy_bistcomplete         ( usb_phy_bistcomplete   ), // USB PHY BIST interface implemented through programmable registers in SCU
  .phy_bisterror            ( usb_phy_bisterror      ), // USB PHY BIST interface implemented through programmable registers in SCU
  .phy_bisterrorcount       ( usb_phy_bisterrorcount ), // USB PHY BIST interface implemented through programmable registers in SCU

  .phy_scan_clock           ( '0                     ), // To be connected later into common scan chains
  .phy_scan_en              ( '0                     ), // To be connected later into common scan chains
  .phy_scan_en_cg           ( '0                     ), // To be connected later into common scan chains
  .phy_scan_mode            ( '0                     ), // To be connected later into common scan chains
  .phy_scan_in              ( '0                     ), // To be connected later into common scan chains
  .phy_scan_out             (                        ), // To be connected later into common scan chains

  .phy_pll_clockout         (                        ), // not used

  .phy_lane_reverse         ( 1'b0                   ), // disable USB DP/DM lane reversal
  .phy_vbus_sel             ( 2'b00                  ), // 3.3V VBUS is used
  .phy_pllrefsel            ( 4'h5                   ), // 24MHz xtal must be connected to USB PHY as a reference clock

  .phy_pso_disable          ( 1'b1                   ), // tied to 1 as per recommendation from Cadence PHY user guide
  .phy_pso_disable_sel      ( 2'b11                  ), // tied to 2'b11 as per recommendation from Cadence PHY user guide

  .phy_usb2_phy_arch        ( 2'b00                  ), // tied to 0 as per recommendation from Cadence PHY user guide
  .phy_usb2_phy_spare_out   (                        ), // not used

  .phy_pll_bypass_mode      ( usb_pll_bypass         ), // To be sourced from SCU regiter

  .phy_option_n             ( 1'b0                   ), // tied to 0 as per recommendation from Cadence PHY user guide
  .phy_option_cv            ( 1'b0                   ), // to be review after clarity on core voltage nominal

  .phy_iddq_mode            ( 1'b0                   ), // Normal operation mode is selected for PHY

  .phy_scan_hsclock         ( '0                     ), // To be connected later into common scan chains
  .phy_scan_hssiclock       ( '0                     ), // To be connected later into common scan chains
  .phy_scan_sieclock        ( '0                     ), // To be connected later into common scan chains
  .phy_scan_ats_mode        ( '0                     ), // To be connected later into common scan chains
  .phy_scan_ats_hsclock     (                        ), // To be connected later into common scan chains
  .phy_scan_ats_hssiclock   (                        ), // To be connected later into common scan chains
  .phy_scan_ats_sieclock    (                        ), // To be connected later into common scan chains

  .aclk                     ( clk_usb                ),
  .areset                   ( rst_n_per              ),

  .sawid                    ( '0                     ),
  .sawaddr                  ( usb_s0_awaddr          ),
  .sawsize                  ( 3'b010                 ),
  .sawlen                   ( '0                     ),
  .sawburst                 ( 2'b01                  ),
  .sawlock                  ( '0                     ),
  .sawcache                 ( '0                     ),
  .sawprot                  ( usb_s0_awprot          ),
  .sawvalid                 ( usb_s0_awvalid         ),
  .sawready                 ( usb_s0_awready         ),

  .swid                     ( '0                     ),
  .swdata                   ( usb_s0_wdata           ),
  .swstrb                   ( usb_s0_wstrb           ),
  .swvalid                  ( usb_s0_wvalid          ),
  .swlast                   ( 1'b1                   ),
  .swready                  ( usb_s0_wready          ),

  .sbid                     (                        ),
  .sbready                  ( usb_s0_bready          ),
  .sbresp                   ( usb_s0_bresp           ),
  .sbvalid                  ( usb_s0_bvalid          ),

  .sarid                    ( '0                     ),
  .saraddr                  ( usb_s0_araddr          ),
  .sarsize                  ( 3'b010                 ),
  .sarlen                   ( '0                     ),
  .sarburst                 ( 2'b01                  ),
  .sarlock                  ( '0                     ),
  .sarcache                 ( '0                     ),
  .sarprot                  ( usb_s0_arprot          ),
  .sarvalid                 ( usb_s0_arvalid         ),
  .sarready                 ( usb_s0_arready         ),

  .srid                     (                        ),
  .srready                  ( usb_s0_rready          ),
  .srdata                   ( usb_s0_rdata           ),
  .srresp                   ( usb_s0_rresp           ),
  .srvalid                  ( usb_s0_rvalid          ),
  .srlast                   (                        ),

  .vbusfault                ( usb_vbusfault          ), // To be connected to usb_Vbus monitor, if it exists on board

  .tsmode                   ( usb_tsmode             ), // To be sourced from SCU regiter
  .tmodecustom              ( usb_tmodecustom        ), // To be connected to SCU register bits     
  .tmodeselcustom           ( usb_tmodeselcustom     ), // To be connected to SCU register bits     

  .mawid                    ( usb_m0_awid        ),
  .mawaddr                  ( usb_m0_awaddr      ),
  .mawsize                  ( usb_m0_awsize      ),
  .mawlen                   ( usb_m0_awlen       ),
  .mawburst                 ( usb_m0_awburst     ),
  .mawlock                  ( usb_m0_awlock      ),
  .mawcache                 ( usb_m0_awcache     ),
  .mawprot                  ( usb_m0_awprot      ),
  .mawvalid                 ( usb_m0_awvalid     ),
  .mawready                 ( usb_m0_awready     ),

  .mwid                     (                    ),
  .mwdata                   ( usb_m0_wdata       ),
  .mwstrb                   ( usb_m0_wstrb       ),
  .mwvalid                  ( usb_m0_wvalid      ),
  .mwready                  ( usb_m0_wready      ),
  .mwlast                   ( usb_m0_wlast       ),

  .mbid                     ( usb_m0_bid         ),
  .mbready                  ( usb_m0_bready      ),
  .mbresp                   ( usb_m0_bresp       ),
  .mbvalid                  ( usb_m0_bvalid      ),

  .marid                    ( usb_m0_arid        ),
  .maraddr                  ( usb_m0_araddr      ),
  .marsize                  ( usb_m0_arsize      ),
  .marlen                   ( usb_m0_arlen       ),
  .marburst                 ( usb_m0_arburst     ),
  .marlock                  ( usb_m0_arlock      ),
  .marcache                 ( usb_m0_arcache     ),
  .marprot                  ( usb_m0_arprot      ),
  .marvalid                 ( usb_m0_arvalid     ),
  .marready                 ( usb_m0_arready     ),

  .mrid                     ( usb_m0_rid         ),
  .mrready                  ( usb_m0_rready      ),
  .mrdata                   ( usb_m0_rdata       ),
  .mrresp                   ( usb_m0_rresp       ),
  .mrvalid                  ( usb_m0_rvalid      ),
  .mrlast                   ( usb_m0_rlast       ),

  .wuintreq                 ( usb_wuintreq       ),
  .usbintreq                ( usbintreq          ),
  .usbivect                 (                    )

);

assign usb_irq = usbintreq | usb_wuintreq;




// //*****************************************************************************
// //             BCPU declaration
// //*****************************************************************************

  logic dbg_wakeup_req     ; //not used
  logic dbg_srst_req       ; //not used
  logic hart0_core_wfi_mode; //not used
  logic pin_tdi_out        ; //not used
  logic pin_tdi_out_en     ; //not used
  logic pin_tdo_in         ; //not used
  logic pin_tdo_out_en     ; //not used
  logic pin_tms_out        ; //not used
  logic pin_tms_out_en     ; //not used
  logic pin_trst_in        ; //not used
  logic pin_trst_out       ; //not used
  logic pin_trst_out_en    ; //not used

  logic [31:0] hart0_reset_vector       ;
  logic        hart0_icache_disable_init;
  logic        hart0_dcache_disable_init;
  logic        ahb_bus_clk_en           ;

  assign hart0_reset_vector        = 32'hffff0080;
  assign hart0_icache_disable_init = 1'b1;
  assign hart0_dcache_disable_init = 1'b1;
  assign ahb_bus_clk_en            = 1'b1;

  ae250_cpu_subsystem bcpu (
    .int_src                  (bcpu_irq_set[31:1]       ),
    .dbg_wakeup_req           (dbg_wakeup_req           ),
    .test_mode                (testmode                 ),
    .hart0_nmi                (bcpu_irq_set[0]          ),
    .dbg_srst_req             (dbg_srst_req             ),
    .dbg_tck                  (bcpu_jtag_tck            ),
    .mtime_clk                (clk_bcpu_mtime           ),
    .pin_tdi_in               (bcpu_jtag_tdi            ),
    .pin_tdi_out              (pin_tdi_out              ),
    .pin_tdi_out_en           (pin_tdi_out_en           ),
    .pin_tdo_in               (pin_tdo_in               ),
    .pin_tdo_out              (bcpu_jtag_tdo            ),
    .pin_tdo_out_en           (pin_tdo_out_en           ),
    .pin_tms_in               (bcpu_jtag_tms            ),
    .pin_tms_out              (pin_tms_out              ),
    .pin_tms_out_en           (pin_tms_out_en           ),
    .pin_trst_in              (pin_trst_in              ),
    .pin_trst_out             (pin_trst_out             ),
    .pin_trst_out_en          (pin_trst_out_en          ),
    .por_rstn                 (rst_n_bcpu               ),
    .core_clk                 (clk_bcpu                 ),
    .hart0_core_reset_n       (rst_n_bcpu               ),
    .hart0_core_wfi_mode      (hart0_core_wfi_mode      ),
    .hart0_reset_vector       (hart0_reset_vector       ),
    .hart0_icache_disable_init(hart0_icache_disable_init),
    .hart0_dcache_disable_init(hart0_dcache_disable_init),
    .ahb_bus_clk_en           (ahb_bus_clk_en           ),
    .hclk                     (clk_bcpu                 ),
    .hresetn                  (rst_n_bcpu_bus           ),
    .hrdata                   (bcpu_m0_hrdata           ),
    .hready                   (bcpu_m0_hready           ),
    .hresp                    (bcpu_m0_hresp            ),
    .haddr                    (bcpu_m0_haddr            ),
    .hsel                     (bcpu_m0_hsel             ),
    .hburst                   (bcpu_m0_hburst           ),
    .hprot                    (bcpu_m0_hprot            ),
    .hsize                    (bcpu_m0_hsize            ),
    .htrans                   (bcpu_m0_htrans           ),
    .hwdata                   (bcpu_m0_hwdata           ),
    .hwrite                   (bcpu_m0_hwrite           )
  );

//*****************************************************************************
//             PUFCC declaration
//*****************************************************************************


assign pufcc_m0_ar_cache = 'h0;
assign pufcc_m0_ar_id    = 'h0;
assign pufcc_m0_ar_lock  = 'h0;
assign pufcc_m0_aw_cache = 'h0;
assign pufcc_m0_aw_id    = 'h0;
assign pufcc_m0_aw_lock  = 'h0;

localparam DMADBW              = 32  ;
localparam DMAFFD              = 16  ;
localparam PRIVATE_KEY_WIDTH   = 256 ;
localparam SHARED_SECRET_WIDTH = 1152;
localparam KWP_MAX_KSIZE       = 640 ;
localparam AES_SBOX_NUM        = 16  ;
localparam CHACHA_QR_NUM       = 4   ;
localparam CHACHA_QR_CYCLE     = 1   ;
localparam SUP_AES             = 1   ;
localparam SUP_GCM             = 1   ;
localparam SUP_XTS             = 1   ;
localparam SUP_CCM             = 1   ;
localparam SUP_SP90A           = 1   ;
localparam SUP_RFC8439         = 1   ;
localparam SUP_SHA2_256        = 1   ;
localparam SUP_SHA2_512        = 1   ;
localparam SUP_SM3             = 1   ;
localparam SUP_SM4             = 1   ;
localparam SUP_KBKDF           = 1   ;
localparam SUP_PBKDF           = 1   ;
localparam SUP_SM2ENC          = 1   ;
localparam SUP_SGDMA           = 1   ;
localparam DPA_PKC             = 1   ;
localparam DPA_CIP             = 1   ;
localparam AUTOLD_SIZE         = 1   ;
localparam CLK_XTL_PERIOD      = 40  ;

logic                       autold_vld ;
logic [AUTOLD_SIZE*256-1:0] autold_bits;
logic [              255:0] kexp_key   ;
logic                       kexp_size  ;
logic                       kexp_idx   ;
logic                       kexp_vld   ;
logic                       kexp_rdy   ;

assign kexp_rdy = 1'b1;

pufcc #(
  .DMADBW             (DMADBW             ),
  .DMAFFD             (DMAFFD             ),
  .PRIVATE_KEY_WIDTH  (PRIVATE_KEY_WIDTH  ),
  .SHARED_SECRET_WIDTH(SHARED_SECRET_WIDTH),
  .KWP_MAX_KSIZE      (KWP_MAX_KSIZE      ),
  .AES_SBOX_NUM       (AES_SBOX_NUM       ),
  .CHACHA_QR_NUM      (CHACHA_QR_NUM      ),
  .CHACHA_QR_CYCLE    (CHACHA_QR_CYCLE    ),
  .SUP_AES            (SUP_AES            ),
  .SUP_GCM            (SUP_GCM            ),
  .SUP_XTS            (SUP_XTS            ),
  .SUP_CCM            (SUP_CCM            ),
  .SUP_SP90A          (SUP_SP90A          ),
  .SUP_RFC8439        (SUP_RFC8439        ),
  .SUP_SHA2_256       (SUP_SHA2_256       ),
  .SUP_SHA2_512       (SUP_SHA2_512       ),
  .SUP_SM3            (SUP_SM3            ),
  .SUP_SM4            (SUP_SM4            ),
  .SUP_KBKDF          (SUP_KBKDF          ),
  .SUP_PBKDF          (SUP_PBKDF          ),
  .SUP_SM2ENC         (SUP_SM2ENC         ),
  .SUP_SGDMA          (SUP_SGDMA          ),
  .DPA_PKC            (DPA_PKC            ),
  .DPA_CIP            (DPA_CIP            ),
  .AUTOLD_SIZE        (AUTOLD_SIZE        ),
  .CLK_XTL_PERIOD     (CLK_XTL_PERIOD     )
) pufcc_u (
  `ifdef               USE_PWR_PIN
  .VDD        (VDD                 ),
  .VDD2       (VDD2                ),
  .VSS        (VSS                 ),
  `endif
  .autold_vld (autold_vld          ),
  .autold_bits(autold_bits         ),
  .intrpt     (pscc_irq            ),
  .paddr      (pufcc_s0_paddr[14:0]),
  .pwrite     (pufcc_s0_pwrite     ),
  .psel       (pufcc_s0_psel       ),
  .penable    (pufcc_s0_penable    ),
  .pwdata     (pufcc_s0_pwdata     ),
  .prdata     (pufcc_s0_prdata     ),
  .pready     (pufcc_s0_pready     ),
  .pslverr    (pufcc_s0_pslverr    ),
  .awprot     (pufcc_m0_aw_prot    ),
  .awaddr     (pufcc_m0_aw_addr    ),
  .awlen      (pufcc_m0_aw_len     ),
  .awsize     (pufcc_m0_aw_size    ),
  .awburst    (pufcc_m0_aw_burst   ),
  .awvalid    (pufcc_m0_aw_valid   ),
  .awready    (pufcc_m0_aw_ready   ),
  .wdata      (pufcc_m0_w_data     ),
  .wstrb      (pufcc_m0_w_strb     ),
  .wlast      (pufcc_m0_w_last     ),
  .wvalid     (pufcc_m0_w_valid    ),
  .wready     (pufcc_m0_w_ready    ),
  .bresp      (pufcc_m0_b_resp     ),
  .bvalid     (pufcc_m0_b_valid    ),
  .bready     (pufcc_m0_b_ready    ),
  .arprot     (pufcc_m0_ar_prot    ),
  .araddr     (pufcc_m0_ar_addr    ),
  .arlen      (pufcc_m0_ar_len     ),
  .arsize     (pufcc_m0_ar_size    ),
  .arburst    (pufcc_m0_ar_burst   ),
  .arvalid    (pufcc_m0_ar_valid   ),
  .arready    (pufcc_m0_ar_ready   ),
  .rdata      (pufcc_m0_r_data     ),
  .rresp      (pufcc_m0_r_resp     ),
  .rlast      (pufcc_m0_r_last     ),
  .rvalid     (pufcc_m0_r_valid    ),
  .rready     (pufcc_m0_r_ready    ),
  .kexp_key   (kexp_key            ),
  .kexp_size  (kexp_size           ),
  .kexp_idx   (kexp_idx            ),
  .kexp_vld   (kexp_vld            ),
  .kexp_rdy   (kexp_rdy            ),
  .rng_fre_en (rng_fre_en          ),
  .rng_fre_sel(rng_fre_sel         ),
  .rng_fre_out(rng_fre_out         ),
  .scan_mode  (1'b0                ),
  .scan_clk   (1'b0                ),
  .clk_eng    (clk_apb_ug          ),
  .clk_xtl    (clk_pscc_xtl        ),
  .rst_n      (rst_n_per           )
);

//#//*****************************************************************************
//#//             PADS Instantation
//#//*****************************************************************************
//#	/*********** PADS Module *******************/	
//#	pads		pads_inst(
//#			.RST_N (RST_N),
//#			.XIN (XIN),
//#			.REF_CLK_1 (REF_CLK_1),
//#			.REF_CLK_2 (REF_CLK_2),
//#			.REF_CLK_3 (REF_CLK_3),
//#			.REF_CLK_4 (REF_CLK_4),
//#			.TESTMODE (TESTMODE),
//#			.BOOTM0 (BOOTM0),
//#			.BOOTM1 (BOOTM1),
//#			.BOOTM2 (BOOTM2),
//#			.CLKSEL_0 (CLKSEL_0),
//#			.CLKSEL_1 (CLKSEL_1),
//#			.JTAG_TDI (JTAG_TDI),
//#			.JTAG_TDO (JTAG_TDO),
//#			.JTAG_TMS (JTAG_TMS),
//#			.JTAG_TCK (JTAG_TCK),
//#			.JTAG_TRSTN (JTAG_TRSTN),
//#			.GPIO_B_0 (GPIO_B_0),
//#			.GPIO_B_1 (GPIO_B_1),
//#			.GPIO_B_2 (GPIO_B_2),
//#			.GPIO_B_3 (GPIO_B_3),
//#			.GPIO_B_4 (GPIO_B_4),
//#			.GPIO_B_5 (GPIO_B_5),
//#			.GPIO_B_6 (GPIO_B_6),
//#			.GPIO_B_7 (GPIO_B_7),
//#			.GPIO_B_8 (GPIO_B_8),
//#			.GPIO_B_9 (GPIO_B_9),
//#			.GPIO_B_10 (GPIO_B_10),
//#			.GPIO_B_11 (GPIO_B_11),
//#			.GPIO_B_12 (GPIO_B_12),
//#			.GPIO_B_13 (GPIO_B_13),
//#			.GPIO_B_14 (GPIO_B_14),
//#			.GPIO_B_15 (GPIO_B_15),
//#			.GPIO_C_0 (GPIO_C_0),
//#			.GPIO_C_1 (GPIO_C_1),
//#			.GPIO_C_2 (GPIO_C_2),
//#			.GPIO_C_3 (GPIO_C_3),
//#			.GPIO_C_4 (GPIO_C_4),
//#			.GPIO_C_5 (GPIO_C_5),
//#			.GPIO_C_6 (GPIO_C_6),
//#			.GPIO_C_7 (GPIO_C_7),
//#			.GPIO_C_8 (GPIO_C_8),
//#			.GPIO_C_9 (GPIO_C_9),
//#			.GPIO_C_10 (GPIO_C_10),
//#			.GPIO_C_11 (GPIO_C_11),
//#			.GPIO_C_12 (GPIO_C_12),
//#			.GPIO_C_13 (GPIO_C_13),
//#			.GPIO_C_14 (GPIO_C_14),
//#			.GPIO_C_15 (GPIO_C_15),
//#			.I2C_SCL (I2C_SCL),
//#			.SPI_SCLK (SPI_SCLK),
//#			.GPT_RTC (GPT_RTC),
//#			.MDIO_MDC (MDIO_MDC),
//#			.MDIO_DATA (MDIO_DATA),
//#			.RGMII_TXD0 (RGMII_TXD0),
//#			.RGMII_TXD1 (RGMII_TXD1),
//#			.RGMII_TXD2 (RGMII_TXD2),
//#			.RGMII_TXD3 (RGMII_TXD3),
//#			.RGMII_TX_CTL (RGMII_TX_CTL),
//#			.RGMII_TXC (RGMII_TXC),
//#			.RGMII_RXD0 (RGMII_RXD0),
//#			.RGMII_RXD1 (RGMII_RXD1),
//#			.RGMII_RXD2 (RGMII_RXD2),
//#			.RGMII_RXD3 (RGMII_RXD3),
//#			.RGMII_RX_CTL (RGMII_RX_CTL),
//#			.RGMII_RXC (RGMII_RXC),
//#			.por (por),
//#			.xin (xin),
//#			.testmode (testmode),
//#			.bootm (bootm),
//#			.clksel (clksel[1:0]),
//#			.jtag_tdi (jtag_tdi),
//#			.jtag_tdo (1'b0),
//#			.jtag_tdo_oe (1'b0),
//#			.jtag_tms (jtag_tms),
//#			.jtag_tck (jtag_tck),
//#			.jtag_trstn (jtag_trstn),
//#			.i2c_scl (i2c_scl),
//#			.spi_clk (spi_clk),
//#			.rtc_clk (rtc_clk),
//#			.rgmii_txd (rgmii_txd),
//#			.rgmii_tx_ctl (rgmii_tx_ctl),
//#			.rgmii_txc (1'b0),
//#			.rgmii_rxd (rgmii_rxd),
//#			.rgmii_rx_ctl (rgmii_rx_ctl),
//#			.rgmii_rxc (rgmii_rxc),	
//#			.mdio_data (mdio_data),
//#			.gpio_b_in (16'b0),
//#			.gpio_b_out (gpio_b_out),
//#			.gpio_b_oe (16'b0),
//#			.gpio_c_in (16'b0),
//#			.gpio_c_out (gpio_c_out),
//#			.gpio_c_oe (16'b0)
//#	);
assign por = reset_proto;
assign testmode = 'd0;
assign bootm = 'd0; 

//*****************************************************************************
//                       SoC PLL 
//*****************************************************************************
logic foutvco;
logic foutcmln;
logic foutcmlp;
logic foutdiffn;
logic foutdiffp;
logic clksscg;
logic [3:0]fout;

assign clk_soc_pll0 = fout[0];
assign clk_soc_pll1 = fout[1];

logic pll_en;
logic [5:0] pll_en_cnt;

always @(posedge clk_pll_soc_ref or negedge por)
  if (!por)                                       pll_en_cnt  <= 'h0;
  else if (!soc_pll_ctl_pllen)                    pll_en_cnt  <= 'h0;
  else if (soc_pll_ctl_pllen & pll_en_cnt<6'd41)  pll_en_cnt  <= pll_en_cnt+'h1;

always @(posedge clk_pll_soc_ref or negedge por)
  if (!por)                  pll_en  <= 'h0;
  else if(clksel[0])         pll_en  <= 'h0;
  else if(pll_en_cnt>=6'd41) pll_en  <= 'h1;
  else                       pll_en  <= 'h0;


always @ (posedge clk_pll_soc_ref or negedge por)
  if(!por) begin
    soc_pll_ctl_dacen_ff        <= 'h0;
    soc_pll_ctl_dskewcalbyp_ff  <= 'h0;
    soc_pll_ctl_dskewcalcnt_ff  <= 'h0;
    soc_pll_ctl_dskewcalen_ff   <= 'h0;
    soc_pll_ctl_dskewcalin_ff   <= 'h0;
    soc_pll_ctl_dskewfastcal_ff <= 'h0;
    soc_pll_ctl_dsmen_ff        <= 'h0;
    soc_pll_ctl_fouten_ff       <= 'h0;
    soc_pll_ctl_foutvcobyp_ff   <= 'h0;
    soc_pll_ctl_foutvcoen_ff    <= 'h0;
    soc_pll_ctl_refdiv_ff       <= 'h0;
    soc_pll_ctl_frac_ff         <= 'h0;
    soc_pll_ctl_fbdiv_ff        <= 'h0;
    soc_pll_ctl_postdiv0_ff     <= 'h0;
  end
  else if (pll_en_cnt==6'd1) begin
    soc_pll_ctl_dacen_ff        <= soc_pll_ctl_dacen;
    soc_pll_ctl_dskewcalbyp_ff  <= soc_pll_ctl_dskewcalbyp;
    soc_pll_ctl_dskewcalcnt_ff  <= soc_pll_ctl_dskewcalcnt;
    soc_pll_ctl_dskewcalen_ff   <= soc_pll_ctl_dskewcalen;
    soc_pll_ctl_dskewcalin_ff   <= soc_pll_ctl_dskewcalin;
    soc_pll_ctl_dskewfastcal_ff <= soc_pll_ctl_dskewfastcal;
    soc_pll_ctl_dsmen_ff        <= soc_pll_ctl_dsmen;
    soc_pll_ctl_fouten_ff       <= soc_pll_ctl_fouten;
    soc_pll_ctl_foutvcobyp_ff   <= soc_pll_ctl_foutvcobyp;
    soc_pll_ctl_foutvcoen_ff    <= soc_pll_ctl_foutvcoen;
    soc_pll_ctl_refdiv_ff       <= soc_pll_ctl_refdiv;
    soc_pll_ctl_frac_ff         <= soc_pll_ctl_frac;
    soc_pll_ctl_fbdiv_ff        <= soc_pll_ctl_fbdiv;
    soc_pll_ctl_postdiv0_ff     <= soc_pll_ctl_postdiv0;
  end  


  PLLTS16FFCFRACF pll_u (
    .DACEN       (soc_pll_ctl_dacen_ff       ),
    .DSKEWCALBYP (soc_pll_ctl_dskewcalbyp_ff ),
    .DSKEWCALCNT (soc_pll_ctl_dskewcalcnt_ff ),
    .DSKEWCALEN  (soc_pll_ctl_dskewcalen_ff  ),
    .DSKEWCALIN  (soc_pll_ctl_dskewcalin_ff  ),
    .DSKEWFASTCAL(soc_pll_ctl_dskewfastcal_ff),
    .DSMEN       (soc_pll_ctl_dsmen_ff       ),
    .FBDIV       (soc_pll_ctl_fbdiv_ff       ),
    .FOUTCMLEN   (1'b0                       ),
    .FOUTDIFFEN  (1'b0                       ),
    .FOUTEN      (soc_pll_ctl_fouten_ff      ),
    .FOUTVCOBYP  (soc_pll_ctl_foutvcobyp_ff  ),
    .FOUTVCOEN   (soc_pll_ctl_foutvcoen_ff   ),
    .FRAC        (soc_pll_ctl_frac_ff        ),
    .FREF        (clk_pll_soc_ref            ),
    .FREFCMLEN   (1'b0                       ),
    .FREFCMLN    (1'b0                       ),
    .FREFCMLP    (1'b0                       ),
    .PLLEN       (pll_en                     ),
    .POSTDIV0    (soc_pll_ctl_postdiv0_ff    ),
    .POSTDIV1    (soc_pll_ctl_postdiv1       ),
    .POSTDIV2    (4'h0                       ),
    .POSTDIV3    (4'h0                       ),
    .POSTDIV4    (2'h0                       ),
    .REFDIV      (soc_pll_ctl_refdiv_ff      ),
    .CLKSSCG     (clksscg                    ),
    .DSKEWCALLOCK(soc_pll_status_dskewcallock),
    .DSKEWCALOUT (soc_pll_status_dskewcalout ),
    .FOUT        (fout                       ),
    .FOUTCMLN    (foutcmln                   ),
    .FOUTCMLP    (foutcmlp                   ),
    .FOUTDIFFN   (foutdiffn                  ),
    .FOUTDIFFP   (foutdiffp                  ),
    .FOUTVCO     (foutvco                    ),
    .LOCK        (       )
  );


////rsnoc_feedthrough_issue
//assign soc_fpga_intf_ahb_s0_haddr     = flexnoc_ahb_s0_haddr;
//assign soc_fpga_intf_ahb_s0_hburst    = flexnoc_ahb_s0_hburst;
//// assign soc_fpga_intf_ahb_s0_hmastlock = flexnoc_ahb_s0_hmastlock;
//assign soc_fpga_intf_ahb_s0_hprot    = flexnoc_ahb_s0_hprot;
//assign soc_fpga_intf_ahb_s0_hsel     = flexnoc_ahb_s0_hsel;
//assign soc_fpga_intf_ahb_s0_hsize    = flexnoc_ahb_s0_hsize;
//assign soc_fpga_intf_ahb_s0_htrans   = flexnoc_ahb_s0_htrans;
//assign soc_fpga_intf_ahb_s0_hwbe     = flexnoc_ahb_s0_hwbe;
//assign soc_fpga_intf_ahb_s0_hwdata   = flexnoc_ahb_s0_hwdata;
//assign soc_fpga_intf_ahb_s0_hwrite   = flexnoc_ahb_s0_hwrite;
//assign flexnoc_ahb_s0_hrdata         = soc_fpga_intf_ahb_s0_hrdata;
//assign flexnoc_ahb_s0_hready         = soc_fpga_intf_ahb_s0_hready;
//assign flexnoc_ahb_s0_hresp          = soc_fpga_intf_ahb_s0_hresp;
//assign soc_fpga_intf_axi_m0_ar_ready = flexnoc_axi_m0_ar_ready;
//assign soc_fpga_intf_axi_m0_aw_ready = flexnoc_axi_m0_aw_ready;
//assign soc_fpga_intf_axi_m0_b_id     = flexnoc_axi_m0_b_id;
//assign soc_fpga_intf_axi_m0_b_resp   = flexnoc_axi_m0_b_resp;
//assign soc_fpga_intf_axi_m0_b_valid  = flexnoc_axi_m0_b_valid;
//assign soc_fpga_intf_axi_m0_r_data   = flexnoc_axi_m0_r_data;
//assign soc_fpga_intf_axi_m0_r_id     = flexnoc_axi_m0_r_id;
//assign soc_fpga_intf_axi_m0_r_last   = flexnoc_axi_m0_r_last;
//assign soc_fpga_intf_axi_m0_r_resp   = flexnoc_axi_m0_r_resp;
//assign soc_fpga_intf_axi_m0_r_valid  = flexnoc_axi_m0_r_valid;
//assign soc_fpga_intf_axi_m0_w_ready  = flexnoc_axi_m0_w_ready;
//assign flexnoc_axi_m0_ar_addr        = soc_fpga_intf_axi_m0_ar_addr;
//assign flexnoc_axi_m0_ar_burst       = soc_fpga_intf_axi_m0_ar_burst;
//assign flexnoc_axi_m0_ar_cache       = soc_fpga_intf_axi_m0_ar_cache;
//assign flexnoc_axi_m0_ar_id          = soc_fpga_intf_axi_m0_ar_id;
//assign flexnoc_axi_m0_ar_len         = soc_fpga_intf_axi_m0_ar_len;
//assign flexnoc_axi_m0_ar_lock        = soc_fpga_intf_axi_m0_ar_lock;
//assign flexnoc_axi_m0_ar_prot        = soc_fpga_intf_axi_m0_ar_prot;
//assign flexnoc_axi_m0_ar_size        = soc_fpga_intf_axi_m0_ar_size;
//assign flexnoc_axi_m0_ar_valid       = soc_fpga_intf_axi_m0_ar_valid;
//assign flexnoc_axi_m0_aw_addr        = soc_fpga_intf_axi_m0_aw_addr;
//assign flexnoc_axi_m0_aw_burst       = soc_fpga_intf_axi_m0_aw_burst;
//assign flexnoc_axi_m0_aw_cache       = soc_fpga_intf_axi_m0_aw_cache;
//assign flexnoc_axi_m0_aw_id          = soc_fpga_intf_axi_m0_aw_id;
//assign flexnoc_axi_m0_aw_len         = soc_fpga_intf_axi_m0_aw_len;
//assign flexnoc_axi_m0_aw_lock        = soc_fpga_intf_axi_m0_aw_lock;
//assign flexnoc_axi_m0_aw_prot        = soc_fpga_intf_axi_m0_aw_prot;
//assign flexnoc_axi_m0_aw_size        = soc_fpga_intf_axi_m0_aw_size;
//assign flexnoc_axi_m0_aw_valid       = soc_fpga_intf_axi_m0_aw_valid;
//assign flexnoc_axi_m0_b_ready        = soc_fpga_intf_axi_m0_b_ready;
//assign flexnoc_axi_m0_r_ready        = soc_fpga_intf_axi_m0_r_ready;
//assign flexnoc_axi_m0_w_data         = soc_fpga_intf_axi_m0_w_data;
//assign flexnoc_axi_m0_w_last         = soc_fpga_intf_axi_m0_w_last;
//assign flexnoc_axi_m0_w_strb         = soc_fpga_intf_axi_m0_w_strb;
//assign flexnoc_axi_m0_w_valid        = soc_fpga_intf_axi_m0_w_valid;
//assign soc_fpga_intf_axi_m1_ar_ready = flexnoc_axi_m1_ar_ready;
//assign soc_fpga_intf_axi_m1_aw_ready = flexnoc_axi_m1_aw_ready;
//assign soc_fpga_intf_axi_m1_b_id     = flexnoc_axi_m1_b_id;
//assign soc_fpga_intf_axi_m1_b_resp   = flexnoc_axi_m1_b_resp;
//assign soc_fpga_intf_axi_m1_b_valid  = flexnoc_axi_m1_b_valid;
//assign soc_fpga_intf_axi_m1_r_data   = flexnoc_axi_m1_r_data;
//assign soc_fpga_intf_axi_m1_r_id     = flexnoc_axi_m1_r_id;
//assign soc_fpga_intf_axi_m1_r_last   = flexnoc_axi_m1_r_last;
//assign soc_fpga_intf_axi_m1_r_resp   = flexnoc_axi_m1_r_resp;
//assign soc_fpga_intf_axi_m1_r_valid  = flexnoc_axi_m1_r_valid;
//assign soc_fpga_intf_axi_m1_w_ready  = flexnoc_axi_m1_w_ready;
//assign flexnoc_axi_m1_ar_addr        = soc_fpga_intf_axi_m1_ar_addr;
//assign flexnoc_axi_m1_ar_burst       = soc_fpga_intf_axi_m1_ar_burst;
//assign flexnoc_axi_m1_ar_cache       = soc_fpga_intf_axi_m1_ar_cache;
//assign flexnoc_axi_m1_ar_id          = soc_fpga_intf_axi_m1_ar_id;
//assign flexnoc_axi_m1_ar_len         = soc_fpga_intf_axi_m1_ar_len;
//assign flexnoc_axi_m1_ar_lock        = soc_fpga_intf_axi_m1_ar_lock;
//assign flexnoc_axi_m1_ar_prot        = soc_fpga_intf_axi_m1_ar_prot;
//assign flexnoc_axi_m1_ar_size        = soc_fpga_intf_axi_m1_ar_size;
//assign flexnoc_axi_m1_ar_valid       = soc_fpga_intf_axi_m1_ar_valid;
//assign flexnoc_axi_m1_aw_addr        = soc_fpga_intf_axi_m1_aw_addr;
//assign flexnoc_axi_m1_aw_burst       = soc_fpga_intf_axi_m1_aw_burst;
//assign flexnoc_axi_m1_aw_cache       = soc_fpga_intf_axi_m1_aw_cache;
//assign flexnoc_axi_m1_aw_id          = soc_fpga_intf_axi_m1_aw_id;
//assign flexnoc_axi_m1_aw_len         = soc_fpga_intf_axi_m1_aw_len;
//assign flexnoc_axi_m1_aw_lock        = soc_fpga_intf_axi_m1_aw_lock;
//assign flexnoc_axi_m1_aw_prot        = soc_fpga_intf_axi_m1_aw_prot;
//assign flexnoc_axi_m1_aw_size        = soc_fpga_intf_axi_m1_aw_size;
//assign flexnoc_axi_m1_aw_valid       = soc_fpga_intf_axi_m1_aw_valid;
//assign flexnoc_axi_m1_b_ready        = soc_fpga_intf_axi_m1_b_ready;
//assign flexnoc_axi_m1_r_ready        = soc_fpga_intf_axi_m1_r_ready;
//assign flexnoc_axi_m1_w_data         = soc_fpga_intf_axi_m1_w_data;
//assign flexnoc_axi_m1_w_last         = soc_fpga_intf_axi_m1_w_last;
//assign flexnoc_axi_m1_w_strb         = soc_fpga_intf_axi_m1_w_strb;
//assign flexnoc_axi_m1_w_valid        = soc_fpga_intf_axi_m1_w_valid;
//assign soc_fpga_intf_fcb_s0_paddr    = flexnoc_fcb_s0_paddr;
//assign soc_fpga_intf_fcb_s0_psel     = flexnoc_fcb_s0_psel;
//assign soc_fpga_intf_fcb_s0_penable  = flexnoc_fcb_s0_penable;
//assign soc_fpga_intf_fcb_s0_pwrite   = flexnoc_fcb_s0_pwrite;
//assign soc_fpga_intf_fcb_s0_pwdata   = flexnoc_fcb_s0_pwdata;
//assign flexnoc_fcb_s0_prdata         = soc_fpga_intf_fcb_s0_prdata;
//assign flexnoc_fcb_s0_pready         = soc_fpga_intf_fcb_s0_pready;
//assign soc_pll_status_lock = locked_proto;

assign dummy_out=   
  /*output      logic 	    */ uart0_sout_proto		   + 
  /*output      logic       */ clk_acpu                    + 
  /*output      logic       */ clk_acpu_mtime              + 
  /*output      logic       */ clk_bcpu                    + 
  /*output      logic       */ clk_ddr_phy                 + 
  /*output      logic       */ clk_ddr_ctl                 + 
  /*output      logic       */ clk_ddr_cfg                 + 
  /*output      logic       */ clk_apb_ug                  + 
  /*output      logic       */ rst_n_bcpu                  + 
  /*output      logic       */ rst_n_bcpu_bus              + 
  /*output      logic       */ rst_n_sram                  + 
  /*output      logic       */ rst_n_acpu                  + 
  /*output      logic       */ rst_n_acpu_bus              + 
  /*output      logic       */ rst_n_fpga0                 + 
  /*output      logic       */ rst_n_fpga1                 + 
  /*output      logic       */ rst_n_fpga_s                + 
  /*output      logic       */ rst_n_ddr                   + 
  /*output      logic       */ rst_n_133                   + 
  /*output      logic       */ rst_n_266                   + 
  /*output      logic       */ rst_n_533                   + 
  /*output      logic       */ rst_n_per                   + 
  /*output      logic [31:0]*/ acpu_wdt_s0_prdata          + 
  /*output      logic       */ acpu_wdt_s0_pready          + 
  /*output      logic       */ acpu_wdt_s0_pslverr         + 
  /*output      logic [31:0]*/ bcpu_wdt_s0_prdata          + 
  /*output      logic       */ bcpu_wdt_s0_pready          + 
  /*output      logic       */ bcpu_wdt_s0_pslverr         + 
  /*output      logic [31:0]*/ dma_s0_prdata               + 
  /*output      logic       */ dma_s0_pready               + 
  /*output      logic       */ dma_s0_pslverr              + 
  /*output      logic [31:0]*/ gpio_s0_prdata              + 
  /*output      logic       */ gpio_s0_pready              + 
  /*output      logic       */ gpio_s0_pslverr             + 
  /*output      logic [31:0]*/ gpt_s0_prdata               + 
  /*output      logic       */ gpt_s0_pready               + 
  /*output      logic       */ gpt_s0_pslverr              + 
  /*output      logic [31:0]*/ i2c_s0_prdata               + 
  /*output      logic       */ i2c_s0_pready               + 
  /*output      logic       */ i2c_s0_pslverr              + 
  /*output      logic [31:0]*/ mbox_s0_prdata              + 
  /*output      logic       */ mbox_s0_pready              + 
  /*output      logic       */ mbox_s0_pslverr             + 
  /*output      logic [31:0]*/ pufcc_s0_prdata             + 
  /*output      logic       */ pufcc_s0_pready             + 
  /*output      logic       */ pufcc_s0_pslverr            + 
  /*output      logic [31:0]*/ scu_s0_prdata               + 
  /*output      logic       */ scu_s0_pready               + 
  /*output      logic       */ scu_s0_pslverr              + 
  /*output      logic [31:0]*/ spi_reg_s0_hrdata           + 
  /*output      logic       */ spi_reg_s0_hready           + 
  /*output      logic       */ spi_reg_s0_hresp            + 
  /*output      logic [31:0]*/ spi_mem_s0_hrdata           + 
  /*output      logic       */ spi_mem_s0_hready           + 
  /*output      logic       */ spi_mem_s0_hresp            + 
  /*output      logic [31:0]*/ uart_s0_prdata              + 
  /*output      logic       */ uart_s0_pready              + 
  /*output      logic       */ uart_s0_pslverr             + 
  /*output      logic [31:0]*/ uart_s1_prdata              + 
  /*output      logic       */ uart_s1_pready              + 
  /*output      logic       */ uart_s1_pslverr             + 
  /*output      logic       */ usb_s0_arready              + 
  /*output      logic       */ usb_s0_awready              + 
  /*output      logic [ 1:0]*/ usb_s0_bresp                + 
  /*output      logic       */ usb_s0_bvalid               + 
  /*output      logic [31:0]*/ usb_s0_rdata                + 
  /*output      logic [ 1:0]*/ usb_s0_rresp                + 
  /*output      logic       */ usb_s0_rvalid               + 
  /*output      logic       */ usb_s0_wready               + 
  /*output      logic [31:0]*/ bcpu_m0_haddr               + 
  /*output      logic       */ bcpu_m0_hsel                + 
  /*output      logic [ 2:0]*/ bcpu_m0_hburst              + 
  /*output      logic [ 3:0]*/ bcpu_m0_hprot               + 
  /*output      logic [ 2:0]*/ bcpu_m0_hsize               + 
  /*output      logic [ 1:0]*/ bcpu_m0_htrans              + 
  /*output      logic [31:0]*/ bcpu_m0_hwdata              + 
  /*output      logic       */ bcpu_m0_hwrite              + 
  /*output      logic [31:0]*/ dma_m0_araddr               + 
  /*output      logic [ 1:0]*/ dma_m0_arburst              + 
  /*output      logic [ 3:0]*/ dma_m0_arcache              + 
  /*output      logic [ 2:0]*/ dma_m0_arid                 + 
  /*output      logic [ 7:0]*/ dma_m0_arlen                + 
  /*output      logic       */ dma_m0_arlock               + 
  /*output      logic [ 2:0]*/ dma_m0_arprot               + 
  /*output      logic [ 2:0]*/ dma_m0_arsize               + 
  /*output      logic       */ dma_m0_arvalid              + 
  /*output      logic [31:0]*/ dma_m0_awaddr               + 
  /*output      logic [ 1:0]*/ dma_m0_awburst              + 
  /*output      logic [ 3:0]*/ dma_m0_awcache              + 
  /*output      logic [ 2:0]*/ dma_m0_awid                 + 
  /*output      logic [ 7:0]*/ dma_m0_awlen                + 
  /*output      logic       */ dma_m0_awlock               + 
  /*output      logic [ 2:0]*/ dma_m0_awprot               + 
  /*output      logic [ 2:0]*/ dma_m0_awsize               + 
  /*output      logic       */ dma_m0_awvalid              + 
  /*output      logic       */ dma_m0_bready               + 
  /*output      logic       */ dma_m0_rready               + 
  /*output      logic [31:0]*/ dma_m0_wdata                + 
  /*output      logic       */ dma_m0_wlast                + 
  /*output      logic [ 3:0]*/ dma_m0_wstrb                + 
  /*output      logic       */ dma_m0_wvalid               + 
  /*output      logic [31:0]*/ dma_m1_araddr               + 
  /*output      logic [ 1:0]*/ dma_m1_arburst              + 
  /*output      logic [ 3:0]*/ dma_m1_arcache              + 
  /*output      logic [ 2:0]*/ dma_m1_arid                 + 
  /*output      logic [ 7:0]*/ dma_m1_arlen                + 
  /*output      logic       */ dma_m1_arlock               + 
  /*output      logic [ 2:0]*/ dma_m1_arprot               + 
  /*output      logic [ 2:0]*/ dma_m1_arsize               + 
  /*output      logic       */ dma_m1_arvalid              + 
  /*output      logic [31:0]*/ dma_m1_awaddr               + 
  /*output      logic [ 1:0]*/ dma_m1_awburst              + 
  /*output      logic [ 3:0]*/ dma_m1_awcache              + 
  /*output      logic [ 2:0]*/ dma_m1_awid                 + 
  /*output      logic [ 7:0]*/ dma_m1_awlen                + 
  /*output      logic       */ dma_m1_awlock               + 
  /*output      logic [ 2:0]*/ dma_m1_awprot               + 
  /*output      logic [ 2:0]*/ dma_m1_awsize               + 
  /*output      logic       */ dma_m1_awvalid              + 
  /*output      logic       */ dma_m1_bready               + 
  /*output      logic       */ dma_m1_rready               + 
  /*output      logic [31:0]*/ dma_m1_wdata                + 
  /*output      logic       */ dma_m1_wlast                + 
  /*output      logic [ 3:0]*/ dma_m1_wstrb                + 
  /*output      logic       */ dma_m1_wvalid               + 
  /*output      logic [31:0]*/ gbe_s0_prdata               + 
  /*output      logic       */ gbe_s0_pslverr              + 
  /*output      logic [31:0]*/ gbe_m0_araddr               + 
  /*output      logic [ 1:0]*/ gbe_m0_arburst              + 
  /*output      logic [ 3:0]*/ gbe_m0_arcache              + 
  /*output      logic [ 3:0]*/ gbe_m0_arid                 + 
  /*output      logic [ 7:0]*/ gbe_m0_arlen                + 
  /*output      logic [ 1:0]*/ gbe_m0_arlock               + 
  /*output      logic [ 2:0]*/ gbe_m0_arprot               + 
  /*output      logic [ 2:0]*/ gbe_m0_arsize               + 
  /*output      logic       */ gbe_m0_arvalid              + 
  /*output      logic [31:0]*/ gbe_m0_awaddr               + 
  /*output      logic [ 1:0]*/ gbe_m0_awburst              + 
  /*output      logic [ 3:0]*/ gbe_m0_awcache              + 
  /*output      logic [ 3:0]*/ gbe_m0_awid                 + 
  /*output      logic [ 7:0]*/ gbe_m0_awlen                + 
  /*output      logic [ 1:0]*/ gbe_m0_awlock               + 
  /*output      logic [ 2:0]*/ gbe_m0_awprot               + 
  /*output      logic [ 2:0]*/ gbe_m0_awsize               + 
  /*output      logic       */ gbe_m0_awvalid              + 
  /*output      logic       */ gbe_m0_bready               + 
  /*output      logic       */ gbe_m0_rready               + 
  /*output      logic [31:0]*/ gbe_m0_wdata                + 
  /*output      logic       */ gbe_m0_wlast                + 
  /*output      logic [ 3:0]*/ gbe_m0_wstrb                + 
  /*output      logic       */ gbe_m0_wvalid               + 
  /*output      logic [31:0]*/ pufcc_m0_ar_addr            + 
  /*output      logic [ 1:0]*/ pufcc_m0_ar_burst           + 
  /*output      logic [ 3:0]*/ pufcc_m0_ar_cache           + 
  /*output      logic [ 3:0]*/ pufcc_m0_ar_id              + 
  /*output      logic [ 7:0]*/ pufcc_m0_ar_len             + 
  /*output      logic       */ pufcc_m0_ar_lock            + 
  /*output      logic [ 2:0]*/ pufcc_m0_ar_prot            + 
  /*output      logic [ 2:0]*/ pufcc_m0_ar_size            + 
  /*output      logic       */ pufcc_m0_ar_valid           + 
  /*output      logic [31:0]*/ pufcc_m0_aw_addr            + 
  /*output      logic [ 1:0]*/ pufcc_m0_aw_burst           + 
  /*output      logic [ 3:0]*/ pufcc_m0_aw_cache           + 
  /*output      logic [ 3:0]*/ pufcc_m0_aw_id              + 
  /*output      logic [ 7:0]*/ pufcc_m0_aw_len             + 
  /*output      logic       */ pufcc_m0_aw_lock            + 
  /*output      logic [ 2:0]*/ pufcc_m0_aw_prot            + 
  /*output      logic [ 2:0]*/ pufcc_m0_aw_size            + 
  /*output      logic       */ pufcc_m0_aw_valid           + 
  /*output      logic       */ pufcc_m0_b_ready            + 
  /*output      logic       */ pufcc_m0_r_ready            + 
  /*output      logic [31:0]*/ pufcc_m0_w_data             + 
  /*output      logic       */ pufcc_m0_w_last             + 
  /*output      logic [ 3:0]*/ pufcc_m0_w_strb             + 
  /*output      logic       */ pufcc_m0_w_valid            + 
  /*output      logic [31:0]*/ usb_m0_araddr               + 
  /*output      logic [ 1:0]*/ usb_m0_arburst              + 
  /*output      logic [ 3:0]*/ usb_m0_arcache              + 
  /*output      logic [ 3:0]*/ usb_m0_arid                 + 
  /*output      logic [ 3:0]*/ usb_m0_arlen                + 
  /*output      logic [ 1:0]*/ usb_m0_arlock               + 
  /*output      logic [ 2:0]*/ usb_m0_arprot               + 
  /*output      logic [ 2:0]*/ usb_m0_arsize               + 
  /*output      logic       */ usb_m0_arvalid              + 
  /*output      logic [31:0]*/ usb_m0_awaddr               + 
  /*output      logic [ 1:0]*/ usb_m0_awburst              + 
  /*output      logic [ 3:0]*/ usb_m0_awcache              + 
  /*output      logic [ 3:0]*/ usb_m0_awid                 + 
  /*output      logic [ 3:0]*/ usb_m0_awlen                + 
  /*output      logic [ 1:0]*/ usb_m0_awlock               + 
  /*output      logic [ 2:0]*/ usb_m0_awprot               + 
  /*output      logic [ 2:0]*/ usb_m0_awsize               + 
  /*output      logic       */ usb_m0_awvalid              + 
  /*output      logic       */ usb_m0_bready               + 
  /*output      logic       */ usb_m0_rready               + 
  /*output      logic [31:0]*/ usb_m0_wdata                + 
  /*output      logic       */ usb_m0_wlast                + 
  /*output      logic [ 3:0]*/ usb_m0_wstrb                + 
  /*output      logic       */ usb_m0_wvalid               + 
  /*output      logic [31:0]*/ acpu_irq_set                + 
  /*output      logic [12:0]*/ fpga_irq_set                + 
  /*output      logic       */ ace_isolation_ctl           + 
  /*output      logic       */ irq_isolation_ctl           + 
  /*output      logic       */ fcb_isolation_ctl           + 
  /*output      logic       */ ahb_isolation_ctl           + 
  /*output      logic       */ axi1_isolation_ctl          + 
  /*output      logic       */ axi0_isolation_ctl          + 
  /*output      logic       */ scl_o                       + 
  /*output      logic       */ spi_clk_oe                  + 
  /*output      logic       */ spi_clk_out                 + 
  /*output      logic [31:0]*/ gpio_pulldown               + 
  /*output      logic [31:0]*/ gpio_pullup                 + 
  /*output      logic [ 3:0]*/ dma_ack_fpga                + 
  /*output      logic       */ mdio_mdc                    + 
  /*output      logic       */ gbe_mdio_out                + 
  /*output      logic       */ gbe_mdio_en                 + 
  /*output      logic       */ bcpu_jtag_tdo               + 
  /*output      logic [ 1:0]*/ jtag_control                + 
  /*output      logic [ 1:0]*/ fpga_pll3_clk_sel           + 
  /*output      logic [ 1:0]*/ fpga_pll2_clk_sel           + 
  /*output      logic [ 1:0]*/ fpga_pll1_clk_sel           + 
  /*output      logic [ 1:0]*/ fpga_pll0_clk_sel           + 
  /*output      logic       */ testmode ;                    






endmodule


