# Design Description

This is a AC 97 Controller Core. It provides a an interface to an external AC 97 Audio Codec. This allows the implementation of CD quality Audio Input/Output.

## Features

- Variable and Fixed Sample Rate Support, up 48 kHz
- 16, 18 and 20 bit Sample Size Support
- 6 Channel Surround Sound Support
- Stereo Input channel Support
- Mono Microphone Channel Support
- External DMA Engine Support
- WISHBONE SoC host Interface 


# Directory structure

    ├── doc                # Documentation
    ├── rtl                # RTL Sources
    │   └── verilog        # Verilog Sources
    └── testbench          # Testbench
        └── verilog        # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|942|
|FF|1032|
|DSP|0|
|BRAM|0|
|IO|104|

# Testbench
Unavailable

# Documentation
Available
