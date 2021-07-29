# Design Description

Generic, multi-purpose dual clock gray encoded FIFO. It is parameterizable and uses generic_memories for memory. This FIFO is fully portable from FPGAs to ASICS.

## Features

- Written in Verilog
- Fully Synthesizable (FPGA & ASIC libraries)
- Parameterized
- Single and Dual Clock

# Utilization Report
Synthesized on Artix-7 device using vivado.

### generic_fifo_dc_gray

|Resource| No.|
|:---:|:---:|
|LUT|87|
|FF|90|
|DSP|0|
|BRAM|0.5|
|IO|44|

# Directory structure 

    ├── rtl            # RTL Sources
    │   └── verilog    # Verilog Sources
    └── testbench      # Testbench
        └── verilog    # Verilog Sources
