# Design Description

This is a single precision floating point unit. It is fully IEEE 754 compliant. It can currently perform Add/Sub, Mul and Divide operations, as well as integer to floating point and floating point to integer conversions. It supports four rounding modes: Round to Nearest Even, Round to Zero, Round to +INF and Round to -INF. 
 There is now also a separate FP compare unit. It is located in the rtl/fcmp directory. 

# Directory structure

    ├── doc                    # Documentation
    ├── rtl                    # RTL Sources
    │   ├── fcmp                 # FPU Compare unit
    │   │   ├── testbench        # FPU Compare Testbench
    │   │   └── verilog          # FPU Compare Verilog Sources
    │   └── verilog            # Verilog Sources
    └── testbench              # Testbench
        └── test vectors       # Test vectors

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|4255|
|FF|580|
|DSP|2|
|BRAM|0|
|IO|110|

# Testbench
Available

# Documentation
Available
