# Design Description

 BCD or Binary-coded decimal is a class of binary encodings of decimal numbers where each decimal digit is represented by four bits. This format is useful for displaying a value in a seven segment display or LCD panel. 

To convert a binary number to BCD format, an algorithm called Double Dabble, can be use. Written a Verilog code is for converting a 8 bit binary number into BCD format. The maximum value of a 8 bit binary number is 255 in decimal. This means output need 3 BCD digits. So, the size of the output is as 3 digits*4 bits = 12 bits.

# Directory structure

    ├── rtl                # RTL Sources
    └── testbench          # Testbench

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|10|
|FF|0|
|DSP|0|
|BRAM|0|
|IO|20|

# Testbench
Available

# Documentation
Unavailable
