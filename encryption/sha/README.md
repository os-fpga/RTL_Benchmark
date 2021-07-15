# Design Description

This is a collection of SHA(Secure Hash Algorithm) cores. These cores are non-pipelined version of SHA, and have simple interfaces with the host side. 

# Utilization Report
Synthesized on Artix-7 device using vivado.

### SHA
|Resource| No.|
|:---:|:---:|
|LUT|962|
|FF|896|
|DSP|0|
|BRAM|0|
|IO|74|

### SHA1
|Resource| No.|
|:---:|:---:|
|LUT|942|
|FF|895|
|DSP|0|
|BRAM|0|
|IO|74|

### SHA256
|Resource| No.|
|:---:|:---:|
|LUT|952|
|FF|462|
|DSP|0|
|BRAM|0.5|
|IO|30|

# License
GNU Lesser General Public License

# Directory structure

    ├── doc           # Documnetation
    ├── rtl           # RTL Sources
    └── testbench     # Testbench