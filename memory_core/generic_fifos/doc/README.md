# Design Description

Generic, multi-purpose FIFOs. Available as single clock and dual clock version, binary, lfsr, and gray encoded (dual clock only). All are parameterizable and use generic_memories for memory. These FIFOs are fully portable from FPGAs to ASICS.

## Features

- Written in Verilog
- Fully Synthesizable (FPGA & ASIC libraries)
- Parameterized
- Single and Dual Clock

# Utilization Report

### generic_fifo_sc_b

|Resource| No.|
|:---:|:---:|
|LUT|50|
|FF|38|
|DSP|0|
|BRAM|0.5|
|IO|31|