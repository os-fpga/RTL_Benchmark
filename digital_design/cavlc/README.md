# Design Description

This IP implements the CAVLC parsing process in ITU-T H.264.

## Features

- Compatible with ITU-T H.264 (05/2003), but it do not calculate nC and store TotalCoeff, you need to add a nC_decoder outside this core.
- New structure for run_before decoder, the core doesn't save Runs in flip-flops and doesn't need the run_combine process, this feature reduces both cycle and resource.
- This core has a simple interface
- 9 cycles per cavlc block on average(including P frames)
- Fully synchronous design, Fully synthesisable

# Directory structure

    ├── rtl             # RTL Sources
    └── testbench       # Testbench
        ├── input_gen
        └── tests

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|702|
|FF|396|
|DSP|0|
|BRAM|0|
|IO|187|

# Testbench
Available

# Documentation
Unavailable

# License
GNU Lesser General Public License
