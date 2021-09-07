# Design Description

- Reed Solomon Decoder (204,188), with T=8.
- Input codeword length is 204 bytes and output length is 188 bytes.
- Corrects up to 8 byte errors per input codeword.
- Code generator polynomial: (x + λ) (x + λ^2) (x + λ^3) ... (x + λ^16).
- Field generator polynomial: x^8+ x^4+ x^3+ x^2+1.

# Directory structure

    ├── doc           # Documnetation
    ├── rtl           # RTL Sources
    └── testbench     # Testbench

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|570|
|FF|395|
|DSP|0|
|BRAM|0|
|IO|20|

# Testbench
Available

# Documentation
Available

# License
GNU General Public License
