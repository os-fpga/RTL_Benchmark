# Design Description

The TV80 is an 8-bit Z80-compatible microprocessor core, written in Verilog. It is based on Daniel Wallner's VHDL T80 core.

## Features

- executes 8080/Z80 instruction set
- cycle timing is similar to original Z80
- small die area
- sample peripheral with GMII interface

# Directory structure

    ├── doc                # Documentation
    └── rtl                # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|1147|
|FF|230|
|DSP|0|
|BRAM|0|
|IO|46|

# Testbench
Unavailable

# Documentation
Available

# License
Berkeley Software Distribution
