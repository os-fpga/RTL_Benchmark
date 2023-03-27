set prjName soc_ss_prj
project::setCurrentProject  $prjName

#connection beetwen config_ss and rsnoc
component::setCurrentComponent {Vendor Library soc_config_subsystem 1.0}

component::automapBusInterface -name config_ss_scu_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR scu_s0_paddr} {PSELx scu_s0_psel} {PENABLE scu_s0_penable} {PWRITE scu_s0_pwrite} {PRDATA scu_s0_prdata} {PWDATA scu_s0_pwdata} {PREADY scu_s0_pready} {PSLVERR scu_s0_pslverr}} -verbose
component::automapBusInterface -name config_ss_acpu_wdt_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR acpu_wdt_s0_paddr} {PSELx acpu_wdt_s0_psel} {PENABLE acpu_wdt_s0_penable} {PWRITE acpu_wdt_s0_pwrite} {PRDATA acpu_wdt_s0_prdata} {PWDATA acpu_wdt_s0_pwdata} {PREADY acpu_wdt_s0_pready} {PSLVERR acpu_wdt_s0_pslverr}} -verbose
component::automapBusInterface -name config_ss_bcpu_wdt_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR bcpu_wdt_s0_paddr} {PSELx bcpu_wdt_s0_psel} {PENABLE bcpu_wdt_s0_penable} {PWRITE bcpu_wdt_s0_pwrite} {PRDATA bcpu_wdt_s0_prdata} {PWDATA bcpu_wdt_s0_pwdata} {PREADY bcpu_wdt_s0_pready} {PSLVERR bcpu_wdt_s0_pslverr}}
component::automapBusInterface -name config_ss_fcb_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR fcb_s0_paddr} {PSELx fcb_s0_psel} {PENABLE fcb_s0_penable} {PWRITE fcb_s0_pwrite} {PRDATA fcb_s0_prdata} {PWDATA fcb_s0_pwdata} {PREADY fcb_s0_pready} {PSLVERR fcb_s0_pslverr}}
component::automapBusInterface -name config_ss_gpio_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR gpio_s0_paddr} {PSELx gpio_s0_psel} {PENABLE gpio_s0_penable} {PWRITE gpio_s0_pwrite} {PRDATA gpio_s0_prdata} {PWDATA gpio_s0_pwdata} {PREADY gpio_s0_pready} {PSLVERR gpio_s0_pslverr}}
component::automapBusInterface -name config_ss_gpt_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR gpt_s0_paddr} {PSELx gpt_s0_psel} {PENABLE gpt_s0_penable} {PWRITE gpt_s0_pwrite} {PRDATA gpt_s0_prdata} {PWDATA gpt_s0_pwdata} {PREADY gpt_s0_pready} {PSLVERR gpt_s0_pslverr}}
component::automapBusInterface -name config_ss_i2c_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR i2c_s0_paddr} {PSELx i2c_s0_psel} {PENABLE i2c_s0_penable} {PWRITE i2c_s0_pwrite} {PRDATA i2c_s0_prdata} {PWDATA i2c_s0_pwdata} {PREADY i2c_s0_pready} {PSLVERR i2c_s0_pslverr}}
component::automapBusInterface -name config_ss_uart_s0_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR uart_s0_paddr} {PSELx uart_s0_psel} {PENABLE uart_s0_penable} {PWRITE uart_s0_pwrite} {PRDATA uart_s0_prdata} {PWDATA uart_s0_pwdata} {PREADY uart_s0_pready} {PSLVERR uart_s0_pslverr}}
component::automapBusInterface -name config_ss_uart_s1_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR uart_s1_paddr} {PSELx uart_s1_psel} {PENABLE uart_s1_penable} {PWRITE uart_s1_pwrite} {PRDATA uart_s1_prdata} {PWDATA uart_s1_pwdata} {PREADY uart_s1_pready} {PSLVERR uart_s1_pslverr}}
component::automapBusInterface -name config_ss_mbox_s0_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR mbox_s0_paddr} {PSELx mbox_s0_psel} {PENABLE mbox_s0_penable} {PWRITE mbox_s0_pwrite} {PRDATA mbox_s0_prdata} {PWDATA mbox_s0_pwdata} {PREADY mbox_s0_pready} {PSLVERR mbox_s0_pslverr}}
component::automapBusInterface -name config_ss_dma_s0_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR dma_s0_paddr} {PSELx dma_s0_psel} {PENABLE dma_s0_penable} {PWRITE dma_s0_pwrite} {PRDATA dma_s0_prdata} {PWDATA dma_s0_pwdata} {PREADY dma_s0_pready} {PSLVERR dma_s0_pslverr}}
component::automapBusInterface -name config_ss_gbe_apb -mode slave -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR gbe_s0_paddr} {PSELx gbe_s0_psel} {PENABLE gbe_s0_penable} {PWRITE gbe_s0_pwrite} {PRDATA gbe_s0_prdata} {PWDATA gbe_s0_pwdata} {PREADY gbe_s0_pready} {PSLVERR gbe_s0_pslverr}}
component::automapBusInterface -name config_ss_spi_s0_reg_ahb -mode slave -absdef {amba.com AMBA2 AHB_rtl r3p0_1}  -manualmap { {HADDR spi_reg_s0_haddr} {HRDATA spi_reg_s0_hrdata} {HREADYOUT spi_reg_s0_hready} {HRESP spi_reg_s0_hresp} {HSELx spi_reg_s0_hsel} {HTRANS spi_reg_s0_htrans} {HWDATA spi_reg_s0_hwdata} {HWRITE spi_reg_s0_hwrite}}
component::automapBusInterface -name config_ss_spi_s0_mem_ahb -mode slave -absdef {amba.com AMBA2 AHB_rtl r3p0_1}  -manualmap { {HADDR spi_mem_s0_haddr} {HRDATA spi_mem_s0_hrdata} {HREADYOUT spi_mem_s0_hready} {HRESP spi_mem_s0_hresp} {HSELx spi_mem_s0_hsel} {HTRANS spi_mem_s0_htrans} {HWRITE spi_mem_s0_hwrite}}
component::automapBusInterface -name config_ss_usb_s0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {{ARADDR usb_s0_araddr} {ARPROT usb_s0_arprot} {ARREADY usb_s0_arready} {ARVALID usb_s0_arvalid} {AWADDR usb_s0_awaddr} {AWPROT usb_s0_awprot} {AWREADY usb_s0_awready} {AWVALID usb_s0_awvalid} {BREADY usb_s0_bready} {BRESP usb_s0_bresp} {BVALID usb_s0_bvalid} {RDATA usb_s0_rdata} {RREADY usb_s0_rready} {RRESP usb_s0_rresp} {RVALID usb_s0_rvalid} {WDATA usb_s0_wdata} {WREADY usb_s0_wready} {WSTRB usb_s0_wstrb} {WVALID usb_s0_wvalid}}
component::automapBusInterface -name config_ss_usb_m0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR usb_m0_araddr} {ARBURST usb_m0_arburst} {ARCACHE usb_m0_arcache} {ARID usb_m0_arid} {ARLEN usb_m0_arlen} {ARLOCK usb_m0_arlock} {ARPROT usb_m0_arprot} {ARREADY usb_m0_arready} {ARSIZE usb_m0_arsize} {ARVALID usb_m0_arvalid} {AWADDR usb_m0_awaddr} {AWBURST usb_m0_awburst} {AWCACHE usb_m0_awcache} {AWID usb_m0_awid} {AWLEN usb_m0_awlen} {AWLOCK usb_m0_awlock} {AWPROT usb_m0_awprot} {AWREADY usb_m0_awready} {AWSIZE usb_m0_awsize} {AWVALID usb_m0_awvalid} {BID usb_m0_bid} {BREADY usb_m0_bready} {BRESP usb_m0_bresp} {BVALID usb_m0_bvalid} {RDATA usb_m0_rdata} {RID usb_m0_rid} {RLAST usb_m0_rlast} {RREADY usb_m0_rready} {RRESP usb_m0_rresp} {RVALID usb_m0_rvalid} {WDATA usb_m0_wdata} {WLAST usb_m0_wlast} {WREADY usb_m0_wready} {WSTRB usb_m0_wstrb} {WVALID usb_m0_wvalid}}
component::automapBusInterface -name config_ss_dma_m0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR dma_m0_araddr} {ARBURST dma_m0_arburst} {ARCACHE dma_m0_arcache} {ARID dma_m0_arid} {ARLEN dma_m0_arlen} {ARLOCK dma_m0_arlock} {ARPROT dma_m0_arprot} {ARREADY dma_m0_arready} {ARSIZE dma_m0_arsize} {ARVALID dma_m0_arvalid} {AWADDR dma_m0_awaddr} {AWBURST dma_m0_awburst} {AWCACHE dma_m0_awcache} {AWID dma_m0_awid} {AWLEN dma_m0_awlen} {AWLOCK dma_m0_awlock} {AWPROT dma_m0_awprot} {AWREADY dma_m0_awready} {AWSIZE dma_m0_awsize} {AWVALID dma_m0_awvalid} {BID dma_m0_bid} {BREADY dma_m0_bready} {BRESP dma_m0_bresp} {BVALID dma_m0_bvalid} {RDATA dma_m0_rdata} {RID dma_m0_rid} {RLAST dma_m0_rlast} {RREADY dma_m0_rready} {RRESP dma_m0_rresp} {RVALID dma_m0_rvalid} {WDATA dma_m0_wdata} {WLAST dma_m0_wlast} {WREADY dma_m0_wready} {WSTRB dma_m0_wstrb} {WVALID dma_m0_wvalid}}
component::automapBusInterface -name config_ss_dma_m1_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR dma_m1_araddr} {ARBURST dma_m1_arburst} {ARCACHE dma_m1_arcache} {ARID dma_m1_arid} {ARLEN dma_m1_arlen} {ARLOCK dma_m1_arlock} {ARPROT dma_m1_arprot} {ARREADY dma_m1_arready} {ARSIZE dma_m1_arsize} {ARVALID dma_m1_arvalid} {AWADDR dma_m1_awaddr} {AWBURST dma_m1_awburst} {AWCACHE dma_m1_awcache} {AWID dma_m1_awid} {AWLEN dma_m1_awlen} {AWLOCK dma_m1_awlock} {AWPROT dma_m1_awprot} {AWREADY dma_m1_awready} {AWSIZE dma_m1_awsize} {AWVALID dma_m1_awvalid} {BID dma_m1_bid} {BREADY dma_m1_bready} {BRESP dma_m1_bresp} {BVALID dma_m1_bvalid} {RDATA dma_m1_rdata} {RID dma_m1_rid} {RLAST dma_m1_rlast} {RREADY dma_m1_rready} {RRESP dma_m1_rresp} {RVALID dma_m1_rvalid} {WDATA dma_m1_wdata} {WLAST dma_m1_wlast} {WREADY dma_m1_wready} {WSTRB dma_m1_wstrb} {WVALID dma_m1_wvalid}}
component::automapBusInterface -name config_ss_gbe_m0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR gbe_m0_araddr} {ARBURST gbe_m0_arburst} {ARCACHE gbe_m0_arcache} {ARID gbe_m0_arid} {ARLEN gbe_m0_arlen} {ARLOCK gbe_m0_arlock} {ARPROT gbe_m0_arprot} {ARREADY gbe_m0_arready} {ARSIZE gbe_m0_arsize} {ARVALID gbe_m0_arvalid} {AWADDR gbe_m0_awaddr} {AWBURST gbe_m0_awburst} {AWCACHE gbe_m0_awcache} {AWID gbe_m0_awid} {AWLEN gbe_m0_awlen} {AWLOCK gbe_m0_awlock} {AWPROT gbe_m0_awprot} {AWREADY gbe_m0_awready} {AWSIZE gbe_m0_awsize} {AWVALID gbe_m0_awvalid} {BID gbe_m0_bid} {BREADY gbe_m0_bready} {BRESP gbe_m0_bresp} {BVALID gbe_m0_bvalid} {RDATA gbe_m0_rdata} {RID gbe_m0_rid} {RLAST gbe_m0_rlast} {RREADY gbe_m0_rready} {RRESP gbe_m0_rresp} {RVALID gbe_m0_rvalid} {WDATA gbe_m0_wdata} {WLAST gbe_m0_wlast} {WREADY gbe_m0_wready} {WSTRB gbe_m0_wstrb} {WVALID gbe_m0_wvalid}}
component::automapBusInterface -name config_ss_bcpu_m0_ahb_lite -mode master -absdef {amba.com AMBA3 AHBLite_rtl r2p0_0}  -manualmap  {{HADDR bcpu_m0_haddr} {HBURST bcpu_m0_hburst} {HPROT bcpu_m0_hprot} {HRDATA bcpu_m0_hrdata} {HREADY bcpu_m0_hready} {HRESP bcpu_m0_hresp} {HSIZE bcpu_m0_hsize} {HTRANS bcpu_m0_htrans} {HWDATA bcpu_m0_hwdata} {HWRITE bcpu_m0_hwrite}}
component::save

component::setCurrentComponent {Vendor Library rsnoc 1.0}

