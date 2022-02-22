# Design Description

This is a DES core implementation in verilog. It takes a standard 56 bit key and 64 bits of data as input and generates a 64 bit encrypted/decrypted result. Two implementations are provided:

### Area Optimized (CBC Mode)
   This is a sequential implementation and needs 16 cycles to complete a full encryption/decryption cycle.


### Performance Optimized (EBC Mode)
   This is a pipelined implementation that has a 16 cycle pipeline (plus 1 input and 1 output register). It can perform a complete encryption/decryption every cycle.


# Directory structure


    ├── rtl                 # RTL Sources
    │   └── verilog         # Verilog Sources
    │       ├── area_opt    # area optimized
    │       └── perf_opt    # performance optimized
    └── testbench           # Testbench
           └── verilog         # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

### Area Optimized

|Resource| No.|
|:---:|:---:|
|LUT|327|
|FF|64|
|DSP|0|
|BRAM|0|
|IO|190|

### Performance Optimized

|Resource| No.|
|:---:|:---:|
|LUT|5512|
|FF|6008|
|DSP|0|
|BRAM|0|
|IO|298|

# Testbench
Available

# Documentation
Unavailable

# License
GNU General Public License
