# Design Description

The simple Serial Peripheral Interface core is an enhanced version of the Serial Peripheral Interface found on Motorola's M68HC11 family of CPUs. The Serial Peripheral Interface is a serial, synchronous communication protocol that requires a minimum of 3 wires. Enhancements to the original interface include a wider supported operating frequency range, 4 entries deep read and write FIFOs, and programmable transfer count dependent interrupt generation. The high compatibility with the M68HC11 SPI port ensures that existing software can use this core without major modifications. New software can use existing examples as a starting point.

## Features

- Compatible with Motorola’s SPI specifications
- Enhanced M68HC11 Serial Peripheral Interface
- 4 entries deep read FIFO
- 4 entries deep write FIFO
- Interrupt generation after 1, 2, 3, or 4 transferred bytes
- 8 bit WISHBONE RevB.3 Classic interface
- Operates from a wide range of input clock frequencies
- Static synchronous design


# Directory structure

    ├── doc             # Documentation
    ├── rtl             # RTL Sources
    │   └── verilog     # Verilog Sources
    └── testbench       # Testbench
        └── verilog     # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|92|
|FF|68|
|DSP|0|
|BRAM|0|
|IO|28|

# Testbench
Available

# Documentation
Available