component::automapBusInterface -name rsnoc_soc_scu_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR SCU_PAddr} {PSELx SCU_PSel} {PENABLE SCU_PEnable} {PWRITE SCU_PWrite} {PRDATA SCU_PRData} {PWDATA SCU_PWData} {PREADY SCU_PReady} {PSLVERR SCU_PSlvErr}} -verbose
component::automapBusInterface -name rsnoc_acpu_wdt_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR ACPU_WDT_PAddr} {PSELx ACPU_WDT_PSel} {PENABLE ACPU_WDT_PEnable} {PWRITE ACPU_WDT_PWrite} {PRDATA ACPU_WDT_PRData} {PWDATA ACPU_WDT_PWData} {PREADY ACPU_WDT_PReady} {PSLVERR ACPU_WDT_PSlvErr}} -verbose
component::automapBusInterface -name rsnoc_bcpu_wdt_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR BCPU_WDT_PAddr} {PSELx BCPU_WDT_PSel} {PENABLE BCPU_WDT_PEnable} {PWRITE BCPU_WDT_PWrite} {PRDATA BCPU_WDT_PRData} {PWDATA BCPU_WDT_PWData} {PREADY BCPU_WDT_PReady} {PSLVERR BCPU_WDT_PSlvErr}} -verbose
component::automapBusInterface -name rsnoc_fcb_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR FCB_apb_s0_paddr} {PSELx FCB_apb_s0_psel} {PENABLE FCB_apb_s0_penable} {PWRITE FCB_apb_s0_pwrite} {PRDATA FCB_apb_s0_prdata} {PWDATA FCB_apb_s0_pwdata} {PREADY FCB_apb_s0_pready} {PSLVERR FCB_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_gpio_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR GPIO_apb_s0_paddr} {PSELx GPIO_apb_s0_psel} {PENABLE GPIO_apb_s0_penable} {PWRITE GPIO_apb_s0_pwrite} {PRDATA GPIO_apb_s0_prdata} {PWDATA GPIO_apb_s0_pwdata} {PREADY GPIO_apb_s0_pready} {PSLVERR GPIO_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_gpt_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR GPT_apb_s0_paddr} {PSELx GPT_apb_s0_psel} {PENABLE GPT_apb_s0_penable} {PWRITE GPT_apb_s0_pwrite} {PRDATA GPT_apb_s0_prdata} {PWDATA GPT_apb_s0_pwdata} {PREADY GPT_apb_s0_pready} {PSLVERR GPT_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_i2c_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR I2C_apb_s0_paddr} {PSELx I2C_apb_s0_psel} {PENABLE I2C_apb_s0_penable} {PWRITE I2C_apb_s0_pwrite} {PRDATA I2C_apb_s0_prdata} {PWDATA I2C_apb_s0_pwdata} {PREADY I2C_apb_s0_pready} {PSLVERR I2C_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_uart_s0_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR UART_apb_s0_paddr} {PSELx UART_apb_s0_psel} {PENABLE UART_apb_s0_penable} {PWRITE UART_apb_s0_pwrite} {PRDATA UART_apb_s0_prdata} {PWDATA UART_apb_s0_pwdata} {PREADY UART_apb_s0_pready} {PSLVERR UART_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_uart_s1_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR UART_apb_s1_paddr} {PSELx UART_apb_s1_psel} {PENABLE UART_apb_s1_penable} {PWRITE UART_apb_s1_pwrite} {PRDATA UART_apb_s1_prdata} {PWDATA UART_apb_s1_pwdata} {PREADY UART_apb_s1_pready} {PSLVERR UART_apb_s1_pslverr}} -verbose
component::automapBusInterface -name rsnoc_ss_mbox_s0_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR MBOX_apb_s0_paddr} {PSELx MBOX_apb_s0_psel} {PENABLE MBOX_apb_s0_penable} {PWRITE MBOX_apb_s0_pwrite} {PRDATA MBOX_apb_s0_prdata} {PWDATA MBOX_apb_s0_pwdata} {PREADY MBOX_apb_s0_pready} {PSLVERR MBOX_apb_s0_pslverr}} -verbose
component::automapBusInterface -name rsnoc_dma_s0_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap {{PADDR DMA_apb_s0_paddr} {PENABLE DMA_apb_s0_penable} {PRDATA DMA_apb_s0_prdata} {PREADY DMA_apb_s0_pready} {PSELx DMA_apb_s0_psel} {PSLVERR DMA_apb_s0_pslverr} {PWDATA DMA_apb_s0_pwdata} {PWRITE DMA_apb_s0_pwrite}}
component::automapBusInterface -name rsnoc_gbe_apb -mode master -absdef {amba.com AMBA3 APB_rtl r2p0_0}  -manualmap { {PADDR gbe_apb_s0_paddr} {PSELx gbe_apb_s0_psel} {PENABLE gbe_apb_s0_penable} {PWRITE gbe_apb_s0_pwrite} {PRDATA gbe_apb_s0_prdata} {PWDATA gbe_apb_s0_pwdata} {PREADY gbe_apb_s0_pready} {PSLVERR gbe_apb_s0_pslverr}}
component::automapBusInterface -name rsnoc_spi_s0_reg_ahb -mode master -absdef {amba.com AMBA2 AHB_rtl r3p0_1}  -manualmap {{HADDR SPI_ahb_s0_haddr} {HBURST SPI_ahb_s0_hburst} {HMASTLOCK SPI_ahb_s0_hmastlock} {HPROT SPI_ahb_s0_hprot} {HRDATA SPI_ahb_s0_hrdata} {HREADY SPI_ahb_s0_hready} {HRESP SPI_ahb_s0_hresp} {HSELx SPI_ahb_s0_hsel} {HSIZE SPI_ahb_s0_hsize} {HTRANS SPI_ahb_s0_htrans} {HWDATA SPI_ahb_s0_hwdata} {HWRITE SPI_ahb_s0_hwrite}}
component::automapBusInterface -name rsnoc_spi_s0_mem_ahb -mode master -absdef {amba.com AMBA2 AHB_rtl r3p0_1}  -manualmap {{HADDR SPI_mem_ahb_haddr} {HBURST SPI_mem_ahb_hburst} {HMASTLOCK SPI_mem_ahb_hmastlock} {HPROT SPI_mem_ahb_hprot} {HRDATA SPI_mem_ahb_hrdata} {HREADY SPI_mem_ahb_hready} {HRESP SPI_mem_ahb_hresp} {HSELx SPI_mem_ahb_hsel} {HSIZE SPI_mem_ahb_hsize} {HTRANS SPI_mem_ahb_htrans} {HWDATA SPI_mem_ahb_hwdata} {HWRITE SPI_mem_ahb_hwrite}}
component::automapBusInterface -name rsnoc_usb_s0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {{ARADDR USB_axi_s0_ar_addr} {ARPROT USB_axi_s0_ar_prot} {ARREADY USB_axi_s0_ar_ready} {ARVALID USB_axi_s0_ar_valid} {AWADDR USB_axi_s0_aw_addr} {AWPROT USB_axi_s0_aw_prot} {AWREADY USB_axi_s0_aw_ready} {AWVALID USB_axi_s0_aw_valid} {BREADY USB_axi_s0_b_ready} {BRESP USB_axi_s0_b_resp} {BVALID USB_axi_s0_b_valid} {RDATA USB_axi_s0_r_data} {RREADY USB_axi_s0_r_ready} {RRESP USB_axi_s0_r_resp} {RVALID USB_axi_s0_r_valid} {WDATA USB_axi_s0_w_data} {WREADY USB_axi_s0_w_ready} {WSTRB USB_axi_s0_w_strb} {WVALID USB_axi_s0_w_valid}}
component::automapBusInterface -name rsnoc_usb_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR usb_axi_m0_ar_addr} {ARBURST usb_axi_m0_ar_burst} {ARCACHE usb_axi_m0_ar_cache} {ARID usb_axi_m0_ar_id} {ARLEN usb_axi_m0_ar_len} {ARLOCK usb_axi_m0_ar_lock} {ARPROT usb_axi_m0_ar_prot} {ARREADY usb_axi_m0_ar_ready} {ARSIZE usb_axi_m0_ar_size} {ARVALID usb_axi_m0_ar_valid} {AWADDR usb_axi_m0_aw_addr} {AWBURST usb_axi_m0_aw_burst} {AWCACHE usb_axi_m0_aw_cache} {AWID usb_axi_m0_aw_id} {AWLEN usb_axi_m0_aw_len} {AWLOCK usb_axi_m0_aw_lock} {AWPROT usb_axi_m0_aw_prot} {AWREADY usb_axi_m0_aw_ready} {AWSIZE usb_axi_m0_aw_size} {AWVALID usb_axi_m0_aw_valid} {BID usb_axi_m0_b_id} {BREADY usb_axi_m0_b_ready} {BRESP usb_axi_m0_b_resp} {BVALID usb_axi_m0_b_valid} {RDATA usb_axi_m0_r_data} {RID usb_axi_m0_r_id} {RLAST usb_axi_m0_r_last} {RREADY usb_axi_m0_r_ready} {RRESP usb_axi_m0_r_resp} {RVALID usb_axi_m0_r_valid} {WDATA usb_axi_m0_w_data} {WLAST usb_axi_m0_w_last} {WREADY usb_axi_m0_w_ready} {WSTRB usb_axi_m0_w_strb} {WVALID usb_axi_m0_w_valid}}
component::automapBusInterface -name rsnoc_dma_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR dma_axi_m0_ar_addr}  {ARBURST dma_axi_m0_ar_burst}  {ARCACHE dma_axi_m0_ar_cache}  {ARID dma_axi_m0_ar_id}  {ARLEN dma_axi_m0_ar_len}  {ARLOCK dma_axi_m0_ar_lock} {ARPROT dma_axi_m0_ar_prot}  {ARREADY dma_axi_m0_ar_ready}  {ARSIZE dma_axi_m0_ar_size}  {ARVALID dma_axi_m0_ar_valid}  {AWADDR dma_axi_m0_aw_addr}  {AWBURST dma_axi_m0_aw_burst}  {AWCACHE dma_axi_m0_aw_cache}  {AWID dma_axi_m0_aw_id}  {AWLEN dma_axi_m0_aw_len}  {AWLOCK dma_axi_m0_aw_lock}  {AWPROT dma_axi_m0_aw_prot}  {AWREADY dma_axi_m0_aw_ready}  {AWSIZE dma_axi_m0_aw_size}  {AWVALID dma_axi_m0_aw_valid}  {BID dma_axi_m0_b_id}  {BREADY dma_axi_m0_b_ready}  {BRESP dma_axi_m0_b_resp}  {BVALID dma_axi_m0_b_valid}  {RDATA dma_axi_m0_r_data}  {RID dma_axi_m0_r_id}  {RLAST dma_axi_m0_r_last}  {RREADY dma_axi_m0_r_ready}  {RRESP dma_axi_m0_r_resp} {RVALID dma_axi_m0_r_valid}  {WDATA dma_axi_m0_w_data}  {WLAST dma_axi_m0_w_last}  {WREADY dma_axi_m0_w_ready}  {WSTRB dma_axi_m0_w_strb}  {WVALID dma_axi_m0_w_valid}}
component::automapBusInterface -name rsnoc_dma_m1_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR dma_axi_m1_ar_addr}  {ARBURST dma_axi_m1_ar_burst}  {ARCACHE dma_axi_m1_ar_cache}  {ARID dma_axi_m1_ar_id}  {ARLEN dma_axi_m1_ar_len}  {ARLOCK dma_axi_m1_ar_lock} {ARPROT dma_axi_m1_ar_prot}  {ARREADY dma_axi_m1_ar_ready}  {ARSIZE dma_axi_m1_ar_size}  {ARVALID dma_axi_m1_ar_valid}  {AWADDR dma_axi_m1_aw_addr}  {AWBURST dma_axi_m1_aw_burst}  {AWCACHE dma_axi_m1_aw_cache}  {AWID dma_axi_m1_aw_id}  {AWLEN dma_axi_m1_aw_len}  {AWLOCK dma_axi_m1_aw_lock}  {AWPROT dma_axi_m1_aw_prot}  {AWREADY dma_axi_m1_aw_ready}  {AWSIZE dma_axi_m1_aw_size}  {AWVALID dma_axi_m1_aw_valid}  {BID dma_axi_m1_b_id}  {BREADY dma_axi_m1_b_ready}  {BRESP dma_axi_m1_b_resp}  {BVALID dma_axi_m1_b_valid}  {RDATA dma_axi_m1_r_data}  {RID dma_axi_m1_r_id}  {RLAST dma_axi_m1_r_last}  {RREADY dma_axi_m1_r_ready}  {RRESP dma_axi_m1_r_resp} {RVALID dma_axi_m1_r_valid}  {WDATA dma_axi_m1_w_data}  {WLAST dma_axi_m1_w_last}  {WREADY dma_axi_m1_w_ready}  {WSTRB dma_axi_m1_w_strb}  {WVALID dma_axi_m1_w_valid}}
component::automapBusInterface -name rsnoc_gbe_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR gbe_axi_m0_ar_addr}  {ARBURST gbe_axi_m0_ar_burst}  {ARCACHE gbe_axi_m0_ar_cache}  {ARID gbe_axi_m0_ar_id}  {ARLEN gbe_axi_m0_ar_len}  {ARLOCK gbe_axi_m0_ar_lock} {ARPROT gbe_axi_m0_ar_prot}  {ARREADY gbe_axi_m0_ar_ready}  {ARSIZE gbe_axi_m0_ar_size}  {ARVALID gbe_axi_m0_ar_valid}  {AWADDR gbe_axi_m0_aw_addr}  {AWBURST gbe_axi_m0_aw_burst}  {AWCACHE gbe_axi_m0_aw_cache}  {AWID gbe_axi_m0_aw_id}  {AWLEN gbe_axi_m0_aw_len}  {AWLOCK gbe_axi_m0_aw_lock}  {AWPROT gbe_axi_m0_aw_prot}  {AWREADY gbe_axi_m0_aw_ready}  {AWSIZE gbe_axi_m0_aw_size}  {AWVALID gbe_axi_m0_aw_valid}  {BID gbe_axi_m0_b_id}  {BREADY gbe_axi_m0_b_ready}  {BRESP gbe_axi_m0_b_resp}  {BVALID gbe_axi_m0_b_valid}  {RDATA gbe_axi_m0_r_data}  {RID gbe_axi_m0_r_id}  {RLAST gbe_axi_m0_r_last}  {RREADY gbe_axi_m0_r_ready}  {RRESP gbe_axi_m0_r_resp} {RVALID gbe_axi_m0_r_valid}  {WDATA gbe_axi_m0_w_data}  {WLAST gbe_axi_m0_w_last}  {WREADY gbe_axi_m0_w_ready}  {WSTRB gbe_axi_m0_w_strb}  {WVALID gbe_axi_m0_w_valid}}
component::automapBusInterface -name rsnoc_bcpu_m0_ahb_lite -mode slave -absdef {amba.com AMBA3 AHBLite_rtl r2p0_0}  -manualmap  { {HADDR bcpu_ahb_m0_haddr}  {HBURST bcpu_ahb_m0_hburst}  {HPROT bcpu_ahb_m0_hprot}  {HRDATA bcpu_ahb_m0_hrdata}  {HREADY bcpu_ahb_m0_hready}  {HRESP bcpu_ahb_m0_hresp}  {HSIZE bcpu_ahb_m0_hsize}  {HTRANS bcpu_ahb_m0_htrans}  {HWDATA bcpu_ahb_m0_hwdata}  {HWRITE bcpu_ahb_m0_hwrite}}
component::save


design::setCurrentDesign {Vendor Library soc_ss_arch 1.0}
design::createInterconnection config_ss config_ss_scu_apb          flexnoc rsnoc_soc_scu_apb -name config_ss_config_ss_scu_apb__flexnoc_rsnoc_soc_scu_apb
design::createInterconnection config_ss config_ss_acpu_wdt_apb     flexnoc rsnoc_acpu_wdt_apb -name config_ss_config_ss_acpu_wdt_apb__flexnoc_rsnoc_acpu_wdt_apb
design::createInterconnection config_ss config_ss_bcpu_wdt_apb     flexnoc rsnoc_bcpu_wdt_apb -name config_ss_config_ss_bcpu_wdt_apb__flexnoc_rsnoc_bcpu_wdt_apb
design::createInterconnection config_ss config_ss_fcb_apb          flexnoc rsnoc_fcb_apb -name config_ss_config_ss_fcb_apb__flexnoc_rsnoc_fcb_apb
design::createInterconnection config_ss config_ss_gpio_apb         flexnoc rsnoc_gpio_apb -name config_ss_config_ss_gpio_apb__flexnoc_rsnoc_gpio_apb
design::createInterconnection config_ss config_ss_gpt_apb          flexnoc rsnoc_gpt_apb -name config_ss_config_ss_gpt_apb__flexnoc_rsnoc_gpt_apb
design::createInterconnection config_ss config_ss_i2c_apb          flexnoc rsnoc_i2c_apb -name config_ss_config_ss_i2c_apb__flexnoc_rsnoc_i2c_apb
design::createInterconnection config_ss config_ss_uart_s0_apb      flexnoc rsnoc_uart_s0_apb -name config_ss_config_ss_uart_s0_apb__flexnoc_rsnoc_uart_s0_apb
design::createInterconnection config_ss config_ss_uart_s1_apb      flexnoc rsnoc_uart_s1_apb -name config_ss_config_ss_uart_s1_apb__flexnoc_rsnoc_uart_s1_apb
design::createInterconnection config_ss config_ss_mbox_s0_apb      flexnoc rsnoc_ss_mbox_s0_apb -name config_ss_config_ss_mbox_s0_apb__flexnoc_rsnoc_ss_mbox_s0_apb
design::createInterconnection config_ss config_ss_dma_s0_apb       flexnoc rsnoc_dma_s0_apb -name config_ss_config_ss_config_ss_dma_s0_apb__flexnoc_rsnoc_dma_s0_apb
design::createInterconnection config_ss config_ss_gbe_apb          flexnoc rsnoc_gbe_apb -name config_ss_config_ss_config_ss_gbe_apb__flexnoc_rsnoc_gbe_apb
design::createInterconnection config_ss config_ss_spi_s0_reg_ahb   flexnoc rsnoc_spi_s0_reg_ahb -name config_ss_config_ss_config_ss_spi_s0_reg_ahb__flexnoc_rsnoc_spi_s0_reg_ahb
design::createInterconnection config_ss config_ss_spi_s0_mem_ahb   flexnoc rsnoc_spi_s0_mem_ahb -name config_ss_config_ss_config_ss_spi_s0_mem_ahb__flexnoc_rsnoc_spi_s0_mem_ahb
design::createInterconnection config_ss config_ss_usb_s0_axi       flexnoc rsnoc_usb_s0_axi -name config_ss_config_ss_config_ss_usb_s0_axi__flexnoc_rsnoc_usb_s0_axi
design::createInterconnection config_ss config_ss_usb_m0_axi       flexnoc rsnoc_usb_m0_axi -name config_ss_config_ss_config_ss_usb_m0_axi__flexnoc_rsnoc_usb_m0_axi
design::createInterconnection config_ss config_ss_dma_m0_axi       flexnoc rsnoc_dma_m0_axi -name config_ss_config_ss_config_ss_dma_m0_axi__flexnoc_rsnoc_dma_m0_axi
design::createInterconnection config_ss config_ss_dma_m1_axi       flexnoc rsnoc_dma_m1_axi -name config_ss_config_ss_config_ss_dma_m1_axi__flexnoc_rsnoc_dma_m1_axi
design::createInterconnection config_ss config_ss_gbe_m0_axi       flexnoc rsnoc_gbe_m0_axi -name config_ss_config_ss_config_ss_gbe_m0_axi__flexnoc_rsnoc_gbe_m0_axi
design::createInterconnection config_ss config_ss_bcpu_m0_ahb_lite flexnoc rsnoc_bcpu_m0_ahb_lite -name config_ss_config_ss_config_ss_bcpu_m0_ahb_lite__flexnoc_rsnoc_bcpu_m0_ahb_lite
design::save


