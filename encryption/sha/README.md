# Design Description

This is a collection of SHA(Secure Hash Algorithm) cores. These cores are non-pipelined version of SHA, and have simple interfaces with the host side. 

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|962|
|FF|896|
|DSP|0|
|BRAM|0|
|IO|74|

# License
GNU Lesser General Public License

# Directory structure

    ├── doc           # Documnetation
    ├── rtl           # RTL Sources
    └── testbench     # Testbench