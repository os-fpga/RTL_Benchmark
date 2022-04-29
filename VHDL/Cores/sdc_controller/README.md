# Design Description
The Wishbone SD Card Controller IP Core is MMC/SD communication controller designed to be used in a System-on-Chip. The IP core provides a simple interface for any CPU with Wishbone bus. The communication between the MMC/SD card controller and MMC/SD card is performed according to the MMC/SD protocol.

## Features
- 1- or 4-bit MMC/SD mode (does not support SPI mode),
- 32-bit Wishbone interface,
- DMA engine for data transfers,
- Interrupt generation on completion of data and command transactions,
- Configurable data transfer block size,
- Support for any command code (including multiple data block tranfser),
- Support for R1, R1b, R2(136-bit), R3, R6 and R7 responses.

# Directory structure

    ├── doc           # Documentation
    ├── rtl           # RTL Sources
    │   ├── verilog   # Verilog Sources
    │   └── VHDL      # Vhdl Sources
    └── testbench     # Testbench
        └── verilog   # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|1458|
|FF|1604|
|DSP|0|
|BRAM|0|
|IO|203|

# Testbench
Available

# Documentation
Available

# License
GNU Lesser General Public License