#connection beetwen flexnoc and memss
component::setCurrentComponent {Vendor Library memss 1.0}
component::automapBusInterface -name mem_ss_ddr_s0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr0_araddr}  {ARBURST ddr0_arburst}  {ARCACHE ddr0_arcache}  {ARID ddr0_arid}  {ARLEN ddr0_arlen}  {ARLOCK ddr0_arlock}  {ARPROT ddr0_arprot}  {ARREADY ddr0_arready}  {ARSIZE ddr0_arsize}  {ARVALID ddr0_arvalid}  {AWADDR ddr0_awaddr}  {AWBURST ddr0_awburst}  {AWCACHE ddr0_awcache}  {AWID ddr0_awid}  {AWLEN ddr0_awlen}  {AWLOCK ddr0_awlock}  {AWPROT ddr0_awprot}  {AWREADY ddr0_awready}  {AWSIZE ddr0_awsize}  {AWVALID ddr0_awvalid}  {BID ddr0_bid}  {BREADY ddr0_bready}  {BRESP ddr0_bresp}  {BVALID ddr0_bvalid}  {RDATA ddr0_rdata}  {RID ddr0_rid}  {RLAST ddr0_rlast}  {RREADY ddr0_rready}  {RRESP ddr0_rresp}  {RVALID ddr0_rvalid}  {WDATA ddr0_wdata}  {WLAST ddr0_wlast}  {WREADY ddr0_wready}  {WSTRB ddr0_wstrb}  {WVALID ddr0_wvalid}}
component::automapBusInterface -name mem_ss_ddr_s1_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr1_araddr}  {ARBURST ddr1_arburst}  {ARCACHE ddr1_arcache}  {ARID ddr1_arid}  {ARLEN ddr1_arlen}  {ARLOCK ddr1_arlock}  {ARPROT ddr1_arprot}  {ARREADY ddr1_arready}  {ARSIZE ddr1_arsize}  {ARVALID ddr1_arvalid}  {AWADDR ddr1_awaddr}  {AWBURST ddr1_awburst}  {AWCACHE ddr1_awcache}  {AWID ddr1_awid}  {AWLEN ddr1_awlen}  {AWLOCK ddr1_awlock}  {AWPROT ddr1_awprot}  {AWREADY ddr1_awready}  {AWSIZE ddr1_awsize}  {AWVALID ddr1_awvalid}  {BID ddr1_bid}  {BREADY ddr1_bready}  {BRESP ddr1_bresp}  {BVALID ddr1_bvalid}  {RDATA ddr1_rdata}  {RID ddr1_rid}  {RLAST ddr1_rlast}  {RREADY ddr1_rready}  {RRESP ddr1_rresp}  {RVALID ddr1_rvalid}  {WDATA ddr1_wdata}  {WLAST ddr1_wlast}  {WREADY ddr1_wready}  {WSTRB ddr1_wstrb}  {WVALID ddr1_wvalid}}
component::automapBusInterface -name mem_ss_ddr_s2_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr2_araddr}  {ARBURST ddr2_arburst}  {ARCACHE ddr2_arcache}  {ARID ddr2_arid}  {ARLEN ddr2_arlen}  {ARLOCK ddr2_arlock}  {ARPROT ddr2_arprot}  {ARREADY ddr2_arready}  {ARSIZE ddr2_arsize}  {ARVALID ddr2_arvalid}  {AWADDR ddr2_awaddr}  {AWBURST ddr2_awburst}  {AWCACHE ddr2_awcache}  {AWID ddr2_awid}  {AWLEN ddr2_awlen}  {AWLOCK ddr2_awlock}  {AWPROT ddr2_awprot}  {AWREADY ddr2_awready}  {AWSIZE ddr2_awsize}  {AWVALID ddr2_awvalid}  {BID ddr2_bid}  {BREADY ddr2_bready}  {BRESP ddr2_bresp}  {BVALID ddr2_bvalid}  {RDATA ddr2_rdata}  {RID ddr2_rid}  {RLAST ddr2_rlast}  {RREADY ddr2_rready}  {RRESP ddr2_rresp}  {RVALID ddr2_rvalid}  {WDATA ddr2_wdata}  {WLAST ddr2_wlast}  {WREADY ddr2_wready}  {WSTRB ddr2_wstrb}  {WVALID ddr2_wvalid}}
component::automapBusInterface -name mem_ss_ddr_s3_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr3_araddr}  {ARBURST ddr3_arburst}  {ARCACHE ddr3_arcache}  {ARID ddr3_arid}  {ARLEN ddr3_arlen}  {ARLOCK ddr3_arlock}  {ARPROT ddr3_arprot}  {ARREADY ddr3_arready}  {ARSIZE ddr3_arsize}  {ARVALID ddr3_arvalid}  {AWADDR ddr3_awaddr}  {AWBURST ddr3_awburst}  {AWCACHE ddr3_awcache}  {AWID ddr3_awid}  {AWLEN ddr3_awlen}  {AWLOCK ddr3_awlock}  {AWPROT ddr3_awprot}  {AWREADY ddr3_awready}  {AWSIZE ddr3_awsize}  {AWVALID ddr3_awvalid}  {BID ddr3_bid}  {BREADY ddr3_bready}  {BRESP ddr3_bresp}  {BVALID ddr3_bvalid}  {RDATA ddr3_rdata}  {RID ddr3_rid}  {RLAST ddr3_rlast}  {RREADY ddr3_rready}  {RRESP ddr3_rresp}  {RVALID ddr3_rvalid}  {WDATA ddr3_wdata}  {WLAST ddr3_wlast}  {WREADY ddr3_wready}  {WSTRB ddr3_wstrb}  {WVALID ddr3_wvalid}}
component::automapBusInterface -name mem_ss_sram_s0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sramb0_araddr} {ARBURST sramb0_arburst} {ARID sramb0_arid} {ARLEN sramb0_arlen} {ARREADY sramb0_arready} {ARSIZE sramb0_arsize} {ARVALID sramb0_arvalid} {AWADDR sramb0_awaddr} {AWBURST sramb0_awburst} {AWID sramb0_awid} {AWLEN sramb0_awlen} {AWREADY sramb0_awready} {AWSIZE sramb0_awsize} {AWVALID sramb0_awvalid} {BID sramb0_bid} {BREADY sramb0_bready} {BRESP sramb0_bresp} {BVALID sramb0_bvalid} {RDATA sramb0_rdata} {RID sramb0_rid} {RLAST sramb0_rlast} {RREADY sramb0_rready} {RRESP sramb0_rresp} {RVALID sramb0_rvalid} {WDATA sramb0_wdata} {WLAST sramb0_wlast} {WREADY sramb0_wready} {WSTRB sramb0_wstrb} {WVALID sramb0_wvalid}}
component::automapBusInterface -name mem_ss_sram_s1_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sramb1_araddr} {ARBURST sramb1_arburst} {ARID sramb1_arid} {ARLEN sramb1_arlen} {ARREADY sramb1_arready} {ARSIZE sramb1_arsize} {ARVALID sramb1_arvalid} {AWADDR sramb1_awaddr} {AWBURST sramb1_awburst} {AWID sramb1_awid} {AWLEN sramb1_awlen} {AWREADY sramb1_awready} {AWSIZE sramb1_awsize} {AWVALID sramb1_awvalid} {BID sramb1_bid} {BREADY sramb1_bready} {BRESP sramb1_bresp} {BVALID sramb1_bvalid} {RDATA sramb1_rdata} {RID sramb1_rid} {RLAST sramb1_rlast} {RREADY sramb1_rready} {RRESP sramb1_rresp} {RVALID sramb1_rvalid} {WDATA sramb1_wdata} {WLAST sramb1_wlast} {WREADY sramb1_wready} {WSTRB sramb1_wstrb} {WVALID sramb1_wvalid}}
component::automapBusInterface -name mem_ss_sram_s2_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sramb2_araddr} {ARBURST sramb2_arburst} {ARID sramb2_arid} {ARLEN sramb2_arlen} {ARREADY sramb2_arready} {ARSIZE sramb2_arsize} {ARVALID sramb2_arvalid} {AWADDR sramb2_awaddr} {AWBURST sramb2_awburst} {AWID sramb2_awid} {AWLEN sramb2_awlen} {AWREADY sramb2_awready} {AWSIZE sramb2_awsize} {AWVALID sramb2_awvalid} {BID sramb2_bid} {BREADY sramb2_bready} {BRESP sramb2_bresp} {BVALID sramb2_bvalid} {RDATA sramb2_rdata} {RID sramb2_rid} {RLAST sramb2_rlast} {RREADY sramb2_rready} {RRESP sramb2_rresp} {RVALID sramb2_rvalid} {WDATA sramb2_wdata} {WLAST sramb2_wlast} {WREADY sramb2_wready} {WSTRB sramb2_wstrb} {WVALID sramb2_wvalid}}
component::automapBusInterface -name mem_ss_sram_s3_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sramb3_araddr} {ARBURST sramb3_arburst} {ARID sramb3_arid} {ARLEN sramb3_arlen} {ARREADY sramb3_arready} {ARSIZE sramb3_arsize} {ARVALID sramb3_arvalid} {AWADDR sramb3_awaddr} {AWBURST sramb3_awburst} {AWID sramb3_awid} {AWLEN sramb3_awlen} {AWREADY sramb3_awready} {AWSIZE sramb3_awsize} {AWVALID sramb3_awvalid} {BID sramb3_bid} {BREADY sramb3_bready} {BRESP sramb3_bresp} {BVALID sramb3_bvalid} {RDATA sramb3_rdata} {RID sramb3_rid} {RLAST sramb3_rlast} {RREADY sramb3_rready} {RRESP sramb3_rresp} {RVALID sramb3_rvalid} {WDATA sramb3_wdata} {WLAST sramb3_wlast} {WREADY sramb3_wready} {WSTRB sramb3_wstrb} {WVALID sramb3_wvalid}}
component::automapBusInterface -name mem_ss_sram_cntl_axil -mode slave -absdef {amba.com AMBA3 AXILite_rtl r2p0_0}  -manualmap {  {ARADDR cntl_araddr} {ARREADY cntl_arready} {ARVALID cntl_arvalid} {AWADDR cntl_awaddr} {AWREADY cntl_awready} {AWVALID cntl_awvalid} {BREADY cntl_bready} {BRESP cntl_bresp} {BVALID cntl_bvalid} {RDATA cntl_rdata} {RREADY cntl_rready} {RRESP cntl_rresp} {RVALID cntl_rvalid} {WDATA cntl_wdata} {WREADY cntl_wready} {WVALID cntl_wvalid}}
component::save

