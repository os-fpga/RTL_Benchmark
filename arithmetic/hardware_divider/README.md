# Design Description

A divider that calculates the quotient and remainder of a division operation in multiple clock cycles. The dividend, divisor, quotient and remainder are all 32-bit signed integers. By taking the advantage of a shifter that can shift more than one bit (up to 9 bits) during each cycle of computation, it takes less cycles to finish than a radix-2 nonrestoring divider.

# Directory structure

    ├── rtl         # RTL Sources
    └── testbench   # Testbench

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|786|
|FF|351|
|DSP|0|
|BRAM|0|
|IO|132|

# Testbench
Available

# Documentation
Unavailable

# License
GNU Lesser General Public License
