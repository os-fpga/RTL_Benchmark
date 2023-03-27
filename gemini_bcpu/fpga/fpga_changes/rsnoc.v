module rsnoc (
	ACPU_WDT_PAddr
,	ACPU_WDT_PEnable
,	ACPU_WDT_PRData
,	ACPU_WDT_PReady
,	ACPU_WDT_PSel
,	ACPU_WDT_PSlvErr
,	ACPU_WDT_PWBe
,	ACPU_WDT_PWData
,	ACPU_WDT_PWrite
,	BCPU_WDT_PAddr
,	BCPU_WDT_PEnable
,	BCPU_WDT_PRData
,	BCPU_WDT_PReady
,	BCPU_WDT_PSel
,	BCPU_WDT_PSlvErr
,	BCPU_WDT_PWBe
,	BCPU_WDT_PWData
,	BCPU_WDT_PWrite
,	DMA_apb_s0_paddr
,	DMA_apb_s0_penable
,	DMA_apb_s0_prdata
,	DMA_apb_s0_pready
,	DMA_apb_s0_psel
,	DMA_apb_s0_pslverr
,	DMA_apb_s0_pwbe
,	DMA_apb_s0_pwdata
,	DMA_apb_s0_pwrite
,	FCB_apb_s0_paddr
,	FCB_apb_s0_penable
,	FCB_apb_s0_prdata
,	FCB_apb_s0_pready
,	FCB_apb_s0_psel
,	FCB_apb_s0_pslverr
,	FCB_apb_s0_pwbe
,	FCB_apb_s0_pwdata
,	FCB_apb_s0_pwrite
,	GPIO_apb_s0_paddr
,	GPIO_apb_s0_penable
,	GPIO_apb_s0_prdata
,	GPIO_apb_s0_pready
,	GPIO_apb_s0_psel
,	GPIO_apb_s0_pslverr
,	GPIO_apb_s0_pwbe
,	GPIO_apb_s0_pwdata
,	GPIO_apb_s0_pwrite
,	GPT_apb_s0_paddr
,	GPT_apb_s0_penable
,	GPT_apb_s0_prdata
,	GPT_apb_s0_pready
,	GPT_apb_s0_psel
,	GPT_apb_s0_pslverr
,	GPT_apb_s0_pwbe
,	GPT_apb_s0_pwdata
,	GPT_apb_s0_pwrite
,	I2C_apb_s0_paddr
,	I2C_apb_s0_penable
,	I2C_apb_s0_prdata
,	I2C_apb_s0_pready
,	I2C_apb_s0_psel
,	I2C_apb_s0_pslverr
,	I2C_apb_s0_pwbe
,	I2C_apb_s0_pwdata
,	I2C_apb_s0_pwrite
,	MBOX_apb_s0_paddr
,	MBOX_apb_s0_penable
,	MBOX_apb_s0_prdata
,	MBOX_apb_s0_pready
,	MBOX_apb_s0_psel
,	MBOX_apb_s0_pslverr
,	MBOX_apb_s0_pwbe
,	MBOX_apb_s0_pwdata
,	MBOX_apb_s0_pwrite
,	PUFCC_apb_s0_PAddr
,	PUFCC_apb_s0_PEnable
,	PUFCC_apb_s0_PProt
,	PUFCC_apb_s0_PRData
,	PUFCC_apb_s0_PReady
,	PUFCC_apb_s0_PSel
,	PUFCC_apb_s0_PSlvErr
,	PUFCC_apb_s0_PStrb
,	PUFCC_apb_s0_PWData
,	PUFCC_apb_s0_PWrite
,	SCU_PAddr
,	SCU_PEnable
,	SCU_PRData
,	SCU_PReady
,	SCU_PSel
,	SCU_PSlvErr
,	SCU_PWBe
,	SCU_PWData
,	SCU_PWrite
,	SPI_ahb_s0_haddr
,	SPI_ahb_s0_hburst
,	SPI_ahb_s0_hmastlock
,	SPI_ahb_s0_hprot
,	SPI_ahb_s0_hrdata
,	SPI_ahb_s0_hready
,	SPI_ahb_s0_hresp
,	SPI_ahb_s0_hsel
,	SPI_ahb_s0_hsize
,	SPI_ahb_s0_htrans
,	SPI_ahb_s0_hwbe
,	SPI_ahb_s0_hwdata
,	SPI_ahb_s0_hwrite
,	SPI_mem_ahb_haddr
,	SPI_mem_ahb_hburst
,	SPI_mem_ahb_hmastlock
,	SPI_mem_ahb_hprot
,	SPI_mem_ahb_hrdata
,	SPI_mem_ahb_hready
,	SPI_mem_ahb_hresp
,	SPI_mem_ahb_hsel
,	SPI_mem_ahb_hsize
,	SPI_mem_ahb_htrans
,	SPI_mem_ahb_hwbe
,	SPI_mem_ahb_hwdata
,	SPI_mem_ahb_hwrite
,	UART_apb_s0_paddr
,	UART_apb_s0_penable
,	UART_apb_s0_prdata
,	UART_apb_s0_pready
,	UART_apb_s0_psel
,	UART_apb_s0_pslverr
,	UART_apb_s0_pwbe
,	UART_apb_s0_pwdata
,	UART_apb_s0_pwrite
,	UART_apb_s1_paddr
,	UART_apb_s1_penable
,	UART_apb_s1_prdata
,	UART_apb_s1_pready
,	UART_apb_s1_psel
,	UART_apb_s1_pslverr
,	UART_apb_s1_pwbe
,	UART_apb_s1_pwdata
,	UART_apb_s1_pwrite
,	USB_axi_s0_ar_addr
,	USB_axi_s0_ar_prot
,	USB_axi_s0_ar_ready
,	USB_axi_s0_ar_valid
,	USB_axi_s0_aw_addr
,	USB_axi_s0_aw_prot
,	USB_axi_s0_aw_ready
,	USB_axi_s0_aw_valid
,	USB_axi_s0_b_ready
,	USB_axi_s0_b_resp
,	USB_axi_s0_b_valid
,	USB_axi_s0_r_data
,	USB_axi_s0_r_ready
,	USB_axi_s0_r_resp
,	USB_axi_s0_r_valid
,	USB_axi_s0_w_data
,	USB_axi_s0_w_ready
,	USB_axi_s0_w_strb
,	USB_axi_s0_w_valid
,	acpu_axi_m0_ar_addr
,	acpu_axi_m0_ar_burst
,	acpu_axi_m0_ar_cache
,	acpu_axi_m0_ar_id
,	acpu_axi_m0_ar_len
,	acpu_axi_m0_ar_lock
,	acpu_axi_m0_ar_prot
,	acpu_axi_m0_ar_ready
,	acpu_axi_m0_ar_size
,	acpu_axi_m0_ar_valid
,	acpu_axi_m0_aw_addr
,	acpu_axi_m0_aw_burst
,	acpu_axi_m0_aw_cache
,	acpu_axi_m0_aw_id
,	acpu_axi_m0_aw_len
,	acpu_axi_m0_aw_lock
,	acpu_axi_m0_aw_prot
,	acpu_axi_m0_aw_ready
,	acpu_axi_m0_aw_size
,	acpu_axi_m0_aw_valid
,	acpu_axi_m0_b_id
,	acpu_axi_m0_b_ready
,	acpu_axi_m0_b_resp
,	acpu_axi_m0_b_valid
,	acpu_axi_m0_r_data
,	acpu_axi_m0_r_id
,	acpu_axi_m0_r_last
,	acpu_axi_m0_r_ready
,	acpu_axi_m0_r_resp
,	acpu_axi_m0_r_valid
,	acpu_axi_m0_w_data
,	acpu_axi_m0_w_last
,	acpu_axi_m0_w_ready
,	acpu_axi_m0_w_strb
,	acpu_axi_m0_w_valid
,	arm_axi_m0_ar_addr
,	arm_axi_m0_ar_burst
,	arm_axi_m0_ar_cache
,	arm_axi_m0_ar_id
,	arm_axi_m0_ar_len
,	arm_axi_m0_ar_lock
,	arm_axi_m0_ar_prot
,	arm_axi_m0_ar_ready
,	arm_axi_m0_ar_size
,	arm_axi_m0_ar_valid
,	arm_axi_m0_aw_addr
,	arm_axi_m0_aw_burst
,	arm_axi_m0_aw_cache
,	arm_axi_m0_aw_id
,	arm_axi_m0_aw_len
,	arm_axi_m0_aw_lock
,	arm_axi_m0_aw_prot
,	arm_axi_m0_aw_ready
,	arm_axi_m0_aw_size
,	arm_axi_m0_aw_valid
,	arm_axi_m0_b_id
,	arm_axi_m0_b_ready
,	arm_axi_m0_b_resp
,	arm_axi_m0_b_valid
,	arm_axi_m0_r_data
,	arm_axi_m0_r_id
,	arm_axi_m0_r_last
,	arm_axi_m0_r_ready
,	arm_axi_m0_r_resp
,	arm_axi_m0_r_valid
,	arm_axi_m0_w_data
,	arm_axi_m0_w_last
,	arm_axi_m0_w_ready
,	arm_axi_m0_w_strb
,	arm_axi_m0_w_valid
,	bcpu_ahb_m0_haddr
,	bcpu_ahb_m0_hburst
,	bcpu_ahb_m0_hmastlock
,	bcpu_ahb_m0_hprot
,	bcpu_ahb_m0_hrdata
,	bcpu_ahb_m0_hready
,	bcpu_ahb_m0_hresp
,	bcpu_ahb_m0_hsel
,	bcpu_ahb_m0_hsize
,	bcpu_ahb_m0_htrans
,	bcpu_ahb_m0_hwbe
,	bcpu_ahb_m0_hwdata
,	bcpu_ahb_m0_hwrite
,	clk_133
,	clk_266
,	clk_533
,	cpu_observer_AFReady
,	cpu_observer_AFValid
,	cpu_observer_ATBytes
,	cpu_observer_ATData
,	cpu_observer_ATId
,	cpu_observer_ATReady
,	cpu_observer_ATValid
,	ddr_axi_s0_ar_addr
,	ddr_axi_s0_ar_burst
,	ddr_axi_s0_ar_cache
,	ddr_axi_s0_ar_id
,	ddr_axi_s0_ar_len
,	ddr_axi_s0_ar_lock
,	ddr_axi_s0_ar_prot
,	ddr_axi_s0_ar_ready
,	ddr_axi_s0_ar_size
,	ddr_axi_s0_ar_valid
,	ddr_axi_s0_aw_addr
,	ddr_axi_s0_aw_burst
,	ddr_axi_s0_aw_cache
,	ddr_axi_s0_aw_id
,	ddr_axi_s0_aw_len
,	ddr_axi_s0_aw_lock
,	ddr_axi_s0_aw_prot
,	ddr_axi_s0_aw_ready
,	ddr_axi_s0_aw_size
,	ddr_axi_s0_aw_valid
,	ddr_axi_s0_b_id
,	ddr_axi_s0_b_ready
,	ddr_axi_s0_b_resp
,	ddr_axi_s0_b_valid
,	ddr_axi_s0_r_data
,	ddr_axi_s0_r_id
,	ddr_axi_s0_r_last
,	ddr_axi_s0_r_ready
,	ddr_axi_s0_r_resp
,	ddr_axi_s0_r_valid
,	ddr_axi_s0_w_data
,	ddr_axi_s0_w_last
,	ddr_axi_s0_w_ready
,	ddr_axi_s0_w_strb
,	ddr_axi_s0_w_valid
,	ddr_axi_s1_ar_addr
,	ddr_axi_s1_ar_burst
,	ddr_axi_s1_ar_cache
,	ddr_axi_s1_ar_id
,	ddr_axi_s1_ar_len
,	ddr_axi_s1_ar_lock
,	ddr_axi_s1_ar_prot
,	ddr_axi_s1_ar_ready
,	ddr_axi_s1_ar_size
,	ddr_axi_s1_ar_valid
,	ddr_axi_s1_aw_addr
,	ddr_axi_s1_aw_burst
,	ddr_axi_s1_aw_cache
,	ddr_axi_s1_aw_id
,	ddr_axi_s1_aw_len
,	ddr_axi_s1_aw_lock
,	ddr_axi_s1_aw_prot
,	ddr_axi_s1_aw_ready
,	ddr_axi_s1_aw_size
,	ddr_axi_s1_aw_valid
,	ddr_axi_s1_b_id
,	ddr_axi_s1_b_ready
,	ddr_axi_s1_b_resp
,	ddr_axi_s1_b_valid
,	ddr_axi_s1_r_data
,	ddr_axi_s1_r_id
,	ddr_axi_s1_r_last
,	ddr_axi_s1_r_ready
,	ddr_axi_s1_r_resp
,	ddr_axi_s1_r_valid
,	ddr_axi_s1_w_data
,	ddr_axi_s1_w_last
,	ddr_axi_s1_w_ready
,	ddr_axi_s1_w_strb
,	ddr_axi_s1_w_valid
,	ddr_axi_s2_ar_addr
,	ddr_axi_s2_ar_burst
,	ddr_axi_s2_ar_cache
,	ddr_axi_s2_ar_id
,	ddr_axi_s2_ar_len
,	ddr_axi_s2_ar_lock
,	ddr_axi_s2_ar_prot
,	ddr_axi_s2_ar_ready
,	ddr_axi_s2_ar_size
,	ddr_axi_s2_ar_valid
,	ddr_axi_s2_aw_addr
,	ddr_axi_s2_aw_burst
,	ddr_axi_s2_aw_cache
,	ddr_axi_s2_aw_id
,	ddr_axi_s2_aw_len
,	ddr_axi_s2_aw_lock
,	ddr_axi_s2_aw_prot
,	ddr_axi_s2_aw_ready
,	ddr_axi_s2_aw_size
,	ddr_axi_s2_aw_valid
,	ddr_axi_s2_b_id
,	ddr_axi_s2_b_ready
,	ddr_axi_s2_b_resp
,	ddr_axi_s2_b_valid
,	ddr_axi_s2_r_data
,	ddr_axi_s2_r_id
,	ddr_axi_s2_r_last
,	ddr_axi_s2_r_ready
,	ddr_axi_s2_r_resp
,	ddr_axi_s2_r_valid
,	ddr_axi_s2_w_data
,	ddr_axi_s2_w_last
,	ddr_axi_s2_w_ready
,	ddr_axi_s2_w_strb
,	ddr_axi_s2_w_valid
,	ddr_axi_s3_ar_addr
,	ddr_axi_s3_ar_burst
,	ddr_axi_s3_ar_cache
,	ddr_axi_s3_ar_id
,	ddr_axi_s3_ar_len
,	ddr_axi_s3_ar_lock
,	ddr_axi_s3_ar_prot
,	ddr_axi_s3_ar_ready
,	ddr_axi_s3_ar_size
,	ddr_axi_s3_ar_valid
,	ddr_axi_s3_aw_addr
,	ddr_axi_s3_aw_burst
,	ddr_axi_s3_aw_cache
,	ddr_axi_s3_aw_id
,	ddr_axi_s3_aw_len
,	ddr_axi_s3_aw_lock
,	ddr_axi_s3_aw_prot
,	ddr_axi_s3_aw_ready
,	ddr_axi_s3_aw_size
,	ddr_axi_s3_aw_valid
,	ddr_axi_s3_b_id
,	ddr_axi_s3_b_ready
,	ddr_axi_s3_b_resp
,	ddr_axi_s3_b_valid
,	ddr_axi_s3_r_data
,	ddr_axi_s3_r_id
,	ddr_axi_s3_r_last
,	ddr_axi_s3_r_ready
,	ddr_axi_s3_r_resp
,	ddr_axi_s3_r_valid
,	ddr_axi_s3_w_data
,	ddr_axi_s3_w_last
,	ddr_axi_s3_w_ready
,	ddr_axi_s3_w_strb
,	ddr_axi_s3_w_valid
,	ddr_axil_s0_ar_addr
,	ddr_axil_s0_ar_prot
,	ddr_axil_s0_ar_ready
,	ddr_axil_s0_ar_valid
,	ddr_axil_s0_aw_addr
,	ddr_axil_s0_aw_prot
,	ddr_axil_s0_aw_ready
,	ddr_axil_s0_aw_valid
,	ddr_axil_s0_b_ready
,	ddr_axil_s0_b_resp
,	ddr_axil_s0_b_valid
,	ddr_axil_s0_r_data
,	ddr_axil_s0_r_ready
,	ddr_axil_s0_r_resp
,	ddr_axil_s0_r_valid
,	ddr_axil_s0_w_data
,	ddr_axil_s0_w_ready
,	ddr_axil_s0_w_strb
,	ddr_axil_s0_w_valid
,	dma_axi_m0_ar_addr
,	dma_axi_m0_ar_burst
,	dma_axi_m0_ar_cache
,	dma_axi_m0_ar_id
,	dma_axi_m0_ar_len
,	dma_axi_m0_ar_lock
,	dma_axi_m0_ar_prot
,	dma_axi_m0_ar_ready
,	dma_axi_m0_ar_size
,	dma_axi_m0_ar_valid
,	dma_axi_m0_aw_addr
,	dma_axi_m0_aw_burst
,	dma_axi_m0_aw_cache
,	dma_axi_m0_aw_id
,	dma_axi_m0_aw_len
,	dma_axi_m0_aw_lock
,	dma_axi_m0_aw_prot
,	dma_axi_m0_aw_ready
,	dma_axi_m0_aw_size
,	dma_axi_m0_aw_valid
,	dma_axi_m0_b_id
,	dma_axi_m0_b_ready
,	dma_axi_m0_b_resp
,	dma_axi_m0_b_valid
,	dma_axi_m0_r_data
,	dma_axi_m0_r_id
,	dma_axi_m0_r_last
,	dma_axi_m0_r_ready
,	dma_axi_m0_r_resp
,	dma_axi_m0_r_valid
,	dma_axi_m0_w_data
,	dma_axi_m0_w_last
,	dma_axi_m0_w_ready
,	dma_axi_m0_w_strb
,	dma_axi_m0_w_valid
,	dma_axi_m1_ar_addr
,	dma_axi_m1_ar_burst
,	dma_axi_m1_ar_cache
,	dma_axi_m1_ar_id
,	dma_axi_m1_ar_len
,	dma_axi_m1_ar_lock
,	dma_axi_m1_ar_prot
,	dma_axi_m1_ar_ready
,	dma_axi_m1_ar_size
,	dma_axi_m1_ar_valid
,	dma_axi_m1_aw_addr
,	dma_axi_m1_aw_burst
,	dma_axi_m1_aw_cache
,	dma_axi_m1_aw_id
,	dma_axi_m1_aw_len
,	dma_axi_m1_aw_lock
,	dma_axi_m1_aw_prot
,	dma_axi_m1_aw_ready
,	dma_axi_m1_aw_size
,	dma_axi_m1_aw_valid
,	dma_axi_m1_b_id
,	dma_axi_m1_b_ready
,	dma_axi_m1_b_resp
,	dma_axi_m1_b_valid
,	dma_axi_m1_r_data
,	dma_axi_m1_r_id
,	dma_axi_m1_r_last
,	dma_axi_m1_r_ready
,	dma_axi_m1_r_resp
,	dma_axi_m1_r_valid
,	dma_axi_m1_w_data
,	dma_axi_m1_w_last
,	dma_axi_m1_w_ready
,	dma_axi_m1_w_strb
,	dma_axi_m1_w_valid
,	fpga_ahb_s0_haddr
,	fpga_ahb_s0_hburst
,	fpga_ahb_s0_hmastlock
,	fpga_ahb_s0_hprot
,	fpga_ahb_s0_hrdata
,	fpga_ahb_s0_hready
,	fpga_ahb_s0_hresp
,	fpga_ahb_s0_hsel
,	fpga_ahb_s0_hsize
,	fpga_ahb_s0_htrans
,	fpga_ahb_s0_hwbe
,	fpga_ahb_s0_hwdata
,	fpga_ahb_s0_hwrite
,	fpga_axi_m0_ar_addr
,	fpga_axi_m0_ar_burst
,	fpga_axi_m0_ar_cache
,	fpga_axi_m0_ar_id
,	fpga_axi_m0_ar_len
,	fpga_axi_m0_ar_lock
,	fpga_axi_m0_ar_prot
,	fpga_axi_m0_ar_ready
,	fpga_axi_m0_ar_size
,	fpga_axi_m0_ar_valid
,	fpga_axi_m0_aw_addr
,	fpga_axi_m0_aw_burst
,	fpga_axi_m0_aw_cache
,	fpga_axi_m0_aw_id
,	fpga_axi_m0_aw_len
,	fpga_axi_m0_aw_lock
,	fpga_axi_m0_aw_prot
,	fpga_axi_m0_aw_ready
,	fpga_axi_m0_aw_size
,	fpga_axi_m0_aw_valid
,	fpga_axi_m0_b_id
,	fpga_axi_m0_b_ready
,	fpga_axi_m0_b_resp
,	fpga_axi_m0_b_valid
,	fpga_axi_m0_r_data
,	fpga_axi_m0_r_id
,	fpga_axi_m0_r_last
,	fpga_axi_m0_r_ready
,	fpga_axi_m0_r_resp
,	fpga_axi_m0_r_valid
,	fpga_axi_m0_w_data
,	fpga_axi_m0_w_last
,	fpga_axi_m0_w_ready
,	fpga_axi_m0_w_strb
,	fpga_axi_m0_w_valid
,	fpga_axi_m1_ar_addr
,	fpga_axi_m1_ar_burst
,	fpga_axi_m1_ar_cache
,	fpga_axi_m1_ar_id
,	fpga_axi_m1_ar_len
,	fpga_axi_m1_ar_lock
,	fpga_axi_m1_ar_prot
,	fpga_axi_m1_ar_ready
,	fpga_axi_m1_ar_size
,	fpga_axi_m1_ar_valid
,	fpga_axi_m1_aw_addr
,	fpga_axi_m1_aw_burst
,	fpga_axi_m1_aw_cache
,	fpga_axi_m1_aw_id
,	fpga_axi_m1_aw_len
,	fpga_axi_m1_aw_lock
,	fpga_axi_m1_aw_prot
,	fpga_axi_m1_aw_ready
,	fpga_axi_m1_aw_size
,	fpga_axi_m1_aw_valid
,	fpga_axi_m1_b_id
,	fpga_axi_m1_b_ready
,	fpga_axi_m1_b_resp
,	fpga_axi_m1_b_valid
,	fpga_axi_m1_r_data
,	fpga_axi_m1_r_id
,	fpga_axi_m1_r_last
,	fpga_axi_m1_r_ready
,	fpga_axi_m1_r_resp
,	fpga_axi_m1_r_valid
,	fpga_axi_m1_w_data
,	fpga_axi_m1_w_last
,	fpga_axi_m1_w_ready
,	fpga_axi_m1_w_strb
,	fpga_axi_m1_w_valid
,	fpga_clk_m0
,	fpga_clk_m1
,	fpga_clk_s0
,	fpga_rstm0_n
,	fpga_rstm1_n
,	fpga_rsts0_n
,	gbe_apb_s0_paddr
,	gbe_apb_s0_penable
,	gbe_apb_s0_prdata
,	gbe_apb_s0_pready
,	gbe_apb_s0_psel
,	gbe_apb_s0_pslverr
,	gbe_apb_s0_pwbe
,	gbe_apb_s0_pwdata
,	gbe_apb_s0_pwrite
,	gbe_axi_m0_ar_addr
,	gbe_axi_m0_ar_burst
,	gbe_axi_m0_ar_cache
,	gbe_axi_m0_ar_id
,	gbe_axi_m0_ar_len
,	gbe_axi_m0_ar_lock
,	gbe_axi_m0_ar_prot
,	gbe_axi_m0_ar_ready
,	gbe_axi_m0_ar_size
,	gbe_axi_m0_ar_valid
,	gbe_axi_m0_aw_addr
,	gbe_axi_m0_aw_burst
,	gbe_axi_m0_aw_cache
,	gbe_axi_m0_aw_id
,	gbe_axi_m0_aw_len
,	gbe_axi_m0_aw_lock
,	gbe_axi_m0_aw_prot
,	gbe_axi_m0_aw_ready
,	gbe_axi_m0_aw_size
,	gbe_axi_m0_aw_valid
,	gbe_axi_m0_b_id
,	gbe_axi_m0_b_ready
,	gbe_axi_m0_b_resp
,	gbe_axi_m0_b_valid
,	gbe_axi_m0_r_data
,	gbe_axi_m0_r_id
,	gbe_axi_m0_r_last
,	gbe_axi_m0_r_ready
,	gbe_axi_m0_r_resp
,	gbe_axi_m0_r_valid
,	gbe_axi_m0_w_data
,	gbe_axi_m0_w_last
,	gbe_axi_m0_w_ready
,	gbe_axi_m0_w_strb
,	gbe_axi_m0_w_valid
,	pufcc_axi_m0_ar_addr
,	pufcc_axi_m0_ar_burst
,	pufcc_axi_m0_ar_cache
,	pufcc_axi_m0_ar_id
,	pufcc_axi_m0_ar_len
,	pufcc_axi_m0_ar_lock
,	pufcc_axi_m0_ar_prot
,	pufcc_axi_m0_ar_ready
,	pufcc_axi_m0_ar_size
,	pufcc_axi_m0_ar_valid
,	pufcc_axi_m0_aw_addr
,	pufcc_axi_m0_aw_burst
,	pufcc_axi_m0_aw_cache
,	pufcc_axi_m0_aw_id
,	pufcc_axi_m0_aw_len
,	pufcc_axi_m0_aw_lock
,	pufcc_axi_m0_aw_prot
,	pufcc_axi_m0_aw_ready
,	pufcc_axi_m0_aw_size
,	pufcc_axi_m0_aw_valid
,	pufcc_axi_m0_b_id
,	pufcc_axi_m0_b_ready
,	pufcc_axi_m0_b_resp
,	pufcc_axi_m0_b_valid
,	pufcc_axi_m0_r_data
,	pufcc_axi_m0_r_id
,	pufcc_axi_m0_r_last
,	pufcc_axi_m0_r_ready
,	pufcc_axi_m0_r_resp
,	pufcc_axi_m0_r_valid
,	pufcc_axi_m0_w_data
,	pufcc_axi_m0_w_last
,	pufcc_axi_m0_w_ready
,	pufcc_axi_m0_w_strb
,	pufcc_axi_m0_w_valid
,	rst_133_n
,	rst_266_n
,	rst_533_n
,	sram_axi_s0_ar_addr
,	sram_axi_s0_ar_burst
,	sram_axi_s0_ar_cache
,	sram_axi_s0_ar_id
,	sram_axi_s0_ar_len
,	sram_axi_s0_ar_lock
,	sram_axi_s0_ar_prot
,	sram_axi_s0_ar_ready
,	sram_axi_s0_ar_size
,	sram_axi_s0_ar_valid
,	sram_axi_s0_aw_addr
,	sram_axi_s0_aw_burst
,	sram_axi_s0_aw_cache
,	sram_axi_s0_aw_id
,	sram_axi_s0_aw_len
,	sram_axi_s0_aw_lock
,	sram_axi_s0_aw_prot
,	sram_axi_s0_aw_ready
,	sram_axi_s0_aw_size
,	sram_axi_s0_aw_valid
,	sram_axi_s0_b_id
,	sram_axi_s0_b_ready
,	sram_axi_s0_b_resp
,	sram_axi_s0_b_valid
,	sram_axi_s0_r_data
,	sram_axi_s0_r_id
,	sram_axi_s0_r_last
,	sram_axi_s0_r_ready
,	sram_axi_s0_r_resp
,	sram_axi_s0_r_valid
,	sram_axi_s0_w_data
,	sram_axi_s0_w_last
,	sram_axi_s0_w_ready
,	sram_axi_s0_w_strb
,	sram_axi_s0_w_valid
,	sram_axi_s1_ar_addr
,	sram_axi_s1_ar_burst
,	sram_axi_s1_ar_cache
,	sram_axi_s1_ar_id
,	sram_axi_s1_ar_len
,	sram_axi_s1_ar_lock
,	sram_axi_s1_ar_prot
,	sram_axi_s1_ar_ready
,	sram_axi_s1_ar_size
,	sram_axi_s1_ar_valid
,	sram_axi_s1_aw_addr
,	sram_axi_s1_aw_burst
,	sram_axi_s1_aw_cache
,	sram_axi_s1_aw_id
,	sram_axi_s1_aw_len
,	sram_axi_s1_aw_lock
,	sram_axi_s1_aw_prot
,	sram_axi_s1_aw_ready
,	sram_axi_s1_aw_size
,	sram_axi_s1_aw_valid
,	sram_axi_s1_b_id
,	sram_axi_s1_b_ready
,	sram_axi_s1_b_resp
,	sram_axi_s1_b_valid
,	sram_axi_s1_r_data
,	sram_axi_s1_r_id
,	sram_axi_s1_r_last
,	sram_axi_s1_r_ready
,	sram_axi_s1_r_resp
,	sram_axi_s1_r_valid
,	sram_axi_s1_w_data
,	sram_axi_s1_w_last
,	sram_axi_s1_w_ready
,	sram_axi_s1_w_strb
,	sram_axi_s1_w_valid
,	sram_axi_s2_ar_addr
,	sram_axi_s2_ar_burst
,	sram_axi_s2_ar_cache
,	sram_axi_s2_ar_id
,	sram_axi_s2_ar_len
,	sram_axi_s2_ar_lock
,	sram_axi_s2_ar_prot
,	sram_axi_s2_ar_ready
,	sram_axi_s2_ar_size
,	sram_axi_s2_ar_valid
,	sram_axi_s2_aw_addr
,	sram_axi_s2_aw_burst
,	sram_axi_s2_aw_cache
,	sram_axi_s2_aw_id
,	sram_axi_s2_aw_len
,	sram_axi_s2_aw_lock
,	sram_axi_s2_aw_prot
,	sram_axi_s2_aw_ready
,	sram_axi_s2_aw_size
,	sram_axi_s2_aw_valid
,	sram_axi_s2_b_id
,	sram_axi_s2_b_ready
,	sram_axi_s2_b_resp
,	sram_axi_s2_b_valid
,	sram_axi_s2_r_data
,	sram_axi_s2_r_id
,	sram_axi_s2_r_last
,	sram_axi_s2_r_ready
,	sram_axi_s2_r_resp
,	sram_axi_s2_r_valid
,	sram_axi_s2_w_data
,	sram_axi_s2_w_last
,	sram_axi_s2_w_ready
,	sram_axi_s2_w_strb
,	sram_axi_s2_w_valid
,	sram_axi_s3_ar_addr
,	sram_axi_s3_ar_burst
,	sram_axi_s3_ar_cache
,	sram_axi_s3_ar_id
,	sram_axi_s3_ar_len
,	sram_axi_s3_ar_lock
,	sram_axi_s3_ar_prot
,	sram_axi_s3_ar_ready
,	sram_axi_s3_ar_size
,	sram_axi_s3_ar_valid
,	sram_axi_s3_aw_addr
,	sram_axi_s3_aw_burst
,	sram_axi_s3_aw_cache
,	sram_axi_s3_aw_id
,	sram_axi_s3_aw_len
,	sram_axi_s3_aw_lock
,	sram_axi_s3_aw_prot
,	sram_axi_s3_aw_ready
,	sram_axi_s3_aw_size
,	sram_axi_s3_aw_valid
,	sram_axi_s3_b_id
,	sram_axi_s3_b_ready
,	sram_axi_s3_b_resp
,	sram_axi_s3_b_valid
,	sram_axi_s3_r_data
,	sram_axi_s3_r_id
,	sram_axi_s3_r_last
,	sram_axi_s3_r_ready
,	sram_axi_s3_r_resp
,	sram_axi_s3_r_valid
,	sram_axi_s3_w_data
,	sram_axi_s3_w_last
,	sram_axi_s3_w_ready
,	sram_axi_s3_w_strb
,	sram_axi_s3_w_valid
,	tm
,	usb_axi_m0_ar_addr
,	usb_axi_m0_ar_burst
,	usb_axi_m0_ar_cache
,	usb_axi_m0_ar_id
,	usb_axi_m0_ar_len
,	usb_axi_m0_ar_lock
,	usb_axi_m0_ar_prot
,	usb_axi_m0_ar_ready
,	usb_axi_m0_ar_size
,	usb_axi_m0_ar_valid
,	usb_axi_m0_aw_addr
,	usb_axi_m0_aw_burst
,	usb_axi_m0_aw_cache
,	usb_axi_m0_aw_id
,	usb_axi_m0_aw_len
,	usb_axi_m0_aw_lock
,	usb_axi_m0_aw_prot
,	usb_axi_m0_aw_ready
,	usb_axi_m0_aw_size
,	usb_axi_m0_aw_valid
,	usb_axi_m0_b_id
,	usb_axi_m0_b_ready
,	usb_axi_m0_b_resp
,	usb_axi_m0_b_valid
,	usb_axi_m0_r_data
,	usb_axi_m0_r_id
,	usb_axi_m0_r_last
,	usb_axi_m0_r_ready
,	usb_axi_m0_r_resp
,	usb_axi_m0_r_valid
,	usb_axi_m0_w_data
,	usb_axi_m0_w_last
,	usb_axi_m0_w_ready
,	usb_axi_m0_w_strb
,	usb_axi_m0_w_valid
);
	output [31:0]  ACPU_WDT_PAddr        ;
	output         ACPU_WDT_PEnable      ;
	input  [31:0]  ACPU_WDT_PRData       ;
	input          ACPU_WDT_PReady       ;
	output         ACPU_WDT_PSel         ;
	input          ACPU_WDT_PSlvErr      ;
	output [3:0]   ACPU_WDT_PWBe         ;
	output [31:0]  ACPU_WDT_PWData       ;
	output         ACPU_WDT_PWrite       ;
	output [31:0]  BCPU_WDT_PAddr        ;
	output         BCPU_WDT_PEnable      ;
	input  [31:0]  BCPU_WDT_PRData       ;
	input          BCPU_WDT_PReady       ;
	output         BCPU_WDT_PSel         ;
	input          BCPU_WDT_PSlvErr      ;
	output [3:0]   BCPU_WDT_PWBe         ;
	output [31:0]  BCPU_WDT_PWData       ;
	output         BCPU_WDT_PWrite       ;
	output [31:0]  DMA_apb_s0_paddr      ;
	output         DMA_apb_s0_penable    ;
	input  [31:0]  DMA_apb_s0_prdata     ;
	input          DMA_apb_s0_pready     ;
	output         DMA_apb_s0_psel       ;
	input          DMA_apb_s0_pslverr    ;
	output [3:0]   DMA_apb_s0_pwbe       ;
	output [31:0]  DMA_apb_s0_pwdata     ;
	output         DMA_apb_s0_pwrite     ;
	output [31:0]  FCB_apb_s0_paddr      ;
	output         FCB_apb_s0_penable    ;
	input  [31:0]  FCB_apb_s0_prdata     ;
	input          FCB_apb_s0_pready     ;
	output         FCB_apb_s0_psel       ;
	input          FCB_apb_s0_pslverr    ;
	output [3:0]   FCB_apb_s0_pwbe       ;
	output [31:0]  FCB_apb_s0_pwdata     ;
	output         FCB_apb_s0_pwrite     ;
	output [31:0]  GPIO_apb_s0_paddr     ;
	output         GPIO_apb_s0_penable   ;
	input  [31:0]  GPIO_apb_s0_prdata    ;
	input          GPIO_apb_s0_pready    ;
	output         GPIO_apb_s0_psel      ;
	input          GPIO_apb_s0_pslverr   ;
	output [3:0]   GPIO_apb_s0_pwbe      ;
	output [31:0]  GPIO_apb_s0_pwdata    ;
	output         GPIO_apb_s0_pwrite    ;
	output [31:0]  GPT_apb_s0_paddr      ;
	output         GPT_apb_s0_penable    ;
	input  [31:0]  GPT_apb_s0_prdata     ;
	input          GPT_apb_s0_pready     ;
	output         GPT_apb_s0_psel       ;
	input          GPT_apb_s0_pslverr    ;
	output [3:0]   GPT_apb_s0_pwbe       ;
	output [31:0]  GPT_apb_s0_pwdata     ;
	output         GPT_apb_s0_pwrite     ;
	output [31:0]  I2C_apb_s0_paddr      ;
	output         I2C_apb_s0_penable    ;
	input  [31:0]  I2C_apb_s0_prdata     ;
	input          I2C_apb_s0_pready     ;
	output         I2C_apb_s0_psel       ;
	input          I2C_apb_s0_pslverr    ;
	output [3:0]   I2C_apb_s0_pwbe       ;
	output [31:0]  I2C_apb_s0_pwdata     ;
	output         I2C_apb_s0_pwrite     ;
	output [31:0]  MBOX_apb_s0_paddr     ;
	output         MBOX_apb_s0_penable   ;
	input  [31:0]  MBOX_apb_s0_prdata    ;
	input          MBOX_apb_s0_pready    ;
	output         MBOX_apb_s0_psel      ;
	input          MBOX_apb_s0_pslverr   ;
	output [3:0]   MBOX_apb_s0_pwbe      ;
	output [31:0]  MBOX_apb_s0_pwdata    ;
	output         MBOX_apb_s0_pwrite    ;
	output [31:0]  PUFCC_apb_s0_PAddr    ;
	output         PUFCC_apb_s0_PEnable  ;
	output [2:0]   PUFCC_apb_s0_PProt    ;
	input  [31:0]  PUFCC_apb_s0_PRData   ;
	input          PUFCC_apb_s0_PReady   ;
	output         PUFCC_apb_s0_PSel     ;
	input          PUFCC_apb_s0_PSlvErr  ;
	output [3:0]   PUFCC_apb_s0_PStrb    ;
	output [31:0]  PUFCC_apb_s0_PWData   ;
	output         PUFCC_apb_s0_PWrite   ;
	output [31:0]  SCU_PAddr             ;
	output         SCU_PEnable           ;
	input  [31:0]  SCU_PRData            ;
	input          SCU_PReady            ;
	output         SCU_PSel              ;
	input          SCU_PSlvErr           ;
	output [3:0]   SCU_PWBe              ;
	output [31:0]  SCU_PWData            ;
	output         SCU_PWrite            ;
	output [31:0]  SPI_ahb_s0_haddr      ;
	output [2:0]   SPI_ahb_s0_hburst     ;
	output         SPI_ahb_s0_hmastlock  ;
	output [3:0]   SPI_ahb_s0_hprot      ;
	input  [31:0]  SPI_ahb_s0_hrdata     ;
	input          SPI_ahb_s0_hready     ;
	input          SPI_ahb_s0_hresp      ;
	output         SPI_ahb_s0_hsel       ;
	output [2:0]   SPI_ahb_s0_hsize      ;
	output [1:0]   SPI_ahb_s0_htrans     ;
	output [3:0]   SPI_ahb_s0_hwbe       ;
	output [31:0]  SPI_ahb_s0_hwdata     ;
	output         SPI_ahb_s0_hwrite     ;
	output [31:0]  SPI_mem_ahb_haddr     ;
	output [2:0]   SPI_mem_ahb_hburst    ;
	output         SPI_mem_ahb_hmastlock ;
	output [3:0]   SPI_mem_ahb_hprot     ;
	input  [31:0]  SPI_mem_ahb_hrdata    ;
	input          SPI_mem_ahb_hready    ;
	input          SPI_mem_ahb_hresp     ;
	output         SPI_mem_ahb_hsel      ;
	output [2:0]   SPI_mem_ahb_hsize     ;
	output [1:0]   SPI_mem_ahb_htrans    ;
	output [3:0]   SPI_mem_ahb_hwbe      ;
	output [31:0]  SPI_mem_ahb_hwdata    ;
	output         SPI_mem_ahb_hwrite    ;
	output [31:0]  UART_apb_s0_paddr     ;
	output         UART_apb_s0_penable   ;
	input  [31:0]  UART_apb_s0_prdata    ;
	input          UART_apb_s0_pready    ;
	output         UART_apb_s0_psel      ;
	input          UART_apb_s0_pslverr   ;
	output [3:0]   UART_apb_s0_pwbe      ;
	output [31:0]  UART_apb_s0_pwdata    ;
	output         UART_apb_s0_pwrite    ;
	output [31:0]  UART_apb_s1_paddr     ;
	output         UART_apb_s1_penable   ;
	input  [31:0]  UART_apb_s1_prdata    ;
	input          UART_apb_s1_pready    ;
	output         UART_apb_s1_psel      ;
	input          UART_apb_s1_pslverr   ;
	output [3:0]   UART_apb_s1_pwbe      ;
	output [31:0]  UART_apb_s1_pwdata    ;
	output         UART_apb_s1_pwrite    ;
	output [31:0]  USB_axi_s0_ar_addr    ;
	output [2:0]   USB_axi_s0_ar_prot    ;
	input          USB_axi_s0_ar_ready   ;
	output         USB_axi_s0_ar_valid   ;
	output [31:0]  USB_axi_s0_aw_addr    ;
	output [2:0]   USB_axi_s0_aw_prot    ;
	input          USB_axi_s0_aw_ready   ;
	output         USB_axi_s0_aw_valid   ;
	output         USB_axi_s0_b_ready    ;
	input  [1:0]   USB_axi_s0_b_resp     ;
	input          USB_axi_s0_b_valid    ;
	input  [31:0]  USB_axi_s0_r_data     ;
	output         USB_axi_s0_r_ready    ;
	input  [1:0]   USB_axi_s0_r_resp     ;
	input          USB_axi_s0_r_valid    ;
	output [31:0]  USB_axi_s0_w_data     ;
	input          USB_axi_s0_w_ready    ;
	output [3:0]   USB_axi_s0_w_strb     ;
	output         USB_axi_s0_w_valid    ;
	input  [31:0]  acpu_axi_m0_ar_addr   ;
	input  [1:0]   acpu_axi_m0_ar_burst  ;
	input  [3:0]   acpu_axi_m0_ar_cache  ;
	input  [3:0]   acpu_axi_m0_ar_id     ;
	input  [2:0]   acpu_axi_m0_ar_len    ;
	input          acpu_axi_m0_ar_lock   ;
	input  [2:0]   acpu_axi_m0_ar_prot   ;
	output         acpu_axi_m0_ar_ready  ;
	input  [2:0]   acpu_axi_m0_ar_size   ;
	input          acpu_axi_m0_ar_valid  ;
	input  [31:0]  acpu_axi_m0_aw_addr   ;
	input  [1:0]   acpu_axi_m0_aw_burst  ;
	input  [3:0]   acpu_axi_m0_aw_cache  ;
	input  [3:0]   acpu_axi_m0_aw_id     ;
	input  [2:0]   acpu_axi_m0_aw_len    ;
	input          acpu_axi_m0_aw_lock   ;
	input  [2:0]   acpu_axi_m0_aw_prot   ;
	output         acpu_axi_m0_aw_ready  ;
	input  [2:0]   acpu_axi_m0_aw_size   ;
	input          acpu_axi_m0_aw_valid  ;
	output [3:0]   acpu_axi_m0_b_id      ;
	input          acpu_axi_m0_b_ready   ;
	output [1:0]   acpu_axi_m0_b_resp    ;
	output         acpu_axi_m0_b_valid   ;
	output [63:0]  acpu_axi_m0_r_data    ;
	output [3:0]   acpu_axi_m0_r_id      ;
	output         acpu_axi_m0_r_last    ;
	input          acpu_axi_m0_r_ready   ;
	output [1:0]   acpu_axi_m0_r_resp    ;
	output         acpu_axi_m0_r_valid   ;
	input  [63:0]  acpu_axi_m0_w_data    ;
	input          acpu_axi_m0_w_last    ;
	output         acpu_axi_m0_w_ready   ;
	input  [7:0]   acpu_axi_m0_w_strb    ;
	input          acpu_axi_m0_w_valid   ;
	input  [31:0]  arm_axi_m0_ar_addr    ;
	input  [1:0]   arm_axi_m0_ar_burst   ;
	input  [3:0]   arm_axi_m0_ar_cache   ;
	input  [3:0]   arm_axi_m0_ar_id      ;
	input  [2:0]   arm_axi_m0_ar_len     ;
	input          arm_axi_m0_ar_lock    ;
	input  [2:0]   arm_axi_m0_ar_prot    ;
	output         arm_axi_m0_ar_ready   ;
	input  [2:0]   arm_axi_m0_ar_size    ;
	input          arm_axi_m0_ar_valid   ;
	input  [31:0]  arm_axi_m0_aw_addr    ;
	input  [1:0]   arm_axi_m0_aw_burst   ;
	input  [3:0]   arm_axi_m0_aw_cache   ;
	input  [3:0]   arm_axi_m0_aw_id      ;
	input  [2:0]   arm_axi_m0_aw_len     ;
	input          arm_axi_m0_aw_lock    ;
	input  [2:0]   arm_axi_m0_aw_prot    ;
	output         arm_axi_m0_aw_ready   ;
	input  [2:0]   arm_axi_m0_aw_size    ;
	input          arm_axi_m0_aw_valid   ;
	output [3:0]   arm_axi_m0_b_id       ;
	input          arm_axi_m0_b_ready    ;
	output [1:0]   arm_axi_m0_b_resp     ;
	output         arm_axi_m0_b_valid    ;
	output [63:0]  arm_axi_m0_r_data     ;
	output [3:0]   arm_axi_m0_r_id       ;
	output         arm_axi_m0_r_last     ;
	input          arm_axi_m0_r_ready    ;
	output [1:0]   arm_axi_m0_r_resp     ;
	output         arm_axi_m0_r_valid    ;
	input  [63:0]  arm_axi_m0_w_data     ;
	input          arm_axi_m0_w_last     ;
	output         arm_axi_m0_w_ready    ;
	input  [7:0]   arm_axi_m0_w_strb     ;
	input          arm_axi_m0_w_valid    ;
	input  [31:0]  bcpu_ahb_m0_haddr     ;
	input  [2:0]   bcpu_ahb_m0_hburst    ;
	input          bcpu_ahb_m0_hmastlock ;
	input  [3:0]   bcpu_ahb_m0_hprot     ;
	output [31:0]  bcpu_ahb_m0_hrdata    ;
	output         bcpu_ahb_m0_hready    ;
	output         bcpu_ahb_m0_hresp     ;
	input          bcpu_ahb_m0_hsel      ;
	input  [2:0]   bcpu_ahb_m0_hsize     ;
	input  [1:0]   bcpu_ahb_m0_htrans    ;
	input  [3:0]   bcpu_ahb_m0_hwbe      ;
	input  [31:0]  bcpu_ahb_m0_hwdata    ;
	input          bcpu_ahb_m0_hwrite    ;
	input          clk_133               ;
	input          clk_266               ;
	input          clk_533               ;
	output         cpu_observer_AFReady  ;
	input          cpu_observer_AFValid  ;
	output         cpu_observer_ATBytes  ;
	output [15:0]  cpu_observer_ATData   ;
	output [6:0]   cpu_observer_ATId     ;
	input          cpu_observer_ATReady  ;
	output         cpu_observer_ATValid  ;
	output [31:0]  ddr_axi_s0_ar_addr    ;
	output [1:0]   ddr_axi_s0_ar_burst   ;
	output [3:0]   ddr_axi_s0_ar_cache   ;
	output [3:0]   ddr_axi_s0_ar_id      ;
	output [2:0]   ddr_axi_s0_ar_len     ;
	output         ddr_axi_s0_ar_lock    ;
	output [2:0]   ddr_axi_s0_ar_prot    ;
	input          ddr_axi_s0_ar_ready   ;
	output [2:0]   ddr_axi_s0_ar_size    ;
	output         ddr_axi_s0_ar_valid   ;
	output [31:0]  ddr_axi_s0_aw_addr    ;
	output [1:0]   ddr_axi_s0_aw_burst   ;
	output [3:0]   ddr_axi_s0_aw_cache   ;
	output [3:0]   ddr_axi_s0_aw_id      ;
	output [2:0]   ddr_axi_s0_aw_len     ;
	output         ddr_axi_s0_aw_lock    ;
	output [2:0]   ddr_axi_s0_aw_prot    ;
	input          ddr_axi_s0_aw_ready   ;
	output [2:0]   ddr_axi_s0_aw_size    ;
	output         ddr_axi_s0_aw_valid   ;
	input  [3:0]   ddr_axi_s0_b_id       ;
	output         ddr_axi_s0_b_ready    ;
	input  [1:0]   ddr_axi_s0_b_resp     ;
	input          ddr_axi_s0_b_valid    ;
	input  [127:0] ddr_axi_s0_r_data     ;
	input  [3:0]   ddr_axi_s0_r_id       ;
	input          ddr_axi_s0_r_last     ;
	output         ddr_axi_s0_r_ready    ;
	input  [1:0]   ddr_axi_s0_r_resp     ;
	input          ddr_axi_s0_r_valid    ;
	output [127:0] ddr_axi_s0_w_data     ;
	output         ddr_axi_s0_w_last     ;
	input          ddr_axi_s0_w_ready    ;
	output [15:0]  ddr_axi_s0_w_strb     ;
	output         ddr_axi_s0_w_valid    ;
	output [31:0]  ddr_axi_s1_ar_addr    ;
	output [1:0]   ddr_axi_s1_ar_burst   ;
	output [3:0]   ddr_axi_s1_ar_cache   ;
	output [3:0]   ddr_axi_s1_ar_id      ;
	output [2:0]   ddr_axi_s1_ar_len     ;
	output         ddr_axi_s1_ar_lock    ;
	output [2:0]   ddr_axi_s1_ar_prot    ;
	input          ddr_axi_s1_ar_ready   ;
	output [2:0]   ddr_axi_s1_ar_size    ;
	output         ddr_axi_s1_ar_valid   ;
	output [31:0]  ddr_axi_s1_aw_addr    ;
	output [1:0]   ddr_axi_s1_aw_burst   ;
	output [3:0]   ddr_axi_s1_aw_cache   ;
	output [3:0]   ddr_axi_s1_aw_id      ;
	output [2:0]   ddr_axi_s1_aw_len     ;
	output         ddr_axi_s1_aw_lock    ;
	output [2:0]   ddr_axi_s1_aw_prot    ;
	input          ddr_axi_s1_aw_ready   ;
	output [2:0]   ddr_axi_s1_aw_size    ;
	output         ddr_axi_s1_aw_valid   ;
	input  [3:0]   ddr_axi_s1_b_id       ;
	output         ddr_axi_s1_b_ready    ;
	input  [1:0]   ddr_axi_s1_b_resp     ;
	input          ddr_axi_s1_b_valid    ;
	input  [127:0] ddr_axi_s1_r_data     ;
	input  [3:0]   ddr_axi_s1_r_id       ;
	input          ddr_axi_s1_r_last     ;
	output         ddr_axi_s1_r_ready    ;
	input  [1:0]   ddr_axi_s1_r_resp     ;
	input          ddr_axi_s1_r_valid    ;
	output [127:0] ddr_axi_s1_w_data     ;
	output         ddr_axi_s1_w_last     ;
	input          ddr_axi_s1_w_ready    ;
	output [15:0]  ddr_axi_s1_w_strb     ;
	output         ddr_axi_s1_w_valid    ;
	output [31:0]  ddr_axi_s2_ar_addr    ;
	output [1:0]   ddr_axi_s2_ar_burst   ;
	output [3:0]   ddr_axi_s2_ar_cache   ;
	output [3:0]   ddr_axi_s2_ar_id      ;
	output [2:0]   ddr_axi_s2_ar_len     ;
	output         ddr_axi_s2_ar_lock    ;
	output [2:0]   ddr_axi_s2_ar_prot    ;
	input          ddr_axi_s2_ar_ready   ;
	output [2:0]   ddr_axi_s2_ar_size    ;
	output         ddr_axi_s2_ar_valid   ;
	output [31:0]  ddr_axi_s2_aw_addr    ;
	output [1:0]   ddr_axi_s2_aw_burst   ;
	output [3:0]   ddr_axi_s2_aw_cache   ;
	output [3:0]   ddr_axi_s2_aw_id      ;
	output [2:0]   ddr_axi_s2_aw_len     ;
	output         ddr_axi_s2_aw_lock    ;
	output [2:0]   ddr_axi_s2_aw_prot    ;
	input          ddr_axi_s2_aw_ready   ;
	output [2:0]   ddr_axi_s2_aw_size    ;
	output         ddr_axi_s2_aw_valid   ;
	input  [3:0]   ddr_axi_s2_b_id       ;
	output         ddr_axi_s2_b_ready    ;
	input  [1:0]   ddr_axi_s2_b_resp     ;
	input          ddr_axi_s2_b_valid    ;
	input  [127:0] ddr_axi_s2_r_data     ;
	input  [3:0]   ddr_axi_s2_r_id       ;
	input          ddr_axi_s2_r_last     ;
	output         ddr_axi_s2_r_ready    ;
	input  [1:0]   ddr_axi_s2_r_resp     ;
	input          ddr_axi_s2_r_valid    ;
	output [127:0] ddr_axi_s2_w_data     ;
	output         ddr_axi_s2_w_last     ;
	input          ddr_axi_s2_w_ready    ;
	output [15:0]  ddr_axi_s2_w_strb     ;
	output         ddr_axi_s2_w_valid    ;
	output [31:0]  ddr_axi_s3_ar_addr    ;
	output [1:0]   ddr_axi_s3_ar_burst   ;
	output [3:0]   ddr_axi_s3_ar_cache   ;
	output [3:0]   ddr_axi_s3_ar_id      ;
	output [2:0]   ddr_axi_s3_ar_len     ;
	output         ddr_axi_s3_ar_lock    ;
	output [2:0]   ddr_axi_s3_ar_prot    ;
	input          ddr_axi_s3_ar_ready   ;
	output [2:0]   ddr_axi_s3_ar_size    ;
	output         ddr_axi_s3_ar_valid   ;
	output [31:0]  ddr_axi_s3_aw_addr    ;
	output [1:0]   ddr_axi_s3_aw_burst   ;
	output [3:0]   ddr_axi_s3_aw_cache   ;
	output [3:0]   ddr_axi_s3_aw_id      ;
	output [2:0]   ddr_axi_s3_aw_len     ;
	output         ddr_axi_s3_aw_lock    ;
	output [2:0]   ddr_axi_s3_aw_prot    ;
	input          ddr_axi_s3_aw_ready   ;
	output [2:0]   ddr_axi_s3_aw_size    ;
	output         ddr_axi_s3_aw_valid   ;
	input  [3:0]   ddr_axi_s3_b_id       ;
	output         ddr_axi_s3_b_ready    ;
	input  [1:0]   ddr_axi_s3_b_resp     ;
	input          ddr_axi_s3_b_valid    ;
	input  [127:0] ddr_axi_s3_r_data     ;
	input  [3:0]   ddr_axi_s3_r_id       ;
	input          ddr_axi_s3_r_last     ;
	output         ddr_axi_s3_r_ready    ;
	input  [1:0]   ddr_axi_s3_r_resp     ;
	input          ddr_axi_s3_r_valid    ;
	output [127:0] ddr_axi_s3_w_data     ;
	output         ddr_axi_s3_w_last     ;
	input          ddr_axi_s3_w_ready    ;
	output [15:0]  ddr_axi_s3_w_strb     ;
	output         ddr_axi_s3_w_valid    ;
	output [31:0]  ddr_axil_s0_ar_addr   ;
	output [2:0]   ddr_axil_s0_ar_prot   ;
	input          ddr_axil_s0_ar_ready  ;
	output         ddr_axil_s0_ar_valid  ;
	output [31:0]  ddr_axil_s0_aw_addr   ;
	output [2:0]   ddr_axil_s0_aw_prot   ;
	input          ddr_axil_s0_aw_ready  ;
	output         ddr_axil_s0_aw_valid  ;
	output         ddr_axil_s0_b_ready   ;
	input  [1:0]   ddr_axil_s0_b_resp    ;
	input          ddr_axil_s0_b_valid   ;
	input  [31:0]  ddr_axil_s0_r_data    ;
	output         ddr_axil_s0_r_ready   ;
	input  [1:0]   ddr_axil_s0_r_resp    ;
	input          ddr_axil_s0_r_valid   ;
	output [31:0]  ddr_axil_s0_w_data    ;
	input          ddr_axil_s0_w_ready   ;
	output [3:0]   ddr_axil_s0_w_strb    ;
	output         ddr_axil_s0_w_valid   ;
	input  [31:0]  dma_axi_m0_ar_addr    ;
	input  [1:0]   dma_axi_m0_ar_burst   ;
	input  [3:0]   dma_axi_m0_ar_cache   ;
	input  [3:0]   dma_axi_m0_ar_id      ;
	input  [3:0]   dma_axi_m0_ar_len     ;
	input          dma_axi_m0_ar_lock    ;
	input  [2:0]   dma_axi_m0_ar_prot    ;
	output         dma_axi_m0_ar_ready   ;
	input  [2:0]   dma_axi_m0_ar_size    ;
	input          dma_axi_m0_ar_valid   ;
	input  [31:0]  dma_axi_m0_aw_addr    ;
	input  [1:0]   dma_axi_m0_aw_burst   ;
	input  [3:0]   dma_axi_m0_aw_cache   ;
	input  [3:0]   dma_axi_m0_aw_id      ;
	input  [3:0]   dma_axi_m0_aw_len     ;
	input          dma_axi_m0_aw_lock    ;
	input  [2:0]   dma_axi_m0_aw_prot    ;
	output         dma_axi_m0_aw_ready   ;
	input  [2:0]   dma_axi_m0_aw_size    ;
	input          dma_axi_m0_aw_valid   ;
	output [3:0]   dma_axi_m0_b_id       ;
	input          dma_axi_m0_b_ready    ;
	output [1:0]   dma_axi_m0_b_resp     ;
	output         dma_axi_m0_b_valid    ;
	output [31:0]  dma_axi_m0_r_data     ;
	output [3:0]   dma_axi_m0_r_id       ;
	output         dma_axi_m0_r_last     ;
	input          dma_axi_m0_r_ready    ;
	output [1:0]   dma_axi_m0_r_resp     ;
	output         dma_axi_m0_r_valid    ;
	input  [31:0]  dma_axi_m0_w_data     ;
	input          dma_axi_m0_w_last     ;
	output         dma_axi_m0_w_ready    ;
	input  [3:0]   dma_axi_m0_w_strb     ;
	input          dma_axi_m0_w_valid    ;
	input  [31:0]  dma_axi_m1_ar_addr    ;
	input  [1:0]   dma_axi_m1_ar_burst   ;
	input  [3:0]   dma_axi_m1_ar_cache   ;
	input  [3:0]   dma_axi_m1_ar_id      ;
	input  [3:0]   dma_axi_m1_ar_len     ;
	input          dma_axi_m1_ar_lock    ;
	input  [2:0]   dma_axi_m1_ar_prot    ;
	output         dma_axi_m1_ar_ready   ;
	input  [2:0]   dma_axi_m1_ar_size    ;
	input          dma_axi_m1_ar_valid   ;
	input  [31:0]  dma_axi_m1_aw_addr    ;
	input  [1:0]   dma_axi_m1_aw_burst   ;
	input  [3:0]   dma_axi_m1_aw_cache   ;
	input  [3:0]   dma_axi_m1_aw_id      ;
	input  [3:0]   dma_axi_m1_aw_len     ;
	input          dma_axi_m1_aw_lock    ;
	input  [2:0]   dma_axi_m1_aw_prot    ;
	output         dma_axi_m1_aw_ready   ;
	input  [2:0]   dma_axi_m1_aw_size    ;
	input          dma_axi_m1_aw_valid   ;
	output [3:0]   dma_axi_m1_b_id       ;
	input          dma_axi_m1_b_ready    ;
	output [1:0]   dma_axi_m1_b_resp     ;
	output         dma_axi_m1_b_valid    ;
	output [31:0]  dma_axi_m1_r_data     ;
	output [3:0]   dma_axi_m1_r_id       ;
	output         dma_axi_m1_r_last     ;
	input          dma_axi_m1_r_ready    ;
	output [1:0]   dma_axi_m1_r_resp     ;
	output         dma_axi_m1_r_valid    ;
	input  [31:0]  dma_axi_m1_w_data     ;
	input          dma_axi_m1_w_last     ;
	output         dma_axi_m1_w_ready    ;
	input  [3:0]   dma_axi_m1_w_strb     ;
	input          dma_axi_m1_w_valid    ;
	output [31:0]  fpga_ahb_s0_haddr     ;
	output [2:0]   fpga_ahb_s0_hburst    ;
	output         fpga_ahb_s0_hmastlock ;
	output [3:0]   fpga_ahb_s0_hprot     ;
	input  [31:0]  fpga_ahb_s0_hrdata    ;
	input          fpga_ahb_s0_hready    ;
	input          fpga_ahb_s0_hresp     ;
	output         fpga_ahb_s0_hsel      ;
	output [2:0]   fpga_ahb_s0_hsize     ;
	output [1:0]   fpga_ahb_s0_htrans    ;
	output [3:0]   fpga_ahb_s0_hwbe      ;
	output [31:0]  fpga_ahb_s0_hwdata    ;
	output         fpga_ahb_s0_hwrite    ;
	input  [31:0]  fpga_axi_m0_ar_addr   ;
	input  [1:0]   fpga_axi_m0_ar_burst  ;
	input  [3:0]   fpga_axi_m0_ar_cache  ;
	input  [3:0]   fpga_axi_m0_ar_id     ;
	input  [2:0]   fpga_axi_m0_ar_len    ;
	input          fpga_axi_m0_ar_lock   ;
	input  [2:0]   fpga_axi_m0_ar_prot   ;
	output         fpga_axi_m0_ar_ready  ;
	input  [2:0]   fpga_axi_m0_ar_size   ;
	input          fpga_axi_m0_ar_valid  ;
	input  [31:0]  fpga_axi_m0_aw_addr   ;
	input  [1:0]   fpga_axi_m0_aw_burst  ;
	input  [3:0]   fpga_axi_m0_aw_cache  ;
	input  [3:0]   fpga_axi_m0_aw_id     ;
	input  [2:0]   fpga_axi_m0_aw_len    ;
	input          fpga_axi_m0_aw_lock   ;
	input  [2:0]   fpga_axi_m0_aw_prot   ;
	output         fpga_axi_m0_aw_ready  ;
	input  [2:0]   fpga_axi_m0_aw_size   ;
	input          fpga_axi_m0_aw_valid  ;
	output [3:0]   fpga_axi_m0_b_id      ;
	input          fpga_axi_m0_b_ready   ;
	output [1:0]   fpga_axi_m0_b_resp    ;
	output         fpga_axi_m0_b_valid   ;
	output [63:0]  fpga_axi_m0_r_data    ;
	output [3:0]   fpga_axi_m0_r_id      ;
	output         fpga_axi_m0_r_last    ;
	input          fpga_axi_m0_r_ready   ;
	output [1:0]   fpga_axi_m0_r_resp    ;
	output         fpga_axi_m0_r_valid   ;
	input  [63:0]  fpga_axi_m0_w_data    ;
	input          fpga_axi_m0_w_last    ;
	output         fpga_axi_m0_w_ready   ;
	input  [7:0]   fpga_axi_m0_w_strb    ;
	input          fpga_axi_m0_w_valid   ;
	input  [31:0]  fpga_axi_m1_ar_addr   ;
	input  [1:0]   fpga_axi_m1_ar_burst  ;
	input  [3:0]   fpga_axi_m1_ar_cache  ;
	input  [3:0]   fpga_axi_m1_ar_id     ;
	input  [3:0]   fpga_axi_m1_ar_len    ;
	input          fpga_axi_m1_ar_lock   ;
	input  [2:0]   fpga_axi_m1_ar_prot   ;
	output         fpga_axi_m1_ar_ready  ;
	input  [2:0]   fpga_axi_m1_ar_size   ;
	input          fpga_axi_m1_ar_valid  ;
	input  [31:0]  fpga_axi_m1_aw_addr   ;
	input  [1:0]   fpga_axi_m1_aw_burst  ;
	input  [3:0]   fpga_axi_m1_aw_cache  ;
	input  [3:0]   fpga_axi_m1_aw_id     ;
	input  [3:0]   fpga_axi_m1_aw_len    ;
	input          fpga_axi_m1_aw_lock   ;
	input  [2:0]   fpga_axi_m1_aw_prot   ;
	output         fpga_axi_m1_aw_ready  ;
	input  [2:0]   fpga_axi_m1_aw_size   ;
	input          fpga_axi_m1_aw_valid  ;
	output [3:0]   fpga_axi_m1_b_id      ;
	input          fpga_axi_m1_b_ready   ;
	output [1:0]   fpga_axi_m1_b_resp    ;
	output         fpga_axi_m1_b_valid   ;
	output [31:0]  fpga_axi_m1_r_data    ;
	output [3:0]   fpga_axi_m1_r_id      ;
	output         fpga_axi_m1_r_last    ;
	input          fpga_axi_m1_r_ready   ;
	output [1:0]   fpga_axi_m1_r_resp    ;
	output         fpga_axi_m1_r_valid   ;
	input  [31:0]  fpga_axi_m1_w_data    ;
	input          fpga_axi_m1_w_last    ;
	output         fpga_axi_m1_w_ready   ;
	input  [3:0]   fpga_axi_m1_w_strb    ;
	input          fpga_axi_m1_w_valid   ;
	input          fpga_clk_m0           ;
	input          fpga_clk_m1           ;
	input          fpga_clk_s0           ;
	input          fpga_rstm0_n          ;
	input          fpga_rstm1_n          ;
	input          fpga_rsts0_n          ;
	output [31:0]  gbe_apb_s0_paddr      ;
	output         gbe_apb_s0_penable    ;
	input  [31:0]  gbe_apb_s0_prdata     ;
	input          gbe_apb_s0_pready     ;
	output         gbe_apb_s0_psel       ;
	input          gbe_apb_s0_pslverr    ;
	output [3:0]   gbe_apb_s0_pwbe       ;
	output [31:0]  gbe_apb_s0_pwdata     ;
	output         gbe_apb_s0_pwrite     ;
	input  [31:0]  gbe_axi_m0_ar_addr    ;
	input  [1:0]   gbe_axi_m0_ar_burst   ;
	input  [3:0]   gbe_axi_m0_ar_cache   ;
	input  [3:0]   gbe_axi_m0_ar_id      ;
	input  [3:0]   gbe_axi_m0_ar_len     ;
	input          gbe_axi_m0_ar_lock    ;
	input  [2:0]   gbe_axi_m0_ar_prot    ;
	output         gbe_axi_m0_ar_ready   ;
	input  [2:0]   gbe_axi_m0_ar_size    ;
	input          gbe_axi_m0_ar_valid   ;
	input  [31:0]  gbe_axi_m0_aw_addr    ;
	input  [1:0]   gbe_axi_m0_aw_burst   ;
	input  [3:0]   gbe_axi_m0_aw_cache   ;
	input  [3:0]   gbe_axi_m0_aw_id      ;
	input  [3:0]   gbe_axi_m0_aw_len     ;
	input          gbe_axi_m0_aw_lock    ;
	input  [2:0]   gbe_axi_m0_aw_prot    ;
	output         gbe_axi_m0_aw_ready   ;
	input  [2:0]   gbe_axi_m0_aw_size    ;
	input          gbe_axi_m0_aw_valid   ;
	output [3:0]   gbe_axi_m0_b_id       ;
	input          gbe_axi_m0_b_ready    ;
	output [1:0]   gbe_axi_m0_b_resp     ;
	output         gbe_axi_m0_b_valid    ;
	output [31:0]  gbe_axi_m0_r_data     ;
	output [3:0]   gbe_axi_m0_r_id       ;
	output         gbe_axi_m0_r_last     ;
	input          gbe_axi_m0_r_ready    ;
	output [1:0]   gbe_axi_m0_r_resp     ;
	output         gbe_axi_m0_r_valid    ;
	input  [31:0]  gbe_axi_m0_w_data     ;
	input          gbe_axi_m0_w_last     ;
	output         gbe_axi_m0_w_ready    ;
	input  [3:0]   gbe_axi_m0_w_strb     ;
	input          gbe_axi_m0_w_valid    ;
	input  [31:0]  pufcc_axi_m0_ar_addr  ;
	input  [1:0]   pufcc_axi_m0_ar_burst ;
	input  [3:0]   pufcc_axi_m0_ar_cache ;
	input  [3:0]   pufcc_axi_m0_ar_id    ;
	input  [3:0]   pufcc_axi_m0_ar_len   ;
	input          pufcc_axi_m0_ar_lock  ;
	input  [2:0]   pufcc_axi_m0_ar_prot  ;
	output         pufcc_axi_m0_ar_ready ;
	input  [2:0]   pufcc_axi_m0_ar_size  ;
	input          pufcc_axi_m0_ar_valid ;
	input  [31:0]  pufcc_axi_m0_aw_addr  ;
	input  [1:0]   pufcc_axi_m0_aw_burst ;
	input  [3:0]   pufcc_axi_m0_aw_cache ;
	input  [3:0]   pufcc_axi_m0_aw_id    ;
	input  [3:0]   pufcc_axi_m0_aw_len   ;
	input          pufcc_axi_m0_aw_lock  ;
	input  [2:0]   pufcc_axi_m0_aw_prot  ;
	output         pufcc_axi_m0_aw_ready ;
	input  [2:0]   pufcc_axi_m0_aw_size  ;
	input          pufcc_axi_m0_aw_valid ;
	output [3:0]   pufcc_axi_m0_b_id     ;
	input          pufcc_axi_m0_b_ready  ;
	output [1:0]   pufcc_axi_m0_b_resp   ;
	output         pufcc_axi_m0_b_valid  ;
	output [31:0]  pufcc_axi_m0_r_data   ;
	output [3:0]   pufcc_axi_m0_r_id     ;
	output         pufcc_axi_m0_r_last   ;
	input          pufcc_axi_m0_r_ready  ;
	output [1:0]   pufcc_axi_m0_r_resp   ;
	output         pufcc_axi_m0_r_valid  ;
	input  [31:0]  pufcc_axi_m0_w_data   ;
	input          pufcc_axi_m0_w_last   ;
	output         pufcc_axi_m0_w_ready  ;
	input  [3:0]   pufcc_axi_m0_w_strb   ;
	input          pufcc_axi_m0_w_valid  ;
	input          rst_133_n             ;
	input          rst_266_n             ;
	input          rst_533_n             ;
	output [31:0]  sram_axi_s0_ar_addr   ;
	output [1:0]   sram_axi_s0_ar_burst  ;
	output [3:0]   sram_axi_s0_ar_cache  ;
	output [3:0]   sram_axi_s0_ar_id     ;
	output [3:0]   sram_axi_s0_ar_len    ;
	output         sram_axi_s0_ar_lock   ;
	output [2:0]   sram_axi_s0_ar_prot   ;
	input          sram_axi_s0_ar_ready  ;
	output [2:0]   sram_axi_s0_ar_size   ;
	output         sram_axi_s0_ar_valid  ;
	output [31:0]  sram_axi_s0_aw_addr   ;
	output [1:0]   sram_axi_s0_aw_burst  ;
	output [3:0]   sram_axi_s0_aw_cache  ;
	output [3:0]   sram_axi_s0_aw_id     ;
	output [3:0]   sram_axi_s0_aw_len    ;
	output         sram_axi_s0_aw_lock   ;
	output [2:0]   sram_axi_s0_aw_prot   ;
	input          sram_axi_s0_aw_ready  ;
	output [2:0]   sram_axi_s0_aw_size   ;
	output         sram_axi_s0_aw_valid  ;
	input  [3:0]   sram_axi_s0_b_id      ;
	output         sram_axi_s0_b_ready   ;
	input  [1:0]   sram_axi_s0_b_resp    ;
	input          sram_axi_s0_b_valid   ;
	input  [31:0]  sram_axi_s0_r_data    ;
	input  [3:0]   sram_axi_s0_r_id      ;
	input          sram_axi_s0_r_last    ;
	output         sram_axi_s0_r_ready   ;
	input  [1:0]   sram_axi_s0_r_resp    ;
	input          sram_axi_s0_r_valid   ;
	output [31:0]  sram_axi_s0_w_data    ;
	output         sram_axi_s0_w_last    ;
	input          sram_axi_s0_w_ready   ;
	output [3:0]   sram_axi_s0_w_strb    ;
	output         sram_axi_s0_w_valid   ;
	output [31:0]  sram_axi_s1_ar_addr   ;
	output [1:0]   sram_axi_s1_ar_burst  ;
	output [3:0]   sram_axi_s1_ar_cache  ;
	output [3:0]   sram_axi_s1_ar_id     ;
	output [3:0]   sram_axi_s1_ar_len    ;
	output         sram_axi_s1_ar_lock   ;
	output [2:0]   sram_axi_s1_ar_prot   ;
	input          sram_axi_s1_ar_ready  ;
	output [2:0]   sram_axi_s1_ar_size   ;
	output         sram_axi_s1_ar_valid  ;
	output [31:0]  sram_axi_s1_aw_addr   ;
	output [1:0]   sram_axi_s1_aw_burst  ;
	output [3:0]   sram_axi_s1_aw_cache  ;
	output [3:0]   sram_axi_s1_aw_id     ;
	output [3:0]   sram_axi_s1_aw_len    ;
	output         sram_axi_s1_aw_lock   ;
	output [2:0]   sram_axi_s1_aw_prot   ;
	input          sram_axi_s1_aw_ready  ;
	output [2:0]   sram_axi_s1_aw_size   ;
	output         sram_axi_s1_aw_valid  ;
	input  [3:0]   sram_axi_s1_b_id      ;
	output         sram_axi_s1_b_ready   ;
	input  [1:0]   sram_axi_s1_b_resp    ;
	input          sram_axi_s1_b_valid   ;
	input  [31:0]  sram_axi_s1_r_data    ;
	input  [3:0]   sram_axi_s1_r_id      ;
	input          sram_axi_s1_r_last    ;
	output         sram_axi_s1_r_ready   ;
	input  [1:0]   sram_axi_s1_r_resp    ;
	input          sram_axi_s1_r_valid   ;
	output [31:0]  sram_axi_s1_w_data    ;
	output         sram_axi_s1_w_last    ;
	input          sram_axi_s1_w_ready   ;
	output [3:0]   sram_axi_s1_w_strb    ;
	output         sram_axi_s1_w_valid   ;
	output [31:0]  sram_axi_s2_ar_addr   ;
	output [1:0]   sram_axi_s2_ar_burst  ;
	output [3:0]   sram_axi_s2_ar_cache  ;
	output [3:0]   sram_axi_s2_ar_id     ;
	output [3:0]   sram_axi_s2_ar_len    ;
	output         sram_axi_s2_ar_lock   ;
	output [2:0]   sram_axi_s2_ar_prot   ;
	input          sram_axi_s2_ar_ready  ;
	output [2:0]   sram_axi_s2_ar_size   ;
	output         sram_axi_s2_ar_valid  ;
	output [31:0]  sram_axi_s2_aw_addr   ;
	output [1:0]   sram_axi_s2_aw_burst  ;
	output [3:0]   sram_axi_s2_aw_cache  ;
	output [3:0]   sram_axi_s2_aw_id     ;
	output [3:0]   sram_axi_s2_aw_len    ;
	output         sram_axi_s2_aw_lock   ;
	output [2:0]   sram_axi_s2_aw_prot   ;
	input          sram_axi_s2_aw_ready  ;
	output [2:0]   sram_axi_s2_aw_size   ;
	output         sram_axi_s2_aw_valid  ;
	input  [3:0]   sram_axi_s2_b_id      ;
	output         sram_axi_s2_b_ready   ;
	input  [1:0]   sram_axi_s2_b_resp    ;
	input          sram_axi_s2_b_valid   ;
	input  [31:0]  sram_axi_s2_r_data    ;
	input  [3:0]   sram_axi_s2_r_id      ;
	input          sram_axi_s2_r_last    ;
	output         sram_axi_s2_r_ready   ;
	input  [1:0]   sram_axi_s2_r_resp    ;
	input          sram_axi_s2_r_valid   ;
	output [31:0]  sram_axi_s2_w_data    ;
	output         sram_axi_s2_w_last    ;
	input          sram_axi_s2_w_ready   ;
	output [3:0]   sram_axi_s2_w_strb    ;
	output         sram_axi_s2_w_valid   ;
	output [31:0]  sram_axi_s3_ar_addr   ;
	output [1:0]   sram_axi_s3_ar_burst  ;
	output [3:0]   sram_axi_s3_ar_cache  ;
	output [3:0]   sram_axi_s3_ar_id     ;
	output [3:0]   sram_axi_s3_ar_len    ;
	output         sram_axi_s3_ar_lock   ;
	output [2:0]   sram_axi_s3_ar_prot   ;
	input          sram_axi_s3_ar_ready  ;
	output [2:0]   sram_axi_s3_ar_size   ;
	output         sram_axi_s3_ar_valid  ;
	output [31:0]  sram_axi_s3_aw_addr   ;
	output [1:0]   sram_axi_s3_aw_burst  ;
	output [3:0]   sram_axi_s3_aw_cache  ;
	output [3:0]   sram_axi_s3_aw_id     ;
	output [3:0]   sram_axi_s3_aw_len    ;
	output         sram_axi_s3_aw_lock   ;
	output [2:0]   sram_axi_s3_aw_prot   ;
	input          sram_axi_s3_aw_ready  ;
	output [2:0]   sram_axi_s3_aw_size   ;
	output         sram_axi_s3_aw_valid  ;
	input  [3:0]   sram_axi_s3_b_id      ;
	output         sram_axi_s3_b_ready   ;
	input  [1:0]   sram_axi_s3_b_resp    ;
	input          sram_axi_s3_b_valid   ;
	input  [31:0]  sram_axi_s3_r_data    ;
	input  [3:0]   sram_axi_s3_r_id      ;
	input          sram_axi_s3_r_last    ;
	output         sram_axi_s3_r_ready   ;
	input  [1:0]   sram_axi_s3_r_resp    ;
	input          sram_axi_s3_r_valid   ;
	output [31:0]  sram_axi_s3_w_data    ;
	output         sram_axi_s3_w_last    ;
	input          sram_axi_s3_w_ready   ;
	output [3:0]   sram_axi_s3_w_strb    ;
	output         sram_axi_s3_w_valid   ;
	input          tm                    ;
	input  [31:0]  usb_axi_m0_ar_addr    ;
	input  [1:0]   usb_axi_m0_ar_burst   ;
	input  [3:0]   usb_axi_m0_ar_cache   ;
	input  [3:0]   usb_axi_m0_ar_id      ;
	input  [3:0]   usb_axi_m0_ar_len     ;
	input          usb_axi_m0_ar_lock    ;
	input  [2:0]   usb_axi_m0_ar_prot    ;
	output         usb_axi_m0_ar_ready   ;
	input  [2:0]   usb_axi_m0_ar_size    ;
	input          usb_axi_m0_ar_valid   ;
	input  [31:0]  usb_axi_m0_aw_addr    ;
	input  [1:0]   usb_axi_m0_aw_burst   ;
	input  [3:0]   usb_axi_m0_aw_cache   ;
	input  [3:0]   usb_axi_m0_aw_id      ;
	input  [3:0]   usb_axi_m0_aw_len     ;
	input          usb_axi_m0_aw_lock    ;
	input  [2:0]   usb_axi_m0_aw_prot    ;
	output         usb_axi_m0_aw_ready   ;
	input  [2:0]   usb_axi_m0_aw_size    ;
	input          usb_axi_m0_aw_valid   ;
	output [3:0]   usb_axi_m0_b_id       ;
	input          usb_axi_m0_b_ready    ;
	output [1:0]   usb_axi_m0_b_resp     ;
	output         usb_axi_m0_b_valid    ;
	output [31:0]  usb_axi_m0_r_data     ;
	output [3:0]   usb_axi_m0_r_id       ;
	output         usb_axi_m0_r_last     ;
	input          usb_axi_m0_r_ready    ;
	output [1:0]   usb_axi_m0_r_resp     ;
	output         usb_axi_m0_r_valid    ;
	input  [31:0]  usb_axi_m0_w_data     ;
	input          usb_axi_m0_w_last     ;
	output         usb_axi_m0_w_ready    ;
	input  [3:0]   usb_axi_m0_w_strb     ;
	input          usb_axi_m0_w_valid    ;
	wire         u_10ae                                                  ;
	wire         u_11c5                                                  ;
	wire         u_127c                                                  ;
	wire         u_147b                                                  ;
	wire         u_14b1                                                  ;
	wire         u_1663                                                  ;
	wire         u_16c8                                                  ;
	wire         u_16da                                                  ;
	wire         u_1a72                                                  ;
	wire         u_1ab5                                                  ;
	wire         u_1b7b                                                  ;
	wire         u_1be8                                                  ;
	wire         u_1d74                                                  ;
	wire         u_1dd0                                                  ;
	wire         u_1e07                                                  ;
	wire         u_1eca                                                  ;
	wire         u_2052                                                  ;
	wire         u_2115                                                  ;
	wire         u_21c                                                   ;
	wire         u_2336                                                  ;
	wire         u_24b5                                                  ;
	wire         u_2506                                                  ;
	wire         u_2559                                                  ;
	wire         u_264a                                                  ;
	wire         u_2675                                                  ;
	wire         u_26f1                                                  ;
	wire         u_2835                                                  ;
	wire         u_2898                                                  ;
	wire         u_2c90                                                  ;
	wire         u_2ec1                                                  ;
	wire         u_32d2                                                  ;
	wire         u_363c                                                  ;
	wire         u_36bf                                                  ;
	wire         u_3707                                                  ;
	wire         u_3720                                                  ;
	wire         u_3767                                                  ;
	wire         u_3838                                                  ;
	wire         u_38b6                                                  ;
	wire         u_3a18                                                  ;
	wire         u_3ced                                                  ;
	wire         u_3d3                                                   ;
	wire         u_3fd3                                                  ;
