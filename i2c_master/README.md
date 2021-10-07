# Design Description

I2C is a two-wire, bi-directional serial bus that provides a simple and efficient method of data exchange between devices. It is most suitable for applications requiring occasional communication over a short distance between many devices. The I2C standard is a true multi-master bus including collision detection and arbitration that prevents data corruption if two or more masters attempt to control the bus simultaneously.

# Directory structure 

    ├── doc            # Documentation
    ├── rtl            # RTL Sources
    └── testbench      # Testbench
        └── verilog    # Verilog Sources
        
# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|139|
|FF|114|
|DSP|0|
|BRAM|0|
|IO|33|

# Testbench
Available

# Documentation
Available

# License
Berkeley Software Distribution
