
`timescale 1ns/100ps

//set RTL for simulation, override FPGA specific definitions (JTAG TAP, MEMORY and CLOCK DIVIDER)
`define GENERIC_FPGA
`define NO_CLOCK_DIVISION   //if commented out, generic clock division is implemented (odd divisors are rounded down)
`define POSITIVE_RESET
//~set RTL for simulation, override FPGA specific definitions (JTAG TAP, MEMORY and CLOCK DIVIDER)

`define FREQ_NUM_FOR_NS 1000000000

`define FREQ 25000000
`define CLK_PERIOD (`FREQ_NUM_FOR_NS/`FREQ)

`define ETH_PHY_FREQ  25000000
`define ETH_PHY_PERIOD  (`FREQ_NUM_FOR_NS/`ETH_PHY_FREQ)    //40ns

`define UART_BAUDRATE 115200

`define VPI_DEBUG

//`define VCD_OUTPUT

//`define START_UP						//pass firmware over spi to or1k_startup

`define INITIALIZE_MEMORY_MODEL			//instantaneously initialize memory model with firmware
										//only use with the memory model (it is safe to 
										//comment this and include the original memory instead)