component::setCurrentComponent {Vendor Library rsnoc 1.0}
component::automapBusInterface -name rsnoc_ddr_s0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr_axi_s0_ar_addr}  {ARBURST ddr_axi_s0_ar_burst}  {ARCACHE ddr_axi_s0_ar_cache}  {ARID ddr_axi_s0_ar_id}  {ARLEN ddr_axi_s0_ar_len}  {ARLOCK ddr_axi_s0_ar_lock}  {ARPROT ddr_axi_s0_ar_prot}  {ARREADY ddr_axi_s0_ar_ready}  {ARSIZE ddr_axi_s0_ar_size}  {ARVALID ddr_axi_s0_ar_valid}  {AWADDR ddr_axi_s0_aw_addr}  {AWBURST ddr_axi_s0_aw_burst}  {AWCACHE ddr_axi_s0_aw_cache}  {AWID ddr_axi_s0_aw_id}  {AWLEN ddr_axi_s0_aw_len}  {AWLOCK ddr_axi_s0_aw_lock}  {AWPROT ddr_axi_s0_aw_prot}  {AWREADY ddr_axi_s0_aw_ready}  {AWSIZE ddr_axi_s0_aw_size}  {AWVALID ddr_axi_s0_aw_valid}  {BID ddr_axi_s0_b_id}  {BREADY ddr_axi_s0_b_ready}  {BRESP ddr_axi_s0_b_resp}  {BVALID ddr_axi_s0_b_valid}  {RDATA ddr_axi_s0_r_data}  {RID ddr_axi_s0_r_id}  {RLAST ddr_axi_s0_r_last}  {RREADY ddr_axi_s0_r_ready}  {RRESP ddr_axi_s0_r_resp}  {RVALID ddr_axi_s0_r_valid}  {WDATA ddr_axi_s0_w_data}  {WLAST ddr_axi_s0_w_last}  {WREADY ddr_axi_s0_w_ready}  {WSTRB ddr_axi_s0_w_strb}  {WVALID ddr_axi_s0_w_valid}}
component::automapBusInterface -name rsnoc_ddr_s1_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr_axi_s1_ar_addr}  {ARBURST ddr_axi_s1_ar_burst}  {ARCACHE ddr_axi_s1_ar_cache}  {ARID ddr_axi_s1_ar_id}  {ARLEN ddr_axi_s1_ar_len}  {ARLOCK ddr_axi_s1_ar_lock}  {ARPROT ddr_axi_s1_ar_prot}  {ARREADY ddr_axi_s1_ar_ready}  {ARSIZE ddr_axi_s1_ar_size}  {ARVALID ddr_axi_s1_ar_valid}  {AWADDR ddr_axi_s1_aw_addr}  {AWBURST ddr_axi_s1_aw_burst}  {AWCACHE ddr_axi_s1_aw_cache}  {AWID ddr_axi_s1_aw_id}  {AWLEN ddr_axi_s1_aw_len}  {AWLOCK ddr_axi_s1_aw_lock}  {AWPROT ddr_axi_s1_aw_prot}  {AWREADY ddr_axi_s1_aw_ready}  {AWSIZE ddr_axi_s1_aw_size}  {AWVALID ddr_axi_s1_aw_valid}  {BID ddr_axi_s1_b_id}  {BREADY ddr_axi_s1_b_ready}  {BRESP ddr_axi_s1_b_resp}  {BVALID ddr_axi_s1_b_valid}  {RDATA ddr_axi_s1_r_data}  {RID ddr_axi_s1_r_id}  {RLAST ddr_axi_s1_r_last}  {RREADY ddr_axi_s1_r_ready}  {RRESP ddr_axi_s1_r_resp}  {RVALID ddr_axi_s1_r_valid}  {WDATA ddr_axi_s1_w_data}  {WLAST ddr_axi_s1_w_last}  {WREADY ddr_axi_s1_w_ready}  {WSTRB ddr_axi_s1_w_strb}  {WVALID ddr_axi_s1_w_valid}}
component::automapBusInterface -name rsnoc_ddr_s2_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr_axi_s2_ar_addr}  {ARBURST ddr_axi_s2_ar_burst}  {ARCACHE ddr_axi_s2_ar_cache}  {ARID ddr_axi_s2_ar_id}  {ARLEN ddr_axi_s2_ar_len}  {ARLOCK ddr_axi_s2_ar_lock}  {ARPROT ddr_axi_s2_ar_prot}  {ARREADY ddr_axi_s2_ar_ready}  {ARSIZE ddr_axi_s2_ar_size}  {ARVALID ddr_axi_s2_ar_valid}  {AWADDR ddr_axi_s2_aw_addr}  {AWBURST ddr_axi_s2_aw_burst}  {AWCACHE ddr_axi_s2_aw_cache}  {AWID ddr_axi_s2_aw_id}  {AWLEN ddr_axi_s2_aw_len}  {AWLOCK ddr_axi_s2_aw_lock}  {AWPROT ddr_axi_s2_aw_prot}  {AWREADY ddr_axi_s2_aw_ready}  {AWSIZE ddr_axi_s2_aw_size}  {AWVALID ddr_axi_s2_aw_valid}  {BID ddr_axi_s2_b_id}  {BREADY ddr_axi_s2_b_ready}  {BRESP ddr_axi_s2_b_resp}  {BVALID ddr_axi_s2_b_valid}  {RDATA ddr_axi_s2_r_data}  {RID ddr_axi_s2_r_id}  {RLAST ddr_axi_s2_r_last}  {RREADY ddr_axi_s2_r_ready}  {RRESP ddr_axi_s2_r_resp}  {RVALID ddr_axi_s2_r_valid}  {WDATA ddr_axi_s2_w_data}  {WLAST ddr_axi_s2_w_last}  {WREADY ddr_axi_s2_w_ready}  {WSTRB ddr_axi_s2_w_strb}  {WVALID ddr_axi_s2_w_valid}}
component::automapBusInterface -name rsnoc_ddr_s3_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap {  {ARADDR ddr_axi_s3_ar_addr}  {ARBURST ddr_axi_s3_ar_burst}  {ARCACHE ddr_axi_s3_ar_cache}  {ARID ddr_axi_s3_ar_id}  {ARLEN ddr_axi_s3_ar_len}  {ARLOCK ddr_axi_s3_ar_lock}  {ARPROT ddr_axi_s3_ar_prot}  {ARREADY ddr_axi_s3_ar_ready}  {ARSIZE ddr_axi_s3_ar_size}  {ARVALID ddr_axi_s3_ar_valid}  {AWADDR ddr_axi_s3_aw_addr}  {AWBURST ddr_axi_s3_aw_burst}  {AWCACHE ddr_axi_s3_aw_cache}  {AWID ddr_axi_s3_aw_id}  {AWLEN ddr_axi_s3_aw_len}  {AWLOCK ddr_axi_s3_aw_lock}  {AWPROT ddr_axi_s3_aw_prot}  {AWREADY ddr_axi_s3_aw_ready}  {AWSIZE ddr_axi_s3_aw_size}  {AWVALID ddr_axi_s3_aw_valid}  {BID ddr_axi_s3_b_id}  {BREADY ddr_axi_s3_b_ready}  {BRESP ddr_axi_s3_b_resp}  {BVALID ddr_axi_s3_b_valid}  {RDATA ddr_axi_s3_r_data}  {RID ddr_axi_s3_r_id}  {RLAST ddr_axi_s3_r_last}  {RREADY ddr_axi_s3_r_ready}  {RRESP ddr_axi_s3_r_resp}  {RVALID ddr_axi_s3_r_valid}  {WDATA ddr_axi_s3_w_data}  {WLAST ddr_axi_s3_w_last}  {WREADY ddr_axi_s3_w_ready}  {WSTRB ddr_axi_s3_w_strb}  {WVALID ddr_axi_s3_w_valid}}
component::automapBusInterface -name rsnoc_sram_s0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sram_axi_s0_ar_addr} {ARBURST sram_axi_s0_ar_burst} {ARCACHE sram_axi_s0_ar_cache} {ARID sram_axi_s0_ar_id} {ARLEN sram_axi_s0_ar_len} {ARLOCK sram_axi_s0_ar_lock} {ARPROT sram_axi_s0_ar_prot} {ARREADY sram_axi_s0_ar_ready} {ARSIZE sram_axi_s0_ar_size} {ARVALID sram_axi_s0_ar_valid} {AWADDR sram_axi_s0_aw_addr} {AWBURST sram_axi_s0_aw_burst} {AWCACHE sram_axi_s0_aw_cache} {AWID sram_axi_s0_aw_id} {AWLEN sram_axi_s0_aw_len} {AWLOCK sram_axi_s0_aw_lock} {AWPROT sram_axi_s0_aw_prot} {AWREADY sram_axi_s0_aw_ready} {AWSIZE sram_axi_s0_aw_size} {AWVALID sram_axi_s0_aw_valid} {BID sram_axi_s0_b_id} {BREADY sram_axi_s0_b_ready} {BRESP sram_axi_s0_b_resp} {BVALID sram_axi_s0_b_valid} {RDATA sram_axi_s0_r_data} {RID sram_axi_s0_r_id} {RLAST sram_axi_s0_r_last} {RREADY sram_axi_s0_r_ready} {RRESP sram_axi_s0_r_resp} {RVALID sram_axi_s0_r_valid} {WDATA sram_axi_s0_w_data} {WLAST sram_axi_s0_w_last} {WREADY sram_axi_s0_w_ready} {WSTRB sram_axi_s0_w_strb} {WVALID sram_axi_s0_w_valid}}
component::automapBusInterface -name rsnoc_sram_s1_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sram_axi_s1_ar_addr} {ARBURST sram_axi_s1_ar_burst} {ARCACHE sram_axi_s1_ar_cache} {ARID sram_axi_s1_ar_id} {ARLEN sram_axi_s1_ar_len} {ARLOCK sram_axi_s1_ar_lock} {ARPROT sram_axi_s1_ar_prot} {ARREADY sram_axi_s1_ar_ready} {ARSIZE sram_axi_s1_ar_size} {ARVALID sram_axi_s1_ar_valid} {AWADDR sram_axi_s1_aw_addr} {AWBURST sram_axi_s1_aw_burst} {AWCACHE sram_axi_s1_aw_cache} {AWID sram_axi_s1_aw_id} {AWLEN sram_axi_s1_aw_len} {AWLOCK sram_axi_s1_aw_lock} {AWPROT sram_axi_s1_aw_prot} {AWREADY sram_axi_s1_aw_ready} {AWSIZE sram_axi_s1_aw_size} {AWVALID sram_axi_s1_aw_valid} {BID sram_axi_s1_b_id} {BREADY sram_axi_s1_b_ready} {BRESP sram_axi_s1_b_resp} {BVALID sram_axi_s1_b_valid} {RDATA sram_axi_s1_r_data} {RID sram_axi_s1_r_id} {RLAST sram_axi_s1_r_last} {RREADY sram_axi_s1_r_ready} {RRESP sram_axi_s1_r_resp} {RVALID sram_axi_s1_r_valid} {WDATA sram_axi_s1_w_data} {WLAST sram_axi_s1_w_last} {WREADY sram_axi_s1_w_ready} {WSTRB sram_axi_s1_w_strb} {WVALID sram_axi_s1_w_valid}}
component::automapBusInterface -name rsnoc_sram_s2_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sram_axi_s2_ar_addr} {ARBURST sram_axi_s2_ar_burst} {ARCACHE sram_axi_s2_ar_cache} {ARID sram_axi_s2_ar_id} {ARLEN sram_axi_s2_ar_len} {ARLOCK sram_axi_s2_ar_lock} {ARPROT sram_axi_s2_ar_prot} {ARREADY sram_axi_s2_ar_ready} {ARSIZE sram_axi_s2_ar_size} {ARVALID sram_axi_s2_ar_valid} {AWADDR sram_axi_s2_aw_addr} {AWBURST sram_axi_s2_aw_burst} {AWCACHE sram_axi_s2_aw_cache} {AWID sram_axi_s2_aw_id} {AWLEN sram_axi_s2_aw_len} {AWLOCK sram_axi_s2_aw_lock} {AWPROT sram_axi_s2_aw_prot} {AWREADY sram_axi_s2_aw_ready} {AWSIZE sram_axi_s2_aw_size} {AWVALID sram_axi_s2_aw_valid} {BID sram_axi_s2_b_id} {BREADY sram_axi_s2_b_ready} {BRESP sram_axi_s2_b_resp} {BVALID sram_axi_s2_b_valid} {RDATA sram_axi_s2_r_data} {RID sram_axi_s2_r_id} {RLAST sram_axi_s2_r_last} {RREADY sram_axi_s2_r_ready} {RRESP sram_axi_s2_r_resp} {RVALID sram_axi_s2_r_valid} {WDATA sram_axi_s2_w_data} {WLAST sram_axi_s2_w_last} {WREADY sram_axi_s2_w_ready} {WSTRB sram_axi_s2_w_strb} {WVALID sram_axi_s2_w_valid}}
component::automapBusInterface -name rsnoc_sram_s3_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARADDR sram_axi_s3_ar_addr} {ARBURST sram_axi_s3_ar_burst} {ARCACHE sram_axi_s3_ar_cache} {ARID sram_axi_s3_ar_id} {ARLEN sram_axi_s3_ar_len} {ARLOCK sram_axi_s3_ar_lock} {ARPROT sram_axi_s3_ar_prot} {ARREADY sram_axi_s3_ar_ready} {ARSIZE sram_axi_s3_ar_size} {ARVALID sram_axi_s3_ar_valid} {AWADDR sram_axi_s3_aw_addr} {AWBURST sram_axi_s3_aw_burst} {AWCACHE sram_axi_s3_aw_cache} {AWID sram_axi_s3_aw_id} {AWLEN sram_axi_s3_aw_len} {AWLOCK sram_axi_s3_aw_lock} {AWPROT sram_axi_s3_aw_prot} {AWREADY sram_axi_s3_aw_ready} {AWSIZE sram_axi_s3_aw_size} {AWVALID sram_axi_s3_aw_valid} {BID sram_axi_s3_b_id} {BREADY sram_axi_s3_b_ready} {BRESP sram_axi_s3_b_resp} {BVALID sram_axi_s3_b_valid} {RDATA sram_axi_s3_r_data} {RID sram_axi_s3_r_id} {RLAST sram_axi_s3_r_last} {RREADY sram_axi_s3_r_ready} {RRESP sram_axi_s3_r_resp} {RVALID sram_axi_s3_r_valid} {WDATA sram_axi_s3_w_data} {WLAST sram_axi_s3_w_last} {WREADY sram_axi_s3_w_ready} {WSTRB sram_axi_s3_w_strb} {WVALID sram_axi_s3_w_valid}}
component::automapBusInterface -name rsnoc_sram_cntl_axil -mode master -absdef {amba.com AMBA3 AXILite_rtl r2p0_0}  -manualmap {  {ARADDR ddr_axil_s0_ar_addr} {ARREADY ddr_axil_s0_ar_ready} {ARVALID ddr_axil_s0_ar_valid} {AWADDR ddr_axil_s0_aw_addr} {AWREADY ddr_axil_s0_aw_ready} {AWVALID ddr_axil_s0_aw_valid} {BREADY ddr_axil_s0_b_ready} {BRESP ddr_axil_s0_b_resp} {BVALID ddr_axil_s0_b_valid} {RDATA ddr_axil_s0_r_data} {RREADY ddr_axil_s0_r_ready} {RRESP ddr_axil_s0_r_resp} {RVALID ddr_axil_s0_r_valid} {WDATA ddr_axil_s0_w_data} {WREADY ddr_axil_s0_w_ready} {WVALID ddr_axil_s0_w_valid} {ARPROT ddr_axil_s0_ar_prot} {AWPROT ddr_axil_s0_aw_prot} {WSTRB ddr_axil_s0_w_strb}}
component::save

design::setCurrentDesign {Vendor Library soc_ss_arch 1.0}
design::createInterconnection memory_ss mem_ss_ddr_s0_axi    flexnoc rsnoc_ddr_s0_axi  -name memory_ss_mem_ss_ddr_s0_axi__flexnoc_rsnoc_ddr_s0_axi 
design::createInterconnection memory_ss mem_ss_ddr_s1_axi    flexnoc rsnoc_ddr_s1_axi  -name memory_ss_mem_ss_ddr_s1_axi__flexnoc_rsnoc_ddr_s1_axi 
design::createInterconnection memory_ss mem_ss_ddr_s2_axi    flexnoc rsnoc_ddr_s2_axi  -name memory_ss_mem_ss_ddr_s2_axi__flexnoc_rsnoc_ddr_s2_axi 
design::createInterconnection memory_ss mem_ss_ddr_s3_axi    flexnoc rsnoc_ddr_s3_axi  -name memory_ss_mem_ss_ddr_s3_axi__flexnoc_rsnoc_ddr_s3_axi 
design::createInterconnection memory_ss mem_ss_sram_s0_axi   flexnoc rsnoc_sram_s0_axi -name memory_ss_mem_ss_sram_s0_axi__flexnoc_rsnoc_sram_s0_axi
design::createInterconnection memory_ss mem_ss_sram_s1_axi   flexnoc rsnoc_sram_s1_axi -name memory_ss_mem_ss_sram_s1_axi__flexnoc_rsnoc_sram_s1_axi
design::createInterconnection memory_ss mem_ss_sram_s2_axi   flexnoc rsnoc_sram_s2_axi -name memory_ss_mem_ss_sram_s2_axi__flexnoc_rsnoc_sram_s2_axi
design::createInterconnection memory_ss mem_ss_sram_s3_axi   flexnoc rsnoc_sram_s3_axi -name memory_ss_mem_ss_sram_s3_axi__flexnoc_rsnoc_sram_s3_axi
design::createInterconnection memory_ss mem_ss_sram_cntl_axil   flexnoc rsnoc_sram_cntl_axil -name memory_ss_mem_ss_sram_cntl_axil__flexnoc_rsnoc_sram_cntl_axil
design::save


#connection beetwen flexnoc and acpu
component::setCurrentComponent {Vendor Library ae350_cpu_subsystem 1.0}
component::automapBusInterface -name acpu_m0_axi -mode master -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap { {ARID arid} {ARADDR araddr} {ARLEN arlen} {ARSIZE arsize} {ARBURST arburst} {ARLOCK arlock} {ARCACHE arcache} {ARPROT arprot} {ARVALID arvalid} {ARREADY arready} {AWID awid} {AWADDR awaddr} {AWLEN awlen} {AWSIZE awsize} {AWBURST awburst} {AWLOCK awlock} {AWCACHE awcache} {AWPROT awprot} {AWVALID awvalid} {AWREADY awready} {WDATA wdata} {WSTRB wstrb} {WLAST wlast} {WVALID wvalid} {WREADY wready} {BID bid} {BRESP bresp} {BVALID bvalid} {BREADY bready} {RID rid} {RDATA rdata} {RRESP rresp} {RLAST rlast} {RVALID rvalid} {RREADY rready}}
component::save

component::setCurrentComponent {Vendor Library rsnoc 1.0}
component::automapBusInterface -name rsnoc_acpu_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0}  -manualmap  { {ARADDR acpu_axi_m0_ar_addr} {ARBURST acpu_axi_m0_ar_burst} {ARCACHE acpu_axi_m0_ar_cache} {ARID acpu_axi_m0_ar_id} {ARLEN acpu_axi_m0_ar_len} {ARLOCK acpu_axi_m0_ar_lock} {ARPROT acpu_axi_m0_ar_prot} {ARREADY acpu_axi_m0_ar_ready} {ARSIZE acpu_axi_m0_ar_size} {ARVALID acpu_axi_m0_ar_valid} {AWADDR acpu_axi_m0_aw_addr} {AWBURST acpu_axi_m0_aw_burst} {AWCACHE acpu_axi_m0_aw_cache} {AWID acpu_axi_m0_aw_id} {AWLEN acpu_axi_m0_aw_len} {AWLOCK acpu_axi_m0_aw_lock} {AWPROT acpu_axi_m0_aw_prot} {AWREADY acpu_axi_m0_aw_ready} {AWSIZE acpu_axi_m0_aw_size} {AWVALID acpu_axi_m0_aw_valid} {BID acpu_axi_m0_b_id} {BREADY acpu_axi_m0_b_ready} {BRESP acpu_axi_m0_b_resp} {BVALID acpu_axi_m0_b_valid} {RDATA acpu_axi_m0_r_data} {RID acpu_axi_m0_r_id} {RLAST acpu_axi_m0_r_last} {RREADY acpu_axi_m0_r_ready} {RRESP acpu_axi_m0_r_resp} {RVALID acpu_axi_m0_r_valid} {WDATA acpu_axi_m0_w_data} {WLAST acpu_axi_m0_w_last} {WREADY acpu_axi_m0_w_ready} {WSTRB acpu_axi_m0_w_strb} {WVALID acpu_axi_m0_w_valid}}
component::save

