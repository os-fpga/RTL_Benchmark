# Design Description

SPI (Serial Peripheral Interface) is serial, synchronous, full duplex communication protocol. It is widely used as a board-level interface between different devices such as microcontrollers, DACs, ADCs and others. This core is SPI/Microwire compliant master serial communication controller with additional functionality.

## Features

- Full duplex synchronous serial data transfer
- Variable length of transfer word up to 32 bits
- MSB or LSB first data transfer
- Rx and Tx on both rising or falling edge of serial clock independently
- 8 slave select lines
- Fully static synchronous design with one clock domain
- Technology independent Verilog
- Fully synthesizable 

# Directory structure

    ├── doc             # Documentation
    ├── rtl             # RTL Sources
    └── testbench       # Testbench
        └── verilog     # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|555|
|FF|229|
|DSP|0|
|BRAM|0|
|IO|90|

# Testbench
Available

# Documentation
Available
