# Design Description

The OpenCores VGA/LCD Controller core is a WISHBONE revB.3 compliant embedded VGA core capable of driving CRT and LCD displays. It supports user programmable resolutions and video timings, which are limited only by the available WISHBONE bandwidth. Making it compatible with almost all available LCD and CRT displays.

The core supports a number of color modes, including 32bpp, 24bpp, 16bpp, 8bpp gray-scale, and 8bpp-pseudo color. The video memory is located outside the primary core, thus providing the most flexible memory solution. It can be located on-chip or off-chip, shared with the system’s main memory (VGA on demand) or be dedicated to the VGA system. The color lookup table is, as of core version 2.0, incorporated into the color-processor block.

# Directory structure

    ├── doc            # Documentation 
    ├── rtl            # RTL Sources
    │   ├── verilog    # Verilog Sources    
    │   └── vhdl       # Vhdl Sources
    └── testbench      # Testbench
        └── verilog    # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|930|
|FF|748|
|DSP|0|
|BRAM|1|
|IO|196|

# Testbench
Available

# Documentation
Available

# License
GNU General Public License