design::setCurrentDesign {Vendor Library soc_ss_arch 1.0}
design::createInterconnection acpu acpu_m0_axi flexnoc rsnoc_acpu_m0_axi -name ae350_cpu_subsystem_acpu_m0_axi__flexnoc_rsnoc_acpu_m0_axi
design::save


#connection soc_ss
component::setCurrentComponent {Vendor Library soc_ss 1.0}
component::automapBusInterface -name soc_ss_fpga_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0} -manualmap {   {ARADDR fpga_axi_m0_ar_addr}  {ARBURST fpga_axi_m0_ar_burst}  {ARCACHE fpga_axi_m0_ar_cache}  {ARID fpga_axi_m0_ar_id}  {ARLEN fpga_axi_m0_ar_len}  {ARLOCK fpga_axi_m0_ar_lock}  {ARPROT fpga_axi_m0_ar_prot}  {ARREADY fpga_axi_m0_ar_ready}  {ARSIZE fpga_axi_m0_ar_size}  {ARVALID fpga_axi_m0_ar_valid}  {AWADDR fpga_axi_m0_aw_addr}  {AWBURST fpga_axi_m0_aw_burst}  {AWCACHE fpga_axi_m0_aw_cache}  {AWID fpga_axi_m0_aw_id}  {AWLEN fpga_axi_m0_aw_len}  {AWLOCK fpga_axi_m0_aw_lock}  {AWPROT fpga_axi_m0_aw_prot}  {AWREADY fpga_axi_m0_aw_ready}  {AWSIZE fpga_axi_m0_aw_size}  {AWVALID fpga_axi_m0_aw_valid}  {BID fpga_axi_m0_b_id}  {BREADY fpga_axi_m0_b_ready}  {BRESP fpga_axi_m0_b_resp}  {BVALID fpga_axi_m0_b_valid}  {RDATA fpga_axi_m0_r_data}  {RID fpga_axi_m0_r_id}  {RLAST fpga_axi_m0_r_last}  {RREADY fpga_axi_m0_r_ready}  {RRESP fpga_axi_m0_r_resp}  {RVALID fpga_axi_m0_r_valid}  {WDATA fpga_axi_m0_w_data}  {WLAST fpga_axi_m0_w_last}  {WREADY fpga_axi_m0_w_ready}  {WSTRB fpga_axi_m0_w_strb}  {WVALID fpga_axi_m0_w_valid}}
component::automapBusInterface -name soc_ss_fpga_m1_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0} -manualmap {   {ARADDR fpga_axi_m1_ar_addr}  {ARBURST fpga_axi_m1_ar_burst}  {ARCACHE fpga_axi_m1_ar_cache}  {ARID fpga_axi_m1_ar_id}  {ARLEN fpga_axi_m1_ar_len}  {ARLOCK fpga_axi_m1_ar_lock}  {ARPROT fpga_axi_m1_ar_prot}  {ARREADY fpga_axi_m1_ar_ready}  {ARSIZE fpga_axi_m1_ar_size}  {ARVALID fpga_axi_m1_ar_valid}  {AWADDR fpga_axi_m1_aw_addr}  {AWBURST fpga_axi_m1_aw_burst}  {AWCACHE fpga_axi_m1_aw_cache}  {AWID fpga_axi_m1_aw_id}  {AWLEN fpga_axi_m1_aw_len}  {AWLOCK fpga_axi_m1_aw_lock}  {AWPROT fpga_axi_m1_aw_prot}  {AWREADY fpga_axi_m1_aw_ready}  {AWSIZE fpga_axi_m1_aw_size}  {AWVALID fpga_axi_m1_aw_valid}  {BID fpga_axi_m1_b_id}  {BREADY fpga_axi_m1_b_ready}  {BRESP fpga_axi_m1_b_resp}  {BVALID fpga_axi_m1_b_valid}  {RDATA fpga_axi_m1_r_data}  {RID fpga_axi_m1_r_id}  {RLAST fpga_axi_m1_r_last}  {RREADY fpga_axi_m1_r_ready}  {RRESP fpga_axi_m1_r_resp}  {RVALID fpga_axi_m1_r_valid}  {WDATA fpga_axi_m1_w_data}  {WLAST fpga_axi_m1_w_last}  {WREADY fpga_axi_m1_w_ready}  {WSTRB fpga_axi_m1_w_strb}  {WVALID fpga_axi_m1_w_valid}}
component::automapBusInterface -name soc_ss_fpga_s0_ahb -mode master -absdef {amba.com AMBA2 AHB_rtl r3p0_1} -manualmap {  {HADDR fpga_ahb_s0_haddr} {HBURST fpga_ahb_s0_hburst} {HMASTLOCK fpga_ahb_s0_hmastlock} {HPROT fpga_ahb_s0_hprot} {HRDATA fpga_ahb_s0_hrdata} {HREADY fpga_ahb_s0_hready} {HRESP fpga_ahb_s0_hresp} {HSELx fpga_ahb_s0_hsel} {HSIZE fpga_ahb_s0_hsize} {HTRANS fpga_ahb_s0_htrans} {HWBE fpga_ahb_s0_hwbe} {HWDATA fpga_ahb_s0_hwdata} {HWRITE fpga_ahb_s0_hwrite}}
component::automapBusInterface -name soc_ss_uart0 -mode master -absdef {andes gemini UART_rtl 1.0} -manualmap {{SOUT uart0_sout} {SIN uart0_sin} {CTSN uart0_ctsn} {RTSN uart0_rtsn}}
component::automapBusInterface -name soc_ss_uart1 -mode master -absdef {andes gemini UART_rtl 1.0} -manualmap {{SOUT uart1_sout} {SIN uart1_sin} {CTSN uart1_ctsn} {RTSN uart1_rtsn}}
component::automapBusInterface -name soc_ss_i2c -mode master -absdef {andes gemini I2C_rtl 1.0} -manualmap {   {SCL_O scl_o} {SDA_O sda_o} {SCL_I scl_i} {SDA_I sda_i}}
component::automapBusInterface -name soc_ss_qspi -mode master -absdef {andes gemini QSPI_rtl 1.0} -manualmap { {CS_N_IN spi_cs_n_in} {HOLD_N_IN spi_hold_n_in} {HOLD_N_OE spi_hold_n_oe} {HOLD_N_OUT spi_hold_n_out} {WP_N_IN spi_wp_n_in} {WP_N_OE spi_wp_n_oe} {WP_N_OUT spi_wp_n_out} {CLK_IN spi_clk_in} {CLK_OE spi_clk_oe} {CLK_OUT spi_clk_out} {CS_N_OE spi_cs_n_oe} {CS_N_OUT spi_cs_n_out} {MISO_IN spi_miso_in} {MISO_OE spi_miso_oe} {MISO_OUT spi_miso_out} {MOSI_IN spi_mosi_in} {MOSI_OE spi_mosi_oe} {MOSI_OUT spi_mosi_out}}
component::automapBusInterface -name soc_ss_gpio -mode master -absdef {andes gemini GPIO_rtl 1.0} -manualmap { {GPIO_PULLDOWN gpio_pulldown} {GPIO_PULLUP gpio_pullup} {GPIO_OE gpio_oe} {GPIO_OUT gpio_out} {GPIO_IN gpio_in}}
component::automapBusInterface -name soc_ss_gbe -mode master -absdef {rapidsilicon gemini GBE_rtl 1.0} -manualmap {  {RGMII_TXD rgmii_txd} {RGMII_TX_CTL rgmii_tx_ctl} {RGMII_RXD rgmii_rxd} {RGMII_RX_CTL rgmii_rx_ctl} {RGMII_RXC rgmii_rxc} {MDIO_MDC mdio_mdc} {MDIO_DATA mdio_data}}
component::automapBusInterface -name soc_ss_usb -mode master -absdef {rapidsilicon gemini USB_rtl 1.0} -manualmap { 	 {DP usb_dp} {DN usb_dn} {XTAL_IN usb_xtal_in} {XTAL_OUT usb_xtal_out}}
component::save


component::setCurrentComponent {Vendor Library rsnoc 1.0}
component::automapBusInterface -name rsnoc_fpga_m0_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0} -manualmap {   {ARADDR fpga_axi_m0_ar_addr}  {ARBURST fpga_axi_m0_ar_burst}  {ARCACHE fpga_axi_m0_ar_cache}  {ARID fpga_axi_m0_ar_id}  {ARLEN fpga_axi_m0_ar_len}  {ARLOCK fpga_axi_m0_ar_lock}  {ARPROT fpga_axi_m0_ar_prot}  {ARREADY fpga_axi_m0_ar_ready}  {ARSIZE fpga_axi_m0_ar_size}  {ARVALID fpga_axi_m0_ar_valid}  {AWADDR fpga_axi_m0_aw_addr}  {AWBURST fpga_axi_m0_aw_burst}  {AWCACHE fpga_axi_m0_aw_cache}  {AWID fpga_axi_m0_aw_id}  {AWLEN fpga_axi_m0_aw_len}  {AWLOCK fpga_axi_m0_aw_lock}  {AWPROT fpga_axi_m0_aw_prot}  {AWREADY fpga_axi_m0_aw_ready}  {AWSIZE fpga_axi_m0_aw_size}  {AWVALID fpga_axi_m0_aw_valid}  {BID fpga_axi_m0_b_id}  {BREADY fpga_axi_m0_b_ready}  {BRESP fpga_axi_m0_b_resp}  {BVALID fpga_axi_m0_b_valid}  {RDATA fpga_axi_m0_r_data}  {RID fpga_axi_m0_r_id}  {RLAST fpga_axi_m0_r_last}  {RREADY fpga_axi_m0_r_ready}  {RRESP fpga_axi_m0_r_resp}  {RVALID fpga_axi_m0_r_valid}  {WDATA fpga_axi_m0_w_data}  {WLAST fpga_axi_m0_w_last}  {WREADY fpga_axi_m0_w_ready}  {WSTRB fpga_axi_m0_w_strb}  {WVALID fpga_axi_m0_w_valid}}
component::automapBusInterface -name rsnoc_fpga_m1_axi -mode slave -absdef {amba.com AMBA3 AXI_rtl r2p0_0} -manualmap {   {ARADDR fpga_axi_m1_ar_addr}  {ARBURST fpga_axi_m1_ar_burst}  {ARCACHE fpga_axi_m1_ar_cache}  {ARID fpga_axi_m1_ar_id}  {ARLEN fpga_axi_m1_ar_len}  {ARLOCK fpga_axi_m1_ar_lock}  {ARPROT fpga_axi_m1_ar_prot}  {ARREADY fpga_axi_m1_ar_ready}  {ARSIZE fpga_axi_m1_ar_size}  {ARVALID fpga_axi_m1_ar_valid}  {AWADDR fpga_axi_m1_aw_addr}  {AWBURST fpga_axi_m1_aw_burst}  {AWCACHE fpga_axi_m1_aw_cache}  {AWID fpga_axi_m1_aw_id}  {AWLEN fpga_axi_m1_aw_len}  {AWLOCK fpga_axi_m1_aw_lock}  {AWPROT fpga_axi_m1_aw_prot}  {AWREADY fpga_axi_m1_aw_ready}  {AWSIZE fpga_axi_m1_aw_size}  {AWVALID fpga_axi_m1_aw_valid}  {BID fpga_axi_m1_b_id}  {BREADY fpga_axi_m1_b_ready}  {BRESP fpga_axi_m1_b_resp}  {BVALID fpga_axi_m1_b_valid}  {RDATA fpga_axi_m1_r_data}  {RID fpga_axi_m1_r_id}  {RLAST fpga_axi_m1_r_last}  {RREADY fpga_axi_m1_r_ready}  {RRESP fpga_axi_m1_r_resp}  {RVALID fpga_axi_m1_r_valid}  {WDATA fpga_axi_m1_w_data}  {WLAST fpga_axi_m1_w_last}  {WREADY fpga_axi_m1_w_ready}  {WSTRB fpga_axi_m1_w_strb}  {WVALID fpga_axi_m1_w_valid}}
component::automapBusInterface -name rsnoc_fpga_s0_ahb -mode master -absdef {amba.com AMBA2 AHB_rtl r3p0_1} -manualmap {  {HADDR fpga_ahb_s0_haddr} {HBURST fpga_ahb_s0_hburst} {HMASTLOCK fpga_ahb_s0_hmastlock} {HPROT fpga_ahb_s0_hprot} {HRDATA fpga_ahb_s0_hrdata} {HREADY fpga_ahb_s0_hready} {HRESP fpga_ahb_s0_hresp} {HSELx fpga_ahb_s0_hsel} {HSIZE fpga_ahb_s0_hsize} {HTRANS fpga_ahb_s0_htrans} {HWBE fpga_ahb_s0_hwbe} {HWDATA fpga_ahb_s0_hwdata} {HWRITE fpga_ahb_s0_hwrite}}
component::save

component::setCurrentComponent {Vendor Library soc_config_subsystem 1.0}
component::automapBusInterface -name config_ss_uart0 -mode master -absdef {andes gemini UART_rtl 1.0} -manualmap {{SOUT uart0_sout} {SIN uart0_sin} {CTSN uart0_ctsn} {RTSN uart0_rtsn}}
component::automapBusInterface -name config_ss_uart1 -mode master -absdef {andes gemini UART_rtl 1.0} -manualmap {{SOUT uart1_sout} {SIN uart1_sin} {CTSN uart1_ctsn} {RTSN uart1_rtsn}}
component::automapBusInterface -name config_ss_i2c -mode master -absdef {andes gemini I2C_rtl 1.0} -manualmap {   {SCL_O scl_o} {SDA_O sda_o} {SCL_I scl_i} {SDA_I sda_i}}
component::automapBusInterface -name config_ss_qspi -mode master -absdef {andes gemini QSPI_rtl 1.0} -manualmap { {CS_N_IN spi_cs_n_in} {HOLD_N_IN spi_hold_n_in} {HOLD_N_OE spi_hold_n_oe} {HOLD_N_OUT spi_hold_n_out} {WP_N_IN spi_wp_n_in} {WP_N_OE spi_wp_n_oe} {WP_N_OUT spi_wp_n_out} {CLK_IN spi_clk_in} {CLK_OE spi_clk_oe} {CLK_OUT spi_clk_out} {CS_N_OE spi_cs_n_oe} {CS_N_OUT spi_cs_n_out} {MISO_IN spi_miso_in} {MISO_OE spi_miso_oe} {MISO_OUT spi_miso_out} {MOSI_IN spi_mosi_in} {MOSI_OE spi_mosi_oe} {MOSI_OUT spi_mosi_out}}
component::automapBusInterface -name config_ss_gpio -mode master -absdef {andes gemini GPIO_rtl 1.0} -manualmap { {GPIO_PULLDOWN gpio_pulldown} {GPIO_PULLUP gpio_pullup} {GPIO_OE gpio_oe} {GPIO_OUT gpio_out} {GPIO_IN gpio_in}}
component::automapBusInterface -name config_ss_gbe -mode master -absdef {rapidsilicon gemini GBE_rtl 1.0} -manualmap {  {RGMII_TXD rgmii_txd} {RGMII_TX_CTL rgmii_tx_ctl} {RGMII_RXD rgmii_rxd} {RGMII_RX_CTL rgmii_rx_ctl} {RGMII_RXC rgmii_rxc} {MDIO_MDC mdio_mdc} {MDIO_DATA mdio_data}}
component::automapBusInterface -name config_ss_usb -mode master -absdef {rapidsilicon gemini USB_rtl 1.0} -manualmap { 	 {DP usb_dp} {DN usb_dn} {XTAL_IN usb_xtal_in} {XTAL_OUT usb_xtal_out}}
component::save



design::setCurrentDesign {Vendor Library soc_ss_arch 1.0}
design::createHierarchicalConnection flexnoc rsnoc_fpga_m0_axi soc_ss_fpga_m0_axi
design::createHierarchicalConnection flexnoc rsnoc_fpga_m1_axi soc_ss_fpga_m1_axi
design::createHierarchicalConnection flexnoc rsnoc_fpga_s0_ahb soc_ss_fpga_s0_ahb

