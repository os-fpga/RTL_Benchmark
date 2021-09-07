# Design Description

Simple asynchronous serial controller (aka UART). Includes 4 byte receive and a 4 byte transmit FIFO (FIFO size can be easily adjusted). External baud rate generator (included).

# Features

- Implemented in Verilog
- Flow Control (CTS/RTS)
- 1 start bit, 1 stop bit, NO parity
- 4 byte receive FIFO
- 4 byte transmit FIFO
- Fully Synthesisable

# Directory structure

    └── rtl                # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|56|
|FF|52|
|DSP|0|
|BRAM|0|
|IO|28|

# Testbench
Unavailable

# Documentation
Unavailable