assign /*	output [31:0]  */ ACPU_WDT_PAddr        ='d0;
assign /*	output         */ ACPU_WDT_PEnable      ='d0;
assign /*	output         */ ACPU_WDT_PSel         ='d0;
assign /*	output [3:0]   */ ACPU_WDT_PWBe         ='d0;
assign /*	output [31:0]  */ ACPU_WDT_PWData       ='d0;
assign /*	output         */ ACPU_WDT_PWrite       ='d0;
assign /*	output [31:0]  */ BCPU_WDT_PAddr        ='d0;
assign /*	output         */ BCPU_WDT_PEnable      ='d0;
assign /*	output         */ BCPU_WDT_PSel         ='d0;
assign /*	output [3:0]   */ BCPU_WDT_PWBe         ='d0;
assign /*	output [31:0]  */ BCPU_WDT_PWData       ='d0;
assign /*	output         */ BCPU_WDT_PWrite       ='d0;
assign /*	output [31:0]  */ DMA_apb_s0_paddr      ='d0;
assign /*	output         */ DMA_apb_s0_penable    ='d0;
assign /*	output         */ DMA_apb_s0_psel       ='d0;
assign /*	output [3:0]   */ DMA_apb_s0_pwbe       ='d0;
assign /*	output [31:0]  */ DMA_apb_s0_pwdata     ='d0;
assign /*	output         */ DMA_apb_s0_pwrite     ='d0;
assign /*	output [31:0]  */ FCB_apb_s0_paddr      ='d0;
assign /*	output         */ FCB_apb_s0_penable    ='d0;
assign /*	output         */ FCB_apb_s0_psel       ='d0;
assign /*	output [3:0]   */ FCB_apb_s0_pwbe       ='d0;
assign /*	output [31:0]  */ FCB_apb_s0_pwdata     ='d0;
assign /*	output         */ FCB_apb_s0_pwrite     ='d0;
assign /*	output [31:0]  */ GPIO_apb_s0_paddr     ='d0;
assign /*	output         */ GPIO_apb_s0_penable   ='d0;
assign /*	output         */ GPIO_apb_s0_psel      ='d0;
assign /*	output [3:0]   */ GPIO_apb_s0_pwbe      ='d0;
assign /*	output [31:0]  */ GPIO_apb_s0_pwdata    ='d0;
assign /*	output         */ GPIO_apb_s0_pwrite    ='d0;
assign /*	output [31:0]  */ GPT_apb_s0_paddr      ='d0;
assign /*	output         */ GPT_apb_s0_penable    ='d0;
assign /*	output         */ GPT_apb_s0_psel       ='d0;
assign /*	output [3:0]   */ GPT_apb_s0_pwbe       ='d0;
assign /*	output [31:0]  */ GPT_apb_s0_pwdata     ='d0;
assign /*	output         */ GPT_apb_s0_pwrite     ='d0;
assign /*	output [31:0]  */ I2C_apb_s0_paddr      ='d0;
assign /*	output         */ I2C_apb_s0_penable    ='d0;
assign /*	output         */ I2C_apb_s0_psel       ='d0;
assign /*	output [3:0]   */ I2C_apb_s0_pwbe       ='d0;
assign /*	output [31:0]  */ I2C_apb_s0_pwdata     ='d0;
assign /*	output         */ I2C_apb_s0_pwrite     ='d0;
assign /*	output [31:0]  */ MBOX_apb_s0_paddr     ='d0;
assign /*	output         */ MBOX_apb_s0_penable   ='d0;
assign /*	output         */ MBOX_apb_s0_psel      ='d0;
assign /*	output [3:0]   */ MBOX_apb_s0_pwbe      ='d0;
assign /*	output [31:0]  */ MBOX_apb_s0_pwdata    ='d0;
assign /*	output         */ MBOX_apb_s0_pwrite    ='d0;
assign /*	output [31:0]  */ PUFCC_apb_s0_PAddr    ='d0;
assign /*	output         */ PUFCC_apb_s0_PEnable  ='d0;
assign /*	output [2:0]   */ PUFCC_apb_s0_PProt    ='d0;
assign /*	output         */ PUFCC_apb_s0_PSel     ='d0;
assign /*	output [3:0]   */ PUFCC_apb_s0_PStrb    ='d0;
assign /*	output [31:0]  */ PUFCC_apb_s0_PWData   ='d0;
assign /*	output         */ PUFCC_apb_s0_PWrite   ='d0;
assign /*	output [31:0]  */ SCU_PAddr             ='d0;
assign /*	output         */ SCU_PEnable           ='d0;
assign /*	output         */ SCU_PSel              ='d0;
assign /*	output [3:0]   */ SCU_PWBe              ='d0;
assign /*	output [31:0]  */ SCU_PWData            ='d0;
assign /*	output         */ SCU_PWrite            ='d0;
assign /*	output [31:0]  */ SPI_ahb_s0_haddr      ='d0;
assign /*	output [2:0]   */ SPI_ahb_s0_hburst     ='d0;
assign /*	output         */ SPI_ahb_s0_hmastlock  ='d0;
assign /*	output [3:0]   */ SPI_ahb_s0_hprot      ='d0;
assign /*	output         */ SPI_ahb_s0_hsel       ='d0;
assign /*	output [2:0]   */ SPI_ahb_s0_hsize      ='d0;
assign /*	output [1:0]   */ SPI_ahb_s0_htrans     ='d0;
assign /*	output [3:0]   */ SPI_ahb_s0_hwbe       ='d0;
assign /*	output [31:0]  */ SPI_ahb_s0_hwdata     ='d0;
assign /*	output         */ SPI_ahb_s0_hwrite     ='d0;
assign /*	output [31:0]  */ SPI_mem_ahb_haddr     ='d0;
assign /*	output [2:0]   */ SPI_mem_ahb_hburst    ='d0;
assign /*	output         */ SPI_mem_ahb_hmastlock ='d0;
assign /*	output [3:0]   */ SPI_mem_ahb_hprot     ='d0;
assign /*	output         */ SPI_mem_ahb_hsel      ='d0;
assign /*	output [2:0]   */ SPI_mem_ahb_hsize     ='d0;
assign /*	output [1:0]   */ SPI_mem_ahb_htrans    ='d0;
assign /*	output [3:0]   */ SPI_mem_ahb_hwbe      ='d0;
assign /*	output [31:0]  */ SPI_mem_ahb_hwdata    ='d0;
assign /*	output         */ SPI_mem_ahb_hwrite    ='d0;
assign /*	output [31:0]  */ UART_apb_s0_paddr     ='d0;
assign /*	output         */ UART_apb_s0_penable   ='d0;
assign /*	output         */ UART_apb_s0_psel      ='d0;
assign /*	output [3:0]   */ UART_apb_s0_pwbe      ='d0;
assign /*	output [31:0]  */ UART_apb_s0_pwdata    ='d0;
assign /*	output         */ UART_apb_s0_pwrite    ='d0;
assign /*	output [31:0]  */ UART_apb_s1_paddr     ='d0;
assign /*	output         */ UART_apb_s1_penable   ='d0;
assign /*	output         */ UART_apb_s1_psel      ='d0;
assign /*	output [3:0]   */ UART_apb_s1_pwbe      ='d0;
assign /*	output [31:0]  */ UART_apb_s1_pwdata    ='d0;
assign /*	output         */ UART_apb_s1_pwrite    ='d0;
assign /*	output [31:0]  */ USB_axi_s0_ar_addr    ='d0;
assign /*	output [2:0]   */ USB_axi_s0_ar_prot    ='d0;
assign /*	output         */ USB_axi_s0_ar_valid   ='d0;
assign /*	output [31:0]  */ USB_axi_s0_aw_addr    ='d0;
assign /*	output [2:0]   */ USB_axi_s0_aw_prot    ='d0;
assign /*	output         */ USB_axi_s0_aw_valid   ='d0;
assign /*	output         */ USB_axi_s0_b_ready    ='d0;
assign /*	output         */ USB_axi_s0_r_ready    ='d0;
assign /*	output [31:0]  */ USB_axi_s0_w_data     ='d0;
assign /*	output [3:0]   */ USB_axi_s0_w_strb     ='d0;
assign /*	output         */ USB_axi_s0_w_valid    ='d0;
assign /*	output         */ acpu_axi_m0_ar_ready  ='d0;
assign /*	output         */ acpu_axi_m0_aw_ready  ='d0;
assign /*	output [3:0]   */ acpu_axi_m0_b_id      ='d0;
assign /*	output [1:0]   */ acpu_axi_m0_b_resp    ='d0;
assign /*	output         */ acpu_axi_m0_b_valid   ='d0;
assign /*	output [63:0]  */ acpu_axi_m0_r_data    ='d0;
assign /*	output [3:0]   */ acpu_axi_m0_r_id      ='d0;
assign /*	output         */ acpu_axi_m0_r_last    ='d0;
assign /*	output [1:0]   */ acpu_axi_m0_r_resp    ='d0;
assign /*	output         */ acpu_axi_m0_r_valid   ='d0;
assign /*	output         */ acpu_axi_m0_w_ready   ='d0;
assign /*	output         */ arm_axi_m0_ar_ready   ='d0;
assign /*	output         */ arm_axi_m0_aw_ready   ='d0;
assign /*	output [3:0]   */ arm_axi_m0_b_id       ='d0;
assign /*	output [1:0]   */ arm_axi_m0_b_resp     ='d0;
assign /*	output         */ arm_axi_m0_b_valid    ='d0;
assign /*	output [63:0]  */ arm_axi_m0_r_data     ='d0;
assign /*	output [3:0]   */ arm_axi_m0_r_id       ='d0;
assign /*	output         */ arm_axi_m0_r_last     ='d0;
assign /*	output [1:0]   */ arm_axi_m0_r_resp     ='d0;
assign /*	output         */ arm_axi_m0_r_valid    ='d0;
assign /*	output         */ arm_axi_m0_w_ready    ='d0;
assign /*	output [31:0]  */ bcpu_ahb_m0_hrdata    ='d0;
assign /*	output         */ bcpu_ahb_m0_hready    ='d0;
assign /*	output         */ bcpu_ahb_m0_hresp     ='d0;
assign /*	output         */ cpu_observer_AFReady  ='d0;
assign /*	output         */ cpu_observer_ATBytes  ='d0;
assign /*	output [15:0]  */ cpu_observer_ATData   ='d0;
assign /*	output [6:0]   */ cpu_observer_ATId     ='d0;
assign /*	output         */ cpu_observer_ATValid  ='d0;
assign /*	output [31:0]  */ ddr_axi_s0_ar_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s0_ar_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s0_ar_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s0_ar_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_ar_len     ='d0;
assign /*	output         */ ddr_axi_s0_ar_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_ar_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_ar_size    ='d0;
assign /*	output         */ ddr_axi_s0_ar_valid   ='d0;
assign /*	output [31:0]  */ ddr_axi_s0_aw_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s0_aw_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s0_aw_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s0_aw_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_aw_len     ='d0;
assign /*	output         */ ddr_axi_s0_aw_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_aw_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s0_aw_size    ='d0;
assign /*	output         */ ddr_axi_s0_aw_valid   ='d0;
assign /*	output         */ ddr_axi_s0_b_ready    ='d0;
assign /*	output         */ ddr_axi_s0_r_ready    ='d0;
assign /*	output [127:0] */ ddr_axi_s0_w_data     ='d0;
assign /*	output         */ ddr_axi_s0_w_last     ='d0;
assign /*	output [15:0]  */ ddr_axi_s0_w_strb     ='d0;
assign /*	output         */ ddr_axi_s0_w_valid    ='d0;
assign /*	output [31:0]  */ ddr_axi_s1_ar_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s1_ar_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s1_ar_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s1_ar_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_ar_len     ='d0;
assign /*	output         */ ddr_axi_s1_ar_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_ar_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_ar_size    ='d0;
assign /*	output         */ ddr_axi_s1_ar_valid   ='d0;
assign /*	output [31:0]  */ ddr_axi_s1_aw_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s1_aw_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s1_aw_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s1_aw_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_aw_len     ='d0;
assign /*	output         */ ddr_axi_s1_aw_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_aw_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s1_aw_size    ='d0;
assign /*	output         */ ddr_axi_s1_aw_valid   ='d0;
assign /*	output         */ ddr_axi_s1_b_ready    ='d0;
assign /*	output         */ ddr_axi_s1_r_ready    ='d0;
assign /*	output [127:0] */ ddr_axi_s1_w_data     ='d0;
assign /*	output         */ ddr_axi_s1_w_last     ='d0;
assign /*	output [15:0]  */ ddr_axi_s1_w_strb     ='d0;
assign /*	output         */ ddr_axi_s1_w_valid    ='d0;
assign /*	output [31:0]  */ ddr_axi_s2_ar_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s2_ar_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s2_ar_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s2_ar_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_ar_len     ='d0;
assign /*	output         */ ddr_axi_s2_ar_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_ar_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_ar_size    ='d0;
assign /*	output         */ ddr_axi_s2_ar_valid   ='d0;
assign /*	output [31:0]  */ ddr_axi_s2_aw_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s2_aw_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s2_aw_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s2_aw_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_aw_len     ='d0;
assign /*	output         */ ddr_axi_s2_aw_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_aw_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s2_aw_size    ='d0;
assign /*	output         */ ddr_axi_s2_aw_valid   ='d0;
assign /*	output         */ ddr_axi_s2_b_ready    ='d0;
assign /*	output         */ ddr_axi_s2_r_ready    ='d0;
assign /*	output [127:0] */ ddr_axi_s2_w_data     ='d0;
assign /*	output         */ ddr_axi_s2_w_last     ='d0;
assign /*	output [15:0]  */ ddr_axi_s2_w_strb     ='d0;
assign /*	output         */ ddr_axi_s2_w_valid    ='d0;
assign /*	output [31:0]  */ ddr_axi_s3_ar_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s3_ar_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s3_ar_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s3_ar_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_ar_len     ='d0;
assign /*	output         */ ddr_axi_s3_ar_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_ar_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_ar_size    ='d0;
assign /*	output         */ ddr_axi_s3_ar_valid   ='d0;
assign /*	output [31:0]  */ ddr_axi_s3_aw_addr    ='d0;
assign /*	output [1:0]   */ ddr_axi_s3_aw_burst   ='d0;
assign /*	output [3:0]   */ ddr_axi_s3_aw_cache   ='d0;
assign /*	output [3:0]   */ ddr_axi_s3_aw_id      ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_aw_len     ='d0;
assign /*	output         */ ddr_axi_s3_aw_lock    ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_aw_prot    ='d0;
assign /*	output [2:0]   */ ddr_axi_s3_aw_size    ='d0;
assign /*	output         */ ddr_axi_s3_aw_valid   ='d0;
assign /*	output         */ ddr_axi_s3_b_ready    ='d0;
assign /*	output         */ ddr_axi_s3_r_ready    ='d0;
assign /*	output [127:0] */ ddr_axi_s3_w_data     ='d0;
assign /*	output         */ ddr_axi_s3_w_last     ='d0;
assign /*	output [15:0]  */ ddr_axi_s3_w_strb     ='d0;
assign /*	output         */ ddr_axi_s3_w_valid    ='d0;
assign /*	output [31:0]  */ ddr_axil_s0_ar_addr   ='d0;
assign /*	output [2:0]   */ ddr_axil_s0_ar_prot   ='d0;
assign /*	output         */ ddr_axil_s0_ar_valid  ='d0;
assign /*	output [31:0]  */ ddr_axil_s0_aw_addr   ='d0;
assign /*	output [2:0]   */ ddr_axil_s0_aw_prot   ='d0;
assign /*	output         */ ddr_axil_s0_aw_valid  ='d0;
assign /*	output         */ ddr_axil_s0_b_ready   ='d0;
assign /*	output         */ ddr_axil_s0_r_ready   ='d0;
assign /*	output [31:0]  */ ddr_axil_s0_w_data    ='d0;
assign /*	output [3:0]   */ ddr_axil_s0_w_strb    ='d0;
assign /*	output         */ ddr_axil_s0_w_valid   ='d0;
assign /*	output         */ dma_axi_m0_ar_ready   ='d0;
assign /*	output         */ dma_axi_m0_aw_ready   ='d0;
assign /*	output [3:0]   */ dma_axi_m0_b_id       ='d0;
assign /*	output [1:0]   */ dma_axi_m0_b_resp     ='d0;
assign /*	output         */ dma_axi_m0_b_valid    ='d0;
assign /*	output [31:0]  */ dma_axi_m0_r_data     ='d0;
assign /*	output [3:0]   */ dma_axi_m0_r_id       ='d0;
assign /*	output         */ dma_axi_m0_r_last     ='d0;
assign /*	output [1:0]   */ dma_axi_m0_r_resp     ='d0;
assign /*	output         */ dma_axi_m0_r_valid    ='d0;
assign /*	output         */ dma_axi_m0_w_ready    ='d0;
assign /*	output         */ dma_axi_m1_ar_ready   ='d0;
assign /*	output         */ dma_axi_m1_aw_ready   ='d0;
assign /*	output [3:0]   */ dma_axi_m1_b_id       ='d0;
assign /*	output [1:0]   */ dma_axi_m1_b_resp     ='d0;
assign /*	output         */ dma_axi_m1_b_valid    ='d0;
assign /*	output [31:0]  */ dma_axi_m1_r_data     ='d0;
assign /*	output [3:0]   */ dma_axi_m1_r_id       ='d0;
assign /*	output         */ dma_axi_m1_r_last     ='d0;
assign /*	output [1:0]   */ dma_axi_m1_r_resp     ='d0;
assign /*	output         */ dma_axi_m1_r_valid    ='d0;
assign /*	output         */ dma_axi_m1_w_ready    ='d0;
assign /*	output [31:0]  */ fpga_ahb_s0_haddr     ='d0;
assign /*	output [2:0]   */ fpga_ahb_s0_hburst    ='d0;
assign /*	output         */ fpga_ahb_s0_hmastlock ='d0;
assign /*	output [3:0]   */ fpga_ahb_s0_hprot     ='d0;
assign /*	output         */ fpga_ahb_s0_hsel      ='d0;
assign /*	output [2:0]   */ fpga_ahb_s0_hsize     ='d0;
assign /*	output [1:0]   */ fpga_ahb_s0_htrans    ='d0;
assign /*	output [3:0]   */ fpga_ahb_s0_hwbe      ='d0;
assign /*	output [31:0]  */ fpga_ahb_s0_hwdata    ='d0;
assign /*	output         */ fpga_ahb_s0_hwrite    ='d0;
assign /*	output         */ fpga_axi_m0_ar_ready  ='d0;
assign /*	output         */ fpga_axi_m0_aw_ready  ='d0;
assign /*	output [3:0]   */ fpga_axi_m0_b_id      ='d0;
assign /*	output [1:0]   */ fpga_axi_m0_b_resp    ='d0;
assign /*	output         */ fpga_axi_m0_b_valid   ='d0;
assign /*	output [63:0]  */ fpga_axi_m0_r_data    ='d0;
assign /*	output [3:0]   */ fpga_axi_m0_r_id      ='d0;
assign /*	output         */ fpga_axi_m0_r_last    ='d0;
assign /*	output [1:0]   */ fpga_axi_m0_r_resp    ='d0;
assign /*	output         */ fpga_axi_m0_r_valid   ='d0;
assign /*	output         */ fpga_axi_m0_w_ready   ='d0;
assign /*	output         */ fpga_axi_m1_ar_ready  ='d0;
assign /*	output         */ fpga_axi_m1_aw_ready  ='d0;
assign /*	output [3:0]   */ fpga_axi_m1_b_id      ='d0;
assign /*	output [1:0]   */ fpga_axi_m1_b_resp    ='d0;
assign /*	output         */ fpga_axi_m1_b_valid   ='d0;
assign /*	output [31:0]  */ fpga_axi_m1_r_data    ='d0;
assign /*	output [3:0]   */ fpga_axi_m1_r_id      ='d0;
assign /*	output         */ fpga_axi_m1_r_last    ='d0;
assign /*	output [1:0]   */ fpga_axi_m1_r_resp    ='d0;
assign /*	output         */ fpga_axi_m1_r_valid   ='d0;
assign /*	output         */ fpga_axi_m1_w_ready   ='d0;
assign /*	output [31:0]  */ gbe_apb_s0_paddr      ='d0;
assign /*	output         */ gbe_apb_s0_penable    ='d0;
assign /*	output         */ gbe_apb_s0_psel       ='d0;
assign /*	output [3:0]   */ gbe_apb_s0_pwbe       ='d0;
assign /*	output [31:0]  */ gbe_apb_s0_pwdata     ='d0;
assign /*	output         */ gbe_apb_s0_pwrite     ='d0;
assign /*	output         */ gbe_axi_m0_ar_ready   ='d0;
assign /*	output         */ gbe_axi_m0_aw_ready   ='d0;
assign /*	output [3:0]   */ gbe_axi_m0_b_id       ='d0;
assign /*	output [1:0]   */ gbe_axi_m0_b_resp     ='d0;
assign /*	output         */ gbe_axi_m0_b_valid    ='d0;
assign /*	output [31:0]  */ gbe_axi_m0_r_data     ='d0;
assign /*	output [3:0]   */ gbe_axi_m0_r_id       ='d0;
assign /*	output         */ gbe_axi_m0_r_last     ='d0;
assign /*	output [1:0]   */ gbe_axi_m0_r_resp     ='d0;
assign /*	output         */ gbe_axi_m0_r_valid    ='d0;
assign /*	output         */ gbe_axi_m0_w_ready    ='d0;
assign /*	output         */ pufcc_axi_m0_ar_ready ='d0;
assign /*	output         */ pufcc_axi_m0_aw_ready ='d0;
assign /*	output [3:0]   */ pufcc_axi_m0_b_id     ='d0;
assign /*	output [1:0]   */ pufcc_axi_m0_b_resp   ='d0;
assign /*	output         */ pufcc_axi_m0_b_valid  ='d0;
assign /*	output [31:0]  */ pufcc_axi_m0_r_data   ='d0;
assign /*	output [3:0]   */ pufcc_axi_m0_r_id     ='d0;
assign /*	output         */ pufcc_axi_m0_r_last   ='d0;
assign /*	output [1:0]   */ pufcc_axi_m0_r_resp   ='d0;
assign /*	output         */ pufcc_axi_m0_r_valid  ='d0;
assign /*	output         */ pufcc_axi_m0_w_ready  ='d0;
assign /*	output [31:0]  */ sram_axi_s0_ar_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s0_ar_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s0_ar_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s0_ar_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s0_ar_len    ='d0;
assign /*	output         */ sram_axi_s0_ar_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s0_ar_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s0_ar_size   ='d0;
assign /*	output         */ sram_axi_s0_ar_valid  ='d0;
assign /*	output [31:0]  */ sram_axi_s0_aw_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s0_aw_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s0_aw_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s0_aw_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s0_aw_len    ='d0;
assign /*	output         */ sram_axi_s0_aw_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s0_aw_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s0_aw_size   ='d0;
assign /*	output         */ sram_axi_s0_aw_valid  ='d0;
assign /*	output         */ sram_axi_s0_b_ready   ='d0;
assign /*	output         */ sram_axi_s0_r_ready   ='d0;
assign /*	output [31:0]  */ sram_axi_s0_w_data    ='d0;
assign /*	output         */ sram_axi_s0_w_last    ='d0;
assign /*	output [3:0]   */ sram_axi_s0_w_strb    ='d0;
assign /*	output         */ sram_axi_s0_w_valid   ='d0;
assign /*	output [31:0]  */ sram_axi_s1_ar_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s1_ar_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s1_ar_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s1_ar_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s1_ar_len    ='d0;
assign /*	output         */ sram_axi_s1_ar_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s1_ar_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s1_ar_size   ='d0;
assign /*	output         */ sram_axi_s1_ar_valid  ='d0;
assign /*	output [31:0]  */ sram_axi_s1_aw_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s1_aw_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s1_aw_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s1_aw_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s1_aw_len    ='d0;
assign /*	output         */ sram_axi_s1_aw_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s1_aw_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s1_aw_size   ='d0;
assign /*	output         */ sram_axi_s1_aw_valid  ='d0;
assign /*	output         */ sram_axi_s1_b_ready   ='d0;
assign /*	output         */ sram_axi_s1_r_ready   ='d0;
assign /*	output [31:0]  */ sram_axi_s1_w_data    ='d0;
assign /*	output         */ sram_axi_s1_w_last    ='d0;
assign /*	output [3:0]   */ sram_axi_s1_w_strb    ='d0;
assign /*	output         */ sram_axi_s1_w_valid   ='d0;
assign /*	output [31:0]  */ sram_axi_s2_ar_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s2_ar_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s2_ar_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s2_ar_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s2_ar_len    ='d0;
assign /*	output         */ sram_axi_s2_ar_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s2_ar_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s2_ar_size   ='d0;
assign /*	output         */ sram_axi_s2_ar_valid  ='d0;
assign /*	output [31:0]  */ sram_axi_s2_aw_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s2_aw_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s2_aw_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s2_aw_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s2_aw_len    ='d0;
assign /*	output         */ sram_axi_s2_aw_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s2_aw_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s2_aw_size   ='d0;
assign /*	output         */ sram_axi_s2_aw_valid  ='d0;
assign /*	output         */ sram_axi_s2_b_ready   ='d0;
assign /*	output         */ sram_axi_s2_r_ready   ='d0;
assign /*	output [31:0]  */ sram_axi_s2_w_data    ='d0;
assign /*	output         */ sram_axi_s2_w_last    ='d0;
assign /*	output [3:0]   */ sram_axi_s2_w_strb    ='d0;
assign /*	output         */ sram_axi_s2_w_valid   ='d0;
assign /*	output [31:0]  */ sram_axi_s3_ar_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s3_ar_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s3_ar_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s3_ar_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s3_ar_len    ='d0;
assign /*	output         */ sram_axi_s3_ar_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s3_ar_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s3_ar_size   ='d0;
assign /*	output         */ sram_axi_s3_ar_valid  ='d0;
assign /*	output [31:0]  */ sram_axi_s3_aw_addr   ='d0;
assign /*	output [1:0]   */ sram_axi_s3_aw_burst  ='d0;
assign /*	output [3:0]   */ sram_axi_s3_aw_cache  ='d0;
assign /*	output [3:0]   */ sram_axi_s3_aw_id     ='d0;
assign /*	output [3:0]   */ sram_axi_s3_aw_len    ='d0;
assign /*	output         */ sram_axi_s3_aw_lock   ='d0;
assign /*	output [2:0]   */ sram_axi_s3_aw_prot   ='d0;
assign /*	output [2:0]   */ sram_axi_s3_aw_size   ='d0;
assign /*	output         */ sram_axi_s3_aw_valid  ='d0;
assign /*	output         */ sram_axi_s3_b_ready   ='d0;
assign /*	output         */ sram_axi_s3_r_ready   ='d0;
assign /*	output [31:0]  */ sram_axi_s3_w_data    ='d0;
assign /*	output         */ sram_axi_s3_w_last    ='d0;
assign /*	output [3:0]   */ sram_axi_s3_w_strb    ='d0;
assign /*	output         */ sram_axi_s3_w_valid   ='d0;
assign /*	output         */ usb_axi_m0_ar_ready   ='d0;
assign /*	output         */ usb_axi_m0_aw_ready   ='d0;
assign /*	output [3:0]   */ usb_axi_m0_b_id       ='d0;
assign /*	output [1:0]   */ usb_axi_m0_b_resp     ='d0;
assign /*	output         */ usb_axi_m0_b_valid    ='d0;
assign /*	output [31:0]  */ usb_axi_m0_r_data     ='d0;
assign /*	output [3:0]   */ usb_axi_m0_r_id       ='d0;
assign /*	output         */ usb_axi_m0_r_last     ='d0;
assign /*	output [1:0]   */ usb_axi_m0_r_resp     ='d0;
assign /*	output         */ usb_axi_m0_r_valid    ='d0;
assign /*	output         */ usb_axi_m0_w_ready    ='d0;

endmodule

