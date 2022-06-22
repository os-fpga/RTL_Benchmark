# Design Description

Generic, multi-purpose single clock FIFO. It is parameterizable and uses generic_memories for memory. This FIFO is fully portable from FPGAs to ASICS.

## Features

- Written in Verilog
- Fully Synthesizable (FPGA & ASIC libraries)
- Parameterized
- Single and Dual Clock

# Directory structure 

    ├── rtl            # RTL Sources
    │   └── verilog    # Verilog Sources
    └── testbench      # Testbench
        └── verilog    # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

### generic_fifo_sc_a

|Resource| No.|
|:---:|:---:|
|LUT|63|
|FF|34|
|DSP|0|
|BRAM|0.5|
|IO|31|

# Testbench
Available

# Documentation
Unavailable