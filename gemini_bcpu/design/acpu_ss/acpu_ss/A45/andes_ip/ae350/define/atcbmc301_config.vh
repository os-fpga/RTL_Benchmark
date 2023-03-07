`ifdef ATCBMC301_CONFIG_VH
`else
`define ATCBMC301_CONFIG_VH
`include "config.inc"
`include "ae350_config.vh"
`include "ae350_const.vh"

`ifdef  PLATFORM_FORCE_4GB_SPACE
        `define ATCBMC301_ADDR_WIDTH 32
`else  //~PLATFORM_FORCE_4GB_SPACE
        `define ATCBMC301_ADDR_WIDTH `NDS_BIU_ADDR_WIDTH
`endif  //PLATFORM_FORCE_4GB_SPACE
`define ATCBMC301_ID_WIDTH   `AE350_AXI_ID_WIDTH
`ifdef NDS_L2C_BIU_DATA_WIDTH
	`define ATCBMC301_DATA_WIDTH `NDS_L2C_BIU_DATA_WIDTH
`else
	`define ATCBMC301_DATA_WIDTH `NDS_BIU_DATA_WIDTH
`endif

`ifdef NDS_IO_CLUSTER
	`define ATCBMC301_MST0_SUPPORT	// AXI_MMIO
`else
	`ifdef NDS_IO_BIU_X2
		`define ATCBMC301_MST0_SUPPORT	// Dual BIU IF for i
		`define ATCBMC301_MST1_SUPPORT	// Dual BIU IF for d
	`else
		`define ATCBMC301_MST0_SUPPORT	// Single BIU IF
	`endif
`endif

`define ATCBMC301_SLV1_SUPPORT	// PLIC, PLMT, PLIC_SW, DEBUG

`ifdef NDS_IO_CLUSTER
	`define ATCBMC301_SLV2_SUPPORT	// AXI_MMIO
`else
	`ifdef NDS_IO_BIU_X2
		`define ATCBMC301_SLV2_SUPPORT	// Dual BIU IF for i
		`define ATCBMC301_SLV3_SUPPORT	// Dual BIU IF for d
	`else
		`define ATCBMC301_SLV2_SUPPORT	// Single BIU IF
	`endif
`endif

`define ATCBMC301_PRIORITY_DECODE

`ifdef NDS_IO_CLUSTER
	`define _ATCBMC301_OUTSTANDING_DEPTH 16
`else
	`define _ATCBMC301_OUTSTANDING_DEPTH 8
`endif // NDS_IO_CLUSTER

//-------------------------------------------------
// AXI Master Ports
//-------------------------------------------------
`define ATCBMC301_MST0_DEFAULT_HIGH_PRIORITY   0

`define ATCBMC301_MST0_DEFAULT_PRIORITY_RELOAD 1
`define ATCBMC301_MST0_OUTSTANDING_DEPTH `_ATCBMC301_OUTSTANDING_DEPTH
`define ATCBMC301_MST1_DEFAULT_PRIORITY_RELOAD 1
`define ATCBMC301_MST1_OUTSTANDING_DEPTH `_ATCBMC301_OUTSTANDING_DEPTH

//-------------------------------------------------
// AXI Slave Base Address
//-------------------------------------------------
// PLIC, PLMT, PLIC_SW, DEBUG 64 MiB
`define ATCBMC301_SLV1_BASE_ADDR	`ATCBMC301_ADDR_WIDTH'hE4000000
`define ATCBMC301_SLV1_SIZE		7
`define ATCBMC301_SLV1_FIFO_DEPTH	4

// 4GiB (SIZE=13) or more
`define ATCBMC301_SLV2_BASE_ADDR	`ATCBMC301_ADDR_WIDTH'h0000_0000
`define ATCBMC301_SLV2_SIZE		13
`define ATCBMC301_SLV2_FIFO_DEPTH	`_ATCBMC301_OUTSTANDING_DEPTH
// 4GiB (SIZE=13) or more
`define ATCBMC301_SLV3_BASE_ADDR	`ATCBMC301_ADDR_WIDTH'h0000_0000
`define ATCBMC301_SLV3_SIZE		13
`define ATCBMC301_SLV3_FIFO_DEPTH	`_ATCBMC301_OUTSTANDING_DEPTH


//-------------------------------------------------
// AXI Master & Slave Ports Connectivity
//-------------------------------------------------
// VPERL_BEGIN
// for ($i = 0; $i < 2; $i++) {
//: `ifdef ATCBMC301_MST${i}_SUPPORT
//	foreach $j (1, $i + 2) {
//:	`define ATCBMC301_MST${i}_SLV${j}
//	}
//: `endif // ATCBMC301_MST${i}
// }
// VPERL_END

// VPERL_GENERATED_BEGIN
`ifdef ATCBMC301_MST0_SUPPORT
	`define ATCBMC301_MST0_SLV1
	`define ATCBMC301_MST0_SLV2
`endif // ATCBMC301_MST0
`ifdef ATCBMC301_MST1_SUPPORT
	`define ATCBMC301_MST1_SLV1
	`define ATCBMC301_MST1_SLV3
`endif // ATCBMC301_MST1
// VPERL_GENERATED_END

`endif // ATCBMC301_CONFIG_VH


