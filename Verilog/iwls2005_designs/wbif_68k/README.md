# Design Description

This is a Motorola DragonBall/68K to Wishbone bridge. The core translates the 16bit DragonBall/68K bus into a full featured 16bit Wishbone master bus.

# Features

- 16bit Motorola DragonBall/68K Interface
- 16bit full featured RevB.3 Wishbone Classic Master interface
- programmable address-bus size
- static synchronous design
- fully synthesisable


# Directory structure 

    └── rtl            # RTL Sources
        └── verilog    # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|5|
|FF|31|
|DSP|0|
|BRAM|0|
|IO|83|

# Testbench
Unavailable

# Documentation
Unavailable
