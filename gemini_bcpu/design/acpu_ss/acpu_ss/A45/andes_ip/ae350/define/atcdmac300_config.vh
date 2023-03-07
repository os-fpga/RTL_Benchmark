`ifdef ATCDMAC300_CONFIG_VH
`else
`define ATCDMAC300_CONFIG_VH
`include "config.inc"

//-------------------------------------------------
// DMAC Channel Number
//-------------------------------------------------
// Available value: 1~8
`define ATCDMAC300_CH_NUM_8

//-------------------------------------------------
// DMAC FIFO DEPTH
//-------------------------------------------------
//`define ATCDMAC300_FIFO_DEPTH_4
//`define ATCDMAC300_FIFO_DEPTH_8
`define ATCDMAC300_FIFO_DEPTH_16
//`define ATCDMAC300_FIFO_DEPTH_32

//-------------------------------------------------
// DMAC Request/Acknowledge Handshake
//-------------------------------------------------
`define ATCDMAC300_REQ_ACK_NUM	16
`define ATCDMAC300_REQ_SYNC_SUPPORT

//-------------------------------------------------
// DMAC Chain Transfer Support
//-------------------------------------------------
`define ATCDMAC300_CHAIN_TRANSFER_SUPPORT

//-------------------------------------------------
// DMAC Dual DMA Cores Support
//-------------------------------------------------
//`define ATCDMAC300_DUAL_DMA_CORE_SUPPORT

//-------------------------------------------------
// DMAC Dual Master Interfaces Support
//-------------------------------------------------
//`define ATCDMAC300_DUAL_MASTER_IF_SUPPORT

//-------------------------------------------------
// DMAC Address Width
//-------------------------------------------------
`ifdef PLATFORM_FORCE_4GB_SPACE
        `define ATCDMAC300_ADDR_WIDTH 32
`else  //~PLATFORM_FORCE_4GB_SPACE
        `define ATCDMAC300_ADDR_WIDTH `NDS_BIU_ADDR_WIDTH
`endif //PLATFORM_FORCE_4GB_SPACE

//-------------------------------------------------
// DMAC Data Width
//-------------------------------------------------
`ifdef NDS_BIU_DATA_WIDTH_256
	`define ATCDMAC300_DATA_WIDTH_256
`else
	`ifdef NDS_BIU_DATA_WIDTH_128
		`define ATCDMAC300_DATA_WIDTH_128
	`else
		`ifdef NDS_BIU_DATA_WIDTH_64
			`define ATCDMAC300_DATA_WIDTH_64
		`else
			`define ATCDMAC300_DATA_WIDTH_32
		`endif // NDS_BIU_DATA_WIDTH_64
	`endif // NDS_BIU_DATA_WIDTH_128
`endif // NDS_BIU_DATA_WIDTH_256

`endif // ATCDMAC300_CONFIG_VH

