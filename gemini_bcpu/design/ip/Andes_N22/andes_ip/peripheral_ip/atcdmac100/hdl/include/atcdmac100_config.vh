`ifdef ATCDMAC100_CONFIG_VH
`else
`define ATCDMAC100_CONFIG_VH

//-------------------------------------------------
// DMAC Address Width
//-------------------------------------------------
`define ATCDMAC100_ADDR_WIDTH_24

//-------------------------------------------------
// DMAC Channel Number
//-------------------------------------------------
// Available value: 1~8
`define ATCDMAC100_CH_NUM_8

//-------------------------------------------------
// DMAC FIFO DEPTH
//-------------------------------------------------
//`define ATCDMAC100_FIFO_DEPTH_4
`define ATCDMAC100_FIFO_DEPTH_8
//`define ATCDMAC100_FIFO_DEPTH_16
//`define ATCDMAC100_FIFO_DEPTH_32

//-------------------------------------------------
// DMAC Request/Acknowledge Handshake
//-------------------------------------------------
`define ATCDMAC100_REQ_ACK_NUM	6'd32
//`define ATCDMAC100_REQ_SYNC_SUPPORT

//-------------------------------------------------
// DMAC Chain Transfer Support
//-------------------------------------------------
`define ATCDMAC100_CHAIN_TRANSFER_SUPPORT

`endif // ATCDMAC100_CONFIG_VH

