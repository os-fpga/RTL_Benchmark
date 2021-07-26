# Design Description

Generic, multi-purpose FIFOs. Available as single clock and dual clock version, binary, lfsr, and gray encoded (dual clock only). All are parameterizable and use generic_memories for memory. These FIFOs are fully portable from FPGAs to ASICS.

## Features

- Written in Verilog
- Fully Synthesizable (FPGA & ASIC libraries)
- Parameterized
- Single and Dual Clock

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

### generic_fifo_sc_b

|Resource| No.|
|:---:|:---:|
|LUT|50|
|FF|38|
|DSP|0|
|BRAM|0.5|
|IO|31|

### generic_fifo_dc

|Resource| No.|
|:---:|:---:|
|LUT|46|
|FF|62|
|DSP|0|
|BRAM|0.5|
|IO|28|

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
