`ifdef AE250_CONST_VH
`else
`define AE250_CONST_VH

`ifndef AE250_NCORE
	`define AE250_NCORE		1
`endif

`define AE250_PRODUCT_ID	32'h41452500

`ifdef NDS_BOARD_CF1
	`define AE250_BOARD_ID		32'h01741110
`else
	`define AE250_BOARD_ID		32'h0174b010
`endif

`define AE250_HWINT_NUM		32

`ifdef AE250_ADDR_WIDTH_24
	`define AE250_HADDR_MSB			31
	`define AE250_PADDR_MSB			31
`elsif AE250_ADDR_WIDTH_39
	`define AE250_HADDR_MSB			38
	`define AE250_PADDR_MSB			38
`else
	`define AE250_HADDR_MSB			31
	`define AE250_PADDR_MSB			31
`endif

`define AE250_DATA_MSB		31

`ifdef NDS_FPGA
		`ifdef AE250_SRAM_1KB
		`elsif AE250_SRAM_2KB
		`elsif AE250_SRAM_4KB
		`elsif AE250_SRAM_8KB
		`elsif AE250_SRAM_16KB
		`elsif AE250_SRAM_32KB
		`elsif AE250_SRAM_64KB
		`elsif AE250_SRAM_128KB
		`elsif AE250_SRAM_256KB
		`elsif AE250_SRAM_512KB
		`elsif AE250_SRAM_1MB
		`elsif AE250_SRAM_2MB
		`elsif AE250_SRAM_4MB
		`else
			`define AE250_SRAM_32KB
		`endif

`endif

`endif
