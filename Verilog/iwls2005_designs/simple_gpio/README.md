# Design Description

Simple General Purpose IO port. It supports up to 8 GPIO pins. Each pin is individually programmable as either input or output. The core features an 8bit wishbone interface. Wider wishbone interfaces are easily supported by using multiple instances (e.g. 4 simple GPIO cores provide a 32bit wishbone interface).

## Features

- Up to 8 GPIO pins per core
- Each GPIO pin individually programmable as either input or output
- Static synchronous design
- Fully synthesisable

# Directory structure

    └── rtl                # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|24|
|FF|42|
|DSP|0|
|BRAM|0|
|IO|31|

# Testbench
Unavailable

# Documentation
Unavailable
