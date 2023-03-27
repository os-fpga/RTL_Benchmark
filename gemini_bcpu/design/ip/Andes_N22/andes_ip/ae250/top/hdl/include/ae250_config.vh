//------------------------------------------------------------------------
// Filename     : ae250p_config.inc
// Description  : Add for peripheral IP configurations
//------------------------------------------------------------------------
`ifdef AE250_CONFIG_VH
`else
`define AE250_CONFIG_VH

`define AE250_DMA_SUPPORT
`define AE250_DMA_EXTREQ_SUPPORT
`define AE250_DMA_EXTREQ_NUM		6'd5

`define AE250_RAMBRG200_SUPPORT

`define	AE250_SPI1_SUPPORT
`define	AE250_SPI2_SUPPORT
`define	AE250_I2C_SUPPORT
`define	AE250_UART1_SUPPORT
`define	AE250_UART2_SUPPORT

//`define AE250_SRAM_1KB
//`define AE250_SRAM_2KB
//`define AE250_SRAM_4KB
//`define AE250_SRAM_8KB
//`define AE250_SRAM_16KB
//`define AE250_SRAM_32KB
//`define AE250_SRAM_64KB
//`define AE250_SRAM_128KB
//`define AE250_SRAM_256KB
//`define AE250_SRAM_512KB
//`define AE250_SRAM_1MB
//`define AE250_SRAM_2MB
//`define AE250_SRAM_4MB

//------------------------------------------------------------------------
// Debug configs
//------------------------------------------------------------------------
//`define PLATFORM_NO_DEBUG_SUPPORT
//
//--- minor configurations
//`define AE250_JTAG_TWOWIRE
//`define AE250_PLDM_SYS_BUS_ACCESS
`define AE250_PLDM_PROGBUF_SUPPORT

//------------------------------------------------------------------------
// Unconfigurable
//------------------------------------------------------------------------
`define AE250_AHB_SUPPORT
`define AE250_ADDR_WIDTH_32

`ifndef PLATFORM_NO_DEBUG_SUPPORT
`define PLATFORM_DEBUG_PORT
`define PLATFORM_DEBUG_SUBSYSTEM
`endif // PLATFORM_NO_DEBUG_SUPPORT

`endif //AE250_CONFIG_VH