design::createHierarchicalConnection config_ss config_ss_uart0 soc_ss_uart0
design::createHierarchicalConnection config_ss config_ss_uart1 soc_ss_uart1
design::createHierarchicalConnection config_ss config_ss_i2c soc_ss_i2c
design::createHierarchicalConnection config_ss config_ss_qspi soc_ss_qspi
design::createHierarchicalConnection config_ss config_ss_gpio soc_ss_gpio
design::createHierarchicalConnection config_ss config_ss_gbe soc_ss_gbe
design::createHierarchicalConnection config_ss config_ss_usb soc_ss_usb


design::save



~> design::setPortToTieHex config_ss bcpu_m0_hresp 0x0 1 1
 design::setCurrentDesign {Vendor Library soc_ss_arch 1.0}
 design::removeAdhocConnection dma_s0_paddr
 design::removeAdhocConnection dma_s0_penable
 design::removeAdhocConnection dma_s0_prdata
 design::removeAdhocConnection dma_s0_pready
 design::removeAdhocConnection dma_s0_psel
 design::removeAdhocConnection dma_s0_pslverr
 design::removeAdhocConnection dma_s0_pwdata
 design::removeAdhocConnection dma_s0_pwrite
 design::removeAdhocConnection gbe_s0_paddr
 design::removeAdhocConnection gbe_s0_penable
 design::removeAdhocConnection gbe_s0_prdata
 design::removeAdhocConnection gbe_s0_pready
 design::removeAdhocConnection gbe_s0_psel
 design::removeAdhocConnection gbe_s0_pslverr
 design::removeAdhocConnection gbe_s0_pstrb
 design::removeAdhocConnection gbe_s0_pwdata
 design::removeAdhocConnection gbe_s0_pwrite
 design::removeAdhocConnection gbe_m0_araddr
 design::removeAdhocConnection gbe_m0_arburst
 design::removeAdhocConnection gbe_m0_arcache
 design::removeAdhocConnection gbe_m0_arid
 design::removeAdhocConnection gbe_m0_arlen
 design::removeAdhocConnection gbe_m0_arlock
 design::removeAdhocConnection gbe_m0_arprot
 design::removeAdhocConnection gbe_m0_arready
 design::removeAdhocConnection gbe_m0_arsize
 design::removeAdhocConnection gbe_m0_arvalid
 design::removeAdhocConnection gbe_m0_awaddr
 design::removeAdhocConnection gbe_m0_awburst
 design::removeAdhocConnection gbe_m0_awcache
 design::removeAdhocConnection gbe_m0_awid
 design::removeAdhocConnection gbe_m0_awlen
 design::removeAdhocConnection gbe_m0_awlock
 design::removeAdhocConnection gbe_m0_awprot
 design::removeAdhocConnection gbe_m0_awready
 design::removeAdhocConnection gbe_m0_awsize
 design::removeAdhocConnection gbe_m0_awvalid
 design::removeAdhocConnection gbe_m0_bid
 design::removeAdhocConnection gbe_m0_bready
 design::removeAdhocConnection gbe_m0_bresp
 design::removeAdhocConnection gbe_m0_bvalid
 design::removeAdhocConnection gbe_m0_rdata
 design::removeAdhocConnection gbe_m0_rid
 design::removeAdhocConnection gbe_m0_rlast
 design::removeAdhocConnection gbe_m0_rready
 design::removeAdhocConnection gbe_m0_rresp
 design::removeAdhocConnection gbe_m0_rvalid
 design::removeAdhocConnection gbe_m0_wdata
 design::removeAdhocConnection gbe_m0_wlast
 design::removeAdhocConnection gbe_m0_wready
 design::removeAdhocConnection gbe_m0_wstrb
 design::removeAdhocConnection gbe_m0_wvalid
 design::removeAdhocConnection spi_reg_s0_haddr
 design::removeAdhocConnection spi_reg_s0_hrdata
 design::removeAdhocConnection spi_reg_s0_hready
 design::removeAdhocConnection spi_reg_s0_hresp
 design::removeAdhocConnection spi_reg_s0_hsel
 design::removeAdhocConnection spi_reg_s0_htrans
 design::removeAdhocConnection spi_reg_s0_hwdata
 design::removeAdhocConnection spi_reg_s0_hwrite
 design::removeAdhocConnection spi_mem_s0_haddr
 design::removeAdhocConnection spi_mem_s0_hrdata
 design::removeAdhocConnection spi_mem_s0_hready
 design::removeAdhocConnection spi_mem_s0_hresp
 design::removeAdhocConnection spi_mem_s0_hsel
 design::removeAdhocConnection spi_mem_s0_htrans
 design::removeAdhocConnection spi_mem_s0_hwrite

 design::removeAdhocConnection usb_s0_araddr
 design::removeAdhocConnection usb_s0_arprot
 design::removeAdhocConnection usb_s0_arready
 design::removeAdhocConnection usb_s0_arvalid
 design::removeAdhocConnection usb_s0_awaddr
 design::removeAdhocConnection usb_s0_awprot
 design::removeAdhocConnection usb_s0_awready
 design::removeAdhocConnection usb_s0_awvalid
 design::removeAdhocConnection usb_s0_bready
 design::removeAdhocConnection usb_s0_bresp
 design::removeAdhocConnection usb_s0_bvalid
 design::removeAdhocConnection usb_s0_rdata
 design::removeAdhocConnection usb_s0_rready
 design::removeAdhocConnection usb_s0_rresp
 design::removeAdhocConnection usb_s0_rvalid
 design::removeAdhocConnection usb_s0_wdata
 design::removeAdhocConnection usb_s0_wready
 design::removeAdhocConnection usb_s0_wstrb
 design::removeAdhocConnection usb_s0_wvalid
 design::removeAdhocConnection usb_m0_araddr
 design::removeAdhocConnection usb_m0_arburst
 design::removeAdhocConnection usb_m0_arcache
 design::removeAdhocConnection usb_m0_arid
 design::removeAdhocConnection usb_m0_arlen
 design::removeAdhocConnection usb_m0_arlock
 design::removeAdhocConnection usb_m0_arprot
 design::removeAdhocConnection usb_m0_arready
 design::removeAdhocConnection usb_m0_arsize
 design::removeAdhocConnection usb_m0_arvalid
 design::removeAdhocConnection usb_m0_awaddr
 design::removeAdhocConnection usb_m0_awburst
 design::removeAdhocConnection usb_m0_awcache
 design::removeAdhocConnection usb_m0_awid
 design::removeAdhocConnection usb_m0_awlen
 design::removeAdhocConnection usb_m0_awlock
 design::removeAdhocConnection usb_m0_awprot
 design::removeAdhocConnection usb_m0_awready
 design::removeAdhocConnection usb_m0_awsize
 design::removeAdhocConnection usb_m0_awvalid
 design::removeAdhocConnection usb_m0_bid
 design::removeAdhocConnection usb_m0_bready
 design::removeAdhocConnection usb_m0_bresp
 design::removeAdhocConnection usb_m0_bvalid
 design::removeAdhocConnection usb_m0_rdata
 design::removeAdhocConnection usb_m0_rid
 design::removeAdhocConnection usb_m0_rlast
 design::removeAdhocConnection usb_m0_rready
 design::removeAdhocConnection usb_m0_rresp
 design::removeAdhocConnection usb_m0_rvalid
 design::removeAdhocConnection usb_m0_wdata
 design::removeAdhocConnection usb_m0_wlast
 design::removeAdhocConnection usb_m0_wready
 design::removeAdhocConnection usb_m0_wstrb
 design::removeAdhocConnection usb_m0_wvalid
 design::removeAdhocConnection dma_m0_araddr
 design::removeAdhocConnection dma_m0_arburst
 design::removeAdhocConnection dma_m0_arcache
 design::removeAdhocConnection dma_m0_arid
 design::removeAdhocConnection dma_m0_arlen
 design::removeAdhocConnection dma_m0_arlock
 design::removeAdhocConnection dma_m0_arprot
 design::removeAdhocConnection dma_m0_arready
 design::removeAdhocConnection dma_m0_arsize
 design::removeAdhocConnection dma_m0_arvalid
 design::removeAdhocConnection dma_m0_awaddr
 design::removeAdhocConnection dma_m0_awburst
 design::removeAdhocConnection dma_m0_awcache
 design::removeAdhocConnection dma_m0_awid
 design::removeAdhocConnection dma_m0_awlen
 design::removeAdhocConnection dma_m0_awlock
 design::removeAdhocConnection dma_m0_awprot
 design::removeAdhocConnection dma_m0_awready
 design::removeAdhocConnection dma_m0_awsize
 design::removeAdhocConnection dma_m0_awvalid
 design::removeAdhocConnection dma_m0_bid
 design::removeAdhocConnection dma_m0_bready
 design::removeAdhocConnection dma_m0_bresp
 design::removeAdhocConnection dma_m0_bvalid
 design::removeAdhocConnection dma_m0_rdata
 design::removeAdhocConnection dma_m0_rid
 design::removeAdhocConnection dma_m0_rlast
 design::removeAdhocConnection dma_m0_rready
 design::removeAdhocConnection dma_m0_rresp
 design::removeAdhocConnection dma_m0_rvalid
 design::removeAdhocConnection dma_m0_wdata
 design::removeAdhocConnection dma_m0_wlast
 design::removeAdhocConnection dma_m0_wready
 design::removeAdhocConnection dma_m0_wstrb
 design::removeAdhocConnection dma_m0_wvalid
 design::removeAdhocConnection dma_m1_araddr
 design::removeAdhocConnection dma_m1_arburst
 design::removeAdhocConnection dma_m1_arcache
 design::removeAdhocConnection dma_m1_arid
 design::removeAdhocConnection dma_m1_arlen
 design::removeAdhocConnection dma_m1_arlock
 design::removeAdhocConnection dma_m1_arprot
 design::removeAdhocConnection dma_m1_arready
 design::removeAdhocConnection dma_m1_arsize
 design::removeAdhocConnection dma_m1_arvalid
 design::removeAdhocConnection dma_m1_awaddr
 design::removeAdhocConnection dma_m1_awburst
 design::removeAdhocConnection dma_m1_awcache
 design::removeAdhocConnection dma_m1_awid
 design::removeAdhocConnection dma_m1_awlen
 design::removeAdhocConnection dma_m1_awlock
 design::removeAdhocConnection dma_m1_awprot
 design::removeAdhocConnection dma_m1_awready
 design::removeAdhocConnection dma_m1_awsize
 design::removeAdhocConnection dma_m1_awvalid
 design::removeAdhocConnection dma_m1_bid
 design::removeAdhocConnection dma_m1_bready
 design::removeAdhocConnection dma_m1_bresp
 design::removeAdhocConnection dma_m1_bvalid
 design::removeAdhocConnection dma_m1_rdata
 design::removeAdhocConnection dma_m1_rid
 design::removeAdhocConnection dma_m1_rlast
 design::removeAdhocConnection dma_m1_rready
 design::removeAdhocConnection dma_m1_rresp
 design::removeAdhocConnection dma_m1_rvalid
 design::removeAdhocConnection dma_m1_wdata
 design::removeAdhocConnection dma_m1_wlast
 design::removeAdhocConnection dma_m1_wready
 design::removeAdhocConnection dma_m1_wstrb
 design::removeAdhocConnection dma_m1_wvalid
 design::removeAdhocConnection gbe_m0_araddr
 design::removeAdhocConnection gbe_m0_arburst
 design::removeAdhocConnection gbe_m0_arcache
 design::removeAdhocConnection gbe_m0_arid
 design::removeAdhocConnection gbe_m0_arlen
 design::removeAdhocConnection gbe_m0_arlock
 design::removeAdhocConnection gbe_m0_arprot
 design::removeAdhocConnection gbe_m0_arready
 design::removeAdhocConnection gbe_m0_arsize
 design::removeAdhocConnection gbe_m0_arvalid
 design::removeAdhocConnection gbe_m0_awaddr
 design::removeAdhocConnection gbe_m0_awburst
 design::removeAdhocConnection gbe_m0_awcache
 design::removeAdhocConnection gbe_m0_awid
 design::removeAdhocConnection gbe_m0_awlen
 design::removeAdhocConnection gbe_m0_awlock
 design::removeAdhocConnection gbe_m0_awprot
 design::removeAdhocConnection gbe_m0_awready
 design::removeAdhocConnection gbe_m0_awsize
 design::removeAdhocConnection gbe_m0_awvalid
 design::removeAdhocConnection gbe_m0_bid
 design::removeAdhocConnection gbe_m0_bready
 design::removeAdhocConnection gbe_m0_bresp
 design::removeAdhocConnection gbe_m0_bvalid
 design::removeAdhocConnection gbe_m0_rdata
 design::removeAdhocConnection gbe_m0_rid
 design::removeAdhocConnection gbe_m0_rlast
 design::removeAdhocConnection gbe_m0_rready
 design::removeAdhocConnection gbe_m0_rresp
 design::removeAdhocConnection gbe_m0_rvalid
 design::removeAdhocConnection gbe_m0_wdata
 design::removeAdhocConnection gbe_m0_wlast
 design::removeAdhocConnection gbe_m0_wready
 design::removeAdhocConnection gbe_m0_wstrb
 design::removeAdhocConnection gbe_m0_wvalid

 design::removeAdhocConnection acpu_wdt_s0_paddr
