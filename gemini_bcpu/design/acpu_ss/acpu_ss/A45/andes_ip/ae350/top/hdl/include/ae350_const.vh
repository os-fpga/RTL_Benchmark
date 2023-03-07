`ifdef AE350_CONST_VH
`else
`define AE350_CONST_VH

`ifndef AE350_NCORE
	`define AE350_NCORE	1
`endif

`define AE350_PRODUCT_ID	32'h41453500

`define AE350_BOARD_ID		32'h0174b010

`define AE350_HWINT_NUM	32

`ifdef AE350_ADDR_WIDTH_24
	`define AE350_HADDR_MSB			23
	`define AE350_PADDR_MSB			23
	`define ATCEXLMBRG100_ADDR_WIDTH_24
	`define ATCEILMBRG100_ADDR_WIDTH_24
	`define ATCDMAC300_ADDR_WIDTH_24
	`define ATCAHB2SPI200_ADDR_WIDTH_24
	`define ATCAPBBRG100_ADDR_WIDTH_24
	`define ATCAPBDEC100_ADDR_WIDTH_24
`elsif AE350_ADDR_WIDTH_39
	`define AE350_HADDR_MSB			38
	`define AE350_PADDR_MSB			38
`else
	`define AE350_HADDR_MSB			31
	`define AE350_PADDR_MSB			31
`endif

`define AE350_DATA_MSB				63
`define AE350_HDATA_MSB		        31

`ifdef  NDS_BIU_ID_WIDTH
        `define AE350_AXI_ID_WIDTH	`NDS_BIU_ID_WIDTH
`else
        `define AE350_AXI_ID_WIDTH	4
`endif



`ifdef NDS_FPGA
		`ifdef AE350_SRAM_1KB
		`elsif AE350_SRAM_2KB
		`elsif AE350_SRAM_4KB
		`elsif AE350_SRAM_8KB
		`elsif AE350_SRAM_16KB
		`elsif AE350_SRAM_32KB
		`elsif AE350_SRAM_64KB
		`elsif AE350_SRAM_128KB
		`elsif AE350_SRAM_256KB
		`elsif AE350_SRAM_512KB
		`elsif AE350_SRAM_1MB
		`elsif AE350_SRAM_2MB
		`elsif AE350_SRAM_4MB
		`else
			`define AE350_SRAM_64KB
		`endif

`endif
`endif
