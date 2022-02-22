# Design Description

Simple programmable interrupt controller. It supports up to 8 interrupt sources. Polarity and sensitivity (either edge or level) is programmable per interrupt source. The core features an 8bit wishbone interface. Wider wishbone interfaces are easily supported by using multiple instances.

## Features

- Up to 8 interrupt sources
- Sensitivity (edge/level) programmable per interrupt source
- Polarity programmable per source
- Static synchronous design
- Fully synthesisable


# Directory structure

    └── rtl                # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|33|
|FF|66|
|DSP|0|
|BRAM|0|
|IO|31|

# Testbench
Unavailable

# Documentation
Unavailable
