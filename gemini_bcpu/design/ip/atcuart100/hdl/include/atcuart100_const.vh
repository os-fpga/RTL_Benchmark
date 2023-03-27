`ifdef ATCUART100_CONST_VH
`else
`define ATCUART100_CONST_VH

`define ATCUART100_PRODUCT_ID		32'h02011009

`ifdef ATCUART100_FIFO_DEPTH_128
	`define ATCUART100_FIFO_DEPTH_BIT	7
	`define ATCUART100_HWCFG		4'h3
`else
	`ifdef ATCUART100_FIFO_DEPTH_64
		`define ATCUART100_FIFO_DEPTH_BIT	6
		`define ATCUART100_HWCFG		4'h2
	`else
		`ifdef ATCUART100_FIFO_DEPTH_32
			`define ATCUART100_FIFO_DEPTH_BIT	5
			`define ATCUART100_HWCFG		4'h1
		`else
			`define ATCUART100_FIFO_DEPTH_BIT	4
			`define ATCUART100_HWCFG		4'h0
		`endif
	`endif
`endif

`endif
