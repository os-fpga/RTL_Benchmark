# Design Description

This is a WISHBONE Interconnect Matrix IP core.It can interconnect up to 8 Masters and 16 Slaves.

## Features

- Up to 8 Masters
- Up to 16 Slaves
- 1, 2 or 4 priority levels
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
|LUT|7075|
|FF|770|
|DSP|0|
|BRAM|0|
|IO|2546|

### Wrapper RTL
|Resource| No.|
|:---:|:---:|
|LUT|7643|
|FF|770|
|DSP|0|
|BRAM|0|
|IO|221|

# Testbench
Available

# Documentation
Available
