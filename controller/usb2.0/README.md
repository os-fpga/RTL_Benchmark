# Design Description

This is a USB 2.0 compliant core. USB 2.0 allows data transfers of 480 Mb/s. Because of the high interface speed, an external PHY will be required with this core. A industry standard PHY interface for USB has been developed. This interface is called USB Transceiver Macrocell Interface or UTMI for short. The host interface of the USB core will be WISHBONE SoC compliant. 

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|1852|
|FF|1713|
|DSP|0|
|BRAM|0|
|IO|235|

# Directory structure

    ├── doc           # Documentation
    └── rtl           # RTL Sources
        └── verilog   # Verilog Sources
