# Design Description

USB 1.1 PHY. includes all the goodies: serial/parallel conversion, bit stuffing/unstuffing, NRZI encoding decoding. Uses a simplified UTMI interface. 

'phy_mode' selects between single ended and differential tx_phy output. See Philips ISP 1105 transceiver data sheet for an explanation of it's MODE
select pin (see Note below). Currently this PHY only operates in Full-Speed mode. Required clock frequency is 48MHz, from which the 12MHz USB transmit and receive clocks are derived.

## Features 
- FPGA or ASIC implementation possible
- 8 bit wide unidirectional UTMI interface
- serial parallel conversion
- bit stuffing/unstuffing
- NRZI encoding/Decoding
- DPLL
- Implemented in Verilog
- Fully synthesizable 

# Directory structure

    └── rtl           # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|64|
|FF|110|
|DSP|0|
|BRAM|0|
|IO|33|

# Testbench
Unavailable

# Documentation
Unavailable