design::removeAdhocConnection acpu_wdt_s0_penable
design::removeAdhocConnection acpu_wdt_s0_prdata
design::removeAdhocConnection acpu_wdt_s0_pready
design::removeAdhocConnection acpu_wdt_s0_psel
design::removeAdhocConnection acpu_wdt_s0_pslverr
design::removeAdhocConnection acpu_wdt_s0_pwdata
design::removeAdhocConnection acpu_wdt_s0_pwrite
design::removeAdhocConnection bcpu_wdt_s0_paddr
design::removeAdhocConnection bcpu_wdt_s0_penable
design::removeAdhocConnection bcpu_wdt_s0_prdata
design::removeAdhocConnection bcpu_wdt_s0_pready
design::removeAdhocConnection bcpu_wdt_s0_psel
design::removeAdhocConnection bcpu_wdt_s0_pslverr
design::removeAdhocConnection bcpu_wdt_s0_pwdata
design::removeAdhocConnection bcpu_wdt_s0_pwrite
design::removeAdhocConnection dma_s0_paddr
design::removeAdhocConnection dma_s0_penable
design::removeAdhocConnection dma_s0_prdata
design::removeAdhocConnection dma_s0_pready
design::removeAdhocConnection dma_s0_psel
design::removeAdhocConnection dma_s0_pslverr
design::removeAdhocConnection dma_s0_pwdata
design::removeAdhocConnection dma_s0_pwrite
design::removeAdhocConnection fcb_s0_paddr
design::removeAdhocConnection fcb_s0_penable
design::removeAdhocConnection fcb_s0_prdata
design::removeAdhocConnection fcb_s0_pready
design::removeAdhocConnection fcb_s0_psel
design::removeAdhocConnection fcb_s0_pslverr
design::removeAdhocConnection fcb_s0_pstrb
design::removeAdhocConnection fcb_s0_pwdata
design::removeAdhocConnection fcb_s0_pwrite
design::removeAdhocConnection gpio_s0_paddr
design::removeAdhocConnection gpio_s0_penable
design::removeAdhocConnection gpio_s0_prdata
design::removeAdhocConnection gpio_s0_pready
design::removeAdhocConnection gpio_s0_psel
design::removeAdhocConnection gpio_s0_pslverr
design::removeAdhocConnection gpio_s0_pwdata
design::removeAdhocConnection gpio_s0_pwrite
design::removeAdhocConnection gpt_s0_paddr
design::removeAdhocConnection gpt_s0_penable
design::removeAdhocConnection gpt_s0_prdata
design::removeAdhocConnection gpt_s0_pready
design::removeAdhocConnection gpt_s0_psel
design::removeAdhocConnection gpt_s0_pslverr
design::removeAdhocConnection gpt_s0_pwdata
design::removeAdhocConnection gpt_s0_pwrite
design::removeAdhocConnection i2c_s0_paddr
design::removeAdhocConnection i2c_s0_penable
design::removeAdhocConnection i2c_s0_prdata
design::removeAdhocConnection i2c_s0_pready
design::removeAdhocConnection i2c_s0_psel
design::removeAdhocConnection i2c_s0_pslverr
design::removeAdhocConnection i2c_s0_pwdata
design::removeAdhocConnection i2c_s0_pwrite
design::removeAdhocConnection mbox_s0_paddr
design::removeAdhocConnection mbox_s0_penable
design::removeAdhocConnection mbox_s0_prdata
design::removeAdhocConnection mbox_s0_pready
design::removeAdhocConnection mbox_s0_psel
design::removeAdhocConnection mbox_s0_pslverr
design::removeAdhocConnection mbox_s0_pstrb
design::removeAdhocConnection mbox_s0_pwdata
design::removeAdhocConnection mbox_s0_pwrite
design::removeAdhocConnection scu_s0_paddr
design::removeAdhocConnection scu_s0_penable
design::removeAdhocConnection scu_s0_prdata
design::removeAdhocConnection scu_s0_pready
design::removeAdhocConnection scu_s0_psel
design::removeAdhocConnection scu_s0_pslverr
design::removeAdhocConnection scu_s0_pstrb
design::removeAdhocConnection scu_s0_pwdata
design::removeAdhocConnection scu_s0_pwrite
design::removeAdhocConnection spi_reg_s0_haddr
design::removeAdhocConnection spi_reg_s0_hrdata
design::removeAdhocConnection spi_reg_s0_hready
design::removeAdhocConnection spi_reg_s0_hresp
design::removeAdhocConnection spi_reg_s0_hsel
design::removeAdhocConnection spi_reg_s0_htrans
design::removeAdhocConnection spi_reg_s0_hwdata
design::removeAdhocConnection spi_reg_s0_hwrite
design::removeAdhocConnection spi_mem_s0_haddr
design::removeAdhocConnection spi_mem_s0_hrdata
design::removeAdhocConnection spi_mem_s0_hready
design::removeAdhocConnection spi_mem_s0_hresp
design::removeAdhocConnection spi_mem_s0_hsel
design::removeAdhocConnection spi_mem_s0_htrans
design::removeAdhocConnection spi_mem_s0_hwrite
design::removeAdhocConnection uart_s0_paddr
design::removeAdhocConnection uart_s0_penable
design::removeAdhocConnection uart_s0_prdata
design::removeAdhocConnection uart_s0_pready
design::removeAdhocConnection uart_s0_psel
design::removeAdhocConnection uart_s0_pslverr
design::removeAdhocConnection uart_s0_pwdata
design::removeAdhocConnection uart_s0_pwrite
design::removeAdhocConnection uart_s1_paddr
design::removeAdhocConnection uart_s1_penable
design::removeAdhocConnection uart_s1_prdata
design::removeAdhocConnection uart_s1_pready
design::removeAdhocConnection uart_s1_psel
design::removeAdhocConnection uart_s1_pslverr
design::removeAdhocConnection uart_s1_pwdata
design::removeAdhocConnection uart_s1_pwrite
design::removeAdhocConnection usb_s0_araddr
design::removeAdhocConnection usb_s0_arprot
design::removeAdhocConnection usb_s0_arready
design::removeAdhocConnection usb_s0_arvalid
design::removeAdhocConnection usb_s0_awaddr
design::removeAdhocConnection usb_s0_awprot
design::removeAdhocConnection usb_s0_awready
design::removeAdhocConnection usb_s0_awvalid
design::removeAdhocConnection usb_s0_bready
design::removeAdhocConnection usb_s0_bresp
design::removeAdhocConnection usb_s0_bvalid
design::removeAdhocConnection usb_s0_rdata
design::removeAdhocConnection usb_s0_rready
design::removeAdhocConnection usb_s0_rresp
design::removeAdhocConnection usb_s0_rvalid
design::removeAdhocConnection usb_s0_wdata
design::removeAdhocConnection usb_s0_wready
design::removeAdhocConnection usb_s0_wstrb
design::removeAdhocConnection usb_s0_wvalid
design::removeAdhocConnection acpu_m0_araddr
design::removeAdhocConnection acpu_m0_arburst
design::removeAdhocConnection acpu_m0_arcache
design::removeAdhocConnection acpu_m0_arid
design::removeAdhocConnection acpu_m0_arlen
design::removeAdhocConnection acpu_m0_arlock
design::removeAdhocConnection acpu_m0_arprot
design::removeAdhocConnection acpu_m0_arready
design::removeAdhocConnection acpu_m0_arsize
design::removeAdhocConnection acpu_m0_arvalid
design::removeAdhocConnection acpu_m0_awaddr
design::removeAdhocConnection acpu_m0_awburst
design::removeAdhocConnection acpu_m0_awcache
design::removeAdhocConnection acpu_m0_awid
design::removeAdhocConnection acpu_m0_awlen
design::removeAdhocConnection acpu_m0_awlock
design::removeAdhocConnection acpu_m0_awprot
design::removeAdhocConnection acpu_m0_awready
design::removeAdhocConnection acpu_m0_awsize
design::removeAdhocConnection acpu_m0_awvalid
design::removeAdhocConnection acpu_m0_bid
design::removeAdhocConnection acpu_m0_bready
design::removeAdhocConnection acpu_m0_bresp
design::removeAdhocConnection acpu_m0_bvalid
design::removeAdhocConnection acpu_m0_rdata
design::removeAdhocConnection acpu_m0_rid
design::removeAdhocConnection acpu_m0_rlast
design::removeAdhocConnection acpu_m0_rready
design::removeAdhocConnection acpu_m0_rresp
design::removeAdhocConnection acpu_m0_rvalid
design::removeAdhocConnection acpu_m0_wdata
design::removeAdhocConnection acpu_m0_wlast
design::removeAdhocConnection acpu_m0_wready
design::removeAdhocConnection acpu_m0_wstrb
design::removeAdhocConnection acpu_m0_wvalid
design::removeAdhocConnection bcpu_m0_haddr
design::removeAdhocConnection bcpu_m0_hburst
design::removeAdhocConnection bcpu_m0_hprot
design::removeAdhocConnection bcpu_m0_hrdata
design::removeAdhocConnection bcpu_m0_hready
design::removeAdhocConnection bcpu_m0_hresp
design::removeAdhocConnection bcpu_m0_hsize
design::removeAdhocConnection bcpu_m0_htrans
design::removeAdhocConnection bcpu_m0_hwdata
design::removeAdhocConnection bcpu_m0_hwrite
design::removeAdhocConnection ddr0_araddr
design::removeAdhocConnection ddr0_arburst
design::removeAdhocConnection ddr0_arcache
design::removeAdhocConnection ddr0_arid
design::removeAdhocConnection ddr0_arlen
design::removeAdhocConnection ddr0_arlock
design::removeAdhocConnection ddr0_arprot
design::removeAdhocConnection ddr0_arready
design::removeAdhocConnection ddr0_arsize
design::removeAdhocConnection ddr0_arvalid
design::removeAdhocConnection ddr0_awaddr
design::removeAdhocConnection ddr0_awburst
design::removeAdhocConnection ddr0_awcache
design::removeAdhocConnection ddr0_awid
design::removeAdhocConnection ddr0_awlen
design::removeAdhocConnection ddr0_awlock
design::removeAdhocConnection ddr0_awprot
design::removeAdhocConnection ddr0_awready
design::removeAdhocConnection ddr0_awsize
design::removeAdhocConnection ddr0_awvalid
design::removeAdhocConnection ddr0_bid
design::removeAdhocConnection ddr0_bready
design::removeAdhocConnection ddr0_bresp
design::removeAdhocConnection ddr0_bvalid
design::removeAdhocConnection ddr0_rdata
design::removeAdhocConnection ddr0_rid
design::removeAdhocConnection ddr0_rlast
design::removeAdhocConnection ddr0_rready
design::removeAdhocConnection ddr0_rresp
design::removeAdhocConnection ddr0_rvalid
design::removeAdhocConnection ddr0_wdata
design::removeAdhocConnection ddr0_wlast
design::removeAdhocConnection ddr0_wready
design::removeAdhocConnection ddr0_wstrb
design::removeAdhocConnection ddr0_wvalid
design::removeAdhocConnection ddr1_araddr
design::removeAdhocConnection ddr1_arburst
design::removeAdhocConnection ddr1_arcache
design::removeAdhocConnection ddr1_arid
design::removeAdhocConnection ddr1_arlen
design::removeAdhocConnection ddr1_arlock
design::removeAdhocConnection ddr1_arprot
design::removeAdhocConnection ddr1_arready
design::removeAdhocConnection ddr1_arsize
design::removeAdhocConnection ddr1_arvalid
design::removeAdhocConnection ddr1_awaddr
design::removeAdhocConnection ddr1_awburst
design::removeAdhocConnection ddr1_awcache
design::removeAdhocConnection ddr1_awid
design::removeAdhocConnection ddr1_awlen
design::removeAdhocConnection ddr1_awlock
design::removeAdhocConnection ddr1_awprot
design::removeAdhocConnection ddr1_awready
design::removeAdhocConnection ddr1_awsize
design::removeAdhocConnection ddr1_awvalid
design::removeAdhocConnection ddr1_bid
design::removeAdhocConnection ddr1_bready
design::removeAdhocConnection ddr1_bresp
design::removeAdhocConnection ddr1_bvalid
design::removeAdhocConnection ddr1_rdata
design::removeAdhocConnection ddr1_rid
design::removeAdhocConnection ddr1_rlast
design::removeAdhocConnection ddr1_rready
design::removeAdhocConnection ddr1_rresp
design::removeAdhocConnection ddr1_rvalid
design::removeAdhocConnection ddr1_wdata
design::removeAdhocConnection ddr1_wlast
design::removeAdhocConnection ddr1_wready
design::removeAdhocConnection ddr1_wstrb
design::removeAdhocConnection ddr1_wvalid
design::removeAdhocConnection ddr2_araddr
design::removeAdhocConnection ddr2_arburst
design::removeAdhocConnection ddr2_arcache
design::removeAdhocConnection ddr2_arid
design::removeAdhocConnection ddr2_arlen
design::removeAdhocConnection ddr2_arlock
design::removeAdhocConnection ddr2_arprot
design::removeAdhocConnection ddr2_arready
design::removeAdhocConnection ddr2_arsize
design::removeAdhocConnection ddr2_arvalid
design::removeAdhocConnection ddr2_awaddr
design::removeAdhocConnection ddr2_awburst
design::removeAdhocConnection ddr2_awcache
design::removeAdhocConnection ddr2_awid
design::removeAdhocConnection ddr2_awlen
design::removeAdhocConnection ddr2_awlock
design::removeAdhocConnection ddr2_awprot
design::removeAdhocConnection ddr2_awready
design::removeAdhocConnection ddr2_awsize
design::removeAdhocConnection ddr2_awvalid
design::removeAdhocConnection ddr2_bid
design::removeAdhocConnection ddr2_bready
design::removeAdhocConnection ddr2_bresp
design::removeAdhocConnection ddr2_bvalid
design::removeAdhocConnection ddr2_rdata
design::removeAdhocConnection ddr2_rid
design::removeAdhocConnection ddr2_rlast
design::removeAdhocConnection ddr2_rready
design::removeAdhocConnection ddr2_rresp
design::removeAdhocConnection ddr2_rvalid
design::removeAdhocConnection ddr2_wdata
design::removeAdhocConnection ddr2_wlast
design::removeAdhocConnection ddr2_wready
design::removeAdhocConnection ddr2_wstrb
design::removeAdhocConnection ddr2_wvalid
design::removeAdhocConnection ddr3_araddr
design::removeAdhocConnection ddr3_arburst
design::removeAdhocConnection ddr3_arcache
design::removeAdhocConnection ddr3_arid
design::removeAdhocConnection ddr3_arlen
design::removeAdhocConnection ddr3_arlock
design::removeAdhocConnection ddr3_arprot
design::removeAdhocConnection ddr3_arready
design::removeAdhocConnection ddr3_arsize
design::removeAdhocConnection ddr3_arvalid
design::removeAdhocConnection ddr3_awaddr
design::removeAdhocConnection ddr3_awburst
design::removeAdhocConnection ddr3_awcache
design::removeAdhocConnection ddr3_awid
design::removeAdhocConnection ddr3_awlen
design::removeAdhocConnection ddr3_awlock
design::removeAdhocConnection ddr3_awprot
design::removeAdhocConnection ddr3_awready
design::removeAdhocConnection ddr3_awsize
design::removeAdhocConnection ddr3_awvalid
design::removeAdhocConnection ddr3_bid
design::removeAdhocConnection ddr3_bready
design::removeAdhocConnection ddr3_bresp
design::removeAdhocConnection ddr3_bvalid
design::removeAdhocConnection ddr3_rdata
design::removeAdhocConnection ddr3_rid
design::removeAdhocConnection ddr3_rlast
design::removeAdhocConnection ddr3_rready
design::removeAdhocConnection ddr3_rresp
design::removeAdhocConnection ddr3_rvalid
design::removeAdhocConnection ddr3_wdata
design::removeAdhocConnection ddr3_wlast
design::removeAdhocConnection ddr3_wready
design::removeAdhocConnection ddr3_wstrb
design::removeAdhocConnection ddr3_wvalid
design::removeAdhocConnection cntl_araddr
design::removeAdhocConnection cntl_arready
design::removeAdhocConnection cntl_arvalid
design::removeAdhocConnection cntl_awaddr
design::removeAdhocConnection cntl_awready
design::removeAdhocConnection cntl_awvalid
design::removeAdhocConnection cntl_bready
design::removeAdhocConnection cntl_bresp
design::removeAdhocConnection cntl_bvalid
design::removeAdhocConnection cntl_rdata
design::removeAdhocConnection cntl_rready
design::removeAdhocConnection cntl_rresp
design::removeAdhocConnection cntl_rvalid
design::removeAdhocConnection cntl_wdata
design::removeAdhocConnection cntl_wready
design::removeAdhocConnection cntl_wvalid
design::removeAdhocConnection dma_m0_araddr
design::removeAdhocConnection dma_m0_arburst
design::removeAdhocConnection dma_m0_arcache
design::removeAdhocConnection dma_m0_arid
design::removeAdhocConnection dma_m0_arlen
design::removeAdhocConnection dma_m0_arlock
design::removeAdhocConnection dma_m0_arprot
design::removeAdhocConnection dma_m0_arready
design::removeAdhocConnection dma_m0_arsize
design::removeAdhocConnection dma_m0_arvalid
design::removeAdhocConnection dma_m0_awaddr
design::removeAdhocConnection dma_m0_awburst
design::removeAdhocConnection dma_m0_awcache
design::removeAdhocConnection dma_m0_awid
design::removeAdhocConnection dma_m0_awlen
design::removeAdhocConnection dma_m0_awlock
design::removeAdhocConnection dma_m0_awprot
design::removeAdhocConnection dma_m0_awready
design::removeAdhocConnection dma_m0_awsize
design::removeAdhocConnection dma_m0_awvalid
design::removeAdhocConnection dma_m0_bid
design::removeAdhocConnection dma_m0_bready
design::removeAdhocConnection dma_m0_bresp
design::removeAdhocConnection dma_m0_bvalid
design::removeAdhocConnection dma_m0_rdata
design::removeAdhocConnection dma_m0_rid
design::removeAdhocConnection dma_m0_rlast
design::removeAdhocConnection dma_m0_rready
design::removeAdhocConnection dma_m0_rresp
design::removeAdhocConnection dma_m0_rvalid
design::removeAdhocConnection dma_m0_wdata
design::removeAdhocConnection dma_m0_wlast
design::removeAdhocConnection dma_m0_wready
design::removeAdhocConnection dma_m0_wstrb
design::removeAdhocConnection dma_m0_wvalid
design::removeAdhocConnection dma_m1_araddr
design::removeAdhocConnection dma_m1_arburst
design::removeAdhocConnection dma_m1_arcache
design::removeAdhocConnection dma_m1_arlen
design::removeAdhocConnection dma_m1_arlock
design::removeAdhocConnection dma_m1_arprot
design::removeAdhocConnection dma_m1_arready
design::removeAdhocConnection dma_m1_arsize
design::removeAdhocConnection dma_m1_arvalid
design::removeAdhocConnection dma_m1_awaddr
design::removeAdhocConnection dma_m1_awburst
design::removeAdhocConnection dma_m1_awcache
design::removeAdhocConnection dma_m1_awlen
design::removeAdhocConnection dma_m1_awlock
design::removeAdhocConnection dma_m1_awprot
design::removeAdhocConnection dma_m1_awready
design::removeAdhocConnection dma_m1_awsize
design::removeAdhocConnection dma_m1_awvalid
design::removeAdhocConnection dma_m1_bid
design::removeAdhocConnection dma_m1_bready
design::removeAdhocConnection dma_m1_bresp
design::removeAdhocConnection dma_m1_bvalid
design::removeAdhocConnection dma_m1_rdata
design::removeAdhocConnection dma_m1_rid
design::removeAdhocConnection dma_m1_rlast
design::removeAdhocConnection dma_m1_rready
design::removeAdhocConnection dma_m1_rresp
design::removeAdhocConnection dma_m1_rvalid
design::removeAdhocConnection dma_m1_wdata
design::removeAdhocConnection dma_m1_wlast
design::removeAdhocConnection dma_m1_wready
design::removeAdhocConnection dma_m1_wstrb
design::removeAdhocConnection dma_m1_wvalid
design::removeAdhocConnection fpga_ahb_s0_haddr
design::removeAdhocConnection fpga_ahb_s0_hburst
design::removeAdhocConnection fpga_ahb_s0_hmastlock
design::removeAdhocConnection fpga_ahb_s0_hprot
design::removeAdhocConnection fpga_ahb_s0_hrdata
design::removeAdhocConnection fpga_ahb_s0_hready
design::removeAdhocConnection fpga_ahb_s0_hresp
design::removeAdhocConnection fpga_ahb_s0_hsel
design::removeAdhocConnection fpga_ahb_s0_hsize
design::removeAdhocConnection fpga_ahb_s0_htrans
design::removeAdhocConnection fpga_ahb_s0_hwbe
design::removeAdhocConnection fpga_ahb_s0_hwdata
design::removeAdhocConnection fpga_ahb_s0_hwrite
design::removeAdhocConnection fpga_axi_m0_ar_addr
design::removeAdhocConnection fpga_axi_m0_ar_burst
design::removeAdhocConnection fpga_axi_m0_ar_cache
design::removeAdhocConnection fpga_axi_m0_ar_id
design::removeAdhocConnection fpga_axi_m0_ar_len
design::removeAdhocConnection fpga_axi_m0_ar_lock
design::removeAdhocConnection fpga_axi_m0_ar_prot
design::removeAdhocConnection fpga_axi_m0_ar_ready
design::removeAdhocConnection fpga_axi_m0_ar_size
design::removeAdhocConnection fpga_axi_m0_ar_valid
design::removeAdhocConnection fpga_axi_m0_aw_addr
design::removeAdhocConnection fpga_axi_m0_aw_burst
design::removeAdhocConnection fpga_axi_m0_aw_cache
design::removeAdhocConnection fpga_axi_m0_aw_id
design::removeAdhocConnection fpga_axi_m0_aw_len
design::removeAdhocConnection fpga_axi_m0_aw_lock
design::removeAdhocConnection fpga_axi_m0_aw_prot
design::removeAdhocConnection fpga_axi_m0_aw_ready
design::removeAdhocConnection fpga_axi_m0_aw_size
design::removeAdhocConnection fpga_axi_m0_aw_valid
design::removeAdhocConnection fpga_axi_m0_b_id
design::removeAdhocConnection fpga_axi_m0_b_ready
design::removeAdhocConnection fpga_axi_m0_b_resp
design::removeAdhocConnection fpga_axi_m0_b_valid
design::removeAdhocConnection fpga_axi_m0_r_data
design::removeAdhocConnection fpga_axi_m0_r_id
design::removeAdhocConnection fpga_axi_m0_r_last
design::removeAdhocConnection fpga_axi_m0_r_ready
design::removeAdhocConnection fpga_axi_m0_r_resp
design::removeAdhocConnection fpga_axi_m0_r_valid
design::removeAdhocConnection fpga_axi_m0_w_data
design::removeAdhocConnection fpga_axi_m0_w_last
design::removeAdhocConnection fpga_axi_m0_w_ready
design::removeAdhocConnection fpga_axi_m0_w_strb
design::removeAdhocConnection fpga_axi_m0_w_valid
design::removeAdhocConnection fpga_axi_m1_ar_addr
design::removeAdhocConnection fpga_axi_m1_ar_burst
design::removeAdhocConnection fpga_axi_m1_ar_cache
design::removeAdhocConnection fpga_axi_m1_ar_id
design::removeAdhocConnection fpga_axi_m1_ar_len
design::removeAdhocConnection fpga_axi_m1_ar_lock
design::removeAdhocConnection fpga_axi_m1_ar_prot
design::removeAdhocConnection fpga_axi_m1_ar_ready
design::removeAdhocConnection fpga_axi_m1_ar_size
design::removeAdhocConnection fpga_axi_m1_ar_valid
design::removeAdhocConnection fpga_axi_m1_aw_addr
design::removeAdhocConnection fpga_axi_m1_aw_burst
design::removeAdhocConnection fpga_axi_m1_aw_cache
design::removeAdhocConnection fpga_axi_m1_aw_id
design::removeAdhocConnection fpga_axi_m1_aw_len
design::removeAdhocConnection fpga_axi_m1_aw_lock
design::removeAdhocConnection fpga_axi_m1_aw_prot
design::removeAdhocConnection fpga_axi_m1_aw_ready
design::removeAdhocConnection fpga_axi_m1_aw_size
design::removeAdhocConnection fpga_axi_m1_aw_valid
design::removeAdhocConnection fpga_axi_m1_b_id
design::removeAdhocConnection fpga_axi_m1_b_ready
design::removeAdhocConnection fpga_axi_m1_b_resp
design::removeAdhocConnection fpga_axi_m1_b_valid
design::removeAdhocConnection fpga_axi_m1_r_data
design::removeAdhocConnection fpga_axi_m1_r_id
design::removeAdhocConnection fpga_axi_m1_r_last
design::removeAdhocConnection fpga_axi_m1_r_ready
design::removeAdhocConnection fpga_axi_m1_r_resp
design::removeAdhocConnection fpga_axi_m1_r_valid
design::removeAdhocConnection fpga_axi_m1_w_data
design::removeAdhocConnection fpga_axi_m1_w_last
design::removeAdhocConnection fpga_axi_m1_w_ready
design::removeAdhocConnection fpga_axi_m1_w_strb
design::removeAdhocConnection fpga_axi_m1_w_valid
design::removeAdhocConnection gbe_s0_paddr
design::removeAdhocConnection gbe_s0_penable
design::removeAdhocConnection gbe_s0_prdata
design::removeAdhocConnection gbe_s0_pready
design::removeAdhocConnection gbe_s0_psel
design::removeAdhocConnection gbe_s0_pslverr
design::removeAdhocConnection gbe_s0_pstrb
design::removeAdhocConnection gbe_s0_pwdata
design::removeAdhocConnection gbe_s0_pwrite
design::removeAdhocConnection gbe_m0_araddr
design::removeAdhocConnection gbe_m0_arburst
design::removeAdhocConnection gbe_m0_arcache
design::removeAdhocConnection gbe_m0_arid
design::removeAdhocConnection gbe_m0_arlen
design::removeAdhocConnection gbe_m0_arlock
design::removeAdhocConnection gbe_m0_arprot
design::removeAdhocConnection gbe_m0_arready
design::removeAdhocConnection gbe_m0_arsize
design::removeAdhocConnection gbe_m0_arvalid
design::removeAdhocConnection gbe_m0_awaddr
design::removeAdhocConnection gbe_m0_awburst
design::removeAdhocConnection gbe_m0_awcache
design::removeAdhocConnection gbe_m0_awid
design::removeAdhocConnection gbe_m0_awlen
design::removeAdhocConnection gbe_m0_awlock
design::removeAdhocConnection gbe_m0_awprot
design::removeAdhocConnection gbe_m0_awready
design::removeAdhocConnection gbe_m0_awsize
design::removeAdhocConnection gbe_m0_awvalid
design::removeAdhocConnection gbe_m0_bid
design::removeAdhocConnection gbe_m0_bready
design::removeAdhocConnection gbe_m0_bresp
design::removeAdhocConnection gbe_m0_bvalid
design::removeAdhocConnection gbe_m0_rdata
design::removeAdhocConnection gbe_m0_rid
design::removeAdhocConnection gbe_m0_rlast
design::removeAdhocConnection gbe_m0_rready
design::removeAdhocConnection gbe_m0_rresp
design::removeAdhocConnection gbe_m0_rvalid
design::removeAdhocConnection gbe_m0_wdata
design::removeAdhocConnection gbe_m0_wlast
design::removeAdhocConnection gbe_m0_wready
design::removeAdhocConnection gbe_m0_wstrb
design::removeAdhocConnection gbe_m0_wvalid
design::removeAdhocConnection rst_n_133
design::removeAdhocConnection rst_n_266
design::removeAdhocConnection rst_n_533
design::removeAdhocConnection sramb0_araddr
design::removeAdhocConnection sramb0_arburst
design::removeAdhocConnection sramb0_arid
design::removeAdhocConnection sramb0_arlen
design::removeAdhocConnection sramb0_arready
design::removeAdhocConnection sramb0_arsize
design::removeAdhocConnection sramb0_arvalid
design::removeAdhocConnection sramb0_awaddr
design::removeAdhocConnection sramb0_awburst
design::removeAdhocConnection sramb0_awid
design::removeAdhocConnection sramb0_awlen
design::removeAdhocConnection sramb0_awready
design::removeAdhocConnection sramb0_awsize
design::removeAdhocConnection sramb0_awvalid
design::removeAdhocConnection sramb0_bid
design::removeAdhocConnection sramb0_bready
design::removeAdhocConnection sramb0_bresp
design::removeAdhocConnection sramb0_bvalid
design::removeAdhocConnection sramb0_rdata
design::removeAdhocConnection sramb0_rid
design::removeAdhocConnection sramb0_rlast
design::removeAdhocConnection sramb0_rready
design::removeAdhocConnection sramb0_rresp
design::removeAdhocConnection sramb0_rvalid
design::removeAdhocConnection sramb0_wdata
design::removeAdhocConnection sramb0_wlast
design::removeAdhocConnection sramb0_wready
design::removeAdhocConnection sramb0_wstrb
design::removeAdhocConnection sramb0_wvalid
design::removeAdhocConnection sramb1_araddr
design::removeAdhocConnection sramb1_arburst
design::removeAdhocConnection sramb1_arid
design::removeAdhocConnection sramb1_arlen
design::removeAdhocConnection sramb1_arready
design::removeAdhocConnection sramb1_arsize
design::removeAdhocConnection sramb1_arvalid
design::removeAdhocConnection sramb1_awaddr
design::removeAdhocConnection sramb1_awburst
design::removeAdhocConnection sramb1_awid
design::removeAdhocConnection sramb1_awlen
design::removeAdhocConnection sramb1_awready
design::removeAdhocConnection sramb1_awsize
design::removeAdhocConnection sramb1_awvalid
design::removeAdhocConnection sramb1_bid
design::removeAdhocConnection sramb1_bready
design::removeAdhocConnection sramb1_bresp
design::removeAdhocConnection sramb1_bvalid
design::removeAdhocConnection sramb1_rdata
design::removeAdhocConnection sramb1_rid
design::removeAdhocConnection sramb1_rlast
design::removeAdhocConnection sramb1_rready
design::removeAdhocConnection sramb1_rresp
design::removeAdhocConnection sramb1_rvalid
design::removeAdhocConnection sramb1_wdata
design::removeAdhocConnection sramb1_wlast
design::removeAdhocConnection sramb1_wready
design::removeAdhocConnection sramb1_wstrb
design::removeAdhocConnection sramb1_wvalid
design::removeAdhocConnection sramb2_araddr
design::removeAdhocConnection sramb2_arburst
design::removeAdhocConnection sramb2_arid
design::removeAdhocConnection sramb2_arlen
design::removeAdhocConnection sramb2_arready
design::removeAdhocConnection sramb2_arsize
design::removeAdhocConnection sramb2_arvalid
design::removeAdhocConnection sramb2_awaddr
design::removeAdhocConnection sramb2_awburst
design::removeAdhocConnection sramb2_awid
design::removeAdhocConnection sramb2_awlen
design::removeAdhocConnection sramb2_awready
design::removeAdhocConnection sramb2_awsize
design::removeAdhocConnection sramb2_awvalid
design::removeAdhocConnection sramb2_bid
design::removeAdhocConnection sramb2_bready
design::removeAdhocConnection sramb2_bresp
design::removeAdhocConnection sramb2_bvalid
design::removeAdhocConnection sramb2_rdata
design::removeAdhocConnection sramb2_rid
design::removeAdhocConnection sramb2_rlast
design::removeAdhocConnection sramb2_rready
design::removeAdhocConnection sramb2_rresp
design::removeAdhocConnection sramb2_rvalid
design::removeAdhocConnection sramb2_wdata
design::removeAdhocConnection sramb2_wlast
design::removeAdhocConnection sramb2_wready
design::removeAdhocConnection sramb2_wstrb
design::removeAdhocConnection sramb2_wvalid
design::removeAdhocConnection sramb3_araddr
design::removeAdhocConnection sramb3_arburst
design::removeAdhocConnection sramb3_arid
design::removeAdhocConnection sramb3_arlen
design::removeAdhocConnection sramb3_arready
design::removeAdhocConnection sramb3_arsize
design::removeAdhocConnection sramb3_arvalid
design::removeAdhocConnection sramb3_awaddr
design::removeAdhocConnection sramb3_awburst
design::removeAdhocConnection sramb3_awid
design::removeAdhocConnection sramb3_awlen
design::removeAdhocConnection sramb3_awready
design::removeAdhocConnection sramb3_awsize
design::removeAdhocConnection sramb3_awvalid
design::removeAdhocConnection sramb3_bid
design::removeAdhocConnection sramb3_bready
design::removeAdhocConnection sramb3_bresp
design::removeAdhocConnection sramb3_bvalid
design::removeAdhocConnection sramb3_rdata
design::removeAdhocConnection sramb3_rid
design::removeAdhocConnection sramb3_rlast
design::removeAdhocConnection sramb3_rready
design::removeAdhocConnection sramb3_rresp
design::removeAdhocConnection sramb3_rvalid
design::removeAdhocConnection sramb3_wdata
design::removeAdhocConnection sramb3_wlast
design::removeAdhocConnection sramb3_wready
design::removeAdhocConnection sramb3_wstrb
design::removeAdhocConnection sramb3_wvalid
design::removeAdhocConnection usb_m0_araddr
design::removeAdhocConnection usb_m0_arburst
design::removeAdhocConnection usb_m0_arcache
design::removeAdhocConnection usb_m0_arid
design::removeAdhocConnection usb_m0_arlen
design::removeAdhocConnection usb_m0_arlock
design::removeAdhocConnection usb_m0_arprot
design::removeAdhocConnection usb_m0_arready
design::removeAdhocConnection usb_m0_arsize
design::removeAdhocConnection usb_m0_arvalid
design::removeAdhocConnection usb_m0_awaddr
design::removeAdhocConnection usb_m0_awburst
design::removeAdhocConnection usb_m0_awcache
design::removeAdhocConnection usb_m0_awid
design::removeAdhocConnection usb_m0_awlen
design::removeAdhocConnection usb_m0_awlock
design::removeAdhocConnection usb_m0_awprot
design::removeAdhocConnection usb_m0_awready
design::removeAdhocConnection usb_m0_awsize
design::removeAdhocConnection usb_m0_awvalid
design::removeAdhocConnection usb_m0_bid
design::removeAdhocConnection usb_m0_bready
design::removeAdhocConnection usb_m0_bresp
design::removeAdhocConnection usb_m0_bvalid
design::removeAdhocConnection usb_m0_rdata
design::removeAdhocConnection usb_m0_rid
design::removeAdhocConnection usb_m0_rlast
design::removeAdhocConnection usb_m0_rready
design::removeAdhocConnection usb_m0_rresp
design::removeAdhocConnection usb_m0_rvalid
design::removeAdhocConnection usb_m0_wdata
design::removeAdhocConnection usb_m0_wlast
design::removeAdhocConnection usb_m0_wready
design::removeAdhocConnection usb_m0_wstrb
design::removeAdhocConnection usb_m0_wvalid