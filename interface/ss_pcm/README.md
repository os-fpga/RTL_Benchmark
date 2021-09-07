# Design Description

Simple PCM Interface. Allows to interface to such popular devices like TI DSPs (via McBSP bus) in PCM mode. Of course many more applications. This is a Salve PCM interface, meaning Clock and Sync are input to the core. To make it a Master interface add a clock and Sync signal generator (for example a 128KHz clock and 8KHz Sync).

## Features

- Implemented in Verilog
- Frame Start position adjustable
- full 16 bit frames
- 1 Receive holding register
- 1 Transmit holding Register
- Fully Synthesisable
- Can handle PCM streams at any rate, 128KHz to 100MHz.

# Directory structure

    └── rtl            # RTL Sources 
        └── verilog    # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|31|
|FF|79|
|DSP|0|
|BRAM|0|
|IO|28|

# Testbench
Unavailable

# Documentation
Unavailable
