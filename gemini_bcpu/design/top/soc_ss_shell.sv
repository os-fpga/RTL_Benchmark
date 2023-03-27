module soc_ss (
    // input clock control
    input  logic        clk_sel0                   ,
    input  logic        clk_sel1                   ,
    // input OSC clock
    input  logic        clk_osc                    ,
    // input ref PLL clock
    input  logic        clk_xtal_ref               ,
    // input PLL clocks
    input  logic        clk_soc_pll0               ,
    input  logic        clk_soc_pll1               ,
    // input power on reset
    input  logic        rst_n_poweron              ,
    // input FPGA clocks
    input  logic        clk_fpga0                  ,
    input  logic        clk_fpga1                  ,
    input  logic        clk_fpga_s                 ,
    output logic        rst_n_fpga0                ,
    output logic        rst_n_fpga1                ,
    output logic        rst_n_fpga_s               ,
    // test mode
    input  logic        test_mode                  ,
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
    input  logic        scl_i                      ,
    // QSPI interface signals
    input  logic        spi_clk_in                 ,
    output logic        spi_clk_oe                 ,
    output logic        spi_clk_out                ,
    // GPIO interface signals
    output logic [31:0] gpio_pulldown              ,
    output logic [31:0] gpio_pullup                ,
    // GPT interface signals
    input  logic        rtc_clk                    ,
    input  logic        pit_pause                  ,
    // GbE interface signals
    output logic [ 3:0] rgmii_txd                  ,
    output logic        rgmii_tx_ctl               ,
    input  logic [ 3:0] rgmii_rxd                  ,
    input  logic        rgmii_rx_ctl               ,
    input  logic        rgmii_rxc                  ,
    output logic        mdio_mdc                   ,
    inout  wire         mdio_data                  ,
    // USB interface signals
    inout  wire         usb_dp                     ,
    inout  wire  [31:0] usb_dn                     ,
    input  logic        usb_xtal_in                ,
    output logic        usb_xtal_out               ,
    // FCB interface signals
    output logic [31:0] fcb_out                    ,
    // PAD control
    input  logic [31:0] pad_c                      ,
    output logic [31:0] pad_pu                     ,
    output logic [31:0] pad_pd                     ,
    output logic [31:0] pad_i                      ,
    output logic [31:0] pad_oen                    ,
    output logic [31:0] pad_ds0                    ,
    output logic [31:0] pad_ds1                    ,
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
    //FPGA configuration interface
    output logic        clb_sel                    ,
    output logic [31:0] pwdata                     ,
    input  logic        pready                     ,
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

endmodule
