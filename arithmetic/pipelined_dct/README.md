# Design Description

DCT soft core is the unit to perform the Discrete Cosine Transform (DCT). It performs twodimensional 8 by 8 point DCT for the period of 64 clock cycles in pipelined mode.

## Features

- more than 300 MHz sampling frequency, 64-cycle calculation period
- approximately 330 CLBs and 4 DSP48E in Virtex-5 device
- 2 DSP48E when the scaled output data mode is used
- 8-bit input data
- 11-bit coefficients
- 12-bit results
- pipelined mode
- latent delay from input to output is 132 clock cycles
- structure optimized for Xilinx Virtex, Spartan FPGA devices


# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|659|
|FF|550|
|DSP|4|
|BRAM|0|
|IO|25|

# License
GNU Lesser General Public License

# Directory structure

    ├── doc                # Documentation
    ├── rtl                # RTL Sources
    └── testbench          # Testbench
