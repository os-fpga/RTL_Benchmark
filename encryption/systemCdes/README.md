# Design Description
SystemC DES is a implementation of the DES algorithm in SystemC focusing on low area applications. Implements the encoder and decoder in the same block. It was fully verified using TLM (Transaction Level Modelling Style) defined in the SystemC Verification Library. Verilog translation for synthesis is also provided. Encoder and decoder are in the same block.

# Directory structure

    ├── rtl           # RTL Sources
    │   ├── systemc   # SystemC Sources
    │   └── verilog   # Verilog Sources
    └── testbench     # Testbench Sources
        ├── systemc   # SystemC Sources
        └── verilog   # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|309|
|FF|411|
|DSP|0|
|BRAM|0|
|IO|78|

# Testbench
Available

# Documentation
Unavailable
