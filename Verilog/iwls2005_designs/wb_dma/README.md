# Design Description

This is a simple DMA/Bridge IP core. It has two WISHBONE interface. It can perform DMA transfers between the two interfaces or on the same interfaces. 

## Features

- Up to 31 DMA Channels
- 2, 4 or 8 priority levels
- Linked List Descriptors support
- Circular Buffer support
- FIFO buffer support
- Software & Hardware handshake support
- Automatic Channel Registers Reload support
- Fully configurable


# Directory structure

    ├── doc               # Documentation
    ├── rtl               # RTL Resources
    │   ├── raw_rtl       # Raw RTL
    │   └── wrapper_rtl   # RTL with Wrapper
    └── testbench         # Testbench
        └── verilog       # Verilog Resources

# Utilization Report
Synthesized on Artix-7 device using vivado.

### Raw RTL
|Resource| No.|
|:---:|:---:|
|LUT|584|
|FF|541|
|DSP|0|
|BRAM|0|
|IO|431|

### Wrapper RTL
|Resource| No.|
|:---:|:---:|
|LUT|528|
|FF|541|
|DSP|0|
|BRAM|0|
|IO|221|

# Testbench
Available

# Documentation
Available
